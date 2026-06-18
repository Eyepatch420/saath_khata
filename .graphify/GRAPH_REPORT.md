# Graph Report - .  (2026-06-18)

## Corpus Check
- 343 files · ~265,139 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1664 nodes · 1429 edges · 242 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output
- Edge kinds: contains: 1412 · calls: 16 · method: 1


## Input Scope
- Requested: auto
- Resolved: committed (source: cli)
- Included files: 343 · Candidates: 635
- Excluded: 0 untracked · 9143 ignored · 2 sensitive · 0 missing committed
- Recommendation: Use --scope all or graphify.yaml inputs.corpus for a knowledge-base folder.
## God Nodes (most connected - your core abstractions)
1. `Create()` - 6 edges
2. `Destroy()` - 6 edges
3. `MessageHandler()` - 5 edges
4. `Win32Window::WndProc()` - 4 edges
5. `GetClientArea()` - 3 edges
6. `UpdateTheme()` - 3 edges
7. `GetCommandLineArguments()` - 2 edges
8. `Utf8FromUtf16()` - 2 edges
9. `Scale()` - 2 edges
10. `EnableFullDpiSupportIfAvailable()` - 2 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Communities

### Community 0 - "API Endpoints"
Cohesion: 0.06
Nodes (1): ApiEndpoints

### Community 1 - "L10n (Base)"
Cohesion: 0.07
Nodes (2): AppLocalizations, _AppLocalizationsDelegate

### Community 2 - "L10n Bhojpuri"
Cohesion: 0.09
Nodes (1): AppLocalizationsBho

### Community 3 - "L10n Bengali"
Cohesion: 0.09
Nodes (1): AppLocalizationsBn

### Community 4 - "L10n English"
Cohesion: 0.09
Nodes (1): AppLocalizationsEn

### Community 5 - "L10n Gujarati"
Cohesion: 0.09
Nodes (1): AppLocalizationsGu

### Community 6 - "L10n Hindi"
Cohesion: 0.09
Nodes (1): AppLocalizationsHi

### Community 7 - "L10n Kannada"
Cohesion: 0.09
Nodes (1): AppLocalizationsKn

### Community 8 - "L10n Maithili"
Cohesion: 0.09
Nodes (1): AppLocalizationsMai

### Community 9 - "L10n Malayalam"
Cohesion: 0.09
Nodes (1): AppLocalizationsMl

### Community 10 - "L10n Marathi"
Cohesion: 0.09
Nodes (1): AppLocalizationsMr

### Community 11 - "L10n Punjabi"
Cohesion: 0.09
Nodes (1): AppLocalizationsPa

### Community 12 - "L10n Tamil"
Cohesion: 0.09
Nodes (1): AppLocalizationsTa

### Community 13 - "L10n Telugu"
Cohesion: 0.09
Nodes (1): AppLocalizationsTe

### Community 14 - "Voice Entry UI"
Cohesion: 0.09
Nodes (12): _DialogCard, _ErrorCard, _ListeningCard, _ListeningCardState, _LoadingCard, _ParsingCard, _ReviewCard, _ReviewCardState (+4 more)

### Community 15 - "Windows Runner"
Cohesion: 0.17
Nodes (16): Create(), Destroy(), EnableFullDpiSupportIfAvailable(), GetClientArea(), GetThisFromHandle(), GetWindowClass(), MessageHandler(), OnCreate() (+8 more)

### Community 16 - "Staff Detail Screen"
Cohesion: 0.10
Nodes (12): _ActionButtons, _AttendanceCalendar, _AttendanceCalendarState, _AttendanceOption, _CalendarLegend, _DayCell, _LegendItem, _ProfileCard (+4 more)

### Community 17 - "Storage Service"
Cohesion: 0.11
Nodes (1): StorageService

### Community 18 - "Bulk Charge Screen"
Cohesion: 0.11
Nodes (12): _BottomBar, BulkChargeScreen, _BulkChargeView, _CustomerGrid, _CustomerQtyRow, _EmptyTemplates, _NoCustomers, _SelectTemplateHint (+4 more)

### Community 19 - "Customer Dashboard"
Cohesion: 0.13
Nodes (9): CustomerDashboard, CustomerDashboardView, _NotifBadge, _PayAllDuesSheet, _PayAllDuesSheetState, _PendingVendorRequestsBanner, _PendingVendorRequestsBannerState, _UpcomingAppointmentsCard (+1 more)

### Community 20 - "Community 20"
Cohesion: 0.14
Nodes (7): _AmountDisplay, _FailureView, _OrDivider, _SuccessView, _UpiAppsRow, UpiPaymentScreen, _UpiPaymentScreenState

### Community 21 - "Community 21"
Cohesion: 0.15
Nodes (4): _CoordChip, _LocationCard, LocationPickerScreen, _LocationPickerScreenState

### Community 22 - "Community 22"
Cohesion: 0.15
Nodes (7): _PaySummary, _QrCard, _QrCardState, _SalaryHistory, _SalaryHistoryState, StaffPayScreen, _Stat

### Community 23 - "Community 23"
Cohesion: 0.17
Nodes (11): LinkRequestError, LinkRequestInitial, LinkRequestLoaded, LinkRequestLoading, LinkRequestResponded, LinkRequestState, SendRequestError, SendRequestIdle (+3 more)

### Community 24 - "Community 24"
Cohesion: 0.17
Nodes (5): AppRouter, CustomerMainWrapper, _CustomerMainWrapperState, VendorMainWrapper, _VendorMainWrapperState

### Community 25 - "Community 25"
Cohesion: 0.17
Nodes (6): _BookAppointmentBody, _BookAppointmentBodyState, BookAppointmentScreen, _DateStrip, _SlotChip, _SlotGrid

