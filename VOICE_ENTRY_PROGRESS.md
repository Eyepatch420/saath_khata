# Voice Entry — Progress Tracker

Plan: [VOICE_ENTRY_PLAN.md](VOICE_ENTRY_PLAN.md)

Legend: ✅ done · 🚧 in progress · ⬜ todo

## Phase 1 — Backend brain (Gemini parse endpoint) ✅
- ✅ `voice` module: types / validators
- ✅ `gemini.service.ts` — REST (native fetch) + `responseSchema` + multilingual prompt;
  hardened part extraction for "thinking" models; timeout + error mapping (503/502/504/422)
- ✅ `voice.service.ts` — link auth + role derivation (customer → payment only)
- ✅ controller + routes; mounted `POST /api/v1/links/:linkId/voice/parse`
- ✅ `tsc --noEmit` passes
- ✅ **Verified live** with the provided key across Hindi, Tamil, Telugu, and romanized
  code-mix → correct structured JSON each time. `gemini-flash-latest` → gemini-3.5-flash.

## Phase 2 — Mobile capture + confirmation UI ✅
- ✅ `speech_to_text: ^7.0.0` added; Android `RECORD_AUDIO` + RecognitionService query;
  iOS mic + speech usage strings
- ✅ `SpeechService` wrapper (init/permission, locale resolution, partials)
- ✅ `voice_entry` repository + `VoiceDraft` model + endpoint + DI
- ✅ `VoiceEntryCubit` + states (idle→listening→parsing→review→error)
- ✅ `VoiceEntrySheet` UI; mic FAB on shared ledger (both roles); confirm → `AddLedgerEntry`
- ✅ removed dead `/voice-entry` route + mock screen
- ✅ `flutter analyze` clean

## Phase 3 — Robustness & polish ✅ (folded into Phase 2)
- ✅ app-locale → STT locale mapping; bho/mai → Hindi STT fallback
- ✅ editable review fields, "try again", low-confidence badge
- ✅ error states: mic unavailable, "didn't catch that", upstream/timeout
- ✅ backend error handling + logging; final analyze + tsc clean

## Deployment
- `GEMINI_API_KEY` is provided via **GitHub Actions** (user-managed). Optional
  `GEMINI_MODEL` (default `gemini-flash-latest`). Until the key is present in the deployed
  env, `/voice/parse` returns 503 and the mic flow shows "voice not available".
- CI/CD auto-deploys the backend.

## Notes
- The API key was used only for a one-off live test; it is **not** stored in the repo.
- STT is on-device and free; Bhojpuri/Maithili use Hindi recognition + LLM normalization.
