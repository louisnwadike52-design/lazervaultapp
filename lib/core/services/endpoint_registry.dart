import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/core/config/app_environment.dart'
    show currentAppEnvironment;
import 'package:lazervault/core/config/feature_flags.dart';

/// Single chokepoint for every backend URL the Flutter app talks to —
/// gRPC channels, HTTP REST gateways, WebSockets, the chat/voice agent
/// HTTP routes, storage, and provider webhook bases.
///
/// Stale-while-revalidate semantics, exactly as agreed with the user:
///
///   * **Cold start (first launch ever)** — SharedPreferences is empty,
///     so values come from `.env` / `.env.prod` via `flutter_dotenv`.
///     Defaults are then seeded into SharedPreferences so the *next*
///     launch starts warm.
///
///   * **Warm start (every subsequent launch)** — SharedPreferences is
///     read SYNCHRONOUSLY (zero network) and exposed immediately, so the
///     first frame uses the last-known-good URLs. The cache is the
///     authoritative source for any caller until the background fetch
///     overwrites it.
///
///   * **Background refresh** — a fire-and-forget `Future` polls the
///     admin-gateway's internal endpoint
///     (`GET https://api.lazervault.app/api/v1/internal/voice-agents/settings`)
///     for every `url_*` key, writes the fresh values to
///     SharedPreferences, and pings the [ValueNotifier] so any subscriber
///     can react. A failure is logged + ignored — startup is never
///     blocked on a remote read. The next launch sees the new cache.
///
///   * **API** — typed accessors ([grpcBase], [httpBase], [wsUrl]) that
///     hide the raw map. Callers don't see SharedPreferences directly.
///
/// Lifecycle:
///   1. Register a singleton at GetIt at the very top of the DI graph.
///   2. `await EndpointRegistry.instance.ensureReady()` once, ideally
///      in `main.dart` right after `dotenv.load(...)` and before
///      `init()` of the rest of DI.
///   3. From there on, anything that needed `dotenv.env['X']` reads
///      `endpointRegistry.X` instead.
class EndpointRegistry {
  EndpointRegistry._();
  static final EndpointRegistry instance = EndpointRegistry._();

  /// SharedPreferences key prefix so the URL registry namespace can't
  /// collide with any pre-existing key the app already stores.
  static const String _prefix = 'lv.endpoint.';

  /// Non-`url_` admin keys that the registry also caches (read at startup and
  /// refreshed in the background exactly like the URLs). Keep this tiny — it's
  /// for app-wide runtime knobs that must be admin-tunable without a release.
  static const Set<String> _persistedNonUrlKeys = {
    'session_inactivity_logout_seconds',
    'splitbill_external_receiver_enabled',
    // Whether Split Bills appears as a quick action INSIDE the send-funds flow.
    // Cached like the other admin knobs so the send-funds screen can decide on
    // the first frame — a tile that appears a moment after the sheet opens is
    // worse than one that was never there.
    'splitbill_sendfunds_entry_visible',
    // Flutter feature flags (admin-toggled). Cached here like every other
    // admin knob; FeatureFlags.applyRemoteSnapshot reads them at boot.
    'dashboard_cards_section_visible',
    'voice_chat_assistant_section_visible',
    // African voice-language master gate (English-only when off). Cached so the
    // language picker can hide African languages even on the offline fallback path.
    'voice_african_languages_enabled',
    // Send Funds flow config (admin-toggled). Cached after login; the send-funds
    // flow reads these via FeatureFlags for instant, poor-network-safe routing.
    'send_funds_short_flow_enabled',
    'send_funds_pin_required',
    // Batch Transfer flow config (admin-toggled). Same internal poll; read via
    // FeatureFlags for instant, poor-network-safe short/long routing.
    'batch_transfer_short_flow_enabled',
    'batch_transfer_pin_required',
    // Scan Account Details (OCR) config (admin-toggled). Gates the scan quick
    // action + whether scanned identifiers resolve to internal users.
    'scan_account_details_enabled',
    'scan_resolve_users_enabled',
    // Standalone signup BVN screen (admin-toggled, OFF by default). Gates
    // whether signup shows the dedicated BVN screen; the default onboarding
    // uses Mono Prove (whose webhook auto-provisions the virtual account).
    'bvn_signup_screen_enabled',
    // Insurance hosted-webview entry points (admin-toggled). The toggle gates
    // whether Buy + Manage open MyCover's hosted webview; the link is the
    // universal base the app composes the per-user URL from. Read via
    // FeatureFlags at boot.
    'insurance_hosted_entrypoints_enabled',
    'insurance_hosted_link',
    // Whether the Insurance service appears at all (tiles + All-Services
    // search). Admin-toggled, hidden by default — see
    // FeatureFlags.insuranceVisible.
    'insurance_enabled',
    // Airtime landing tabs (admin-toggled). Show/hide Buy / International / Sell.
    // Buy + International default ON; Sell (airtime-to-cash) default OFF. Read via
    // FeatureFlags so the airtime screen renders only the enabled tabs.
    'airtime_tab_buy_enabled',
    'airtime_tab_international_enabled',
    'airtime_tab_sell_enabled',
    // Invoice split-among-multiple-payers (admin-toggled, default OFF). Read via
    // FeatureFlags so the create-invoice flow hides the split step entirely.
    'invoice_split_enabled',
    // Platform authentication mode (email_password | phone_passcode). Cached
    // from the same internal settings poll and read via FeatureFlags at boot to
    // pick the signup/login flow.
    'auth_mode',
    // Onboarding verification requirement toggles (bool) — read via FeatureFlags
    // to decide whether the verify-email/phone step is skippable.
    'email_verification_required',
    'phone_verification_required',
    // App auto-update (store version check). Per-platform latest/min build
    // numbers + store URLs + master toggle + release notes. Cached here so the
    // version check is instant + offline-safe; AppUpdateService reads them via
    // FeatureFlags and compares against the running PackageInfo build number.
    'app_update_enabled',
    'app_latest_version_ios',
    'app_latest_build_ios',
    'app_min_build_ios',
    'app_store_url_ios',
    'app_latest_version_android',
    'app_latest_build_android',
    'app_min_build_android',
    'app_store_url_android',
    'app_update_notes',
  };