### Community 26 - "Community 26"
Cohesion: 0.17
Nodes (5): _BookingsList, _CustomerBookingCard, CustomerBookingsScreen, _CustomerBookingsScreenState, _StatusChip

### Community 27 - "Community 27"
Cohesion: 0.17
Nodes (6): _LiveDot, _LiveDotState, SharedLedgerScreen, _SharedLedgerScreenState, SharedLedgerView, _SharedLedgerViewState

### Community 28 - "Community 28"
Cohesion: 0.17
Nodes (9): _ActionCard, _CustomerTile, _NotifBadge, _PendingRequestsSection, _PendingRequestsSectionState, _PendingRequestTile, VendorDashboard, VendorDashboardView (+1 more)

### Community 29 - "Community 29"
Cohesion: 0.17
Nodes (8): _AvatarInitial, _CustomerCta, _InfoItem, _InfoSection, _ProfileScaffold, _VendorCta, VendorProfileScreen, _VendorProfileScreenState

### Community 30 - "Community 30"
Cohesion: 0.17
Nodes (10): _CategoryChip, _EmptyResult, _ErrorView, _Hint, _InitialFallback, _ResultCard, _ResultsList, _VendorAvatar (+2 more)

### Community 31 - "Community 31"
Cohesion: 0.17
Nodes (1): LedgerSocketService

### Community 32 - "Community 32"
Cohesion: 0.18
Nodes (1): AuthBloc

### Community 33 - "Community 33"
Cohesion: 0.18
Nodes (10): AuthCheckStatusRequested, AuthDeleteAccountRequested, AuthEmailLoginRequested, AuthEvent, AuthLogoutRequested, AuthOtpSendRequested, AuthOtpVerifyRequested, AuthProfileUpdateRequested (+2 more)

### Community 34 - "Community 34"
Cohesion: 0.18
Nodes (1): LedgerBloc

### Community 35 - "Community 35"
Cohesion: 0.18
Nodes (1): MembershipCubit

### Community 36 - "Community 36"
Cohesion: 0.18
Nodes (8): CollectedTodayItem, CustomerDetailReport, CustomerReportItem, MonthlyPaymentData, MonthlyRevenueData, MonthlyRevenueReport, PaginatedList, VendorSummaryReport

### Community 37 - "Community 37"
Cohesion: 0.18
Nodes (1): StaffRepositoryImpl

### Community 38 - "Community 38"
Cohesion: 0.18
Nodes (8): _FailedBody, _InProgressBody, _InProgressBodyState, PaymentVerificationScreen, _SuccessBody, _SuccessBodyState, _TimeoutBody, _VerificationView

### Community 39 - "Community 39"
Cohesion: 0.18
Nodes (7): _ActionTile, _BookingCard, _BookingsContent, _DateSelector, _StatusBadge, VendorBookingsScreen, _VendorBookingsView

### Community 40 - "Community 40"
Cohesion: 0.20
Nodes (1): BookingBloc

### Community 41 - "Community 41"
Cohesion: 0.20
Nodes (9): AddLedgerEntry, ConfirmLedgerEntry, DisputeLedgerEntry, FilterLedger, LedgerEvent, LoadLedger, RefreshLedger, SocketLedgerEntryAdded (+1 more)

### Community 42 - "Community 42"
Cohesion: 0.20
Nodes (1): StaffBloc

### Community 43 - "Community 43"
Cohesion: 0.20
Nodes (9): AccrueSalary, AddAdvance, AddStaff, LoadAttendance, LoadStaff, MarkAttendance, PaySalary, RefreshStaff (+1 more)

### Community 45 - "Community 45"
Cohesion: 0.20
Nodes (3): _CollectedTile, CollectedTodayScreen, _CollectedTodayScreenState

### Community 46 - "Community 46"
Cohesion: 0.22
Nodes (8): AuthAuthenticated, AuthError, AuthInitial, AuthLoading, AuthOtpSent, AuthOtpVerifiedNewUser, AuthState, AuthUnauthenticated

### Community 47 - "Community 47"
Cohesion: 0.22
Nodes (8): BookingEvent, CancelBooking, CreateBooking, LoadAvailableSlots, LoadCustomerBookings, LoadVendorBookings, SelectBookingDate, UpdateBookingStatus

### Community 48 - "Community 48"
Cohesion: 0.22
Nodes (8): BookingActionError, BookingCreated, BookingError, BookingInitial, BookingLoaded, BookingLoading, BookingState, SlotsLoaded

### Community 49 - "Community 49"
Cohesion: 0.22
Nodes (5): MembershipTiersCubit, MembershipTiersError, MembershipTiersLoaded, MembershipTiersLoading, MembershipTiersState

### Community 50 - "Community 50"
Cohesion: 0.22
Nodes (6): ReportsDashboardCubit, ReportsDashboardError, ReportsDashboardInitial, ReportsDashboardLoaded, ReportsDashboardLoading, ReportsDashboardState

### Community 51 - "Community 51"
Cohesion: 0.22
Nodes (1): BulkChargeCubit

### Community 52 - "Community 52"
Cohesion: 0.22
Nodes (2): ApiClient, _LoggingInterceptor

### Community 53 - "Community 53"
Cohesion: 0.22
Nodes (1): AuthRepositoryImpl

### Community 54 - "Community 54"
Cohesion: 0.22
Nodes (1): AuthRepository

### Community 55 - "Community 55"
Cohesion: 0.22
Nodes (1): MockStaffRepository

### Community 56 - "Community 56"
Cohesion: 0.22
Nodes (1): StaffRepository

