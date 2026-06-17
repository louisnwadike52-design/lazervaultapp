fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios setup_appstore

```sh
[bundle exec] fastlane ios setup_appstore
```

FIRST-TIME SETUP — verifies App Store Connect access, auto-creates the app listing if missing

### ios sync_signing

```sh
[bundle exec] fastlane ios sync_signing
```

Sync iOS code-signing via fastlane match. Run once on this machine.

### ios testflight_upload_existing

```sh
[bundle exec] fastlane ios testflight_upload_existing
```

Upload an existing IPA to TestFlight (skips rebuild). Useful when manually built in Xcode.

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Quick alias for the staging lane (TestFlight internal group)

### ios setup_push_credentials

```sh
[bundle exec] fastlane ios setup_push_credentials
```

Open Firebase Console pages for the APNs .p8 + VAPID upload (one-time setup)

### ios dev

```sh
[bundle exec] fastlane ios dev
```

Dev → Firebase App Distribution (internal testers)

### ios staging

```sh
[bundle exec] fastlane ios staging
```

Staging → TestFlight (internal group)

### ios production

```sh
[bundle exec] fastlane ios production
```

Production → TestFlight (external) + App Store (no auto-submit)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
