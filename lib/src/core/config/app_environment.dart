import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application Environment Configuration
///
/// Centralized environment detection and configuration.
/// The app automatically loads the correct .env file:
/// - Emulator → .env (development)
/// - Physical device → .env.prod (production)
///
/// Environment Hierarchy:
/// ┌─────────────────┬─────────────────────────────────────────────────┐
/// │ Environment     │ Behavior                                        │
/// ├─────────────────┼─────────────────────────────────────────────────┤
/// │ development     │ Test APIs, sandbox mode, verbose logging        │
/// │ staging         │ Test APIs, sandbox mode, limited logging        │
/// │ production      │ Live APIs, strict security, minimal logging     │
/// └─────────────────┴─────────────────────────────────────────────────┘
enum AppEnvironment {
  development,
  staging,
  production;

  /// Parse environment from string
  static AppEnvironment fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'production':
      case 'prod':
        return AppEnvironment.production;
      case 'staging':
      case 'stage':
        return AppEnvironment.staging;
      case 'development':
      case 'dev':
      default:
        return AppEnvironment.development;
    }
  }

  /// Get display name
  String get displayName {
    switch (this) {
      case AppEnvironment.development:
        return 'Development';
      case AppEnvironment.staging:
        return 'Staging';
      case AppEnvironment.production:
        return 'Production';
    }
  }

  /// Whether this is a production environment
  bool get isProduction => this == AppEnvironment.production;

  /// Whether this is a development environment
  bool get isDevelopment => this == AppEnvironment.development;

  /// Whether this is a staging environment
  bool get isStaging => this == AppEnvironment.staging;

  /// Whether to use sandbox/test APIs
  bool get useSandbox => this != AppEnvironment.production;

  /// Whether verbose logging is enabled
  bool get verboseLogging => this == AppEnvironment.development;

  /// Whether to show debug UI elements
  bool get showDebugUI => this == AppEnvironment.development;

  /// Short three-letter tier name matching the backend `ENVIRONMENT` var
  /// (`dev` / `staging` / `prod`). Used wherever we cross to backend / DNS
  /// concepts that don't speak the long "development" form — most notably
  /// the path-prefix routing.
  String get tierName {
    switch (this) {
      case AppEnvironment.development:
        return 'dev';
      case AppEnvironment.staging:
        return 'staging';
      case AppEnvironment.production:
        return 'prod';
    }
  }

  /// Sub-domain segment used by EVERY transport (HTTP, WebSocket, gRPC) to
  /// reach the right tier's backend (see endpoint_registry.dart _tierBase/grpcBase
  /// — the `api.` prefix is only used for prod; dev/staging drop it):
  ///   dev      → `dev.lazervault.app`
  ///   staging  → `staging.lazervault.app`
  ///   prod     → `api.lazervault.app`            (prod-only `api.` prefix)
  ///
  /// Cloudflare DNS dispatches by sub-hostname directly to the matching
  /// backend (cloudflared tunnel for dev + staging, k8s Istio ingress for
  /// prod). No path prefix, no edge Worker, no rewrite.
  ///
  /// Used by `EndpointRegistry._tierBase` (HTTP/WS) and `grpcBase` (gRPC).
  String get envSubdomain {
    switch (this) {
      case AppEnvironment.development:
        return 'dev';
      case AppEnvironment.staging:
        return 'staging';
      case AppEnvironment.production:
        return '';
    }
  }
}

/// Build-time tier identity. Set via `--dart-define FLUTTER_FLAVOR=<tier>`
/// from the Android product-flavor `dartDefines` block (build.gradle.kts) and
/// the iOS gym `DART_DEFINES` xcargs. Read at build time (not `dotenv.env`) so
/// the tier is locked into the binary — operators can't accidentally swap the
/// `.env` and have a dev build talk to production.
///
/// Empty string when the `--dart-define` did NOT bake into the binary (the
/// historical "prod build still hit dev" failure mode). We resolve that case
/// below rather than trusting a raw default here.
const String _flavorDefine = String.fromEnvironment('FLUTTER_FLAVOR');

/// The single resolved build flavor (`dev` / `staging` / `prod`), FAIL-CLOSED.
///
/// If the compile-time define is present, it wins. If it is MISSING (mis-bake),
/// a RELEASE binary resolves to `prod` — a release must never silently point at
/// the dev backend / dev Firebase / sandbox mode again. Debug & profile builds
/// still resolve to `dev` so a plain `flutter run` (no flavor) targets the local
/// dev stack. `kReleaseMode` is a compile-time `const`, so this stays `const`.
///
/// This is the ONE source of truth for the build tier — `firebase_options.dart`
/// imports it too, so the backend tier and Firebase project can never disagree.
// NB: `== ''` (not `.isNotEmpty`) — String equality is const-legal; a method
// call on a String is not, and this must stay a compile-time constant.
const String resolvedFlavor =
    _flavorDefine == '' ? (kReleaseMode ? 'prod' : 'dev') : _flavorDefine;

/// The tier this build was compiled for. Use this whenever you need to know
/// whether to talk to dev / staging / prod backends; do NOT introspect
/// `dotenv.env['ENVIRONMENT']` directly, that string is mutable at runtime
/// and can drift from the binary's identity.
AppEnvironment get currentAppEnvironment =>
    AppEnvironment.fromString(resolvedFlavor);
