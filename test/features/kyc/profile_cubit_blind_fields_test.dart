import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/domain/entities/postal_address.dart';

/// FIELDS ProfileCubit CAN NEVER KNOW.
///
/// `UpdateUserProfile` and `GetUserProfile` both answer with the COMMON
/// proto's `User`, and that message carries no `date_of_birth`,
/// `two_factor_enabled`, `two_factor_method`, `kyc_tier`, `kyc_status`,
/// `identity_verified`, `signup_status`, `has_passcode` … at all. So
/// `ProfileLoaded.user` reports null/0/false for every one of them, for every
/// holder — not stale, never populated.
///
/// Two screens read them from there and lied:
///
///   * the KYC "Update your information" screen showed "Date of birth — Not
///     set" to holders whose date was correctly on file, on the one screen
///     whose job is to show what a registry check compares — and its own copy
///     calls an empty date "a guaranteed mismatch", so it told a
///     correctly-registered customer their verification would fail;
///   * Settings → Security showed 2FA as "Off" to every holder who had it
///     enrolled.
///
/// Both now read the AUTH profile, which is sourced from `fromAuthProto` and
/// is also the copy every registry check is actually run against.
void main() {
  group('the screens read the auth profile, not ProfileCubit', () {
    test('the KYC details screen takes the date of birth from auth', () {
      final src = File(
              'lib/src/features/kyc/presentation/views/kyc_update_details_screen.dart')
          .readAsStringSync();
      expect(src.contains("state.user.dateOfBirth"), isFalse,
          reason: 'ProfileCubit cannot carry a date of birth — reading it '
              'there renders "Not set" for everybody');
      expect(src.contains('AuthenticationCubit>().currentProfile'), isTrue);
      expect(src.contains('humanDobFromIso'), isTrue,
          reason: 'ISO reads as two different days depending on the reader; '
              'see core/utils/dob_display.dart');
    });

    test('the Settings security tile takes 2FA from auth', () {
      final src = File(
              'lib/src/features/settings/presentation/view/settings_screen.dart')
          .readAsStringSync();
      expect(src.contains('user?.twoFactorEnabled'), isFalse,
          reason: 'that `user` is ProfileCubit\'s, which never has the flag');
      expect(src.contains('authUser2fa'), isTrue);
      expect(src.contains('BlocBuilder<AuthenticationCubit, AuthenticationState>'),
          isTrue,
          reason: 'TwoFactorSettingsScreen finishes with refreshProfile(); '
              'without listening, the tile keeps the pre-change state');
    });
  });

  group('User.identityVerified', () {
    final base = User(
      id: 'u1',
      firstName: 'Ada',
      lastName: 'Okafor',
      email: 'a@example.com',
      verified: false,
      isEmailVerified: false,
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
      address: PostalAddress.empty,
    );

    test('defaults to false, so the server stays the authority', () {
      expect(base.identityVerified, isFalse,
          reason: 'an unknown flag must not lock a date of birth the holder '
              'is still allowed to correct');
    });

    test('survives copyWith', () {
      expect(base.copyWith(identityVerified: true).identityVerified, isTrue);
      expect(base.copyWith(firstName: 'Chidi').identityVerified, isFalse,
          reason: 'an unrelated copyWith must not flip it');
    });

    test('is part of equality, or an emit comparing equal is dropped', () {
      expect(base == base.copyWith(identityVerified: true), isFalse);
    });

    test('is read with has_x so an older gateway is not read as false-true',
        () {
      final src =
          File('lib/src/features/authentication/data/models/user_model.dart')
              .readAsStringSync();
      expect(src.contains('hasIdentityVerified()'), isTrue);
    });
  });
}