### Community 57 - "Community 57"
Cohesion: 0.22
Nodes (3): OutstandingListScreen, _OutstandingListScreenState, _OutstandingTile

### Community 58 - "Community 58"
Cohesion: 0.22
Nodes (7): _PaymentsContent, PaymentsScreen, _PaymentsView, _PaymentTile, _QuickPayCard, _SummaryRow, _SummaryStat

### Community 59 - "Community 59"
Cohesion: 0.22
Nodes (2): ProfileSetupScreen, _ProfileSetupScreenState

### Community 60 - "Community 60"
Cohesion: 0.22
Nodes (7): _AttendanceTodayButton, _StaffCard, _StaffContent, StaffManagementScreen, _StaffSummaryBar, _StaffView, _SummaryItem

### Community 61 - "Community 61"
Cohesion: 0.22
Nodes (2): UpiManagementScreen, _UpiManagementScreenState

### Community 62 - "Community 62"
Cohesion: 0.22
Nodes (1): AppLogger

### Community 63 - "Community 63"
Cohesion: 0.22
Nodes (3): _CustomerDropdown, _RecordEntrySheet, _RecordEntrySheetState

### Community 64 - "Community 64"
Cohesion: 0.25
Nodes (6): AllCustomersReportCubit, AllCustomersReportError, AllCustomersReportInitial, AllCustomersReportLoaded, AllCustomersReportLoading, AllCustomersReportState

### Community 65 - "Community 65"
Cohesion: 0.25
Nodes (6): CustomerDetailCubit, CustomerDetailError, CustomerDetailInitial, CustomerDetailLoaded, CustomerDetailLoading, CustomerDetailState

### Community 66 - "Community 66"
Cohesion: 0.25
Nodes (2): LinkRequestCubit, SendLinkRequestCubit

### Community 67 - "Community 67"
Cohesion: 0.25
Nodes (1): NotificationBloc

### Community 68 - "Community 68"
Cohesion: 0.25
Nodes (2): PaymentVerificationBloc, _TimedOut

### Community 69 - "Community 69"
Cohesion: 0.25
Nodes (7): StaffActionLoading, StaffDetailLoaded, StaffError, StaffInitial, StaffLoaded, StaffLoading, StaffState

### Community 70 - "Community 70"
Cohesion: 0.25
Nodes (1): VoiceEntryCubit

### Community 71 - "Community 71"
Cohesion: 0.25
Nodes (3): _CupertinoFallbackDelegate, _MaterialFallbackDelegate, _WidgetsFallbackDelegate

### Community 72 - "Community 72"
Cohesion: 0.25
Nodes (1): LinkRequestRepositoryImpl

### Community 73 - "Community 73"
Cohesion: 0.25
Nodes (1): LinkRequestRepository

### Community 74 - "Community 74"
Cohesion: 0.25
Nodes (1): MembershipRepositoryImpl

### Community 75 - "Community 75"
Cohesion: 0.25
Nodes (1): MembershipRepository

### Community 76 - "Community 76"
Cohesion: 0.25
Nodes (1): MockVendorRepository

### Community 77 - "Community 77"
Cohesion: 0.25
Nodes (1): VendorRepositoryImpl

### Community 78 - "Community 78"
Cohesion: 0.25
Nodes (1): VendorRepository

### Community 79 - "Community 79"
Cohesion: 0.25
Nodes (3): _FallbackIcon, TapAnimatedRiveIcon, TapAnimatedRiveIconState

### Community 80 - "Community 80"
Cohesion: 0.25
Nodes (3): CustomerProfileScreen, _ProfileItem, _SectionHeader

### Community 81 - "Community 81"
Cohesion: 0.25
Nodes (2): EditProfileScreen, _EditProfileScreenState

### Community 82 - "Community 82"
Cohesion: 0.25
Nodes (4): _ProfileHeader, _SectionLabel, SettingsScreen, _SettingsTile

### Community 83 - "Community 83"
Cohesion: 0.25
Nodes (1): SpeechService

### Community 84 - "Community 84"
Cohesion: 0.25
Nodes (3): AppToast, _ToastBanner, _ToastBannerState

### Community 85 - "Community 85"
Cohesion: 0.25
Nodes (3): DiscountEditorSheet, _DiscountEditorSheetState, DiscountEditResult

### Community 86 - "Community 86"
Cohesion: 0.29
Nodes (6): LedgerActionLoading, LedgerError, LedgerInitial, LedgerLoaded, LedgerLoading, LedgerState

### Community 87 - "Community 87"
Cohesion: 0.29
Nodes (6): LoadNotifications, LoadUnreadCount, MarkAllNotificationsRead, MarkNotificationRead, NotificationArrived, NotificationEvent

### Community 88 - "Community 88"
Cohesion: 0.29
Nodes (6): PaymentVerificationFailed, PaymentVerificationInitial, PaymentVerificationInProgress, PaymentVerificationState, PaymentVerificationSuccess, PaymentVerificationTimeout

### Community 89 - "Community 89"
Cohesion: 0.29
Nodes (1): SearchCubit

### Community 90 - "Community 90"
Cohesion: 0.29
Nodes (6): VoiceEntryState, VoiceErrorState, VoiceIdle, VoiceListening, VoiceParsing, VoiceReview

### Community 91 - "Community 91"
Cohesion: 0.29
Nodes (2): SaathKhataApp, _SaathKhataAppState

### Community 92 - "Community 92"
Cohesion: 0.29
Nodes (5): CustomerLinkRequestScreen, _CustomerLinkRequestView, _ErrorView, _RequestBody, _VendorInfoCard

### Community 93 - "Community 93"
Cohesion: 0.29
Nodes (4): _NotificationCard, _NotificationsList, NotificationsScreen, _NotificationsView

