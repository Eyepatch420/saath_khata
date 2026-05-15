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
  String get onboarding2Title => 'वॉइस और बिल ओसीआर';

  @override
  String get onboarding2Subtitle =>
      '12 भाषाओं में तुरंत प्रविष्टि बनाने के लिए बोलें या बिल स्कैन करें।';

  @override
  String get onboarding3Title => 'वन-टैप UPI भुगतान';

  @override
  String get onboarding3Subtitle =>
      'UPI के माध्यम से एक टैप में अपने महीने के अंत के बकाया का निपटान करें।';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get next => 'अगला';

  @override
  String get skip => 'छोड़ें';

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get chooseRole => 'अपनी भूमिका चुनें';

  @override
  String get vendor => 'विक्रेता';

  @override
  String get customer => 'ग्राहक';

  @override
  String get welcomeToSaathKhata => 'साथखाता में आपका स्वागत है';

  @override
  String get tellUsHowYouUse => 'हमें बताएं कि आप ऐप का उपयोग कैसे करेंगे';

  @override
  String get vendorRoleTitle => 'मैं एक विक्रेता हूँ';

  @override
  String get vendorRoleSubtitle =>
      'अपने व्यवसाय का बहीखाता, कर्मचारी प्रबंधित करें और भुगतान प्राप्त करें।';

  @override
  String get customerRoleTitle => 'मैं एक ग्राहक हूँ';

  @override
  String get customerRoleSubtitle =>
      'स्थानीय विक्रेताओं के साथ अपना खाता ट्रैक करें और UPI के माध्यम से भुगतान करें।';

  @override
  String get loginTitle => 'साथखाता में लॉगिन करें';

  @override
  String get verifyOtp => 'ओटीपी सत्यापित करें';

  @override
  String get enterMobile => 'जारी रखने के लिए अपना मोबाइल नंबर दर्ज करें';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'ओटीपी भेजें';

  @override
  String get verifyAndContinue => 'सत्यापित करें और जारी रखें';

  @override
  String get changePhoneNumber => 'फ़ोन नंबर बदलें';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber पर भेजा गया 6-अंकों का कोड दर्ज करें';
  }

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
  String get businessCategory => 'व्यवसाय की श्रेणी';

  @override
  String get businessAddress => 'व्यवसाय का पता (वैकल्पिक)';

  @override
  String get upiId => 'UPI आईडी (भुगतान के लिए)';

  @override
  String get vendorDashboard => 'विक्रेता डैशबोर्ड';

  @override
  String get customerDashboard => 'ग्राहक डैशबोर्ड';

  @override
  String get outstanding => 'बकाया';

  @override
  String get collectedToday => 'आज का संग्रह';

  @override
  String get quickActions => 'त्वरित कार्रवाई';

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
  String get staffAndLabour => 'स्टाफ और लेबर';

  @override
  String get addStaff => 'स्टाफ जोड़ें';

  @override
  String get presentToday => 'आज उपस्थित';

  @override
  String get unpaidSalary => 'अवैतनिक वेतन';

  @override
  String get paySalary => 'वेतन भुगतान करें';

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
  String get appLanguage => 'ऐप की भाषा';

  @override
  String get myUpiIds => 'मेरी UPI आईडी';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get security => 'सुरक्षा';

  @override
  String get helpSupport => 'सहायता और समर्थन';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get markAllRead => 'सभी पढ़ा हुआ मार्क करें';

  @override
  String get noNotificationsTitle => 'अभी तक कोई सूचना नहीं';

  @override
  String get noNotificationsSubtitle =>
      'यहाँ बहीखाता अपडेट, भुगतान अलर्ट और रिमाइंडर दिखेंगे।';

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
  String get noTransactionsTitle => 'अभी तक कोई लेनदेन नहीं';

  @override
  String get noTransactionsSubtitle => 'आपका भुगतान इतिहास यहाँ दिखेगा।';

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
      'ग्राहक ऐप के माध्यम से अपॉइंटमेंट बुक कर सकते हैं।';

  @override
  String get noAppointmentsTitle => 'अभी तक कोई अपॉइंटमेंट नहीं';

  @override
  String get noAppointmentsSubtitle =>
      'शुरू करने के लिए अपने विक्रेता के साथ अपॉइंटमेंट बुक करें।';

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
  String get retryPayment => 'पुनः प्रयास';

  @override
  String get enterUpiId => 'UPI आईडी दर्ज करें';

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
}
