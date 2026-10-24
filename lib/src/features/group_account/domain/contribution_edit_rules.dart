// The entity files are `part of` this library, so the library is the
// importable unit.
import 'entities/group_entities.dart';

/// WHAT AN ESUSU'S CREATOR MAY ACTUALLY CHANGE, AND WHY.
///
/// A rotating circle's numbers are not independent of one another. The pot
/// each cycle pays out is `regular amount x active members`, and the whole
/// circle moves `pot x cycles`. Let a creator type a target that contradicts
/// that and the figure on the screen stops describing the money.
///
/// So for a rotation the target is DERIVED and shown read-only, and the thing
/// a creator actually decides — how many cycles the circle runs — is edited
/// directly, with the one rule that keeps turns fair.
class ContributionEditRules {
  const ContributionEditRules._();

  /// Whether the target is computed from the rotation rather than typed.
  ///
  /// True only for a rotating circle. A one-time or target-savings pot has a
  /// goal the creator genuinely chooses, so there the field is a real input.
  static bool targetIsDerived(ContributionType type) =>
      type == ContributionType.rotatingSavings;

  /// The total a rotation will move: one pot per cycle.
  ///
  /// Returns null when any input is missing, so the caller shows the stored
  /// value rather than a confident zero.
  static int? derivedTargetMinor({
    required int? regularAmountMinor,
    required int activeMembers,
    required int? cycles,
  }) {
    if (regularAmountMinor == null || regularAmountMinor <= 0) return null;
    if (activeMembers <= 0) return null;
    if (cycles == null || cycles <= 0) return null;
    return regularAmountMinor * activeMembers * cycles;
  }

  /// EVERY MEMBER GETS THE SAME NUMBER OF TURNS, OR SOMEONE PAYS FOR A TURN
  /// THEY NEVER GET.
  ///
  /// A rotation hands the pot to one member per cycle. With 2 members and 3
  /// cycles somebody collects twice while the other collects once — and both
  /// paid in three times. That is not a rounding problem, it is one member
  /// funding another, and it is exactly the shape of the fanthom incident
  /// where one member took both turns of a two-cycle circle.
  ///
  /// So the count must be a whole number of full passes: 2 members means
  /// 2, 4, 6...; 3 members means 3, 6, 9...
  ///
  /// Returns null when valid, or a sentence naming the nearest allowed
  /// values — a creator told "invalid" has to guess, and the guess is the
  /// thing we already know.
  static String? validateCycles({
    required int? cycles,
    required int activeMembers,
  }) {
    if (activeMembers <= 0) {
      // Nothing to divide by. The circle has a different problem, and
      // blocking the cycle field would hide it behind the wrong message.
      return null;
    }
    if (cycles == null || cycles <= 0) {
      return 'Enter how many cycles this circle should run.';
    }
    if (cycles % activeMembers != 0) {
      final lower = (cycles ~/ activeMembers) * activeMembers;
      final upper = lower + activeMembers;
      final options = lower >= activeMembers ? '$lower or $upper' : '$upper';
      return 'With $activeMembers members, cycles must come in full rounds '
          'so everyone gets the same number of turns. Try $options.';
    }
    return null;
  }

  /// How many full passes of the rotation [cycles] represents.
  static int? roundsFor({required int? cycles, required int activeMembers}) {
    if (cycles == null || activeMembers <= 0) return null;
    if (cycles % activeMembers != 0) return null;
    return cycles ~/ activeMembers;
  }

  /// Members who actually hold a turn.
  ///
  /// Shadow rows — an invitee who has not accepted, or who declined — are not
  /// members and must not widen the pot or the cycle count. Counting them is
  /// how a circle ends up with a slot nobody can fill.
  static int activeMemberCount(List<ContributionMember> members) => members
      .where((m) => m.membershipStatus == ContributionMembershipStatus.active)
      .length;
}
