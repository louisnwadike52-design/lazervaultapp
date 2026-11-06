import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A mistyped email during signup was a dead end.
///
/// The email step CREATES the account and then asks for a code sent to the
/// address just entered. At the code screen — exactly where a user notices
/// the code never arrived because the address is wrong — back popped the
/// whole step, and re-submitting would have been refused as a duplicate
/// phone. The account existed, attached to an inbox they do not read, and
/// abandoning signup was the only exit.
void main() {
  late String screen;
  late String cubit;
  late String repo;

  setUpAll(() {
    screen = File(
            'lib/src/features/authentication/presentation/views/phone_email_verification_screen.dart')
        .readAsStringSync();
    cubit = File(
            'lib/src/features/authentication/cubit/phone_passcode_cubit.dart')
        .readAsStringSync();
    repo = File(
            'lib/src/features/authentication/data/repositories/auth_repository.dart')
        .readAsStringSync();
  });

  group('back from the code phase returns to the email field', () {
    test('an onBack is supplied, and only while in the code phase', () {
      expect(screen.contains('onBack: inCode'), isTrue,
          reason: 'back still pops the whole step, so the address cannot be '
              'corrected');
      expect(screen.contains('_phase = _Phase.email'), isTrue);
    });

    test('the stale code is cleared on the way back', () {
      final at = screen.indexOf('onBack: inCode');
      expect(screen.substring(at, at + 260).contains("_code = ''"), isTrue,
          reason: 'digits typed against the OLD address must not carry over');
    });
  });

  group('submitting branches on whether the account exists', () {
    test('it tracks account creation', () {
      expect(screen.contains('_accountCreated = true'), isTrue,
          reason: 'without this a corrected address re-runs submitSignup, '
              'which the server refuses as a duplicate phone — the exact '
              'wall the user would hit');
    });

    test('an existing account takes the CHANGE path, not create', () {
      final at = screen.indexOf('if (_accountCreated) {');
      expect(at, greaterThan(-1));
      final window = screen.substring(at, at + 400);
      expect(window.contains('changeSignupEmail(email)'), isTrue);
      expect(window.contains('submitSignup(email: email)'), isTrue,
          reason: 'the create path must survive for the FIRST submission');
    });
  });

  group('the change completes back into the code phase', () {
    test('a clean result returns to the code step', () {
      expect(screen.contains('_awaitingEmailChange'), isTrue,
          reason: 'the change succeeds into PhonePasscodeInitial, which '
              'carries no payload — without a marker its completion cannot '
              'be told from any other emission');
      final at = screen.indexOf('if (_awaitingEmailChange &&');
      expect(at, greaterThan(-1));
      expect(screen.substring(at, at + 420).contains('_Phase.code'), isTrue);
    });

    test('a FAILURE does not advance, and clears the marker', () {
      expect(
        screen.contains('if (_awaitingEmailChange && state is PhonePasscodeFailure)'),
        isTrue,
        reason: 'a refused change must leave the user on the field they are '
            'editing, and must not leave the marker set for the next state',
      );
    });
  });

  test('the repository talks to the fenced server path', () {
    expect(repo.contains('RequestEmailVerificationRequest(email: email)'), isTrue,
        reason: 'the email must actually be sent — the server ignored this '
            'field for years and resent to the stored address');
    expect(cubit.contains('_authRepository.changeSignupEmail(email: email)'),
        isTrue);
  });
}
