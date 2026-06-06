# Membership Feature — Progress Tracker

Plan: [MEMBERSHIP_PLAN.md](MEMBERSHIP_PLAN.md)

Legend: ✅ done · 🚧 in progress · ⬜ todo

## Backend (`saath_khata_backend`)
- ✅ Migration `20260019_create_memberships.ts` (tiers, `links.tier_id`, requests, partial-unique pending index)
- ✅ `memberships` module: types
- ✅ `memberships` module: validators
- ✅ `memberships` module: repository (lazy default-tier seeding)
- ✅ `memberships` module: service
- ✅ `memberships` module: controller
- ✅ `memberships` module: routes
- ✅ Mount `/api/v1/memberships` in `app.ts`
- ✅ `emitMembershipEvent` in `ledger-socket.ts`
- ✅ New notification types in `notification.types.ts`
- ✅ `tsc --noEmit` passes (app + migrations tsconfig)

## Frontend (`saath_khata`)
- ✅ `ApiEndpoints` membership routes
- ✅ Models: tier / request / status
- ✅ Repository interface + impl
- ✅ `MembershipCubit` + state
- ✅ DI registration (`MembershipRepository` lazy singleton; cubit created per-screen)
- ✅ `LedgerSocketService.onMembershipUpdated` + dispose `off`
- ✅ Flutter `NotificationType` membership values + notifications-screen switch arms
- ✅ `MembershipBanner` widget
- ✅ Wired banner + socket reload into `shared_ledger_screen.dart`
- ✅ `flutter analyze` clean (only a pre-existing unrelated lint remains)

## How it works (end to end)
- Shared ledger screen creates a `MembershipCubit` per link and shows `MembershipBanner`
  under the balance header.
- **Vendor view**: sees current tier; a pending request shows an Approve/Decline card;
  a "Set/Change" button opens a tier picker to assign/elevate/remove manually.
- **Customer view**: sees current tier; "Apply" opens a tier picker that POSTs a request;
  shows "awaiting approval" while pending.
- Every mutation emits `membership:updated` to the `link:<id>` Socket.IO room, so the other
  party's open screen reloads live. Both parties also get an in-app/push notification.

## Deployment notes (REQUIRED before it works)
1. Deploy the backend to `45.195.159.30`.
2. Run `npm run migrate:latest` on the server (creates the 3 new tables/column).
   - Rollback available via `npm run migrate:rollback` (down() drops them cleanly).
- Until deployed+migrated, the Flutter UI will show an error snackbar / empty banner
  because `/api/v1/memberships/*` returns 404.
- The unrelated **ledger date fix** (UTC ISO) already works against the live server.

## Deliberately out of scope
- Pricing/billing (per user instruction).
- Per-tier perk/benefit rules (tiers are labels keyed by `level`; rules can hang off it later).
- Localization: membership UI strings are hardcoded English for now (other screens use l10n;
  adding keys touches 11 generated arb files — left as a follow-up).

## Follow-ups / ideas
- Surface a tier badge in the vendor's customer list (`all_customers_screen`) and the
  customer's vendor list (`my_khatas_screen`).
- Vendor tier-rename UI (endpoint `PATCH /memberships/tiers/:tierId` exists; no screen yet).
- Vendor "pending requests" inbox screen (endpoint `GET /memberships/requests/pending`
  exists; currently requests only surface inside each ledger).
