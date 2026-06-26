// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'সাথখাতা';

  @override
  String get tagline => 'এক খাতা, দুজনের';

  @override
  String get onboarding1Title => 'দুই পক্ষের ভাগ করা খাতা';

  @override
  String get onboarding1Subtitle =>
      'বিক্রেতা ও ক্রেতা উভয়ের জন্য একটি খাতা। দুজনেই একই সত্য দেখেন।';

  @override
  String get onboarding2Title => 'ভয়েস ও বিল OCR';

  @override
  String get onboarding2Subtitle =>
      '১২টি ভাষায় তাৎক্ষণিক এন্ট্রি করতে বলুন বা বিল স্ক্যান করুন।';

  @override
  String get onboarding3Title => 'এক ট্যাপে UPI পেমেন্ট';

  @override
  String get onboarding3Subtitle =>
      'UPI দিয়ে এক ট্যাপেই মাসের বকেয়া মিটিয়ে দিন।';

  @override
  String get getStarted => 'শুরু করুন';

  @override
  String get next => 'পরবর্তী';

  @override
  String get skip => 'এড়িয়ে যান';

  @override
  String get chooseLanguage => 'আপনার ভাষা বেছে নিন';

  @override
  String get continueButton => 'চালিয়ে যান';

  @override
  String get chooseRole => 'আপনার ভূমিকা বেছে নিন';

  @override
  String get vendor => 'বিক্রেতা';

  @override
  String get customer => 'ক্রেতা';

  @override
  String get welcomeToSaathKhata => 'সাথখাতায় স্বাগতম';

  @override
  String get tellUsHowYouUse => 'বলুন আপনি অ্যাপটি কীভাবে ব্যবহার করবেন';

  @override
  String get vendorRoleTitle => 'আমি একজন বিক্রেতা';

  @override
  String get vendorRoleSubtitle =>
      'ব্যবসার খাতা, কর্মী পরিচালনা করুন এবং পেমেন্ট নিন।';

  @override
  String get customerRoleTitle => 'আমি একজন ক্রেতা';

  @override
  String get customerRoleSubtitle =>
      'বিক্রেতাদের সাথে খাতা ট্র্যাক করুন এবং UPI দিয়ে পেমেন্ট করুন।';

  @override
  String get loginTitle => 'সাথখাতায় লগইন করুন';

  @override
  String get enterMobile => 'চালিয়ে যেতে তথ্য দিন';

  @override
  String get mobileNumber => 'মোবাইল নম্বর';

  @override
  String get sendOtp => 'OTP পাঠান';

  @override
  String get verifyOtp => 'OTP যাচাই করুন';

  @override
  String get verifyAndContinue => 'যাচাই করে চালিয়ে যান';

  @override
  String get changePhoneNumber => 'ফোন নম্বর পরিবর্তন করুন';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber নম্বরে পাঠানো ৬ সংখ্যার কোড দিন';
  }

  @override
  String get email => 'ইমেইল';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get passwordHint => 'পাসওয়ার্ড দিন';

  @override
  String get loginButton => 'লগইন';

  @override
  String get noAccount => 'অ্যাকাউন্ট নেই?';

  @override
  String get signUp => 'নিবন্ধন করুন';

  @override
  String get pleaseEnterCredentials => 'ইমেইল ও পাসওয়ার্ড দিন';

  @override
  String get fillRequiredFields => 'নাম, ইমেইল ও পাসওয়ার্ড পূরণ করুন';

  @override
  String get passwordMinChars => 'কমপক্ষে ৮ অক্ষর';

  @override
  String get completeProfile => 'প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get enterYourName => 'আপনার নাম দিন';

  @override
  String get egBusinessName => 'যেমন: কৃষ্ণ ডেইরি';

  @override
  String get selectCategory => 'বিভাগ বেছে নিন';

  @override
  String get enterAddress => 'এলাকা বা পূর্ণ ঠিকানা দিন';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'পুরো নাম';

  @override
  String get businessName => 'ব্যবসার নাম';

  @override
  String get businessCategory => 'ব্যবসার বিভাগ';

  @override
  String get businessAddress => 'ব্যবসার ঠিকানা (ঐচ্ছিক)';

  @override
  String get upiId => 'UPI আইডি (পেমেন্টের জন্য)';

  @override
  String get vendorDashboard => 'বিক্রেতা ড্যাশবোর্ড';

  @override
  String get customerDashboard => 'ক্রেতা ড্যাশবোর্ড';

  @override
  String get customerMode => 'ক্রেতা মোড';

  @override
  String get myVendors => 'আমার বিক্রেতা';

  @override
  String get outstanding => 'বকেয়া';

  @override
  String get collectedToday => 'আজকের সংগ্রহ';

  @override
  String get quickActions => 'দ্রুত কাজ';

  @override
  String get scanBill => 'বিল স্ক্যান করুন';

  @override
  String get remindAll => 'সবাইকে মনে করিয়ে দিন';

  @override
  String get addNew => 'নতুন যোগ করুন';

  @override
  String get recentCustomers => 'সাম্প্রতিক ক্রেতা';

  @override
  String get viewAll => 'সব দেখুন';

  @override
  String customerAddedSnackbar(String name) {
    return '$name যোগ হয়েছে';
  }

  @override
  String get sharedLedger => 'ভাগ করা খাতা';

  @override
  String get totalBalance => 'মোট ব্যালেন্স';

  @override
  String get statement => 'বিবৃতি';

  @override
  String get giveCredit => 'বাকি দিন';

  @override
  String get recordPayment => 'পেমেন্ট রেকর্ড করুন';

  @override
  String get giveCreditSheet => 'বাকি দিন';

  @override
  String get recordPaymentSheet => 'পেমেন্ট রেকর্ড করুন';

  @override
  String get filterAll => 'সব';

  @override
  String get balanceCustomerOwes => 'ক্রেতার বকেয়া';

  @override
  String get balanceYouOwe => 'আপনার বকেয়া';

  @override
  String get balanceSettled => 'নিষ্পত্তি হয়েছে';

  @override
  String get balanceYouOweVendor => 'বিক্রেতার বকেয়া আপনার';

  @override
  String get balanceVendorOwesYou => 'বিক্রেতার কাছে আপনার পাওনা';

  @override
  String get ledgerInfoTitle => 'এই খাতা কীভাবে কাজ করে';

  @override
  String get statusConfirmed => 'নিশ্চিত';

  @override
  String get statusConfirmedDesc =>
      'উভয় পক্ষ সম্মত। এন্ট্রি লক এবং পরিবর্তন করা যাবে না।';

  @override
  String get statusPending => 'অপেক্ষমান';

  @override
  String get statusPendingDesc =>
      'ক্রেতার নিশ্চিতের অপেক্ষা। ৭২ ঘণ্টায় স্বয়ংক্রিয় নিশ্চিত।';

  @override
  String get statusDisputed => 'বিতর্কিত';

  @override
  String get statusDisputedDesc =>
      'ক্রেতা আপত্তি জানিয়েছে। বিক্রেতার পর্যালোচনা প্রয়োজন।';

  @override
  String get statusAutoConfirmed => 'স্বয়ংক্রিয় নিশ্চিত';

  @override
  String get entryTypeCreditLabel => 'বাকি এন্ট্রি';

  @override
  String get entryTypePaymentLabel => 'পেমেন্ট প্রাপ্ত';

  @override
  String get entryDetails => 'এন্ট্রির বিবরণ';

  @override
  String get entryAmount => 'পরিমাণ';

  @override
  String get entryType => 'ধরন';

  @override
  String get entryTypeCreditGiven => 'বাকি (দেওয়া)';

  @override
  String get entryTypePaymentReceived => 'পেমেন্ট (প্রাপ্ত)';

  @override
  String get entryDate => 'তারিখ';

  @override
  String get entryDescription => 'বিবরণ';

  @override
  String get entryQuantity => 'পরিমাণ';

  @override
  String get entryConfirmedAt => 'নিশ্চিতের তারিখ';

  @override
  String get entryDisputeReason => 'আপত্তির কারণ';

  @override
  String entryFor(String name) {
    return '$name-এর জন্য';
  }

  @override
  String get descriptionOptional => 'বিবরণ (ঐচ্ছিক)';

  @override
  String get quantityOptional => 'পরিমাণ (ঐচ্ছিক)';

  @override
  String get descriptionHint => 'যেমন: ২L দুধ, মাসিক মুদিখানা';

  @override
  String get quantityHint => 'যেমন: ২';

  @override
  String get addCreditEntry => 'বাকি এন্ট্রি যোগ করুন';

  @override
  String get noLedgerTransactions => 'এখনও কোনো লেনদেন নেই';

  @override
  String get noLedgerTransactionsSubtitle =>
      'শুরু করতে বাকি বা পেমেন্ট এন্ট্রি যোগ করুন।';

  @override
  String get confirmEntryTitle => 'এন্ট্রি নিশ্চিত করুন';

  @override
  String confirmEntryMessage(String amount) {
    return 'আপনি কি ₹$amount-এর এন্ট্রি নিশ্চিত করতে চান? এটি পূর্বাবস্থায় ফেরানো যাবে না।';
  }

  @override
  String get dispute => 'আপত্তি';

  @override
  String get raiseDisputeTitle => 'আপত্তি জানান';

  @override
  String get raiseDisputeSubtitle => 'এই এন্ট্রিতে কী ভুল তা বলুন।';

  @override
  String get raiseDisputeHint => 'যেমন: পরিমাণ ₹৫০ হওয়া উচিত, ₹৬০ নয়';

  @override
  String get submitDispute => 'আপত্তি জমা দিন';

  @override
  String get staffAndLabour => 'কর্মী ও শ্রমিক';

  @override
  String get addStaff => 'কর্মী যোগ করুন';

  @override
  String get presentToday => 'আজ উপস্থিত';

  @override
  String get unpaidSalary => 'অপরিশোধিত বেতন';

  @override
  String get paySalary => 'বেতন দিন';

  @override
  String get noStaffAdded => 'এখনও কোনো কর্মী নেই';

  @override
  String get noStaffAddedSubtitle => 'প্রথম কর্মী যোগ করতে নিচের বোতামে চাপুন।';

  @override
  String get present => 'উপস্থিত';

  @override
  String get absent => 'অনুপস্থিত';

  @override
  String get halfDay => 'অর্ধদিন';

  @override
  String get paySalaryTitle => 'বেতন দিন';

  @override
  String unpaidLabel(String amount) {
    return 'অপরিশোধিত: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI লেনদেন আইডি (ঐচ্ছিক)';

  @override
  String get noDues => 'কোনো বকেয়া নেই';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount দিন';
  }

  @override
  String staffJoined(String date) {
    return '$date-এ যোগ দিয়েছে';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/দিন';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/মাস';
  }

  @override
  String get staffPayButton => 'পেমেন্ট';

  @override
  String get businessReports => 'ব্যবসার রিপোর্ট';

  @override
  String get revenueTrend => 'আয়ের ধারা';

  @override
  String get collectionSummary => 'সংগ্রহের সারাংশ';

  @override
  String get totalOutstanding => 'মোট বকেয়া';

  @override
  String get totalCollected => 'মোট সংগ্রহ';

  @override
  String get topCustomers => 'শীর্ষ ক্রেতা';

  @override
  String get seeAll => 'সব দেখুন';

  @override
  String get settings => 'সেটিংস';

  @override
  String get appLanguage => 'অ্যাপের ভাষা';

  @override
  String get selectLanguage => 'ভাষা বেছে নিন';

  @override
  String get settingsManagePayments => 'পেমেন্ট অ্যাকাউন্ট পরিচালনা করুন';

  @override
  String get settingsManageAlerts => 'অ্যালার্ট ও রিমাইন্ডার পরিচালনা করুন';

  @override
  String get settingsAppPinFingerprint => 'অ্যাপ পিন ও ফিঙ্গারপ্রিন্ট';

  @override
  String get settingsFaqsContact => 'সহায়তা ও যোগাযোগ';

  @override
  String settingsVersion(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get myUpiIds => 'আমার UPI আইডি';

  @override
  String get notifications => 'বিজ্ঞপ্তি';

  @override
  String get security => 'নিরাপত্তা';

  @override
  String get helpSupport => 'সহায়তা';

  @override
  String get logout => 'লগআউট';

  @override
  String get markAllRead => 'সব পড়া হয়েছে চিহ্নিত করুন';

  @override
  String get noNotificationsTitle => 'এখনও কোনো বিজ্ঞপ্তি নেই';

  @override
  String get noNotificationsSubtitle =>
      'এখানে খাতা আপডেট, পেমেন্ট অ্যালার্ট ও রিমাইন্ডার দেখাবে।';

  @override
  String get today => 'আজ';

  @override
  String get yesterday => 'গতকাল';

  @override
  String minutesAgo(int count) {
    return '$count মিনিট আগে';
  }

  @override
  String hoursAgo(int count) {
    return '$count ঘণ্টা আগে';
  }

  @override
  String get payments => 'পেমেন্ট';

  @override
  String get transactionHistory => 'লেনদেনের ইতিহাস';

  @override
  String get totalPaid => 'মোট পরিশোধ';

  @override
  String get pending => 'অপেক্ষমান';

  @override
  String get quickPay => 'দ্রুত পেমেন্ট';

  @override
  String get scanAndPay => 'স্ক্যান করে পেমেন্ট করুন';

  @override
  String get scanUpiDesc => 'বিক্রেতাকে পেমেন্ট করতে UPI QR স্ক্যান করুন';

  @override
  String get noTransactionsTitle => 'এখনও কোনো লেনদেন নেই';

  @override
  String get noTransactionsSubtitle => 'আপনার পেমেন্টের ইতিহাস এখানে দেখাবে।';

  @override
  String get paymentStatusPaid => 'পরিশোধ হয়েছে';

  @override
  String get paymentStatusFailed => 'ব্যর্থ';

  @override
  String get paymentStatusRefunded => 'ফেরত';

  @override
  String get appointments => 'অ্যাপয়েন্টমেন্ট';

  @override
  String get myAppointments => 'আমার অ্যাপয়েন্টমেন্ট';

  @override
  String get upcoming => 'আসন্ন';

  @override
  String get past => 'আগের';

  @override
  String get cancelBooking => 'বুকিং বাতিল করুন';

  @override
  String get keepBooking => 'রাখুন';

  @override
  String get noBookingsToday => 'আজ কোনো বুকিং নেই';

  @override
  String get noBookingsTodaySubtitle =>
      'ক্রেতারা অ্যাপ থেকে অ্যাপয়েন্টমেন্ট বুক করতে পারবেন।';

  @override
  String get noAppointmentsTitle => 'এখনও কোনো অ্যাপয়েন্টমেন্ট নেই';

  @override
  String get noAppointmentsSubtitle =>
      'শুরু করতে আপনার বিক্রেতার সাথে অ্যাপয়েন্টমেন্ট বুক করুন।';

  @override
  String get cancelAppointmentTitle => 'অ্যাপয়েন্টমেন্ট বাতিল করবেন?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date তারিখে $time-এর অ্যাপয়েন্টমেন্ট বাতিল করবেন?';
  }

  @override
  String get bookingStatusConfirmed => 'নিশ্চিত';

  @override
  String get bookingStatusPending => 'অপেক্ষমান';

  @override
  String get bookingStatusCancelled => 'বাতিল';

  @override
  String get bookingStatusCompleted => 'সম্পন্ন';

  @override
  String get bookingStatusDone => 'সম্পন্ন';

  @override
  String get upiPayment => 'UPI পেমেন্ট';

  @override
  String get amountToPay => 'পেমেন্টের পরিমাণ';

  @override
  String get securedByUpi => 'UPI দ্বারা সুরক্ষিত';

  @override
  String get paymentSuccessful => 'পেমেন্ট সফল!';

  @override
  String get paymentFailed => 'পেমেন্ট ব্যর্থ';

  @override
  String get retryPayment => 'আবার চেষ্টা করুন';

  @override
  String get enterUpiId => 'UPI আইডি দিন';

  @override
  String get addNoteOptional => 'নোট যোগ করুন (ঐচ্ছিক)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount পেমেন্ট করুন';
  }

  @override
  String get done => 'সম্পন্ন';

  @override
  String get paymentSomethingWentWrong => 'কিছু ভুল হয়েছে। আবার চেষ্টা করুন।';

  @override
  String upiAppComingSoon(String app) {
    return '$app শীঘ্রই আসছে';
  }

  @override
  String get pleaseEnterUpiId => 'UPI আইডি দিন';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $name-কে পরিশোধ হয়েছে';
  }

  @override
  String get orDivider => 'অথবা';

  @override
  String get addNewCustomer => 'নতুন ক্রেতা যোগ করুন';

  @override
  String get customerName => 'ক্রেতার নাম';

  @override
  String get mobileNo => 'মোবাইল নম্বর';

  @override
  String get addCustomer => 'ক্রেতা যোগ করুন';

  @override
  String get paymentConfirmed => 'পেমেন্ট নিশ্চিত করুন';

  @override
  String get addAdvance => 'অগ্রিম যোগ করুন';

  @override
  String get addAdvanceTitle => 'অগ্রিম যোগ করুন';

  @override
  String get attendanceTitle => 'উপস্থিতি';

  @override
  String get salaryTitle => 'বেতনের সারাংশ';

  @override
  String get rate => 'হার';

  @override
  String get daysPresent => 'উপস্থিত দিন';

  @override
  String get earned => 'উপার্জিত';

  @override
  String get unpaid => 'অপরিশোধিত';

  @override
  String get advanceTaken => 'নেওয়া অগ্রিম';

  @override
  String get active => 'সক্রিয়';

  @override
  String get inactive => 'নিষ্ক্রিয়';

  @override
  String get joined => 'যোগ দিয়েছে';

  @override
  String get noPhone => 'ফোন নেই';

  @override
  String get addNewStaff => 'নতুন কর্মী যোগ করুন';

  @override
  String get fullNameLabel => 'পুরো নাম';

  @override
  String get phoneNumber => 'ফোন নম্বর';

  @override
  String get role => 'ভূমিকা';

  @override
  String get salaryType => 'বেতনের ধরন';

  @override
  String get dailyWage => 'দৈনিক মজুরি';

  @override
  String get monthlySalary => 'মাসিক বেতন';

  @override
  String get dailyWageAmount => 'দৈনিক মজুরি (₹)';

  @override
  String get monthlySalaryAmount => 'মাসিক বেতন (₹)';

  @override
  String get addStaffButton => 'কর্মী যোগ করুন';

  @override
  String get noteOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get amountRupees => 'পরিমাণ (₹)';

  @override
  String get cancel => 'বাতিল';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get tryAgain => 'আবার চেষ্টা করুন';

  @override
  String get alignBillInFrame => 'বিল ফ্রেমে রাখুন';

  @override
  String get verifyAndLogin => 'যাচাই করে লগইন করুন';

  @override
  String get voiceListening => 'শুনছি...';

  @override
  String get voiceThinking => 'ভাবছি...';

  @override
  String get voiceDetectedEntry => 'শনাক্ত করা এন্ট্রি';

  @override
  String get voiceConfirmEntry => 'এন্ট্রি নিশ্চিত করুন';

  @override
  String get item => 'আইটেম';

  @override
  String get totalOutstandingBalance => 'মোট বকেয়া পরিমাণ';

  @override
  String get payAllDues => 'সব বকেয়া পরিশোধ করুন';

  @override
  String get myKhatas => 'আমার খাতা';

  @override
  String get noVendorsFound => 'কোনো বিক্রেতা পাওয়া যায়নি';

  @override
  String get verifyBillDetails => 'বিলের বিবরণ যাচাই করুন';

  @override
  String get scannedBillPreview => 'স্ক্যান করা বিল';

  @override
  String get descriptionItemDetails => 'বিবরণ / পণ্যের তথ্য';

  @override
  String get selectCustomer => 'ক্রেতা বেছে নিন';

  @override
  String get searchCustomerHint => 'ক্রেতা খুঁজুন বা বেছে নিন';

  @override
  String get saveToKhata => 'খাতায় সেভ করুন';

  @override
  String get allCustomersReport => 'সব ক্রেতার রিপোর্ট';

  @override
  String collectedInMonth(String month) {
    return '$month-এ সংগ্রহ';
  }

  @override
  String get notificationSettings => 'বিজ্ঞপ্তি সেটিংস';

  @override
  String get securityPin => 'নিরাপত্তা ও পিন';

  @override
  String get editProfile => 'প্রোফাইল সম্পাদনা করুন';

  @override
  String get changePassword => 'পাসওয়ার্ড পরিবর্তন করুন';

  @override
  String get termsAndConditions => 'শর্তাবলী';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get accountSettings => 'অ্যাকাউন্ট সেটিংস';

  @override
  String get legalInfo => 'আইনি';

  @override
  String get currentPassword => 'বর্তমান পাসওয়ার্ড';

  @override
  String get newPassword => 'নতুন পাসওয়ার্ড';

  @override
  String get confirmNewPassword => 'নতুন পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get passwordsDoNotMatch => 'পাসওয়ার্ড মেলে না';

  @override
  String get changePasswordButton => 'পাসওয়ার্ড পরিবর্তন করুন';

  @override
  String get passwordChangedSuccess => 'পাসওয়ার্ড সফলভাবে পরিবর্তিত হয়েছে';

  @override
  String get loadingContent => 'লোড হচ্ছে...';

  @override
  String get failedToLoad => 'সামগ্রী লোড করতে ব্যর্থ। আবার চেষ্টা করুন।';

  @override
  String get bookingActions => 'বুকিং কার্যক্রম';

  @override
  String get confirmBooking => 'বুকিং নিশ্চিত করুন';

  @override
  String get markComplete => 'সম্পন্ন চিহ্নিত করুন';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer-এর $date তারিখে $time-এর অ্যাপয়েন্টমেন্ট নিশ্চিত করবেন?';
  }

  @override
  String get bookingUpdated => 'বুকিং সফলভাবে আপডেট হয়েছে';

  @override
  String get bookingUpdateFailed => 'বুকিং আপডেট করতে ব্যর্থ';

  @override
  String markAttendanceFor(String date) {
    return 'উপস্থিতি চিহ্নিত করুন — $date';
  }

  @override
  String get allCustomers => 'সব ক্রেতা';

  @override
  String get noCustomersYet => 'এখনও কোনো ক্রেতা নেই';

  @override
  String get noCustomersYetSubtitle => 'শুরু করতে প্রথম ক্রেতা যোগ করুন';

  @override
  String get invalidPhone => '৬–৯ দিয়ে শুরু ১০ সংখ্যার বৈধ মোবাইল নম্বর দিন';

  @override
  String accrueMonthSalary(String amount) {
    return 'মাসের বেতন যোগ করুন (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'মাসের বেতন যোগ করুন';

  @override
  String get removeStaffTitle => 'Remove Staff Member';

  @override
  String removeStaffConfirm(String name) {
    return 'Remove $name from your staff? This will revoke their app access immediately.';
  }

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name-এর বকেয়ায় এই মাসে ₹$amount যোগ করবেন?';
  }

  @override
  String get accountInformation => 'অ্যাকাউন্ট তথ্য';

  @override
  String get updateProfileDetails => 'আপনার নাম, ছবি ও তথ্য আপডেট করুন';

  @override
  String get updateAccountPassword => 'আপনার অ্যাকাউন্ট পাসওয়ার্ড আপডেট করুন';

  @override
  String get deleteAccount => 'অ্যাকাউন্ট মুছুন';

  @override
  String get deleteAccountSubtitle => 'অ্যাকাউন্ট ও সব ডেটা স্থায়ীভাবে মুছুন';

  @override
  String get deleteAccountConfirmation => 'অ্যাকাউন্ট মুছবেন?';

  @override
  String get deleteAccountConfirmationMessage =>
      'এটি আপনার অ্যাকাউন্ট ও সব ডেটা স্থায়ীভাবে মুছে ফেলবে। এটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get deleteAccountStaffWarning =>
      'এটি আপনার অ্যাকাউন্ট স্থায়ীভাবে মুছে ফেলবে। এটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get deleteForever => 'চিরতরে মুছুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get readTermsOfService => 'আমাদের সেবার শর্তাবলী পড়ুন';

  @override
  String get privacyPolicyDescription => 'আমরা আপনার ডেটা কীভাবে পরিচালনা করি';

  @override
  String get confirmLogout => 'আপনি কি সত্যিই লগআউট করতে চান?';

  @override
  String get membershipTiers => 'সদস্যপদ স্তর';

  @override
  String get membershipTiersDescription =>
      'স্তরের নাম পরিবর্তন করুন ও সদস্য ছাড় সেট করুন';

  @override
  String get logIn => 'লগইন করুন';

  @override
  String get enterPhoneNumberToContinue => 'চালিয়ে যেতে ফোন নম্বর দিন';

  @override
  String get otpDemoHint => 'OTP শুধু ডেমোর জন্য · চালিয়ে যেতে 123456 দিন';

  @override
  String get havingTrouble => 'সমস্যা হচ্ছে?';

  @override
  String get useEmailInstead => 'ইমেইল দিয়ে লগইন করুন →';

  @override
  String get logInWithEmail => 'ইমেইল দিয়ে লগইন করুন';

  @override
  String get emailPlaceholder => 'you@example.com';

  @override
  String get enterYourPassword => 'পাসওয়ার্ড দিন';

  @override
  String get takePhoto => 'ছবি তুলুন';

  @override
  String get chooseFromGallery => 'গ্যালারি থেকে বেছে নিন';

  @override
  String get removePhoto => 'ছবি সরান';

  @override
  String get tapToAddProfilePhoto => 'প্রোফাইল ছবি যোগ করতে ট্যাপ করুন';

  @override
  String get camera => 'ক্যামেরা';

  @override
  String get gallery => 'গ্যালারি';

  @override
  String get add => 'যোগ করুন';

  @override
  String get addUpiId => 'UPI আইডি যোগ করুন';

  @override
  String get save => 'সেভ করুন';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get remove => 'সরান';

  @override
  String get approve => 'অনুমোদন করুন';

  @override
  String get decline => 'প্রত্যাখ্যান করুন';

  @override
  String get none => 'কিছু না';

  @override
  String get percent => 'শতাংশ';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get paymentVerification => 'পেমেন্ট যাচাই';

  @override
  String get verifyingPayment => 'পেমেন্ট যাচাই হচ্ছে';

  @override
  String get paymentConfirmedExclamation => 'পেমেন্ট নিশ্চিত!';

  @override
  String get verificationTimedOut => 'যাচাইয়ের সময় শেষ';

  @override
  String get goBack => 'ফিরে যান';

  @override
  String get payDues => 'বকেয়া পরিশোধ করুন';

  @override
  String get skipForNow => 'এখনের মতো এড়িয়ে যান';

  @override
  String get allDone => 'সব হয়েছে!';

  @override
  String get noUpcomingAppointments => 'কোনো আসন্ন অ্যাপয়েন্টমেন্ট নেই';

  @override
  String get myPay => 'আমার বেতন';

  @override
  String get myPaymentQr => 'আমার পেমেন্ট QR';

  @override
  String get showMyQr => 'আমার QR দেখান';

  @override
  String get noPaymentsYet => 'এখনও কোনো পেমেন্ট নেই';

  @override
  String get paymentHistory => 'পেমেন্টের ইতিহাস';

  @override
  String get paymentHistory6Months => 'পেমেন্টের ইতিহাস (৬ মাস)';

  @override
  String get connectionRequest => 'সংযোগ অনুরোধ';

  @override
  String get vendorWantsToConnect => 'একজন বিক্রেতা সংযুক্ত হতে চান';

  @override
  String get acceptRequest => 'গ্রহণ করুন';

  @override
  String get declineRequest => 'প্রত্যাখ্যান করুন';

  @override
  String get messageLabel => 'বার্তা';

  @override
  String get sendRequest => 'অনুরোধ পাঠান';

  @override
  String get requestSentNotification =>
      'অনুরোধ পাঠানো হয়েছে! তাদের নিশ্চিত করতে জানানো হবে।';

  @override
  String get awaitingAcceptance => 'গ্রহণের অপেক্ষায়';

  @override
  String get addAVendor => 'বিক্রেতা যোগ করুন';

  @override
  String get findByPhoneOrEmail => 'ফোন নম্বর বা ইমেইলে খুঁজুন';

  @override
  String get phoneOrEmail => 'ফোন বা ইমেইল';

  @override
  String get phoneOrEmailHint => '১০ সংখ্যার মোবাইল বা ইমেইল ঠিকানা';

  @override
  String get nicknameOptional => 'ডাকনাম (ঐচ্ছিক)';

  @override
  String get howYouKnowVendor => 'আপনি এই বিক্রেতাকে কীভাবে চেনেন';

  @override
  String get bookingNoteExample => 'যেমন: আজ অতিরিক্ত দুধ দরকার';

  @override
  String get confirmLocation => 'অবস্থান নিশ্চিত করুন';

  @override
  String get moveMapToSelectLocation => 'অবস্থান বেছে নিতে মানচিত্র সরান';

  @override
  String get searchPlaceHint => 'একটি স্থান খুঁজুন…';

  @override
  String get mapAttribution => '© OpenStreetMap contributors';

  @override
  String get searchVendorsHint => 'বিক্রেতা খুঁজুন…';

  @override
  String get somethingWentWrong => 'কিছু ভুল হয়েছে';

  @override
  String get payViaUpi => 'UPI দিয়ে পেমেন্ট';

  @override
  String get connectWithVendor => 'সংযুক্ত হন';

  @override
  String get requestConnection => 'সংযোগ অনুরোধ';

  @override
  String get addVendor => 'বিক্রেতা যোগ করুন';

  @override
  String get noOutstandingBalances => 'কোনো বকেয়া শেষ নেই';

  @override
  String get allCustomersSettledUp => 'সব ক্রেতার হিসাব মিটে গেছে।';

  @override
  String get nothingCollectedToday => 'আজ কিছু সংগ্রহ হয়নি';

  @override
  String get paymentsWillAppearHere => 'আজকের প্রাপ্ত পেমেন্ট এখানে দেখাবে।';

  @override
  String get customerReport => 'ক্রেতার রিপোর্ট';

  @override
  String get overview => 'সারসংক্ষেপ';

  @override
  String get tapToStop => 'থামাতে ট্যাপ করুন';

  @override
  String get itemName => 'পণ্যের নাম';

  @override
  String get itemNameExample => 'যেমন: দুধ';

  @override
  String get unitPrice => 'প্রতি ইউনিট মূল্য ₹';

  @override
  String get deliverTo => 'ডেলিভারি করুন';

  @override
  String get bulkCharge => 'বাল্ক চার্জ';

  @override
  String get newProduct => 'নতুন পণ্য';

  @override
  String get editProduct => 'পণ্য সম্পাদনা করুন';

  @override
  String get newProductService => 'নতুন পণ্য / সেবা';

  @override
  String get updateProductDetails => 'নাম, ইউনিট বা মূল্য আপডেট করুন';

  @override
  String get defineProduct => 'আপনি কী বিক্রি করেন ও মূল্য নির্ধারণ করুন';

  @override
  String get productName => 'পণ্যের নাম';

  @override
  String get productNameExample => 'যেমন: সকালের দুধ';

  @override
  String get unit => 'ইউনিট';

  @override
  String get unitExample => 'লিটার / কেজি / পিস';

  @override
  String get pricePerUnit => 'প্রতি ইউনিট মূল্য (₹)';

  @override
  String get deleteProduct => 'পণ্য মুছুন';

  @override
  String get deleteProductConfirmation => 'পণ্য মুছবেন?';

  @override
  String removeProductConfirmation(String name) {
    return 'Remove \"$name\" from your product list?';
  }

  @override
  String get noProductsYet => 'এখনও কোনো পণ্য নেই';

  @override
  String get addFirstProduct => 'প্রথম পণ্য যোগ করুন';

  @override
  String get renameTier => 'স্তরের নাম পরিবর্তন করুন';

  @override
  String get tierName => 'স্তরের নাম';

  @override
  String tierLevel(int level) {
    return 'Level $level';
  }

  @override
  String get memberDiscount => 'সদস্য ছাড়';

  @override
  String discountFor(String tier) {
    return 'Discount for $tier';
  }

  @override
  String get flatAmount => 'ফ্ল্যাট ₹';

  @override
  String get discountPercent => 'ছাড় %';

  @override
  String get discountAmount => 'ছাড়ের পরিমাণ (₹)';

  @override
  String get percentExample => 'যেমন: ৫';

  @override
  String get amountExample => 'যেমন: ৫০';

  @override
  String get maxDiscountPerDue => 'প্রতি বকেয়ায় সর্বোচ্চ ছাড় (₹) — ঐচ্ছিক';

  @override
  String get maxDiscountExample => 'যেমন: ১০০ (সীমা না থাকলে খালি রাখুন)';

  @override
  String get saveDiscount => 'ছাড় সেভ করুন';

  @override
  String get membership => 'সদস্যপদ';

  @override
  String get setTier => 'সেট করুন';

  @override
  String get changeTier => 'পরিবর্তন করুন';

  @override
  String get applyMembership => 'প্রয়োগ করুন';

  @override
  String get removeMembership => 'সদস্যপদ সরান';

  @override
  String get removeLedgerConfirmation => 'খাতা সরাবেন?';

  @override
  String get exportStatement => 'স্টেটমেন্ট এক্সপোর্ট করুন';

  @override
  String get appAccess => 'অ্যাপ অ্যাক্সেস';

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

  @override
  String get manageSchedule => 'Manage Schedule';

  @override
  String get bookingsTab => 'Bookings';

  @override
  String get bySlotTab => 'By Slot';

  @override
  String get scheduleSaved => 'Schedule saved!';

  @override
  String get addSlot => 'Add Slot';

  @override
  String noSlotsForDay(String day) {
    return 'No slots for $day';
  }

  @override
  String get tapAddSlotHint => 'Tap \"Add Slot\" to set your availability';

  @override
  String get slotAvailable => 'Available';

  @override
  String get slotsFull => 'Slots Full';

  @override
  String get slotFullHint => 'Mark this slot as fully booked';

  @override
  String get enableSlotFirst => 'Enable slot first';

  @override
  String get deleteSlotTitle => 'Delete Slot';

  @override
  String deleteSlotConfirm(String time) {
    return 'Remove the $time slot?';
  }

  @override
  String get endTimeAfterStart => 'End time must be after start time';

  @override
  String get slotOverlaps => 'This slot overlaps with an existing one';

  @override
  String get addTimeSlot => 'Add Time Slot';

  @override
  String get editTimeSlot => 'Edit Time Slot';

  @override
  String get selectTimeHint => 'Select start and end time in 12-hour format';

  @override
  String get startLabel => 'Start';

  @override
  String get endLabel => 'End';

  @override
  String get update => 'Update';

  @override
  String get notifTabAll => 'All';

  @override
  String get notifTabBookings => 'Bookings';

  @override
  String get noBookingNotifications => 'No booking notifications';

  @override
  String get noBookingNotificationsSubtitle =>
      'Booking requests and updates will appear here';

  @override
  String get bookingPillLabel => 'Booking';

  @override
  String get slotDetailTitle => 'Slot Details';

  @override
  String bookingsCount(int count) {
    return '$count booking';
  }

  @override
  String bookingsCountPlural(int count) {
    return '$count bookings';
  }

  @override
  String pendingCountLabel(int count) {
    return '$count pending';
  }

  @override
  String slotTimeRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get keepButton => 'Keep';

  @override
  String get deleteButton => 'Delete';
}
