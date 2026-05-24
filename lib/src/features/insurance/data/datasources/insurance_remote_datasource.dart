import 'package:grpc/grpc.dart' show CallOptions, GrpcError, StatusCode;
import '../../../../generated/insurance.pbgrpc.dart' as pb;
import '../../../../generated/financial-products.pbgrpc.dart' as fppb;
import '../../../../core/network/grpc_client.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/entities/insurance_product_entity.dart';
import '../../domain/entities/mycover_management_entities.dart';
import '../../domain/entities/insurance_document_upload_url.dart';

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

class InsuranceRemoteDataSourceImpl implements InsuranceRemoteDataSource {
  final GrpcClient grpcClient;

  InsuranceRemoteDataSourceImpl({required this.grpcClient});

  pb.InsuranceServiceClient get _client => grpcClient.insuranceClient;
  fppb.FinancialProductsServiceClient get _fpClient => grpcClient.financialProductsClient;

  /// Retries [op] on TRANSIENT gRPC connection failures only — the
  /// HTTP/2 "connection is being forcefully terminated" / UNAVAILABLE
  /// class that cold channels and mobile networks produce on a request
  /// the user actually triggered (so they'd otherwise see a spurious
  /// "Connection Error" on a product we showed them). Auth and
  /// validation errors (UNAUTHENTICATED, INVALID_ARGUMENT, NOT_FOUND,
  /// etc.) are NOT retried — only transport blips. Safe for the reads;
  /// safe for the purchase too because it carries an idempotency key, so
  /// a replay returns the original result instead of double-charging.
  Future<T> _withTransientRetry<T>(Future<T> Function() op,
      {int attempts = 3}) async {
    for (var i = 0;; i++) {
      try {
        return await op();
      } catch (e) {
        if (!_isTransientConnectionError(e) || i >= attempts - 1) rethrow;
        await Future<void>.delayed(Duration(milliseconds: 400 * (i + 1)));
      }
    }
  }

  bool _isTransientConnectionError(Object e) {
    if (e is GrpcError) {
      if (e.code == StatusCode.unavailable) return true;
      if (e.code == StatusCode.unknown) {
        final m = (e.message ?? '').toLowerCase();
        return m.contains('connection') ||
            m.contains('terminated') ||
            m.contains('http/2') ||
            m.contains('socket');
      }
      return false;
    }
    final s = e.toString().toLowerCase();
    return s.contains('connection is being forcefully terminated') ||
        s.contains('http/2 error') ||
        s.contains('connection terminated');
  }

