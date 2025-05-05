import 'package:intl/intl.dart';

String generateCurrencyString(
    {required num amount,
    String locale = 'en-us',
    symbol = '\$',
    isCompact = false}) {
  return !isCompact
      ? NumberFormat.currency(
          locale: locale,
          symbol: '\$',
          decimalDigits: 2,
        ).format(amount)
      : NumberFormat.compactCurrency(
          locale: locale,
          symbol: '\$',
          decimalDigits: 2,
        ).format(amount);
}
