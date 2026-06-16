# Graph Report - .  (2026-06-13)

## Corpus Check
- 202 files · ~97,125 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1381 nodes · 1181 edges · 198 communities detected
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output
- Edge kinds: contains: 1181


## Input Scope
- Requested: auto
- Resolved: committed (source: cli)
- Included files: 202 · Candidates: 216
- Excluded: 199 untracked · 0 ignored · 2 sensitive · 0 missing committed
- Recommendation: Use --scope all or graphify.yaml inputs.corpus for a knowledge-base folder.
## God Nodes (most connected - your core abstractions)
1. `AppColors` - 1 edges
2. `AppTypography` - 1 edges
3. `_MaterialFallbackDelegate` - 1 edges
4. `_CupertinoFallbackDelegate` - 1 edges
5. `_WidgetsFallbackDelegate` - 1 edges
6. `LocaleProvider` - 1 edges
7. `ApiClient` - 1 edges
8. `_LoggingInterceptor` - 1 edges
9. `ApiEndpoints` - 1 edges
10. `AppRouter` - 1 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Communities

### Community 0 - "Community 0"
Cohesion: 0.06
Nodes (1): ApiEndpoints

### Community 1 - "Community 1"
Cohesion: 0.07
Nodes (2): AppLocalizations, _AppLocalizationsDelegate

### Community 2 - "Community 2"
Cohesion: 0.09
Nodes (1): AppLocalizationsBho

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (1): AppLocalizationsBn

### Community 4 - "Community 4"
Cohesion: 0.09
Nodes (1): AppLocalizationsEn

### Community 5 - "Community 5"
Cohesion: 0.09
Nodes (1): AppLocalizationsGu

### Community 6 - "Community 6"
Cohesion: 0.09
Nodes (1): AppLocalizationsHi

### Community 7 - "Community 7"
Cohesion: 0.09
Nodes (1): AppLocalizationsKn

### Community 8 - "Community 8"
Cohesion: 0.09
Nodes (1): AppLocalizationsMai

### Community 9 - "Community 9"
Cohesion: 0.09
Nodes (1): AppLocalizationsMl

### Community 10 - "Community 10"
Cohesion: 0.09
Nodes (1): AppLocalizationsMr

### Community 11 - "Community 11"
Cohesion: 0.09
Nodes (1): AppLocalizationsPa

### Community 12 - "Community 12"
Cohesion: 0.09
Nodes (1): AppLocalizationsTa

### Community 13 - "Community 13"
Cohesion: 0.09
Nodes (1): AppLocalizationsTe

### Community 14 - "Community 14"
Cohesion: 0.09
Nodes (12): _DialogCard, _ErrorCard, _ListeningCard, _ListeningCardState, _LoadingCard, _ParsingCard, _ReviewCard, _ReviewCardState (+4 more)

### Community 15 - "Community 15"
Cohesion: 0.10
Nodes (12): _ActionButtons, _AttendanceCalendar, _AttendanceCalendarState, _AttendanceOption, _CalendarLegend, _DayCell, _LegendItem, _ProfileCard (+4 more)

### Community 16 - "Community 16"
Cohesion: 0.11
Nodes (1): StorageService

### Community 17 - "Community 17"
Cohesion: 0.14
Nodes (7): _AmountDisplay, _FailureView, _OrDivider, _SuccessView, _UpiAppsRow, UpiPaymentScreen, _UpiPaymentScreenState

### Community 18 - "Community 18"
Cohesion: 0.15
Nodes (4): _CoordChip, _LocationCard, LocationPickerScreen, _LocationPickerScreenState

### Community 19 - "Community 19"
Cohesion: 0.15
Nodes (9): _AvatarInitial, _CustomerCta, _InfoItem, _InfoSection, _ProfileScaffold, _StepRow, _VendorCta, VendorProfileScreen (+1 more)

### Community 20 - "Community 20"
Cohesion: 0.17
Nodes (11): LinkRequestError, LinkRequestInitial, LinkRequestLoaded, LinkRequestLoading, LinkRequestResponded, LinkRequestState, SendRequestError, SendRequestIdle (+3 more)

### Community 21 - "Community 21"
Cohesion: 0.17
Nodes (6): _BookAppointmentBody, _BookAppointmentBodyState, BookAppointmentScreen, _DateStrip, _SlotChip, _SlotGrid

### Community 22 - "Community 22"
Cohesion: 0.17
Nodes (5): _BookingsList, _CustomerBookingCard, CustomerBookingsScreen, _CustomerBookingsScreenState, _StatusChip

