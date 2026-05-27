# Phase 1 — Links

**Status:** ✅ Complete  
**Date:** 2026-05-27

## What was done

### Files created
- `lib/features/vendor/data/repositories/vendor_repository_impl.dart`
- `lib/features/customer/data/repositories/customer_repository_impl.dart`

### `lib/core/di/injection.dart` updated
Replaced:
```dart
getIt.registerLazySingleton<VendorRepository>(() => MockVendorRepository());
getIt.registerLazySingleton<CustomerRepository>(() => MockCustomerRepository());
```
With:
```dart
getIt.registerLazySingleton<VendorRepository>(() => VendorRepositoryImpl(getIt<ApiClient>()));
getIt.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(getIt<ApiClient>()));
```

## API endpoints consumed

| Method | Path | Used by |
|---|---|---|
| GET | `/links/customers` | `VendorRepositoryImpl.getLinkedCustomers` |
| POST | `/links` | `VendorRepositoryImpl.linkCustomer` |
| DELETE | `/links/:id` | `VendorRepositoryImpl.deactivateLink` |
| GET | `/links/vendors` | `CustomerRepositoryImpl.getLinkedVendors` |

## Notes

- `CustomerLinkItem` and `VendorLinkItem` both parse from the `CustomerLinkItem[]` / `VendorLinkItem[]` arrays returned directly in `data`.
- Backend returns balances as numbers (already parsed from string in the service layer).
- `deactivateLink` returns 204 No Content on success.
