import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/access_token_shape.dart';

/// A MALFORMED TOKEN IS WORSE THAN NO TOKEN.
///
/// A missing authorization header is an ordinary unauthenticated call the app
/// already handles quietly. A header carrying something that is NOT a JWT is
/// PARSED by the server, fails with "token contains an invalid number of
/// segments", and is rejected as malformed — louder, and surfaced to the user.
///
/// On 2026-10-20 that put a raw parse error on the dashboard during login. The
/// window is real: an OPAQUE token is briefly in play during login and step-up
/// (auth_repository's twoFactorToken), so "a non-empty value is in secure
/// storage" does not mean "a usable access token is in secure storage".
///
/// Two transports carry credentials — gRPC call options and the Dio
/// interceptor — and both ask the SAME question from the same place.
String _codeOnly(String path) {
  final f = File(path);
  if (!f.existsSync()) return '';
  final out = <String>[];
  for (final line in f.readAsLinesSync()) {
    final t = line.trimLeft();
    if (t.startsWith('//') || t.startsWith('///')) continue;
    out.add(line);
  }
  return out.join('\n');
}

const _grpc = 'lib/core/services/grpc_call_options_helper.dart';
const _http = 'lib/core/services/dio_auth_interceptor.dart';
const _rule = 'lib/core/services/access_token_shape.dart';

void main() {
  group('the rule itself', () {
    test('accepts a three-segment token', () {
      expect(isUsableJwt('aaa.bbb.ccc'), isTrue);
    });

    test('rejects what actually turns up in storage', () {
      // Each of these is a real shape: nothing written yet, a cleared value,
      // the string "null" from an unguarded interpolation, and an opaque
      // step-up token.
      for (final bad in [null, '', '   ', 'null', 'opaque-step-up-token']) {
        expect(isUsableJwt(bad), isFalse, reason: 'should reject ${bad ?? "null"}');
      }
    });

    test('rejects a token with an empty segment', () {
      // "a..b" has three segments and is still not a token.
      expect(isUsableJwt('a..b'), isFalse);
      expect(isUsableJwt('.b.c'), isFalse);
    });

    test('tolerates surrounding whitespace on a real token', () {
      expect(isUsableJwt('  aaa.bbb.ccc  '), isTrue);
    });
  });

  group('both transports ask it', () {
    test('gRPC attaches the header only for a usable token', () {
      final src = _codeOnly(_grpc);
      expect(src, isNotEmpty, reason: 'the helper moved; re-point this guard');
      expect(
        src.contains("if (isUsableJwt(accessToken)) {\n      metadata['authorization']"),
        isTrue,
        reason: 'gRPC attaches the authorization header without checking the '
            'token is a JWT',
      );
    });

    test('gRPC waits for a USABLE token, not merely a present one', () {
      final src = _codeOnly(_grpc);
      expect(src.contains('if (isUsableJwt(accessToken)) break;'), isTrue,
          reason: 'the startup wait settles for any non-empty value again, so '
              'a transient non-JWT is sent instead of waiting for the real one');
    });

    test('HTTP attaches the header only for a usable token', () {
      final src = _codeOnly(_http);
      expect(src, isNotEmpty);
      expect(src.contains('if (isUsableJwt(accessToken))'), isTrue,
          reason: 'the Dio interceptor is back to a bare non-empty check');
    });

    test('a 401 retry never invents a credential', () {
      // The race: a refresh can report success before the write lands. Setting
      // the header unconditionally then retried with the literal string
      // "Bearer null", turning a recoverable 401 into a malformed-credential
      // rejection.
      final src = _codeOnly(_http);
      expect(src.contains('if (!isUsableJwt(accessToken)) {\n            return handler.reject(err);'),
          isTrue,
          reason: 'the 401 retry sets Authorization without a usable token '
              'again');
    });
  });

  test('the rule is defined exactly once', () {
    // No duplicate functions: two copies is how the transports start
    // disagreeing about what a token is.
    var definitions = 0;
    for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      definitions += RegExp(r'^bool isUsableJwt\(', multiLine: true)
          .allMatches(_codeOnly(f.path))
          .length;
    }
    expect(definitions, 1, reason: 'expected one definition, found $definitions');
    expect(File(_rule).existsSync(), isTrue);
  });
}
