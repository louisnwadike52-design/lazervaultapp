import 'dart:math';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../datasources/insurance_local_datasource.dart';

class InsuranceRepositoryImpl implements InsuranceRepository {
  final InsuranceLocalDataSource localDataSource;

  InsuranceRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Insurance>> getUserInsurances(String userId) async {
    return await localDataSource.getUserInsurances(userId);
  }

  @override
  Future<Insurance?> getInsuranceById(String id) async {
    return await localDataSource.getInsuranceById(id);
  }

  @override
  Future<Insurance> createInsurance(Insurance insurance) async {
    return await localDataSource.saveInsurance(insurance);
  }

  @override
  Future<Insurance> updateInsurance(Insurance insurance) async {
    return await localDataSource.updateInsurance(insurance);
  }

  @override
  Future<void> deleteInsurance(String id) async {
    return await localDataSource.deleteInsurance(id);
  }

  @override
  Future<List<Insurance>> searchInsurances(String query, String userId) async {
    return await localDataSource.searchInsurances(query, userId);
  }

  @override
  Future<List<InsurancePayment>> getInsurancePayments(String insuranceId) async {
    return await localDataSource.getInsurancePayments(insuranceId);
  }

  @override
  Future<List<InsurancePayment>> getUserPayments(String userId) async {
    return await localDataSource.getUserPayments(userId);
  }

  @override
  Future<InsurancePayment?> getPaymentById(String id) async {
    return await localDataSource.getPaymentById(id);
  }

  @override
  Future<InsurancePayment> createPayment(InsurancePayment payment) async {
    return await localDataSource.savePayment(payment);
  }

  @override
  Future<InsurancePayment> updatePayment(InsurancePayment payment) async {
    return await localDataSource.updatePayment(payment);
  }

  @override
  Future<List<InsurancePayment>> getOverduePayments(String userId) async {
    return await localDataSource.getOverduePayments(userId);
  }

  // Mock claim operations (for demo purposes)
  @override
  Future<List<InsuranceClaim>> getInsuranceClaims(String insuranceId) async {
    // Mock data - in a real app, this would use a data source
    return [];
  }

  @override
  Future<List<InsuranceClaim>> getUserClaims(String userId) async {
    // Mock data - in a real app, this would use a data source
    return [];
  }

  @override
  Future<InsuranceClaim?> getClaimById(String id) async {
    // Mock data - in a real app, this would use a data source
    return null;
  }

  @override
  Future<InsuranceClaim> createClaim(InsuranceClaim claim) async {
    // Mock implementation - in a real app, this would save to data source
    return claim;
  }

  @override
  Future<InsuranceClaim> updateClaim(InsuranceClaim claim) async {
    // Mock implementation - in a real app, this would update in data source
    return claim;
  }

  @override
  Future<void> deleteClaim(String id) async {
    // Mock implementation - in a real app, this would delete from data source
  }

  @override
  Future<String> generatePaymentReceipt(String paymentId) async {
    // Mock receipt generation
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    final receiptId = 'RCP${random.nextInt(999999).toString().padLeft(6, '0')}';
    return 'https://receipts.lazervault.com/$receiptId.pdf';
  }

  @override
  Future<List<String>> getUserReceipts(String userId) async {
    // Mock receipts list
    return [];
  }

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId) async {
    return await localDataSource.getInsuranceStatistics(userId);
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics(String userId, {DateTime? startDate, DateTime? endDate}) async {
    return await localDataSource.getPaymentStatistics(userId, startDate: startDate, endDate: endDate);
  }
} 