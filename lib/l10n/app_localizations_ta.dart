// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'சாத்கதா';

  @override
  String get tagline => 'ஒரு கணக்கு, இருவருக்கும்';

  @override
  String get onboarding1Title => 'இருதரப்பு பகிரப்பட்ட கணக்கு';

  @override
  String get onboarding1Subtitle =>
      'விற்பனையாளர் மற்றும் வாடிக்கையாளர் இருவருக்கும் ஒரே கணக்கு. இருவரும் ஒரே உண்மையை காண்கிறார்கள்.';

  @override
  String get onboarding2Title => 'குரல் மற்றும் பில் OCR';

  @override
  String get onboarding2Subtitle =>
      '12 மொழிகளில் உடனடியாக உள்ளீடுகளை உருவாக்க பேசுங்கள் அல்லது பில்களை ஸ்கேன் செய்யுங்கள்.';

  @override
  String get onboarding3Title => 'ஒரே தட்டில் UPI கட்டணம்';

  @override
  String get onboarding3Subtitle =>
      'UPI மூலம் ஒரே தட்டில் மாத நிலுவைகளை தீர்க்கவும்.';

  @override
  String get getStarted => 'தொடங்குங்கள்';

  @override
  String get next => 'அடுத்து';

  @override
  String get skip => 'தவிர்க்க';

  @override
  String get chooseLanguage => 'உங்கள் மொழியை தேர்ந்தெடுங்கள்';

  @override
  String get continueButton => 'தொடரவும்';

  @override
  String get chooseRole => 'உங்கள் பாத்திரத்தை தேர்ந்தெடுங்கள்';

  @override
  String get vendor => 'விற்பனையாளர்';

  @override
  String get customer => 'வாடிக்கையாளர்';

  @override
  String get welcomeToSaathKhata => 'சாத்கதாவிற்கு வரவேற்கிறோம்';

  @override
  String get tellUsHowYouUse =>
      'நீங்கள் ஆப்பை எவ்வாறு பயன்படுத்துவீர்கள் என்று சொல்லுங்கள்';

  @override
  String get vendorRoleTitle => 'நான் ஒரு விற்பனையாளர்';

  @override
  String get vendorRoleSubtitle =>
      'வணிகக் கணக்கு, ஊழியர்களை நிர்வகிக்கவும் மற்றும் கட்டணம் பெறவும்.';

  @override
  String get customerRoleTitle => 'நான் ஒரு வாடிக்கையாளர்';

  @override
  String get customerRoleSubtitle =>
      'விற்பனையாளர்களுடன் கணக்கை கண்காணிக்கவும் மற்றும் UPI மூலம் கட்டணம் செலுத்தவும்.';

  @override
  String get loginTitle => 'சாத்கதாவில் உள்நுழைக';

  @override
  String get enterMobile => 'தொடர உங்கள் விவரங்களை உள்ளிடுக';

  @override
  String get mobileNumber => 'மொபைல் எண்';

  @override
  String get sendOtp => 'OTP அனுப்பு';

  @override
  String get verifyOtp => 'OTP சரிபார்க்க';

  @override
  String get verifyAndContinue => 'சரிபார்த்து தொடரவும்';

  @override
  String get changePhoneNumber => 'தொலைபேசி எண்ணை மாற்றவும்';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber க்கு அனுப்பப்பட்ட 6 இலக்க குறியீட்டை உள்ளிடுக';
  }

  @override
  String get email => 'மின்னஞ்சல்';

  @override
  String get password => 'கடவுச்சொல்';

  @override
  String get passwordHint => 'கடவுச்சொல்லை உள்ளிடுக';

  @override
  String get loginButton => 'உள்நுழைக';

  @override
  String get noAccount => 'கணக்கு இல்லையா?';

  @override
  String get signUp => 'பதிவு செய்யவும்';

  @override
  String get pleaseEnterCredentials =>
      'மின்னஞ்சல் மற்றும் கடவுச்சொல்லை உள்ளிடுக';

  @override
  String get fillRequiredFields =>
      'பெயர், மின்னஞ்சல் மற்றும் கடவுச்சொல்லை நிரப்பவும்';

  @override
  String get passwordMinChars => 'குறைந்தது 8 எழுத்துக்கள்';

  @override
  String get completeProfile => 'சுயவிவரத்தை நிறைவு செய்யவும்';

  @override
  String get enterYourName => 'உங்கள் பெயரை உள்ளிடுக';

  @override
  String get egBusinessName => 'எ.கா. கிருஷ்ணா டெய்ரி';

  @override
  String get selectCategory => 'வகையை தேர்ந்தெடுக';

  @override
  String get enterAddress => 'பகுதி அல்லது முழு முகவரியை உள்ளிடுக';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'முழு பெயர்';

  @override
  String get businessName => 'வணிகத்தின் பெயர்';

  @override
  String get businessCategory => 'வணிக வகை';

  @override
  String get businessAddress => 'வணிக முகவரி (விருப்பத்தேர்வு)';

  @override
  String get upiId => 'UPI ஐடி (கட்டணங்களுக்கு)';

  @override
  String get vendorDashboard => 'விற்பனையாளர் டாஷ்போர்டு';

  @override
  String get customerDashboard => 'வாடிக்கையாளர் டாஷ்போர்டு';

  @override
  String get customerMode => 'வாடிக்கையாளர் பயன்முறை';

  @override
  String get myVendors => 'என் விற்பனையாளர்கள்';

  @override
  String get outstanding => 'நிலுவை';

  @override
  String get collectedToday => 'இன்று சேகரிக்கப்பட்டது';

  @override
  String get quickActions => 'விரைவு செயல்கள்';

  @override
  String get scanBill => 'பில் ஸ்கேன் செய்யவும்';

  @override
  String get remindAll => 'அனைவரையும் நினைவூட்டுக';

  @override
  String get addNew => 'புதிதாக சேர்க்கவும்';

  @override
  String get recentCustomers => 'சமீபத்திய வாடிக்கையாளர்கள்';

  @override
  String get viewAll => 'அனைத்தையும் பார்க்க';

  @override
  String customerAddedSnackbar(String name) {
    return '$name சேர்க்கப்பட்டது';
  }

  @override
  String get sharedLedger => 'பகிரப்பட்ட கணக்கு';

  @override
  String get totalBalance => 'மொத்த இருப்பு';

  @override
  String get statement => 'அறிக்கை';

  @override
  String get giveCredit => 'கடன் கொடு';

  @override
  String get recordPayment => 'கட்டணத்தை பதிவு செய்யவும்';

  @override
  String get giveCreditSheet => 'கடன் கொடு';

  @override
  String get recordPaymentSheet => 'கட்டணத்தை பதிவு செய்யவும்';

  @override
  String get filterAll => 'அனைத்தும்';

  @override
  String get balanceCustomerOwes => 'வாடிக்கையாளரின் நிலுவை';

  @override
  String get balanceYouOwe => 'உங்கள் நிலுவை';

  @override
  String get balanceSettled => 'தீர்க்கப்பட்டது';

  @override
  String get balanceYouOweVendor => 'நீங்கள் வணிகருக்கு கடன்பட்டிருக்கிறீர்கள்';

  @override
  String get balanceVendorOwesYou => 'வணிகர் உங்களுக்கு கடன்பட்டிருக்கிறார்';

  @override
  String get ledgerInfoTitle => 'இந்த கணக்கு எவ்வாறு செயல்படுகிறது';

  @override
  String get statusConfirmed => 'உறுதிப்படுத்தப்பட்டது';

  @override
  String get statusConfirmedDesc =>
      'இரு தரப்பும் ஒப்புக்கொண்டனர். உள்ளீடு பூட்டப்பட்டது மற்றும் மாற்ற முடியாது.';

  @override
  String get statusPending => 'நிலுவையில்';

  @override
  String get statusPendingDesc =>
      'வாடிக்கையாளர் உறுதிப்படுத்தலுக்காக காத்திருக்கிறது. 72 மணி நேரத்தில் தானாகவே உறுதிப்படுத்தப்படும்.';

  @override
  String get statusDisputed => 'சர்ச்சையில்';

  @override
  String get statusDisputedDesc =>
      'வாடிக்கையாளர் சர்ச்சை எழுப்பினார். விற்பனையாளர் மதிப்பாய்வு தேவை.';

  @override
  String get statusAutoConfirmed => 'தானியங்கி உறுதிப்படுத்தல்';

  @override
  String get entryTypeCreditLabel => 'கடன் உள்ளீடு';

  @override
  String get entryTypePaymentLabel => 'கட்டணம் பெறப்பட்டது';

  @override
  String get entryDetails => 'உள்ளீட்டு விவரங்கள்';

  @override
  String get entryAmount => 'தொகை';

  @override
  String get entryType => 'வகை';

  @override
  String get entryTypeCreditGiven => 'கடன் (கொடுத்தது)';

  @override
  String get entryTypePaymentReceived => 'கட்டணம் (பெறப்பட்டது)';

  @override
  String get entryDate => 'தேதி';

  @override
  String get entryDescription => 'விவரம்';

  @override
  String get entryQuantity => 'அளவு';

  @override
  String get entryConfirmedAt => 'உறுதிப்படுத்தல் தேதி';

  @override
  String get entryDisputeReason => 'சர்ச்சையின் காரணம்';

  @override
  String entryFor(String name) {
    return '$name க்காக';
  }

  @override
  String get descriptionOptional => 'விவரம் (விருப்பத்தேர்வு)';

  @override
  String get quantityOptional => 'அளவு (விருப்பத்தேர்வு)';

  @override
  String get descriptionHint => 'எ.கா. 2L பால், மாத மளிகை';

  @override
  String get quantityHint => 'எ.கா. 2';

  @override
  String get addCreditEntry => 'கடன் உள்ளீட்டை சேர்க்கவும்';

  @override
  String get noLedgerTransactions => 'இன்னும் பரிவர்த்தனைகள் இல்லை';

  @override
  String get noLedgerTransactionsSubtitle =>
      'தொடங்க கடன் அல்லது கட்டண உள்ளீட்டை சேர்க்கவும்.';

  @override
  String get confirmEntryTitle => 'உள்ளீட்டை உறுதிப்படுத்தவும்';

  @override
  String confirmEntryMessage(String amount) {
    return '₹$amount உள்ளீட்டை உறுதிப்படுத்த விரும்புகிறீர்களா? இதை மாற்ற முடியாது.';
  }

  @override
  String get dispute => 'சர்ச்சை';

  @override
  String get raiseDisputeTitle => 'சர்ச்சையை எழுப்பவும்';

  @override
  String get raiseDisputeSubtitle =>
      'இந்த உள்ளீட்டில் என்ன தவறு என்று விவரிக்கவும்.';

  @override
  String get raiseDisputeHint => 'எ.கா. தொகை ₹50 ஆக இருக்க வேண்டும், ₹60 அல்ல';

  @override
  String get submitDispute => 'சர்ச்சையை சமர்ப்பிக்கவும்';

  @override
  String get staffAndLabour => 'ஊழியர்கள் மற்றும் தொழிலாளர்கள்';

  @override
  String get addStaff => 'ஊழியரை சேர்க்கவும்';

  @override
  String get presentToday => 'இன்று வருகை';

  @override
  String get unpaidSalary => 'செலுத்தப்படாத சம்பளம்';

  @override
  String get paySalary => 'சம்பளம் கொடுக்கவும்';

  @override
  String get noStaffAdded => 'இன்னும் ஊழியர்கள் இல்லை';

  @override
  String get noStaffAddedSubtitle =>
      'முதல் ஊழியரை சேர்க்க கீழே உள்ள பொத்தானை அழுத்துங்கள்.';

  @override
  String get present => 'வருகை';

  @override
  String get absent => 'வருகை இல்லை';

  @override
  String get halfDay => 'அரை நாள்';

  @override
  String get paySalaryTitle => 'சம்பளம் கொடுக்கவும்';

  @override
  String unpaidLabel(String amount) {
    return 'செலுத்தப்படாதது: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional =>
      'UPI பரிவர்த்தனை ஐடி (விருப்பத்தேர்வு)';

  @override
  String get noDues => 'நிலுவைகள் இல்லை';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount கொடுக்கவும்';
  }

  @override
  String staffJoined(String date) {
    return '$date அன்று சேர்ந்தார்';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/நாள்';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/மாதம்';
  }

  @override
  String get staffPayButton => 'கட்டணம்';

  @override
  String get businessReports => 'வணிக அறிக்கைகள்';

  @override
  String get revenueTrend => 'வருவாய் போக்கு';

  @override
  String get collectionSummary => 'சேகரிப்பு சுருக்கம்';

  @override
  String get totalOutstanding => 'மொத்த நிலுவை';

  @override
  String get totalCollected => 'மொத்த சேகரிப்பு';

  @override
  String get topCustomers => 'சிறந்த வாடிக்கையாளர்கள்';

  @override
  String get seeAll => 'அனைத்தையும் பார்க்க';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get appLanguage => 'ஆப் மொழி';

  @override
  String get selectLanguage => 'மொழியை தேர்ந்தெடுக';

  @override
  String get settingsManagePayments => 'கட்டண கணக்குகளை நிர்வகிக்கவும்';

  @override
  String get settingsManageAlerts =>
      'எச்சரிக்கைகள் மற்றும் நினைவூட்டல்களை நிர்வகிக்கவும்';

  @override
  String get settingsAppPinFingerprint => 'ஆப் பின் மற்றும் கைரேகை';

  @override
  String get settingsFaqsContact => 'உதவி மற்றும் தொடர்பு';

  @override
  String settingsVersion(String version) {
    return 'பதிப்பு $version';
  }

  @override
  String get myUpiIds => 'என் UPI ஐடிகள்';

  @override
  String get notifications => 'அறிவிப்புகள்';

  @override
  String get security => 'பாதுகாப்பு';

  @override
  String get helpSupport => 'உதவி';

  @override
  String get logout => 'வெளியேறு';

  @override
  String get markAllRead => 'அனைத்தையும் படித்ததாக குறிக்கவும்';

  @override
  String get noNotificationsTitle => 'இன்னும் அறிவிப்புகள் இல்லை';

  @override
  String get noNotificationsSubtitle =>
      'இங்கே கணக்கு புதுப்பிப்புகள், கட்டண எச்சரிக்கைகள் மற்றும் நினைவூட்டல்கள் தெரியும்.';

  @override
  String get today => 'இன்று';

  @override
  String get yesterday => 'நேற்று';

  @override
  String minutesAgo(int count) {
    return '$count நிமிடங்களுக்கு முன்';
  }

  @override
  String hoursAgo(int count) {
    return '$count மணி நேரத்திற்கு முன்';
  }

  @override
  String get payments => 'கட்டணங்கள்';

  @override
  String get transactionHistory => 'பரிவர்த்தனை வரலாறு';

  @override
  String get totalPaid => 'மொத்தம் செலுத்தப்பட்டது';

  @override
  String get pending => 'நிலுவையில்';

  @override
  String get quickPay => 'விரைவு கட்டணம்';

  @override
  String get scanAndPay => 'ஸ்கேன் செய்து கட்டணம் செலுத்தவும்';

  @override
  String get scanUpiDesc =>
      'விற்பனையாளருக்கு கட்டணம் செலுத்த UPI QR ஸ்கேன் செய்யவும்';

  @override
  String get noTransactionsTitle => 'இன்னும் பரிவர்த்தனைகள் இல்லை';

  @override
  String get noTransactionsSubtitle => 'உங்கள் கட்டண வரலாறு இங்கே தெரியும்.';

  @override
  String get paymentStatusPaid => 'செலுத்தப்பட்டது';

  @override
  String get paymentStatusFailed => 'தோல்வி';

  @override
  String get paymentStatusRefunded => 'திரும்பப்பெறப்பட்டது';

  @override
  String get appointments => 'சந்திப்புகள்';

  @override
  String get myAppointments => 'என் சந்திப்புகள்';

  @override
  String get upcoming => 'வரவிருக்கும்';

  @override
  String get past => 'கடந்த';

  @override
  String get cancelBooking => 'முன்பதிவை ரத்து செய்யவும்';

  @override
  String get keepBooking => 'வைத்திரு';

  @override
  String get noBookingsToday => 'இன்று முன்பதிவுகள் இல்லை';

  @override
  String get noBookingsTodaySubtitle =>
      'வாடிக்கையாளர்கள் ஆப் மூலம் சந்திப்புகளை முன்பதிவு செய்யலாம்.';

  @override
  String get noAppointmentsTitle => 'இன்னும் சந்திப்புகள் இல்லை';

  @override
  String get noAppointmentsSubtitle =>
      'தொடங்க உங்கள் விற்பனையாளருடன் சந்திப்பை முன்பதிவு செய்யவும்.';

  @override
  String get cancelAppointmentTitle => 'சந்திப்பை ரத்து செய்யவதா?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date அன்று $time மணிக்கான சந்திப்பை ரத்து செய்யவதா?';
  }

  @override
  String get bookingStatusConfirmed => 'உறுதிப்படுத்தப்பட்டது';

  @override
  String get bookingStatusPending => 'நிலுவையில்';

  @override
  String get bookingStatusCancelled => 'ரத்து செய்யப்பட்டது';

  @override
  String get bookingStatusCompleted => 'முடிந்தது';

  @override
  String get bookingStatusDone => 'முடிந்தது';

  @override
  String get upiPayment => 'UPI கட்டணம்';

  @override
  String get amountToPay => 'செலுத்த வேண்டிய தொகை';

  @override
  String get securedByUpi => 'UPI மூலம் பாதுகாக்கப்பட்டது';

  @override
  String get paymentSuccessful => 'கட்டணம் வெற்றிகரமாக!';

  @override
  String get paymentFailed => 'கட்டணம் தோல்வியடைந்தது';

  @override
  String get retryPayment => 'மீண்டும் முயற்சிக்கவும்';

  @override
  String get enterUpiId => 'UPI ஐடியை உள்ளிடுக';

  @override
  String get addNoteOptional => 'குறிப்பை சேர்க்கவும் (விருப்பத்தேர்வு)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount செலுத்தவும்';
  }

  @override
  String get done => 'முடிந்தது';

  @override
  String get paymentSomethingWentWrong =>
      'ஏதோ தவறு நடந்தது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String upiAppComingSoon(String app) {
    return '$app விரைவில் வருகிறது';
  }

  @override
  String get pleaseEnterUpiId => 'UPI ஐடியை உள்ளிடுக';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $name க்கு செலுத்தப்பட்டது';
  }

  @override
  String get orDivider => 'அல்லது';

  @override
  String get addNewCustomer => 'புதிய வாடிக்கையாளரை சேர்க்கவும்';

  @override
  String get customerName => 'வாடிக்கையாளர் பெயர்';

  @override
  String get mobileNo => 'மொபைல் எண்';

  @override
  String get addCustomer => 'வாடிக்கையாளரை சேர்க்கவும்';

  @override
  String get paymentConfirmed => 'கட்டணத்தை உறுதிப்படுத்தவும்';

  @override
  String get addAdvance => 'முன்பணம் சேர்க்கவும்';

  @override
  String get addAdvanceTitle => 'முன்பணம் சேர்க்கவும்';

  @override
  String get attendanceTitle => 'வருகை';

  @override
  String get salaryTitle => 'சம்பள சுருக்கம்';

  @override
  String get rate => 'விகிதம்';

  @override
  String get daysPresent => 'வருகை நாட்கள்';

  @override
  String get earned => 'சம்பாதித்தது';

  @override
  String get unpaid => 'செலுத்தப்படாதது';

  @override
  String get advanceTaken => 'எடுக்கப்பட்ட முன்பணம்';

  @override
  String get active => 'செயலில்';

  @override
  String get inactive => 'செயலற்றது';

  @override
  String get joined => 'சேர்ந்தார்';

  @override
  String get noPhone => 'தொலைபேசி இல்லை';

  @override
  String get addNewStaff => 'புதிய ஊழியரை சேர்க்கவும்';

  @override
  String get fullNameLabel => 'முழு பெயர்';

  @override
  String get phoneNumber => 'தொலைபேசி எண்';

  @override
  String get role => 'பாத்திரம்';

  @override
  String get salaryType => 'சம்பள வகை';

  @override
  String get dailyWage => 'தினசரி கூலி';

  @override
  String get monthlySalary => 'மாத சம்பளம்';

  @override
  String get dailyWageAmount => 'தினசரி கூலி (₹)';

  @override
  String get monthlySalaryAmount => 'மாத சம்பளம் (₹)';

  @override
  String get addStaffButton => 'ஊழியரை சேர்க்கவும்';

  @override
  String get noteOptional => 'குறிப்பு (விருப்பத்தேர்வு)';

  @override
  String get amountRupees => 'தொகை (₹)';

  @override
  String get cancel => 'ரத்து செய்';

  @override
  String get confirm => 'உறுதிப்படுத்து';

  @override
  String get tryAgain => 'மீண்டும் முயற்சிக்கவும்';

  @override
  String get alignBillInFrame => 'பில்லை சட்டகத்தில் வைக்கவும்';

  @override
  String get verifyAndLogin => 'சரிபார்த்து உள்நுழைக';

  @override
  String get voiceListening => 'கேட்கிறேன்...';

  @override
  String get voiceThinking => 'யோசிக்கிறேன்...';

  @override
  String get voiceDetectedEntry => 'கண்டறியப்பட்ட உள்ளீடு';

  @override
  String get voiceConfirmEntry => 'உள்ளீட்டை உறுதிப்படுத்தவும்';

  @override
  String get item => 'பொருள்';

  @override
  String get totalOutstandingBalance => 'மொத்த நிலுவை தொகை';

  @override
  String get payAllDues => 'அனைத்து நிலுவைகளையும் செலுத்தவும்';

  @override
  String get myKhatas => 'என் கணக்குகள்';

  @override
  String get noVendorsFound => 'விற்பனையாளர்கள் கிடைக்கவில்லை';

  @override
  String get verifyBillDetails => 'பில் விவரங்களை சரிபார்க்கவும்';

  @override
  String get scannedBillPreview => 'ஸ்கேன் செய்யப்பட்ட பில்';

  @override
  String get descriptionItemDetails => 'விவரம் / பொருள் விவரங்கள்';

  @override
  String get selectCustomer => 'வாடிக்கையாளரை தேர்ந்தெடுக';

  @override
  String get searchCustomerHint =>
      'வாடிக்கையாளரை தேடுங்கள் அல்லது தேர்ந்தெடுங்கள்';

  @override
  String get saveToKhata => 'கணக்கில் சேமிக்கவும்';

  @override
  String get allCustomersReport => 'அனைத்து வாடிக்கையாளர்கள் அறிக்கை';

  @override
  String collectedInMonth(String month) {
    return '$month இல் சேகரிக்கப்பட்டது';
  }

  @override
  String get notificationSettings => 'அறிவிப்பு அமைப்புகள்';

  @override
  String get securityPin => 'பாதுகாப்பு மற்றும் பின்';

  @override
  String get editProfile => 'சுயவிவரத்தை திருத்தவும்';

  @override
  String get changePassword => 'கடவுச்சொல்லை மாற்றவும்';

  @override
  String get termsAndConditions => 'விதிமுறைகள் மற்றும் நிபந்தனைகள்';

  @override
  String get privacyPolicy => 'தனியுரிமைக் கொள்கை';

  @override
  String get accountSettings => 'கணக்கு அமைப்புகள்';

  @override
  String get legalInfo => 'சட்டம்';

  @override
  String get currentPassword => 'தற்போதைய கடவுச்சொல்';

  @override
  String get newPassword => 'புதிய கடவுச்சொல்';

  @override
  String get confirmNewPassword => 'புதிய கடவுச்சொல்லை உறுதிப்படுத்தவும்';

  @override
  String get passwordsDoNotMatch => 'கடவுச்சொற்கள் பொருந்தவில்லை';

  @override
  String get changePasswordButton => 'கடவுச்சொல்லை மாற்றவும்';

  @override
  String get passwordChangedSuccess => 'கடவுச்சொல் வெற்றிகரமாக மாற்றப்பட்டது';

  @override
  String get loadingContent => 'ஏற்றுகிறது...';

  @override
  String get failedToLoad =>
      'உள்ளடக்கத்தை ஏற்ற முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get bookingActions => 'முன்பதிவு செயல்கள்';

  @override
  String get confirmBooking => 'முன்பதிவை உறுதிப்படுத்தவும்';

  @override
  String get markComplete => 'முடிந்ததாக குறிக்கவும்';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer இன் $date அன்று $time மணி சந்திப்பை உறுதிப்படுத்தவதா?';
  }

  @override
  String get bookingUpdated => 'முன்பதிவு வெற்றிகரமாக புதுப்பிக்கப்பட்டது';

  @override
  String get bookingUpdateFailed => 'முன்பதிவை புதுப்பிக்க முடியவில்லை';

  @override
  String markAttendanceFor(String date) {
    return 'வருகையை குறிக்கவும் — $date';
  }

  @override
  String get allCustomers => 'அனைத்து வாடிக்கையாளர்கள்';

  @override
  String get noCustomersYet => 'இன்னும் வாடிக்கையாளர்கள் இல்லை';

  @override
  String get noCustomersYetSubtitle => 'தொடங்க முதல் வாடிக்கையாளரை சேர்க்கவும்';

  @override
  String get invalidPhone =>
      '6–9 இல் தொடங்கும் 10 இலக்க வலிய மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String accrueMonthSalary(String amount) {
    return 'மாத சம்பளத்தை சேர்க்கவும் (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'மாத சம்பளத்தை சேர்க்கவும்';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name இன் நிலுவைக்கு இந்த மாதம் ₹$amount சேர்க்கவதா?';
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

  @override
  String get invalidPhoneNumber =>
      'Enter a valid 10-digit Indian mobile number';

  @override
  String get enterAll6Digits => 'Enter all 6 digits';

  @override
  String get invalidEmailAddress => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get required => 'Required';

  @override
  String get invalidUpiFormat => 'Invalid UPI ID format (e.g. name@upi)';

  @override
  String get upiIdAlreadyAdded => 'This UPI ID is already added';

  @override
  String get verifyButton => 'Verify';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get phonePlaceholder => '98765 43210';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get mobileNumberLabel => 'Mobile Number';

  @override
  String get personalInfo => 'Personal Info';

  @override
  String get businessInfo => 'Business Info';

  @override
  String get enterOtpTitle => 'Enter OTP';

  @override
  String get sentToLabel => 'Sent to';

  @override
  String get noOtpReceived => 'Didn\'t receive it?';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get uploadingPhotoLabel => 'Uploading photo...';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get iAmA => 'I am a';

  @override
  String get dualRoleExplanation =>
      'You\'ll primarily use the Vendor experience. Your Customer account can be accessed separately.';

  @override
  String get profileSavedPhotoFailed =>
      'Profile saved — photo could not be uploaded right now';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully';

  @override
  String get addUpiIdTitle => 'Add UPI ID';

  @override
  String get upiIdHint => 'yourname@upi';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get primaryUpiInfo => 'PRIMARY UPI ID';

  @override
  String get primaryUpiDescription =>
      'The primary ID is shared with customers for payment. Tap the star to switch which one is primary.';

  @override
  String upiIdCounter(int count, int max) {
    return '$count / $max UPI IDs';
  }

  @override
  String get primaryUpiIdTooltip => 'Primary UPI ID';

  @override
  String get setAsPrimaryTooltip => 'Set as primary';

  @override
  String get primaryLabel => 'Primary';

  @override
  String get removeButtonLabel => 'Remove';

  @override
  String get noUpiIdsEmpty => 'No UPI IDs yet';

  @override
  String get upiEmptyDescription =>
      'Add up to 5 UPI IDs. Your primary ID will be shared with customers for payment.';

  @override
  String get changePasswordSubtitle =>
      'Enter your current password and choose a new one.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get goBackButton => 'Go back';

  @override
  String get saveButton => 'Save';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageBengali => 'Bengali';

  @override
  String get languageMarathi => 'Marathi';

  @override
  String get languageTamil => 'Tamil';

  @override
  String get languageTelugu => 'Telugu';

  @override
  String get languageKannada => 'Kannada';

  @override
  String get languageGujarati => 'Gujarati';

  @override
  String get languagePunjabi => 'Punjabi';

  @override
  String get languageMalayalam => 'Malayalam';

  @override
  String get languageBhojpuri => 'Bhojpuri';

  @override
  String get languageMaithili => 'Maithili';

  @override
  String get needPasswordForEmail =>
      'You need a password set on your account to use this.\nSet one from Settings → Change Password.';

  @override
  String get usePhoneInstead => 'Use phone number instead →';

  @override
  String get sessionExpiredVerifyPhoneAgain =>
      'Session expired. Please verify your phone again.';

  @override
  String get upiIdsSavedSuccessfully => 'UPI IDs saved successfully';

  @override
  String get chooseYourLanguageHindi => 'आपकी भाषा चुनें';

  @override
  String get unknownLanguage => 'Unknown';

  @override
  String get businessCategoryMilkDairy => 'Milk / Dairy';

  @override
  String get businessCategoryPressDhobi => 'Press / Dhobi';

  @override
  String get businessCategoryMaidCook => 'Maid / Cook';

  @override
  String get businessCategoryNewspaper => 'Newspaper';

  @override
  String get businessCategoryWaterCan => 'Water Can';

  @override
  String get businessCategoryTiffinFood => 'Tiffin / Food';

  @override
  String get businessCategoryKiranaGrocery => 'Kirana / Grocery';

  @override
  String get businessCategorySalonParlour => 'Salon / Parlour';

  @override
  String get businessCategoryConstructionLabour => 'Construction Labour';

  @override
  String get businessCategoryTransportAuto => 'Transport / Auto';

  @override
  String get businessCategoryOther => 'Other';

  @override
  String get bookAnAppointment => 'Book an Appointment';

  @override
  String get noSlotsAvailable => 'No slots available';

  @override
  String get trySelectingDifferentDate => 'Try selecting a different date';

  @override
  String get availableSlots => 'Available Slots';

  @override
  String get bookingConfirmedToast => 'Booking confirmed!';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get saveProduct => 'Save Product';

  @override
  String get editProductMenuItem => 'Edit product';

  @override
  String get deleteProductMenuItem => 'Delete product';

  @override
  String get noProductsYetDescription =>
      'Define the items you sell — milk, paneer, etc. — once, then use them every day.';

  @override
  String get selectProductToAssignQty =>
      'Select a product above to assign quantities';

  @override
  String get noCustomersLinked => 'No customers linked yet';

  @override
  String get chargeAll => 'Charge All';

  @override
  String chargedSuccessfully(int count) {
    return 'Charged $count customer successfully';
  }

  @override
  String chargedSuccessfullyPlural(int count) {
    return 'Charged $count customers successfully';
  }

  @override
  String chargedPartial(int ok, int fail) {
    return '$ok charged, $fail failed';
  }

  @override
  String bulkSummaryLine(int count, String qty, String unit) {
    return '$count customer  •  $qty $unit';
  }

  @override
  String bulkSummaryLinePlural(int count, String qty, String unit) {
    return '$count customers  •  $qty $unit';
  }

  @override
  String totalAmount(String amount) {
    return '₹$amount total';
  }

  @override
  String appointmentNext(String vendorName, String date, String time) {
    return 'Next: $vendorName · $date at $time';
  }

  @override
  String get outstandingShortLabel => 'outstanding';

  @override
  String payViaUpiAmount(String amount) {
    return 'Pay ₹$amount via UPI';
  }

  @override
  String paymentSummarySkipped(int count, int skipped) {
    return 'Paid $count vendors, skipped $skipped.';
  }

  @override
  String paymentSummarySkippedSingular(int count, int skipped) {
    return 'Paid $count vendor, skipped $skipped.';
  }

  @override
  String paymentSummaryComplete(int count) {
    return 'Paid all $count vendors.';
  }

  @override
  String paymentSummaryCompleteSingular(int count) {
    return 'Paid all $count vendor.';
  }

  @override
  String get tapToAcceptOrDecline => 'Tap to accept or decline';

  @override
  String get helpSupportContactPrefix =>
      'For any assistance, reach out to us at:';

  @override
  String get supportEmail => 'igurus@info.in';

  @override
  String get bookButton => 'Book';

  @override
  String waitingForVendorAcceptance(String name) {
    return 'Waiting for $name to accept your request.';
  }

  @override
  String get vendorWantsToConnectAsCustomer => 'A vendor wants to connect';

  @override
  String get vendorWantsToConnectDesc =>
      'They want to add you as a customer and track your account.';

  @override
  String get someoneWantsToConnect => 'Someone wants to connect';

  @override
  String get someoneWantsToConnectDesc =>
      'They will be added as a customer to your account.';

  @override
  String requestedTimeAgo(String time) {
    return 'Requested $time';
  }

  @override
  String connectedVendorLinked(String name) {
    return 'Connected! $name is now linked to your account.';
  }

  @override
  String requestDeclinedFrom(String name) {
    return 'Request from $name declined.';
  }

  @override
  String connectedCustomerLinked(String name) {
    return 'Connected! $name is now linked to your business.';
  }

  @override
  String get processing => 'Processing…';

  @override
  String get retryButton => 'Retry';

  @override
  String get memberDiscountDescription =>
      'Members on this tier get this discount on their dues.';

  @override
  String get discountValueInvalid => 'Enter a valid amount greater than 0';

  @override
  String get percentageExceedsMax => 'Percentage cannot exceed 100';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String get rename => 'Rename';

  @override
  String get membershipLabel => 'Membership';

  @override
  String get noMembership => 'No membership';

  @override
  String get applyForMembership => 'Apply for membership';

  @override
  String get setMembershipTier => 'Set membership tier';

  @override
  String get chooseTierToRequestFromVendor =>
      'Choose a tier to request from this vendor';

  @override
  String chooseTierFor(String customerName) {
    return 'Choose a tier for $customerName';
  }

  @override
  String get setButton => 'Set';

  @override
  String get changeButton => 'Change';

  @override
  String get applyButton => 'Apply';

  @override
  String get approveButton => 'Approve';

  @override
  String customerRequestedTier(String customerName, String tierName) {
    return '$customerName requested $tierName';
  }

  @override
  String requestedTierAwaiting(String tierName) {
    return 'Requested $tierName — awaiting approval';
  }

  @override
  String get verificationConnecting => 'Connecting to your bank…';

  @override
  String get verificationVerifying => 'Verifying transaction…';

  @override
  String get verificationWaiting => 'Waiting for confirmation…';

  @override
  String get verificationAlmostThere => 'Almost there…';

  @override
  String get verificationDoNotClose => 'Do not close this screen';

  @override
  String verificationElapsed(int seconds) {
    return '${seconds}s  •  Do not close this screen';
  }

  @override
  String txnLabel(String txnId) {
    return 'Txn: $txnId';
  }

  @override
  String paidAmountToRecipient(String amount, String name) {
    return '₹$amount paid to $name';
  }

  @override
  String get verificationTimeoutBody =>
      'We could not confirm your payment within 30 seconds. Your money may NOT have been debited — please check your bank statement before retrying.';

  @override
  String get ifDebitedContactSupport =>
      'If debited, contact support with Txn ID.';

  @override
  String get thisMonthSubtitle => 'This month';

  @override
  String get billedNet => 'Billed (net)';

  @override
  String get exclDisputed => 'excl. disputed';

  @override
  String get receivedLabel => 'Received';

  @override
  String get paymentsAndAdj => 'payments & adj.';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String paymentCount(int count) {
    return '$count payment';
  }

  @override
  String paymentCountPlural(int count) {
    return '$count payments';
  }

  @override
  String customersCount(int count) {
    return '$count customers';
  }

  @override
  String get rankedByOutstanding => 'Ranked by outstanding balance';

  @override
  String collectedThisMonth(String amount) {
    return '₹$amount this month';
  }

  @override
  String collectedThisMonthShort(String amount) {
    return '₹$amount this mo.';
  }

  @override
  String get categoryAll => 'All';

  @override
  String get findVendorsNearYou => 'Find vendors near you';

  @override
  String get searchByNameOrCategory =>
      'Search by name, business name,\nor select a category above.';

  @override
  String noResultsForQuery(String query) {
    return 'No results for \"$query\".\nTry a different name or category.';
  }

  @override
  String get addressLabel => 'Address';

  @override
  String get emailLabel => 'Email';

  @override
  String get upiLabel => 'UPI';

  @override
  String get upiIdLabel => 'UPI ID';

  @override
  String get upiEmailLabel => 'UPI / Email';

  @override
  String get couldNotLoadRetry => 'Could not load — tap to retry';

  @override
  String labelCopied(String label) {
    return '$label copied!';
  }

  @override
  String get upiIdCopied => 'UPI ID copied!';

  @override
  String get requestSentButton => 'Request Sent';

  @override
  String get alreadyConnected => 'Already Connected';

  @override
  String get sendingEllipsis => 'Sending…';

  @override
  String get sendConnectionRequest => 'Send Connection Request';

  @override
  String get copyUpiIdToPay => 'Copy UPI ID to Pay';

  @override
  String requestSentToVendor(String name) {
    return 'Request sent! $name will be notified.';
  }

  @override
  String byOwnerName(String name) {
    return 'by $name';
  }

  @override
  String get logOut => 'Log out';

  @override
  String get confirmLogoutTitle => 'Log out';

  @override
  String get areYouSureLogout => 'Are you sure you want to log out?';

  @override
  String get showQrToCollect =>
      'Show this QR to a customer to collect payment directly to you.';

  @override
  String get uploadQr => 'Upload QR';

  @override
  String get replaceQr => 'Replace';

  @override
  String get qrUploaded => 'QR uploaded';

  @override
  String scanToPayName(String name) {
    return 'Scan to pay $name';
  }

  @override
  String get salarySingle => 'Salary';

  @override
  String get advanceSingle => 'Advance';

  @override
  String get customersTitle => 'Customers';

  @override
  String balanceDue(String balance) {
    return '₹$balance due';
  }

  @override
  String get recordDeliveryTooltip => 'Record delivery';

  @override
  String get viewLedgerTooltip => 'View ledger';

  @override
  String staffRoleSubtitle(String name) {
    return 'Staff · $name';
  }

  @override
  String get recordDelivery => 'Record Delivery';

  @override
  String get recordDeliverySubtitle => 'Add a delivery to a customer\'s ledger';

  @override
  String get collectPayment => 'Collect Payment';

  @override
  String get collectPaymentSubtitle => 'Record cash collected from a customer';

  @override
  String get viewAll2 => 'View all';

  @override
  String get noCustomersStaff => 'No customers yet';

  @override
  String get myVendorsSection => 'My Vendors';

  @override
  String get shopsYouBuyFrom => 'Shops you buy from';

  @override
  String get awaitingAcceptanceTitle => 'Awaiting Acceptance';

  @override
  String get customersHaventConfirmed =>
      'These customers haven\'t confirmed yet';

  @override
  String get pendingBadge => 'Pending';

  @override
  String get notifyCustomersWithDues => 'Notify customers with dues';

  @override
  String get linkANewCustomer => 'Link a new customer';

  @override
  String get dailyCharge => 'Daily Charge';

  @override
  String get dailyChargeSubtitle => 'Set quantities & charge all at once';

  @override
  String get findByPhoneOrEmailHint => 'Find by phone number or email';

  @override
  String get phoneOrEmailLabel => 'Phone or email';

  @override
  String get phoneMobileOrEmail => '10-digit mobile or email address';

  @override
  String get nicknameOptionalLabel => 'Nickname (optional)';

  @override
  String get howYouKnowCustomer => 'How you know this customer';

  @override
  String get requestSentWillBeNotified =>
      'Request sent! They will be notified to confirm.';

  @override
  String get outstandingTitle => 'Outstanding';

  @override
  String customersWithDues(int count) {
    return '$count+ customers with dues';
  }

  @override
  String get dueLabel => 'due';

  @override
  String get collectedTodayTitle => 'Collected Today';

  @override
  String paymentsCountSubtitle(int count) {
    return '$count+ payments';
  }

  @override
  String get noPaymentsYetSubtitle => 'No payments yet';

  @override
  String removeLedgerVendorContent(String name) {
    return 'This will deactivate your link with $name. Both parties will lose access to this shared ledger.';
  }

  @override
  String removeLedgerCustomerContent(String name) {
    return 'This will remove your connection with $name.';
  }

  @override
  String get offlineUpdatesPaused => 'Offline — updates paused';

  @override
  String get exportStatementTitle => 'Export Statement';

  @override
  String get chooseExportDateRange =>
      'Choose the date range to include in the PDF.';

  @override
  String get last7DaysRange => 'Entries from the past 7 days';

  @override
  String get last30DaysRange => 'Entries from the past 30 days';

  @override
  String get last3MonthsRange => 'Entries from the past 3 months';

  @override
  String get completeLedgerHistory => 'Complete ledger history';

  @override
  String appAccessActive(String phone) {
    return 'Active · $phone';
  }

  @override
  String get appAccessDisabled => 'Disabled';

  @override
  String appAccessGranted(String name, String phone) {
    return '$name can now log in with $phone';
  }

  @override
  String appAccessRevoked(String name) {
    return 'App access revoked for $name';
  }

  @override
  String appAccessDescription(String name, String phone) {
    return 'When on, $name logs in with their own number ($phone) and can record deliveries & payments and show their own QR — but cannot change attendance, add customers, or see other staff.';
  }

  @override
  String get paymentHistoryTitle => 'Payment History';

  @override
  String get couldNotLoadPaymentHistory => 'Could not load payment history';

  @override
  String get voicePleaseCheck => 'Please check';

  @override
  String get navHome => 'Home';

  @override
  String get qty => 'Qty';

  @override
  String totalRupees(String amount) {
    return 'Total: ₹$amount';
  }

  @override
  String get selectCustomerFirst => 'Select a customer first';

  @override
  String get enterValidAmount => 'Enter a valid amount';

  @override
  String get addsCredit => 'Adds a credit to the customer\'s ledger';

  @override
  String get recordsCash => 'Records cash collected from the customer';

  @override
  String deliveryRecordedFor(String name) {
    return 'Delivery recorded for $name';
  }

  @override
  String paymentCollectedFrom(String name) {
    return 'Payment collected from $name';
  }
}
