import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/recipient_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final IExchangeRepository _repository;

  ExchangeCubit({
    required IExchangeRepository repository,
  })  : _repository = repository,
        super(ExchangeInitial());

  Timer? _pollTimer;
  int _pollCount = 0;
  static const int _maxPollAttempts = 20;
  static const Duration _pollInterval = Duration(seconds: 2);

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

  /// Check if the current rate is still valid. If expired, emit expired state.
  bool checkRateValidity() {
    if (_currentRate == null || _currentRate!.isExpired) {
      emit(ExchangeRateExpired(
        fromCurrency: _fromCurrency,
        toCurrency: _toCurrency,
        amount: _amount,
      ));
      return false;
    }
    return true;
  }

  /// Execute a wallet-to-wallet currency conversion.
  Future<void> convertCurrency({
    required String verificationToken,
  }) async {
    // Fetch fresh rate immediately before executing to avoid stale rates
    final freshRateResult = await _repository.getExchangeRate(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: _amount > 0 ? _amount : null,
    );

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

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (transaction) {
        if (transaction.isCompleted) {
          emit(ExchangeSuccess(transaction: transaction));
        } else {
          emit(ExchangeProcessing(
            transactionId: transaction.id,
            isConversion: true,
          ));
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
  }) async {
    // Fetch fresh rate immediately before executing to avoid stale rates
    final freshRateResult = await _repository.getExchangeRate(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: _amount > 0 ? _amount : null,
    );

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
    );

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (transaction) {
        if (transaction.isCompleted) {
          emit(ExchangeSuccess(transaction: transaction));
        } else {
          emit(ExchangeProcessing(
            transactionId: transaction.id,
            isConversion: false,
          ));
        }
      },
    );
  }

  /// Poll transaction status until completed/failed or max attempts.
  void pollTransactionStatus(String transactionId) {
    _pollCount = 0;
    _pollTimer?.cancel();

    _pollTimer = Timer.periodic(_pollInterval, (timer) async {
      _pollCount++;

      if (_pollCount > _maxPollAttempts) {
        timer.cancel();
        // Emit last known state — transaction may still be processing
        final result = await _repository.getTransactionStatus(
          transactionId: transactionId,
        );
        result.fold(
          (failure) => emit(ExchangeError(
            'Transfer is still processing. Check your exchange history for updates.',
          )),
          (tx) {
            if (tx.isCompleted || tx.isFailed) {
              emit(ExchangeSuccess(transaction: tx));
            } else {
              emit(ExchangeError(
                'Transfer is still processing. Check your exchange history for updates.',
              ));
            }
          },
        );
        return;
      }

      final result = await _repository.getTransactionStatus(
        transactionId: transactionId,
      );

      result.fold(
        (failure) {
          // Don't stop polling on transient errors
          emit(ExchangeStatusPolled(
            transaction: CurrencyTransaction(
              id: transactionId,
              fromCurrency: _fromCurrency,
              toCurrency: _toCurrency,
              fromAmount: _amount,
              toAmount: 0,
              exchangeRate: 0,
              fees: 0,
              totalCost: 0,
              recipient: Recipient(
                id: '', name: '', email: '', accountNumber: '',
                bankName: '', countryCode: '', currency: '',
                createdAt: DateTime.now(),
              ),
              status: TransactionStatus.processing,
              createdAt: DateTime.now(),
            ),
            pollCount: _pollCount,
          ));
        },
        (transaction) {
          if (transaction.isCompleted || transaction.isFailed) {
            timer.cancel();
            emit(ExchangeSuccess(transaction: transaction));
          } else {
            emit(ExchangeStatusPolled(
              transaction: transaction,
              pollCount: _pollCount,
            ));
          }
        },
      );
    });
  }

  /// Load exchange history with optional filter.
  Future<void> loadHistory({
    ExchangeHistoryFilter filter = ExchangeHistoryFilter.all,
    int limit = 20,
  }) async {
    emit(ExchangeLoading());

    final result = await _repository.getRecentExchanges(limit: limit);

    result.fold(
      (failure) => emit(ExchangeError(failure.message)),
      (transactions) {
        final filtered = _applyFilter(transactions, filter);
        emit(ExchangeHistoryLoaded(
          transactions: filtered,
          hasMore: transactions.length >= limit,
          filter: filter,
        ));
      },
    );
  }

  /// Load supported currencies.
  Future<void> loadCurrencies() async {
    emit(ExchangeLoading());

    final result = await _repository.getSupportedCurrencies();

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

  List<CurrencyTransaction> _applyFilter(
    List<CurrencyTransaction> transactions,
    ExchangeHistoryFilter filter,
  ) {
    switch (filter) {
      case ExchangeHistoryFilter.all:
        return transactions;
      case ExchangeHistoryFilter.conversions:
        return transactions.where((t) => t.type == TransactionType.exchange).toList();
      case ExchangeHistoryFilter.international:
        return transactions.where((t) => t.type == TransactionType.send).toList();
      case ExchangeHistoryFilter.pending:
        return transactions.where((t) => t.isPending || t.isProcessing).toList();
      case ExchangeHistoryFilter.completed:
        return transactions.where((t) => t.isCompleted).toList();
      case ExchangeHistoryFilter.failed:
        return transactions.where((t) => t.isFailed).toList();
    }
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
