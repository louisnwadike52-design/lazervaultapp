/// Resilient HTTP client with retry logic, exponential backoff, and circuit breaker
library;

import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../errors/banking_errors.dart';

/// Configuration for retry behavior
class RetryConfig {
  final int maxRetries;
  final Duration baseDelay;
  final Duration maxDelay;
  final double backoffMultiplier;
  final bool retryOnTimeout;
  final bool retryOnNetworkError;
  final bool retryOnServerError;

  const RetryConfig({
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.retryOnTimeout = true,
    this.retryOnNetworkError = true,
    this.retryOnServerError = true,
  });

  static const RetryConfig none = RetryConfig(maxRetries: 0);

  static const RetryConfig aggressive = RetryConfig(
    maxRetries: 5,
    baseDelay: Duration(milliseconds: 250),
    maxDelay: Duration(seconds: 60),
    backoffMultiplier: 2.0,
  );
}

/// Circuit breaker state
enum CircuitState { closed, open, halfOpen }

/// Circuit breaker for failing services
class CircuitBreaker {
  final int failureThreshold;
  final Duration resetTimeout;

  CircuitState _state = CircuitState.closed;
  int _failureCount = 0;
  DateTime? _lastFailureTime;

  CircuitBreaker({
    this.failureThreshold = 3,
    this.resetTimeout = const Duration(seconds: 30),
  });

  CircuitState get state => _state;
  bool get isOpen => _state == CircuitState.open;
  bool get isClosed => _state == CircuitState.closed;

  /// Check if request should be allowed
  bool allowRequest() {
    switch (_state) {
      case CircuitState.closed:
        return true;

      case CircuitState.open:
        // Check if we should transition to half-open
        if (_lastFailureTime != null &&
            DateTime.now().difference(_lastFailureTime!) > resetTimeout) {
          _state = CircuitState.halfOpen;
          return true;
        }
        return false;

      case CircuitState.halfOpen:
        return true;
    }
  }

  /// Record a successful request
  void recordSuccess() {
    _failureCount = 0;
    _state = CircuitState.closed;
  }

  /// Record a failed request
  void recordFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();

    if (_failureCount >= failureThreshold) {
      _state = CircuitState.open;
    }
  }

  /// Reset the circuit breaker
  void reset() {
    _state = CircuitState.closed;
    _failureCount = 0;
    _lastFailureTime = null;
  }
}

/// Callback for request events
typedef RequestEventCallback = void Function(RequestEvent event);

/// Request event types for monitoring
sealed class RequestEvent {}

class RequestStarted extends RequestEvent {
  final String url;
  final String method;
  RequestStarted(this.url, this.method);
}

class RequestRetrying extends RequestEvent {
  final String url;
  final int attempt;
  final int maxAttempts;
  final Duration delay;
  final String reason;
  RequestRetrying(this.url, this.attempt, this.maxAttempts, this.delay, this.reason);
}

class RequestSucceeded extends RequestEvent {
  final String url;
  final int statusCode;
  final Duration duration;
  RequestSucceeded(this.url, this.statusCode, this.duration);
}

class RequestFailed extends RequestEvent {
  final String url;
  final BankingException error;
  final int attempts;
  RequestFailed(this.url, this.error, this.attempts);
}

class CircuitBreakerOpened extends RequestEvent {
  final String reason;
  CircuitBreakerOpened(this.reason);
}

/// Resilient HTTP client with retry logic and circuit breaker
class ResilientBankingClient {
  final http.Client _client;
  final RetryConfig _defaultRetryConfig;
  final CircuitBreaker _circuitBreaker;
  final Duration _timeout;
  final RequestEventCallback? _onEvent;
  final Random _random = Random();

  ResilientBankingClient({
    http.Client? client,
    RetryConfig retryConfig = const RetryConfig(),
    CircuitBreaker? circuitBreaker,
    Duration timeout = const Duration(seconds: 30),
    RequestEventCallback? onEvent,
  })  : _client = client ?? http.Client(),
        _defaultRetryConfig = retryConfig,
        _circuitBreaker = circuitBreaker ?? CircuitBreaker(),
        _timeout = timeout,
        _onEvent = onEvent;

