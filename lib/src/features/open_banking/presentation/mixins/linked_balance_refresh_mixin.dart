import 'package:flutter/material.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/data/errors/banking_errors.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';

/// Map a FAILED linked-bank balance refresh to short, user-friendly, category-
/// appropriate copy shown in the tx-PIN sheet's unsuccessful state. Shared by
/// every refresh surface (deposit, withdrawal, LazerBeam, AI stats, Linked
/// Banks) so a failed refresh reads the same everywhere — and NEVER as
/// "balance refreshed". The error is the exception thrown out of
/// `OpenBankingCubit.refreshBalance(rethrowOnError: true)`.
String linkedBalanceRefreshFailureMessage(Object error) {
  // Expired/invalid bank link — the only fix is to re-link the account.
  if (error is ReauthorizationRequiredException) {
    return 'Couldn’t refresh — please re-link your bank account.';
  }
  // Fee reservation failed for lack of funds (hold-first, before the live read).
  if (error is InsufficientFundsException) {
    return 'Insufficient balance to cover the refresh fee.';
  }
  // Transport / provider / capacity issues — retryable, so invite a retry.
  if (error is NetworkException ||
      error is ServiceUnavailableException ||
      error is RateLimitException ||
      (error is BankingException && error.isRetryable)) {
    return 'Couldn’t refresh right now. Please try again.';
  }
  // Anything else (not-found, unauthorized, unknown) → honest generic failure.
  return 'Balance refresh failed. Please try again.';
}

/// ONE shared per-account linked-bank balance refresh, consumed by the deposit AND
/// withdrawal screens (and any other linked-bank surface). Because it drives the
/// GetIt-singleton [OpenBankingCubit] — mutating the single `_linkedAccounts` cache
/// and emitting `BalanceRefreshed(accountId)` — a refresh triggered on ANY screen
/// reflects on every screen listening to the cubit.
///
/// Money-safety: a live Mono balance read is billed per account, so a refresh is:
///   - keyed to ONE `account.id` (never a fan-out over all banks),
///   - gated behind a fee tx-PIN sheet when a refresh fee applies (fee shown first),
///   - a no-op charge when the fee is 0.
///
/// Requires [TransactionPinMixin] (for the fee tx-PIN sheet) — list it AFTER
/// TransactionPinMixin in the State's `with` clause.
mixin LinkedBalanceRefreshMixin<T extends StatefulWidget>
    on State<T>, TransactionPinMixin<T> {
  static const List<String> _monthsShort = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

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

  /// Refresh a SINGLE linked account's balance (fee-gated). Mirrors the deposit
  /// screen's original `_refreshSourceBalance`; both now call this one function.
  Future<void> refreshLinkedBalance(
    BuildContext context,
    LinkedBankAccount account, {
    required String userId,
    required String accessToken,
  }) async {
    final cubit = serviceLocator<OpenBankingCubit>();

    // Quote the per-account refresh fee first. 0 → refresh straight through (no sheet).
    final feeKobo = await cubit.quoteRefreshFee(
      accountId: account.id,
      userId: userId,
      accessToken: accessToken,
    );
    if (!mounted) return;
    if (feeKobo <= 0) {
      cubit.refreshBalance(
        accountId: account.id,
        userId: userId,
        accessToken: accessToken,
        isManual: true,
      );
      return;
    }

    final feeNaira = feeKobo / 100.0;
    final txnId = 'refresh-${account.id}-${DateTime.now().millisecondsSinceEpoch}';
    await validateTransactionPin(
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
          'Refreshing ${account.bankName} pulls a live balance and costs ₦${feeNaira.toStringAsFixed(2)}.',
      successMessage: 'Balance refreshed',
      // Refresh-specific copy so the single sheet never reads as a "transfer".
      processingSubtitle: 'Refreshing your balance…',
      successSubtitle: 'Your balance is up to date',
      // A failed live read must show the sheet's UNSUCCESSFUL state with
      // category copy — never a false "balance refreshed".
      failureMessageBuilder: linkedBalanceRefreshFailureMessage,
      onPinValidated: (token) async {
        // rethrowOnError: propagate a failed refresh so the sheet flips to
        // FAILED (success/balance-update happen ONLY when the RPC returns a
        // fresh balance — see OpenBankingCubit.refreshBalance).
        await cubit.refreshBalance(
          accountId: account.id,
          userId: userId,
          accessToken: accessToken,
          isManual: true,
          verificationToken: token,
          transactionId: txnId,
          rethrowOnError: true,
        );
      },
    );
  }
}
