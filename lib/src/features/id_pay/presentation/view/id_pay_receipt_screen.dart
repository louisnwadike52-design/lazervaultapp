import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/safe_args.dart';
import 'package:lazervault/src/features/id_pay/domain/entities/id_pay_transaction_entity.dart';
import 'package:lazervault/src/features/id_pay/utils/id_pay_unified_mapper.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';

/// Post-payment receipt for the PayID flow.
///
/// This used to be a bespoke plain receipt with its own thin PDF. It now
/// adapts the PayID result into a [UnifiedTransaction] and hands it to the
/// SAME rich [TransactionDetailScreen] the dashboard transaction history
/// opens — identical layout, identical PDF/JPG/share pipeline, so the
/// receipt for a PayID payment looks the same whether you reach it from the
/// flow or from history (the QR-pay precedent). Navigation is rebuilt as
/// dashboard → receipt so Back always lands on the dashboard, never on a
/// stale payment screen.
class IDPayReceiptScreen extends StatefulWidget {
  const IDPayReceiptScreen({super.key});

  @override
  State<IDPayReceiptScreen> createState() => _IDPayReceiptScreenState();
}

class _IDPayReceiptScreenState extends State<IDPayReceiptScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openRichReceipt());
  }

  void _openRichReceipt() {
    final args = safeArgs<Map<String, dynamic>>();
    final txn = args?['transaction'];
    final newBalance = args?['newBalance'] as double?;

    if (txn is! IDPayTransactionEntity) {
      Get.offAllNamed(AppRoutes.dashboard);
      Get.snackbar('Receipt unavailable', 'No transaction data was provided.',
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white);
      return;
    }

    // The person landing here just paid — viewer is the payer (outgoing).
    final unified = idPayTxnToUnified(txn, newBalance: newBalance);

    // Dashboard underneath, rich receipt on top: Back from the receipt lands
    // on the dashboard, exactly like opening it from transaction history.
    // Both route ops run synchronously in this frame and the receipt enters
    // WITHOUT animation — an animated entry painted the dashboard for the
    // slide's duration, which read as a navigation glitch after paying.
    Get.offAllNamed(AppRoutes.dashboard);
    Get.to(
      () => TransactionDetailScreen(transaction: unified),
      transition: Transition.noTransition,
      duration: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Center(child: LazerVaultLoader.small()),
    );
  }
}
