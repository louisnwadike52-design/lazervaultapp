import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE CUSTOMER WHO MOST NEEDS SUPPORT IS THE ONE WHO CANNOT SIGN IN.
///
/// Every authenticated support route answers 401 to them. These pin that the
/// one route which does not is present on the screens people actually get
/// stranded on, and that it never quietly carries a stale token.
void main() {
  String read(String p) => File(p).readAsStringSync();

  test('the pre-auth call sends NO Authorization header', () {
    final api = read('lib/src/features/support/data/support_api.dart');
    final at = api.indexOf('createPreAuthTicket');
    expect(at, greaterThan(-1));
    final body = api.substring(at, at + 1600);
    expect(body.contains("headers: const {'Content-Type': 'application/json'}"),
        isTrue,
        reason: 'attaching a stale token turns a filed ticket into a 401');
    expect(body.contains('await _headers()'), isFalse,
        reason: '_headers() attaches whatever token is lying in storage');
  });

  test('it is offered on the passcode lock', () {
    final s = read('lib/src/features/authentication/presentation/widgets/'
        'passcode_sign_in.dart');
    expect(s.contains('LockedOutSupport.open'), isTrue);
    expect(s.contains("stuckOn: 'Passcode screen'"), isTrue,
        reason: 'the ticket must name the screen; the customer cannot be '
            'asked, because they cannot get in to answer');
  });

  test('it is offered on both resumption states', () {
    for (final f in [
      'lib/src/features/authentication/presentation/views/'
          'phone_verification_screen.dart',
      'lib/src/features/authentication/presentation/views/'
          'email_verification_screen.dart',
    ]) {
      expect(read(f).contains('LockedOutSupport.open'), isTrue, reason: f);
    }
  });

  test('a failure never promises a reply we cannot make', () {
    final s = read('lib/src/features/support/presentation/'
        'locked_out_support.dart');
    // The one thing that must not happen is telling somebody we have their
    // request when it never left the phone. Anchor inside _send() — there is
    // an earlier `} catch (_) {` in the cached-email reader, and matching that
    // one asserted nothing about the handler this test is about.
    final send = s.indexOf('Future<void> _send() async {');
    expect(send, greaterThan(-1), reason: 'the submit handler was renamed');
    final at = s.indexOf('} catch (_) {', send);
    expect(at, greaterThan(send), reason: 'no catch-all in _send()');
    // Strip comment lines: the handler's own comment QUOTES the phrase it
    // forbids, so a raw substring search would fail on the explanation
    // rather than on the copy.
    final tail = s
        .substring(at, at + 400)
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
    expect(tail.contains('could not send'), isTrue);
    expect(tail.contains('We have your request'), isFalse);
    expect(tail.contains("we'll be in touch"), isFalse);
  });
}
