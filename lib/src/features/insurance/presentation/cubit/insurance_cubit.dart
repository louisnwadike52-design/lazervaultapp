import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  /// Get the current user ID, return guest if not set
  String get currentUserId => _currentUserId ?? 'guest_user';

  /// Load all insurances for the current user
  Future<void> loadInsurances() async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      final insurances = await repository.getUserInsurances(currentUserId);
      if (isClosed) return;
      final recentPayments = await repository.getUserPayments(currentUserId);
      if (isClosed) return;
      final overduePayments = await repository.getOverduePayments(currentUserId);
      if (isClosed) return;
      final statistics = await repository.getInsuranceStatistics(currentUserId);
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

  /// Load details for a specific insurance policy
  Future<void> loadInsuranceDetails(String insuranceId) async {
    try {
      if (isClosed) return;
      emit(InsuranceLoading());

      final insurance = await repository.getInsuranceById(insuranceId);
      if (isClosed) return;
      if (insurance == null) {
        emit(const InsuranceError('Insurance not found'));
        return;
      }

      final payments = await repository.getInsurancePayments(insuranceId);
      if (isClosed) return;
      final claims = await repository.getInsuranceClaims(insuranceId);
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

      // Then load payments and claims in the background
      final payments = await repository.getInsurancePayments(insurance.id);
      if (isClosed) return;
      final claims = await repository.getInsuranceClaims(insurance.id);
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

  /// Process a premium payment
  Future<void> processPayment(InsurancePayment payment) async {
    try {
      if (isClosed) return;
      emit(PaymentProcessing(
        payment: payment,
        step: 'Initializing payment...',
        progress: 0.1,
      ));

      // Simulate payment processing steps
      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;
      emit(PaymentProcessing(
        payment: payment,
        step: 'Verifying payment method...',
        progress: 0.3,
      ));

      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;
      emit(PaymentProcessing(
        payment: payment,
        step: 'Processing payment...',
        progress: 0.6,
      ));

      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;
      emit(PaymentProcessing(
        payment: payment,
        step: 'Confirming transaction...',
        progress: 0.8,
      ));

      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;

      // Simulate payment success/failure (90% success rate)
      final random = Random();
      final isSuccess = random.nextDouble() > 0.1;

      if (isSuccess) {
        final completedPayment = payment.copyWith(
          status: PaymentStatus.completed,
          processedAt: DateTime.now(),
          transactionId: 'TXN${random.nextInt(999999).toString().padLeft(6, '0')}',
          referenceNumber: 'REF${random.nextInt(999999).toString().padLeft(6, '0')}',
        );

        await repository.updatePayment(completedPayment);
        if (isClosed) return;
        final receiptUrl = await repository.generatePaymentReceipt(completedPayment.id);
        if (isClosed) return;

        emit(PaymentCompleted(
          payment: completedPayment,
          receiptUrl: receiptUrl,
        ));
      } else {
        final failedPayment = payment.copyWith(
          status: PaymentStatus.failed,
          failureReason: 'Payment processing failed. Please try again.',
        );

        await repository.updatePayment(failedPayment);
        if (isClosed) return;

        emit(PaymentFailed(
          payment: failedPayment,
          error: 'Payment processing failed. Please try again.',
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
      id: 'PAY${Random().nextInt(999999).toString().padLeft(6, '0')}',
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
      emit(InsuranceLoading());

      final claims = await repository.getUserClaims(currentUserId);
      if (isClosed) return;
      emit(ClaimsLoaded(claims));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError('Failed to load claims: ${e.toString()}'));
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
      emit(InsuranceLoading());

      final results = await repository.searchInsurances(query, currentUserId);
      if (isClosed) return;
      emit(InsuranceSearchResults(results: results, query: query));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError('Failed to search insurances: ${e.toString()}'));
    }
  }

  /// Get sample insurance data for demo
  Insurance getSampleInsurance() {
    final random = Random();
    final types = InsuranceType.values;
    final statuses = [InsuranceStatus.active, InsuranceStatus.pending];
    final providers = ['SafeGuard Insurance', 'ProtectPlus', 'SecureLife', 'TrustCover'];
    
    final type = types[random.nextInt(types.length)];
    final provider = providers[random.nextInt(providers.length)];
    
    return Insurance(
      id: 'INS${random.nextInt(999999).toString().padLeft(6, '0')}',
      policyNumber: 'POL${random.nextInt(9999999).toString().padLeft(7, '0')}',
      policyHolderName: 'John Doe',
      policyHolderEmail: 'john.doe@example.com',
      policyHolderPhone: '+1234567890',
      type: type,
      provider: provider,
      providerLogo: 'https://via.placeholder.com/100x100?text=${provider[0]}',
      premiumAmount: 100.0 + random.nextDouble() * 500.0,
      coverageAmount: 10000.0 + random.nextDouble() * 90000.0,
      currency: 'USD',
      startDate: DateTime.now().subtract(Duration(days: random.nextInt(365))),
      endDate: DateTime.now().add(Duration(days: 365 + random.nextInt(365))),
      nextPaymentDate: DateTime.now().add(Duration(days: random.nextInt(30))),
      status: statuses[random.nextInt(statuses.length)],
      beneficiaries: ['Jane Doe', 'John Doe Jr.'],
      coverageDetails: {
        'deductible': 500.0 + random.nextDouble() * 1500.0,
        'coverage_limit': 50000.0 + random.nextDouble() * 50000.0,
        'features': ['24/7 Support', 'Online Claims', 'Mobile App'],
      },
      description: 'Comprehensive ${type.displayName.toLowerCase()} coverage',
      createdAt: DateTime.now().subtract(Duration(days: random.nextInt(365))),
      updatedAt: DateTime.now(),
      userId: currentUserId,
    );
  }
} 