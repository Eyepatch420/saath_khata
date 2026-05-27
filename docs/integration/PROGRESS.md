# Integration Progress

> Last updated: 2026-05-27

## Phases

| Phase | File | Status |
|---|---|---|
| 0 — Foundation | [phase_0_foundation.md](phase_0_foundation.md) | ✅ Complete (2026-05-27) |
| 1 — Links | [phase_1_links.md](phase_1_links.md) | ✅ Complete (2026-05-27) |
| 2 — Ledger | [phase_2_ledger.md](phase_2_ledger.md) | ✅ Complete (2026-05-27) |
| 3 — Payments | [phase_3_payments.md](phase_3_payments.md) | ✅ Complete (2026-05-27) |
| 4 — Notifications | [phase_4_notifications.md](phase_4_notifications.md) | ✅ Complete (2026-05-27) |
| 5 — Staff | [phase_5_staff.md](phase_5_staff.md) | ✅ Complete (2026-05-27) |
| 6 — Bookings | [phase_6_bookings.md](phase_6_bookings.md) | ✅ Complete (2026-05-27) |
| 7 — Reports | [phase_7_reports.md](phase_7_reports.md) | 🔲 Pending |

## Key Notes

- Auth is already fully integrated. Do NOT touch auth.
- Mock repositories stay in place until each phase is done; only the DI binding is swapped.
- Backend base URL: `http://45.195.159.30:3001/api/v1`
- All API responses are wrapped: `{ "success": true, "data": { ... } }` — use `ApiClient.extractData()`.
- Enum values: backend uses snake_case strings; Dart uses camelCase enum members. Parsing is handled in `fromJson` factory constructors on each model.
