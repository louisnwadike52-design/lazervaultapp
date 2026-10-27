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
