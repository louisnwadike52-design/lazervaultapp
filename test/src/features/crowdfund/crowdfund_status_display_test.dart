import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_status_display.dart';

/// Completed, expired and cancelled are three different endings.
///
/// Reported: the donations list said "Completed" about a contribution to a
/// campaign whose own page said "Cancelled". The server side of that is
/// fixed (the proxy now derives a donation status instead of hardcoding
/// COMPLETED); this covers the campaign side, where three separate copies
/// of the status vocabulary disagreed with each other.
Crowdfund _c({
  required CrowdfundStatus status,
  DateTime? deadline,
  String? cancelReason,
}) =>
    Crowdfund(
      id: 'cf1',
      creatorUserId: 7,
      creator: const CrowdfundCreator(
        userId: 7,
        username: 'glora',
        firstName: 'Glora',
        lastName: 'Ltd',
        verified: false,
        facialRecognitionEnabled: false,
      ),
      title: 'Expand Glora to 54 African Countries',
      description: '',
      story: '',
      crowdfundCode: 'LVCF-1',
      targetAmount: 1000,
      currentAmount: 0,
      currency: 'NGN',
      deadline: deadline,
      category: 'business',
      status: status,
      donorCount: 0,
      progressPercentage: 0,
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 10, 1),
      cancelReason: cancelReason,
    );

final _future = DateTime.now().add(const Duration(days: 20));
final _past = DateTime.now().subtract(const Duration(days: 3));

