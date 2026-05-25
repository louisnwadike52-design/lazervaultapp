import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';

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
  final VoidCallback? onCommitted;
  final VoidCallback? onCancelled;

  const QuoteTimerCard({
    super.key,
    this.refreshGraceSeconds = 2.0,
    this.onCommitted,
    this.onCancelled,
  });

  @override
  State<QuoteTimerCard> createState() => _QuoteTimerCardState();
}

class _QuoteTimerCardState extends State<QuoteTimerCard> {
  Timer? _ticker;
  bool _refreshFired = false;

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
    return BlocConsumer<CryptoCubit, CryptoState>(
      listenWhen: (a, b) =>
          b is SwapPending || b is SwapCompleted || b is SwapFailed,
      listener: (context, state) {
        if (state is SwapPending || state is SwapCompleted) {
          widget.onCommitted?.call();
        } else if (state is SwapFailed) {
          widget.onCancelled?.call();
        }
      },
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
                if (state.spreadBps > 0)
                  _buildSummaryRow(
                    'Platform fee',
                    '${(state.spreadBps / 100).toStringAsFixed(2)}%',
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
                        onPressed: secondsLeft <= 0
                            ? null
                            : () => context.read<CryptoCubit>().confirmSwapQuote(),
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
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              value: fraction,
              strokeWidth: 4,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(
                fraction > 0.3 ? const Color(0xFF10B981) : const Color(0xFFFB923C),
              ),
            ),
          ),
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
Future<void> showQuoteTimerSheet(BuildContext context) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) {
      return BlocProvider.value(
        value: context.read<CryptoCubit>(),
        child: QuoteTimerCard(
          onCommitted: () {
            if (Navigator.canPop(sheetCtx)) Navigator.of(sheetCtx).pop();
          },
          onCancelled: () {
            if (Navigator.canPop(sheetCtx)) Navigator.of(sheetCtx).pop();
          },
        ),
      );
    },
  );
}
