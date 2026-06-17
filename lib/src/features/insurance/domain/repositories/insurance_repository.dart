import '../entities/insurance_entity.dart';
import '../entities/insurance_payment_entity.dart';
import '../entities/insurance_claim_entity.dart';
import '../entities/insurance_product_entity.dart';
import '../entities/mycover_management_entities.dart';
import '../entities/insurance_document_upload_url.dart';

abstract class InsuranceRepository {
  // Insurance Policy Operations
  Future<List<Insurance>> getUserInsurances(String userId);

  /// Paginated variant of getUserInsurances (Slice 4). Returns items +
  /// pagination metadata for scroll-to-bottom infinite scroll.
  Future<UserInsurancesPage> getUserInsurancesPage({
    required String userId,
    int page,
    int limit,
  });
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
  Future<List<InsurancePayment>> getOverduePayments(String userId);

  // Claim Operations
  Future<List<InsuranceClaim>> getInsuranceClaims(String insuranceId);
  /// Paginated. The backend caps `limit` at 200 server-side, so requesting
  /// more silently returns at most 200 rows. Callers should treat the
  /// result as a single page: `result.length == limit` is the cubit's
  /// signal that there's likely another page (the backend doesn't return
  /// a total count today — see GetUserInsuranceClaimsResponse).
  Future<List<InsuranceClaim>> getUserClaims(
    String userId, {
    int page,
    int limit,
  });
  Future<InsuranceClaim?> getClaimById(String id);
  Future<InsuranceClaim> createClaim(InsuranceClaim claim);
  Future<InsuranceClaim> updateClaim(InsuranceClaim claim);

  // Receipt Operations
  Future<String> generatePaymentReceipt(String paymentId);
  Future<List<String>> getUserReceipts(String userId);

  // Statistics Operations
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId);
  Future<Map<String, dynamic>> getPaymentStatistics(String userId, {DateTime? startDate, DateTime? endDate});

  // MyCover.ai Marketplace Operations
  Future<List<InsuranceProduct>> getInsuranceProducts({required String locale, String? category});

  /// Paginated variant (Slice 4). Returns total + items so the UI can do
  /// scroll-to-bottom infinite scrolling without re-counting.
  Future<InsuranceProductPage> getInsuranceProductsPage({
    required String locale,
    String? category,
    int page,
    int limit,
  });

  Future<List<InsuranceCategoryInfo>> getInsuranceCategories({required String locale});

  /// Admin-set hosted terms & conditions URL. Returns empty string when
  /// not configured so the UI can render an "unavailable" state.
  Future<String> getInsuranceTermsLink({required String locale});

  Future<InsuranceQuote> getInsuranceQuote({required String productId, required Map<String, String> formData, required String locale});
  Future<InsurancePurchaseResult> purchaseInsurance({
    required String quoteId,
    required String productId,
    required String accountId,
    required String transactionPin,
    required String idempotencyKey,
    required Map<String, String> formData,
    required String locale,
    String? transactionId,
  });
  Future<InsurancePurchaseResult> getInsurancePurchaseStatus({required String reference});

  // Document Upload
  Future<String> uploadInsuranceDocument({
    required List<int> fileData,
    required String filename,
    required String documentType,
  });

  /// Pre-construct the upload + public URL pair for a deferred upload.
  /// Used by the purchase saga so the form_data carries the final
  /// public URL before the bytes have finished uploading. See
  /// [InsuranceDocumentUploadURL] for field semantics.
  Future<InsuranceDocumentUploadURL> getInsuranceDocumentUploadURL({
    required String filename,
    required String contentType,
    required String documentType,
  });

  // Auxiliary Data
  Future<List<AuxiliaryItem>> getInsuranceAuxiliaryData({
    required String utilityId,
    String? query,
  });

  // MyCover Management APIs
  Future<({List<MyCoverCustomer> customers, int total})> getMyCoverCustomers({int page = 1, int limit = 20});
  Future<MyCoverCustomer> getMyCoverCustomerById(String customerId);
  Future<({List<MyCoverPolicyDetail> policies, int total})> getMyCoverCustomerPolicies(String customerId, {int page = 1, int limit = 20});
  Future<({List<MyCoverPurchase> purchases, int total})> getMyCoverCustomerPurchases(String customerId, {int page = 1, int limit = 20});
  Future<({List<MyCoverPurchase> purchases, int total})> getMyCoverPurchases({int page = 1, int limit = 20});
  Future<MyCoverPurchase> getMyCoverPurchaseById(String purchaseId);
  Future<({List<MyCoverProviderClaim> claims, int total})> getMyCoverClaims({String? status, int page = 1, int limit = 20});
  Future<MyCoverProviderClaim> getMyCoverClaimById(String claimId);
  Future<({String claimId, String claimNumber, String status})> fileCreditLifeClaim({
    required String policyId,
    required String claimType,
    required String description,
    required double amount,
    List<String>? documents,
    Map<String, String>? additionalInfo,
  });
  Future<List<AuxiliaryItem>> getInsuranceStates();
  Future<List<AuxiliaryItem>> getInsuranceVehicleMakes();

  // Notification Preferences
  Future<List<MyCoverNotificationPref>> getMyCoverNotificationPreferences();
  Future<void> updateMyCoverNotificationPreferences(List<MyCoverNotificationPref> preferences);

  // Wallet & Refund
  Future<MyCoverWalletBalance> getMyCoverWalletBalance();
  Future<InsuranceRefund> requestInsuranceRefund({required String policyReference, required String reason});
  Future<InsuranceRefund> getInsuranceRefundStatus(String policyReference);
}