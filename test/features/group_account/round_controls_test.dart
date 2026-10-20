import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/contribution_round_state.dart';

/// THE TWO STANDING CREATOR ACTIONS MUST BE REACHABLE, EVERY ROUND.
///
/// "Run it longer" and "close it" are what a creator does with a circle, and
/// neither was on the contribution page: extend lived in the three-dot menu,
/// end appeared only in one narrow state, and the whole banner rendered
/// nothing at all while a round was still running — which is most of a
/// circle's life. A creator looking at an overdue circle saw no action.
///
/// Ending is also the one action that makes a debt PERMANENT: it closes the
/// circle, so a member who paid in and never received their turn has nothing
/// left to collect against. So it is shown always and ENABLED only when the
/// server will accept it.
void main() {
  group('ending mirrors the server allow-list', () {
    test('only the states the server accepts allow ending', () {
      expect(ContributionRoundCode.ready.allowsEnding, isTrue);
      expect(ContributionRoundCode.noActiveMembers.allowsEnding, isTrue,
          reason: 'a circle everyone has left is precisely one worth closing');
      expect(ContributionRoundCode.noAgreedCycles.allowsEnding, isTrue,
          reason: 'an indefinite circle has no round to finish, so ending it '
              'is the only way to close it');
    });

    test('a state that still owes money refuses', () {
      // Each of these would bury something: an unpaid turn, money in the pot,
      // or a payout mid-flight.
      for (final c in [
        ContributionRoundCode.turnOutstanding,
        ContributionRoundCode.potNotEmpty,
        ContributionRoundCode.payoutInFlight,
      ]) {
        expect(c.allowsEnding, isFalse, reason: '$c must not close the circle');
      }
    });

    test('a running round cannot be closed', () {
      expect(ContributionRoundCode.stillRunning.allowsEnding, isFalse);
    });

    test('an unrecognised code refuses, same as the server', () {
      // The cost of this direction is a creator who cannot close until the app
      // learns a new state. The cost of the other direction is a member's
      // money.
      expect(ContributionRoundCode.unknown.allowsEnding, isFalse);
      expect(ContributionRoundCode.fromWire('round_some_future_state')
          .allowsEnding, isFalse);
    });
  });

  group('the banner surfaces the controls', () {
    String banner() => File(
          'lib/src/features/group_account/presentation/widgets/'
          'contribution_round_banner.dart',
        ).readAsStringSync();

    test('a running round still shows the creator controls', () {
      final src = banner();
      expect(
        src.contains('return isCreator ? _runningControls()'),
        isTrue,
        reason: 'the banner renders nothing mid-round again, so neither '
            'extend nor end is reachable for most of a circle\'s life',
      );
    });

    test('end is rendered but gated on allowsEnding, not hidden', () {
      final src = banner();
      // Hidden leaves creators unable to find it; unconditional hands them a
      // guaranteed refusal. Disabled-with-a-reason is the honest middle.
      expect(src.contains('!state.code.allowsEnding'), isTrue);
      expect(src.contains('_endBlockedNote()'), isTrue,
          reason: 'a disabled control with no reason reads as broken');
    });

    test('extend is always offered to the creator', () {
      final src = banner();
      final offers = RegExp(r"label: 'Extend cycles'").allMatches(src).length;
      expect(offers, greaterThanOrEqualTo(2),
          reason: 'extend should be offered both mid-round and once a round '
              'completes');
    });
  });
}
