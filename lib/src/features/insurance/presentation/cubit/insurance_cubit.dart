import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/entities/mycover_management_entities.dart';
import '../../domain/repositories/insurance_repository.dart';
import 'insurance_state.dart';

class InsuranceCubit extends Cubit<InsuranceState> {
  final InsuranceRepository repository;
  // Optional: when present, the cubit subscribes to insurance_*
  // WS events so the policy list refreshes the moment a purchase
  // completes or a renewal lands, without waiting on a pull-to-refresh.
  // Optional so unit tests can construct without GetIt.
  final BalanceWebSocketService? wsService;
  StreamSubscription<InsurancePurchaseEvent>? _purchaseEventSub;
  String? _currentUserId;

  InsuranceCubit({
    required this.repository,
    this.wsService,
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
        _subscribeToInsuranceEvents();
      } else {
        _purchaseEventSub?.cancel();
        _purchaseEventSub = null;
      }
    }
  }

  /// Subscribe to ws-balance-service insurance events so the policy
  /// list refreshes in real time. Events of interest:
  ///   * insurance_purchase_completed — a new policy just landed
  ///   * insurance_purchase_failed / refunded / refund_failed —
  ///     the in-flight purchase reached a terminal state; refetch so
  ///     the list reflects the post-saga truth.
  ///   * insurance_policy_renewed — policy_end_date moved forward;
  ///     refetch so Renewal Date + the Renew CTA reflect the new term.
  ///
  /// The subscription is best-effort: if wsService is null (unit tests)
  /// or the channel is down, we silently fall back to manual refreshes.
  /// Filters on userId so multi-user environments don't cross-react.
  void _subscribeToInsuranceEvents() {
    if (wsService == null) return;
    _purchaseEventSub?.cancel();
    _purchaseEventSub = wsService!.insurancePurchaseEvents.listen((event) {
      if (event.userId.isNotEmpty &&
          _currentUserId != null &&
          event.userId != _currentUserId) {
        return;
      }
      // Refetch unconditionally — every event we care about either
      // adds a policy, changes a policy's status, or moves an expiry
      // date. Cheap re-fetch is simpler than diffing here.
      loadInsurances();
    });
  }

  /// Get the current user ID
  String get currentUserId => _currentUserId ?? '';

  /// Check if user is authenticated
  bool get _isAuthenticated => _currentUserId != null && _currentUserId!.isNotEmpty;

  bool _isLoadingInsurances = false;
  // Slice 4 race guard: same pattern as CreatePolicyCubit. Increments
  // every time loadInsurances starts a new first-page fetch; any
  // in-flight loadMoreInsurances whose generation no longer matches
  // drops its emit on completion. Prevents stale appends after a
  // pull-to-refresh.
  int _insurancesLoadGeneration = 0;

  /// Load the first page of insurances for the current user.
  ///
  /// Slice 4: switched to the paginated repo entry point so the resulting
  /// state carries hasMore/currentPage and the UI can scroll-load further
  /// pages via loadMoreInsurances.
  Future<void> loadInsurances({int limit = 15}) async {
    try {
      if (isClosed) return;
      if (!_isAuthenticated) {
        emit(const InsuranceError('Please log in to view insurance'));
        return;
      }
      if (_isLoadingInsurances) return;
      _isLoadingInsurances = true;
      emit(InsuranceLoading());
      _insurancesLoadGeneration++;
      final myGeneration = _insurancesLoadGeneration;

      // Fan out the three independent companion RPCs in parallel with
      // the main page fetch instead of awaiting them serially. Each
      // adds 200–600 ms on a healthy backend; serial = ~2s spinner.
      // Parallel = single max-of-3 = ~600 ms. Wrapped in _safeCall so a
      // missing/erroring endpoint doesn't take down the whole load.
      final pageFuture = repository.getUserInsurancesPage(
        userId: currentUserId,
        page: 1,
        limit: limit,
      );
      final recentPaymentsFuture =
          _safeCall(() => repository.getUserPayments(currentUserId), <InsurancePayment>[]);
      final overduePaymentsFuture =
          _safeCall(() => repository.getOverduePayments(currentUserId), <InsurancePayment>[]);
      final statisticsFuture =
          _safeCall(() => repository.getInsuranceStatistics(currentUserId), <String, dynamic>{});

      final page = await pageFuture;
      if (isClosed) return;
      if (myGeneration != _insurancesLoadGeneration) return; // superseded

      final recentPayments = await recentPaymentsFuture;
      final overduePayments = await overduePaymentsFuture;
      final statistics = await statisticsFuture;
      if (isClosed) return;

      emit(InsurancesLoaded(
        insurances: page.insurances,
        recentPayments: recentPayments.take(5).toList(),
        overduePayments: overduePayments,
        statistics: statistics,
        hasMore: page.hasMore,
        currentPage: 1,
        isLoadingMore: false,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(InsuranceError(_friendlyError(e, 'Failed to load insurance policies. Please try again.')));
    } finally {
      _isLoadingInsurances = false;
    }
  }

  /// Slice 4: load the next page of user insurances and append to the
  /// current list. No-op when there's nothing more, an in-flight load, or
  /// the state isn't InsurancesLoaded.
  Future<void> loadMoreInsurances({int limit = 15}) async {
    if (isClosed) return;
    final current = state;
    if (current is! InsurancesLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;
    if (!_isAuthenticated) return;

    emit(current.copyWith(isLoadingMore: true));
    final myGeneration = _insurancesLoadGeneration;

    try {
      final nextPage = current.currentPage + 1;
      final page = await repository.getUserInsurancesPage(
        userId: currentUserId,
        page: nextPage,
        limit: limit,
      );
      if (isClosed) return;
      if (myGeneration != _insurancesLoadGeneration) return; // superseded by refresh
      // Re-read state in case a pull-to-refresh rebuilt it.
      final latest = state;
      if (latest is! InsurancesLoaded) return;
      emit(latest.copyWith(
        insurances: [...latest.insurances, ...page.insurances],
        hasMore: page.hasMore,
        isLoadingMore: false,
        currentPage: nextPage,
      ));
    } catch (_) {
      if (isClosed) return;
      if (myGeneration != _insurancesLoadGeneration) return;
      // Drop the in-flight flag so user can retry scroll-load.
      final latest = state;
      if (latest is InsurancesLoaded) {
        emit(latest.copyWith(isLoadingMore: false));
      }
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

      // Then load payments and claims in the background. These are read-only
      // history — a failure (provider has no per-policy payment list, an id
      // mismatch → "invalid policy_id", etc.) must NEVER break the whole detail
      // screen. Tolerate ANY error: payments falls back to the synthesized
      // purchase row below; claims falls back to empty.
      List<InsurancePayment> fetched = const [];
      try {
        fetched = await repository.getInsurancePayments(insurance.id);
      } catch (_) {/* non-fatal — synthesize from the policy below */}
      if (isClosed) return;
      List<InsuranceClaim> claims = const [];
      try {
        claims = await repository.getInsuranceClaims(insurance.id);
      } catch (_) {/* non-fatal — show empty claims, not an error screen */}
      if (isClosed) return;

      // MyCover.ai doesn't expose a per-policy payment list — there's no
      // PUT /policies endpoint and no /policies/:id/payments. The policy
      // record itself carries `amount` (the premium paid at purchase) and
      // its `start_date`. When our local insurance_payments table has no
      // rows (typical for fresh purchases), synthesize the initial
      // purchase row from the policy so users see the transaction that
      // bought the cover, matching what they expect under "Payments".
      final payments = fetched.isEmpty
          ? _synthesizePurchasePayment(insurance)
          : fetched;

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

  /// Build a synthetic payment row representing the initial premium
  /// charge at purchase. Used only when the backend returns no
  /// insurance_payments rows; the policy itself is the source of truth
  /// for the amount + date.
  List<InsurancePayment> _synthesizePurchasePayment(Insurance insurance) {
    if (insurance.premiumAmount <= 0) return const [];
    return [
      InsurancePayment(
        id: 'purchase-${insurance.id}',
        insuranceId: insurance.id,
        policyNumber: insurance.policyNumber,
        amount: insurance.premiumAmount,
        currency: insurance.currency.isNotEmpty ? insurance.currency : 'NGN',
        paymentMethod: PaymentMethod.wallet,
        status: insurance.startDate.isBefore(DateTime.now().add(const Duration(days: 1)))
            ? PaymentStatus.completed
            : PaymentStatus.pending,
        referenceNumber: insurance.policyNumber.isNotEmpty
            ? insurance.policyNumber
            : null,
        paymentDate: insurance.startDate,
        dueDate: insurance.startDate,
        processedAt: insurance.startDate,
        createdAt: insurance.startDate,
        updatedAt: insurance.startDate,
        userId: currentUserId,
      ),
    ];
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

  // Removed: `updateInsurance` cubit method. MyCover.ai has no
  // policy-update endpoint, and our local-only write path drifted from
  // the upstream policy state. The repository's `updateInsurance` is
  // kept for internal status mutations (cancel) but is no longer
  // exposed through the cubit.

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

  /// In-flight payment dedupe map. Keyed by `${insuranceId}:${amount}` so two
  /// rapid taps for the same policy + amount share one backend call instead of
  /// firing two and double-charging the user. The entry is cleared on
  /// resolution (success or error) so a legitimate retry is allowed.
  final Map<String, Future<InsurancePayment>> _inFlightPayments = {};

  /// Create a payment for a specific insurance.
  ///
  /// Idempotent at the cubit level: if a payment with the same key is
  /// already in flight, the same Future is returned to the second caller
  /// so we never fire two `createPayment` RPCs concurrently for the same
  /// policy + amount. Backend-side idempotency is the source of truth,
  /// but this saves a duplicate network round trip and keeps the UI sane.
  Future<InsurancePayment> createPayment({
    required String insuranceId,
    required String policyNumber,
    required double amount,
    required PaymentMethod paymentMethod,
    String? currency,
  }) async {
    final dedupKey = '$insuranceId:${amount.toStringAsFixed(2)}';
    final existing = _inFlightPayments[dedupKey];
    if (existing != null) return existing;

    // Currency precedence: caller-supplied (policy currency) → active
    // locale's currency from LocaleManager → NGN as the Nigerian default.
    // The previous hardcoded 'USD' showed dollars to NGN-locale users.
    final effectiveCurrency = (currency != null && currency.isNotEmpty)
        ? currency
        : (CurrencySymbols.currentCurrency.isNotEmpty
            ? CurrencySymbols.currentCurrency
            : 'NGN');

    final payment = InsurancePayment(
      id: '',
      insuranceId: insuranceId,
      policyNumber: policyNumber,
      amount: amount,
      currency: effectiveCurrency,
      paymentMethod: paymentMethod,
      status: PaymentStatus.pending,
      paymentDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 30)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: currentUserId,
    );

    final future = repository.createPayment(payment);
    _inFlightPayments[dedupKey] = future;
    try {
      return await future;
    } finally {
      _inFlightPayments.remove(dedupKey);
    }
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

  @override
  Future<void> close() {
    _purchaseEventSub?.cancel();
    _purchaseEventSub = null;
    return super.close();
  }
}