### Community 23 - "Community 23"
Cohesion: 0.17
Nodes (10): _CategoryChip, _EmptyResult, _ErrorView, _Hint, _InitialFallback, _ResultCard, _ResultsList, _VendorAvatar (+2 more)

### Community 24 - "Community 24"
Cohesion: 0.17
Nodes (1): LedgerSocketService

### Community 25 - "Community 25"
Cohesion: 0.18
Nodes (1): LedgerBloc

### Community 26 - "Community 26"
Cohesion: 0.18
Nodes (1): MembershipCubit

### Community 27 - "Community 27"
Cohesion: 0.18
Nodes (8): CollectedTodayItem, CustomerDetailReport, CustomerReportItem, MonthlyPaymentData, MonthlyRevenueData, MonthlyRevenueReport, PaginatedList, VendorSummaryReport

### Community 28 - "Community 28"
Cohesion: 0.18
Nodes (6): CustomerDashboard, CustomerDashboardView, _NotifBadge, _PayAllDuesSheet, _PayAllDuesSheetState, _UpcomingAppointmentsCard

### Community 29 - "Community 29"
Cohesion: 0.18
Nodes (7): _ActionTile, _BookingCard, _BookingsContent, _DateSelector, _StatusBadge, VendorBookingsScreen, _VendorBookingsView

### Community 30 - "Community 30"
Cohesion: 0.20
Nodes (1): BookingBloc

### Community 31 - "Community 31"
Cohesion: 0.20
Nodes (9): AddLedgerEntry, ConfirmLedgerEntry, DisputeLedgerEntry, FilterLedger, LedgerEvent, LoadLedger, RefreshLedger, SocketLedgerEntryAdded (+1 more)

### Community 32 - "Community 32"
Cohesion: 0.20
Nodes (1): StaffBloc

### Community 33 - "Community 33"
Cohesion: 0.20
Nodes (9): AccrueSalary, AddAdvance, AddStaff, LoadAttendance, LoadStaff, MarkAttendance, PaySalary, RefreshStaff (+1 more)

### Community 34 - "Community 34"
Cohesion: 0.20
Nodes (1): StaffRepositoryImpl

### Community 35 - "Community 35"
Cohesion: 0.20
Nodes (3): _CollectedTile, CollectedTodayScreen, _CollectedTodayScreenState

### Community 36 - "Community 36"
Cohesion: 0.22
Nodes (8): BookingEvent, CancelBooking, CreateBooking, LoadAvailableSlots, LoadCustomerBookings, LoadVendorBookings, SelectBookingDate, UpdateBookingStatus

### Community 37 - "Community 37"
Cohesion: 0.22
Nodes (8): BookingActionError, BookingCreated, BookingError, BookingInitial, BookingLoaded, BookingLoading, BookingState, SlotsLoaded

### Community 38 - "Community 38"
Cohesion: 0.22
Nodes (5): MembershipTiersCubit, MembershipTiersError, MembershipTiersLoaded, MembershipTiersLoading, MembershipTiersState

### Community 39 - "Community 39"
Cohesion: 0.22
Nodes (6): ReportsDashboardCubit, ReportsDashboardError, ReportsDashboardInitial, ReportsDashboardLoaded, ReportsDashboardLoading, ReportsDashboardState

### Community 40 - "Community 40"
Cohesion: 0.22
Nodes (2): ApiClient, _LoggingInterceptor

### Community 41 - "Community 41"
Cohesion: 0.22
Nodes (3): OutstandingListScreen, _OutstandingListScreenState, _OutstandingTile

### Community 42 - "Community 42"
Cohesion: 0.22
Nodes (7): _PaymentsContent, PaymentsScreen, _PaymentsView, _PaymentTile, _QuickPayCard, _SummaryRow, _SummaryStat

### Community 43 - "Community 43"
Cohesion: 0.22
Nodes (5): _LiveDot, _LiveDotState, SharedLedgerScreen, _SharedLedgerScreenState, SharedLedgerView

### Community 44 - "Community 44"
Cohesion: 0.22
Nodes (7): _AttendanceTodayButton, _StaffCard, _StaffContent, StaffManagementScreen, _StaffSummaryBar, _StaffView, _SummaryItem

### Community 45 - "Community 45"
Cohesion: 0.22
Nodes (2): UpiManagementScreen, _UpiManagementScreenState

### Community 46 - "Community 46"
Cohesion: 0.22
Nodes (1): AppLogger

