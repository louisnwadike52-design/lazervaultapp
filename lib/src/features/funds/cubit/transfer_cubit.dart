import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/offline/mutation_queue.dart';
import 'package:lazervault/core/utilities/bank_sort.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';
import 'package:lazervault/core/utils/kyc_error_handler.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

class TransferCubit extends Cubit<TransferState> {
  final IPaymentsTransferDataSource paymentsTransferDataSource;
  final MutationQueue? mutationQueue;

  /// Cache the last fee lookup result so it can be used when building receipt details
  TransferFeeLoaded? lastFeeLoaded;

  TransferCubit({
    required this.paymentsTransferDataSource,
    this.mutationQueue,
  }) : super(const TransferInitial());

  /// Check if an error is a network-related error that should trigger offline queuing
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  /// Get transfer fee for a given amount, currency, and transfer type.
  /// Internal transfers are always free. External transfers use tiered fees.
  Future<void> getTransferFee({
    required int amountMinorUnits,
    required String currency,
    required String transferType, // "internal", "domestic", "international"
    String? destinationBankCode,
  }) async {
    if (isClosed) return;
    emit(const TransferFeeLoading());

    try {
      // Internal transfers are always free
      if (transferType == 'internal') {
        final feeState = TransferFeeLoaded(
          fee: 0,
          currency: currency,
          feeType: 'flat',
          totalAmount: amountMinorUnits,
          breakdown: const [FeeBreakdownItem(label: 'Transfer Fee', amount: 0)],
          quotedForAmountMinor: amountMinorUnits,
          quotedForType: transferType,
        );
        lastFeeLoaded = feeState;
        emit(feeState);
        return;
      }

      // Fee comes from the BACKEND — the exact amount SendFunds will charge
      // (our admin-configured platform fee + the CBN/Flutterwave provider fee).
      // No hard-coded client-side values or fallbacks: if the backend can't
      // quote a fee, surface an error rather than guess.
      final fee = await paymentsTransferDataSource.getTransferFee(
        amountMinorUnits: amountMinorUnits,
        currency: currency,
        transferType: transferType,
      );

      if (isClosed) return;
      final feeState = TransferFeeLoaded(
        fee: fee,
        currency: currency,
        feeType: 'flat',
        totalAmount: amountMinorUnits + fee,
        breakdown: [FeeBreakdownItem(label: 'Transfer Fee', amount: fee)],
        quotedForAmountMinor: amountMinorUnits,
        quotedForType: transferType,
      );
      lastFeeLoaded = feeState;
      emit(feeState);
    } catch (e) {
      if (isClosed) return;
      emit(TransferFeeError(message: 'Failed to get transfer fee: $e'));
    }
  }

  /// Return a fee quote that is GUARANTEED to be for [amountMinorUnits] +
  /// [transferType]. Because fees are amount-dependent (provider fee scales
  /// with amount; platform fee may be percentage-with-cap), the cached
  /// [lastFeeLoaded] is only trustworthy when it was quoted for the exact same
  /// amount and type — otherwise it's silently wrong (e.g. a ₦10k quote shown
  /// on a ₦50k confirm). This is the single revalidation gate every confirm /
  /// PIN sheet should use instead of reading [lastFeeLoaded] directly:
  ///   • cache HIT (same amount+type) → return it, no redundant network call;
  ///   • cache MISS / stale / null / errored → re-quote synchronously.
  /// Returns null only if the (re)quote fails, so callers can decide whether to
  /// block the confirm or proceed without a fee row.
  Future<TransferFeeLoaded?> ensureFeeForAmount({
    required int amountMinorUnits,
    required String currency,
    required String transferType,
    String? destinationBankCode,
  }) async {
    final cached = lastFeeLoaded;
    if (cached != null &&
        cached.quotedForAmountMinor == amountMinorUnits &&
        cached.quotedForType == transferType &&
        cached.currency == currency) {
      // Stale-while-revalidate: hand back the cached fee INSTANTLY (no spinner)
      // and revalidate in the BACKGROUND so an admin fee-config change (e.g. new
      // range bands) propagates without blocking or flashing a loading state.
      _revalidateFeeInBackground(
        amountMinorUnits: amountMinorUnits,
        currency: currency,
        transferType: transferType,
        cachedFee: cached.fee,
      );
      return cached;
    }
    await getTransferFee(
      amountMinorUnits: amountMinorUnits,
      currency: currency,
      transferType: transferType,
      destinationBankCode: destinationBankCode,
    );
    // getTransferFee updates lastFeeLoaded on success and leaves it untouched
    // (emitting TransferFeeError) on failure — so only return a quote that
    // actually matches the requested amount, never a stale one.
    final fresh = lastFeeLoaded;
    if (fresh != null &&
        fresh.quotedForAmountMinor == amountMinorUnits &&
        fresh.quotedForType == transferType) {
      return fresh;
    }
    return null;
  }

