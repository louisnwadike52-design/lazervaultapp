import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// QuoteTimerCard renders a 15-second countdown for the active Quidax swap
/// quotation. When the timer hits `refreshGraceSeconds` (default 2s) before
/// `expiresAt`, it fires CryptoCubit.refreshSwapQuote(). The Confirm button
/// commits the trade via CryptoCubit.confirmSwapQuote().
///
/// Designed to render as a modal bottom sheet from buy_crypto_screen.dart and
/// sell_crypto_screen.dart. Pops itself when the cubit transitions to
/// SwapPending / SwapCompleted / SwapFailed.
class QuoteTimerCard extends StatefulWidget {
  final double refreshGraceSeconds;
  final VoidCallback? onCancelled;

  /// Called when the user taps Confirm. When provided, the trade is NOT
  /// committed directly here — instead this runs the tx-PIN sheet (whose own
  /// processing phase runs confirmSwapQuote) and, when it returns, the parent
  /// [showQuoteTimerSheet] pops this sheet. When null, Confirm commits directly
  /// (legacy behaviour). We deliberately do NOT auto-pop on the swap state
  /// transition: the PIN sheet stacks above this one during confirm and a
  /// state-driven pop would close the PIN sheet mid-processing.
  final Future<void> Function()? onConfirm;

  const QuoteTimerCard({
    super.key,
    this.refreshGraceSeconds = 2.0,
    this.onCancelled,
    this.onConfirm,
  });

  @override
  State<QuoteTimerCard> createState() => _QuoteTimerCardState();
}

