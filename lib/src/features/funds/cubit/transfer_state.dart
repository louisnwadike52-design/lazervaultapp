import 'package:equatable/equatable.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

sealed class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object?> get props => [];
}

final class TransferInitial extends TransferState {
  const TransferInitial();
}

final class TransferLoading extends TransferState {
  const TransferLoading();
}

final class TransferSuccess extends TransferState {
  final TransferEntity response;

  /// True when the transfer was accepted but is still in-flight (external
  /// Flutterwave transfer waiting on the webhook). Receipt screens should
  /// render a "Processing" badge and rely on the balance WebSocket for the
  /// terminal transition. Defaults to false (internal / scheduled / terminal
  /// success). New in the hold-then-capture flow.
  final bool isInFlight;

  const TransferSuccess({required this.response, this.isInFlight = false});

  @override
  List<Object?> get props => [response, isInFlight];
}

final class TransferFailure extends TransferState {
  final String message;
  final bool isRetryable;
  final bool isKYCError;

  /// The server REFUSED this spend on its merits — a limit, a cap, an allowance
  /// or an account state — rather than failing to carry it out.
  ///
  /// Set from gRPC FailedPrecondition, which is the code core-payments uses for
  /// every such refusal. The distinction matters because a refusal has no retry:
  /// [message] already says what to change, so a screen can show it properly
  /// instead of flashing it for two seconds the way a transport error deserves.
  /// Family wallets are where this hurt most — see
  /// showFamilySpendRefusalDialog.
  final bool isSpendRefusal;

  const TransferFailure(
      {required this.message,
      this.isRetryable = false,
      this.isKYCError = false,
      this.isSpendRefusal = false});

  @override
  List<Object?> get props => [message, isRetryable, isKYCError, isSpendRefusal];
}

/// Emitted when a transfer fails specifically due to an incorrect PIN.
final class TransferPinFailure extends TransferState {
  final PinFailureInfo pinInfo;

  const TransferPinFailure({required this.pinInfo});

  @override
  List<Object?> get props =>
      [pinInfo.isLocked, pinInfo.attemptsRemaining, pinInfo.message];
}

// Fee lookup states
final class TransferFeeLoading extends TransferState {
  const TransferFeeLoading();
}

final class TransferFeeLoaded extends TransferState {
  final int fee; // Minor units (kobo)
  final String currency;
  final String feeType; // "flat" or "percentage"
  final int totalAmount; // Minor units
  final List<FeeBreakdownItem> breakdown;

  /// The exact amount (minor units) and transfer type this quote was fetched
  /// for. Fees are AMOUNT-DEPENDENT — the provider fee scales with the amount
  /// and the platform fee can be a percentage-with-cap — so a cached quote is
  /// only valid for the SAME amount + type it was quoted at. Callers must
  /// revalidate against these before trusting the cached `fee` (see
  /// [TransferCubit.ensureFeeForAmount]). Default 0/'' marks an unqualified
  /// quote (older call sites) which is always treated as stale.
  final int quotedForAmountMinor;
  final String quotedForType;

  const TransferFeeLoaded({
    required this.fee,
    required this.currency,
    required this.feeType,
    required this.totalAmount,
    required this.breakdown,
    this.quotedForAmountMinor = 0,
    this.quotedForType = '',
  });

  @override
  List<Object?> get props => [
        fee,
        currency,
        feeType,
        totalAmount,
        breakdown,
        quotedForAmountMinor,
        quotedForType
      ];
}

final class TransferFeeError extends TransferState {
  final String message;

  const TransferFeeError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FeeBreakdownItem extends Equatable {
  final String label;
  final int amount; // Minor units

  const FeeBreakdownItem({required this.label, required this.amount});

  @override
  List<Object?> get props => [label, amount];
}
