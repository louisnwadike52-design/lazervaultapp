import 'package:flutter/foundation.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/recipient_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';

class ExchangeProvider extends ChangeNotifier {
  final IExchangeRepository _repository;

  ExchangeProvider({required IExchangeRepository repository})
      : _repository = repository;

  // State
  Currency? _fromCurrency;
  Currency? _toCurrency;
  double _amount = 0.0;
  ExchangeRate? _currentRate;
  List<CurrencyTransaction> _recentTransactions = [];
  Recipient? _selectedRecipient;

  // UI State
  bool _isLoadingRate = false;
  bool _isSubmitting = false;
  String? _errorMessage;
  CurrencyTransaction? _lastTransaction;

  // Getters
  Currency? get fromCurrency => _fromCurrency;
  Currency? get toCurrency => _toCurrency;
  double get amount => _amount;
  ExchangeRate? get currentRate => _currentRate;
  List<CurrencyTransaction> get recentTransactions => _recentTransactions;
  Recipient? get selectedRecipient => _selectedRecipient;
  bool get isLoadingRate => _isLoadingRate;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;
  CurrencyTransaction? get lastTransaction => _lastTransaction;

  // Computed values
  double get convertedAmount {
    if (_currentRate == null || _amount == 0) return 0.0;
    return _currentRate!.calculateToAmount(_amount);
  }

  double get fees {
    if (_currentRate == null) return 0.0;
    return _currentRate!.fees;
  }

  double get totalCost {
    return _amount + fees;
  }

  bool get canSubmit {
    return _fromCurrency != null &&
        _toCurrency != null &&
        _amount > 0 &&
        _selectedRecipient != null &&
        _currentRate != null &&
        !_isSubmitting;
  }

  // Methods
  void setFromCurrency(Currency currency) {
    _fromCurrency = currency;
    _errorMessage = null;
    _refreshRate();
    notifyListeners();
  }

  void setToCurrency(Currency currency) {
    _toCurrency = currency;
    _errorMessage = null;
    _refreshRate();
    notifyListeners();
  }

  void swapCurrencies() {
    final temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;
    _errorMessage = null;
    _refreshRate();
    notifyListeners();
  }

  void setAmount(double amount) {
    _amount = amount;
    _errorMessage = null;
    _refreshRate();
    notifyListeners();
  }

  void setSelectedRecipient(Recipient? recipient) {
    _selectedRecipient = recipient;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _refreshRate() async {
    if (_fromCurrency == null || _toCurrency == null || _amount <= 0) {
      _currentRate = null;
      notifyListeners();
      return;
    }

    _isLoadingRate = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.getExchangeRate(
        fromCurrency: _fromCurrency!.code,
        toCurrency: _toCurrency!.code,
      );

      result.fold(
        (failure) {
          _errorMessage = failure.message;
          _currentRate = null;
        },
        (rate) {
          _currentRate = rate.copyWith(fees: _calculateFees(_amount));
        },
      );
    } catch (e) {
      _errorMessage = 'Failed to fetch exchange rate';
      _currentRate = null;
    } finally {
      _isLoadingRate = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecentTransactions() async {
    try {
      final result = await _repository.getRecentExchanges(limit: 20);

      result.fold(
        (failure) {
          _errorMessage = failure.message;
        },
        (transactions) {
          _recentTransactions = transactions;
        },
      );
    } catch (e) {
      _errorMessage = 'Failed to fetch recent transactions';
    } finally {
      notifyListeners();
    }
  }

  Future<bool> submitTransfer() async {
    if (!canSubmit) return false;

    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.initiateInternationalTransfer(
        fromCurrency: _fromCurrency!.code,
        toCurrency: _toCurrency!.code,
        amount: _amount,
        recipientId: _selectedRecipient!.id,
      );

      return result.fold(
        (failure) {
          _errorMessage = failure.message;
          _isSubmitting = false;
          notifyListeners();
          return false;
        },
        (transaction) {
          _lastTransaction = transaction;
          _isSubmitting = false;
          notifyListeners();
          return true;
        },
      );
    } catch (e) {
      _errorMessage = 'Failed to initiate transfer';
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _amount = 0.0;
    _currentRate = null;
    _selectedRecipient = null;
    _errorMessage = null;
    _lastTransaction = null;
    notifyListeners();
  }

  double _calculateFees(double amount) {
    // Simple fee calculation: 1% of amount with minimum $2 and maximum $50
    const feePercentage = 0.01;
    final fee = amount * feePercentage;
    const minFee = 2.0;
    const maxFee = 50.0;
    return fee.clamp(minFee, maxFee);
  }
}

extension on ExchangeRate {
  ExchangeRate copyWith({
    String? fromCurrency,
    String? toCurrency,
    double? rate,
    DateTime? timestamp,
    double? fees,
  }) {
    return ExchangeRate(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      rate: rate ?? this.rate,
      timestamp: timestamp ?? this.timestamp,
      fees: fees ?? this.fees,
    );
  }
}
