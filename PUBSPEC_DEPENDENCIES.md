# Required Package Dependencies for Statistics Feature

## Add these to pubspec.yaml

### Core Dependencies (already included)
```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2

  # DI
  get_it: ^7.6.4

  # Networking
  grpc: ^3.2.4
  protobuf: ^3.1.0
  fixnum: ^1.1.0

  # Secure Storage
  flutter_secure_storage: ^9.0.0

  # UI Components
  flutter_screenutil: ^5.9.0

  # Utilities
  intl: ^0.18.1
  equatable: ^2.0.5

  # WebSocket
  web_socket_channel: ^2.4.0
```

### Additional Dependencies for Statistics Feature

```yaml
dependencies:
  # Charts and Visualizations
  fl_chart: ^0.65.0
  synced_scroll_controller: ^0.0.2

  # Date & Time
  timeago: ^3.6.0

  # Caching
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # Analytics
  firebase_analytics: ^10.8.0
  mixpanel_flutter: ^2.2.0

  # Error Reporting
  sentry_flutter: ^7.14.0
  crashlytics: ^3.4.9

dev_dependencies:
  # Testing
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.5
  mockito: ^5.4.4
  build_runner: ^2.4.7
  json_serializable: ^6.7.1

  # Code Quality
  flutter_lints: ^3.0.1

  # Performance
  flutter_driver:
    sdk: flutter
  test: ^1.24.0
  integration_test:
    sdk: flutter
```

## Installation Commands

```bash
# Get all dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Clean and rebuild
flutter clean
flutter pub get
```

## Platform-Specific Setup

### iOS (Podfile)
```ruby
# Add to Podfile
pod 'Protobuf', '~> 3.21'
```

### Android (build.gradle)
```groovy
// Add to app/build.gradle
implementation 'com.google.protobuf:protobuf-java:3.21.0'
implementation 'io.grpc:grpc-okhttp:1.57.2'
```

## Version Compatibility

- **Minimum Flutter SDK**: 3.16.0
- **Dart SDK**: >=3.2.0 <4.0.0
- **iOS**: >=12.0
- **Android**: API Level 21+ (Android 5.0 Lollipop)

## Troubleshooting

### Dependency Conflicts
```bash
# Clear pub cache
flutter pub cache repair

# Resolve dependencies
flutter pub deps
```

### Build Issues
```bash
# Clean build
flutter clean
cd ios && pod install && cd ..
flutter pub run
```
