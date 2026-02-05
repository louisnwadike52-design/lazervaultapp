import 'package:grpc/grpc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../datasources/insurance_remote_datasource.dart';

class InsuranceRepositoryGrpcImpl implements InsuranceRepository {
  final InsuranceRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  InsuranceRepositoryGrpcImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  /// Helper method to get access token
  Future<String> _getAccessToken() async {
    final token = await secureStorage.read(key: 'access_token');
    if (token == null || token.isEmpty) {
      throw GrpcError.unauthenticated('No access token available');
    }
    return token;
  }

  @override
  Future<List<Insurance>> getUserInsurances(String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getUserInsurances(
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting user insurances: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting user insurances: $e');
      rethrow;
    }
  }

  @override
  Future<Insurance?> getInsuranceById(String id) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getInsuranceById(
        id: id,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return null;
      }
      print('gRPC Error getting insurance by ID: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting insurance by ID: $e');
      rethrow;
    }
  }

  @override
  Future<Insurance> createInsurance(Insurance insurance) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.createInsurance(
        insurance: insurance,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error creating insurance: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error creating insurance: $e');
      rethrow;
    }
  }

  @override
  Future<Insurance> updateInsurance(Insurance insurance) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.updateInsurance(
        insurance: insurance,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error updating insurance: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error updating insurance: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteInsurance(String id) async {
    try {
      final accessToken = await _getAccessToken();
      await remoteDataSource.deleteInsurance(
        id: id,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error deleting insurance: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error deleting insurance: $e');
      rethrow;
    }
  }

  @override
  Future<List<Insurance>> searchInsurances(String query, String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.searchInsurances(
        query: query,
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error searching insurances: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error searching insurances: $e');
      rethrow;
    }
  }

  @override
  Future<List<InsurancePayment>> getInsurancePayments(String insuranceId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getInsurancePayments(
        insuranceId: insuranceId,
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting insurance payments: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting insurance payments: $e');
      rethrow;
    }
  }

  @override
  Future<List<InsurancePayment>> getUserPayments(String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getUserPayments(
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting user payments: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting user payments: $e');
      rethrow;
    }
  }

  @override
  Future<InsurancePayment?> getPaymentById(String id) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getPaymentById(
        id: id,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return null;
      }
      print('gRPC Error getting payment by ID: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting payment by ID: $e');
      rethrow;
    }
  }

  @override
  Future<InsurancePayment> createPayment(InsurancePayment payment) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.createPayment(
        payment: payment,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error creating payment: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error creating payment: $e');
      rethrow;
    }
  }

  @override
  Future<InsurancePayment> updatePayment(InsurancePayment payment) async {
    try {
      // Note: The remote datasource doesn't have updatePayment method
      // This would need to be added to the proto and datasource
      // For now, we'll return the payment as-is or throw an error
      throw UnimplementedError('Update payment not yet implemented in gRPC service');
    } on GrpcError catch (e) {
      print('gRPC Error updating payment: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error updating payment: $e');
      rethrow;
    }
  }

  @override
  Future<List<InsurancePayment>> getOverduePayments(String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getOverduePayments(
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting overdue payments: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting overdue payments: $e');
      rethrow;
    }
  }

  @override
  Future<List<InsuranceClaim>> getInsuranceClaims(String insuranceId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getInsuranceClaims(
        insuranceId: insuranceId,
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting insurance claims: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting insurance claims: $e');
      rethrow;
    }
  }

  @override
  Future<List<InsuranceClaim>> getUserClaims(String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getUserClaims(
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting user claims: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting user claims: $e');
      rethrow;
    }
  }

  @override
  Future<InsuranceClaim?> getClaimById(String id) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getClaimById(
        id: id,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return null;
      }
      print('gRPC Error getting claim by ID: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting claim by ID: $e');
      rethrow;
    }
  }

  @override
  Future<InsuranceClaim> createClaim(InsuranceClaim claim) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.createClaim(
        claim: claim,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error creating claim: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error creating claim: $e');
      rethrow;
    }
  }

  @override
  Future<InsuranceClaim> updateClaim(InsuranceClaim claim) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.updateClaim(
        claim: claim,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error updating claim: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error updating claim: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteClaim(String id) async {
    try {
      // Note: The remote datasource doesn't have deleteClaim method
      // This would need to be added to the proto and datasource
      throw UnimplementedError('Delete claim not yet implemented in gRPC service');
    } on GrpcError catch (e) {
      print('gRPC Error deleting claim: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error deleting claim: $e');
      rethrow;
    }
  }

  @override
  Future<String> generatePaymentReceipt(String paymentId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.generatePaymentReceipt(
        paymentId: paymentId,
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error generating payment receipt: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error generating payment receipt: $e');
      rethrow;
    }
  }

  @override
  Future<List<String>> getUserReceipts(String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getUserReceipts(
        accessToken: accessToken,
        page: 1,
        limit: 100,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting user receipts: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting user receipts: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getInsuranceStatistics(
        accessToken: accessToken,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting insurance statistics: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting insurance statistics: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final accessToken = await _getAccessToken();
      return await remoteDataSource.getPaymentStatistics(
        accessToken: accessToken,
        startDate: startDate,
        endDate: endDate,
      );
    } on GrpcError catch (e) {
      print('gRPC Error getting payment statistics: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error getting payment statistics: $e');
      rethrow;
    }
  }
}