  /// Background (non-blocking, NO loading emit) fee revalidation. Fetches the
  /// current fee and, ONLY if it differs from [cachedFee] AND the cache still
  /// corresponds to this amount, updates the cache + emits a fresh
  /// TransferFeeLoaded so the fee row updates to the new value. Silent on error
  /// — the cached value stays authoritative until a real re-quote. This is what
  /// makes an admin range-fee change take effect on the app without the user
  /// ever seeing a spinner.
  Future<void> _revalidateFeeInBackground({
    required int amountMinorUnits,
    required String currency,
    required String transferType,
    required int cachedFee,
  }) async {
    if (transferType == 'internal') return; // internal is always free
    try {
      final fee = await paymentsTransferDataSource.getTransferFee(
        amountMinorUnits: amountMinorUnits,
        currency: currency,
        transferType: transferType,
      );
      if (isClosed || fee == cachedFee) return;
      // Guard against a race: the user may have moved to a different amount
      // while this fetch was in flight — only replace a still-matching cache.
      final cur = lastFeeLoaded;
      if (cur == null ||
          cur.quotedForAmountMinor != amountMinorUnits ||
          cur.quotedForType != transferType) {
        return;
      }
      final feeState = TransferFeeLoaded(
        fee: fee,
        currency: currency,
        feeType: 'flat',
        totalAmount: amountMinorUnits + fee,
        breakdown: [FeeBreakdownItem(label: 'Transfer Fee', amount: fee)],
        quotedForAmountMinor: amountMinorUnits,
        quotedForType: transferType,
      );
      lastFeeLoaded = feeState;
      emit(feeState);
    } catch (_) {
      // Keep the cached value; a real re-quote will correct it if needed.
    }
  }

