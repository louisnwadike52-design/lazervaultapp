import '../entities/group_entities.dart';

abstract class ContributionPaymentRepository {
  Future<ContributionPayment> savePayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
    String? paymentMethod,
  });
  
  Future<List<ContributionPayment>> getPaymentsByContribution(String contributionId);
  Future<List<ContributionPayment>> getPaymentsByUser(String userId);
  Future<ContributionPayment?> getPaymentById(String paymentId);
  Future<void> deletePayment(String paymentId);
} 