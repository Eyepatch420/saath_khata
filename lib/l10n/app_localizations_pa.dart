// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'ਸਾਥਖਾਤਾ';

  @override
  String get tagline => 'ਇੱਕ ਖਾਤਾ, ਦੋਵਾਂ ਦਾ';

  @override
  String get onboarding1Title => 'ਦੋ-ਪੱਖੀ ਸਾਂਝਾ ਖਾਤਾ';

  @override
  String get onboarding1Subtitle =>
      'ਵਿਕ੍ਰੇਤਾ ਅਤੇ ਗਾਹਕ ਦੋਵਾਂ ਲਈ ਇੱਕੋ ਖਾਤਾ। ਦੋਵੇਂ ਇੱਕੋ ਸੱਚ ਦੇਖਦੇ ਹਨ।';

  @override
  String get onboarding2Title => 'ਆਵਾਜ਼ ਅਤੇ ਬਿੱਲ OCR';

  @override
  String get onboarding2Subtitle =>
      '12 ਭਾਸ਼ਾਵਾਂ ਵਿੱਚ ਤੁਰੰਤ ਐਂਟਰੀਆਂ ਬਣਾਉਣ ਲਈ ਬੋਲੋ ਜਾਂ ਬਿੱਲ ਸਕੈਨ ਕਰੋ।';

  @override
  String get onboarding3Title => 'ਇੱਕ ਟੈਪ ਵਿੱਚ UPI ਭੁਗਤਾਨ';

  @override
  String get onboarding3Subtitle =>
      'UPI ਰਾਹੀਂ ਇੱਕ ਟੈਪ ਵਿੱਚ ਮਹੀਨੇ ਦਾ ਬਕਾਇਆ ਚੁਕਾਓ।';

  @override
  String get getStarted => 'ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get next => 'ਅਗਲਾ';

  @override
  String get skip => 'ਛੱਡੋ';

  @override
  String get chooseLanguage => 'ਆਪਣੀ ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get continueButton => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get chooseRole => 'ਆਪਣੀ ਭੂਮਿਕਾ ਚੁਣੋ';

  @override
  String get vendor => 'ਵਿਕ੍ਰੇਤਾ';

  @override
  String get customer => 'ਗਾਹਕ';

  @override
  String get welcomeToSaathKhata => 'ਸਾਥਖਾਤਾ ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ';

  @override
  String get tellUsHowYouUse => 'ਸਾਨੂੰ ਦੱਸੋ ਤੁਸੀਂ ਐਪ ਕਿਵੇਂ ਵਰਤੋਗੇ';

  @override
  String get vendorRoleTitle => 'ਮੈਂ ਵਿਕ੍ਰੇਤਾ ਹਾਂ';

  @override
  String get vendorRoleSubtitle =>
      'ਕਾਰੋਬਾਰ ਦਾ ਖਾਤਾ, ਕਰਮਚਾਰੀ ਪ੍ਰਬੰਧਿਤ ਕਰੋ ਅਤੇ ਭੁਗਤਾਨ ਲਓ।';

  @override
  String get customerRoleTitle => 'ਮੈਂ ਗਾਹਕ ਹਾਂ';

  @override
  String get customerRoleSubtitle =>
      'ਵਿਕ੍ਰੇਤਾਵਾਂ ਨਾਲ ਖਾਤਾ ਟ੍ਰੈਕ ਕਰੋ ਅਤੇ UPI ਨਾਲ ਭੁਗਤਾਨ ਕਰੋ।';

  @override
  String get loginTitle => 'ਸਾਥਖਾਤਾ ਵਿੱਚ ਲੌਗਇਨ ਕਰੋ';

  @override
  String get enterMobile => 'ਜਾਰੀ ਰੱਖਣ ਲਈ ਆਪਣੀ ਜਾਣਕਾਰੀ ਦਰਜ ਕਰੋ';

  @override
  String get mobileNumber => 'ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get sendOtp => 'OTP ਭੇਜੋ';

  @override
  String get verifyOtp => 'OTP ਤਸਦੀਕ ਕਰੋ';

  @override
  String get verifyAndContinue => 'ਤਸਦੀਕ ਕਰੋ ਅਤੇ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get changePhoneNumber => 'ਫ਼ੋਨ ਨੰਬਰ ਬਦਲੋ';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber \'ਤੇ ਭੇਜਿਆ 6 ਅੰਕਾਂ ਦਾ ਕੋਡ ਦਰਜ ਕਰੋ';
  }

  @override
  String get email => 'ਈਮੇਲ';

  @override
  String get password => 'ਪਾਸਵਰਡ';

  @override
  String get passwordHint => 'ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ';

  @override
  String get loginButton => 'ਲੌਗਇਨ';

  @override
  String get noAccount => 'ਖਾਤਾ ਨਹੀਂ ਹੈ?';

  @override
  String get signUp => 'ਰਜਿਸਟਰ ਕਰੋ';

  @override
  String get pleaseEnterCredentials => 'ਈਮੇਲ ਅਤੇ ਪਾਸਵਰਡ ਦਰਜ ਕਰੋ';

  @override
  String get fillRequiredFields => 'ਨਾਮ, ਈਮੇਲ ਅਤੇ ਪਾਸਵਰਡ ਭਰੋ';

  @override
  String get passwordMinChars => 'ਘੱਟੋ-ਘੱਟ 8 ਅੱਖਰ';

  @override
  String get completeProfile => 'ਪ੍ਰੋਫਾਈਲ ਪੂਰਾ ਕਰੋ';

  @override
  String get enterYourName => 'ਆਪਣਾ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get egBusinessName => 'ਜਿਵੇਂ: ਕ੍ਰਿਸ਼ਨਾ ਡੇਅਰੀ';

  @override
  String get selectCategory => 'ਸ਼੍ਰੇਣੀ ਚੁਣੋ';

  @override
  String get enterAddress => 'ਇਲਾਕਾ ਜਾਂ ਪੂਰਾ ਪਤਾ ਦਰਜ ਕਰੋ';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'ਪੂਰਾ ਨਾਮ';

  @override
  String get businessName => 'ਕਾਰੋਬਾਰ ਦਾ ਨਾਮ';

  @override
  String get businessCategory => 'ਕਾਰੋਬਾਰ ਸ਼੍ਰੇਣੀ';

  @override
  String get businessAddress => 'ਕਾਰੋਬਾਰ ਦਾ ਪਤਾ (ਵਿਕਲਪਿਕ)';

  @override
  String get upiId => 'UPI ID (ਭੁਗਤਾਨ ਲਈ)';

  @override
  String get vendorDashboard => 'ਵਿਕ੍ਰੇਤਾ ਡੈਸ਼ਬੋਰਡ';

  @override
  String get customerDashboard => 'ਗਾਹਕ ਡੈਸ਼ਬੋਰਡ';

  @override
  String get customerMode => 'ਗਾਹਕ ਮੋਡ';

  @override
  String get myVendors => 'ਮੇਰੇ ਵਿਕ੍ਰੇਤਾ';

  @override
  String get outstanding => 'ਬਕਾਇਆ';

  @override
  String get collectedToday => 'ਅੱਜ ਦੀ ਵਸੂਲੀ';

  @override
  String get quickActions => 'ਤੇਜ਼ ਕਿਰਿਆਵਾਂ';

  @override
  String get scanBill => 'ਬਿੱਲ ਸਕੈਨ ਕਰੋ';

  @override
  String get remindAll => 'ਸਭ ਨੂੰ ਯਾਦ ਦਿਵਾਓ';

  @override
  String get addNew => 'ਨਵਾਂ ਜੋੜੋ';

  @override
  String get recentCustomers => 'ਹਾਲੀਆ ਗਾਹਕ';

  @override
  String get viewAll => 'ਸਭ ਦੇਖੋ';

  @override
  String customerAddedSnackbar(String name) {
    return '$name ਜੋੜਿਆ ਗਿਆ';
  }

  @override
  String get sharedLedger => 'ਸਾਂਝਾ ਖਾਤਾ';

  @override
  String get totalBalance => 'ਕੁੱਲ ਬੈਲੇਂਸ';

  @override
  String get statement => 'ਬਿਆਨ';

  @override
  String get giveCredit => 'ਉਧਾਰ ਦਿਓ';

  @override
  String get recordPayment => 'ਭੁਗਤਾਨ ਦਰਜ ਕਰੋ';

  @override
  String get giveCreditSheet => 'ਉਧਾਰ ਦਿਓ';

  @override
  String get recordPaymentSheet => 'ਭੁਗਤਾਨ ਦਰਜ ਕਰੋ';

  @override
  String get filterAll => 'ਸਭ';

  @override
  String get balanceCustomerOwes => 'ਗਾਹਕ ਦਾ ਬਕਾਇਆ';

  @override
  String get balanceYouOwe => 'ਤੁਹਾਡਾ ਬਕਾਇਆ';

  @override
  String get balanceSettled => 'ਚੁਕਤਾ';

  @override
  String get balanceYouOweVendor => 'ਤੁਸੀਂ ਦੁਕਾਨਦਾਰ ਦੇ ਦੇਣਦਾਰ ਹੋ';

  @override
  String get balanceVendorOwesYou => 'ਦੁਕਾਨਦਾਰ ਤੁਹਾਡਾ ਦੇਣਦਾਰ ਹੈ';

  @override
  String get ledgerInfoTitle => 'ਇਹ ਖਾਤਾ ਕਿਵੇਂ ਕੰਮ ਕਰਦਾ ਹੈ';

  @override
  String get statusConfirmed => 'ਪੁਸ਼ਟੀ ਹੋਈ';

  @override
  String get statusConfirmedDesc =>
      'ਦੋਵੇਂ ਧਿਰਾਂ ਸਹਿਮਤ। ਐਂਟਰੀ ਲੌਕ ਹੈ ਅਤੇ ਬਦਲੀ ਨਹੀਂ ਜਾ ਸਕਦੀ।';

  @override
  String get statusPending => 'ਲੰਬਿਤ';

  @override
  String get statusPendingDesc =>
      'ਗਾਹਕ ਦੀ ਪੁਸ਼ਟੀ ਦੀ ਉਡੀਕ। 72 ਘੰਟਿਆਂ ਵਿੱਚ ਆਪਣੇ ਆਪ ਪੁਸ਼ਟੀ।';

  @override
  String get statusDisputed => 'ਵਿਵਾਦਿਤ';

  @override
  String get statusDisputedDesc =>
      'ਗਾਹਕ ਨੇ ਵਿਵਾਦ ਉਠਾਇਆ। ਵਿਕ੍ਰੇਤਾ ਦੀ ਸਮੀਖਿਆ ਲੋੜੀਂਦੀ ਹੈ।';

  @override
  String get statusAutoConfirmed => 'ਆਪਣੇ ਆਪ ਪੁਸ਼ਟੀ';

  @override
  String get entryTypeCreditLabel => 'ਉਧਾਰ ਐਂਟਰੀ';

  @override
  String get entryTypePaymentLabel => 'ਭੁਗਤਾਨ ਮਿਲਿਆ';

  @override
  String get entryDetails => 'ਐਂਟਰੀ ਵੇਰਵਾ';

  @override
  String get entryAmount => 'ਰਕਮ';

  @override
  String get entryType => 'ਕਿਸਮ';

  @override
  String get entryTypeCreditGiven => 'ਉਧਾਰ (ਦਿੱਤਾ)';

  @override
  String get entryTypePaymentReceived => 'ਭੁਗਤਾਨ (ਮਿਲਿਆ)';

  @override
  String get entryDate => 'ਤਾਰੀਖ਼';

  @override
  String get entryDescription => 'ਵੇਰਵਾ';

  @override
  String get entryQuantity => 'ਮਾਤਰਾ';

  @override
  String get entryConfirmedAt => 'ਪੁਸ਼ਟੀ ਤਾਰੀਖ਼';

  @override
  String get entryDisputeReason => 'ਵਿਵਾਦ ਦਾ ਕਾਰਨ';

  @override
  String entryFor(String name) {
    return '$name ਲਈ';
  }

  @override
  String get descriptionOptional => 'ਵੇਰਵਾ (ਵਿਕਲਪਿਕ)';

  @override
  String get quantityOptional => 'ਮਾਤਰਾ (ਵਿਕਲਪਿਕ)';

  @override
  String get descriptionHint => 'ਜਿਵੇਂ: 2L ਦੁੱਧ, ਮਹੀਨੇ ਦਾ ਕਿਰਾਨਾ';

  @override
  String get quantityHint => 'ਜਿਵੇਂ: 2';

  @override
  String get addCreditEntry => 'ਉਧਾਰ ਐਂਟਰੀ ਜੋੜੋ';

  @override
  String get noLedgerTransactions => 'ਅਜੇ ਕੋਈ ਲੈਣ-ਦੇਣ ਨਹੀਂ';

  @override
  String get noLedgerTransactionsSubtitle =>
      'ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਉਧਾਰ ਜਾਂ ਭੁਗਤਾਨ ਐਂਟਰੀ ਜੋੜੋ।';

  @override
  String get confirmEntryTitle => 'ਐਂਟਰੀ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String confirmEntryMessage(String amount) {
    return 'ਕੀ ਤੁਸੀਂ ₹$amount ਦੀ ਐਂਟਰੀ ਪੁਸ਼ਟੀ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ? ਇਹ ਵਾਪਸ ਨਹੀਂ ਹੋ ਸਕਦੀ।';
  }

  @override
  String get dispute => 'ਵਿਵਾਦ';

  @override
  String get raiseDisputeTitle => 'ਵਿਵਾਦ ਉਠਾਓ';

  @override
  String get raiseDisputeSubtitle => 'ਦੱਸੋ ਇਸ ਐਂਟਰੀ ਵਿੱਚ ਕੀ ਗਲਤ ਹੈ।';

  @override
  String get raiseDisputeHint => 'ਜਿਵੇਂ: ਰਕਮ ₹50 ਹੋਣੀ ਚਾਹੀਦੀ, ₹60 ਨਹੀਂ';

  @override
  String get submitDispute => 'ਵਿਵਾਦ ਦਰਜ ਕਰੋ';

  @override
  String get staffAndLabour => 'ਕਰਮਚਾਰੀ ਅਤੇ ਮਜ਼ਦੂਰ';

  @override
  String get addStaff => 'ਕਰਮਚਾਰੀ ਜੋੜੋ';

  @override
  String get presentToday => 'ਅੱਜ ਹਾਜ਼ਰ';

  @override
  String get unpaidSalary => 'ਅਦਾਇਗੀ ਨਾ ਕੀਤੀ ਤਨਖਾਹ';

  @override
  String get paySalary => 'ਤਨਖਾਹ ਦਿਓ';

  @override
  String get noStaffAdded => 'ਅਜੇ ਕੋਈ ਕਰਮਚਾਰੀ ਨਹੀਂ';

  @override
  String get noStaffAddedSubtitle => 'ਪਹਿਲਾ ਕਰਮਚਾਰੀ ਜੋੜਨ ਲਈ ਹੇਠਾਂ ਦਾ ਬਟਨ ਦਬਾਓ।';

  @override
  String get present => 'ਹਾਜ਼ਰ';

  @override
  String get absent => 'ਗੈਰਹਾਜ਼ਰ';

  @override
  String get halfDay => 'ਅੱਧਾ ਦਿਨ';

  @override
  String get paySalaryTitle => 'ਤਨਖਾਹ ਦਿਓ';

  @override
  String unpaidLabel(String amount) {
    return 'ਅਦਾਇਗੀ ਬਾਕੀ: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI ਲੈਣ-ਦੇਣ ID (ਵਿਕਲਪਿਕ)';

  @override
  String get noDues => 'ਕੋਈ ਬਕਾਇਆ ਨਹੀਂ';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount ਦਿਓ';
  }

  @override
  String staffJoined(String date) {
    return '$date ਨੂੰ ਜੁੜੇ';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/ਦਿਨ';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/ਮਹੀਨਾ';
  }

  @override
  String get staffPayButton => 'ਭੁਗਤਾਨ';

  @override
  String get businessReports => 'ਕਾਰੋਬਾਰ ਰਿਪੋਰਟਾਂ';

  @override
  String get revenueTrend => 'ਆਮਦਨ ਰੁਝਾਨ';

  @override
  String get collectionSummary => 'ਵਸੂਲੀ ਸਾਰ';

  @override
  String get totalOutstanding => 'ਕੁੱਲ ਬਕਾਇਆ';

  @override
  String get totalCollected => 'ਕੁੱਲ ਵਸੂਲੀ';

  @override
  String get topCustomers => 'ਚੋਟੀ ਦੇ ਗਾਹਕ';

  @override
  String get seeAll => 'ਸਭ ਦੇਖੋ';

  @override
  String get settings => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get appLanguage => 'ਐਪ ਭਾਸ਼ਾ';

  @override
  String get selectLanguage => 'ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get settingsManagePayments => 'ਭੁਗਤਾਨ ਖਾਤੇ ਪ੍ਰਬੰਧਿਤ ਕਰੋ';

  @override
  String get settingsManageAlerts => 'ਚੇਤਾਵਨੀਆਂ ਅਤੇ ਯਾਦ-ਦਿਹਾਨੀਆਂ ਪ੍ਰਬੰਧਿਤ ਕਰੋ';

  @override
  String get settingsAppPinFingerprint => 'ਐਪ ਪਿੰਨ ਅਤੇ ਫਿੰਗਰਪ੍ਰਿੰਟ';

  @override
  String get settingsFaqsContact => 'ਸਹਾਇਤਾ ਅਤੇ ਸੰਪਰਕ';

  @override
  String settingsVersion(String version) {
    return 'ਵਰਜ਼ਨ $version';
  }

  @override
  String get myUpiIds => 'ਮੇਰੇ UPI ID';

  @override
  String get notifications => 'ਸੂਚਨਾਵਾਂ';

  @override
  String get security => 'ਸੁਰੱਖਿਆ';

  @override
  String get helpSupport => 'ਸਹਾਇਤਾ';

  @override
  String get logout => 'ਲੌਗਆਉਟ';

  @override
  String get markAllRead => 'ਸਭ ਪੜ੍ਹਿਆ ਮਾਰਕ ਕਰੋ';

  @override
  String get noNotificationsTitle => 'ਅਜੇ ਕੋਈ ਸੂਚਨਾ ਨਹੀਂ';

  @override
  String get noNotificationsSubtitle =>
      'ਇੱਥੇ ਖਾਤਾ ਅਪਡੇਟ, ਭੁਗਤਾਨ ਚੇਤਾਵਨੀਆਂ ਅਤੇ ਯਾਦ-ਦਿਹਾਨੀਆਂ ਦਿਖਾਈ ਦੇਣਗੀਆਂ।';

  @override
  String get today => 'ਅੱਜ';

  @override
  String get yesterday => 'ਕੱਲ੍ਹ';

  @override
  String minutesAgo(int count) {
    return '$count ਮਿੰਟ ਪਹਿਲਾਂ';
  }

  @override
  String hoursAgo(int count) {
    return '$count ਘੰਟੇ ਪਹਿਲਾਂ';
  }

  @override
  String get payments => 'ਭੁਗਤਾਨ';

  @override
  String get transactionHistory => 'ਲੈਣ-ਦੇਣ ਇਤਿਹਾਸ';

  @override
  String get totalPaid => 'ਕੁੱਲ ਭੁਗਤਾਨ';

  @override
  String get pending => 'ਲੰਬਿਤ';

  @override
  String get quickPay => 'ਤੇਜ਼ ਭੁਗਤਾਨ';

  @override
  String get scanAndPay => 'ਸਕੈਨ ਕਰੋ ਅਤੇ ਭੁਗਤਾਨ ਕਰੋ';

  @override
  String get scanUpiDesc => 'ਵਿਕ੍ਰੇਤਾ ਨੂੰ ਭੁਗਤਾਨ ਕਰਨ ਲਈ UPI QR ਸਕੈਨ ਕਰੋ';

  @override
  String get noTransactionsTitle => 'ਅਜੇ ਕੋਈ ਲੈਣ-ਦੇਣ ਨਹੀਂ';

  @override
  String get noTransactionsSubtitle => 'ਤੁਹਾਡਾ ਭੁਗਤਾਨ ਇਤਿਹਾਸ ਇੱਥੇ ਦਿਖੇਗਾ।';

  @override
  String get paymentStatusPaid => 'ਭੁਗਤਾਨ ਹੋਇਆ';

  @override
  String get paymentStatusFailed => 'ਅਸਫ਼ਲ';

  @override
  String get paymentStatusRefunded => 'ਵਾਪਸ';

  @override
  String get appointments => 'ਅਪੌਇੰਟਮੈਂਟ';

  @override
  String get myAppointments => 'ਮੇਰੀਆਂ ਅਪੌਇੰਟਮੈਂਟਾਂ';

  @override
  String get upcoming => 'ਆਉਣ ਵਾਲੀਆਂ';

  @override
  String get past => 'ਪਿਛਲੀਆਂ';

  @override
  String get cancelBooking => 'ਬੁਕਿੰਗ ਰੱਦ ਕਰੋ';

  @override
  String get keepBooking => 'ਰੱਖੋ';

  @override
  String get noBookingsToday => 'ਅੱਜ ਕੋਈ ਬੁਕਿੰਗ ਨਹੀਂ';

  @override
  String get noBookingsTodaySubtitle =>
      'ਗਾਹਕ ਐਪ ਰਾਹੀਂ ਅਪੌਇੰਟਮੈਂਟ ਬੁੱਕ ਕਰ ਸਕਦੇ ਹਨ।';

  @override
  String get noAppointmentsTitle => 'ਅਜੇ ਕੋਈ ਅਪੌਇੰਟਮੈਂਟ ਨਹੀਂ';

  @override
  String get noAppointmentsSubtitle =>
      'ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਆਪਣੇ ਵਿਕ੍ਰੇਤਾ ਨਾਲ ਅਪੌਇੰਟਮੈਂਟ ਬੁੱਕ ਕਰੋ।';

  @override
  String get cancelAppointmentTitle => 'ਅਪੌਇੰਟਮੈਂਟ ਰੱਦ ਕਰਨੀ ਹੈ?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date ਨੂੰ $time ਦੀ ਅਪੌਇੰਟਮੈਂਟ ਰੱਦ ਕਰਨੀ ਹੈ?';
  }

  @override
  String get bookingStatusConfirmed => 'ਪੁਸ਼ਟੀ ਹੋਈ';

  @override
  String get bookingStatusPending => 'ਲੰਬਿਤ';

  @override
  String get bookingStatusCancelled => 'ਰੱਦ';

  @override
  String get bookingStatusCompleted => 'ਪੂਰੀ';

  @override
  String get bookingStatusDone => 'ਪੂਰੀ';

  @override
  String get upiPayment => 'UPI ਭੁਗਤਾਨ';

  @override
  String get amountToPay => 'ਭੁਗਤਾਨ ਕਰਨ ਦੀ ਰਕਮ';

  @override
  String get securedByUpi => 'UPI ਦੁਆਰਾ ਸੁਰੱਖਿਅਤ';

  @override
  String get paymentSuccessful => 'ਭੁਗਤਾਨ ਸਫ਼ਲ!';

  @override
  String get paymentFailed => 'ਭੁਗਤਾਨ ਅਸਫ਼ਲ';

  @override
  String get retryPayment => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get enterUpiId => 'UPI ID ਦਰਜ ਕਰੋ';

  @override
  String get addNoteOptional => 'ਨੋਟ ਜੋੜੋ (ਵਿਕਲਪਿਕ)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount ਭੁਗਤਾਨ ਕਰੋ';
  }

  @override
  String get done => 'ਹੋ ਗਿਆ';

  @override
  String get paymentSomethingWentWrong => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ। ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String upiAppComingSoon(String app) {
    return '$app ਜਲਦੀ ਆ ਰਿਹਾ ਹੈ';
  }

  @override
  String get pleaseEnterUpiId => 'UPI ID ਦਰਜ ਕਰੋ';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $name ਨੂੰ ਭੁਗਤਾਨ ਹੋਇਆ';
  }

  @override
  String get orDivider => 'ਜਾਂ';

  @override
  String get addNewCustomer => 'ਨਵਾਂ ਗਾਹਕ ਜੋੜੋ';

  @override
  String get customerName => 'ਗਾਹਕ ਦਾ ਨਾਮ';

  @override
  String get mobileNo => 'ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get addCustomer => 'ਗਾਹਕ ਜੋੜੋ';

  @override
  String get paymentConfirmed => 'ਭੁਗਤਾਨ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get addAdvance => 'ਅਗਾਊਂ ਜੋੜੋ';

  @override
  String get addAdvanceTitle => 'ਅਗਾਊਂ ਜੋੜੋ';

  @override
  String get attendanceTitle => 'ਹਾਜ਼ਰੀ';

  @override
  String get salaryTitle => 'ਤਨਖਾਹ ਸਾਰ';

  @override
  String get rate => 'ਦਰ';

  @override
  String get daysPresent => 'ਹਾਜ਼ਰੀ ਦੇ ਦਿਨ';

  @override
  String get earned => 'ਕਮਾਇਆ';

  @override
  String get unpaid => 'ਅਦਾਇਗੀ ਨਹੀਂ';

  @override
  String get advanceTaken => 'ਲਿਆ ਅਗਾਊਂ';

  @override
  String get active => 'ਸਰਗਰਮ';

  @override
  String get inactive => 'ਅਕਿਰਿਆਸ਼ੀਲ';

  @override
  String get joined => 'ਜੁੜੇ';

  @override
  String get noPhone => 'ਫ਼ੋਨ ਨਹੀਂ';

  @override
  String get addNewStaff => 'ਨਵਾਂ ਕਰਮਚਾਰੀ ਜੋੜੋ';

  @override
  String get fullNameLabel => 'ਪੂਰਾ ਨਾਮ';

  @override
  String get phoneNumber => 'ਫ਼ੋਨ ਨੰਬਰ';

  @override
  String get role => 'ਭੂਮਿਕਾ';

  @override
  String get salaryType => 'ਤਨਖਾਹ ਕਿਸਮ';

  @override
  String get dailyWage => 'ਰੋਜ਼ਾਨਾ ਮਜ਼ਦੂਰੀ';

  @override
  String get monthlySalary => 'ਮਾਸਿਕ ਤਨਖਾਹ';

  @override
  String get dailyWageAmount => 'ਰੋਜ਼ਾਨਾ ਮਜ਼ਦੂਰੀ (₹)';

  @override
  String get monthlySalaryAmount => 'ਮਾਸਿਕ ਤਨਖਾਹ (₹)';

  @override
  String get addStaffButton => 'ਕਰਮਚਾਰੀ ਜੋੜੋ';

  @override
  String get noteOptional => 'ਨੋਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get amountRupees => 'ਰਕਮ (₹)';

  @override
  String get cancel => 'ਰੱਦ';

  @override
  String get confirm => 'ਪੁਸ਼ਟੀ';

  @override
  String get tryAgain => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get alignBillInFrame => 'ਬਿੱਲ ਫ਼੍ਰੇਮ ਵਿੱਚ ਰੱਖੋ';

  @override
  String get verifyAndLogin => 'ਤਸਦੀਕ ਕਰੋ ਅਤੇ ਲੌਗਇਨ ਕਰੋ';

  @override
  String get voiceListening => 'ਸੁਣ ਰਿਹਾ ਹਾਂ...';

  @override
  String get voiceThinking => 'ਸੋਚ ਰਿਹਾ ਹਾਂ...';

  @override
  String get voiceDetectedEntry => 'ਮਿਲੀ ਐਂਟਰੀ';

  @override
  String get voiceConfirmEntry => 'ਐਂਟਰੀ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get item => 'ਵਸਤੂ';

  @override
  String get totalOutstandingBalance => 'ਕੁੱਲ ਬਕਾਇਆ ਰਕਮ';

  @override
  String get payAllDues => 'ਸਭ ਬਕਾਇਆ ਚੁਕਾਓ';

  @override
  String get myKhatas => 'ਮੇਰੇ ਖਾਤੇ';

  @override
  String get noVendorsFound => 'ਕੋਈ ਵਿਕ੍ਰੇਤਾ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get verifyBillDetails => 'ਬਿੱਲ ਵੇਰਵਾ ਤਸਦੀਕ ਕਰੋ';

  @override
  String get scannedBillPreview => 'ਸਕੈਨ ਕੀਤਾ ਬਿੱਲ';

  @override
  String get descriptionItemDetails => 'ਵੇਰਵਾ / ਵਸਤੂ ਜਾਣਕਾਰੀ';

  @override
  String get selectCustomer => 'ਗਾਹਕ ਚੁਣੋ';

  @override
  String get searchCustomerHint => 'ਗਾਹਕ ਲੱਭੋ ਜਾਂ ਚੁਣੋ';

  @override
  String get saveToKhata => 'ਖਾਤੇ ਵਿੱਚ ਸੇਵ ਕਰੋ';

  @override
  String get allCustomersReport => 'ਸਭ ਗਾਹਕਾਂ ਦੀ ਰਿਪੋਰਟ';

  @override
  String collectedInMonth(String month) {
    return '$month ਵਿੱਚ ਵਸੂਲੀ';
  }

  @override
  String get notificationSettings => 'ਸੂਚਨਾ ਸੈਟਿੰਗਾਂ';

  @override
  String get securityPin => 'ਸੁਰੱਖਿਆ ਅਤੇ ਪਿੰਨ';

  @override
  String get editProfile => 'ਪ੍ਰੋਫਾਈਲ ਸੰਪਾਦਿਤ ਕਰੋ';

  @override
  String get changePassword => 'ਪਾਸਵਰਡ ਬਦਲੋ';

  @override
  String get termsAndConditions => 'ਨਿਯਮ ਅਤੇ ਸ਼ਰਤਾਂ';

  @override
  String get privacyPolicy => 'ਗੋਪਨੀਯਤਾ ਨੀਤੀ';

  @override
  String get accountSettings => 'ਖਾਤਾ ਸੈਟਿੰਗਾਂ';

  @override
  String get legalInfo => 'ਕਾਨੂੰਨੀ';

  @override
  String get currentPassword => 'ਮੌਜੂਦਾ ਪਾਸਵਰਡ';

  @override
  String get newPassword => 'ਨਵਾਂ ਪਾਸਵਰਡ';

  @override
  String get confirmNewPassword => 'ਨਵਾਂ ਪਾਸਵਰਡ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get passwordsDoNotMatch => 'ਪਾਸਵਰਡ ਮੇਲ ਨਹੀਂ ਖਾਂਦੇ';

  @override
  String get changePasswordButton => 'ਪਾਸਵਰਡ ਬਦਲੋ';

  @override
  String get passwordChangedSuccess => 'ਪਾਸਵਰਡ ਸਫ਼ਲਤਾਪੂਰਵਕ ਬਦਲਿਆ ਗਿਆ';

  @override
  String get loadingContent => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String get failedToLoad => 'ਸਮੱਗਰੀ ਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਫ਼ਲ। ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get bookingActions => 'ਬੁਕਿੰਗ ਕਿਰਿਆਵਾਂ';

  @override
  String get confirmBooking => 'ਬੁਕਿੰਗ ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get markComplete => 'ਪੂਰਾ ਮਾਰਕ ਕਰੋ';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer ਦੀ $date ਨੂੰ $time ਦੀ ਅਪੌਇੰਟਮੈਂਟ ਪੁਸ਼ਟੀ ਕਰਨੀ ਹੈ?';
  }

  @override
  String get bookingUpdated => 'ਬੁਕਿੰਗ ਸਫ਼ਲਤਾਪੂਰਵਕ ਅਪਡੇਟ ਹੋਈ';

  @override
  String get bookingUpdateFailed => 'ਬੁਕਿੰਗ ਅਪਡੇਟ ਕਰਨ ਵਿੱਚ ਅਸਫ਼ਲ';

  @override
  String markAttendanceFor(String date) {
    return 'ਹਾਜ਼ਰੀ ਦਰਜ ਕਰੋ — $date';
  }

  @override
  String get allCustomers => 'ਸਭ ਗਾਹਕ';

  @override
  String get noCustomersYet => 'ਅਜੇ ਕੋਈ ਗਾਹਕ ਨਹੀਂ';

  @override
  String get noCustomersYetSubtitle => 'ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਪਹਿਲਾ ਗਾਹਕ ਜੋੜੋ';

  @override
  String get invalidPhone =>
      '6–9 ਨਾਲ ਸ਼ੁਰੂ ਹੋਣ ਵਾਲਾ 10 ਅੰਕਾਂ ਦਾ ਮਾਨਕ ਮੋਬਾਈਲ ਨੰਬਰ ਦਰਜ ਕਰੋ';

  @override
  String accrueMonthSalary(String amount) {
    return 'ਮਹੀਨੇ ਦੀ ਤਨਖਾਹ ਜੋੜੋ (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'ਮਹੀਨੇ ਦੀ ਤਨਖਾਹ ਜੋੜੋ';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name ਦੇ ਬਕਾਏ ਵਿੱਚ ਇਸ ਮਹੀਨੇ ₹$amount ਜੋੜਨੇ ਹਨ?';
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