  /// Unified send funds method (works for both internal and external transfers)
  /// Uses Transfer Gateway (port 50076) -> Core-Payment-Service (port 50053)
  /// On network failure, queues the transfer for retry when online.
  ///
  /// [availableBalance] - Optional pre-flight check against the source account's
  /// available balance (in major units). Prevents unnecessary network calls when
  /// the user clearly doesn't have enough funds.
  Future<void> sendFunds({
    required String fromAccountId,
    required String toAccountNumber,
    String? toAccountId,              // Account UUID for internal transfers
    required String type,              // "internal" or "external" - PRIMARY KEY
    required double amount,             // Amount in major units (e.g., 100.50)
    required String description,
    required String transactionId,
    required String verificationToken,
    String? destinationBankCode,        // External: bank code from recipient.sortCode
    String? beneficiaryName,            // External: recipient name on bank account
    DateTime? scheduledAt,
    double? availableBalance,          // Source account available balance (major units)
    int? expenseCategory,              // Budget category enum value selected by user
    String? flow,                      // Funnel flow ("long"|"short"); falls back to last screen view
  }) async {
    if (isClosed) return;

    // Resolve the funnel flow once: explicit caller value wins, else the flow of
    // the last viewed send-funds screen. Used both for the backend x-flow header
    // and for client outcome attribution so long/short stay consistent.
    final sendFlow = flow ?? AnalyticsService.instance.currentSendFlow;

    // Telemetry: measure client-observed send latency + record terminal outcome.
    final telemetryStart = DateTime.now();
    void recordOutcome(String outcome) {
      AnalyticsService.instance.trackSendFundsOutcome(
        type: type,
        outcome: outcome,
        flow: sendFlow,
        latencyMs: DateTime.now().difference(telemetryStart).inMilliseconds,
      );
    }

    // Pre-flight balance check: reject early if amount exceeds available balance
    if (availableBalance != null && amount > availableBalance) {
      emit(TransferFailure(
        message: 'Insufficient available balance. You have ${availableBalance.toStringAsFixed(2)} available.',
      ));
      recordOutcome('failure');
      return;
    }

    emit(const TransferLoading());

    try {
      final result = await paymentsTransferDataSource.sendFunds(
        fromAccountId: fromAccountId,
        toAccountNumber: toAccountNumber,
        toAccountId: toAccountId,
        type: type,  // REQUIRED: "internal" or "external"
        amount: amount,
        description: description,
        transactionId: transactionId,
        verificationToken: verificationToken,
        destinationBankCode: destinationBankCode,
        beneficiaryName: beneficiaryName,
        scheduledAt: scheduledAt,
        expenseCategory: expenseCategory,
        flow: sendFlow,
      );

      if (isClosed) return;

      if (result.success) {
        // External transfers go through Flutterwave hold-then-capture: the
        // backend returns immediately with status="pending" or "processing"
        // and the webhook drives the terminal transition. The receipt screen
        // uses isInFlight to render a Processing badge and listens on the
        // balance WebSocket for the terminal Success/Failure event.
        final status = result.status?.toLowerCase() ?? '';
        final isInFlight = type == 'external' && (status == 'pending' || status == 'processing');
        emit(TransferSuccess(response: _toEntity(result), isInFlight: isInFlight));
        recordOutcome('success');
        // Tally the destination bank so it leads the "Most used" picker pill.
        if (type == 'external' &&
            destinationBankCode != null &&
            destinationBankCode.isNotEmpty) {
          MostUsedBanks.record(destinationBankCode);
        }
      } else {
        emit(TransferFailure(message: result.errorMessage ?? 'Transfer failed'));
        recordOutcome('failure');
      }
    } on GrpcError catch (e) {
      if (isClosed) return;

      // Check for PIN-specific failure first
      final pinFailure = GrpcErrorHandler.extractPinFailure(e);
      if (pinFailure != null) {
        emit(TransferPinFailure(pinInfo: pinFailure));
        recordOutcome('pin_failure');
        return;
      }

      // Check for KYC tier insufficient error
      if (isKYCLimitError(e.message)) {
        emit(TransferFailure(
          message: 'Transaction limit reached. Upgrade your account to increase limits.',
          isKYCError: true,
        ));
        recordOutcome('kyc_error');
        return;
      }

      // For financial operations, show clear error and let user retry manually
      // NEVER queue payments offline - security tokens expire, balances change
      emit(TransferFailure(
        message: GrpcErrorHandler.userFriendlyMessage(e),
        isRetryable: GrpcErrorHandler.isRetryable(e),
      ));
      recordOutcome('failure');
    } catch (e) {
      if (isClosed) return;

      if (_isNetworkError(e)) {
        emit(const TransferFailure(
          message: 'No internet connection. Please check your network and try again.',
          isRetryable: true,
        ));
        recordOutcome('network_error');
      } else {
        emit(TransferFailure(message: 'Transfer failed. Please try again.'));
        recordOutcome('failure');
      }
    }
  }

  /// Reset state to initial (prevents stale success/failure from re-firing listeners)
  void resetState() {
    if (!isClosed) {
      emit(const TransferInitial());
    }
  }

  /// Convert PaymentsTransferResult to TransferEntity for state
  TransferEntity _toEntity(PaymentsTransferResult result) {
    final amountMinor = result.amount ?? 0;
    // Use response fee if available, otherwise fall back to cached fee lookup
    final feeMinor = result.fee ?? lastFeeLoaded?.fee ?? 0;
    return TransferEntity(
      transferId: result.transferId ?? '',  // UUID string, not Int64
      status: result.status ?? 'pending',
      amount: Int64(amountMinor),
      fee: Int64(feeMinor),
      totalAmount: Int64(amountMinor + feeMinor),
      createdAt: result.createdAt ?? DateTime.now(),
      scheduledAt: result.scheduledAt,
      providerReference: result.providerReference,
      internalReference: result.reference,
    );
  }
}
