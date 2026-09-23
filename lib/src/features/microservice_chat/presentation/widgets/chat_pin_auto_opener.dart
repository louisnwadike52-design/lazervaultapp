import 'package:flutter/material.dart';

import 'chat_pin_prompt_card.dart';

/// Drives the PIN sheet open the moment a chat turn asks for one.
///
/// WHY THIS EXISTS AS A SHARED PIECE
/// ---------------------------------
/// `ChatPinPromptCard` has carried an [ChatPinPromptCard.autoOpenFor] entry point for a
/// while, and two of the four chat surfaces used it. The other two — `general_chat_content`
/// (NOVA, the general assistant) and `microservice_chat_content` — did not, and they also
/// rendered the card WITHOUT [ChatPinPromptCard.keyFor], so the key was never registered
/// and auto-open could not have worked there even if it had been called.
///
/// The result was a split experience for the same money move: ask the AI chat to send
/// money and the secure pad appears; ask NOVA and you get a card you have to tap. Worse,
/// the tap was easy to miss — the user reads "enter your PIN on the secure pad", sees no
/// pad, and assumes the transfer is stuck.
///
/// Rather than copy the listener a third and fourth time, the whole decision lives here.
/// It is a plain object, not a widget: each surface owns one and feeds it state, so there
/// is exactly one definition of when the sheet may open.
///
/// WHAT IT GUARDS AGAINST
/// ----------------------
/// Opening a modal automatically is easy to get wrong in ways that are worse than not
/// opening it at all, so every one of these is deliberate:
///
///   * HISTORY REPLAY — a conversation reloaded from history replays old `pin_prompt`
///     messages. Opening a PIN pad for a transfer the user completed days ago is alarming
///     and, if they enter it, acts on a stale intent. Only live turns open.
///   * ONE SHOT PER TRANSACTION — a rebuild must not reopen a sheet the user just closed.
///     Marked BEFORE the async open so a same-frame rebuild cannot double-fire.
///   * CANCELLATION IS REMEMBERED — dismissing the sheet means "not now". Re-opening it
///     on the next rebuild would trap the user in a modal they are actively declining.
///     The card's own "Enter PIN" button still works, so the decision stays theirs.
///   * A NEW PROMPT RE-ARMS — "make it 200" produces a NEW transaction_id, which is a new
///     intent and opens normally even if the previous one was cancelled. This is why the
///     guards are keyed by transaction id rather than by a single boolean.
///   * NAVIGATION — if the user has left the chat (pushed another route, switched tab)
///     the sheet must not appear over whatever they are now looking at. Checked after the
///     frame, because the route can change between the state emission and the open.
///   * EXPIRY — an expired prompt cannot be completed; the card renders it as expired and
///     the sheet would only fail.
class ChatPinAutoOpener {
  /// Transaction ids already auto-opened once.
  final Set<String> _opened = <String>{};

  /// Transaction ids the user dismissed. Never auto-opened again.
  final Set<String> _cancelled = <String>{};

  /// Prompts that were already in the transcript when this opener started watching.
  ///
  /// THE SUBTLE PART. `loadHistory` emits the SAME success state a live reply does — it
  /// finishes with `GeneralChatSuccess`, not a distinct history state — so a caller that
  /// keys "live turn" off the state class alone would auto-open the PIN pad for a
  /// transfer the user completed days ago. That is the single worst failure this
  /// component could have.
  ///
  /// So eligibility is decided by APPEARANCE, not by state class: the first observation
  /// records whatever is already there without opening anything, and only ids that show
  /// up afterwards can open. That holds regardless of which state carried them, which
  /// makes it robust to the cubit's emission order changing later.
  final Set<String> _preexisting = <String>{};
  bool _primed = false;

  /// The ids this opener has auto-opened, for tests.
  ///
  /// Exposed because the decision is the thing worth asserting: the opener drives the
  /// card through a GlobalKey, so with no card mounted an open is a no-op and there is
  /// nothing else observable. Read-only view — callers cannot mutate the guard sets.
  @visibleForTesting
  Set<String> get debugOpened => Set.unmodifiable(_opened);

  /// Extracts the transaction id a prompt payload refers to.
  static String transactionIdOf(Map<String, dynamic> payload) =>
      payload['transaction_id']?.toString().trim() ?? '';

  /// True when the prompt's own expiry has passed.
  ///
  /// Mirrors the card's `_isExpired`. A missing or unparseable value is treated as NOT
  /// expired: the server is the authority on expiry, and refusing to open on a timestamp
  /// we failed to read would block a valid transfer.
  static bool isExpired(Map<String, dynamic> payload) {
    final raw = payload['expires_at']?.toString() ?? '';
    if (raw.isEmpty) return false;
    final exp = DateTime.tryParse(raw);
    if (exp == null) return false;
    return exp.isBefore(DateTime.now().toUtc());
  }

  /// Record that the user dismissed the sheet for [transactionId].
  ///
  /// Wired to the card's `onCancelled`. Without this the next rebuild would reopen the
  /// sheet the user just closed, which reads as the app refusing to take no for an answer.
  void noteCancelled(String transactionId) {
    if (transactionId.isEmpty) return;
    _cancelled.add(transactionId);
  }

  /// Forget everything. Call when the conversation changes.
  ///
  /// Session-scoped rather than global: switching to another conversation that has its own
  /// live prompt should open it, and leaving these sets populated across sessions would
  /// also leak ids for the lifetime of the screen.
  void reset() {
    _opened.clear();
    _cancelled.clear();
    _preexisting.clear();
    _primed = false;
  }

  /// Open the sheet for the newest live prompt, if one is eligible.
  ///
  /// [prompts] is every pin-prompt payload currently in the conversation, oldest first.
  /// [isLiveTurn] must be false whenever the emission came from loading history.
  void sync({
    required BuildContext context,
    required List<Map<String, dynamic>> prompts,
    required bool isLiveTurn,
  }) {
    // First observation of this conversation: record what is already in the transcript
    // and open nothing. See [_preexisting] — history finishes on the same success state
    // a live reply does, so appearance is the only trustworthy signal.
    if (!_primed) {
      _primed = true;
      for (final p in prompts) {
        final id = transactionIdOf(p);
        if (id.isNotEmpty) _preexisting.add(id);
      }
      return;
    }

    if (!isLiveTurn || prompts.isEmpty) return;

    // Newest only. An older prompt in the same conversation has either been completed or
    // superseded — "make it 200" leaves the ₦500 prompt above it in the transcript, and
    // opening that one would confirm the amount the user just corrected.
    final payload = prompts.last;
    final txId = transactionIdOf(payload);
    if (txId.isEmpty) return;
    if (_preexisting.contains(txId)) return;
    if (_opened.contains(txId) || _cancelled.contains(txId)) return;
    if (isExpired(payload)) return;

    // Marked before the await so a rebuild in the same frame cannot open twice.
    _opened.add(txId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // The route can change between the state emission and this callback — the user may
      // have tapped a receipt, opened a session drawer, or backed out entirely. A modal
      // that appears over an unrelated screen is worse than a missed auto-open, and the
      // card's button is still there when they return.
      if (!context.mounted) return;
      final route = ModalRoute.of(context);
      if (route != null && !route.isCurrent) return;

      // Drives the CARD's own modal via its GlobalKey, so the auto-open and the manual
      // tap share one implementation and one set of guards.
      ChatPinPromptCard.autoOpenFor(txId);
    });
  }
}
