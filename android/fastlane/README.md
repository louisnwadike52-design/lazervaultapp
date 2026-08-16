fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android dev

```sh
[bundle exec] fastlane android dev
```

Dev → Play Console internal track (PROD build: prod backend/Firebase, auto-rolls to internal testers)

### android staging

```sh
[bundle exec] fastlane android staging
```

Staging → Play Console closed (alpha) track (PROD build: prod backend/Firebase, auto-rolls to alpha testers)

### android production

```sh
[bundle exec] fastlane android production
```

Production → Play Console production track (release-signed AAB, HOLDS rollout in draft)

### android promote_to_production

```sh
[bundle exec] fastlane android promote_to_production
```

Promote alpha → production (no rebuild, just track switch)

### android dev_firebase

```sh
[bundle exec] fastlane android dev_firebase
```

Dev fallback → Firebase App Distribution (debug-signed APK, no keystore needed)

### android staging_firebase

```sh
[bundle exec] fastlane android staging_firebase
```

Staging fallback → Firebase App Distribution (debug-signed APK)

### android shorebird_release

```sh
[bundle exec] fastlane android shorebird_release
```

Shorebird patch-capable RELEASE (AAB) → Play Console internal track

### android shorebird_patch

```sh
[bundle exec] fastlane android shorebird_patch
```

Shorebird OTA PATCH (Dart-only) → already-shipped release (no store, no bump)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
