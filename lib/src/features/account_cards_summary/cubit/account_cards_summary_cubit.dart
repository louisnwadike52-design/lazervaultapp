import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../domain/entities/account_summary_entity.dart';
import '../domain/usecases/get_account_summaries_usecase.dart';
import '../services/balance_websocket_service.dart';
import 'account_cards_summary_state.dart';


@injectable
class AccountCardsSummaryCubit extends Cubit<AccountCardsSummaryState> {
  final GetAccountSummariesUseCase _getAccountSummariesUseCase;
  final BalanceWebSocketService? _wsService;
  final AccountManager _accountManager;
  final LocaleManager _localeManager;
  StreamSubscription<BalanceUpdateEvent>? _wsSubscription;

  // Keep track of current summaries for WebSocket updates
  List<AccountSummaryEntity> _currentSummaries = [];

  // Track the user ID for whom the data was loaded
  String? _currentUserId;

  // Stores the entity balance before the first WebSocket update per account (for animation "from" value)
  final Map<String, double> _preAnimationBalances = {};

  // Stores the latest WebSocket balance per account (for animation "to" value)
  final Map<String, double> _latestWebSocketBalances = {};

  AccountCardsSummaryCubit(
    this._getAccountSummariesUseCase, {
    required AccountManager accountManager,
    required LocaleManager localeManager,
    BalanceWebSocketService? wsService,
  })  : _wsService = wsService,
        _accountManager = accountManager,
        _localeManager = localeManager,
        super(AccountCardsSummaryInitial()) {
    // Listen to WebSocket balance updates if service provided
    if (_wsService != null) {
      _wsSubscription = _wsService!.balanceUpdates.listen(_handleBalanceUpdate);
    }
  }

  /// Get the current user ID for whom data is loaded
  String? get currentUserId => _currentUserId;

  /// Reset the cubit state (call on logout)
  void reset() {
    _currentSummaries = [];
    _currentUserId = null;
    _preAnimationBalances.clear();
    _latestWebSocketBalances.clear();
    emit(AccountCardsSummaryInitial());
    print('AccountCardsSummaryCubit: State reset');
  }

  /// Handle incoming WebSocket balance update
  ///
  /// Does NOT mutate _currentSummaries — entities always reflect server-fetched
  /// balances. WebSocket updates are tracked separately for animation purposes.
  void _handleBalanceUpdate(BalanceUpdateEvent event) {
    if (isClosed) return;

    // Find the account that was updated
    final accountIndex = _currentSummaries.indexWhere(
      (summary) => summary.id == event.accountId,
    );

    if (accountIndex == -1) {
      print('AccountCardsSummaryCubit: Account ${event.accountId} not found, skipping update');
      return;
    }

    // Record the entity balance before any WebSocket update (only on first update per account)
    final entityBalance = _currentSummaries[accountIndex].balance;
    _preAnimationBalances.putIfAbsent(event.accountId, () => entityBalance);

    // Always store the latest WebSocket balance
    _latestWebSocketBalances[event.accountId] = event.newBalance;

    // Determine the "previous" balance for the emitted state:
    // Use the pre-animation balance (entity snapshot) so the carousel can animate from→to
    final previousBalance = _preAnimationBalances[event.accountId]!;

    // Emit animated update state (entities unchanged — carousel uses _realtimeBalances overlay)
    emit(AccountBalanceUpdated(
      accountSummaries: _currentSummaries,
      updatedAccountId: event.accountId,
      previousBalance: previousBalance,
      newBalance: event.newBalance,
      amount: event.amount ?? (event.newBalance - previousBalance).abs(),
      eventType: event.eventType,
      status: event.status,
      reference: event.reference,
    ));

    print('AccountCardsSummaryCubit: Balance update tracked for account ${event.accountId} - ${event.eventType}: $previousBalance -> ${event.newBalance}');
  }

  /// Calculate trend percentage
  double _calculateTrendPercentage(double previousBalance, double newBalance) {
    if (previousBalance == 0) return 0.0;
    return ((newBalance - previousBalance) / previousBalance) * 100;
  }

