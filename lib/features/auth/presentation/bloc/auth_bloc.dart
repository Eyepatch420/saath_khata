import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/services/ledger_socket_service.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../notifications/presentation/bloc/notification_bloc.dart';
import '../../../notifications/presentation/bloc/notification_event.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storage;

  static const _m = 'Auth';

  AuthBloc({
    required AuthRepository authRepository,
    required StorageService storage,
  })  : _authRepository = authRepository,
        _storage = storage,
        super(const AuthInitial()) {
    on<AuthCheckStatusRequested>(_onCheckStatus);
    on<AuthOtpSendRequested>(_onOtpSend);
    on<AuthOtpVerifyRequested>(_onOtpVerify);
    on<AuthSignupRequested>(_onSignup);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthProfileUpdateRequested>(_onUpdateProfile);
    on<AuthUserUpdated>(_onUserUpdated);
    on<AuthDeleteAccountRequested>(_onDeleteAccount);
  }

  Future<void> _onCheckStatus(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Checking stored session...');
    emit(const AuthLoading());
    try {
      final user = await _storage.getStoredUser();
      if (user != null) {
        AppLogger.i(_m, 'Session restored — ${user.mobile} (${user.role})');
        final accessToken = await _storage.getAccessToken();
        if (accessToken != null) {
          if (kDebugMode) {
            AppLogger.i(_m, '🔑 [DEBUG] Bearer token: $accessToken');
          }
          getIt<LedgerSocketService>().connect(accessToken);
          await getIt<PushNotificationService>().initialize();
          getIt<NotificationBloc>().add(LoadUnreadCount());
        }
        emit(AuthAuthenticated(user));
      } else {
        AppLogger.i(_m, 'No stored session — unauthenticated');
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      AppLogger.e(_m, 'Session check failed', e);
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onOtpSend(
    AuthOtpSendRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'OTP send: ${event.phone}');
    emit(const AuthLoading());
    try {
      await _authRepository.sendOtp(phone: event.phone);
      emit(AuthOtpSent(phone: event.phone));
    } catch (e) {
      AppLogger.e(_m, 'OTP send failed', e);
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onOtpVerify(
    AuthOtpVerifyRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'OTP verify: ${event.phone}');
    emit(const AuthLoading());
    try {
      final result = await _authRepository.verifyOtp(
        phone: event.phone,
        otp: event.otp,
      );

      if (result.existingUser) {
        await _storage.saveTokens(
          accessToken: result.tokens!.accessToken,
          refreshToken: result.tokens!.refreshToken,
          expiresIn: result.tokens!.expiresIn,
        );
        await _storage.saveFullUser(result.user!);
        AppLogger.i(_m, 'OTP login — ${result.user!.mobile} (${result.user!.role})');
        if (kDebugMode) {
          AppLogger.i(_m, '🔑 [DEBUG] Bearer token: ${result.tokens!.accessToken}');
        }
        getIt<LedgerSocketService>().connect(result.tokens!.accessToken);
        await getIt<PushNotificationService>().initialize();
        getIt<NotificationBloc>().add(LoadUnreadCount());
        emit(AuthAuthenticated(result.user!));
      } else {
        AppLogger.i(_m, 'OTP verified — new user, go to signup');
        emit(AuthOtpVerifiedNewUser(
          phone: event.phone,
          signupToken: result.signupToken!,
        ));
      }
    } catch (e) {
      AppLogger.e(_m, 'OTP verify failed', e);
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onSignup(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Signup attempt as ${event.role}');
    emit(const AuthLoading());
    try {
      final result = await _authRepository.signup(
        signupToken: event.signupToken,
        name: event.name,
        role: event.role,
        email: event.email,
        upiId: event.upiId,
        businessName: event.businessName,
        businessCategory: event.businessCategory,
        businessAddress: event.businessAddress,
      );

      await _storage.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
        expiresIn: result.tokens.expiresIn,
      );
      await _storage.saveFullUser(result.user);
      AppLogger.i(_m, 'Signup success — ${result.user.mobile} id:${result.user.id}');
      getIt<LedgerSocketService>().connect(result.tokens.accessToken);
      await getIt<PushNotificationService>().initialize();
      getIt<NotificationBloc>().add(LoadUnreadCount());
      emit(AuthAuthenticated(result.user));
    } catch (e) {
      AppLogger.e(_m, 'Signup failed', e);
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Logout requested');
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken != null) {
        await _authRepository.logout(refreshToken: refreshToken);
        AppLogger.i(_m, 'Server session revoked');
      }
    } catch (e) {
      AppLogger.w(_m, 'Server logout failed (continuing anyway)',);
    } finally {
      await _storage.clearAll();
      getIt<LedgerSocketService>().disconnect();
      AppLogger.i(_m, 'Local session cleared — unauthenticated');
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onUserUpdated(
    AuthUserUpdated event,
    Emitter<AuthState> emit,
  ) async {
    await _storage.saveFullUser(event.user);
    emit(AuthAuthenticated(event.user));
  }

  Future<void> _onDeleteAccount(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Delete account requested');
    emit(const AuthLoading());
    try {
      await _authRepository.deleteAccount();
      AppLogger.i(_m, 'Account deleted on server');
    } catch (e) {
      AppLogger.w(_m, 'Server delete failed (clearing locally anyway)');
    } finally {
      await _storage.clearAll();
      getIt<LedgerSocketService>().disconnect();
      AppLogger.i(_m, 'Local session cleared after account deletion');
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onUpdateProfile(
    AuthProfileUpdateRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Profile update requested');
    emit(const AuthLoading());
    try {
      final updated = await _authRepository.updateProfile(
        name: event.name,
        mobile: event.mobile,
        upiId: event.upiId,
        businessName: event.businessName,
        businessCategory: event.businessCategory,
        businessAddress: event.businessAddress,
      );
      await _storage.saveFullUser(updated);
      AppLogger.i(_m, 'Profile updated — name:${updated.name}');
      emit(AuthAuthenticated(updated));
    } catch (e) {
      AppLogger.e(_m, 'Profile update failed', e);
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
