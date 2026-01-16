import '../services/contribution_payment_service.dart';
import '../../domain/entities/group_entities.dart';
import '../../domain/repositories/contribution_payment_repository.dart';

class ContributionPaymentRepositoryImpl implements ContributionPaymentRepository {
  final ContributionPaymentService paymentService;

  ContributionPaymentRepositoryImpl({required this.paymentService});

  @override
  Future<ContributionPayment> savePayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
    String? paymentMethod,
  }) async {
    final paymentModel = await paymentService.savePayment(
      contributionId: contributionId,
      groupId: groupId,
      userId: userId,
      userName: userName,
      amount: amount,
      currency: currency,
      notes: notes,
      paymentMethod: paymentMethod,
    );
    
    return paymentModel;
  }

  @override
  Future<List<ContributionPayment>> getPaymentsByContribution(String contributionId) async {
    final paymentModels = await paymentService.getPaymentsByContribution(contributionId);
    return paymentModels.cast<ContributionPayment>();
  }

  @override
  Future<List<ContributionPayment>> getPaymentsByUser(String userId) async {
    final paymentModels = await paymentService.getPaymentsByUser(userId);
    return paymentModels.cast<ContributionPayment>();
  }

  @override
  Future<ContributionPayment?> getPaymentById(String paymentId) async {
    final paymentModel = await paymentService.getPaymentById(paymentId);
    return paymentModel;
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    await paymentService.deletePayment(paymentId);
  }
} 