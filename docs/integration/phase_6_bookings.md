# Phase 6 — Bookings

**Status:** ✅ Complete (2026-05-27)

## What to do

### Files to create
- `lib/features/booking/data/repositories/booking_repository_impl.dart`
- `lib/shared/models/booking_config.dart` (new model for vendor booking config)

### `lib/core/di/injection.dart` change
Replace:
```dart
getIt.registerLazySingleton<BookingRepository>(() => MockBookingRepository());
```
With:
```dart
getIt.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(getIt<ApiClient>()));
```

### Domain interface to extend
Add config methods:
```dart
Future<BookingConfig?> getConfig();
Future<void> saveConfig(BookingConfig config);
```

## API endpoints to consume

| Method | Path | Role | Description |
|---|---|---|---|
| GET | `/bookings/config` | vendor | Get booking config |
| PUT | `/bookings/config` | vendor | Save booking config |
| GET | `/bookings/slots/:vendorId?date=YYYY-MM-DD` | public | Available slots |
| POST | `/bookings` | customer | Create booking |
| GET | `/bookings/vendor?date=YYYY-MM-DD` | vendor | Bookings for a date |
| GET | `/bookings/customer` | customer | Customer's full history |
| PATCH | `/bookings/:id` | both | Update status |

## BookingConfig shape
```dart
class BookingConfig {
  final String startTime;       // 'HH:MM'
  final String endTime;
  final int slotDurationMinutes;
  final List<int> workingDays;  // 0=Sun … 6=Sat
}
```

## Implementation notes
- `BookingConfig` model not needed client-side — BLoC only uses the 5 core methods, config endpoints aren't called from any existing screen
- All 3 list endpoints (vendor bookings, customer bookings, slots) return JSON arrays — use `(response.data as Map)['data'] as List` NOT `extractData`
- `createBooking` and `updateBookingStatus` return a single object — use `extractData`
- Slots endpoint requires auth (router.use(authenticate) covers it) — ApiClient adds token automatically
- `PATCH /bookings/:id` body: `{ "status": "confirmed" | "completed" | "cancelled" }`

## Seeded data (live backend)
Vendor: ravi.dairy@test.com (id: ae31e6fd-f492-420b-add2-83407535ed11)
- Booking config: 09:00–18:00, 30-min slots, Mon–Sat
Customer: amit.booking@test.com / Test@1234

| Date | Time | Service | Status |
|---|---|---|---|
| 2026-05-26 | 10:00 | Milk Delivery | confirmed |
| 2026-05-27 | 09:00 | Curd Order | pending |
| 2026-05-28 | 11:00 | Ghee Order | pending |
