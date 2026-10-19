import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Step 2 of Create Split Bill, after the redesign.
///
/// The screen's one job is collecting each co-payer's share, and the input
/// was a small unlabelled box floating in a row. What a typed percentage
/// came to in money appeared only in the error banner at the bottom — "5 %"
/// up here, "Too small: Nnaemeka Ezeke (₦25.00)" down there — so the fix for
/// the error was never next to the error. The summary sat behind a 1px
/// hairline this file had already abandoned elsewhere, and its labels were
/// terse enough to mislead: "Co-payers 2" with one co-payer listed is only
/// true because it counts the organiser.
///
/// These are source-level because the defects are layout and wording: no
/// return value distinguishes a prominent field from a cramped one. They pin
/// the properties that are easy to undo by accident.

void main() {
  final root = Directory.current.path;
  final view =
      '$root/lib/src/features/split_bills/presentation/view';
  final step = File('$view/create_split_bill_screen_people_step.dart')
      .readAsStringSync();
  final screen =
      File('$view/create_split_bill_screen.dart').readAsStringSync();

  group('the share input is the job of the screen', () {
    test('it is labelled, not a bare box with a % sign', () {
      expect(step, contains('Their share of the bill'));
      expect(step, contains('What they pay'));
    });

    test('the money a percentage works out to sits beside the field', () {
      // The whole point: someone deciding whether a share clears the bank
      // floor is deciding on the amount, not the percentage.
      expect(step, contains('THE ANSWER, NEXT TO THE QUESTION'));
      expect(step, contains('belowFloor'));
      expect(step, contains('bank minimum'));
    });

    test('a share under the floor is marked on its own row', () {
      // Previously only the global banner named the person.
      expect(step, contains('Color(0xFFF59E0B)'));
    });
  });

  group('no tiny borders', () {
    test('the summary uses elevation, not a hairline', () {
      // The old card wore `border: Border.all(Color(0xFF4834D4)...)`.
      expect(step, contains('buildSplitSummaryCard'));
      expect(step, isNot(contains('border: Border.all')));
      expect(step, contains('BoxShadow'));
    });

    test('the co-payer card does too', () {
      expect(step, contains('Elevation, not a hairline'));
    });
  });

  group('the summary explains itself', () {
    test('the headcount says it includes the organiser', () {
      // "Co-payers 2" with one co-payer on screen read as an off-by-one.
      expect(screen, contains("'Split between'"));
      expect(screen, contains('and you'));
    });

    test('the organiser\'s share says it is the leftover', () {
      // Under custom and percentage it is the REMAINDER, not a choice.
      expect(screen, contains("Whatever is left after the co-payers' shares"));
    });

    test('the destination says how each share reaches it', () {
      expect(screen, contains('Money goes to'));
      expect(screen, contains('paid out to this bank account separately'));
    });
  });

  test('THE REGRESSION: the field is keyed by person AND input mode', () {
    // initialValue is applied only on an element's first build. Keyed on
    // the person alone, a typed PERCENTAGE survives a switch to Custom and
    // the box reads "5" while the model holds ₦5. Keyed on position alone
    // (the older bug), removing a co-payer leaves their figure against
    // whoever took the row.
    expect(screen, contains("ValueKey('\${participant.key}:\${input.name}')"));
  });
}
