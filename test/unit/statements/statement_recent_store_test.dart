import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/statements/data/services/statement_recent_store.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';

StatementRecentEntry entry({
  String accountId = 'acc-1',
  int startMs = 1000,
  int endMs = 2000,
  StatementFormat format = StatementFormat.pdf,
  int generatedMs = 3000,
}) {
  return StatementRecentEntry(
    accountId: accountId,
    startDate: DateTime.fromMillisecondsSinceEpoch(startMs),
    endDate: DateTime.fromMillisecondsSinceEpoch(endMs),
    format: format,
    generatedAt: DateTime.fromMillisecondsSinceEpoch(generatedMs),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('round-trips an entry', () async {
    final store = StatementRecentStore();
    await store.record(entry());
    final loaded = await store.load();
    expect(loaded, hasLength(1));
    expect(loaded.first.accountId, 'acc-1');
    expect(loaded.first.format, StatementFormat.pdf);
    expect(loaded.first.startDate.millisecondsSinceEpoch, 1000);
  });

  test('newest first, identical requests de-duplicated', () async {
    final store = StatementRecentStore();
    await store.record(entry(accountId: 'acc-1'));
    await store.record(entry(accountId: 'acc-2'));
    // Same account + window + format as the first: replaces it, does not
    // add a second row.
    await store.record(entry(accountId: 'acc-1', generatedMs: 9000));

    final loaded = await store.load();
    expect(loaded.map((e) => e.accountId), ['acc-1', 'acc-2']);
    expect(loaded.first.generatedAt.millisecondsSinceEpoch, 9000);
  });

  test('a different format is a different statement, not a duplicate',
      () async {
    final store = StatementRecentStore();
    await store.record(entry());
    await store.record(entry(format: StatementFormat.csv));
    expect(await store.load(), hasLength(2));
  });

  test('caps at 20 so the list cannot grow without bound', () async {
    final store = StatementRecentStore();
    for (var i = 0; i < 25; i++) {
      await store.record(entry(startMs: 1000 + i));
    }
    final loaded = await store.load();
    expect(loaded, hasLength(20));
    // Newest kept, oldest dropped.
    expect(loaded.first.startDate.millisecondsSinceEpoch, 1024);
  });

  test('unreadable storage yields an empty list, never a throw', () async {
    SharedPreferences.setMockInitialValues({
      'recent_statements_v1': 'not json at all',
    });
    expect(await StatementRecentStore().load(), isEmpty);
  });

  test('a malformed row drops out without taking the good ones', () async {
    SharedPreferences.setMockInitialValues({
      'recent_statements_v1':
          '[{"accountId":"acc-1","startMs":1,"endMs":2,"format":"pdf","generatedMs":3},'
          '{"accountId":"","startMs":1,"endMs":2},'
          '{"startMs":"not-an-int"},'
          '{"accountId":"acc-2","startMs":5,"endMs":6,"format":"csv","generatedMs":7}]',
    });
    final loaded = await StatementRecentStore().load();
    expect(loaded.map((e) => e.accountId), ['acc-1', 'acc-2']);
  });

  test('an entry written before generatedMs existed still loads', () async {
    SharedPreferences.setMockInitialValues({
      'recent_statements_v1':
          '[{"accountId":"acc-1","startMs":1000,"endMs":2000,"format":"pdf"}]',
    });
    final loaded = await StatementRecentStore().load();
    expect(loaded, hasLength(1));
    expect(loaded.first.generatedAt.millisecondsSinceEpoch, 1000);
  });
}
