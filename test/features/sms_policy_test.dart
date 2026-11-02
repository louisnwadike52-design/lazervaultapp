import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SMS gating.
///
/// The platform has no working SMS provider. The failure this prevents is the
/// one we shipped: an OTP step SHOWN mid-signup with a "skip for now" link,
/// asking a brand-new user for a code that will never arrive and leaving them
/// to work out that skipping is correct — at the exact moment they are
/// deciding whether to trust us with money.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // FeatureFlags caches its SharedPreferences instance (init() is `??=`), so
  // the mock store must be installed ONCE, before the first init. Calling
  // setMockInitialValues again later creates a NEW instance that FeatureFlags
  // is not holding, and the writes then land somewhere it never reads — which
  // is exactly how the first version of this test failed.
  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    prefs = await SharedPreferences.getInstance();
  });

  setUp(() async {
    for (final k in [
      FeatureFlags.smsProviderActiveKey,
      FeatureFlags.smsOtpEnabledKey,
      FeatureFlags.bvnPhoneNoticeEnabledKey,
    ]) {
      await prefs.remove(k);
    }
  });

  Future<void> withSettings(Map<String, Object> values) async {
    for (final e in values.entries) {
      await prefs.setBool(e.key, e.value as bool);
    }
  }

  group('defaults, before any admin snapshot resolves', () {
    test('SMS is assumed unavailable', () async {
      await withSettings({});
      expect(FeatureFlags.smsProviderActive, isFalse);
      expect(SmsPolicy.available, isFalse,
          reason: 'the safe direction: showing an OTP screen that cannot '
              'work is worse than skipping one that could have');
      expect(SmsPolicy.showSignupOtpStep, isFalse);
      expect(SmsPolicy.showLoginOtpStep, isFalse);
      expect(SmsPolicy.canUseSmsTwoFactor, isFalse);
      expect(SmsPolicy.canRecoverBySms, isFalse);
    });

    test('the BVN notice defaults ON while SMS is off', () async {
      await withSettings({});
      expect(SmsPolicy.showBvnPhoneNotice, isTrue,
          reason: 'the number reaches our KYC partners unverified, so a '
              'mismatch surfaces days later as a failed verification');
    });
  });

  group('when an operator marks the provider active', () {
    test('every OTP surface returns without a release', () async {
      await withSettings({'sms_provider_active': true});
      expect(SmsPolicy.available, isTrue);
      expect(SmsPolicy.showSignupOtpStep, isTrue);
      expect(SmsPolicy.showLoginOtpStep, isTrue);
      expect(SmsPolicy.canUseSmsTwoFactor, isTrue);
      expect(SmsPolicy.canRecoverBySms, isTrue);
    });

    test('the BVN notice defaults away once we can verify the number', () async {
      await withSettings({'sms_provider_active': true});
      expect(SmsPolicy.showBvnPhoneNotice, isFalse);
    });
  });

  group('the switches are independent where that matters', () {
    test('OTP can stay off while a provider is configured but untrusted',
        () async {
      await withSettings({
        'sms_provider_active': true,
        'sms_otp_enabled': false,
      });
      expect(SmsPolicy.available, isFalse,
          reason: 'a configured provider is not the same as one cleared for '
              'production traffic');
      expect(SmsPolicy.showSignupOtpStep, isFalse);
    });

    test('the BVN notice can be forced on regardless of SMS', () async {
      await withSettings({
        'sms_provider_active': true,
        'bvn_phone_notice_enabled': true,
      });
      expect(SmsPolicy.available, isTrue);
      expect(SmsPolicy.showBvnPhoneNotice, isTrue,
          reason: 'the BVN match matters to KYC whether or not we can verify '
              'the number ourselves');
    });

    test('the BVN notice can be forced off while SMS is down', () async {
      await withSettings({
        'sms_provider_active': false,
        'bvn_phone_notice_enabled': false,
      });
      expect(SmsPolicy.showBvnPhoneNotice, isFalse);
    });
  });

  test('every SMS surface agrees — they must never diverge', () async {
    // A login that demands a code the signup never set up is worse than
    // either behaviour alone. All four read one policy for exactly this
    // reason.
    for (final active in [true, false]) {
      await withSettings({'sms_provider_active': active});
      final surfaces = [
        SmsPolicy.showSignupOtpStep,
        SmsPolicy.showLoginOtpStep,
        SmsPolicy.canUseSmsTwoFactor,
        SmsPolicy.canRecoverBySms,
      ];
      expect(surfaces.toSet().length, 1,
          reason: 'with provider active=$active the surfaces disagreed: '
              '$surfaces');
    }
  });

  test('there is always a reason to show when SMS is blocked', () {
    expect(SmsPolicy.unavailableReason, isNotEmpty);
    // Naming the vendor invites support questions we do not want, and the
    // user cannot act on it either way.
    expect(SmsPolicy.unavailableReason.toLowerCase(), isNot(contains('twilio')));
    expect(SmsPolicy.unavailableReason.toLowerCase(),
        isNot(contains('suspended')));
  });
}
