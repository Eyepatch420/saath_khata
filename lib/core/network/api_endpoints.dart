class ApiEndpoints {
  static const String baseUrl = 'http://45.195.159.30:3001/api/v1';

  // Auth — OTP
  static const String sendOtp = '/auth/otp/send';
  static const String verifyOtp = '/auth/otp/verify';

  // Auth
  static const String signup = '/auth/signup';
  static const String login = '/auth/login'; // kept for legacy reference only
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String logoutAll = '/auth/logout-all';
  static const String me = '/auth/me';
  static const String updateProfile = '/auth/profile';
  static const String uploadPhoto = '/auth/profile/photo';
  static const String changePassword = '/auth/change-password';

  // Content (public)
  static const String termsAndConditions = '/content/terms';
  static const String privacyPolicy = '/content/privacy';

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

  // Voice entry (nested under link) — LLM-normalized ledger draft
  static String parseVoice(String linkId) => '/links/$linkId/voice/parse';

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

  // Link Requests (customer-initiated connections)
  static const String linkRequests = '/link-requests';
  static const String pendingLinkRequests = '/link-requests/pending';
  static const String sentLinkRequests = '/link-requests/sent';
  static String linkRequestById(String id) => '/link-requests/$id';
  static String acceptLinkRequest(String id) => '/link-requests/$id/accept';
  static String declineLinkRequest(String id) => '/link-requests/$id/decline';

  // Memberships
  static const String membershipTiers = '/memberships/tiers';
  static String updateMembershipTier(String tierId) => '/memberships/tiers/$tierId';
  static String membershipDiscount(String linkId) =>
      '/memberships/links/$linkId/discount';
  static String membershipStatus(String linkId) => '/memberships/links/$linkId';
  static String assignMembership(String linkId) => '/memberships/links/$linkId/assign';
  static String requestMembership(String linkId) => '/memberships/links/$linkId/request';
  static const String pendingMembershipRequests = '/memberships/requests/pending';
  static String approveMembershipRequest(String id) =>
      '/memberships/requests/$id/approve';
  static String declineMembershipRequest(String id) =>
      '/memberships/requests/$id/decline';

  // Search (authenticated — both roles)
  static const String searchVendors = '/search/vendors';
  static String vendorPublicProfile(String vendorId) => '/search/vendors/$vendorId';

  // Reports (vendor-only)
  static const String reportSummary = '/reports/summary';
  static const String reportCustomers = '/reports/customers';
  static String reportCustomerDetail(String linkId) => '/reports/customers/$linkId';
  static const String reportOutstanding = '/reports/outstanding';
  static const String reportCollectedToday = '/reports/collected-today';
  static const String reportMonthly = '/reports/monthly';
}
