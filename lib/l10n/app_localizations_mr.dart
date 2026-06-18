// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'साथखाता';

  @override
  String get tagline => 'एक खाता, दोघांचा';

  @override
  String get onboarding1Title => 'दोन बाजूंचे सामायिक खाते';

  @override
  String get onboarding1Subtitle =>
      'विक्रेता आणि ग्राहक दोघांसाठी एकच खाते. दोघेही एकच सत्य पाहतात.';

  @override
  String get onboarding2Title => 'व्हॉईस आणि बिल OCR';

  @override
  String get onboarding2Subtitle =>
      '१२ भाषांमध्ये त्वरित नोंदी करण्यासाठी बोला किंवा बिल स्कॅन करा.';

  @override
  String get onboarding3Title => 'एका टॅपमध्ये UPI पेमेंट';

  @override
  String get onboarding3Subtitle =>
      'UPI द्वारे एका टॅपमध्ये महिन्याचे थकित पेमेंट करा.';

  @override
  String get getStarted => 'सुरुवात करा';

  @override
  String get next => 'पुढे';

  @override
  String get skip => 'वगळा';

  @override
  String get chooseLanguage => 'तुमची भाषा निवडा';

  @override
  String get continueButton => 'पुढे सुरू ठेवा';

  @override
  String get chooseRole => 'तुमची भूमिका निवडा';

  @override
  String get vendor => 'विक्रेता';

  @override
  String get customer => 'ग्राहक';

  @override
  String get welcomeToSaathKhata => 'साथखातामध्ये आपले स्वागत आहे';

  @override
  String get tellUsHowYouUse => 'तुम्ही अॅप कसे वापराल ते सांगा';

  @override
  String get vendorRoleTitle => 'मी एक विक्रेता आहे';

  @override
  String get vendorRoleSubtitle =>
      'व्यवसायाचे खाते, कर्मचारी व्यवस्थापित करा आणि पेमेंट घ्या.';

  @override
  String get customerRoleTitle => 'मी एक ग्राहक आहे';

  @override
  String get customerRoleSubtitle =>
      'विक्रेत्यांसोबत खाते ट्रॅक करा आणि UPI द्वारे पेमेंट करा.';

  @override
  String get loginTitle => 'साथखातामध्ये लॉगिन करा';

  @override
  String get enterMobile => 'पुढे सुरू ठेवण्यासाठी माहिती प्रविष्ट करा';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP पाठवा';

  @override
  String get verifyOtp => 'OTP सत्यापित करा';

  @override
  String get verifyAndContinue => 'सत्यापित करा आणि पुढे सुरू ठेवा';

  @override
  String get changePhoneNumber => 'फोन नंबर बदला';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber वर पाठवलेला ६ अंकी कोड प्रविष्ट करा';
  }

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get passwordHint => 'पासवर्ड प्रविष्ट करा';

  @override
  String get loginButton => 'लॉगिन';

  @override
  String get noAccount => 'खाते नाही?';

  @override
  String get signUp => 'नोंदणी करा';

  @override
  String get pleaseEnterCredentials => 'ईमेल आणि पासवर्ड प्रविष्ट करा';

  @override
  String get fillRequiredFields => 'नाव, ईमेल आणि पासवर्ड भरा';

  @override
  String get passwordMinChars => 'किमान ८ अक्षरे';

  @override
  String get completeProfile => 'प्रोफाइल पूर्ण करा';

  @override
  String get enterYourName => 'तुमचे नाव प्रविष्ट करा';

  @override
  String get egBusinessName => 'उदा. कृष्णा डेअरी';

  @override
  String get selectCategory => 'श्रेणी निवडा';

  @override
  String get enterAddress => 'परिसर किंवा पूर्ण पत्ता प्रविष्ट करा';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'पूर्ण नाव';

  @override
  String get businessName => 'व्यवसायाचे नाव';

  @override
  String get businessCategory => 'व्यवसायाची श्रेणी';

  @override
  String get businessAddress => 'व्यवसायाचा पत्ता (पर्यायी)';

  @override
  String get upiId => 'UPI आयडी (पेमेंटसाठी)';

  @override
  String get vendorDashboard => 'विक्रेता डॅशबोर्ड';

  @override
  String get customerDashboard => 'ग्राहक डॅशबोर्ड';

  @override
  String get customerMode => 'ग्राहक मोड';

  @override
  String get myVendors => 'माझे विक्रेते';

  @override
  String get outstanding => 'थकबाकी';

  @override
  String get collectedToday => 'आजचे संकलन';

  @override
  String get quickActions => 'जलद क्रिया';

  @override
  String get scanBill => 'बिल स्कॅन करा';

  @override
  String get remindAll => 'सर्वांना आठवण द्या';

  @override
  String get addNew => 'नवीन जोडा';

  @override
  String get recentCustomers => 'अलीकडील ग्राहक';

  @override
  String get viewAll => 'सर्व पहा';

  @override
  String customerAddedSnackbar(String name) {
    return '$name जोडला';
  }

  @override
  String get sharedLedger => 'सामायिक खाते';

  @override
  String get totalBalance => 'एकूण शिल्लक';

  @override
  String get statement => 'विवरण';

  @override
  String get giveCredit => 'उधार द्या';

  @override
  String get recordPayment => 'पेमेंट नोंदवा';

  @override
  String get giveCreditSheet => 'उधार द्या';

  @override
  String get recordPaymentSheet => 'पेमेंट नोंदवा';

  @override
  String get filterAll => 'सर्व';

  @override
  String get balanceCustomerOwes => 'ग्राहकाची थकबाकी';

  @override
  String get balanceYouOwe => 'तुमची थकबाकी';

  @override
  String get balanceSettled => 'निकाल झाला';

  @override
  String get balanceYouOweVendor => 'तुम्ही दुकानदाराला द्यायचे आहे';

  @override
  String get balanceVendorOwesYou => 'दुकानदार तुम्हाला देणे आहे';

  @override
  String get ledgerInfoTitle => 'हे खाते कसे काम करते';

  @override
  String get statusConfirmed => 'पुष्टी झाली';

  @override
  String get statusConfirmedDesc =>
      'दोन्ही बाजू सहमत. नोंद लॉक आहे आणि बदलता येणार नाही.';

  @override
  String get statusPending => 'प्रलंबित';

  @override
  String get statusPendingDesc =>
      'ग्राहकाच्या पुष्टीची प्रतीक्षा. ७२ तासांत स्वयंचलितपणे पुष्टी.';

  @override
  String get statusDisputed => 'विवादित';

  @override
  String get statusDisputedDesc =>
      'ग्राहकाने विवाद उपस्थित केला. विक्रेत्याची तपासणी आवश्यक.';

  @override
  String get statusAutoConfirmed => 'स्वयं-पुष्टी';

  @override
  String get entryTypeCreditLabel => 'उधार नोंद';

  @override
  String get entryTypePaymentLabel => 'पेमेंट प्राप्त';

  @override
  String get entryDetails => 'नोंदीचा तपशील';

  @override
  String get entryAmount => 'रक्कम';

  @override
  String get entryType => 'प्रकार';

  @override
  String get entryTypeCreditGiven => 'उधार (दिले)';

  @override
  String get entryTypePaymentReceived => 'पेमेंट (प्राप्त)';

  @override
  String get entryDate => 'तारीख';

  @override
  String get entryDescription => 'वर्णन';

  @override
  String get entryQuantity => 'प्रमाण';

  @override
  String get entryConfirmedAt => 'पुष्टी तारीख';

  @override
  String get entryDisputeReason => 'विवादाचे कारण';

  @override
  String entryFor(String name) {
    return '$name साठी';
  }

  @override
  String get descriptionOptional => 'वर्णन (पर्यायी)';

  @override
  String get quantityOptional => 'प्रमाण (पर्यायी)';

  @override
  String get descriptionHint => 'उदा. २L दूध, मासिक किराणा';

  @override
  String get quantityHint => 'उदा. २';

  @override
  String get addCreditEntry => 'उधार नोंद जोडा';

  @override
  String get noLedgerTransactions => 'अद्याप कोणताही व्यवहार नाही';

  @override
  String get noLedgerTransactionsSubtitle =>
      'सुरुवात करण्यासाठी उधार किंवा पेमेंट नोंद जोडा.';

  @override
  String get confirmEntryTitle => 'नोंद पुष्टी करा';

  @override
  String confirmEntryMessage(String amount) {
    return 'तुम्हाला ₹$amount ची नोंद पुष्टी करायची आहे का? हे पूर्ववत होणार नाही.';
  }

  @override
  String get dispute => 'विवाद';

  @override
  String get raiseDisputeTitle => 'विवाद उपस्थित करा';

  @override
  String get raiseDisputeSubtitle => 'या नोंदीत काय चुकीचे आहे ते सांगा.';

  @override
  String get raiseDisputeHint => 'उदा. रक्कम ₹५० असायला हवी होती, ₹६० नाही';

  @override
  String get submitDispute => 'विवाद सादर करा';

  @override
  String get staffAndLabour => 'कर्मचारी आणि मजूर';

  @override
  String get addStaff => 'कर्मचारी जोडा';

  @override
  String get presentToday => 'आज उपस्थित';

  @override
  String get unpaidSalary => 'न दिलेला पगार';

  @override
  String get paySalary => 'पगार द्या';

  @override
  String get noStaffAdded => 'अद्याप कोणताही कर्मचारी नाही';

  @override
  String get noStaffAddedSubtitle =>
      'पहिला कर्मचारी जोडण्यासाठी खालील बटण दाबा.';

  @override
  String get present => 'उपस्थित';

  @override
  String get absent => 'अनुपस्थित';

  @override
  String get halfDay => 'अर्धा दिवस';

  @override
  String get paySalaryTitle => 'पगार द्या';

  @override
  String unpaidLabel(String amount) {
    return 'न दिलेले: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI व्यवहार आयडी (पर्यायी)';

  @override
  String get noDues => 'कोणतीही थकबाकी नाही';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount द्या';
  }

  @override
  String staffJoined(String date) {
    return '$date रोजी रुजू झाले';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/दिवस';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/महिना';
  }

  @override
  String get staffPayButton => 'पेमेंट';

  @override
  String get businessReports => 'व्यवसाय अहवाल';

  @override
  String get revenueTrend => 'महसूल कल';

  @override
  String get collectionSummary => 'संकलनाचा सारांश';

  @override
  String get totalOutstanding => 'एकूण थकबाकी';

  @override
  String get totalCollected => 'एकूण संकलन';

  @override
  String get topCustomers => 'शीर्ष ग्राहक';

  @override
  String get seeAll => 'सर्व पहा';

  @override
  String get settings => 'सेटिंग्ज';

  @override
  String get appLanguage => 'अॅप भाषा';

  @override
  String get selectLanguage => 'भाषा निवडा';

  @override
  String get settingsManagePayments => 'पेमेंट खाती व्यवस्थापित करा';

  @override
  String get settingsManageAlerts => 'सूचना आणि स्मरणपत्रे व्यवस्थापित करा';

  @override
  String get settingsAppPinFingerprint => 'अॅप पिन आणि फिंगरप्रिंट';

  @override
  String get settingsFaqsContact => 'मदत आणि संपर्क';

  @override
  String settingsVersion(String version) {
    return 'आवृत्ती $version';
  }

  @override
  String get myUpiIds => 'माझे UPI आयडी';

  @override
  String get notifications => 'सूचना';

  @override
  String get security => 'सुरक्षा';

  @override
  String get helpSupport => 'मदत';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get markAllRead => 'सर्व वाचले म्हणून चिन्हांकित करा';

  @override
  String get noNotificationsTitle => 'अद्याप कोणत्याही सूचना नाहीत';

  @override
  String get noNotificationsSubtitle =>
      'येथे खाते अपडेट, पेमेंट सूचना आणि स्मरणपत्रे दिसतील.';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'काल';

  @override
  String minutesAgo(int count) {
    return '$count मिनिटांपूर्वी';
  }

  @override
  String hoursAgo(int count) {
    return '$count तासांपूर्वी';
  }

  @override
  String get payments => 'पेमेंट';

  @override
  String get transactionHistory => 'व्यवहार इतिहास';

  @override
  String get totalPaid => 'एकूण भरलेले';

  @override
  String get pending => 'प्रलंबित';

  @override
  String get quickPay => 'जलद पेमेंट';

  @override
  String get scanAndPay => 'स्कॅन करा आणि पेमेंट करा';

  @override
  String get scanUpiDesc => 'विक्रेत्याला पेमेंट करण्यासाठी UPI QR स्कॅन करा';

  @override
  String get noTransactionsTitle => 'अद्याप कोणताही व्यवहार नाही';

  @override
  String get noTransactionsSubtitle => 'तुमचा पेमेंट इतिहास येथे दिसेल.';

  @override
  String get paymentStatusPaid => 'भरले';

  @override
  String get paymentStatusFailed => 'अयशस्वी';

  @override
  String get paymentStatusRefunded => 'परत';

  @override
  String get appointments => 'भेटी';

  @override
  String get myAppointments => 'माझ्या भेटी';

  @override
  String get upcoming => 'येणाऱ्या';

  @override
  String get past => 'मागील';

  @override
  String get cancelBooking => 'बुकिंग रद्द करा';

  @override
  String get keepBooking => 'ठेवा';

  @override
  String get noBookingsToday => 'आज कोणतीही बुकिंग नाही';

  @override
  String get noBookingsTodaySubtitle => 'ग्राहक अॅपद्वारे भेटी बुक करू शकतात.';

  @override
  String get noAppointmentsTitle => 'अद्याप कोणत्याही भेटी नाहीत';

  @override
  String get noAppointmentsSubtitle =>
      'सुरुवात करण्यासाठी तुमच्या विक्रेत्यासोबत भेट बुक करा.';

  @override
  String get cancelAppointmentTitle => 'भेट रद्द करायची?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date रोजी $time वाजता भेट रद्द करायची?';
  }

  @override
  String get bookingStatusConfirmed => 'पुष्टी झाली';

  @override
  String get bookingStatusPending => 'प्रलंबित';

  @override
  String get bookingStatusCancelled => 'रद्द';

  @override
  String get bookingStatusCompleted => 'पूर्ण';

  @override
  String get bookingStatusDone => 'पूर्ण';

  @override
  String get upiPayment => 'UPI पेमेंट';

  @override
  String get amountToPay => 'भरण्याची रक्कम';

  @override
  String get securedByUpi => 'UPI द्वारे सुरक्षित';

  @override
  String get paymentSuccessful => 'पेमेंट यशस्वी!';

  @override
  String get paymentFailed => 'पेमेंट अयशस्वी';

  @override
  String get retryPayment => 'पुन्हा प्रयत्न करा';

  @override
  String get enterUpiId => 'UPI आयडी प्रविष्ट करा';

  @override
  String get addNoteOptional => 'नोट जोडा (पर्यायी)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount भरा';
  }

  @override
  String get done => 'झाले';

  @override
  String get paymentSomethingWentWrong => 'काहीतरी चुकले. पुन्हा प्रयत्न करा.';

  @override
  String upiAppComingSoon(String app) {
    return '$app लवकरच येत आहे';
  }

  @override
  String get pleaseEnterUpiId => 'UPI आयडी प्रविष्ट करा';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $name ला भरले';
  }

  @override
  String get orDivider => 'किंवा';

  @override
  String get addNewCustomer => 'नवीन ग्राहक जोडा';

  @override
  String get customerName => 'ग्राहकाचे नाव';

  @override
  String get mobileNo => 'मोबाइल नंबर';

  @override
  String get addCustomer => 'ग्राहक जोडा';

  @override
  String get paymentConfirmed => 'पेमेंट पुष्टी करा';

  @override
  String get addAdvance => 'आगाऊ जोडा';

  @override
  String get addAdvanceTitle => 'आगाऊ जोडा';

  @override
  String get attendanceTitle => 'उपस्थिती';

  @override
  String get salaryTitle => 'पगाराचा सारांश';

  @override
  String get rate => 'दर';

  @override
  String get daysPresent => 'उपस्थित दिवस';

  @override
  String get earned => 'मिळवलेले';

  @override
  String get unpaid => 'न दिलेले';

  @override
  String get advanceTaken => 'घेतलेले आगाऊ';

  @override
  String get active => 'सक्रिय';

  @override
  String get inactive => 'निष्क्रिय';

  @override
  String get joined => 'रुजू झाले';

  @override
  String get noPhone => 'फोन नाही';

  @override
  String get addNewStaff => 'नवीन कर्मचारी जोडा';

  @override
  String get fullNameLabel => 'पूर्ण नाव';

  @override
  String get phoneNumber => 'फोन नंबर';

  @override
  String get role => 'भूमिका';

  @override
  String get salaryType => 'पगाराचा प्रकार';

  @override
  String get dailyWage => 'दैनिक मजुरी';

  @override
  String get monthlySalary => 'मासिक पगार';

  @override
  String get dailyWageAmount => 'दैनिक मजुरी (₹)';

  @override
  String get monthlySalaryAmount => 'मासिक पगार (₹)';

  @override
  String get addStaffButton => 'कर्मचारी जोडा';

  @override
  String get noteOptional => 'नोट (पर्यायी)';

  @override
  String get amountRupees => 'रक्कम (₹)';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get confirm => 'पुष्टी करा';

  @override
  String get tryAgain => 'पुन्हा प्रयत्न करा';

  @override
  String get alignBillInFrame => 'बिल फ्रेममध्ये ठेवा';

  @override
  String get verifyAndLogin => 'सत्यापित करा आणि लॉगिन करा';

  @override
  String get voiceListening => 'ऐकत आहे...';

  @override
  String get voiceThinking => 'विचार करत आहे...';

  @override
  String get voiceDetectedEntry => 'आढळलेली नोंद';

  @override
  String get voiceConfirmEntry => 'नोंद पुष्टी करा';

  @override
  String get item => 'वस्तू';

  @override
  String get totalOutstandingBalance => 'एकूण थकबाकी रक्कम';

  @override
  String get payAllDues => 'सर्व थकबाकी भरा';

  @override
  String get myKhatas => 'माझी खाती';

  @override
  String get noVendorsFound => 'कोणताही विक्रेता आढळला नाही';

  @override
  String get verifyBillDetails => 'बिलाचा तपशील सत्यापित करा';

  @override
  String get scannedBillPreview => 'स्कॅन केलेले बिल';

  @override
  String get descriptionItemDetails => 'वर्णन / वस्तूचा तपशील';

  @override
  String get selectCustomer => 'ग्राहक निवडा';

  @override
  String get searchCustomerHint => 'ग्राहक शोधा किंवा निवडा';

  @override
  String get saveToKhata => 'खात्यात सेव्ह करा';

  @override
  String get allCustomersReport => 'सर्व ग्राहकांचा अहवाल';

  @override
  String collectedInMonth(String month) {
    return '$month मध्ये संकलन';
  }

  @override
  String get notificationSettings => 'सूचना सेटिंग्ज';

  @override
  String get securityPin => 'सुरक्षा आणि पिन';

  @override
  String get editProfile => 'प्रोफाइल संपादित करा';

  @override
  String get changePassword => 'पासवर्ड बदला';

  @override
  String get termsAndConditions => 'अटी आणि शर्ती';

  @override
  String get privacyPolicy => 'गोपनीयता धोरण';

  @override
  String get accountSettings => 'खाते सेटिंग्ज';

  @override
  String get legalInfo => 'कायदेशीर';

  @override
  String get currentPassword => 'सध्याचा पासवर्ड';

  @override
  String get newPassword => 'नवीन पासवर्ड';

  @override
  String get confirmNewPassword => 'नवीन पासवर्ड पुष्टी करा';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड जुळत नाहीत';

  @override
  String get changePasswordButton => 'पासवर्ड बदला';

  @override
  String get passwordChangedSuccess => 'पासवर्ड यशस्वीरीत्या बदलला';

  @override
  String get loadingContent => 'लोड होत आहे...';

  @override
  String get failedToLoad => 'सामग्री लोड करण्यात अयशस्वी. पुन्हा प्रयत्न करा.';

  @override
  String get bookingActions => 'बुकिंग क्रिया';

  @override
  String get confirmBooking => 'बुकिंग पुष्टी करा';

  @override
  String get markComplete => 'पूर्ण चिन्हांकित करा';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer च्या $date रोजी $time वाजता भेट पुष्टी करायची?';
  }

  @override
  String get bookingUpdated => 'बुकिंग यशस्वीरीत्या अपडेट झाली';

  @override
  String get bookingUpdateFailed => 'बुकिंग अपडेट करण्यात अयशस्वी';

  @override
  String markAttendanceFor(String date) {
    return 'उपस्थिती नोंदवा — $date';
  }

  @override
  String get allCustomers => 'सर्व ग्राहक';

  @override
  String get noCustomersYet => 'अद्याप कोणताही ग्राहक नाही';

  @override
  String get noCustomersYetSubtitle => 'सुरुवात करण्यासाठी पहिला ग्राहक जोडा';

  @override
  String get invalidPhone =>
      '6–9 ने सुरू होणारा 10 अंकी वैध मोबाइल नंबर प्रविष्ट करा';

  @override
  String accrueMonthSalary(String amount) {
    return 'महिन्याचा पगार जोडा (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'महिन्याचा पगार जोडा';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name च्या थकबाकीत या महिन्यासाठी ₹$amount जोडायचे?';
  }
}
