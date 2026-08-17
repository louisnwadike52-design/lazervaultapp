part of 'swr_cache_manager.dart';

/// Error types for cache operations.
enum CacheErrorType {
  /// Storage is full, cannot write new entries.
  storageFull,

  /// Cache entry is corrupted and cannot be read.
  corruption,

  /// Serialization failed.
  serializationError,

  /// Deserialization failed.
  deserializationError,

  /// Network fetch failed.
  fetchError,

  /// Storage operation failed.
  storageError,

  /// Unknown error.
  unknown,
}

/// Wrapper for cache errors with type classification.
class CacheError implements Exception {
  final CacheErrorType type;
  final String message;
  final Object? originalError;
  final String? key;

  const CacheError({
    required this.type,
    required this.message,
    this.originalError,
    this.key,
  });

  /// Whether this error is recoverable (can retry).
  bool get isRecoverable =>
      type == CacheErrorType.fetchError || type == CacheErrorType.storageFull;

  /// User-friendly message suitable for display in the UI.
  /// Use this (or getUserFriendlyErrorMessage) instead of toString().
  String get userMessage {
    switch (type) {
      case CacheErrorType.fetchError:
        return "Couldn't load the latest data. Pull down to refresh.";
      case CacheErrorType.storageFull:
        return 'Your device storage is full. Please free up some space.';
      case CacheErrorType.corruption:
      case CacheErrorType.serializationError:
      case CacheErrorType.deserializationError:
        return 'Something went wrong loading saved data. Please try refreshing.';
      case CacheErrorType.storageError:
        return "Couldn't save data to your device. Please try again.";
      case CacheErrorType.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => 'CacheError($type): $message';
}

/// Statistics for cache operations.
class CacheStatistics {
  int hits = 0;
  int misses = 0;
  int staleHits = 0;
  int networkFetches = 0;
  int errors = 0;
  int evictions = 0;
  int corruptionRepairs = 0;

  double get hitRate => (hits + staleHits) / (hits + staleHits + misses).clamp(1, double.infinity);

  void reset() {
    hits = misses = staleHits = networkFetches = errors = evictions = corruptionRepairs = 0;
  }

  Map<String, dynamic> toJson() => {
        'hits': hits,
        'misses': misses,
        'staleHits': staleHits,
        'networkFetches': networkFetches,
        'errors': errors,
        'evictions': evictions,
        'corruptionRepairs': corruptionRepairs,
        'hitRate': hitRate,
      };
}
