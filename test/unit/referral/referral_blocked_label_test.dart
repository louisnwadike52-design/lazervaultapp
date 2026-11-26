import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_transaction_entity.dart';

/// A BONUS NEEDS A VERIFIED REFEREE **AND** A UNIQUE DEVICE.
///
/// Only the backend can judge the device half, so it writes the reason onto
/// the row while leaving the status at `pending` — nothing permanent has been
/// lost. The screen therefore has to prefer that reason over its own stage
/// wording, or it says "KYC not completed yet" about somebody who completed
/// KYC. One referrer in production had six signups, no bonus, and a screen
/// that told him nothing.

ReferralTransactionEntity _r({
  ReferralStatus status = ReferralStatus.pending,
  String? failureReason,
  bool hasJoined = true,
}) =>
    ReferralTransactionEntity(
      id: 1,
      referrerUserId: 10,
      refereeUserId: 20,
      referralCodeUsed: 'DANIQZU6',
      status: status,
      referrerRewardAmount: 1000,
      refereeRewardAmount: 1000,
      currency: 'NGN',
      createdAt: DateTime(2026, 11, 8),
      failureReason: failureReason,
      refereeHasJoined: hasJoined,
    );

const _sharedDevice = 'Signed up on a device already used by another account';

void main() {
  group('a pending referral the backend has blocked', () {
    test('shows the reason instead of the KYC stage', () {
      final r = _r(failureReason: _sharedDevice);
      expect(r.kycStageLabel, _sharedDevice);
      expect(r.kycStageLabel, isNot(contains('KYC not completed')),
          reason: 'the referee DID complete KYC; that wording is false here');
    });

    test('is flagged so the row can render as a problem', () {
      expect(_r(failureReason: _sharedDevice).blockedWhilePending, isTrue);
    });
  });

  group('an ordinary pending referral is unchanged', () {
    test('joined, no reason → the KYC stage wording', () {
      expect(_r().kycStageLabel, 'Joined · KYC not completed yet');
      expect(_r().blockedWhilePending, isFalse);
    });

    test('not joined yet → the signup wording', () {
      expect(_r(hasJoined: false).kycStageLabel,
          'Signed up · KYC not completed yet');
    });

    test('an EMPTY reason is not a reason', () {
      // A blank column must not promote an ordinary referral into a blocked
      // one, or every row would render red with no text.
      for (final blank in ['', '   ']) {
        final r = _r(failureReason: blank);
        expect(r.blockedWhilePending, isFalse, reason: 'reason=${blank.length}');
        expect(r.kycStageLabel, 'Joined · KYC not completed yet');
      }
    });

    test('a null reason is not a reason', () {
      expect(_r(failureReason: null).blockedWhilePending, isFalse);
    });
  });

  group('the other statuses keep their own meaning', () {
    test('completed still reads as earned, reason or not', () {
      final r = _r(status: ReferralStatus.completed, failureReason: 'stale');
      expect(r.kycStageLabel, 'KYC verified · bonus earned');
      expect(r.blockedWhilePending, isFalse,
          reason: 'blockedWhilePending is about PENDING rows only');
    });

    test('failed still surfaces its own reason', () {
      final r = _r(status: ReferralStatus.failed, failureReason: 'wallet error');
      expect(r.kycStageLabel, 'wallet error');
      expect(r.blockedWhilePending, isFalse);
    });

    test('cancelled is unaffected', () {
      final r = _r(status: ReferralStatus.cancelled, failureReason: _sharedDevice);
      expect(r.kycStageLabel, 'Cancelled');
      expect(r.blockedWhilePending, isFalse);
    });
  });
}