### Community 94 - "Community 94"
Cohesion: 0.29
Nodes (2): OtpVerifyScreen, _OtpVerifyScreenState

### Community 95 - "Community 95"
Cohesion: 0.29
Nodes (1): AppBlocObserver

### Community 96 - "Community 96"
Cohesion: 0.29
Nodes (3): BookingConfirmationSheet, _BookingConfirmationSheetState, _InfoRow

### Community 97 - "Community 97"
Cohesion: 0.33
Nodes (5): CustomerError, CustomerInitial, CustomerLoaded, CustomerLoading, CustomerState

### Community 98 - "Community 98"
Cohesion: 0.33
Nodes (5): MembershipError, MembershipInitial, MembershipLoaded, MembershipLoading, MembershipState

### Community 99 - "Community 99"
Cohesion: 0.33
Nodes (5): NotificationError, NotificationInitial, NotificationLoaded, NotificationLoading, NotificationState

### Community 100 - "Community 100"
Cohesion: 0.33
Nodes (5): PaymentError, PaymentInitial, PaymentLoaded, PaymentLoading, PaymentState

### Community 101 - "Community 101"
Cohesion: 0.33
Nodes (5): SearchErrorState, SearchInitialState, SearchLoadedState, SearchLoadingState, SearchState

### Community 102 - "Community 102"
Cohesion: 0.33
Nodes (5): VendorError, VendorInitial, VendorLoaded, VendorLoading, VendorState

### Community 103 - "Community 103"
Cohesion: 0.33
Nodes (5): CustomerLinkItem, RemindAllResult, UserSummary, VendorLinkItem, VendorSummary

### Community 104 - "Community 104"
Cohesion: 0.33
Nodes (5): BulkChargeFailure, BulkChargeItem, BulkChargeResult, BulkChargeSuccess, ProductTemplate

### Community 105 - "Community 105"
Cohesion: 0.33
Nodes (1): LedgerRepositoryImpl

### Community 106 - "Community 106"
Cohesion: 0.33
Nodes (1): LedgerRepository

### Community 107 - "Community 107"
Cohesion: 0.33
Nodes (1): MockLedgerRepository

### Community 108 - "Community 108"
Cohesion: 0.33
Nodes (1): TemplateRepository

### Community 109 - "Community 109"
Cohesion: 0.33
Nodes (3): EmailLoginScreen, _EmailLoginScreenState, _InputField

### Community 110 - "Community 110"
Cohesion: 0.33
Nodes (3): MembershipTiersScreen, _MembershipTiersView, _TierList

### Community 111 - "Community 111"
Cohesion: 0.33
Nodes (4): _ErrorView, _RequestBody, VendorLinkRequestScreen, _VendorLinkRequestView

### Community 112 - "Community 112"
Cohesion: 0.33
Nodes (4): AppBottomNavBar, AppNavItem, _PillNavItem, _PillNavItemState

### Community 113 - "Community 113"
Cohesion: 0.33
Nodes (3): SalaryHistorySection, _SalaryHistorySectionState, _SalaryHistoryTile

### Community 114 - "Community 114"
Cohesion: 0.40
Nodes (2): StaffPortalCubit, StaffPortalState

### Community 115 - "Community 115"
Cohesion: 0.40
Nodes (1): MockBookingRepository

### Community 116 - "Community 116"
Cohesion: 0.40
Nodes (1): MockNotificationRepository

### Community 117 - "Community 117"
Cohesion: 0.40
Nodes (1): NotificationRepositoryImpl

### Community 118 - "Community 118"
Cohesion: 0.40
Nodes (1): NotificationRepository

### Community 120 - "Community 120"
Cohesion: 0.40
Nodes (2): PhoneEntryScreen, _PhoneEntryScreenState

### Community 121 - "Community 121"
Cohesion: 0.40
Nodes (2): PolicyScreen, _PolicyScreenState

### Community 122 - "Community 122"
Cohesion: 0.40
Nodes (2): SplashScreen, _SplashScreenState

### Community 123 - "Community 123"
Cohesion: 0.40
Nodes (3): _ActionButton, _CustomerRow, StaffHomeScreen

### Community 124 - "Community 124"
Cohesion: 0.40
Nodes (1): PushNotificationService

### Community 125 - "Community 125"
Cohesion: 0.40
Nodes (1): StatementPdfService

### Community 126 - "Community 126"
Cohesion: 0.40
Nodes (1): LedgerEntryCard

### Community 127 - "Community 127"
Cohesion: 0.40
Nodes (3): _CurrentTierRow, MembershipBanner, _PendingRequestCard

### Community 128 - "Community 128"
Cohesion: 0.50
Nodes (1): PaymentBloc

### Community 129 - "Community 129"
Cohesion: 0.50
Nodes (3): LoadPayments, PaymentEvent, RecordPayment

### Community 130 - "Community 130"
Cohesion: 0.50
Nodes (3): PaymentVerificationEvent, RetryPaymentVerification, StartPaymentVerification

### Community 131 - "Community 131"
Cohesion: 0.50
Nodes (1): VendorBloc

### Community 132 - "Community 132"
Cohesion: 0.50
Nodes (3): LoadVendorDashboard, RemindAllRequested, VendorEvent

### Community 133 - "Community 133"
Cohesion: 0.50
Nodes (1): StaffPortalRepository

### Community 134 - "Community 134"
Cohesion: 0.50
Nodes (1): LocaleProvider

### Community 135 - "Community 135"
Cohesion: 0.50
Nodes (3): AuthResponseModel, OtpVerifyResponseModel, TokensModel

### Community 136 - "Community 136"
Cohesion: 0.50
Nodes (2): AppointmentSlot, BookingModel

