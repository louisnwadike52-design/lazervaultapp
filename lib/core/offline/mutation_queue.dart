import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'mutation.dart';

/// Configuration for the mutation queue.
class MutationQueueConfig {
  /// Maximum number of mutations in the queue.
  final int maxQueueSize;

  /// Maximum age for a mutation before it's considered expired.
  final Duration maxMutationAge;

  /// Debounce duration for connectivity changes.
  final Duration connectivityDebounce;

  /// Timeout for processing a single mutation.
  final Duration mutationTimeout;

  /// Whether to auto-process when connectivity is restored.
  final bool autoProcessOnConnectivity;

  const MutationQueueConfig({
    this.maxQueueSize = 50,
    this.maxMutationAge = const Duration(hours: 24),
    this.connectivityDebounce = const Duration(seconds: 2),
    this.mutationTimeout = const Duration(seconds: 60),
    this.autoProcessOnConnectivity = true,
  });

  static const defaultConfig = MutationQueueConfig();
}

/// Statistics for mutation queue monitoring.
class MutationQueueStatistics {
  int totalEnqueued = 0;
  int totalProcessed = 0;
  int totalFailed = 0;
  int totalCancelled = 0;
  int totalExpired = 0;
  int duplicatesPrevented = 0;
  int recoveredOnRestart = 0;

  void reset() {
    totalEnqueued = totalProcessed = totalFailed = totalCancelled = 0;
    totalExpired = duplicatesPrevented = recoveredOnRestart = 0;
  }

  Map<String, dynamic> toJson() => {
        'totalEnqueued': totalEnqueued,
        'totalProcessed': totalProcessed,
        'totalFailed': totalFailed,
        'totalCancelled': totalCancelled,
        'totalExpired': totalExpired,
        'duplicatesPrevented': duplicatesPrevented,
        'recoveredOnRestart': recoveredOnRestart,
      };
}

/// Manages a queue of offline mutations for automatic retry.
///
/// When network requests fail due to connectivity issues, mutations
/// are queued and automatically retried when connectivity is restored.
///
/// Edge cases handled:
/// - App killed mid-processing: Recovers on restart via persistent storage
/// - Duplicate mutations: SHA256-based deduplication
/// - Token expiry: Token refresh callback before processing
/// - Queue overflow: Rejects new mutations when full
/// - Network flapping: Debounced connectivity handling
/// - Mutation timeout: Per-mutation timeout with proper cleanup
/// - Expired mutations: Auto-cleanup of old mutations
class MutationQueue {
  /// Secure storage for persisting the queue.
  final FlutterSecureStorage _storage;

  /// Connectivity monitoring.
  final Connectivity _connectivity;

  /// Configuration.
  final MutationQueueConfig config;

  /// In-memory queue.
  final List<QueuedMutation> _queue = [];

  /// Deduplication set (content hashes of pending mutations).
  final Set<String> _contentHashes = {};

  /// Storage key for the queue.
  static const String _storageKey = 'mutation_queue_v2';

  /// Whether the queue is currently processing.
  bool _isProcessing = false;

  /// Whether initialization has completed.
  bool _initialized = false;

  /// Subscription to connectivity changes.
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Debounce timer for connectivity changes.
  Timer? _connectivityDebounceTimer;

  /// Stream controller for queue updates.
  final _queueController = StreamController<List<QueuedMutation>>.broadcast();

  /// Stream controller for status updates (for UI notifications).
  final _statusController = StreamController<MutationStatusEvent>.broadcast();

  /// Statistics for monitoring.
  final MutationQueueStatistics statistics = MutationQueueStatistics();

  /// Stream of queue updates for UI binding.
  Stream<List<QueuedMutation>> get queueStream => _queueController.stream;

  /// Stream of status events for notifications.
  Stream<MutationStatusEvent> get statusStream => _statusController.stream;

  /// Current queue state.
  List<QueuedMutation> get queue => List.unmodifiable(_queue);

