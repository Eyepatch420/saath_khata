import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bho.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_mai.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bho'),
    Locale('bn'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('kn'),
    Locale('mai'),
    Locale('ml'),
    Locale('mr'),
    Locale('pa'),
    Locale('ta'),
    Locale('te'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Saath Khata'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Ek Khata, Dono Ka'**
  String get tagline;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Two-Sided Shared Ledger'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'One Ledger for both Vendor and Customer. Both see the same truth.'**
  String get onboarding1Subtitle;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Voice & Bill OCR'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Speak or scan bills to create entries instantly in 12 languages.'**
  String get onboarding2Subtitle;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'One-Tap UPI Payment'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Settle your month-end dues with a single tap via UPI.'**
  String get onboarding3Subtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get chooseLanguage;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @chooseRole.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get chooseRole;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @welcomeToSaathKhata.
  ///
  /// In en, this message translates to:
  /// **'Welcome to SaathKhata'**
  String get welcomeToSaathKhata;

  /// No description provided for @tellUsHowYouUse.
  ///
  /// In en, this message translates to:
  /// **'Tell us how you will use the app'**
  String get tellUsHowYouUse;

  /// No description provided for @vendorRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'I am a Vendor / Seller'**
  String get vendorRoleTitle;

  /// No description provided for @vendorRoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage my business ledger, staff, and collect payments.'**
  String get vendorRoleSubtitle;

  /// No description provided for @customerRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'I am a Customer / Buyer'**
  String get customerRoleTitle;

  /// No description provided for @customerRoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track my khata with local vendors and pay via UPI.'**
  String get customerRoleSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login to SaathKhata'**
  String get loginTitle;

  /// No description provided for @enterMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to continue'**
  String get enterMobile;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @verifyAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get verifyAndContinue;

  /// No description provided for @changePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Phone Number'**
  String get changePhoneNumber;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to +91 {phoneNumber}'**
  String otpSentTo(String phoneNumber);

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get loginButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @pleaseEnterCredentials.
  ///
  /// In en, this message translates to:
  /// **'Please enter email and password'**
  String get pleaseEnterCredentials;

  /// No description provided for @fillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in name, email and password'**
  String get fillRequiredFields;

  /// No description provided for @passwordMinChars.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get passwordMinChars;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @egBusinessName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Krishna Dairy'**
  String get egBusinessName;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter area or full address'**
  String get enterAddress;

  /// No description provided for @upiHint.
  ///
  /// In en, this message translates to:
  /// **'yourname@upi'**
  String get upiHint;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @businessCategory.
  ///
  /// In en, this message translates to:
  /// **'Business Category'**
  String get businessCategory;

  /// No description provided for @businessAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Address (Optional)'**
  String get businessAddress;

  /// No description provided for @upiId.
  ///
  /// In en, this message translates to:
  /// **'UPI ID (For Payments)'**
  String get upiId;

  /// No description provided for @vendorDashboard.
  ///
  /// In en, this message translates to:
  /// **'Vendor Dashboard'**
  String get vendorDashboard;

  /// No description provided for @customerDashboard.
  ///
  /// In en, this message translates to:
  /// **'Customer Dashboard'**
  String get customerDashboard;

  /// No description provided for @customerMode.
  ///
  /// In en, this message translates to:
  /// **'Customer Mode'**
  String get customerMode;

  /// No description provided for @myVendors.
  ///
  /// In en, this message translates to:
  /// **'My Vendors'**
  String get myVendors;

  /// No description provided for @outstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get outstanding;

  /// No description provided for @collectedToday.
  ///
  /// In en, this message translates to:
  /// **'Collected Today'**
  String get collectedToday;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @scanBill.
  ///
  /// In en, this message translates to:
  /// **'Scan Bill'**
  String get scanBill;

  /// No description provided for @remindAll.
  ///
  /// In en, this message translates to:
  /// **'Remind All'**
  String get remindAll;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNew;

  /// No description provided for @recentCustomers.
  ///
  /// In en, this message translates to:
  /// **'Recent Customers'**
  String get recentCustomers;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @customerAddedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'{name} added'**
  String customerAddedSnackbar(String name);

  /// No description provided for @sharedLedger.
  ///
  /// In en, this message translates to:
  /// **'Shared Ledger'**
  String get sharedLedger;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'TOTAL BALANCE'**
  String get totalBalance;

  /// No description provided for @statement.
  ///
  /// In en, this message translates to:
  /// **'Statement'**
  String get statement;

  /// No description provided for @giveCredit.
  ///
  /// In en, this message translates to:
  /// **'GIVE CREDIT'**
  String get giveCredit;

  /// No description provided for @recordPayment.
  ///
  /// In en, this message translates to:
  /// **'RECORD PAYMENT'**
  String get recordPayment;

  /// No description provided for @giveCreditSheet.
  ///
  /// In en, this message translates to:
  /// **'Give Credit'**
  String get giveCreditSheet;

  /// No description provided for @recordPaymentSheet.
  ///
  /// In en, this message translates to:
  /// **'Record Payment'**
  String get recordPaymentSheet;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @balanceCustomerOwes.
  ///
  /// In en, this message translates to:
  /// **'Customer owes you'**
  String get balanceCustomerOwes;

  /// No description provided for @balanceYouOwe.
  ///
  /// In en, this message translates to:
  /// **'You owe customer'**
  String get balanceYouOwe;

  /// No description provided for @balanceSettled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get balanceSettled;

  /// No description provided for @balanceYouOweVendor.
  ///
  /// In en, this message translates to:
  /// **'You owe vendor'**
  String get balanceYouOweVendor;

  /// No description provided for @balanceVendorOwesYou.
  ///
  /// In en, this message translates to:
  /// **'Vendor owes you'**
  String get balanceVendorOwesYou;

  /// No description provided for @ledgerInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'How this ledger works'**
  String get ledgerInfoTitle;

  /// No description provided for @statusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get statusConfirmed;

  /// No description provided for @statusConfirmedDesc.
  ///
  /// In en, this message translates to:
  /// **'Both parties agreed. Entry is locked and cannot be changed.'**
  String get statusConfirmedDesc;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusPendingDesc.
  ///
  /// In en, this message translates to:
  /// **'Awaiting customer confirmation. Auto-confirmed after 72 hours.'**
  String get statusPendingDesc;

  /// No description provided for @statusDisputed.
  ///
  /// In en, this message translates to:
  /// **'Disputed'**
  String get statusDisputed;

  /// No description provided for @statusDisputedDesc.
  ///
  /// In en, this message translates to:
  /// **'Customer raised a dispute. Vendor review required.'**
  String get statusDisputedDesc;

  /// No description provided for @statusAutoConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Auto-Confirmed'**
  String get statusAutoConfirmed;

  /// No description provided for @entryTypeCreditLabel.
  ///
  /// In en, this message translates to:
  /// **'Credit Entry'**
  String get entryTypeCreditLabel;

  /// No description provided for @entryTypePaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Received'**
  String get entryTypePaymentLabel;

  /// No description provided for @entryDetails.
  ///
  /// In en, this message translates to:
  /// **'Entry Details'**
  String get entryDetails;

  /// No description provided for @entryAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get entryAmount;

  /// No description provided for @entryType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get entryType;

  /// No description provided for @entryTypeCreditGiven.
  ///
  /// In en, this message translates to:
  /// **'Credit (Given)'**
  String get entryTypeCreditGiven;

  /// No description provided for @entryTypePaymentReceived.
  ///
  /// In en, this message translates to:
  /// **'Payment (Received)'**
  String get entryTypePaymentReceived;

  /// No description provided for @entryDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get entryDate;

  /// No description provided for @entryDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get entryDescription;

  /// No description provided for @entryQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get entryQuantity;

  /// No description provided for @entryConfirmedAt.
  ///
  /// In en, this message translates to:
  /// **'Confirmed At'**
  String get entryConfirmedAt;

  /// No description provided for @entryDisputeReason.
  ///
  /// In en, this message translates to:
  /// **'Dispute Reason'**
  String get entryDisputeReason;

  /// No description provided for @entryFor.
  ///
  /// In en, this message translates to:
  /// **'for {name}'**
  String entryFor(String name);

  /// No description provided for @descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptional;

  /// No description provided for @quantityOptional.
  ///
  /// In en, this message translates to:
  /// **'Quantity (optional)'**
  String get quantityOptional;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2L Milk, Monthly groceries'**
  String get descriptionHint;

  /// No description provided for @quantityHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2'**
  String get quantityHint;

  /// No description provided for @addCreditEntry.
  ///
  /// In en, this message translates to:
  /// **'ADD CREDIT ENTRY'**
  String get addCreditEntry;

  /// No description provided for @noLedgerTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noLedgerTransactions;

  /// No description provided for @noLedgerTransactionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a credit or payment entry to get started.'**
  String get noLedgerTransactionsSubtitle;

  /// No description provided for @confirmEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Entry'**
  String get confirmEntryTitle;

  /// No description provided for @confirmEntryMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to confirm ₹{amount} entry? This action cannot be undone.'**
  String confirmEntryMessage(String amount);

  /// No description provided for @dispute.
  ///
  /// In en, this message translates to:
  /// **'Dispute'**
  String get dispute;

  /// No description provided for @raiseDisputeTitle.
  ///
  /// In en, this message translates to:
  /// **'Raise a Dispute'**
  String get raiseDisputeTitle;

  /// No description provided for @raiseDisputeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Describe what is incorrect about this entry.'**
  String get raiseDisputeSubtitle;

  /// No description provided for @raiseDisputeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Amount should be ₹50, not ₹60'**
  String get raiseDisputeHint;

  /// No description provided for @submitDispute.
  ///
  /// In en, this message translates to:
  /// **'Submit Dispute'**
  String get submitDispute;

  /// No description provided for @staffAndLabour.
  ///
  /// In en, this message translates to:
  /// **'Staff & Labour'**
  String get staffAndLabour;

  /// No description provided for @addStaff.
  ///
  /// In en, this message translates to:
  /// **'Add Staff'**
  String get addStaff;

  /// No description provided for @presentToday.
  ///
  /// In en, this message translates to:
  /// **'Present Today'**
  String get presentToday;

  /// No description provided for @unpaidSalary.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Salary'**
  String get unpaidSalary;

  /// No description provided for @paySalary.
  ///
  /// In en, this message translates to:
  /// **'Pay Salary'**
  String get paySalary;

  /// No description provided for @noStaffAdded.
  ///
  /// In en, this message translates to:
  /// **'No staff added yet'**
  String get noStaffAdded;

  /// No description provided for @noStaffAddedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to add your first staff member.'**
  String get noStaffAddedSubtitle;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @absent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get absent;

  /// No description provided for @halfDay.
  ///
  /// In en, this message translates to:
  /// **'Half Day'**
  String get halfDay;

  /// No description provided for @paySalaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay Salary'**
  String get paySalaryTitle;

  /// No description provided for @unpaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Unpaid: ₹{amount}'**
  String unpaidLabel(String amount);

  /// No description provided for @upiTransactionIdOptional.
  ///
  /// In en, this message translates to:
  /// **'UPI Transaction ID (optional)'**
  String get upiTransactionIdOptional;

  /// No description provided for @noDues.
  ///
  /// In en, this message translates to:
  /// **'No Dues'**
  String get noDues;

  /// No description provided for @staffPayAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay ₹{amount}'**
  String staffPayAmount(String amount);

  /// No description provided for @staffJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined {date}'**
  String staffJoined(String date);

  /// No description provided for @staffSalaryPerDay.
  ///
  /// In en, this message translates to:
  /// **'₹{amount}/day'**
  String staffSalaryPerDay(String amount);

  /// No description provided for @staffSalaryPerMonth.
  ///
  /// In en, this message translates to:
  /// **'₹{amount}/month'**
  String staffSalaryPerMonth(String amount);

  /// No description provided for @staffPayButton.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get staffPayButton;

  /// No description provided for @businessReports.
  ///
  /// In en, this message translates to:
  /// **'Business Reports'**
  String get businessReports;

  /// No description provided for @revenueTrend.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get revenueTrend;

  /// No description provided for @collectionSummary.
  ///
  /// In en, this message translates to:
  /// **'Collection Summary'**
  String get collectionSummary;

  /// No description provided for @totalOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Total Outstanding'**
  String get totalOutstanding;

  /// No description provided for @totalCollected.
  ///
  /// In en, this message translates to:
  /// **'Total Collected'**
  String get totalCollected;

  /// No description provided for @topCustomers.
  ///
  /// In en, this message translates to:
  /// **'Top Customers'**
  String get topCustomers;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @settingsManagePayments.
  ///
  /// In en, this message translates to:
  /// **'Manage payment accounts'**
  String get settingsManagePayments;

  /// No description provided for @settingsManageAlerts.
  ///
  /// In en, this message translates to:
  /// **'Manage alerts and reminders'**
  String get settingsManageAlerts;

  /// No description provided for @settingsAppPinFingerprint.
  ///
  /// In en, this message translates to:
  /// **'App PIN and Fingerprint'**
  String get settingsAppPinFingerprint;

  /// No description provided for @settingsFaqsContact.
  ///
  /// In en, this message translates to:
  /// **'FAQs and Contact Us'**
  String get settingsFaqsContact;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(String version);

  /// No description provided for @myUpiIds.
  ///
  /// In en, this message translates to:
  /// **'My UPI IDs'**
  String get myUpiIds;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @noNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsTitle;

  /// No description provided for @noNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You will see ledger updates, payment alerts and reminders here.'**
  String get noNotificationsSubtitle;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String hoursAgo(int count);

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transactionHistory;

  /// No description provided for @totalPaid.
  ///
  /// In en, this message translates to:
  /// **'Total Paid'**
  String get totalPaid;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @quickPay.
  ///
  /// In en, this message translates to:
  /// **'Quick Pay'**
  String get quickPay;

  /// No description provided for @scanAndPay.
  ///
  /// In en, this message translates to:
  /// **'SCAN & PAY'**
  String get scanAndPay;

  /// No description provided for @scanUpiDesc.
  ///
  /// In en, this message translates to:
  /// **'Scan any UPI QR to pay your vendor'**
  String get scanUpiDesc;

  /// No description provided for @noTransactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get noTransactionsTitle;

  /// No description provided for @noTransactionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your payment history will appear here.'**
  String get noTransactionsSubtitle;

  /// No description provided for @paymentStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paymentStatusPaid;

  /// No description provided for @paymentStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get paymentStatusFailed;

  /// No description provided for @paymentStatusRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get paymentStatusRefunded;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @keepBooking.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keepBooking;

  /// No description provided for @noBookingsToday.
  ///
  /// In en, this message translates to:
  /// **'No bookings for this day'**
  String get noBookingsToday;

  /// No description provided for @noBookingsTodaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customers can book appointments through the app.'**
  String get noBookingsTodaySubtitle;

  /// No description provided for @noAppointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No appointments yet'**
  String get noAppointmentsTitle;

  /// No description provided for @noAppointmentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Book an appointment with your vendor to get started.'**
  String get noAppointmentsSubtitle;

  /// No description provided for @cancelAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Appointment?'**
  String get cancelAppointmentTitle;

  /// No description provided for @cancelAppointmentMessage.
  ///
  /// In en, this message translates to:
  /// **'Cancel your appointment on {date} at {time}?'**
  String cancelAppointmentMessage(String date, String time);

  /// No description provided for @bookingStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get bookingStatusConfirmed;

  /// No description provided for @bookingStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bookingStatusPending;

  /// No description provided for @bookingStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get bookingStatusCancelled;

  /// No description provided for @bookingStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get bookingStatusCompleted;

  /// No description provided for @bookingStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get bookingStatusDone;

  /// No description provided for @upiPayment.
  ///
  /// In en, this message translates to:
  /// **'UPI Payment'**
  String get upiPayment;

  /// No description provided for @amountToPay.
  ///
  /// In en, this message translates to:
  /// **'Amount to pay'**
  String get amountToPay;

  /// No description provided for @securedByUpi.
  ///
  /// In en, this message translates to:
  /// **'Secured by UPI'**
  String get securedByUpi;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful!'**
  String get paymentSuccessful;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// No description provided for @retryPayment.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryPayment;

  /// No description provided for @enterUpiId.
  ///
  /// In en, this message translates to:
  /// **'Enter UPI ID'**
  String get enterUpiId;

  /// No description provided for @addNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Add a note (optional)'**
  String get addNoteOptional;

  /// No description provided for @payAmountButton.
  ///
  /// In en, this message translates to:
  /// **'PAY ₹{amount}'**
  String payAmountButton(String amount);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done;

  /// No description provided for @paymentSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get paymentSomethingWentWrong;

  /// No description provided for @upiAppComingSoon.
  ///
  /// In en, this message translates to:
  /// **'{app} integration coming soon'**
  String upiAppComingSoon(String app);

  /// No description provided for @pleaseEnterUpiId.
  ///
  /// In en, this message translates to:
  /// **'Please enter a UPI ID'**
  String get pleaseEnterUpiId;

  /// No description provided for @paidToRecipient.
  ///
  /// In en, this message translates to:
  /// **'₹{amount} paid to {name}'**
  String paidToRecipient(String amount, String name);

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orDivider;

  /// No description provided for @addNewCustomer.
  ///
  /// In en, this message translates to:
  /// **'Add New Customer'**
  String get addNewCustomer;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @mobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNo;

  /// No description provided for @addCustomer.
  ///
  /// In en, this message translates to:
  /// **'ADD CUSTOMER'**
  String get addCustomer;

  /// No description provided for @paymentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM PAYMENT'**
  String get paymentConfirmed;

  /// No description provided for @addAdvance.
  ///
  /// In en, this message translates to:
  /// **'Add Advance'**
  String get addAdvance;

  /// No description provided for @addAdvanceTitle.
  ///
  /// In en, this message translates to:
  /// **'ADD ADVANCE'**
  String get addAdvanceTitle;

  /// No description provided for @attendanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendanceTitle;

  /// No description provided for @salaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Salary Summary'**
  String get salaryTitle;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @daysPresent.
  ///
  /// In en, this message translates to:
  /// **'Days Present'**
  String get daysPresent;

  /// No description provided for @earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earned;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @advanceTaken.
  ///
  /// In en, this message translates to:
  /// **'Advance Taken'**
  String get advanceTaken;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @noPhone.
  ///
  /// In en, this message translates to:
  /// **'No phone'**
  String get noPhone;

  /// No description provided for @addNewStaff.
  ///
  /// In en, this message translates to:
  /// **'Add New Staff'**
  String get addNewStaff;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @salaryType.
  ///
  /// In en, this message translates to:
  /// **'Salary Type'**
  String get salaryType;

  /// No description provided for @dailyWage.
  ///
  /// In en, this message translates to:
  /// **'Daily Wage'**
  String get dailyWage;

  /// No description provided for @monthlySalary.
  ///
  /// In en, this message translates to:
  /// **'Monthly Salary'**
  String get monthlySalary;

  /// No description provided for @dailyWageAmount.
  ///
  /// In en, this message translates to:
  /// **'Daily Wage (₹)'**
  String get dailyWageAmount;

  /// No description provided for @monthlySalaryAmount.
  ///
  /// In en, this message translates to:
  /// **'Monthly Salary (₹)'**
  String get monthlySalaryAmount;

  /// No description provided for @addStaffButton.
  ///
  /// In en, this message translates to:
  /// **'ADD STAFF'**
  String get addStaffButton;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @amountRupees.
  ///
  /// In en, this message translates to:
  /// **'Amount (₹)'**
  String get amountRupees;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @alignBillInFrame.
  ///
  /// In en, this message translates to:
  /// **'Align bill within the frame'**
  String get alignBillInFrame;

  /// No description provided for @verifyAndLogin.
  ///
  /// In en, this message translates to:
  /// **'Verify & Login'**
  String get verifyAndLogin;

  /// No description provided for @voiceListening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get voiceListening;

  /// No description provided for @voiceThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get voiceThinking;

  /// No description provided for @voiceDetectedEntry.
  ///
  /// In en, this message translates to:
  /// **'Detected Entry'**
  String get voiceDetectedEntry;

  /// No description provided for @voiceConfirmEntry.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM ENTRY'**
  String get voiceConfirmEntry;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @totalOutstandingBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Outstanding Balance'**
  String get totalOutstandingBalance;

  /// No description provided for @payAllDues.
  ///
  /// In en, this message translates to:
  /// **'PAY ALL DUES'**
  String get payAllDues;

  /// No description provided for @myKhatas.
  ///
  /// In en, this message translates to:
  /// **'My Khatas'**
  String get myKhatas;

  /// No description provided for @noVendorsFound.
  ///
  /// In en, this message translates to:
  /// **'No vendors found'**
  String get noVendorsFound;

  /// No description provided for @verifyBillDetails.
  ///
  /// In en, this message translates to:
  /// **'Verify Bill Details'**
  String get verifyBillDetails;

  /// No description provided for @scannedBillPreview.
  ///
  /// In en, this message translates to:
  /// **'Scanned Bill Preview'**
  String get scannedBillPreview;

  /// No description provided for @descriptionItemDetails.
  ///
  /// In en, this message translates to:
  /// **'Description / Item Details'**
  String get descriptionItemDetails;

  /// No description provided for @selectCustomer.
  ///
  /// In en, this message translates to:
  /// **'Select Customer'**
  String get selectCustomer;

  /// No description provided for @searchCustomerHint.
  ///
  /// In en, this message translates to:
  /// **'Search or select customer'**
  String get searchCustomerHint;

  /// No description provided for @saveToKhata.
  ///
  /// In en, this message translates to:
  /// **'SAVE TO KHATA'**
  String get saveToKhata;

  /// No description provided for @allCustomersReport.
  ///
  /// In en, this message translates to:
  /// **'All Customers Report'**
  String get allCustomersReport;

  /// No description provided for @collectedInMonth.
  ///
  /// In en, this message translates to:
  /// **'Collected in {month}'**
  String collectedInMonth(String month);

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @securityPin.
  ///
  /// In en, this message translates to:
  /// **'Security & PIN'**
  String get securityPin;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @legalInfo.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legalInfo;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @changePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'CHANGE PASSWORD'**
  String get changePasswordButton;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @loadingContent.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingContent;

  /// No description provided for @failedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load content. Please try again.'**
  String get failedToLoad;

  /// No description provided for @bookingActions.
  ///
  /// In en, this message translates to:
  /// **'Booking Actions'**
  String get bookingActions;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @markComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get markComplete;

  /// No description provided for @confirmBookingMessage.
  ///
  /// In en, this message translates to:
  /// **'Confirm the appointment on {date} at {time} for {customer}?'**
  String confirmBookingMessage(String date, String time, String customer);

  /// No description provided for @bookingUpdated.
  ///
  /// In en, this message translates to:
  /// **'Booking updated successfully'**
  String get bookingUpdated;

  /// No description provided for @bookingUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update booking'**
  String get bookingUpdateFailed;

  /// No description provided for @markAttendanceFor.
  ///
  /// In en, this message translates to:
  /// **'Mark Attendance — {date}'**
  String markAttendanceFor(String date);

  /// No description provided for @allCustomers.
  ///
  /// In en, this message translates to:
  /// **'All Customers'**
  String get allCustomers;

  /// No description provided for @noCustomersYet.
  ///
  /// In en, this message translates to:
  /// **'No customers yet'**
  String get noCustomersYet;

  /// No description provided for @noCustomersYetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first customer to get started'**
  String get noCustomersYetSubtitle;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 10-digit mobile number starting with 6–9'**
  String get invalidPhone;

  /// No description provided for @accrueMonthSalary.
  ///
  /// In en, this message translates to:
  /// **'Add Month\'s Salary (₹{amount})'**
  String accrueMonthSalary(String amount);

  /// No description provided for @accrueMonthSalaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Month\'s Salary'**
  String get accrueMonthSalaryTitle;

  /// No description provided for @accrueMonthSalaryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Add ₹{amount} to {name}\'s unpaid balance for this month?'**
  String accrueMonthSalaryConfirm(String name, String amount);

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @updateProfileDetails.
  ///
  /// In en, this message translates to:
  /// **'Update your name, photo and details'**
  String get updateProfileDetails;

  /// No description provided for @updateAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'Update your account password'**
  String get updateAccountPassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account and all data'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get deleteAccountConfirmation;

  /// No description provided for @deleteAccountConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all your data. This action cannot be undone.'**
  String get deleteAccountConfirmationMessage;

  /// No description provided for @deleteAccountStaffWarning.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account. This cannot be undone.'**
  String get deleteAccountStaffWarning;

  /// No description provided for @deleteForever.
  ///
  /// In en, this message translates to:
  /// **'Delete Forever'**
  String get deleteForever;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @readTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Read our terms of service'**
  String get readTermsOfService;

  /// No description provided for @privacyPolicyDescription.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get privacyPolicyDescription;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogout;

  /// No description provided for @membershipTiers.
  ///
  /// In en, this message translates to:
  /// **'Membership Tiers'**
  String get membershipTiers;

  /// No description provided for @membershipTiersDescription.
  ///
  /// In en, this message translates to:
  /// **'Rename tiers and set member discounts'**
  String get membershipTiersDescription;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @enterPhoneNumberToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to continue'**
  String get enterPhoneNumberToContinue;

  /// No description provided for @otpDemoHint.
  ///
  /// In en, this message translates to:
  /// **'OTP is for demo only · enter 123456 to continue'**
  String get otpDemoHint;

  /// No description provided for @havingTrouble.
  ///
  /// In en, this message translates to:
  /// **'Having trouble?'**
  String get havingTrouble;

  /// No description provided for @useEmailInstead.
  ///
  /// In en, this message translates to:
  /// **'Use email instead →'**
  String get useEmailInstead;

  /// No description provided for @logInWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Log in with email'**
  String get logInWithEmail;

  /// No description provided for @emailPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailPlaceholder;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @tapToAddProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to add profile photo'**
  String get tapToAddProfilePhoto;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addUpiId.
  ///
  /// In en, this message translates to:
  /// **'Add UPI ID'**
  String get addUpiId;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @percent.
  ///
  /// In en, this message translates to:
  /// **'Percent'**
  String get percent;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @paymentVerification.
  ///
  /// In en, this message translates to:
  /// **'Payment Verification'**
  String get paymentVerification;

  /// No description provided for @verifyingPayment.
  ///
  /// In en, this message translates to:
  /// **'Verifying Payment'**
  String get verifyingPayment;

  /// No description provided for @paymentConfirmedExclamation.
  ///
  /// In en, this message translates to:
  /// **'Payment Confirmed!'**
  String get paymentConfirmedExclamation;

  /// No description provided for @verificationTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Verification Timed Out'**
  String get verificationTimedOut;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @payDues.
  ///
  /// In en, this message translates to:
  /// **'Pay Dues'**
  String get payDues;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// No description provided for @allDone.
  ///
  /// In en, this message translates to:
  /// **'All Done!'**
  String get allDone;

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'No upcoming appointments'**
  String get noUpcomingAppointments;

  /// No description provided for @myPay.
  ///
  /// In en, this message translates to:
  /// **'My Pay'**
  String get myPay;

  /// No description provided for @myPaymentQr.
  ///
  /// In en, this message translates to:
  /// **'My Payment QR'**
  String get myPaymentQr;

  /// No description provided for @showMyQr.
  ///
  /// In en, this message translates to:
  /// **'Show my QR'**
  String get showMyQr;

  /// No description provided for @noPaymentsYet.
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get noPaymentsYet;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// No description provided for @paymentHistory6Months.
  ///
  /// In en, this message translates to:
  /// **'Payment History (6 months)'**
  String get paymentHistory6Months;

  /// No description provided for @connectionRequest.
  ///
  /// In en, this message translates to:
  /// **'Connection Request'**
  String get connectionRequest;

  /// No description provided for @vendorWantsToConnect.
  ///
  /// In en, this message translates to:
  /// **'A vendor wants to connect'**
  String get vendorWantsToConnect;

  /// No description provided for @acceptRequest.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptRequest;

  /// No description provided for @declineRequest.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get declineRequest;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @requestSentNotification.
  ///
  /// In en, this message translates to:
  /// **'Request sent! They will be notified to confirm.'**
  String get requestSentNotification;

  /// No description provided for @awaitingAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Awaiting Acceptance'**
  String get awaitingAcceptance;

  /// No description provided for @addAVendor.
  ///
  /// In en, this message translates to:
  /// **'Add a Vendor'**
  String get addAVendor;

  /// No description provided for @findByPhoneOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Find by phone number or email'**
  String get findByPhoneOrEmail;

  /// No description provided for @phoneOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Phone or email'**
  String get phoneOrEmail;

  /// No description provided for @phoneOrEmailHint.
  ///
  /// In en, this message translates to:
  /// **'10-digit mobile or email address'**
  String get phoneOrEmailHint;

  /// No description provided for @nicknameOptional.
  ///
  /// In en, this message translates to:
  /// **'Nickname (optional)'**
  String get nicknameOptional;

  /// No description provided for @howYouKnowVendor.
  ///
  /// In en, this message translates to:
  /// **'How you know this vendor'**
  String get howYouKnowVendor;

  /// No description provided for @bookingNoteExample.
  ///
  /// In en, this message translates to:
  /// **'E.g. Need extra milk today'**
  String get bookingNoteExample;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @moveMapToSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Move the map to select a location'**
  String get moveMapToSelectLocation;

  /// No description provided for @searchPlaceHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a place…'**
  String get searchPlaceHint;

  /// No description provided for @mapAttribution.
  ///
  /// In en, this message translates to:
  /// **'© OpenStreetMap contributors'**
  String get mapAttribution;

  /// No description provided for @searchVendorsHint.
  ///
  /// In en, this message translates to:
  /// **'Search vendors…'**
  String get searchVendorsHint;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @payViaUpi.
  ///
  /// In en, this message translates to:
  /// **'Pay via UPI'**
  String get payViaUpi;

  /// No description provided for @connectWithVendor.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connectWithVendor;

  /// No description provided for @requestConnection.
  ///
  /// In en, this message translates to:
  /// **'Request Connection'**
  String get requestConnection;

  /// No description provided for @addVendor.
  ///
  /// In en, this message translates to:
  /// **'Add Vendor'**
  String get addVendor;

  /// No description provided for @noOutstandingBalances.
  ///
  /// In en, this message translates to:
  /// **'No outstanding balances'**
  String get noOutstandingBalances;

  /// No description provided for @allCustomersSettledUp.
  ///
  /// In en, this message translates to:
  /// **'All customers are settled up.'**
  String get allCustomersSettledUp;

  /// No description provided for @nothingCollectedToday.
  ///
  /// In en, this message translates to:
  /// **'Nothing collected today'**
  String get nothingCollectedToday;

  /// No description provided for @paymentsWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Payments received today will appear here.'**
  String get paymentsWillAppearHere;

  /// No description provided for @customerReport.
  ///
  /// In en, this message translates to:
  /// **'Customer Report'**
  String get customerReport;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @tapToStop.
  ///
  /// In en, this message translates to:
  /// **'Tap to stop'**
  String get tapToStop;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemName;

  /// No description provided for @itemNameExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Milk'**
  String get itemNameExample;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price ₹'**
  String get unitPrice;

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliverTo;

  /// No description provided for @bulkCharge.
  ///
  /// In en, this message translates to:
  /// **'Bulk Charge'**
  String get bulkCharge;

  /// No description provided for @newProduct.
  ///
  /// In en, this message translates to:
  /// **'New product'**
  String get newProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @newProductService.
  ///
  /// In en, this message translates to:
  /// **'New Product / Service'**
  String get newProductService;

  /// No description provided for @updateProductDetails.
  ///
  /// In en, this message translates to:
  /// **'Update name, unit or price'**
  String get updateProductDetails;

  /// No description provided for @defineProduct.
  ///
  /// In en, this message translates to:
  /// **'Define what you sell and its base price'**
  String get defineProduct;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get productName;

  /// No description provided for @productNameExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Daily Morning Milk'**
  String get productNameExample;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @unitExample.
  ///
  /// In en, this message translates to:
  /// **'litre / kg / piece'**
  String get unitExample;

  /// No description provided for @pricePerUnit.
  ///
  /// In en, this message translates to:
  /// **'Price / unit (₹)'**
  String get pricePerUnit;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete product'**
  String get deleteProduct;

  /// No description provided for @deleteProductConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete product?'**
  String get deleteProductConfirmation;

  /// No description provided for @removeProductConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from your product list?'**
  String removeProductConfirmation(String name);

  /// No description provided for @noProductsYet.
  ///
  /// In en, this message translates to:
  /// **'No products yet'**
  String get noProductsYet;

  /// No description provided for @addFirstProduct.
  ///
  /// In en, this message translates to:
  /// **'Add First Product'**
  String get addFirstProduct;

  /// No description provided for @renameTier.
  ///
  /// In en, this message translates to:
  /// **'Rename tier'**
  String get renameTier;

  /// No description provided for @tierName.
  ///
  /// In en, this message translates to:
  /// **'Tier name'**
  String get tierName;

  /// No description provided for @tierLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String tierLevel(int level);

  /// No description provided for @memberDiscount.
  ///
  /// In en, this message translates to:
  /// **'Member discount'**
  String get memberDiscount;

  /// No description provided for @discountFor.
  ///
  /// In en, this message translates to:
  /// **'Discount for {tier}'**
  String discountFor(String tier);

  /// No description provided for @flatAmount.
  ///
  /// In en, this message translates to:
  /// **'Flat ₹'**
  String get flatAmount;

  /// No description provided for @discountPercent.
  ///
  /// In en, this message translates to:
  /// **'Discount %'**
  String get discountPercent;

  /// No description provided for @discountAmount.
  ///
  /// In en, this message translates to:
  /// **'Discount amount (₹)'**
  String get discountAmount;

  /// No description provided for @percentExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 5'**
  String get percentExample;

  /// No description provided for @amountExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 50'**
  String get amountExample;

  /// No description provided for @maxDiscountPerDue.
  ///
  /// In en, this message translates to:
  /// **'Max discount per due (₹) — optional'**
  String get maxDiscountPerDue;

  /// No description provided for @maxDiscountExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 100 (leave blank for no cap)'**
  String get maxDiscountExample;

  /// No description provided for @saveDiscount.
  ///
  /// In en, this message translates to:
  /// **'Save discount'**
  String get saveDiscount;

  /// No description provided for @membership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membership;

  /// No description provided for @setTier.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get setTier;

  /// No description provided for @changeTier.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeTier;

  /// No description provided for @applyMembership.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyMembership;

  /// No description provided for @removeMembership.
  ///
  /// In en, this message translates to:
  /// **'Remove membership'**
  String get removeMembership;

  /// No description provided for @removeLedgerConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Remove ledger?'**
  String get removeLedgerConfirmation;

  /// No description provided for @exportStatement.
  ///
  /// In en, this message translates to:
  /// **'Export Statement'**
  String get exportStatement;

  /// No description provided for @appAccess.
  ///
  /// In en, this message translates to:
  /// **'App access'**
  String get appAccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bho',
    'bn',
    'en',
    'gu',
    'hi',
    'kn',
    'mai',
    'ml',
    'mr',
    'pa',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bho':
      return AppLocalizationsBho();
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'mai':
      return AppLocalizationsMai();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