### Community 47 - "Community 47"
Cohesion: 0.25
Nodes (6): AllCustomersReportCubit, AllCustomersReportError, AllCustomersReportInitial, AllCustomersReportLoaded, AllCustomersReportLoading, AllCustomersReportState

### Community 48 - "Community 48"
Cohesion: 0.25
Nodes (1): AuthBloc

### Community 49 - "Community 49"
Cohesion: 0.25
Nodes (7): AuthCheckStatusRequested, AuthEvent, AuthLoginRequested, AuthLogoutRequested, AuthProfileUpdateRequested, AuthSignupRequested, AuthUserUpdated

### Community 50 - "Community 50"
Cohesion: 0.25
Nodes (6): CustomerDetailCubit, CustomerDetailError, CustomerDetailInitial, CustomerDetailLoaded, CustomerDetailLoading, CustomerDetailState

### Community 51 - "Community 51"
Cohesion: 0.25
Nodes (2): LinkRequestCubit, SendLinkRequestCubit

### Community 52 - "Community 52"
Cohesion: 0.25
Nodes (1): NotificationBloc

### Community 53 - "Community 53"
Cohesion: 0.25
Nodes (7): StaffActionLoading, StaffDetailLoaded, StaffError, StaffInitial, StaffLoaded, StaffLoading, StaffState

### Community 54 - "Community 54"
Cohesion: 0.25
Nodes (1): VoiceEntryCubit

### Community 55 - "Community 55"
Cohesion: 0.25
Nodes (3): _CupertinoFallbackDelegate, _MaterialFallbackDelegate, _WidgetsFallbackDelegate

### Community 56 - "Community 56"
Cohesion: 0.25
Nodes (1): MembershipRepositoryImpl

### Community 57 - "Community 57"
Cohesion: 0.25
Nodes (1): MembershipRepository

### Community 58 - "Community 58"
Cohesion: 0.25
Nodes (1): MockStaffRepository

### Community 59 - "Community 59"
Cohesion: 0.25
Nodes (1): MockVendorRepository

### Community 60 - "Community 60"
Cohesion: 0.25
Nodes (1): StaffRepository

### Community 61 - "Community 61"
Cohesion: 0.25
Nodes (1): VendorRepositoryImpl

### Community 62 - "Community 62"
Cohesion: 0.25
Nodes (1): VendorRepository

### Community 63 - "Community 63"
Cohesion: 0.25
Nodes (3): _FallbackIcon, TapAnimatedRiveIcon, TapAnimatedRiveIconState

### Community 64 - "Community 64"
Cohesion: 0.25
Nodes (4): AppRouter, CustomerMainWrapper, VendorMainWrapper, _VendorMainWrapperState

### Community 65 - "Community 65"
Cohesion: 0.25
Nodes (2): EditProfileScreen, _EditProfileScreenState

### Community 66 - "Community 66"
Cohesion: 0.25
Nodes (2): ProfileSetupScreen, _ProfileSetupScreenState

### Community 67 - "Community 67"
Cohesion: 0.25
Nodes (1): SpeechService

### Community 68 - "Community 68"
Cohesion: 0.25
Nodes (3): AppToast, _ToastBanner, _ToastBannerState

### Community 69 - "Community 69"
Cohesion: 0.25
Nodes (3): DiscountEditorSheet, _DiscountEditorSheetState, DiscountEditResult

### Community 70 - "Community 70"
Cohesion: 0.29
Nodes (6): AuthAuthenticated, AuthError, AuthInitial, AuthLoading, AuthState, AuthUnauthenticated

### Community 71 - "Community 71"
Cohesion: 0.29
Nodes (6): LedgerActionLoading, LedgerError, LedgerInitial, LedgerLoaded, LedgerLoading, LedgerState

### Community 72 - "Community 72"
Cohesion: 0.29
Nodes (6): LoadNotifications, LoadUnreadCount, MarkAllNotificationsRead, MarkNotificationRead, NotificationArrived, NotificationEvent

### Community 73 - "Community 73"
Cohesion: 0.29
Nodes (1): SearchCubit

### Community 74 - "Community 74"
Cohesion: 0.29
Nodes (6): VoiceEntryState, VoiceErrorState, VoiceIdle, VoiceListening, VoiceParsing, VoiceReview

### Community 75 - "Community 75"
Cohesion: 0.29
Nodes (2): SaathKhataApp, _SaathKhataAppState

### Community 76 - "Community 76"
Cohesion: 0.29
Nodes (3): CustomerProfileScreen, _ProfileItem, _SectionHeader

### Community 77 - "Community 77"
Cohesion: 0.29
Nodes (4): _NotificationCard, _NotificationsList, NotificationsScreen, _NotificationsView

