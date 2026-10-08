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
  ChatPinAutoOpener() : _attachedAt = DateTime.now().toUtc();

  /// When this opener started watching its conversation.
  ///
  /// THE AUTHORITATIVE LIVENESS TEST, replacing a stack of heuristics.
  ///
  /// A prompt minted BEFORE we attached is history; one minted after is live.
  /// That is arithmetic on a server timestamp, and it holds no matter which
  /// state class carried the prompt — which matters because `loadHistory`
  /// finishes on the SAME success state a live reply does, so the state class
  /// never could distinguish them.
  ///
  /// What it replaces: "record whatever is in the transcript on the first
  /// observation, and only open ids that appear later". That worked only if the
  /// first observation happened to be an empty or history-only transcript. Two
  /// of the five chat surfaces drive this from `BlocConsumer.listener`, which
  /// is NOT called for the initial state — so their first observation is
  /// whichever state change arrives first, and when that one already carried a
  /// fresh prompt, priming swallowed it: the card rendered with its "Enter PIN"
  /// button and the pad never opened by itself. Exactly the reported symptom,
  /// and invisible because declining was silent.
  DateTime _attachedAt;

  /// Highest `prompt_seq` this opener has acted on — the compare-and-swap cell.
  ///
  /// The server mints a monotonic seq per prompt, so "already opened" and
  /// "asked again" are distinguishable by a single integer comparison. The swap
  /// happens BEFORE the open, so a rebuild in the same frame cannot double-fire.
  ///
  /// The counting it replaces was defeated by design: the chat derives a
  /// prompt's transaction_id from a 60-second bucket (deliberately — it is the
  /// saga's double-send guard), so a re-ask inside a minute produces the SAME
  /// id, and the opener had to infer a re-ask from how many times that id
  /// appeared in the transcript.
  int _handledSeq = 0;

  /// EVERY transaction this opener has auto-opened, not just the newest.
  ///
  /// The tiebreak for when the seq does not advance — see the swap below. Each
  /// chat service mints its own seq, so equal seqs from two services are
  /// possible and `>` alone would drop one of them.
  ///
  /// A SET rather than the last id: holding only the newest meant replaying an
  /// EARLIER transaction (seq still <= the high-water mark, id different from
  /// the newest) read as a new ask and reopened a pad the user had already
  /// dealt with. Session-scoped and cleared on reset, so it stays small.
  final Set<String> _handledTxIds = <String>{};

  /// Highest seq the user dismissed. A later prompt re-arms; this one does not.
  int _cancelledSeq = 0;

  /// Every transaction the user dismissed, same purpose.
  final Set<String> _cancelledTxIds = <String>{};

  /// Seq of the newest prompt seen, so [noteCancelled] can stamp it without the
  /// card needing to know about sequences.
  int _lastSeenSeq = 0;

  /// Mint time of that newest prompt, for the same reason.
  DateTime? _lastSeenIssuedAt;

  /// Why the last [sync] declined to open, for diagnosis.
  ///
  /// Every decline path writes here and logs. Three rounds of fixes went into
  /// this component without anyone being able to say WHICH guard was biting,
  /// because declining produced no output at all.
  String? lastDeclineReason;

  void _decline(String reason) {
    lastDeclineReason = reason;
    debugPrint('[chat-pin] not opening the pad: $reason');
  }

  /// The server's mint time for a prompt, or null when it did not supply one.
  static DateTime? issuedAtOf(Map<String, dynamic> payload) {
    final raw = payload['issued_at']?.toString().trim() ?? '';
    if (raw.isEmpty) return null;
    return DateTime.tryParse(raw)?.toUtc();
  }

  /// The server's monotonic sequence for a prompt; 0 when not supplied.
  static int seqOf(Map<String, dynamic> payload) {
    final raw = payload['prompt_seq'];
    if (raw is int) return raw;
    return int.tryParse(raw?.toString() ?? '') ?? 0;
  }

  /// True when the payload carries BOTH authoritative fields.
  ///
  /// Both or neither: a seq with no issued_at cannot be tested for liveness,
  /// and an issued_at with no seq cannot be compare-and-swapped. Falling back
  /// wholesale is safer than running half the new scheme.
  static bool hasAuthoritativeOrdering(Map<String, dynamic> payload) =>
      seqOf(payload) > 0 && issuedAtOf(payload) != null;

  /// How many times each id had APPEARED in the transcript when it was opened.
  ///
  /// A count rather than a flag, because "already opened" and "asked again" are
  /// otherwise indistinguishable. The chat derives a prompt's transaction_id from
  /// (user, kind, amount, counterparty, 60-second bucket) — that determinism is
  /// the saga's double-send guard — so asking twice for the same transfer inside a
  /// minute produces the SAME id. With a flag, the second ask was swallowed: the
  /// pad never reappeared and the user was told to enter a PIN on a pad that was
  /// not there. A re-ask appends a NEW prompt message, so the id's occurrence
  /// count rises, while a mere rebuild passes the same list and it does not.
  final Map<String, int> _openedAt = <String, int>{};

  /// Same, for ids the user dismissed.
  ///
  /// Dismissing means "not now", and that must survive rebuilds — but not an
  /// explicit re-ask. Someone who closes the pad and then types "send it again"
  /// has changed their mind, and refusing to reopen would strand them.
  final Map<String, int> _cancelledAt = <String, int>{};

  /// Occurrences seen on the last sync, so noteCancelled can stamp the right
  /// count without the card having to know about transcript positions.
  final Map<String, int> _lastSeenCount = <String, int>{};

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
  Set<String> get debugOpened => Set.unmodifiable(_openedAt.keys);

  /// How many times each id has been auto-opened, for tests that need to tell a
  /// re-ask (2) from a rebuild (1).
  @visibleForTesting
  Map<String, int> get debugOpenCounts => Map.unmodifiable(_openCounts);
  final Map<String, int> _openCounts = <String, int>{};

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
    // Stamped at the count the prompt was at when dismissed, so only a LATER
    // appearance — a genuine re-ask — can reopen it.
    _cancelledAt[transactionId] = _lastSeenCount[transactionId] ?? 1;
    // And on the authoritative cell, so a prompt with a HIGHER seq still
    // re-arms while this one stays dismissed.
    if (_lastSeenSeq > _cancelledSeq) _cancelledSeq = _lastSeenSeq;
    // And the id, because seqs from independent services can tie: a DIFFERENT
    // transaction must still re-arm even when the seq does not advance.
    _cancelledTxIds.add(transactionId);
  }

  /// Forget everything. Call when the conversation changes.
  ///
  /// Session-scoped rather than global: switching to another conversation that has its own
  /// live prompt should open it, and leaving these sets populated across sessions would
  /// also leak ids for the lifetime of the screen.
  void reset() {
    _openedAt.clear();
    _cancelledAt.clear();
    _openCounts.clear();
    _lastSeenCount.clear();
    _preexisting.clear();
    _primed = false;
    // The authoritative cells too. Re-attaching is the point of a reset: a
    // prompt minted before NOW belongs to the conversation we just left.
    _attachedAt = DateTime.now().toUtc();
    _handledSeq = 0;
    _cancelledSeq = 0;
    _lastSeenSeq = 0;
    _handledTxIds.clear();
    _cancelledTxIds.clear();
    _lastSeenIssuedAt = null;
    lastDeclineReason = null;
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
    lastDeclineReason = null;

    // AUTHORITATIVE PATH — taken whenever the server supplied issued_at +
    // prompt_seq. It needs no priming, no occurrence counting and no
    // `isLiveTurn`, which is what makes it immune to the surface-specific
    // ordering that broke the heuristic below.
    if (prompts.isNotEmpty && hasAuthoritativeOrdering(prompts.last)) {
      // Prime the LEGACY sets anyway, so a conversation that later receives a
      // prompt from an older service (mid-rollout) is not treated as brand new.
      if (!_primed) {
        _primed = true;
        for (final p in prompts) {
          final id = transactionIdOf(p);
          if (id.isNotEmpty) _preexisting.add(id);
        }
      }
      _syncAuthoritative(context: context, payload: prompts.last);
      return;
    }

    // First observation of this conversation: record what is already in the transcript
    // and open nothing. See [_preexisting] — history finishes on the same success state
    // a live reply does, so appearance is the only trustworthy signal.
    if (!_primed) {
      _primed = true;
      for (final p in prompts) {
        final id = transactionIdOf(p);
        if (id.isNotEmpty) _preexisting.add(id);
      }
      _decline('first observation of this conversation (legacy heuristic)');
      return;
    }

    if (!isLiveTurn) {
      _decline('not a live turn (legacy heuristic)');
      return;
    }
    if (prompts.isEmpty) {
      _decline('no pin prompts in the transcript');
      return;
    }

    // Newest only. An older prompt in the same conversation has either been completed or
    // superseded — "make it 200" leaves the ₦500 prompt above it in the transcript, and
    // opening that one would confirm the amount the user just corrected.
    final payload = prompts.last;
    final txId = transactionIdOf(payload);
    if (txId.isEmpty) return;
    if (_preexisting.contains(txId)) return;
    if (isExpired(payload)) return;

    // How many prompt messages in the transcript carry this id. A rebuild does
    // not change it; a re-ask does, because the agent appends a new message.
    var occurrences = 0;
    for (final p in prompts) {
      if (transactionIdOf(p) == txId) occurrences++;
    }
    _lastSeenCount[txId] = occurrences;

    // Open only for an appearance we have not already acted on. This is what
    // makes a repeat "send ₦500 to Chris" inside the same minute reopen the pad
    // even though the derived transaction_id is identical.
    if (occurrences <= (_openedAt[txId] ?? 0)) return;
    if (occurrences <= (_cancelledAt[txId] ?? 0)) return;

    // Marked before the await so a rebuild in the same frame cannot open twice.
    _openedAt[txId] = occurrences;
    _openCounts[txId] = (_openCounts[txId] ?? 0) + 1;

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

  /// The compare-and-swap open. Only called when the payload carries both
  /// `issued_at` and `prompt_seq`.
  void _syncAuthoritative({
    required BuildContext context,
    required Map<String, dynamic> payload,
  }) {
    final txId = transactionIdOf(payload);
    if (txId.isEmpty) {
      _decline('prompt carries no transaction_id');
      return;
    }
    if (isExpired(payload)) {
      _decline('prompt $txId has expired');
      return;
    }

    final seq = seqOf(payload);
    final issuedAt = issuedAtOf(payload)!;
    if (seq > _lastSeenSeq) _lastSeenSeq = seq;
    if (_lastSeenIssuedAt == null || issuedAt.isAfter(_lastSeenIssuedAt!)) {
      _lastSeenIssuedAt = issuedAt;
    }

    // Minted before we attached: this is a replayed prompt from history, and
    // opening a pad for a transfer the user may have completed days ago is the
    // single worst thing this component could do.
    if (!issuedAt.isAfter(_attachedAt)) {
      _decline('prompt $txId was minted at $issuedAt, before this conversation '
          'was attached at $_attachedAt — history, not a live turn');
      return;
    }

    // THE SWAP. Strictly greater, and written before the open so a rebuild in
    // the same frame cannot fire twice.
    //
    // THE TRANSACTION ID IS THE TIEBREAK when the seq does not advance.
    //
    // Each chat service (transfers, commerce, accounts…) mints its own seq, so
    // two services CAN produce the same value and a strict `>` would silently
    // drop the second — the pad would never open for it, and declining is
    // silent. That is the "opened once, then never again" report.
    //
    // The discriminator is the transaction id, NOT issued_at. A rebuild replays
    // the identical stored payload, so its id is identical and it is correctly
    // refused; a prompt from a different service is a different transaction and
    // opens. issued_at was tried and rejected: any surface that rebuilds a
    // payload with a fresh timestamp would reopen the modal on every rebuild,
    // which is a worse failure than the one being fixed.
    if (seq <= _handledSeq && _handledTxIds.contains(txId)) {
      _decline('seq $seq already handled (at $_handledSeq) for the same '
          'transaction $txId — a rebuild, not a new ask');
      return;
    }
    // A dismissal is remembered the same way: another transaction re-arms,
    // this one stays dismissed.
    if (seq <= _cancelledSeq && _cancelledTxIds.contains(txId)) {
      _decline('seq $seq was dismissed by the user — their "Enter PIN" tap '
          'still works');
      return;
    }
    _handledSeq = seq > _handledSeq ? seq : _handledSeq;
    _handledTxIds.add(txId);
    _openedAt[txId] = (_openedAt[txId] ?? 0) + 1;
    _openCounts[txId] = (_openCounts[txId] ?? 0) + 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        _decline('the chat surface was disposed before the pad could open');
        return;
      }
      final route = ModalRoute.of(context);
      if (route != null && !route.isCurrent) {
        // A modal over an unrelated screen is worse than a missed auto-open,
        // and the card's button is still there when they come back.
        _decline('the chat is no longer the current route');
        return;
      }
      debugPrint('[chat-pin] opening the pad for $txId (seq $seq)');
      ChatPinPromptCard.autoOpenFor(txId);
    });
  }
}
