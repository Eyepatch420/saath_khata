class ApiEndpoints {
  static const String baseUrl = 'http://45.195.159.30:3001/api/v1';

  // Auth
  static const String signup = '/auth/signup';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String logoutAll = '/auth/logout-all';
  static const String me = '/auth/me';
  static const String updateProfile = '/auth/profile';
  static const String uploadPhoto = '/auth/profile/photo';

  // Links
  static const String links = '/links';
  static const String myCustomers = '/links/customers';
  static const String myVendors = '/links/vendors';
  static const String remindAll = '/links/remind-all';
  static String linkById(String id) => '/links/$id';

  // Ledger (nested under link)
  static String linkEntries(String linkId) => '/links/$linkId/entries';
  static String linkBalance(String linkId) => '/links/$linkId/entries/balance';
  static String confirmEntry(String linkId, String entryId) =>
      '/links/$linkId/entries/$entryId/confirm';
  static String disputeEntry(String linkId, String entryId) =>
      '/links/$linkId/entries/$entryId/dispute';

  // Payments (nested under link)
  static String linkPayments(String linkId) => '/links/$linkId/payments';
  static String settleLink(String linkId) => '/links/$linkId/payments/settle';

  // Notifications
  static const String notifications = '/notifications';
  static const String notifUnreadCount = '/notifications/unread-count';
  static const String notifReadAll = '/notifications/read-all';
  static String notifReadOne(String id) => '/notifications/$id/read';

  // Staff (vendor-only)
  static const String staff = '/staff';
  static String staffById(String id) => '/staff/$id';
  static String staffAttendance(String id) => '/staff/$id/attendance';
  static String staffPay(String id) => '/staff/$id/pay';
  static String staffAdvance(String id) => '/staff/$id/advance';
  static String staffAccrue(String id) => '/staff/$id/accrue';
  static String staffSalaryHistory(String id) => '/staff/$id/salary-history';

  // Bookings
  static const String bookings = '/bookings';
  static const String bookingConfig = '/bookings/config';
  static String publicSlots(String vendorId) => '/bookings/slots/$vendorId';
  static const String vendorBookings = '/bookings/vendor';
  static const String customerBookings = '/bookings/customer';
  static String bookingById(String id) => '/bookings/$id';

  // Device tokens (push notifications)
  static const String registerDevice = '/devices/token';

  // Reports (vendor-only)
  static const String reportSummary = '/reports/summary';
  static const String reportCustomers = '/reports/customers';
  static String reportCustomerDetail(String linkId) => '/reports/customers/$linkId';
  static const String reportMonthly = '/reports/monthly';
}
