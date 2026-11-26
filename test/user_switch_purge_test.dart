import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/user_switch_purge.dart';

/// A stale cached identifier is not a cosmetic bug: the returning-user lock
/// screen submits `stored_phone` verbatim, so one left behind by a user switch
/// spends failed-login attempts against the PREVIOUS user and locks them out of
/// their own account. That happened on prod. These tests pin the two halves
/// that prevent it — detecting the switch, and knowing which keys to drop.
void main() {
  group('isUserSwitch', () {
    const newId = 'user-b';
    const newEmail = 'b@example.com';

    test('a different user id is a switch', () {
      expect(
        isUserSwitch(
          previousUserId: 'user-a',
          previousEmail: null,
          newUserId: newId,
          newEmail: newEmail,
        ),
        isTrue,
      );
    });

    test('a different email is a switch', () {
      expect(
        isUserSwitch(
          previousUserId: null,
          previousEmail: 'a@example.com',
          newUserId: newId,
          newEmail: newEmail,
        ),
        isTrue,
      );
    });

    test('the same user re-logging in is NOT a switch', () {
      // This is the "remember my email for the passcode screen" UX. Purging
      // here would log the user out of their own conveniences on every launch.
      expect(
        isUserSwitch(
          previousUserId: newId,
          previousEmail: newEmail,
          newUserId: newId,
          newEmail: newEmail,
        ),
        isFalse,
      );
    });

    test('email comparison ignores case', () {
      expect(
        isUserSwitch(
          previousUserId: null,
          previousEmail: 'B@Example.COM',
          newUserId: newId,
          newEmail: newEmail,
        ),
        isFalse,
      );
    });

    test('NO RECORD of a previous user MUST purge', () {
      // THIS TEST USED TO ASSERT THE OPPOSITE — "a first-ever sign-in on a
      // clean device is NOT a switch" — and that assumption caused a
      // production data leak on 2026-11-10.
      //
      // The intent was sound: do not pay for a purge when there is nothing to
      // purge. The flaw is that null/null does NOT mean "clean device". It is
      // ALSO what a device looks like after a logout, because logging out
      // clears stored_user_id and stored_email while leaving the SWR caches
      // (balances, active account) in place. The two are indistinguishable
      // from here.
      //
      // So the old rule let this happen: user A logs out, user B signs up on
      // the same handset, and B's dashboard renders A's balance (₦4,435.54)
      // and account number, correcting itself only on the next login.
      //
      // The trade is asymmetric and the file's own comment already says so:
      // a spurious purge costs a cache re-fetch, a missed one shows one
      // customer another's money. On a genuinely fresh install the purge is a
      // no-op over empty caches.
      expect(
        isUserSwitch(
          previousUserId: null,
          previousEmail: null,
          newUserId: newId,
          newEmail: newEmail,
        ),
        isTrue,
      );
      expect(
        isUserSwitch(
          previousUserId: '',
          previousEmail: '',
          newUserId: newId,
          newEmail: newEmail,
        ),
        isTrue,
      );
    });

    test('a phone-only account after an email account IS a switch', () {
      // The new user has no email at all. Treating "they had one, this one
      // doesn't" as the same person would skip the purge and leave the email
      // user's data in place — so this must err toward purging.
      expect(
        isUserSwitch(
          previousUserId: null,
          previousEmail: 'a@example.com',
          newUserId: newId,
          newEmail: '',
        ),
        isTrue,
      );
    });
  });

  group('kPerUserStorageKeys', () {
    test('carries the login identifiers, not just display state', () {
      // stored_phone is the one that locked a real account out. The others are
      // read by the same lock-screen path and must not outlive their user
      // either.
      expect(kPerUserStorageKeys, contains('stored_phone'));
      expect(kPerUserStorageKeys, contains('stored_email'));
      expect(kPerUserStorageKeys, contains('user_email'));
      expect(kPerUserStorageKeys, contains('preferred_login_method'));
    });

    test('still carries the credential and display state', () {
      expect(kPerUserStorageKeys, contains('user_passcode'));
      expect(kPerUserStorageKeys, contains('user_first_name'));
      expect(kPerUserStorageKeys, contains('user_last_name'));
      expect(kPerUserStorageKeys, contains('user_avatar_url'));
    });

    test('carries every biometric preference, including how it fires', () {
      // Enablement AND trigger mode are both the previous user's choice. A new
      // account inheriting "ask automatically" would meet a Face ID sheet it
      // never asked for, before enabling any biometric at all.
      expect(kPerUserStorageKeys, contains('face_login_enabled'));
      expect(kPerUserStorageKeys, contains('fingerprint_login_enabled'));
      expect(kPerUserStorageKeys, contains('voice_login_enabled'));
      expect(kPerUserStorageKeys, contains('biometric_auto_prompt'));
    });

    test('does not drop the device id', () {
      // device_id identifies the HARDWARE, not the person. Clearing it would
      // rotate the device UUID on every user switch, so the next login looks
      // like a brand-new device and forces an OTP step-up every time.
      expect(kPerUserStorageKeys, isNot(contains('device_id')));
    });
  });
}
