# News App — Agent Instructions

Flutter news reader app with local auth, NewsAPI integration, and feature-first architecture.

## Tech Stack

- **Flutter** SDK ^3.11.1
- **State management:** Provider + ChangeNotifier
- **Local storage:** Hive CE via `UserRepository` (user profile + app settings)
- **Remote:** HTTP → NewsAPI (`newsapi.org`)
- **UI:** flutter_screenutil, cached_network_image, shimmer, flutter_svg

## Project Structure

```
lib/
├── main.dart                    # App entry, init UserRepository
├── core/
│   ├── constants/               # Constant, AppSizes
│   ├── datasource/
│   │   ├── local_data/servies/  # UserRepository (singleton)
│   │   └── remote_data/         # ApiService, ApiConfig
│   ├── enums/                   # RequestStatus (loading | error | loaded)
│   ├── mixins/                  # SafeNotifyMixin
│   ├── models/                  # UserModel (Hive)
│   ├── repos/                   # NewsRepository
│   ├── theme/                   # lightTheme, LightColor
│   └── widget/                  # Shared widgets (Custom_*)
└── features/
    ├── auth/                    # LoginScreen, RegisterScreen (StatefulWidget)
    ├── home/                    # HomeController, news lists, categories
    ├── main/                    # Bottom nav shell
    ├── onboarding/
    ├── profile/
    ├── search/
    ├── splash/                  # Routes based on onboarding + login flags
    └── ...
```

## Architecture Conventions

- **Feature-first:** each feature owns screens, controllers, and local models/components.
- **Controllers:** `ChangeNotifier` + `SafeNotifyMixin`, named `*_controller.dart`.
- **Provider scope:** per-screen `ChangeNotifierProvider`, not a global tree.
- **Repositories:** singleton for local data; instantiated per-screen for remote news.
- **Navigation:** imperative `Navigator` + `MaterialPageRoute` (no go_router).

## App Flow

```
SplashScreen (2s)
  → Onboarding (if !onboarding_complete)
  → LoginScreen (if !is_logged_in)
  → MainScreen (Home | Search | Bookmark | Profile)
```

All local persistence lives in Hive via `UserRepository` (`settings_box` for onboarding, `user_box` for profile/session).

## Coding Standards

- Use `package:news_app/...` imports (avoid mixing relative imports).
- Use `AppSizes` helpers (`.sp`, `.h`, `.w`, `.r`) for responsive sizing.
- Use `RequestStatus` enum + `switch` for async UI states.
- Call `safeNotify()` instead of `notifyListeners()` in controllers.
- Reuse existing widgets: `CustomTextFromField`, `CustomCachedNetworkImage`, `CustomSvgPicture`.
- Keep changes minimal — match existing patterns, don't refactor unrelated code.

## Data Layer Notes

- **UserRepository:** Hive boxes for user profile and app settings (onboarding flag).
- **NewsRepository:** fetches from NewsAPI; maps JSON to `NewsArticleModel`.
- Auth is local-only — no backend. API key lives in `api_config.dart`.

## Code Generation

Hive adapters require build_runner:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Common Commands

```bash
flutter pub get
flutter analyze
flutter run
```

## Known WIP Areas

Auth/session flow is actively being worked on (`preferences_manager`, `user_repository`, `user_model`, splash, sign-in, onboarding, profile). When touching auth:

- Set `isLoggedIn` on `UserModel` via `UserRepository` after login/sign-up.
- Use `UserRepository().logout()` on logout.
- Profile data source is Hive (`UserRepository`).

## Do Not

- Add new state management libraries without explicit request.
- Rename existing typo folders (`servies`, `detalis`, `onbording`) unless asked.
- Commit `.env` or move API keys to tracked files without user approval.
- Over-engineer abstractions — this is a portfolio-scale app.
