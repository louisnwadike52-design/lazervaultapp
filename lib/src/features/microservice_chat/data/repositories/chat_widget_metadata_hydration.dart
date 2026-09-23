/// Rebuilding a conversation's RICH WIDGETS from stored history.
///
/// A chat turn is not always text. A money move renders a confirm-transfer card, a
/// completed one renders a receipt, and those are the parts of the transcript a user
/// actually looks for when they come back. The agent persists what it needs to redraw
/// them — `metadata.pin_prompt`, `metadata.receipt_card`, `metadata.receipt_data` — but
/// only the keys a history mapper copies forward survive the reload. Anything it drops
/// silently degrades to a plain grey bubble.
///
/// THE BUG THIS FIXES
/// ------------------
/// There are TWO history paths — `getHistory` (session-based) and `getDirectHistory`
/// (per-service chat, used by the bills hub and every other service bottom sheet) — and
/// they had drifted. `getHistory` hydrated `pin_prompt` and the V2 `receipt_card`;
/// `getDirectHistory` hydrated neither, carrying only the legacy `receipt_data`.
///
/// So leaving a service chat and coming back turned a styled confirm-transfer card and a
/// V2 receipt into bare text, while the same conversation in the general chat kept them.
/// Nothing errored; the widgets just stopped being widgets.
///
/// Keeping the logic in one place is the actual fix. Two mappers that must agree but are
/// written separately WILL diverge again — they already did once.
library;

/// Keys that carry a renderable widget in a stored message's metadata.
///
/// `receipt_data` is the legacy single receipt; `receipt_card` is the V2 shape and may be
/// a Map (one receipt) or a List (a batch), which is why its type is checked loosely.
const String kChatMetaReceiptData = 'receipt_data';
const String kChatMetaReceiptCard = 'receipt_card';
const String kChatMetaPinPrompt = 'pin_prompt';

/// QR and recipient cards.
///
/// These ride a DIFFERENT live channel from the receipt and PIN cards — the agent passes
/// them as a JSON string in `entities['_qr_card']` / `entities['_recipient_card']`, which
/// the cubit decodes and then removes. That channel is not part of stored history, so a
/// card rendered live turns back into plain text on reload.
///
/// Hydrating them here closes the client half: whenever they are present in stored
/// metadata they render again. Persisting them into metadata is the server half, and
/// hydration has to exist first or there would be nothing to read it.
const String kChatMetaQrCard = 'qr_card';
const String kChatMetaRecipientCard = 'recipient_card';

/// Rebuilds the widget metadata for ONE stored message.
///
/// [storedMetadata] is the message's persisted `metadata`; [entities] is the agent's
/// entity bag, which held the receipt before it moved into metadata and is still read for
/// older conversations.
///
/// Returns null when the message carries no widget, so a plain text turn stays plain
/// rather than gaining an empty map.
Map<String, dynamic>? hydrateChatWidgetMetadata({
  Map<String, dynamic>? storedMetadata,
  Map<String, dynamic>? entities,
}) {
  Map<String, dynamic>? out;

  void put(String key, dynamic value) {
    out = (out ?? <String, dynamic>{})..[key] = value;
  }

  // Receipt, legacy shape. Metadata wins over entities: entities is where it used to
  // live, so a message carrying both is a migrated one and metadata is the current copy.
  final receiptData = storedMetadata?[kChatMetaReceiptData];
  final legacyReceipt = entities?['_$kChatMetaReceiptData'];
  if (receiptData is Map<String, dynamic>) {
    put(kChatMetaReceiptData, receiptData);
  } else if (legacyReceipt is Map<String, dynamic>) {
    put(kChatMetaReceiptData, legacyReceipt);
  }

  // Receipt, V2. Map for a single receipt, List for a batch — both render.
  final receiptCard = storedMetadata?[kChatMetaReceiptCard];
  if (receiptCard is Map || receiptCard is List) {
    put(kChatMetaReceiptCard, receiptCard);
  }

  // Confirm-transfer prompt. Hydrated for EVERY message here; keeping it only on the
  // latest assistant turn is a separate concern handled by [markSupersededPinPrompts],
  // because that decision needs the whole transcript and this function sees one message.
  final pinPrompt = storedMetadata?[kChatMetaPinPrompt];
  if (pinPrompt is Map<String, dynamic>) {
    put(kChatMetaPinPrompt, pinPrompt);
  }

  // QR and recipient cards. Both are history artifacts like a receipt — they describe
  // something the turn produced — so they are kept on EVERY message, not just the last.
  for (final key in const [kChatMetaQrCard, kChatMetaRecipientCard]) {
    final v = storedMetadata?[key];
    if (v is Map || v is List) put(key, v);
  }

  return out;
}