  /// Snapshot of the cached non-`url_` admin keys (feature flags + runtime
  /// knobs). FeatureFlags consumes this at boot to hydrate its flag cache.
  Map<String, String> nonUrlSnapshot() {
    final out = <String, String>{};
    for (final k in _persistedNonUrlKeys) {
      final v = _cache[k];
      if (v != null && v.isNotEmpty) out[k] = v;
    }
    return out;
  }

  /// SharedPreferences key (under [_prefix]) holding the `version+build` of the
  /// last launch. A change means a fresh install or an app update — both must
  /// drop the endpoint cache so a prior build's (possibly cross-env) URLs never
  /// stick. Excluded from the cache wipe so the comparison survives the reset.
  static const String _appBuildKey = 'app_build';

  /// Single source of truth for the admin endpoint Flutter polls. The
  /// tier is selected by sub-hostname:
  ///
  ///   dev      → https://dev.lazervault.app/api/v1/internal/voice-agents/settings
  ///   staging  → https://staging.lazervault.app/api/v1/internal/voice-agents/settings
  ///   prod     → https://api.lazervault.app/api/v1/internal/voice-agents/settings
  ///
  /// Cloudflare DNS resolves each sub-hostname directly to the matching
  /// tier's backend (cloudflared tunnel for dev + staging, k8s Istio LB
  /// for prod). No edge Worker / path-stripper in the chain.
  static String get _settingsRefreshUrl {
    final sub = currentAppEnvironment.envSubdomain;
    final host = sub.isEmpty
        ? 'api.lazervault.app'
        : '$sub.lazervault.app';
    return 'https://$host/api/v1/internal/voice-agents/settings';
  }

  /// Public accessor for the admin settings endpoint (no-auth internal read).
  /// Other admin-driven config services (e.g. HelpConfigService) reuse this so
  /// the host/tier resolution stays in one place.
  String get adminSettingsEndpoint => _settingsRefreshUrl;

  /// Background refresh budget. The first refresh after a cold install
  /// happens while the rest of the app is still booting and Flutter is
  /// competing with Gradle + the engine warm-up for I/O — 5s was too
  /// tight (most cold starts saw a TimeoutException). 10s leaves plenty
  /// of slack while still feeling instant on warm starts (cache is
  /// already populated so the timeout never matters for them).
  static const Duration _refreshTimeout = Duration(seconds: 10);

