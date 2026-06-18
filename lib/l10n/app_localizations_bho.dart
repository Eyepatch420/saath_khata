// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bhojpuri (`bho`).
class AppLocalizationsBho extends AppLocalizations {
  AppLocalizationsBho([String locale = 'bho']) : super(locale);

  @override
  String get appTitle => 'साथखाता';

  @override
  String get tagline => 'एगो खाता, दूनों के';

  @override
  String get onboarding1Title => 'दू तरफा साझा खाता';

  @override
  String get onboarding1Subtitle =>
      'विक्रेता आ ग्राहक दूनों खातिर एके खाता। दूनों एके सच देखेलें।';

  @override
  String get onboarding2Title => 'आवाज आ बिल OCR';

  @override
  String get onboarding2Subtitle =>
      '12 भाषा में तुरंत एंट्री बनावे खातिर बोलीं भा बिल स्कैन करीं।';

  @override
  String get onboarding3Title => 'एक टैप UPI भुगतान';

  @override
  String get onboarding3Subtitle => 'UPI से एक टैप में महीना के बाकी चुका दीं।';

  @override
  String get getStarted => 'शुरू करीं';

  @override
  String get next => 'अगिला';

  @override
  String get skip => 'छोड़ीं';

  @override
  String get chooseLanguage => 'आपन भाषा चुनीं';

  @override
  String get continueButton => 'जारी राखीं';

  @override
  String get chooseRole => 'आपन भूमिका चुनीं';

  @override
  String get vendor => 'विक्रेता';

  @override
  String get customer => 'ग्राहक';

  @override
  String get welcomeToSaathKhata => 'साथखाता में रउआ के स्वागत बा';

  @override
  String get tellUsHowYouUse => 'बताईं रउआ ऐप के इस्तेमाल कइसे करब';

  @override
  String get vendorRoleTitle => 'हम एगो विक्रेता बानी';

  @override
  String get vendorRoleSubtitle =>
      'बेपार के खाता, कर्मचारी संभालीं आ भुगतान लीं।';

  @override
  String get customerRoleTitle => 'हम एगो ग्राहक बानी';

  @override
  String get customerRoleSubtitle =>
      'विक्रेता लोग के साथे खाता देखीं आ UPI से भुगतान करीं।';

  @override
  String get loginTitle => 'साथखाता में लॉगिन करीं';

  @override
  String get enterMobile => 'आगे बढ़े खातिर जानकारी भरीं';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP भेजीं';

  @override
  String get verifyOtp => 'OTP जाँचीं';

  @override
  String get verifyAndContinue => 'जाँचीं आ जारी राखीं';

  @override
  String get changePhoneNumber => 'फोन नंबर बदलीं';

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
  String get loginButton => 'लॉगिन करीं';

  @override
  String get noAccount => 'खाता नइखे?';

  @override
  String get signUp => 'साइन अप करीं';

  @override
  String get pleaseEnterCredentials => 'ईमेल और पासवर्ड दर्ज करें';

  @override
  String get fillRequiredFields => 'नाम, ईमेल और पासवर्ड भरें';

  @override
  String get passwordMinChars => 'कम से कम 8 अक्षर';

  @override
  String get completeProfile => 'प्रोफ़ाइल पूरा करीं';

  @override
  String get enterYourName => 'आपन नाम भरीं';

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
  String get myVendors => 'हमार विक्रेता';

  @override
  String get outstanding => 'बाकी';

  @override
  String get collectedToday => 'आज के वसूली';

  @override
  String get quickActions => 'झटपट काम';

  @override
  String get scanBill => 'बिल स्कैन करीं';

  @override
  String get remindAll => 'सभके याद दिआईं';

  @override
  String get addNew => 'नया जोड़ीं';

  @override
  String get recentCustomers => 'हाल के ग्राहक';

  @override
  String get viewAll => 'सभ देखीं';

  @override
  String customerAddedSnackbar(String name) {
    return '$name जोड़ा गया';
  }

  @override
  String get sharedLedger => 'साझा खाता';

  @override
  String get totalBalance => 'कुल बाकी';

  @override
  String get statement => 'स्टेटमेंट';

  @override
  String get giveCredit => 'उधार दीं';

