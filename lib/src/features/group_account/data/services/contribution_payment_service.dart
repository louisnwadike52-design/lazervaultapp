import '../datasources/contribution_payment_local_data_source.dart';
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
  final ContributionPaymentLocalDataSource localDataSource;
  final bool useRemoteApi;

  ContributionPaymentServiceImpl({
    required this.localDataSource,
    this.useRemoteApi = false, // Switch this to true when remote API is ready
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
    final payment = ContributionPaymentModel(
      id: 'payment_${DateTime.now().millisecondsSinceEpoch}',
      contributionId: contributionId,
      groupId: groupId,
      userId: userId,
      userName: userName,
      amount: amount,
      currency: currency,
      paymentDate: DateTime.now(),
      status: PaymentStatus.completed,
      transactionId: 'TXN_${DateTime.now().millisecondsSinceEpoch}',
      notes: notes,
      metadata: paymentMethod != null ? {'paymentMethod': paymentMethod} : null,
    );

    if (useRemoteApi) {
      // TODO: Call remote API when available
      // final remotePayment = await _remoteApiCall(payment);
      // Also save to local storage as cache
      await localDataSource.savePayment(payment);
      return payment;
    } else {
      // Use local storage only
      await localDataSource.savePayment(payment);
      return payment;
    }
  }

  @override
  Future<List<ContributionPaymentModel>> getPaymentsByContribution(String contributionId) async {
    if (useRemoteApi) {
      // TODO: Call remote API first, fallback to local if needed
      // try {
      //   final remotePayments = await _getRemotePaymentsByContribution(contributionId);
      //   // Cache remote payments locally
      //   for (final payment in remotePayments) {
      //     await localDataSource.savePayment(payment);
      //   }
      //   return remotePayments;
      // } catch (e) {
      //   // Fallback to local storage
      //   return await localDataSource.getPaymentsByContribution(contributionId);
      // }
      return await localDataSource.getPaymentsByContribution(contributionId);
    } else {
      return await localDataSource.getPaymentsByContribution(contributionId);
    }
  }

  @override
  Future<List<ContributionPaymentModel>> getPaymentsByUser(String userId) async {
    if (useRemoteApi) {
      // TODO: Implement remote API call
      return await localDataSource.getPaymentsByUser(userId);
    } else {
      return await localDataSource.getPaymentsByUser(userId);
    }
  }

  @override
  Future<ContributionPaymentModel?> getPaymentById(String paymentId) async {
    if (useRemoteApi) {
      // TODO: Implement remote API call
      return await localDataSource.getPaymentById(paymentId);
    } else {
      return await localDataSource.getPaymentById(paymentId);
    }
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    if (useRemoteApi) {
      // TODO: Call remote API first
      // await _deleteRemotePayment(paymentId);
      // Also delete from local storage
      await localDataSource.deletePayment(paymentId);
    } else {
      await localDataSource.deletePayment(paymentId);
    }
  }

  // TODO: Implement these when remote API is available
  // Future<ContributionPaymentModel> _remoteApiCall(ContributionPaymentModel payment) async { ... }
  // Future<List<ContributionPaymentModel>> _getRemotePaymentsByContribution(String contributionId) async { ... }
  // Future<void> _deleteRemotePayment(String paymentId) async { ... }
} 