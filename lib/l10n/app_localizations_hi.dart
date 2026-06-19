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
  String get egBusinessName => 'जैसे: कृष्णा डेयरी';

  @override
  String get selectCategory => 'श्रेणी चुनें';

  @override
  String get enterAddress => 'क्षेत्र या पूरा पता दर्ज करें';

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
  String get balanceYouOweVendor => 'आप पर दुकानदार का बकाया है';

  @override
  String get balanceVendorOwesYou => 'दुकानदार पर आपका बकाया है';

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
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

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

  @override
  String get accountInformation => 'खाता जानकारी';

  @override
  String get updateProfileDetails => 'अपना नाम, फ़ोटो और जानकारी अपडेट करें';

  @override
  String get updateAccountPassword => 'अपना खाता पासवर्ड अपडेट करें';

  @override
  String get deleteAccount => 'खाता हटाएं';

  @override
  String get deleteAccountSubtitle => 'खाता और सारा डेटा स्थायी रूप से हटाएं';

  @override
  String get deleteAccountConfirmation => 'खाता हटाएं?';

  @override
  String get deleteAccountConfirmationMessage =>
      'यह आपका खाता और सारा डेटा स्थायी रूप से हटा देगा। यह कार्रवाई पूर्ववत नहीं होगी।';

  @override
  String get deleteAccountStaffWarning =>
      'यह आपका खाता स्थायी रूप से हटा देगा। यह पूर्ववत नहीं होगा।';

  @override
  String get deleteForever => 'हमेशा के लिए हटाएं';

  @override
  String get delete => 'हटाएं';

  @override
  String get readTermsOfService => 'हमारी सेवा शर्तें पढ़ें';

  @override
  String get privacyPolicyDescription => 'हम आपका डेटा कैसे संभालते हैं';

  @override
  String get confirmLogout => 'क्या आप वाकई लॉगआउट करना चाहते हैं?';

  @override
  String get membershipTiers => 'सदस्यता स्तर';

  @override
  String get membershipTiersDescription =>
      'स्तरों का नाम बदलें और सदस्य छूट सेट करें';

  @override
  String get logIn => 'लॉगिन करें';

  @override
  String get enterPhoneNumberToContinue =>
      'जारी रखने के लिए फ़ोन नंबर दर्ज करें';

  @override
  String get otpDemoHint =>
      'OTP केवल डेमो के लिए है · जारी रखने के लिए 123456 दर्ज करें';

  @override
  String get havingTrouble => 'कोई समस्या है?';

  @override
  String get useEmailInstead => 'ईमेल से लॉगिन करें →';

  @override
  String get logInWithEmail => 'ईमेल से लॉगिन करें';

  @override
  String get emailPlaceholder => 'you@example.com';

  @override
  String get enterYourPassword => 'पासवर्ड दर्ज करें';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get chooseFromGallery => 'गैलरी से चुनें';

  @override
  String get removePhoto => 'फ़ोटो हटाएं';

  @override
  String get tapToAddProfilePhoto => 'प्रोफ़ाइल फ़ोटो जोड़ने के लिए टैप करें';

  @override
  String get camera => 'कैमरा';

  @override
  String get gallery => 'गैलरी';

  @override
  String get add => 'जोड़ें';

  @override
  String get addUpiId => 'UPI आईडी जोड़ें';

  @override
  String get save => 'सेव करें';

  @override
  String get close => 'बंद करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get remove => 'हटाएं';

  @override
  String get approve => 'स्वीकृत करें';

  @override
  String get decline => 'अस्वीकार करें';

  @override
  String get none => 'कोई नहीं';

  @override
  String get percent => 'प्रतिशत';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get paymentVerification => 'भुगतान सत्यापन';

  @override
  String get verifyingPayment => 'भुगतान सत्यापित हो रहा है';

  @override
  String get paymentConfirmedExclamation => 'भुगतान की पुष्टि!';

  @override
  String get verificationTimedOut => 'सत्यापन समय समाप्त';

  @override
  String get goBack => 'वापस जाएं';

  @override
  String get payDues => 'बकाया चुकाएं';

  @override
  String get skipForNow => 'अभी छोड़ें';

  @override
  String get allDone => 'सब हो गया!';

  @override
  String get noUpcomingAppointments => 'कोई आगामी अपॉइंटमेंट नहीं';

  @override
  String get myPay => 'मेरा वेतन';

  @override
  String get myPaymentQr => 'मेरा भुगतान QR';

  @override
  String get showMyQr => 'मेरा QR दिखाएं';

  @override
  String get noPaymentsYet => 'अभी तक कोई भुगतान नहीं';

  @override
  String get paymentHistory => 'भुगतान इतिहास';

  @override
  String get paymentHistory6Months => 'भुगतान इतिहास (6 महीने)';

  @override
  String get connectionRequest => 'कनेक्शन अनुरोध';

  @override
  String get vendorWantsToConnect => 'एक विक्रेता जुड़ना चाहता है';

  @override
  String get acceptRequest => 'स्वीकार करें';

  @override
  String get declineRequest => 'अस्वीकार करें';

  @override
  String get messageLabel => 'संदेश';

  @override
  String get sendRequest => 'अनुरोध भेजें';

  @override
  String get requestSentNotification =>
      'अनुरोध भेज दिया! उन्हें सूचित किया जाएगा।';

  @override
  String get awaitingAcceptance => 'स्वीकृति की प्रतीक्षा';

  @override
  String get addAVendor => 'विक्रेता जोड़ें';

  @override
  String get findByPhoneOrEmail => 'फ़ोन नंबर या ईमेल से खोजें';

  @override
  String get phoneOrEmail => 'फ़ोन या ईमेल';

  @override
  String get phoneOrEmailHint => '10 अंक मोबाइल या ईमेल पता';

  @override
  String get nicknameOptional => 'उपनाम (वैकल्पिक)';

  @override
  String get howYouKnowVendor => 'आप इस विक्रेता को कैसे जानते हैं';

  @override
  String get bookingNoteExample => 'जैसे: आज अतिरिक्त दूध चाहिए';

  @override
  String get confirmLocation => 'स्थान की पुष्टि करें';

  @override
  String get moveMapToSelectLocation => 'स्थान चुनने के लिए मैप हिलाएं';

  @override
  String get searchPlaceHint => 'कोई स्थान खोजें…';

  @override
  String get mapAttribution => '© OpenStreetMap contributors';

  @override
  String get searchVendorsHint => 'विक्रेता खोजें…';

  @override
  String get somethingWentWrong => 'कुछ गलत हुआ';

  @override
  String get payViaUpi => 'UPI से भुगतान';

  @override
  String get connectWithVendor => 'जुड़ें';

  @override
  String get requestConnection => 'कनेक्शन अनुरोध';

  @override
  String get addVendor => 'विक्रेता जोड़ें';

  @override
  String get noOutstandingBalances => 'कोई बकाया शेष नहीं';

  @override
  String get allCustomersSettledUp => 'सभी ग्राहकों का हिसाब बराबर है।';

  @override
  String get nothingCollectedToday => 'आज कुछ नहीं उगाया';

  @override
  String get paymentsWillAppearHere => 'आज प्राप्त भुगतान यहाँ दिखेंगे।';

  @override
  String get customerReport => 'ग्राहक रिपोर्ट';

  @override
  String get overview => 'अवलोकन';

  @override
  String get tapToStop => 'रोकने के लिए टैप करें';

  @override
  String get itemName => 'वस्तु का नाम';

  @override
  String get itemNameExample => 'जैसे: दूध';

  @override
  String get unitPrice => 'प्रति इकाई मूल्य ₹';

  @override
  String get deliverTo => 'डिलीवरी करें';

  @override
  String get bulkCharge => 'बल्क चार्ज';

  @override
  String get newProduct => 'नया उत्पाद';

  @override
  String get editProduct => 'उत्पाद संपादित करें';

  @override
  String get newProductService => 'नया उत्पाद / सेवा';

  @override
  String get updateProductDetails => 'नाम, इकाई या मूल्य अपडेट करें';

  @override
  String get defineProduct => 'बताएं आप क्या बेचते हैं और उसकी कीमत';

  @override
  String get productName => 'उत्पाद का नाम';

  @override
  String get productNameExample => 'जैसे: सुबह का दूध';

  @override
  String get unit => 'इकाई';

  @override
  String get unitExample => 'लीटर / किलो / टुकड़ा';

  @override
  String get pricePerUnit => 'प्रति इकाई मूल्य (₹)';

  @override
  String get deleteProduct => 'उत्पाद हटाएं';

  @override
  String get deleteProductConfirmation => 'उत्पाद हटाएं?';

  @override
  String removeProductConfirmation(String name) {
    return '\"$name\" को उत्पाद सूची से हटाएं?';
  }

  @override
  String get noProductsYet => 'अभी तक कोई उत्पाद नहीं';

  @override
  String get addFirstProduct => 'पहला उत्पाद जोड़ें';

  @override
  String get renameTier => 'स्तर का नाम बदलें';

  @override
  String get tierName => 'स्तर का नाम';

  @override
  String tierLevel(int level) {
    return 'स्तर $level';
  }

  @override
  String get memberDiscount => 'सदस्य छूट';

  @override
  String discountFor(String tier) {
    return '$tier के लिए छूट';
  }

  @override
  String get flatAmount => 'फ्लैट ₹';

  @override
  String get discountPercent => 'छूट %';

  @override
  String get discountAmount => 'छूट राशि (₹)';

  @override
  String get percentExample => 'जैसे: 5';

  @override
  String get amountExample => 'जैसे: 50';

  @override
  String get maxDiscountPerDue => 'अधिकतम छूट प्रति बकाया (₹) — वैकल्पिक';

  @override
  String get maxDiscountExample => 'जैसे: 100 (सीमा नहीं चाहिए तो खाली छोड़ें)';

  @override
  String get saveDiscount => 'छूट सेव करें';

  @override
  String get membership => 'सदस्यता';

  @override
  String get setTier => 'सेट करें';

  @override
  String get changeTier => 'बदलें';

  @override
  String get applyMembership => 'लागू करें';

  @override
  String get removeMembership => 'सदस्यता हटाएं';

  @override
  String get removeLedgerConfirmation => 'खाता हटाएं?';

  @override
  String get exportStatement => 'स्टेटमेंट एक्सपोर्ट करें';

  @override
  String get appAccess => 'ऐप एक्सेस';

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
