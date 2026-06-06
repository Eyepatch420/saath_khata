# Membership Feature — Implementation Plan

> Status doc: see [MEMBERSHIP_PROGRESS.md](MEMBERSHIP_PROGRESS.md) for what is done vs pending.

## Goal

Let a **vendor** assign each linked **customer** to one of **three membership tiers**
(default *Bronze / Silver / Gold*, names editable per vendor). Customers can **apply**
for a tier on any vendor they're linked with; the **vendor controls** who gets it —
approving/declining requests or assigning tiers manually. Everything is surfaced on the
**shared ledger screen** (the one screen both roles already use).

## Core design decision

**Membership is a property of the `vendor_customer_link`**, exactly like `balance`.
A link has at most one tier at a time (`tier_id`, nullable = no membership). Tiers are
**owned by the vendor** (each vendor has their own 3 tiers they can rename).

This keeps the model tiny and reuses the existing link/ledger/socket/notification plumbing.

## Data model (backend, Postgres)

Migration `20260019_create_memberships.ts`:

1. **`membership_tiers`** — one set of 3 per vendor
   - `id` uuid pk
   - `vendor_id` uuid → users (CASCADE)
   - `level` int (1=lowest … 3=highest)
   - `name` varchar(50)  (default Bronze/Silver/Gold, vendor-editable)
   - timestamps
   - `unique(vendor_id, level)`
   - Auto-seeded lazily the first time a vendor reads their tiers.

2. **`vendor_customer_links.tier_id`** — new nullable column
   - uuid → membership_tiers (ON DELETE SET NULL), indexed

3. **`membership_requests`** — customer-initiated tier applications
   - `id` uuid pk
   - `link_id` → vendor_customer_links (CASCADE)
   - `vendor_id`, `customer_id` → users (denormalized for direct queries)
   - `requested_tier_id` → membership_tiers
   - `status` varchar CHECK (pending | approved | declined), default pending
   - `message` text nullable
   - `responded_at` timestamptz nullable
   - timestamps
   - Partial unique index: at most ONE `pending` request per link
   - `index(vendor_id, status)`

## API (backend, mounted at `/api/v1/memberships`)

| Method | Path | Role | Purpose |
|---|---|---|---|
| GET | `/tiers` | vendor | List own 3 tiers (auto-seed defaults if missing) |
| PATCH | `/tiers/:tierId` | vendor | Rename a tier `{ name }` |
| GET | `/links/:linkId` | both | Membership status for a link: `{ currentTier, pendingRequest, tiers }` |
| PATCH | `/links/:linkId/assign` | vendor | Set/elevate/remove a customer's tier `{ tierId \| null }` |
| POST | `/links/:linkId/request` | customer | Apply for a tier `{ tierId, message? }` |
| GET | `/requests/pending` | vendor | All pending requests across this vendor's links |
| PATCH | `/requests/:requestId/approve` | vendor | Approve → assign tier + mark approved |
| PATCH | `/requests/:requestId/decline` | vendor | Decline a request |

All responses use the existing `sendSuccess` envelope `{ success, message, data }`.
List payloads are wrapped in an object (`{ tiers: [...] }`, `{ requests: [...] }`) so the
Flutter `ApiClient.extractData` (which casts to a Map) stays safe.

## Realtime + notifications

- **Socket**: new `emitMembershipEvent(linkId, payload)` helper emits `membership:updated`
  to the existing `link:<linkId>` room. The open shared-ledger screen reloads its
  membership banner live (same pattern as `ledger:entry_added`).
- **Notifications** (new types, snake_case — `notifications.type` is a free string, no CHECK):
  - `membership_requested` → vendor, when a customer applies
  - `membership_changed` → customer, when assigned/approved/elevated
  - `membership_request_declined` → customer, when declined
  - Flutter `NotificationType` gets matching enum values (unknown types already fall back safely).

## Frontend (Flutter, new feature `lib/features/memberships`)

- **Models**: `MembershipTier`, `MembershipRequest`, `MembershipStatus`
- **Repository**: interface + Dio impl (mirrors `LinkRequestRepositoryImpl`)
- **State**: `MembershipCubit` + sealed `MembershipState`
- **DI**: lazy-singleton repo + factory cubit in `injection.dart`
- **Endpoints**: added to `ApiEndpoints`
- **Socket**: `onMembershipUpdated` / `off` added to `LedgerSocketService`
- **UI**: `MembershipBanner` inserted in `shared_ledger_screen.dart` between the balance
  header and the filter bar:
  - **Both**: current tier badge (or "No membership")
  - **Vendor**: pending-request card with Approve/Decline; a "Change membership" button →
    tier-picker bottom sheet (assign)
  - **Customer**: "Apply for membership" button → tier-picker bottom sheet (request);
    "awaiting approval" state when a request is pending

## Out of scope (intentionally)

- Pricing / billing (user said skip price).
- Per-tier perks/benefits logic — tiers are labels for now; benefit rules can hang off
  `level` later.
- Backend deploy + `npm run migrate:latest` on the server (`45.195.159.30`) — must be run
  by whoever deploys; the feature is inert until then.

## Files touched

**Backend** (`saath_khata_backend`)
- `migrations/20260019_create_memberships.ts` (new)
- `src/app/modules/memberships/{types,validators,repositories,services,controllers,routes}/*` (new)
- `src/app/bootstrap/app.ts` (mount route)
- `src/infrastructure/socket/ledger-socket.ts` (emit helper)
- `src/app/modules/notifications/types/notification.types.ts` (new types)

**Frontend** (`saath_khata`)
- `lib/features/memberships/**` (new)
- `lib/core/network/api_endpoints.dart`
- `lib/core/di/injection.dart`
- `lib/core/services/ledger_socket_service.dart`
- `lib/shared/models/notification_model.dart`
- `lib/features/shared_ledger/presentation/screens/shared_ledger_screen.dart` (+ new banner widget)
