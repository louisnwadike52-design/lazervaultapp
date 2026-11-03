import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_settings_tile.dart';

/// WHAT SETTINGS TELLS A CUSTOMER ABOUT THEIR KYC.
///
/// The held case used to read "Tier 1 - add your second ID to raise limits".
/// That customer has already FINISHED a verification; it is sitting with a
/// human because the BVN name only partly matched. They have no second ID to
/// add, and doing what the tile said starts another Mono Prove session — a
/// fresh session fee, landing on the same hold.
///
/// It was also the Settings entry contradicting the onboarding entry, which
/// showed the full held state at the same moment for the same account.
ProveKycStatus status({
  bool verified = false,
  int tier = 1,
  String sessionState = 'pending',
  String failureReason = '',
  String bvnName = '',
  String profileName = '',
  bool correctionReceived = false,
}) =>
    ProveKycStatus(
      verified: verified,
      tier: tier,
      tierName: 'Tier $tier',
      completedSteps: const [],
      nextTier: tier + 1,
      nextRequirements: const [],
      message: '',
      sessionState: sessionState,
      failureReason: failureReason,
      bvnName: bvnName,
      profileName: profileName,
      nameCorrectionReceived: correctionReceived,
    );

void main() {
  group('held for name review', () {
    test('never invites a second ID, and never a second session', () {
      final s = kycTileSubtitle(status(
        failureReason: 'name_review',
        bvnName: 'Nmesomachi Favour',
        profileName: 'mienye Favour',
      ));
      expect(s.toLowerCase(), contains('reviewed'));
      expect(s.toLowerCase(), isNot(contains('second id')));
      expect(s.toLowerCase(), isNot(contains('verify your identity')));
    });

    test('acknowledges a correction already on file', () {
      final s = kycTileSubtitle(status(
        failureReason: 'name_review',
        bvnName: 'A B',
        profileName: 'C D',
        correctionReceived: true,
      ));
      expect(s.toLowerCase(), contains('correction'));
    });

    test('is not shown as neutral — it needs attention', () {
      expect(
        kycTileSubtitleIsSettled(status(
          failureReason: 'name_review',
          bvnName: 'A B',
          profileName: 'C D',
        )),
        isFalse,
      );
    });
  });

  group('terminal failures each say what happened', () {
    test('a refused BVN points at retrying, not at a second ID', () {
      final s = kycTileSubtitle(
          status(sessionState: 'failed', failureReason: 'name_mismatch'));
      expect(s.toLowerCase(), contains('try again'));
      expect(s.toLowerCase(), isNot(contains('second id')));
    });

    test('cancelled and expired are distinguishable from never-started', () {
      final cancelled = kycTileSubtitle(
          status(sessionState: 'failed', failureReason: 'cancelled'));
      final expired = kycTileSubtitle(
          status(sessionState: 'failed', failureReason: 'expired'));
      final never = kycTileSubtitle(status(tier: 0));
      expect(cancelled, isNot(equals(never)));
      expect(expired, isNot(equals(never)));
      expect(cancelled, isNot(equals(expired)));
    });
  });

  group('verified always wins', () {
    test('a stale failure note never contradicts an earned tier', () {
      // A failed UPGRADE attempt must not tell a verified customer their
      // identity is under review.
      final s = kycTileSubtitle(status(
        verified: true,
        tier: 2,
        failureReason: 'name_review',
        bvnName: 'A B',
        profileName: 'C D',
      ));
      expect(s.toLowerCase(), contains('verified'));
      expect(s.toLowerCase(), isNot(contains('reviewed')));
      expect(kycTileSubtitleIsSettled(status(verified: true, tier: 2)), isTrue);
    });

    test('tier 3 reads as fully verified', () {
      expect(
        kycTileSubtitle(status(verified: true, tier: 3)).toLowerCase(),
        contains('tier 3'),
      );
    });
  });

  group('the ordinary states are unchanged', () {
    test('never started', () {
      expect(
        kycTileSubtitle(status(tier: 0, sessionState: '')).toLowerCase(),
        contains('verify your identity'),
      );
    });

    test('tier 1 with nothing in flight still asks for the second ID', () {
      expect(
        kycTileSubtitle(status(tier: 1, sessionState: '')).toLowerCase(),
        contains('second id'),
      );
    });

    test('a null status (lookup failed) degrades, never throws', () {
      expect(kycTileSubtitle(null), isNotEmpty);
      expect(kycTileSubtitleIsSettled(null), isFalse);
    });
  });
}