### Community 137 - "Community 137"
Cohesion: 0.50
Nodes (1): MembershipTier

### Community 138 - "Community 138"
Cohesion: 0.50
Nodes (2): AttendanceRecord, StaffModel

### Community 139 - "Community 139"
Cohesion: 0.50
Nodes (3): StaffProfile, UserModel, VendorProfile

### Community 140 - "Community 140"
Cohesion: 0.50
Nodes (1): BookingRepositoryImpl

### Community 141 - "Community 141"
Cohesion: 0.50
Nodes (1): BookingRepository

### Community 142 - "Community 142"
Cohesion: 0.50
Nodes (1): CustomerRepositoryImpl

### Community 143 - "Community 143"
Cohesion: 0.50
Nodes (1): CustomerRepository

### Community 144 - "Community 144"
Cohesion: 0.50
Nodes (1): MockCustomerRepository

### Community 145 - "Community 145"
Cohesion: 0.50
Nodes (1): MockPaymentRepository

### Community 146 - "Community 146"
Cohesion: 0.50
Nodes (1): PaymentRepositoryImpl

### Community 147 - "Community 147"
Cohesion: 0.50
Nodes (1): PaymentRepository

### Community 148 - "Community 148"
Cohesion: 0.67
Nodes (2): GetCommandLineArguments(), Utf8FromUtf16()

### Community 149 - "Community 149"
Cohesion: 0.50
Nodes (3): AllCustomersScreen, _AllCustomersView, _CustomerTile

### Community 150 - "Community 150"
Cohesion: 0.50
Nodes (3): CustomerDetailReportScreen, _CustomerDetailView, _DetailBody

### Community 151 - "Community 151"
Cohesion: 0.50
Nodes (2): LanguageSelectionScreen, _LanguageSelectionScreenState

### Community 152 - "Community 152"
Cohesion: 0.50
Nodes (2): OnboardingScreen, _OnboardingScreenState

### Community 153 - "Community 153"
Cohesion: 0.50
Nodes (2): RoleSelectionScreen, _RoleSelectionScreenState

### Community 154 - "Community 154"
Cohesion: 0.50
Nodes (1): StaffMainWrapper

### Community 155 - "Community 155"
Cohesion: 0.50
Nodes (1): LedgerStatementService

### Community 156 - "Community 156"
Cohesion: 0.50
Nodes (1): LocationIQService

### Community 157 - "Community 157"
Cohesion: 0.50
Nodes (2): PaymentVerificationResult, PaymentVerificationService

### Community 158 - "Community 158"
Cohesion: 0.50
Nodes (2): AppAccessCard, _AppAccessCardState

### Community 159 - "Community 159"
Cohesion: 0.50
Nodes (3): _CustomerAvatar, CustomerInfoCard, _Initial

### Community 160 - "Community 160"
Cohesion: 0.50
Nodes (2): _DateRangeSheet, _RangeOption

### Community 161 - "Community 161"
Cohesion: 0.50
Nodes (3): _CountChip, EntryCountsRow, _VerticalDivider

### Community 162 - "Community 162"
Cohesion: 0.50
Nodes (2): LedgerList, _LedgerListState

### Community 163 - "Community 163"
Cohesion: 0.50
Nodes (3): _ActiveVendorTile, _PendingVendorTile, VendorTile

### Community 164 - "Community 164"
Cohesion: 0.67
Nodes (2): CustomerEvent, LoadCustomerDashboard

### Community 165 - "Community 165"
Cohesion: 0.67
Nodes (1): BulkChargeState

### Community 167 - "Community 167"
Cohesion: 0.67
Nodes (1): LedgerEntry

### Community 168 - "Community 168"
Cohesion: 0.67
Nodes (2): LinkRequestModel, LinkRequestUserBrief

### Community 169 - "Community 169"
Cohesion: 0.67
Nodes (2): LocationData, LocationSuggestion

### Community 170 - "Community 170"
Cohesion: 0.67
Nodes (2): MembershipRequest, MembershipRequestCustomer

### Community 171 - "Community 171"
Cohesion: 0.67
Nodes (2): PaginatedMeta, PaginatedResult

### Community 172 - "Community 172"
Cohesion: 0.67
Nodes (1): PaymentTransaction

### Community 173 - "Community 173"
Cohesion: 0.67
Nodes (2): StaffPayTransaction, StaffSelfInfo

### Community 174 - "Community 174"
Cohesion: 0.67
Nodes (1): SearchRepositoryImpl

### Community 175 - "Community 175"
Cohesion: 0.67
Nodes (1): SearchRepository

### Community 176 - "Community 176"
Cohesion: 0.67
Nodes (1): VoiceRepositoryImpl

### Community 177 - "Community 177"
Cohesion: 0.67
Nodes (1): VoiceRepository

### Community 178 - "Community 178"
Cohesion: 0.67
Nodes (1): AppRiveIconMapper

### Community 179 - "Community 179"
Cohesion: 0.67
Nodes (1): AuthStateNotifier

### Community 181 - "Community 181"
Cohesion: 0.67
Nodes (2): AllCustomersReportScreen, _AllCustomersView

### Community 182 - "Community 182"
Cohesion: 0.67
Nodes (2): BillDetailsFormScreen, _BillDetailsFormScreenState

### Community 183 - "Community 183"
Cohesion: 0.67
Nodes (2): ReportsScreen, _ReportsView

### Community 184 - "Community 184"
Cohesion: 0.67
Nodes (2): ScanBillScreen, _ScanBillScreenState

### Community 185 - "Community 185"
Cohesion: 0.67
Nodes (1): MockPaymentVerificationService

