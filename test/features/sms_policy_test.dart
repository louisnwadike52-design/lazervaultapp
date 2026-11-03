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
      FeatureFlags.phoneVerificationRequired,
    ]) {
      await prefs.remove(k);
    }
  });

  Future<void> withSettings(Map<String, Object> values) async {
    for (final e in values.entries) {
      await prefs.setBool(e.key, e.value as bool);
    }
  }

  group('the admin snapshot actually reaches SmsPolicy', () {
    // THE FAILURE THIS PINS. These three keys governed the entire phone-OTP
    // flow and were reachable by nobody: absent from the admin-gateway write
    // allowlist AND from applyRemoteSnapshot's ingest list. An operator could
    // not set them, and had they been set, the app would have discarded them.
    // They were pinned at their compiled defaults, so restoring phone OTP
    // after an SMS provider came back needed a RELEASE.
    //
    // Writing the setting and asserting the POLICY changes is the only test
    // that covers the whole path; asserting the getter alone would still have
    // passed while the snapshot dropped the key on the floor.
    test('flipping sms_provider_active turns the OTP flow back on', () async {
      await withSettings({});
      expect(SmsPolicy.available, isFalse, reason: 'baseline: no provider');

      // Values arrive from the settings endpoint as STRINGS, which is the
      // real contract — passing a bool here would test a signature that does
      // not exist and miss a parsing bug entirely.
      await FeatureFlags.applyRemoteSnapshot(
        <String, String>{FeatureFlags.smsProviderActiveKey: 'true'},
      );

      expect(FeatureFlags.smsProviderActive, isTrue,
          reason: 'the snapshot must INGEST this key — if it is missing from '
              'applyRemoteSnapshot the admin write is silently dropped');
      expect(SmsPolicy.available, isTrue);
      expect(SmsPolicy.showSignupOtpStep, isTrue);
      expect(SmsPolicy.showLoginOtpStep, isTrue);
      expect(SmsPolicy.canUseSmsTwoFactor, isTrue);
      // The BVN notice is NOT part of this: it defaults on regardless, because
      // Mono requires a BVN-linked number whether or not we send an OTP.
      expect(SmsPolicy.showBvnPhoneNotice, isTrue);
    });

    test('the two derived keys can still be overridden independently',
        () async {
      await withSettings({});
      await FeatureFlags.applyRemoteSnapshot(<String, String>{
        FeatureFlags.smsProviderActiveKey: 'true',
        // A provider exists but the operator wants OTP off anyway — e.g.
        // keeping it dark while testing deliverability.
        FeatureFlags.smsOtpEnabledKey: 'false',
      });
      expect(FeatureFlags.smsProviderActive, isTrue);
      expect(SmsPolicy.available, isFalse,
          reason: 'an explicit sms_otp_enabled=false must win over the '
              'derived default');
      expect(SmsPolicy.showLoginOtpStep, isFalse);
    });
  });

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

    test('the BVN notice STAYS ON once we can verify the number', () async {
      // CHANGED 2026-11-02. This asserted the notice defaulted away when SMS
      // came back, on the reasoning that it only covered for our missing OTP.
      // That was wrong: Mono Prove requires the number to be LINKED TO THE BVN
      // ("ensure the number you provide is ... a number linked to your BVN" —
      // support.mono.co/en/articles/11035147-faqs-on-mono-prove), which is a
      // permanent constraint unrelated to our provider.
      //
      // An SMS OTP proves the customer HOLDS the number. It says nothing about
      // whose BVN it is registered against — so with the notice gone, KYC would
      // still fail later, long after they have forgotten what they typed.
      await withSettings({'sms_provider_active': true});
      expect(SmsPolicy.showBvnPhoneNotice, isTrue,
          reason: 'the BVN-match requirement does not depend on SMS');
    });
  });

  group('phone verification and change are SMS-dependent surfaces', () {
    // Both were reachable from live-looking controls with no gate: the settings
    // "Verify Phone Number" tile opened an OTP screen, and ChangePhoneScreen
    // sent a code to the new number before applying the change. With no
    // provider the user waits for a code nobody sent and reads it as a broken
    // app rather than an unavailable feature.
    test('both are blocked when SMS cannot be delivered', () async {
      await withSettings({'sms_provider_active': false});
      expect(SmsPolicy.canVerifyPhoneNumber, isFalse);
      expect(SmsPolicy.canChangePhoneNumber, isFalse);
      expect(SmsPolicy.unavailableReason, isNotEmpty,
          reason: 'the UI renders this string, so it must never be blank');
    });

    test('both return when a provider is active', () async {
      await withSettings({'sms_provider_active': true});
      expect(SmsPolicy.canVerifyPhoneNumber, isTrue);
      expect(SmsPolicy.canChangePhoneNumber, isTrue);
    });

    test('an explicit OTP override closes them even with a live provider',
        () async {
      // The posture an operator picks for a provider that is configured but
      // not yet trusted for production traffic.
      await withSettings({
        'sms_provider_active': true,
        'sms_otp_enabled': false,
      });
      expect(SmsPolicy.canVerifyPhoneNumber, isFalse);
      expect(SmsPolicy.canChangePhoneNumber, isFalse);
    });

    test('they track `available`, so no surface can drift from the others',
        () async {
      // The whole point of the policy module. If one of these ever stops
      // tracking `available` it must be a deliberate, separately-reasoned
      // change — not something that happened while editing a screen.
      for (final providerOn in [true, false]) {
        await withSettings({'sms_provider_active': providerOn});
        expect(SmsPolicy.canVerifyPhoneNumber, SmsPolicy.available);
        expect(SmsPolicy.canChangePhoneNumber, SmsPolicy.available);
        expect(SmsPolicy.canRecoverBySms, SmsPolicy.available);
        expect(SmsPolicy.canUseSmsTwoFactor, SmsPolicy.available);
        expect(SmsPolicy.showSignupOtpStep, SmsPolicy.available);
        expect(SmsPolicy.showLoginOtpStep, SmsPolicy.available);
      }
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

  group('the OTP screen\'s "Skip for now"', () {
    // OPERATOR DIRECTIVE: with the SMS provider ACTIVE and the OTP screen
    // showing, there is no skip. The code is on its way; the honest paths are
    // to enter it or to use a different number. A third read as an invitation
    // to dodge a step the platform had just decided to require.
    test('is hidden while the provider is active', () async {
      await withSettings({'sms_provider_active': true});
      expect(SmsPolicy.available, isTrue);
      expect(SmsPolicy.showOtpSkip, isFalse);
    });

    // The one case that genuinely needs an escape hatch: the provider going
    // away while the screen is open. phoneVerificationStepRoute keeps the step
    // out of the journey when SMS is off, so this is not the usual entry — but
    // an admin can switch the provider off mid-flow and the first flag
    // snapshot can resolve after the route. Both leave a screen waiting for a
    // code that will never arrive.
    test('is offered when the provider is gone and it is not required',
        () async {
      await withSettings({'sms_provider_active': false});
      expect(SmsPolicy.showOtpSkip, isTrue);
    });

    test('is vetoed by phone_verification_required either way', () async {
      await withSettings({
        'sms_provider_active': false,
        'phone_verification_required': true,
      });
      // No skip path exists to offer: the backend rejects an unverified
      // SignupWithPhone regardless of what SMS is doing.
      expect(SmsPolicy.showOtpSkip, isFalse);

      await withSettings({
        'sms_provider_active': true,
        'phone_verification_required': true,
      });
      expect(SmsPolicy.showOtpSkip, isFalse);
    });

    test('never contradicts whether the step is shown at all', () async {
      // Skip must never be the ONLY affordance offered on a step that is also
      // being rendered as mandatory-and-deliverable.
      for (final active in [true, false]) {
        await withSettings({'sms_provider_active': active});
        expect(SmsPolicy.showSignupOtpStep && SmsPolicy.showOtpSkip, isFalse,
            reason: 'provider active=$active offered a deliverable step AND a '
                'skip out of it');
      }
    });
  });

  test('there is always a reason to show when SMS is blocked', () {
    expect(SmsPolicy.unavailableReason, isNotEmpty);
    // Naming the vendor invites support questions we do not want, and the
    // user cannot act on it either way.
    expect(
        SmsPolicy.unavailableReason.toLowerCase(), isNot(contains('twilio')));
    expect(SmsPolicy.unavailableReason.toLowerCase(),
        isNot(contains('suspended')));
  });
}
