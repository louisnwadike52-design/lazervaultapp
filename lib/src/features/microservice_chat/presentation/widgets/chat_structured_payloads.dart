import 'package:flutter/material.dart';

import 'bill_receipt_deeplink.dart';
import 'chat_analytics_card.dart';
import 'chat_pin_auto_opener.dart';
import 'chat_pin_prompt_card.dart';
import 'chat_receipt_card.dart';
import 'chat_receipt_card_v2.dart';
import 'chat_recipient_card.dart';
import 'llm_error_banner.dart';

/// Everything an agent turn can carry BESIDES text: the receipt, the PIN pad
/// prompt, the recipient card, a chart, a degradation banner, a bill deep-link.
///
/// WHY THIS IS SHARED
/// ------------------
/// There are two per-service chat surfaces — the full screen
/// (`microservice_chat_content`) and the bottom sheet
/// (`service_chat_bottom_sheet`) — and only the screen rendered any of this.
/// The sheet is what the Send Funds flow opens, so from there a money move
/// looked like this:
///
///   agent: "Please enter your PIN to confirm the transfer of ₦500 to GRACE…"
///   user:  types their PIN into the chat box
///   agent: "Incorrect PIN. You have 1 attempts remaining."
///   user:  "the pin bottomsheet didn't appear"
///
/// The pad never appeared because the CARD was never built: the auto-opener
/// drives the card through a GlobalKey, so with no card mounted every open is
/// a silent no-op. And with no pad, a user told to enter a PIN does the only
/// thing left — types it into the message box, where it does not belong.
///
/// Rendering the same payloads from one place is what makes the two surfaces
/// incapable of drifting again.
class ChatStructuredPayloads extends StatelessWidget {
  const ChatStructuredPayloads({
    super.key,
    required this.metadata,
    required this.isUser,
    required this.onPinCancelled,
    required this.onPinVerified,
    required this.onChangeRecipient,
  });

  final Map<String, dynamic>? metadata;
  final bool isUser;

  /// Told when the user dismisses the pad, so the auto-opener stops reopening it.
  final void Function(String transactionId) onPinCancelled;

  /// Receives the VERIFICATION TOKEN — never the raw PIN, which does not leave
  /// the native sheet.
  final Future<void> Function(
    String verificationToken,
    String callbackIntent,
    Map<String, dynamic> callbackArgs,
  ) onPinVerified;

  final VoidCallback onChangeRecipient;

  @override
  Widget build(BuildContext context) {
    final md = metadata;
    if (isUser || md == null || md.isEmpty) return const SizedBox.shrink();

    final children = <Widget>[];

    // A successful transfer surfaces both receipt_data and receipt_card; the
    // richer receipt_data card wins, and V2 is the fallback for flows that
    // emit only receipt_card (batch transfers produce a list of them).
    if (md['receipt_data'] != null) {
      children.add(_receiptCard(md['receipt_data']));
    } else if (md['receipt_card'] != null) {
      children.add(_receiptCardV2(md['receipt_card']));
    }

    if (md['llm_error_code'] is String) {
      children.add(LlmErrorBanner.build(md['llm_error_code'] as String));
    }

    if (md['analytics_card'] is Map) {
      children.add(ChatAnalyticsCard(
        payload: Map<String, dynamic>.from(md['analytics_card'] as Map),
      ));
    }

    if (md['recipient_card'] is Map) {
      children.add(ChatRecipientCard(
        data: Map<String, dynamic>.from(md['recipient_card'] as Map),
        onChangeRecipient: onChangeRecipient,
      ));
    }

    if (md['pin_prompt'] is Map) {
      children.add(_pinPromptCard(
        Map<String, dynamic>.from(md['pin_prompt'] as Map),
      ));
    }

    if (md['bill_type'] is String && md['last_payment_id'] is String) {
      children.add(BillReceiptDeepLinkButton(
        billType: md['bill_type'] as String,
        paymentId: md['last_payment_id'] as String,
      ));
    }

    if (children.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _pinPromptCard(Map<String, dynamic> payload) {
    final callbackIntent = payload['callback_intent']?.toString() ?? '';
    final rawArgs = payload['callback_args'];
    final callbackArgs = rawArgs is Map
        ? Map<String, dynamic>.from(rawArgs)
        : <String, dynamic>{};
    final txId = ChatPinAutoOpener.transactionIdOf(payload);
    return ChatPinPromptCard(
      // Stable key per transaction_id. Without it autoOpenFor() has no card to
      // drive and the pad silently never appears.
      // Self-registers by transaction_id on mount — see ChatPinPromptCard.
      payload: payload,
      onCancelled: () => onPinCancelled(txId),
      onPinVerified: (token) =>
          onPinVerified(token, callbackIntent, callbackArgs),
    );
  }

  Widget _receiptCardV2(dynamic payload) {
    if (payload is List) return ChatReceiptCardV2List(payloads: payload);
    if (payload is Map) {
      return ChatReceiptCardV2(payload: Map<String, dynamic>.from(payload));
    }
    return const SizedBox.shrink();
  }

  Widget _receiptCard(dynamic receiptData) {
    try {
      final Map<String, dynamic> data;
      if (receiptData is Map<String, dynamic>) {
        data = receiptData;
      } else if (receiptData is Map) {
        data = Map<String, dynamic>.from(receiptData);
      } else {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ChatReceiptCard(receipt: TransferReceiptData.fromJson(data)),
      );
    } catch (_) {
      // Malformed receipt data. The transfer still succeeded, so say that
      // rather than rendering nothing at all.
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2E1A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Color(0xFF34C759), size: 18),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Transfer completed',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
