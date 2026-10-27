import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/data/errors/banking_errors.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';

/// Map a FAILED linked-bank balance refresh to short, user-friendly, category-
/// specific copy. Shared by the fee-gated tx-PIN sheet's `failureMessageBuilder` on
/// every refresh surface (deposit, withdrawal, LazerBeam, AI stats, Linked
/// Banks) so a failed refresh reads the same everywhere — and NEVER as
/// "balance refreshed". The error is the exception thrown out of
/// `OpenBankingCubit.refreshBalance(rethrowOnError: true)`.
String linkedBalanceRefreshFailureMessage(Object error) {
  if (error is ReauthorizationRequiredException) {
    return 'Couldn’t refresh, please re-link your bank account.';
  }
  final s = error.toString().toLowerCase();
  if (s.contains('insufficient')) {
    return 'Insufficient balance to cover the refresh fee.';
  }
  if (s.contains('unavailable') ||
      s.contains('timeout') ||
      s.contains('deadline') ||
      s.contains('network')) {
    return 'Couldn’t refresh right now. Please try again.';
  }
  return 'Balance refresh failed. Please try again.';
}

/// How one tap on a refresh icon ended. Callers rarely need it — the icon
/// state and the sheet already told the user — but a flow that wants to act
/// (re-link on failure, say) can.
enum LinkedRefreshOutcome {
  /// A fresh balance is in the cubit.
  refreshed,

  /// The person closed the fee sheet, or never got a PIN set up.
  cancelled,

  /// The live read, or the fee quote, failed. The user has been told.
  failed,

  /// A refresh for this account was already in flight. Nothing was started.
  alreadyRunning,
}

