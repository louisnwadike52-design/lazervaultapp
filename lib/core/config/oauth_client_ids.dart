/// OAuth client ids for Sign in with Google / Apple.
///
/// These are PUBLIC identifiers (they ship inside every installed app and in
/// every Google sign-in redirect), not secrets — safe to commit. The secret
/// half of the flow is the backend's JWKS verification: auth-service accepts
/// only tokens whose audience matches these ids
/// (GOOGLE_OAUTH_AUDIENCES / APPLE_OAUTH_AUDIENCES in its .env), so both
/// sides must list the same ids.
///
/// All ids belong to the `lazervault-28875` Google project / the
/// com.lazervault.app Apple bundle id.
abstract final class OAuthClientIds {
  /// The WEB (type-3) OAuth client. Passed as `serverClientId` so the ID
  /// token Google returns is audienced to the BACKEND — this is the id
  /// auth-service checks, on both Android and iOS sign-ins.
  static const String googleWeb =
      '815870072849-0rj1ekjanhck3u9mutl5lenh90neu9dc.apps.googleusercontent.com';

  /// The iOS OAuth client. Must match GIDClientID in ios/Runner/Info.plist
  /// (whose REVERSED form is the CFBundleURLSchemes entry). Empty = Google
  /// sign-in hides itself on iOS rather than crashing the plugin.
  static const String googleIos = '';

  /// Sign in with Apple needs no client id in the app: the identity token's
  /// audience is the bundle id itself (com.lazervault.app), which the
  /// backend lists in APPLE_OAUTH_AUDIENCES.
  static const String appleBundleId = 'com.lazervault.app';
}
