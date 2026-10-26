import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/account_update_announcement_service.dart';

/// The "your account details have changed" broadcast must expire.
///
/// It has NO audience filter — it reaches everyone who has not acknowledged it,
/// including users whose account never moved and people who signed up long
/// after the migration it describes. Reported 2026-10-26: it was still
/// published at version 1 from a batch that had long finished, so users kept
/// being told their details changed when nothing had.
///
/// Failing CLOSED on a missing expiry is the fix: an announcement somebody
/// forgets to retire stands itself down, and keeping one running requires
/// saying until when.
String _json(Map<String, Object?> m) => jsonEncode(m);

void main() {
  final svc = AccountUpdateAnnouncementService.instance;

  const base = {
    'version': 1,
    'title': 'Your account details have changed',
    'body': 'Your deposit account number is new.',
    'cta': 'View updated account details',
  };

  test('an announcement with NO expires_at is refused', () {
    // The exact shape that was live in production and would not stop.
    expect(svc.parseAnnouncement(_json(base)), isNull);
  });

  test('an announcement whose expiry has passed is refused', () {
    final past = DateTime.now().toUtc().subtract(const Duration(days: 1));
    expect(
      svc.parseAnnouncement(_json({...base, 'expires_at': past.toIso8601String()})),
      isNull,
    );
  });

  test('an announcement with a future expiry still shows', () {
    // The feature must keep working for a real migration.
    final future = DateTime.now().toUtc().add(const Duration(days: 7));
    final ann =
        svc.parseAnnouncement(_json({...base, 'expires_at': future.toIso8601String()}));
    expect(ann, isNotNull);
    expect(ann!.version, 1);
    expect(ann.title, 'Your account details have changed');
  });

  test('a malformed expiry is refused, not ignored', () {
    // "soon" must not read as "forever".
    expect(
      svc.parseAnnouncement(_json({...base, 'expires_at': 'soon'})),
      isNull,
    );
  });

  test('version 0 is still refused regardless of expiry', () {
    final future = DateTime.now().toUtc().add(const Duration(days: 7));
    expect(
      svc.parseAnnouncement(
          _json({...base, 'version': 0, 'expires_at': future.toIso8601String()})),
      isNull,
    );
  });
}
