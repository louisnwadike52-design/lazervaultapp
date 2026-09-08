import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_state.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

/// The rich receipt for one transaction, opened from history and from every
/// flow that reuses it (QR pay, batch items, …).
///
/// Live status: the screen refreshes once on open, supports pull-to-refresh,
/// and — ONLY while the freshest-known status is pending/processing — polls
/// with exponential backoff (5s → 10s → 20s → 40s → 60s, capped) for at most
/// 10 minutes. Terminal statuses never poll, so a million open receipts cost
/// the backend nothing; a stuck-pending one converges to one call a minute
/// and then goes quiet, with pull-to-refresh as the manual fallback.
class TransactionDetailScreen extends StatefulWidget {
  final UnifiedTransaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late final TransactionHistoryCubit _cubit;
  UnifiedTransaction? _latest;
  Timer? _pollTimer;
  int _pollDelaySeconds = 5;
  late final DateTime _pollingSince;

  static const _maxPollDelaySeconds = 60;
  static const _pollWindow = Duration(minutes: 10);

  @override
  void initState() {
    super.initState();
    _pollingSince = DateTime.now();
    _cubit = serviceLocator<TransactionHistoryCubit>()
      ..loadTransactionDetails(widget.transaction.id);
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _cubit.close();
    super.dispose();
  }

  bool _isLive(UnifiedTransaction tx) =>
      tx.status == UnifiedTransactionStatus.pending ||
      tx.status == UnifiedTransactionStatus.processing;

  void _maybeScheduleNextPoll(UnifiedTransaction tx) {
    _pollTimer?.cancel();
    if (!_isLive(tx)) return; // terminal — never poll
    if (DateTime.now().difference(_pollingSince) > _pollWindow) {
      return; // long-stuck: go quiet, pull-to-refresh remains
    }
    _pollTimer = Timer(Duration(seconds: _pollDelaySeconds), () {
      if (!mounted) return;
      _pollDelaySeconds =
          (_pollDelaySeconds * 2).clamp(5, _maxPollDelaySeconds);
      _cubit.loadTransactionDetails(widget.transaction.id);
    });
  }

  Future<void> _refresh() async {
    await _cubit.loadTransactionDetails(widget.transaction.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<TransactionHistoryCubit, TransactionHistoryState>(
        listener: (context, state) {
          if (state is TransactionDetailsLoaded) {
            _latest = state.transaction;
            _maybeScheduleNextPoll(state.transaction);
          }
        },
        builder: (context, state) {
          // Freshest data wins; while a refresh is in flight keep showing the
          // last known version instead of flashing back to the stale one.
          final tx = state is TransactionDetailsLoaded
              ? state.transaction
              : (_latest ?? widget.transaction);
          return UnifiedTransactionReceipt(
            transaction: tx,
            fromHistory: true,
            onRefresh: _refresh,
          );
        },
      ),
    );
  }
}
