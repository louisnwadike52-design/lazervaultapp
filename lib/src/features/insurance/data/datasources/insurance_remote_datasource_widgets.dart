part of 'insurance_remote_datasource.dart';

abstract class InsuranceRemoteDataSource {
  Future<List<Insurance>> getUserInsurances({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  /// Paginated variant of getUserInsurances (Slice 4). Surfaces the
  /// pagination metadata (totalItems, hasNext) so UIs can drive
  /// scroll-to-bottom infinite scroll without falling back to "list
  /// shorter than limit = end" heuristics.
  Future<UserInsurancesPage> getUserInsurancesPage({
    required String accessToken,
    int page = 1,
    int limit = 15,
  });

  Future<Insurance> getInsuranceById({
    required String id,
    required String accessToken,
  });

  Future<Insurance> createInsurance({
    required Insurance insurance,
    required String accessToken,
  });

  Future<Insurance> updateInsurance({
    required Insurance insurance,
    required String accessToken,
  });

  Future<void> deleteInsurance({
    required String id,
    required String accessToken,
  });

  Future<List<Insurance>> searchInsurances({
    required String query,
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<List<InsurancePayment>> getInsurancePayments({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<List<InsurancePayment>> getUserPayments({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<InsurancePayment> getPaymentById({
    required String id,
    required String accessToken,
  });

  Future<InsurancePayment> createPayment({
    required InsurancePayment payment,
    required String accessToken,
  });

  Future<List<InsurancePayment>> getOverduePayments({
    required String accessToken,
  });

  Future<List<InsuranceClaim>> getInsuranceClaims({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<List<InsuranceClaim>> getUserClaims({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<InsuranceClaim> getClaimById({
    required String id,
    required String accessToken,
  });

  Future<InsuranceClaim> createClaim({
    required InsuranceClaim claim,
    required String accessToken,
  });

  Future<InsuranceClaim> updateClaim({
    required InsuranceClaim claim,
    required String accessToken,
  });

  Future<String> generatePaymentReceipt({
    required String paymentId,
    required String accessToken,
  });

  Future<List<String>> getUserReceipts({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<Map<String, dynamic>> getInsuranceStatistics({
    required String accessToken,
  });

  Future<Map<String, dynamic>> getPaymentStatistics({
    required String accessToken,
    DateTime? startDate,
    DateTime? endDate,
  });

  // MyCover.ai Marketplace Operations
  Future<List<InsuranceProduct>> getInsuranceProducts({
    required String accessToken,
    required String locale,
    String? category,
  });

  /// Paginated variant of getInsuranceProducts (Slice 4). The underlying
  /// gRPC RPC already supports page/limit (proto fields 3-4) and surfaces
  /// `total` so callers can implement scroll-to-bottom infinite scroll.
  Future<InsuranceProductPage> getInsuranceProductsPage({
    required String accessToken,
    required String locale,
    String? category,
    int page = 1,
    int limit = 15,
  });

  Future<List<InsuranceCategoryInfo>> getInsuranceCategories({
    required String accessToken,
    required String locale,
  });

  /// Admin-set hosted terms & conditions URL. Returns empty string when
  /// not configured so callers can render an "unavailable" state. Backed
  /// by the same `GetInsuranceMarketplaceCategories` response that ships
  /// the categories list (the RPC is cached on the server for 4h).
  Future<String> getInsuranceTermsLink({
    required String accessToken,
    required String locale,
  });

  Future<InsuranceQuote> getInsuranceQuote({
    required String accessToken,
    required String productId,
    required Map<String, String> formData,
    required String locale,
  });

  Future<InsurancePurchaseResult> purchaseInsurance({
    required String accessToken,
    required String quoteId,
    required String productId,
    required String accountId,
    required String transactionPin,
    required String idempotencyKey,
    required Map<String, String> formData,
    required String locale,
    String? transactionId,
  });

  Future<InsurancePurchaseResult> getInsurancePurchaseStatus({
    required String accessToken,
    required String reference,
  });

  Future<String> uploadInsuranceDocument({
    required String accessToken,
    required List<int> fileData,
    required String filename,
    required String documentType,
  });

  /// Pre-construct the upload + public URL pair for a deferred
  /// document upload. Backend returns:
  ///   uploadUrl  — PUT bytes here (signed in prod, local route in dev)
  ///   publicUrl  — deterministic GET URL safe to stamp into form_data
  ///                BEFORE the upload completes
  ///   storageKey — bookkeeping; not surfaced to MyCover
  ///   expiresAt  — Unix-seconds when uploadUrl stops accepting writes
  Future<InsuranceDocumentUploadURL> getInsuranceDocumentUploadURL({
    required String accessToken,
    required String filename,
    required String contentType,
    required String documentType,
  });

  Future<List<AuxiliaryItem>> getInsuranceAuxiliaryData({
    required String accessToken,
    required String utilityId,
    String? query,
  });

  // MyCover Management APIs
  Future<({List<MyCoverCustomer> customers, int total})> getMyCoverCustomers({
    required String accessToken,
    int page = 1,
    int limit = 20,
  });

  Future<MyCoverCustomer> getMyCoverCustomerById({
    required String accessToken,
    required String customerId,
  });

  Future<({List<MyCoverPolicyDetail> policies, int total})> getMyCoverCustomerPolicies({
    required String accessToken,
    required String customerId,
    int page = 1,
    int limit = 20,
  });

  Future<({List<MyCoverPurchase> purchases, int total})> getMyCoverCustomerPurchases({
    required String accessToken,
    required String customerId,
    int page = 1,
    int limit = 20,
  });

  Future<({List<MyCoverPurchase> purchases, int total})> getMyCoverPurchases({
    required String accessToken,
    int page = 1,
    int limit = 20,
  });

  Future<MyCoverPurchase> getMyCoverPurchaseById({
    required String accessToken,
    required String purchaseId,
  });

  Future<({List<MyCoverProviderClaim> claims, int total})> getMyCoverClaims({
    required String accessToken,
    String? status,
    int page = 1,
    int limit = 20,
  });

  Future<MyCoverProviderClaim> getMyCoverClaimById({
    required String accessToken,
    required String claimId,
  });

  Future<({String claimId, String claimNumber, String status})> fileCreditLifeClaim({
    required String accessToken,
    required String policyId,
    required String claimType,
    required String description,
    required double amount,
    List<String>? documents,
    Map<String, String>? additionalInfo,
  });

  Future<List<AuxiliaryItem>> getInsuranceStates({
    required String accessToken,
  });

  Future<List<AuxiliaryItem>> getInsuranceVehicleMakes({
    required String accessToken,
  });

  Future<List<MyCoverNotificationPref>> getMyCoverNotificationPreferences({
    required String accessToken,
  });

  Future<void> updateMyCoverNotificationPreferences({
    required List<MyCoverNotificationPref> preferences,
    required String accessToken,
  });

  Future<MyCoverWalletBalance> getMyCoverWalletBalance({
    required String accessToken,
  });

  Future<InsuranceRefund> requestInsuranceRefund({
    required String policyReference,
    required String reason,
    required String accessToken,
  });

  Future<InsuranceRefund> getInsuranceRefundStatus({
    required String policyReference,
    required String accessToken,
  });
}
