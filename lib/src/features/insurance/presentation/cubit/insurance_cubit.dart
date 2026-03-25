import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/entities/mycover_management_entities.dart';
import '../../domain/repositories/insurance_repository.dart';
import 'insurance_state.dart';

class InsuranceCubit extends Cubit<InsuranceState> {
  final InsuranceRepository repository;
  String? _currentUserId;

  InsuranceCubit({
    required this.repository,
  }) : super(InsuranceInitial());

  /// Convert raw errors into user-friendly messages
  String _friendlyError(dynamic error, String fallback) {
    final msg = error.toString().toLowerCase();
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.unavailable:
          return 'Unable to connect to insurance service. Please check your connection and try again.';
        case StatusCode.deadlineExceeded:
          return 'Request timed out. Please try again.';
        case StatusCode.unauthenticated:
          return 'Your session has expired. Please log in again.';
        case StatusCode.permissionDenied:
          return 'You don\'t have permission for this action.';
        case StatusCode.notFound:
          return 'The requested insurance policy was not found.';
        case StatusCode.unimplemented:
          return 'This feature is not yet available. Stay tuned!';
        default:
          return error.message?.isNotEmpty == true ? error.message! : fallback;
      }
    }
    if (msg.contains('connection') || msg.contains('socket') || msg.contains('network')) {
      return 'Unable to connect. Please check your internet connection.';
    }
    if (msg.contains('timeout') || msg.contains('deadline')) {
      return 'Request timed out. Please try again.';
    }
    return fallback;
  }

  /// Set the current user ID when authentication state changes
  void setUserId(String userId) {
    if (_currentUserId != userId) {
      _currentUserId = userId;
      // Reload data when user changes
      if (userId.isNotEmpty) {
        loadInsurances();
      }
    }
  }

  /// Get the current user ID
  String get currentUserId => _currentUserId ?? '';

  /// Check if user is authenticated
  bool get _isAuthenticated => _currentUserId != null && _currentUserId!.isNotEmpty;

  bool _isLoadingInsurances = false;

  /// Load all insurances for the current user
  Future<void> loadInsurances() async {
    try {
      if (isClosed) return;
      if (!_isAuthenticated) {
        emit(const InsuranceError('Please log in to view insurance'));
        return;
      }
      if (_isLoadingInsurances) return;
      _isLoadingInsurances = true;
      emit(InsuranceLoading());

      final insurances = await repository.getUserInsurances(currentUserId);
      if (isClosed) return;

      // These RPCs may not be implemented yet - provide empty defaults
      final recentPayments = await _safeCall(() => repository.getUserPayments(currentUserId), <InsurancePayment>[]);
      if (isClosed) return;
      final overduePayments = await _safeCall(() => repository.getOverduePayments(currentUserId), <InsurancePayment>[]);
      if (isClosed) return;
      final statistics = await _safeCall(() => repository.getInsuranceStatistics(currentUserId), <String, dynamic>{});
      if (isClosed) return;

      emit(InsurancesLoaded(
        insurances: insurances,
        recentPayments: recentPayments.take(5).toList(),
        overduePayments: overduePayments,
        statistics: statistics,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load insurance policies. Please try again.')));
    } finally {
      _isLoadingInsurances = false;
    }
  }

  /// Safely call an RPC, returning a default value if the RPC is unimplemented
  Future<T> _safeCall<T>(Future<T> Function() call, T defaultValue) async {
    try {
      return await call();
    } on GrpcError catch (e) {
      if (e.code == StatusCode.unimplemented) {
        return defaultValue;
      }
      rethrow;
    }
  }

  /// Load details for a specific insurance policy
  Future<void> loadInsuranceDetails(String insuranceId) async {
    try {
      if (isClosed) return;
      if (!_isAuthenticated) {
        emit(const InsuranceError('Please log in to view insurance'));
        return;
      }
      emit(InsuranceLoading());

      final insurance = await repository.getInsuranceById(insuranceId);
      if (isClosed) return;
      if (insurance == null) {
        emit(const InsuranceError('Insurance not found'));
        return;
      }

      final payments = await _safeCall(() => repository.getInsurancePayments(insuranceId), <InsurancePayment>[]);
      if (isClosed) return;
      final claims = await _safeCall(() => repository.getInsuranceClaims(insuranceId), <InsuranceClaim>[]);
      if (isClosed) return;

      emit(InsuranceDetailsLoaded(
        insurance: insurance,
        payments: payments,
        claims: claims,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load insurance details. Please try again.')));
    }
  }

  /// Load details with provided insurance data (simulates API approach)
  Future<void> loadInsuranceDetailsWithData(Insurance insurance) async {
    try {
      // Immediately emit the state with the provided insurance data
      // and empty payments/claims to show the screen right away
      if (isClosed) return;
      emit(InsuranceDetailsLoaded(
        insurance: insurance,
        payments: [],
        claims: [],
      ));

      // Then load payments and claims in the background (may be unimplemented)
      final payments = await _safeCall(() => repository.getInsurancePayments(insurance.id), <InsurancePayment>[]);
      if (isClosed) return;
      final claims = await _safeCall(() => repository.getInsuranceClaims(insurance.id), <InsuranceClaim>[]);
      if (isClosed) return;

      // Update the state with loaded payments and claims
      emit(InsuranceDetailsLoaded(
        insurance: insurance,
        payments: payments,
        claims: claims,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load insurance details. Please try again.')));
    }
  }

  /// Create a new insurance policy
  Future<void> createInsurance(Insurance insurance) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      final createdInsurance = await repository.createInsurance(insurance);
      if (isClosed) return;
      emit(InsuranceCreated(createdInsurance));

      // Reload insurances
      await loadInsurances();
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to create insurance policy. Please try again.')));
    }
  }

  /// Update an existing insurance policy
  Future<void> updateInsurance(Insurance insurance) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      final updatedInsurance = await repository.updateInsurance(insurance);
      if (isClosed) return;
      emit(InsuranceUpdated(updatedInsurance));

      // Reload insurances
      await loadInsurances();
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to update insurance. Please try again.')));
    }
  }

  /// Delete an insurance policy
  Future<void> deleteInsurance(String insuranceId) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      await repository.deleteInsurance(insuranceId);
      if (isClosed) return;
      emit(InsuranceDeleted(insuranceId));

      // Reload insurances
      await loadInsurances();
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to cancel insurance. Please try again.')));
    }
  }

  /// Process a premium payment via the backend
  Future<void> processPayment(InsurancePayment payment) async {
    try {
      if (isClosed) return;
      emit(PaymentProcessing(
        payment: payment,
        step: 'Processing payment...',
        progress: 0.5,
      ));

      // Submit payment to backend - backend handles actual processing
      final createdPayment = await repository.createPayment(payment);
      if (isClosed) return;

      // Check payment result status
      if (createdPayment.status == PaymentStatus.completed) {
        final receiptUrl = await repository.generatePaymentReceipt(createdPayment.id);
        if (isClosed) return;

        emit(PaymentCompleted(
          payment: createdPayment,
          receiptUrl: receiptUrl,
        ));
      } else if (createdPayment.status == PaymentStatus.failed) {
        emit(PaymentFailed(
          payment: createdPayment,
          error: createdPayment.failureReason ?? 'Payment processing failed. Please try again.',
        ));
      } else {
        // Payment is pending - emit completed with the pending payment
        emit(PaymentCompleted(
          payment: createdPayment,
          receiptUrl: '',
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PaymentFailed(
        payment: payment,
        error: _friendlyError(e, 'Payment processing failed. Please try again.'),
      ));
    }
  }

  /// Create a payment for a specific insurance
  Future<InsurancePayment> createPayment({
    required String insuranceId,
    required String policyNumber,
    required double amount,
    required PaymentMethod paymentMethod,
  }) async {
    final payment = InsurancePayment(
      id: '',
      insuranceId: insuranceId,
      policyNumber: policyNumber,
      amount: amount,
      currency: 'USD',
      paymentMethod: paymentMethod,
      status: PaymentStatus.pending,
      paymentDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 30)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: currentUserId,
    );

    return await repository.createPayment(payment);
  }

  /// Submit an insurance claim
  Future<void> submitClaim(InsuranceClaim claim) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      final submittedClaim = await repository.createClaim(claim);
      if (isClosed) return;
      emit(ClaimSubmitted(submittedClaim));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to submit claim. Please try again.')));
    }
  }

  /// Load user claims
  Future<void> loadUserClaims() async {
    try {
      if (isClosed) return;
      if (!_isAuthenticated) {
        emit(const InsuranceError('Please log in to view claims'));
        return;
      }
      emit(InsuranceLoading());

      final claims = await repository.getUserClaims(currentUserId);
      if (isClosed) return;
      emit(ClaimsLoaded(claims));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load claims. Please try again.')));
    }
  }

  /// Update a claim (e.g. cancel it)
  Future<void> updateClaim(InsuranceClaim claim) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      final updatedClaim = await repository.updateClaim(claim);
      if (isClosed) return;
      emit(ClaimUpdated(updatedClaim));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to update claim. Please try again.')));
    }
  }

  /// Get a single claim by ID
  Future<InsuranceClaim?> getClaimById(String claimId) async {
    try {
      return await repository.getClaimById(claimId);
    } catch (e) {
      if (isClosed) return null;
      emit(InsuranceError(_friendlyError(e, 'Failed to load claim details.')));
      return null;
    }
  }

  /// Search insurances
  Future<void> searchInsurances(String query) async {
    try {
      if (query.isEmpty) {
        await loadInsurances();
        return;
      }

      if (isClosed) return;
      if (!_isAuthenticated) {
        emit(const InsuranceError('Please log in to search insurance'));
        return;
      }
      emit(InsuranceLoading());

      final results = await repository.searchInsurances(query, currentUserId);
      if (isClosed) return;
      emit(InsuranceSearchResults(results: results, query: query));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Search failed. Please try again.')));
    }
  }

  // ===== MyCover Management Methods =====

  Future<void> loadMyCoverCustomers({int page = 1, int limit = 20}) async {
    try {
      if (isClosed) return;
      final currentState = state;
      // Only show full loading on first page
      if (page == 1) {
        emit(InsuranceLoading());
      }
      final result = await repository.getMyCoverCustomers(page: page, limit: limit);
      if (isClosed) return;
      final hasMore = result.customers.length >= limit && (page * limit) < result.total;
      if (page > 1 && currentState is MyCoverCustomersLoaded) {
        emit(MyCoverCustomersLoaded(
          customers: [...currentState.customers, ...result.customers],
          total: result.total,
          currentPage: page,
          hasMore: hasMore,
        ));
      } else {
        emit(MyCoverCustomersLoaded(
          customers: result.customers,
          total: result.total,
          currentPage: page,
          hasMore: hasMore,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load customers. Please try again.')));
    }
  }

  Future<void> loadMyCoverCustomerDetail(String customerId) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final customer = await repository.getMyCoverCustomerById(customerId);
      if (isClosed) return;
      final policiesResult = await repository.getMyCoverCustomerPolicies(customerId);
      if (isClosed) return;
      final purchasesResult = await repository.getMyCoverCustomerPurchases(customerId);
      if (isClosed) return;
      emit(MyCoverCustomerDetailLoaded(
        customer: customer,
        policies: policiesResult.policies,
        purchases: purchasesResult.purchases,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load customer details.')));
    }
  }

  Future<void> loadMyCoverPurchases({int page = 1, int limit = 20}) async {
    try {
      if (isClosed) return;
      final currentState = state;
      if (page == 1) {
        emit(InsuranceLoading());
      }
      final result = await repository.getMyCoverPurchases(page: page, limit: limit);
      if (isClosed) return;
      final hasMore = result.purchases.length >= limit && (page * limit) < result.total;
      if (page > 1 && currentState is MyCoverPurchasesLoaded) {
        emit(MyCoverPurchasesLoaded(
          purchases: [...currentState.purchases, ...result.purchases],
          total: result.total,
          currentPage: page,
          hasMore: hasMore,
        ));
      } else {
        emit(MyCoverPurchasesLoaded(
          purchases: result.purchases,
          total: result.total,
          currentPage: page,
          hasMore: hasMore,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load purchases.')));
    }
  }

  Future<void> loadMyCoverPurchaseDetail(String purchaseId) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final purchase = await repository.getMyCoverPurchaseById(purchaseId);
      if (isClosed) return;
      emit(MyCoverPurchaseDetailLoaded(purchase));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load purchase details.')));
    }
  }

  Future<void> loadMyCoverProviderClaims({String? status, int page = 1, int limit = 20}) async {
    try {
      if (isClosed) return;
      final currentState = state;
      if (page == 1) {
        emit(InsuranceLoading());
      }
      final result = await repository.getMyCoverClaims(status: status, page: page, limit: limit);
      if (isClosed) return;
      final hasMore = result.claims.length >= limit && (page * limit) < result.total;
      if (page > 1 && currentState is MyCoverProviderClaimsLoaded) {
        emit(MyCoverProviderClaimsLoaded(
          claims: [...currentState.claims, ...result.claims],
          total: result.total,
          currentPage: page,
          hasMore: hasMore,
        ));
      } else {
        emit(MyCoverProviderClaimsLoaded(
          claims: result.claims,
          total: result.total,
          currentPage: page,
          hasMore: hasMore,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load claims.')));
    }
  }

  Future<void> loadMyCoverProviderClaimDetail(String claimId) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final claim = await repository.getMyCoverClaimById(claimId);
      if (isClosed) return;
      emit(MyCoverProviderClaimDetailLoaded(claim));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load claim details.')));
    }
  }

  Future<void> fileCreditLifeClaim({
    required String policyId,
    required String claimType,
    required String description,
    required double amount,
    List<String>? documents,
    Map<String, String>? additionalInfo,
  }) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final result = await repository.fileCreditLifeClaim(
        policyId: policyId,
        claimType: claimType,
        description: description,
        amount: amount,
        documents: documents,
        additionalInfo: additionalInfo,
      );
      if (isClosed) return;
      emit(CreditLifeClaimFiled(
        claimId: result.claimId,
        claimNumber: result.claimNumber,
        status: result.status,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to file claim. Please try again.')));
    }
  }

  /// Upload an insurance document (for claims evidence, etc.)
  Future<String> uploadInsuranceDocument({
    required List<int> fileData,
    required String filename,
    required String documentType,
  }) async {
    return await repository.uploadInsuranceDocument(
      fileData: fileData,
      filename: filename,
      documentType: documentType,
    );
  }

  // ===== Notification Preferences =====

  Future<void> loadMyCoverNotificationPreferences() async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final prefs = await repository.getMyCoverNotificationPreferences();
      if (isClosed) return;
      emit(MyCoverNotificationPrefsLoaded(prefs));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load notification settings.')));
    }
  }

  Future<void> updateMyCoverNotificationPreferences(List<MyCoverNotificationPref> preferences) async {
    try {
      if (isClosed) return;
      await repository.updateMyCoverNotificationPreferences(preferences);
      if (isClosed) return;
      emit(MyCoverNotificationPrefsUpdated());
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to update notification settings.')));
    }
  }

  // ===== Wallet & Refund =====

  Future<void> loadMyCoverWalletBalance() async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final balance = await repository.getMyCoverWalletBalance();
      if (isClosed) return;
      emit(MyCoverWalletBalanceLoaded(balance));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load wallet balance.')));
    }
  }

  Future<void> requestInsuranceRefund({
    required String policyReference,
    required String reason,
  }) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final refund = await repository.requestInsuranceRefund(
        policyReference: policyReference,
        reason: reason,
      );
      if (isClosed) return;
      emit(InsuranceRefundRequested(refund));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to request refund. Please try again.')));
    }
  }

  Future<void> getInsuranceRefundStatus(String policyReference) async {
    try {
      if (isClosed) return;
      final refund = await repository.getInsuranceRefundStatus(policyReference);
      if (isClosed) return;
      emit(InsuranceRefundStatusLoaded(refund));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to check refund status.')));
    }
  }

  /// Cancel policy and request refund in one step.
  /// Uses the MyCover refund API which handles cancellation + refund together.
  Future<void> cancelPolicyAndRefund({
    required String policyReference,
    required String reason,
  }) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());
      final refund = await repository.requestInsuranceRefund(
        policyReference: policyReference,
        reason: reason,
      );
      if (isClosed) return;
      emit(InsuranceRefundRequested(refund));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to cancel policy. Please try again.')));
    }
  }
} 