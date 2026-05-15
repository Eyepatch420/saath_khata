// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SaathKhata';

  @override
  String get tagline => 'Ek Khata, Dono Ka';

  @override
  String get onboarding1Title => 'Two-Sided Shared Ledger';

  @override
  String get onboarding1Subtitle =>
      'One Ledger for both Vendor and Customer. Both see the same truth.';

  @override
  String get onboarding2Title => 'Voice & Bill OCR';

  @override
  String get onboarding2Subtitle =>
      'Speak or scan bills to create entries instantly in 12 languages.';

  @override
  String get onboarding3Title => 'One-Tap UPI Payment';

  @override
  String get onboarding3Subtitle =>
      'Settle your month-end dues with a single tap via UPI.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get chooseLanguage => 'Choose Your Language';

  @override
  String get chooseRole => 'Choose Your Role';

  @override
  String get vendor => 'Vendor';

  @override
  String get customer => 'Customer';

  @override
  String get welcomeToSaathKhata => 'Welcome to SaathKhata';

  @override
  String get tellUsHowYouUse => 'Tell us how you will use the app';

  @override
  String get vendorRoleTitle => 'I am a Vendor / Seller';

  @override
  String get vendorRoleSubtitle =>
      'Manage my business ledger, staff, and collect payments.';

  @override
  String get customerRoleTitle => 'I am a Customer / Buyer';

  @override
  String get customerRoleSubtitle =>
      'Track my khata with local vendors and pay via UPI.';

  @override
  String get loginTitle => 'Login to SaathKhata';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get enterMobile => 'Enter your mobile number to continue';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get verifyAndContinue => 'Verify & Continue';

  @override
  String get changePhoneNumber => 'Change Phone Number';

  @override
  String otpSentTo(String phoneNumber) {
    return 'Enter the 6-digit code sent to +91 $phoneNumber';
  }

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get egBusinessName => 'e.g. Krishna Dairy';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get enterAddress => 'Enter area or full address';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'Full Name';

  @override
  String get businessName => 'Business Name';

  @override
  String get businessCategory => 'Business Category';

  @override
  String get businessAddress => 'Business Address (Optional)';

  @override
  String get upiId => 'UPI ID (For Payments)';

  @override
  String get vendorDashboard => 'Vendor Dashboard';

  @override
  String get customerDashboard => 'Customer Dashboard';

  @override
  String get outstanding => 'Outstanding';

  @override
  String get collectedToday => 'Collected Today';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get scanBill => 'Scan Bill';

  @override
  String get remindAll => 'Remind All';

  @override
  String get addNew => 'Add New';

  @override
  String get recentCustomers => 'Recent Customers';

  @override
  String get viewAll => 'View All';

  @override
  String get sharedLedger => 'Shared Ledger';

  @override
  String get totalBalance => 'TOTAL BALANCE';

  @override
  String get statement => 'Statement';

  @override
  String get giveCredit => 'GIVE CREDIT';

  @override
  String get recordPayment => 'RECORD PAYMENT';

  @override
  String get staffAndLabour => 'Staff & Labour';

  @override
  String get addStaff => 'Add Staff';

  @override
  String get presentToday => 'Present Today';

  @override
  String get unpaidSalary => 'Unpaid Salary';

  @override
  String get paySalary => 'Pay Salary';

  @override
  String get businessReports => 'Business Reports';

  @override
  String get revenueTrend => 'Revenue Trend';

  @override
  String get collectionSummary => 'Collection Summary';

  @override
  String get totalOutstanding => 'Total Outstanding';

  @override
  String get totalCollected => 'Total Collected';

  @override
  String get topCustomers => 'Top Customers';

  @override
  String get seeAll => 'See All';

  @override
  String get settings => 'Settings';

  @override
  String get appLanguage => 'App Language';

  @override
  String get myUpiIds => 'My UPI IDs';

  @override
  String get notifications => 'Notifications';

  @override
  String get security => 'Security';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get logout => 'Logout';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotificationsTitle => 'No notifications yet';

  @override
  String get noNotificationsSubtitle =>
      'You will see ledger updates, payment alerts and reminders here.';

  @override
  String get payments => 'Payments';

  @override
  String get transactionHistory => 'Transaction History';

  @override
  String get totalPaid => 'Total Paid';

  @override
  String get pending => 'Pending';

  @override
  String get quickPay => 'Quick Pay';

  @override
  String get scanAndPay => 'SCAN & PAY';

  @override
  String get noTransactionsTitle => 'No transactions yet';

  @override
  String get noTransactionsSubtitle => 'Your payment history will appear here.';

  @override
  String get appointments => 'Appointments';

  @override
  String get myAppointments => 'My Appointments';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get past => 'Past';

  @override
  String get cancelBooking => 'Cancel Booking';

  @override
  String get keepBooking => 'Keep';

  @override
  String get noBookingsToday => 'No bookings for this day';

  @override
  String get noBookingsTodaySubtitle =>
      'Customers can book appointments through the app.';

  @override
  String get noAppointmentsTitle => 'No appointments yet';

  @override
  String get noAppointmentsSubtitle =>
      'Book an appointment with your vendor to get started.';

  @override
  String get upiPayment => 'UPI Payment';

  @override
  String get amountToPay => 'Amount to pay';

  @override
  String get securedByUpi => 'Secured by UPI';

  @override
  String get paymentSuccessful => 'Payment Successful!';

  @override
  String get paymentFailed => 'Payment Failed';

  @override
  String get retryPayment => 'Retry';

  @override
  String get enterUpiId => 'Enter UPI ID';

  @override
  String get addNewCustomer => 'Add New Customer';

  @override
  String get customerName => 'Customer Name';

  @override
  String get mobileNo => 'Mobile Number';

  @override
  String get addCustomer => 'ADD CUSTOMER';

  @override
  String get paymentConfirmed => 'CONFIRM PAYMENT';

  @override
  String get addAdvance => 'Add Advance';

  @override
  String get addAdvanceTitle => 'ADD ADVANCE';

  @override
  String get attendanceTitle => 'Attendance';

  @override
  String get salaryTitle => 'Salary Summary';

  @override
  String get rate => 'Rate';

  @override
  String get daysPresent => 'Days Present';

  @override
  String get earned => 'Earned';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get advanceTaken => 'Advance Taken';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get joined => 'Joined';

  @override
  String get noPhone => 'No phone';

  @override
  String get addNewStaff => 'Add New Staff';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get role => 'Role';

  @override
  String get salaryType => 'Salary Type';

  @override
  String get dailyWage => 'Daily Wage';

  @override
  String get monthlySalary => 'Monthly Salary';

  @override
  String get dailyWageAmount => 'Daily Wage (₹)';

  @override
  String get monthlySalaryAmount => 'Monthly Salary (₹)';

  @override
  String get addStaffButton => 'ADD STAFF';
}
