import 'package:get_it/get_it.dart';
import '../utils/app_logger.dart';

import '../../features/vendor/data/repositories/vendor_repository_impl.dart';
import '../../features/vendor/domain/repositories/vendor_repository.dart';

import '../../features/customer/data/repositories/customer_repository_impl.dart';
import '../../features/customer/domain/repositories/customer_repository.dart';

import '../../features/shared_ledger/data/repositories/ledger_repository_impl.dart';
import '../../features/shared_ledger/domain/repositories/ledger_repository.dart';

import '../../features/staff/data/repositories/staff_repository_impl.dart';
import '../../features/staff/domain/repositories/staff_repository.dart';

import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';

import '../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../features/booking/domain/repositories/booking_repository.dart';

import '../../features/payments/data/repositories/payment_repository_impl.dart';
import '../../features/payments/domain/repositories/payment_repository.dart';

// Auth + network
import '../services/storage_service.dart';
import '../services/ledger_socket_service.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../router/auth_state_notifier.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  const module = 'DI';

  AppLogger.i(module, 'Registering StorageService...');
  final storage = StorageService();
  await storage.init();
  getIt.registerSingleton<StorageService>(storage);
  AppLogger.i(module, 'StorageService ready');

  AppLogger.i(module, 'Registering ApiClient (base: ${ApiEndpoints.baseUrl})');
  final apiClient = ApiClient(storage);
  getIt.registerSingleton<ApiClient>(apiClient);

  AppLogger.i(module, 'Registering Auth services');
  getIt.registerSingleton<AuthStateNotifier>(AuthStateNotifier());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(apiClient));
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRepository: getIt<AuthRepository>(),
      storage: getIt<StorageService>(),
    ),
  );

  AppLogger.i(module, 'Registering feature repositories');
  getIt.registerLazySingleton<VendorRepository>(() => VendorRepositoryImpl(apiClient));
  getIt.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(apiClient));
  getIt.registerLazySingleton<LedgerRepository>(() => LedgerRepositoryImpl(apiClient));
  getIt.registerLazySingleton<StaffRepository>(() => StaffRepositoryImpl(apiClient));
  getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(apiClient));
  getIt.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(apiClient));
  getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(apiClient));
  AppLogger.i(module, 'All repositories registered (7 lazy singletons)');

  AppLogger.i(module, 'Registering LedgerSocketService');
  getIt.registerLazySingleton<LedgerSocketService>(() => LedgerSocketService());
  AppLogger.i(module, 'DI setup complete');
}
