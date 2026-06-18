import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/core/config/app_environment.dart'
    show currentAppEnvironment;

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
    'inactivity_timeout_seconds',
  };

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

    // 2. Cold path — if cache was empty, seed from `dotenv` so the
    //    first frame still has something to dial. Every key the
    //    runtime cares about lives in `.env`/`.env.prod` already.
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
      final resp = await http
          .get(Uri.parse(_settingsRefreshUrl))
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
  String get httpAdmin       => _get('url_admin_gateway',       '${_tierBase('https')}/api/v1/admin');
  String get httpChatAgent   => _get('url_chat_agent_gateway',  _tierBase('https'));
  String get httpVoiceAgent  => _get('url_voice_agent_gateway', _tierBase('https'));
  String get httpVoiceLang   => _get('url_voice_language_api',  '${_tierBase('https')}/voice/languages');
  String get httpStorage     => _get('url_storage',             '${_tierBase('https')}/v1/storage');
  String get httpWebhookBase => _get('url_webhook_base',        '${_tierBase('https')}/webhooks');

  String get wsVoice         => _get('url_ws_voice',            '${_tierBase('wss')}/ws/voice');
  String get wsBalance       => _get('url_ws_balance',          '${_tierBase('wss')}/ws/balance');
  String get wsContactless   => _get('url_ws_contactless',      '${_tierBase('wss')}/ws/contactless');

  /// App-wide inactivity auto-logout threshold, in seconds. Admin-tunable via
  /// the `inactivity_timeout_seconds` system setting (single source of truth);
  /// defaults to 30s and is clamped to a sane [5, 3600] range so a bad admin
  /// value can never lock users out instantly or disable the feature outright.
  int get inactivityTimeoutSeconds {
    final n = int.tryParse(_get('inactivity_timeout_seconds', '30').trim()) ?? 30;
    return n.clamp(5, 3600);
  }

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