  /// In-memory mirror of the canonical map. Reads come from here on the
  /// hot path; writes happen during `ensureReady()` and the background
  /// refresh. Initialized empty so a caller that races [ensureReady]
  /// gets `null` (and falls back to its own default) instead of crashing.
  final Map<String, String> _cache = <String, String>{};

  /// Emits a non-null whenever the cache is updated (cold-start seed,
  /// background refresh) so widgets can rebuild if they care. Most
  /// callers won't subscribe — the cache itself is consulted every read.
  final ValueNotifier<int> changeTick = ValueNotifier<int>(0);

  bool _ready = false;
  bool _backgroundRefreshKicked = false;

  /// Cold + warm start path. Idempotent.
  /// Always returns after at most a single synchronous SharedPreferences
  /// read; the background refresh fires off and the future completes.
  Future<void> ensureReady() async {
    if (_ready) return;
    final prefs = await SharedPreferences.getInstance();

    // 1. Warm path — drain SharedPreferences into [_cache].
    var loadedFromCache = 0;
    for (final key in prefs.getKeys()) {
      if (key.startsWith(_prefix)) {
        final stored = prefs.getString(key);
        if (stored != null && stored.isNotEmpty) {
          _cache[key.substring(_prefix.length)] = stored;
          loadedFromCache++;
        }
      }
    }

    // 1b. INSTALL / UPDATE / FLAVOR GUARD — the cache must never be inherited
    //     across a fresh install, an app update (build-number change), or a
    //     flavor switch. Two independent staleness signals force a reset:
    //
    //       * Install/update — a new `version+build` vs the recorded one means
    //         the binary changed; a prior version's URLs (or a different env's
    //         URLs left in SharedPreferences after a same-package-id reinstall)
    //         must not stick. This is the "refresh cache on every install" rule.
    //       * Flavor mismatch — cached URLs point at a DIFFERENT tier than this
    //         build's flavor (e.g. a dev build reusing a prod app's prefs). That
    //         sends HTTP to the wrong backend (prod 404s) while gRPC correctly
    //         uses the dev host — exactly the "scan 404 on dev" bug.
    //
    //     Either condition wipes the endpoint cache and falls through to re-seed
    //     from THIS flavor's `.env`, after which the background refresh pulls the
    //     env-scoped `url_*` keys from the admin dashboard (the source of truth).
    var resetReason = '';
    String? currentBuild;
    try {
      final info = await PackageInfo.fromPlatform();
      currentBuild = '${info.version}+${info.buildNumber}';
    } catch (e) {
      // PackageInfo can fail under unit tests / unusual platforms — never block
      // startup on it; we simply skip the install-detection signal this launch.
      debugPrint('[EndpointRegistry] build-number check skipped: $e');
    }
    if (loadedFromCache > 0) {
      final storedBuild = prefs.getString(_prefix + _appBuildKey) ?? '';
      if (currentBuild != null &&
          storedBuild.isNotEmpty &&
          storedBuild != currentBuild) {
        resetReason = 'install/update ($storedBuild → $currentBuild)';
      }
      if (resetReason.isEmpty) {
        final expectedHost = Uri.tryParse(_tierBase('https'))?.host ?? '';
        final cachedCore = _cache['url_core_gateway'] ?? '';
        final cachedHost =
            cachedCore.isNotEmpty ? (Uri.tryParse(cachedCore)?.host ?? '') : '';
        if (expectedHost.isNotEmpty &&
            cachedHost.isNotEmpty &&
            cachedHost != expectedHost) {
          resetReason =
              'flavor mismatch (cached=$cachedHost, expected=$expectedHost)';
        }
      }
      if (resetReason.isNotEmpty) {
        debugPrint('[EndpointRegistry] $resetReason — resetting endpoint cache');
        _cache.clear();
        final stale = prefs
            .getKeys()
            .where((k) => k.startsWith(_prefix) && k != _prefix + _appBuildKey)
            .toList();
        for (final k in stale) {
          await prefs.remove(k);
        }
        loadedFromCache = 0; // fall through to re-seed from this flavor's .env
      }
    }
    // Record the current build so the NEXT launch can detect install/update.
    if (currentBuild != null) {
      await prefs.setString(_prefix + _appBuildKey, currentBuild);
    }

    // 2. Cold path — if cache was empty (or just reset above), seed from `dotenv`
    //    so the first frame still has something to dial. Every key the runtime
    //    cares about lives in `.env`/`.env.prod` already.
    if (loadedFromCache == 0) {
      _seedFromDotenv(prefs);
    } else {
      debugPrint('[EndpointRegistry] Using cached URLs ($loadedFromCache keys)');
    }

    _ready = true;
    changeTick.value++;

    // 3. Always kick the background refresh — both warm and cold start
    //    benefit (warm to pick up admin edits; cold to overwrite the
    //    dotenv defaults with the canonical Cloudflare-fronted URLs).
    unawaited(_kickBackgroundRefresh(prefs));
  }

