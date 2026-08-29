import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/app_check_service.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/utils/logger.dart';

class GrpcCallOptionsHelper {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  final FlutterSecureStorage storage;
  final LocaleManager? localeManager;
  final AccountManager? accountManager;

  // Callback to refresh tokens when they expire
  Future<Map<String, String>?> Function()? onTokenRefreshNeeded;

  // Track if we're currently refreshing to avoid multiple concurrent refreshes
  bool _isRefreshing = false;

  // Completer to allow multiple calls to wait for the same refresh operation
  Completer<bool>? _refreshCompleter;

  GrpcCallOptionsHelper(
    this.storage, {
    this.localeManager,
    this.accountManager,
    this.onTokenRefreshNeeded,
  });

  /// Create CallOptions with authorization, locale, and account metadata
  ///
  /// This is the primary method that should be used for all gRPC calls.
  /// It automatically injects:
  /// - Authorization: Bearer token
  /// - X-Locale: locale (e.g., "en-US", "en-NG")
  /// - X-Account-Id: active account UUID (if account manager available)
  Future<CallOptions> withAuth([CallOptions? options]) async {
    var accessToken = await storage.read(key: _accessTokenKey);

    // The access token can be TRANSIENTLY absent right after app-start or during
    // auth restore — it's written to secure storage asynchronously. Any RPC that
    // fires in that window (e.g. the insurance home screen's parallel companion
    // reads: statistics / payments / user-insurances) would otherwise send NO
    // authorization header and the gateway rejects it with "authorization token
    // not provided". Briefly retry the read so a token that's moments away from
    // being written is picked up. Zero delay in the common case (token already
    // present); bounded to ~0.6s only when it's initially empty.
    if (accessToken == null || accessToken.isEmpty) {
      for (var attempt = 0; attempt < 5; attempt++) {
        await Future.delayed(const Duration(milliseconds: 120));
        accessToken = await storage.read(key: _accessTokenKey);
        if (accessToken != null && accessToken.isNotEmpty) break;
      }
    }

    print('=== GrpcCallOptionsHelper.withAuth ===');
    print('Access token present: ${accessToken != null && accessToken.isNotEmpty}');
    if (accessToken != null && accessToken.isNotEmpty) {
      print('Access token length: ${accessToken.length}');
      print('Access token prefix: ${accessToken.substring(0, accessToken.length > 20 ? 20 : accessToken.length)}...');
    }

    final metadata = <String, String>{};

    // Add authorization header
    if (accessToken != null && accessToken.isNotEmpty) {
      metadata['authorization'] = 'Bearer $accessToken';
    } else {
      print('WARNING: No access token found in secure storage');
    }

    // Add the Firebase App Check token (device attestation). Lowercase key for
    // gRPC metadata; the gateway forwards/reads `x-firebase-appcheck`. Bounded
    // by a short timeout so a slow/first attestation never blocks the RPC —
    // the gateway runs App Check report-only until enforce, so a missing token
    // is non-fatal.
    try {
      final appCheckToken = await AppCheckService.instance
          .getToken()
          .timeout(const Duration(seconds: 3), onTimeout: () => null);
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        metadata['x-firebase-appcheck'] = appCheckToken;
      }
    } catch (_) {
      // Non-fatal: proceed without the attestation header.
    }

    // Add locale metadata if LocaleManager is available
    if (localeManager != null) {
      final localeMetadata = localeManager!.getLocaleMetadata();
      metadata.addAll(localeMetadata);
      print('Locale metadata added: $localeMetadata');
    }

    // Add account metadata if AccountManager is available and has active account
    if (accountManager != null && accountManager!.hasActiveAccount) {
      final accountMetadata = accountManager!.getAccountMetadata();
      if (accountMetadata.isNotEmpty) {
        metadata.addAll(accountMetadata);
        print('Account metadata added: $accountMetadata');
      } else {
        print('WARNING: AccountManager exists but no active account is set');
      }
    }

