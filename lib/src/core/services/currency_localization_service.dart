import 'package:intl/intl.dart';

/// Currency Localization Service
class CurrencyLocalizationService {
  String _defaultCurrency = 'USD';

  void setDefaultCurrency(String currencyCode) {
    _defaultCurrency = currencyCode;
  }

  String formatAmount(
    double amount, {
    String? currencyCode,
    int? decimalDigits,
    bool showSymbol = true,
  }) {
    final currency = currencyCode ?? _defaultCurrency;
    final symbol = _getSymbol(currency);
    
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: showSymbol ? symbol : '',
      decimalDigits: decimalDigits ?? 2,
    );

    return formatter.format(amount);
  }

  String formatPercentage(
    double value, {
    int decimalDigits = 1,
    bool showSymbol = true,
  }) {
    final formatted = value.toStringAsFixed(decimalDigits);
    return showSymbol ? '$formatted%' : formatted;
  }

  String _getSymbol(String currencyCode) {
    final symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
    };
    return symbols[currencyCode] ?? '\$';
  }
}
