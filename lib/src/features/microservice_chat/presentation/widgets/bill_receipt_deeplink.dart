import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';

/// "Open full receipt" deep-link button for bill payments surfaced in chat.
///
/// The `chat-products-service` agent stashes `bill_type` + `last_payment_id`
/// in response metadata after every successful bill purchase. The chat
/// content widget renders this button under the receipt card; tapping routes
/// to the existing Flutter receipt screen for that bill type so the user
/// gets PDF download, save-beneficiary, auto-recharge setup, etc. — the
/// same post-purchase surface the form flow offers.
class BillReceiptDeepLinkButton extends StatelessWidget {
  /// One of: electricity, airtime, data, cable_tv, internet, water,
  /// education. Anything else renders nothing.
  final String billType;

  /// The payment ID returned by the Go gateway.
  final String paymentId;

  const BillReceiptDeepLinkButton({
    super.key,
    required this.billType,
    required this.paymentId,
  });

  static const Map<String, String> _routes = {
    'electricity': AppRoutes.electricityBillReceipt,
    'cable_tv': AppRoutes.cableTVPaymentReceipt,
    'internet': AppRoutes.internetPaymentReceipt,
    'water': AppRoutes.waterBillPaymentReceipt,
    'airtime': AppRoutes.airtimePaymentConfirmation,
    'data': AppRoutes.dataBundlesPaymentReceipt,
    'education': AppRoutes.educationPinResult,
  };

  @override
  Widget build(BuildContext context) {
    final route = _routes[billType];
    if (route == null || paymentId.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => Get.toNamed(
            route,
            arguments: {'payment_id': paymentId, 'bill_type': billType},
          ),
          icon: const Icon(Icons.receipt_long, size: 18),
          label: const Text('Open full receipt'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: const Color(0xFF3B82F6).withValues(alpha: 0.6)),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
