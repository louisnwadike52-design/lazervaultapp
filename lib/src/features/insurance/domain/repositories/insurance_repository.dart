import '../entities/insurance_entity.dart';
import '../entities/insurance_payment_entity.dart';
import '../entities/insurance_claim_entity.dart';

abstract class InsuranceRepository {
  // Insurance Policy Operations
  Future<List<Insurance>> getUserInsurances(String userId);
  Future<Insurance?> getInsuranceById(String id);
  Future<Insurance> createInsurance(Insurance insurance);
  Future<Insurance> updateInsurance(Insurance insurance);
  Future<void> deleteInsurance(String id);
  Future<List<Insurance>> searchInsurances(String query, String userId);

  // Payment Operations
  Future<List<InsurancePayment>> getInsurancePayments(String insuranceId);
  Future<List<InsurancePayment>> getUserPayments(String userId);
  Future<InsurancePayment?> getPaymentById(String id);
  Future<InsurancePayment> createPayment(InsurancePayment payment);
  Future<InsurancePayment> updatePayment(InsurancePayment payment);
  Future<List<InsurancePayment>> getOverduePayments(String userId);

  // Claim Operations
  Future<List<InsuranceClaim>> getInsuranceClaims(String insuranceId);
  Future<List<InsuranceClaim>> getUserClaims(String userId);
  Future<InsuranceClaim?> getClaimById(String id);
  Future<InsuranceClaim> createClaim(InsuranceClaim claim);
  Future<InsuranceClaim> updateClaim(InsuranceClaim claim);
  Future<void> deleteClaim(String id);

  // Receipt Operations
  Future<String> generatePaymentReceipt(String paymentId);
  Future<List<String>> getUserReceipts(String userId);

  // Statistics Operations
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId);
  Future<Map<String, dynamic>> getPaymentStatistics(String userId, {DateTime? startDate, DateTime? endDate});
} 