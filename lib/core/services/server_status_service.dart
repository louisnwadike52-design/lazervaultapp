import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';

/// What a health probe actually established.
///
/// The old probe returned a bool, which merged two completely different facts:
/// "our gateway answered with a 5xx" and "we could not reach anything at all".
/// Only the first is evidence about OUR servers. The second is equally
/// consistent with the user's phone having no working data — and reporting it as
/// "Our servers are being worked on" tells someone a falsehood about us at the
/// exact moment they are deciding whether to trust us with their money.
enum BackendReachability {
  /// Our gateway answered below 500. It is alive, whatever else is true.
  healthy,

  /// Our gateway — or Cloudflare in front of it — answered with a 5xx. Something
  /// reached our infrastructure and our infrastructure reported a problem, so
  /// this is definitively ours no matter what the device's network is doing.
  serverError,

  /// Nothing answered: socket error, DNS failure, timeout. AMBIGUOUS — this is
  /// what a real outage looks like AND what a phone with no data looks like, and
  /// the two cannot be told apart from this signal alone.
  unreachable,
}

/// App-global "re-check the backend now" signal.
///
/// The [AppStartupGate] only probes on launch, on resume, and on the
/// maintenance modal's "Try again" tap — so if the server goes down WHILE the
/// user is already sitting on an auth screen, the modal wouldn't appear until
/// one of those happens. Any pre-login flow (passcode/email/phone login, OTP,
/// signup) that hits a server-UNREACHABLE failure can call [pokeRecheck] to ask
/// the gate to re-probe immediately. It is only a *request to re-probe* — the
/// gate still confirms with a real health check + a device-online check
/// before showing maintenance, so a one-off blip or the user's own offline
/// network never forces a false modal (offline stays a "check your connection"
/// snackbar; slow/flaky network is handled per-request, never here).
class ServerHealthNotifier extends ChangeNotifier {
  ServerHealthNotifier._();
  static final ServerHealthNotifier instance = ServerHealthNotifier._();

  /// Ask any listening [AppStartupGate] to re-probe backend health right now.
  void pokeRecheck() => notifyListeners();
}

/// Background reachability probe for the backend edge.
///
/// Hosting note: the backend can run on a local machine (even in prod, fronted
/// by a Cloudflare tunnel). If that machine is off/asleep, its battery died, or
/// the server process is down, Cloudflare answers with a 5xx or the request
/// times out. So "down" is precisely: no response, or a 5xx. Anything our
/// gateway answers itself — including a 4xx — proves it is alive. See
/// [_probeOnce].
///
/// Which URL: `/api/v1/health` on core-gateway. It checks the real dependencies
/// (auth, accounts, redis), not just "the process answered", and it lives under
/// `/api/v1` because the Cloudflare tunnel only routes `^/api/v1/...` — the
/// gateway's identical root `/health` is unreachable from outside the origin.
///
/// This used to probe `/api/v1/internal/voice-agents/settings`, chosen only
/// because it happened to be public and tunnel-routed. That tied "is the whole
/// backend up" to one unrelated feature's endpoint: any change to voice-agent
/// settings routing would have shown every user the maintenance screen while
/// the platform was perfectly healthy.
///
/// The probe runs entirely in the background (see AppStartupGate); it never
/// blocks app startup or the current screen.
class ServerStatusService {
  ServerStatusService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  static const Duration _timeout = Duration(seconds: 6);
  // Shorter per-probe timeout for the retry burst so confirming "really down"
  // stays bounded (worst case ≈ _healthAttempts × _retryTimeout + gaps).
  static const Duration _retryTimeout = Duration(seconds: 3);
  static const Duration _retryGap = Duration(milliseconds: 700);

  /// Minimum number of consecutive failed probes before we conclude the backend
  /// is REALLY down (and let the caller surface the maintenance modal). A 5–7
  /// retry floor: a one-off edge hiccup, a brief mobile-network drop, or a cold
  /// gateway must NEVER flash "under maintenance" — that scares users when the
  /// server is actually fine. We stop and report healthy the instant any single
  /// probe gets an answer from our gateway (see [_probeOnce] for what counts).
  static const int _healthAttempts = 6;

  /// Public, unauthenticated, Cloudflare-routed health endpoint.
  /// [endpointRegistry.httpCore] ends in `/api/v1`.
  Uri _healthUri() => Uri.parse('${endpointRegistry.httpCore}/health');

