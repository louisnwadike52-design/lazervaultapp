import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/p2p_chat/data/models/p2p_message_model.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';

/// Disk mirror of the last page of a chat thread, per (user, peer).
///
/// [P2PChatSnapshotCache] already lets a RE-opened chat paint instantly, but
/// it is process-lifetime: the first open after a launch still showed a
/// spinner until getOrCreateConversation + the first page came back. This
/// remembers that page on disk so the cold open paints too, and the fetch
/// that follows merges over it exactly as it does over the memory snapshot.
///
/// Rows are plain JSON maps: row 0 carries the conversation metadata the
/// composer needs (can the user send? is there a safety banner?), the rest
/// are messages in display order. Unsent / failed optimistic bubbles are not
/// mirrored — after a relaunch there is nothing to retry them with.
class P2PChatThreadStore {
  P2PChatThreadStore._();

  /// Peers remembered at once. Each is its own SessionPageStore (one disk
  /// key per peer); the oldest is dropped when the cap is reached.
  static const int _maxPeers = 8;

  /// Messages kept per peer: the cursor page (30) plus a little scroll-back.
  static const int _maxMessages = 60;

  static final Map<String, SessionPageStore<Map<String, dynamic>>> _stores = {};

  static SessionPageStore<Map<String, dynamic>> _storeFor(String peerId) {
    final existing = _stores.remove(peerId);
    if (existing != null) {
      _stores[peerId] = existing; // most-recently-used
      return existing;
    }
    while (_stores.length >= _maxPeers) {
      // `dispose`, not `clear`: a store is created here PER PEER, and
      // SessionPageStore registers every instance in a static list. Clearing
      // alone would leave a dead registration behind for every peer the user
      // has ever opened a chat with, which SessionPageStore.clearAll then
      // walks on each user switch.
      _stores.remove(_stores.keys.first)?.dispose();
    }
    return _stores[peerId] = SessionPageStore<Map<String, dynamic>>(
      'p2p_chat_thread.$peerId',
      toJson: (m) => m,
      fromJson: (j) => j,
      maxAge: const Duration(days: 7),
    );
  }

  /// Remember [state] for the next open of [peerId].
  static void put(String userId, String peerId, P2PChatLoaded state) {
    if (userId.isEmpty || peerId.isEmpty) return;
    final messages = state.messages
        .where((m) =>
            m.id.isNotEmpty &&
            m.deliveryStatus != 'sending' &&
            m.deliveryStatus != 'failed')
        .toList();
    final tail = messages.length > _maxMessages
        ? messages.sublist(messages.length - _maxMessages)
        : messages;
    _storeFor(peerId).put([
      {
        '_meta': true,
        'conversation_id': state.conversationId,
        'connection_status': state.connectionStatus,
        'initiated_by': state.initiatedBy,
        'can_send': state.canSendMessage,
        'safety_warning': state.safetyWarning,
        'safety_warning_reason': state.safetyWarningReason,
        'has_more': state.hasMore,
      },
      for (final m in tail) encodeMessage(m),
    ], userId: userId);
  }

  /// The remembered thread for (user, peer), or null on a genuine cold open.
  static Future<P2PChatLoaded?> hydrate(String userId, String peerId) async {
    if (userId.isEmpty || peerId.isEmpty) return null;
    final rows = await _storeFor(peerId).hydrate(userId: userId);
    if (rows == null || rows.isEmpty) return null;
    final meta = rows.first;
    if (meta['_meta'] != true) return null;
    final conversationId = meta['conversation_id'] as String? ?? '';
    if (conversationId.isEmpty) return null;
    final messages = <P2PMessageEntity>[];
    for (final r in rows.skip(1)) {
      try {
        messages.add(decodeMessage(r));
      } catch (_) {
        // One unreadable row is not a reason to lose the thread.
      }
    }
    return P2PChatLoaded(
      messages: messages,
      conversationId: conversationId,
      hasMore: meta['has_more'] == true,
      connectionStatus: meta['connection_status'] as String? ?? 'accepted',
      initiatedBy: meta['initiated_by'] as String?,
      canSendMessage: meta['can_send'] != false,
      safetyWarning: meta['safety_warning'] == true,
      safetyWarningReason: meta['safety_warning_reason'] as String?,
    );
  }

  /// Forget every remembered thread (memory and disk).
  static void clear() {
    for (final s in _stores.values) {
      s.dispose(); // see _storeFor: these are per-peer registrations
    }
    _stores.clear();
  }

  /// [P2PMessageModel.toJson] plus the one display flag it omits.
  static Map<String, dynamic> encodeMessage(P2PMessageEntity m) => {
        ...P2PMessageModel(
          id: m.id,
          conversationId: m.conversationId,
          senderId: m.senderId,
          messageType: m.messageType,
          content: m.content,
          mediaUrl: m.mediaUrl,
          mediaType: m.mediaType,
          transferRef: m.transferRef,
          transferAmount: m.transferAmount,
          transferCurrency: m.transferCurrency,
          transferStatus: m.transferStatus,
          deliveryStatus: m.deliveryStatus,
          clientMessageId: m.clientMessageId,
          createdAt: m.createdAt,
          replyToMessageId: m.replyToMessageId,
          replyToContent: m.replyToContent,
          replyToSenderId: m.replyToSenderId,
          editedAt: m.editedAt,
          reactions: m.reactions,
        ).toJson(),
        'forwarded': m.forwarded,
      };

  static P2PMessageEntity decodeMessage(Map<String, dynamic> j) =>
      P2PMessageModel.fromJson(j);
}
