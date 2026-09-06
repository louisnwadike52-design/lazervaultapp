import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The ONE correct `FlutterSecureStorage` configuration for this app.
///
/// ## Why this exists
///
/// `flutter_secure_storage` picks its Android backend from `AndroidOptions`. A
/// bare `const FlutterSecureStorage()` uses the DEFAULT keystore-backed store,
/// while the auth flow (injection_container, main.dart, login_flow_resolver)
/// writes `access_token` to the **EncryptedSharedPreferences** store. The two
/// are different physical stores, so a bare instance reads an EMPTY store on
/// Android and every token lookup returns null.
///
/// The symptom is never "auth is broken" — the user is signed in and the rest of
/// the app works. It surfaces only in whichever feature constructed its own bare
/// instance, as a misleading "You need to be logged in" / silent upload failure.
/// This has now been diagnosed repeatedly and independently (returning users
/// bounced to the login screen, Plan My Day "No authentication token found",
/// P2P chat media, and the escrow / invoice / SprayMe uploads).
///
/// ## How to use it
///
/// Prefer the DI singleton, `serviceLocator<FlutterSecureStorage>()`, which is
/// registered with this same configuration.
///
/// Where a class cannot reach the service locator, or exposes an injectable
/// `storage` parameter, make this the DEFAULT rather than a bare instance:
///
/// ```dart
/// MyService({FlutterSecureStorage? storage})
///     : _storage = storage ?? kAppSecureStorage;
/// ```
///
/// Never write `const FlutterSecureStorage()` for anything that reads a value
/// the auth flow wrote — it will silently read the wrong store on Android.
const FlutterSecureStorage kAppSecureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
    // Matches injection_container/login_flow_resolver: a corrupt entry should
    // reset rather than throw and wedge the caller.
    resetOnError: true,
  ),
);