### Community 78 - "Community 78"
Cohesion: 0.29
Nodes (4): _ProfileHeader, _SectionLabel, SettingsScreen, _SettingsTile

### Community 79 - "Community 79"
Cohesion: 0.29
Nodes (5): _ActionCard, _CustomerTile, _NotifBadge, VendorDashboard, VendorDashboardView

### Community 80 - "Community 80"
Cohesion: 0.29
Nodes (1): AppBlocObserver

### Community 81 - "Community 81"
Cohesion: 0.29
Nodes (3): BookingConfirmationSheet, _BookingConfirmationSheetState, _InfoRow

### Community 82 - "Community 82"
Cohesion: 0.33
Nodes (5): CustomerError, CustomerInitial, CustomerLoaded, CustomerLoading, CustomerState

### Community 83 - "Community 83"
Cohesion: 0.33
Nodes (5): MembershipError, MembershipInitial, MembershipLoaded, MembershipLoading, MembershipState

### Community 84 - "Community 84"
Cohesion: 0.33
Nodes (5): NotificationError, NotificationInitial, NotificationLoaded, NotificationLoading, NotificationState

### Community 85 - "Community 85"
Cohesion: 0.33
Nodes (5): PaymentError, PaymentInitial, PaymentLoaded, PaymentLoading, PaymentState

### Community 86 - "Community 86"
Cohesion: 0.33
Nodes (5): SearchErrorState, SearchInitialState, SearchLoadedState, SearchLoadingState, SearchState

### Community 87 - "Community 87"
Cohesion: 0.33
Nodes (5): VendorError, VendorInitial, VendorLoaded, VendorLoading, VendorState

### Community 88 - "Community 88"
Cohesion: 0.33
Nodes (5): CustomerLinkItem, RemindAllResult, UserSummary, VendorLinkItem, VendorSummary

### Community 89 - "Community 89"
Cohesion: 0.33
Nodes (1): AuthRepositoryImpl

### Community 90 - "Community 90"
Cohesion: 0.33
Nodes (1): AuthRepository

### Community 91 - "Community 91"
Cohesion: 0.33
Nodes (1): LedgerRepositoryImpl

### Community 92 - "Community 92"
Cohesion: 0.33
Nodes (1): LedgerRepository

### Community 93 - "Community 93"
Cohesion: 0.33
Nodes (1): LinkRequestRepositoryImpl

### Community 94 - "Community 94"
Cohesion: 0.33
Nodes (1): LinkRequestRepository

### Community 95 - "Community 95"
Cohesion: 0.33
Nodes (1): MockLedgerRepository

### Community 96 - "Community 96"
Cohesion: 0.33
Nodes (3): MembershipTiersScreen, _MembershipTiersView, _TierList

### Community 97 - "Community 97"
Cohesion: 0.33
Nodes (4): _ErrorView, _RequestBody, VendorLinkRequestScreen, _VendorLinkRequestView

### Community 98 - "Community 98"
Cohesion: 0.33
Nodes (4): AppBottomNavBar, AppNavItem, _PillNavItem, _PillNavItemState

### Community 99 - "Community 99"
Cohesion: 0.40
Nodes (1): MockBookingRepository

### Community 100 - "Community 100"
Cohesion: 0.40
Nodes (1): MockNotificationRepository

### Community 101 - "Community 101"
Cohesion: 0.40
Nodes (1): NotificationRepositoryImpl

### Community 102 - "Community 102"
Cohesion: 0.40
Nodes (1): NotificationRepository

### Community 103 - "Community 103"
Cohesion: 0.40
Nodes (2): PolicyScreen, _PolicyScreenState

### Community 104 - "Community 104"
Cohesion: 0.40
Nodes (2): SplashScreen, _SplashScreenState

### Community 105 - "Community 105"
Cohesion: 0.40
Nodes (1): PushNotificationService

### Community 106 - "Community 106"
Cohesion: 0.40
Nodes (1): LedgerEntryCard

### Community 107 - "Community 107"
Cohesion: 0.40
Nodes (3): _CurrentTierRow, MembershipBanner, _PendingRequestCard

### Community 108 - "Community 108"
Cohesion: 0.50
Nodes (1): PaymentBloc

### Community 109 - "Community 109"
Cohesion: 0.50
Nodes (3): LoadPayments, PaymentEvent, RecordPayment

### Community 110 - "Community 110"
Cohesion: 0.50
Nodes (1): VendorBloc

