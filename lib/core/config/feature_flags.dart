import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight client-side feature-flag cache.
///
/// Backed by SharedPreferences so admin-side flips survive cold-start, and
/// re-hydrated from the admin/system_settings endpoint on each app launch
/// (call [FeatureFlags.refresh] from a startup hook that has the cached
/// settings map — same place the EndpointRegistry refresh is wired).
///
/// New flags should be:
///   1) Declared as a `static const String` key.
///   2) Exposed via a getter that returns the SharedPreferences value, with
///      a safe default if the key hasn't been seeded yet.
///   3) Hidden-by-default if exposing the surface costs us anything.
class FeatureFlags {
  // ── Existing flags ────────────────────────────────────────────────────────
  static const String useNewTransferApi = 'use_new_transfer_api';

  // ── Dashboard section visibility (admin-toggled) ──────────────────────────
  // Key the admin-side system_settings table uses. The toggle is intentionally
  // OFF by default — the Cards card on the dashboard is hidden from the user
  // until the admin flips the flag from Flutter Service Configs in the
  // admin dashboard. Code path is otherwise unchanged, so flipping the flag
  // back to true restores the section without redeploy.
  static const String dashboardCardsSectionVisible =
      'dashboard_cards_section_visible';

  // Visibility of the "Voice & Chat Assistant" accordion on the Settings page.
  // OFF by default — hidden until an admin flips this key from the admin
  // dashboard Feature Flags tab. Flip to true to restore it with no redeploy.
  static const String voiceChatAssistantSectionVisible =
      'voice_chat_assistant_section_visible';

  // ── Send Funds (transfer) flow config (admin-toggled) ─────────────────────
  // Read after login + cached (EndpointRegistry → applyRemoteSnapshot) so they
  // resolve instantly and survive poor networks via the cached value.
  //
  // sendFundsShortFlowEnabled: false (DEFAULT) = current long flow; true = the
  //   streamlined short flow (inline recipient → amount → PIN → receipt).
  static const String sendFundsShortFlowEnabled =
      'send_funds_short_flow_enabled';
  // sendFundsPinRequired: true (DEFAULT) = transaction PIN required to send.
  //   This is a UI gate ONLY — the authoritative check is server-side in
  //   core-payments-service SendFunds. Default ON for safety.
  static const String sendFundsPinRequired = 'send_funds_pin_required';

  // ── Platform authentication mode (admin-selected) ─────────────────────────
  // Single mutually-exclusive enum mirrored from system_settings(auth_mode):
  //   'email_password' (DEFAULT) | 'phone_passcode'
  // Decides which signup/login flow brand-new / logged-out users see. Existing
  // users keep their own per-account method regardless of this value. Stored as
  // a STRING (not a bool) and read synchronously at boot to pick the flow.
  // Defaults to email_password so there is zero change until an admin flips it.
  static const String authMode = 'auth_mode';
  static const String authModeEmailPassword = 'email_password';
  static const String authModePhonePasscode = 'phone_passcode';

  // ── Insurance hosted-webview entry points (admin-toggled) ─────────────────
  // When ON, the in-app "Buy" and "Manage Plan" insurance entry points open
  // MyCover's universal hosted webview (insuranceHostedLink) in a themed
  // bottom sheet instead of the native in-app flow. Renew/Claim are unchanged.
  // Mirrored from system_settings via the same internal endpoint the app
  // already polls. OFF by default — zero change until an admin flips it.
  static const String insuranceHostedEntrypointsEnabled =
      'insurance_hosted_entrypoints_enabled';
  // The universal MyCover merchant link (string). The Buy/Manage entry points
  // compose the per-user URL from this base client-side (append email/phone/
  // client_reference). Empty by default → hosted mode unavailable even if the
  // toggle is on (the sheet renders an "unavailable" state).
  static const String insuranceHostedLink = 'insurance_hosted_link';

  static SharedPreferences? _prefs;

