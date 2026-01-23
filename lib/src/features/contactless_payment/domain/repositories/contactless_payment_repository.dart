import '../entities/contactless_payment_entity.dart';

abstract class ContactlessPaymentRepository {
  /// Create a payment session that can be broadcast via NFC (receiver creates)
  Future<({PaymentSessionEntity session, String nfcPayload, String message})>
      createPaymentSession({
    required double amount,
    required String currency,
    String? category,
    String? description,
    int validitySeconds = 120,
  });

  /// Get session details by session ID (payer reads NFC data)
  Future<PaymentSessionEntity> getPaymentSession(String sessionId);

  /// Process payment after payer confirms (with PIN verification)
  Future<({ContactlessTransactionEntity transaction, double newBalance, String message})>
      processContactlessPayment({
    required String sessionId,
    required String sourceAccountId,
    required String transactionId,
    required String verificationToken,
  });

  /// Cancel a pending payment session (receiver cancels)
  Future<String> cancelPaymentSession(String sessionId);

  /// Get receiver's created payment sessions
  Future<({List<PaymentSessionEntity> sessions, int total})>
      getMyPaymentSessions({
    int limit = 20,
    int offset = 0,
    String? statusFilter,
  });

  /// Get payer's contactless payment history
  Future<({List<ContactlessTransactionEntity> transactions, int total})>
      getMyContactlessPayments({
    int limit = 20,
    int offset = 0,
    String? roleFilter,
  });

  /// Check session status (for polling during NFC exchange)
  Future<({String status, String? payerName, DateTime updatedAt})>
      checkSessionStatus(String sessionId);

  /// Acknowledge session read (payer confirms they read the NFC data)
  Future<({PaymentSessionEntity session, String message})>
      acknowledgeSessionRead(String sessionId);
}