### Community 111 - "Community 111"
Cohesion: 0.50
Nodes (3): LoadVendorDashboard, RemindAllRequested, VendorEvent

### Community 112 - "Community 112"
Cohesion: 0.50
Nodes (1): LocaleProvider

### Community 113 - "Community 113"
Cohesion: 0.50
Nodes (2): AppointmentSlot, BookingModel

### Community 114 - "Community 114"
Cohesion: 0.50
Nodes (1): MembershipTier

### Community 115 - "Community 115"
Cohesion: 0.50
Nodes (2): AttendanceRecord, StaffModel

### Community 116 - "Community 116"
Cohesion: 0.50
Nodes (1): BookingRepositoryImpl

### Community 117 - "Community 117"
Cohesion: 0.50
Nodes (1): BookingRepository

### Community 118 - "Community 118"
Cohesion: 0.50
Nodes (1): MockPaymentRepository

### Community 119 - "Community 119"
Cohesion: 0.50
Nodes (1): PaymentRepositoryImpl

### Community 120 - "Community 120"
Cohesion: 0.50
Nodes (1): PaymentRepository

### Community 121 - "Community 121"
Cohesion: 0.50
Nodes (3): AllCustomersScreen, _AllCustomersView, _CustomerTile

### Community 122 - "Community 122"
Cohesion: 0.50
Nodes (3): CustomerDetailReportScreen, _CustomerDetailView, _DetailBody

### Community 123 - "Community 123"
Cohesion: 0.50
Nodes (2): LanguageSelectionScreen, _LanguageSelectionScreenState

### Community 124 - "Community 124"
Cohesion: 0.50
Nodes (2): LoginScreen, _LoginScreenState

### Community 125 - "Community 125"
Cohesion: 0.50
Nodes (2): OnboardingScreen, _OnboardingScreenState

### Community 126 - "Community 126"
Cohesion: 0.50
Nodes (2): RoleSelectionScreen, _RoleSelectionScreenState

### Community 127 - "Community 127"
Cohesion: 0.50
Nodes (1): LedgerStatementService

### Community 128 - "Community 128"
Cohesion: 0.50
Nodes (1): LocationIQService

### Community 129 - "Community 129"
Cohesion: 0.50
Nodes (3): _CustomerAvatar, CustomerInfoCard, _Initial

### Community 130 - "Community 130"
Cohesion: 0.50
Nodes (3): _CountChip, EntryCountsRow, _VerticalDivider

### Community 131 - "Community 131"
Cohesion: 0.50
Nodes (2): LedgerList, _LedgerListState

### Community 132 - "Community 132"
Cohesion: 0.67
Nodes (2): CustomerEvent, LoadCustomerDashboard

### Community 133 - "Community 133"
Cohesion: 0.67
Nodes (2): AuthResponseModel, TokensModel

### Community 134 - "Community 134"
Cohesion: 0.67
Nodes (1): LedgerEntry

### Community 135 - "Community 135"
Cohesion: 0.67
Nodes (2): LinkRequestModel, LinkRequestUserBrief

### Community 136 - "Community 136"
Cohesion: 0.67
Nodes (2): LocationData, LocationSuggestion

### Community 137 - "Community 137"
Cohesion: 0.67
Nodes (2): MembershipRequest, MembershipRequestCustomer

### Community 138 - "Community 138"
Cohesion: 0.67
Nodes (2): PaginatedMeta, PaginatedResult

### Community 139 - "Community 139"
Cohesion: 0.67
Nodes (1): PaymentTransaction

### Community 140 - "Community 140"
Cohesion: 0.67
Nodes (2): UserModel, VendorProfile

### Community 141 - "Community 141"
Cohesion: 0.67
Nodes (1): SearchRepositoryImpl

### Community 142 - "Community 142"
Cohesion: 0.67
Nodes (1): SearchRepository

### Community 143 - "Community 143"
Cohesion: 0.67
Nodes (1): VoiceRepositoryImpl

### Community 144 - "Community 144"
Cohesion: 0.67
Nodes (1): VoiceRepository

### Community 145 - "Community 145"
Cohesion: 0.67
Nodes (1): AppRiveIconMapper

### Community 146 - "Community 146"
Cohesion: 0.67
Nodes (1): AuthStateNotifier

### Community 147 - "Community 147"
Cohesion: 0.67
Nodes (2): AllCustomersReportScreen, _AllCustomersView

### Community 148 - "Community 148"
Cohesion: 0.67
Nodes (2): BillDetailsFormScreen, _BillDetailsFormScreenState

### Community 149 - "Community 149"
Cohesion: 0.67
Nodes (2): ReportsScreen, _ReportsView

