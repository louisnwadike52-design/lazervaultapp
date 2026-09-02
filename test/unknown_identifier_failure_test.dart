import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';

/// Observed on prod: a user typed "onhapraiz@gmail.com" for
/// "onahpraiz@gmail.com" — two transposed letters — entered their CORRECT
/// passcode, and was told "invalid credentials" on the passcode screen. They
/// reported it as a passcode bug, because nothing on screen pointed at the
/// email they had typed two screens earlier.
///
/// auth-service already separates the two failures. These pin that the client
/// keeps them apart, and in particular that a genuinely wrong passcode is NOT
/// misread as a bad identifier — doing so would throw the user back to retype
/// an email that was right all along.
void main() {
  group('isUnknownIdentifierFailure', () {
    test('nobody matched the identifier', () {
      // auth_phone_passcode.go returns exactly this when resolveLoginUser
      // finds no user.
      expect(isUnknownIdentifierFailure('invalid credentials'), isTrue);
    });

    test('is case-insensitive', () {
      expect(isUnknownIdentifierFailure('Invalid Credentials'), isTrue);
      expect(isUnknownIdentifierFailure('INVALID CREDENTIALS'), isTrue);
    });

    test('a WRONG PASSCODE is not an unknown identifier', () {
      // The regression that would hurt most: sending someone back to retype a
      // perfectly good email because they fat-fingered the passcode.
      expect(
        isUnknownIdentifierFailure(
            'Incorrect passcode. 2 attempts remaining before your account is '
            'temporarily locked.'),
        isFalse,
      );
      expect(
        isUnknownIdentifierFailure(
            'Incorrect passcode. 1 attempt remaining before your account is '
            'temporarily locked.'),
        isFalse,
      );
    });

    test('a lockout is not an unknown identifier', () {
      expect(
        isUnknownIdentifierFailure(
            'Too many failed attempts. Your account is temporarily locked. '
            'Please try again in about 30 minutes.'),
        isFalse,
      );
    });

    test('an account without a passcode is not an unknown identifier', () {
      // This one has its own branch — the account EXISTS, it just cannot be
      // signed into this way, so the user is steered to sign up instead.
      expect(isUnknownIdentifierFailure('passcode not set for this account'),
          isFalse);
    });

    test('network and server errors are not unknown identifiers', () {
      expect(isUnknownIdentifierFailure('Network error'), isFalse);
      expect(isUnknownIdentifierFailure('check your connection'), isFalse);
      expect(isUnknownIdentifierFailure(''), isFalse);
    });
  });
}
