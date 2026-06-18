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
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name-এর বকেয়ায় এই মাসে ₹$amount যোগ করবেন?';
  }
}
