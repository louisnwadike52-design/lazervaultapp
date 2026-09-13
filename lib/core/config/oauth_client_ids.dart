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

  /// The iOS OAuth client. MUST match GIDClientID in ios/Runner/Info.plist
  /// (whose REVERSED form is the CFBundleURLSchemes entry).
  ///
  /// This is the SAME client the Gmail (Plan My Day) flow already uses —
  /// project lazervault-dev (961906506476), bundle com.lazervault.app.
  /// GoogleSignIn.instance is a SINGLETON, so iOS login must reuse this one
  /// client (and its web client below as serverClientId) or it would collide
  /// with the already-initialised Gmail configuration. The backend accepts the
  /// token because [googleWebIos] is in GOOGLE_OAUTH_AUDIENCES; the token is
  /// Google-signed and verified server-side regardless of which project's
  /// client id it carries.
  static const String googleIos =
      '961906506476-1n6ktov46o0n3ck8s1qvafadjkasn0j5.apps.googleusercontent.com';

  /// The WEB client passed as serverClientId on iOS — the lazervault-dev web
  /// client (GMAIL_WEB_CLIENT_ID). Using it keeps iOS login's GoogleSignIn
  /// init identical to Gmail's (same project, no singleton conflict) and makes
  /// the returned ID token audienced to a client the backend already trusts.
  /// Kept in sync with the GMAIL_WEB_CLIENT_ID env value; the repository
  /// prefers that env var and falls back to this constant.
  static const String googleWebIos =
      '961906506476-51ugt48f8os51a8r9pvmftavuo86ksul.apps.googleusercontent.com';

  /// Sign in with Apple needs no client id in the app: the identity token's
  /// audience is the bundle id itself (com.lazervault.app), which the
  /// backend lists in APPLE_OAUTH_AUDIENCES.
  static const String appleBundleId = 'com.lazervault.app';
}
