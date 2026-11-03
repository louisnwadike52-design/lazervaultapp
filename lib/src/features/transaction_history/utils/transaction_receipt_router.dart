import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';

/// Routes all transaction taps to the unified receipt screen.
class TransactionReceiptRouter {
  TransactionReceiptRouter._();

  /// Opens the receipt for [transaction].
  ///
  /// [replace] swaps the CURRENT route for the receipt instead of stacking on
  /// top of it. Used by the notification deep-link loader, which must not
  /// remain under the receipt — otherwise Back would return the user to a
  /// spinner that immediately re-resolves and pushes the receipt again.
  static void navigateToReceipt(
    UnifiedTransaction transaction, {
    bool replace = false,
  }) {
    // Invoice platform fees are not transfers — tapping the history row opens
    // the invoice itself (creator perspective), where the real invoice
    // receipt/preview/share live. Falls through to the generic receipt when
    // the invoice id is unknown (very old rows with unrecoverable references).
    if (transaction.serviceType == TransactionServiceType.fee) {
      final invoiceId = transaction.metadata?['invoice_id']?.toString();
      if (invoiceId != null && invoiceId.isNotEmpty) {
        final args = {'invoiceId': invoiceId, 'isFromReceivedTab': false};
        if (replace) {
          Get.offNamed(AppRoutes.invoiceDetails, arguments: args);
        } else {
          Get.toNamed(AppRoutes.invoiceDetails, arguments: args);
        }
        return;
      }
    }
    // Gift cards: the generic receipt cannot show the redemption code/PIN and
    // shares a transfer-shaped PDF. Open the card itself, where the code, PIN
    // and the gift-card receipt (download + share) already live.
    if (transaction.serviceType == TransactionServiceType.giftCard) {
      final ref = transaction.metadata?['giftcard_ref']?.toString();
      if (ref != null && ref.isNotEmpty) {
        if (replace) {
          Get.offNamed(AppRoutes.giftCardFromReference, arguments: ref);
        } else {
          Get.toNamed(AppRoutes.giftCardFromReference, arguments: ref);
        }
        return;
      }
    }
    if (replace) {
      Get.off(
        () => TransactionDetailScreen(transaction: transaction),
        transition: Transition.rightToLeft,
      );
      return;
    }
    Get.to(
      () => TransactionDetailScreen(transaction: transaction),
      transition: Transition.rightToLeft,
    );
  }
}
