# Voice Entry — Implementation Plan (multi-phase)

> Progress: see [VOICE_ENTRY_PROGRESS.md](VOICE_ENTRY_PROGRESS.md).

## Goal
A vendor or customer, inside the **shared ledger**, taps a mic and speaks a sentence in
any of the app's **12 languages** (e.g. *"Satish ka 2 litre doodh, ₹120 udhaar"*). The app
transcribes it on-device, sends the transcript to the backend, which uses a **free LLM
(Google Gemini Flash)** to normalize it into a ledger draft `{amount, type, description,
quantity, unit}`. The user sees a **confirmation card**, edits if needed, taps confirm, and
it creates a normal ledger entry via the existing flow.

## Target languages (confirmed from l10n + picker)
English, Hindi, Bengali, Marathi, Tamil, Telugu, Kannada, Gujarati, Punjabi, Malayalam,
Bhojpuri, Maithili. (Bhojpuri/Maithili have no on-device STT → fall back to Hindi STT;
the LLM normalizes regardless of input language/script/transliteration.)

## Decisions (researched June 2026)
- **LLM = Google Gemini Flash (free tier)** — 1,500 req/day, no card, native JSON-Schema
  structured output. Called **server-side** so the key never ships in the app.
- **STT = on-device `speech_to_text`** — free, no key, low latency. Major Indian languages
  supported per-device; bho/mai → Hindi locale fallback.
- **Not** using `flutter_ai_toolkit` — it's a chat-UI toolkit and now forces a Firebase
  project; wrong shape for one-shot extraction.

## Architecture / data flow
```
[Shared Ledger mic button]  (vendor OR customer)
        │  on-device STT (speech_to_text), locale = app language
        ▼
  transcript + language ──POST /links/:linkId/voice/parse──▶ Backend
                                                              │ verify link access + role
                                                              │ build multilingual prompt
                                                              │ Gemini Flash (responseSchema)
                                                              ▼
                                          draft { amount, type, description, quantity,
                                                  unit, rawTranscript, confidence }
        ◀──────────────────────────────────────────────────┘
  Confirmation card (editable) ──confirm──▶ existing AddLedgerEntry → ledger entry
```
- Customers may only create `payment` entries (mirrors ledger rule) → the prompt constrains
  `type` by role.
- Voice entry surfaces **only** in the shared ledger, for both roles.

## Backend (module `voice`, mounted at `/api/v1/links/:linkId/voice`)
- `POST /parse` — body `{ transcript, language? }` → returns the draft. Auth required;
  `LinkRepository.findForUser` authorizes + determines role.
- `gemini.service.ts` — REST call via native `fetch` (Node 22), `responseMimeType:
  application/json` + `responseSchema`, low temperature, AbortController timeout.
- Env: `GEMINI_API_KEY` (optional — endpoint returns 503 if unset), `GEMINI_MODEL`
  (default `gemini-flash-latest`).

## Frontend (feature `voice_entry`, modular)
- `data/` repository → calls `/voice/parse`. `domain/models` → `VoiceDraft`.
- `presentation/bloc` → `VoiceEntryCubit` state machine: idle → listening → transcribing →
  parsing → review(draft) → submitting → done / error.
- `presentation/` → mic sheet + editable confirmation card, launched from the shared ledger.
- `core/services/speech_service.dart` → wraps `speech_to_text` (init, locale resolution,
  bho/mai→hi fallback, partial results).

## Phases (each retains the previous)
- **Phase 1 — Backend brain.** Endpoint + Gemini prompt + schema. Testable via `curl`.
- **Phase 2 — Mobile capture + UI.** `speech_to_text` + permissions, repository, cubit,
  confirmation card wired into the shared ledger, confirm → `AddLedgerEntry`.
- **Phase 3 — Robustness.** Locale→STT mapping, bho/mai fallback, edit/retry/low-confidence
  states, provider/error handling, logging.

## Out of scope (for now)
- Cloud STT (Sarvam/Bhashini) — on-device chosen; architecture leaves room to add later.
- Auto-creating entries without confirmation (always user-confirmed).
