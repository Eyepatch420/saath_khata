# Phase 5 — Staff

**Status:** ✅ Complete (2026-05-27)

## What to do

### Files to create
- `lib/features/staff/data/repositories/staff_repository_impl.dart`

### `lib/core/di/injection.dart` change
Replace:
```dart
getIt.registerLazySingleton<StaffRepository>(() => MockStaffRepository());
```
With:
```dart
getIt.registerLazySingleton<StaffRepository>(() => StaffRepositoryImpl(getIt<ApiClient>()));
```

### Domain interface to extend
Add missing methods:
```dart
Future<StaffModel> getStaffById(String staffId);
Future<void> deactivateStaff(String staffId);
Future<void> accrueSalary(String staffId);
Future<List<SalaryTransaction>> getSalaryHistory(String staffId);
```

## API endpoints to consume

| Method | Path | Description |
|---|---|---|
| GET | `/staff` | List all active staff |
| POST | `/staff` | Add staff member |
| GET | `/staff/:id` | Staff detail + salary stats |
| PATCH | `/staff/:id` | Update staff |
| DELETE | `/staff/:id` | Deactivate (soft delete) |
| PUT | `/staff/:id/attendance` | Upsert attendance |
| GET | `/staff/:id/attendance` | Monthly map (year, month query) |
| POST | `/staff/:id/pay` | Salary payment |
| POST | `/staff/:id/advance` | Record advance |
| POST | `/staff/:id/accrue` | Accrue one period |
| GET | `/staff/:id/salary-history` | Last 50 transactions |

## SalaryType note
Backend accepts `daily`, `weekly`, `monthly` but Flutter model only has `daily` and `monthly`.
Map any `weekly` response to `monthly` as a safe fallback.

## AttendanceStatus serialization
- `AttendanceStatus.halfDay` → send `"half_day"` to backend
- `"half_day"` from backend → `AttendanceStatus.halfDay`

## Implementation notes

- `ApiClient.put<T>` was added (backend uses `PUT` for attendance upsert)
- `AttendanceStatusX.fromString` static added to the existing extension in `staff_model.dart` — needed by `getAttendanceForMonth` which receives a raw `Map<String,String>` from the backend
- `getStaffList` → `data` is a direct JSON array (use `response.data['data'] as List`, not `extractData`)
- `getAttendanceForMonth` → `data` is a plain object `{ "YYYY-MM-DD": "present" }` — use `extractData` then `.map()`

## Seeded staff (live backend — vendor: ravi.dairy@test.com)

| Name | Role | Type | Unpaid | Advance |
|---|---|---|---|---|
| Mohan Lal | Helper | daily ₹500 | ₹4500 | ₹500 |
| Sunita Devi | Cook | monthly ₹8000 | ₹8000 | ₹0 |
| Raju Verma | Delivery Boy | daily ₹400 | ₹1200 | ₹0 |

10 days of attendance seeded (2026-05-17 to 2026-05-26). Today's attendance not yet marked — realistic starting state.
