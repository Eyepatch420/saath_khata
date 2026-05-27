# Phase 1 — Auth + First-Launch Integration

**Base URL:** `http://45.195.159.30:3001/api/v1`

## Scope

- First-launch detection (Splash → Onboarding only on first open)
- Login (vendor + customer) wired to real backend
- Signup (vendor + customer) wired to real backend
- JWT token persistence in Flutter Secure Storage
- Auth state guard on router (auto-redirect if already logged in)

## Backend APIs used

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/auth/signup` | Create account |
| POST | `/auth/login` | Email + password login |
| POST | `/auth/refresh` | Rotate access token |
| POST | `/auth/logout` | Revoke refresh token |

### Signup body
```json
{
  "name": "string",
  "email": "string",
  "password": "string (min 8)",
  "role": "vendor | customer",
  "mobile": "optional 10-digit",
  "upiId": "optional xxx@xxx",
  "businessName": "vendor only",
  "businessCategory": "vendor only (enum)",
  "businessAddress": "vendor only"
}
```

### Login body
```json
{ "email": "string", "password": "string" }
```

### Success response shape
```json
{
  "success": true,
  "message": "...",
  "data": {
    "user": { "id": "uuid", "name": "string", "email": "string", "role": "vendor|customer" },
    "tokens": { "accessToken": "...", "refreshToken": "...", "expiresIn": 900 }
  }
}
```

## Flutter layers added

```
lib/
  core/
    network/
      api_client.dart          ← Dio singleton with auth interceptor
      api_endpoints.dart       ← URL constants
    services/
      storage_service.dart     ← Extended: secure tokens + onboarding flag
  features/
    auth/
      data/
        models/
          auth_response_model.dart
          user_model.dart
        repositories/
          auth_repository_impl.dart
      domain/
        repositories/
          auth_repository.dart
      presentation/
        bloc/
          auth_bloc.dart
          auth_event.dart
          auth_state.dart
```

## First-launch routing logic

```
SplashScreen.initState
  └── StorageService.hasSeenOnboarding
        ├── false → /language-selection → /onboarding → /role-selection → /login
        └── true  → StorageService.getAccessToken
                      ├── null/expired → /role-selection
                      └── valid        → stored role → /vendor | /customer
```

## Status

- [x] Plan written
- [x] Packages added (`dio`, `flutter_secure_storage`)
- [x] StorageService extended (Hive for locale, SecureStorage for tokens + onboarding flag)
- [x] Network layer created (`ApiClient` with auto-refresh interceptor, `ApiEndpoints`)
- [x] Auth models created (`UserModel`, `TokensModel`, `AuthResponseModel`)
- [x] Auth repository created (`AuthRepository` abstract + `AuthRepositoryImpl`)
- [x] AuthBloc created (Login / Signup / Logout / CheckStatus events)
- [x] DI wired (`StorageService`, `ApiClient`, `AuthStateNotifier`, `AuthRepository`, `AuthBloc`)
- [x] Screens wired (LoginScreen + ProfileSetupScreen → AuthBloc)
- [x] Onboarding first-launch logic (Splash reads `has_seen_onboarding`; OnboardingScreen marks it)
- [x] Router guard added (`AuthStateNotifier` as `refreshListenable`; redirect for unauth/auth)
