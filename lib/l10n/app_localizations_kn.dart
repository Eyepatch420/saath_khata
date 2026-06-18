// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'ಸಾಥ್‌ಖಾತಾ';

  @override
  String get tagline => 'ಒಂದು ಖಾತೆ, ಇಬ್ಬರಿಗೂ';

  @override
  String get onboarding1Title => 'ಎರಡು ಕಡೆಯ ಹಂಚಿಕೆ ಖಾತೆ';

  @override
  String get onboarding1Subtitle =>
      'ಮಾರಾಟಗಾರ ಮತ್ತು ಗ್ರಾಹಕ ಇಬ್ಬರಿಗೂ ಒಂದೇ ಖಾತೆ. ಇಬ್ಬರೂ ಒಂದೇ ಸತ್ಯ ನೋಡುತ್ತಾರೆ.';

  @override
  String get onboarding2Title => 'ವಾಯ್ಸ್ ಮತ್ತು ಬಿಲ್ OCR';

  @override
  String get onboarding2Subtitle =>
      '12 ಭಾಷೆಗಳಲ್ಲಿ ತಕ್ಷಣ ನಮೂದುಗಳನ್ನು ರಚಿಸಲು ಮಾತನಾಡಿ ಅಥವಾ ಬಿಲ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ.';

  @override
  String get onboarding3Title => 'ಒಂದೇ ಟ್ಯಾಪ್‌ನಲ್ಲಿ UPI ಪಾವತಿ';

  @override
  String get onboarding3Subtitle =>
      'UPI ಮೂಲಕ ಒಂದೇ ಟ್ಯಾಪ್‌ನಲ್ಲಿ ತಿಂಗಳ ಬಾಕಿ ತೀರಿಸಿ.';

  @override
  String get getStarted => 'ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get next => 'ಮುಂದೆ';

  @override
  String get skip => 'ಬಿಡಿ';

  @override
  String get chooseLanguage => 'ನಿಮ್ಮ ಭಾಷೆ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get continueButton => 'ಮುಂದುವರಿಸಿ';

  @override
  String get chooseRole => 'ನಿಮ್ಮ ಪಾತ್ರ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get vendor => 'ಮಾರಾಟಗಾರ';

  @override
  String get customer => 'ಗ್ರಾಹಕ';

  @override
  String get welcomeToSaathKhata => 'ಸಾಥ್‌ಖಾತಾಗೆ ಸ್ವಾಗತ';

  @override
  String get tellUsHowYouUse => 'ನೀವು ಅಪ್ ಅನ್ನು ಹೇಗೆ ಬಳಸುತ್ತೀರಿ ಎಂದು ಹೇಳಿ';

  @override
  String get vendorRoleTitle => 'ನಾನು ಮಾರಾಟಗಾರ';

  @override
  String get vendorRoleSubtitle =>
      'ವ್ಯವಹಾರ ಖಾತೆ, ಉದ್ಯೋಗಿಗಳನ್ನು ನಿರ್ವಹಿಸಿ ಮತ್ತು ಪಾವತಿ ಪಡೆಯಿರಿ.';

  @override
  String get customerRoleTitle => 'ನಾನು ಗ್ರಾಹಕ';

  @override
  String get customerRoleSubtitle =>
      'ಮಾರಾಟಗಾರರೊಂದಿಗೆ ಖಾತೆ ಟ್ರ್ಯಾಕ್ ಮಾಡಿ ಮತ್ತು UPI ಮೂಲಕ ಪಾವತಿಸಿ.';

  @override
  String get loginTitle => 'ಸಾಥ್‌ಖಾತಾಗೆ ಲಾಗಿನ್ ಮಾಡಿ';

  @override
  String get enterMobile => 'ಮುಂದುವರಿಯಲು ನಿಮ್ಮ ವಿವರಗಳನ್ನು ನಮೂದಿಸಿ';

  @override
  String get mobileNumber => 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get sendOtp => 'OTP ಕಳುಹಿಸಿ';

  @override
  String get verifyOtp => 'OTP ಪರಿಶೀಲಿಸಿ';

  @override
  String get verifyAndContinue => 'ಪರಿಶೀಲಿಸಿ ಮತ್ತು ಮುಂದುವರಿಸಿ';

  @override
  String get changePhoneNumber => 'ಫೋನ್ ಸಂಖ್ಯೆ ಬದಲಿಸಿ';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumberಗೆ ಕಳುಹಿಸಿದ 6 ಅಂಕಿ ಕೋಡ್ ನಮೂದಿಸಿ';
  }

  @override
  String get email => 'ಇಮೇಲ್';

  @override
  String get password => 'ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get passwordHint => 'ಪಾಸ್‌ವರ್ಡ್ ನಮೂದಿಸಿ';

  @override
  String get loginButton => 'ಲಾಗಿನ್';

  @override
  String get noAccount => 'ಖಾತೆ ಇಲ್ಲವೇ?';

  @override
  String get signUp => 'ನೋಂದಣಿ ಮಾಡಿ';

  @override
  String get pleaseEnterCredentials => 'ಇಮೇಲ್ ಮತ್ತು ಪಾಸ್‌ವರ್ಡ್ ನಮೂದಿಸಿ';

  @override
  String get fillRequiredFields => 'ಹೆಸರು, ಇಮೇಲ್ ಮತ್ತು ಪಾಸ್‌ವರ್ಡ್ ತುಂಬಿಸಿ';

  @override
  String get passwordMinChars => 'ಕನಿಷ್ಠ 8 ಅಕ್ಷರಗಳು';

  @override
  String get completeProfile => 'ಪ್ರೊಫೈಲ್ ಪೂರ್ಣಗೊಳಿಸಿ';

  @override
  String get enterYourName => 'ನಿಮ್ಮ ಹೆಸರು ನಮೂದಿಸಿ';

  @override
  String get egBusinessName => 'ಉದಾ. ಕೃಷ್ಣ ಡೈರಿ';

  @override
  String get selectCategory => 'ವರ್ಗ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get enterAddress => 'ಪ್ರದೇಶ ಅಥವಾ ಪೂರ್ಣ ವಿಳಾಸ ನಮೂದಿಸಿ';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'ಪೂರ್ಣ ಹೆಸರು';

  @override
  String get businessName => 'ವ್ಯವಹಾರದ ಹೆಸರು';

  @override
  String get businessCategory => 'ವ್ಯವಹಾರ ವರ್ಗ';

  @override
  String get businessAddress => 'ವ್ಯವಹಾರ ವಿಳಾಸ (ಐಚ್ಛಿಕ)';

  @override
  String get upiId => 'UPI ID (ಪಾವತಿಗಳಿಗಾಗಿ)';

  @override
  String get vendorDashboard => 'ಮಾರಾಟಗಾರ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್';

  @override
  String get customerDashboard => 'ಗ್ರಾಹಕ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್';

  @override
  String get customerMode => 'ಗ್ರಾಹಕ ಮೋಡ್';

  @override
  String get myVendors => 'ನನ್ನ ಮಾರಾಟಗಾರರು';

  @override
  String get outstanding => 'ಬಾಕಿ';

  @override
  String get collectedToday => 'ಇಂದು ಸಂಗ್ರಹ';

  @override
  String get quickActions => 'ತ್ವರಿತ ಕ್ರಮಗಳು';

  @override
  String get scanBill => 'ಬಿಲ್ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ';

  @override
  String get remindAll => 'ಎಲ್ಲರಿಗೂ ನೆನಪಿಸಿ';

  @override
  String get addNew => 'ಹೊಸದು ಸೇರಿಸಿ';

  @override
  String get recentCustomers => 'ಇತ್ತೀಚಿನ ಗ್ರಾಹಕರು';

  @override
  String get viewAll => 'ಎಲ್ಲ ನೋಡಿ';

  @override
  String customerAddedSnackbar(String name) {
    return '$name ಸೇರಿಸಲಾಗಿದೆ';
  }

  @override
  String get sharedLedger => 'ಹಂಚಿಕೆ ಖಾತೆ';

  @override
  String get totalBalance => 'ಒಟ್ಟು ಬ್ಯಾಲೆನ್ಸ್';

  @override
  String get statement => 'ಹೇಳಿಕೆ';

  @override
  String get giveCredit => 'ಸಾಲ ನೀಡಿ';

  @override
  String get recordPayment => 'ಪಾವತಿ ದಾಖಲಿಸಿ';

  @override
  String get giveCreditSheet => 'ಸಾಲ ನೀಡಿ';

  @override
  String get recordPaymentSheet => 'ಪಾವತಿ ದಾಖಲಿಸಿ';

  @override
  String get filterAll => 'ಎಲ್ಲ';

  @override
  String get balanceCustomerOwes => 'ಗ್ರಾಹಕರ ಬಾಕಿ';

  @override
  String get balanceYouOwe => 'ನಿಮ್ಮ ಬಾಕಿ';

  @override
  String get balanceSettled => 'ತೀರಿಸಲಾಗಿದೆ';

  @override
  String get balanceYouOweVendor => 'ವ್ಯಾಪಾರಿಗೆ ನಿಮ್ಮ ಬಾಕಿ';

  @override
  String get balanceVendorOwesYou => 'ವ್ಯಾಪಾರಿಯ ಬಾಕಿ ನಿಮಗೆ';

  @override
  String get ledgerInfoTitle => 'ಈ ಖಾತೆ ಹೇಗೆ ಕಾರ್ಯನಿರ್ವಹಿಸುತ್ತದೆ';

  @override
  String get statusConfirmed => 'ದೃಢೀಕರಿಸಲಾಗಿದೆ';

  @override
  String get statusConfirmedDesc =>
      'ಎರಡೂ ಕಡೆ ಒಪ್ಪಿಗೆ ಇದೆ. ನಮೂದು ಲಾಕ್ ಆಗಿದೆ ಮತ್ತು ಬದಲಿಸಲಾಗುವುದಿಲ್ಲ.';

  @override
  String get statusPending => 'ಬಾಕಿ';

  @override
  String get statusPendingDesc =>
      'ಗ್ರಾಹಕರ ದೃಢೀಕರಣಕ್ಕಾಗಿ ಕಾಯಲಾಗುತ್ತಿದೆ. 72 ಗಂಟೆಗಳಲ್ಲಿ ಸ್ವಯಂಚಾಲಿತವಾಗಿ ದೃಢೀಕರಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get statusDisputed => 'ವಿವಾದಿತ';

  @override
  String get statusDisputedDesc =>
      'ಗ್ರಾಹಕರು ವಿವಾದ ಎತ್ತಿದ್ದಾರೆ. ಮಾರಾಟಗಾರರ ಪರಿಶೀಲನೆ ಅಗತ್ಯ.';

  @override
  String get statusAutoConfirmed => 'ಸ್ವಯಂ ದೃಢೀಕರಣ';

  @override
  String get entryTypeCreditLabel => 'ಸಾಲ ನಮೂದು';

  @override
  String get entryTypePaymentLabel => 'ಪಾವತಿ ಸ್ವೀಕರಿಸಲಾಗಿದೆ';

  @override
  String get entryDetails => 'ನಮೂದಿನ ವಿವರಗಳು';

  @override
  String get entryAmount => 'ಮೊತ್ತ';

  @override
  String get entryType => 'ಪ್ರಕಾರ';

  @override
  String get entryTypeCreditGiven => 'ಸಾಲ (ನೀಡಿದ)';

  @override
  String get entryTypePaymentReceived => 'ಪಾವತಿ (ಸ್ವೀಕರಿಸಿದ)';

  @override
  String get entryDate => 'ದಿನಾಂಕ';

  @override
  String get entryDescription => 'ವಿವರಣೆ';

  @override
  String get entryQuantity => 'ಪ್ರಮಾಣ';

  @override
  String get entryConfirmedAt => 'ದೃಢೀಕರಣ ದಿನಾಂಕ';

  @override
  String get entryDisputeReason => 'ವಿವಾದದ ಕಾರಣ';

  @override
  String entryFor(String name) {
    return '$name ಗಾಗಿ';
  }

  @override
  String get descriptionOptional => 'ವಿವರಣೆ (ಐಚ್ಛಿಕ)';

  @override
  String get quantityOptional => 'ಪ್ರಮಾಣ (ಐಚ್ಛಿಕ)';

  @override
  String get descriptionHint => 'ಉದಾ. 2L ಹಾಲು, ತಿಂಗಳ ದಿನಸಿ';

  @override
  String get quantityHint => 'ಉದಾ. 2';

  @override
  String get addCreditEntry => 'ಸಾಲ ನಮೂದು ಸೇರಿಸಿ';

  @override
  String get noLedgerTransactions => 'ಇನ್ನೂ ವ್ಯವಹಾರಗಳಿಲ್ಲ';

  @override
  String get noLedgerTransactionsSubtitle =>
      'ಪ್ರಾರಂಭಿಸಲು ಸಾಲ ಅಥವಾ ಪಾವತಿ ನಮೂದು ಸೇರಿಸಿ.';

  @override
  String get confirmEntryTitle => 'ನಮೂದು ದೃಢೀಕರಿಸಿ';

  @override
  String confirmEntryMessage(String amount) {
    return '₹$amount ನಮೂದನ್ನು ದೃಢೀಕರಿಸಲು ಬಯಸುವಿರಾ? ಇದನ್ನು ರದ್ದು ಮಾಡಲಾಗುವುದಿಲ್ಲ.';
  }

  @override
  String get dispute => 'ವಿವಾದ';

  @override
  String get raiseDisputeTitle => 'ವಿವಾದ ಎತ್ತಿ';

  @override
  String get raiseDisputeSubtitle => 'ಈ ನಮೂದಿನಲ್ಲಿ ಏನು ತಪ್ಪಿದೆ ಎಂದು ವಿವರಿಸಿ.';

  @override
  String get raiseDisputeHint => 'ಉದಾ. ಮೊತ್ತ ₹50 ಆಗಿರಬೇಕು, ₹60 ಅಲ್ಲ';

  @override
  String get submitDispute => 'ವಿವಾದ ಸಲ್ಲಿಸಿ';

  @override
  String get staffAndLabour => 'ಸಿಬ್ಬಂದಿ ಮತ್ತು ಕಾರ್ಮಿಕರು';

  @override
  String get addStaff => 'ಸಿಬ್ಬಂದಿ ಸೇರಿಸಿ';

  @override
  String get presentToday => 'ಇಂದು ಹಾಜರು';

  @override
  String get unpaidSalary => 'ಪಾವತಿ ಆಗದ ಸಂಬಳ';

  @override
  String get paySalary => 'ಸಂಬಳ ಕೊಡಿ';

  @override
  String get noStaffAdded => 'ಇನ್ನೂ ಸಿಬ್ಬಂದಿ ಇಲ್ಲ';

  @override
  String get noStaffAddedSubtitle =>
      'ಮೊದಲ ಸಿಬ್ಬಂದಿ ಸೇರಿಸಲು ಕೆಳಗಿನ ಗುಂಡಿ ಒತ್ತಿ.';

  @override
  String get present => 'ಹಾಜರು';

  @override
  String get absent => 'ಗೈರುಹಾಜರು';

  @override
  String get halfDay => 'ಅರ್ಧ ದಿನ';

  @override
  String get paySalaryTitle => 'ಸಂಬಳ ಕೊಡಿ';

  @override
  String unpaidLabel(String amount) {
    return 'ಪಾವತಿ ಆಗಿಲ್ಲ: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI ವ್ಯವಹಾರ ID (ಐಚ್ಛಿಕ)';

  @override
  String get noDues => 'ಬಾಕಿ ಇಲ್ಲ';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount ಕೊಡಿ';
  }

  @override
  String staffJoined(String date) {
    return '$date ರಂದು ಸೇರಿದರು';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/ದಿನ';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/ತಿಂಗಳು';
  }

  @override
  String get staffPayButton => 'ಪಾವತಿ';

  @override
  String get businessReports => 'ವ್ಯವಹಾರ ವರದಿಗಳು';

  @override
  String get revenueTrend => 'ಆದಾಯ ಪ್ರವೃತ್ತಿ';

  @override
  String get collectionSummary => 'ಸಂಗ್ರಹ ಸಾರಾಂಶ';

  @override
  String get totalOutstanding => 'ಒಟ್ಟು ಬಾಕಿ';

  @override
  String get totalCollected => 'ಒಟ್ಟು ಸಂಗ್ರಹ';

  @override
  String get topCustomers => 'ಮೇಲ್ಮಟ್ಟದ ಗ್ರಾಹಕರು';

  @override
  String get seeAll => 'ಎಲ್ಲ ನೋಡಿ';

  @override
  String get settings => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get appLanguage => 'ಅಪ್ ಭಾಷೆ';

  @override
  String get selectLanguage => 'ಭಾಷೆ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get settingsManagePayments => 'ಪಾವತಿ ಖಾತೆಗಳನ್ನು ನಿರ್ವಹಿಸಿ';

  @override
  String get settingsManageAlerts => 'ಎಚ್ಚರಿಕೆಗಳು ಮತ್ತು ಜ್ಞಾಪಕಗಳನ್ನು ನಿರ್ವಹಿಸಿ';

  @override
  String get settingsAppPinFingerprint => 'ಅಪ್ ಪಿನ್ ಮತ್ತು ಬೆರಳಚ್ಚು';

  @override
  String get settingsFaqsContact => 'ಸಹಾಯ ಮತ್ತು ಸಂಪರ್ಕ';

  @override
  String settingsVersion(String version) {
    return 'ಆವೃತ್ತಿ $version';
  }

  @override
  String get myUpiIds => 'ನನ್ನ UPI IDಗಳು';

  @override
  String get notifications => 'ಅಧಿಸೂಚನೆಗಳು';

  @override
  String get security => 'ಭದ್ರತೆ';

  @override
  String get helpSupport => 'ಸಹಾಯ';

  @override
  String get logout => 'ಲಾಗ್‌ಔಟ್';

  @override
  String get markAllRead => 'ಎಲ್ಲವನ್ನೂ ಓದಿದಂತೆ ಗುರುತಿಸಿ';

  @override
  String get noNotificationsTitle => 'ಇನ್ನೂ ಅಧಿಸೂಚನೆಗಳಿಲ್ಲ';

  @override
  String get noNotificationsSubtitle =>
      'ಇಲ್ಲಿ ಖಾತೆ ನವೀಕರಣಗಳು, ಪಾವತಿ ಎಚ್ಚರಿಕೆಗಳು ಮತ್ತು ಜ್ಞಾಪಕಗಳು ಕಾಣಿಸುತ್ತವೆ.';

  @override
  String get today => 'ಇಂದು';

  @override
  String get yesterday => 'ನಿನ್ನೆ';

  @override
  String minutesAgo(int count) {
    return '$count ನಿಮಿಷಗಳ ಹಿಂದೆ';
  }

  @override
  String hoursAgo(int count) {
    return '$count ಗಂಟೆಗಳ ಹಿಂದೆ';
  }

  @override
  String get payments => 'ಪಾವತಿಗಳು';

  @override
  String get transactionHistory => 'ವ್ಯವಹಾರ ಇತಿಹಾಸ';

  @override
  String get totalPaid => 'ಒಟ್ಟು ಪಾವತಿ';

  @override
  String get pending => 'ಬಾಕಿ';

  @override
  String get quickPay => 'ತ್ವರಿತ ಪಾವತಿ';

  @override
  String get scanAndPay => 'ಸ್ಕ್ಯಾನ್ ಮಾಡಿ ಮತ್ತು ಪಾವತಿಸಿ';

  @override
  String get scanUpiDesc => 'ಮಾರಾಟಗಾರರಿಗೆ ಪಾವತಿಸಲು UPI QR ಸ್ಕ್ಯಾನ್ ಮಾಡಿ';

  @override
  String get noTransactionsTitle => 'ಇನ್ನೂ ವ್ಯವಹಾರಗಳಿಲ್ಲ';

  @override
  String get noTransactionsSubtitle => 'ನಿಮ್ಮ ಪಾವತಿ ಇತಿಹಾಸ ಇಲ್ಲಿ ಕಾಣಿಸುತ್ತದೆ.';

  @override
  String get paymentStatusPaid => 'ಪಾವತಿ ಆಗಿದೆ';

  @override
  String get paymentStatusFailed => 'ವಿಫಲ';

  @override
  String get paymentStatusRefunded => 'ಮರಳಿ ನೀಡಲಾಗಿದೆ';

  @override
  String get appointments => 'ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್‌ಗಳು';

  @override
  String get myAppointments => 'ನನ್ನ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್‌ಗಳು';

  @override
  String get upcoming => 'ಮುಂಬರುವ';

  @override
  String get past => 'ಹಿಂದಿನ';

  @override
  String get cancelBooking => 'ಬುಕಿಂಗ್ ರದ್ದು ಮಾಡಿ';

  @override
  String get keepBooking => 'ಇರಲಿ';

  @override
  String get noBookingsToday => 'ಇಂದು ಬುಕಿಂಗ್‌ಗಳಿಲ್ಲ';

  @override
  String get noBookingsTodaySubtitle =>
      'ಗ್ರಾಹಕರು ಅಪ್ ಮೂಲಕ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್‌ಗಳನ್ನು ಬುಕ್ ಮಾಡಬಹುದು.';

  @override
  String get noAppointmentsTitle => 'ಇನ್ನೂ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್‌ಗಳಿಲ್ಲ';

  @override
  String get noAppointmentsSubtitle =>
      'ಪ್ರಾರಂಭಿಸಲು ನಿಮ್ಮ ಮಾರಾಟಗಾರರೊಂದಿಗೆ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್ ಬುಕ್ ಮಾಡಿ.';

  @override
  String get cancelAppointmentTitle => 'ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್ ರದ್ದು ಮಾಡುವಿರಾ?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date ರಂದು $time ಗೆ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್ ರದ್ದು ಮಾಡುವಿರಾ?';
  }

  @override
  String get bookingStatusConfirmed => 'ದೃಢೀಕರಿಸಲಾಗಿದೆ';

  @override
  String get bookingStatusPending => 'ಬಾಕಿ';

  @override
  String get bookingStatusCancelled => 'ರದ್ದು';

  @override
  String get bookingStatusCompleted => 'ಪೂರ್ಣ';

  @override
  String get bookingStatusDone => 'ಪೂರ್ಣ';

  @override
  String get upiPayment => 'UPI ಪಾವತಿ';

  @override
  String get amountToPay => 'ಪಾವತಿಸಬೇಕಾದ ಮೊತ್ತ';

  @override
  String get securedByUpi => 'UPI ಮೂಲಕ ಸುರಕ್ಷಿತ';

  @override
  String get paymentSuccessful => 'ಪಾವತಿ ಯಶಸ್ವಿ!';

  @override
  String get paymentFailed => 'ಪಾವತಿ ವಿಫಲ';

  @override
  String get retryPayment => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get enterUpiId => 'UPI ID ನಮೂದಿಸಿ';

  @override
  String get addNoteOptional => 'ಟಿಪ್ಪಣಿ ಸೇರಿಸಿ (ಐಚ್ಛಿಕ)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount ಪಾವತಿಸಿ';
  }

  @override
  String get done => 'ಮುಗಿಯಿತು';

  @override
  String get paymentSomethingWentWrong => 'ಏನೋ ತಪ್ಪಾಯಿತು. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String upiAppComingSoon(String app) {
    return '$app ಶೀಘ್ರದಲ್ಲೇ ಬರಲಿದೆ';
  }

  @override
  String get pleaseEnterUpiId => 'UPI ID ನಮೂದಿಸಿ';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $nameಗೆ ಪಾವತಿಸಲಾಗಿದೆ';
  }

  @override
  String get orDivider => 'ಅಥವಾ';

  @override
  String get addNewCustomer => 'ಹೊಸ ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಿ';

  @override
  String get customerName => 'ಗ್ರಾಹಕರ ಹೆಸರು';

  @override
  String get mobileNo => 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get addCustomer => 'ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಿ';

  @override
  String get paymentConfirmed => 'ಪಾವತಿ ದೃಢೀಕರಿಸಿ';

  @override
  String get addAdvance => 'ಮುಂಗಡ ಸೇರಿಸಿ';

  @override
  String get addAdvanceTitle => 'ಮುಂಗಡ ಸೇರಿಸಿ';

  @override
  String get attendanceTitle => 'ಹಾಜರಾತಿ';

  @override
  String get salaryTitle => 'ಸಂಬಳ ಸಾರಾಂಶ';

  @override
  String get rate => 'ದರ';

  @override
  String get daysPresent => 'ಹಾಜರಾದ ದಿನಗಳು';

  @override
  String get earned => 'ಗಳಿಸಿದ';

  @override
  String get unpaid => 'ಪಾವತಿ ಆಗಿಲ್ಲ';

  @override
  String get advanceTaken => 'ತೆಗೆದ ಮುಂಗಡ';

  @override
  String get active => 'ಸಕ್ರಿಯ';

  @override
  String get inactive => 'ನಿಷ್ಕ್ರಿಯ';

  @override
  String get joined => 'ಸೇರಿದ';

  @override
  String get noPhone => 'ಫೋನ್ ಇಲ್ಲ';

  @override
  String get addNewStaff => 'ಹೊಸ ಸಿಬ್ಬಂದಿ ಸೇರಿಸಿ';

  @override
  String get fullNameLabel => 'ಪೂರ್ಣ ಹೆಸರು';

  @override
  String get phoneNumber => 'ಫೋನ್ ಸಂಖ್ಯೆ';

  @override
  String get role => 'ಪಾತ್ರ';

  @override
  String get salaryType => 'ಸಂಬಳ ಪ್ರಕಾರ';

  @override
  String get dailyWage => 'ದಿನಗೂಲಿ';

  @override
  String get monthlySalary => 'ತಿಂಗಳ ಸಂಬಳ';

  @override
  String get dailyWageAmount => 'ದಿನಗೂಲಿ (₹)';

  @override
  String get monthlySalaryAmount => 'ತಿಂಗಳ ಸಂಬಳ (₹)';

  @override
  String get addStaffButton => 'ಸಿಬ್ಬಂದಿ ಸೇರಿಸಿ';

  @override
  String get noteOptional => 'ಟಿಪ್ಪಣಿ (ಐಚ್ಛಿಕ)';

  @override
  String get amountRupees => 'ಮೊತ್ತ (₹)';

  @override
  String get cancel => 'ರದ್ದು';

  @override
  String get confirm => 'ದೃಢೀಕರಿಸಿ';

  @override
  String get tryAgain => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get alignBillInFrame => 'ಬಿಲ್ ಅನ್ನು ಫ್ರೇಮ್‌ನಲ್ಲಿ ಇರಿಸಿ';

  @override
  String get verifyAndLogin => 'ಪರಿಶೀಲಿಸಿ ಮತ್ತು ಲಾಗಿನ್ ಮಾಡಿ';

  @override
  String get voiceListening => 'ಕೇಳುತ್ತಿದ್ದೇನೆ...';

  @override
  String get voiceThinking => 'ಯೋಚಿಸುತ್ತಿದ್ದೇನೆ...';

  @override
  String get voiceDetectedEntry => 'ಪತ್ತೆ ಹಚ್ಚಿದ ನಮೂದು';

  @override
  String get voiceConfirmEntry => 'ನಮೂದು ದೃಢೀಕರಿಸಿ';

  @override
  String get item => 'ವಸ್ತು';

  @override
  String get totalOutstandingBalance => 'ಒಟ್ಟು ಬಾಕಿ ಮೊತ್ತ';

  @override
  String get payAllDues => 'ಎಲ್ಲ ಬಾಕಿ ಪಾವತಿಸಿ';

  @override
  String get myKhatas => 'ನನ್ನ ಖಾತೆಗಳು';

  @override
  String get noVendorsFound => 'ಮಾರಾಟಗಾರರು ಕಂಡುಬಂದಿಲ್ಲ';

  @override
  String get verifyBillDetails => 'ಬಿಲ್ ವಿವರಗಳನ್ನು ಪರಿಶೀಲಿಸಿ';

  @override
  String get scannedBillPreview => 'ಸ್ಕ್ಯಾನ್ ಮಾಡಿದ ಬಿಲ್';

  @override
  String get descriptionItemDetails => 'ವಿವರಣೆ / ವಸ್ತು ವಿವರಗಳು';

  @override
  String get selectCustomer => 'ಗ್ರಾಹಕರನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get searchCustomerHint => 'ಗ್ರಾಹಕರನ್ನು ಹುಡುಕಿ ಅಥವಾ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get saveToKhata => 'ಖಾತೆಗೆ ಉಳಿಸಿ';

  @override
  String get allCustomersReport => 'ಎಲ್ಲ ಗ್ರಾಹಕರ ವರದಿ';

  @override
  String collectedInMonth(String month) {
    return '$monthನಲ್ಲಿ ಸಂಗ್ರಹ';
  }

  @override
  String get notificationSettings => 'ಅಧಿಸೂಚನೆ ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get securityPin => 'ಭದ್ರತೆ ಮತ್ತು ಪಿನ್';

  @override
  String get editProfile => 'ಪ್ರೊಫೈಲ್ ಸಂಪಾದಿಸಿ';

  @override
  String get changePassword => 'ಪಾಸ್‌ವರ್ಡ್ ಬದಲಿಸಿ';

  @override
  String get termsAndConditions => 'ನಿಯಮಗಳು ಮತ್ತು ಷರತ್ತುಗಳು';

  @override
  String get privacyPolicy => 'ಗೌಪ್ಯತಾ ನೀತಿ';

  @override
  String get accountSettings => 'ಖಾತೆ ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get legalInfo => 'ಕಾನೂನು';

  @override
  String get currentPassword => 'ಪ್ರಸ್ತುತ ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get newPassword => 'ಹೊಸ ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get confirmNewPassword => 'ಹೊಸ ಪಾಸ್‌ವರ್ಡ್ ದೃಢೀಕರಿಸಿ';

  @override
  String get passwordsDoNotMatch => 'ಪಾಸ್‌ವರ್ಡ್‌ಗಳು ಹೊಂದಿಕೆಯಾಗುವುದಿಲ್ಲ';

  @override
  String get changePasswordButton => 'ಪಾಸ್‌ವರ್ಡ್ ಬದಲಿಸಿ';

  @override
  String get passwordChangedSuccess => 'ಪಾಸ್‌ವರ್ಡ್ ಯಶಸ್ವಿಯಾಗಿ ಬದಲಾಯಿಸಲಾಗಿದೆ';

  @override
  String get loadingContent => 'ಲೋಡ್ ಆಗುತ್ತಿದೆ...';

  @override
  String get failedToLoad => 'ವಿಷಯ ಲೋಡ್ ಮಾಡಲು ವಿಫಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get bookingActions => 'ಬುಕಿಂಗ್ ಕ್ರಮಗಳು';

  @override
  String get confirmBooking => 'ಬುಕಿಂಗ್ ದೃಢೀಕರಿಸಿ';

  @override
  String get markComplete => 'ಪೂರ್ಣ ಎಂದು ಗುರುತಿಸಿ';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer ರ $date ರಂದು $time ಗೆ ಅಪಾಯಿಂಟ್‌ಮೆಂಟ್ ದೃಢೀಕರಿಸುವಿರಾ?';
  }

  @override
  String get bookingUpdated => 'ಬುಕಿಂಗ್ ಯಶಸ್ವಿಯಾಗಿ ನವೀಕರಿಸಲಾಗಿದೆ';

  @override
  String get bookingUpdateFailed => 'ಬುಕಿಂಗ್ ನವೀಕರಿಸಲು ವಿಫಲ';

  @override
  String markAttendanceFor(String date) {
    return 'ಹಾಜರಾತಿ ಗುರುತಿಸಿ — $date';
  }

  @override
  String get allCustomers => 'ಎಲ್ಲ ಗ್ರಾಹಕರು';

  @override
  String get noCustomersYet => 'ಇನ್ನೂ ಗ್ರಾಹಕರಿಲ್ಲ';

  @override
  String get noCustomersYetSubtitle => 'ಪ್ರಾರಂಭಿಸಲು ಮೊದಲ ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಿ';

  @override
  String get invalidPhone =>
      '6–9 ರಿಂದ ಪ್ರಾರಂಭವಾಗುವ 10 ಅಂಕಿ ಮಾನ್ಯ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ ನಮೂದಿಸಿ';

  @override
  String accrueMonthSalary(String amount) {
    return 'ತಿಂಗಳ ಸಂಬಳ ಸೇರಿಸಿ (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'ತಿಂಗಳ ಸಂಬಳ ಸೇರಿಸಿ';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name ರ ಬಾಕಿಗೆ ಈ ತಿಂಗಳು ₹$amount ಸೇರಿಸುವಿರಾ?';
  }

  @override
  String get accountInformation => 'Account Information';

  @override
  String get updateProfileDetails => 'Update your name, photo and details';

  @override
  String get updateAccountPassword => 'Update your account password';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountSubtitle =>
      'Permanently delete your account and all data';

  @override
  String get deleteAccountConfirmation => 'Delete Account?';

  @override
  String get deleteAccountConfirmationMessage =>
      'This will permanently delete your account and all your data. This action cannot be undone.';

  @override
  String get deleteAccountStaffWarning =>
      'This will permanently delete your account. This cannot be undone.';

  @override
  String get deleteForever => 'Delete Forever';

  @override
  String get delete => 'Delete';

  @override
  String get readTermsOfService => 'Read our terms of service';

  @override
  String get privacyPolicyDescription => 'How we handle your data';

  @override
  String get confirmLogout => 'Are you sure you want to log out?';

  @override
  String get membershipTiers => 'Membership Tiers';

  @override
  String get membershipTiersDescription =>
      'Rename tiers and set member discounts';

  @override
  String get logIn => 'Log in';

  @override
  String get enterPhoneNumberToContinue =>
      'Enter your phone number to continue';

  @override
  String get otpDemoHint => 'OTP is for demo only · enter 123456 to continue';

  @override
  String get havingTrouble => 'Having trouble?';

  @override
  String get useEmailInstead => 'Use email instead →';

  @override
  String get logInWithEmail => 'Log in with email';

  @override
  String get emailPlaceholder => 'you@example.com';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get tapToAddProfilePhoto => 'Tap to add profile photo';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get add => 'Add';

  @override
  String get addUpiId => 'Add UPI ID';

  @override
  String get save => 'Save';

  @override
  String get close => 'Close';

  @override
  String get ok => 'OK';

  @override
  String get remove => 'Remove';

  @override
  String get approve => 'Approve';

  @override
  String get decline => 'Decline';

  @override
  String get none => 'None';

  @override
  String get percent => 'Percent';

  @override
  String get profile => 'Profile';

  @override
  String get paymentVerification => 'Payment Verification';

  @override
  String get verifyingPayment => 'Verifying Payment';

  @override
  String get paymentConfirmedExclamation => 'Payment Confirmed!';

  @override
  String get verificationTimedOut => 'Verification Timed Out';

  @override
  String get goBack => 'Go Back';

  @override
  String get payDues => 'Pay Dues';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get allDone => 'All Done!';

  @override
  String get noUpcomingAppointments => 'No upcoming appointments';

  @override
  String get myPay => 'My Pay';

  @override
  String get myPaymentQr => 'My Payment QR';

  @override
  String get showMyQr => 'Show my QR';

  @override
  String get noPaymentsYet => 'No payments yet';

  @override
  String get paymentHistory => 'Payment History';

  @override
  String get paymentHistory6Months => 'Payment History (6 months)';

  @override
  String get connectionRequest => 'Connection Request';

  @override
  String get vendorWantsToConnect => 'A vendor wants to connect';

  @override
  String get acceptRequest => 'Accept';

  @override
  String get declineRequest => 'Decline';

  @override
  String get messageLabel => 'Message';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get requestSentNotification =>
      'Request sent! They will be notified to confirm.';

  @override
  String get awaitingAcceptance => 'Awaiting Acceptance';

  @override
  String get addAVendor => 'Add a Vendor';

  @override
  String get findByPhoneOrEmail => 'Find by phone number or email';

  @override
  String get phoneOrEmail => 'Phone or email';

  @override
  String get phoneOrEmailHint => '10-digit mobile or email address';

  @override
  String get nicknameOptional => 'Nickname (optional)';

  @override
  String get howYouKnowVendor => 'How you know this vendor';

  @override
  String get bookingNoteExample => 'E.g. Need extra milk today';

  @override
  String get confirmLocation => 'Confirm Location';

  @override
  String get moveMapToSelectLocation => 'Move the map to select a location';

  @override
  String get searchPlaceHint => 'Search for a place…';

  @override
  String get mapAttribution => '© OpenStreetMap contributors';

  @override
  String get searchVendorsHint => 'Search vendors…';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get payViaUpi => 'Pay via UPI';

  @override
  String get connectWithVendor => 'Connect';

  @override
  String get requestConnection => 'Request Connection';

  @override
  String get addVendor => 'Add Vendor';

  @override
  String get noOutstandingBalances => 'No outstanding balances';

  @override
  String get allCustomersSettledUp => 'All customers are settled up.';

  @override
  String get nothingCollectedToday => 'Nothing collected today';

  @override
  String get paymentsWillAppearHere =>
      'Payments received today will appear here.';

  @override
  String get customerReport => 'Customer Report';

  @override
  String get overview => 'Overview';

  @override
  String get tapToStop => 'Tap to stop';

  @override
  String get itemName => 'Item name';

  @override
  String get itemNameExample => 'e.g. Milk';

  @override
  String get unitPrice => 'Unit Price ₹';

  @override
  String get deliverTo => 'Deliver to';

  @override
  String get bulkCharge => 'Bulk Charge';

  @override
  String get newProduct => 'New product';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get newProductService => 'New Product / Service';

  @override
  String get updateProductDetails => 'Update name, unit or price';

  @override
  String get defineProduct => 'Define what you sell and its base price';

  @override
  String get productName => 'Product name';

  @override
  String get productNameExample => 'e.g. Daily Morning Milk';

  @override
  String get unit => 'Unit';

  @override
  String get unitExample => 'litre / kg / piece';

  @override
  String get pricePerUnit => 'Price / unit (₹)';

  @override
  String get deleteProduct => 'Delete product';

  @override
  String get deleteProductConfirmation => 'Delete product?';

  @override
  String removeProductConfirmation(String name) {
    return 'Remove \"$name\" from your product list?';
  }

  @override
  String get noProductsYet => 'No products yet';

  @override
  String get addFirstProduct => 'Add First Product';

  @override
  String get renameTier => 'Rename tier';

  @override
  String get tierName => 'Tier name';

  @override
  String tierLevel(int level) {
    return 'Level $level';
  }

  @override
  String get memberDiscount => 'Member discount';

  @override
  String discountFor(String tier) {
    return 'Discount for $tier';
  }

  @override
  String get flatAmount => 'Flat ₹';

  @override
  String get discountPercent => 'Discount %';

  @override
  String get discountAmount => 'Discount amount (₹)';

  @override
  String get percentExample => 'e.g. 5';

  @override
  String get amountExample => 'e.g. 50';

  @override
  String get maxDiscountPerDue => 'Max discount per due (₹) — optional';

  @override
  String get maxDiscountExample => 'e.g. 100 (leave blank for no cap)';

  @override
  String get saveDiscount => 'Save discount';

  @override
  String get membership => 'Membership';

  @override
  String get setTier => 'Set';

  @override
  String get changeTier => 'Change';

  @override
  String get applyMembership => 'Apply';

  @override
  String get removeMembership => 'Remove membership';

  @override
  String get removeLedgerConfirmation => 'Remove ledger?';

  @override
  String get exportStatement => 'Export Statement';

  @override
  String get appAccess => 'App access';
}
