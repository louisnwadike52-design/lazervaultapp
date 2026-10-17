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
    // Literals live in _cycleLabelFor now, which takes `c`.
    expect(src, contains("'Cycle \$current of \$total'"),
        reason: 'the badge must name the round AND the agreed total');
  });

  test('a missing total does not invent a denominator', () {
    // total_cycles is nullable: a contribution created but not yet OPENED has
    // no roster to size the rotation against (open() sets it from the member
    // count). "Cycle 1 of 0" would be worse than no total at all.
    expect(src, contains("'Cycle \$current'"),
        reason: 'with no total, show the round alone');
    expect(src, contains('c.totalCycles ?? 0'));
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

  test('one definition of the cycle label, used by every surface', () {
    // The summary card badge, the Overview "Current Cycle" stat and the
    // Cycles tab all report the round. Three places computing it separately
    // is how a screen ends up showing two different cycle numbers — the same
    // class of bug as the crypto sheet showing two rates.
    expect(src, contains('String _cycleLabelFor(Contribution c)'));
    final uses = RegExp(r'_cycleLabelFor\(').allMatches(src).length;
    expect(uses, greaterThanOrEqualTo(3),
        reason: 'definition + the summary badge + the Overview stat must all '
            'go through it');
  });

  test('the Overview statistics show the cycle too', () {
    expect(src, contains("title: 'Current Cycle'"),
        reason: 'every figure on that tab is scoped to the current cycle, so '
            'the tab is ambiguous without the round number');
    expect(src, contains('if (_showCyclesTab(contribution)) ...['),
        reason: 'the stat is rotating-savings only — a one-time collection '
            'has no cycles');
  });

  group('the cycles CTAs are gone now that Cycles is a tab', () {
    test('no "View past" status chip', () {
      expect(src, isNot(contains("value: 'View past'")),
          reason: 'the chip opened the same surface the tab shows, on the '
              'identical condition, and cost a header row');
    });

    test('no "View Cycles History" overflow entry', () {
      // Comments stripped: the removal is DOCUMENTED in a comment naming the
      // old label, and matching that would fail on the very note explaining
      // why it is gone.
      final code = src
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(code, isNot(contains('View Cycles History')),
          reason: 'it was UNGATED, so it also offered a cycles list for '
              'one-time contributions, which have none');
    });

    test('and nothing is left calling the removed route', () {
      // A dead handler is worse than a visible one: the menu value would
      // silently do nothing.
      expect(src, isNot(contains("case 'history':")));
      expect(src, isNot(contains('void _openCyclesHistory')));
    });
  });

  group('cycles tab badges', () {
    late String cycles;
    setUpAll(() {
      cycles = File(
        'lib/src/features/group_account/presentation/views/'
        'contribution_cycles_history_screen.dart',
      ).readAsStringSync();
    });

    test('the current round is marked, not just "Live"', () {
      // "Live" is a STATUS; "Current" says this is the round the contribution
      // itself points at. Both can be true, and they are different facts.
      expect(cycles, contains("_buildBadge('Current'"));
      expect(
          cycles, contains('widget.contribution.currentCycle == c.cycleIndex'),
          reason: 'it must read the SAME currentCycle the summary card and '
              'the Overview stat use, or the surfaces disagree');
    });

    test('identity badges are a constant light purple, not status-tinted', () {
      // Tinting the NUMBER by status turned "Cycle 3" red on a failed round,
      // which reads as though the number were the problem.
      expect(cycles, contains('const Color _kCycleBadgePurple'));
      expect(
          cycles,
          contains(
              "_buildBadge('Cycle \${c.cycleIndex}', _kCycleBadgePurple)"));
    });

    test('settled/failed/cancelled keep their semantic colours', () {
      // "Make the badges purple" applies to the identity badges and the live
      // accent. Turning a FAILED pill purple would destroy the only signal
      // separating a paid-out round from a failed one.
      expect(cycles, contains('return const Color(0xFF10B981);'),
          reason: 'settled stays green');
      expect(cycles, contains('return const Color(0xFFEF4444);'),
          reason: 'failed stays red');
    });
  });
}
