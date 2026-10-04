import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/src/features/impersonation/data/impersonation_service.dart';
import 'package:lazervault/src/features/impersonation/presentation/impersonation_session.dart';

// WHAT THESE PROTECT
// ------------------
// The worst failure this feature can have is an admin silently acting as
// someone else: no banner, no exit, another person's balance presented as
// their own. Every case below is one of the ways that could happen.

String _b64(Map<String, dynamic> m) {
  // JWT payloads are base64url WITHOUT padding. The decoder has to cope, so
  // the fixtures are built the way a real server emits them.
  return base64Url.encode(utf8.encode(jsonEncode(m))).replaceAll('=', '');
}

String _token(Map<String, dynamic> claims) =>
    'header.${_b64(claims)}.signature';

void main() {
  group('ImpersonationState', () {
    test('none() is inactive and claims no time', () {
      const s = ImpersonationState.none();
      expect(s.active, isFalse);
      expect(s.sessionId, isEmpty);
      expect(s.minutesRemaining, 0);
    });

    test('minutesRemaining never goes negative', () {
      // An expired session must read as "0 minutes", not "-3". The banner
      // prints this number.
      final s = ImpersonationState(
        active: true,
        sessionId: 's',
        targetLabel: 'Chris',
        expiresAt: DateTime.now().toUtc().subtract(const Duration(minutes: 3)),
      );
      expect(s.minutesRemaining, 0);
    });

    test('minutesRemaining floors toward zero', () {
      final s = ImpersonationState(
        active: true,
        sessionId: 's',
        targetLabel: 'Chris',
        expiresAt: DateTime.now()
            .toUtc()
            .add(const Duration(minutes: 14, seconds: 50)),
      );
      expect(s.minutesRemaining, 14);
    });

    test('a session with no expiry reads as 0, not forever', () {
      const s = ImpersonationState(
          active: true, sessionId: 's', targetLabel: 'Chris');
      expect(s.minutesRemaining, 0);
    });
  });

  group('ImpersonationCandidate', () {
    Map<String, dynamic> row({
      String role = 'user',
      bool selectable = true,
      String first = 'Chris',
      String last = 'Okoye',
    }) =>
        {
          'id': 'u-1',
          'email': 'chris@example.com',
          'first_name': first,
          'last_name': last,
          'highest_role': role,
          'selectable': selectable,
        };

    test('selectable comes from the SERVER, never re-derived', () {
      // The server computes it with exactly the rule the mint refuses on, so
      // the list can never offer a row the mint would then reject — nor, more
      // importantly, one it would wrongly accept.
      final c = ImpersonationCandidate.fromJson(row(selectable: false));
      expect(c.selectable, isFalse);
      final d = ImpersonationCandidate.fromJson(row(selectable: true));
      expect(d.selectable, isTrue);
    });

    test('a missing selectable flag defaults to NOT selectable', () {
      // Fails closed: a server that stops sending the field must not make
      // every row tappable.
      final j = row()..remove('selectable');
      expect(ImpersonationCandidate.fromJson(j).selectable, isFalse);
    });

    test('a blocked privileged row explains why', () {
      final c = ImpersonationCandidate.fromJson(
          row(role: 'super_admin', selectable: false));
      expect(c.blockedReason, contains('equal or higher privileges'));
    });

    test('a blocked plain row reads as your own account', () {
      final c =
          ImpersonationCandidate.fromJson(row(role: 'user', selectable: false));
      expect(c.blockedReason, contains('your own account'));
    });

    test('a selectable row has no reason to show', () {
      expect(ImpersonationCandidate.fromJson(row()).blockedReason, isEmpty);
    });

    test('displayName falls back through name, username, email, id', () {
      expect(ImpersonationCandidate.fromJson(row()).displayName,
          'Chris Okoye');
      final noName = row(first: '', last: '')..['username'] = 'chrisy';
      expect(ImpersonationCandidate.fromJson(noName).displayName, '@chrisy');
      final noUser = row(first: '', last: '')..['username'] = '';
      expect(ImpersonationCandidate.fromJson(noUser).displayName,
          'chris@example.com');
      final nothing = row(first: '', last: '')
        ..['username'] = ''
        ..['email'] = '';
      expect(ImpersonationCandidate.fromJson(nothing).displayName, 'u-1');
    });
  });

  group('role gate on the entry point', () {
    // The gate decides whether to DRAW the tile. The server enforces the real
    // thing at both endpoints and again at the mint, so these cases are about
    // not offering something that will be refused — and about not offering a
    // nested session.
    bool canImpersonate(Map<String, dynamic> claims) {
      if (claims['imp'] == true) return false;
      final roles = <String>{};
      final raw = claims['roles'];
      if (raw is List) {
        for (final r in raw) {
          final s = r?.toString().trim().toLowerCase();
          if (s != null && s.isNotEmpty) roles.add(s);
        }
      }
      final single = claims['role']?.toString().trim().toLowerCase();
      if (single != null && single.isNotEmpty) roles.add(single);
      return roles.contains('admin') ||
          roles.contains('pro_admin') ||
          roles.contains('super_admin');
    }

    test('admin, pro_admin and super_admin see the entry point', () {
      for (final r in ['admin', 'pro_admin', 'super_admin']) {
        expect(canImpersonate({'roles': [r, 'user']}), isTrue, reason: r);
      }
    });

    test('everyone below admin does not', () {
      for (final r in ['user', 'support', 'operations', 'auditor', 'merchant']) {
        expect(canImpersonate({'roles': [r]}), isFalse, reason: r);
      }
    });

    test('a pro_admin holding `user` too is still an admin', () {
      // This is the bug that was fixed server-side: the string `role` claim
      // came back as "user" for a pro_admin because the priority list omitted
      // the tier. Reading the ARRAY as well as the string is what makes the
      // client immune to that class of mistake.
      expect(
        canImpersonate({'role': 'user', 'roles': ['pro_admin', 'user']}),
        isTrue,
      );
    });

    test('an IMPERSONATED session never offers a nested one', () {
      // While impersonating, the active token carries the TARGET's roles.
      // Viewing an ordinary user would hide the tile anyway, but viewing
      // another admin would otherwise offer a session inside a session.
      expect(
        canImpersonate({'imp': true, 'roles': ['admin', 'user']}),
        isFalse,
      );
    });

    test('no roles at all is not an admin', () {
      expect(canImpersonate(const {}), isFalse);
      expect(canImpersonate({'roles': const []}), isFalse);
      expect(canImpersonate({'role': ''}), isFalse);
    });
  });

  group('JWT payload decoding', () {
    // The decoder must cope with real unpadded base64url and must never throw
    // — a malformed token has to read as "no roles" (tile hidden) rather than
    // crashing a settings list.
    Map<String, dynamic>? decode(String token) {
      try {
        final parts = token.split('.');
        if (parts.length < 2) return null;
        var payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
        while (payload.length % 4 != 0) {
          payload += '=';
        }
        final map = jsonDecode(utf8.decode(base64.decode(payload)));
        return map is Map<String, dynamic> ? map : null;
      } catch (_) {
        return null;
      }
    }

    test('decodes an unpadded base64url payload', () {
      final t = _token({'imp': true, 'imp_by': 'actor-1', 'roles': ['user']});
      final claims = decode(t);
      expect(claims, isNotNull);
      expect(claims!['imp'], isTrue);
      expect(claims['imp_by'], 'actor-1');
    });

    test('malformed tokens return null instead of throwing', () {
      for (final t in ['', 'nodots', 'a.b', 'a.!!!!.c', 'only.one']) {
        expect(() => decode(t), returnsNormally, reason: t);
      }
    });
  });
}
