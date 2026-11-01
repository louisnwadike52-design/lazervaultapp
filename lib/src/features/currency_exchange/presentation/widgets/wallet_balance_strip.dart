import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../data/services/exchange_wallet_balances.dart';
import '../theme/exchange_theme.dart';

/// What the user actually holds in the two currencies they are exchanging
/// between.
///
/// The screen asked for an amount with no indication of what was available,
/// so the only way to discover the limit was to type a number and be refused
/// — after picking currencies, after a rate call, and on the step that asks
/// for a PIN. The target side matters too: it is the account the money lands
/// in, and seeing it is how a conversion reads as moving your own money
/// rather than sending it somewhere.
class WalletBalanceStrip extends StatelessWidget {
  const WalletBalanceStrip({
    super.key,
    required this.balances,
    required this.fromCurrency,
    required this.toCurrency,
    this.loading = false,
  });

  final ExchangeWalletBalances balances;
  final String fromCurrency;
  final String toCurrency;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _BalanceCell(
            label: 'Your $fromCurrency balance',
            currency: fromCurrency,
            balances: balances,
            loading: loading,
            alignEnd: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _BalanceCell(
            label: 'Your $toCurrency balance',
            currency: toCurrency,
            balances: balances,
            loading: loading,
            alignEnd: true,
          ),
        ),
      ],
    );
  }
}

class _BalanceCell extends StatelessWidget {
  const _BalanceCell({
    required this.label,
    required this.currency,
    required this.balances,
    required this.loading,
    required this.alignEnd,
  });

  final String label;
  final String currency;
  final ExchangeWalletBalances balances;
  final bool loading;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final minor = balances.minorFor(currency);
    // No account in this currency is NOT zero — one means "you cannot fund
    // from here", the other means "this wallet is empty". A dash says the
    // honest thing while the balances are still loading, too.
    final value = loading
        ? '—'
        : (minor == null
            ? 'No $currency wallet yet'
            : CurrencySymbols.formatAmountWithCurrency(
                minor / 100.0, currency));

    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: minor == null && !loading
                ? const Color(0xFF9CA3AF)
                : ExchangeTheme.primary,
          ),
        ),
      ],
    );
  }
}
