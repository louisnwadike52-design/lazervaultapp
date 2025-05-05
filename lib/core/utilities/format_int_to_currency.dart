import 'package:intl/intl.dart';

String formatIntToCurrency(
    {required num amount,
    String locale = 'en-GB',
    String symbol = '£',
    bool isCompact = false}) {
  return !isCompact
      ? NumberFormat.currency(
          locale: locale,
          symbol: symbol,
          decimalDigits: 2,
        ).format(amount)
      : NumberFormat.compactCurrency(
          locale: locale,
          symbol: symbol,
          decimalDigits: 2,
        ).format(amount);
}
