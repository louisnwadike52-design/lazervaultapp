/// Configuration for cache TTL (time-to-live) settings.
///
/// LazerVault uses a stale-while-revalidate caching strategy:
/// - [staleTime]: Data is considered fresh until this duration passes.
///   During this time, cached data is returned without revalidation.
/// - [cacheTime]: Data is kept in cache for this duration.
///   After this time, data is evicted and must be fetched fresh.
///
/// The pattern:
/// 1. If data is fresh (< staleTime): Return cached data immediately
/// 2. If data is stale (> staleTime but < cacheTime): Return cached data,
///    revalidate in background, update cache when fresh data arrives
/// 3. If data is expired (> cacheTime): Fetch fresh data, show loading
class CacheConfig {
  /// Duration after which cached data is considered stale.
  /// Stale data will still be shown but revalidation will happen in background.
  final Duration staleTime;

  /// Duration after which cached data is completely evicted.
  /// After this time, a full fetch is required.
  final Duration cacheTime;

  const CacheConfig({
    this.staleTime = const Duration(minutes: 5),
    this.cacheTime = const Duration(hours: 24),
  });

  /// Configuration for TagPay tags list.
  /// Short stale time (2 min) because tags change frequently.
  static const tags = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for recipients list.
  /// Longer stale time (10 min) as recipients change less frequently.
  static const recipients = CacheConfig(
    staleTime: Duration(minutes: 10),
    cacheTime: Duration(hours: 24),
  );

  /// Configuration for invoices list.
  /// Medium stale time (5 min) for balance between freshness and network efficiency.
  static const invoices = CacheConfig(
    staleTime: Duration(minutes: 5),
    cacheTime: Duration(hours: 24),
  );

  /// Configuration for group accounts.
  /// Medium stale time (5 min) as group data changes moderately.
  static const groups = CacheConfig(
    staleTime: Duration(minutes: 5),
    cacheTime: Duration(hours: 24),
  );

  /// Configuration for user profile data.
  /// Longer stale time (15 min) as profile rarely changes.
  static const profile = CacheConfig(
    staleTime: Duration(minutes: 15),
    cacheTime: Duration(hours: 48),
  );

  /// Configuration for transaction history.
  /// Short stale time (1 min) to show recent transactions quickly.
  static const transactions = CacheConfig(
    staleTime: Duration(minutes: 1),
    cacheTime: Duration(hours: 6),
  );

  /// Configuration for search results.
  /// Very short stale time (30 sec) and short cache time.
  static const search = CacheConfig(
    staleTime: Duration(seconds: 30),
    cacheTime: Duration(minutes: 5),
  );

  /// Configuration for rarely changing reference data (banks, countries, etc).
  static const referenceData = CacheConfig(
    staleTime: Duration(hours: 1),
    cacheTime: Duration(days: 7),
  );

  @override
  String toString() =>
      'CacheConfig(staleTime: $staleTime, cacheTime: $cacheTime)';
}
