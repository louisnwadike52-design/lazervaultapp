import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_ownership.dart';

/// The "Yours" pill existed only on Browse All, because the check that drove
/// it was a private one-liner inside that screen's State. The leaderboard and
/// the dashboard's trending rail — the two places a creator is most likely to
/// meet their own campaign among strangers' — had no way to ask the question.
///
/// The rule itself is the part that can quietly go wrong, so it lives in a
/// plain function with these tests rather than in three screens.

Crowdfund campaignBy(String username) => Crowdfund(
      id: 'c1',
      creatorUserId: 1,
      creator: CrowdfundCreator(
        userId: 1,
        username: username,
        firstName: 'Praiz',
        lastName: 'Onah',
        verified: false,
        facialRecognitionEnabled: false,
      ),
      title: 'Building',
      description: '',
      story: '',
      crowdfundCode: 'CF1',
      targetAmount: 500,
      currentAmount: 375,
      currency: 'NGN',
      category: 'community',
      status: CrowdfundStatus.active,
      donorCount: 1,
      progressPercentage: 75,
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 1),
    );

void main() {
  group('mine', () {
    test('the creator sees their own campaign as theirs', () {
      expect(crowdfundIsMine(campaignBy('onahpraiz'), 'onahpraiz'), isTrue);
    });

    test('case and padding do not decide ownership', () {
      expect(crowdfundIsMine(campaignBy('OnahPraiz'), '  onahpraiz '), isTrue);
    });

    test('a leading @ is ignored on either side', () {
      // The profile stores a bare handle; plenty of UI carries the display
      // form. Comparing them raw made a creator a stranger to their own
      // campaign.
      expect(crowdfundIsMine(campaignBy('@onahpraiz'), 'onahpraiz'), isTrue);
      expect(crowdfundIsMine(campaignBy('onahpraiz'), '@onahpraiz'), isTrue);
    });
  });

  group('not mine', () {
    test('someone else’s campaign is not badged', () {
      expect(crowdfundIsMine(campaignBy('chris'), 'onahpraiz'), isFalse);
    });

    test('THE DANGEROUS CASE: no profile loaded badges nothing', () {
      // "unknown equals unknown" would mark EVERY campaign as yours the
      // moment the profile failed to load — on a screen that offers withdraw
      // and edit affordances off the back of ownership.
      expect(crowdfundIsMine(campaignBy('onahpraiz'), null), isFalse);
      expect(crowdfundIsMine(campaignBy('onahpraiz'), ''), isFalse);
      expect(crowdfundIsMine(campaignBy('onahpraiz'), '   '), isFalse);
    });

    test('a campaign with no creator handle is not badged either', () {
      expect(crowdfundIsMine(campaignBy(''), 'onahpraiz'), isFalse);
      expect(crowdfundIsMine(campaignBy('@'), 'onahpraiz'), isFalse);
    });

    test('both sides empty is still not a match', () {
      expect(crowdfundIsMine(campaignBy(''), ''), isFalse);
    });
  });

  test('the production pair: chris does not own praiz’s campaign', () {
    // Measured 2026-10-19: the three live campaigns carry creator_username
    // "chris" (1) and "onahpraiz" (2).
    expect(crowdfundIsMine(campaignBy('onahpraiz'), 'chris'), isFalse);
    expect(crowdfundIsMine(campaignBy('chris'), 'chris'), isTrue);
  });

  test('usernamesMatch is usable without a Crowdfund', () {
    expect(usernamesMatch('@Chris', 'chris'), isTrue);
    expect(usernamesMatch('chris', 'chris2'), isFalse);
  });
}
