import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_progress.dart';

import 'crowdfund_money_summary_test.dart' show campaign;

/// A campaign that met its target in full was shown as having raised
/// nothing, the moment its creator withdrew the money.
///
/// Measured on prod 2026-10-19 — "Building":
///   contributions (completed)  500.00
///   withdrawals  (completed)   500.00
///   crowdfunds.current_amount    0.00   <- what the bar drew
///   status                   completed
///
/// The card read "NGN 0 / 500 · 0.0%" under a green Completed badge.

void main() {
  group('a completed campaign shows what it achieved', () {
    test('THE PROD CASE: fully withdrawn still reads 100%', () {
      final p = CrowdfundProgress.of(campaign(
        id: 'building',
        current: 0,
        status: CrowdfundStatus.completed,
      ));
      expect(p.raised, 1000, reason: 'the fixture target is 1000');
      expect(p.percent, greaterThanOrEqualTo(100));
      expect(p.fraction, 1.0);
      expect(p.wasFullyFunded, isTrue);
    });

    test('completed is EVIDENCE of reaching target, not a label', () {
      // The deadline worker sets completed only when
      // CurrentAmount >= TargetAmount, so the status carries the fact.
      final p = CrowdfundProgress.of(campaign(
        id: 'x', current: 250, status: CrowdfundStatus.completed));
      expect(p.raised, 1000);
    });

    test('an overfunded campaign is not trimmed back to the target', () {
      final p = CrowdfundProgress.of(campaign(
        id: 'x', current: 1500, status: CrowdfundStatus.completed));
      expect(p.raised, 1500);
      expect(p.percent, greaterThan(100));
      expect(p.fraction, 1.0, reason: 'the BAR still clamps');
    });
  });

  group('every other status uses a floor, never an invention', () {
    test('refunded money was raised first', () {
      final p = CrowdfundProgress.of(campaign(
        id: 'x', current: 0, refunded: 150,
        status: CrowdfundStatus.cancelled));
      expect(p.raised, 150);
    });

    test('an expired campaign that truly raised nothing still reads zero', () {
      // "Community building" on prod: 0 raised, 0 refunded. Showing 0 is
      // CORRECT here, and the fix must not inflate it.
      final p = CrowdfundProgress.of(campaign(
        id: 'x', current: 0, status: CrowdfundStatus.expired));
      expect(p.raised, 0);
      expect(p.percent, 0);
      expect(p.wasFullyFunded, isFalse);
    });

    test('an active campaign is unchanged', () {
      final p = CrowdfundProgress.of(campaign(
        id: 'x', current: 400, status: CrowdfundStatus.active));
      expect(p.raised, 400);
      expect(p.percent, 40);
      expect(p.isFinished, isFalse);
    });
  });

  test('a server percentage higher than ours is trusted', () {
    // It may have seen an overfunded peak we cannot reconstruct from the
    // residual pot. A LOWER one is the bug and must never win.
    final c = Crowdfund(
      id: 'x',
      creatorUserId: 1,
      creator: const CrowdfundCreator(
        userId: 1, username: 'u', firstName: 'A', lastName: 'B',
        verified: false, facialRecognitionEnabled: false),
      title: 't', description: '', story: '', crowdfundCode: 'C',
      targetAmount: 1000, currentAmount: 0, currency: 'NGN',
      category: 'c', status: CrowdfundStatus.cancelled,
      donorCount: 0, progressPercentage: 80,
      createdAt: DateTime(2026, 1, 1), updatedAt: DateTime(2026, 1, 1),
    );
    expect(CrowdfundProgress.of(c).percent, 80);
  });

  test('a zero target never divides by zero', () {
    final p = CrowdfundProgress.of(campaign(
      id: 'x', current: 50, status: CrowdfundStatus.active));
    expect(p.fraction, inInclusiveRange(0.0, 1.0));
  });
}
