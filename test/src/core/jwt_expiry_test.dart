import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/access_token_shape.dart';

// isUsableJwt checks SHAPE only, so an EXPIRED token passed it and was sent.
// The gateway answered "invalid token: ... token is expired" and the app, which
// retries nothing on Unauthenticated, left the dashboard card spinning. 6 such
// rejections on prod 2026-11-08 alongside 80 of "token not provided".

String _jwt(Map<String, dynamic> payload) {
  String seg(Object o) =>
      base64Url.encode(utf8.encode(jsonEncode(o))).replaceAll('=', '');
  return '${seg({'alg': 'HS256', 'typ': 'JWT'})}.${seg(payload)}.sig';
}

int _epoch(Duration fromNow) =>
    DateTime.now().toUtc().add(fromNow).millisecondsSinceEpoch ~/ 1000;

void main() {
  group('jwtExpiry', () {
    test('reads the exp claim', () {
      final t = _jwt({'exp': _epoch(const Duration(hours: 1))});
      final exp = jwtExpiry(t);
      expect(exp, isNotNull);
      expect(exp!.isAfter(DateTime.now().toUtc()), isTrue);
    });

    test('is null for a non-JWT, so nothing is inferred from junk', () {
      for (final bad in [null, '', 'abc', 'a.b', 'a..c']) {
        expect(jwtExpiry(bad), isNull, reason: 'input: $bad');
      }
    });

    test('is null when exp is absent or not a number', () {
      expect(jwtExpiry(_jwt({'sub': 'x'})), isNull);
      expect(jwtExpiry(_jwt({'exp': 'soon'})), isNull);
    });

    test('survives a payload that is not base64 or not JSON', () {
      expect(jwtExpiry('header.!!!notbase64!!!.sig'), isNull);
      expect(jwtExpiry('header.${base64Url.encode(utf8.encode("plain"))}.sig'),
          isNull);
    });

    test('handles base64url payloads without padding', () {
      // JWTs are unpadded; a decoder that does not normalise throws here.
      final t = _jwt({'exp': _epoch(const Duration(hours: 2)), 'pad': 'aaa'});
      expect(t.split('.')[1].contains('='), isFalse);
      expect(jwtExpiry(t), isNotNull);
    });
  });

  group('isJwtExpired', () {
    test('a token well in the future is not expired', () {
      expect(isJwtExpired(_jwt({'exp': _epoch(const Duration(hours: 1))})),
          isFalse);
    });

    test('a token already past its exp is expired', () {
      expect(isJwtExpired(_jwt({'exp': _epoch(const Duration(hours: -1))})),
          isTrue);
    });

    test('the leeway catches a token about to expire mid-flight', () {
      // Valid when checked, expired by the time the server reads it — a real
      // outcome on a slow first call after a cold start.
      final t = _jwt({'exp': _epoch(const Duration(seconds: 5))});
      expect(isJwtExpired(t), isTrue, reason: 'default 30s leeway');
      expect(isJwtExpired(t, leeway: Duration.zero), isFalse);
    });

    test('an UNREADABLE expiry is treated as NOT expired', () {
      // Refusing to send a token we merely failed to parse would be worse than
      // letting the server judge it.
      expect(isJwtExpired('header.!!!.sig'), isFalse);
      expect(isJwtExpired(_jwt({'sub': 'no-exp'})), isFalse);
    });

    test('a non-JWT is not reported as expired — it is reported by shape', () {
      expect(isJwtExpired(null), isFalse);
      expect(isUsableJwt(null), isFalse);
    });
  });

  group('the two checks together decide whether to send', () {
    test('shaped-and-fresh is the only sendable combination', () {
      final fresh = _jwt({'exp': _epoch(const Duration(hours: 1))});
      final stale = _jwt({'exp': _epoch(const Duration(hours: -1))});
      expect(isUsableJwt(fresh) && !isJwtExpired(fresh), isTrue);
      // Shape alone used to be the whole test, which is how a stale token
      // reached the gateway.
      expect(isUsableJwt(stale), isTrue);
      expect(isUsableJwt(stale) && !isJwtExpired(stale), isFalse);
    });
  });
}
