import 'package:grpc/grpc.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../datasources/insurance_remote_datasource.dart';
import '../../../../../core/services/secure_storage_service.dart';

class InsuranceRepositoryImpl implements InsuranceRepository {
  final InsuranceRemoteDataSource remoteDataSource;
  final SecureStorageService secureStorage;

  InsuranceRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<List<Insurance>> getUserInsurances(String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getUserInsurances(accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch user insurances: $e');
    }
  }

  @override
  Future<Insurance?> getInsuranceById(String id) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getInsuranceById(id: id, accessToken: accessToken);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return null;
      }
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch insurance: $e');
    }
  }

  @override
  Future<Insurance> createInsurance(Insurance insurance) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.createInsurance(insurance: insurance, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to create insurance: $e');
    }
  }

  @override
  Future<Insurance> updateInsurance(Insurance insurance) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.updateInsurance(insurance: insurance, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to update insurance: $e');
    }
  }

  @override
  Future<void> deleteInsurance(String id) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      await remoteDataSource.deleteInsurance(id: id, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to delete insurance: $e');
    }
  }

  @override
  Future<List<Insurance>> searchInsurances(String query, String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.searchInsurances(query: query, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to search insurances: $e');
    }
  }

  @override
  Future<List<InsurancePayment>> getInsurancePayments(String insuranceId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getInsurancePayments(insuranceId: insuranceId, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch insurance payments: $e');
    }
  }

  @override
  Future<List<InsurancePayment>> getUserPayments(String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getUserPayments(accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch user payments: $e');
    }
  }

  @override
  Future<InsurancePayment?> getPaymentById(String id) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getPaymentById(id: id, accessToken: accessToken);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return null;
      }
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch payment: $e');
    }
  }

  @override
  Future<InsurancePayment> createPayment(InsurancePayment payment) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.createPayment(payment: payment, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to create payment: $e');
    }
  }

  @override
  Future<InsurancePayment> updatePayment(InsurancePayment payment) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.createPayment(payment: payment, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to update payment: $e');
    }
  }

  @override
  Future<List<InsurancePayment>> getOverduePayments(String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getOverduePayments(accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch overdue payments: $e');
    }
  }

  @override
  Future<List<InsuranceClaim>> getInsuranceClaims(String insuranceId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getInsuranceClaims(insuranceId: insuranceId, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch insurance claims: $e');
    }
  }

  @override
  Future<List<InsuranceClaim>> getUserClaims(String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getUserClaims(accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch user claims: $e');
    }
  }

  @override
  Future<InsuranceClaim?> getClaimById(String id) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getClaimById(id: id, accessToken: accessToken);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        return null;
      }
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch claim: $e');
    }
  }

  @override
  Future<InsuranceClaim> createClaim(InsuranceClaim claim) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.createClaim(claim: claim, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to create claim: $e');
    }
  }

  @override
  Future<InsuranceClaim> updateClaim(InsuranceClaim claim) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.updateClaim(claim: claim, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to update claim: $e');
    }
  }

  @override
  Future<void> deleteClaim(String id) async {
    try {
      // Note: deleteClaim not in remote datasource interface, might need to add
      throw UnimplementedError('Delete claim not yet implemented in remote datasource');
    } catch (e) {
      throw Exception('Failed to delete claim: $e');
    }
  }

  @override
  Future<String> generatePaymentReceipt(String paymentId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.generatePaymentReceipt(paymentId: paymentId, accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to generate payment receipt: $e');
    }
  }

  @override
  Future<List<String>> getUserReceipts(String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getUserReceipts(accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch user receipts: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getInsuranceStatistics(accessToken: accessToken);
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch insurance statistics: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics(String userId, {DateTime? startDate, DateTime? endDate}) async {
    try {
      final accessToken = await secureStorage.getAccessToken() ?? '';
      return await remoteDataSource.getPaymentStatistics(
        accessToken: accessToken,
        startDate: startDate,
        endDate: endDate,
      );
    } on GrpcError catch (e) {
      throw _handleGrpcError(e);
    } catch (e) {
      throw Exception('Failed to fetch payment statistics: $e');
    }
  }

  // Error Handling Helper
  Exception _handleGrpcError(GrpcError error) {
    switch (error.code) {
      case StatusCode.notFound:
        return Exception('Insurance not found');
      case StatusCode.unauthenticated:
        return Exception('Authentication required. Please log in again.');
      case StatusCode.permissionDenied:
        return Exception('You do not have permission to perform this action');
      case StatusCode.invalidArgument:
        return Exception('Invalid data provided: ${error.message}');
      case StatusCode.alreadyExists:
        return Exception('Insurance already exists');
      case StatusCode.unavailable:
        return Exception('Service temporarily unavailable. Please try again later.');
      default:
        return Exception('An error occurred: ${error.message}');
    }
  }
} 