  @override
  Future<List<Insurance>> getUserInsurances({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserInsurancesRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    // 12s cap so a wedged backend doesn't leave the My Insurances list
    // stuck on a spinner forever.
    final response = await _client
        .getUserInsurances(request, options: options)
        .timeout(
          const Duration(seconds: 12),
          onTimeout: () => throw Exception(
              'Timed out loading policies. Pull to refresh and try again.'),
        );

    return response.insurances.map((proto) => _insuranceFromProto(proto)).toList();
  }

  @override
  Future<UserInsurancesPage> getUserInsurancesPage({
    required String accessToken,
    int page = 1,
    int limit = 15,
  }) async {
    if (page < 1) page = 1;
    if (limit < 1) limit = 15;
    if (limit > 100) limit = 100;
    final request = pb.GetUserInsurancesRequest()
      ..page = page
      ..limit = limit;
    final options = await grpcClient.callOptions;
    final response = await _client
        .getUserInsurances(request, options: options)
        .timeout(
          const Duration(seconds: 12),
          onTimeout: () => throw Exception(
              'Timed out loading policies. Pull to refresh and try again.'),
        );
    final pagination = response.pagination;
    return UserInsurancesPage(
      insurances:
          response.insurances.map((proto) => _insuranceFromProto(proto)).toList(),
      totalItems: pagination.totalItems,
      currentPage: pagination.currentPage > 0 ? pagination.currentPage : page,
      totalPages: pagination.totalPages,
      hasMore: pagination.hasNext,
    );
  }

  @override
  Future<Insurance> getInsuranceById({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.GetInsuranceByIdRequest()..id = id;

    final options = await grpcClient.callOptions;
    // Policy detail load — 12s cap so detail screen doesn't spin forever.
    final response = await _client
        .getInsuranceById(request, options: options)
        .timeout(
          const Duration(seconds: 12),
          onTimeout: () => throw Exception(
              'Timed out loading policy details. Please try again.'),
        );

    return _insuranceFromProto(response.insurance);
  }

  @override
  Future<Insurance> createInsurance({
    required Insurance insurance,
    required String accessToken,
  }) async {
    final request = pb.CreateInsuranceRequest()
      ..insurance = _insuranceToProto(insurance);

    final options = await grpcClient.callOptions;
    final response = await _client.createInsurance(request, options: options);

    return _insuranceFromProto(response.insurance);
  }

  @override
  Future<Insurance> updateInsurance({
    required Insurance insurance,
    required String accessToken,
  }) async {
    final request = pb.UpdateInsuranceRequest()
      ..insurance = _insuranceToProto(insurance);

    final options = await grpcClient.callOptions;
    final response = await _client.updateInsurance(request, options: options);

    return _insuranceFromProto(response.insurance);
  }

  @override
  Future<void> deleteInsurance({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.DeleteInsuranceRequest()..id = id;

    final options = await grpcClient.callOptions;
    await _client.deleteInsurance(request, options: options);
  }

  @override
  Future<List<Insurance>> searchInsurances({
    required String query,
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.SearchInsurancesRequest()
      ..query = query
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.searchInsurances(request, options: options);

    return response.insurances.map((proto) => _insuranceFromProto(proto)).toList();
  }

  @override
  Future<List<InsurancePayment>> getInsurancePayments({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetInsurancePaymentsRequest()
      ..insuranceId = insuranceId
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsurancePayments(request, options: options);

    return response.payments.map((proto) => _paymentFromProto(proto)).toList();
  }

  @override
  Future<List<InsurancePayment>> getUserPayments({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserPaymentsRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserPayments(request, options: options);

    return response.payments.map((proto) => _paymentFromProto(proto)).toList();
  }

  @override
  Future<InsurancePayment> getPaymentById({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.GetPaymentByIdRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await _client.getPaymentById(request, options: options);

    return _paymentFromProto(response.payment);
  }

  @override
  Future<InsurancePayment> createPayment({
    required InsurancePayment payment,
    required String accessToken,
  }) async {
    final request = pb.CreatePaymentRequest()
      ..payment = _paymentToProto(payment);

    final options = await grpcClient.callOptions;
    // 20s cap. Premium charges round-trip through the provider so this
    // is the longest user-facing call in the insurance flow; bound it
    // so the Pay button doesn't appear stuck on a wedged backend.
    final response = await _client
        .createPayment(request, options: options)
        .timeout(
          const Duration(seconds: 20),
          onTimeout: () => throw Exception(
              'Payment took too long. Please check your balance and try again.'),
        );

    return _paymentFromProto(response.payment);
  }

  @override
  Future<List<InsurancePayment>> getOverduePayments({
    required String accessToken,
  }) async {
    final request = pb.GetOverduePaymentsRequest();

    final options = await grpcClient.callOptions;
    final response = await _client.getOverduePayments(request, options: options);

    return response.payments.map((proto) => _paymentFromProto(proto)).toList();
  }

  @override
  Future<List<InsuranceClaim>> getInsuranceClaims({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetInsuranceClaimsRequest()
      ..insuranceId = insuranceId
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceClaims(request, options: options);

    return response.claims.map((proto) => _claimFromProto(proto)).toList();
  }

  @override
  Future<List<InsuranceClaim>> getUserClaims({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserClaimsRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserClaims(request, options: options);

    return response.claims.map((proto) => _claimFromProto(proto)).toList();
  }

  @override
  Future<InsuranceClaim> getClaimById({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.GetClaimByIdRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await _client.getClaimById(request, options: options);

    return _claimFromProto(response.claim);
  }

  @override
  Future<InsuranceClaim> createClaim({
    required InsuranceClaim claim,
    required String accessToken,
  }) async {
    final request = pb.CreateClaimRequest()..claim = _claimToProto(claim);

    final options = await grpcClient.callOptions;
    final response = await _client.createClaim(request, options: options);

    return _claimFromProto(response.claim);
  }

  @override
  Future<InsuranceClaim> updateClaim({
    required InsuranceClaim claim,
    required String accessToken,
  }) async {
    final request = pb.UpdateClaimRequest()..claim = _claimToProto(claim);

    final options = await grpcClient.callOptions;
    final response = await _client.updateClaim(request, options: options);

    return _claimFromProto(response.claim);
  }

  @override
  Future<String> generatePaymentReceipt({
    required String paymentId,
    required String accessToken,
  }) async {
    final request = pb.GeneratePaymentReceiptRequest()..paymentId = paymentId;

    final options = await grpcClient.callOptions;
    final response = await _client.generatePaymentReceipt(request, options: options);

    return response.receiptUrl;
  }

  @override
  Future<List<String>> getUserReceipts({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserReceiptsRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserReceipts(request, options: options);

    return response.receiptUrls;
  }

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics({
    required String accessToken,
  }) async {
    final request = pb.GetInsuranceStatisticsRequest();

    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceStatistics(request, options: options);

    return {
      'total_policies': response.totalPolicies,
      'active_policies': response.activePolicies,
      'expired_policies': response.expiredPolicies,
      'total_coverage_amount': response.totalCoverageAmount,
      'total_premium_amount': response.totalPremiumAmount,
      'policies_by_type': response.policiesByType,
    };
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics({
    required String accessToken,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final request = pb.GetPaymentStatisticsRequest()
      ..startDate = startDate?.toIso8601String() ?? ''
      ..endDate = endDate?.toIso8601String() ?? '';

    final options = await grpcClient.callOptions;
    final response = await _client.getPaymentStatistics(request, options: options);

    return {
      'total_payments': response.totalPayments,
      'completed_payments': response.completedPayments,
      'pending_payments': response.pendingPayments,
      'failed_payments': response.failedPayments,
      'total_amount': response.totalAmount,
      'completed_amount': response.completedAmount,
      'payments_by_method': response.paymentsByMethod,
    };
  }

  // MyCover.ai Marketplace Operations

  @override
  Future<List<InsuranceProduct>> getInsuranceProducts({
    required String accessToken,
    required String locale,
    String? category,
  }) async {
    final request = pb.GetInsuranceProductsRequest()
      ..locale = locale;
    if (category != null && category.isNotEmpty) {
      request.category = category;
    }

    final options = await grpcClient.callOptions;
    final response = await _withTransientRetry(
        () => _client.getInsuranceProducts(request, options: options));

    return response.products.map((p) => _insuranceProductFromProto(p)).toList();
  }

  @override
  Future<InsuranceProductPage> getInsuranceProductsPage({
    required String accessToken,
    required String locale,
    String? category,
    int page = 1,
    int limit = 15,
  }) async {
    if (page < 1) page = 1;
    if (limit < 1) limit = 15;
    if (limit > 100) limit = 100;
    final request = pb.GetInsuranceProductsRequest()
      ..locale = locale
      ..page = page
      ..limit = limit;
    if (category != null && category.isNotEmpty) {
      request.category = category;
    }

    final options = await grpcClient.callOptions;
    final response = await _withTransientRetry(
        () => _client.getInsuranceProducts(request, options: options));
    return InsuranceProductPage(
      products: response.products
          .map((p) => _insuranceProductFromProto(p))
          .toList(),
      total: response.total,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<List<InsuranceCategoryInfo>> getInsuranceCategories({
    required String accessToken,
    required String locale,
  }) async {
    final request = pb.GetInsuranceCategoriesRequest()..locale = locale;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceCategories(request, options: options);

    return response.categories.map((c) => InsuranceCategoryInfo(
      id: c.id,
      name: c.name,
      icon: c.icon,
      description: c.description,
      productCount: c.productCount,
    )).toList();
  }

  @override
  Future<String> getInsuranceTermsLink({
    required String accessToken,
    required String locale,
  }) async {
    final request = pb.GetInsuranceCategoriesRequest()..locale = locale;
    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceCategories(request, options: options);
    return response.termsLink.trim();
  }

  @override
  Future<InsuranceQuote> getInsuranceQuote({
    required String accessToken,
    required String productId,
    required Map<String, String> formData,
    required String locale,
  }) async {
    final request = pb.GetInsuranceQuoteRequest()
      ..productId = productId
      ..locale = locale;
    request.formData.addAll(formData);

    final options = await grpcClient.callOptions;
    // 60-second client cap. Quotes round-trip MyCover's pricing service,
    // and slow providers — travel (compute-travel-premium) in particular —
    // routinely take 30–50s (the travel BUY was measured at ~39s). An 18s
    // cap surfaced a false "took too long" on those before the user could
    // even pay. 60s sits under the backend's 75s MYCOVER_TIMEOUT so a
    // genuinely-wedged backend still can't hang the CTA indefinitely.
    final response = await _withTransientRetry(() => _client
        .getInsuranceQuote(request, options: options)
        .timeout(
          const Duration(seconds: 60),
          onTimeout: () => throw Exception(
              'Quote took too long. Please try again.'),
        ));

    return _quoteFromProto(response.quote);
  }

  @override
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
  }) async {
    final request = fppb.PurchaseMarketplaceInsuranceRequest()
      ..quoteId = quoteId
      ..productId = productId
      ..accountId = accountId
      ..transactionPinToken = transactionPin
      ..idempotencyKey = idempotencyKey
      ..locale = locale
      ..pinTransactionId = transactionId ?? idempotencyKey;

    request.formData.addAll(formData);

    // Purchase needs a longer deadline than the 30s channel default.
    // The backend calls MyCover's /buy endpoint synchronously with a
    // 75s provider timeout (MYCOVER_TIMEOUT), and slow providers —
    // travel insurance in particular — routinely take 30–60s to issue
    // a policy. With the default 30s the client deadline fires while
    // the backend is mid-purchase, the user has already been debited,
    // and the cancelled context can break the backend's refund path.
    // Give the purchase RPC a 90s ceiling (75s provider + hop/processing
    // buffer) so legitimate slow issuances complete instead of
    // surfacing a false "took too long" to a user whose money has moved.
    final baseOptions = await grpcClient.callOptions;
    final options = baseOptions.mergedWith(
      CallOptions(timeout: const Duration(seconds: 90)),
    );
    // Retry on transient connection blips only. Safe to replay: the
    // request carries [idempotencyKey], so the backend's dual-layer
    // idempotency returns the original purchase rather than charging
    // twice. This keeps a user from seeing a spurious failure on a
    // shown product when the channel resets mid-call.
    final response = await _withTransientRetry(() =>
        _fpClient.purchaseMarketplaceInsurance(request, options: options));

    return _marketplacePurchaseResultFromProto(response.result);
  }

  @override
  Future<InsurancePurchaseResult> getInsurancePurchaseStatus({
    required String accessToken,
    required String reference,
  }) async {
    final request = pb.GetInsurancePurchaseStatusRequest()..reference = reference;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsurancePurchaseStatus(request, options: options);

    return _purchaseResultFromProto(response.result);
  }

  @override
  Future<String> uploadInsuranceDocument({
    required String accessToken,
    required List<int> fileData,
    required String filename,
    required String documentType,
  }) async {
    final request = pb.UploadInsuranceDocumentRequest()
      ..fileData = fileData
      ..filename = filename
      ..documentType = documentType;

    final options = await grpcClient.callOptions;
    final response = await _client.uploadInsuranceDocument(request, options: options);

    return response.uploadId;
  }

  @override
  Future<InsuranceDocumentUploadURL> getInsuranceDocumentUploadURL({
    required String accessToken,
    required String filename,
    required String contentType,
    required String documentType,
  }) async {
    final request = fppb.GetInsuranceDocumentUploadURLRequest()
      ..filename = filename
      ..contentType = contentType
      ..documentType = documentType;
    final options = await grpcClient.callOptions;
    final response = await _fpClient.getInsuranceDocumentUploadURL(request, options: options);
    return InsuranceDocumentUploadURL(
      uploadUrl: response.uploadUrl,
      publicUrl: response.publicUrl,
      storageKey: response.storageKey,
      expiresAt: response.expiresAt.toInt(),
    );
  }

  @override
  Future<List<AuxiliaryItem>> getInsuranceAuxiliaryData({
    required String accessToken,
    required String utilityId,
    String? query,
  }) async {
    final request = pb.GetInsuranceAuxiliaryDataRequest()
      ..utilityId = utilityId;
    if (query != null && query.isNotEmpty) {
      request.query = query;
    }

    final options = await grpcClient.callOptions;
    // 12-second client cap so a stuck backend or unreachable MyCover
    // doesn't leave the form's select dropdowns spinning forever. The
    // form's retry UI handles surfacing the failure to the user.
    final response = await _client
        .getInsuranceAuxiliaryData(request, options: options)
        .timeout(
          const Duration(seconds: 12),
          onTimeout: () => throw Exception(
              'Timed out loading options. Please retry.'),
        );

    return response.items.map((item) => AuxiliaryItem(
      label: item.label,
      value: item.value,
    )).toList();
  }

  // MyCover.ai Proto Conversion Helpers

  InsuranceProduct _insuranceProductFromProto(pb.InsuranceProduct proto) {
    return InsuranceProduct(
      id: proto.id,
      name: proto.name,
      description: proto.description,
      category: InsuranceProductCategory.fromString(proto.category),
      providerName: proto.providerName,
      providerLogo: proto.providerLogo,
      minPremium: proto.minPremium,
      maxPremium: proto.maxPremium,
      currency: proto.currency,
      benefits: proto.benefits.toList(),
      termsUrl: proto.termsUrl,
      metadata: Map<String, String>.from(proto.metadata),
      formFields: proto.formFields.map((f) => InsuranceProductFormField(
        name: f.name,
        label: f.label,
        type: f.type,
        required: f.required,
        options: f.options.toList(),
        defaultValue: f.defaultValue,
        validationRegex: f.validationRegex,
        placeholder: f.placeholder,
        description: f.description,
        utilityId: f.utilityId,
        dependsOn: f.dependsOn,
        itemFields: f.itemFields
            .map((sf) => InsuranceProductFormItemField(
                  name: sf.name,
                  label: sf.label,
                  type: sf.type,
                  required: sf.required,
                  options: sf.options.toList(),
                  placeholder: sf.placeholder,
                ))
            .toList(),
      )).toList(),
      isActive: proto.isActive,
      purchaseRoute: proto.purchaseRoute,
      providerId: proto.providerId,
      basePrice: proto.basePrice,
      howItWorks: proto.howItWorks,
      fullBenefits: proto.fullBenefits,
      isRenewable: proto.isRenewable,
      isClaimable: proto.isClaimable,
    );
  }

  InsuranceQuote _quoteFromProto(pb.InsuranceQuote proto) {
    return InsuranceQuote(
      quoteId: proto.quoteId,
      productId: proto.productId,
      premium: proto.premium,
      currency: proto.currency,
      coverageSummary: proto.coverageSummary,
      coverageItems: proto.coverageItems.toList(),
      validUntil: proto.validUntil.isNotEmpty ? DateTime.tryParse(proto.validUntil) : null,
      quoteDetails: Map<String, String>.from(proto.quoteDetails),
    );
  }

  InsurancePurchaseResult _purchaseResultFromProto(pb.InsurancePurchaseResult proto) {
    // Legacy proto only carries the 5 core fields. The richer policy
    // detail (certificate, premium, dates) flows through the marketplace
    // path below.
    return InsurancePurchaseResult(
      policyId: proto.policyId,
      policyNumber: proto.policyNumber,
      reference: proto.reference,
      status: proto.status,
      providerReference: proto.providerReference,
    );
  }

  InsurancePurchaseResult _marketplacePurchaseResultFromProto(fppb.MarketplaceInsurancePurchaseResult proto) {
    return InsurancePurchaseResult(
      policyId: proto.policyId,
      policyNumber: proto.policyNumber,
      reference: proto.reference,
      status: proto.status,
      providerReference: proto.providerReference,
      certificateUrl: proto.certificateUrl,
      premium: proto.hasPremium() ? proto.premium : null,
      currency: proto.currency,
      coverageAmount: proto.hasCoverageAmount() ? proto.coverageAmount : null,
      startDate: proto.startDate.isNotEmpty
          ? DateTime.tryParse(proto.startDate)
          : null,
      endDate: proto.endDate.isNotEmpty
          ? DateTime.tryParse(proto.endDate)
          : null,
    );
  }

  // Conversion Helpers

  DateTime _safeParseDate(String dateStr, [DateTime? fallback]) {
    if (dateStr.isEmpty) return fallback ?? DateTime.now();
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      return fallback ?? DateTime.now();
    }
  }

  Insurance _insuranceFromProto(pb.Insurance proto) {
    return Insurance(
      id: proto.id,
      policyNumber: proto.policyNumber,
      policyHolderName: proto.policyHolderName,
      policyHolderEmail: proto.policyHolderEmail,
      policyHolderPhone: proto.policyHolderPhone,
      type: _parseInsuranceType(proto.type),
      provider: proto.provider,
      providerLogo: proto.providerLogo,
      premiumAmount: proto.premiumAmount,
      coverageAmount: proto.coverageAmount,
      currency: proto.currency,
      startDate: _safeParseDate(proto.startDate),
      endDate: _safeParseDate(proto.endDate),
      nextPaymentDate: _safeParseDate(proto.nextPaymentDate),
      status: _parseInsuranceStatus(proto.status),
      beneficiaries: proto.beneficiaries.toList(),
      coverageDetails: Map<String, dynamic>.from(proto.coverageDetails),
      description: proto.description.isEmpty ? null : proto.description,
      userId: proto.userId,
      createdAt: _safeParseDate(proto.createdAt),
      updatedAt: _safeParseDate(proto.updatedAt),
    );
  }

  pb.Insurance _insuranceToProto(Insurance insurance) {
    return pb.Insurance()
      ..id = insurance.id
      ..policyNumber = insurance.policyNumber
      ..policyHolderName = insurance.policyHolderName
      ..policyHolderEmail = insurance.policyHolderEmail
      ..policyHolderPhone = insurance.policyHolderPhone
      ..type = insurance.type.name
      ..provider = insurance.provider
      ..providerLogo = insurance.providerLogo
      ..premiumAmount = insurance.premiumAmount
      ..coverageAmount = insurance.coverageAmount
      ..currency = insurance.currency
      ..startDate = insurance.startDate.toIso8601String()
      ..endDate = insurance.endDate.toIso8601String()
      ..nextPaymentDate = insurance.nextPaymentDate.toIso8601String()
      ..status = insurance.status.name
      ..beneficiaries.addAll(insurance.beneficiaries)
      ..coverageDetails.addAll(insurance.coverageDetails.map((k, v) => MapEntry(k, v.toString())))
      ..description = insurance.description ?? ''
      ..userId = insurance.userId
      ..createdAt = insurance.createdAt.toIso8601String()
      ..updatedAt = insurance.updatedAt.toIso8601String();
  }

  InsurancePayment _paymentFromProto(pb.InsurancePayment proto) {
    return InsurancePayment(
      id: proto.id,
      insuranceId: proto.insuranceId,
      policyNumber: proto.policyNumber,
      amount: proto.amount,
      currency: proto.currency,
      paymentMethod: _parsePaymentMethod(proto.paymentMethod),
      status: _parsePaymentStatus(proto.status),
      transactionId: proto.transactionId.isEmpty ? null : proto.transactionId,
      referenceNumber: proto.referenceNumber.isEmpty ? null : proto.referenceNumber,
      paymentDate: _safeParseDate(proto.paymentDate),
      dueDate: _safeParseDate(proto.dueDate),
      processedAt: proto.processedAt.isEmpty ? null : _safeParseDate(proto.processedAt),
      paymentDetails: proto.paymentDetails.isEmpty ? {} : Map<String, dynamic>.from(proto.paymentDetails),
      failureReason: proto.failureReason.isEmpty ? null : proto.failureReason,
      receiptUrl: proto.receiptUrl.isEmpty ? null : proto.receiptUrl,
      userId: proto.userId,
      createdAt: _safeParseDate(proto.createdAt),
      updatedAt: _safeParseDate(proto.updatedAt),
    );
  }

  pb.InsurancePayment _paymentToProto(InsurancePayment payment) {
    return pb.InsurancePayment()
      ..id = payment.id
      ..insuranceId = payment.insuranceId
      ..policyNumber = payment.policyNumber
      ..amount = payment.amount
      ..currency = payment.currency
      ..paymentMethod = payment.paymentMethod.name
      ..status = payment.status.name
      ..transactionId = payment.transactionId ?? ''
      ..referenceNumber = payment.referenceNumber ?? ''
      ..paymentDate = payment.paymentDate.toIso8601String()
      ..dueDate = payment.dueDate.toIso8601String()
      ..processedAt = payment.processedAt?.toIso8601String() ?? ''
      ..paymentDetails.addAll((payment.paymentDetails ?? {}).map((k, v) => MapEntry(k, v.toString())))
      ..failureReason = payment.failureReason ?? ''
      ..receiptUrl = payment.receiptUrl ?? ''
      ..userId = payment.userId
      ..createdAt = payment.createdAt.toIso8601String()
      ..updatedAt = payment.updatedAt.toIso8601String();
  }

  InsuranceClaim _claimFromProto(pb.InsuranceClaim proto) {
    return InsuranceClaim(
      id: proto.id,
      claimNumber: proto.claimNumber,
      insuranceId: proto.insuranceId,
      policyNumber: proto.policyNumber,
      type: _parseClaimType(proto.type),
      status: _parseClaimStatus(proto.status),
      title: proto.title,
      description: proto.description,
      claimAmount: proto.claimAmount,
      approvedAmount: proto.approvedAmount == 0 ? null : proto.approvedAmount,
      currency: proto.currency,
      incidentDate: _safeParseDate(proto.incidentDate),
      incidentLocation: proto.incidentLocation,
      attachments: proto.attachments.toList(),
      documents: proto.documents.toList(),
      additionalInfo: Map<String, dynamic>.from(proto.additionalInfo),
      rejectionReason: proto.rejectionReason.isEmpty ? null : proto.rejectionReason,
      settlementDate: proto.settlementDate.isEmpty ? null : _safeParseDate(proto.settlementDate),
      settlementDetails: proto.settlementDetails.isEmpty ? null : proto.settlementDetails,
      userId: proto.userId,
      createdAt: _safeParseDate(proto.createdAt),
      updatedAt: _safeParseDate(proto.updatedAt),
    );
  }

  pb.InsuranceClaim _claimToProto(InsuranceClaim claim) {
    return pb.InsuranceClaim()
      ..id = claim.id
      ..claimNumber = claim.claimNumber
      ..insuranceId = claim.insuranceId
      ..policyNumber = claim.policyNumber
      ..type = claim.type.name
      ..status = claim.status.name
      ..title = claim.title
      ..description = claim.description
      ..claimAmount = claim.claimAmount
      ..approvedAmount = claim.approvedAmount ?? 0.0
      ..currency = claim.currency
      ..incidentDate = claim.incidentDate.toIso8601String()
      ..incidentLocation = claim.incidentLocation
      ..attachments.addAll(claim.attachments)
      ..documents.addAll(claim.documents)
      ..additionalInfo.addAll(claim.additionalInfo.map((k, v) => MapEntry(k, v.toString())))
      ..rejectionReason = claim.rejectionReason ?? ''
      ..settlementDate = claim.settlementDate?.toIso8601String() ?? ''
      ..settlementDetails = claim.settlementDetails ?? ''
      ..userId = claim.userId
      ..createdAt = claim.createdAt.toIso8601String()
      ..updatedAt = claim.updatedAt.toIso8601String();
  }

  InsuranceType _parseInsuranceType(String type) {
    // Defaulting to `health` for unknown values made every marketplace
    // policy render as "Health Insurance" because the backend sends the
    // raw product UUID for marketplace rows. Fall back to `other` (which
    // renders as "Insurance") so the label is at least not actively
    // wrong. Auto / home / etc. still match when the backend sends the
    // category name from local-table rows.
    if (type.isEmpty) return InsuranceType.other;
    try {
      return InsuranceType.values.firstWhere((e) => e.name == type.toLowerCase());
    } catch (_) {
      return InsuranceType.other;
    }
  }

  // ===== MyCover Management API Implementations =====

  @override
  Future<({List<MyCoverCustomer> customers, int total})> getMyCoverCustomers({
    required String accessToken,
    int page = 1,
    int limit = 20,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverCustomers(
      pb.GetMyCoverCustomersRequest(page: page, limit: limit),
      options: options,
    );
    return (
      customers: response.customers.map(_protoToMyCoverCustomer).toList(),
      total: response.total,
    );
  }

  @override
  Future<MyCoverCustomer> getMyCoverCustomerById({
    required String accessToken,
    required String customerId,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverCustomerById(
      pb.GetMyCoverCustomerByIdRequest(customerId: customerId),
      options: options,
    );
    return _protoToMyCoverCustomer(response.customer);
  }

  @override
  Future<({List<MyCoverPolicyDetail> policies, int total})> getMyCoverCustomerPolicies({
    required String accessToken,
    required String customerId,
    int page = 1,
    int limit = 20,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverCustomerPolicies(
      pb.GetMyCoverCustomerPoliciesRequest(customerId: customerId, page: page, limit: limit),
      options: options,
    );
    return (
      policies: response.policies.map(_protoToMyCoverPolicyDetail).toList(),
      total: response.total,
    );
  }

  @override
  Future<({List<MyCoverPurchase> purchases, int total})> getMyCoverCustomerPurchases({
    required String accessToken,
    required String customerId,
    int page = 1,
    int limit = 20,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverCustomerPurchases(
      pb.GetMyCoverCustomerPurchasesRequest(customerId: customerId, page: page, limit: limit),
      options: options,
    );
    return (
      purchases: response.purchases.map(_protoToMyCoverPurchase).toList(),
      total: response.total,
    );
  }

  @override
  Future<({List<MyCoverPurchase> purchases, int total})> getMyCoverPurchases({
    required String accessToken,
    int page = 1,
    int limit = 20,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverPurchases(
      pb.GetMyCoverPurchasesRequest(page: page, limit: limit),
      options: options,
    );
    return (
      purchases: response.purchases.map(_protoToMyCoverPurchase).toList(),
      total: response.total,
    );
  }

  @override
  Future<MyCoverPurchase> getMyCoverPurchaseById({
    required String accessToken,
    required String purchaseId,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverPurchaseById(
      pb.GetMyCoverPurchaseByIdRequest(purchaseId: purchaseId),
      options: options,
    );
    return _protoToMyCoverPurchase(response.purchase);
  }

  @override
  Future<({List<MyCoverProviderClaim> claims, int total})> getMyCoverClaims({
    required String accessToken,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverClaims(
      pb.GetMyCoverClaimsRequest(status: status ?? '', page: page, limit: limit),
      options: options,
    );
    return (
      claims: response.claims.map(_protoToMyCoverProviderClaim).toList(),
      total: response.total,
    );
  }

  @override
  Future<MyCoverProviderClaim> getMyCoverClaimById({
    required String accessToken,
    required String claimId,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverClaimById(
      pb.GetMyCoverClaimByIdRequest(claimId: claimId),
      options: options,
    );
    return _protoToMyCoverProviderClaim(response.claim);
  }

  @override
  Future<({String claimId, String claimNumber, String status})> fileCreditLifeClaim({
    required String accessToken,
    required String policyId,
    required String claimType,
    required String description,
    required double amount,
    List<String>? documents,
    Map<String, String>? additionalInfo,
  }) async {
    final options = await grpcClient.callOptions;
    final req = pb.FileCreditLifeClaimRequest(
      policyId: policyId,
      claimType: claimType,
      description: description,
      amount: amount,
      documents: documents ?? [],
    );
    if (additionalInfo != null && additionalInfo.isNotEmpty) {
      req.additionalInfo.addAll(additionalInfo);
    }
    final response = await _client.fileCreditLifeClaim(req, options: options);
    return (
      claimId: response.claimId,
      claimNumber: response.claimNumber,
      status: response.status,
    );
  }

  @override
  Future<List<AuxiliaryItem>> getInsuranceStates({
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceStates(
      pb.GetInsuranceStatesRequest(),
      options: options,
    );
    return response.states
        .map((s) => AuxiliaryItem(label: s.label, value: s.value))
        .toList();
  }

  @override
  Future<List<AuxiliaryItem>> getInsuranceVehicleMakes({
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceVehicleMakes(
      pb.GetInsuranceVehicleMakesRequest(),
      options: options,
    );
    return response.makes
        .map((m) => AuxiliaryItem(label: m.label, value: m.value))
        .toList();
  }

  // ===== MyCover Proto Converters =====

  MyCoverCustomer _protoToMyCoverCustomer(pb.MyCoverCustomerInfo c) {
    return MyCoverCustomer(
      id: c.id,
      firstName: c.firstName,
      lastName: c.lastName,
      email: c.email,
      phoneNumber: c.phoneNumber,
      gender: c.gender,
      dateOfBirth: c.dateOfBirth,
      createdAt: c.createdAt,
      updatedAt: c.updatedAt,
    );
  }

  MyCoverPurchase _protoToMyCoverPurchase(pb.MyCoverPurchaseInfo p) {
    return MyCoverPurchase(
      id: p.id,
      appMode: p.appMode,
      isRenewal: p.isRenewal,
      amount: p.amount,
      customerId: p.customerId,
      distributorId: p.distributorId,
      paymentChannel: p.paymentChannel,
      paymentOption: p.paymentOption,
      policyId: p.policyId,
      productCategoryId: p.productCategoryId,
      productId: p.productId,
      providerId: p.providerId,
      countryId: p.countryId,
      currencyId: p.currencyId,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      customerName: p.customerName,
      customerEmail: p.customerEmail,
      customerPhone: p.customerPhone,
      policyNumber: p.policyNumber,
      certificateUrl: p.certificateUrl,
      policyIsActive: p.policyIsActive,
      policyAmount: p.policyAmount,
      providerName: p.providerName,
      productName: p.productName,
      productCategoryName: p.productCategoryName,
    );
  }

  MyCoverPolicyDetail _protoToMyCoverPolicyDetail(pb.MyCoverPolicyDetailInfo p) {
    return MyCoverPolicyDetail(
      id: p.id,
      appMode: p.appMode,
      firstName: p.firstName,
      lastName: p.lastName,
      email: p.email,
      phoneNumber: p.phoneNumber,
      dateOfBirth: p.dateOfBirth,
      activationDate: p.activationDate,
      startDate: p.startDate,
      expirationDate: p.expirationDate,
      amount: p.amount,
      isActive: p.isActive,
      isSubmittedToProvider: p.isSubmittedToProvider,
      customerId: p.customerId,
      productId: p.productId,
      productCategoryId: p.productCategoryId,
      providerId: p.providerId,
      purchaseId: p.purchaseId,
      policyNumber: p.policyNumber,
      certificateUrl: p.certificateUrl,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
      providerName: p.providerName,
      productName: p.productName,
    );
  }

  MyCoverProviderClaim _protoToMyCoverProviderClaim(pb.MyCoverClaimInfo c) {
    return MyCoverProviderClaim(
      id: c.id,
      status: c.status,
      type: c.type,
      amount: c.amount,
      description: c.description,
      policyId: c.policyId,
      customerId: c.customerId,
      claimNumber: c.claimNumber,
      documents: c.documents.toList(),
      rejectionReason: c.rejectionReason,
      approvedAmount: c.approvedAmount,
      createdAt: c.createdAt,
      updatedAt: c.updatedAt,
    );
  }

  InsuranceStatus _parseInsuranceStatus(String status) {
    // Backend uses snake_case for multi-word statuses
    // (e.g. `refund_pending`, `manual_review`, `awaiting_webhook`);
    // Dart enum names are camelCase (`refundPending`, `manualReview`,
    // `awaitingWebhook`). Normalize before matching.
    final wire = status.toLowerCase().trim();
    final normalized = wire.replaceAllMapped(
      RegExp(r'_(\w)'),
      (m) => m.group(1)!.toUpperCase(),
    );
    // The marketplace `insurance_purchases.status` enum has no
    // `active`/`expired` values — those are derived states.
    // `completed` is the terminal "policy is live with the provider"
    // state and should surface as Active. `failed` means the purchase
    // never reached MyCover and is effectively a no-op for the user;
    // surface it as Cancelled (refunded, not active). Active expiry is
    // computed in Insurance.isExpired via the end_date, so we never
    // need to map a wire status to `expired`.
    const wireAlias = <String, InsuranceStatus>{
      'completed': InsuranceStatus.active,
      'failed': InsuranceStatus.cancelled,
    };
    if (wireAlias.containsKey(wire)) return wireAlias[wire]!;
    try {
      return InsuranceStatus.values.firstWhere((e) => e.name == normalized);
    } catch (_) {
      try {
        return InsuranceStatus.values.firstWhere((e) => e.name == wire);
      } catch (_) {
        return InsuranceStatus.pending; // Default fallback
      }
    }
  }

  PaymentMethod _parsePaymentMethod(String method) {
    final normalized = method.toLowerCase().trim();
    // Backend sends snake_case (e.g. "mycover_hosted_renewal"); enum names
    // are camelCase. Map the known snake_case values explicitly, then fall
    // back to a direct name match for the simple ones (wallet, card, ...).
    switch (normalized) {
      case 'mycover_hosted_renewal':
        return PaymentMethod.mycoverHostedRenewal;
      case 'bank_transfer':
        return PaymentMethod.bankTransfer;
      case 'mobile_money':
        return PaymentMethod.mobileMoney;
    }
    try {
      return PaymentMethod.values.firstWhere((e) => e.name == normalized);
    } catch (e) {
      return PaymentMethod.wallet; // Default fallback
    }
  }

  PaymentStatus _parsePaymentStatus(String status) {
    try {
      return PaymentStatus.values.firstWhere((e) => e.name == status.toLowerCase());
    } catch (e) {
      return PaymentStatus.pending; // Default fallback
    }
  }

  ClaimType _parseClaimType(String type) {
    try {
      return ClaimType.values.firstWhere((e) => e.name == type.toLowerCase());
    } catch (e) {
      return ClaimType.other; // Default fallback
    }
  }

  ClaimStatus _parseClaimStatus(String status) {
    // Backend uses snake_case for multi-word statuses
    // (e.g. `under_review`, `offer_sent`); Dart enum names are camelCase
    // (`underReview`, `offerSent`). Normalize both sides before
    // matching, and fall through to `submitted` for unknown values so a
    // future MyCover state can't crash the deserialiser.
    final wire = status.toLowerCase().trim();
    final normalized = wire.replaceAllMapped(
      RegExp(r'_(\w)'),
      (m) => m.group(1)!.toUpperCase(),
    );
    try {
      return ClaimStatus.values.firstWhere((e) => e.name == normalized);
    } catch (_) {
      try {
        return ClaimStatus.values.firstWhere((e) => e.name == wire);
      } catch (_) {
        return ClaimStatus.submitted;
      }
    }
  }

  @override
  Future<List<MyCoverNotificationPref>> getMyCoverNotificationPreferences({
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverNotificationPreferences(
      pb.GetMyCoverNotificationPreferencesRequest(),
      options: options,
    );
    return response.preferences
        .map((p) => MyCoverNotificationPref(
              key: p.key,
              category: p.category,
              label: p.label,
              description: p.description,
              enabled: p.enabled,
            ))
        .toList();
  }

  @override
  Future<void> updateMyCoverNotificationPreferences({
    required List<MyCoverNotificationPref> preferences,
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final protoPrefs = preferences
        .map((p) => pb.MyCoverNotificationPreference(
              key: p.key,
              category: p.category,
              label: p.label,
              description: p.description,
              enabled: p.enabled,
            ))
        .toList();
    await _client.updateMyCoverNotificationPreferences(
      pb.UpdateMyCoverNotificationPreferencesRequest(preferences: protoPrefs),
      options: options,
    );
  }

  @override
  Future<MyCoverWalletBalance> getMyCoverWalletBalance({
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getMyCoverWalletBalance(
      pb.GetMyCoverWalletBalanceRequest(),
      options: options,
    );
    return MyCoverWalletBalance(
      balance: response.balance,
      currency: response.currency.isNotEmpty ? response.currency : 'NGN',
    );
  }

  @override
  Future<InsuranceRefund> requestInsuranceRefund({
    required String policyReference,
    required String reason,
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.requestInsuranceRefund(
      pb.RequestInsuranceRefundRequest(
        policyReference: policyReference,
        reason: reason,
      ),
      options: options,
    );
    return _protoToInsuranceRefund(response.refund);
  }

  @override
  Future<InsuranceRefund> getInsuranceRefundStatus({
    required String policyReference,
    required String accessToken,
  }) async {
    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceRefundStatus(
      pb.GetInsuranceRefundStatusRequest(policyReference: policyReference),
      options: options,
    );
    return _protoToInsuranceRefund(response.refund);
  }

  InsuranceRefund _protoToInsuranceRefund(pb.InsuranceRefundInfo r) {
    return InsuranceRefund(
      refundId: r.refundId,
      policyReference: r.policyReference,
      status: r.status,
      amount: r.amount,
      currency: r.currency.isNotEmpty ? r.currency : 'NGN',
      providerRefunded: r.providerRefunded,
      walletCredited: r.walletCredited,
      reason: r.reason,
      failureReason: r.failureReason,
      initiatedAt: r.initiatedAt,
      completedAt: r.completedAt,
    );
  }
}
