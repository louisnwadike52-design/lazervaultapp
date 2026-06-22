import 'package:flutter/material.dart';

import '../../domain/entities/scan_entities.dart';
import 'bank_details_receipt_screen.dart';

/// Unified receipt screen for every AI Scan-to-Pay target. The unified
/// [PaymentReceipt] entity is identical to what the bank-details receipt
/// already renders cleanly (amount card, transaction details, share + Done →
/// back to dashboard), so this wraps [BankDetailsReceiptScreen] rather than
/// duplicating ~600 lines of receipt UI.
class AiScanReceiptScreen extends StatelessWidget {
  final PaymentReceipt receipt;

  const AiScanReceiptScreen({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return BankDetailsReceiptScreen(receipt: receipt);
  }
}
