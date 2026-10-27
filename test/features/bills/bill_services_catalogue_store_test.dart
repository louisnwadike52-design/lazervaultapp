// The Bills Hub menu is painted from the remembered catalogue and refreshed
// behind it. What matters: the catalogue survives a cold start (disk mirror),
// an admin toggle lands as a changed `enabled` flag that listeners can see,
// and one user's catalogue is never painted for another.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/bills/presentation/view/bill_services_catalogue_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
  });

  SessionPageStore<BillServiceEntry> freshStore() =>
      SessionPageStore<BillServiceEntry>(
        'bill_services',
        toJson: (e) => e.toJson(),
        fromJson: BillServiceEntry.fromJson,
      );

  test('an entry round-trips through JSON with its enabled flag', () {
    const e = BillServiceEntry(
      type: 'electricity',
      enabled: false,
      label: 'Electricity',
      disabledReason: 'provider down',
    );
    final back = BillServiceEntry.fromJson(e.toJson());
    expect(back.type, 'electricity');
    expect(back.enabled, isFalse);
    expect(back.label, 'Electricity');
    expect(back.disabledReason, 'provider down');
  });

  test('enabledByType is what the hub consults', () {
    final map = billServicesEnabledByType(const [
      BillServiceEntry(type: 'airtime', enabled: true),
      BillServiceEntry(type: 'water', enabled: false),
    ]);
    expect(map, {'airtime': true, 'water': false});
  });

  test('the catalogue survives a cold start for the same user and country',
      () async {
    freshStore().put(
      const [BillServiceEntry(type: 'airtime', enabled: true)],
      userId: 'u1',
      scope: 'NG',
    );
    // Let the SharedPreferences write settle.
    await Future<void>.delayed(Duration.zero);

    // A new process: new store instance, nothing in memory.
    final again = freshStore();
    expect(again.peek(userId: 'u1', scope: 'NG'), isNull);
    final hydrated = await again.hydrate(userId: 'u1', scope: 'NG');
    expect(hydrated, isNotNull);
    expect(billServicesEnabledByType(hydrated!), {'airtime': true});
  });

  test('an admin toggle lands as a revision bump with the flag flipped',
      () async {
    final store = freshStore();
    store.put(
      const [BillServiceEntry(type: 'cable_tv', enabled: true)],
      userId: 'u1',
      scope: 'NG',
    );
    final before = store.revision.value;
    store.put(
      const [BillServiceEntry(type: 'cable_tv', enabled: false)],
      userId: 'u1',
      scope: 'NG',
    );
    expect(store.revision.value, before + 1);
    final map =
        billServicesEnabledByType(store.peek(userId: 'u1', scope: 'NG')!);
    expect(map['cable_tv'], isFalse);
  });

  test('another user or another country never sees this catalogue', () {
    final store = freshStore();
    store.put(
      const [BillServiceEntry(type: 'airtime', enabled: true)],
      userId: 'u1',
      scope: 'NG',
    );
    expect(store.peek(userId: 'u2', scope: 'NG'), isNull);
    expect(store.peek(userId: 'u1', scope: 'GH'), isNull);
  });
}