/// Marks superseded `pin_prompt` cards terminal instead of deleting them.
///
/// WHY THEY ARE KEPT
/// ----------------
/// They used to be removed from every message but the latest, so a completed transfer
/// left only its receipt in the transcript and the confirm-transfer card vanished. The
/// card is part of what happened — scrolling back to see what you approved, and for how
/// much, is the normal reason to reopen a conversation — so it stays.
///
/// What must NOT survive is its INTERACTIVITY. A live card opens the secure PIN pad, and
/// with the auto-opener wired it can do so without being asked. So each superseded card
/// is stamped with the outcome and the card renders it read-only.
///
/// HOW THE OUTCOME IS DECIDED
/// --------------------------
/// The agent stores no status on the prompt, so it is inferred — and only ever from
/// evidence:
///
///   * A receipt whose `reference` CONTAINS the prompt's transaction_id means that exact
///     transfer completed. The platform reference embeds the chat intent id
///     (TRF-CHAT-transfer-<id>), which is what makes the match reliable rather than
///     positional.
///   * Anything else is stamped INACTIVE, never "completed". A superseded prompt might
///     have been abandoned, and telling someone a transfer completed when it did not is
///     the one error worth avoiding here. The card says so neutrally instead.
const String kPinPromptHistoryState = '_history_state';
const String kPinPromptStateCompleted = 'completed';
const String kPinPromptStateInactive = 'inactive';

void markSupersededPinPrompts<T>(
  List<T> messages, {
  required bool Function(T) isUser,
  required Map<String, dynamic>? Function(T) metadataOf,
}) {
  // Every receipt reference in the transcript, for the completion match below.
  final references = <String>[];
  for (final m in messages) {
    final card = metadataOf(m)?[kChatMetaReceiptCard];
    void collect(dynamic c) {
      if (c is Map) {
        final r = c['reference']?.toString().trim() ?? '';
        if (r.isNotEmpty) references.add(r);
      }
    }
    if (card is List) {
      for (final c in card) {
        collect(c);
      }
    } else {
      collect(card);
    }
  }

  var latestAssistant = -1;
  for (var i = messages.length - 1; i >= 0; i--) {
    if (!isUser(messages[i])) {
      latestAssistant = i;
      break;
    }
  }

  for (var i = 0; i < messages.length; i++) {
    if (i == latestAssistant) continue;
    final meta = metadataOf(messages[i]);
    final prompt = meta?[kChatMetaPinPrompt];
    if (prompt is! Map) continue;

    final txId = prompt['transaction_id']?.toString().trim() ?? '';
    final completed = txId.isNotEmpty && references.any((r) => r.contains(txId));

    // Write a COPY back rather than mutating the prompt in place.
    //
    // The hydrated map is a reference to whatever the history layer decoded, and that is
    // not guaranteed to be modifiable — an unmodifiable or const map would throw here and
    // take down the whole conversation load. Replacing the entry is also the honest
    // shape: this function owns the metadata map it was handed, not the objects inside it.
    meta![kChatMetaPinPrompt] = <String, dynamic>{
      ...prompt.map((k, v) => MapEntry(k.toString(), v)),
      kPinPromptHistoryState:
          completed ? kPinPromptStateCompleted : kPinPromptStateInactive,
    };
  }
}
