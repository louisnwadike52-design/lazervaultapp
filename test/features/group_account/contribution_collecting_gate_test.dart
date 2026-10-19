import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// The Contribute CTA was gated on `isCompleted` alone.
///
/// MakePayment refuses EVERY non-active status, each with its own sentence:
///   completed  → "it has reached its target and is now closed"
///   paused     → "it is paused — the organiser can resume it"
///   cancelled  → "it was cancelled"
///
/// so a paused or cancelled contribution still showed the button, and the
/// only way to find out was to go through the pay screen, choose an amount
/// and be refused at the end. `isCollecting` mirrors the server's own state
/// check so the two cannot disagree about what "collecting" means.

Contribution contributionWith(ContributionStatus status) => Contribution(
      id: 'c1',
      groupId: 'g1',
      title: 'Test',
      description: '',
      targetAmount: 1000,
      currentAmount: 0,
      currency: 'NGN',
      status: status,
      createdBy: 'u1',
      payments: const [],
      deadline: DateTime(2026, 12, 31),
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('only an ACTIVE contribution is collecting', () {
    expect(contributionWith(ContributionStatus.active).isCollecting, isTrue);
  });

  test('the three states the server refuses are not collecting', () {
    for (final s in [
      ContributionStatus.completed,
      ContributionStatus.paused,
      ContributionStatus.cancelled,
    ]) {
      expect(contributionWith(s).isCollecting, isFalse,
          reason: '$s still offers Contribute, and the tap is refused by '
              'MakePayment after the user has picked an amount');
    }
  });

  test('isCompleted stays narrow — it is a different question', () {
    // Other call sites ask "did this finish successfully", which is not the
    // same as "can it take money"; widening isCompleted would have changed
    // their meaning too.
    expect(contributionWith(ContributionStatus.completed).isCompleted, isTrue);
    expect(contributionWith(ContributionStatus.paused).isCompleted, isFalse);
    expect(contributionWith(ContributionStatus.cancelled).isCompleted, isFalse);
  });
}
