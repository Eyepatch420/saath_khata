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
}
