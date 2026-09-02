import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // Currently-selected trend window for the dashboard %-change chip. Persisted
  // here (not just in the widget) so the period bottom-sheet reflects the active
  // option on reopen and refetches keep the same window. Defaults to 30 days.
  String _trendPeriod = 'month';
  String get trendPeriod => _trendPeriod;

  // Stores the entity balance before the first WebSocket update per account (for animation "from" value)
  final Map<String, double> _preAnimationBalances = {};

  // Stores the latest WebSocket balance per account (for animation "to" value)
  final Map<String, double> _latestWebSocketBalances = {};

  // Debounces the server-authoritative refetch triggered by balance events that
  // arrive without a usable balance snapshot. See _handleBalanceUpdate.
  Timer? _refetchDebounce;

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
    // Drop any pending refetch FIRST: it captured the outgoing user's id, so
    // letting it fire after a logout/user-switch would pull the previous
    // account's balances into the new session.
    _refetchDebounce?.cancel();
    _refetchDebounce = null;
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

    // Lifecycle / non-balance events (insurance renewals, TagPay & similar
    // notifications) carry NO real balance snapshot — BalanceUpdateEvent defaults
    // new_balance/available_balance to 0 for those. Applying one would overwrite
    // the entity + snapshot maps with 0, corrupting the real balance (and the
    // panic shake-reveal would then show ₦0 after e.g. TagPay). The same is true
    // of an event whose account_id doesn't match any loaded card — TagPay's
    // receiver-side push omits account_id entirely, so it fails the lookup above.
    //
    // Neither case may be applied, but neither is meaningless either: the socket
    // is per-user, so an event arriving at all means money moved for THIS user.
    // Silently dropping both (which is what this did) is why no TagPay operation
    // ever refreshed a balance card. Instead of guessing a balance we don't have,
    // ask the server — it is authoritative — and let the normal loaded-state path
    // update the cards. Debounced and silent, so a burst (both legs of a
    // transfer) costs one request and never flashes a spinner over live cards.
    final hasBalanceSnapshot =
        event.newBalance > 0 || event.availableBalance > 0;
    if (accountIndex == -1 || !hasBalanceSnapshot) {
      print('AccountCardsSummaryCubit: ${event.eventType} event for account '
          '"${event.accountId}" has no usable balance snapshot '
          '(matched=${accountIndex != -1}); refetching from server');
      _scheduleBalanceRefetch();
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

    // Apply the new balance to the entity IMMEDIATELY so it survives any rebuild
    // or navigation — previously the entity was only updated by
    // markBalanceUpdateConsumed() (called by the dashboard carousel after it
    // animates). When the event arrives while the user is elsewhere (e.g. the
    // deposit screen), nothing consumed it and the dashboard reverted to the
    // stale balance until a re-login re-fetched. The animation still works: the
    // carousel animates _preAnimationBalances → _latestWebSocketBalances.
    final trendPercentage =
        _calculateTrendPercentage(previousBalance, event.newBalance);
    _currentSummaries = List.from(_currentSummaries);
    _currentSummaries[accountIndex] = _currentSummaries[accountIndex].copyWith(
      balance: event.newBalance,
      trendPercentage: trendPercentage,
    );

    // Emit animated update state (entities now carry the fresh balance; the
    // carousel animates from→to via the snapshot maps).
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

  /// Coalesces balance-event-driven refetches into a single silent fetch.
  ///
  /// Called when a WebSocket balance event tells us something happened but not
  /// what the new balance is (see _handleBalanceUpdate). A transfer pushes one
  /// event per leg and lifecycle events can arrive in bursts, so firing a
  /// request per event would hammer the gateway for no extra information.
  ///
  /// `silent: true` keeps the current cards on screen and, per
  /// fetchAccountSummaries' own failure handling, leaves the stale-but-real
  /// balance in place if the request fails rather than replacing live cards
  /// with an error screen. No loop risk: fetching balances moves no money and
  /// therefore emits no further balance events.
  void _scheduleBalanceRefetch() {
    final userId = _currentUserId;
    // Nothing has been loaded yet (no user context) — the first real fetch will
    // bring the fresh balance along with it, so there is nothing to refresh.
    if (userId == null || userId.isEmpty) return;

    _refetchDebounce?.cancel();
    _refetchDebounce = Timer(const Duration(milliseconds: 900), () {
      if (isClosed) return;
      // Re-check the user: a logout/user-switch between scheduling and firing
      // must not refetch the previous user's accounts.
      if (_currentUserId != userId) return;
      fetchAccountSummaries(userId: userId, silent: true);
    });
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
    String? period,
    bool silent = false,
    bool manualRefresh = false,
  }) async {
    if (isClosed) return;

    // If it's a different user, reset first
    if (_currentUserId != null && _currentUserId != userId) {
      print('AccountCardsSummaryCubit: User changed from $_currentUserId to $userId, resetting state');
      reset();
    }

    // Persist the chosen trend window so the bottom-sheet reflects the active
    // selection on reopen and subsequent refetches keep the same window.
    if (period != null && period.isNotEmpty) {
      _trendPeriod = period;
    }

    _currentUserId = userId;
    if (manualRefresh) {
      // EXPLICIT user refresh (swipe-down → "Refresh accounts"). The network
      // fetch below ALWAYS runs and re-persists the cache, so balances are
      // revalidated even when the amount comes back unchanged. Keep the current
      // cards on screen (don't collapse to the full-area spinner) and flag
      // isRefreshing so the card shows a small loader — the user gets feedback
      // that a refresh happened regardless of whether the number moved. Fall
      // back to the plain spinner only when there's nothing to show yet.
      final existing = _currentSummaries.isNotEmpty
          ? _currentSummaries
          : (await _loadCachedSummaries(userId) ?? const []);
      if (existing.isNotEmpty) {
        _currentSummaries = existing;
        emit(AccountCardsSummaryLoaded(existing, isRefreshing: true));
        _autoSelectPersonalAccount(existing);
      } else {
        emit(AccountCardsSummaryLoading());
      }
    } else if (!silent) {
      // On a fresh (non-silent) load — e.g. right after login — show the LAST
      // KNOWN balances from the local cache INSTANTLY instead of a loading state,
      // then revalidate in the background. The animated balance counter tweens
      // from the cached value to the fresh value, so a changed balance animates
      // and an unchanged one just stays put. Only fall back to the spinner when we
      // have nothing cached yet (very first login on this device).
      final cached = await _loadCachedSummaries(userId);
      if (cached != null && cached.isNotEmpty) {
        _currentSummaries = cached;
        emit(AccountCardsSummaryLoaded(cached));
        _autoSelectPersonalAccount(cached);
      } else {
        emit(AccountCardsSummaryLoading());
      }
    }
    final result = await _getAccountSummariesUseCase.call(
      userId: userId,
      accessToken: accessToken,
      country: country,
      period: _trendPeriod,
    );
    if (isClosed) return;
    result.fold(
      (failure) {
        // On a silent refresh don't replace live cards with an error screen —
        // the mutation (freeze) already succeeded server-side; just keep what
        // we have if the follow-up fetch hiccups.
        if (silent && _currentSummaries.isNotEmpty) return;
        // A MANUAL refresh that fails but has cards on screen: clear the
        // refreshing loader and keep the (last-known) cards rather than wiping
        // them with a full error screen. The dashboard surfaces the failure via
        // its own snackbar.
        if (manualRefresh && _currentSummaries.isNotEmpty) {
          emit(AccountCardsSummaryLoaded(_currentSummaries));
          return;
        }
        emit(AccountCardsSummaryError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (summaries) {
        // Sort: family accounts go last in the carousel
        final sorted = List<AccountSummaryEntity>.from(summaries)
          ..sort((a, b) {
            final aIsFamily = a.accountTypeEnum == VirtualAccountType.family ? 1 : 0;
            final bIsFamily = b.accountTypeEnum == VirtualAccountType.family ? 1 : 0;
            return aIsFamily.compareTo(bIsFamily);
          });
        _currentSummaries = sorted;
        emit(AccountCardsSummaryLoaded(sorted));
        // Persist the fresh balances so the NEXT login renders instantly from
        // cache (and the counter animates cache → fresh) instead of a spinner.
        _saveCachedSummaries(userId, sorted);

        // Auto-select personal account matching current locale's currency
        _autoSelectPersonalAccount(summaries);
      },
    );
  }

  static String _cacheKey(String userId) => 'acct_summaries_cache_$userId';

  /// Persist the latest summaries for instant cached render on next login.
  /// Best-effort — a storage failure must never break the live dashboard.
  Future<void> _saveCachedSummaries(
      String userId, List<AccountSummaryEntity> summaries) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final payload = jsonEncode(summaries.map((s) => s.toJson()).toList());
      await prefs.setString(_cacheKey(userId), payload);
    } catch (_) {/* cache is an optimization, not a source of truth */}
  }

  /// Read the last-known summaries for [userId], or null when none/corrupt.
  Future<List<AccountSummaryEntity>?> _loadCachedSummaries(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_cacheKey(userId));
      if (raw == null || raw.isEmpty) return null;
      final list = (jsonDecode(raw) as List)
          .map((e) => AccountSummaryEntity.fromJson(e as Map<String, dynamic>))
          .toList();
      return list;
    } catch (_) {
      return null;
    }
  }

  /// Automatically select the personal account that matches the current locale's currency
  void _autoSelectPersonalAccount(List<AccountSummaryEntity> summaries) {
    if (summaries.isEmpty) return;

    // Preserve the account the user is currently on across refreshes. A
    // pull-to-refresh re-fetches summaries; without this guard we'd reset the
    // active account (and therefore the carousel) back to the personal account
    // every time. Only auto-select on the FIRST load, or when the previously
    // active account is no longer present (e.g. it was closed/removed).
    final currentActive = _accountManager.activeAccountId;
    if (currentActive != null &&
        currentActive.isNotEmpty &&
        summaries.any((acc) =>
            acc.id == currentActive || acc.spendingAccountId == currentActive)) {
      return; // keep the user's current selection
    }

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

  /// Switch the active account. Surfaces a single public entry point so any
  /// screen that lets the user toggle accounts (crypto swap, transfer, etc.)
  /// goes through the cubit instead of grabbing AccountManager directly.
  ///
  /// Validates the new id corresponds to one of the loaded summaries — silent
  /// no-op if not, so callers can't accidentally drop us into an invalid
  /// account state.
  void setActiveAccount(String accountId) {
    if (accountId.isEmpty) return;
    final exists = _currentSummaries.any((s) => s.id == accountId);
    if (!exists) {
      print('AccountCardsSummaryCubit.setActiveAccount: account $accountId not in loaded summaries; ignored');
      return;
    }
    _accountManager.setActiveAccount(accountId);
  }

  /// The currently active account id as known by AccountManager. Returns null
  /// if no account has been selected yet (e.g. before the first load).
  String? get activeAccountId => _accountManager.activeAccountId;

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
    _refetchDebounce?.cancel();
    _wsSubscription?.cancel();
    return super.close();
  }
} 