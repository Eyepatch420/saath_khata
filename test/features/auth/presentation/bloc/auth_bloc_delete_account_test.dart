import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saath_khata/core/di/injection.dart';
import 'package:saath_khata/core/services/ledger_socket_service.dart';
import 'package:saath_khata/core/services/storage_service.dart';
import 'package:saath_khata/features/auth/domain/repositories/auth_repository.dart';
import 'package:saath_khata/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:saath_khata/features/auth/presentation/bloc/auth_event.dart';
import 'package:saath_khata/features/auth/presentation/bloc/auth_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockStorageService extends Mock implements StorageService {}

class MockLedgerSocketService extends Mock implements LedgerSocketService {}

void main() {
  late MockAuthRepository authRepository;
  late MockStorageService storage;
  late MockLedgerSocketService ledgerSocket;

  setUp(() {
    authRepository = MockAuthRepository();
    storage = MockStorageService();
    ledgerSocket = MockLedgerSocketService();

    if (getIt.isRegistered<LedgerSocketService>()) {
      getIt.unregister<LedgerSocketService>();
    }
    getIt.registerSingleton<LedgerSocketService>(ledgerSocket);

    when(() => ledgerSocket.disconnect()).thenReturn(null);
    when(() => storage.clearAll()).thenAnswer((_) async {});
  });

  tearDown(() {
    if (getIt.isRegistered<LedgerSocketService>()) {
      getIt.unregister<LedgerSocketService>();
    }
  });

  AuthBloc buildBloc() => AuthBloc(authRepository: authRepository, storage: storage);

  group('AuthDeleteAccountRequested — vendor', () {
    blocTest<AuthBloc, AuthState>(
      'clears local session and emits Unauthenticated when server delete succeeds',
      setUp: () {
        when(() => authRepository.deleteAccount()).thenAnswer((_) async {});
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      expect: () => [const AuthLoading(), const AuthUnauthenticated()],
      verify: (_) {
        verify(() => authRepository.deleteAccount()).called(1);
        verify(() => storage.clearAll()).called(1);
        verify(() => ledgerSocket.disconnect()).called(1);
      },
    );
  });

  group('AuthDeleteAccountRequested — customer', () {
    blocTest<AuthBloc, AuthState>(
      'clears local session and emits Unauthenticated when server delete succeeds',
      setUp: () {
        when(() => authRepository.deleteAccount()).thenAnswer((_) async {});
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      expect: () => [const AuthLoading(), const AuthUnauthenticated()],
      verify: (_) {
        verify(() => authRepository.deleteAccount()).called(1);
        verify(() => storage.clearAll()).called(1);
      },
    );
  });

  group('AuthDeleteAccountRequested — staff', () {
    blocTest<AuthBloc, AuthState>(
      'clears local session and emits Unauthenticated when server delete succeeds',
      setUp: () {
        when(() => authRepository.deleteAccount()).thenAnswer((_) async {});
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      expect: () => [const AuthLoading(), const AuthUnauthenticated()],
      verify: (_) {
        verify(() => authRepository.deleteAccount()).called(1);
        verify(() => storage.clearAll()).called(1);
      },
    );
  });

  group('AuthDeleteAccountRequested — server failure', () {
    blocTest<AuthBloc, AuthState>(
      'still clears local session and emits Unauthenticated even when the server call throws '
      '(documents the current client/server desync: local state is cleared unconditionally)',
      setUp: () {
        when(() => authRepository.deleteAccount()).thenThrow(Exception('network error'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthDeleteAccountRequested()),
      expect: () => [const AuthLoading(), const AuthUnauthenticated()],
      verify: (_) {
        verify(() => authRepository.deleteAccount()).called(1);
        // Local session is still cleared despite the server failure — this is
        // deliberate current behavior (see auth_bloc.dart _onDeleteAccount's
        // try/finally), asserted here so a future change to that contract is
        // a visible, intentional test update rather than a silent regression.
        verify(() => storage.clearAll()).called(1);
        verify(() => ledgerSocket.disconnect()).called(1);
      },
    );
  });

  test('AuthDeleteAccountRequested is a stable const event with no payload', () {
    expect(const AuthDeleteAccountRequested(), equals(const AuthDeleteAccountRequested()));
  });
}