  /// Seeds [_cache] (and SharedPreferences for the next launch) from
  /// `.env`. The keys map 1:1 to the admin registry's `url_*` keys.
  void _seedFromDotenv(SharedPreferences prefs) {
    // Defaults match the post-tunnel layout described in
    // ~/.cloudflared/config.yml. dotenv values OVERRIDE these so a
    // developer with a local `.env` pointing at 10.0.2.2 still works
    // without ever talking to the cloud admin endpoint.
    //
    // Built from [_tierBase] so dev → dev.lazervault.app,
    // staging → staging.lazervault.app, prod → api.lazervault.app.
    // Must NOT be `const` — the values interpolate the runtime tier.
    final httpsBase = _tierBase('https');
    final wssBase = _tierBase('wss');
    // Inline mirror of [grpcBase] for the seed map — same asymmetric rule:
    // dev/staging drop `api.` from the host, prod keeps it.
    final sub = currentAppEnvironment.envSubdomain;
    final grpcHostPort = sub.isNotEmpty
        ? '$sub.lazervault.app:443'
        : 'api.lazervault.app:443';
    final seeds = <String, String>{
      'url_grpc_base':            grpcHostPort,
      'url_core_gateway':         '$httpsBase/api/v1',
      'url_transfer_gateway':     '$httpsBase/api/v1',
      'url_financial_gateway':    '$httpsBase/api/v1',
      'url_banking_gateway':      '$httpsBase/api/v1',
      'url_commerce_gateway':     '$httpsBase/api/v1',
      'url_investment_gateway':   '$httpsBase/api/v1',
      'url_business_gateway':     '$httpsBase/api/v1',
      'url_products_gateway':     '$httpsBase/api/v1',
      'url_statistics_gateway':   '$httpsBase/api/v1',
      // Lifestyle + planning gateways share the same per-tier REST base (the
      // env sub-hostname dispatches by path). Dedicated keys so an operator can
      // repoint just these later without touching the others.
      'url_lifestyle_gateway':    '$httpsBase/api/v1',
      'url_planning_gateway':     '$httpsBase/api/v1',
      'url_admin_gateway':        '$httpsBase/api/v1/admin',
      // Chat + voice gateway BASE URLs — the host only. Every voice/chat
      // client appends the `/voice/...` or `/chat/...` prefix itself
      // (see voice_session_cubit.dart, voice_biometrics_service.dart,
      // ai_chat_service.dart). Including the segment here used to cause
      // URL doubling like `<host>/voice/voice/session/start`
      // → 404 → "Voice service temporarily unavailable" surfaced by
      // voice_enrollment_cubit.dart's error mapping.
      'url_chat_agent_gateway':   httpsBase,
      'url_voice_agent_gateway':  httpsBase,
      // url_voice_language_api is the FULL endpoint, not a base — callers
      // hit it directly via Uri.parse(httpVoiceLang).
      'url_voice_language_api':   '$httpsBase/voice/languages',
      'url_ws_voice':             '$wssBase/ws/voice',
      'url_ws_balance':           '$wssBase/ws/balance',
      // Contactless (tap-to-pay) realtime WS — host-only base, exactly like
      // wsVoice. The receiver phone subscribes here right after creating a
      // session; the gateway fans the completion event back. MUST be the
      // cloudflared host (dev.lazervault.app), never 10.0.2.2, so a real
      // phone (not just the Android emulator) can connect.
      'url_ws_contactless':       '$wssBase/ws/contactless',
      'url_storage':              '$httpsBase/v1/storage',
      'url_webhook_base':         '$httpsBase/webhooks',
      // Client telemetry ingest — the telemetry-collector service translates
      // batched app events into Prometheus metrics. Best-effort; failures are
      // re-queued and dropped after a cap, never surfaced to the user.
      'url_telemetry_ingest':     '$httpsBase/api/v1/telemetry/ingest',
      // Admin ops-alerts feed — read via the ADMIN-GATEWAY (AdminAuthMiddleware
      // verifies the JWT + admin role), which proxies to notifications-service.
      // The notifications read surface itself is internal-only (not public).
      'url_ops_alerts':           '$httpsBase/api/v1/admin/ops-alerts',
    };
    var seeded = 0;
    for (final entry in seeds.entries) {
      // dotenv wins when set so local-dev override behaviour is unchanged.
      final overridden = (dotenv.env[entry.key.toUpperCase()] ?? '').trim();
      final value = overridden.isNotEmpty ? overridden : entry.value;
      _cache[entry.key] = value;
      prefs.setString(_prefix + entry.key, value);
      seeded++;
    }
    debugPrint('[EndpointRegistry] Cold start — seeded $seeded URL defaults');
  }

