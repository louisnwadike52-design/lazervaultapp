import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';

/// App-global "re-check the backend now" signal.
///
/// The [AppStartupGate] only probes on launch, on resume, and on the
/// maintenance modal's "Try again" tap — so if the server goes down WHILE the
/// user is already sitting on an auth screen, the modal wouldn't appear until
/// one of those happens. Any pre-login flow (passcode/email/phone login, OTP,
/// signup) that hits a server-UNREACHABLE failure can call [pokeRecheck] to ask
/// the gate to re-probe immediately. It is only a *request to re-probe* — the
/// gate still confirms with a real 2xx health check + a device-online check
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
/// the server process is down, Cloudflare answers with a 5xx / the request
/// times out — never a 200. So the only "healthy" signal we trust is a **2xx**.
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
  ServerStatusService({http.Client? client}) : _client = client ?? http.Client();

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
  /// probe answers 2xx.
  static const int _healthAttempts = 6;

  /// Public, unauthenticated, Cloudflare-routed health endpoint.
  /// [endpointRegistry.httpCore] ends in `/api/v1`.
  Uri _healthUri() => Uri.parse('${endpointRegistry.httpCore}/health');

  Future<bool> _probeOnce({Duration? timeout}) async {
    try {
      final resp = await _client.get(_healthUri()).timeout(timeout ?? _timeout);
      // Strictly 2xx = backend up AND healthy. 401/404 would mean a wrong/gated
      // path, and 5xx/503 means degraded — both treated as NOT healthy here
      // because /api/v1/health is expected to answer 200 when good.
      return resp.statusCode >= 200 && resp.statusCode < 300;
    } catch (_) {
      return false; // socket/DNS/timeout → edge unreachable (machine off, etc.)
    }
  }

  /// Returns true when the backend answered a 2xx health check. Probes up to
  /// [_healthAttempts] times (the 5–7 retry floor) with a short gap between,
  /// returning true the instant ANY probe succeeds and false only after ALL
  /// attempts fail — so the maintenance modal only appears when the server is
  /// really, really down, not on a transient blip.
  Future<bool> isBackendHealthy() async {
    for (var attempt = 0; attempt < _healthAttempts; attempt++) {
      final healthy =
          await _probeOnce(timeout: attempt == 0 ? _timeout : _retryTimeout);
      if (healthy) return true;
      if (attempt < _healthAttempts - 1) {
        await Future<void>.delayed(_retryGap);
      }
    }
    return false;
  }
}
