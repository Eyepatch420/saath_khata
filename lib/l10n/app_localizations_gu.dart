// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'સાથખાતા';

  @override
  String get tagline => 'એક ખાતું, બંનેનું';

  @override
  String get onboarding1Title => 'બે-તરફી શેર ખાતું';

  @override
  String get onboarding1Subtitle =>
      'વિક્રેતા અને ગ્રાહક બંને માટે એક ખાતું. બંને એક જ સત્ય જુએ છે.';

  @override
  String get onboarding2Title => 'વૉઇસ અને બિલ OCR';

  @override
  String get onboarding2Subtitle =>
      '12 ભાષાઓમાં તરત જ એન્ટ્રી બનાવવા માટે બોલો અથવા બિલ સ્કૅન કરો.';

  @override
  String get onboarding3Title => 'એક ટૅપમાં UPI ચુકવણી';

  @override
  String get onboarding3Subtitle => 'UPI દ્વારા એક ટૅપમાં મહિનાની બાકી ચુકવો.';

  @override
  String get getStarted => 'શરૂ કરો';

  @override
  String get next => 'આગળ';

  @override
  String get skip => 'છોડો';

  @override
  String get chooseLanguage => 'તમારી ભાષા પસંદ કરો';

  @override
  String get continueButton => 'ચાલુ રાખો';

  @override
  String get chooseRole => 'તમારી ભૂમિકા પસંદ કરો';

  @override
  String get vendor => 'વિક્રેતા';

  @override
  String get customer => 'ગ્રાહક';

  @override
  String get welcomeToSaathKhata => 'સાથખાતામાં આપનું સ્વાગત છે';

  @override
  String get tellUsHowYouUse => 'અમને જણાવો તમે ઍપ કેવી રીતે વાપરશો';

  @override
  String get vendorRoleTitle => 'હું વિક્રેતા છું';

  @override
  String get vendorRoleSubtitle =>
      'વ્યવસાયનું ખાતું, કર્મચારીઓ સંચાલિત કરો અને ચુકવણી લો.';

  @override
  String get customerRoleTitle => 'હું ગ્રાહક છું';

  @override
  String get customerRoleSubtitle =>
      'વિક્રેતા સાથે ખાતું ટ્રૅક કરો અને UPI દ્વારા ચૂકવો.';

  @override
  String get loginTitle => 'સાથખાતામાં લૉગ ઇન કરો';

  @override
  String get enterMobile => 'ચાલુ રાખવા માટે તમારી માહિતી દાખલ કરો';

  @override
  String get mobileNumber => 'મોબાઇલ નંબર';

  @override
  String get sendOtp => 'OTP મોકલો';

  @override
  String get verifyOtp => 'OTP ચકાસો';

  @override
  String get verifyAndContinue => 'ચકાસો અને ચાલુ રાખો';

  @override
  String get changePhoneNumber => 'ફોન નંબર બદલો';

  @override
  String otpSentTo(String phoneNumber) {
    return '+91 $phoneNumber પર મોકલેલ 6 અંકનો કોડ દાખલ કરો';
  }

  @override
  String get email => 'ઈ-મેઇલ';

  @override
  String get password => 'પાસવર્ડ';

  @override
  String get passwordHint => 'પાસવર્ડ દાખલ કરો';

  @override
  String get loginButton => 'લૉગ ઇન';

  @override
  String get noAccount => 'ખાતું નથી?';

  @override
  String get signUp => 'નોંધણી કરો';

  @override
  String get pleaseEnterCredentials => 'ઈ-મેઇલ અને પાસવર્ડ દાખલ કરો';

  @override
  String get fillRequiredFields => 'નામ, ઈ-મેઇલ અને પાસવર્ડ ભરો';

  @override
  String get passwordMinChars => 'ઓછામાં ઓછા 8 અક્ષરો';

  @override
  String get completeProfile => 'પ્રોફાઇલ પૂર્ણ કરો';

  @override
  String get enterYourName => 'તમારું નામ દાખલ કરો';

  @override
  String get egBusinessName => 'દા.ત. કૃષ્ણ ડેરી';

  @override
  String get selectCategory => 'શ્રેણી પસંદ કરો';

  @override
  String get enterAddress => 'વિસ્તાર અથવા સંપૂર્ણ સરનામું દાખલ કરો';

  @override
  String get upiHint => 'yourname@upi';

  @override
  String get fullName => 'પૂરું નામ';

  @override
  String get businessName => 'વ્યવસાયનું નામ';

  @override
  String get businessCategory => 'વ્યવસાય શ્રેણી';

  @override
  String get businessAddress => 'વ્યવસાયનું સરનામું (વૈકલ્પિક)';

  @override
  String get upiId => 'UPI ID (ચુકવણી માટે)';

  @override
  String get vendorDashboard => 'વિક્રેતા ડૅશબોર્ડ';

  @override
  String get customerDashboard => 'ગ્રાહક ડૅશબોર્ડ';

  @override
  String get customerMode => 'ગ્રાહક મોડ';

  @override
  String get myVendors => 'મારા વિક્રેતા';

  @override
  String get outstanding => 'બાકી';

  @override
  String get collectedToday => 'આજે ઉઘરાણું';

  @override
  String get quickActions => 'ઝડપી ક્રિયાઓ';

  @override
  String get scanBill => 'બિલ સ્કૅન કરો';

  @override
  String get remindAll => 'બધાને યાદ કરાવો';

  @override
  String get addNew => 'નવું ઉમેરો';

  @override
  String get recentCustomers => 'તાજેતરના ગ્રાહકો';

  @override
  String get viewAll => 'બધું જુઓ';

  @override
  String customerAddedSnackbar(String name) {
    return '$name ઉમેરાયો';
  }

  @override
  String get sharedLedger => 'શેર ખાતું';

  @override
  String get totalBalance => 'કુલ બૅલૅન્સ';

  @override
  String get statement => 'નિવેદન';

  @override
  String get giveCredit => 'ઉધાર આપો';

  @override
  String get recordPayment => 'ચુકવણી નોંધો';

  @override
  String get giveCreditSheet => 'ઉધાર આપો';

  @override
  String get recordPaymentSheet => 'ચુકવણી નોંધો';

  @override
  String get filterAll => 'બધું';

  @override
  String get balanceCustomerOwes => 'ગ્રાહકની બાકી';

  @override
  String get balanceYouOwe => 'તમારી બાકી';

  @override
  String get balanceSettled => 'ચૂકતે';

  @override
  String get balanceYouOweVendor => 'તમારે વ્યાપારીને ચૂકવવાનું છે';

  @override
  String get balanceVendorOwesYou => 'વ્યાપારી તમને ચૂકવશે';

  @override
  String get ledgerInfoTitle => 'આ ખાતું કેવી રીતે કામ કરે છે';

  @override
  String get statusConfirmed => 'પુષ્ટિ થઈ';

  @override
  String get statusConfirmedDesc =>
      'બંને પક્ષ સહમત. એન્ટ્રી લૉક છે અને બદલી શકાય નહીં.';

  @override
  String get statusPending => 'બાકી';

  @override
  String get statusPendingDesc =>
      'ગ્રાહકની પુષ્ટિ માટે રાહ. 72 કલાકમાં આપોઆપ પુષ્ટિ.';

  @override
  String get statusDisputed => 'વિવાદિત';

  @override
  String get statusDisputedDesc =>
      'ગ્રાહકે વિવાદ ઉઠાવ્યો. વિક્રેતાની સમીક્ષા જરૂરી.';

  @override
  String get statusAutoConfirmed => 'આપોઆપ પુષ્ટિ';

  @override
  String get entryTypeCreditLabel => 'ઉધાર એન્ટ્રી';

  @override
  String get entryTypePaymentLabel => 'ચુકવણી મળી';

  @override
  String get entryDetails => 'એન્ટ્રી વિગત';

  @override
  String get entryAmount => 'રકમ';

  @override
  String get entryType => 'પ્રકાર';

  @override
  String get entryTypeCreditGiven => 'ઉધાર (આપ્યું)';

  @override
  String get entryTypePaymentReceived => 'ચુકવણી (મળ્યું)';

  @override
  String get entryDate => 'તારીખ';

  @override
  String get entryDescription => 'વર્ણન';

  @override
  String get entryQuantity => 'જથ્થો';

  @override
  String get entryConfirmedAt => 'પુષ્ટિ તારીખ';

  @override
  String get entryDisputeReason => 'વિવાદનું કારણ';

  @override
  String entryFor(String name) {
    return '$name માટે';
  }

  @override
  String get descriptionOptional => 'વર્ણન (વૈકલ્પિક)';

  @override
  String get quantityOptional => 'જથ્થો (વૈકલ્પિક)';

  @override
  String get descriptionHint => 'દા.ત. 2L દૂધ, મહિના કરિયાણું';

  @override
  String get quantityHint => 'દા.ત. 2';

  @override
  String get addCreditEntry => 'ઉધાર એન્ટ્રી ઉમેરો';

  @override
  String get noLedgerTransactions => 'હજુ કોઈ વ્યવહાર નથી';

  @override
  String get noLedgerTransactionsSubtitle =>
      'શરૂ કરવા ઉધાર અથવા ચુકવણી એન્ટ્રી ઉમેરો.';

  @override
  String get confirmEntryTitle => 'એન્ટ્રી પુષ્ટિ કરો';

  @override
  String confirmEntryMessage(String amount) {
    return '₹$amount ની એન્ટ્રી પુષ્ટિ કરવી છે? આ પૂર્વવત્ ન થઈ શકે.';
  }

  @override
  String get dispute => 'વિવાદ';

  @override
  String get raiseDisputeTitle => 'વિવાદ ઉઠાવો';

  @override
  String get raiseDisputeSubtitle => 'આ એન્ટ્રીમાં શું ખોટું છે તે સમજાવો.';

  @override
  String get raiseDisputeHint => 'દા.ત. રકમ ₹50 હોવી જોઈએ, ₹60 નહીં';

  @override
  String get submitDispute => 'વિવાદ સબમિટ કરો';

  @override
  String get staffAndLabour => 'કર્મચારી અને મજૂર';

  @override
  String get addStaff => 'કર્મચારી ઉમેરો';

  @override
  String get presentToday => 'આજે હાજર';

  @override
  String get unpaidSalary => 'ન ચૂકવેલ પગાર';

  @override
  String get paySalary => 'પગાર આપો';

  @override
  String get noStaffAdded => 'હજુ કોઈ કર્મચારી નથી';

  @override
  String get noStaffAddedSubtitle => 'પ્રથમ કર્મચારી ઉમેરવા નીચેનું બટન દબાવો.';

  @override
  String get present => 'હાજર';

  @override
  String get absent => 'ગેરહાજર';

  @override
  String get halfDay => 'અડધો દિવસ';

  @override
  String get paySalaryTitle => 'પગાર આપો';

  @override
  String unpaidLabel(String amount) {
    return 'ન ચૂકવેલ: ₹$amount';
  }

  @override
  String get upiTransactionIdOptional => 'UPI વ્યવહાર ID (વૈકલ્પિક)';

  @override
  String get noDues => 'કોઈ બાકી નથી';

  @override
  String staffPayAmount(String amount) {
    return '₹$amount આપો';
  }

  @override
  String staffJoined(String date) {
    return '$date ના રોજ જોડાયા';
  }

  @override
  String staffSalaryPerDay(String amount) {
    return '₹$amount/દિવસ';
  }

  @override
  String staffSalaryPerMonth(String amount) {
    return '₹$amount/મહિનો';
  }

  @override
  String get staffPayButton => 'ચુકવણી';

  @override
  String get businessReports => 'વ્યવસાય અહેવાલ';

  @override
  String get revenueTrend => 'આવક વલણ';

  @override
  String get collectionSummary => 'ઉઘરાણું સારાંશ';

  @override
  String get totalOutstanding => 'કુલ બાકી';

  @override
  String get totalCollected => 'કુલ ઉઘરાણું';

  @override
  String get topCustomers => 'ટોચના ગ્રાહકો';

  @override
  String get seeAll => 'બધું જુઓ';

  @override
  String get settings => 'સેટિંગ્સ';

  @override
  String get appLanguage => 'ઍપ ભાષા';

  @override
  String get selectLanguage => 'ભાષા પસંદ કરો';

  @override
  String get settingsManagePayments => 'ચુકવણી ખાતા સંચાલિત કરો';

  @override
  String get settingsManageAlerts => 'ચેતવણી અને રિમાઇન્ડર સંચાલિત કરો';

  @override
  String get settingsAppPinFingerprint => 'ઍપ પિન અને ફિંગરપ્રિન્ટ';

  @override
  String get settingsFaqsContact => 'સહાય અને સંપર્ક';

  @override
  String settingsVersion(String version) {
    return 'આવૃત્તિ $version';
  }

  @override
  String get myUpiIds => 'મારા UPI ID';

  @override
  String get notifications => 'સૂચનાઓ';

  @override
  String get security => 'સુરક્ષા';

  @override
  String get helpSupport => 'સહાય';

  @override
  String get logout => 'લૉગ આઉટ';

  @override
  String get markAllRead => 'બધું વાંચ્યું ગણો';

  @override
  String get noNotificationsTitle => 'હજુ કોઈ સૂચનાઓ નથી';

  @override
  String get noNotificationsSubtitle =>
      'અહીં ખાતા અપડેટ, ચુકવણી ચેતવણી અને રિમાઇન્ડર દેખાશે.';

  @override
  String get today => 'આજે';

  @override
  String get yesterday => 'ગઈ કાલે';

  @override
  String minutesAgo(int count) {
    return '$count મિનિટ પહેલાં';
  }

  @override
  String hoursAgo(int count) {
    return '$count કલાક પહેલાં';
  }

  @override
  String get payments => 'ચુકવણી';

  @override
  String get transactionHistory => 'વ્યવહાર ઇતિહાસ';

  @override
  String get totalPaid => 'કુલ ચૂકવ્યું';

  @override
  String get pending => 'બાકી';

  @override
  String get quickPay => 'ઝડપી ચુકવણી';

  @override
  String get scanAndPay => 'સ્કૅન કરો અને ચૂકવો';

  @override
  String get scanUpiDesc => 'વિક્રેતાને ચૂકવવા UPI QR સ્કૅન કરો';

  @override
  String get noTransactionsTitle => 'હજુ કોઈ વ્યવહાર નથી';

  @override
  String get noTransactionsSubtitle => 'તમારો ચુકવણી ઇતિહાસ અહીં દેખાશે.';

  @override
  String get paymentStatusPaid => 'ચૂક્વ્યું';

  @override
  String get paymentStatusFailed => 'નિષ્ફળ';

  @override
  String get paymentStatusRefunded => 'પાછું';

  @override
  String get appointments => 'મુલાકાત';

  @override
  String get myAppointments => 'મારી મુલાકાત';

  @override
  String get upcoming => 'આગામી';

  @override
  String get past => 'ભૂતકાળ';

  @override
  String get cancelBooking => 'બુકિંગ રદ કરો';

  @override
  String get keepBooking => 'રાખો';

  @override
  String get noBookingsToday => 'આજે કોઈ બુકિંગ નથી';

  @override
  String get noBookingsTodaySubtitle =>
      'ગ્રાહકો ઍપ દ્વારા મુલાકાત બુક કરી શકે છે.';

  @override
  String get noAppointmentsTitle => 'હજુ કોઈ મુલાકાત નથી';

  @override
  String get noAppointmentsSubtitle =>
      'શરૂ કરવા તમારા વિક્રેતા સાથે મુલાકાત બુક કરો.';

  @override
  String get cancelAppointmentTitle => 'મુલાકાત રદ કરવી?';

  @override
  String cancelAppointmentMessage(String date, String time) {
    return '$date ના $time ની મુલાકાત રદ કરવી?';
  }

  @override
  String get bookingStatusConfirmed => 'પુષ્ટિ થઈ';

  @override
  String get bookingStatusPending => 'બાકી';

  @override
  String get bookingStatusCancelled => 'રદ';

  @override
  String get bookingStatusCompleted => 'પૂર્ણ';

  @override
  String get bookingStatusDone => 'પૂર્ણ';

  @override
  String get upiPayment => 'UPI ચુકવણી';

  @override
  String get amountToPay => 'ચૂકવવાની રકમ';

  @override
  String get securedByUpi => 'UPI દ્વારા સુરક્ષિત';

  @override
  String get paymentSuccessful => 'ચુકવણી સફળ!';

  @override
  String get paymentFailed => 'ચુકવણી નિષ્ફળ';

  @override
  String get retryPayment => 'ફરી પ્રયાસ કરો';

  @override
  String get enterUpiId => 'UPI ID દાખલ કરો';

  @override
  String get addNoteOptional => 'નોંધ ઉમેરો (વૈકલ્પિક)';

  @override
  String payAmountButton(String amount) {
    return '₹$amount ચૂકવો';
  }

  @override
  String get done => 'થઈ ગયું';

  @override
  String get paymentSomethingWentWrong => 'કંઈક ખોટું થયું. ફરી પ્રયાસ કરો.';

  @override
  String upiAppComingSoon(String app) {
    return '$app ટૂંક સમયમાં આવે છે';
  }

  @override
  String get pleaseEnterUpiId => 'UPI ID દાખલ કરો';

  @override
  String paidToRecipient(String amount, String name) {
    return '₹$amount $name ને ચૂક્વ્યું';
  }

  @override
  String get orDivider => 'અથવા';

  @override
  String get addNewCustomer => 'નવો ગ્રાહક ઉમેરો';

  @override
  String get customerName => 'ગ્રાહકનું નામ';

  @override
  String get mobileNo => 'મોબાઇલ નંબર';

  @override
  String get addCustomer => 'ગ્રાહક ઉમેરો';

  @override
  String get paymentConfirmed => 'ચુકવણી પુષ્ટિ કરો';

  @override
  String get addAdvance => 'આગોતરું ઉમેરો';

  @override
  String get addAdvanceTitle => 'આગોતરું ઉમેરો';

  @override
  String get attendanceTitle => 'હાજરી';

  @override
  String get salaryTitle => 'પગાર સારાંશ';

  @override
  String get rate => 'દર';

  @override
  String get daysPresent => 'હાજરીના દિવસો';

  @override
  String get earned => 'કમાયું';

  @override
  String get unpaid => 'ન ચૂકવેલ';

  @override
  String get advanceTaken => 'લીધેલ આગોતરું';

  @override
  String get active => 'સક્રિય';

  @override
  String get inactive => 'નિષ્ક્રિય';

  @override
  String get joined => 'જોડાયા';

  @override
  String get noPhone => 'ફોન નથી';

  @override
  String get addNewStaff => 'નવો કર્મચારી ઉમેરો';

  @override
  String get fullNameLabel => 'પૂરું નામ';

  @override
  String get phoneNumber => 'ફોન નંબર';

  @override
  String get role => 'ભૂમિકા';

  @override
  String get salaryType => 'પગારનો પ્રકાર';

  @override
  String get dailyWage => 'દૈનિક મજૂરી';

  @override
  String get monthlySalary => 'માસિક પગાર';

  @override
  String get dailyWageAmount => 'દૈનિક મજૂરી (₹)';

  @override
  String get monthlySalaryAmount => 'માસિક પગાર (₹)';

  @override
  String get addStaffButton => 'કર્મચારી ઉમેરો';

  @override
  String get noteOptional => 'નોંધ (વૈકલ્પિક)';

  @override
  String get amountRupees => 'રકમ (₹)';

  @override
  String get cancel => 'રદ';

  @override
  String get confirm => 'પુષ્ટિ';

  @override
  String get tryAgain => 'ફરી પ્રયાસ કરો';

  @override
  String get alignBillInFrame => 'બિલ ફ્રેમમાં ગોઠવો';

  @override
  String get verifyAndLogin => 'ચકાસો અને લૉગ ઇન કરો';

  @override
  String get voiceListening => 'સાંભળી રહ્યો છું...';

  @override
  String get voiceThinking => 'વિચારી રહ્યો છું...';

  @override
  String get voiceDetectedEntry => 'શોધેલ એન્ટ્રી';

  @override
  String get voiceConfirmEntry => 'એન્ટ્રી પુષ્ટિ કરો';

  @override
  String get item => 'વસ્તુ';

  @override
  String get totalOutstandingBalance => 'કુલ બાકી રકમ';

  @override
  String get payAllDues => 'બધી બાકી ચૂકવો';

  @override
  String get myKhatas => 'મારા ખાતા';

  @override
  String get noVendorsFound => 'કોઈ વિક્રેતા મળ્યા નહીં';

  @override
  String get verifyBillDetails => 'બિલ વિગત ચકાસો';

  @override
  String get scannedBillPreview => 'સ્કૅન કરેલ બિલ';

  @override
  String get descriptionItemDetails => 'વર્ણન / વસ્તુ વિગત';

  @override
  String get selectCustomer => 'ગ્રાહક પસંદ કરો';

  @override
  String get searchCustomerHint => 'ગ્રાહક શોધો અથવા પસંદ કરો';

  @override
  String get saveToKhata => 'ખાતામાં સૅવ કરો';

  @override
  String get allCustomersReport => 'બધા ગ્રાહકોનો અહેવાલ';

  @override
  String collectedInMonth(String month) {
    return '$monthમાં ઉઘરાણું';
  }

  @override
  String get notificationSettings => 'સૂચના સેટિંગ્સ';

  @override
  String get securityPin => 'સુરક્ષા અને પિન';

  @override
  String get editProfile => 'પ્રોફાઇલ સંપાદિત કરો';

  @override
  String get changePassword => 'પાસવર્ડ બદલો';

  @override
  String get termsAndConditions => 'નિયમો અને શરતો';

  @override
  String get privacyPolicy => 'ગોપનીયતા નીતિ';

  @override
  String get accountSettings => 'ખાતા સેટિંગ્સ';

  @override
  String get legalInfo => 'કાનૂની';

  @override
  String get currentPassword => 'વર્તમાન પાસવર્ડ';

  @override
  String get newPassword => 'નવો પાસવર્ડ';

  @override
  String get confirmNewPassword => 'નવો પાસવર્ડ પુષ્ટિ કરો';

  @override
  String get passwordsDoNotMatch => 'પાસવર્ડ મળતા નથી';

  @override
  String get changePasswordButton => 'પાસવર્ડ બદલો';

  @override
  String get passwordChangedSuccess => 'પાસવર્ડ સફળતાપૂર્વક બદલાયો';

  @override
  String get loadingContent => 'લોડ થઈ રહ્યું છે...';

  @override
  String get failedToLoad => 'સામગ્રી લોડ કરવામાં નિષ્ફળ. ફરી પ્રયાસ કરો.';

  @override
  String get bookingActions => 'બુકિંગ ક્રિયાઓ';

  @override
  String get confirmBooking => 'બુકિંગ પુષ્ટિ કરો';

  @override
  String get markComplete => 'પૂર્ણ ગણો';

  @override
  String confirmBookingMessage(String date, String time, String customer) {
    return '$customer ની $date ના $time ની મુલાકાત પુષ્ટિ કરવી?';
  }

  @override
  String get bookingUpdated => 'બુકિંગ સફળતાપૂર્વક અપડેટ થઈ';

  @override
  String get bookingUpdateFailed => 'બુકિંગ અપડેટ કરવામાં નિષ્ફળ';

  @override
  String markAttendanceFor(String date) {
    return 'હાજરી નોંધો — $date';
  }

  @override
  String get allCustomers => 'બધા ગ્રાહકો';

  @override
  String get noCustomersYet => 'હજુ કોઈ ગ્રાહક નથી';

  @override
  String get noCustomersYetSubtitle => 'શરૂ કરવા પ્રથમ ગ્રાહક ઉમેરો';

  @override
  String get invalidPhone =>
      '6–9 થી શરૂ થતો 10 અંકનો માન્ય મોબાઇલ નંબર દાખલ કરો';

  @override
  String accrueMonthSalary(String amount) {
    return 'મહિનો પગાર ઉમેરો (₹$amount)';
  }

  @override
  String get accrueMonthSalaryTitle => 'મહિનો પગાર ઉમેરો';

  @override
  String accrueMonthSalaryConfirm(String name, String amount) {
    return '$name ની બાકીમાં આ મહિને ₹$amount ઉમેરવું?';
  }

  @override
  String get accountInformation => 'ખાતા માહિતી';

  @override
  String get updateProfileDetails => 'તમારું નામ, ફોટો અને વિગત અપડેટ કરો';

  @override
  String get updateAccountPassword => 'તમારો ખાતા પાસવર્ડ અપડેટ કરો';

  @override
  String get deleteAccount => 'ખાતું ભૂંસો';

  @override
  String get deleteAccountSubtitle => 'ખાતું અને બધો ડેટા કાયમ માટે ભૂંસો';

  @override
  String get deleteAccountConfirmation => 'ખાતું ભૂંસવું?';

  @override
  String get deleteAccountConfirmationMessage =>
      'આ તમારું ખાતું અને બધો ડેટા કાયમ માટે ભૂંસી નાખશે. આ ક્રિયા ઉલટાવી શકાશે નહીં.';

  @override
  String get deleteAccountStaffWarning =>
      'આ તમારું ખાતું કાયમ માટે ભૂંસી નાખશે. આ ઉલટાવી શકાશે નહીં.';

  @override
  String get deleteForever => 'કાયમ માટે ભૂંસો';

  @override
  String get delete => 'ભૂંસો';

  @override
  String get readTermsOfService => 'અમારી સેવા શરતો વાંચો';

  @override
  String get privacyPolicyDescription => 'અમે તમારો ડેટા કેવી રીતે સંભાળીએ છીએ';

  @override
  String get confirmLogout => 'શું તમે ખરેખર લૉગ આઉટ કરવા માંગો છો?';

  @override
  String get membershipTiers => 'સભ્યપદ સ્તર';

  @override
  String get membershipTiersDescription =>
      'સ્તરોનું નામ બદલો અને સભ્ય ડિસ્કાઉન્ટ સેટ કરો';

  @override
  String get logIn => 'લૉગ ઇન';

  @override
  String get enterPhoneNumberToContinue => 'ચાલુ રાખવા ફોન નંબર દાખલ કરો';

  @override
  String get otpDemoHint =>
      'OTP ફક્ત ડેમો માટે છે · ચાલુ રાખવા 123456 દાખલ કરો';

  @override
  String get havingTrouble => 'મુશ્કેલી છે?';

  @override
  String get useEmailInstead => 'ઈ-મેઇલ દ્વારા લૉગ ઇન →';

  @override
  String get logInWithEmail => 'ઈ-મેઇલ દ્વારા લૉગ ઇન';

  @override
  String get emailPlaceholder => 'you@example.com';

  @override
  String get enterYourPassword => 'પાસવર્ડ દાખલ કરો';

  @override
  String get takePhoto => 'ફોટો લો';

  @override
  String get chooseFromGallery => 'ગેલેરીમાંથી પસંદ કરો';

  @override
  String get removePhoto => 'ફોટો દૂર કરો';

  @override
  String get tapToAddProfilePhoto => 'પ્રોફાઇલ ફોટો ઉમેરવા ટૅપ કરો';

  @override
  String get camera => 'કૅમેરા';

  @override
  String get gallery => 'ગેલેરી';

  @override
  String get add => 'ઉમેરો';

  @override
  String get addUpiId => 'UPI ID ઉમેરો';

  @override
  String get save => 'સૅવ કરો';

  @override
  String get close => 'બંધ કરો';

  @override
  String get ok => 'ઠીક છે';

  @override
  String get remove => 'દૂર કરો';

  @override
  String get approve => 'મંજૂર કરો';

  @override
  String get decline => 'નકારો';

  @override
  String get none => 'કોઈ નહીં';

  @override
  String get percent => 'ટકા';

  @override
  String get profile => 'પ્રોફાઇલ';

  @override
  String get paymentVerification => 'ચુકવણી ચકાસણી';

  @override
  String get verifyingPayment => 'ચુકવણી ચકાસાઈ રહી છે';

  @override
  String get paymentConfirmedExclamation => 'ચુકવણી પુષ્ટિ!';

  @override
  String get verificationTimedOut => 'ચકાસણીનો સમય સમાપ્ત';

  @override
  String get goBack => 'પાછળ જાઓ';

  @override
  String get payDues => 'બાકી ચૂકવો';

  @override
  String get skipForNow => 'હમણા છોડો';

  @override
  String get allDone => 'બધું થઈ ગયું!';

  @override
  String get noUpcomingAppointments => 'કોઈ આગામી મુલાકાત નથી';

  @override
  String get myPay => 'મારો પગાર';

  @override
  String get myPaymentQr => 'મારો ચુકવણી QR';

  @override
  String get showMyQr => 'મારો QR બતાવો';

  @override
  String get noPaymentsYet => 'હજુ કોઈ ચુકવણી નથી';

  @override
  String get paymentHistory => 'ચુકવણી ઇતિહાસ';

  @override
  String get paymentHistory6Months => 'ચુકવણી ઇતિહાસ (6 મહિના)';

  @override
  String get connectionRequest => 'કનેક્શન વિનંતી';

  @override
  String get vendorWantsToConnect => 'એક વિક્રેતા જોડવા ઇચ્છે છે';

  @override
  String get acceptRequest => 'સ્વીકારો';

  @override
  String get declineRequest => 'નકારો';

  @override
  String get messageLabel => 'સંદેશ';

  @override
  String get sendRequest => 'વિનંતી મોકલો';

  @override
  String get requestSentNotification =>
      'વિનંતી મોકલી! તેમને પુષ્ટિ માટે જાણ કરાશે.';

  @override
  String get awaitingAcceptance => 'સ્વીકૃતિ રાહ';

  @override
  String get addAVendor => 'વિક્રેતા ઉમેરો';

  @override
  String get findByPhoneOrEmail => 'ફોન નંબર અથવા ઈ-મેઇલ દ્વારા શોધો';

  @override
  String get phoneOrEmail => 'ફોન અથવા ઈ-મેઇલ';

  @override
  String get phoneOrEmailHint => '10 અંક મોબાઇલ અથવા ઈ-મેઇલ સરનામું';

  @override
  String get nicknameOptional => 'ઉપનામ (વૈકલ્પિક)';

  @override
  String get howYouKnowVendor => 'તમે આ વિક્રેતાને કેવી રીતે ઓળખો છો';

  @override
  String get bookingNoteExample => 'દા.ત. આજે વધારાનું દૂધ જોઈએ';

  @override
  String get confirmLocation => 'સ્થાન પુષ્ટિ કરો';

  @override
  String get moveMapToSelectLocation => 'સ્થાન પસંદ કરવા નકશો ખસેડો';

  @override
  String get searchPlaceHint => 'કોઈ સ્થળ શોધો…';

  @override
  String get mapAttribution => '© OpenStreetMap contributors';

  @override
  String get searchVendorsHint => 'વિક્રેતા શોધો…';

  @override
  String get somethingWentWrong => 'કંઈક ખોટું ગયું';

  @override
  String get payViaUpi => 'UPI થી ચૂકવો';

  @override
  String get connectWithVendor => 'જોડો';

  @override
  String get requestConnection => 'કનેક્શન વિનંતી';

  @override
  String get addVendor => 'વિક્રેતા ઉમેરો';

  @override
  String get noOutstandingBalances => 'કોઈ બાકી રકમ નથી';

  @override
  String get allCustomersSettledUp => 'બધા ગ્રાહકોનો હિસાબ ચૂકતો છે.';

  @override
  String get nothingCollectedToday => 'આજે કંઈ ઉઘરાયું નથી';

  @override
  String get paymentsWillAppearHere => 'આજે મળેલ ચુકવણી અહીં દેખાશે.';

  @override
  String get customerReport => 'ગ્રાહક અહેવાલ';

  @override
  String get overview => 'ઝલક';

  @override
  String get tapToStop => 'થોભવા ટૅપ કરો';

  @override
  String get itemName => 'વસ્તુનું નામ';

  @override
  String get itemNameExample => 'દા.ત. દૂધ';

  @override
  String get unitPrice => 'પ્રતિ એકમ ભાવ ₹';

  @override
  String get deliverTo => 'ડિલિવરી કરો';

  @override
  String get bulkCharge => 'બલ્ક ચાર્જ';

  @override
  String get newProduct => 'નવી વસ્તુ';

  @override
  String get editProduct => 'વસ્તુ સંપાદિત કરો';

  @override
  String get newProductService => 'નવી વસ્તુ / સેવા';

  @override
  String get updateProductDetails => 'નામ, એકમ અથવા ભાવ અપડેટ કરો';

  @override
  String get defineProduct => 'તમે શું વેચો છો અને તેનો ભાવ નક્કી કરો';

  @override
  String get productName => 'વસ્તુનું નામ';

  @override
  String get productNameExample => 'દા.ત. સવારનું દૂધ';

  @override
  String get unit => 'એકમ';

  @override
  String get unitExample => 'લીટર / કિલો / ટુકડો';

  @override
  String get pricePerUnit => 'પ્રતિ એકમ ભાવ (₹)';

  @override
  String get deleteProduct => 'વસ્તુ ભૂંસો';

  @override
  String get deleteProductConfirmation => 'વસ્તુ ભૂંસવી?';

  @override
  String removeProductConfirmation(String name) {
    return 'Remove \"$name\" from your product list?';
  }

  @override
  String get noProductsYet => 'હજુ કોઈ વસ્તુ નથી';

  @override
  String get addFirstProduct => 'પ્રથમ વસ્તુ ઉમેરો';

  @override
  String get renameTier => 'સ્તરનું નામ બદલો';

  @override
  String get tierName => 'સ્તરનું નામ';

  @override
  String tierLevel(int level) {
    return 'Level $level';
  }

  @override
  String get memberDiscount => 'સભ્ય ડિસ્કાઉન્ટ';

  @override
  String discountFor(String tier) {
    return 'Discount for $tier';
  }

  @override
  String get flatAmount => 'ફ્લૅટ ₹';

  @override
  String get discountPercent => 'ડિસ્કાઉન્ટ %';

  @override
  String get discountAmount => 'ડિસ્કાઉન્ટ રકમ (₹)';

  @override
  String get percentExample => 'દા.ત. 5';

  @override
  String get amountExample => 'દા.ત. 50';

  @override
  String get maxDiscountPerDue => 'પ્રતિ બાકી મહત્તમ ડિસ્કાઉન્ટ (₹) — વૈકલ્પિક';

  @override
  String get maxDiscountExample => 'દા.ત. 100 (મર્યાદા ન હોય તો ખાલી છોડો)';

  @override
  String get saveDiscount => 'ડિસ્કાઉન્ટ સૅવ કરો';

  @override
  String get membership => 'સભ્યપદ';

  @override
  String get setTier => 'સેટ કરો';

  @override
  String get changeTier => 'બદલો';

  @override
  String get applyMembership => 'લાગુ કરો';

  @override
  String get removeMembership => 'સભ્યપદ દૂર કરો';

  @override
  String get removeLedgerConfirmation => 'ખાતું દૂર કરવું?';

  @override
  String get exportStatement => 'સ્ટેટમેન્ટ નિકાસ કરો';

  @override
  String get appAccess => 'ઍપ ઍક્સેસ';
}
