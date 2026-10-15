import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// "Set up your transaction PIN" — a hand-off, not an input.
///
/// The onboarding agent used to take the new PIN as tool arguments
/// (`create_transaction_pin(pin, confirm_pin)`). A tool argument is read by
/// the LLM and persisted with the tool call in conversation history, so that
/// wrote a brand-new credential into chat history in plaintext.
///
/// There was nothing to hand off TO: the existing pin_prompt opens the pad
/// for SPENDING against a PIN that already exists. This card is the missing
/// half — it routes to the same native setup screen the account screens use,
/// and the digits never cross the chat boundary.
///
/// Deliberately has no text field. Any input here would recreate the defect.
class ChatPinSetupCard extends StatelessWidget {
  const ChatPinSetupCard({super.key, this.reason});

  /// Why the user is being asked, shown verbatim. Says the reason, never
  /// what to type.
  final String? reason;

  @override
  Widget build(BuildContext context) {
    final why = (reason ?? '').trim();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lock_outline, color: Color(0xFF9B6DFF), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Set up your transaction PIN',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          if (why.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              why,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
            ),
          ],
          const SizedBox(height: 6),
          const Text(
            'You enter it on the secure screen — it is never typed into this '
            'chat and never stored in the conversation.',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 11.5),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed(AppRoutes.transactionPinSetup),
              icon: const Icon(Icons.shield_outlined, size: 18),
              label: const Text('Set up PIN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
