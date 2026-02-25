import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';

/// Filter options for exchange history.
enum ExchangeHistoryFilter {
  all,
  conversions,
  international,
  pending,
  completed,
  failed,
}

/// Whether the flow is a wallet-to-wallet conversion or international send.
enum ExchangeMode {
  convert,
  sendAbroad,
}

abstract class ExchangeState extends Equatable {
  const ExchangeState();

  @override
  List<Object?> get props => [];
}

class ExchangeInitial extends ExchangeState {}

class ExchangeLoading extends ExchangeState {}

class ExchangeError extends ExchangeState {
  final String message;

  const ExchangeError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Live exchange rate fetched for a currency pair.
class ExchangeRateLoaded extends ExchangeState {
  final ExchangeRate rate;
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double convertedAmount;
  final double fees;

  const ExchangeRateLoaded({
    required this.rate,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.convertedAmount,
    required this.fees,
  });

  ExchangeRateLoaded copyWith({
    ExchangeRate? rate,
    String? fromCurrency,
    String? toCurrency,
    double? amount,
    double? convertedAmount,
    double? fees,
  }) {
    return ExchangeRateLoaded(
      rate: rate ?? this.rate,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      fees: fees ?? this.fees,
    );
  }

  @override
  List<Object?> get props => [rate, fromCurrency, toCurrency, amount, convertedAmount, fees];
}

/// Rate has expired and needs refresh.
class ExchangeRateExpired extends ExchangeState {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  const ExchangeRateExpired({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  List<Object?> get props => [fromCurrency, toCurrency, amount];
}

/// Exchange or transfer is being processed.
class ExchangeProcessing extends ExchangeState {
  final String transactionId;
  final bool isConversion;

  const ExchangeProcessing({
    required this.transactionId,
    required this.isConversion,
  });

  @override
  List<Object?> get props => [transactionId, isConversion];
}

/// Exchange or transfer completed successfully.
class ExchangeSuccess extends ExchangeState {
  final CurrencyTransaction transaction;

  const ExchangeSuccess({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

/// Transaction status polled (processing screen).
class ExchangeStatusPolled extends ExchangeState {
  final CurrencyTransaction transaction;
  final int pollCount;

  const ExchangeStatusPolled({
    required this.transaction,
    required this.pollCount,
  });

  @override
  List<Object?> get props => [transaction, pollCount];
}

/// Exchange history loaded with filter and pagination.
class ExchangeHistoryLoaded extends ExchangeState {
  final List<CurrencyTransaction> transactions;
  final bool hasMore;
  final bool isStale;
  final ExchangeHistoryFilter filter;

  const ExchangeHistoryLoaded({
    required this.transactions,
    this.hasMore = false,
    this.isStale = false,
    this.filter = ExchangeHistoryFilter.all,
  });

  ExchangeHistoryLoaded copyWith({
    List<CurrencyTransaction>? transactions,
    bool? hasMore,
    bool? isStale,
    ExchangeHistoryFilter? filter,
  }) {
    return ExchangeHistoryLoaded(
      transactions: transactions ?? this.transactions,
      hasMore: hasMore ?? this.hasMore,
      isStale: isStale ?? this.isStale,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [transactions, hasMore, isStale, filter];
}

/// Supported currencies loaded (for pair selection screen).
class ExchangeCurrenciesLoaded extends ExchangeState {
  final List<SupportedCurrencyInfo> currencies;

  const ExchangeCurrenciesLoaded({required this.currencies});

  @override
  List<Object?> get props => [currencies];
}

/// Home screen loaded with currencies, recent transactions, AND live rate data.
/// Used by the consolidated landing page that shows everything inline.
class ExchangeHomeWithRate extends ExchangeState {
  final List<SupportedCurrencyInfo> supportedCurrencies;
  final List<CurrencyTransaction> recentTransactions;
  final ExchangeRate? rate;
  final double amount;
  final double convertedAmount;

  const ExchangeHomeWithRate({
    required this.supportedCurrencies,
    required this.recentTransactions,
    this.rate,
    this.amount = 0,
    this.convertedAmount = 0,
  });

  ExchangeHomeWithRate copyWith({
    List<SupportedCurrencyInfo>? supportedCurrencies,
    List<CurrencyTransaction>? recentTransactions,
    ExchangeRate? rate,
    double? amount,
    double? convertedAmount,
  }) {
    return ExchangeHomeWithRate(
      supportedCurrencies: supportedCurrencies ?? this.supportedCurrencies,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      rate: rate ?? this.rate,
      amount: amount ?? this.amount,
      convertedAmount: convertedAmount ?? this.convertedAmount,
    );
  }

  @override
  List<Object?> get props => [supportedCurrencies, recentTransactions, rate, amount, convertedAmount];
}
