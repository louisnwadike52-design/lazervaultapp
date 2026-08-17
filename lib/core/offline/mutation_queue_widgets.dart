part of 'mutation_queue.dart';

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