  /// Check if device has internet connectivity
  Future<bool> hasConnectivity() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } catch (_) {
      return true; // Assume connected if we can't check
    }
  }

  /// Make a GET request with retry logic
  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
    RetryConfig? retryConfig,
  }) async {
    return _executeWithRetry(
      () => _client.get(url, headers: headers).timeout(_timeout),
      url.toString(),
      'GET',
      retryConfig ?? _defaultRetryConfig,
    );
  }

  /// Make a POST request with retry logic
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    RetryConfig? retryConfig,
  }) async {
    return _executeWithRetry(
      () => _client
          .post(url, headers: headers, body: body)
          .timeout(_timeout),
      url.toString(),
      'POST',
      retryConfig ?? _defaultRetryConfig,
    );
  }

  /// Make a PUT request with retry logic
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    RetryConfig? retryConfig,
  }) async {
    return _executeWithRetry(
      () => _client
          .put(url, headers: headers, body: body)
          .timeout(_timeout),
      url.toString(),
      'PUT',
      retryConfig ?? _defaultRetryConfig,
    );
  }

  /// Make a DELETE request with retry logic
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    RetryConfig? retryConfig,
  }) async {
    return _executeWithRetry(
      () => _client.delete(url, headers: headers).timeout(_timeout),
      url.toString(),
      'DELETE',
      retryConfig ?? _defaultRetryConfig,
    );
  }

  /// Execute request with retry logic
  Future<http.Response> _executeWithRetry(
    Future<http.Response> Function() request,
    String url,
    String method,
    RetryConfig config,
  ) async {
    // Check circuit breaker
    if (!_circuitBreaker.allowRequest()) {
      _onEvent?.call(CircuitBreakerOpened('Service is temporarily unavailable'));
      throw const ServiceUnavailableException(
        message: 'Service circuit breaker is open',
      );
    }

    // Check connectivity before making request
    if (!await hasConnectivity()) {
      throw const NetworkException(
        message: 'No internet connection',
        isTimeout: false,
      );
    }

    _onEvent?.call(RequestStarted(url, method));
    final startTime = DateTime.now();

    int attempts = 0;
    BankingException? lastError;

    while (attempts <= config.maxRetries) {
      try {
        final response = await request();

        // Check if response is successful
        if (response.statusCode >= 200 && response.statusCode < 300) {
          _circuitBreaker.recordSuccess();
          _onEvent?.call(RequestSucceeded(
            url,
            response.statusCode,
            DateTime.now().difference(startTime),
          ));
          return response;
        }

        // Parse error response
        final error = BankingErrorParser.parseResponse(
          response.statusCode,
          response.body,
        );

        // Check if we should retry
        if (_shouldRetry(error, attempts, config)) {
          lastError = error;
          attempts++;
          final delay = _calculateDelay(attempts, config);
          _onEvent?.call(RequestRetrying(
            url,
            attempts,
            config.maxRetries + 1,
            delay,
            'HTTP ${response.statusCode}',
          ));
          await Future.delayed(delay);
          continue;
        }

        // Non-retryable error
        _circuitBreaker.recordFailure();
        _onEvent?.call(RequestFailed(url, error, attempts + 1));
        throw error;
      } on BankingException {
        rethrow;
      } catch (e) {
        // Handle platform exceptions (network errors, timeouts)
        final error = BankingErrorParser.parsePlatformException(e);

        if (_shouldRetry(error, attempts, config)) {
          lastError = error;
          attempts++;
          final delay = _calculateDelay(attempts, config);
          _onEvent?.call(RequestRetrying(
            url,
            attempts,
            config.maxRetries + 1,
            delay,
            e.runtimeType.toString(),
          ));
          await Future.delayed(delay);
          continue;
        }

        _circuitBreaker.recordFailure();
        _onEvent?.call(RequestFailed(url, error, attempts + 1));
        throw error;
      }
    }

    // All retries exhausted
    _circuitBreaker.recordFailure();
    final finalError = lastError ??
        const GenericBankingException(
          message: 'Request failed after all retries',
          isRetryable: false,
        );
    _onEvent?.call(RequestFailed(url, finalError, attempts));
    throw finalError;
  }

  /// Determine if we should retry the request
  bool _shouldRetry(BankingException error, int attempts, RetryConfig config) {
    if (attempts >= config.maxRetries) return false;
    if (!error.isRetryable) return false;

    if (error is NetworkException) {
      if (error.isTimeout && !config.retryOnTimeout) return false;
      if (!error.isTimeout && !config.retryOnNetworkError) return false;
      return true;
    }

    if (error is ServiceUnavailableException) {
      return config.retryOnServerError;
    }

    if (error is RateLimitException) {
      return true; // Always retry rate limit with delay
    }

    return error.isRetryable;
  }

  /// Calculate delay with exponential backoff and jitter
  Duration _calculateDelay(int attempt, RetryConfig config) {
    // Exponential backoff
    final exponentialDelay = config.baseDelay.inMilliseconds *
        pow(config.backoffMultiplier, attempt - 1);

    // Add jitter (0-25% of the delay)
    final jitter = _random.nextDouble() * 0.25 * exponentialDelay;

    final totalDelay = (exponentialDelay + jitter).toInt();

    // Cap at max delay
    return Duration(
      milliseconds: min(totalDelay, config.maxDelay.inMilliseconds),
    );
  }

  /// Reset the circuit breaker
  void resetCircuitBreaker() {
    _circuitBreaker.reset();
  }

  /// Get current circuit breaker state
  CircuitState get circuitState => _circuitBreaker.state;

  /// Close the client
  void close() {
    _client.close();
  }
}

/// Extension for easy response handling
extension ResponseExtension on http.Response {
  /// Parse response body as JSON or throw appropriate exception
  Map<String, dynamic> parseJsonOrThrow() {
    if (statusCode >= 200 && statusCode < 300) {
      try {
        return jsonDecode(body) as Map<String, dynamic>;
      } catch (e) {
        throw const GenericBankingException(
          message: 'Invalid response format',
          isRetryable: false,
        );
      }
    }
    throw BankingErrorParser.parseResponse(statusCode, body);
  }
}
