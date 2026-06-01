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
  String get continueButton => 'Continue';

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
  String get enterMobile => 'Enter your credentials to continue';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get verifyAndContinue => 'Verify & Continue';

  @override
  String get changePhoneNumber => 'Change Phone Number';

  @override
  String otpSentTo(String phoneNumber) {
    return 'Enter the 6-digit code sent to +91 $phoneNumber';
  }

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get loginButton => 'LOGIN';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get pleaseEnterCredentials => 'Please enter email and password';

  @override
  String get fillRequiredFields => 'Please fill in name, email and password';

  @override
  String get passwordMinChars => 'Minimum 8 characters';

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
  String get customerMode => 'Customer Mode';

  @override
  String get myVendors => 'My Vendors';

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
  String customerAddedSnackbar(String name) {
    return '$name added';
  }

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
  String get giveCreditSheet => 'Give Credit';

  @override
  String get recordPaymentSheet => 'Record Payment';

  @override
  String get filterAll => 'All';

  @override
  String get balanceCustomerOwes => 'Customer owes you';

  @override
  String get balanceYouOwe => 'You owe customer';

  @override
  String get balanceSettled => 'Settled';

  @override
  String get ledgerInfoTitle => 'How this ledger works';

  @override
  String get statusConfirmed => 'Confirmed';

  @override
  String get statusConfirmedDesc =>
      'Both parties agreed. Entry is locked and cannot be changed.';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusPendingDesc =>
      'Awaiting customer confirmation. Auto-confirmed after 72 hours.';

  @override
  String get statusDisputed => 'Disputed';

  @override
  String get statusDisputedDesc =>
      'Customer raised a dispute. Vendor review required.';

  @override
  String get statusAutoConfirmed => 'Auto-Confirmed';

  @override
  String get entryTypeCreditLabel => 'Credit Entry';

  @override
  String get entryTypePaymentLabel => 'Payment Received';

  @override
  String get entryDetails => 'Entry Details';

  @override
  String get entryAmount => 'Amount';

  @override
  String get entryType => 'Type';

  @override
  String get entryTypeCreditGiven => 'Credit (Given)';

  @override
  String get entryTypePaymentReceived => 'Payment (Received)';

  @override
  String get entryDate => 'Date';

  @override
  String get entryDescription => 'Description';

  @override
  String get entryQuantity => 'Quantity';

  @override
  String get entryConfirmedAt => 'Confirmed At';

  @override
  String get entryDisputeReason => 'Dispute Reason';

  @override
  String entryFor(String name) {
    return 'for $name';
  }

  @override
  String get descriptionOptional => 'Description (optional)';

  @override
  String get quantityOptional => 'Quantity (optional)';

  @override
  String get descriptionHint => 'e.g. 2L Milk, Monthly groceries';

  @override
  String get quantityHint => 'e.g. 2';

  @override
  String get addCreditEntry => 'ADD CREDIT ENTRY';

  @override
  String get noLedgerTransactions => 'No transactions yet';

  @override
  String get noLedgerTransactionsSubtitle =>
      'Add a credit or payment entry to get started.';

  @override
  String get confirmEntryTitle => 'Confirm Entry';

  @override
  String confirmEntryMessage(String amount) {
    return 'Are you sure you want to confirm ₹$amount entry? This action cannot be undone.';
  }

  @override
  String get dispute => 'Dispute';

  @override
  String get raiseDisputeTitle => 'Raise a Dispute';

  @override
  String get raiseDisputeSubtitle =>
      'Describe what is incorrect about this entry.';

  @override
  String get raiseDisputeHint => 'e.g. Amount should be ₹50, not ₹60';

  @override
  String get submitDispute => 'Submit Dispute';

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
  String get noStaffAdded => 'No staff added yet';

  @override
  String get noStaffAddedSubtitle =>
      'Tap the button below to add your first staff member.';

  @override
  String get present => 'Present';

  @override
  String get absent => 'Absent';

  @override
  String get halfDay => 'Half Day';

  @override
  String get paySalaryTitle => 'Pay Salary';

  @override
  String unpaidLabel(String amount) {
    return 'Unpaid: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI Transaction ID (optional)';

  @override
  String get noDues => 'No Dues';

  @override
  String staffPayAmount(String amount) {
    return 'Pay ₹$amount';
  }

  @override
  String staffJoined(String date) {
    return 'Joined $date';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/day';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/month';
  }

  @override
  String get staffPayButton => 'Pay';

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
  String get selectLanguage => 'Select Language';

  @override
  String get settingsManagePayments => 'Manage payment accounts';

  @override
  String get settingsManageAlerts => 'Manage alerts and reminders';

  @override
  String get settingsAppPinFingerprint => 'App PIN and Fingerprint';

  @override
  String get settingsFaqsContact => 'FAQs and Contact Us';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

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
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String minutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String hoursAgo(int count) {
    return '${count}h ago';
  }

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
  String get scanUpiDesc => 'Scan any UPI QR to pay your vendor';

  @override
  String get noTransactionsTitle => 'No transactions yet';

  @override
  String get noTransactionsSubtitle => 'Your payment history will appear here.';

  @override
  String get paymentStatusPaid => 'Paid';

  @override
  String get paymentStatusFailed => 'Failed';

  @override
  String get paymentStatusRefunded => 'Refunded';

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
  String get cancelAppointmentTitle => 'Cancel Appointment?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return 'Cancel your appointment on $date at $time?';
  }

  @override
  String get bookingStatusConfirmed => 'Confirmed';

  @override
  String get bookingStatusPending => 'Pending';

  @override
  String get bookingStatusCancelled => 'Cancelled';

  @override
  String get bookingStatusCompleted => 'Completed';

  @override
  String get bookingStatusDone => 'Done';

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
  String get addNoteOptional => 'Add a note (optional)';

  @override
  String payAmountButton(String amount) {
    return 'PAY ₹$amount';
  }

  @override
  String get done => 'DONE';

  @override
  String get paymentSomethingWentWrong =>
      'Something went wrong. Please try again.';

  @override
  String upiAppComingSoon(String app) {
    return '$app integration coming soon';
  }

  @override
  String get pleaseEnterUpiId => 'Please enter a UPI ID';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount paid to $name';
  }

  @override
  String get orDivider => 'OR';

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

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get amountRupees => 'Amount (₹)';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get alignBillInFrame => 'Align bill within the frame';

  @override
  String get verifyAndLogin => 'Verify & Login';

  @override
  String get voiceListening => 'Listening...';

  @override
  String get voiceThinking => 'Thinking...';

  @override
  String get voiceDetectedEntry => 'Detected Entry';

  @override
  String get voiceConfirmEntry => 'CONFIRM ENTRY';

  @override
  String get item => 'Item';

  @override
  String get totalOutstandingBalance => 'Total Outstanding Balance';

  @override
  String get payAllDues => 'PAY ALL DUES';

  @override
  String get myKhatas => 'My Khatas';

  @override
  String get noVendorsFound => 'No vendors found';

  @override
  String get verifyBillDetails => 'Verify Bill Details';

  @override
  String get scannedBillPreview => 'Scanned Bill Preview';

  @override
  String get descriptionItemDetails => 'Description / Item Details';

  @override
  String get selectCustomer => 'Select Customer';

  @override
  String get searchCustomerHint => 'Search or select customer';

  @override
  String get saveToKhata => 'SAVE TO KHATA';

  @override
  String get allCustomersReport => 'All Customers Report';

  @override
  String collectedInMonth(String month) {
    return 'Collected in $month';
  }

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get securityPin => 'Security & PIN';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get legalInfo => 'Legal';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get changePasswordButton => 'CHANGE PASSWORD';

  @override
  String get passwordChangedSuccess => 'Password changed successfully';

  @override
  String get loadingContent => 'Loading...';

  @override
  String get failedToLoad => 'Failed to load content. Please try again.';

  @override
  String get bookingActions => 'Booking Actions';

  @override
  String get confirmBooking => 'Confirm Booking';

  @override
  String get markComplete => 'Mark as Complete';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return 'Confirm the appointment on $date at $time for $customer?';
  }

  @override
  String get bookingUpdated => 'Booking updated successfully';

  @override
  String get bookingUpdateFailed => 'Failed to update booking';

  @override
  String markAttendanceFor(String date) {
    return 'Mark Attendance — $date';
  }

  @override
  String get allCustomers => 'All Customers';

  @override
  String get noCustomersYet => 'No customers yet';

  @override
  String get noCustomersYetSubtitle => 'Add your first customer to get started';

  @override
  String get invalidPhone =>
      'Enter a valid 10-digit mobile number starting with 6–9';

  @override
  String accrueMonthSalary(String amount) {
    return 'Add Month\'s Salary (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'Add Month\'s Salary';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return 'Add ₹$amount to $name\'s unpaid balance for this month?';
  }
}
