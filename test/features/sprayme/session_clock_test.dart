import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_clock.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';

SpraySession _session({DateTime? expiresAt}) => SpraySession(
      id: 's1',
      hostUserId: 'h1',
      hostName: 'Praiz',
      title: 'Independence Naija',
      occasionType: 'party',
      sessionCode: 'ABC123',
      status: 'active',
      createdAt: DateTime.now(),
      expiresAt: expiresAt,
    );

const _policy = SessionClockPolicy(
  enabled: true,
  freeMinutes: 120,
  maxTotalHours: 12,
  warnAtMinutes: [15, 5, 1],
  options: [
    SessionExtensionOption(minutes: 30, priceKobo: 50000, label: '30 more minutes'),
    SessionExtensionOption(minutes: 60, priceKobo: 90000, label: '1 more hour'),
  ],
);

void main() {
  group('a session with no clock', () {
    // THE DEFAULT, and the one that must never go wrong. No deadline is
    // stamped while session limits are off, so every session on the platform
    // today has a null expiresAt. Reading that as "expires now" would end
    // every party in the country.
    test('has no deadline and no countdown', () {
      final s = _session();
      expect(s.hasTimeLimit, isFalse);
      expect(s.timeRemaining, isNull);
      expect(urgencyFor(null, _policy), SessionClockUrgency.calm);
    });

    test('a missing or empty expires_at parses to null, never to now', () {
      expect(SpraySession.fromJson(_json()).expiresAt, isNull);
      expect(SpraySession.fromJson(_json(expiresAt: '')).expiresAt, isNull);
      // An unparseable value is also null — a malformed timestamp must not be
      // the reason a live session is shown as ending.
      expect(SpraySession.fromJson(_json(expiresAt: 'not a date')).expiresAt,
          isNull);
    });
  });

  group('time remaining', () {
    test('counts down from the deadline', () {
      final s = _session(
          expiresAt: DateTime.now().add(const Duration(minutes: 30)));
      final left = s.timeRemaining!;
      expect(left.inMinutes, inInclusiveRange(29, 30));
    });

    // Never negative: "-3m left" is not a countdown, and the server ends an
    // overdue session within thirty seconds anyway.
    test('clamps at zero once the deadline has passed', () {
      final s = _session(
          expiresAt: DateTime.now().subtract(const Duration(minutes: 5)));
      expect(s.timeRemaining, Duration.zero);
    });
  });

  group('urgency', () {
    test('calm well clear of the first warning', () {
      expect(urgencyFor(const Duration(minutes: 40), _policy),
          SessionClockUrgency.calm);
      expect(urgencyFor(const Duration(minutes: 16), _policy),
          SessionClockUrgency.calm);
    });

    test('warning from the first mark', () {
      expect(urgencyFor(const Duration(minutes: 15), _policy),
          SessionClockUrgency.warning);
      expect(urgencyFor(const Duration(minutes: 6), _policy),
          SessionClockUrgency.warning);
    });

    test('critical from the last mark', () {
      expect(urgencyFor(const Duration(minutes: 1), _policy),
          SessionClockUrgency.critical);
      expect(urgencyFor(const Duration(seconds: 20), _policy),
          SessionClockUrgency.critical);
      expect(urgencyFor(Duration.zero, _policy), SessionClockUrgency.critical);
    });

    // A disabled policy must render nothing alarming even if a deadline
    // somehow arrives — the admin turned the feature off, so the app says
    // nothing about time.
    test('a disabled policy is always calm', () {
      const off = SessionClockPolicy(enabled: false, warnAtMinutes: [15, 5, 1]);
      expect(urgencyFor(const Duration(seconds: 5), off),
          SessionClockUrgency.calm);
    });

    test('a policy with no marks is always calm rather than crashing', () {
      const none = SessionClockPolicy(enabled: true, warnAtMinutes: []);
      expect(urgencyFor(const Duration(seconds: 5), none),
          SessionClockUrgency.calm);
    });
  });

  group('countdown formatting', () {
    test('hours show h:mm:ss', () {
      expect(formatCountdown(const Duration(hours: 1, minutes: 4, seconds: 30)),
          '1:04:30');
    });

    // Above ten minutes the seconds are noise; below it they are the whole
    // point.
    test('minutes only when there is plenty left', () {
      expect(formatCountdown(const Duration(minutes: 42)), '42m');
      expect(formatCountdown(const Duration(minutes: 10)), '10m');
    });

    test('seconds appear under ten minutes', () {
      expect(formatCountdown(const Duration(minutes: 4, seconds: 30)), '4:30');
      expect(formatCountdown(const Duration(seconds: 45)), '0:45');
      expect(formatCountdown(const Duration(seconds: 5)), '0:05');
    });

    test('never renders a negative', () {
      expect(formatCountdown(const Duration(minutes: -5)), '0:00');
    });
  });

  group('policy parsing', () {
    test('an unreachable policy is disabled, not assumed', () {
      expect(SessionClockPolicy.unknown.enabled, isFalse,
          reason: 'an unreachable endpoint must never be the reason a host is '
              'told their session is about to end');
    });

    test('marks are sorted longest first whatever order they arrive in', () {
      final p = SessionClockPolicy.fromJson({
        'enabled': true,
        'warn_at_minutes': [1, 15, 5],
      });
      expect(p.warnAtMinutes, [15, 5, 1]);
    });

    test('options carry their price in kobo and render in naira', () {
      final p = SessionClockPolicy.fromJson({
        'enabled': true,
        'options': [
          {'minutes': 30, 'price_kobo': 50000, 'label': '30 more minutes'},
        ],
      });
      expect(p.options.single.priceKobo, 50000);
      expect(p.options.single.priceMajor, 500.0);
    });

    test('a malformed payload degrades to the safe default', () {
      final p = SessionClockPolicy.fromJson({});
      expect(p.enabled, isFalse);
      expect(p.options, isEmpty);
    });
  });
}

Map<String, dynamic> _json({String? expiresAt}) => {
      'id': 's1',
      'host_user_id': 'h1',
      'host_name': 'Praiz',
      'title': 'Independence Naija',
      'occasion_type': 'party',
      'session_code': 'ABC123',
      'status': 'active',
      if (expiresAt != null) 'expires_at': expiresAt,
    };