### Community 186 - "Community 186"
Cohesion: 0.67
Nodes (1): LedgerBalanceHeader

### Community 187 - "Community 187"
Cohesion: 0.67
Nodes (2): LedgerFilterBar, _LedgerFilterChip

### Community 188 - "Community 188"
Cohesion: 0.67
Nodes (1): LedgerActions

### Community 189 - "Community 189"
Cohesion: 0.67
Nodes (1): MonthlyRow

### Community 190 - "Community 190"
Cohesion: 0.67
Nodes (2): _MonthBar, RevenueChartCard

### Community 191 - "Community 191"
Cohesion: 0.67
Nodes (2): ReportsStatCard, StatCard

### Community 192 - "Community 192"
Cohesion: 0.67
Nodes (2): UpiEntry, UpiIdTile

### Community 193 - "Community 193"
Cohesion: 1.00
Nodes (1): CustomerBloc

### Community 194 - "Community 194"
Cohesion: 1.00
Nodes (1): AppColors

### Community 195 - "Community 195"
Cohesion: 1.00
Nodes (1): AppTypography

### Community 197 - "Community 197"
Cohesion: 1.00
Nodes (1): LedgerBalance

### Community 198 - "Community 198"
Cohesion: 1.00
Nodes (1): MembershipStatus

### Community 199 - "Community 199"
Cohesion: 1.00
Nodes (1): AppNotification

### Community 200 - "Community 200"
Cohesion: 1.00
Nodes (1): SalaryTransaction

### Community 201 - "Community 201"
Cohesion: 1.00
Nodes (1): UpiIdModel

### Community 202 - "Community 202"
Cohesion: 1.00
Nodes (1): VendorPublicProfile

### Community 203 - "Community 203"
Cohesion: 1.00
Nodes (1): VendorSearchResult

### Community 204 - "Community 204"
Cohesion: 1.00
Nodes (1): VoiceDraft

### Community 205 - "Community 205"
Cohesion: 1.00
Nodes (1): LoginScreen

### Community 206 - "Community 206"
Cohesion: 1.00
Nodes (1): MyKhatasScreen

### Community 207 - "Community 207"
Cohesion: 1.00
Nodes (1): StaffCustomersScreen

### Community 209 - "Community 209"
Cohesion: 1.00
Nodes (1): AppTheme

### Community 210 - "Community 210"
Cohesion: 1.00
Nodes (1): RequestActionButtons

### Community 211 - "Community 211"
Cohesion: 1.00
Nodes (1): AppCard

### Community 212 - "Community 212"
Cohesion: 1.00
Nodes (1): BalanceCheck

### Community 213 - "Community 213"
Cohesion: 1.00
Nodes (1): BalanceHero

### Community 214 - "Community 214"
Cohesion: 1.00
Nodes (1): CustomTextField

### Community 215 - "Community 215"
Cohesion: 1.00
Nodes (1): CustomerReportTile

### Community 216 - "Community 216"
Cohesion: 1.00
Nodes (1): LedgerDetailRow

### Community 217 - "Community 217"
Cohesion: 1.00
Nodes (1): EmptyStateWidget

### Community 218 - "Community 218"
Cohesion: 1.00
Nodes (1): ErrorStateWidget

### Community 219 - "Community 219"
Cohesion: 1.00
Nodes (1): LedgerInfoRow

### Community 220 - "Community 220"
Cohesion: 1.00
Nodes (1): LocationPickerTile

### Community 221 - "Community 221"
Cohesion: 1.00
Nodes (1): MembershipTierBadge

### Community 222 - "Community 222"
Cohesion: 1.00
Nodes (1): PrimaryButton

### Community 223 - "Community 223"
Cohesion: 1.00
Nodes (1): RoleCard

### Community 224 - "Community 224"
Cohesion: 1.00
Nodes (1): SearchBarPill

### Community 225 - "Community 225"
Cohesion: 1.00
Nodes (1): SectionHeader

### Community 226 - "Community 226"
Cohesion: 1.00
Nodes (1): LedgerStatusChip

### Community 227 - "Community 227"
Cohesion: 1.00
Nodes (1): ReportsSummaryCard

### Community 228 - "Community 228"
Cohesion: 1.00
Nodes (1): CustomersSummaryHeader

### Community 229 - "Community 229"
Cohesion: 1.00
Nodes (1): TierEditCard

### Community 230 - "Community 230"
Cohesion: 1.00
Nodes (1): TopCustomerItem

### Community 231 - "Community 231"
Cohesion: 1.00
Nodes (1): TotalDueCard

### Community 232 - "Community 232"
Cohesion: 1.00
Nodes (1): UpiEmptyState

### Community 233 - "Community 233"
Cohesion: 1.00
Nodes (1): Architecture Decisions Document

### Community 234 - "Community 234"
Cohesion: 1.00
Nodes (1): Backend Integration Master Document

### Community 235 - "Community 235"
Cohesion: 1.00
Nodes (1): Graph Report (2026-06-13)

### Community 236 - "Community 236"
Cohesion: 1.00
Nodes (1): Backend Integration Plan

### Community 237 - "Community 237"
Cohesion: 1.00
Nodes (1): Integration Progress Tracker

### Community 238 - "Community 238"
Cohesion: 1.00
Nodes (1): Membership Feature Implementation Plan

### Community 239 - "Community 239"
Cohesion: 1.00
Nodes (1): Membership Feature Progress Tracker

### Community 240 - "Community 240"
Cohesion: 1.00
Nodes (1): MVP Implementation Tracker

### Community 241 - "Community 241"
Cohesion: 1.00
Nodes (1): Phase 0 Foundation Integration Doc

### Community 242 - "Community 242"
Cohesion: 1.00
Nodes (1): Phase 1 Links Integration Doc

