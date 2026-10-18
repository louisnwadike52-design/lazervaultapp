library;

import 'package:intl/intl.dart';

/// THE MIN LINE LOOKED LIKE A SECOND, WORSE EXCHANGE RATE.
///
/// The buy sheet already states the rate at the top — "1 USDT ≈ 1,379 NGN".
/// The limits caption underneath then printed the minimum in BOTH units:
///
///     Min 1.02 USDT (≈₦1403) · Max ≈37.677021 USDT
///
/// and ₦1403 ÷ 1.02 is ₦1,375, not ₦1,379. Both figures are individually
/// right — the fiat minimum carries a 2% deliverability pad and each half is
/// rounded for display — but side by side they read as a conversion, and a
/// conversion that disagrees with the headline rate is simply a wrong number
/// to the person reading it. No arithmetic fixes that: two rounded numbers in
/// different units will keep failing to divide into the quoted rate.
///
/// So the caption no longer converts. The rate is stated once, at the top;
/// below it there is only Min and Max, in the unit being typed. Nothing on
/// the line invites the reader to divide it by anything.
///
/// Kept as plain functions over plain values so the figures a person checks
/// their money against are testable without the sheet.

/// Crypto amounts: enough precision to be exact, not so much that the line
/// overflows. "37.677021 USDT" was a real value on a ₦52k wallet and it is
/// what pushed the caption off-screen.
String formatCryptoLimit(double v) {
  if (v <= 0) return '0';
  // Small balances need the decimals; large ones do not.
  final decimals = v >= 1000
      ? 0
      : v >= 1
          ? 2
          : 6;
  var s = v.toStringAsFixed(decimals);
  if (s.contains('.')) {
    s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
  return s;
}

/// Fiat amounts, grouped the way the rest of the sheet groups them — the old
/// `toStringAsFixed(0)` printed "₦1403" next to a header reading "1,379".
String formatFiatLimit(double v) => NumberFormat('#,##0').format(v);

/// The caption under the amount field: Min and Max, nothing else.
///
/// [insufficientBalance] replaces Max with [blockedLabel] — showing
/// "Min ₦3,451 · Max ₦2,837" is a contradiction, not a limit. The sell sheet
/// has the same caption with its own wording ("Holding too small to sell"),
/// and had the same cross-rate parenthetical.
String buyLimitsCaption({
  required bool amountInCrypto,
  required double minFiat,
  required double minCrypto,
  required double maxFiat,
  required double maxCrypto,
  required bool insufficientBalance,
  required String fiatSymbol,
  required String ticker,
  String blockedLabel = 'Insufficient balance',
}) {
  final parts = <String>[];
  if (amountInCrypto) {
    if (minCrypto > 0) parts.add('Min ${formatCryptoLimit(minCrypto)} $ticker');
    if (insufficientBalance) {
      parts.add(blockedLabel);
    } else if (maxCrypto > 0) {
      parts.add('Max ${formatCryptoLimit(maxCrypto)} $ticker');
    }
  } else {
    if (minFiat > 0) parts.add('Min $fiatSymbol${formatFiatLimit(minFiat)}');
    if (insufficientBalance) {
      parts.add(blockedLabel);
    } else if (maxFiat > 0) {
      parts.add('Max $fiatSymbol${formatFiatLimit(maxFiat)}');
    }
  }
  return parts.join(' · ');
}
