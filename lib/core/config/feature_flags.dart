import 'package:flutter/foundation.dart';
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

  // African voice-language master gate (admin). OFF by default → the voice/chat
  // assistant is English-only and African languages (yo/ig/ha/pcm) are HIDDEN in
  // the language pickers. The server /voice/languages already filters by this; this
  // client copy is defense-in-depth for the offline fallback list.
  static const String voiceAfricanLanguagesEnabled =
      'voice_african_languages_enabled';

  // ── Quick-service landing entrance animation (admin-toggled) ──────────────
  // When ON (DEFAULT), tapping a quick service from the dashboard animates the
  // landing screen's content in — slide up from below + fade — exactly like the
  // Insurance landing. Admins can turn it OFF platform-wide from the admin
  // dashboard (no redeploy) if the motion is undesirable. Mirrored from
  // system_settings via the same internal endpoint the app already polls.
  static const String serviceEntranceAnimationEnabled =
      'mobile_service_entrance_animation_enabled';

  // ── Send Funds (transfer) flow config (admin-toggled) ─────────────────────
  // Read after login + cached (EndpointRegistry → applyRemoteSnapshot) so they
  // resolve instantly and survive poor networks via the cached value.
  //
  // sendFundsShortFlowEnabled: true (DEFAULT) = the streamlined short flow
  //   (inline recipient → amount → PIN → receipt) — the product default for
  //   every user on signup. An admin may set this false to make the long flow
  //   the platform default; a per-user setting still overrides either way.
  static const String sendFundsShortFlowEnabled =
      'send_funds_short_flow_enabled';
  // Persisted "last resolved" Send Funds flow (short=true/long=false). Written
  // through whenever the session pin is (re)resolved so the value survives a
  // logout/cold-start and can be loaded into memory at boot for INSTANT, offline
  // routing — the fresh admin/override value is revalidated on the next login in
  // the background and re-persisted only if it changed. See [pinSendFlowForSession].
  static const String sendFlowPinned = 'send_flow_pinned_short';
  // sendFundsPinRequired: true (DEFAULT) = transaction PIN required to send.
  //   This is a UI gate ONLY — the authoritative check is server-side in
  //   core-payments-service SendFunds. Default ON for safety.
  static const String sendFundsPinRequired = 'send_funds_pin_required';

  // ── Batch-transfer flow config (admin-toggled, mirrors send-funds) ────────
  // batchTransferShortFlowEnabled: false (DEFAULT) = current long flow
  //   (entry → multiselect → review → processing → receipt); true = the
  //   streamlined short flow (compose → PIN → receipt).
  static const String batchTransferShortFlowEnabled =
      'batch_transfer_short_flow_enabled';
  // batchTransferPinRequired: true (DEFAULT) = transaction PIN required. UI gate
  //   ONLY — authoritative check is server-side in core-payments BatchTransfer.
  static const String batchTransferPinRequired = 'batch_transfer_pin_required';

  // ── Scan Account Details (OCR) config (admin-toggled) ─────────────────────
  // scanAccountDetailsEnabled: true (DEFAULT) = the "Scan Account Details"
  //   quick action + scan history are shown; false hides them.
  static const String scanAccountDetailsEnabled = 'scan_account_details_enabled';
  // scanResolveUsersEnabled: true (DEFAULT) = a scanned phone/email/username
  //   resolved to a Lazervault user is offered as a free internal transfer;
  //   false ignores resolution (bank/external routing only). UI gate.
  static const String scanResolveUsersEnabled = 'scan_resolve_users_enabled';

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
  /// Canonical per-user resolved login flow (see [loginFlow]). Distinct from the
  /// platform [authMode]: this is what the specific account/user should see.
  static const String effectiveLoginMethod = 'effective_login_method';

  // ── Onboarding verification requirement toggles (admin-tunable) ───────────
  // When ON, the onboarding email/phone verification step is NOT skippable and
  // the backend enforces it at signup + login. OFF by default (skippable) — zero
  // change until an admin flips it. Mirrored from system_settings via the same
  // internal endpoint + GetAuthenticationConfig.
  static const String emailVerificationRequired = 'email_verification_required';
  static const String phoneVerificationRequired = 'phone_verification_required';

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

  // ── Airtime landing tabs (admin-toggled) ─────────────────────────────────
  // Show/hide each of the three Airtime tabs (Buy / International / Sell) from
  // the admin dashboard. Buy + International default ON; Sell (airtime-to-cash)
  // defaults OFF. Read via FeatureFlags at build time so the airtime screen only
  // renders the enabled tabs (and lands on the first enabled one).
  static const String airtimeTabBuyEnabled = 'airtime_tab_buy_enabled';
  static const String airtimeTabInternationalEnabled =
      'airtime_tab_international_enabled';
  static const String airtimeTabSellEnabled = 'airtime_tab_sell_enabled';

  // ── App auto-update (store version check) ─────────────────────────────────
  // Per-platform "latest" + "minimum supported" build numbers + store URLs,
  // mirrored from system_settings via the same internal endpoint the app polls.
  // AppUpdateService compares the running PackageInfo build number against these:
  //   build < latest → optional banner/modal; build < min → blocking gate.
  // Build numbers are monotonic integers stored as strings. Shorebird handles
  // Dart-only OTA patches separately (see docs/SHOREBIRD.md); these keys cover
  // native/store updates Shorebird can't deliver.
  static const String appUpdateEnabledKey = 'app_update_enabled';
  static const String appLatestVersionIos = 'app_latest_version_ios';
  static const String appLatestBuildIos = 'app_latest_build_ios';
  static const String appMinBuildIos = 'app_min_build_ios';
  static const String appStoreUrlIos = 'app_store_url_ios';
  static const String appLatestVersionAndroid = 'app_latest_version_android';
  static const String appLatestBuildAndroid = 'app_latest_build_android';
  static const String appMinBuildAndroid = 'app_min_build_android';
  static const String appStoreUrlAndroid = 'app_store_url_android';
  static const String appUpdateNotesKey = 'app_update_notes';

  static SharedPreferences? _prefs;

  /// Session-pinned Send Funds flow decision (short vs long). Loaded from the
  /// persisted [sendFlowPinned] at boot (fast, offline), re-resolved on login,
  /// and held in memory for routing — see [sendFlowShortForSession] /
  /// [pinSendFlowForSession].
  static bool? _sessionShortSendFlow;

  /// Depth of active Send Funds journeys. While > 0 (the user has entered a send
  /// flow and hasn't returned to the dashboard) the pin is FROZEN: a re-resolve
  /// is deferred (see [_repinPending]) so the flow can never switch mid-journey.
  static int _sendFlowDepth = 0;

  /// A re-resolve arrived while a send flow was active; apply it once the last
  /// flow ends (back on the dashboard).
  static bool _repinPending = false;

  /// Called once from app boot (after SharedPreferences is available) so the
  /// synchronous getters below don't have to await. Idempotent.
  ///
  /// Note: it deliberately does NOT seed the in-memory session pin
  /// [_sessionShortSendFlow] from the persisted value. The pin is established
  /// ONCE per login-session by the first genuine login (or a Settings change),
  /// so an in-session re-pin (app-lock unlock, background default change) can't
  /// flip the user. Cold-boot routing before that first login stays instant +
  /// offline-safe because [sendFlowShortForSession] falls back to the persisted
  /// [sendFlowPinned] value.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Test-only: rebind + clear the backing store so each test starts clean.
  /// No-op in production (never called). Call after
  /// `SharedPreferences.setMockInitialValues(...)`.
  @visibleForTesting
  static Future<void> debugResetForTest() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.clear();
    _sessionShortSendFlow = null;
    _sendFlowDepth = 0;
    _repinPending = false;
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
      serviceEntranceAnimationEnabled,
      sendFundsShortFlowEnabled,
      sendFundsPinRequired,
      batchTransferShortFlowEnabled,
      batchTransferPinRequired,
      scanAccountDetailsEnabled,
      scanResolveUsersEnabled,
      insuranceHostedEntrypointsEnabled,
      airtimeTabBuyEnabled,
      airtimeTabInternationalEnabled,
      airtimeTabSellEnabled,
      voiceAfricanLanguagesEnabled,
      emailVerificationRequired,
      phoneVerificationRequired,
      appUpdateEnabledKey,
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
    // App auto-update string values (build numbers, versions, store URLs, notes)
    // — stored verbatim. AppUpdateService parses build numbers on read.
    for (final key in <String>[
      appLatestVersionIos,
      appLatestBuildIos,
      appMinBuildIos,
      appStoreUrlIos,
      appLatestVersionAndroid,
      appLatestBuildAndroid,
      appMinBuildAndroid,
      appStoreUrlAndroid,
      appUpdateNotesKey,
    ]) {
      final v = remote[key];
      if (v == null) continue;
      await prefs.setString(key, v.trim());
    }
    // auth_mode is a string enum, not a boolean — store it verbatim (normalized
    // to a known value; anything unexpected falls back to phone_passcode, the
    // product default).
    final mode = remote[authMode];
    if (mode != null) {
      final m = mode.toLowerCase().trim();
      await prefs.setString(
        authMode,
        m == authModeEmailPassword ? authModeEmailPassword : authModePhonePasscode,
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

  // ── Quick-service landing entrance animation ─────────────────────────────
  /// `true` by default — quick-service landing screens animate their content in
  /// (slide-up + fade), matching the Insurance landing. Admin can flip this off
  /// platform-wide. Synchronous read — call after [init]; offline/first-launch
  /// defaults to ON so the motion is present out of the box.
  static bool get serviceEntranceAnimation {
    return _prefs?.getBool(serviceEntranceAnimationEnabled) ?? true;
  }

  // ── Send Funds flow config ───────────────────────────────────────────────
  /// `true` (SHORT flow) by DEFAULT for every user — the short flow is the
  /// product default on signup. An admin can flip the platform default to the
  /// long flow from the dashboard (key [sendFundsShortFlowEnabled], synced into
  /// prefs via the endpoint registry); when that admin value is present it wins.
  /// A per-user choice (see [transferStyleOverride]) still takes precedence over
  /// both via [useShortSendFlow]. Synchronous read — call after [init].
  static bool get sendFundsShortFlow {
    return _prefs?.getBool(sendFundsShortFlowEnabled) ?? true;
  }

  // ── Dashboard layout style ───────────────────────────────────────────────
  // User-selectable dashboard layout, mirroring the transfer-style override:
  //   "classic" (DEFAULT)  = today's layout — full-height quick-services grid
  //     with the refer-a-friend card directly below it.
  //   "showcase"           = compact quick-services grid + a small adverts
  //     carousel below it, with the refer-a-friend entry moved into a compact
  //     "view all" row that opens a modal. Purely a client-side preference.
  // Defaults to classic so the current view is retained until the user opts in.
  static const String userDashboardLayout = 'user_dashboard_layout';
  static const String dashboardLayoutClassic = 'classic';
  static const String dashboardLayoutShowcase = 'showcase';

  /// Bumps whenever the dashboard layout choice changes so a live dashboard can
  /// rebuild immediately (it may be kept alive inside the TabBarView). Widgets
  /// wrap the affected region in a `ValueListenableBuilder`.
  static final ValueNotifier<int> dashboardLayoutRevision =
      ValueNotifier<int>(0);

  /// `true` when the user has opted into the showcase layout (compact services +
  /// adverts carousel). Defaults to `false` (classic). Synchronous — call after
  /// [init].
  static bool get dashboardShowcaseLayout =>
      _prefs?.getString(userDashboardLayout) == dashboardLayoutShowcase;

  /// Persist the user's dashboard-layout choice. Pass anything other than
  /// "showcase" to fall back to the classic (default) layout.
  static Future<void> setDashboardLayout(String style) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final s = style.toLowerCase().trim();
    if (s == dashboardLayoutShowcase) {
      await prefs.setString(userDashboardLayout, s);
    } else {
      await prefs.remove(userDashboardLayout);
    }
    dashboardLayoutRevision.value++;
  }

  // User-selectable transfer style: "classic" (short flow) | "standard" (long
  // flow) | "" (follow the platform default). Client-side preference, mirroring
  // the auth_mode override pattern.
  static const String userTransferStyle = 'user_transfer_style';
  static const String transferStyleClassic = 'classic';
  static const String transferStyleStandard = 'standard';

  /// The user's explicit transfer-style choice, or `null` when they haven't
  /// chosen (→ follow the platform default). Synchronous read — call after [init].
  static String? get transferStyleOverride {
    final v = _prefs?.getString(userTransferStyle);
    return (v == null || v.isEmpty) ? null : v;
  }

  /// Resolved decision for which Send Funds flow to show: the per-user choice
  /// wins when set, otherwise the platform [sendFundsShortFlow] default.
  /// `true` = short ("classic"), `false` = long ("standard").
  static bool get useShortSendFlow {
    final override = transferStyleOverride;
    if (override == transferStyleClassic) return true;
    if (override == transferStyleStandard) return false;
    return sendFundsShortFlow;
  }

  /// Persist the user's transfer-style choice. Pass `null`/empty to clear the
  /// override and fall back to the platform default.
  static Future<void> setTransferStyle(String? style) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final s = (style ?? '').toLowerCase().trim();
    if (s == transferStyleClassic || s == transferStyleStandard) {
      await prefs.setString(userTransferStyle, s);
    } else {
      await prefs.remove(userTransferStyle);
    }
    // A style change is a DELIBERATE user action (Settings, never mid-send) —
    // force-re-pin so the new choice takes effect immediately for the next send,
    // even if a stray freeze were somehow active.
    pinSendFlowForSession(force: true);
  }

  /// The Send Funds flow decision to use everywhere the app STARTS a send
  /// journey. Returns the value pinned at login/boot (persisted, so it is stable
  /// for the whole session AND survives a cold start) — a mid-session background
  /// config refresh can never flip a user between the long and short flow
  /// mid-journey (e.g. switching right after the transaction-PIN sheet on a slow
  /// network). Falls back to the live [useShortSendFlow] only before the first
  /// pin (a brand-new install that has never resolved one).
  static bool get sendFlowShortForSession =>
      _sessionShortSendFlow ?? _prefs?.getBool(sendFlowPinned) ?? useShortSendFlow;

  /// (Re)resolve [useShortSendFlow] and pin it in memory + persist it (write-
  /// through) so the next cold start routes instantly with the last-known value.
  /// Called at login/session-revalidation (authentication_cubit, beside
  /// `LoginFlowResolver`) and on an explicit Settings change.
  ///
  /// A BACKGROUND re-resolve (login/session-revalidation) is FROZEN while a send
  /// flow is active ([_sendFlowDepth] > 0): it's deferred until the user is back
  /// on the dashboard, so a change can never take effect mid-journey. Memory is
  /// updated BEFORE the (async, fire-and-forget) disk write so the fast path is
  /// instant.
  ///
  /// A DELIBERATE user change (Settings) passes [force] — it is never mid-send,
  /// so it applies immediately and clears any deferred pin. `force` also makes
  /// the setting robust to a (bug-path) leaked [_sendFlowDepth] that would
  /// otherwise silently swallow the user's own change for the whole session.
  static void pinSendFlowForSession({bool force = false}) {
    if (!force) {
      // Establish the flow ONCE per login-session. A NON-force re-pin — an
      // app-lock passcode/biometric/voice unlock (session revalidation), a
      // background admin/remote default change, or a deferred re-pin applied
      // when a send journey ends — must NEVER flip the user mid-session (the
      // reported bug: short flow flipped to the long amount page right after a
      // send / after the receipt). It is re-resolved only on a GENUINE fresh
      // login (the pin is cleared on logout) or an explicit Settings change
      // ([force]).
      _repinPending = false;
      if (_sessionShortSendFlow != null) return;
    } else {
      _repinPending = false;
    }
    final v = useShortSendFlow;
    if (_sessionShortSendFlow == v) return; // unchanged — no memory/disk churn
    _sessionShortSendFlow = v;
    _prefs?.setBool(sendFlowPinned, v);
  }

  /// Clear the in-memory session flow pin (call on logout) so the NEXT genuine
  /// login re-resolves the flow (and picks up any changed platform default).
  /// The persisted [sendFlowPinned] value is intentionally KEPT so cold-boot
  /// routing before that login is still instant + offline-safe.
  static void clearSessionSendFlowPin() {
    _sessionShortSendFlow = null;
    _repinPending = false;
  }

  /// Mark that a Send Funds journey has been entered (the user tapped into it).
  /// Freezes the flow pin until the matching [endSendFlow] — reference-counted so
  /// nested send screens (picker → amount) don't unfreeze early.
  static void beginSendFlow() {
    _sendFlowDepth++;
  }

  /// Mark that a Send Funds screen was left. When the last one is gone (back on
  /// the dashboard) any deferred re-resolve is applied.
  static void endSendFlow() {
    if (_sendFlowDepth > 0) _sendFlowDepth--;
    if (_sendFlowDepth == 0 && _repinPending) {
      _repinPending = false;
      pinSendFlowForSession();
    }
  }

  /// `true` (PIN required) by default — fail-safe. UI gate only; the backend
  /// independently enforces the same setting. Synchronous read — call after
  /// [init].
  static bool get sendFundsPinIsRequired {
    return _prefs?.getBool(sendFundsPinRequired) ?? true;
  }

  // ── Batch Transfer flow config ───────────────────────────────────────────
  /// Batch transfer is PINNED to the long (step-by-step) flow by product
  /// decision — always false, regardless of any cached/admin short-flow value.
  /// (Re-enable the admin toggle by returning the prefs read below.)
  static bool get batchTransferShortFlow {
    return false;
    // return _prefs?.getBool(batchTransferShortFlowEnabled) ?? false;
  }

  /// `true` (PIN required) by default — fail-safe. UI gate only; the backend
  /// independently enforces the same setting. Synchronous read — call after [init].
  static bool get batchTransferPinIsRequired {
    return _prefs?.getBool(batchTransferPinRequired) ?? true;
  }

  // ── Scan Account Details config ──────────────────────────────────────────
  /// `true` (shown) by default until an admin hides the scan feature.
  /// Synchronous read — call after [init].
  static bool get scanAccountDetailsIsEnabled {
    return _prefs?.getBool(scanAccountDetailsEnabled) ?? true;
  }

  /// `true` (resolve scanned identifiers to Lazervault users for free internal
  /// transfers) by default. Synchronous read — call after [init].
  static bool get scanResolveUsersIsEnabled {
    return _prefs?.getBool(scanResolveUsersEnabled) ?? true;
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

  // ── Airtime landing tabs ─────────────────────────────────────────────────
  /// Buy (domestic airtime) tab — ON by default. Synchronous — call after [init].
  static bool get airtimeBuyTabIsEnabled {
    return _prefs?.getBool(airtimeTabBuyEnabled) ?? true;
  }

  /// International airtime tab — ON by default. Synchronous — call after [init].
  static bool get airtimeInternationalTabIsEnabled {
    return _prefs?.getBool(airtimeTabInternationalEnabled) ?? true;
  }

  /// Sell (airtime-to-cash) tab — OFF by default. Synchronous — call after [init].
  static bool get airtimeSellTabIsEnabled {
    return _prefs?.getBool(airtimeTabSellEnabled) ?? false;
  }

  /// African voice languages (yo/ig/ha/pcm) — OFF by default. When off the voice
  /// assistant is English-only and African languages are hidden in the pickers.
  /// Synchronous — call after [init].
  static bool get africanVoiceLanguagesEnabled {
    return _prefs?.getBool(voiceAfricanLanguagesEnabled) ?? false;
  }

  // ── Platform authentication mode ─────────────────────────────────────────
  /// Active platform auth mode, defaulting to `phone_passcode` (the product
  /// default) so a fresh/pre-config launch is CONSISTENT with the platform
  /// intent and doesn't flip to email when `/auth/config` is slow/unreachable.
  /// Synchronous — call after [init].
  static String get authenticationMode {
    return _prefs?.getString(authMode) ?? authModePhonePasscode;
  }

  /// True when the platform is in phone+passcode mode (brand-new/logged-out
  /// users get the phone onboarding + phone login). Existing accounts always
  /// keep their own method via [loginFlow].
  static bool get isPhonePasscodeMode {
    return authenticationMode == authModePhonePasscode;
  }

  /// Overwrite the cached auth mode (used by a startup refresh that reads the
  /// authoritative value from GET /api/v1/auth/config). Idempotent. Unknown
  /// values normalize to phone_passcode (the default).
  static Future<void> setAuthenticationMode(String mode) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final m = mode.toLowerCase().trim();
    await prefs.setString(
      authMode,
      m == authModeEmailPassword ? authModeEmailPassword : authModePhonePasscode,
    );
  }

  // ── Effective (per-user) login flow — SINGLE SOURCE OF TRUTH ─────────────
  /// The one canonical decision for "which login flow to show": either
  /// `phone_passcode` (→ passcode screen / phone signup) or `email_password`
  /// (→ email sign-in / email signup). It is resolved ONCE (from the account's
  /// shape + the user's explicit Settings choice) and cached here, so every
  /// site — the boot router, [AppRoutes.loginEntry]/[AppRoutes.signupEntry],
  /// and both login screens' sub-state — reads the SAME value instead of
  /// re-deriving it from a racy mix of signals.
  ///
  /// Offline-safe: a plain SharedPreferences read, never a network call. Falls
  /// back to the platform [authenticationMode] (itself default phone_passcode)
  /// when never set, so a brand-new user still follows the platform default.
  static String get loginFlow {
    return _prefs?.getString(effectiveLoginMethod) ?? authenticationMode;
  }

  /// True when the resolved per-user flow is email+password.
  static bool get isEmailPasswordLogin => loginFlow == authModeEmailPassword;

  /// Whether an effective login flow has been resolved+cached yet (used by the
  /// one-time boot migration to seed it from legacy signals).
  static bool get hasLoginFlow =>
      _prefs?.getString(effectiveLoginMethod) != null;

  /// Persist the resolved per-user login flow. Called on every successful login
  /// (from the account shape) and when the user switches method in Settings.
  static Future<void> setLoginFlow(String mode) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final m = mode.toLowerCase().trim();
    await prefs.setString(
      effectiveLoginMethod,
      m == authModeEmailPassword ? authModeEmailPassword : authModePhonePasscode,
    );
  }

  /// Whether onboarding email verification is required (admin toggle). When true
  /// the verify-email step is not skippable and the backend gates login on it.
  /// Defaults to false (skippable). Synchronous — call after [init].
  static bool get isEmailVerificationRequired {
    return _prefs?.getBool(emailVerificationRequired) ?? false;
  }

  /// Whether onboarding phone verification is required (admin toggle).
  static bool get isPhoneVerificationRequired {
    return _prefs?.getBool(phoneVerificationRequired) ?? false;
  }

  /// Overwrite the cached verification-required flags (used by the startup
  /// refresh that reads them from GET /api/v1/auth/config alongside auth_mode).
  static Future<void> setVerificationRequirements({
    required bool email,
    required bool phone,
  }) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(emailVerificationRequired, email);
    await prefs.setBool(phoneVerificationRequired, phone);
  }

  // ── App auto-update (store version check) ─────────────────────────────────
  /// Master toggle for the OPTIONAL update prompt (banner + one-time modal).
  /// `true` by default. The forced/blocking update (below minimum build) is
  /// independent of this and always applies. Synchronous — call after [init].
  static bool get appUpdateEnabled {
    return _prefs?.getBool(appUpdateEnabledKey) ?? true;
  }

  static int _buildOf(String key) {
    final raw = _prefs?.getString(key);
    if (raw == null || raw.trim().isEmpty) return 0;
    return int.tryParse(raw.trim()) ?? 0;
  }

  /// Latest available build number for the platform (0 = unset/unknown → no
  /// update prompt). Pass `isIOS = true` for iOS, false for Android.
  static int appLatestBuild({required bool isIOS}) {
    return _buildOf(isIOS ? appLatestBuildIos : appLatestBuildAndroid);
  }

  /// Minimum supported build number for the platform (0 = unset → never force).
  /// A running build below this triggers the blocking update gate.
  static int appMinBuild({required bool isIOS}) {
    return _buildOf(isIOS ? appMinBuildIos : appMinBuildAndroid);
  }

  /// Admin-configured store URL for the platform, or empty when unset (the
  /// service falls back to a sensible default store link).
  static String appStoreUrl({required bool isIOS}) {
    return (_prefs?.getString(isIOS ? appStoreUrlIos : appStoreUrlAndroid) ?? '')
        .trim();
  }

  /// Human-readable latest version string (e.g. "1.1.0") for display, or empty.
  static String appLatestVersion({required bool isIOS}) {
    return (_prefs?.getString(
              isIOS ? appLatestVersionIos : appLatestVersionAndroid,
            ) ??
            '')
        .trim();
  }

  /// Optional release notes shown in the update modal, or empty.
  static String get appUpdateNotes {
    return (_prefs?.getString(appUpdateNotesKey) ?? '').trim();
  }
}
