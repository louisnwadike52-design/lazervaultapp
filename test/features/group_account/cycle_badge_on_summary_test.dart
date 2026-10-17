import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A rotating circle's headline numbers are all PER CYCLE — raised,
/// contributors, progress, the pot bar — so without the round number the
/// summary card is ambiguous the moment cycle 2 starts and every figure
/// resets to zero. The Cycles tab carries it, but only if you go looking.
///
/// The data needed no backend work: group-accounts already puts total_cycles
/// and current_cycle on the Contribution proto (gah_proto.go) and the app
/// already maps both (group_account_grpc_data_source.dart). The admin console
/// already renders "Cycle N of M" too. This was a rendering gap only.
void main() {
  late String src;

  setUpAll(() {
    src = File(
      'lib/src/features/group_account/presentation/views/'
      'contribution_details_screen.dart',
    ).readAsStringSync();
  });

  test('the summary card shows which cycle the circle is on', () {
    expect(src, contains('cycleBadgeLabel'));
    expect(src, contains("'Cycle \$currentCycle of \$totalCycles'"),
        reason: 'the badge must name the round AND the agreed total');
  });

  test('a missing total does not invent a denominator', () {
    // total_cycles is nullable: a contribution created but not yet OPENED has
    // no roster to size the rotation against (open() sets it from the member
    // count). "Cycle 1 of 0" would be worse than no total at all.
    expect(src, contains("'Cycle \$currentCycle'"),
        reason: 'with no total, show the round alone');
    expect(src, contains('contribution.totalCycles ?? 0'));
  });

  test('one-time collections get no cycle badge', () {
    // A one-time contribution has no cycles; "Cycle 1 of 1" on it is noise.
    expect(src, contains('contribution.isRotatingSavings && currentCycle > 0'),
        reason: 'the badge must be gated on the rotation, not shown always');
  });

  test('the badge renders even before anyone has paid', () {
    // The pill row it lives in used to appear only when there were partial or
    // fully-paid counts. A brand-new cycle has neither, and that is exactly
    // when "which cycle am I on" matters most.
    expect(
        src,
        contains(
            'if (showCycleBadge || partialCount > 0 || fullyPaidCount > 0)'),
        reason: 'gating the row on payments alone hides the badge on a fresh '
            'cycle, when it is most needed');
  });
}