  /// Calls the admin internal endpoint (no auth required by design — same
  /// endpoint the voice-agent-gateway / chat-svcs poll). Failures are
  /// swallowed so startup never blocks.
  Future<void> _kickBackgroundRefresh(SharedPreferences prefs) async {
    if (_backgroundRefreshKicked) return;
    _backgroundRefreshKicked = true;
    try {
      // Make env-scoping EXPLICIT. The admin-gateway resolves the settings tier
      // by precedence ?env > X-Env-Hint header > its own ENVIRONMENT var > "prod"
      // fallback. Relying on the deployment's ENVIRONMENT is fragile (an unset
      // var silently serves PROD URLs to a dev app). Sending the hint guarantees
      // the app always receives ITS OWN tier's `url_*` values regardless of which
      // admin-gateway instance answers behind the sub-hostname.
      final sub = currentAppEnvironment.envSubdomain;
      final envHint = sub.isEmpty ? 'prod' : sub; // '' → prod, 'dev', 'staging'
      final resp = await http
          .get(Uri.parse(_settingsRefreshUrl), headers: {'X-Env-Hint': envHint})
          .timeout(_refreshTimeout);
      if (resp.statusCode != 200) {
        debugPrint('[EndpointRegistry] refresh HTTP ${resp.statusCode}; '
            'keeping cached URLs');
        return;
      }
      final body = jsonDecode(resp.body);
      final settings = body is Map<String, dynamic>
          ? body['settings']
          : null;
      if (settings is! List) {
        debugPrint('[EndpointRegistry] refresh body shape unexpected; '
            'keeping cached URLs');
        return;
      }

      var updated = 0;
      for (final raw in settings) {
        if (raw is! Map) continue;
        final key = raw['key'];
        final value = raw['value'];
        if (key is! String || value is! String) continue;
        if (!key.startsWith('url_') && !_persistedNonUrlKeys.contains(key)) continue;
        if (_cache[key] == value) continue;
        _cache[key] = value;
        await prefs.setString(_prefix + key, value);
        updated++;
      }
      if (updated > 0) {
        debugPrint('[EndpointRegistry] background refresh updated '
            '$updated URL(s)');
        // Re-apply admin flags to FeatureFlags so a post-login refresh takes
        // effect WITHIN this session — the send-funds entry (and other flag
        // gates) read FeatureFlags synchronously, so without this they'd stay
        // stale until the next cold start.
        await FeatureFlags.applyRemoteSnapshot(nonUrlSnapshot());
        changeTick.value++;
      }
    } catch (e) {
      // Stale-while-revalidate: a refresh failure is NEVER user-visible.
      // The cache served on this launch keeps working; the next launch
      // tries again. Log at debugPrint so devs can see it during
      // diagnosis, but no banner / no analytics event for the user.
      final reason = e is TimeoutException ? 'timeout' : e.runtimeType.toString();
      debugPrint('[EndpointRegistry] background refresh skipped this turn '
          '($reason); cached URLs remain authoritative '
          '(${_cache.length} keys in cache)');
    } finally {
      _backgroundRefreshKicked = false;
    }
  }

  // ===== Typed accessors =====
  //
  // Callers stick to these and never touch [_cache] / SharedPreferences
  // directly. Every accessor degrades gracefully: if the key isn't in
  // the cache (e.g. brand new registry entry not yet synced), the
  // provided default is returned. Defaults match the cloudflared
  // ingress, so the contract holds even with an empty registry.

  String _get(String key, String fallback) {
    final v = _cache[key];
    if (v == null || v.isEmpty) return fallback;
    return v;
  }

