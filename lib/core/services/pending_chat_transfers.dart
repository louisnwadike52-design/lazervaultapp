/// Bridges a completed internal (Lazervault-to-Lazervault) transfer back to the
/// P2P chat with that recipient, so the money bubble shows the moment the user
/// opens/returns to the chat — WITHOUT waiting on transaction-history to catch
/// up or on the fragile counterparty-name match.
///
/// Why this exists: the send-funds flow ends on the receipt via
/// `Get.offAllNamed(transferProof)`, which WIPES the navigation stack —
/// including the chat screen that started the send. So the chat can't just
/// reload on return (it's been torn down). Instead, the send flow records the
/// completed transfer here keyed by the recipient's user id, and the chat cubit
/// drains matching entries when it (re)initializes, injecting a real transfer
/// bubble immediately. Entries are deduped against real history rows by their
/// transfer reference, so nothing double-renders once history reflects the tx.
class PendingChatTransfer {
  final String peerUserId;
  final int amountMinor; // kobo / minor units
  final String currency;
  final String? reference; // internal C2C/TRF reference, used for dedup
  final String? note; // optional user narration
  final DateTime createdAt;
  // Real transfer status ('completed' | 'scheduled' | ...). Lets the injected
  // chat bubble render "Money Scheduled" for a not-yet-fired send instead of
  // hardcoding "completed". Null → treated as completed by the consumer.
  final String? status;
  final DateTime? scheduledAt; // when a scheduled send is due to fire

  const PendingChatTransfer({
    required this.peerUserId,
    required this.amountMinor,
    required this.currency,
    required this.createdAt,
    this.reference,
    this.note,
    this.status,
    this.scheduledAt,
  });
}

class PendingChatTransfers {
  PendingChatTransfers._();
  static final PendingChatTransfers instance = PendingChatTransfers._();

  /// How long a recorded transfer stays injectable. Long enough to cover the
  /// receipt → back-to-chat round trip and a few re-opens; short enough that a
  /// stale entry never lingers past transaction-history catching up.
  static const Duration _ttl = Duration(minutes: 15);
  static const int _maxPerPeer = 25;

  final Map<String, List<PendingChatTransfer>> _byPeer = {};

  /// Record a just-completed internal transfer to [peerUserId]. No-op when the
  /// peer id is empty or the same reference was already recorded.
  void record({
    required String peerUserId,
    required int amountMinor,
    required String currency,
    DateTime? createdAt,
    String? reference,
    String? note,
    String? status,
    DateTime? scheduledAt,
  }) {
    if (peerUserId.isEmpty || amountMinor <= 0) return;
    final list = _byPeer.putIfAbsent(peerUserId, () => <PendingChatTransfer>[]);
    if (reference != null &&
        reference.isNotEmpty &&
        list.any((t) => t.reference == reference)) {
      return;
    }
    list.add(PendingChatTransfer(
      peerUserId: peerUserId,
      amountMinor: amountMinor,
      currency: currency,
      reference: reference,
      note: (note != null && note.trim().isNotEmpty) ? note.trim() : null,
      status: (status != null && status.trim().isNotEmpty) ? status.trim() : null,
      scheduledAt: scheduledAt,
      createdAt: createdAt ?? DateTime.now(),
    ));
    if (list.length > _maxPerPeer) {
      list.removeRange(0, list.length - _maxPerPeer);
    }
  }

  /// Non-destructive read of the (non-expired) pending transfers for [peerUserId].
  /// Kept non-destructive so re-opening the chat before history catches up still
  /// shows the bubble; expiry + reference dedup prevent stale/duplicate rows.
  List<PendingChatTransfer> peek(String peerUserId) {
    final list = _byPeer[peerUserId];
    if (list == null || list.isEmpty) return const [];
    final now = DateTime.now();
    list.removeWhere((t) => now.difference(t.createdAt) > _ttl);
    if (list.isEmpty) {
      _byPeer.remove(peerUserId);
      return const [];
    }
    return List.unmodifiable(list);
  }
}
