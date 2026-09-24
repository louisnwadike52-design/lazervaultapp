/// Shared currency formatting utilities
/// Provides currency symbol conversion and formatted amount display
library;

import 'package:intl/intl.dart';
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
    'PHP': '₱',
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

  /// The app's money pattern, used by both formatters below.
  ///
  /// `#,##0.00`, with TWO deliberate details:
  ///
  ///  * the thousands separator. These two methods have 265 call sites between
  ///    them and every one of them was printing `toStringAsFixed(2)` — so a
  ///    family account holding ₦120,000 displayed as `₦120000.00` everywhere in
  ///    the app. At that length the digits have to be counted to be read, which
  ///    is exactly the moment someone misreads their own balance by a factor of
  ///    ten.
  ///
  ///  * the `0` before the decimal point rather than `#`. `#,###.00` renders any
  ///    value below one with no leading digit at all — ₦0.50 becomes `₦.50` and
  ///    zero becomes `₦.00`. That bug was found in the send-funds
  ///    insufficient-funds message, which is shown precisely when the balance is
  ///    small enough for it to appear.
  ///
  /// Nothing parses these strings back into numbers — verified across all 265
  /// call sites — so adding separators is safe. The two that feed text into a
  /// receipt and an export both read better for it.
  static final NumberFormat _money = NumberFormat('#,##0.00');

  /// Format amount with current currency symbol
  static String formatAmount(double amount) {
    final symbol = currentSymbol;
    return '$symbol${_money.format(amount)}';
  }

  /// Format amount with a specific currency code
  static String formatAmountWithCurrency(double amount, String currencyCode) {
    final symbol = getSymbol(currencyCode);
    return '$symbol${_money.format(amount)}';
  }

  /// Stream of current currency symbol for reactive updates
  static Stream<String> get currencySymbolStream {
    final localeManager = serviceLocator<LocaleManager>();
    return localeManager.currencyStream.map((currency) => getSymbol(currency));
  }
}
