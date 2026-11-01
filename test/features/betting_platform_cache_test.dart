import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/betting/data/betting_platforms_store.dart';

/// "Clicking out and into this fund betting page leads to constant
/// reloading."
///
/// BettingCubit is a FACTORY registration, so a new one is built on every
/// entry into the funding screen, and its initState called loadPlatforms(),
/// which emitted Loading first. The screen renders a full-page spinner on
/// that state — so leaving and coming back blanked the entire form and
/// refetched over the network every single time.
///
/// The bookmaker list is near-static reference data, not the user's money. It
/// is now cached at process level (the cubit cannot hold it — it does not
/// outlive the route) and served immediately, with the network call only when
/// the copy has gone stale.
void main() {
  setUp(BettingPlatformsStore.clear);
  tearDown(BettingPlatformsStore.clear);

  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  String code(String src) => src
      .split('\n')
      .where((l) =>
          !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
      .join('\n');

  test('an empty fetch never overwrites a good list', () {
    // A transient backend blip returning nothing would otherwise empty the
    // screen AND stamp itself fresh, so nothing retried for the whole TTL.
    expect(BettingPlatformsStore.hasValue, isFalse);
    expect(BettingPlatformsStore.isStale, isTrue,
        reason: 'an empty cache must read as stale or nothing ever fetches');
    BettingPlatformsStore.save(const []);
    expect(BettingPlatformsStore.hasValue, isFalse);
    expect(BettingPlatformsStore.isStale, isTrue,
        reason: 'an empty save must not stamp the cache fresh');
  });

  test('clear resets both the list and the freshness stamp', () {
    BettingPlatformsStore.clear();
    expect(BettingPlatformsStore.platforms, isEmpty);
    expect(BettingPlatformsStore.isStale, isTrue);
  });

  test('the TTL survives normal navigation but not a whole session', () {
    // Long enough that back-and-forth never refetches; short enough that a
    // bookmaker added or disabled in the dashboard reaches handsets the same
    // session.
    expect(BettingPlatformsStore.ttl.inMinutes, greaterThanOrEqualTo(5));
    expect(BettingPlatformsStore.ttl.inMinutes, lessThanOrEqualTo(60));
  });

  test('the cubit paints the cache before deciding to fetch', () {
    final src = code(read(
        'lib/src/features/betting/presentation/cubit/betting_cubit.dart'));
    expect(src.contains('BettingPlatformsStore.platforms'), isTrue,
        reason: 'loadPlatforms no longer reads the cache, so every route '
            'entry refetches and blanks the screen again');
    expect(src.contains('if (!force && !BettingPlatformsStore.isStale) return;'),
        isTrue,
        reason: 'a fresh cache must short-circuit the network call');
    // Loading is only honest when there is nothing to show.
    expect(src.contains('} else {\n      emit(const BettingPlatformsLoading());'),
        isTrue,
        reason: 'Loading is emitted unconditionally again, which is what '
            'blanked the form on re-entry');
    expect(src.contains('if (cached.isNotEmpty) return;'), isTrue,
        reason: 'a failed background refresh must not replace a list the '
            'user is already filling a form against');
  });

  test('the catalogue is dropped at sign-out', () {
    final src = code(read(
        'lib/src/features/authentication/cubit/authentication_cubit.dart'));
    expect(src.contains('BettingPlatformsStore.clear()'), isTrue,
        reason: 'one account\'s view of what is on sale would persist into '
            'another session on a shared handset');
  });

  test('the platform picker is a sheet, not a wall of chips', () {
    final src = code(read(
        'lib/src/features/betting/presentation/widgets/betting_quick_buy.dart'));
    expect(src.contains('showBettingPlatformSheet'), isTrue,
        reason: 'the picker is back to an inline grid, which pushes the '
            'fields that take input off the first screen');
    expect(src.contains('_platformSelector()'), isTrue);
  });
}
