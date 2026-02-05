import 'dart:convert';

/// Represents a cached data entry with metadata for staleness tracking.
///
/// Each entry tracks:
/// - The cached data (as JSON for persistence)
/// - When it was fetched
/// - The configured stale and cache times
/// - A unique cache key
class CacheEntry<T> {
  /// Unique identifier for this cache entry.
  final String key;

  /// The cached data serialized as JSON.
  final String dataJson;

  /// When the data was fetched from the server.
  final DateTime fetchedAt;

  /// Duration after which data is considered stale.
  final Duration staleTime;

  /// Duration after which data is completely expired.
  final Duration cacheTime;

  const CacheEntry({
    required this.key,
    required this.dataJson,
    required this.fetchedAt,
    required this.staleTime,
    required this.cacheTime,
  });

  /// Whether the cached data is stale and should be revalidated.
  bool get isStale => DateTime.now().difference(fetchedAt) > staleTime;

  /// Whether the cached data is completely expired and should not be used.
  bool get isExpired => DateTime.now().difference(fetchedAt) > cacheTime;

  /// Whether the cached data is fresh and can be used without revalidation.
  bool get isFresh => !isStale;

  /// Age of the cache entry.
  Duration get age => DateTime.now().difference(fetchedAt);

  /// Time remaining until the entry becomes stale.
  Duration get timeUntilStale {
    final remaining = staleTime - age;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// Time remaining until the entry expires.
  Duration get timeUntilExpiry {
    final remaining = cacheTime - age;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// Creates a copy with updated data but same metadata.
  CacheEntry<T> copyWithData(String newDataJson) {
    return CacheEntry<T>(
      key: key,
      dataJson: newDataJson,
      fetchedAt: DateTime.now(),
      staleTime: staleTime,
      cacheTime: cacheTime,
    );
  }

  /// Serializes the entry to JSON for persistence.
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'dataJson': dataJson,
      'fetchedAt': fetchedAt.toIso8601String(),
      'staleTimeMs': staleTime.inMilliseconds,
      'cacheTimeMs': cacheTime.inMilliseconds,
    };
  }

  /// Deserializes an entry from JSON.
  factory CacheEntry.fromJson(Map<String, dynamic> json) {
    return CacheEntry<T>(
      key: json['key'] as String,
      dataJson: json['dataJson'] as String,
      fetchedAt: DateTime.parse(json['fetchedAt'] as String),
      staleTime: Duration(milliseconds: json['staleTimeMs'] as int),
      cacheTime: Duration(milliseconds: json['cacheTimeMs'] as int),
    );
  }

  /// Encodes the entire entry to a single JSON string for storage.
  String encode() => jsonEncode(toJson());

  /// Decodes an entry from a JSON string.
  static CacheEntry<T> decode<T>(String encoded) {
    return CacheEntry<T>.fromJson(jsonDecode(encoded) as Map<String, dynamic>);
  }

  @override
  String toString() =>
      'CacheEntry(key: $key, age: ${age.inSeconds}s, isStale: $isStale, isExpired: $isExpired)';
}

/// Result of a cache get operation, indicating the data source.
enum CacheResultSource {
  /// Data came from cache and is fresh.
  cacheFresh,

  /// Data came from cache but is stale (revalidation in progress).
  cacheStale,

  /// Data was fetched fresh from the network.
  network,

  /// No cached data available.
  miss,
}

/// Wrapper for cache results that includes source information.
class SWRResult<T> {
  /// The data (may be null for cache miss or error).
  final T? data;

  /// Where the data came from.
  final CacheResultSource source;

  /// Whether revalidation is currently in progress.
  final bool isRevalidating;

  /// Error that occurred during fetch (if any).
  final Object? error;

  const SWRResult({
    this.data,
    required this.source,
    this.isRevalidating = false,
    this.error,
  });

  /// Whether we have valid data to display.
  bool get hasData => data != null;

  /// Whether the data is stale and being revalidated.
  bool get isStale => source == CacheResultSource.cacheStale;

  /// Whether this result is from cache (fresh or stale).
  bool get isFromCache =>
      source == CacheResultSource.cacheFresh ||
      source == CacheResultSource.cacheStale;

  /// Whether this result is fresh from the network.
  bool get isFromNetwork => source == CacheResultSource.network;

  /// Whether there was an error.
  bool get hasError => error != null;

  @override
  String toString() =>
      'SWRResult(hasData: $hasData, source: $source, isRevalidating: $isRevalidating)';
}