### Community 150 - "Community 150"
Cohesion: 0.67
Nodes (2): ScanBillScreen, _ScanBillScreenState

### Community 151 - "Community 151"
Cohesion: 0.67
Nodes (1): LedgerBalanceHeader

### Community 152 - "Community 152"
Cohesion: 0.67
Nodes (2): LedgerFilterBar, _LedgerFilterChip

### Community 153 - "Community 153"
Cohesion: 0.67
Nodes (1): LedgerActions

### Community 154 - "Community 154"
Cohesion: 0.67
Nodes (1): MonthlyRow

### Community 155 - "Community 155"
Cohesion: 0.67
Nodes (2): _MonthBar, RevenueChartCard

### Community 156 - "Community 156"
Cohesion: 0.67
Nodes (2): ReportsStatCard, StatCard

### Community 157 - "Community 157"
Cohesion: 0.67
Nodes (2): UpiEntry, UpiIdTile

### Community 158 - "Community 158"
Cohesion: 1.00
Nodes (1): CustomerBloc

### Community 159 - "Community 159"
Cohesion: 1.00
Nodes (1): AppColors

### Community 160 - "Community 160"
Cohesion: 1.00
Nodes (1): AppTypography

### Community 162 - "Community 162"
Cohesion: 1.00
Nodes (1): LedgerBalance

### Community 163 - "Community 163"
Cohesion: 1.00
Nodes (1): MembershipStatus

### Community 164 - "Community 164"
Cohesion: 1.00
Nodes (1): AppNotification

### Community 165 - "Community 165"
Cohesion: 1.00
Nodes (1): SalaryTransaction

### Community 166 - "Community 166"
Cohesion: 1.00
Nodes (1): UpiIdModel

### Community 167 - "Community 167"
Cohesion: 1.00
Nodes (1): VendorPublicProfile

### Community 168 - "Community 168"
Cohesion: 1.00
Nodes (1): VendorSearchResult

### Community 169 - "Community 169"
Cohesion: 1.00
Nodes (1): VoiceDraft

### Community 170 - "Community 170"
Cohesion: 1.00
Nodes (1): CustomerRepositoryImpl

### Community 171 - "Community 171"
Cohesion: 1.00
Nodes (1): CustomerRepository

### Community 172 - "Community 172"
Cohesion: 1.00
Nodes (1): MockCustomerRepository

### Community 173 - "Community 173"
Cohesion: 1.00
Nodes (1): MyKhatasScreen

### Community 174 - "Community 174"
Cohesion: 1.00
Nodes (1): AppTheme

### Community 175 - "Community 175"
Cohesion: 1.00
Nodes (1): RequestActionButtons

### Community 176 - "Community 176"
Cohesion: 1.00
Nodes (1): AppCard

### Community 177 - "Community 177"
Cohesion: 1.00
Nodes (1): BalanceCheck

### Community 178 - "Community 178"
Cohesion: 1.00
Nodes (1): BalanceHero

### Community 179 - "Community 179"
Cohesion: 1.00
Nodes (1): CustomTextField

### Community 180 - "Community 180"
Cohesion: 1.00
Nodes (1): CustomerReportTile

### Community 181 - "Community 181"
Cohesion: 1.00
Nodes (1): LedgerDetailRow

### Community 182 - "Community 182"
Cohesion: 1.00
Nodes (1): EmptyStateWidget

### Community 183 - "Community 183"
Cohesion: 1.00
Nodes (1): ErrorStateWidget

### Community 184 - "Community 184"
Cohesion: 1.00
Nodes (1): LedgerInfoRow

### Community 185 - "Community 185"
Cohesion: 1.00
Nodes (1): LocationPickerTile

### Community 186 - "Community 186"
Cohesion: 1.00
Nodes (1): MembershipTierBadge

### Community 187 - "Community 187"
Cohesion: 1.00
Nodes (1): PrimaryButton

### Community 188 - "Community 188"
Cohesion: 1.00
Nodes (1): RoleCard

### Community 189 - "Community 189"
Cohesion: 1.00
Nodes (1): SearchBarPill

### Community 190 - "Community 190"
Cohesion: 1.00
Nodes (1): SectionHeader

### Community 191 - "Community 191"
Cohesion: 1.00
Nodes (1): LedgerStatusChip

### Community 192 - "Community 192"
Cohesion: 1.00
Nodes (1): ReportsSummaryCard

### Community 193 - "Community 193"
Cohesion: 1.00
Nodes (1): CustomersSummaryHeader