  Future<void> fetchAccountSummaries({
    required String userId,
    String? accessToken,
    String? country,
  }) async {
    if (isClosed) return;

    // If it's a different user, reset first
    if (_currentUserId != null && _currentUserId != userId) {
      print('AccountCardsSummaryCubit: User changed from $_currentUserId to $userId, resetting state');
      reset();
    }

    _currentUserId = userId;
    emit(AccountCardsSummaryLoading());
    final result = await _getAccountSummariesUseCase.call(
      userId: userId,
      accessToken: accessToken,
      country: country,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(AccountCardsSummaryError(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (summaries) {
        _currentSummaries = summaries;
        emit(AccountCardsSummaryLoaded(summaries));

        // Auto-select personal account matching current locale's currency
        _autoSelectPersonalAccount(summaries);
      },
    );
  }

  /// Automatically select the personal account that matches the current locale's currency
  void _autoSelectPersonalAccount(List<AccountSummaryEntity> summaries) {
    if (summaries.isEmpty) return;

    // Get current locale to determine expected currency
    final currentLocale = _localeManager.currentLocale;
    final expectedCurrency = _getCurrencyForLocale(currentLocale);

    // Find personal account with matching currency
    final personalAccount = summaries.firstWhere(
      (acc) => acc.accountType.toLowerCase() == 'personal' && acc.currency == expectedCurrency,
      orElse: () => summaries.first, // Fallback to first account if no personal match
    );

    _accountManager.setActiveAccount(personalAccount.id);
    print('AccountCardsSummaryCubit: Auto-selected account ${personalAccount.accountNumber} (${personalAccount.accountType}) for locale $currentLocale ($expectedCurrency)');
  }

  /// Get currency code for locale (e.g., en-NG -> NGN, en-US -> USD)
  /// Uses CountryLocales as the single source of truth.
  String _getCurrencyForLocale(String locale) {
    if (locale.contains('-')) {
      final countryCode = locale.split('-')[1].toUpperCase();
      final countryLocale = CountryLocales.findByCountryCode(countryCode);
      if (countryLocale != null) {
        return countryLocale.currency;
      }
      return countryCode; // Fallback to country code itself
    }
    return 'USD'; // Default fallback
  }

  /// Returns true if the cubit already holds loaded data for [userId].
  /// Used by the dashboard to skip redundant gRPC fetches on re-mount.
  bool hasDataForUser(String userId) {
    return _currentUserId == userId && _currentSummaries.isNotEmpty;
  }

  /// Builds animation info from the tracking maps.
  /// Returns a map of accountId → (from, to) balance pairs for accounts
  /// that have pending WebSocket updates not yet consumed.
  Map<String, ({double from, double to})> getPendingAnimations() {
    final result = <String, ({double from, double to})>{};
    for (final accountId in _latestWebSocketBalances.keys) {
      final from = _preAnimationBalances[accountId];
      final to = _latestWebSocketBalances[accountId];
      if (from != null && to != null) {
        result[accountId] = (from: from, to: to);
      }
    }
    return result;
  }

  /// Called after the carousel finishes animating. Updates _currentSummaries
  /// with WebSocket balances so entities reflect reality, then clears tracking maps.
  void markBalanceUpdateConsumed() {
    if (isClosed) return;

    // Apply WebSocket balances to entities
    for (final entry in _latestWebSocketBalances.entries) {
      final idx = _currentSummaries.indexWhere((s) => s.id == entry.key);
      if (idx != -1) {
        final prev = _currentSummaries[idx];
        final trendPercentage = _calculateTrendPercentage(prev.balance, entry.value);
        _currentSummaries = List.from(_currentSummaries);
        _currentSummaries[idx] = prev.copyWith(
          balance: entry.value,
          trendPercentage: trendPercentage,
        );
      }
    }

    _preAnimationBalances.clear();
    _latestWebSocketBalances.clear();

    emit(AccountCardsSummaryLoaded(_currentSummaries));
    print('AccountCardsSummaryCubit: Balance updates consumed, entities updated');
  }

  /// Connect WebSocket for real-time updates
  Future<void> connectWebSocket({
    required String userId,
    required String countryCode,
    required String accessToken,
  }) async {
    if (_wsService != null && !_wsService!.isConnected) {
      try {
        await _wsService!.connect(
          userId: userId,
          countryCode: countryCode,
          accessToken: accessToken,
        );
        print('AccountCardsSummaryCubit: WebSocket connected for real-time updates');
      } catch (e) {
        print('AccountCardsSummaryCubit: Failed to connect WebSocket - $e');
      }
    }
  }

  /// Disconnect WebSocket
  void disconnectWebSocket() {
    _wsService?.disconnect();
  }

  /// Get current summaries
  List<AccountSummaryEntity> get currentSummaries => _currentSummaries;

  @override
  Future<void> close() {
    _wsSubscription?.cancel();
    return super.close();
  }
} 