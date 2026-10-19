import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';
import 'package:lazervault/src/features/group_account/domain/rotation_extension.dart';

/// EIGHT OF NINE LIVE CIRCLES HAD ALREADY EXPIRED.
///
/// Measured on prod 2026-10-19. Every one was daily with a handful of agreed
/// cycles and a deadline set around the FIRST cycle's date, so the circle
/// expired before the rotation it promised could run — and a cycle that opens
/// past its due date marks every member as in arrears the same instant, which
/// makes the pot unpayable.
///
/// The server refuses to start such a cycle. This is the app half: work out
/// the date that WOULD accommodate the remaining turns, so the creator is
/// offered one instead of guessing.

Contribution circle({
  required ContributionFrequency freq,
  int? total,
  int? current,
}) =>
    Contribution(
      id: 'c1',
      groupId: 'g1',
      title: 'Ikeja circle',
      description: '',
      targetAmount: 400,
      currentAmount: 0,
      currency: 'NGN',
      deadline: DateTime(2026, 10, 17),
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 19),
      status: ContributionStatus.active,
      createdBy: 'u1',
      payments: const [],
      type: ContributionType.rotatingSavings,
      frequency: freq,
      totalCycles: total,
      currentCycle: current,
    );

void main() {
  final now = DateTime(2026, 10, 20, 12);

  group('how much more time the circle needs', () {
    test('a daily circle needs a day per remaining turn', () {
      // 3 agreed, on cycle 2 → 2 turns still to run → 2 days.
      final c = circle(freq: ContributionFrequency.daily, total: 3, current: 2);
      expect(rotationCyclesRemaining(c), 2);
      expect(suggestedRotationDeadline(c, now), DateTime(2026, 10, 22, 12));
    });

    test('a monthly circle needs calendar months, not 30-day blocks', () {
      final c =
          circle(freq: ContributionFrequency.monthly, total: 4, current: 2);
      expect(rotationCyclesRemaining(c), 3);
      expect(suggestedRotationDeadline(c, now), DateTime(2027, 1, 20, 12));
    });

    test('weekly and quarterly follow the same shape', () {
      expect(
        suggestedRotationDeadline(
            circle(freq: ContributionFrequency.weekly, total: 2, current: 1),
            now),
        DateTime(2026, 11, 3, 12),
      );
      expect(
        suggestedRotationDeadline(
            circle(freq: ContributionFrequency.quarterly, total: 2, current: 2),
            now),
        DateTime(2027, 1, 20, 12),
      );
    });

    test('a circle with no agreed count is offered one period', () {
      // It runs as long as the members want, so there is no horizon to
      // measure. One period of headroom is the honest minimum.
      final c = circle(freq: ContributionFrequency.daily);
      expect(rotationCyclesRemaining(c), 0);
      expect(suggestedRotationDeadline(c, now), DateTime(2026, 10, 21, 12));
    });

    test('a rotation past its agreed count never suggests the past', () {
      final c = circle(freq: ContributionFrequency.daily, total: 2, current: 5);
      expect(rotationCyclesRemaining(c), 0);
      expect(suggestedRotationDeadline(c, now).isAfter(now), isTrue);
    });
  });

  group('recognising the server refusal', () {
    test('the three sentences the server actually sends', () {
      for (final msg in const [
        "this savings circle's end date has passed. Extend it to at least 22 Oct 2026",
        'the end date does not leave room for the cycles this circle still '
            'owes its members. Extend it to at least 22 Oct 2026',
        'the next cycle would start already overdue, which puts every member '
            'in arrears. Extend the end date to at least 22 Oct 2026',
      ]) {
        expect(looksLikeRotationNeedsExtension(Exception(msg)), isTrue,
            reason: msg);
      }
    });

    test('other refusals are NOT mistaken for it', () {
      // Matching these would offer a date picker for a problem a date cannot
      // fix. It fails safe either way — the plain error is shown instead —
      // but offering the wrong recovery is its own confusion.
      for (final msg in const [
        'rotation deferred — all 3 remaining position(s) are held by members in arrears',
        'this circle has already moved on to its next cycle',
        'not authorized',
        '',
      ]) {
        expect(looksLikeRotationNeedsExtension(Exception(msg)), isFalse,
            reason: msg);
      }
      expect(looksLikeRotationNeedsExtension(null), isFalse);
    });
  });

  test('the remaining-turns label reads as a person would say it', () {
    expect(
        rotationRemainingLabel(
            circle(freq: ContributionFrequency.daily, total: 3, current: 3)),
        '1 more cycle');
    expect(
        rotationRemainingLabel(
            circle(freq: ContributionFrequency.daily, total: 3, current: 1)),
        '3 more cycles');
  });

  group('the screen offers the fix instead of reporting a failure', () {
    final src = File(
      'lib/src/features/group_account/presentation/views/'
      'contribution_details_screen.dart',
    ).readAsLinesSync().where((l) {
      final t = l.trimLeft();
      return !t.startsWith('//') && !t.startsWith('///');
    }).join('\n');

    test('a refusal routes to the extend sheet', () {
      expect(src, contains('looksLikeRotationNeedsExtension(e)'));
      expect(src, contains('_extendThenStart(contribution'));
    });

    test('the extension is saved BEFORE the cycle is retried', () {
      final save = src.indexOf('updateContributionDetails(contribution.copyWith');
      final retry = src.indexOf('advanceRotation(contributionId: contribution.id)',
          save);
      expect(save, greaterThan(0));
      expect(retry, greaterThan(save),
          reason: 'a circle must never be told it was extended when it was not');
    });
  });
}