### Community 194 - "Community 194"
Cohesion: 1.00
Nodes (1): TierEditCard

### Community 195 - "Community 195"
Cohesion: 1.00
Nodes (1): TopCustomerItem

### Community 196 - "Community 196"
Cohesion: 1.00
Nodes (1): TotalDueCard

### Community 197 - "Community 197"
Cohesion: 1.00
Nodes (1): UpiEmptyState

### Community 198 - "Community 198"
Cohesion: 1.00
Nodes (1): VendorTile

## Knowledge Gaps
- **490 isolated node(s):** `AppColors`, `AppTypography`, `_MaterialFallbackDelegate`, `_CupertinoFallbackDelegate`, `_WidgetsFallbackDelegate` (+485 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 0`** (1 nodes): `ApiEndpoints`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 1`** (2 nodes): `AppLocalizations`, `_AppLocalizationsDelegate`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 2`** (1 nodes): `AppLocalizationsBho`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 3`** (1 nodes): `AppLocalizationsBn`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 4`** (1 nodes): `AppLocalizationsEn`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 5`** (1 nodes): `AppLocalizationsGu`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 6`** (1 nodes): `AppLocalizationsHi`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 7`** (1 nodes): `AppLocalizationsKn`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 8`** (1 nodes): `AppLocalizationsMai`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 9`** (1 nodes): `AppLocalizationsMl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 10`** (1 nodes): `AppLocalizationsMr`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 11`** (1 nodes): `AppLocalizationsPa`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 12`** (1 nodes): `AppLocalizationsTa`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 13`** (1 nodes): `AppLocalizationsTe`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 16`** (1 nodes): `StorageService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 24`** (1 nodes): `LedgerSocketService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 25`** (1 nodes): `LedgerBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 26`** (1 nodes): `MembershipCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 30`** (1 nodes): `BookingBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 32`** (1 nodes): `StaffBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 34`** (1 nodes): `StaffRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 40`** (2 nodes): `ApiClient`, `_LoggingInterceptor`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 45`** (2 nodes): `UpiManagementScreen`, `_UpiManagementScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 46`** (1 nodes): `AppLogger`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 48`** (1 nodes): `AuthBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 51`** (2 nodes): `LinkRequestCubit`, `SendLinkRequestCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 52`** (1 nodes): `NotificationBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 54`** (1 nodes): `VoiceEntryCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 56`** (1 nodes): `MembershipRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 57`** (1 nodes): `MembershipRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 58`** (1 nodes): `MockStaffRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 59`** (1 nodes): `MockVendorRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 60`** (1 nodes): `StaffRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 61`** (1 nodes): `VendorRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 62`** (1 nodes): `VendorRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 65`** (2 nodes): `EditProfileScreen`, `_EditProfileScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 66`** (2 nodes): `ProfileSetupScreen`, `_ProfileSetupScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 67`** (1 nodes): `SpeechService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 73`** (1 nodes): `SearchCubit`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 75`** (2 nodes): `SaathKhataApp`, `_SaathKhataAppState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 80`** (1 nodes): `AppBlocObserver`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 89`** (1 nodes): `AuthRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 90`** (1 nodes): `AuthRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 91`** (1 nodes): `LedgerRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 92`** (1 nodes): `LedgerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 93`** (1 nodes): `LinkRequestRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 94`** (1 nodes): `LinkRequestRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 95`** (1 nodes): `MockLedgerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 99`** (1 nodes): `MockBookingRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 100`** (1 nodes): `MockNotificationRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 101`** (1 nodes): `NotificationRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 102`** (1 nodes): `NotificationRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 103`** (2 nodes): `PolicyScreen`, `_PolicyScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 104`** (2 nodes): `SplashScreen`, `_SplashScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 105`** (1 nodes): `PushNotificationService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 106`** (1 nodes): `LedgerEntryCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 108`** (1 nodes): `PaymentBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 110`** (1 nodes): `VendorBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 112`** (1 nodes): `LocaleProvider`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 113`** (2 nodes): `AppointmentSlot`, `BookingModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 114`** (1 nodes): `MembershipTier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 115`** (2 nodes): `AttendanceRecord`, `StaffModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 116`** (1 nodes): `BookingRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 117`** (1 nodes): `BookingRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 118`** (1 nodes): `MockPaymentRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 119`** (1 nodes): `PaymentRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 120`** (1 nodes): `PaymentRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 123`** (2 nodes): `LanguageSelectionScreen`, `_LanguageSelectionScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 124`** (2 nodes): `LoginScreen`, `_LoginScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 125`** (2 nodes): `OnboardingScreen`, `_OnboardingScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 126`** (2 nodes): `RoleSelectionScreen`, `_RoleSelectionScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 127`** (1 nodes): `LedgerStatementService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 128`** (1 nodes): `LocationIQService`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 131`** (2 nodes): `LedgerList`, `_LedgerListState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 132`** (2 nodes): `CustomerEvent`, `LoadCustomerDashboard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 133`** (2 nodes): `AuthResponseModel`, `TokensModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 134`** (1 nodes): `LedgerEntry`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 135`** (2 nodes): `LinkRequestModel`, `LinkRequestUserBrief`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 136`** (2 nodes): `LocationData`, `LocationSuggestion`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 137`** (2 nodes): `MembershipRequest`, `MembershipRequestCustomer`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 138`** (2 nodes): `PaginatedMeta`, `PaginatedResult`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 139`** (1 nodes): `PaymentTransaction`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 140`** (2 nodes): `UserModel`, `VendorProfile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 141`** (1 nodes): `SearchRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 142`** (1 nodes): `SearchRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 143`** (1 nodes): `VoiceRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 144`** (1 nodes): `VoiceRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 145`** (1 nodes): `AppRiveIconMapper`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 146`** (1 nodes): `AuthStateNotifier`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 147`** (2 nodes): `AllCustomersReportScreen`, `_AllCustomersView`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 148`** (2 nodes): `BillDetailsFormScreen`, `_BillDetailsFormScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 149`** (2 nodes): `ReportsScreen`, `_ReportsView`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 150`** (2 nodes): `ScanBillScreen`, `_ScanBillScreenState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 151`** (1 nodes): `LedgerBalanceHeader`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 152`** (2 nodes): `LedgerFilterBar`, `_LedgerFilterChip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 153`** (1 nodes): `LedgerActions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 154`** (1 nodes): `MonthlyRow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 155`** (2 nodes): `_MonthBar`, `RevenueChartCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 156`** (2 nodes): `ReportsStatCard`, `StatCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 157`** (2 nodes): `UpiEntry`, `UpiIdTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 158`** (1 nodes): `CustomerBloc`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 159`** (1 nodes): `AppColors`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 160`** (1 nodes): `AppTypography`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 162`** (1 nodes): `LedgerBalance`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 163`** (1 nodes): `MembershipStatus`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 164`** (1 nodes): `AppNotification`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 165`** (1 nodes): `SalaryTransaction`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 166`** (1 nodes): `UpiIdModel`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 167`** (1 nodes): `VendorPublicProfile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 168`** (1 nodes): `VendorSearchResult`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 169`** (1 nodes): `VoiceDraft`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 170`** (1 nodes): `CustomerRepositoryImpl`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 171`** (1 nodes): `CustomerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 172`** (1 nodes): `MockCustomerRepository`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 173`** (1 nodes): `MyKhatasScreen`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 174`** (1 nodes): `AppTheme`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 175`** (1 nodes): `RequestActionButtons`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 176`** (1 nodes): `AppCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 177`** (1 nodes): `BalanceCheck`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 178`** (1 nodes): `BalanceHero`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 179`** (1 nodes): `CustomTextField`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 180`** (1 nodes): `CustomerReportTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 181`** (1 nodes): `LedgerDetailRow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 182`** (1 nodes): `EmptyStateWidget`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 183`** (1 nodes): `ErrorStateWidget`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 184`** (1 nodes): `LedgerInfoRow`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 185`** (1 nodes): `LocationPickerTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 186`** (1 nodes): `MembershipTierBadge`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 187`** (1 nodes): `PrimaryButton`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 188`** (1 nodes): `RoleCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 189`** (1 nodes): `SearchBarPill`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 190`** (1 nodes): `SectionHeader`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 191`** (1 nodes): `LedgerStatusChip`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 192`** (1 nodes): `ReportsSummaryCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 193`** (1 nodes): `CustomersSummaryHeader`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 194`** (1 nodes): `TierEditCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 195`** (1 nodes): `TopCustomerItem`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 196`** (1 nodes): `TotalDueCard`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 197`** (1 nodes): `UpiEmptyState`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Community 198`** (1 nodes): `VendorTile`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `AppColors`, `AppTypography`, `_MaterialFallbackDelegate` to the rest of the system?**
  _490 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.06451612903225806 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.07407407407407407 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `Community 4` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._
- **Should `Community 5` be split into smaller, more focused modules?**
  _Cohesion score 0.08695652173913043 - nodes in this community are weakly interconnected._