void main() {
  group('status visuals', () {
    test('a server-expired campaign is not reported as Active', () {
      // THE BUG. The detail screen tested `isExpired && isActive` first;
      // a row the deadline worker had already set to `expired` is not
      // active, so it matched nothing and fell through to the Active
      // default — a closed campaign inviting contributions.
      final v = crowdfundStatusVisual(_c(
        status: CrowdfundStatus.expired,
        deadline: _past,
      ));
      expect(v.label, 'Expired');
      expect(v.blurb, isNotEmpty);
    });

    test('a cancelling campaign is not reported as Active either', () {
      final v = crowdfundStatusVisual(_c(status: CrowdfundStatus.cancelling));
      expect(v.label, 'Refunding');
    });

    test('the three endings get three different colours', () {
      final completed =
          crowdfundStatusVisual(_c(status: CrowdfundStatus.completed));
      final expired = crowdfundStatusVisual(_c(status: CrowdfundStatus.expired));
      final cancelled =
          crowdfundStatusVisual(_c(status: CrowdfundStatus.cancelled));

      expect({completed.color, expired.color, cancelled.color}.length, 3,
          reason: 'the card painted expired the same red as cancelled');
      expect({completed.label, expired.label, cancelled.label}.length, 3);
    });

    test('expired is not painted as a failure', () {
      // Missing a target is not misconduct; red says it was.
      expect(crowdfundStatusVisual(_c(status: CrowdfundStatus.expired)).color,
          isNot(crowdfundStatusVisual(_c(status: CrowdfundStatus.cancelled))
              .color));
    });

    test('active past its own deadline claims neither ending', () {
      // The worker has not run. We do not know yet whether it closes as
      // completed or expired, so it must not say either.
      final v = crowdfundStatusVisual(
          _c(status: CrowdfundStatus.active, deadline: _past));
      expect(v.label, 'Closing');
    });

    test('an open campaign carries no banner text', () {
      final v = crowdfundStatusVisual(
          _c(status: CrowdfundStatus.active, deadline: _future));
      expect(v.label, 'Active');
      expect(v.blurb, isEmpty, reason: 'no banner on a healthy campaign');
    });

    test('the active colour is the only surface-specific one', () {
      const brand = Color(0xFF4E03D0);
      expect(
        crowdfundStatusVisual(
          _c(status: CrowdfundStatus.active, deadline: _future),
          activeColor: brand,
        ).color,
        brand,
      );
      expect(
        crowdfundStatusVisual(
          _c(status: CrowdfundStatus.cancelled),
          activeColor: brand,
        ).color,
        isNot(brand),
        reason: 'activeColor must not leak into terminal states',
      );
    });
  });

  group('deadline label', () {
    test('a cancelled campaign has not "reached its deadline"', () {
      // THE REPORTED LINE. A campaign cancelled weeks early said
      // "Deadline reached", because the only test was daysRemaining > 0.
      expect(
        crowdfundDeadlineLabel(
            _c(status: CrowdfundStatus.cancelled, deadline: _future)),
        'Cancelled',
      );
    });

    test('each terminal state names itself', () {
      expect(
          crowdfundDeadlineLabel(
              _c(status: CrowdfundStatus.completed, deadline: _future)),
          'Closed');
      expect(
          crowdfundDeadlineLabel(
              _c(status: CrowdfundStatus.expired, deadline: _past)),
          'Ended');
      expect(
          crowdfundDeadlineLabel(
              _c(status: CrowdfundStatus.cancelling, deadline: _future)),
          'Cancelled');
    });

    test('under 24 hours left is the Last day, not "0 days left"', () {
      final c = _c(
        status: CrowdfundStatus.active,
        deadline: DateTime.now().add(const Duration(hours: 10)),
      );
      expect(c.daysRemaining, 0, reason: 'inDays truncates');
      expect(crowdfundDeadlineLabel(c), 'Last day');
    });

    test('singular day', () {
      final c = _c(
        status: CrowdfundStatus.active,
        deadline: DateTime.now().add(const Duration(days: 1, hours: 2)),
      );
      expect(crowdfundDeadlineLabel(c), '1 day left');
    });

    test('an open campaign past its deadline did reach it', () {
      expect(
        crowdfundDeadlineLabel(
            _c(status: CrowdfundStatus.active, deadline: _past)),
        'Deadline reached',
      );
    });

    test('no deadline, no clock line', () {
      expect(crowdfundDeadlineLabel(_c(status: CrowdfundStatus.active)), '');
    });
  });

  group('urgency', () {
    test('a finished campaign never wears the hurry colour', () {
      // daysRemaining is 0 for every terminal campaign, and the amber was
      // keyed on `< 7`, so completed and cancelled cards looked urgent.
      for (final s in [
        CrowdfundStatus.completed,
        CrowdfundStatus.cancelled,
        CrowdfundStatus.cancelling,
        CrowdfundStatus.expired,
      ]) {
        expect(crowdfundDeadlineIsUrgent(_c(status: s, deadline: _past)), false,
            reason: '$s must not be urgent');
      }
    });

    test('an open campaign inside a week is urgent', () {
      expect(
        crowdfundDeadlineIsUrgent(_c(
          status: CrowdfundStatus.active,
          deadline: DateTime.now().add(const Duration(days: 3)),
        )),
        true,
      );
    });

    test('an open campaign past its deadline is not urgent, it is over', () {
      expect(
        crowdfundDeadlineIsUrgent(
            _c(status: CrowdfundStatus.active, deadline: _past)),
        false,
      );
    });
  });

  group('accepts contributions', () {
    test('only an active campaign inside its deadline', () {
      expect(
          crowdfundAcceptsContributions(
              _c(status: CrowdfundStatus.active, deadline: _future)),
          true);
      expect(
          crowdfundAcceptsContributions(
              _c(status: CrowdfundStatus.active, deadline: _past)),
          false);
      for (final s in [
        CrowdfundStatus.paused,
        CrowdfundStatus.completed,
        CrowdfundStatus.cancelling,
        CrowdfundStatus.cancelled,
        CrowdfundStatus.expired,
      ]) {
        expect(crowdfundAcceptsContributions(_c(status: s, deadline: _future)),
            false,
            reason: '$s must not offer a Contribute button');
      }
    });

    test('a campaign with no deadline stays open', () {
      expect(
          crowdfundAcceptsContributions(_c(status: CrowdfundStatus.active)),
          true);
    });
  });
}
