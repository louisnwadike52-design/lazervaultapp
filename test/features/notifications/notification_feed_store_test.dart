// Page one of the notifications feed is painted from memory/disk and refreshed
// behind it. The contract: a row survives the disk round trip intact (read
// flag, timestamp, deep-link data), a refresh that marks a row read replaces
// it in place, and the store is per user.
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/notifications/data/notifications_remote_datasource.dart';
import 'package:lazervault/src/features/presentation/views/notification_feed_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
  });

  SessionPageStore<AppNotification> freshStore() =>
      SessionPageStore<AppNotification>(
        'notifications_page1',
        toJson: notificationToJson,
        fromJson: AppNotification.fromJson,
      );

  AppNotification row({required bool read}) => AppNotification(
        id: 'n1',
        type: 'transfer',
        title: 'Money in',
        body: 'You received NGN 5,000',
        read: read,
        createdAt: DateTime.utc(2026, 10, 27, 9, 30),
        data: const {'transfer_id': 't-1'},
        referenceId: 'ref-1',
      );

  test('a row round-trips through the wire codec', () {
    final back = AppNotification.fromJson(notificationToJson(row(read: true)));
    expect(back.id, 'n1');
    expect(back.type, 'transfer');
    expect(back.title, 'Money in');
    expect(back.read, isTrue);
    expect(back.createdAt.toUtc(), DateTime.utc(2026, 10, 27, 9, 30));
    expect(back.data['transfer_id'], 't-1');
    // fromJson folds reference_id into data so the resolver has one place to
    // look — the codec must feed it the same way the API does.
    expect(back.data['reference_id'], 'ref-1');
  });

  test('page one survives a cold start for the same user', () async {
    freshStore().put([row(read: false)], userId: 'u1');
    await Future<void>.delayed(Duration.zero);

    final again = freshStore();
    expect(again.peek(userId: 'u1'), isNull);
    final hydrated = await again.hydrate(userId: 'u1');
    expect(hydrated, isNotNull);
    expect(hydrated!.single.id, 'n1');
    expect(hydrated.single.read, isFalse);
  });

  test('a refresh that marks a row read replaces it in place', () {
    final store = freshStore();
    store.put([row(read: false)], userId: 'u1');
    store.put([row(read: true)], userId: 'u1');
    final shown = store.peek(userId: 'u1')!;
    expect(shown, hasLength(1));
    expect(shown.single.read, isTrue);
  });

  test('an empty feed is remembered and never leaks to another user', () {
    final store = freshStore();
    store.put(const [], userId: 'u1');
    expect(store.peek(userId: 'u1'), isEmpty);
    expect(store.peek(userId: 'u2'), isNull);
  });
}
