import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE ACCOUNT CARDS MUST NOT DEPEND ON WINNING A RACE.
///
/// `_fetchData()` returns early when the AuthenticationCubit is not yet
/// `AuthenticationSuccess`. It was called ONCE, from initState, and restoring
/// a session is asynchronous — so on a device where auth landed after this
/// widget mounted, that early return was final. The card area kept its spinner
/// for ever while the rest of the dashboard rendered normally, because nothing
/// else on that screen reads auth state.
///
/// The giveaway in production was that the SERVER was never asked:
/// GetUserAccounts was called 320 times that day by other users and zero times
/// by the affected one, while his stored-token calls kept working.
///
/// A source guard rather than a widget test: reproducing it needs the real
/// async auth-restore ordering, which a pumped widget cannot express honestly.
/// These pin the two properties that actually prevent the dead end.
void main() {
  final view = File(
    'lib/src/features/account_cards_summary/presentation/view/dashboard_card_summary.dart',
  );

  late String src;

  setUpAll(() {
    expect(view.existsSync(), isTrue,
        reason: 'the dashboard card view moved — this guard needs updating');
    src = view.readAsStringSync();
  });

  test('a late AuthenticationSuccess still triggers the fetch', () {
    expect(
      src,
      contains('BlocListener<AuthenticationCubit, AuthenticationState>'),
      reason: 'without a listener, auth arriving AFTER initState leaves the '
          'card area spinning with no retry and no error — the server is '
          'never even asked for the accounts',
    );
  });

  test('the listener fires on the transition INTO success, not on every state',
      () {
    expect(
      src,
      contains('curr is AuthenticationSuccess && prev is! AuthenticationSuccess'),
      reason: 'firing on every auth state would refetch the accounts on '
          'unrelated transitions; the race is only closed by the transition '
          'into success',
    );
  });

  test('it does not refetch when the cards are already populated', () {
    expect(
      src,
      contains('hasDataForUser'),
      reason: 'initState usually wins the race. Without this guard the '
          'listener would put a second GetUserAccounts behind every login',
    );
  });

  test('_fetchData is still reachable from more than initState alone', () {
    // If this drops back to a single call site, the dead end has returned.
    final calls = RegExp(r'_fetchData\(\)').allMatches(src).length;
    expect(calls, greaterThan(2),
        reason: 'found $calls call sites; the listener, initState and the '
            'account-created paths should all be able to drive it');
  });
}
