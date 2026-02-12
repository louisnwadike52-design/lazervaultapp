import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import 'insurance_state.dart';

class InsuranceCubit extends Cubit<InsuranceState> {
  final InsuranceRepository repository;
  String? _currentUserId;

  InsuranceCubit({
    required this.repository,
  }) : super(InsuranceInitial());

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

  /// Load all insurances for the current user
  Future<void> loadInsurances() async {
    try {
      if (isClosed) return;
      if (!_isAuthenticated) {
        emit(const InsuranceError('Please log in to view insurance'));
        return;
      }
      if (state is InsuranceLoading) return;
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
      emit(InsuranceError('Failed to load insurances: ${e.toString()}'));
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
    } on Exception catch (e) {
      if (e.toString().contains('Unimplemented') || e.toString().contains('not yet available')) {
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
      emit(InsuranceError('Failed to load insurance details: ${e.toString()}'));
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
      emit(InsuranceError('Failed to load insurance details: ${e.toString()}'));
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
      emit(InsuranceError('Failed to create insurance: ${e.toString()}'));
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
      emit(InsuranceError('Failed to update insurance: ${e.toString()}'));
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
      emit(InsuranceError('Failed to delete insurance: ${e.toString()}'));
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
        error: 'Payment failed: ${e.toString()}',
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
      emit(InsuranceError('Failed to submit claim: ${e.toString()}'));
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
      emit(InsuranceError('Failed to load claims: ${e.toString()}'));
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
      emit(InsuranceError('Failed to update claim: ${e.toString()}'));
    }
  }

  /// Get a single claim by ID
  Future<InsuranceClaim?> getClaimById(String claimId) async {
    try {
      return await repository.getClaimById(claimId);
    } catch (e) {
      if (isClosed) return null;
      emit(InsuranceError('Failed to load claim: ${e.toString()}'));
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
      emit(InsuranceError('Failed to search insurances: ${e.toString()}'));
    }
  }

} 