  /// Build the per-tier base URL for HTTP / WebSocket fallbacks. Sub-
  /// hostnames are the single routing mechanism for every transport.
  /// Layout is intentionally asymmetric — prod keeps the legacy
  /// `api.lazervault.app` (the canonical customer-facing URL) while
  /// dev/staging drop the `api.` prefix so the hostname doesn't double
  /// up on the path's `/api/v1/` segment:
  ///
  ///   dev      → https://dev.lazervault.app
  ///   staging  → https://staging.lazervault.app
  ///   prod     → https://api.lazervault.app
  ///
  /// `scheme` switches between https / wss for the WS accessors.
  String _tierBase(String scheme) {
    final sub = currentAppEnvironment.envSubdomain; // 'dev' / 'staging' / ''
    final host = sub.isEmpty
        ? 'api.lazervault.app'
        : '$sub.lazervault.app';
    return '$scheme://$host';
  }

  /// Single host:port for every gRPC channel. Same sub-hostname routing
  /// as the HTTP/WS accessors above — `.pbgrpc.dart` keeps emitting
  /// unmodified `/pb.Service/Method` paths and Cloudflare DNS dispatches
  /// by SNI to the right cluster.
  String get grpcBase {
    final sub = currentAppEnvironment.envSubdomain; // 'dev' / 'staging' / ''
    if (sub.isNotEmpty) return '$sub.lazervault.app:443';
    // Honour the admin override only when the DB value already includes a
    // host:port (prevents a stale `https://…` row from sneaking in here).
    final cached = _cache['url_grpc_base'];
    if (cached != null && cached.contains(':') && !cached.contains('/')) {
      return cached;
    }
    return 'api.lazervault.app:443';
  }

  /// Convenience split for [ClientChannel] constructors.
  String get grpcHost {
    final parts = grpcBase.split(':');
    return parts.first;
  }

  int get grpcPort {
    final parts = grpcBase.split(':');
    if (parts.length < 2) return 443;
    return int.tryParse(parts[1]) ?? 443;
  }

  // Tier-aware accessors — fall back to `${_tierBase}/...` when the admin
  // DB hasn't seeded a URL yet. The DB also stores per-tier hostnames
  // (see migration 024) so a populated cache already carries the right
  // sub-hostname; the fallback only matters on a brand-new install
  // before the first background refresh completes.
  String get httpCore        => _get('url_core_gateway',        '${_tierBase('https')}/api/v1');
  String get httpTransfer    => _get('url_transfer_gateway',    '${_tierBase('https')}/api/v1');
  String get httpFinancial   => _get('url_financial_gateway',   '${_tierBase('https')}/api/v1');
  String get httpBanking     => _get('url_banking_gateway',     '${_tierBase('https')}/api/v1');
  String get httpCommerce    => _get('url_commerce_gateway',    '${_tierBase('https')}/api/v1');
  String get httpInvestment  => _get('url_investment_gateway',  '${_tierBase('https')}/api/v1');
  String get httpBusiness    => _get('url_business_gateway',    '${_tierBase('https')}/api/v1');
  String get httpProducts    => _get('url_products_gateway',    '${_tierBase('https')}/api/v1');
  String get httpStatistics  => _get('url_statistics_gateway',  '${_tierBase('https')}/api/v1');
  String get httpLifestyle   => _get('url_lifestyle_gateway',   '${_tierBase('https')}/api/v1');
  String get httpPlanning    => _get('url_planning_gateway',    '${_tierBase('https')}/api/v1');
  String get httpAdmin       => _get('url_admin_gateway',       '${_tierBase('https')}/api/v1/admin');
  String get httpChatAgent   => _get('url_chat_agent_gateway',  _tierBase('https'));
  String get httpVoiceAgent  => _get('url_voice_agent_gateway', _tierBase('https'));
  String get httpVoiceLang   => _get('url_voice_language_api',  '${_tierBase('https')}/voice/languages');
  String get httpStorage     => _get('url_storage',             '${_tierBase('https')}/v1/storage');
  String get httpWebhookBase => _get('url_webhook_base',        '${_tierBase('https')}/webhooks');
  String get telemetryIngest => _get('url_telemetry_ingest',    '${_tierBase('https')}/api/v1/telemetry/ingest');
  String get opsAlerts       => _get('url_ops_alerts',          '${_tierBase('https')}/api/v1/admin/ops-alerts');

