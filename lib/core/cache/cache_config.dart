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

  /// Configuration for airtime network providers.
  /// Short stale time (2 min) for freshness, 12 hour cache.
  static const airtimeProviders = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for auto-save rules.
  /// Short stale time (3 min) as rules can be toggled/updated frequently.
  static const autosaveRules = CacheConfig(
    staleTime: Duration(minutes: 3),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for auto-save statistics.
  /// Short stale time (2 min) as stats change with each trigger.
  static const autosaveStatistics = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 6),
  );

  /// Configuration for rarely changing reference data (banks, countries, etc).
  static const referenceData = CacheConfig(
    staleTime: Duration(hours: 1),
    cacheTime: Duration(days: 7),
  );

  /// Configuration for crowdfund campaign list.
  /// Medium stale time (3 min) for balance between freshness and caching.
  static const crowdfunds = CacheConfig(
    staleTime: Duration(minutes: 3),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for crowdfund campaign details.
  /// Short stale time (1 min) to keep details current.
  static const crowdfundDetails = CacheConfig(
    staleTime: Duration(minutes: 1),
    cacheTime: Duration(hours: 6),
  );

  /// Configuration for trending crowdfunds on discovery page.
  /// Short stale time (2 min) for freshness, 6 hour cache.
  static const trendingCrowdfunds = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 6),
  );

  /// Configuration for crowdfund leaderboard.
  /// Short stale time (1 min) for freshness, 6 hour cache.
  static const leaderboard = CacheConfig(
    staleTime: Duration(minutes: 1),
    cacheTime: Duration(hours: 6),
  );

  /// Configuration for public groups discovery.
  /// Medium stale time (3 min) as public groups change less frequently.
  static const publicGroups = CacheConfig(
    staleTime: Duration(minutes: 3),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for insurance products from MyCover.ai marketplace.
  /// Longer stale time (30 min) as products change infrequently, 12 hour cache.
  static const insuranceProducts = CacheConfig(
    staleTime: Duration(minutes: 30),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for insurance quotes.
  /// Short stale time (2 min) as quotes have limited validity, 15 min cache.
  static const insuranceQuotes = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(minutes: 15),
  );

  /// Configuration for stock listings and search results.
  /// Short stale time (2 min) for market freshness, 12 hour cache.
  static const stocks = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for investment portfolio data.
  /// Short stale time (2 min) as portfolio values change with market, 12 hour cache.
  static const portfolio = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for stock holdings list.
  /// Short stale time (2 min) for freshness, 12 hour cache.
  static const holdings = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for gift card brands catalog.
  /// Longer stale time (30 min) as brand catalog changes infrequently.
  static const giftCardBrands = CacheConfig(
    staleTime: Duration(minutes: 30),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for user's gift cards list.
  /// Short stale time (2 min) to reflect purchases/redemptions quickly.
  static const giftCards = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for gift card sales list.
  /// Short stale time (2 min) to reflect status changes.
  static const giftCardSales = CacheConfig(
    staleTime: Duration(minutes: 2),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for electricity bill providers.
  /// Longer stale time (10 min) as providers rarely change, 12 hour cache.
  static const electricityProviders = CacheConfig(
    staleTime: Duration(minutes: 10),
    cacheTime: Duration(hours: 12),
  );

  /// Configuration for business dashboard summary data.
  /// Medium stale time (5 min) for business metrics, 24 hour cache.
  static const businessDashboard = CacheConfig(
    staleTime: Duration(minutes: 5),
    cacheTime: Duration(hours: 24),
  );

  /// Configuration for business analytics charts data.
  /// Medium stale time (10 min) for analytics, 24 hour cache.
  static const businessAnalytics = CacheConfig(
    staleTime: Duration(minutes: 10),
    cacheTime: Duration(hours: 24),
  );

  @override
  String toString() =>
      'CacheConfig(staleTime: $staleTime, cacheTime: $cacheTime)';
}
