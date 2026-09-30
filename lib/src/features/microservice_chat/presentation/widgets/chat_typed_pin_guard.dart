import 'package:lazervault/core/utils/pin_mask_utils.dart';

import 'chat_pin_auto_opener.dart';
import 'chat_pin_prompt_card.dart';

/// Stops a transaction PIN from being typed into the chat box.
///
/// WHAT HAPPENED
/// -------------
/// The agents' own instructions say it plainly — "NEVER ask the user to type
/// their PIN into the chat, NEVER accept a PIN as a tool argument" — but the
/// client still sent whatever was typed. When the secure pad failed to appear
/// (the bottom-sheet chat rendered no pin-prompt card at all), the user did
/// the only thing left: typed their PIN into the message box. It went over the
/// wire, was spent as a PIN, and came back "Incorrect PIN. You have 1 attempts
/// remaining." The display was masked to "Secured data ***", which hid the
/// leak without preventing it.
///
/// WHY IT IS CONDITIONAL
/// ---------------------
/// "4 to 6 digits" is not enough on its own to call something a PIN — "5000"
/// is also a perfectly good answer to "how much?". Swallowing that would break
/// the flow far more often than it protects anything. So the guard only bites
/// while a PIN prompt is actually OUTSTANDING. In that state, digits are the
/// PIN, and the right response is not to refuse the user but to put them where
/// the PIN belongs: the secure pad, reopened.
class ChatTypedPinGuard {
  const ChatTypedPinGuard._();

  /// What the surface should do with [text].
  ///
  /// Returns the transaction id whose pad to open when the text must NOT be
  /// sent, and null when the message is ordinary and should go as typed.
  ///
  /// [prompts] is every pin-prompt payload in the transcript, oldest first —
  /// the same list the auto-opener is fed.
  static String? interceptedTransactionId({
    required String text,
    required List<Map<String, dynamic>> prompts,
  }) {
    if (!isPinText(text.trim())) return null;
    if (prompts.isEmpty) return null;
    // Newest only: an older prompt has been completed or superseded.
    final payload = prompts.last;
    if (ChatPinAutoOpener.isExpired(payload)) return null;
    final txId = ChatPinAutoOpener.transactionIdOf(payload);
    return txId.isEmpty ? null : txId;
  }

  /// Reopen the pad for [transactionId]. Safe to call when no card is mounted.
  static void openPadFor(String transactionId) {
    ChatPinPromptCard.autoOpenFor(transactionId);
  }

  /// What to tell the user in the transcript. Short, no blame: they followed
  /// an instruction the app gave them.
  static const String notice =
      'For your security, your PIN goes on the secure pad — not in the chat. '
      'Opening it now.';
}
