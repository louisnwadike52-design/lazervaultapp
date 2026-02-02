import 'package:get/get.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';

/// Routes all transaction taps to the unified receipt screen.
class TransactionReceiptRouter {
  TransactionReceiptRouter._();

  static void navigateToReceipt(UnifiedTransaction transaction) {
    Get.to(
      () => TransactionDetailScreen(transaction: transaction),
      transition: Transition.rightToLeft,
    );
  }
}