  @override
  String get recordPayment => 'भुगतान दर्ज करीं';

  @override
  String get giveCreditSheet => 'उधार दीं';

  @override
  String get recordPaymentSheet => 'भुगतान दर्ज करीं';

  @override
  String get filterAll => 'सभ';

  @override
  String get balanceCustomerOwes => 'ग्राहक पर बाकी बा';

  @override
  String get balanceYouOwe => 'रउआ पर बाकी बा';

  @override
  String get balanceSettled => 'चुकता';

  @override
  String get balanceYouOweVendor => 'रउआ व्यापारी के देवे के बा';

  @override
  String get balanceVendorOwesYou => 'व्यापारी रउआ के देवे के बा';

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
  String get addCreditEntry => 'उधार एंट्री जोड़ीं';

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
  String get submitDispute => 'विवाद दर्ज करीं';

  @override
  String get staffAndLabour => 'स्टाफ और लेबर';

  @override
  String get addStaff => 'स्टाफ जोड़ीं';

  @override
  String get presentToday => 'आज उपस्थित';

  @override
  String get unpaidSalary => 'अवैतनिक वेतन';

  @override
  String get paySalary => 'तनख्वाह दीं';

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
  String get seeAll => 'सभ देखीं';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appLanguage => 'ऐप भाषा';

  @override
  String get selectLanguage => 'भाषा चुनीं';

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
  String get markAllRead => 'सभके पढ़ल मार्क करीं';

  @override
  String get noNotificationsTitle => 'अभी तक कोई सूचना नहीं';

  @override
  String get noNotificationsSubtitle =>
      'यहाँ खाता अपडेट, भुगतान अलर्ट और रिमाइंडर दिखेंगे।';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'काल्ह';

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
  String get pending => 'बाकी';

  @override
  String get quickPay => 'झटपट भुगतान';

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
  String get done => 'हो गइल';

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
  String get addNewCustomer => 'नया ग्राहक जोड़ीं';

  @override
  String get customerName => 'ग्राहक के नाम';

  @override
  String get mobileNo => 'मोबाइल नंबर';

  @override
  String get addCustomer => 'ग्राहक जोड़ीं';

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
  String get cancel => 'रद्द करीं';

  @override
  String get confirm => 'पक्का करीं';

  @override
  String get tryAgain => 'फेर से कोसिस करीं';

  @override
  String get alignBillInFrame => 'बिल को फ्रेम में रखें';

  @override
  String get verifyAndLogin => 'सत्यापित करें और लॉगिन करें';

  @override
  String get voiceListening => 'सुनत बानी...';

  @override
  String get voiceThinking => 'सोचत बानी...';

  @override
  String get voiceDetectedEntry => 'पहचानी गई एंट्री';

  @override
  String get voiceConfirmEntry => 'एंट्री पक्का करीं';

  @override
  String get item => 'वस्तु';

  @override
  String get totalOutstandingBalance => 'कुल बकाया राशि';

  @override
  String get payAllDues => 'सभ बाकी चुका दीं';

  @override
  String get myKhatas => 'हमार खाता';

  @override
  String get noVendorsFound => 'कवनो विक्रेता ना मिलल';

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
  String get editProfile => 'प्रोफ़ाइल बदलीं';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get termsAndConditions => 'नियम और शर्तें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get accountSettings => 'खाता सेटिंग';

  @override
  String get legalInfo => 'कानूनी';

  @override
  String get currentPassword => 'वर्तमान पासवर्ड';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get confirmNewPassword => 'नया पासवर्ड दोबारा दर्ज करें';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get changePasswordButton => 'पासवर्ड बदलें';

  @override
  String get passwordChangedSuccess => 'पासवर्ड सफलतापूर्वक बदला गया';

  @override
  String get loadingContent => 'लोड हो रहा है...';

  @override
  String get failedToLoad =>
      'सामग्री लोड करने में विफल। कृपया पुनः प्रयास करें।';

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
  String get allCustomers => 'सभ ग्राहक';

  @override
  String get noCustomersYet => 'अबले कवनो ग्राहक ना';

  @override
  String get noCustomersYetSubtitle => 'शुरू करे खातिर आपन पहिला ग्राहक जोड़ीं';

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
