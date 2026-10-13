import 'package:flutter_test/flutter_test.dart';

/// A member cannot pay more than their allocated share into one esusu cycle.
///
/// A rotation allocates a FIXED share per member per cycle — that is what
/// makes the pot (share x members) and the rotation fair. Paying twice would
/// inflate the pot one member funded and distort every later cycle.
///
/// The server already enforced it (payments.go: an amount must EQUAL
/// regular_amount, or fall within the remaining headroom when partials are
/// allowed, and it refuses outright once the cycle is settled). The CLIENT
/// did not: the Contribute button was offered regardless, and the amount
/// validator only engaged while `remaining > 0`, so a member who had already
/// paid had no guard at all — every amount passed, the whole pay flow ran,
/// and the refusal arrived from the server at the end.
///
/// This pins the decision both sides implement. A ONE-TIME goal is
/// deliberately excluded: it has no per-member cycle share and people may top
/// it up as often as they like.
void main() {
  /// Mirrors _myCycleShareIsSettled + the pay screen's validator.
  bool settled({
    required bool isRotating,
    required bool hasPaidCurrentCycle,
    required bool allowsPartial,
    required double share,
    required double cyclePaid,
  }) {
    if (!isRotating) return false; // one-time: never capped this way
    if (hasPaidCurrentCycle) return true;
    if (!allowsPartial) return false;
    if (share <= 0) return false;
    return cyclePaid >= share;
  }

  group('rotating savings', () {
    test('a settled cycle blocks further payment', () {
      expect(
        settled(
            isRotating: true,
            hasPaidCurrentCycle: true,
            allowsPartial: false,
            share: 500,
            cyclePaid: 500),
        isTrue,
      );
    });

    test('partials: reaching the share settles the cycle', () {
      expect(
        settled(
            isRotating: true,
            hasPaidCurrentCycle: false,
            allowsPartial: true,
            share: 500,
            cyclePaid: 500),
        isTrue,
      );
    });

    test('partials: part-paid still owes, so Contribute stays available', () {
      expect(
        settled(
            isRotating: true,
            hasPaidCurrentCycle: false,
            allowsPartial: true,
            share: 500,
            cyclePaid: 200),
        isFalse,
      );
    });

    test('an unknown share does NOT hide the button', () {
      // The server is the authority. Guessing "settled" from missing data
      // would strand somebody who genuinely owes.
      expect(
        settled(
            isRotating: true,
            hasPaidCurrentCycle: false,
            allowsPartial: true,
            share: 0,
            cyclePaid: 0),
        isFalse,
      );
    });
  });

  test('a one-time goal is never capped by a cycle share', () {
    expect(
      settled(
          isRotating: false,
          hasPaidCurrentCycle: true,
          allowsPartial: true,
          share: 500,
          cyclePaid: 9999),
      isFalse,
      reason: 'one-time goals have no per-member cycle share — topping up '
          'more than once is the point of the type',
    );
  });
}
