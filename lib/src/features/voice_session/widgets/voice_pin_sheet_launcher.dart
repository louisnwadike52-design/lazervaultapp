/// VoicePinSheetLauncher — auto-opens the canonical
/// `TransactionPinMixin` bottom sheet during a voice session so voice
/// and chat money-move flows share the SAME PIN UI, lockout policy,
/// and single-use `verification_token` semantics.
///
/// Replaces the legacy [VoicePinEntryDialog] which submitted PIN
/// directly to transfer-gateway over HTTP. That direct-submit path:
///   * skipped the platform-wide attempt counters in TransactionPinMixin
///   * created a parallel PIN-handling codepath that drifts over time
///   * couldn't surface the agent's `verification_token` round-trip,
///     so the voice agent never had a replay-safe way to resume the
///     same saga after PIN success
///
/// Lifecycle:
///   1. Mount → schedule a post-frame callback that calls
///      `validateTransactionPin(...)` with the `transactionPayload`
///      shape the chat-agent-gateway sends via PinPromptIntent.
///   2. On PIN success → invoke `onPinVerified(verificationToken)` so
///      `VoiceSessionCubit.submitPinVerification(token, ...)` can
///      resume the agent's callback intent.
///   3. On cancel / failure → invoke `onCancelled()` so the session
///      can cancel the in-flight voice action cleanly.
///
/// The widget itself is invisible — it just hosts the State that
/// owns the TransactionPinMixin's modal key. Callers `showDialog`
/// this so its lifecycle is bound to the active route.
library;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

typedef VoicePinVerifiedCallback = Future<void> Function(
  String verificationToken,
);

class VoicePinSheetLauncher extends StatefulWidget {
  /// PinPromptIntent payload from the agent. Same shape as the chat
  /// path's `_pin_prompt_pending` entity.
  final Map<String, dynamic> transactionPayload;

  /// Bearer token. The mixin internally uses it via
  /// `transactionPinService`; this field is kept for parity with the
  /// legacy [VoicePinEntryDialog] caller signature.
  final String accessToken;

  /// Fired with the single-use `verification_token` from the PIN
  /// service once the user enters a valid PIN.
  final VoicePinVerifiedCallback onPinVerified;

  /// Fired when the user dismisses the sheet, exceeds attempts, or
  /// the underlying PIN service surface returns false.
  final VoidCallback onCancelled;

  const VoicePinSheetLauncher({
    super.key,
    required this.transactionPayload,
    required this.accessToken,
    required this.onPinVerified,
    required this.onCancelled,
  });

  @override
  State<VoicePinSheetLauncher> createState() => _VoicePinSheetLauncherState();
}

class _VoicePinSheetLauncherState extends State<VoicePinSheetLauncher>
    with TransactionPinMixin {
  bool _launched = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    // Auto-open the canonical TransactionPinMixin bottom sheet on the
    // very next frame, so users see the PIN UI immediately without
    // an extra "Enter PIN" CTA inside the voice flow.
    WidgetsBinding.instance.addPostFrameCallback((_) => _open());
  }

  Future<void> _open() async {
    if (_launched) return;
    _launched = true;

    final payload = widget.transactionPayload;
    final amount =
        double.tryParse(payload['amount']?.toString() ?? '0') ?? 0.0;
    final fee = double.tryParse(payload['fee']?.toString() ?? '0') ?? 0.0;
    final total = double.tryParse(payload['total_amount']?.toString() ?? '') ??
        (amount + fee);
    final currency = (payload['currency'] ?? 'NGN').toString();
    final transactionId = (payload['transaction_id'] ?? '').toString();
    final transactionType = (payload['transaction_type'] ?? 'transfer').toString();
    final recipientSummary =
        (payload['recipient_summary'] ?? '').toString().trim();
    final title = _titleForType(transactionType);

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: transactionType,
      amount: amount,
      currency: currency,
      title: title,
      message: recipientSummary.isEmpty
          ? 'Enter your PIN to continue.'
          : recipientSummary,
      fee: fee,
      totalAmount: total,
      onPinValidated: (verificationToken) async {
        await widget.onPinVerified(verificationToken);
      },
    );

    if (!mounted) return;
    if (!success) {
      widget.onCancelled();
    }
    // Pop the host route — either path. The bottom sheet itself was
    // dismissed by the mixin; this just cleans up the dialog frame
    // we were mounted inside.
    Navigator.of(context, rootNavigator: true).maybePop();
  }

  String _titleForType(String t) {
    switch (t) {
      case 'transfer':
        return 'Confirm transfer';
      case 'transfer_intl':
        return 'Confirm international transfer';
      case 'batch_transfer':
        return 'Confirm batch transfer';
      case 'crypto_buy':
        return 'Confirm crypto purchase';
      case 'crypto_sell':
        return 'Confirm crypto sale';
      case 'crypto_swap':
        return 'Confirm crypto swap';
      case 'crypto_send':
        return 'Confirm crypto send';
      case 'insurance_buy':
        return 'Confirm insurance purchase';
      case 'insurance_claim':
        return 'Submit insurance claim';
      case 'exchange_convert':
        return 'Confirm currency conversion';
      case 'split_bill_pay':
        return 'Confirm split-bill payment';
      default:
        return 'Confirm payment';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Invisible host — the bottom sheet is launched via the mixin
    // and lives in its own modal route on the navigator.
    return const SizedBox.shrink();
  }
}
