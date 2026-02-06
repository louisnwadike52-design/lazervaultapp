/// Shared currency formatting utilities
/// Provides currency symbol conversion and formatted amount display
library;

import 'package:flutter/material.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';

/// Currency symbol mapping for all supported currencies
class CurrencySymbols {
  static const Map<String, String> symbols = {
    'USD': '\$',
    'GBP': '£',
    'EUR': '€',
    'NGN': '₦',
    'ZAR': 'R',
    'CAD': 'C\$',
    'AUD': 'A\$',
    'JPY': '¥',
    'INR': '₹',
    'KES': 'KSh',
    'GHS': 'GH₵',
  };

  /// Get currency symbol for a given currency code
  static String getSymbol(String currencyCode) {
    return symbols[currencyCode.toUpperCase()] ?? '\$';
  }

  /// Get the current user's currency symbol from LocaleManager
  static String get currentSymbol {
    final localeManager = serviceLocator<LocaleManager>();
    return getSymbol(localeManager.currentCurrency);
  }

  /// Get the current user's currency code from LocaleManager
  static String get currentCurrency {
    final localeManager = serviceLocator<LocaleManager>();
    return localeManager.currentCurrency;
  }

  /// Format amount with current currency symbol
  static String formatAmount(double amount) {
    final symbol = currentSymbol;
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  /// Format amount with a specific currency code
  static String formatAmountWithCurrency(double amount, String currencyCode) {
    final symbol = getSymbol(currencyCode);
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  /// Format amount with currency code (legacy format - e.g., "NGN 1000.00")
  static String formatAmountWithCode(double amount, String currencyCode) {
    return '$currencyCode ${amount.toStringAsFixed(2)}';
  }

  /// Stream of current currency symbol for reactive updates
  static Stream<String> get currencySymbolStream {
    final localeManager = serviceLocator<LocaleManager>();
    return localeManager.currencyStream.map((currency) => getSymbol(currency));
  }
}