/// ONE shared per-account linked-bank balance refresh, consumed by the deposit,
/// withdrawal, Move Money, Linked Banks and Statistics surfaces. Because it
/// drives the GetIt-singleton [OpenBankingCubit] — mutating the single
/// `_linkedAccounts` cache and emitting `BalanceRefreshed(accountId)` — a
/// refresh triggered on ANY screen reflects on every screen listening.
///
/// Money-safety: a live Mono balance read is billed per account, so a refresh is:
///   - keyed to ONE `account.id` (never a fan-out over all banks),
///   - gated behind a fee tx-PIN sheet when a refresh fee applies (fee shown first),
///   - a no-op charge when the fee is 0,
///   - never started twice for the same account while one is in flight.
///
/// ## The icon must say something from the first tap
///
/// The fee QUOTE is a round trip, and on a slow uplink it is seconds. Before
/// this, nothing changed on screen between the tap and the sheet appearing, so
/// people tapped again — and a second quote, a second sheet, and in the free
/// case a second billed read, were all possible. [linkedRefreshPending] holds
/// the account ids with a refresh in flight from the moment of the tap to the
/// moment the sheet is gone (or the free read has landed); every refresh icon
/// renders a small spinner, disabled, while its account is in it.
///
/// ## Where the navigator ends up
///
/// The PIN sheet pops itself on success, and on cancel or failure pops every
/// popup down to the page — unless [preserveHostSheet] is passed, in which
/// case only down to the caller's route. A refresh icon that lives INSIDE a
/// bottom sheet (an account picker) must pass `preserveHostSheet: true`, or a
/// cancelled fee sheet silently closes the picker as well and the person is
/// dropped back on the page wondering what happened. One that lives on the
/// page itself must not, or a cancelled sheet would leave a stale sheet open.
///
/// Requires [TransactionPinMixin] (for the fee tx-PIN sheet) — list it AFTER
/// TransactionPinMixin in the State's `with` clause.
mixin LinkedBalanceRefreshMixin<T extends StatefulWidget>
    on State<T>, TransactionPinMixin<T> {
  static const List<String> _monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  /// Account ids with a refresh in flight (fee quote, PIN sheet, or the live
  /// read itself). Listen with a [ValueListenableBuilder] to swap the icon.
  final ValueNotifier<Set<String>> linkedRefreshPending =
      ValueNotifier<Set<String>>(<String>{});

  bool isLinkedRefreshPending(String accountId) =>
      linkedRefreshPending.value.contains(accountId);

  /// Shared timeout for the fee quote. A quote that takes longer than this is
  /// treated as a failed refresh — the person is told, the icon stops — rather
  /// than a spinner that never resolves.
  static const Duration linkedRefreshQuoteTimeout = Duration(seconds: 15);

  @override
  void dispose() {
    linkedRefreshPending.dispose();
    super.dispose();
  }

  /// Short, truncatable "last updated" label for a linked-bank card. Relative for
  /// recent refreshes, an absolute short date once older than a week.
  String linkedBalanceLastUpdatedLabel(DateTime? updatedAt) {
    if (updatedAt == null) return 'Not refreshed yet';
    final d = DateTime.now().difference(updatedAt);
    if (d.inSeconds < 45) return 'Updated just now';
    if (d.inMinutes < 60) return 'Updated ${d.inMinutes}m ago';
    if (d.inHours < 24) return 'Updated ${d.inHours}h ago';
    if (d.inDays < 7) return 'Updated ${d.inDays}d ago';
    return 'Updated ${updatedAt.day} ${_monthsShort[updatedAt.month - 1]}';
  }

  /// The one refresh-icon widget every surface uses: a refresh glyph normally,
  /// a small spinner (and no tap) while this account's refresh is in flight.
  Widget linkedRefreshIcon(
    LinkedBankAccount account, {
    required VoidCallback onPressed,
    double size = 18,
    Color? color,
    IconData icon = Icons.refresh_rounded,
    String tooltip = 'Refresh balance',
  }) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: linkedRefreshPending,
      builder: (context, pending, _) {
        final busy = pending.contains(account.id);
        final c = color ?? Theme.of(context).colorScheme.onSurface;
        return IconButton(
          tooltip: tooltip,
          onPressed: busy ? null : onPressed,
          padding: EdgeInsets.zero,
          constraints:
              BoxConstraints(minWidth: size + 12, minHeight: size + 12),
          icon: busy
              ? SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(c),
                  ),
                )
              : Icon(icon, size: size, color: c),
        );
      },
    );
  }

  /// Refresh a SINGLE linked account's balance (fee-gated). Every surface's
  /// refresh icon ends up here; none quote or charge on their own.
  Future<LinkedRefreshOutcome> refreshLinkedBalance(
    BuildContext context,
    LinkedBankAccount account, {
    required String userId,
    required String accessToken,
    bool preserveHostSheet = false,
  }) async {
    if (isLinkedRefreshPending(account.id)) {
      return LinkedRefreshOutcome.alreadyRunning;
    }
    _setPending(account.id, true);
    try {
      return await _refresh(
        context,
        account,
        userId: userId,
        accessToken: accessToken,
        preserveHostSheet: preserveHostSheet,
      );
    } finally {
      _setPending(account.id, false);
    }
  }

  Future<LinkedRefreshOutcome> _refresh(
    BuildContext context,
    LinkedBankAccount account, {
    required String userId,
    required String accessToken,
    required bool preserveHostSheet,
  }) async {
    final cubit = serviceLocator<OpenBankingCubit>();

    // Quote the per-account refresh fee first. 0 → refresh straight through
    // (no sheet). A quote that fails or stalls is a failed refresh, said so.
    final int feeKobo;
    try {
      feeKobo = await cubit
          .quoteRefreshFee(
            accountId: account.id,
            userId: userId,
            accessToken: accessToken,
          )
          .timeout(linkedRefreshQuoteTimeout);
    } catch (e) {
      if (context.mounted) {
        _tell(context, linkedBalanceRefreshFailureMessage(e));
      }
      return LinkedRefreshOutcome.failed;
    }
    if (!mounted || !context.mounted) return LinkedRefreshOutcome.cancelled;

    if (feeKobo <= 0) {
      // Free: no sheet to report through, so this path reports itself. The
      // icon keeps spinning until the read lands, and a failure is shown with
      // the same copy the sheet would have used.
      try {
        await cubit.refreshBalance(
          accountId: account.id,
          userId: userId,
          accessToken: accessToken,
          isManual: true,
          rethrowOnError: true,
        );
        return LinkedRefreshOutcome.refreshed;
      } catch (e) {
        if (context.mounted) {
          _tell(context, linkedBalanceRefreshFailureMessage(e));
        }
        return LinkedRefreshOutcome.failed;
      }
    }

    final feeNaira = feeKobo / 100.0;
    final txnId =
        'refresh-${account.id}-${DateTime.now().millisecondsSinceEpoch}';
    var readFailed = false;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'balance_refresh',
      // Fee-only charge: no base amount (the modal shows the fee as the total).
      amount: 0,
      fee: feeNaira,
      totalAmount: feeNaira,
      currency: 'NGN',
      title: 'Refresh balance',
      message:
          'Refreshing ${account.bankName} pulls a live balance and costs ₦${feeNaira.toStringAsFixed(2)}. Your last-known balance is shown otherwise.',
      successMessage: 'Balance refreshed',
      // Refresh-specific copy so the single sheet never reads as a "transfer".
      processingSubtitle: 'Refreshing your balance…',
      successSubtitle: 'Your balance is up to date',
      // A failed live read must show the sheet's UNSUCCESSFUL state with
      // category copy — never a false "balance refreshed".
      failureMessageBuilder: linkedBalanceRefreshFailureMessage,
      preserveHostSheet: preserveHostSheet,
      onPinValidated: (token) async {
        // rethrowOnError: propagate a failed refresh so the sheet flips to
        // FAILED (success/balance-update happen ONLY when the RPC returns a
        // fresh balance — see OpenBankingCubit.refreshBalance).
        try {
          await cubit.refreshBalance(
            accountId: account.id,
            userId: userId,
            accessToken: accessToken,
            isManual: true,
            verificationToken: token,
            transactionId: txnId,
            rethrowOnError: true,
          );
        } catch (_) {
          readFailed = true;
          rethrow;
        }
      },
    );
    if (ok) return LinkedRefreshOutcome.refreshed;
    return readFailed
        ? LinkedRefreshOutcome.failed
        : LinkedRefreshOutcome.cancelled;
  }

  void _setPending(String accountId, bool pending) {
    // The State may have been disposed while a sheet was up; a disposed
    // notifier must not be touched, and nothing is listening anyway.
    if (!mounted) return;
    final next = Set<String>.from(linkedRefreshPending.value);
    if (pending) {
      next.add(accountId);
    } else {
      next.remove(accountId);
    }
    linkedRefreshPending.value = next;
  }

  void _tell(BuildContext context, String message) {
    try {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    } catch (_) {/* no scaffold above — the icon stopping is the signal */}
  }
}
