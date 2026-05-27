# Phase 4 — Notifications

**Status:** ✅ Complete (2026-05-27)

## What to do

### Files to create
- `lib/features/notifications/data/repositories/notification_repository_impl.dart`

### `lib/core/di/injection.dart` change
Replace:
```dart
getIt.registerLazySingleton<NotificationRepository>(() => MockNotificationRepository());
```
With:
```dart
getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(getIt<ApiClient>()));
```

### Domain interface to extend
Add pagination support:
```dart
Future<PaginatedResult<AppNotification>> getNotificationsPaginated({
  int page, bool unreadOnly });
```

## API endpoints to consume

| Method | Path | Description |
|---|---|---|
| GET | `/notifications` | Paginated (query: page, limit, unreadOnly) |
| GET | `/notifications/unread-count` | Badge integer |
| PATCH | `/notifications/read-all` | Mark all read |
| PATCH | `/notifications/:id/read` | Mark single read |

## Polling strategy

No WebSocket yet. Use a simple periodic timer in the notification BLoC or screen:
- Poll `getUnreadCount()` every 30s while app is foregrounded
- Refresh full list only when notification screen is opened

## Live notification counts (from Phase 3 seeding)

- Vendor (`ravi.dairy@test.com`): 3 unread — 2x `payment_received`, 1x `entry_disputed`
- Customer Suresh (`suresh.kumar@test.com`): 6 unread — 6x `entry_added`

BullMQ processed all enqueued jobs automatically — no manual seeding needed.

## Notes on implementation

The existing `NotificationRepository` interface was a perfect 1:1 match for the backend — no interface changes were required. The `getNotifications()` call fetches page 1 with limit 50, which is sufficient for the current screen's needs.

## NotificationType serialization (backend snake_case → Dart camelCase)

| Backend | Flutter enum |
|---|---|
| `entry_added` | `NotificationType.entryAdded` |
| `entry_confirmed` | `NotificationType.entryConfirmed` |
| `entry_disputed` | `NotificationType.entryDisputed` |
| `payment_received` | `NotificationType.paymentReceived` |
| `booking_confirmed` | `NotificationType.bookingConfirmed` |
| `booking_cancelled` | `NotificationType.bookingCancelled` |
| `salary_paid` | `NotificationType.salaryPaid` |
| `reminder_due` | `NotificationType.reminderDue` |
| `monthly_summary` | `NotificationType.monthlySummary` |
