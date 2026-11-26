import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:lazervault/src/features/authentication/domain/signup_steps.dart';

/// SMS AVAILABILITY IS PER ACCOUNT, AND THE APP MUST NOT DECIDE IT ALONE.
///
/// The provider accepts and bills OTP traffic it does not deliver, so the
/// master switch is off platform-wide while an operator whitelist keeps SMS for
/// named testers. That list lives ONLY on the server — it is personal contact
/// detail and the app's settings snapshot is an unauthenticated poll every
/// installation downloads.
///
/// Shipping only the server-side list left it correct and UNREACHABLE: the app
/// decides whether a phone-OTP step exists at all, it decided from the global
/// flag, and so the step was removed for everyone including the testers. These
/// tests pin the fix — the server states the answer per account, and the app
/// honours it in the permissive direction only.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    // debugResetForTest, NOT init(): init is `_prefs ??=`, so after the first
    // test it no-ops and the getters keep reading the previous store while the
    // writes below land in the new one. That mismatch is what made the first
    // run of this file fail on four tests that were asserting correct code.
    await FeatureFlags.debugResetForTest();
  });

  Future<void> setFlags({bool? providerActive, bool? perUser}) async {
    final prefs = await SharedPreferences.getInstance();
    if (providerActive != null) {
      await prefs.setBool(FeatureFlags.smsProviderActiveKey, providerActive);
    }
    if (perUser != null) {
      await prefs.setBool(FeatureFlags.smsAvailableForUserKey, perUser);
    }
    // No re-init: _prefs is bound to this same singleton, so the writes above
    // are already visible to every getter.
  }

  group('precedence mirrors the server: global first, per-user widens only', () {
    test('provider off and no per-user answer: unavailable', () async {
      await setFlags(providerActive: false);
      expect(SmsPolicy.available, isFalse);
    });

    // THE WHOLE POINT. A whitelisted tester, with the platform switch off.
    test('provider off but the server says YES for this account', () async {
      await setFlags(providerActive: false, perUser: true);
      expect(SmsPolicy.available, isTrue,
          reason: 'the server resolved the whitelist for this account; '
              'ignoring it is what made the whitelist unreachable');
    });

    test('provider ON overrides a stale per-user false', () async {
      await setFlags(providerActive: true, perUser: false);
      expect(SmsPolicy.available, isTrue,
          reason: 'a stale per-account false must never hide a channel that '
              'works for everyone — global-on wins');
    });

    test('provider on, per-user yes: available', () async {
      await setFlags(providerActive: true, perUser: true);
      expect(SmsPolicy.available, isTrue);
    });
  });

  test('an absent per-user answer is NOT KNOWN, not "unavailable"', () async {
    await setFlags(providerActive: true);
    expect(FeatureFlags.smsAvailableForUser, isNull,
        reason: 'a fresh install at the login screen has no account to answer '
            'for; it must fall back to the platform-wide flag');
    expect(SmsPolicy.available, isTrue);
  });

  // The failure this was built to fix: the signup/resumption journey DROPS the
  // phone-OTP step from the global flag, so a whitelisted tester never reached
  // a screen that would send a code.
  test('a whitelisted account gets the phone-OTP step back', () async {
    await setFlags(providerActive: false);
    expect(activeSignupSteps().contains(SignupStep.phoneOtp), isFalse,
        reason: 'with no per-account answer the step is correctly removed');

    await setFlags(providerActive: false, perUser: true);
    expect(activeSignupSteps().contains(SignupStep.phoneOtp), isTrue,
        reason: 'THE BUG: the step stayed removed for a whitelisted tester, so '
            'the server-side whitelist could never be exercised from the app');
  });

  _raceTests();

  test('availablePlatformWide ignores the per-account override', () async {
    await setFlags(providerActive: false, perUser: true);
    expect(SmsPolicy.available, isTrue);
    expect(SmsPolicy.availablePlatformWide, isFalse,
        reason: 'copy describing the PLATFORM must not be coloured by who is '
            'looking at it');
  });

  // Cross-user safety. One holder's answer must never judge the next.
  test('the per-user key is purged on a user switch', () {
    final src = _readSource('lib/core/services/user_switch_purge.dart');
    expect(src.contains('smsAvailableForUserKey'), isTrue,
        reason: 'left behind, a tester handing their phone to a colleague '
            'grants SMS the server refuses — and a cached false from an '
            'unlisted predecessor HIDES the step from a listed tester, which '
            'is the original bug wearing a different hat');
  });

  // The flag must be recorded where no path can skip it.
  test('it is cached in the one mapper every auth response passes', () {
    final src = _readSource(
        'lib/src/features/authentication/data/models/user_model.dart');
    expect(src.contains('rememberSmsAvailableForUser(user.smsAvailable)'), isTrue,
        reason: 'recording it at the call sites instead is a step one of them '
            'forgets, and that one is a resumption path');
  });
}

/// Reads a source file relative to the package root, the same shape the other
/// source-asserting guards in this suite use.
String _readSource(String path) => File(path).readAsStringSync();

/// THE LOGIN-TIME RACE, which is the whole reason the memo exists.
///
/// The post-login router resolves its route synchronously the moment the auth
/// response is mapped, while the SharedPreferences write is still in flight.
/// Reading only the store hands it the PREVIOUS session's answer on the very
/// login that carried the new one — the same one-launch lag that stopped
/// anyone being prompted for phone verification after the operator turned
/// sms_provider_active on.
void _raceTests() {
  group('the answer is readable in the SAME turn it arrives', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await FeatureFlags.debugResetForTest();
    });

    test('no await: the value is visible immediately', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(FeatureFlags.smsProviderActiveKey, false);

      // Deliberately NOT awaited — this is exactly what the mapper does.
      // ignore: unawaited_futures
      FeatureFlags.rememberSmsAvailableForUser(true);

      expect(FeatureFlags.smsAvailableForUser, isTrue,
          reason: 'the router reads this synchronously; if only the store were '
              'consulted it would still say null here and the phone step would '
              'be skipped on the login that enabled it');
      expect(SmsPolicy.available, isTrue);
    });

    // A USER SWITCH MUST CLEAR BOTH HALVES, and neither alone is enough.
    // The memo lives in the process and outlives a store wipe; the store
    // outlives a process-local clear. Dropping one and not the other leaves
    // the previous holder's answer in force for the next person on the device.
    test('clearing the memo alone is NOT enough', () async {
      await FeatureFlags.rememberSmsAvailableForUser(true);
      FeatureFlags.forgetSmsAvailableForUser();
      expect(FeatureFlags.smsAvailableForUser, isTrue,
          reason: 'the getter still falls back to the stored value — this is '
              'why purgeStaleUserCache removes the key as well');
    });

    test('clearing both halves forgets the account', () async {
      await FeatureFlags.rememberSmsAvailableForUser(true);
      FeatureFlags.forgetSmsAvailableForUser();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(FeatureFlags.smsAvailableForUserKey);
      expect(FeatureFlags.smsAvailableForUser, isNull);
    });
  });
}
