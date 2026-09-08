import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_transaction_entity.dart';
import 'package:lazervault/src/features/qr_payment/utils/qr_unified_mapper.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';

/// Post-payment receipt for the QR flow.
///
/// This used to be a bespoke plain receipt with its own thin PDF. It now
/// adapts the QR result into a [UnifiedTransaction] and hands it to the SAME
/// rich [TransactionDetailScreen] the dashboard transaction history opens —
/// identical layout, identical PDF/JPG/share pipeline, so the receipt for a
/// QR payment looks the same whether you reach it from the flow or from
/// history. Navigation is rebuilt as dashboard → receipt so Back always lands
/// on the dashboard, never on a stale confirmation/processing screen.
class QRPaymentReceiptScreen extends StatefulWidget {
  const QRPaymentReceiptScreen({super.key});

  @override
  State<QRPaymentReceiptScreen> createState() => _QRPaymentReceiptScreenState();
}

class _QRPaymentReceiptScreenState extends State<QRPaymentReceiptScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openRichReceipt());
  }

  void _openRichReceipt() {
    final args = Get.arguments as Map<String, dynamic>?;
    final txn = args?['transaction'] as QRTransactionEntity?;
    final newBalance = args?['newBalance'] as double?;

    if (txn == null) {
      Get.offAllNamed(AppRoutes.dashboard);
      Get.snackbar('Receipt unavailable', 'No transaction data was provided.',
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white);
      return;
    }

    final unified = qrTxnToUnified(txn, newBalance: newBalance);

    // Dashboard underneath, rich receipt on top: Back from the receipt lands
    // on the dashboard, exactly like opening it from transaction history.
    Get.offAllNamed(AppRoutes.dashboard);
    Get.to(
      () => TransactionDetailScreen(transaction: unified),
      transition: Transition.rightToLeft,
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
