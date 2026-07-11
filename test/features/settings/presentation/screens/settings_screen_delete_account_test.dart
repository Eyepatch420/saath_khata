import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:saath_khata/core/di/injection.dart';
import 'package:saath_khata/core/localization/locale_provider.dart';
import 'package:saath_khata/core/services/storage_service.dart';
import 'package:saath_khata/features/auth/data/models/user_model.dart';
import 'package:saath_khata/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:saath_khata/features/auth/presentation/bloc/auth_event.dart';
import 'package:saath_khata/features/auth/presentation/bloc/auth_state.dart';
import 'package:saath_khata/features/memberships/domain/repositories/membership_repository.dart';
import 'package:saath_khata/features/settings/presentation/screens/settings_screen.dart';
import 'package:saath_khata/l10n/app_localizations.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class MockStorageService extends Mock implements StorageService {}

class MockMembershipRepository extends Mock implements MembershipRepository {}

UserModel _user(String role) => UserModel(
      id: 'u1',
      name: 'Test User',
      email: 'test@example.com',
      role: role,
      businessCategories: const [],
    );

Widget _wrap({required AuthBloc authBloc, required LocaleProvider localeProvider}) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    builder: (context, child) => MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
      ],
      child: BlocProvider<AuthBloc>.value(
        value: authBloc,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsScreen(),
        ),
      ),
    ),
  );
}

void main() {
  late MockStorageService storage;
  late LocaleProvider localeProvider;
  late MockMembershipRepository membershipRepository;

  setUpAll(() {
    registerFallbackValue(const AuthDeleteAccountRequested());
  });

  setUp(() {
    storage = MockStorageService();
    when(() => storage.getLocale()).thenReturn('en');
    when(() => storage.setLocale(any())).thenAnswer((_) async {});
    localeProvider = LocaleProvider(storage);

    membershipRepository = MockMembershipRepository();
    when(() => membershipRepository.getPendingRequests()).thenAnswer((_) async => []);
    if (getIt.isRegistered<MembershipRepository>()) {
      getIt.unregister<MembershipRepository>();
    }
    getIt.registerSingleton<MembershipRepository>(membershipRepository);
  });

  tearDown(() {
    if (getIt.isRegistered<MembershipRepository>()) {
      getIt.unregister<MembershipRepository>();
    }
  });

  for (final role in ['vendor', 'customer', 'staff']) {
    group('Settings screen delete-account flow — $role', () {
      testWidgets('shows a confirmation dialog before dispatching delete', (tester) async {
        final authBloc = MockAuthBloc();
        whenListen(
          authBloc,
          Stream<AuthState>.empty(),
          initialState: AuthAuthenticated(_user(role)),
        );

        await tester.pumpWidget(_wrap(authBloc: authBloc, localeProvider: localeProvider));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Delete Account'));
        await tester.pumpAndSettle();

        // Confirmation dialog is shown; delete has NOT been dispatched yet.
        expect(find.text('Delete Account?'), findsOneWidget);
        verifyNever(() => authBloc.add(const AuthDeleteAccountRequested()));
      });

      testWidgets('Cancel dismisses the dialog without dispatching delete', (tester) async {
        final authBloc = MockAuthBloc();
        whenListen(
          authBloc,
          Stream<AuthState>.empty(),
          initialState: AuthAuthenticated(_user(role)),
        );

        await tester.pumpWidget(_wrap(authBloc: authBloc, localeProvider: localeProvider));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Delete Account'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(find.text('Delete Account?'), findsNothing);
        verifyNever(() => authBloc.add(const AuthDeleteAccountRequested()));
      });

      testWidgets('Delete Forever dispatches AuthDeleteAccountRequested exactly once', (tester) async {
        final authBloc = MockAuthBloc();
        whenListen(
          authBloc,
          Stream<AuthState>.empty(),
          initialState: AuthAuthenticated(_user(role)),
        );

        await tester.pumpWidget(_wrap(authBloc: authBloc, localeProvider: localeProvider));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Delete Account'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Delete Forever'));
        await tester.pumpAndSettle();

        expect(find.text('Delete Account?'), findsNothing);
        verify(() => authBloc.add(const AuthDeleteAccountRequested())).called(1);
      });
    });
  }
}
