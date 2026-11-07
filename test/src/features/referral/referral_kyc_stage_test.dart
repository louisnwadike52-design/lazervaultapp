import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_transaction_entity.dart';

// A referrer reported six signups against his code and no bonus, and the screen
// gave him nothing to go on: a name and a date. These pin the line that now
// tells him what is outstanding.

ReferralTransactionEntity _referral({
  required ReferralStatus status,
  bool hasJoined = false,
  String? failureReason,
}) {
  return ReferralTransactionEntity(
    id: 1,
    referrerUserId: 10,
    refereeUserId: 20,
    referralCodeUsed: 'DANIQZU6',
    status: status,
    referrerRewardAmount: 20000,
    refereeRewardAmount: 0,
    currency: 'NGN',
    createdAt: DateTime(2026, 11, 7),
    failureReason: failureReason,
    refereeFirstName: 'Victor',
    refereeLastName: 'Fabian',
    refereeUsername: 'victor',
    referrerUsername: 'daniel',
    refereeHasJoined: hasJoined,
  );
}

void main() {
  group('referral KYC stage', () {
    test('a credited referral reads as verified and earned', () {
      final r = _referral(status: ReferralStatus.completed, hasJoined: true);
      expect(r.refereeKycVerified, isTrue);
      expect(r.awaitingRefereeKyc, isFalse);
      expect(r.kycStageLabel, 'KYC verified · bonus earned');
    });

    test('a pending referral says KYC is what is outstanding', () {
      final r = _referral(status: ReferralStatus.pending);
      expect(r.refereeKycVerified, isFalse);
      expect(r.awaitingRefereeKyc, isTrue);
      // The whole point: the referrer must be able to see WHY nothing is owed.
      expect(r.kycStageLabel, contains('KYC'));
      expect(r.kycStageLabel, 'Signed up · KYC not completed yet');
    });

    test('a failed referral surfaces the reason rather than a bare status', () {
      final r = _referral(
        status: ReferralStatus.failed,
        failureReason: 'referral code belongs to the same user',
      );
      expect(r.kycStageLabel, 'referral code belongs to the same user');
    });

    test('a failed referral with no reason still says something useful', () {
      final r = _referral(status: ReferralStatus.failed, failureReason: '   ');
      expect(r.kycStageLabel, 'Could not be completed');
    });

    test('an unverified referee is never presented as earning', () {
      for (final s in [
        ReferralStatus.pending,
        ReferralStatus.failed,
        ReferralStatus.cancelled,
      ]) {
        expect(_referral(status: s).refereeKycVerified, isFalse,
            reason: '$s must not render the +NGN200 earned badge');
      }
    });
  });
}
