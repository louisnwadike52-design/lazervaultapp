import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/user_switch_purge.dart';

/// TWO PEOPLE, ONE HANDSET.
///
/// The expensive failures in this area are not crashes — they are one user
/// being shown another's state. Production already saw a brand-new signup open
/// on the previous owner's ₦4,435.54 (2026-11-10), which is why
/// [isUserSwitch] purges unless it can POSITIVELY identify the same person.
///
/// These pin the identity rule and the key list, both of which are easy to
/// weaken by accident.
void main() {
  group('isUserSwitch — purge unless provably the same person', () {
    test('no previous user recorded is NOT evidence of the same user', () {
      expect(
        isUserSwitch(
            previousUserId: null,
            previousEmail: null,
            newUserId: 'u2',
            newEmail: 'b@x.com'),
        isTrue,
        reason: 'logout clears the stored id/email while leaving caches '
            'behind — this exact gap showed one user another\'s balance',
      );
    });

    test('same id is the same person', () {
      expect(
        isUserSwitch(
            previousUserId: 'u1',
            previousEmail: 'a@x.com',
            newUserId: 'u1',
            newEmail: 'a@x.com'),
        isFalse,
      );
    });

    test('same email is enough when the id is unknown', () {
      expect(
        isUserSwitch(
            previousUserId: null,
            previousEmail: 'a@x.com',
            newUserId: '',
            newEmail: 'A@X.com'),
        isFalse,
        reason: 'case must not make one person look like two',
      );
    });

    test('a previous email against an empty new one IS a switch', () {
      expect(
        isUserSwitch(
            previousUserId: null,
            previousEmail: 'a@x.com',
            newUserId: 'u2',
            newEmail: ''),
        isTrue,
        reason: 'phone-only accounts have no email; erring toward purging '
            'costs a re-fetch, missing it shows somebody else\'s money',
      );
    });

    test('different ids is a switch', () {
      expect(
        isUserSwitch(
            previousUserId: 'u1',
            previousEmail: 'a@x.com',
            newUserId: 'u2',
            newEmail: 'b@x.com'),
        isTrue,
      );
    });
  });

  group('the purge covers the whole credential shape', () {
    test('both halves are purged, not just the passcode one', () {
      for (final k in const ['has_passcode', 'has_password']) {
        expect(kPerUserStorageKeys, contains(k),
            reason: '$k describes an ACCOUNT SHAPE. phone_passcode_cubit never '
                'writes has_password, so leaving it behind let A\'s "true" '
                'describe B — settings_screen reads it on its own and would '
                'offer B password controls for an account with no password.');
      }
    });

    test('identity, routing and draft keys are all covered', () {
      for (final k in const [
        'stored_phone',
        'stored_email',
        'login_method',
        'preferred_login_method',
        'user_first_name',
        'user_last_name',
        'user_avatar_url',
        'login_facts_v1',
        'signup_draft',
        'has_incomplete_signup',
        'current_signup_step',
      ]) {
        expect(kPerUserStorageKeys, contains(k), reason: '$k is per-user');
      }
    });

    test('user_id is DELIBERATELY not purged', () {
      expect(kPerUserStorageKeys, isNot(contains('user_id')),
          reason: 'the caller owns identity assignment — purging the id here '
              'could leave the app authenticated as nobody mid-login, which '
              'the file states explicitly. If this ever moves into the list, '
              'that reasoning has to be revisited rather than assumed stale.');
    });
  });

  group('a reset routes on the ACCOUNT, not the device', () {
    test('the password screen checks the cache describes this account', () {
      final src =
          File('lib/src/features/widgets/create_new_password.dart')
              .readAsStringSync();
      expect(src.contains('_cacheDescribesThisAccount('), isTrue,
          reason: 'preferred_login_method belongs to whoever last logged in '
              'here. Read unconditionally, it sent a password user to the '
              'passcode lock on a device cached for someone else.');
    });

    test('the passcode lock bounces a reset for a different account', () {
      final src = File(
              'lib/src/features/authentication/presentation/widgets/passcode_sign_in.dart')
          .readAsStringSync();
      expect(src.contains('_cachedIdentityMatches('), isTrue,
          reason: 'otherwise B finishes a reset and is shown A\'s name and '
              'avatar over a pad that will never accept B\'s passcode');
    });
  });
}
