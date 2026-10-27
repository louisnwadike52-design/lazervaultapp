import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE FIRST PAGE OF A LIST, REMEMBERED ACROSS SCREEN OPENS.
///
/// # The problem this solves
///
/// Most list screens in this app are backed by a FACTORY cubit: a fresh cubit,
/// in its `Initial` state, on every open. The screen sees `Initial`, emits
/// `Loading`, and paints a spinner or skeleton over data the user looked at
/// thirty seconds ago — then asks the network for exactly the same rows. On
/// the uplink this backend sits behind, that is three seconds of nothing, on
/// every tab, every time.
///
/// A screen that has shown a list once should show it again INSTANTLY and
/// refresh behind it. The cubit cannot remember (it is gone); something that
/// outlives the cubit has to. `AccountSummariesStore` is that thing for the
/// dashboard balances and it is why the dashboard does not blink. This is the
/// same shape, generic, so every list screen can have one without writing
/// another ad-hoc static.
///
/// # What it is
///
/// A named, user-stamped, in-memory copy of page one, with an optional disk
/// mirror (SharedPreferences JSON) so a cold start can paint too. It is NOT a
/// cache in the HTTP sense — there is no TTL that refuses data. Stale data is
/// still shown; `isStale` only tells the caller to go and refresh. The one
/// thing that refuses is a USER MISMATCH: data put by one user is never
/// returned for another, whatever the registry did.
///
/// # How a cubit uses it
///
/// ```dart
/// static final _page = SessionPageStore<Thing>('things', toJson: ..., fromJson: ...);
///
/// Future<void> load({bool silent = false}) async {
///   final cached = _page.peek(userId: uid) ?? await _page.hydrate(userId: uid);
///   if (cached != null) {
///     emit(ThingsLoaded(cached, isRefreshing: true));   // paint NOW
///   } else if (!silent) {
///     emit(ThingsLoading());                            // genuinely first time
///   }
///   final fresh = await repo.fetch(page: 1);
///   _page.put(fresh, userId: uid);
///   emit(ThingsLoaded(fresh));
/// }
/// ```
///
/// Every instance registers itself so [clearAll] can run on a user switch —
/// belt and braces on top of the user stamp.
class SessionPageStore<T> {
  SessionPageStore(
    this.name, {
    this.toJson,
    this.fromJson,
    this.staleAfter = const Duration(minutes: 2),
    this.maxAge = const Duration(hours: 12),
  }) {
    _registry.add(this);
  }

  /// Unique per list. Also the disk key suffix.
  final String name;

  /// Codecs for the disk mirror. Omit both to keep the store in memory only.
  final Map<String, dynamic> Function(T item)? toJson;
  final T Function(Map<String, dynamic> json)? fromJson;

  /// After this the data is still shown but [isStale] is true.
  final Duration staleAfter;

  /// Older than this on disk is discarded on hydrate rather than shown.
  final Duration maxAge;

  static final List<SessionPageStore<dynamic>> _registry = [];

  /// Bumped on every [put] and [clear], so a widget that wants to repaint when
  /// another screen refreshed the same list can listen.
  final ValueNotifier<int> revision = ValueNotifier<int>(0);

  String? _userId;
  String _scope = '';
  List<T>? _items;
  DateTime? _storedAt;

  bool _matches(String userId, String scope) =>
      _items != null && _userId == userId && _scope == scope;

  /// Synchronous read. Null when there is nothing for THIS user and scope.
  List<T>? peek({required String userId, String scope = ''}) =>
      _matches(userId, scope) ? List<T>.unmodifiable(_items!) : null;

  /// True when the held page is older than [staleAfter] — show it, but refresh.
  bool isStale({required String userId, String scope = ''}) {
    if (!_matches(userId, scope) || _storedAt == null) return true;
    return DateTime.now().difference(_storedAt!) > staleAfter;
  }

  /// When the held page was stored, or null.
  DateTime? storedAt({required String userId, String scope = ''}) =>
      _matches(userId, scope) ? _storedAt : null;

  /// Remember page one for this user. An EMPTY list is remembered too — "you
  /// have no rules yet" is a real answer and painting it instantly is right.
  void put(List<T> items, {required String userId, String scope = ''}) {
    if (userId.isEmpty) return;
    _userId = userId;
    _scope = scope;
    _items = List<T>.from(items);
    _storedAt = DateTime.now();
    revision.value++;
    _persist();
  }