  Future<BackendReachability> _probeOnce({Duration? timeout}) async {
    try {
      final resp = await _client.get(_healthUri()).timeout(timeout ?? _timeout);
      // ANY response below 500 means OUR GATEWAY ANSWERED, and that is the
      // whole question this probe asks. A 4xx is produced by the gateway's own
      // router or middleware (404 no-such-route, 401 from the JWT layer) — a
      // dead origin cannot produce one, because Cloudflare answers 502/523 or
      // times out when it cannot reach the host.
      //
      // Being strict about 2xx here is a trap, and a costly one. /api/v1/health
      // is a NEW route: against an older gateway it does not exist, and because
      // JWTAuthMiddleware runs ahead of the catch-all wildcard, an unknown
      // /api/v1 path comes back 401 rather than 404 — verified against prod.
      // So a strict probe would have shown EVERY USER "Under maintenance" for
      // the entire window between shipping the app and deploying the gateway,
      // while the platform was perfectly healthy. Accepting <500 removes that
      // failure mode in both directions, permanently.
      //
      // 5xx stays unhealthy, and deliberately so: /api/v1/health answers 503
      // when a dependency (auth, accounts, redis) is failing, which is exactly
      // when the maintenance modal SHOULD appear. Same for Cloudflare's
      // 502/523 when the origin is gone.
      return resp.statusCode < 500
          ? BackendReachability.healthy
          // A 5xx is an ANSWER. Cloudflare's 502/523 when the origin is gone, or
          // our own /health returning 503 because auth/accounts/redis is failing.
          // Either way something spoke for us, so the fault is ours to report.
          : BackendReachability.serverError;
    } catch (_) {
      // socket/DNS/timeout. Says nothing about whose fault it is — see the enum.
      return BackendReachability.unreachable;
    }
  }

  /// Returns true when the backend answered the health check. Probes up to
  /// [_healthAttempts] times (the 5–7 retry floor) with a short gap between,
  /// returning true the instant ANY probe succeeds and false only after ALL
  /// attempts fail — so the maintenance modal only appears when the server is
  /// really, really down, not on a transient blip.
  Future<BackendReachability> checkReachability() async {
    var sawServerError = false;
    for (var attempt = 0; attempt < _healthAttempts; attempt++) {
      final outcome =
          await _probeOnce(timeout: attempt == 0 ? _timeout : _retryTimeout);
      if (outcome == BackendReachability.healthy) {
        return BackendReachability.healthy;
      }
      // Remembered across attempts: one 5xx anywhere in the burst is proof our
      // infrastructure is reachable and unwell, which outranks later timeouts.
      if (outcome == BackendReachability.serverError) sawServerError = true;
      if (attempt < _healthAttempts - 1) {
        await Future<void>.delayed(_retryGap);
      }
    }
    return sawServerError
        ? BackendReachability.serverError
        : BackendReachability.unreachable;
  }

  /// Well-known captive-portal probes, used ONLY to answer "does this device
  /// have working internet at all". Deliberately two, on separate operators, so
  /// one of them being blocked or down cannot alone convince us the user is
  /// offline.
  ///
  /// Neither request carries any data about the user — they are bare GETs to
  /// endpoints whose entire purpose is to return an empty 204, and they are the
  /// same ones Android itself uses.
  static const List<String> _internetProbeUrls = <String>[
    'https://cp.cloudflare.com/generate_204',
    'https://connectivitycheck.gstatic.com/generate_204',
  ];

  static const Duration _internetProbeTimeout = Duration(seconds: 4);

  /// True when the device can actually reach the public internet.
  ///
  /// This is the check that separates "our servers are down" from "your phone
  /// has no data". `connectivity_plus` cannot do it: it reports the RADIO state,
  /// so a phone showing four bars of 4G with an exhausted data bundle, a captive
  /// portal, or a broken APN reports itself as perfectly online.
  ///
  /// Exactly 204 counts. That is the point of a `generate_204` endpoint: real
  /// internet returns an empty 204, while a captive portal returns its own login
  /// page with a 200 or a redirect — so anything else means the connection is
  /// intercepted, which for our purposes is not working internet.
  Future<bool> hasWorkingInternet() async {
    for (final url in _internetProbeUrls) {
      try {
        final resp =
            await _client.get(Uri.parse(url)).timeout(_internetProbeTimeout);
        if (resp.statusCode == 204) return true;
      } catch (_) {
        // Try the next operator before concluding anything.
      }
    }
    return false;
  }
}
