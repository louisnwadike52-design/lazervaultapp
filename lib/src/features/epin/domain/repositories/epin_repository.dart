import '../entities/epin_entities.dart';
import 'package:lazervault/src/features/epin/data/datasources/epin_remote_datasource.dart'
    show EPinCatalogue;

/// Result of an ePIN purchase — the order plus the post-purchase balance and
/// the backend message (used to surface pending/processing states).
class EPinPurchaseResult {
  final EPinOrder order;
  final double newBalance;
  final String message;

  const EPinPurchaseResult({
    required this.order,
    required this.newBalance,
    required this.message,
  });
}

abstract class EPinRepository {
  Future<EPinCatalogue> getNetworks();

  Future<EPinPurchaseResult> initiatePurchase({
    required String network,
    required double denomination,
    required int quantity,
    required String sourceAccountId,
    required String phoneNumber,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String businessName,
  });

  Future<EPinOrder> getOrder(String orderId);

  Future<List<EPinOrder>> listOrders({int limit = 20, int offset = 0});

  /// Returns the order (with PINs) plus a server-rendered PDF url when present.
  Future<(EPinOrder, String pdfUrl)> getReceipt(String orderId);
}
