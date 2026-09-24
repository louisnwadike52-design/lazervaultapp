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

  /// Renders [amount] under [symbol], with the sign OUTSIDE the symbol.
  ///
  /// `NumberFormat` puts the minus where the digits are, so the naive
  /// `'$symbol${_money.format(v)}'` produces `₦-1,500.00`. The minus belongs to
  /// the quantity, not to the currency, and every other surface in the platform
  /// writes it `-₦1,500.00` — the same fix the family-notification formatter
  /// needed on the Go side.
  ///
  /// Non-finite values are caught here rather than rendered. `NumberFormat`
  /// happily returns "NaN" and "∞", and `₦NaN` on a balance is worse than a
  /// dash: it looks like a bug in the money rather than a missing figure. These
  /// arise from a division by a zero total — an empty analytics period, a
  /// portfolio with no holdings — which is ordinary, not exceptional.
  static String _render(double amount, String symbol) {
    if (amount.isNaN || amount.isInfinite) return '$symbol—';
    if (amount.isNegative) {
      // abs() first so the minus is placed by us, not by the pattern.
      return '-$symbol${_money.format(amount.abs())}';
    }
    return '$symbol${_money.format(amount)}';
  }

  /// Format amount with current currency symbol
  static String formatAmount(double amount) => _render(amount, currentSymbol);

  /// Format amount with a specific currency code
  static String formatAmountWithCurrency(double amount, String currencyCode) =>
      _render(amount, getSymbol(currencyCode));

  /// Stream of current currency symbol for reactive updates
  static Stream<String> get currencySymbolStream {
    final localeManager = serviceLocator<LocaleManager>();
    return localeManager.currencyStream.map((currency) => getSymbol(currency));
  }
}
