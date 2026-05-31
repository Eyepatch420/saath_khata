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
    on<AuthLoginRequested>(_onLogin);
    on<AuthSignupRequested>(_onSignup);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthProfileUpdateRequested>(_onUpdateProfile);
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
        AppLogger.i(_m, 'Session restored — ${user.email} (${user.role})');
        final accessToken = await _storage.getAccessToken();
        if (accessToken != null) {
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

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Login attempt: ${event.email} as ${event.expectedRole}');
    emit(const AuthLoading());
    try {
      final result = await _authRepository.login(
        email: event.email,
        password: event.password,
      );

      if (result.user.role != event.expectedRole) {
        final actual   = result.user.role == 'vendor' ? 'Vendor / Seller' : 'Customer';
        final expected = event.expectedRole == 'vendor' ? 'Vendor / Seller' : 'Customer';
        AppLogger.w(_m, 'Role mismatch — account is $actual but selected $expected');
        emit(AuthError(
          'This email is registered as a $actual account.\n'
          'Please go back and tap "$actual" instead of "$expected".',
        ));
        return;
      }

      await _storage.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
        expiresIn: result.tokens.expiresIn,
      );
      await _storage.saveFullUser(result.user);
      AppLogger.i(_m, 'Login success — ${result.user.email} (${result.user.role})');
      getIt<LedgerSocketService>().connect(result.tokens.accessToken);
      await getIt<PushNotificationService>().initialize();
      getIt<NotificationBloc>().add(LoadUnreadCount());
      emit(AuthAuthenticated(result.user));
    } catch (e) {
      AppLogger.e(_m, 'Login failed: ${event.email}', e);
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> _onSignup(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    AppLogger.i(_m, 'Signup attempt: ${event.email} as ${event.role}');
    emit(const AuthLoading());
    try {
      final result = await _authRepository.signup(
        name: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
        mobile: event.mobile,
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
      AppLogger.i(_m, 'Signup success — ${result.user.email} id:${result.user.id}');
      getIt<LedgerSocketService>().connect(result.tokens.accessToken);
      await getIt<PushNotificationService>().initialize();
      getIt<NotificationBloc>().add(LoadUnreadCount());
      emit(AuthAuthenticated(result.user));
    } catch (e) {
      AppLogger.e(_m, 'Signup failed: ${event.email}', e);
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
      AppLogger.w(_m, 'Server logout failed (continuing anyway)', );
    } finally {
      await _storage.clearAll();
      getIt<LedgerSocketService>().disconnect();
      AppLogger.i(_m, 'Local session cleared — unauthenticated');
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