  /// Called once from app boot (after SharedPreferences is available) so the
  /// synchronous getters below don't have to await. Idempotent.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Apply a fresh batch of flags pulled from the admin endpoint. The map is
  /// the same shape as the `url_*` cache the EndpointRegistry already
  /// refreshes — just `key → "true"/"false"`. Silently ignores unknown keys.
  static Future<void> applyRemoteSnapshot(Map<String, String> remote) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    for (final key in <String>[
      dashboardCardsSectionVisible,
      voiceChatAssistantSectionVisible,
      sendFundsShortFlowEnabled,
      sendFundsPinRequired,
      insuranceHostedEntrypointsEnabled,
    ]) {
      final v = remote[key];
      if (v == null) continue;
      await prefs.setBool(key, v.toLowerCase() == 'true');
    }
    // insurance_hosted_link is a string (a URL), not a boolean — store verbatim.
    final hostedLink = remote[insuranceHostedLink];
    if (hostedLink != null) {
      await prefs.setString(insuranceHostedLink, hostedLink.trim());
    }
    // auth_mode is a string enum, not a boolean — store it verbatim (normalized
    // to a known value; anything unexpected falls back to email_password).
    final mode = remote[authMode];
    if (mode != null) {
      final m = mode.toLowerCase().trim();
      await prefs.setString(
        authMode,
        m == authModePhonePasscode ? authModePhonePasscode : authModeEmailPassword,
      );
    }
  }

  // ── Existing transfer-API helpers ────────────────────────────────────────
  static bool isUsingNewTransferApi() {
    return _prefs?.getBool(useNewTransferApi) ?? false;
  }

  static void enableNewTransferApi() {
    _prefs?.setBool(useNewTransferApi, true);
  }

  // ── Dashboard cards visibility ───────────────────────────────────────────
  /// `false` by default so the Cards section stays hidden until an admin
  /// enables it from Flutter Service Configs. Synchronous read — must be
  /// called after [init].
  static bool get dashboardCardsVisible {
    return _prefs?.getBool(dashboardCardsSectionVisible) ?? false;
  }

  // ── Voice & Chat Assistant section visibility ────────────────────────────
  /// `false` by default so the "Voice & Chat Assistant" settings accordion
  /// stays hidden until an admin enables it. Synchronous read — call after
  /// [init].
  static bool get voiceChatAssistantVisible {
    return _prefs?.getBool(voiceChatAssistantSectionVisible) ?? false;
  }

  // ── Send Funds flow config ───────────────────────────────────────────────
  /// `false` (long/current flow) by default until an admin enables the short
  /// flow. Synchronous read — call after [init].
  static bool get sendFundsShortFlow {
    return _prefs?.getBool(sendFundsShortFlowEnabled) ?? false;
  }

  /// `true` (PIN required) by default — fail-safe. UI gate only; the backend
  /// independently enforces the same setting. Synchronous read — call after
  /// [init].
  static bool get sendFundsPinIsRequired {
    return _prefs?.getBool(sendFundsPinRequired) ?? true;
  }

  // ── Insurance hosted-webview entry points ────────────────────────────────
  /// `false` by default → native in-app Buy + Manage flows. When `true`, those
  /// two entry points open the MyCover hosted webview. Synchronous — call after
  /// [init].
  static bool get insuranceHostedEntrypoints {
    return _prefs?.getBool(insuranceHostedEntrypointsEnabled) ?? false;
  }

  /// The universal MyCover hosted base link, or empty when unset. The Buy/Manage
  /// flows compose the per-user URL from this. Synchronous — call after [init].
  static String get insuranceHostedBaseLink {
    return _prefs?.getString(insuranceHostedLink) ?? '';
  }

  // ── Platform authentication mode ─────────────────────────────────────────
  /// Active platform auth mode, defaulting to `email_password` so the existing
  /// flow is used until an admin enables phone+passcode. Synchronous — call
  /// after [init].
  static String get authenticationMode {
    return _prefs?.getString(authMode) ?? authModeEmailPassword;
  }

  /// True when the platform is in phone+passcode mode (brand-new/logged-out
  /// users get the phone onboarding + phone login). Existing accounts always
  /// keep their own method regardless of this flag.
  static bool get isPhonePasscodeMode {
    return authenticationMode == authModePhonePasscode;
  }

  /// Overwrite the cached auth mode (used by a startup refresh that reads the
  /// authoritative value from GET /api/v1/auth/config). Idempotent.
  static Future<void> setAuthenticationMode(String mode) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final m = mode.toLowerCase().trim();
    await prefs.setString(
      authMode,
      m == authModePhonePasscode ? authModePhonePasscode : authModeEmailPassword,
    );
  }
}
