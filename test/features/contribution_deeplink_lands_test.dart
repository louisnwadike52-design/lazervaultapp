import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Tapping an esusu notification opened a screen that loaded forever.
///
/// The ROUTE was fine — the resolver has always sent `contribution_*` types to
/// contributionDetails with the id from the payload. The SCREEN was the
/// problem, and it is worth stating exactly:
///
///   * `_currentContribution` is set ONLY from `GroupAccountGroupLoaded`,
///     which comes from loading a GROUP.
///   * A deep link has a contribution id and no group, so it calls
///     `loadContributionDetails`, which fetched the contribution, THREW THE
///     RESULT AWAY, and emitted `GroupAccountSuccess('Contribution loaded')`
///     — a message with no payload.
///   * The builder's last line is `return _buildLoadingView();`.
///
/// So every push tap, every in-app notification tap and every share link into
/// a contribution spun forever. Reaching the screen from the group screen
/// worked, because that path passes the hydrated entity — which is why it was
/// never seen in normal use.
void main() {
  group('the route resolves', () {
    const id = '383ab1e9-abca-4e92-ad81-b7ec6731f064';

    // The real types group-accounts-service publishes for a circle.
    const types = [
      'contribution_payout_completed',
      'contribution_payout_shortfall',
      'group_funds_payout_settled',
      'group_funds_payout_shortfall',
      'contribution_payment_due',
      'contribution_cycle_started',
    ];

    for (final t in types) {
      test('$t lands on the contribution, not the group list', () {
        final target =
            NotificationRouteResolver.resolve(t, {'contribution_id': id});
        expect(target, isNotNull, reason: '$t resolved to nothing');
        expect(target!.route, AppRoutes.contributionDetails);
        expect(target.arguments, isA<Map<String, dynamic>>());
        expect((target.arguments as Map)['contributionId'], id);
      });
    }

    test('the contribution id beats the group id when both are present', () {
      final target = NotificationRouteResolver.resolve(
        'contribution_payout_completed',
        {'contribution_id': id, 'group_id': 'some-group'},
      );
      expect((target!.arguments as Map)['contributionId'], id,
          reason: 'landing on the group lists the circles but says nothing '
              'about the one the message was about');
    });

    test('camelCase keys resolve too', () {
      // FCM delivers strings; the in-app feed delivers parsed JSON, and both
      // shapes have been written over the years.
      final target = NotificationRouteResolver.resolve(
          'contribution_payout_completed', {'contributionId': id});
      expect((target!.arguments as Map)['contributionId'], id);
    });

    test('no id at all still goes somewhere readable', () {
      final target = NotificationRouteResolver.resolve(
          'contribution_payout_completed', const {});
      expect(target, isNotNull,
          reason: 'a tap must never dead-end on the dashboard');
    });
  });

  group('the screen can actually render what it is sent', () {
    String stripped(String path) => File(path)
        .readAsStringSync()
        .split('\n')
        .where((l) =>
            !l.trimLeft().startsWith('//') && !l.trimLeft().startsWith('///'))
        .join('\n');

    const cubit =
        'lib/src/features/group_account/presentation/cubit/group_account_cubit.dart';
    const screen =
        'lib/src/features/group_account/presentation/views/contribution_details_screen.dart';
    const states =
        'lib/src/features/group_account/presentation/cubit/group_account_state.dart';

    test('the loaded state CARRIES the contribution', () {
      final s = stripped(states);
      expect(s, contains('class ContributionDetailsLoaded'));
      expect(s, contains('final Contribution contribution;'),
          reason: 'a state with no payload is what left the screen with '
              'nothing to render');
    });

    test('loadContributionDetails emits it instead of a bare message', () {
      final s = stripped(cubit);
      final i = s.indexOf('Future<void> loadContributionDetails(');
      expect(i, greaterThan(-1), reason: 'loadContributionDetails moved');
      final body = s.substring(i, (i + 1600).clamp(0, s.length));
      expect(body, contains('emit(ContributionDetailsLoaded('),
          reason: 'the fetched contribution is thrown away again');
      expect(body, isNot(contains("emit(GroupAccountSuccess('Contribution loaded')")),
          reason: 'a success MESSAGE tells the screen nothing it can render');
      expect(body, contains('await getContributionById(contributionId)'),
          reason: 'the result must be captured, not awaited for side effects');
    });

    test('the screen rebuilds on it and keeps it', () {
      final s = stripped(screen);
      final bw = s.indexOf('buildWhen:');
      expect(bw, greaterThan(-1));
      final window = s.substring(bw, (bw + 700).clamp(0, s.length));
      expect(window, contains('current is ContributionDetailsLoaded'),
          reason: 'without this the screen never rebuilds after the fetch and '
              'falls through to its loading view for good');
      expect(s, contains('state is ContributionDetailsLoaded'),
          reason: 'the listener must set _currentContribution from it');
      expect(s, contains('_currentContribution = state.contribution;'));
    });

    test('a deep link also fetches the group, for the viewer role', () {
      // The group is what tells the screen whether the viewer is an admin.
      // A deep link has no group id until the contribution lands.
      final s = stripped(screen);
      final i = s.indexOf('state is ContributionDetailsLoaded');
      final window = s.substring(i, (i + 1100).clamp(0, s.length));
      expect(window, contains('loadGroupDetails('),
          reason: 'without the group the admin-only controls never appear for '
              'someone who arrived from a notification');
    });

    test('the comment strip actually strips (self-check)', () {
      const sample = '// emit(ContributionDetailsLoaded(\n  final x = 1;\n';
      final out = sample
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(out, isNot(contains('ContributionDetailsLoaded')));
      expect(out, contains('final x = 1;'));
    });
  });
}
