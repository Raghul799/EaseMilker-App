# Ease Milker

A new Flutter project.

## App basics

- Purpose: Ease Milker is a mobile-first Flutter app that helps small dairy farmers monitor and manage automated milking devices and view daily milk production statistics.
- Platforms: Android, iOS, Web, macOS, Windows and Linux (built with Flutter).
- What this README includes: high-level usage notes and how to run the app locally. It intentionally omits any package identifiers, bundle IDs, keys, or other sensitive information.

### Running locally (developer)

1. Ensure Flutter is installed and on your PATH.
2. From the project root, fetch dependencies:

```powershell
flutter pub get
```

3. Run on a device or simulator (example Android):

```powershell
flutter run -d <device-id>
```

Notes:
- This project uses standard Flutter tooling. If you encounter build issues, try `flutter clean` then `flutter pub get` and rebuild.
- Do not share platform-specific signing files or provisioning profiles. This README deliberately avoids listing any identifiers or secrets.

### Contact / contributions

If you want to contribute, open an issue or submit a pull request. Keep changes focused, add tests for new logic, and avoid committing secrets.
