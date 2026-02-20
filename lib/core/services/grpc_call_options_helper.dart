import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';

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
    final accessToken = await storage.read(key: _accessTokenKey);

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
      // Check if it's an authentication error
      if ((e.code == StatusCode.unauthenticated || e.code == StatusCode.permissionDenied) && maxRetries > 0) {
        print('Authentication error detected (${e.code}). Attempting token refresh...');

        // Try to refresh the token
        final refreshed = await _attemptTokenRefresh();

        if (refreshed) {
          print('Token refreshed successfully. Retrying request...');
          // Retry the call with the new token
          return await executeWithTokenRotation(call, maxRetries: maxRetries - 1);
        } else {
          print('Token refresh failed. Request cannot be retried.');
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
