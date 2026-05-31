// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'साथखाता';

  @override
  String get tagline => 'एक खाता, दोनों का';

  @override
  String get onboarding1Title => 'दो तरफा साझा खाता';

  @override
  String get onboarding1Subtitle =>
      'विक्रेता और ग्राहक दोनों के लिए एक ही खाता। दोनों एक ही सच देखते हैं।';

  @override
  String get onboarding2Title => 'वॉइस और बिल OCR';

  @override
  String get onboarding2Subtitle =>
      '12 भाषाओं में तुरंत एंट्री बनाने के लिए बोलें या बिल स्कैन करें।';

  @override
  String get onboarding3Title => 'एक टैप UPI भुगतान';

  @override
  String get onboarding3Subtitle => 'UPI से एक टैप में महीने का बकाया चुकाएं।';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get next => 'अगला';

  @override
  String get skip => 'छोड़ें';

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get chooseRole => 'अपनी भूमिका चुनें';

  @override
  String get vendor => 'विक्रेता';

  @override
  String get customer => 'ग्राहक';

  @override
  String get welcomeToSaathKhata => 'साथखाता में आपका स्वागत है';

  @override
  String get tellUsHowYouUse => 'बताएं आप ऐप का उपयोग कैसे करेंगे';

  @override
  String get vendorRoleTitle => 'मैं एक विक्रेता हूँ';

  @override
  String get vendorRoleSubtitle =>
      'व्यापार का खाता, कर्मचारी प्रबंधित करें और भुगतान लें।';

  @override
  String get customerRoleTitle => 'मैं एक ग्राहक हूँ';

  @override
  String get customerRoleSubtitle =>
      'विक्रेताओं के साथ खाता ट्रैक करें और UPI से भुगतान करें।';

  @override
  String get loginTitle => 'साथखाता में लॉगिन करें';

  @override
  String get enterMobile => 'जारी रखने के लिए जानकारी दर्ज करें';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String get verifyOtp => 'OTP सत्यापित करें';

  @override
  String get verifyAndContinue => 'सत्यापित करें और जारी रखें';

  @override
  String get changePhoneNumber => 'फोन नंबर बदलें';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber पर भेजे गए 6 अंक दर्ज करें';
  }

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get passwordHint => 'पासवर्ड दर्ज करें';

  @override
  String get loginButton => 'लॉगिन करें';

  @override
  String get noAccount => 'खाता नहीं है?';

  @override
  String get signUp => 'साइन अप करें';

  @override
  String get pleaseEnterCredentials => 'ईमेल और पासवर्ड दर्ज करें';

  @override
  String get fillRequiredFields => 'नाम, ईमेल और पासवर्ड भरें';

  @override
  String get passwordMinChars => 'कम से कम 8 अक्षर';

  @override
  String get completeProfile => 'प्रोफ़ाइल पूरी करें';

  @override
  String get enterYourName => 'अपना नाम दर्ज करें';

  @override
  String get egBusinessName => 'e.g. Krishna Dairy';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get enterAddress => 'Enter area or full address';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get businessName => 'व्यवसाय का नाम';

  @override
  String get businessCategory => 'व्यवसाय श्रेणी';

  @override
  String get businessAddress => 'व्यवसाय का पता (वैकल्पिक)';

  @override
  String get upiId => 'UPI आईडी (भुगतान के लिए)';

  @override
  String get vendorDashboard => 'विक्रेता डैशबोर्ड';

  @override
  String get customerDashboard => 'ग्राहक डैशबोर्ड';

  @override
  String get customerMode => 'ग्राहक मोड';

  @override
  String get myVendors => 'मेरे विक्रेता';

  @override
  String get outstanding => 'बकाया';

  @override
  String get collectedToday => 'आज का संग्रह';

  @override
  String get quickActions => 'त्वरित क्रिया';

  @override
  String get scanBill => 'बिल स्कैन करें';

  @override
  String get remindAll => 'सभी को याद दिलाएं';

  @override
  String get addNew => 'नया जोड़ें';

  @override
  String get recentCustomers => 'हाल के ग्राहक';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String customerAddedSnackbar(String name) {
    return '$name जोड़ा गया';
  }

  @override
  String get sharedLedger => 'साझा खाता';

  @override
  String get totalBalance => 'कुल शेष';

  @override
  String get statement => 'स्टेटमेंट';

  @override
  String get giveCredit => 'उधार दें';

  @override
  String get recordPayment => 'भुगतान रिकॉर्ड करें';

  @override
  String get giveCreditSheet => 'उधार दें';

  @override
  String get recordPaymentSheet => 'भुगतान रिकॉर्ड करें';

  @override
  String get filterAll => 'सभी';

  @override
  String get balanceCustomerOwes => 'ग्राहक पर बकाया है';

  @override
  String get balanceYouOwe => 'आप पर बकाया है';

  @override
  String get balanceSettled => 'चुकता';

  @override
  String get ledgerInfoTitle => 'यह खाता कैसे काम करता है';

  @override
  String get statusConfirmed => 'पुष्टि हुई';

  @override
  String get statusConfirmedDesc =>
      'दोनों पक्षों की सहमति। एंट्री लॉक है और बदली नहीं जा सकती।';

  @override
  String get statusPending => 'लंबित';

  @override
  String get statusPendingDesc =>
      'ग्राहक की पुष्टि का इंतज़ार। 72 घंटे में स्वतः पुष्टि।';

  @override
  String get statusDisputed => 'विवादित';

  @override
  String get statusDisputedDesc =>
      'ग्राहक ने विवाद उठाया। विक्रेता की समीक्षा आवश्यक।';

  @override
  String get statusAutoConfirmed => 'स्वतः पुष्टि';

  @override
  String get entryTypeCreditLabel => 'उधार एंट्री';

  @override
  String get entryTypePaymentLabel => 'भुगतान प्राप्त';

  @override
  String get entryDetails => 'एंट्री विवरण';

  @override
  String get entryAmount => 'राशि';

  @override
  String get entryType => 'प्रकार';

  @override
  String get entryTypeCreditGiven => 'उधार (दिया)';

  @override
  String get entryTypePaymentReceived => 'भुगतान (प्राप्त)';

  @override
  String get entryDate => 'तारीख';

  @override
  String get entryDescription => 'विवरण';

  @override
  String get entryQuantity => 'मात्रा';

  @override
  String get entryConfirmedAt => 'पुष्टि तारीख';

  @override
  String get entryDisputeReason => 'विवाद कारण';

  @override
  String entryFor(String name) {
    return '$name के लिए';
  }

  @override
  String get descriptionOptional => 'विवरण (वैकल्पिक)';

  @override
  String get quantityOptional => 'मात्रा (वैकल्पिक)';

  @override
  String get descriptionHint => 'जैसे: 2L दूध, मासिक राशन';

  @override
  String get quantityHint => 'जैसे: 2';

  @override
  String get addCreditEntry => 'उधार एंट्री जोड़ें';

  @override
  String get noLedgerTransactions => 'अभी तक कोई लेनदेन नहीं';

  @override
  String get noLedgerTransactionsSubtitle =>
      'शुरू करने के लिए उधार या भुगतान एंट्री जोड़ें।';

  @override
  String get confirmEntryTitle => 'एंट्री की पुष्टि करें';

  @override
  String confirmEntryMessage(String amount) {
    return 'क्या आप ₹$amount की एंट्री की पुष्टि करना चाहते हैं? यह पूर्ववत नहीं होगा।';
  }

  @override
  String get dispute => 'विवाद';

  @override
  String get raiseDisputeTitle => 'विवाद उठाएं';

  @override
  String get raiseDisputeSubtitle => 'बताएं इस एंट्री में क्या गलत है।';

  @override
  String get raiseDisputeHint => 'जैसे: राशि ₹50 होनी चाहिए, ₹60 नहीं';

  @override
  String get submitDispute => 'विवाद दर्ज करें';

  @override
  String get staffAndLabour => 'स्टाफ और लेबर';

  @override
  String get addStaff => 'स्टाफ जोड़ें';

  @override
  String get presentToday => 'आज उपस्थित';

  @override
  String get unpaidSalary => 'अवैतनिक वेतन';

  @override
  String get paySalary => 'वेतन दें';

  @override
  String get noStaffAdded => 'अभी तक कोई स्टाफ नहीं';

  @override
  String get noStaffAddedSubtitle => 'पहला स्टाफ जोड़ने के लिए नीचे दबाएं।';

  @override
  String get present => 'उपस्थित';

  @override
  String get absent => 'अनुपस्थित';

  @override
  String get halfDay => 'आधा दिन';

  @override
  String get paySalaryTitle => 'वेतन दें';

  @override
  String unpaidLabel(String amount) {
    return 'अवैतनिक: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI लेनदेन आईडी (वैकल्पिक)';

  @override
  String get noDues => 'कोई बकाया नहीं';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount दें';
  }

  @override
  String staffJoined(String date) {
    return '$date को जुड़े';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/दिन';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/माह';
  }

  @override
  String get staffPayButton => 'भुगतान';

  @override
  String get businessReports => 'व्यापार रिपोर्ट';

  @override
  String get revenueTrend => 'राजस्व रुझान';

  @override
  String get collectionSummary => 'संग्रह सारांश';

  @override
  String get totalOutstanding => 'कुल बकाया';

  @override
  String get totalCollected => 'कुल संग्रह';

  @override
  String get topCustomers => 'शीर्ष ग्राहक';

  @override
  String get seeAll => 'सभी देखें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appLanguage => 'ऐप भाषा';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get settingsManagePayments => 'भुगतान खाते प्रबंधित करें';

  @override
  String get settingsManageAlerts => 'अलर्ट और रिमाइंडर सेट करें';

  @override
  String get settingsAppPinFingerprint => 'ऐप पिन और फिंगरप्रिंट';

  @override
  String get settingsFaqsContact => 'सहायता और संपर्क';

  @override
  String settingsVersion(String version) {
    return 'संस्करण $version';
  }

  @override
  String get myUpiIds => 'मेरी UPI आईडी';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get security => 'सुरक्षा';

  @override
  String get helpSupport => 'सहायता';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get markAllRead => 'सभी पढ़ा हुआ मार्क करें';

  @override
  String get noNotificationsTitle => 'अभी तक कोई सूचना नहीं';

  @override
  String get noNotificationsSubtitle =>
      'यहाँ खाता अपडेट, भुगतान अलर्ट और रिमाइंडर दिखेंगे।';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'कल';

  @override
  String minutesAgo(int count) {
    return '$count मिनट पहले';
  }

  @override
  String hoursAgo(int count) {
    return '$count घंटे पहले';
  }

  @override
  String get payments => 'भुगतान';

  @override
  String get transactionHistory => 'लेनदेन इतिहास';

  @override
  String get totalPaid => 'कुल भुगतान';

  @override
  String get pending => 'लंबित';

  @override
  String get quickPay => 'त्वरित भुगतान';

  @override
  String get scanAndPay => 'स्कैन और भुगतान';

  @override
  String get scanUpiDesc => 'विक्रेता को भुगतान के लिए UPI QR स्कैन करें';

  @override
  String get noTransactionsTitle => 'अभी तक कोई लेनदेन नहीं';

  @override
  String get noTransactionsSubtitle => 'आपका भुगतान इतिहास यहाँ दिखेगा।';

  @override
  String get paymentStatusPaid => 'भुगतान हुआ';

  @override
  String get paymentStatusFailed => 'विफल';

  @override
  String get paymentStatusRefunded => 'वापस';

  @override
  String get appointments => 'अपॉइंटमेंट';

  @override
  String get myAppointments => 'मेरे अपॉइंटमेंट';

  @override
  String get upcoming => 'आगामी';

  @override
  String get past => 'पिछले';

  @override
  String get cancelBooking => 'बुकिंग रद्द करें';

  @override
  String get keepBooking => 'रखें';

  @override
  String get noBookingsToday => 'आज कोई बुकिंग नहीं';

  @override
  String get noBookingsTodaySubtitle =>
      'ग्राहक ऐप से अपॉइंटमेंट बुक कर सकते हैं।';

  @override
  String get noAppointmentsTitle => 'अभी तक कोई अपॉइंटमेंट नहीं';

  @override
  String get noAppointmentsSubtitle =>
      'शुरुआत के लिए विक्रेता से अपॉइंटमेंट बुक करें।';

  @override
  String get cancelAppointmentTitle => 'अपॉइंटमेंट रद्द करें?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date को $time बजे का अपॉइंटमेंट रद्द करें?';
  }

  @override
  String get bookingStatusConfirmed => 'पुष्टि हुई';

  @override
  String get bookingStatusPending => 'लंबित';

  @override
  String get bookingStatusCancelled => 'रद्द';

  @override
  String get bookingStatusCompleted => 'पूर्ण';

  @override
  String get bookingStatusDone => 'पूर्ण';

  @override
  String get upiPayment => 'UPI भुगतान';

  @override
  String get amountToPay => 'भुगतान की राशि';

  @override
  String get securedByUpi => 'UPI द्वारा सुरक्षित';

  @override
  String get paymentSuccessful => 'भुगतान सफल!';

  @override
  String get paymentFailed => 'भुगतान विफल';

  @override
  String get retryPayment => 'फिर प्रयास करें';

  @override
  String get enterUpiId => 'UPI आईडी दर्ज करें';

  @override
  String get addNoteOptional => 'नोट जोड़ें (वैकल्पिक)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount भुगतान करें';
  }

  @override
  String get done => 'हो गया';

  @override
  String get paymentSomethingWentWrong => 'कुछ गलत हुआ। फिर से प्रयास करें।';

  @override
  String upiAppComingSoon(String app) {
    return '$app जल्द आ रहा है';
  }

  @override
  String get pleaseEnterUpiId => 'UPI आईडी दर्ज करें';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount, $name को भुगतान हुआ';
  }

  @override
  String get orDivider => 'या';

  @override
  String get addNewCustomer => 'नया ग्राहक जोड़ें';

  @override
  String get customerName => 'ग्राहक का नाम';

  @override
  String get mobileNo => 'मोबाइल नंबर';

  @override
  String get addCustomer => 'ग्राहक जोड़ें';

  @override
  String get paymentConfirmed => 'भुगतान की पुष्टि करें';

  @override
  String get addAdvance => 'अग्रिम जोड़ें';

  @override
  String get addAdvanceTitle => 'अग्रिम जोड़ें';

  @override
  String get attendanceTitle => 'उपस्थिति';

  @override
  String get salaryTitle => 'वेतन सारांश';

  @override
  String get rate => 'दर';

  @override
  String get daysPresent => 'उपस्थित दिन';

  @override
  String get earned => 'अर्जित';

  @override
  String get unpaid => 'अवैतनिक';

  @override
  String get advanceTaken => 'लिया गया अग्रिम';

  @override
  String get active => 'सक्रिय';

  @override
  String get inactive => 'निष्क्रिय';

  @override
  String get joined => 'जुड़े';

  @override
  String get noPhone => 'कोई फ़ोन नहीं';

  @override
  String get addNewStaff => 'नया स्टाफ जोड़ें';

  @override
  String get fullNameLabel => 'पूरा नाम';

  @override
  String get phoneNumber => 'फ़ोन नंबर';

  @override
  String get role => 'भूमिका';

  @override
  String get salaryType => 'वेतन प्रकार';

  @override
  String get dailyWage => 'दैनिक मजदूरी';

  @override
  String get monthlySalary => 'मासिक वेतन';

  @override
  String get dailyWageAmount => 'दैनिक मजदूरी (₹)';

  @override
  String get monthlySalaryAmount => 'मासिक वेतन (₹)';

  @override
  String get addStaffButton => 'स्टाफ जोड़ें';

  @override
  String get noteOptional => 'नोट (वैकल्पिक)';

  @override
  String get amountRupees => 'राशि (₹)';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get tryAgain => 'फिर से प्रयास करें';

  @override
  String get alignBillInFrame => 'बिल को फ्रेम में रखें';

  @override
  String get verifyAndLogin => 'सत्यापित करें और लॉगिन करें';

  @override
  String get voiceListening => 'सुन रहा हूँ...';

  @override
  String get voiceThinking => 'सोच रहा हूँ...';

  @override
  String get voiceDetectedEntry => 'पहचानी गई एंट्री';

  @override
  String get voiceConfirmEntry => 'एंट्री कन्फर्म करें';

  @override
  String get item => 'वस्तु';

  @override
  String get totalOutstandingBalance => 'कुल बकाया राशि';

  @override
  String get payAllDues => 'सभी बकाया भुगतान करें';

  @override
  String get myKhatas => 'मेरे खाते';

  @override
  String get noVendorsFound => 'कोई विक्रेता नहीं मिला';

  @override
  String get verifyBillDetails => 'बिल विवरण सत्यापित करें';

  @override
  String get scannedBillPreview => 'स्कैन किया बिल';

  @override
  String get descriptionItemDetails => 'विवरण / वस्तु की जानकारी';

  @override
  String get selectCustomer => 'ग्राहक चुनें';

  @override
  String get searchCustomerHint => 'ग्राहक खोजें या चुनें';

  @override
  String get saveToKhata => 'खाते में सेव करें';

  @override
  String get allCustomersReport => 'सभी ग्राहक रिपोर्ट';

  @override
  String collectedInMonth(String month) {
    return '$month में संग्रह';
  }

  @override
  String get notificationSettings => 'नोटिफिकेशन सेटिंग';

  @override
  String get securityPin => 'सुरक्षा और पिन';

  @override
  String get bookingActions => 'बुकिंग कार्रवाई';

  @override
  String get confirmBooking => 'बुकिंग कन्फर्म करें';

  @override
  String get markComplete => 'पूरा हुआ';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer की $date को $time बजे अपॉइंटमेंट कन्फर्म करें?';
  }

  @override
  String get bookingUpdated => 'बुकिंग सफलतापूर्वक अपडेट हुई';

  @override
  String get bookingUpdateFailed => 'बुकिंग अपडेट करने में विफल';

  @override
  String markAttendanceFor(String date) {
    return 'उपस्थिति दर्ज करें — $date';
  }

  @override
  String get allCustomers => 'सभी ग्राहक';

  @override
  String get noCustomersYet => 'अभी तक कोई ग्राहक नहीं';

  @override
  String get noCustomersYetSubtitle =>
      'शुरू करने के लिए अपना पहला ग्राहक जोड़ें';

  @override
  String get invalidPhone =>
      '6–9 से शुरू होने वाला 10 अंकों का वैध मोबाइल नंबर दर्ज करें';

  @override
  String accrueMonthSalary(String amount) {
    return 'माह की तनख्वाह जोड़ें (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'माह की तनख्वाह जोड़ें';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name के बकाया में इस महीने ₹$amount जोड़ें?';
  }
}
