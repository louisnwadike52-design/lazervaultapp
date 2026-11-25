import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/core/offline/mutation_queue.dart';
import 'package:lazervault/core/utilities/bank_sort.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';
import 'package:lazervault/src/features/crypto_pay/domain/fund_payment_with_crypto.dart';
import 'package:lazervault/core/utils/kyc_error_handler.dart';
import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/utils/tier_limit_refusal.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

class TransferCubit extends Cubit<TransferState> {
  final IPaymentsTransferDataSource paymentsTransferDataSource;
  final MutationQueue? mutationQueue;

  /// Cache the last fee lookup result so it can be used when building receipt details
  TransferFeeLoaded? lastFeeLoaded;

  /// How a crypto-funded payment asks for its conversion.
  ///
  /// INJECTED rather than reached for through the service locator, because
  /// this is the step that sells a customer's coin and it has to be provable
  /// in a test: that it runs only after the payment is recorded, that it runs
  /// exactly once, and that a refusal is reported differently from a lost
  /// reply. Defaults to the real call, so production wiring is unchanged.
  final Future<CryptoFundingStart> Function({
    required String accountId,
    required String paymentReference,
    required int requiredMinor,
    required String asset,
    String service,
    String currency,
  }) fundWithCrypto;

  TransferCubit({
    required this.paymentsTransferDataSource,
    this.mutationQueue,
    this.fundWithCrypto = fundPaymentWithCrypto,
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
    String? toAccountId, // Account UUID for internal transfers
    required String type, // "internal" or "external" - PRIMARY KEY
    required double amount, // Amount in major units (e.g., 100.50)
    required String description,
    required String transactionId,
    required String verificationToken,
    String? destinationBankCode, // External: bank code from recipient.sortCode
    String? beneficiaryName, // External: recipient name on bank account
    DateTime? scheduledAt,
    double? availableBalance, // Source account available balance (major units)
    int? expenseCategory, // Budget category enum value selected by user
    String?
        flow, // Funnel flow ("long"|"short"); falls back to last screen view
    /// PAY WITH CRYPTO: the asset to sell to fund this transfer, lowercase
    /// ("usdt"). Null means the ordinary wallet-funded transfer.
    String? fundingAsset,
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

    // Pre-flight balance check: reject early if amount exceeds available balance.
    //
    // SKIPPED FOR A CRYPTO-FUNDED TRANSFER. Being short in the wallet is the
    // entire reason the customer chose to sell crypto, so applying this test
    // would refuse exactly the transfers the feature exists to serve — and it
    // would refuse them here, in the client, before the server ever saw them.
    final isCryptoFunded = (fundingAsset ?? '').trim().isNotEmpty;
    if (!isCryptoFunded &&
        availableBalance != null &&
        amount > availableBalance) {
      emit(TransferFailure(
        message:
            'Insufficient available balance. You have ${availableBalance.toStringAsFixed(2)} available.',
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
        type: type, // REQUIRED: "internal" or "external"
        amount: amount,
        description: description,
        transactionId: transactionId,
        verificationToken: verificationToken,
        destinationBankCode: destinationBankCode,
        beneficiaryName: beneficiaryName,
        scheduledAt: scheduledAt,
        expenseCategory: expenseCategory,
        flow: sendFlow,
        fundingAsset: fundingAsset,
      );

      if (isClosed) return;

      if (result.success) {
        // External transfers go through Flutterwave hold-then-capture: the
        // backend returns immediately with status="pending" or "processing"
        // and the webhook drives the terminal transition. The receipt screen
        // uses isInFlight to render a Processing badge and listens on the
        // balance WebSocket for the terminal Success/Failure event.
        final status = result.status?.toLowerCase() ?? '';

        // PAY WITH CRYPTO — STEP 2 OF THE ORDER, AND IT RUNS HERE ON PURPOSE.
        //
        // core-payments has now recorded the transfer at
        // awaiting_crypto_funding and converted NOTHING. Asking for the
        // conversion is a separate call, and it must happen even if the
        // customer backgrounds the app or the screen that started this is
        // disposed a moment later. Doing it in a screen's BlocListener would
        // tie a money step to a widget's lifetime: navigate away at the wrong
        // instant and the authorisation is left for the sweep to close, with
        // the customer told their transfer was on its way.
        if (isCryptoFunded) {
          final reference = result.reference ?? '';
          if (reference.isEmpty) {
            // No reference means nothing to fund against, and funding a
            // payment we cannot name is how crypto gets sold for an errand
            // nothing tracks. Nothing has moved, so say so plainly.
            emit(const TransferFailure(
              message:
                  'We could not set up that payment. You have not been charged.',
              isRetryable: true,
            ));
            recordOutcome('failure');
            return;
          }
          try {
            // SIZE THE CONVERSION AGAINST WHAT THE TRANSFER WILL ACTUALLY
            // COST, FEE INCLUDED.
            //
            // The server's figures are still preferred — but on THIS path it
            // has none. A crypto-funded transfer is recorded at
            // `awaiting_crypto_funding` and reserves nothing, so the
            // authorising row is written before any fee is computed and
            // `result.fee` comes back 0. The conversion was therefore sized
            // to the amount alone and the wallet silently had to cover the
            // fee.
            //
            // Measured on prod 2026-11-24: required ₦1,300 against a
            // ₦1,323.00 charge. It went through only because that customer
            // had a balance. Someone paying ENTIRELY from crypto with an
            // empty wallet converts ~the amount, passes the sufficiency
            // check, and then fails at the hold for want of the fee — their
            // money is safe in their wallet, but the payment fails for a
            // reason nobody can see and the conversion was avoidable.
            //
            // ensureFeeForAmount, not lastFeeLoaded: fees are
            // amount-dependent, and that gate revalidates the quote against
            // this exact amount and type rather than trusting a stale one
            // from a different figure.
            final amountMinor = result.amount ?? 0;
            var feeMinor = result.fee ?? 0;
            if (feeMinor == 0) {
              final quote = await ensureFeeForAmount(
                amountMinorUnits: amountMinor,
                // The response's own currency when it has one. Empty is
                // safe: GetTransferFee defaults to NGN, which is the only
                // currency a crypto-funded transfer settles in today.
                currency: (result.currency?.trim().isNotEmpty ?? false)
                    ? result.currency!.trim()
                    : 'NGN',
                transferType: type,
                destinationBankCode: destinationBankCode,
              );
              // Null means the re-quote failed. Fall through with 0 rather
              // than blocking: the old behaviour, which usually works, beats
              // refusing a payment the customer has already authorised.
              feeMinor = quote?.fee ?? 0;
            }
            await fundWithCrypto(
              accountId: fromAccountId,
              paymentReference: reference,
              requiredMinor: amountMinor + feeMinor,
              asset: fundingAsset!.trim().toLowerCase(),
            );
          } on GrpcError catch (e) {
            if (isClosed) return;
            // A REFUSAL AND A TIMEOUT ARE NOT THE SAME EVENT, and telling the
            // customer "you have not been charged" when we simply lost the
            // reply would be a guess about their money. Only the codes that
            // mean the server decided against it carry that promise.
            final refused = e.code == StatusCode.invalidArgument ||
                e.code == StatusCode.failedPrecondition ||
                e.code == StatusCode.permissionDenied ||
                e.code == StatusCode.notFound ||
                e.code == StatusCode.outOfRange;
            emit(TransferFailure(
              message: refused
                  ? _withNoChargePromise(GrpcErrorHandler.userFriendlyMessage(e))
                  : 'We could not confirm the conversion. Check this transfer in your history before trying again.',
              isRetryable: refused,
              isSpendRefusal: refused,
            ));
            recordOutcome('failure');
            return;
          } catch (_) {
            if (isClosed) return;
            emit(const TransferFailure(
              message:
                  'We could not confirm the conversion. Check this transfer in your history before trying again.',
              isRetryable: false,
            ));
            recordOutcome('failure');
            return;
          }
        }

        // IN-FLIGHT COVERS THE CONVERSION TOO. Without this a crypto-funded
        // transfer renders a completed receipt while the coin is still being
        // sold — the customer is shown money as sent that has not left, and
        // may send it again.
        final isInFlight = status == 'awaiting_crypto_funding' ||
            isCryptoFunded ||
            (type == 'external' &&
                (status == 'pending' || status == 'processing'));
        emit(TransferSuccess(
            response: _toEntity(result), isInFlight: isInFlight));
        recordOutcome('success');
        // Tally the destination bank so it leads the "Most used" picker pill.
        if (type == 'external' &&
            destinationBankCode != null &&
            destinationBankCode.isNotEmpty) {
          MostUsedBanks.record(destinationBankCode);
        }
      } else {
        emit(
            TransferFailure(message: result.errorMessage ?? 'Transfer failed'));
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
          message:
              'Transaction limit reached. Upgrade your account to increase limits.',
          isKYCError: true,
          // THE TIER HAS TO SURVIVE THE REWORDING. The copy above replaces the
          // server's sentence, and the old handler then decided whether to show
          // the upgrade sheet by searching that copy for 'KYC_TIER_INSUFFICIENT'
          // — a string it does not contain. So the flag said "KYC" and the
          // text-matching handler said "not KYC", the screen took the early
          // return anyway, and the customer was shown NOTHING AT ALL. Carrying
          // the parsed tier in the state removes the text round-trip entirely.
          enforcedKycTier: enforcedTierFromRefusal(e.message),
        ));
        recordOutcome('kyc_error');
        return;
      }

      // For financial operations, show clear error and let user retry manually
      // NEVER queue payments offline - security tokens expire, balances change
      emit(TransferFailure(
        message: GrpcErrorHandler.userFriendlyMessage(e),
        isRetryable: GrpcErrorHandler.isRetryable(e),
        enforcedKycTier: enforcedTierFromRefusal(e.message),
        // FailedPrecondition is core-payments' code for "we refused this on its
        // merits": a limit, a cap, a family allowance, an inactive account. The
        // message it carries is written for the payer and tells them what to
        // change, so a screen must be able to tell this apart from a transport
        // failure and present it properly rather than as a passing flash.
        isSpendRefusal: e.code == StatusCode.failedPrecondition,
      ));
      recordOutcome('failure');
    } catch (e) {
      if (isClosed) return;

      if (_isNetworkError(e)) {
        emit(const TransferFailure(
          message:
              'No internet connection. Please check your network and try again.',
          isRetryable: true,
        ));
        recordOutcome('network_error');
      } else {
        // THE SERVER USUALLY SAYS WHY. Discarding `e` here is what turned
        // "daily transfer amount limit exceeded" into "Transfer failed.
        // Please try again." — advice to retry the one thing that cannot
        // succeed until tomorrow. friendlyError unwraps the gRPC envelope and
        // falls back to the generic line only when the message really is
        // technical.
        final limitMsg = spendingLimitMessage(e);
        final raw = e.toString();

        // THE BRANCH SEND FUNDS ACTUALLY TAKES.
        //
        // PaymentsTransferDataSourceImpl.sendFunds catches the GrpcError and
        // rethrows a ServerException, so the `on GrpcError` handler above is
        // unreachable for this call and everything it sets — the spend-refusal
        // flag that routes a family wallet to its own dialog, the KYC flag, the
        // enforcing tier — was never set for a transfer. The code now travels
        // on the exception, so the same three decisions are made here.
        final code = e is ServerException ? e.code : null;
        final refusedOnMerits = code == StatusCode.failedPrecondition;

        emit(TransferFailure(
          message: friendlyError(e),
          // A limit is a refusal, not a transient failure: offering Retry on
          // it invites the customer to fail again. Same for anything the
          // server refused on its merits.
          isRetryable: limitMsg == null && !refusedOnMerits,
          isKYCError: isKYCLimitError(raw),
          isSpendRefusal: refusedOnMerits,
          enforcedKycTier: enforcedTierFromRefusal(raw),
        ));
        recordOutcome(limitMsg != null ? 'spending_limit' : 'failure');
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
      transferId: result.transferId ?? '', // UUID string, not Int64
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

/// Append the money promise to a refusal, WITHOUT saying it twice.
///
/// Both ends of this flow know the same true thing and both want to say it:
/// crypto-service closes the row `failed_no_charge` and words its refusal
/// with "Nothing was converted", and this cubit adds the customer-facing
/// promise for every refusal it classifies. Concatenating produced
///
///   "…Increase the amount and try again. Nothing was converted. Nothing was
///    converted and you have not been charged."
///
/// — which reads like a system talking to itself at the exact moment a
/// customer is deciding whether to trust it with money again.
///
/// The server's own wording wins when it already carries the promise; the
/// client only fills the gap.
String _withNoChargePromise(String message) {
  final text = message.trim();
  final lower = text.toLowerCase();
  if (lower.contains('not been charged')) return text;
  if (lower.contains('nothing was converted')) {
    return '$text You have not been charged.';
  }
  const promise = 'Nothing was converted and you have not been charged.';
  return text.isEmpty ? promise : '$text $promise';
}
