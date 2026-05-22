# OneUI85Simulator

Samsung One UI 8.5 lock screen and home simulator built with Flutter 3.x for **Android 12+** (API 31).

| Item | Value |
|------|-------|
| Package | `com.oneui85.simulator` |
| minSdk | 31 |
| targetSdk | 35 |

## Setup

1. Install [Flutter](https://docs.flutter.dev/get-started/install) stable 3.x and Android SDK 35.
2. Place Samsung fonts in `assets/fonts/`:
   - `SamsungOne-400.ttf`
   - `SamsungOne-700.ttf`
   - `SamsungSharpSans-Bold.ttf`
3. Add wallpaper JPEGs (optional placeholders):
   - `assets/wallpapers/default_1.jpg`
   - `assets/wallpapers/default_2.jpg`
   - `assets/wallpapers/default_3.jpg`
4. Run:

```bash
flutter pub get
flutter run
```

## Features

- Lock screen: parallax wallpaper, weather particles, 4 clock styles, notification stack, shortcuts, swipe up to unlock
- Now Bar with rotating items and Now Brief sheet
- Home: paged app grid, dock, drag reorder, app open hero animation
- Customization bottom sheet (long-press lock/home)
- Unlock / lock transitions

## CI/CD (GitHub Actions)

Workflows in `.github/workflows/`:

| Workflow | Output |
|----------|--------|
| `build_apk.yml` | `oneui85-release.apk` |
| `build_aab.yml` | `oneui85-release.aab` |
| `code_quality.yml` | analyze, test, format check |

### Cloud signing (no local keystore required)

GitHub Actions workflows (`build_apk.yml`, `build_aab.yml`) automatically:

1. Generate a release keystore at `android/app/release.jks` using `keytool`
2. Write `android/key.properties` for Gradle signing
3. Build and upload signed APK/AAB artifacts

No GitHub Secrets are required for CI builds.

**Important limitations:**

- The signing password is defined in the workflow files (suitable for testing and downloading artifacts, not for production Play Store releases).
- A new ephemeral keystore is generated on each workflow run, so the signing key may differ between builds. You cannot upgrade an installed app across CI builds unless you use a fixed keystore (e.g. GitHub Secrets or Actions cache).

**Local signing (optional):** create `android/key.properties` (gitignored) pointing to your own keystore. See `android/key.properties.example`.

## Code generation (optional)

If you extend Freezed models:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## License

Educational UI simulator — not affiliated with Samsung.
