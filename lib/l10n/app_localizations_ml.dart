// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'സാഥ്ഖാതാ';

  @override
  String get tagline => 'ഒരു ഖാതാ, ഇരുവർക്കും';

  @override
  String get onboarding1Title => 'ഇരുകക്ഷി പങ്കിട്ട ലെഡ്ജർ';

  @override
  String get onboarding1Subtitle =>
      'വ്യാപാരിക്കും ഉപഭോക്താവിനും ഒരേ ഖാതാ. ഇരുവരും ഒരേ സത്യം കാണുന്നു.';

  @override
  String get onboarding2Title => 'വോയ്‌സ് & ബിൽ OCR';

  @override
  String get onboarding2Subtitle =>
      '12 ഭാഷകളിൽ ഉടൻ എൻട്രികൾ ഉണ്ടാക്കാൻ സംസാരിക്കുക അല്ലെങ്കിൽ ബിൽ സ്കാൻ ചെയ്യുക.';

  @override
  String get onboarding3Title => 'ഒരു ടാപ്പിൽ UPI പേയ്‌മെന്റ്';

  @override
  String get onboarding3Subtitle =>
      'UPI വഴി ഒരു ടാപ്പിൽ മാസത്തെ കുടിശ്ശിക അടയ്ക്കുക.';

  @override
  String get getStarted => 'ആരംഭിക്കൂ';

  @override
  String get next => 'അടുത്തത്';

  @override
  String get skip => 'ഒഴിവാക്കുക';

  @override
  String get chooseLanguage => 'നിങ്ങളുടെ ഭാഷ തിരഞ്ഞെടുക്കുക';

  @override
  String get continueButton => 'തുടരുക';

  @override
  String get chooseRole => 'നിങ്ങളുടെ റോൾ തിരഞ്ഞെടുക്കുക';

  @override
  String get vendor => 'വ്യാപാരി';

  @override
  String get customer => 'ഉപഭോക്താവ്';

  @override
  String get welcomeToSaathKhata => 'സാഥ്ഖാതയിലേക്ക് സ്വാഗതം';

  @override
  String get tellUsHowYouUse => 'ആപ്പ് എങ്ങനെ ഉപയോഗിക്കുമെന്ന് പറയൂ';

  @override
  String get vendorRoleTitle => 'ഞാൻ ഒരു വ്യാപാരിയാണ്';

  @override
  String get vendorRoleSubtitle =>
      'ബിസിനസ് ഖാതാ, ജീവനക്കാരെ നിയന്ത്രിക്കൂ, പേയ്‌മെന്റ് സ്വീകരിക്കൂ.';

  @override
  String get customerRoleTitle => 'ഞാൻ ഒരു ഉപഭോക്താവാണ്';

  @override
  String get customerRoleSubtitle =>
      'വ്യാപാരികളുമായി ഖാതാ ട്രാക്ക് ചെയ്യൂ, UPI വഴി പണം നൽകൂ.';

  @override
  String get loginTitle => 'സാഥ്ഖാതയിൽ ലോഗിൻ ചെയ്യൂ';

  @override
  String get enterMobile => 'തുടരാൻ വിവരങ്ങൾ നൽകൂ';

  @override
  String get mobileNumber => 'മൊബൈൽ നമ്പർ';

  @override
  String get sendOtp => 'OTP അയക്കൂ';

  @override
  String get verifyOtp => 'OTP സ്ഥിരീകരിക്കൂ';

  @override
  String get verifyAndContinue => 'സ്ഥിരീകരിച്ച് തുടരൂ';

  @override
  String get changePhoneNumber => 'ഫോൺ നമ്പർ മാറ്റൂ';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber ലേക്ക് അയച്ച 6 അക്ക കോഡ് നൽകൂ';
  }

  @override
  String get email => 'ഇ-മെയിൽ';

  @override
  String get password => 'പാസ്‌വേഡ്';

  @override
  String get passwordHint => 'പാസ്‌വേഡ് നൽകൂ';

  @override
  String get loginButton => 'ലോഗിൻ';

  @override
  String get noAccount => 'അക്കൗണ്ട് ഇല്ലേ?';

  @override
  String get signUp => 'രജിസ്റ്റർ ചെയ്യൂ';

  @override
  String get pleaseEnterCredentials => 'ഇ-മെയിലും പാസ്‌വേഡും നൽകൂ';

  @override
  String get fillRequiredFields => 'പേര്, ഇ-മെയിൽ, പാസ്‌വേഡ് നൽകൂ';

  @override
  String get passwordMinChars => 'കുറഞ്ഞത് 8 അക്ഷരങ്ങൾ';

  @override
  String get completeProfile => 'പ്രൊഫൈൽ പൂർത്തിയാക്കൂ';

  @override
  String get enterYourName => 'നിങ്ങളുടെ പേര് നൽകൂ';

  @override
  String get egBusinessName => 'ഉദാ. കൃഷ്ണ ഡെയറി';

  @override
  String get selectCategory => 'വിഭാഗം തിരഞ്ഞെടുക്കൂ';

  @override
  String get enterAddress => 'പ്രദേശം അല്ലെങ്കിൽ പൂർണ്ണ വിലാസം നൽകൂ';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'പൂർണ്ണ പേര്';

  @override
  String get businessName => 'ബിസിനസ് പേര്';

  @override
  String get businessCategory => 'ബിസിനസ് വിഭാഗം';

  @override
  String get businessAddress => 'ബിസിനസ് വിലാസം (ഐച്ഛികം)';

  @override
  String get upiId => 'UPI ID (പേയ്‌മെന്റുകൾക്ക്)';

  @override
  String get vendorDashboard => 'വ്യാപാരി ഡാഷ്‌ബോർഡ്';

  @override
  String get customerDashboard => 'ഉപഭോക്താവ് ഡാഷ്‌ബോർഡ്';

  @override
  String get customerMode => 'ഉപഭോക്തൃ മോഡ്';

  @override
  String get myVendors => 'എന്റെ വ്യാപാരികൾ';

  @override
  String get outstanding => 'കുടിശ്ശിക';

  @override
  String get collectedToday => 'ഇന്ന് ശേഖരിച്ചത്';

  @override
  String get quickActions => 'വേഗ പ്രവർത്തനങ്ങൾ';

  @override
  String get scanBill => 'ബിൽ സ്കാൻ ചെയ്യൂ';

  @override
  String get remindAll => 'എല്ലാവരെയും ഓർമ്മിപ്പിക്കൂ';

  @override
  String get addNew => 'പുതിയത് ചേർക്കൂ';

  @override
  String get recentCustomers => 'സമീപകാല ഉപഭോക്താക്കൾ';

  @override
  String get viewAll => 'എല്ലാം കാണൂ';

  @override
  String customerAddedSnackbar(String name) {
    return '$name ചേർത്തു';
  }

  @override
  String get sharedLedger => 'പങ്കിട്ട ഖാതാ';

  @override
  String get totalBalance => 'മൊത്തം ബാലൻസ്';

  @override
  String get statement => 'സ്റ്റേറ്റ്‌മെന്റ്';

  @override
  String get giveCredit => 'കടം നൽകൂ';

  @override
  String get recordPayment => 'പേയ്‌മെന്റ് രേഖപ്പെടുത്തൂ';

  @override
  String get giveCreditSheet => 'കടം നൽകൂ';

  @override
  String get recordPaymentSheet => 'പേയ്‌മെന്റ് രേഖപ്പെടുത്തൂ';

  @override
  String get filterAll => 'എല്ലാം';

  @override
  String get balanceCustomerOwes => 'ഉപഭോക്താവിന്റെ കുടിശ്ശിക';

  @override
  String get balanceYouOwe => 'നിങ്ങളുടെ കുടിശ്ശിക';

  @override
  String get balanceSettled => 'തീർപ്പാക്കി';

  @override
  String get balanceYouOweVendor => 'നിങ്ങൾ വ്യാപാരിക്ക് കൊടുക്കാനുണ്ട്';

  @override
  String get balanceVendorOwesYou => 'വ്യാപാരി നിങ്ങൾക്ക് കൊടുക്കാനുണ്ട്';

  @override
  String get ledgerInfoTitle => 'ഈ ഖാതാ എങ്ങനെ പ്രവർത്തിക്കുന്നു';

  @override
  String get statusConfirmed => 'സ്ഥിരീകരിച്ചു';

  @override
  String get statusConfirmedDesc =>
      'ഇരുകക്ഷിയും സമ്മതിച്ചു. എൻട്രി ലോക്ക് ചെയ്തു, മാറ്റാനാകില്ല.';

  @override
  String get statusPending => 'കാത്തിരിക്കുന്നു';

  @override
  String get statusPendingDesc =>
      'ഉപഭോക്താവിന്റെ സ്ഥിരീകരണം കാക്കുന്നു. 72 മണിക്കൂറിൽ സ്വയം സ്ഥിരീകരിക്കും.';

  @override
  String get statusDisputed => 'തർക്കത്തിൽ';

  @override
  String get statusDisputedDesc =>
      'ഉപഭോക്താവ് തർക്കമുന്നയിച്ചു. വ്യാപാരി അവലോകനം ആവശ്യം.';

  @override
  String get statusAutoConfirmed => 'സ്വയം സ്ഥിരീകരണം';

  @override
  String get entryTypeCreditLabel => 'കടം എൻട്രി';

  @override
  String get entryTypePaymentLabel => 'പേയ്‌മെന്റ് ലഭിച്ചു';

  @override
  String get entryDetails => 'എൻട്രി വിവരങ്ങൾ';

  @override
  String get entryAmount => 'തുക';

  @override
  String get entryType => 'തരം';

  @override
  String get entryTypeCreditGiven => 'കടം (നൽകിയത്)';

  @override
  String get entryTypePaymentReceived => 'പേയ്‌മെന്റ് (ലഭിച്ചത്)';

  @override
  String get entryDate => 'തീയതി';

  @override
  String get entryDescription => 'വിവരണം';

  @override
  String get entryQuantity => 'അളവ്';

  @override
  String get entryConfirmedAt => 'സ്ഥിരീകരണ തീയതി';

  @override
  String get entryDisputeReason => 'തർക്കത്തിന്റെ കാരണം';

  @override
  String entryFor(String name) {
    return '$name ന് വേണ്ടി';
  }

  @override
  String get descriptionOptional => 'വിവരണം (ഐച്ഛികം)';

  @override
  String get quantityOptional => 'അളവ് (ഐച്ഛികം)';

  @override
  String get descriptionHint => 'ഉദാ. 2L പാൽ, മാസ കിരാണ';

  @override
  String get quantityHint => 'ഉദാ. 2';

  @override
  String get addCreditEntry => 'കടം എൻട്രി ചേർക്കൂ';

  @override
  String get noLedgerTransactions => 'ഇനിയും ഇടപാടുകൾ ഇല്ല';

  @override
  String get noLedgerTransactionsSubtitle =>
      'ആരംഭിക്കാൻ കടം അല്ലെങ്കിൽ പേയ്‌മെന്റ് എൻട്രി ചേർക്കൂ.';

  @override
  String get confirmEntryTitle => 'എൻട്രി സ്ഥിരീകരിക്കൂ';

  @override
  String confirmEntryMessage(String amount) {
    return '₹$amount എൻട്രി സ്ഥിരീകരിക്കണോ? ഇത് മാറ്റാനാകില്ല.';
  }

  @override
  String get dispute => 'തർക്കം';

  @override
  String get raiseDisputeTitle => 'തർക്കം ഉന്നയിക്കൂ';

  @override
  String get raiseDisputeSubtitle =>
      'ഈ എൻട്രിയിൽ എന്ത് തെറ്റാണെന്ന് വിശദീകരിക്കൂ.';

  @override
  String get raiseDisputeHint => 'ഉദാ. തുക ₹50 ആകണം, ₹60 അല്ല';

  @override
  String get submitDispute => 'തർക്കം സമർപ്പിക്കൂ';

  @override
  String get staffAndLabour => 'ജീവനക്കാരും തൊഴിലാളികളും';

  @override
  String get addStaff => 'ജീവനക്കാരനെ ചേർക്കൂ';

  @override
  String get presentToday => 'ഇന്ന് ഹാജർ';

  @override
  String get unpaidSalary => 'നൽകാത്ത ശമ്പളം';

  @override
  String get paySalary => 'ശമ്പളം നൽകൂ';

  @override
  String get noStaffAdded => 'ഇനിയും ജീവനക്കാർ ഇല്ല';

  @override
  String get noStaffAddedSubtitle =>
      'ആദ്യ ജീവനക്കാരനെ ചേർക്കാൻ താഴെ ബട്ടൺ അമർത്തൂ.';

  @override
  String get present => 'ഹാജർ';

  @override
  String get absent => 'ഗൈർഹാജർ';

  @override
  String get halfDay => 'അർദ്ധ ദിവസം';

  @override
  String get paySalaryTitle => 'ശമ്പളം നൽകൂ';

  @override
  String unpaidLabel(String amount) {
    return 'നൽകാത്തത്: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI ഇടപാട് ID (ഐച്ഛികം)';

  @override
  String get noDues => 'കുടിശ്ശിക ഇല്ല';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount നൽകൂ';
  }

  @override
  String staffJoined(String date) {
    return '$date ന് ചേർന്നു';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/ദിവസം';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/മാസം';
  }

  @override
  String get staffPayButton => 'പേയ്‌മെന്റ്';

  @override
  String get businessReports => 'ബിസിനസ് റിപ്പോർട്ടുകൾ';

  @override
  String get revenueTrend => 'വരുമാന പ്രവണത';

  @override
  String get collectionSummary => 'ശേഖരണ സംഗ്രഹം';

  @override
  String get totalOutstanding => 'മൊത്തം കുടിശ്ശിക';

  @override
  String get totalCollected => 'മൊത്തം ശേഖരിച്ചത്';

  @override
  String get topCustomers => 'മികച്ച ഉപഭോക്താക്കൾ';

  @override
  String get seeAll => 'എല്ലാം കാണൂ';

  @override
  String get settings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get appLanguage => 'ആപ്പ് ഭാഷ';

  @override
  String get selectLanguage => 'ഭാഷ തിരഞ്ഞെടുക്കൂ';

  @override
  String get settingsManagePayments => 'പേയ്‌മെന്റ് അക്കൗണ്ടുകൾ നിയന്ത്രിക്കൂ';

  @override
  String get settingsManageAlerts =>
      'അലർട്ടുകളും ഓർമ്മിപ്പിക്കലുകളും നിയന്ത്രിക്കൂ';

  @override
  String get settingsAppPinFingerprint => 'ആപ്പ് പിൻ, വിരലടയാളം';

  @override
  String get settingsFaqsContact => 'സഹായവും ബന്ധപ്പെടലും';

  @override
  String settingsVersion(String version) {
    return 'പതിപ്പ് $version';
  }

  @override
  String get myUpiIds => 'എന്റെ UPI IDകൾ';

  @override
  String get notifications => 'അറിയിപ്പുകൾ';

  @override
  String get security => 'സുരക്ഷ';

  @override
  String get helpSupport => 'സഹായം';

  @override
  String get logout => 'ലോഗ് ഔട്ട്';

  @override
  String get markAllRead => 'എല്ലാം വായിച്ചതായി അടയാളപ്പെടുത്തൂ';

  @override
  String get noNotificationsTitle => 'ഇനിയും അറിയിപ്പുകൾ ഇല്ല';

  @override
  String get noNotificationsSubtitle =>
      'ഇവിടെ ഖാതാ അപ്‌ഡേറ്റുകൾ, പേയ്‌മെന്റ് അലർട്ടുകൾ, ഓർമ്മിപ്പിക്കലുകൾ കാണും.';

  @override
  String get today => 'ഇന്ന്';

  @override
  String get yesterday => 'ഇന്നലെ';

  @override
  String minutesAgo(int count) {
    return '$count മിനിറ്റ് മുമ്പ്';
  }

  @override
  String hoursAgo(int count) {
    return '$count മണിക്കൂർ മുമ്പ്';
  }

  @override
  String get payments => 'പേയ്‌മെന്റുകൾ';

  @override
  String get transactionHistory => 'ഇടപാട് ചരിത്രം';

  @override
  String get totalPaid => 'മൊത്തം അടച്ചത്';

  @override
  String get pending => 'കാത്തിരിക്കുന്നു';

  @override
  String get quickPay => 'വേഗ പേയ്‌മെന്റ്';

  @override
  String get scanAndPay => 'സ്കാൻ ചെയ്ത് അടയ്ക്കൂ';

  @override
  String get scanUpiDesc => 'വ്യാപാരിക്ക് നൽകാൻ UPI QR സ്കാൻ ചെയ്യൂ';

  @override
  String get noTransactionsTitle => 'ഇനിയും ഇടപാടുകൾ ഇല്ല';

  @override
  String get noTransactionsSubtitle =>
      'നിങ്ങളുടെ പേയ്‌മെന്റ് ചരിത്രം ഇവിടെ കാണും.';

  @override
  String get paymentStatusPaid => 'അടച്ചു';

  @override
  String get paymentStatusFailed => 'പരാജയം';

  @override
  String get paymentStatusRefunded => 'തിരിച്ചു';

  @override
  String get appointments => 'അപ്പോയിന്റ്‌മെന്റുകൾ';

  @override
  String get myAppointments => 'എന്റെ അപ്പോയിന്റ്‌മെന്റുകൾ';

  @override
  String get upcoming => 'വരാനിരിക്കുന്നത്';

  @override
  String get past => 'കഴിഞ്ഞത്';

  @override
  String get cancelBooking => 'ബുക്കിംഗ് റദ്ദ് ചെയ്യൂ';

  @override
  String get keepBooking => 'നിലനിർത്തൂ';

  @override
  String get noBookingsToday => 'ഇന്ന് ബുക്കിംഗുകൾ ഇല്ല';

  @override
  String get noBookingsTodaySubtitle =>
      'ഉപഭോക്താക്കൾക്ക് ആപ്പ് വഴി അപ്പോയിന്റ്‌മെന്റ് ബുക്ക് ചെയ്യാം.';

  @override
  String get noAppointmentsTitle => 'ഇനിയും അപ്പോയിന്റ്‌മെന്റുകൾ ഇല്ല';

  @override
  String get noAppointmentsSubtitle =>
      'ആരംഭിക്കാൻ നിങ്ങളുടെ വ്യാപാരിയുമായി അപ്പോയിന്റ്‌മെന്റ് ബുക്ക് ചെയ്യൂ.';

  @override
  String get cancelAppointmentTitle => 'അപ്പോയിന്റ്‌മെന്റ് റദ്ദ് ചെയ്യണോ?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date ന് $time ന് ഉള്ള അപ്പോയിന്റ്‌മെന്റ് റദ്ദ് ചെയ്യണോ?';
  }

  @override
  String get bookingStatusConfirmed => 'സ്ഥിരീകരിച്ചു';

  @override
  String get bookingStatusPending => 'കാത്തിരിക്കുന്നു';

  @override
  String get bookingStatusCancelled => 'റദ്ദ്';

  @override
  String get bookingStatusCompleted => 'പൂർണ്ണം';

  @override
  String get bookingStatusDone => 'പൂർണ്ണം';

  @override
  String get upiPayment => 'UPI പേയ്‌മെന്റ്';

  @override
  String get amountToPay => 'അടയ്ക്കേണ്ട തുക';

  @override
  String get securedByUpi => 'UPI വഴി സുരക്ഷിതം';

  @override
  String get paymentSuccessful => 'പേയ്‌മെന്റ് വിജയകരം!';

  @override
  String get paymentFailed => 'പേയ്‌മെന്റ് പരാജയം';

  @override
  String get retryPayment => 'വീണ്ടും ശ്രമിക്കൂ';

  @override
  String get enterUpiId => 'UPI ID നൽകൂ';

  @override
  String get addNoteOptional => 'കുറിപ്പ് ചേർക്കൂ (ഐച്ഛികം)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount അടയ്ക്കൂ';
  }

  @override
  String get done => 'ആയി';

  @override
  String get paymentSomethingWentWrong => 'എന്തോ തകരാർ. വീണ്ടും ശ്രമിക്കൂ.';

  @override
  String upiAppComingSoon(String app) {
    return '$app ഉടൻ വരുന്നു';
  }

  @override
  String get pleaseEnterUpiId => 'UPI ID നൽകൂ';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $name ന് അടച്ചു';
  }

  @override
  String get orDivider => 'അല്ലെങ്കിൽ';

  @override
  String get addNewCustomer => 'പുതിയ ഉപഭോക്താവിനെ ചേർക്കൂ';

  @override
  String get customerName => 'ഉപഭോക്താവിന്റെ പേര്';

  @override
  String get mobileNo => 'മൊബൈൽ നമ്പർ';

  @override
  String get addCustomer => 'ഉപഭോക്താവിനെ ചേർക്കൂ';

  @override
  String get paymentConfirmed => 'പേയ്‌മെന്റ് സ്ഥിരീകരിക്കൂ';

  @override
  String get addAdvance => 'അഡ്വാൻസ് ചേർക്കൂ';

  @override
  String get addAdvanceTitle => 'അഡ്വാൻസ് ചേർക്കൂ';

  @override
  String get attendanceTitle => 'ഹാജർ';

  @override
  String get salaryTitle => 'ശമ്പള സംഗ്രഹം';

  @override
  String get rate => 'നിരക്ക്';

  @override
  String get daysPresent => 'ഹാജർ ദിവസങ്ങൾ';

  @override
  String get earned => 'സമ്പാദിച്ചത്';

  @override
  String get unpaid => 'നൽകാത്തത്';

  @override
  String get advanceTaken => 'എടുത്ത അഡ്വാൻസ്';

  @override
  String get active => 'സജീവം';

  @override
  String get inactive => 'നിഷ്‌ക്രിയം';

  @override
  String get joined => 'ചേർന്നു';

  @override
  String get noPhone => 'ഫോൺ ഇല്ല';

  @override
  String get addNewStaff => 'പുതിയ ജീവനക്കാരനെ ചേർക്കൂ';

  @override
  String get fullNameLabel => 'പൂർണ്ണ പേര്';

  @override
  String get phoneNumber => 'ഫോൺ നമ്പർ';

  @override
  String get role => 'റോൾ';

  @override
  String get salaryType => 'ശമ്പള തരം';

  @override
  String get dailyWage => 'ദൈനംദിന കൂലി';

  @override
  String get monthlySalary => 'മാസ ശമ്പളം';

  @override
  String get dailyWageAmount => 'ദൈനംദിന കൂലി (₹)';

  @override
  String get monthlySalaryAmount => 'മാസ ശമ്പളം (₹)';

  @override
  String get addStaffButton => 'ജീവനക്കാരനെ ചേർക്കൂ';

  @override
  String get noteOptional => 'കുറിപ്പ് (ഐച്ഛികം)';

  @override
  String get amountRupees => 'തുക (₹)';

  @override
  String get cancel => 'റദ്ദ്';

  @override
  String get confirm => 'സ്ഥിരീകരിക്കൂ';

  @override
  String get tryAgain => 'വീണ്ടും ശ്രമിക്കൂ';

  @override
  String get alignBillInFrame => 'ബിൽ ഫ്രേമിൽ വയ്ക്കൂ';

  @override
  String get verifyAndLogin => 'സ്ഥിരീകരിച്ച് ലോഗിൻ ചെയ്യൂ';

  @override
  String get voiceListening => 'കേൾക്കുന്നു...';

  @override
  String get voiceThinking => 'ചിന്തിക്കുന്നു...';

  @override
  String get voiceDetectedEntry => 'കണ്ടെത്തിയ എൻട്രി';

  @override
  String get voiceConfirmEntry => 'എൻട്രി സ്ഥിരീകരിക്കൂ';

  @override
  String get item => 'ഇനം';

  @override
  String get totalOutstandingBalance => 'മൊത്തം കുടിശ്ശിക തുക';

  @override
  String get payAllDues => 'എല്ലാ കുടിശ്ശികയും അടയ്ക്കൂ';

  @override
  String get myKhatas => 'എന്റെ ഖാതകൾ';

  @override
  String get noVendorsFound => 'വ്യാപാരികളെ കണ്ടെത്തിയില്ല';

  @override
  String get verifyBillDetails => 'ബിൽ വിവരങ്ങൾ സ്ഥിരീകരിക്കൂ';

  @override
  String get scannedBillPreview => 'സ്കാൻ ചെയ്ത ബിൽ';

  @override
  String get descriptionItemDetails => 'വിവരണം / ഇനം വിശദാംശങ്ങൾ';

  @override
  String get selectCustomer => 'ഉപഭോക്താവിനെ തിരഞ്ഞെടുക്കൂ';

  @override
  String get searchCustomerHint =>
      'ഉപഭോക്താവിനെ തിരയൂ അല്ലെങ്കിൽ തിരഞ്ഞെടുക്കൂ';

  @override
  String get saveToKhata => 'ഖാതയിൽ സേവ് ചെയ്യൂ';

  @override
  String get allCustomersReport => 'എല്ലാ ഉപഭോക്താക്കളുടെ റിപ്പോർട്ട്';

  @override
  String collectedInMonth(String month) {
    return '$month ൽ ശേഖരിച്ചത്';
  }

  @override
  String get notificationSettings => 'അറിയിപ്പ് ക്രമീകരണങ്ങൾ';

  @override
  String get securityPin => 'സുരക്ഷയും പിൻ';

  @override
  String get editProfile => 'പ്രൊഫൈൽ എഡിറ്റ് ചെയ്യൂ';

  @override
  String get changePassword => 'പാസ്‌വേഡ് മാറ്റൂ';

  @override
  String get termsAndConditions => 'നിബന്ധനകളും വ്യവസ്ഥകളും';

  @override
  String get privacyPolicy => 'സ്വകാര്യതാ നയം';

  @override
  String get accountSettings => 'അക്കൗണ്ട് ക്രമീകരണങ്ങൾ';

  @override
  String get legalInfo => 'നിയമ';

  @override
  String get currentPassword => 'നിലവിലെ പാസ്‌വേഡ്';

  @override
  String get newPassword => 'പുതിയ പാസ്‌വേഡ്';

  @override
  String get confirmNewPassword => 'പുതിയ പാസ്‌വേഡ് സ്ഥിരീകരിക്കൂ';

  @override
  String get passwordsDoNotMatch => 'പാസ്‌വേഡുകൾ പൊരുത്തപ്പെടുന്നില്ല';

  @override
  String get changePasswordButton => 'പാസ്‌വേഡ് മാറ്റൂ';

  @override
  String get passwordChangedSuccess => 'പാസ്‌വേഡ് വിജയകരമായി മാറ്റി';

  @override
  String get loadingContent => 'ലോഡ് ചെയ്യുന്നു...';

  @override
  String get failedToLoad =>
      'ഉള്ളടക്കം ലോഡ് ചെയ്യുന്നതിൽ പരാജയം. വീണ്ടും ശ്രമിക്കൂ.';

  @override
  String get bookingActions => 'ബുക്കിംഗ് പ്രവർത്തനങ്ങൾ';

  @override
  String get confirmBooking => 'ബുക്കിംഗ് സ്ഥിരീകരിക്കൂ';

  @override
  String get markComplete => 'പൂർണ്ണമായി അടയാളപ്പെടുത്തൂ';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer ന്റെ $date ന് $time ന് ഉള്ള അപ്പോയിന്റ്‌മെന്റ് സ്ഥിരീകരിക്കണോ?';
  }

  @override
  String get bookingUpdated => 'ബുക്കിംഗ് വിജയകരമായി അപ്‌ഡേറ്റ് ചെയ്തു';

  @override
  String get bookingUpdateFailed => 'ബുക്കിംഗ് അപ്‌ഡേറ്റ് ചെയ്യൽ പരാജയം';

  @override
  String markAttendanceFor(String date) {
    return 'ഹാജർ അടയാളപ്പെടുത്തൂ — $date';
  }

  @override
  String get allCustomers => 'എല്ലാ ഉപഭോക്താക്കളും';

  @override
  String get noCustomersYet => 'ഇനിയും ഉപഭോക്താക്കൾ ഇല്ല';

  @override
  String get noCustomersYetSubtitle => 'ആരംഭിക്കാൻ ആദ്യ ഉപഭോക്താവിനെ ചേർക്കൂ';

  @override
  String get invalidPhone => '6–9 ൽ തുടങ്ങുന്ന 10 അക്ക മൊബൈൽ നമ്പർ നൽകൂ';

  @override
  String accrueMonthSalary(String amount) {
    return 'മാസ ശമ്പളം ചേർക്കൂ (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'മാസ ശമ്പളം ചേർക്കൂ';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name ന്റെ കുടിശ്ശികയിൽ ഈ മാസം ₹$amount ചേർക്കണോ?';
  }
}
