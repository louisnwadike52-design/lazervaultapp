part of 'transaction_pin_modal.dart';

/// Phases the PIN modal transitions through
enum PinModalPhase { pinEntry, verifying, processing, success, failed }

/// Transaction PIN entry bottom sheet with inline loading states
/// Transitions: pinEntry → verifying → processing → success → navigate
class TransactionPinModal extends StatefulWidget {
  final String? title;
  final String? message;
  final double? amount;
  final double? fee;
  final double? totalAmount;
  final String? currency;
  final String? currencySymbol;
  final Function(String) onPinSubmitted;
  final VoidCallback? onForgotPin;
  final VoidCallback? onCancel;
  final int maxAttempts;
  final int currentAttempt;
  final String? errorMessage;
  final bool isLoading;

  /// Optional action rendered near the top of the PIN-entry sheet (e.g. a
  /// "Custom Voice" pill from the voice flow). Backward-compatible: defaults to
  /// null so existing callers render unchanged.
  final Widget? headerAction;

  /// Optional recipient identity for chat-driven money moves — when present the
  /// sheet shows the recipient's avatar + name so the user confirms WHO they're
  /// paying while entering the PIN. Backward-compatible: null → default header.
  final String? recipientImageUrl;
  final String? recipientName;
  // Optional per-phase subtitle overrides so a non-transfer flow (e.g. a balance
  // refresh) doesn't read as "Your transfer is being processed". Null → defaults.
  final String? processingSubtitle;
  final String? successSubtitle;

  // The flow's transaction type (e.g. 'airtime_purchase', 'cable_tv_purchase').
  // Drives a service-appropriate processing/success subtitle via
  // [transactionServiceNoun] when no explicit [processingSubtitle] /
  // [successSubtitle] is supplied. Null → sheet keeps its transfer default.
  final String? transactionType;

  /// A Family & Friends member's OWN spending allowance, when the family
  /// account is in an allocation mode (equal_split / custom_allocation).
  ///
  /// WHY IT BELONGS ON THIS SHEET. Under allocation, a member does not spend
  /// the family pool — they spend their allocation, and the backend refuses
  /// anything above it. The PIN sheet is the last screen before the money
  /// moves and the only one that shows the amount, so it is where a member can
  /// still be told "this is more than you have" instead of typing a PIN and
  /// being rejected afterwards. Being refused AFTER entering a PIN reads as a
  /// fault; being told beforehand reads as a rule.
  ///
  /// Null on every non-family flow and in shared_pool, where no member has an
  /// allocation and the pool balance is already the honest figure.
  final double? memberAllocationRemaining;

  const TransactionPinModal({
    super.key,
    this.title,
    this.message,
    this.amount,
    this.fee,
    this.totalAmount,
    this.currency,
    this.currencySymbol,
    required this.onPinSubmitted,
    this.onForgotPin,
    this.onCancel,
    this.maxAttempts = 3,
    this.currentAttempt = 1,
    this.errorMessage,
    this.isLoading = false,
    this.headerAction,
    this.recipientImageUrl,
    this.recipientName,
    this.processingSubtitle,
    this.successSubtitle,
    this.transactionType,
    this.memberAllocationRemaining,
  });

  @override
  State<TransactionPinModal> createState() => TransactionPinModalState();
}

class _StepInfo {
  final String label;
  final PinModalPhase phase;
  const _StepInfo(this.label, this.phase);
}
