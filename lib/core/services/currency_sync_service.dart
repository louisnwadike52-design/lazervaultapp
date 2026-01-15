import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'locale_manager.dart';

/// Service for synchronizing currency between local storage and server.
///
/// This ensures that the active user's currency stays in sync:
/// - On login/app start: Fetch from server and store locally
/// - On currency change: Update both local and server
/// - Offline support: Use local currency with background sync
///
/// Usage:
/// ```dart
/// final syncService = serviceLocator<CurrencySyncService>();
///
/// // Call on user login/app start to fetch and sync currency
/// await syncService.syncFromServer();
///
/// // Call when user changes currency
/// await syncService.updateCurrency('EUR');
///
/// // Get current currency (from local storage for instant access)
/// final currency = syncService.currentCurrency;
/// ```
class CurrencySyncService {
  final IProfileRepository _profileRepository;
  final LocaleManager _localeManager;
  final Logger _logger;

  bool _isInitialized = false;
  String? _lastKnownServerCurrency;

  CurrencySyncService({
    required IProfileRepository profileRepository,
    required LocaleManager localeManager,
    Logger? logger,
  })  : _profileRepository = profileRepository,
        _localeManager = localeManager,
        _logger = logger ?? Logger();

  /// Get the current currency from local storage
  ///
  /// Returns the locally stored currency immediately without network call.
  /// Use this for UI updates and instant access.
  String get currentCurrency => _localeManager.currentCurrency;

  /// Stream of currency changes for reactive UI updates
  Stream<String> get currencyStream => _localeManager.currencyStream;

  /// Check if the service has been initialized with server data
  bool get isInitialized => _isInitialized;

  /// Synchronize currency from server to local storage
  ///
  /// Call this on user login or app start to ensure local currency
  /// matches the server. Handles offline scenarios gracefully.
  ///
  /// Returns:
  /// - Right(String): The synced currency code
  /// - Left(Failure): If sync fails and local currency is used as fallback
  Future<Either<dynamic, String>> syncFromServer() async {
    try {
      _logger.i('Syncing currency from server...');

      final result = await _profileRepository.getUserProfile();

      return result.fold(
        (failure) {
          _logger.w('Failed to sync currency from server: ${failure.message}');
          _logger.i('Using locally cached currency: $currentCurrency');

          // Return local currency as fallback
          return Right(currentCurrency);
        },
        (data) {
          final preferences = data['preferences'] as UserPreferences?;
          final serverCurrency = preferences?.currency ?? 'USD';

          _logger.i('Server currency: $serverCurrency, Local currency: $currentCurrency');

          // Update local storage if server currency is different
          if (serverCurrency != currentCurrency) {
            _localeManager.setCurrency(serverCurrency);
            _logger.i('Updated local currency to match server: $serverCurrency');
          }

          _lastKnownServerCurrency = serverCurrency;
          _isInitialized = true;

          return Right(serverCurrency);
        },
      );
    } catch (e) {
      _logger.e('Error syncing currency from server: $e');
      _logger.i('Using locally cached currency: $currentCurrency');
      return Right(currentCurrency);
    }
  }

  /// Update currency both locally and on server
  ///
  /// This is the preferred method to update currency as it ensures
  /// both local storage and server stay in sync.
  ///
  /// Parameters:
  /// - currencyCode: ISO 4217 currency code (e.g., "USD", "GBP", "EUR")
  ///
  /// Returns:
  /// - Right(UserPreferences): Updated preferences from server
  /// - Left(Failure): If update failed
  Future<Either<dynamic, UserPreferences>> updateCurrency(String currencyCode) async {
    try {
      _logger.i('Updating currency to: $currencyCode');

      // First, update local storage for instant UI feedback
      await _localeManager.setCurrency(currencyCode);

      // Then, sync to server
      final result = await _profileRepository.updatePreferences(
        currency: currencyCode,
      );

      return result.fold(
        (failure) {
          _logger.e('Failed to update currency on server: ${failure.message}');

          // Rollback local change if server update failed
          if (_lastKnownServerCurrency != null) {
            _logger.w('Rolling back to last known server currency: $_lastKnownServerCurrency');
            _localeManager.setCurrency(_lastKnownServerCurrency!);
          }

          return Left(failure);
        },
        (preferences) {
          _logger.i('Successfully updated currency to: ${preferences.currency}');
          _lastKnownServerCurrency = preferences.currency;
          _isInitialized = true;
          return Right(preferences);
        },
      );
    } catch (e) {
      _logger.e('Error updating currency: $e');
      return Left(Exception('Failed to update currency: $e'));
    }
  }

  /// Update currency locally only (without server sync)
  ///
  /// Use this for temporary changes or when offline.
  /// Changes will be synced to server on next syncFromServer call.
  ///
  /// Note: This bypasses server validation and may cause conflicts.
  Future<void> updateCurrencyLocalOnly(String currencyCode) async {
    _logger.w('Updating currency locally only (no server sync): $currencyCode');
    await _localeManager.setCurrency(currencyCode);
  }

  /// Get recommended currency for current country
  ///
  /// Returns the default currency for the user's current country
  /// based on their locale settings.
  String getRecommendedCurrencyForCurrentCountry() {
    final countryCode = _localeManager.currentCountry;
    final countryLocale = CountryLocales.findByCountryCode(countryCode);
    return countryLocale?.currency ?? 'USD';
  }

  /// Reset to default currency for current country
  ///
  /// Updates currency to match the user's current country and
  /// syncs the change to the server.
  Future<Either<dynamic, UserPreferences>> resetToDefaultForCountry() async {
    final recommendedCurrency = getRecommendedCurrencyForCurrentCountry();
    _logger.i('Resetting currency to default for country: $recommendedCurrency');
    return updateCurrency(recommendedCurrency);
  }

  /// Clear initialization state
  ///
  /// Call this on user logout to force re-sync on next login.
  void clear() {
    _logger.i('Clearing currency sync state');
    _isInitialized = false;
    _lastKnownServerCurrency = null;
  }

  /// Check if local currency matches server currency
  ///
  /// Returns true if local and server currencies are in sync.
  /// Returns false if they differ or if server is unreachable.
  Future<bool> isInSyncWithServer() async {
    try {
      final result = await _profileRepository.getUserProfile();

      return result.fold(
        (failure) {
          _logger.w('Cannot check sync status: server unreachable');
          return false; // Assume not in sync if server is unreachable
        },
        (data) {
          final preferences = data['preferences'] as UserPreferences?;
          final serverCurrency = preferences?.currency;
          final localCurrency = currentCurrency;

          final inSync = serverCurrency == localCurrency;
          _logger.i('Currency sync check: local=$localCurrency, server=$serverCurrency, inSync=$inSync');

          return inSync;
        },
      );
    } catch (e) {
      _logger.e('Error checking sync status: $e');
      return false;
    }
  }
}
