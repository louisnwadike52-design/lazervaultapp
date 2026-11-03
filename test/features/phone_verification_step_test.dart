import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/phone_verification_step.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE OTP SCREEN MUST NOT BE REACHABLE WHILE NO PROVIDER CAN DELIVER A CODE.
///
/// Reported from an Android device: the SMS OTP screen still appeared on
/// login with the provider off, and the screen requests a code ON LOAD — so
/// the server's SMS gate refused it and the customer was stranded on "we
/// could not send a code" with nothing to tap.
///
/// The cause was drift, not a missing rule. `signup_steps.dart` already takes
/// the step out of the journey, and `main.dart`'s PHONE-flow resume map
/// checked SmsPolicy — but its EMAIL-flow sibling, and both signup chaining
/// hops, pushed the screen directly without asking. This test pins the
/// replacement so a fourth navigation site cannot quietly reintroduce it.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // FeatureFlags caches its SharedPreferences (init() is `??=`), so the mock
  // store has to be installed once before the first init — see
  // sms_policy_test.dart, where getting this wrong made the writes invisible.
  late SharedPreferences prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    prefs = await SharedPreferences.getInstance();
  });

  setUp(() async {
    await prefs.remove(FeatureFlags.smsProviderActiveKey);
    await prefs.remove(FeatureFlags.smsOtpEnabledKey);
  });

  Future<void> smsOn() =>
      prefs.setBool(FeatureFlags.smsProviderActiveKey, true);

  group('with NO active provider (the live configuration)', () {
    test('the step is unavailable by default, with nothing configured', () {
      expect(phoneOtpStepAvailable, isFalse);
    });

    test('a phone-primary signup goes to email verification, not the OTP page',
        () {
      final r = phoneVerificationStepRoute(
        phoneNumber: '08012345678',
        secondaryEmail: 'her@example.com',
      );
      expect(r.name, AppRoutes.emailVerification);
      expect(r.args?['email'], 'her@example.com');
      // The fallback must not be HARDER to pass than the step it replaced.
      expect(r.args?['isRequired'], isFalse);
    });

    test('with no email to fall back to, it goes to passcode setup', () {
      final r = phoneVerificationStepRoute(phoneNumber: '08012345678');
      expect(r.name, AppRoutes.passcodeSetup);
    });

    test('isRequired cannot force the OTP page into view', () {
      // The admin "phone verification required" switch governs SKIPPABILITY.
      // It must never override DELIVERABILITY: requiring a code we cannot
      // send would lock every new customer out of signup entirely.
      final r = phoneVerificationStepRoute(
        phoneNumber: '08012345678',
        isRequired: true,
      );
      expect(r.name, isNot(AppRoutes.phoneVerification));
    });
  });

  // main.dart's resume map returns a bare route STRING — its signature has
  // nowhere to put arguments — so it uses onwardFromPhoneVerification().name
  // and discards .args. That is only safe while the no-email fallback carries
  // none. Pinned here so adding arguments to it cannot silently drop them on
  // the resume path.
  test('the no-email fallback carries no arguments to drop', () {
    final r = onwardFromPhoneVerification();
    expect(r.name, AppRoutes.passcodeSetup);
    expect(r.args, isNull);
  });

  test('the email fallback matches the route contract', () {
    // app_router.dart reads exactly these keys off the emailVerification
    // route; a renamed key would silently become a null email.
    final r = onwardFromPhoneVerification(secondaryEmail: 'her@example.com');
    expect(r.name, AppRoutes.emailVerification);
    expect(r.args?.keys.toSet(),
        {'email', 'codeSent', 'isRequired', 'secondaryPhone'});
    // false means the screen SENDS one on load — there is no code in flight,
    // because the step that would have sent one never ran.
    expect(r.args?['codeSent'], isFalse);
  });

  _skipHatchGroup();

  group('with a provider active', () {
    test('the OTP page is shown, carrying its arguments', () async {
      await smsOn();
      expect(phoneOtpStepAvailable, isTrue);
      final r = phoneVerificationStepRoute(
        phoneNumber: '08012345678',
        secondaryEmail: 'her@example.com',
        codeSent: true,
        isRequired: true,
      );
      expect(r.name, AppRoutes.phoneVerification);
      expect(r.args?['phoneNumber'], '08012345678');
      expect(r.args?['codeSent'], isTrue);
      expect(r.args?['isRequired'], isTrue);
      // Carried through so the screen can chain on to it after verifying.
      expect(r.args?['secondaryEmail'], 'her@example.com');
    });

    test('a missing phone still never opens the OTP page', () async {
      await smsOn();
      // Defensive: an OTP screen with no number to send to is a dead end
      // whatever the provider is doing.
      expect(phoneVerificationStepRoute(phoneNumber: null).name,
          AppRoutes.passcodeSetup);
      expect(phoneVerificationStepRoute(phoneNumber: '').name,
          AppRoutes.passcodeSetup);
    });

    test('an explicit sms_otp_enabled=false overrides an active provider',
        () async {
      await smsOn();
      await prefs.setBool(FeatureFlags.smsOtpEnabledKey, false);
      expect(phoneOtpStepAvailable, isFalse);
      expect(phoneVerificationStepRoute(phoneNumber: '08012345678').name,
          AppRoutes.passcodeSetup);
    });
  });
}

/// THE SKIP HATCH CLOSES ONCE A CODE CAN ACTUALLY ARRIVE.
///
/// "Skip for now" exists because a code the customer can never receive is a
/// dead end. With a live provider the code IS being sent, so offering to skip
/// undermines the step — the honest instruction is "enter the code", with the
/// resend beside it for one that is slow.
///
/// Mirrors `_codeCanBeDelivered` on login_otp_screen: an EMAIL challenge is
/// always deliverable (adaptive_otp.go defaults to email and only falls to
/// SMS for a phone-only account), so only an SMS challenge with no provider
/// can strand anyone.
void _skipHatchGroup() {
  bool codeCanBeDelivered(String method) =>
      method != 'sms' || SmsPolicy.available;

  bool skipShown({required String method, required bool tunableOn}) =>
      tunableOn && !codeCanBeDelivered(method);

  group('the OTP skip hatch', () {
    test('hidden for an SMS challenge once a provider is active', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(FeatureFlags.smsProviderActiveKey, true);
      expect(skipShown(method: 'sms', tunableOn: true), isFalse);
    });

    test('shown for an SMS challenge with no provider', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(FeatureFlags.smsProviderActiveKey);
      expect(skipShown(method: 'sms', tunableOn: true), isTrue);
    });

    test('never shown for an EMAIL challenge — email always delivers',
        () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(FeatureFlags.smsProviderActiveKey);
      expect(skipShown(method: 'email', tunableOn: true), isFalse);
    });

    test('the admin tunable can still suppress it entirely', () async {
      // Operator control is not overridden — the deliverability check only
      // ever NARROWS what the tunable allows.
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(FeatureFlags.smsProviderActiveKey);
      expect(skipShown(method: 'sms', tunableOn: false), isFalse);
    });
  });
}