  String get wsVoice         => _get('url_ws_voice',            '${_tierBase('wss')}/ws/voice');
  String get wsBalance       => _get('url_ws_balance',          '${_tierBase('wss')}/ws/balance');
  String get wsContactless   => _get('url_ws_contactless',      '${_tierBase('wss')}/ws/contactless');

  /// Resolve a realtime WS/HTTP endpoint's (host, port), honouring an OPTIONAL
  /// dev host override. With NO usable override we follow the tunnel host AND its
  /// port TOGETHER (443 → TLS).
  ///
  /// This closes a systemic prod bug: several services kept the tunnel host
  /// (`api.lazervault.app`) but defaulted the PORT to a loopback dev port
  /// (8082/8083/8084/8086/8088…), so on prod they dialed
  /// `api.lazervault.app:<devPort>` — a port the Cloudflare edge never serves —
  /// and the socket/request hung or failed (features silently degraded to
  /// SSE/polling, or just broke, e.g. the Financial Connections spinner). On prod
  /// there is no `*_HOST`/`*_PORT` in the bundled `.env`, so the override is
  /// absent and we correctly follow the 443 tunnel; local dev keeps its explicit
  /// loopback host:port override untouched.
  ({String host, int port}) resolveServiceHostPort({
    String? overrideHost,
    int? overridePort,
    required int devPort,
  }) {
    if (overrideHost != null && overrideHost.trim().isNotEmpty) {
      return (host: overrideHost.trim(), port: overridePort ?? devPort);
    }
    return (host: grpcHost, port: grpcPort);
  }

  /// App-wide screen-inactivity auto-logout threshold, in seconds. Admin-tunable
  /// via the `session_inactivity_logout_seconds` system setting (single source of
  /// truth — fetched from the admin dashboard). Defaults to **60 (1m) = ENABLED**;
  /// an admin can raise/lower it (clamped to a sane [15, 600] range so a bad value
  /// can never lock users out instantly) or set exactly `0` to DISABLE auto-logout.
  int get inactivityTimeoutSeconds {
    // Debug/emulator builds disable auto-logout so long manual test sessions
    // aren't interrupted. Release builds are unaffected — they still honour the
    // admin setting. (kDebugMode is compile-time stripped from release.)
    if (kDebugMode) return 0;
    final n =
        int.tryParse(_get('session_inactivity_logout_seconds', '60').trim()) ??
            60;
    if (n <= 0) return 0; // 0 = disabled (no auto-logout)
    return n.clamp(15, 600);
  }

  /// Whether a split bill may be paid to an external bank account (each
  /// co-payer pays the bank directly via the send-funds flow). Admin-tunable
  /// via the `splitbill_external_receiver_enabled` system setting (single
  /// source of truth) — NOT hardcoded. Defaults to ON (matches the backend
  /// seed default) so the bank-receiver option shows out of the box; an admin
  /// setting the key to "false" in system_settings still hides it (that value
  /// wins over this default via the background settings refresh).
  bool get splitBillExternalReceiverEnabled =>
      _get('splitbill_external_receiver_enabled', 'true').trim().toLowerCase() !=
          'false';

  /// Whether the Split Bills quick action shows inside the SEND-FUNDS flow.
  /// Admin-tunable via `splitbill_sendfunds_entry_visible`.
  ///
  /// Turning this off does NOT disable split bills — the service tile and every
  /// route stay live, so existing bills, deep links and notifications still
  /// work. It only removes the entry point from send-funds, for when the
  /// feature belongs under quick services rather than in the middle of a
  /// transfer. Defaults to ON so behaviour is unchanged until an admin opts out.
  bool get splitBillSendFundsEntryVisible =>
      _get('splitbill_sendfunds_entry_visible', 'true').trim().toLowerCase() !=
          'false';

  /// Raw read for any registered key — for places that store/read a key
  /// the typed accessors don't (yet) cover.
  String? raw(String urlKey) => _cache[urlKey];

  /// Test-only: replace the in-memory cache. Production code should
  /// never call this.
  @visibleForTesting
  void overrideForTest(Map<String, String> entries) {
    _cache
      ..clear()
      ..addAll(entries);
    _ready = true;
    changeTick.value++;
  }
}

/// Top-level shortcut so call sites read `endpointRegistry.httpCore`
/// rather than `EndpointRegistry.instance.httpCore` (mirrors the
/// `dotenv.env` ergonomics callers already know).
EndpointRegistry get endpointRegistry => EndpointRegistry.instance;
