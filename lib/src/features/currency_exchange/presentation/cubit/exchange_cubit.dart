import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../data/services/exchange_websocket_service.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final IExchangeRepository _repository;
  final ExchangeWebSocketService _wsService;

  ExchangeCubit({
    required IExchangeRepository repository,
    required ExchangeWebSocketService wsService,
  })  : _repository = repository,
        _wsService = wsService,
        super(ExchangeInitial());

  // WebSocket subscription replaces polling entirely. While the
  // processing screen is open the cubit subscribes via
  // ExchangeWebSocketService; backend emits a terminal event from the
  // outbox publisher → financial-gateway Kafka consumer → WS hub →
  // here. No timers, no hardcoded delays.
  StreamSubscription<ExchangeWsEvent>? _wsSub;
  String? _activeWsTxId;

  // Bounded auto-poll fallback for the terminal event. The WS push is the
  // fast path, but it depends on Flutterwave's webhook reaching the
  // backend — which never happens in local/dev and can lag in prod. The
  // reconciler settles the money server-side regardless, so we poll
  // GetTransactionStatus on a bounded schedule until we observe a terminal
  // status (or the WS beats us to it). This is a recovery fallback, NOT
  // business polling — it stops the instant the transfer resolves.
  Timer? _pollTimer;
  int _pollTick = 0;
  static const _pollInterval = Duration(seconds: 4);
  // ~2.5 min ceiling (37 ticks × 4s). Past this the processing screen
  // still offers manual pull-to-refresh; we don't spin forever.
  static const _pollMaxTicks = 37;

  // Cached state for the current flow
  ExchangeMode _currentMode = ExchangeMode.convert;
  String _fromCurrency = 'NGN';
  String _toCurrency = 'USD';
  double _amount = 0;
  ExchangeRate? _currentRate;
  List<SupportedCurrencyInfo> _supportedCurrencies = [];

  ExchangeMode get currentMode => _currentMode;
  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;
  double get amount => _amount;
  ExchangeRate? get currentRate => _currentRate;
  List<SupportedCurrencyInfo> get supportedCurrencies => _supportedCurrencies;

  // Cached home data for composite state updates
  List<CurrencyTransaction> _recentTransactions = [];

  /// Last-loaded recent exchanges, readable regardless of the current state
  /// (the recipient screen's previous-beneficiaries picker reads this after
  /// navigation has moved the cubit past ExchangeHomeWithRate).
  List<CurrencyTransaction> get recentTransactionsCache =>
      List.unmodifiable(_recentTransactions);

  // Latest daily FX limits for the current source currency (pre-flight).
  ExchangeLimits? _limits;
  ExchangeLimits? get limits => _limits;

  /// Fetch the user's daily FX limits for the current source currency and
  /// return a friendly, actionable message if [amount] would breach the
  /// remaining daily allowance — else null. Called BEFORE navigating to the
  /// recipient screen / PIN so a limit breach never first surfaces at PIN
  /// time. Fails OPEN (returns null) on a lookup error so a transient limits
  /// RPC failure never blocks a legitimate transfer — the backend re-checks
  /// atomically under lock anyway.
  Future<String?> checkDailyLimit(double amount) async {
    final result =
        await _repository.getExchangeLimits(currency: _fromCurrency);
    if (isClosed) return null;
    return result.fold(
      (_) => null,
      (limits) {
        _limits = limits;
        if (!limits.exceedsRemaining(amount)) return null;
        final cur = limits.currency.isNotEmpty ? limits.currency : _fromCurrency;
        return 'This exceeds your daily transfer limit for tier ${limits.kycTier}. '
            'Remaining today: ${limits.dailyRemaining.toStringAsFixed(2)} $cur '
            '(daily cap ${limits.dailyLimit.toStringAsFixed(2)} $cur). '
            'Upgrade your KYC tier to send more.';
      },
    );
  }

  /// Initialize cubit state from route arguments (fixes state loss between screens).
  void initFromArguments({
    required String from,
    required String to,
    required double amount,
    required ExchangeRate rate,
    required ExchangeMode mode,
  }) {
    _fromCurrency = from;
    _toCurrency = to;
    _amount = amount;
    _currentRate = rate;
    _currentMode = mode;
  }

  /// Load data for the home screen with rate data inline.
  Future<void> loadHome() async {
    emit(ExchangeLoading());

    final currenciesResult = await _repository.getSupportedCurrencies();
    final recentResult = await _repository.getRecentExchanges(limit: 3);
    if (isClosed) return;

    // If both fail, show error
    if (currenciesResult.isLeft() && recentResult.isLeft()) {
      currenciesResult.fold(
        (failure) => emit(ExchangeError(failure.message)),
        (_) {},
      );
      return;
    }

    final currencies = currenciesResult.fold(
      (_) => <SupportedCurrencyInfo>[],
      (data) => data,
    );
    final recent = recentResult.fold(
      (_) => <CurrencyTransaction>[],
      (data) => data,
    );

    _supportedCurrencies = currencies;
    _recentTransactions = recent;

    emit(ExchangeHomeWithRate(
      supportedCurrencies: currencies,
      recentTransactions: recent,
    ));

    // Auto-fetch initial rate for the default currency pair
    await fetchRateForHome();
  }

  /// Set the exchange mode.
  void setMode(ExchangeMode mode) {
    _currentMode = mode;
  }

  /// Set the currency pair.
  void setCurrencyPair(String from, String to) {
    _fromCurrency = from;
    _toCurrency = to;
  }

  /// Swap the currency pair.
  void swapCurrencies() {
    final temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;
  }

  /// Set the amount and recalculate with current rate.
  /// Emits ExchangeHomeWithRate when on the home screen.
  ///
  /// When no rate is loaded yet (e.g. the initial loadHome() rate-fetch
  /// failed because the upstream provider was momentarily down), kick off
  /// a fresh fetch so typing an amount self-heals into a visible rate
  /// instead of silently doing nothing.
  void setAmount(double newAmount) {
    _amount = newAmount;
    if (_currentRate != null && !_currentRate!.isExpired) {
      final converted = _currentRate!.calculateToAmount(newAmount);
      emit(ExchangeHomeWithRate(
        supportedCurrencies: _supportedCurrencies,
        recentTransactions: _recentTransactions,
        rate: _currentRate,
        amount: newAmount,
        convertedAmount: converted,
      ));
      return;
    }
    // No rate cached — fetch one now in the background. The amount the
    // user just typed feeds the request so the converted value reflects
    // exactly what they entered.
    if (newAmount > 0) {
      fetchRateForHome(forAmount: newAmount);
    }
  }

  /// Fetch live exchange rate for the current pair and amount.
  Future<void> fetchRate({double? forAmount}) async {
    final amt = forAmount ?? _amount;

    final result = await _repository.getExchangeRate(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: amt > 0 ? amt : null,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (rate) {
        _currentRate = rate;
        final converted = rate.calculateToAmount(amt);
        emit(ExchangeRateLoaded(
          rate: rate,
          fromCurrency: _fromCurrency,
          toCurrency: _toCurrency,
          amount: amt,
          convertedAmount: converted,
          fees: rate.fees,
        ));
      },
    );
  }

  /// Fetch rate and emit as ExchangeHomeWithRate (for consolidated home screen).
  Future<void> fetchRateForHome({double? forAmount}) async {
    final amt = forAmount ?? _amount;

    final result = await _repository.getExchangeRate(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: amt > 0 ? amt : null,
    );
    if (isClosed) return;

    result.fold(
      (failure) {
        // Keep showing home data even if rate fetch fails
        emit(ExchangeHomeWithRate(
          supportedCurrencies: _supportedCurrencies,
          recentTransactions: _recentTransactions,
        ));
      },
      (rate) {
        _currentRate = rate;
        final converted = rate.calculateToAmount(amt);
        emit(ExchangeHomeWithRate(
          supportedCurrencies: _supportedCurrencies,
          recentTransactions: _recentTransactions,
          rate: rate,
          amount: amt,
          convertedAmount: converted,
        ));
      },
    );
  }

  /// Deprecated — the backend captures the fresh Flutterwave rate at the
  /// moment of the transfer, so the client no longer needs to validate rate
  /// staleness. Kept to avoid breaking callers; always returns true when a
  /// rate exists.
  @Deprecated('Rate staleness is enforced server-side; this is a no-op')
  bool checkRateValidity() => _currentRate != null;

  /// Execute a wallet-to-wallet currency conversion.
  Future<void> convertCurrency({
    required String verificationToken,
  }) async {
    // Always fetch a fresh rate before finalizing to ensure the user gets
    // the most accurate conversion. This prevents stale-rate surprises
    // on transactions that took a while to confirm (PIN entry, etc.).
    final freshRateResult = await _repository.getExchangeRate(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: _amount > 0 ? _amount : null,
      forceRefresh: true,
    );
    if (isClosed) return;

    final freshRate = freshRateResult.fold(
      (failure) => null,
      (rate) => rate,
    );

    if (freshRate != null) {
      _currentRate = freshRate;
    } else if (_currentRate == null || _currentRate!.isExpired) {
      emit(const ExchangeError('No exchange rate available. Please refresh.'));
      return;
    }

    final idempotencyKey = const Uuid().v4();

    final result = await _repository.convertCurrency(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: _amount,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
      rateId: _currentRate!.rateId,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (transaction) {
        // Sync mode (the default for conversion) returns the tx already
        // terminal — emit success immediately so the host screen jumps
        // to the receipt. Async mode returns processing; emit
        // ExchangeProcessing AND auto-subscribe to the WS so the inline
        // processing sheet on the host screen flips to ExchangeSuccess
        // when the backend pushes the terminal event.
        final st = transaction.statusString.toLowerCase();
        final terminal = transaction.isCompleted ||
            transaction.isFailed ||
            st == 'cancelled';
        if (terminal) {
          emit(ExchangeSuccess(transaction: transaction));
        } else {
          emit(ExchangeProcessing(
            transactionId: transaction.id,
            isConversion: true,
          ));
          subscribeToTransactionStatus(transaction.id);
        }
      },
    );
  }

  /// Initiate an international transfer.
  Future<void> initiateTransfer({
    required String verificationToken,
    required String recipientName,
    required String recipientAccountNumber,
    required String recipientBankName,
    String? recipientBankCode,
    String? recipientSwiftCode,
    required String recipientCountry,
    String? recipientEmail,
    String? purposeOfPayment,
    String? recipientRoutingNumber,
    String? recipientAddress,
    // "individual" or "business" — carried end-to-end to Flutterwave
    // meta.beneficiary_type. Null falls back to individual semantics.
    String? beneficiaryType,
    /// Recipient inputs that only SOME payout rails require, keyed by the
    /// field name the active rail publishes (dots included, e.g.
    /// "beneficiary.transitNumber"). Collected from
    /// GET /v1/exchange/transfer-requirements — never hardcoded, because the
    /// set changes per provider and per corridor without an app release.
    Map<String, String>? providerFields,
  }) async {
    // Always fetch a fresh rate before finalizing to protect the user
    // from stale rates that drifted during recipient entry / PIN flow.
    final freshRateResult = await _repository.getExchangeRate(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: _amount > 0 ? _amount : null,
      forceRefresh: true,
    );
    if (isClosed) return;

    final freshRate = freshRateResult.fold(
      (failure) => null,
      (rate) => rate,
    );

    if (freshRate != null) {
      _currentRate = freshRate;
    } else if (_currentRate == null || _currentRate!.isExpired) {
      emit(const ExchangeError('No exchange rate available. Please refresh.'));
      return;
    }

    final idempotencyKey = const Uuid().v4();

    final result = await _repository.initiateInternationalTransfer(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: _amount,
      recipientId: '',
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
      rateId: _currentRate!.rateId,
      purposeOfPayment: purposeOfPayment,
      recipientName: recipientName,
      recipientAccountNumber: recipientAccountNumber,
      recipientBankName: recipientBankName,
      recipientBankCode: recipientBankCode,
      recipientSwiftCode: recipientSwiftCode,
      recipientCountry: recipientCountry,
      recipientEmail: recipientEmail,
      recipientRoutingNumber: recipientRoutingNumber,
      recipientAddress: recipientAddress,
      beneficiaryType: beneficiaryType,
          providerFields: providerFields,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (transaction) {
        // Same pattern as convertCurrency: terminal RPC response goes
        // straight to receipt; only `processing` keeps the inline
        // processing sheet open until the WS pushes terminal.
        final st = transaction.statusString.toLowerCase();
        final terminal = transaction.isCompleted ||
            transaction.isFailed ||
            st == 'cancelled';
        if (terminal) {
          emit(ExchangeSuccess(transaction: transaction));
        } else {
          emit(ExchangeProcessing(
            transactionId: transaction.id,
            isConversion: false,
          ));
          subscribeToTransactionStatus(transaction.id);
        }
      },
    );
  }

  /// Subscribe to the exchange WebSocket for this transaction. Called
  /// by the processing screen in initState. On terminal event we fetch
  /// the full transaction via RPC (the WS only carries the minimal
  /// event, not the full receipt payload) then emit ExchangeSuccess.
  ///
  /// No timers, no hardcoded delays — purely event-driven. If the WS
  /// is down the connection helper retries with exponential backoff
  /// internally; an extended outage surfaces as a connection error
  /// that lets the user pull-to-refresh.
  void subscribeToTransactionStatus(String transactionId) {
    if (transactionId.isEmpty) {
      emit(const ExchangeError('Missing transaction id — cannot subscribe.'));
      return;
    }
    _cancelWsSub();
    _activeWsTxId = transactionId;
    // Belt-and-suspenders: start the bounded RPC poll alongside the WS so
    // completion is observed even when the WS never delivers (no webhook
    // in local/dev, dropped socket, etc.).
    _startPollFallback(transactionId);

    _wsSub = _wsService.events.listen((event) async {
      if (isClosed || _activeWsTxId != transactionId) return;
      if (event.transactionId != transactionId) return;
      if (!event.terminal) return;

      // Terminal event arrived. Fetch the full transaction so the
      // receipt has every backend-authoritative field. If the fetch
      // fails (rare — network blip), surface the error to the UI
      // rather than fabricate a stub transaction; the user can
      // pull-to-refresh on the processing screen to retry.
      final result = await _repository.getTransactionStatus(
        transactionId: transactionId,
      );
      if (isClosed) return;
      result.fold(
        (failure) => emit(ExchangeError(
          'Could not load receipt: ${failure.message}. Pull to refresh.',
        )),
        (tx) {
          _activeWsTxId = null;
          emit(ExchangeSuccess(transaction: tx));
        },
      );
    });

    // Tell the WS service to connect/subscribe for this user. Safe
    // to call repeatedly — service maintains a single shared socket.
    _wsService.ensureConnected();
  }

  /// Manual fetch for pull-to-refresh on the processing screen — if the
  /// user suspects the WS dropped an event, they can force an RPC
  /// reconcile. Still no polling loop; this fires exactly once per pull.
  Future<void> refreshTransactionStatus() async {
    final txId = _activeWsTxId;
    if (txId == null) return;
    final result = await _repository.getTransactionStatus(
      transactionId: txId,
    );
    if (isClosed) return;
    result.fold(
      (_) {/* transient — leave state as-is */},
      (tx) {
        final st = tx.statusString.toLowerCase();
        if (tx.isCompleted || tx.isFailed || st == 'cancelled') {
          _activeWsTxId = null;
          emit(ExchangeSuccess(transaction: tx));
        }
      },
    );
  }

  /// Bounded RPC poll that runs alongside the WS subscription. Fires
  /// GetTransactionStatus every [_pollInterval] until it sees a terminal
  /// status (then emits ExchangeSuccess) or hits [_pollMaxTicks]. Cancels
  /// itself the moment the WS delivers first — both paths clear
  /// [_activeWsTxId], and this guards on it every tick.
  void _startPollFallback(String transactionId) {
    _pollTimer?.cancel();
    _pollTick = 0;
    _pollTimer = Timer.periodic(_pollInterval, (timer) async {
      if (isClosed || _activeWsTxId != transactionId) {
        timer.cancel();
        return;
      }
      _pollTick++;
      if (_pollTick > _pollMaxTicks) {
        timer.cancel();
        return;
      }
      final result =
          await _repository.getTransactionStatus(transactionId: transactionId);
      if (isClosed || _activeWsTxId != transactionId) {
        timer.cancel();
        return;
      }
      result.fold(
        (_) {/* transient network blip — keep polling */},
        (tx) {
          final st = tx.statusString.toLowerCase();
          if (tx.isCompleted || tx.isFailed || st == 'cancelled') {
            timer.cancel();
            _activeWsTxId = null;
            emit(ExchangeSuccess(transaction: tx));
          }
        },
      );
    });
  }

  void _cancelWsSub() {
    _wsSub?.cancel();
    _wsSub = null;
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  /// Load exchange history. Fetches all transactions; UI tabs handle type filtering.
  Future<void> loadHistory({int limit = 50}) async {
    emit(ExchangeLoading());

    final result = await _repository.getRecentExchanges(limit: limit);
    if (isClosed) return;

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (transactions) {
        emit(ExchangeHistoryLoaded(
          transactions: transactions,
          hasMore: transactions.length >= limit,
        ));
      },
    );
  }

  /// Load supported currencies.
  Future<void> loadCurrencies() async {
    emit(ExchangeLoading());

    final result = await _repository.getSupportedCurrencies();
    if (isClosed) return;

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (currencies) {
        _supportedCurrencies = currencies;
        emit(ExchangeCurrenciesLoaded(currencies: currencies));
      },
    );
  }

  /// Restore the home screen state from cached data.
  /// Used after errors in PIN flow to prevent BlocConsumer from showing
  /// the error screen while the PIN modal is still active.
  void restoreHomeState() {
    emit(ExchangeHomeWithRate(
      supportedCurrencies: _supportedCurrencies,
      recentTransactions: _recentTransactions,
      rate: _currentRate,
      amount: _amount,
      convertedAmount: _currentRate?.calculateToAmount(_amount) ?? 0,
    ));
  }

  @override
  Future<void> close() {
    _cancelWsSub();
    return super.close();
  }
}