  /// Load from disk into memory when memory is empty. Returns the page, or
  /// null when there is none for this user and scope (or it is too old).
  Future<List<T>?> hydrate({required String userId, String scope = ''}) async {
    final inMemory = peek(userId: userId, scope: scope);
    if (inMemory != null) return inMemory;
    if (fromJson == null) return null;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_diskKey);
      if (raw == null) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      if (decoded['userId'] != userId || (decoded['scope'] ?? '') != scope) {
        return null;
      }
      final storedAt = DateTime.tryParse(decoded['storedAt']?.toString() ?? '');
      if (storedAt == null || DateTime.now().difference(storedAt) > maxAge) {
        return null;
      }
      final rows = decoded['items'];
      if (rows is! List) return null;
      final items = <T>[];
      for (final r in rows) {
        if (r is Map) items.add(fromJson!(Map<String, dynamic>.from(r)));
      }
      _userId = userId;
      _scope = scope;
      _items = items;
      _storedAt = storedAt;
      revision.value++;
      return List<T>.unmodifiable(items);
    } catch (_) {
      // A corrupt mirror costs one spinner, never a crash.
      return null;
    }
  }

  /// Forget everything, memory and disk.
  void clear() {
    _userId = null;
    _scope = '';
    _items = null;
    _storedAt = null;
    revision.value++;
    if (toJson != null) {
      // A write this clear supersedes must not land after it — see [_onDisk].
      _diskGeneration++;
      _onDisk((p) => p.remove(_diskKey));
    }
  }

  /// [clear], plus unregister, for a store created PER KEY that is being
  /// dropped for good.
  ///
  /// Most stores are `static final` — one per list, for the life of the
  /// process — and must never unregister. But a few are created per key (one
  /// per chat peer, say) and evicted by their owner when a cap is reached;
  /// dropping such a store from its owner's map alone leaves a dead entry in
  /// the static registry for every key ever used, which [clearAll] then walks
  /// (and issues a disk delete for) on every user switch.
  void dispose() {
    clear();
    _registry.remove(this);
  }

  /// Forget every store. Called on a user switch so the next person's first
  /// paint can never be the previous person's list, even for a store that
  /// forgot to stamp.
  static void clearAll() {
    for (final s in List<SessionPageStore<dynamic>>.from(_registry)) {
      s.clear();
    }
  }

  String get _diskKey => 'session_page_store.$name';

  /// Bumped by every [clear]. A write issued before the bump is ABANDONED
  /// rather than allowed to land after the delete — see [_onDisk].
  int _diskGeneration = 0;

  /// This store's disk operations, run one at a time in the order they were
  /// issued.
  ///
  /// `put` and `clear` are both synchronous to the caller and both finish on
  /// disk later, and before this they raced: each did its own
  /// `getInstance().then(...)`, so a `put` immediately followed by a `clear`
  /// reliably left the FILE in place (measured, not theorised — the removal
  /// resolved against the cache before the write resolved against the store).
  /// For a user switch that is the difference between "the previous person's
  /// recipients and chat threads are deleted from this device" — which is the
  /// whole contract of the purge — and "they are still there, merely never
  /// painted because the row stamp refuses them".
  ///
  /// Serialising, plus the generation check, makes `clear` the last word
  /// whichever way round the two calls happen to arrive.
  Future<void> _diskQueue = Future<void>.value();

  void _onDisk(Future<void> Function(SharedPreferences prefs) op) {
    _diskQueue = _diskQueue.then((_) async {
      try {
        await op(await SharedPreferences.getInstance());
      } catch (_) {
        // A mirror that cannot be written (or deleted) costs one spinner, or
        // one stale file the user stamp already refuses. Never a crash.
      }
    });
  }

  void _persist() {
    final encode = toJson;
    if (encode == null) return;
    final payload = jsonEncode({
      'userId': _userId,
      'scope': _scope,
      'storedAt': _storedAt!.toIso8601String(),
      'items': _items!.map(encode).toList(),
    });
    final generation = _diskGeneration;
    _onDisk((p) async {
      // Cleared since this write was issued: the page it describes is gone,
      // and writing it now would resurrect the file the clear deleted.
      if (generation != _diskGeneration) return;
      await p.setString(_diskKey, payload);
    });
  }

  /// Test hook: wait for this store's pending disk work to settle.
  @visibleForTesting
  Future<void> diskSettled() => _diskQueue;

  /// Test hook: forget registrations made by earlier tests.
  @visibleForTesting
  static void resetRegistryForTest() => _registry.clear();

  /// Test hook: how many stores [clearAll] would currently walk.
  @visibleForTesting
  static int get registeredCountForTest => _registry.length;
}
