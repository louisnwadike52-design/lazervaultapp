import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';

/// Routes all transaction taps to the unified receipt screen.
class TransactionReceiptRouter {
  TransactionReceiptRouter._();

  static void navigateToReceipt(UnifiedTransaction transaction) {
    // Invoice platform fees are not transfers — tapping the history row opens
    // the invoice itself (creator perspective), where the real invoice
    // receipt/preview/share live. Falls through to the generic receipt when
    // the invoice id is unknown (very old rows with unrecoverable references).
    if (transaction.serviceType == TransactionServiceType.fee) {
      final invoiceId = transaction.metadata?['invoice_id']?.toString();
      if (invoiceId != null && invoiceId.isNotEmpty) {
        Get.toNamed(AppRoutes.invoiceDetails, arguments: {
          'invoiceId': invoiceId,
          'isFromReceivedTab': false,
        });
        return;
      }
    }
    // Gift cards: the generic receipt cannot show the redemption code/PIN and
    // shares a transfer-shaped PDF. Open the card itself, where the code, PIN
    // and the gift-card receipt (download + share) already live.
    if (transaction.serviceType == TransactionServiceType.giftCard) {
      final ref = transaction.metadata?['giftcard_ref']?.toString();
      if (ref != null && ref.isNotEmpty) {
        Get.toNamed(AppRoutes.giftCardFromReference, arguments: ref);
        return;
      }
    }
    Get.to(
      () => TransactionDetailScreen(transaction: transaction),
      transition: Transition.rightToLeft,
    );
  }
}
