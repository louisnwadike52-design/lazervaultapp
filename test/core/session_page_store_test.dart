// SessionPageStore is what lets a list screen paint instantly on re-open. The
// contract that matters: it never hands one user's rows to another, it comes
// back from disk after a cold start, and clearAll empties every registered
// store on a user switch.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Row {
  const _Row(this.id, this.name);
  final String id;
  final String name;
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
  static _Row fromJson(Map<String, dynamic> j) =>
      _Row(j['id'] as String, j['name'] as String);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
  });

  test('put then peek for the same user and scope', () {
    final s = SessionPageStore<_Row>('t1');
    s.put([const _Row('a', 'A')], userId: 'u1', scope: 'acct-1');
    expect(s.peek(userId: 'u1', scope: 'acct-1')!.single.name, 'A');
    expect(s.isStale(userId: 'u1', scope: 'acct-1'), isFalse);
  });

  test('never serves another user or another scope', () {
    final s = SessionPageStore<_Row>('t2');
    s.put([const _Row('a', 'A')], userId: 'u1');
    expect(s.peek(userId: 'u2'), isNull);
    expect(s.peek(userId: 'u1', scope: 'other'), isNull);
  });

  test('an empty page is a real answer and is remembered', () {
    final s = SessionPageStore<_Row>('t3');
    s.put(const [], userId: 'u1');
    expect(s.peek(userId: 'u1'), isEmpty);
  });

  test('an empty user id is ignored', () {
    final s = SessionPageStore<_Row>('t4');
    s.put([const _Row('a', 'A')], userId: '');
    expect(s.peek(userId: ''), isNull);
  });

  test('revision bumps on put and clear so listeners can repaint', () {
    final s = SessionPageStore<_Row>('t5');
    final seen = <int>[];
    s.revision.addListener(() => seen.add(s.revision.value));
    s.put([const _Row('a', 'A')], userId: 'u1');
    s.clear();
    expect(seen, [1, 2]);
    expect(s.peek(userId: 'u1'), isNull);
  });

  test('hydrates from disk for the same user, not for another', () async {
    final writer = SessionPageStore<_Row>('t6',
        toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
    writer.put([const _Row('a', 'A'), const _Row('b', 'B')], userId: 'u1');
    // Let the fire-and-forget persist land.
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final reader = SessionPageStore<_Row>('t6',
        toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
    expect(await reader.hydrate(userId: 'u2'), isNull);
    final rows = await reader.hydrate(userId: 'u1');
    expect(rows!.map((r) => r.id), ['a', 'b']);
    // And it is now in memory.
    expect(reader.peek(userId: 'u1'), isNotNull);
  });

  test('too old on disk is discarded', () async {
    SharedPreferences.setMockInitialValues({
      'session_page_store.t7': '{"userId":"u1","scope":"","storedAt":"'
          '${DateTime.now().subtract(const Duration(days: 2)).toIso8601String()}'
          '","items":[{"id":"a","name":"A"}]}',
    });
    final s = SessionPageStore<_Row>('t7',
        toJson: (r) => r.toJson(),
        fromJson: _Row.fromJson,
        maxAge: const Duration(hours: 12));
    expect(await s.hydrate(userId: 'u1'), isNull);
  });

  test('a corrupt disk mirror reads as nothing, not a crash', () async {
    SharedPreferences.setMockInitialValues({'session_page_store.t8': '{oops'});
    final s = SessionPageStore<_Row>('t8',
        toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
    expect(await s.hydrate(userId: 'u1'), isNull);
  });

  test('a memory-only store never touches disk', () async {
    final s = SessionPageStore<_Row>('t9');
    s.put([const _Row('a', 'A')], userId: 'u1');
    await Future<void>.delayed(const Duration(milliseconds: 20));
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('session_page_store.t9'), isNull);
  });

  test('clearAll empties every registered store', () {
    final a = SessionPageStore<_Row>('t10a')
      ..put([const _Row('a', 'A')], userId: 'u1');
    final b = SessionPageStore<_Row>('t10b')
      ..put([const _Row('b', 'B')], userId: 'u1');
    SessionPageStore.clearAll();
    expect(a.peek(userId: 'u1'), isNull);
    expect(b.peek(userId: 'u1'), isNull);
  });

  test('nothing remembered reads as STALE, so a caller still refreshes', () {
    // The bills hub gates its app-resume refresh on isStale (a flapping
    // foreground would otherwise fetch the catalogue once per flap). That is
    // only safe because "no page at all" is stale: a cold hub must still ask.
    final s = SessionPageStore<_Row>('t12');
    expect(s.isStale(userId: 'u1'), isTrue);
    expect(s.isStale(userId: ''), isTrue);
    s.put([const _Row('a', 'A')], userId: 'u1');
    expect(s.isStale(userId: 'u1'), isFalse);
    // Another user's page is not THIS user's page, so still "go and refresh".
    expect(s.isStale(userId: 'u2'), isTrue);
  });

  test('dispose unregisters, so clearAll stops walking a dead store', () {
    // Stores created PER KEY (one per chat peer) are evicted by their owner.
    // clear() alone leaves the static registration behind for every key ever
    // used, and clearAll then walks — and issues a disk delete for — each one.
    final kept = SessionPageStore<_Row>('t13-kept');
    final evicted = SessionPageStore<_Row>('t13-evicted');
    expect(SessionPageStore.registeredCountForTest, 2);

    evicted.put([const _Row('a', 'A')], userId: 'u1');
    evicted.dispose();
    expect(evicted.peek(userId: 'u1'), isNull);
    expect(SessionPageStore.registeredCountForTest, 1);

    // The surviving store is untouched and still cleared by clearAll.
    kept.put([const _Row('b', 'B')], userId: 'u1');
    SessionPageStore.clearAll();
    expect(kept.peek(userId: 'u1'), isNull);
  });

  group('clear is the last word on disk', () {
    // These two ran as separate getInstance().then(...) chains and raced: a
    // put immediately followed by a clear left the FILE behind. On a user
    // switch that is the difference between the previous person's rows being
    // DELETED from the device — the purge's whole contract — and their being
    // kept, merely never painted because the stamp refuses them.
    Future<String?> diskOf(String name) async =>
        (await SharedPreferences.getInstance())
            .getString('session_page_store.$name');

    test('a put immediately followed by a clear leaves nothing', () async {
      final s = SessionPageStore<_Row>('t14',
          toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
      s.put([const _Row('a', 'A')], userId: 'u1');
      s.clear(); // same microtask turn as the put
      await s.diskSettled();
      expect(await diskOf('t14'), isNull);
    });

    test('a settled put, then a clear, also leaves nothing', () async {
      final s = SessionPageStore<_Row>('t15',
          toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
      s.put([const _Row('a', 'A')], userId: 'u1');
      await s.diskSettled();
      expect(await diskOf('t15'), isNotNull);
      s.clear();
      await s.diskSettled();
      expect(await diskOf('t15'), isNull);
    });

    test('clearAll leaves nothing for any store, however recent the put',
        () async {
      final a = SessionPageStore<_Row>('t16a',
          toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
      final b = SessionPageStore<_Row>('t16b',
          toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
      a.put([const _Row('a', 'A')], userId: 'u1');
      await a.diskSettled();
      b.put([const _Row('b', 'B')], userId: 'u1'); // still in flight
      SessionPageStore.clearAll();
      await a.diskSettled();
      await b.diskSettled();
      expect(await diskOf('t16a'), isNull);
      expect(await diskOf('t16b'), isNull);
    });

    test('a put AFTER a clear is a new page and is kept', () async {
      // The generation guard must drop only writes the clear superseded — a
      // genuinely later page is this user's current one.
      final s = SessionPageStore<_Row>('t17',
          toJson: (r) => r.toJson(), fromJson: _Row.fromJson);
      s.put([const _Row('a', 'A')], userId: 'u1');
      s.clear();
      s.put([const _Row('b', 'B')], userId: 'u1');
      await s.diskSettled();
      expect(await diskOf('t17'), contains('"id":"b"'));
    });
  });

  test('isStale flips after staleAfter', () async {
    final s = SessionPageStore<_Row>('t11',
        staleAfter: const Duration(milliseconds: 10));
    s.put([const _Row('a', 'A')], userId: 'u1');
    expect(s.isStale(userId: 'u1'), isFalse);
    await Future<void>.delayed(const Duration(milliseconds: 25));
    expect(s.isStale(userId: 'u1'), isTrue);
    // Stale data is still SHOWN; only the flag changes.
    expect(s.peek(userId: 'u1'), isNotNull);
  });
}
