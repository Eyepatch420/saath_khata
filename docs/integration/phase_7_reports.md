# Phase 7 — Reports

**Status:** 🔲 Pending

## What to do

### Files to create
- `lib/features/reports/domain/repositories/report_repository.dart` (new abstract class)
- `lib/features/reports/data/repositories/report_repository_impl.dart`

### `lib/core/di/injection.dart` change
Add (no mock to replace — this is net new):
```dart
getIt.registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(getIt<ApiClient>()));
```

### Domain interface
```dart
abstract class ReportRepository {
  Future<VendorSummaryReport> getSummary();
  Future<List<CustomerReportItem>> getAllCustomers();
  Future<CustomerDetailReport> getCustomerDetail(String linkId);
  Future<MonthlyRevenueReport> getMonthlyTrend({int? year});
}
```

## API endpoints to consume

| Method | Path | Cache | Description |
|---|---|---|---|
| GET | `/reports/summary` | Redis 5 min | Totals + top customers |
| GET | `/reports/customers` | Redis 5 min | All customers ranked by balance |
| GET | `/reports/customers/:linkId` | None | Single customer detail |
| GET | `/reports/monthly?year=YYYY` | Redis 1 hr | 12-month trend |

## Models (in `lib/shared/models/report_models.dart`)
All four types are defined in `report_models.dart` created in Phase 0:
- `VendorSummaryReport`
- `CustomerReportItem`
- `CustomerDetailReport`
- `MonthlyRevenueReport`

## Notes
- Reports are vendor-only. No role guard needed client-side (the backend enforces it and returns 403 for customers).
- Redis cache means values may be up to 5 minutes stale. This is by design — no need to add a manual refresh button.
