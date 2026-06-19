// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'సాథ్‌ఖాతా';

  @override
  String get tagline => 'ఒక ఖాతా, ఇద్దరికీ';

  @override
  String get onboarding1Title => 'రెండు వైపుల భాగస్వామ్య లెడ్జర్';

  @override
  String get onboarding1Subtitle =>
      'వ్యాపారి మరియు కస్టమర్ ఇద్దరికీ ఒకే ఖాతా. ఇద్దరూ ఒకే నిజాన్ని చూస్తారు.';

  @override
  String get onboarding2Title => 'వాయిస్ & బిల్ OCR';

  @override
  String get onboarding2Subtitle =>
      '12 భాషల్లో వెంటనే ఎంట్రీలు చేయడానికి మాట్లాడండి లేదా బిల్లులు స్కాన్ చేయండి.';

  @override
  String get onboarding3Title => 'ఒక్క ట్యాప్‌లో UPI చెల్లింపు';

  @override
  String get onboarding3Subtitle =>
      'UPI ద్వారా ఒక్క ట్యాప్‌లో నెల బకాయిలు తీర్చండి.';

  @override
  String get getStarted => 'ప్రారంభించండి';

  @override
  String get next => 'తదుపరి';

  @override
  String get skip => 'దాటవేయి';

  @override
  String get chooseLanguage => 'మీ భాషను ఎంచుకోండి';

  @override
  String get continueButton => 'కొనసాగించు';

  @override
  String get chooseRole => 'మీ పాత్రను ఎంచుకోండి';

  @override
  String get vendor => 'వ్యాపారి';

  @override
  String get customer => 'కస్టమర్';

  @override
  String get welcomeToSaathKhata => 'సాథ్‌ఖాతాకు స్వాగతం';

  @override
  String get tellUsHowYouUse => 'మీరు యాప్‌ను ఎలా వాడతారో చెప్పండి';

  @override
  String get vendorRoleTitle => 'నేను ఒక వ్యాపారిని';

  @override
  String get vendorRoleSubtitle =>
      'వ్యాపార ఖాతా, ఉద్యోగులను నిర్వహించండి మరియు చెల్లింపులు స్వీకరించండి.';

  @override
  String get customerRoleTitle => 'నేను ఒక కస్టమర్‌ని';

  @override
  String get customerRoleSubtitle =>
      'వ్యాపారులతో ఖాతాను ట్రాక్ చేయండి మరియు UPI ద్వారా చెల్లించండి.';

  @override
  String get loginTitle => 'సాథ్‌ఖాతాలో లాగిన్ అవ్వండి';

  @override
  String get enterMobile => 'కొనసాగించడానికి మీ వివరాలు నమోదు చేయండి';

  @override
  String get mobileNumber => 'మొబైల్ నంబర్';

  @override
  String get sendOtp => 'OTP పంపండి';

  @override
  String get verifyOtp => 'OTP ధృవీకరించండి';

  @override
  String get verifyAndContinue => 'ధృవీకరించి కొనసాగించు';

  @override
  String get changePhoneNumber => 'ఫోన్ నంబర్ మార్చండి';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumberకు పంపిన 6 అంకెల కోడ్ నమోదు చేయండి';
  }

  @override
  String get email => 'ఇమెయిల్';

  @override
  String get password => 'పాస్‌వర్డ్';

  @override
  String get passwordHint => 'పాస్‌వర్డ్ నమోదు చేయండి';

  @override
  String get loginButton => 'లాగిన్';

  @override
  String get noAccount => 'ఖాతా లేదా?';

  @override
  String get signUp => 'నమోదు చేయండి';

  @override
  String get pleaseEnterCredentials => 'ఇమెయిల్ మరియు పాస్‌వర్డ్ నమోదు చేయండి';

  @override
  String get fillRequiredFields => 'పేరు, ఇమెయిల్ మరియు పాస్‌వర్డ్ నింపండి';

  @override
  String get passwordMinChars => 'కనీసం 8 అక్షరాలు';

  @override
  String get completeProfile => 'ప్రొఫైల్ పూర్తి చేయండి';

  @override
  String get enterYourName => 'మీ పేరు నమోదు చేయండి';

  @override
  String get egBusinessName => 'ఉదా. కృష్ణ డెయిరీ';

  @override
  String get selectCategory => 'వర్గాన్ని ఎంచుకోండి';

  @override
  String get enterAddress => 'ప్రాంతం లేదా పూర్తి చిరునామా నమోదు చేయండి';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'పూర్తి పేరు';

  @override
  String get businessName => 'వ్యాపార పేరు';

  @override
  String get businessCategory => 'వ్యాపార వర్గం';

  @override
  String get businessAddress => 'వ్యాపార చిరునామా (ఐచ్ఛికం)';

  @override
  String get upiId => 'UPI ID (చెల్లింపులకు)';

  @override
  String get vendorDashboard => 'వ్యాపారి డాష్‌బోర్డ్';

  @override
  String get customerDashboard => 'కస్టమర్ డాష్‌బోర్డ్';

  @override
  String get customerMode => 'కస్టమర్ మోడ్';

  @override
  String get myVendors => 'నా వ్యాపారులు';

  @override
  String get outstanding => 'బాకీ';

  @override
  String get collectedToday => 'నేడు వసూలు';

  @override
  String get quickActions => 'త్వరిత చర్యలు';

  @override
  String get scanBill => 'బిల్ స్కాన్ చేయండి';

  @override
  String get remindAll => 'అందరికీ గుర్తు చేయండి';

  @override
  String get addNew => 'కొత్తది జోడించు';

  @override
  String get recentCustomers => 'ఇటీవలి కస్టమర్లు';

  @override
  String get viewAll => 'అన్నీ చూడు';

  @override
  String customerAddedSnackbar(String name) {
    return '$name జోడించబడింది';
  }

  @override
  String get sharedLedger => 'భాగస్వామ్య ఖాతా';

  @override
  String get totalBalance => 'మొత్తం బ్యాలెన్స్';

  @override
  String get statement => 'స్టేట్‌మెంట్';

  @override
  String get giveCredit => 'అప్పు ఇవ్వు';

  @override
  String get recordPayment => 'చెల్లింపు నమోదు చేయండి';

  @override
  String get giveCreditSheet => 'అప్పు ఇవ్వు';

  @override
  String get recordPaymentSheet => 'చెల్లింపు నమోదు చేయండి';

  @override
  String get filterAll => 'అన్నీ';

  @override
  String get balanceCustomerOwes => 'కస్టమర్ బాకీ';

  @override
  String get balanceYouOwe => 'మీ బాకీ';

  @override
  String get balanceSettled => 'తీర్చబడింది';

  @override
  String get balanceYouOweVendor => 'మీరు వ్యాపారికి చెల్లించాలి';

  @override
  String get balanceVendorOwesYou => 'వ్యాపారి మీకు చెల్లించాలి';

  @override
  String get ledgerInfoTitle => 'ఈ ఖాతా ఎలా పనిచేస్తుంది';

  @override
  String get statusConfirmed => 'నిర్ధారించబడింది';

  @override
  String get statusConfirmedDesc =>
      'ఇరు పక్షాలూ అంగీకరించారు. ఎంట్రీ లాక్ చేయబడింది మరియు మార్చలేరు.';

  @override
  String get statusPending => 'పెండింగ్';

  @override
  String get statusPendingDesc =>
      'కస్టమర్ నిర్ధారణ కోసం వేచి ఉంది. 72 గంటల్లో స్వయంచాలకంగా నిర్ధారించబడుతుంది.';

  @override
  String get statusDisputed => 'వివాదాస్పదం';

  @override
  String get statusDisputedDesc =>
      'కస్టమర్ వివాదం లేవనెత్తారు. వ్యాపారి సమీక్ష అవసరం.';

  @override
  String get statusAutoConfirmed => 'స్వయంచాలక నిర్ధారణ';

  @override
  String get entryTypeCreditLabel => 'అప్పు ఎంట్రీ';

  @override
  String get entryTypePaymentLabel => 'చెల్లింపు స్వీకరించబడింది';

  @override
  String get entryDetails => 'ఎంట్రీ వివరాలు';

  @override
  String get entryAmount => 'మొత్తం';

  @override
  String get entryType => 'రకం';

  @override
  String get entryTypeCreditGiven => 'అప్పు (ఇచ్చినది)';

  @override
  String get entryTypePaymentReceived => 'చెల్లింపు (స్వీకరించినది)';

  @override
  String get entryDate => 'తేదీ';

  @override
  String get entryDescription => 'వివరణ';

  @override
  String get entryQuantity => 'పరిమాణం';

  @override
  String get entryConfirmedAt => 'నిర్ధారణ తేదీ';

  @override
  String get entryDisputeReason => 'వివాద కారణం';

  @override
  String entryFor(String name) {
    return '$name కోసం';
  }

  @override
  String get descriptionOptional => 'వివరణ (ఐచ్ఛికం)';

  @override
  String get quantityOptional => 'పరిమాణం (ఐచ్ఛికం)';

  @override
  String get descriptionHint => 'ఉదా. 2L పాలు, నెల కిరాణా';

  @override
  String get quantityHint => 'ఉదా. 2';

  @override
  String get addCreditEntry => 'అప్పు ఎంట్రీ జోడించు';

  @override
  String get noLedgerTransactions => 'ఇంకా లావాదేవీలు లేవు';

  @override
  String get noLedgerTransactionsSubtitle =>
      'ప్రారంభించడానికి అప్పు లేదా చెల్లింపు ఎంట్రీ జోడించండి.';

  @override
  String get confirmEntryTitle => 'ఎంట్రీని నిర్ధారించండి';

  @override
  String confirmEntryMessage(String amount) {
    return '₹$amount ఎంట్రీని నిర్ధారించాలా? ఇది తిరిగి మార్చలేరు.';
  }

  @override
  String get dispute => 'వివాదం';

  @override
  String get raiseDisputeTitle => 'వివాదం లేవనెత్తండి';

  @override
  String get raiseDisputeSubtitle => 'ఈ ఎంట్రీలో ఏమి తప్పు ఉందో వివరించండి.';

  @override
  String get raiseDisputeHint => 'ఉదా. మొత్తం ₹50 ఉండాలి, ₹60 కాదు';

  @override
  String get submitDispute => 'వివాదం సమర్పించండి';

  @override
  String get staffAndLabour => 'సిబ్బంది మరియు కార్మికులు';

  @override
  String get addStaff => 'సిబ్బందిని జోడించు';

  @override
  String get presentToday => 'నేడు హాజరు';

  @override
  String get unpaidSalary => 'చెల్లింపు కాని జీతం';

  @override
  String get paySalary => 'జీతం చెల్లించు';

  @override
  String get noStaffAdded => 'ఇంకా సిబ్బంది లేరు';

  @override
  String get noStaffAddedSubtitle =>
      'మొదటి సిబ్బందిని జోడించడానికి దిగువ బటన్ నొక్కండి.';

  @override
  String get present => 'హాజరు';

  @override
  String get absent => 'గైర్హాజరు';

  @override
  String get halfDay => 'అర్థ రోజు';

  @override
  String get paySalaryTitle => 'జీతం చెల్లించు';

  @override
  String unpaidLabel(String amount) {
    return 'చెల్లింపు కానిది: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI లావాదేవీ ID (ఐచ్ఛికం)';

  @override
  String get noDues => 'బాకీలు లేవు';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount చెల్లించు';
  }

  @override
  String staffJoined(String date) {
    return '$dateన చేరారు';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/రోజు';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/నెల';
  }

  @override
  String get staffPayButton => 'చెల్లించు';

  @override
  String get businessReports => 'వ్యాపార నివేదికలు';

  @override
  String get revenueTrend => 'ఆదాయ ధోరణి';

  @override
  String get collectionSummary => 'వసూలు సారాంశం';

  @override
  String get totalOutstanding => 'మొత్తం బాకీ';

  @override
  String get totalCollected => 'మొత్తం వసూలు';

  @override
  String get topCustomers => 'అగ్రశ్రేణి కస్టమర్లు';

  @override
  String get seeAll => 'అన్నీ చూడు';

  @override
  String get settings => 'సెట్టింగ్‌లు';

  @override
  String get appLanguage => 'యాప్ భాష';

  @override
  String get selectLanguage => 'భాష ఎంచుకోండి';

  @override
  String get settingsManagePayments => 'చెల్లింపు ఖాతాలు నిర్వహించండి';

  @override
  String get settingsManageAlerts => 'హెచ్చరికలు మరియు రిమైండర్లు నిర్వహించండి';

  @override
  String get settingsAppPinFingerprint => 'యాప్ పిన్ మరియు వేలిముద్ర';

  @override
  String get settingsFaqsContact => 'సహాయం మరియు సంప్రదింపు';

  @override
  String settingsVersion(String version) {
    return 'వెర్షన్ $version';
  }

  @override
  String get myUpiIds => 'నా UPI IDలు';

  @override
  String get notifications => 'నోటిఫికేషన్లు';

  @override
  String get security => 'భద్రత';

  @override
  String get helpSupport => 'సహాయం';

  @override
  String get logout => 'లాగ్ అవుట్';

  @override
  String get markAllRead => 'అన్నీ చదివినట్లు గుర్తించు';

  @override
  String get noNotificationsTitle => 'ఇంకా నోటిఫికేషన్లు లేవు';

  @override
  String get noNotificationsSubtitle =>
      'ఇక్కడ ఖాతా అప్‌డేట్లు, చెల్లింపు హెచ్చరికలు మరియు రిమైండర్లు కనిపిస్తాయి.';

  @override
  String get today => 'నేడు';

  @override
  String get yesterday => 'నిన్న';

  @override
  String minutesAgo(int count) {
    return '$count నిమిషాల క్రితం';
  }

  @override
  String hoursAgo(int count) {
    return '$count గంటల క్రితం';
  }

  @override
  String get payments => 'చెల్లింపులు';

  @override
  String get transactionHistory => 'లావాదేవీల చరిత్ర';

  @override
  String get totalPaid => 'మొత్తం చెల్లించబడింది';

  @override
  String get pending => 'పెండింగ్';

  @override
  String get quickPay => 'త్వరిత చెల్లింపు';

  @override
  String get scanAndPay => 'స్కాన్ చేసి చెల్లించు';

  @override
  String get scanUpiDesc => 'వ్యాపారికి చెల్లించడానికి UPI QR స్కాన్ చేయండి';

  @override
  String get noTransactionsTitle => 'ఇంకా లావాదేవీలు లేవు';

  @override
  String get noTransactionsSubtitle =>
      'మీ చెల్లింపుల చరిత్ర ఇక్కడ కనిపిస్తుంది.';

  @override
  String get paymentStatusPaid => 'చెల్లించబడింది';

  @override
  String get paymentStatusFailed => 'విఫలమైంది';

  @override
  String get paymentStatusRefunded => 'తిరిగి ఇవ్వబడింది';

  @override
  String get appointments => 'అపాయింట్‌మెంట్లు';

  @override
  String get myAppointments => 'నా అపాయింట్‌మెంట్లు';

  @override
  String get upcoming => 'రాబోయే';

  @override
  String get past => 'గత';

  @override
  String get cancelBooking => 'బుకింగ్ రద్దు చేయండి';

  @override
  String get keepBooking => 'ఉంచు';

  @override
  String get noBookingsToday => 'నేడు బుకింగ్‌లు లేవు';

  @override
  String get noBookingsTodaySubtitle =>
      'కస్టమర్లు యాప్ ద్వారా అపాయింట్‌మెంట్లు బుక్ చేయవచ్చు.';

  @override
  String get noAppointmentsTitle => 'ఇంకా అపాయింట్‌మెంట్లు లేవు';

  @override
  String get noAppointmentsSubtitle =>
      'ప్రారంభించడానికి మీ వ్యాపారితో అపాయింట్‌మెంట్ బుక్ చేయండి.';

  @override
  String get cancelAppointmentTitle => 'అపాయింట్‌మెంట్ రద్దు చేయాలా?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$dateన $timeకి అపాయింట్‌మెంట్ రద్దు చేయాలా?';
  }

  @override
  String get bookingStatusConfirmed => 'నిర్ధారించబడింది';

  @override
  String get bookingStatusPending => 'పెండింగ్';

  @override
  String get bookingStatusCancelled => 'రద్దు చేయబడింది';

  @override
  String get bookingStatusCompleted => 'పూర్తయింది';

  @override
  String get bookingStatusDone => 'పూర్తయింది';

  @override
  String get upiPayment => 'UPI చెల్లింపు';

  @override
  String get amountToPay => 'చెల్లించాల్సిన మొత్తం';

  @override
  String get securedByUpi => 'UPI ద్వారా సురక్షితం';

  @override
  String get paymentSuccessful => 'చెల్లింపు విజయవంతం!';

  @override
  String get paymentFailed => 'చెల్లింపు విఫలమైంది';

  @override
  String get retryPayment => 'మళ్ళీ ప్రయత్నించు';

  @override
  String get enterUpiId => 'UPI ID నమోదు చేయండి';

  @override
  String get addNoteOptional => 'నోట్ జోడించు (ఐచ్ఛికం)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount చెల్లించు';
  }

  @override
  String get done => 'పూర్తయింది';

  @override
  String get paymentSomethingWentWrong =>
      'ఏదో తప్పు జరిగింది. మళ్ళీ ప్రయత్నించండి.';

  @override
  String upiAppComingSoon(String app) {
    return '$app త్వరలో వస్తుంది';
  }

  @override
  String get pleaseEnterUpiId => 'UPI ID నమోదు చేయండి';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $nameకి చెల్లించబడింది';
  }

  @override
  String get orDivider => 'లేదా';

  @override
  String get addNewCustomer => 'కొత్త కస్టమర్‌ని జోడించు';

  @override
  String get customerName => 'కస్టమర్ పేరు';

  @override
  String get mobileNo => 'మొబైల్ నంబర్';

  @override
  String get addCustomer => 'కస్టమర్‌ని జోడించు';

  @override
  String get paymentConfirmed => 'చెల్లింపు నిర్ధారించు';

  @override
  String get addAdvance => 'అడ్వాన్స్ జోడించు';

  @override
  String get addAdvanceTitle => 'అడ్వాన్స్ జోడించు';

  @override
  String get attendanceTitle => 'హాజరు';

  @override
  String get salaryTitle => 'జీతం సారాంశం';

  @override
  String get rate => 'రేటు';

  @override
  String get daysPresent => 'హాజరు రోజులు';

  @override
  String get earned => 'సంపాదించినది';

  @override
  String get unpaid => 'చెల్లింపు కానిది';

  @override
  String get advanceTaken => 'తీసుకున్న అడ్వాన్స్';

  @override
  String get active => 'చురుకుగా';

  @override
  String get inactive => 'నిష్క్రియంగా';

  @override
  String get joined => 'చేరారు';

  @override
  String get noPhone => 'ఫోన్ లేదు';

  @override
  String get addNewStaff => 'కొత్త సిబ్బందిని జోడించు';

  @override
  String get fullNameLabel => 'పూర్తి పేరు';

  @override
  String get phoneNumber => 'ఫోన్ నంబర్';

  @override
  String get role => 'పాత్ర';

  @override
  String get salaryType => 'జీతం రకం';

  @override
  String get dailyWage => 'రోజువారీ కూలి';

  @override
  String get monthlySalary => 'నెలవారీ జీతం';

  @override
  String get dailyWageAmount => 'రోజువారీ కూలి (₹)';

  @override
  String get monthlySalaryAmount => 'నెలవారీ జీతం (₹)';

  @override
  String get addStaffButton => 'సిబ్బందిని జోడించు';

  @override
  String get noteOptional => 'నోట్ (ఐచ్ఛికం)';

  @override
  String get amountRupees => 'మొత్తం (₹)';

  @override
  String get cancel => 'రద్దు';

  @override
  String get confirm => 'నిర్ధారించు';

  @override
  String get tryAgain => 'మళ్ళీ ప్రయత్నించు';

  @override
  String get alignBillInFrame => 'బిల్‌ని ఫ్రేమ్‌లో పెట్టండి';

  @override
  String get verifyAndLogin => 'ధృవీకరించి లాగిన్ అవ్వండి';

  @override
  String get voiceListening => 'వింటున్నాను...';

  @override
  String get voiceThinking => 'ఆలోచిస్తున్నాను...';

  @override
  String get voiceDetectedEntry => 'గుర్తించిన ఎంట్రీ';

  @override
  String get voiceConfirmEntry => 'ఎంట్రీని నిర్ధారించు';

  @override
  String get item => 'వస్తువు';

  @override
  String get totalOutstandingBalance => 'మొత్తం బాకీ మొత్తం';

  @override
  String get payAllDues => 'అన్ని బాకీలు చెల్లించు';

  @override
  String get myKhatas => 'నా ఖాతాలు';

  @override
  String get noVendorsFound => 'వ్యాపారులు కనుగొనబడలేదు';

  @override
  String get verifyBillDetails => 'బిల్ వివరాలను ధృవీకరించండి';

  @override
  String get scannedBillPreview => 'స్కాన్ చేసిన బిల్';

  @override
  String get descriptionItemDetails => 'వివరణ / వస్తు వివరాలు';

  @override
  String get selectCustomer => 'కస్టమర్‌ని ఎంచుకోండి';

  @override
  String get searchCustomerHint => 'కస్టమర్‌ని వెతకండి లేదా ఎంచుకోండి';

  @override
  String get saveToKhata => 'ఖాతాలో సేవ్ చేయండి';

  @override
  String get allCustomersReport => 'అన్ని కస్టమర్ల నివేదిక';

  @override
  String collectedInMonth(String month) {
    return '$monthలో వసూలు';
  }

  @override
  String get notificationSettings => 'నోటిఫికేషన్ సెట్టింగ్‌లు';

  @override
  String get securityPin => 'భద్రత మరియు పిన్';

  @override
  String get editProfile => 'ప్రొఫైల్ సవరించు';

  @override
  String get changePassword => 'పాస్‌వర్డ్ మార్చు';

  @override
  String get termsAndConditions => 'నిబంధనలు మరియు షరతులు';

  @override
  String get privacyPolicy => 'గోప్యతా విధానం';

  @override
  String get accountSettings => 'ఖాతా సెట్టింగ్‌లు';

  @override
  String get legalInfo => 'చట్టపరమైన';

  @override
  String get currentPassword => 'ప్రస్తుత పాస్‌వర్డ్';

  @override
  String get newPassword => 'కొత్త పాస్‌వర్డ్';

  @override
  String get confirmNewPassword => 'కొత్త పాస్‌వర్డ్ నిర్ధారించు';

  @override
  String get passwordsDoNotMatch => 'పాస్‌వర్డ్‌లు సరిపోలడం లేదు';

  @override
  String get changePasswordButton => 'పాస్‌వర్డ్ మార్చు';

  @override
  String get passwordChangedSuccess => 'పాస్‌వర్డ్ విజయవంతంగా మార్చబడింది';

  @override
  String get loadingContent => 'లోడ్ అవుతోంది...';

  @override
  String get failedToLoad =>
      'కంటెంట్ లోడ్ చేయడం విఫలమైంది. మళ్ళీ ప్రయత్నించండి.';

  @override
  String get bookingActions => 'బుకింగ్ చర్యలు';

  @override
  String get confirmBooking => 'బుకింగ్ నిర్ధారించు';

  @override
  String get markComplete => 'పూర్తయిందిగా గుర్తించు';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customerకి $dateన $timeకి అపాయింట్‌మెంట్ నిర్ధారించాలా?';
  }

  @override
  String get bookingUpdated => 'బుకింగ్ విజయవంతంగా అప్‌డేట్ అయింది';

  @override
  String get bookingUpdateFailed => 'బుకింగ్ అప్‌డేట్ చేయడం విఫలమైంది';

  @override
  String markAttendanceFor(String date) {
    return 'హాజరు గుర్తించు — $date';
  }

  @override
  String get allCustomers => 'అందరు కస్టమర్లు';

  @override
  String get noCustomersYet => 'ఇంకా కస్టమర్లు లేరు';

  @override
  String get noCustomersYetSubtitle =>
      'ప్రారంభించడానికి మొదటి కస్టమర్‌ని జోడించండి';

  @override
  String get invalidPhone =>
      '6–9తో ప్రారంభమయ్యే 10 అంకెల చెల్లుబాటు అయ్యే మొబైల్ నంబర్ నమోదు చేయండి';

  @override
  String accrueMonthSalary(String amount) {
    return 'నెల జీతం జోడించు (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'నెల జీతం జోడించు';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$nameకి ఈ నెల ₹$amount బాకీకి జోడించాలా?';
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
