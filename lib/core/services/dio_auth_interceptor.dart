import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';

/// Dio interceptor that injects JWT authorization and user context headers.
///
/// Mirrors the gRPC [GrpcCallOptionsHelper] pattern for HTTP requests.
/// On 401 responses, attempts a single token refresh and retries.
class DioAuthInterceptor extends QueuedInterceptor {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;
  final LocaleManager? _localeManager;
  final AccountManager? _accountManager;
  final Dio _dio;

  /// Optional callback to refresh tokens when they expire.
  /// Should return a map with 'accessToken' and 'refreshToken' keys, or null on failure.
  Future<Map<String, String>?> Function()? onTokenRefreshNeeded;

  bool _isRefreshing = false;
  Completer<bool>? _refreshCompleter;

  /// Tracks whether we're already retrying inside onError to prevent infinite loops.
  /// When the retry itself returns 401, we must NOT attempt another refresh.
  bool _isRetrying = false;

  DioAuthInterceptor({
    required FlutterSecureStorage storage,
    required Dio dio,
    LocaleManager? localeManager,
    AccountManager? accountManager,
    this.onTokenRefreshNeeded,
  })  : _storage = storage,
        _dio = dio,
        _localeManager = localeManager,
        _accountManager = accountManager;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Inject authorization header
    try {
      final accessToken = await _storage.read(key: _accessTokenKey);
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (_) {
      // Storage read failed — continue without token rather than crashing
    }

    // Inject locale and user context
    try {
      if (_localeManager != null) {
        final locale = _localeManager!.currentLocale;
        if (locale.isNotEmpty) {
          options.headers['X-Locale'] = locale;
        }
        final country = _localeManager!.currentCountry;
        if (country.isNotEmpty) {
          options.headers['X-User-Country'] = country;
        }
        final currency = _localeManager!.currentCurrency;
        if (currency.isNotEmpty) {
          options.headers['X-Currency'] = currency;
        }
      }

      if (_accountManager != null && _accountManager!.hasActiveAccount) {
        final accountMetadata = _accountManager!.getAccountMetadata();
        if (accountMetadata.containsKey('x-account-id')) {
          options.headers['X-Account-Id'] = accountMetadata['x-account-id'];
        }
      }
    } catch (_) {
      // Non-critical metadata — continue without it
    }

    options.headers['X-Service-Name'] = 'lazervault-flutter';

    // Telemetry: stamp request start so onResponse/onError can measure latency.
    options.extra['_t0'] = DateTime.now().millisecondsSinceEpoch;

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    _recordTelemetry(response.requestOptions, response.statusCode);
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only attempt refresh on 401, and never during a retry (prevents infinite loop)
    if (err.response?.statusCode == 401 && !_isRetrying) {
      final refreshed = await _attemptTokenRefresh();
      if (refreshed) {
        // Retry the original request with new token
        _isRetrying = true;
        try {
          final accessToken = await _storage.read(key: _accessTokenKey);
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $accessToken';

          final response = await _dio.fetch(opts);
          return handler.resolve(response);
        } on DioException catch (retryErr) {
          return handler.reject(retryErr);
        } catch (e) {
          return handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: e,
            type: DioExceptionType.unknown,
          ));
        } finally {
          _isRetrying = false;
        }
      }
    }

    // Telemetry: record the failed request (response status if any, else a
    // network/timeout "error" class).
    _recordTelemetry(err.requestOptions, err.response?.statusCode);

    handler.next(err);
  }

  // Emit an http_request telemetry event with bounded labels. Best-effort.
  void _recordTelemetry(RequestOptions options, int? statusCode) {
    try {
      int? latencyMs;
      final t0 = options.extra['_t0'];
      if (t0 is int) {
        latencyMs = DateTime.now().millisecondsSinceEpoch - t0;
      }
      AnalyticsService.instance.trackHttpRequest(
        endpointGroup: _endpointGroup(options.path),
        statusClass: _statusClass(statusCode),
        latencyMs: latencyMs,
      );
    } catch (_) {
      // Telemetry must never affect the request path.
    }
  }

  // Map a request path to a bounded endpoint group (collector allowlist).
  String _endpointGroup(String path) {
    final p = path.toLowerCase();
    if (p.contains('/transfers/')) {
      if (p.contains('send')) return 'transfers_send';
      if (p.contains('fee')) return 'transfers_fee';
      if (p.contains('recipient')) return 'transfers_recipients';
      return 'other_api';
    }
    if (p.contains('/accounts')) return 'accounts';
    if (p.contains('/auth') || p.contains('/login')) return 'auth';
    if (p.contains('/pin')) return 'pin_verify';
    return 'other_api';
  }

  // Map an HTTP status code to a bounded class. Null code = network/timeout.
  String _statusClass(int? code) {
    if (code == null) return 'error';
    if (code >= 200 && code < 300) return '2xx';
    if (code >= 300 && code < 400) return '3xx';
    if (code >= 400 && code < 500) return '4xx';
    if (code >= 500) return '5xx';
    return 'error';
  }

  Future<bool> _attemptTokenRefresh() async {
    // If a refresh is already in progress, wait for it
    if (_isRefreshing && _refreshCompleter != null) {
      try {
        return await _refreshCompleter!.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => false,
        );
      } catch (_) {
        return false;
      }
    }

    _refreshCompleter = Completer<bool>();
    _isRefreshing = true;

    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null || refreshToken.isEmpty) {
        _refreshCompleter!.complete(false);
        return false;
      }

      if (onTokenRefreshNeeded == null) {
        _refreshCompleter!.complete(false);
        return false;
      }

      try {
        final newTokens = await onTokenRefreshNeeded!();
        if (newTokens != null &&
            newTokens['accessToken'] != null &&
            newTokens['refreshToken'] != null) {
          await _storage.write(key: _accessTokenKey, value: newTokens['accessToken']!);
          await _storage.write(key: _refreshTokenKey, value: newTokens['refreshToken']!);
          _refreshCompleter!.complete(true);
          return true;
        }
      } catch (_) {
        // Callback or storage write failed
      }

      _refreshCompleter!.complete(false);
      return false;
    } catch (e) {
      if (!_refreshCompleter!.isCompleted) {
        _refreshCompleter!.complete(false);
      }
      return false;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
