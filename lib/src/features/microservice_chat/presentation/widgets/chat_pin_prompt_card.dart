import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';

/// ChatPinPromptCard — secure PIN handoff for chat-driven money moves.
///
/// Consumes the JSON shape emitted by `chat_services_shared/pin_prompt.py`
/// (the `PinPromptIntent` Pydantic model). Renders a compact card under
/// the chat bubble summarising what the user is about to pay; a single
/// "Enter PIN" CTA opens the existing native `TransactionPinMixin` modal
/// from `transaction_pin/`.
///
/// PIN never enters the chat context:
///   1. The Python agent emits a pin_prompt with amount + fee + total +
///      recipient summary;
///   2. The user taps "Enter PIN" — opens the native modal;
///   3. PIN is verified against auth-service inside the modal; we receive
///      back a single-use `verificationToken`;
///   4. The card calls `onPinVerified(token)` with the token — the cubit
///      re-POSTs the message with metadata.pin_verification_token so the
///      agent's bound callback_intent fires.
///
/// The widget intentionally does NOT call the chat cubit directly; the
/// `onPinVerified` callback is wired by the parent (see
/// general_chat_content.dart). Keeps the widget testable in isolation.
class ChatPinPromptCard extends StatefulWidget {
  /// Resolve (and lazily create) the stable [GlobalKey] used to drive a
  /// rendered card's PIN modal from outside the widget tree — e.g. the
  /// AI-chat listener that AUTO-opens the sheet the moment a `pin_prompt`
  /// arrives. Keyed by the prompt's `transaction_id` so the same card
  /// instance is targeted across rebuilds and there is exactly ONE code
  /// path into the modal (the card's own [_openPinModal]).
  static GlobalKey<ChatPinPromptCardState> keyFor(String transactionId) {
    return _cardKeys.putIfAbsent(
      transactionId,
      () => GlobalKey<ChatPinPromptCardState>(
        debugLabel: 'pin_prompt_$transactionId',
      ),
    );
  }

  static final Map<String, GlobalKey<ChatPinPromptCardState>> _cardKeys = {};

  /// Auto-open the PIN modal for an already-rendered card identified by
  /// [transactionId]. No-op if the card isn't mounted yet, is already open,
  /// or has already completed. Reuses the card's own [_openPinModal] so the
  /// auto-open and the manual "Enter PIN" tap share one implementation.
  static void autoOpenFor(String transactionId) {
    final state = _cardKeys[transactionId]?.currentState;
    state?.openModal();
  }

  final Map<String, dynamic> payload;

  /// Called with the single-use verification token once the user
  /// successfully enters their PIN. Parent (usually the cubit) is
  /// responsible for sending a follow-up chat message that includes
  /// `metadata.pin_verification_token` + `metadata.callback_intent` +
  /// `metadata.callback_args` so the agent can execute the bound tool.
  final Future<void> Function(String verificationToken)? onPinVerified;

  /// Called when the user dismissed/cancelled the PIN modal without
  /// completing it. Parent can surface a "Transaction not submitted"
  /// snackbar or leave the prompt visible for retry.
  final VoidCallback? onCancelled;

  const ChatPinPromptCard({
    super.key,
    required this.payload,
    this.onPinVerified,
    this.onCancelled,
  });

  @override
  State<ChatPinPromptCard> createState() => ChatPinPromptCardState();
}

