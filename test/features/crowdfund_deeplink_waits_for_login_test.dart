import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/src/core/services/deep_link_service.dart';

/// A shared crowdfund link must not drop the campaign at the login gate.
///
/// "Crowdfund deep link shouldn't just go to the page. It has to go through
/// the login flow and store the payload of where it's supposed to navigate to
/// and all the details that it needs."
///
/// Two separate things have to hold, and they live in two different files:
///
///  1. The PARSER must recover the campaign id from both link shapes, so there
///     is a payload to stash at all.
///  2. The TARGET that main.dart builds from it must require auth, so
///     PendingDeepLink holds it until there is a session rather than pushing
///     the page over the sign-in screen.
void main() {
  group('a shared campaign link carries its id', () {
    test('universal link', () {
      final data = DeepLinkService.parseUriForTest(
          Uri.parse('https://lazervault.app/crowdfund/abc-123'));
      
      expect(data.type, DeepLinkType.crowdfundCampaign);
      expect(data.crowdfundCampaignId, 'abc-123');
    });

    test('custom scheme', () {
      final data = DeepLinkService.parseUriForTest(
          Uri.parse('lazervault://crowdfund/abc-123'));
      
      expect(data.type, DeepLinkType.crowdfundCampaign);
      expect(data.crowdfundCampaignId, 'abc-123');
    });
  });

  test('the target it becomes waits for a session', () {
    // Mirrors what main.dart pushes for DeepLinkType.crowdfundCampaign. The
    // default matters: NotificationTarget.requiresAuth defaults to true, and
    // PendingDeepLink.consumeAndNavigate returns early while it is unmet, so
    // the campaign is held and replayed after login instead of being pushed
    // over the sign-in screen and lost.
    const target = NotificationTarget(
      route: '/crowdfund-details',
      arguments: {'crowdfundId': 'abc-123'},
    );
    expect(target.requiresAuth, isTrue,
        reason: 'A campaign link opened logged-out must survive the gate. '
            'Passing requiresAuth: false here would navigate immediately, '
            'which is the behaviour that was reported as wrong.');
    expect((target.arguments as Map)['crowdfundId'], 'abc-123',
        reason: 'The id is the whole payload — without it the replayed page '
            'has nothing to load.');
  });
}