### Community 243 - "Community 243"
Cohesion: 1.00
Nodes (1): Phase 1 Auth Integration Doc

### Community 244 - "Community 244"
Cohesion: 1.00
Nodes (1): SaathKhata PRD v1.0

### Community 248 - "Community 248"
Cohesion: 1.00
Nodes (1): UI Component Map

### Community 249 - "Community 249"
Cohesion: 1.00
Nodes (1): Voice Entry Implementation Plan

### Community 250 - "Community 250"
Cohesion: 1.00
Nodes (1): Voice Entry Progress Tracker

## Knowledge Gaps
- **603 isolated node(s):** `AppColors`, `AppTypography`, `_MaterialFallbackDelegate`, `_CupertinoFallbackDelegate`, `_WidgetsFallbackDelegate` (+598 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `API Endpoints`** (1 nodes): `ApiEndpoints`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n (Base)`** (2 nodes): `AppLocalizations`, `_AppLocalizationsDelegate`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Bhojpuri`** (1 nodes): `AppLocalizationsBho`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Bengali`** (1 nodes): `AppLocalizationsBn`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n English`** (1 nodes): `AppLocalizationsEn`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Gujarati`** (1 nodes): `AppLocalizationsGu`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Hindi`** (1 nodes): `AppLocalizationsHi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Kannada`** (1 nodes): `AppLocalizationsKn`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Maithili`** (1 nodes): `AppLocalizationsMai`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Malayalam`** (1 nodes): `AppLocalizationsMl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Marathi`** (1 nodes): `AppLocalizationsMr`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Punjabi`** (1 nodes): `AppLocalizationsPa`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Tamil`** (1 nodes): `AppLocalizationsTa`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `L10n Telugu`** (1 nodes): `AppLocalizationsTe`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Storage Service`** (1 nodes): `StorageService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 31`** (1 nodes): `LedgerSocketService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 32`** (1 nodes): `AuthBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 34`** (1 nodes): `LedgerBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 35`** (1 nodes): `MembershipCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 37`** (1 nodes): `StaffRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 40`** (1 nodes): `BookingBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 42`** (1 nodes): `StaffBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 51`** (1 nodes): `BulkChargeCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 52`** (2 nodes): `ApiClient`, `_LoggingInterceptor`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 53`** (1 nodes): `AuthRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 54`** (1 nodes): `AuthRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 55`** (1 nodes): `MockStaffRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 56`** (1 nodes): `StaffRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 59`** (2 nodes): `ProfileSetupScreen`, `_ProfileSetupScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 61`** (2 nodes): `UpiManagementScreen`, `_UpiManagementScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 62`** (1 nodes): `AppLogger`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 66`** (2 nodes): `LinkRequestCubit`, `SendLinkRequestCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 67`** (1 nodes): `NotificationBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 68`** (2 nodes): `PaymentVerificationBloc`, `_TimedOut`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 70`** (1 nodes): `VoiceEntryCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 72`** (1 nodes): `LinkRequestRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 73`** (1 nodes): `LinkRequestRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 74`** (1 nodes): `MembershipRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 75`** (1 nodes): `MembershipRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 76`** (1 nodes): `MockVendorRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 77`** (1 nodes): `VendorRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 78`** (1 nodes): `VendorRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 81`** (2 nodes): `EditProfileScreen`, `_EditProfileScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 83`** (1 nodes): `SpeechService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 89`** (1 nodes): `SearchCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 91`** (2 nodes): `SaathKhataApp`, `_SaathKhataAppState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 94`** (2 nodes): `OtpVerifyScreen`, `_OtpVerifyScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 95`** (1 nodes): `AppBlocObserver`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 105`** (1 nodes): `LedgerRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 106`** (1 nodes): `LedgerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 107`** (1 nodes): `MockLedgerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 108`** (1 nodes): `TemplateRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 114`** (2 nodes): `StaffPortalCubit`, `StaffPortalState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 115`** (1 nodes): `MockBookingRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 116`** (1 nodes): `MockNotificationRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 117`** (1 nodes): `NotificationRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 118`** (1 nodes): `NotificationRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 120`** (2 nodes): `PhoneEntryScreen`, `_PhoneEntryScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 121`** (2 nodes): `PolicyScreen`, `_PolicyScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 122`** (2 nodes): `SplashScreen`, `_SplashScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 124`** (1 nodes): `PushNotificationService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 125`** (1 nodes): `StatementPdfService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 126`** (1 nodes): `LedgerEntryCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 128`** (1 nodes): `PaymentBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 131`** (1 nodes): `VendorBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 133`** (1 nodes): `StaffPortalRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 134`** (1 nodes): `LocaleProvider`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 136`** (2 nodes): `AppointmentSlot`, `BookingModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 137`** (1 nodes): `MembershipTier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 138`** (2 nodes): `AttendanceRecord`, `StaffModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 140`** (1 nodes): `BookingRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 141`** (1 nodes): `BookingRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 142`** (1 nodes): `CustomerRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 143`** (1 nodes): `CustomerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 144`** (1 nodes): `MockCustomerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 145`** (1 nodes): `MockPaymentRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 146`** (1 nodes): `PaymentRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 147`** (1 nodes): `PaymentRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 148`** (2 nodes): `GetCommandLineArguments()`, `Utf8FromUtf16()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 151`** (2 nodes): `LanguageSelectionScreen`, `_LanguageSelectionScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 152`** (2 nodes): `OnboardingScreen`, `_OnboardingScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 153`** (2 nodes): `RoleSelectionScreen`, `_RoleSelectionScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 154`** (1 nodes): `StaffMainWrapper`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 155`** (1 nodes): `LedgerStatementService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 156`** (1 nodes): `LocationIQService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 157`** (2 nodes): `PaymentVerificationResult`, `PaymentVerificationService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 158`** (2 nodes): `AppAccessCard`, `_AppAccessCardState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 160`** (2 nodes): `_DateRangeSheet`, `_RangeOption`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 162`** (2 nodes): `LedgerList`, `_LedgerListState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 164`** (2 nodes): `CustomerEvent`, `LoadCustomerDashboard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 165`** (1 nodes): `BulkChargeState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 167`** (1 nodes): `LedgerEntry`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 168`** (2 nodes): `LinkRequestModel`, `LinkRequestUserBrief`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 169`** (2 nodes): `LocationData`, `LocationSuggestion`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 170`** (2 nodes): `MembershipRequest`, `MembershipRequestCustomer`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 171`** (2 nodes): `PaginatedMeta`, `PaginatedResult`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 172`** (1 nodes): `PaymentTransaction`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 173`** (2 nodes): `StaffPayTransaction`, `StaffSelfInfo`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 174`** (1 nodes): `SearchRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 175`** (1 nodes): `SearchRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 176`** (1 nodes): `VoiceRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 177`** (1 nodes): `VoiceRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 178`** (1 nodes): `AppRiveIconMapper`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 179`** (1 nodes): `AuthStateNotifier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 181`** (2 nodes): `AllCustomersReportScreen`, `_AllCustomersView`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 182`** (2 nodes): `BillDetailsFormScreen`, `_BillDetailsFormScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 183`** (2 nodes): `ReportsScreen`, `_ReportsView`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 184`** (2 nodes): `ScanBillScreen`, `_ScanBillScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 185`** (1 nodes): `MockPaymentVerificationService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 186`** (1 nodes): `LedgerBalanceHeader`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 187`** (2 nodes): `LedgerFilterBar`, `_LedgerFilterChip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 188`** (1 nodes): `LedgerActions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 189`** (1 nodes): `MonthlyRow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 190`** (2 nodes): `_MonthBar`, `RevenueChartCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 191`** (2 nodes): `ReportsStatCard`, `StatCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 192`** (2 nodes): `UpiEntry`, `UpiIdTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 193`** (1 nodes): `CustomerBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 194`** (1 nodes): `AppColors`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 195`** (1 nodes): `AppTypography`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 197`** (1 nodes): `LedgerBalance`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 198`** (1 nodes): `MembershipStatus`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 199`** (1 nodes): `AppNotification`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 200`** (1 nodes): `SalaryTransaction`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 201`** (1 nodes): `UpiIdModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 202`** (1 nodes): `VendorPublicProfile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 203`** (1 nodes): `VendorSearchResult`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 204`** (1 nodes): `VoiceDraft`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 205`** (1 nodes): `LoginScreen`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 206`** (1 nodes): `MyKhatasScreen`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 207`** (1 nodes): `StaffCustomersScreen`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 209`** (1 nodes): `AppTheme`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 210`** (1 nodes): `RequestActionButtons`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 211`** (1 nodes): `AppCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 212`** (1 nodes): `BalanceCheck`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 213`** (1 nodes): `BalanceHero`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 214`** (1 nodes): `CustomTextField`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 215`** (1 nodes): `CustomerReportTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 216`** (1 nodes): `LedgerDetailRow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 217`** (1 nodes): `EmptyStateWidget`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 218`** (1 nodes): `ErrorStateWidget`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 219`** (1 nodes): `LedgerInfoRow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 220`** (1 nodes): `LocationPickerTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 221`** (1 nodes): `MembershipTierBadge`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 222`** (1 nodes): `PrimaryButton`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 223`** (1 nodes): `RoleCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 224`** (1 nodes): `SearchBarPill`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 225`** (1 nodes): `SectionHeader`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 226`** (1 nodes): `LedgerStatusChip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 227`** (1 nodes): `ReportsSummaryCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 228`** (1 nodes): `CustomersSummaryHeader`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 229`** (1 nodes): `TierEditCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 230`** (1 nodes): `TopCustomerItem`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 231`** (1 nodes): `TotalDueCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 232`** (1 nodes): `UpiEmptyState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 233`** (1 nodes): `Architecture Decisions Document`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 234`** (1 nodes): `Backend Integration Master Document`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 235`** (1 nodes): `Graph Report (2026-06-13)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 236`** (1 nodes): `Backend Integration Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 237`** (1 nodes): `Integration Progress Tracker`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 238`** (1 nodes): `Membership Feature Implementation Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 239`** (1 nodes): `Membership Feature Progress Tracker`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 240`** (1 nodes): `MVP Implementation Tracker`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 241`** (1 nodes): `Phase 0 Foundation Integration Doc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 242`** (1 nodes): `Phase 1 Links Integration Doc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 243`** (1 nodes): `Phase 1 Auth Integration Doc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 244`** (1 nodes): `SaathKhata PRD v1.0`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 248`** (1 nodes): `UI Component Map`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 249`** (1 nodes): `Voice Entry Implementation Plan`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 250`** (1 nodes): `Voice Entry Progress Tracker`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `AppColors`, `AppTypography`, `_MaterialFallbackDelegate` to the rest of the system?**
  _603 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `API Endpoints` be split into smaller, more focused modules?**
  _Cohesion score 0.058823529411764705 - nodes in this community are weakly interconnected._
- **Should `L10n (Base)` be split into smaller, more focused modules?**
  _Cohesion score 0.07407407407407407 - nodes in this community are weakly interconnected._
- **Should `L10n Bhojpuri` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `L10n Bengali` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `L10n English` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `L10n Gujarati` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._