  /// Number of pending mutations.
  int get pendingCount =>
      _queue.where((m) => m.status == MutationStatus.pending).length;

  /// Whether there are pending mutations.
  bool get hasPending => pendingCount > 0;

  /// Whether the queue is full.
  bool get isFull => _queue.length >= config.maxQueueSize;

  /// Whether processing is in progress.
  bool get isProcessing => _isProcessing;

  /// Callback for processing mutations (set by MutationExecutor).
  Future<void> Function(QueuedMutation mutation)? onProcess;

  /// Callback for token refresh before processing (returns refreshed token or null).
  Future<String?> Function()? onTokenRefresh;

  /// Callback for mutation status changes (for UI updates).
  void Function(QueuedMutation mutation)? onStatusChange;

  MutationQueue({
    FlutterSecureStorage? storage,
    Connectivity? connectivity,
    MutationQueueConfig? config,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _connectivity = connectivity ?? Connectivity(),
        config = config ?? MutationQueueConfig.defaultConfig;

  /// Initializes the queue by loading from storage and setting up connectivity monitoring.
  ///
  /// Handles recovery from app kill mid-processing by:
  /// 1. Loading persisted queue
  /// 2. Resetting any "processing" mutations back to "pending"
  /// 3. Cleaning up expired mutations
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await _loadFromStorage();
      _recoverFromCrash();
      await _cleanupExpired();

      // Monitor connectivity changes
      if (config.autoProcessOnConnectivity) {
        _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
          _onConnectivityChanged,
        );
      }

      // Check initial connectivity
      final results = await _connectivity.checkConnectivity();
      if (_hasConnectivity(results) && hasPending) {
        _processQueue();
      }

      _initialized = true;
      _emit('[MutationQueue] Initialized with ${_queue.length} mutations');
    } catch (e) {
      _emit('[MutationQueue] Initialization error: $e');
      _initialized = true; // Continue in degraded mode
    }
  }

  /// Disposes of resources.
  Future<void> dispose() async {
    _connectivityDebounceTimer?.cancel();
    await _connectivitySubscription?.cancel();
    await _queueController.close();
    await _statusController.close();
  }

  /// Recovers mutations that were processing when app was killed.
  void _recoverFromCrash() {
    var recoveredCount = 0;
    for (var i = 0; i < _queue.length; i++) {
      final mutation = _queue[i];
      if (mutation.status == MutationStatus.processing) {
        // Reset to pending so it will be retried
        _queue[i] = mutation.copyWith(
          status: MutationStatus.pending,
          lastError: 'Recovered after app restart',
        );
        recoveredCount++;
      }
    }
    if (recoveredCount > 0) {
      statistics.recoveredOnRestart += recoveredCount;
      _emit('[MutationQueue] Recovered $recoveredCount mutations from crash');
      _saveToStorage();
    }
  }

  /// Cleans up mutations that are too old.
  Future<void> _cleanupExpired() async {
    final now = DateTime.now();
    var expiredCount = 0;

    _queue.removeWhere((m) {
      final isExpired = now.difference(m.createdAt) > config.maxMutationAge;
      if (isExpired &&
          (m.status == MutationStatus.pending ||
              m.status == MutationStatus.failed)) {
        _contentHashes.remove(_computeContentHash(m));
        expiredCount++;
        return true;
      }
      return false;
    });

    if (expiredCount > 0) {
      statistics.totalExpired += expiredCount;
      await _saveToStorage();
      _notifyQueueUpdate();
      _emit('[MutationQueue] Cleaned up $expiredCount expired mutations');
    }
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    // Debounce rapid connectivity changes (network flapping)
    _connectivityDebounceTimer?.cancel();
    _connectivityDebounceTimer = Timer(config.connectivityDebounce, () {
      if (_hasConnectivity(results) && hasPending && !_isProcessing) {
        _emit('[MutationQueue] Connectivity restored, processing queue...');
        _processQueue();
      }
    });
  }

  bool _hasConnectivity(List<ConnectivityResult> results) {
    return results.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet);
  }

  /// Computes content hash for deduplication.
  String _computeContentHash(QueuedMutation mutation) {
    final content = '${mutation.type.name}:${jsonEncode(mutation.payload)}';
    return sha256.convert(utf8.encode(content)).toString().substring(0, 16);
  }

  /// Checks if a mutation is a duplicate.
  bool _isDuplicate(QueuedMutation mutation) {
    final hash = _computeContentHash(mutation);
    return _contentHashes.contains(hash);
  }

  /// Enqueues a mutation for later processing.
  ///
  /// Returns the mutation if enqueued, null if rejected (duplicate or full).
  Future<QueuedMutation?> enqueue(QueuedMutation mutation) async {
    // Check for duplicates
    if (_isDuplicate(mutation)) {
      statistics.duplicatesPrevented++;
      _emit('[MutationQueue] Duplicate rejected: ${mutation.type.name}');
      _emitStatus(MutationStatusEvent(
        mutation: mutation,
        type: MutationEventType.duplicateRejected,
        message: 'This operation is already queued',
      ));
      return null;
    }

    // Check queue capacity
    if (isFull) {
      _emit('[MutationQueue] Queue full, rejecting: ${mutation.type.name}');
      _emitStatus(MutationStatusEvent(
        mutation: mutation,
        type: MutationEventType.queueFull,
        message: 'Queue is full. Please try again later.',
      ));
      return null;
    }

    // Add to queue and dedup set
    _queue.add(mutation);
    _contentHashes.add(_computeContentHash(mutation));
    statistics.totalEnqueued++;

    await _saveToStorage();
    _notifyQueueUpdate();

    _emit('[MutationQueue] Enqueued: ${mutation.type.name} (${mutation.id})');
    _emitStatus(MutationStatusEvent(
      mutation: mutation,
      type: MutationEventType.enqueued,
      message: mutation.description ?? 'Operation queued for retry',
    ));

    // Try to process immediately if we have connectivity
    final results = await _connectivity.checkConnectivity();
    if (_hasConnectivity(results)) {
      _processQueue();
    }

    return mutation;
  }

  /// Convenience method to enqueue a TagPay creation (NOT a payment - just an IOU request).
  Future<QueuedMutation?> enqueueTagCreation({
    required String taggedUserTagPay,
    required double amount,
    required String currency,
    String? description,
  }) {
    return enqueue(QueuedMutation.tagCreation(
      taggedUserTagPay: taggedUserTagPay,
      amount: amount,
      currency: currency,
      description: description,
    ));
  }

  /// Convenience method to enqueue a gift card sell submission.
  /// This is safe to queue because sell submissions are non-financial from the
  /// user's perspective — they're submitting card details for review, not paying.
  /// The actual payout happens asynchronously via provider webhook.
  Future<QueuedMutation?> enqueueGiftCardSell({
    required String cardType,
    required String cardNumber,
    required String cardPin,
    required double denomination,
    String? currency,
    List<String>? images,
    String? idempotencyKey,
  }) {
    return enqueue(QueuedMutation.create(
      type: MutationType.generic,
      payload: {
        'operation': 'giftcard_sell',
        'cardType': cardType,
        'cardNumber': cardNumber,
        'cardPin': cardPin,
        'denomination': denomination,
        'currency': currency ?? 'USD',
        'images': images,
        'idempotencyKey': idempotencyKey,
      },
      description: 'Sell $cardType gift card (\$${denomination.toStringAsFixed(0)})',
    ));
  }

  // NOTE: Payment convenience methods (enqueueTagPayment, enqueueInvoicePayment,
  // enqueueGroupContribution) have been intentionally removed. Financial payments
  // should NEVER be queued offline due to stale balance risk, token expiration,
  // and regulatory concerns.

  /// Cancels a pending mutation.
  Future<bool> cancel(String mutationId) async {
    final index = _queue.indexWhere((m) => m.id == mutationId);
    if (index == -1) return false;

    final mutation = _queue[index];
    if (mutation.status != MutationStatus.pending) return false;

    _queue[index] = mutation.copyWith(status: MutationStatus.cancelled);
    _contentHashes.remove(_computeContentHash(mutation));
    statistics.totalCancelled++;

    await _saveToStorage();
    _notifyQueueUpdate();
    onStatusChange?.call(_queue[index]);

    _emit('[MutationQueue] Cancelled: ${mutation.id}');
    _emitStatus(MutationStatusEvent(
      mutation: _queue[index],
      type: MutationEventType.cancelled,
      message: 'Operation cancelled',
    ));

    return true;
  }

  /// Removes a mutation from the queue.
  Future<bool> remove(String mutationId) async {
    final index = _queue.indexWhere((m) => m.id == mutationId);
    if (index == -1) return false;

    final mutation = _queue[index];
    _contentHashes.remove(_computeContentHash(mutation));
    _queue.removeAt(index);

    await _saveToStorage();
    _notifyQueueUpdate();
    return true;
  }

  /// Cleans up completed/cancelled/failed mutations older than the specified duration.
  Future<void> cleanup({Duration olderThan = const Duration(hours: 24)}) async {
    final cutoff = DateTime.now().subtract(olderThan);
    _queue.removeWhere((m) {
      final shouldRemove = (m.status == MutationStatus.completed ||
              m.status == MutationStatus.cancelled ||
              m.status == MutationStatus.failed) &&
          m.createdAt.isBefore(cutoff);
      if (shouldRemove) {
        _contentHashes.remove(_computeContentHash(m));
      }
      return shouldRemove;
    });
    await _saveToStorage();
    _notifyQueueUpdate();
  }

  /// Retries a failed mutation.
  Future<bool> retry(String mutationId) async {
    final index = _queue.indexWhere((m) => m.id == mutationId);
    if (index == -1) return false;

    final mutation = _queue[index];
    if (mutation.status != MutationStatus.failed) return false;

    _queue[index] = mutation.copyWith(
      status: MutationStatus.pending,
      retryCount: 0,
      lastError: null,
    );
    await _saveToStorage();
    _notifyQueueUpdate();

    _emitStatus(MutationStatusEvent(
      mutation: _queue[index],
      type: MutationEventType.retrying,
      message: 'Retrying operation...',
    ));

    // Try to process
    final results = await _connectivity.checkConnectivity();
    if (_hasConnectivity(results)) {
      _processQueue();
    }

    return true;
  }

  /// Manually triggers queue processing.
  Future<void> processNow() async {
    final results = await _connectivity.checkConnectivity();
    if (_hasConnectivity(results)) {
      await _processQueue();
    } else {
      _emit('[MutationQueue] No connectivity, cannot process');
    }
  }

  /// Processes pending mutations in the queue.
  Future<void> _processQueue() async {
    if (_isProcessing || onProcess == null) return;

    _isProcessing = true;
    _emit('[MutationQueue] Processing queue ($pendingCount pending)...');

    try {
      // Refresh token before processing if callback is set
      if (onTokenRefresh != null) {
        try {
          final newToken = await onTokenRefresh!();
          if (newToken == null) {
            _emit('[MutationQueue] Token refresh failed, aborting');
            return;
          }
        } catch (e) {
          _emit('[MutationQueue] Token refresh error: $e');
          return;
        }
      }

      for (var i = 0; i < _queue.length; i++) {
        // Re-check connectivity before each mutation
        final results = await _connectivity.checkConnectivity();
        if (!_hasConnectivity(results)) {
          _emit('[MutationQueue] Lost connectivity, pausing processing');
          break;
        }

        final mutation = _queue[i];
        if (mutation.status != MutationStatus.pending) continue;

        // Check if mutation is expired
        if (DateTime.now().difference(mutation.createdAt) >
            config.maxMutationAge) {
          _queue[i] = mutation.copyWith(
            status: MutationStatus.failed,
            lastError: 'Mutation expired',
          );
          _contentHashes.remove(_computeContentHash(mutation));
          statistics.totalExpired++;
          await _saveToStorage();
          continue;
        }

        // Update status to processing
        _queue[i] = mutation.copyWith(
          status: MutationStatus.processing,
          lastAttemptAt: DateTime.now(),
        );
        await _saveToStorage();
        _notifyQueueUpdate();
        onStatusChange?.call(_queue[i]);

        _emitStatus(MutationStatusEvent(
          mutation: _queue[i],
          type: MutationEventType.processing,
          message: 'Processing ${mutation.description ?? "operation"}...',
        ));

        try {
          // Execute the mutation with timeout
          await onProcess!(_queue[i]).timeout(
            config.mutationTimeout,
            onTimeout: () {
              throw TimeoutException(
                  'Mutation timed out after ${config.mutationTimeout.inSeconds}s');
            },
          );

          // Mark as completed
          _queue[i] = _queue[i].copyWith(status: MutationStatus.completed);
          _contentHashes.remove(_computeContentHash(mutation));
          statistics.totalProcessed++;

          await _saveToStorage();
          _notifyQueueUpdate();
          onStatusChange?.call(_queue[i]);

          _emit('[MutationQueue] Completed: ${mutation.id}');
          _emitStatus(MutationStatusEvent(
            mutation: _queue[i],
            type: MutationEventType.completed,
            message: mutation.description ?? 'Operation completed',
          ));
        } catch (e) {
          _emit('[MutationQueue] Failed: ${mutation.id} - $e');

          // Determine if error is retryable
          final isRetryable = _isRetryableError(e);

          // Update retry count and status
          final newRetryCount = _queue[i].retryCount + 1;
          final shouldFail =
              newRetryCount >= QueuedMutation.maxRetries || !isRetryable;

          final updatedMutation = _queue[i].copyWith(
            retryCount: newRetryCount,
            lastError: e.toString(),
            status: shouldFail ? MutationStatus.failed : MutationStatus.pending,
          );

          _queue[i] = updatedMutation;

          if (shouldFail) {
            _contentHashes.remove(_computeContentHash(mutation));
            statistics.totalFailed++;

            _emitStatus(MutationStatusEvent(
              mutation: _queue[i],
              type: MutationEventType.failed,
              message: _getUserFriendlyError(e),
            ));
          }

          await _saveToStorage();
          _notifyQueueUpdate();
          onStatusChange?.call(_queue[i]);

          // If we should retry, wait before next attempt
          if (!shouldFail && isRetryable) {
            final delay = _calculateBackoffDelay(newRetryCount);
            _emit('[MutationQueue] Retrying in ${delay.inSeconds}s...');
            await Future.delayed(delay);
          }
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  /// Determines if an error is retryable.
  bool _isRetryableError(Object error) {
    final errorStr = error.toString().toLowerCase();

    // Network/connectivity errors are retryable
    if (errorStr.contains('unavailable') ||
        errorStr.contains('deadline') ||
        errorStr.contains('timeout') ||
        errorStr.contains('network') ||
        errorStr.contains('connection')) {
      return true;
    }

    // Server errors (5xx) are retryable
    if (errorStr.contains('internal') || errorStr.contains('503')) {
      return true;
    }

    // Client errors (4xx) are NOT retryable
    if (errorStr.contains('invalid') ||
        errorStr.contains('unauthorized') ||
        errorStr.contains('forbidden') ||
        errorStr.contains('not found') ||
        errorStr.contains('insufficient')) {
      return false;
    }

    // Default to retryable for unknown errors
    return true;
  }

  /// Gets user-friendly error message.
  String _getUserFriendlyError(Object error) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('insufficient')) {
      return 'Insufficient funds to complete this operation';
    }
    if (errorStr.contains('unauthorized') || errorStr.contains('token')) {
      return 'Session expired. Please log in again.';
    }
    if (errorStr.contains('invalid pin')) {
      return 'Invalid transaction PIN';
    }
    if (errorStr.contains('timeout')) {
      return 'Operation timed out. Please try again.';
    }
    if (errorStr.contains('network') || errorStr.contains('connection')) {
      return 'Network error. Will retry automatically.';
    }

    return 'Operation failed. Please try again.';
  }

  /// Calculates exponential backoff delay with jitter.
  Duration _calculateBackoffDelay(int retryCount) {
    // Base delay: 2 seconds
    // Max delay: 30 seconds
    final baseMs = QueuedMutation.retryBaseDelay.inMilliseconds;
    final exponentialMs = baseMs * pow(2, retryCount - 1);
    final cappedMs = min(exponentialMs.toInt(), 30000);

    // Add jitter (±20%)
    final jitter = (Random().nextDouble() * 0.4 - 0.2) * cappedMs;
    return Duration(milliseconds: cappedMs + jitter.toInt());
  }

  /// Loads the queue from persistent storage.
  Future<void> _loadFromStorage() async {
    try {
      final data = await _storage.read(key: _storageKey);
      if (data != null) {
        final list = jsonDecode(data) as List;
        _queue.clear();
        _contentHashes.clear();

        for (final json in list) {
          try {
            final mutation =
                QueuedMutation.fromJson(json as Map<String, dynamic>);
            _queue.add(mutation);
            if (mutation.status == MutationStatus.pending ||
                mutation.status == MutationStatus.processing) {
              _contentHashes.add(_computeContentHash(mutation));
            }
          } catch (e) {
            _emit('[MutationQueue] Error parsing mutation: $e');
          }
        }

        _emit('[MutationQueue] Loaded ${_queue.length} mutations from storage');
        _notifyQueueUpdate();
      }
    } catch (e) {
      _emit('[MutationQueue] Error loading from storage: $e');
    }
  }

  /// Saves the queue to persistent storage.
  Future<void> _saveToStorage() async {
    try {
      final data = jsonEncode(_queue.map((m) => m.toJson()).toList());
      await _storage.write(key: _storageKey, value: data);
    } catch (e) {
      _emit('[MutationQueue] Error saving to storage: $e');
    }
  }

  void _notifyQueueUpdate() {
    if (!_queueController.isClosed) {
      _queueController.add(List.unmodifiable(_queue));
    }
  }

  void _emitStatus(MutationStatusEvent event) {
    if (!_statusController.isClosed) {
      _statusController.add(event);
    }
  }

  void _emit(String message) {
    if (kDebugMode) {
      print(message);
    }
  }

  /// Gets mutation queue statistics.
  MutationQueueStatistics getStatistics() => statistics;
}

/// Event types for mutation status updates.
enum MutationEventType {
  enqueued,
  processing,
  completed,
  failed,
  cancelled,
  retrying,
  duplicateRejected,
  queueFull,
}

/// Event for mutation status updates (for UI notifications).
class MutationStatusEvent {
  final QueuedMutation mutation;
  final MutationEventType type;
  final String message;
  final DateTime timestamp;

  MutationStatusEvent({
    required this.mutation,
    required this.type,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Whether this is a success event.
  bool get isSuccess => type == MutationEventType.completed;

  /// Whether this is a failure event.
  bool get isFailure =>
      type == MutationEventType.failed ||
      type == MutationEventType.queueFull ||
      type == MutationEventType.duplicateRejected;

  /// Whether this event should show a notification to the user.
  bool get shouldNotify =>
      type != MutationEventType.processing &&
      type != MutationEventType.enqueued;
}
