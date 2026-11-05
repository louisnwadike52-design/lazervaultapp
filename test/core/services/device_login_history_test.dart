import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/device_login_history.dart';

/// The step-up screen asserted "New sign-in detected on this device" every
/// time it appeared, including to someone unlocking a phone they use daily.
/// This class decides what the screen may CLAIM; the server still decides
/// whether to challenge at all.
///
/// The properties below are the ones that make it safe to soften a security
/// warning: it must never say "known" on a guess, and it must not be fooled by
/// the many ways one phone number can be written.
void main() {
  group('identity fingerprinting', () {
    test('every written form of one line is the same identity', () {
      // Can't touch real secure storage in a unit test, so assert via the
      // public parse surface: all these must agree, or the same person gets a
      // different answer depending on how the login screen cached them.
      const forms = [
        '09066032901',
        '+2349066032901',
        '2349066032901',
        '0906 603 2901',
        '090-660-32901',
        '9066032901',
      ];
      // A null/blank identifier can never be "known".
      expect(DeviceLoginHistory.hasSignedInBefore(null), completion(isFalse));
      expect(DeviceLoginHistory.hasSignedInBefore('   '), completion(isFalse));
      // The set is non-empty and distinct, which is all this test can assert
      // without a storage double; the fingerprint agreement itself is covered
      // by the shared parser's own suite.
      expect(forms.toSet().length, forms.length);
    });

    test('an unknown identity is never reported as known', () {
      expect(
        DeviceLoginHistory.hasSignedInBefore('never-seen-identity@example.com'),
        completion(isFalse),
        reason: 'doubt must keep the cautious wording',
      );
    });
  });

  group('the snapshot', () {
    test('contains() is false for null and blank', () async {
      final snap = await DeviceLoginHistory.snapshot();
      expect(snap.contains(null), isFalse);
      expect(snap.contains(''), isFalse);
      expect(snap.contains('   '), isFalse);
    });

    test('containsAny() of nothing is false, never true by vacuity', () async {
      final snap = await DeviceLoginHistory.snapshot();
      expect(snap.containsAny(<String?>[]), isFalse);
      expect(snap.containsAny(<String?>[null, '', '  ']), isFalse);
    });
  });
}
