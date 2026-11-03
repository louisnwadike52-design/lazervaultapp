import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_receipt_router.dart';

/// Hydrates a money receipt from an identifier, then becomes that receipt.
///
/// A notification payload carries `transaction_id` / `entity_id` / `reference`
/// — never a `UnifiedTransaction` — and every receipt in this app renders a
/// hydrated entity. That mismatch is why a tapped "your transfer failed" push
/// used to land on the transfer history list: the resolver had an id and the
/// destination wanted an object, so the honest landing was the list with the
/// record at the top.
///
/// This screen closes the gap without weakening any receipt. It fetches the
/// row by id, then REPLACES itself with the real receipt, so the user's back
/// gesture returns to wherever they tapped from — the dashboard on a cold
/// start, the notifications feed from an in-app row — and never to a loading
/// screen they would then have to dismiss again.
///
/// It degrades, never dead-ends. An id this account has no row for (a stale
/// link, a payload referencing another service's key, a record older than the
/// recent window) falls through to exactly the destination the resolver used
/// before: the owning service's transaction history. Worst case is today's
/// behaviour plus one spinner; best case is the actual receipt.
class TransactionDeepLinkScreen extends StatefulWidget {
  const TransactionDeepLinkScreen({
    super.key,
    required this.transactionId,
    this.serviceType,
  });

  /// Any identifier that names the transaction — a ledger row id, a raw
  /// reference, a business reference, or a `-CR` credit leg. The repository
  /// compares normalised forms, so the publisher's choice does not matter.
  final String transactionId;

  /// The service whose history to fall back to when the record cannot be
  /// reached. Null falls back to the all-services history.
  final TransactionServiceType? serviceType;

  @override
  State<TransactionDeepLinkScreen> createState() =>
      _TransactionDeepLinkScreenState();
}

class _TransactionDeepLinkScreenState extends State<TransactionDeepLinkScreen> {
  @override
  void initState() {
    super.initState();
    // After the first frame: this screen is itself being pushed, and calling
    // Get.off during that push throws — which would read to the user as the
    // notification tap doing nothing at all.
    WidgetsBinding.instance.addPostFrameCallback((_) => _resolve());
  }

  /// How long the user waits on the spinner before being sent to the list.
  ///
  /// The lookup is a bounded page walk plus the external-transfer supplement —
  /// four round trips at worst — and on a poor connection that can outlast the
  /// user's patience. The fallback is a real page with the record at the top,
  /// so arriving there quickly beats a spinner that is still technically
  /// making progress.
  static const _budget = Duration(seconds: 6);

  Future<void> _resolve() async {
    UnifiedTransaction? tx;
    try {
      tx = await serviceLocator<TransactionHistoryRepository>()
          .fetchTransactionById(widget.transactionId)
          .timeout(_budget);
    } catch (_) {
      // Offline, or the lookup failed. Treated the same as "not found": the
      // user still reaches the right page, just not the individual receipt.
      tx = null;
    }
    if (!mounted) return;

    if (tx != null) {
      // `replace: true` so this loader leaves the stack — the receipt takes
      // its place and Back returns to the tap's origin.
      TransactionReceiptRouter.navigateToReceipt(tx, replace: true);
      return;
    }

    final service = widget.serviceType;
    if (service != null) {
      Get.offNamed(AppRoutes.serviceTransactionHistory, arguments: service);
    } else {
      Get.offNamed(AppRoutes.dashboardTransactionHistory);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Deliberately chrome-free: no app bar, no title, no back button. The
    // screen exists for a few hundred milliseconds and is replaced, so any
    // chrome would flash and then be gone — and a back button here would
    // race the replacement.
    return const Scaffold(
      body: Center(child: LazerVaultLoader(size: 36)),
    );
  }
}
