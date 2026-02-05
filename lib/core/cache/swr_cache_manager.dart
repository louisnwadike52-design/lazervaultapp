import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'cache_config.dart';
import 'cache_entry.dart';

// Re-export SWRResult and CacheResultSource for consumers
export 'cache_entry.dart' show SWRResult, CacheResultSource;

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

/// Stale-While-Revalidate cache manager for network optimization.
///
/// This manager implements the SWR pattern with comprehensive edge case handling:
/// - Cache corruption detection and automatic repair
/// - Storage full handling with LRU eviction
/// - Memory pressure management with size limits
/// - Concurrent access deduplication
/// - Statistics tracking for monitoring
///
/// Usage in a Cubit:
/// ```dart
/// Future<void> loadItems() async {
///   await for (final result in cacheManager.get<List<Item>>(
///     key: 'items_list',
///     fetcher: () => repository.getItems(),
///     config: CacheConfig.items,
///     serializer: (items) => jsonEncode(items.map((i) => i.toJson()).toList()),
///     deserializer: (json) => (jsonDecode(json) as List).map((j) => Item.fromJson(j)).toList(),
///   )) {
///     if (result.hasData) {
///       emit(ItemsLoaded(items: result.data!, isStale: result.isStale));
///     } else if (result.hasError) {
///       emit(ItemsError(result.error.toString()));
///     }
///   }
/// }
/// ```
class SWRCacheManager {
  /// Secure storage for persisting cache entries.
  final FlutterSecureStorage _storage;

  /// In-memory cache using LRU eviction.
  final LinkedHashMap<String, CacheEntry<dynamic>> _memoryCache =
      LinkedHashMap<String, CacheEntry<dynamic>>();

  /// Active revalidation requests to prevent duplicate fetches.
  final Map<String, Future<dynamic>> _pendingFetches = {};

  /// Lock for concurrent write operations.
  final Map<String, Completer<void>> _writeLocks = {};

  /// Prefix for all cache keys in storage.
  static const String _cachePrefix = 'swr_cache_';

  /// Maximum entries in memory cache (LRU eviction when exceeded).
  final int maxMemoryCacheEntries;

  /// Maximum size of a single cache entry in bytes (to prevent memory issues).
  final int maxEntrySizeBytes;

  /// Statistics for monitoring.
  final CacheStatistics statistics = CacheStatistics();

  /// Whether the cache manager has been initialized.
  bool _initialized = false;

  /// Stream controller for cache events (for debugging/monitoring).
  final _eventController = StreamController<String>.broadcast();

  /// Stream of cache events for debugging.
  Stream<String> get events => _eventController.stream;

  SWRCacheManager({
    FlutterSecureStorage? storage,
    this.maxMemoryCacheEntries = 100,
    this.maxEntrySizeBytes = 1024 * 1024, // 1MB default
  }) : _storage = storage ?? const FlutterSecureStorage();

