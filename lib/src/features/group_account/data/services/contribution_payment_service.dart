import '../datasources/group_account_remote_data_source.dart';
import '../models/group_account_models.dart';
import '../../domain/entities/group_entities.dart';

abstract class ContributionPaymentService {
  Future<ContributionPaymentModel> savePayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
    String? paymentMethod,
  });

  Future<List<ContributionPaymentModel>> getPaymentsByContribution(String contributionId);
  Future<List<ContributionPaymentModel>> getPaymentsByUser(String userId);
  Future<ContributionPaymentModel?> getPaymentById(String paymentId);
  Future<void> deletePayment(String paymentId);
}

class ContributionPaymentServiceImpl implements ContributionPaymentService {
  final GroupAccountRemoteDataSource remoteDataSource;

  ContributionPaymentServiceImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ContributionPaymentModel> savePayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
    String? paymentMethod,
  }) async {
    return await remoteDataSource.makeContributionPayment(
      contributionId: contributionId,
      groupId: groupId,
      userId: userId,
      userName: userName,
      amount: amount,
      currency: currency,
      notes: notes,
      paymentMethod: paymentMethod,
    );
  }

  @override
  Future<List<ContributionPaymentModel>> getPaymentsByContribution(String contributionId) async {
    return await remoteDataSource.getContributionPayments(contributionId);
  }

  @override
  Future<List<ContributionPaymentModel>> getPaymentsByUser(String userId) async {
    // Get all payments and filter by userId
    final allPayments = await remoteDataSource.getContributionPayments('');
    return allPayments.where((payment) => payment.userId == userId).toList();
  }

  @override
  Future<ContributionPaymentModel?> getPaymentById(String paymentId) async {
    // Get all payments and find by ID
    final allPayments = await remoteDataSource.getContributionPayments('');
    try {
      return allPayments.firstWhere((payment) => payment.id == paymentId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    // Note: Remote datasource might not have a delete method
    // This is a placeholder - implement when backend supports it
    throw UnimplementedError('Delete payment not yet implemented in remote datasource');
  }
} 