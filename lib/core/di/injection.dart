import 'package:get_it/get_it.dart';

import '../../features/vendor/data/repositories/mock_vendor_repository.dart';
import '../../features/vendor/domain/repositories/vendor_repository.dart';

import '../../features/customer/data/repositories/mock_customer_repository.dart';
import '../../features/customer/domain/repositories/customer_repository.dart';

import '../../features/shared_ledger/data/repositories/mock_ledger_repository.dart';
import '../../features/shared_ledger/domain/repositories/ledger_repository.dart';

import '../../features/staff/data/repositories/mock_staff_repository.dart';
import '../../features/staff/domain/repositories/staff_repository.dart';

import '../../features/notifications/data/repositories/mock_notification_repository.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';

import '../../features/booking/data/repositories/mock_booking_repository.dart';
import '../../features/booking/domain/repositories/booking_repository.dart';

import '../../features/payments/data/repositories/mock_payment_repository.dart';
import '../../features/payments/domain/repositories/payment_repository.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<VendorRepository>(() => MockVendorRepository());
  getIt.registerLazySingleton<CustomerRepository>(() => MockCustomerRepository());
  getIt.registerLazySingleton<LedgerRepository>(() => MockLedgerRepository());
  getIt.registerLazySingleton<StaffRepository>(() => MockStaffRepository());
  getIt.registerLazySingleton<NotificationRepository>(() => MockNotificationRepository());
  getIt.registerLazySingleton<BookingRepository>(() => MockBookingRepository());
  getIt.registerLazySingleton<PaymentRepository>(() => MockPaymentRepository());
}
