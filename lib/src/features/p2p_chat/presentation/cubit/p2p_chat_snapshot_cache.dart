import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

/// Process-lifetime cache of the Financial-Connections saved-contacts list, so
/// re-entering the screen paints instantly instead of flashing a loader. Lives
/// here (not in the screen file) so [clearAllP2PCaches] can wipe EVERY P2P cache
/// in one place on logout — otherwise the next user would briefly see the
/// previous user's saved contacts.
List<RecipientModel> p2pSavedContactsCache = [];
bool p2pSavedContactsCacheLoaded = false;

/// Wipe all in-memory P2P caches. MUST be called on logout / session clear so no
/// P2P data (conversation snapshots, saved contacts) leaks across users.
void clearAllP2PCaches() {
  P2PChatSnapshotCache.instance.clear();
  p2pSavedContactsCache = [];
  p2pSavedContactsCacheLoaded = false;
}

/// In-memory cache of the last loaded conversation state, keyed by the peer's
/// user id. Lets a re-opened P2P chat paint INSTANTLY from the last snapshot
/// (no full-screen spinner / blank while the network re-init runs in the
/// background) — killing the "entire reload on every back/forth" behaviour.
///
/// The [P2PChatCubit] itself is still constructed per navigation (its live
/// WebSocket subscriptions have their own lifecycle); this cache only holds the
/// last rendered [P2PChatLoaded] snapshot + its timestamp so the new cubit can
/// hydrate immediately and then silently reconcile.
///
/// Bounded (LRU, [_maxEntries]) so it can't grow unbounded; cleared on logout.
class P2PChatSnapshotCache {
  P2PChatSnapshotCache._();
  static final P2PChatSnapshotCache instance = P2PChatSnapshotCache._();

  static const int _maxEntries = 8;

  final Map<String, _Entry> _entries = {};

  /// Return the cached loaded snapshot for [otherUserId], or null. Touches LRU.
  P2PChatLoaded? get(String otherUserId) {
    final e = _entries.remove(otherUserId);
    if (e == null) return null;
    _entries[otherUserId] = e; // re-insert → most-recently-used
    return e.state;
  }

  /// Age of the cached snapshot for [otherUserId] (null when absent). Callers
  /// use this to decide whether the heavier background refresh (e.g. the
  /// transfer-history gRPC) can be skipped for a very fresh re-open.
  Duration? ageOf(String otherUserId) {
    final e = _entries[otherUserId];
    if (e == null) return null;
    return DateTime.now().difference(e.at);
  }

  /// Store/refresh the snapshot for [otherUserId], evicting the LRU entry when
  /// over capacity.
  void put(String otherUserId, P2PChatLoaded state) {
    if (otherUserId.isEmpty) return;
    _entries.remove(otherUserId);
    _entries[otherUserId] = _Entry(state, DateTime.now());
    while (_entries.length > _maxEntries) {
      _entries.remove(_entries.keys.first); // oldest (insertion order)
    }
  }

  void clear() => _entries.clear();
}

class _Entry {
  final P2PChatLoaded state;
  final DateTime at;
  const _Entry(this.state, this.at);
}
