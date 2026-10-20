import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ONE TURN PER MEMBER PER ROUND, SHOWN BEFORE THE ROUND TRIP.
///
/// The server refuses a receiver who has already collected in the round now
/// running — that is the money rule. These guards are about the app telling
/// the creator BEFORE they pick, rather than greying a row with no
/// explanation or letting them tap and be refused.
void main() {
  String strip(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final picker = strip(File(
          'lib/src/features/group_account/presentation/widgets/select_payout_receiver_bottom_sheet.dart')
      .readAsStringSync());
  final details = strip(File(
          'lib/src/features/group_account/presentation/views/contribution_details_screen.dart')
      .readAsStringSync());

  test('the receiver picker blocks a member who already collected', () {
    expect(picker.contains('m.hasCollectedThisRound'), isTrue,
        reason: 'the picker never consults the flag');
    expect(picker.contains('blocked = behind || notJoined || alreadyCollected'),
        isTrue,
        reason: 'already-collected must join the blocked set, or the row is '
            'badged but still tappable');
  });

  test('the CURRENT receiver is not blocked by their own turn', () {
    // The turn in progress is not a second turn. Without this the creator
    // could not even re-confirm the receiver the circle is already paying.
    expect(picker.contains('!isCurrent'), isTrue,
        reason: 'the in-progress receiver was treated as already collected');
  });

  test('a blocked row explains itself', () {
    // A greyed row with no reason reads as a bug.
    expect(picker.contains('Already collected in cycle'), isTrue);
    expect(picker.contains('everyone '), isTrue,
        reason: 'the badge should say why: everyone else takes a turn first');
  });

  test('the roster badges it, ranked above cycles-behind', () {
    final collectedAt = details.indexOf('hasCollectedThisRound');
    final behindAt = details.indexOf("(member?.missedCycles ?? 0) > 0");
    expect(collectedAt, greaterThan(-1),
        reason: 'the members tab never shows who has had their turn');
    expect(behindAt, greaterThan(-1));
    expect(collectedAt, lessThan(behindAt),
        reason: 'someone who has collected is not a candidate at all, which '
            'is the more useful fact about that row than being behind');
  });

  test('it is scoped to rotating savings', () {
    // A one-time goal pays a named beneficiary who may not be contributing;
    // blocking them would stop the only payout the goal exists for.
    expect(picker.contains('widget.contribution.isRotatingSavings &&'), isTrue,
        reason: 'the block must not apply to a one-time contribution');
  });
}
