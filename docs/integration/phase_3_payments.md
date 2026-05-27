# Phase 3 — Payments

**Status:** ✅ Complete (2026-05-27)

## What to do

### Files to create
- `lib/features/payments/data/repositories/payment_repository_impl.dart`

### `lib/core/di/injection.dart` change
Replace:
```dart
getIt.registerLazySingleton<PaymentRepository>(() => MockPaymentRepository());
```
With:
```dart
getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(getIt<ApiClient>()));
```

### Domain interface to extend
The current `PaymentRepository` signature uses `customerId` which doesn't match the backend (which uses `linkId`). Update the abstract class:
```dart
Future<PaginatedResult<PaymentTransaction>> getPayments(String linkId, {int page});
Future<PaymentTransaction> recordPayment(String linkId, {
  required double amount,
  required PaymentMethod method,
  String? upiTransactionId,
  String? note,
});
Future<PaymentTransaction> settleBalance(String linkId);
```

## API endpoints to consume

| Method | Path | Description |
|---|---|---|
| GET | `/links/:linkId/payments` | Paginated history |
| POST | `/links/:linkId/payments` | Record payment (atomic) |
| POST | `/links/:linkId/payments/settle` | Settle full balance |

## Important

`POST /payments` atomically creates an `auto_confirmed` ledger entry AND a payment record in one DB transaction. Do NOT manually create a ledger entry before calling this.

PaymentMethod serialization:
- `PaymentMethod.bankTransfer` → `"bank_transfer"`
- `PaymentMethod.cheque` → `"other"` (no cheque type on backend)

## Mock payment flow (no gateway)

There is no Razorpay / Stripe integration. Payments are recorded directly to the backend on submission. The UPI app buttons in `UpiPaymentScreen` show "coming soon" — the real payment recording goes through `recordPayment(transaction)` once a `linkId` is threaded through the navigation. See `UpiPaymentScreen` notes below.

## UpiPaymentScreen — linkId gap (follow-up needed)

`UpiPaymentScreen` receives `amount`, `recipientName`, `upiId` via route params but NOT `linkId`. The screen currently fakes success with a 2s delay and does not call the repository. To wire it fully:
- Add `linkId` as a query param to `/upi-payment` in `app_router.dart`
- Pass it through all call sites that navigate to the payment screen
- Call `PaymentRepository.recordPayment(...)` inside `_initiatePayment()`

## Seeded test accounts (live backend)

| Role | Email | Password |
|---|---|---|
| Vendor | `ravi.dairy@test.com` | `Test@1234` |
| Customer 1 | `suresh.kumar@test.com` | `Test@1234` |
| Customer 2 | `priya.sharma@test.com` | `Test@1234` |
| Customer 3 | `ramesh.singh@test.com` | `Test@1234` |

**Live balances after seed:**
- Suresh Kumar → ₹335 outstanding
- Priya Sharma → ₹295 outstanding
- Ramesh Singh → ₹470 outstanding
