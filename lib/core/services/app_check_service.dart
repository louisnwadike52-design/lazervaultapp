import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

/// Wires Firebase App Check, which wraps the platform device-attestation APIs:
/// - iOS      -> Apple **App Attest** (`AppleProvider.appAttest`)
/// - Android  -> Google **Play Integrity** (`AndroidProvider.playIntegrity`)
/// - debug    -> a debug provider so emulators/simulators and CI can mint a
///               token registered in the Firebase console (App Check > Apps >
///               Manage debug tokens).
///
/// App Check proves a request originates from the genuine, unmodified app on a
/// real device — scripts, repackaged apps, and bots cannot mint a valid token.
/// The auth-service / core-gateway verify the resulting JWT against the
/// Firebase App Check JWKS. See `appcheck-attestation-config` for the project
/// IDs and the server-side verification contract.
///
/// Must be activated AFTER `Firebase.initializeApp` and BEFORE any App Check
/// token is requested. Activation is idempotent and safe to call more than once.
class AppCheckService {
  AppCheckService._();

  static final AppCheckService instance = AppCheckService._();

  bool _activated = false;

  // ---- In-app token cache + failure back-off ---------------------------------
  // App Check attestation (Play Integrity / App Attest, and the debug provider)
  // is rate-limited by Apple/Google. Calling getToken() on every outbound
  // request — as the gRPC/HTTP metadata helpers do — will trip "Too many
  // attempts" the moment attestation can't mint a token (e.g. an emulator whose
  // debug token isn't registered). We therefore serve a cached token until it's
  // near expiry and, on failure, back off instead of hammering the provider.
  String? _cachedToken;
  DateTime? _tokenExpiry; // refresh at/after this instant (JWT exp minus margin)
  DateTime? _cooldownUntil; // don't call the provider again until this instant
  bool _loggedThisCooldown = false;

  /// Refresh margin — fetch a new token this long before the JWT actually
  /// expires so an in-flight request never carries an expired token.
  static const Duration _refreshMargin = Duration(minutes: 5);

  /// Fallback cache lifetime when the token's own `exp` can't be parsed.
  static const Duration _fallbackTtl = Duration(minutes: 30);

  /// Back-off after a generic failure (offline, provider hiccup).
  static const Duration _failureCooldown = Duration(minutes: 5);

  /// Longer back-off specifically for rate-limit ("too many attempts") — the
  /// provider is actively refusing, so retrying soon only extends the ban.
  static const Duration _rateLimitCooldown = Duration(minutes: 15);

  /// Activate App Check with the right provider per platform/build.
  ///
  /// In debug builds we use the debug provider so the app still works on
  /// simulators/emulators (App Attest / Play Integrity require real hardware).
  /// Release builds use the hardware-backed providers.
  Future<void> activate() async {
    if (_activated) return;
    _activated = true;

    try {
      await FirebaseAppCheck.instance.activate(
        // Android: Play Integrity in release, debug provider otherwise.
        androidProvider:
            kReleaseMode ? AndroidProvider.playIntegrity : AndroidProvider.debug,
        // iOS/macOS: App Attest in release, debug provider otherwise.
        appleProvider:
            kReleaseMode ? AppleProvider.appAttest : AppleProvider.debug,
      );

      // Auto-refresh keeps a fresh token cached so request paths never block on
      // a network round-trip to mint one.
      await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    } catch (e) {
      // App Check must never hard-block app startup. If activation fails (no
      // Play Services, attestation unavailable, offline first launch), we log
      // and continue — the gateway runs App Check in report-only until enforce,
      // and login still proceeds via the other layers (OTP, device record).
      debugPrint('AppCheckService.activate failed (non-fatal): $e');
    }
  }

  /// Fetch the current App Check token to attach to outbound requests as
  /// `X-Firebase-AppCheck`. Returns null when unavailable (offline, debug token
  /// not yet registered) — callers must treat a missing token as "no
  /// attestation this call" rather than an error.
  ///
  /// [forceRefresh] bypasses the cached token (use sparingly — Apple/Google
  /// rate-limit fresh attestations).
  Future<String?> getToken({bool forceRefresh = false}) async {
    if (!_activated) return null;

    final now = DateTime.now();

    // 1) Serve the cached token while it's still fresh — the common path, and
    //    the whole point: no provider round-trip per request.
    if (!forceRefresh &&
        _cachedToken != null &&
        _tokenExpiry != null &&
        now.isBefore(_tokenExpiry!)) {
      return _cachedToken;
    }

    // 2) In a failure back-off window: return the last good token if we still
    //    hold one, otherwise null. Never hit the provider until it elapses.
    if (!forceRefresh && _cooldownUntil != null && now.isBefore(_cooldownUntil!)) {
      return _cachedToken;
    }

    // 3) Actually mint/refresh a token.
    try {
      final token = await FirebaseAppCheck.instance.getToken(forceRefresh);
      if (token != null && token.isNotEmpty) {
        _cachedToken = token;
        _tokenExpiry = _expiryFromJwt(token) ?? now.add(_fallbackTtl);
        _cooldownUntil = null;
        _loggedThisCooldown = false;
        return token;
      }
      // Null/empty without throwing — treat as a soft miss with a short cooldown.
      _enterCooldown(now, _failureCooldown, 'App Check returned no token');
      return _cachedToken;
    } catch (e) {
      final isRateLimit =
          e.toString().toLowerCase().contains('too many attempts');
      _enterCooldown(
        now,
        isRateLimit ? _rateLimitCooldown : _failureCooldown,
        e.toString(),
      );
      // Fall back to the last good token if we have one; else null ("no
      // attestation this call") — callers must tolerate that.
      return _cachedToken;
    }
  }

  /// Record a back-off window and log AT MOST ONCE per window so a failing
  /// provider can't spam the log on every request.
  void _enterCooldown(DateTime now, Duration cooldown, String reason) {
    _cooldownUntil = now.add(cooldown);
    if (!_loggedThisCooldown) {
      _loggedThisCooldown = true;
      debugPrint('AppCheckService: token unavailable, backing off '
          '${cooldown.inMinutes}m — $reason');
    }
  }

  /// Parse the `exp` claim (seconds since epoch) from an App Check JWT and
  /// return the instant we should refresh (exp minus a safety margin). Returns
  /// null if the token isn't a decodable JWT, so callers use the fallback TTL.
  DateTime? _expiryFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      payload = payload.padRight((payload.length + 3) & ~3, '=');
      final map = json.decode(utf8.decode(base64.decode(payload)));
      final exp = map is Map ? map['exp'] : null;
      if (exp is! int) return null;
      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final refreshAt = expiry.subtract(_refreshMargin);
      // Guard against a clock-skewed / already-expired token.
      return refreshAt.isAfter(DateTime.now()) ? refreshAt : null;
    } catch (_) {
      return null;
    }
  }

  /// True on platforms where App Check attestation is meaningful. Desktop/web
  /// flavors of this app don't ship the attestation providers.
  bool get isSupportedPlatform => Platform.isIOS || Platform.isAndroid;
}
