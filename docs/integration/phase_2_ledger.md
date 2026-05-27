# Phase 2 — Ledger

**Status:** ✅ Complete (2026-05-27)

## What to do

### Files to create
- `lib/features/shared_ledger/data/repositories/ledger_repository_impl.dart`

### `lib/core/di/injection.dart` change
Replace:
```dart
getIt.registerLazySingleton<LedgerRepository>(() => MockLedgerRepository());
```
With:
```dart
getIt.registerLazySingleton<LedgerRepository>(() => LedgerRepositoryImpl(getIt<ApiClient>()));
```

### Domain interface to extend
`LedgerRepository` needs two new methods (add to the abstract class):
```dart
Future<PaginatedResult<LedgerEntry>> getEntriesPaginated(
  String linkId, { int page, int limit, EntryStatus? status, EntryType? type });
Future<LedgerBalance> getBalance(String linkId);
```

## API endpoints to consume

| Method | Path | Description |
|---|---|---|
| GET | `/links/:linkId/entries` | Paginated list |
| GET | `/links/:linkId/entries/balance` | Balance + stats |
| POST | `/links/:linkId/entries` | Add entry |
| PATCH | `/links/:linkId/entries/:id/confirm` | Customer confirms |
| PATCH | `/links/:linkId/entries/:id/dispute` | Customer disputes |

## Entry type / status serialization

Send to backend (Dart enum → string):
- `EntryType.credit` → `"credit"`
- `EntryType.autoConfirmed` → — (never sent; only received)
- `EntryStatus.autoConfirmed` → — (never sent; server sets it)

Dispute body: `{ "reason": "..." }` (optional field — check backend validator).