class ChatPinPromptCardState extends State<ChatPinPromptCard>
    with TransactionPinMixin {
  bool _isOpen = false;
  bool _completed = false;

  /// Public entry point used by both the in-card "Enter PIN" tap and the
  /// AI-chat auto-open listener. Guards (`_isOpen` / `_completed` / mounted)
  /// live inside [_openPinModal] so repeated calls are safe.
  Future<void> openModal() => _openPinModal();

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String _s(String key) => widget.payload[key]?.toString() ?? '';

  bool get _isExpired {
    final raw = _s('expires_at');
    if (raw.isEmpty) return false;
    final exp = DateTime.tryParse(raw);
    if (exp == null) return false;
    return exp.isBefore(DateTime.now().toUtc());
  }

  IconData get _typeIcon {
    switch (_s('transaction_type')) {
      case 'transfer':
      case 'transfer_intl':
      case 'batch_transfer':
        return Icons.send_rounded;
      case 'crypto_buy':
      case 'crypto_sell':
      case 'crypto_swap':
      case 'crypto_send':
        return Icons.currency_bitcoin;
      case 'insurance_buy':
      case 'insurance_claim':
        return Icons.shield_outlined;
      case 'exchange_convert':
        return Icons.swap_horiz_rounded;
      case 'exchange_international':
        return Icons.public_rounded;
      case 'split_bill_pay':
        return Icons.group;
      case 'fraud_unfreeze':
        return Icons.lock_open_rounded;
      default:
        return Icons.lock_outline;
    }
  }

  String get _title {
    switch (_s('transaction_type')) {
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
      case 'exchange_international':
        return 'Confirm international transfer';
      case 'split_bill_pay':
        return 'Confirm split-bill payment';
      case 'fraud_unfreeze':
        return 'Unlock your account';
      default:
        return 'Confirm payment';
    }
  }

  Future<void> _openPinModal() async {
    if (!mounted || _isOpen || _completed || _isExpired) return;
    final transactionId = _s('transaction_id');
    final amountRaw = double.tryParse(_s('amount')) ?? 0.0;
    final feeRaw = double.tryParse(_s('fee')) ?? 0.0;
    final totalRaw = double.tryParse(_s('total_amount')) ?? amountRaw + feeRaw;
    final currency = _s('currency');
    final recipientSummary = _s('recipient_summary');

    setState(() => _isOpen = true);
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: _s('transaction_type'),
      amount: amountRaw,
      currency: currency,
      title: _title,
      message: recipientSummary.isEmpty
          ? 'Enter your PIN to continue.'
          : recipientSummary,
      // Show the recipient's photo + name on the secure pad so the user
      // confirms who they're paying while entering the PIN.
      recipientImageUrl: _s('recipient_image_url'),
      recipientName: _s('recipient_name'),
      fee: feeRaw,
      totalAmount: totalRaw,
      onPinValidated: (verificationToken) async {
        // The TransactionPinMixin keeps the sheet open through the
        // callback; we close it after the cubit's follow-up completes
        // (or fails). Mark _completed so the card disables itself.
        if (mounted) setState(() => _completed = true);
        if (widget.onPinVerified != null) {
          await widget.onPinVerified!(verificationToken);
        }
      },
    );
    if (!mounted) return;
    setState(() => _isOpen = false);
    if (!success && !_completed) {
      widget.onCancelled?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = _s('amount');
    final currency = _s('currency');
    final fee = _s('fee');
    final total = _s('total_amount');
    final recipient = _s('recipient_summary');
    final recipientName = _s('recipient_name');
    final recipientImage = _s('recipient_image_url');
    final hasRecipientIdentity =
        recipientName.isNotEmpty || recipientImage.isNotEmpty;
    final feeNum = double.tryParse(fee) ?? 0.0;
    final disabled = _completed || _isExpired;
    final accent = _completed
        ? const Color(0xFF10B981)
        : (_isExpired ? const Color(0xFFEF4444) : const Color(0xFF5B45C9));

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient avatar when we know who's being paid (internal
              // Lazervault user); otherwise the transaction-type icon box.
              if (hasRecipientIdentity)
                UserAvatar(
                  size: 36,
                  imageUrl: recipientImage.isEmpty ? null : recipientImage,
                  firstName: recipientName.split(' ').first,
                  lastName: recipientName.split(' ').length > 1
                      ? recipientName.split(' ').sublist(1).join(' ')
                      : null,
                )
              else
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(_typeIcon, color: accent, size: 18),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (recipientName.isNotEmpty || recipient.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        recipientName.isNotEmpty ? recipientName : recipient,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _kv('Amount', '$amount $currency'),
          if (feeNum > 0) _kv('Fee', '$fee $currency'),
          _kv('Total', '$total $currency', emphasise: true),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: disabled ? null : _openPinModal,
              icon: Icon(
                _completed
                    ? Icons.check_circle_outline
                    : (_isExpired
                        ? Icons.timer_off_outlined
                        : Icons.lock_outline),
                size: 16,
              ),
              label: Text(
                _completed
                    ? 'PIN submitted'
                    : (_isExpired ? 'Prompt expired' : 'Enter PIN'),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: accent.withValues(alpha: 0.25),
                disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kv(String label, String value, {bool emphasise = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: emphasise ? Colors.white : const Color(0xFFD1D5DB),
              fontSize: 11,
              fontWeight: emphasise ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