  /// Initializes the cache manager.
  ///
  /// Should be called during app startup to:
  /// - Clean up corrupted entries
  /// - Remove expired entries
  /// - Pre-warm memory cache with recent entries
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await _cleanupCorruptedEntries();
      await cleanup();
      _initialized = true;
      _emit('[SWRCache] Initialized');
    } catch (e) {
      _emit('[SWRCache] Initialization error: $e');
      // Continue anyway - cache will work in degraded mode
      _initialized = true;
    }
  }

  /// Gets data using the SWR pattern.
  ///
  /// Returns a Stream that emits:
  /// 1. Cached data immediately (if available)
  /// 2. Fresh data when revalidation completes (if cache was stale)
  ///
  /// Edge cases handled:
  /// - Cache corruption: Automatically repairs and fetches fresh
  /// - Storage full: Evicts old entries and retries
  /// - Concurrent requests: Deduplicates fetches
  /// - Memory pressure: LRU eviction when limit exceeded
  Stream<SWRResult<T>> get<T>({
    required String key,
    required Future<T> Function() fetcher,
    required CacheConfig config,
    required String Function(T data) serializer,
    required T Function(String json) deserializer,
  }) {
    return _getStream(
      key: key,
      fetcher: fetcher,
      config: config,
      serializer: serializer,
      deserializer: deserializer,
    );
  }

  Stream<SWRResult<T>> _getStream<T>({
    required String key,
    required Future<T> Function() fetcher,
    required CacheConfig config,
    required String Function(T data) serializer,
    required T Function(String json) deserializer,
  }) async* {
    final cacheKey = '$_cachePrefix$key';

    // Try to get from memory cache first (with LRU update)
    CacheEntry<T>? entry = _getFromMemoryCache<T>(cacheKey);

    // If not in memory, try persistent storage
    if (entry == null) {
      entry = await _getFromStorage<T>(cacheKey, key);
    }

    // If we have cached data and it's not expired, emit it
    if (entry != null && !entry.isExpired) {
      T? data;
      try {
        data = deserializer(entry.dataJson);
      } catch (e) {
        // Deserialization failed - cache is corrupted
        _emit('[SWRCache] Deserialization error for $key: $e');
        statistics.errors++;
        statistics.corruptionRepairs++;
        await _handleCorruptedEntry(cacheKey);
        entry = null;
      }

      if (data != null) {
        if (entry!.isStale) {
          statistics.staleHits++;
          _emit('[SWRCache] Stale hit for $key');
        } else {
          statistics.hits++;
          _emit('[SWRCache] Cache hit for $key');
        }

        yield SWRResult<T>(
          data: data,
          source: entry.isStale
              ? CacheResultSource.cacheStale
              : CacheResultSource.cacheFresh,
          isRevalidating: entry.isStale,
        );

        // If data is fresh, we're done
        if (entry.isFresh) {
          return;
        }
      }
    } else {
      statistics.misses++;
      _emit('[SWRCache] Cache miss for $key');
    }

    // Fetch fresh data (either no cache, expired, or stale)
    try {
      final freshData = await _fetchWithDedup(cacheKey, fetcher);
      statistics.networkFetches++;

      // Serialize the data
      String dataJson;
      try {
        dataJson = serializer(freshData);
      } catch (e) {
        _emit('[SWRCache] Serialization error for $key: $e');
        statistics.errors++;
        yield SWRResult<T>(
          data: freshData, // Still return the data even if we can't cache it
          source: CacheResultSource.network,
          isRevalidating: false,
          error: CacheError(
            type: CacheErrorType.serializationError,
            message: 'Failed to serialize data for caching',
            originalError: e,
            key: key,
          ),
        );
        return;
      }

      // Check entry size
      if (dataJson.length > maxEntrySizeBytes) {
        _emit('[SWRCache] Entry too large for $key (${dataJson.length} bytes)');
        // Still return the data, just don't cache it
        yield SWRResult<T>(
          data: freshData,
          source: CacheResultSource.network,
          isRevalidating: false,
        );
        return;
      }

      // Store in cache
      final newEntry = CacheEntry<T>(
        key: key,
        dataJson: dataJson,
        fetchedAt: DateTime.now(),
        staleTime: config.staleTime,
        cacheTime: config.cacheTime,
      );

      await _storeEntry(cacheKey, newEntry);

      yield SWRResult<T>(
        data: freshData,
        source: CacheResultSource.network,
        isRevalidating: false,
      );
    } catch (e) {
      _emit('[SWRCache] Fetch error for $key: $e');
      statistics.errors++;

      // Classify the error
      final cacheError = CacheError(
        type: CacheErrorType.fetchError,
        message: 'Failed to fetch fresh data',
        originalError: e,
        key: key,
      );

      yield SWRResult<T>(
        data: null,
        source: CacheResultSource.miss,
        isRevalidating: false,
        error: cacheError,
      );
    }
  }

  /// Gets entry from memory cache with LRU update.
  CacheEntry<T>? _getFromMemoryCache<T>(String cacheKey) {
    final entry = _memoryCache[cacheKey];
    if (entry != null) {
      // Move to end for LRU (most recently used)
      _memoryCache.remove(cacheKey);
      _memoryCache[cacheKey] = entry;
      return entry as CacheEntry<T>?;
    }
    return null;
  }

  /// Gets entry from persistent storage.
  Future<CacheEntry<T>?> _getFromStorage<T>(String cacheKey, String key) async {
    try {
      final stored = await _storage.read(key: cacheKey);
      if (stored != null) {
        try {
          final entry = CacheEntry.decode<T>(stored);
          // Populate memory cache
          _addToMemoryCache(cacheKey, entry as CacheEntry<dynamic>);
          return entry;
        } catch (e) {
          // Corrupted entry in storage
          _emit('[SWRCache] Corrupted entry in storage for $key: $e');
          statistics.corruptionRepairs++;
          await _handleCorruptedEntry(cacheKey);
        }
      }
    } catch (e) {
      _emit('[SWRCache] Storage read error for $key: $e');
      statistics.errors++;
    }
    return null;
  }

  /// Adds entry to memory cache with LRU eviction.
  void _addToMemoryCache(String key, CacheEntry<dynamic> entry) {
    // Evict oldest entries if at capacity
    while (_memoryCache.length >= maxMemoryCacheEntries) {
      final oldestKey = _memoryCache.keys.first;
      _memoryCache.remove(oldestKey);
      statistics.evictions++;
      _emit('[SWRCache] Evicted from memory: $oldestKey');
    }
    _memoryCache[key] = entry;
  }

  /// Stores entry in both memory and persistent storage.
  Future<void> _storeEntry(String cacheKey, CacheEntry<dynamic> entry) async {
    // Acquire write lock
    final lock = _writeLocks[cacheKey] ??= Completer<void>();
    if (!lock.isCompleted) {
      await lock.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          _emit('[SWRCache] Write lock timeout for $cacheKey');
        },
      );
    }
    _writeLocks[cacheKey] = Completer<void>();

    try {
      // Update memory cache
      _addToMemoryCache(cacheKey, entry);

      // Persist to storage with retry on failure
      await _persistWithRetry(cacheKey, entry);
    } finally {
      _writeLocks[cacheKey]?.complete();
      _writeLocks.remove(cacheKey);
    }
  }

  /// Persists entry to storage with retry and eviction on failure.
  Future<void> _persistWithRetry(
      String cacheKey, CacheEntry<dynamic> entry) async {
    const maxRetries = 3;
    var attempt = 0;

    while (attempt < maxRetries) {
      try {
        await _storage.write(key: cacheKey, value: entry.encode());
        return;
      } catch (e) {
        attempt++;
        _emit('[SWRCache] Storage write error (attempt $attempt): $e');

        if (e.toString().contains('storage') ||
            e.toString().contains('full') ||
            e.toString().contains('space')) {
          // Storage might be full - try to evict old entries
          await _evictOldestEntries(5);
        }

        if (attempt >= maxRetries) {
          statistics.errors++;
          _emit('[SWRCache] Failed to persist after $maxRetries attempts');
          // Don't throw - data is still in memory cache
        } else {
          await Future.delayed(Duration(milliseconds: 100 * attempt));
        }
      }
    }
  }

  /// Evicts oldest entries from persistent storage.
  Future<void> _evictOldestEntries(int count) async {
    try {
      final allData = await _storage.readAll();
      final cacheEntries = <MapEntry<String, DateTime>>[];

      for (final entry in allData.entries) {
        if (entry.key.startsWith(_cachePrefix)) {
          try {
            final cached = CacheEntry.decode(entry.value);
            cacheEntries.add(MapEntry(entry.key, cached.fetchedAt));
          } catch (e) {
            // Corrupted - delete it
            await _storage.delete(key: entry.key);
            statistics.evictions++;
          }
        }
      }

      // Sort by age (oldest first)
      cacheEntries.sort((a, b) => a.value.compareTo(b.value));

      // Delete oldest entries
      for (var i = 0; i < count && i < cacheEntries.length; i++) {
        await _storage.delete(key: cacheEntries[i].key);
        _memoryCache.remove(cacheEntries[i].key);
        statistics.evictions++;
        _emit('[SWRCache] Evicted: ${cacheEntries[i].key}');
      }
    } catch (e) {
      _emit('[SWRCache] Error during eviction: $e');
    }
  }

  /// Handles corrupted cache entry by removing it.
  Future<void> _handleCorruptedEntry(String cacheKey) async {
    _memoryCache.remove(cacheKey);
    try {
      await _storage.delete(key: cacheKey);
    } catch (e) {
      _emit('[SWRCache] Error deleting corrupted entry: $e');
    }
  }

  /// Cleans up corrupted entries during initialization.
  Future<void> _cleanupCorruptedEntries() async {
    try {
      final allData = await _storage.readAll();
      var corruptedCount = 0;

      for (final entry in allData.entries) {
        if (entry.key.startsWith(_cachePrefix)) {
          try {
            CacheEntry.decode(entry.value);
          } catch (e) {
            await _storage.delete(key: entry.key);
            corruptedCount++;
          }
        }
      }

      if (corruptedCount > 0) {
        _emit('[SWRCache] Cleaned up $corruptedCount corrupted entries');
        statistics.corruptionRepairs += corruptedCount;
      }
    } catch (e) {
      _emit('[SWRCache] Error during corruption cleanup: $e');
    }
  }

  /// Deduplicates concurrent fetch requests for the same key.
  Future<T> _fetchWithDedup<T>(String key, Future<T> Function() fetcher) async {
    // If there's already a pending fetch, reuse it
    if (_pendingFetches.containsKey(key)) {
      _emit('[SWRCache] Reusing pending fetch for $key');
      return await _pendingFetches[key] as T;
    }

    // Start new fetch with timeout
    final fetchFuture = fetcher().timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw TimeoutException('Fetch timed out after 30 seconds');
      },
    );
    _pendingFetches[key] = fetchFuture;

    try {
      final result = await fetchFuture;
      return result;
    } finally {
      _pendingFetches.remove(key);
    }
  }

  /// Invalidates a specific cache entry.
  ///
  /// Call this after mutations that affect the cached data.
  Future<void> invalidate(String key) async {
    final cacheKey = '$_cachePrefix$key';
    _memoryCache.remove(cacheKey);
    try {
      await _storage.delete(key: cacheKey);
      _emit('[SWRCache] Invalidated: $key');
    } catch (e) {
      _emit('[SWRCache] Error invalidating $key: $e');
    }
  }

  /// Invalidates all cache entries matching a pattern.
  ///
  /// Example: invalidatePattern('tags_') to clear all tag caches.
  Future<void> invalidatePattern(String pattern) async {
    final cacheKeyPattern = '$_cachePrefix$pattern';

    // Clear matching memory cache entries
    final keysToRemove =
        _memoryCache.keys.where((k) => k.startsWith(cacheKeyPattern)).toList();
    for (final key in keysToRemove) {
      _memoryCache.remove(key);
    }

    // Clear from persistent storage
    try {
      final allKeys = await _storage.readAll();
      for (final key in allKeys.keys) {
        if (key.startsWith(cacheKeyPattern)) {
          await _storage.delete(key: key);
        }
      }
      _emit('[SWRCache] Invalidated pattern: $pattern (${keysToRemove.length} entries)');
    } catch (e) {
      _emit('[SWRCache] Error invalidating pattern $pattern: $e');
    }
  }

  /// Invalidates all cache entries.
  Future<void> invalidateAll() async {
    _memoryCache.clear();

    try {
      final allKeys = await _storage.readAll();
      for (final key in allKeys.keys) {
        if (key.startsWith(_cachePrefix)) {
          await _storage.delete(key: key);
        }
      }
      _emit('[SWRCache] Invalidated all entries');
    } catch (e) {
      _emit('[SWRCache] Error invalidating all: $e');
    }
  }

  /// Pre-populates the cache with data.
  ///
  /// Useful for optimistic updates after mutations.
  Future<void> set<T>({
    required String key,
    required T data,
    required CacheConfig config,
    required String Function(T data) serializer,
  }) async {
    final cacheKey = '$_cachePrefix$key';

    String dataJson;
    try {
      dataJson = serializer(data);
    } catch (e) {
      _emit('[SWRCache] Serialization error in set for $key: $e');
      return;
    }

    if (dataJson.length > maxEntrySizeBytes) {
      _emit('[SWRCache] Entry too large in set for $key');
      return;
    }

    final entry = CacheEntry<T>(
      key: key,
      dataJson: dataJson,
      fetchedAt: DateTime.now(),
      staleTime: config.staleTime,
      cacheTime: config.cacheTime,
    );

    await _storeEntry(cacheKey, entry);
    _emit('[SWRCache] Set: $key');
  }

  /// Gets cached data synchronously from memory cache only.
  ///
  /// Returns null if not in memory cache. Does not check persistent storage.
  T? getSync<T>({
    required String key,
    required T Function(String json) deserializer,
  }) {
    final cacheKey = '$_cachePrefix$key';
    final entry = _getFromMemoryCache<T>(cacheKey);

    if (entry == null || entry.isExpired) {
      return null;
    }

    try {
      return deserializer(entry.dataJson);
    } catch (e) {
      _emit('[SWRCache] Sync deserialization error for $key: $e');
      return null;
    }
  }

  /// Clears expired entries from both caches.
  Future<void> cleanup() async {
    var expiredCount = 0;

    // Clear expired memory cache entries
    final expiredKeys = _memoryCache.entries
        .where((e) => e.value.isExpired)
        .map((e) => e.key)
        .toList();
    for (final key in expiredKeys) {
      _memoryCache.remove(key);
      expiredCount++;
    }

    // Clear expired persistent storage entries
    try {
      final allData = await _storage.readAll();
      for (final entry in allData.entries) {
        if (entry.key.startsWith(_cachePrefix)) {
          try {
            final cached = CacheEntry.decode(entry.value);
            if (cached.isExpired) {
              await _storage.delete(key: entry.key);
              expiredCount++;
            }
          } catch (e) {
            // Corrupted entry, delete it
            await _storage.delete(key: entry.key);
            statistics.corruptionRepairs++;
          }
        }
      }
    } catch (e) {
      _emit('[SWRCache] Error during cleanup: $e');
    }

    if (expiredCount > 0) {
      _emit('[SWRCache] Cleaned up $expiredCount expired entries');
    }
  }

  /// Called when app goes to background - persist any pending writes.
  Future<void> onAppPaused() async {
    _emit('[SWRCache] App paused - ensuring persistence');
    // All writes are already persisted, nothing special needed
  }

  /// Called when app returns to foreground - refresh stale data.
  Future<void> onAppResumed() async {
    _emit('[SWRCache] App resumed');
    // Cleanup expired entries
    await cleanup();
  }

  /// Called on memory pressure - clear memory cache.
  void onMemoryPressure() {
    _emit('[SWRCache] Memory pressure - clearing memory cache');
    final entriesCleared = _memoryCache.length;
    _memoryCache.clear();
    _emit('[SWRCache] Cleared $entriesCleared entries from memory');
  }

  /// Gets current cache statistics.
  CacheStatistics getStatistics() => statistics;

  /// Resets cache statistics.
  void resetStatistics() => statistics.reset();

  /// Gets the number of entries in memory cache.
  int get memoryCacheSize => _memoryCache.length;

  /// Gets the number of pending fetches.
  int get pendingFetchCount => _pendingFetches.length;

  void _emit(String event) {
    if (kDebugMode) {
      print(event);
    }
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  /// Disposes of resources.
  Future<void> dispose() async {
    await _eventController.close();
  }
}