    // Add user country and currency metadata for provider routing and multi-currency support
    if (localeManager != null) {
      final country = localeManager!.currentCountry;
      if (country.isNotEmpty) {
        metadata['x-user-country'] = country;
      }
      final currency = localeManager!.currentCurrency;
      if (currency.isNotEmpty) {
        metadata['x-currency'] = currency;
      }
    }

    // Preserve any existing metadata from options
    if (options != null && options.metadata.isNotEmpty) {
      metadata.addAll(options.metadata);
    }

    print('Final metadata keys: ${metadata.keys.toList()}');

    return CallOptions(metadata: metadata);
  }

  /// Call options for UNAUTHENTICATED endpoints (login / signup / phone-OTP):
  /// attaches the Firebase App Check device-attestation token + locale/country/
  /// currency, but NO bearer (there is no session yet). Without this, App Check
  /// never reaches the server on the auth calls it most needs to protect — the
  /// gateway verifies `x-firebase-appcheck` ahead of JWT auth, in report mode by
  /// default (a missing token is non-fatal until an operator flips to enforce).
  Future<CallOptions> withAppCheck([CallOptions? options]) async {
    final metadata = <String, String>{};

    try {
      final appCheckToken = await AppCheckService.instance
          .getToken()
          .timeout(const Duration(seconds: 3), onTimeout: () => null);
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        metadata['x-firebase-appcheck'] = appCheckToken;
      }
    } catch (_) {
      // Non-fatal: proceed without the attestation header.
    }

    if (localeManager != null) {
      metadata.addAll(localeManager!.getLocaleMetadata());
      final country = localeManager!.currentCountry;
      if (country.isNotEmpty) metadata['x-user-country'] = country;
      final currency = localeManager!.currentCurrency;
      if (currency.isNotEmpty) metadata['x-currency'] = currency;
    }

    if (options != null && options.metadata.isNotEmpty) {
      metadata.addAll(options.metadata);
    }

    // DEADLINE. Two bugs lived here.
    //
    // 1. A caller-supplied timeout was DISCARDED: only options.metadata was
    //    copied, so `withAuth(CallOptions(timeout: ...))` silently produced a
    //    deadline-less call. Callers believed they had a bound and did not.
    // 2. There was no default either, so an RPC whose response was lost (dead
    //    connection, gateway dropping the stream mid-call) never completed and
    //    never threw. The Future simply hung.
    //
    // That is not theoretical: a gift card purchase completed server-side —
    // provider charged, code issued — while the app sat on "Generating"
    // forever, because buyGiftCard was issued through this method with no
    // deadline and the response never arrived. Nothing downstream can recover
    // from a Future that neither resolves nor throws.
    //
    // The fallback default is deliberately GENEROUS. It is not a latency
    // budget — individual calls that want a tight bound pass their own, and
    // the slowest legitimate unary call here (a buy saga driving a provider)
    // runs into the tens of seconds. It exists so that "forever" is never a
    // possible outcome.
    return CallOptions(
      metadata: metadata,
      timeout: options?.timeout ?? _defaultCallDeadline,
    );
  }

  /// Backstop deadline for any RPC that does not specify one. Long enough that
  /// it can only be hit by a call that is genuinely never coming back.
  static const Duration _defaultCallDeadline = Duration(seconds: 120);

  /// Backward compatibility: withAuthAndLocale is now the same as withAuth
  @Deprecated('Use withAuth() instead - it now includes locale automatically')
  Future<CallOptions> withAuthAndLocale([CallOptions? options]) async {
    return withAuth(options);
  }

  /// Execute a gRPC call with automatic token rotation on auth failures
  ///
  /// This method wraps gRPC calls and automatically:
  /// - Refreshes tokens if they expire (401/403 errors)
  /// - Retries the request with new tokens
  /// - Saves refreshed tokens to storage
  ///
  /// Usage:
  /// ```dart
  /// final response = await grpcHelper.executeWithTokenRotation(() async {
  ///   return await serviceClient.someMethod(request, options: callOptions);
  /// });
  /// ```
  Future<T> executeWithTokenRotation<T>(
    Future<T> Function() call, {
    int maxRetries = 1,
  }) async {
    try {
      return await call();
    } on GrpcError catch (e) {
      // Check if it's a JWT authentication error (expired/invalid token)
      // Note: Only retry on unauthenticated — permissionDenied may come from
      // PIN token validation (single-use tokens) and retrying would fail.
      if (e.code == StatusCode.unauthenticated && maxRetries > 0) {
        print('Authentication error detected (${e.code}). Attempting token refresh...');
        AppLogger.event('token_rotation', 'unauthenticated_retry',
            level: 'warn', fields: {'code': e.code});

        // Try to refresh the token
        final refreshed = await _attemptTokenRefresh();

        if (refreshed) {
          print('Token refreshed successfully. Retrying request...');
          AppLogger.event('token_rotation', 'refresh_ok');
          // Retry the call with the new token
          return await executeWithTokenRotation(call, maxRetries: maxRetries - 1);
        } else {
          print('Token refresh failed. Request cannot be retried.');
          AppLogger.event('token_rotation', 'refresh_failed', level: 'error');
          rethrow;
        }
      }

      // If not an auth error or retries exhausted, rethrow
      rethrow;
    }
  }

  /// Attempt to refresh the access token using the refresh token
  ///
  /// This method handles concurrent refresh attempts properly:
  /// - If a refresh is already in progress, wait for it to complete
  /// - Returns true if refresh succeeded, false otherwise
  /// - Multiple simultaneous calls will wait for the same refresh operation
  Future<bool> _attemptTokenRefresh() async {
    // If a refresh is already in progress, wait for it to complete
    if (_isRefreshing && _refreshCompleter != null) {
      print('Token refresh already in progress, waiting for completion...');
      try {
        return await _refreshCompleter!.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            print('Waiting for token refresh timed out');
            return false;
          },
        );
      } catch (e) {
        print('Error waiting for token refresh: $e');
        return false;
      }
    }

    // Start a new refresh operation
    _refreshCompleter = Completer<bool>();
    _isRefreshing = true;

    try {
      print('Starting token refresh...');

      // Get refresh token from storage
      final refreshToken = await storage.read(key: _refreshTokenKey);
      if (refreshToken == null || refreshToken.isEmpty) {
        print('No refresh token available');
        _refreshCompleter!.complete(false);
        return false;
      }

      print('Calling token refresh callback...');

      // Use the callback to refresh tokens (provided by auth repository/cubit)
      if (onTokenRefreshNeeded != null) {
        final newTokens = await onTokenRefreshNeeded!();

        if (newTokens != null &&
            newTokens['accessToken'] != null &&
            newTokens['refreshToken'] != null) {
          // Save new tokens to storage
          await storage.write(key: _accessTokenKey, value: newTokens['accessToken']!);
          await storage.write(key: _refreshTokenKey, value: newTokens['refreshToken']!);

          print('New tokens saved to storage');
          _refreshCompleter!.complete(true);
          return true;
        }
      }

      print('Token refresh callback not available or returned null');
      _refreshCompleter!.complete(false);
      return false;

    } catch (e) {
      print('Error during token refresh: $e');
      _refreshCompleter!.completeError(e);
      return false;
    } finally {
      _isRefreshing = false;
      // Don't null out _refreshCompleter immediately - let waiting calls complete
      Future.delayed(const Duration(seconds: 1), () {
        _refreshCompleter = null;
      });
    }
  }

  /// Manually refresh tokens (can be called by app logic)
  Future<bool> refreshTokens() async {
    return await _attemptTokenRefresh();
  }
}