class _QuoteTimerCardState extends State<QuoteTimerCard> {
  Timer? _ticker;
  bool _refreshFired = false;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _startTicker();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _startTicker() {
    _ticker?.cancel();
    _refreshFired = false;
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) return;
      final state = context.read<CryptoCubit>().state;
      if (state is! SwapQuotePending) return;
      final remaining = state.expiresAt.difference(DateTime.now().toUtc());
      if (remaining.inMilliseconds <= (widget.refreshGraceSeconds * 1000).toInt() && !_refreshFired) {
        _refreshFired = true;
        context.read<CryptoCubit>().refreshSwapQuote();
      }
      setState(() {}); // re-render the ring
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoCubit, CryptoState>(
      buildWhen: (a, b) => b is SwapQuotePending || a is SwapQuotePending,
      builder: (context, state) {
        if (state is! SwapQuotePending) {
          return const SizedBox.shrink();
        }
        // restart ticker on new quote (refresh path) so the ring resets cleanly
        if (_refreshFired &&
            state.expiresAt.difference(DateTime.now().toUtc()).inMilliseconds >
                ((widget.refreshGraceSeconds * 1000).toInt() + 1000)) {
          _refreshFired = false;
        }
        final remaining = state.expiresAt.difference(DateTime.now().toUtc());
        final secondsLeft = remaining.inMilliseconds.clamp(0, 60000) / 1000.0;
        final fraction = (secondsLeft / 15.0).clamp(0.0, 1.0);

        return Material(
          color: const Color(0xFF0A0A0A),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Confirm Trade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildCountdownRing(fraction, secondsLeft),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSummaryRow('You pay',
                    '${state.fromAmount} ${state.fromCurrency.toUpperCase()}'),
                _buildSummaryRow('You receive',
                    '${state.toAmount} ${state.toCurrency.toUpperCase()}'),
                _buildSummaryRow('Rate', state.quotedPrice),
                // Transaction fee — the ONE aggregated fee the user pays. Quidax's
                // own trading fee is baked into the quoted rate (already reflected
                // in "You receive"), so the only added, user-facing charge is our
                // platform fee (the spread). Show it as a concrete AMOUNT in the
                // pay currency + the %, so the user sees exactly what they're
                // charged before confirming — never a silent fee.
                _buildSummaryRow(
                  'Transaction fee',
                  state.spreadBps > 0
                      ? '${_feeAmountStr(state)} ${state.fromCurrency.toUpperCase()}'
                          ' (${(state.spreadBps / 100).toStringAsFixed(2)}%)'
                      : 'Free',
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          widget.onCancelled?.call();
                          Navigator.of(context).maybePop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (secondsLeft <= 0 || _submitting)
                            ? null
                            : () {
                                if (widget.onConfirm != null) {
                                  // Quote-first flow: run the tx-PIN step, whose
                                  // processing phase finalizes via
                                  // confirmSwapQuote(token). Guard against a
                                  // double-tap; showQuoteTimerSheet pops this
                                  // sheet when onConfirm returns.
                                  setState(() => _submitting = true);
                                  widget.onConfirm!();
                                } else {
                                  context.read<CryptoCubit>().confirmSwapQuote();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  secondsLeft <= 0
                      ? 'Quote expired. Refreshing...'
                      : 'Rate locked for ${secondsLeft.toStringAsFixed(1)}s',
                  style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCountdownRing(double fraction, double secondsLeft) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          LazerVaultLoader(size: 56),
          Text(
            secondsLeft.ceil().toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Platform fee as a concrete amount in the FROM (pay) currency, derived from
  /// the authoritative spread bps against the pay amount so it stays consistent
  /// with the % shown. 2dp when >= 1 (fiat buys); more precision for a small
  /// crypto pay leg so a tiny fee never reads as 0.00.
  String _feeAmountStr(SwapQuotePending state) {
    final from = double.tryParse(state.fromAmount) ?? 0;
    final fee = from * state.spreadBps / 10000.0;
    return fee >= 1 ? fee.toStringAsFixed(2) : fee.toStringAsFixed(6);
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF))),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper to present the timer card as a modal bottom sheet from a Buy/Sell
/// screen. Pops the sheet when the trade transitions out of SwapQuotePending.
Future<void> showQuoteTimerSheet(
  BuildContext context, {
  // The DEDICATED swap cubit (not the shared asset-list one) — the quote card +
  // its state transitions must live on the isolated instance the dispatcher owns.
  required CryptoCubit cubit,
  Future<void> Function()? onConfirm,
}) async {
  // True only while the Confirm→PIN→confirm chain is running (the PIN sheet is
  // stacked above this one). Used to suppress the auto-pop below so we never
  // close the PIN sheet mid-processing.
  var confirmInFlight = false;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<CryptoCubit, CryptoState>(
          // Auto-pop when the trade leaves SwapQuotePending WITHOUT a confirm in
          // flight — e.g. the 15s auto-refresh RPC threw → SwapFailed, which would
          // otherwise render the card blank and hang the whole flow forever (the
          // caller's await never returns, the Buy/Sell button spins indefinitely).
          // During a confirm the PIN sheet is stacked above, so the confirm path
          // owns the pop instead.
          listenWhen: (a, b) => b is! SwapQuotePending,
          listener: (ctx, state) {
            if (!confirmInFlight &&
                sheetCtx.mounted &&
                Navigator.canPop(sheetCtx)) {
              Navigator.of(sheetCtx).pop();
            }
          },
          child: QuoteTimerCard(
            // Confirm runs the tx-PIN + trade confirmation (the PIN sheet's own
            // processing phase), THEN we pop this quote sheet so the caller
            // navigates to the receipt on a clean stack.
            onConfirm: onConfirm == null
                ? null
                : () async {
                    confirmInFlight = true;
                    try {
                      await onConfirm();
                    } finally {
                      confirmInFlight = false;
                    }
                    if (sheetCtx.mounted && Navigator.canPop(sheetCtx)) {
                      Navigator.of(sheetCtx).pop();
                    }
                  },
            onCancelled: () {
              if (Navigator.canPop(sheetCtx)) Navigator.of(sheetCtx).pop();
            },
          ),
        ),
      );
    },
  );
}
