import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/authentication/domain/signup_steps.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE PROGRESS BAR MUST NOT HAVE A HOLE IN IT.
///
/// Every signup screen used to declare a hardcoded `step: N, totalSteps: 5`.
/// With no SMS provider the OTP step is not shown, so the customer walked
/// 1 → 3 → 4 → 5: a visible gap where step 2 should be, and a bar that could
/// never fill because 5-of-5 was only reachable through the removed step.
///
/// The operator's requirement was that the step be TAKEN OUT of the sequence,
/// not skipped within it. These tests pin that.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // FeatureFlags caches its SharedPreferences (init() is `??=`), so the mock
  // store has to be installed once, before the first init.
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
    ]) {
      await prefs.remove(k);
    }
  });

  group('no SMS provider — the default', () {
    test('the OTP step is absent from the sequence, not merely skipped', () {
      expect(activeSignupSteps(), isNot(contains(SignupStep.phoneOtp)));
      expect(activeSignupSteps().length, 4);
    });

    test('the remaining steps are numbered 1..4 with no gap', () {
      // The exact failure: these used to read 1, 3, 4, 5 of 5.
      expect(signupProgressFor(SignupStep.phoneEntry), (step: 1, total: 4));
      expect(signupProgressFor(SignupStep.passcode), (step: 2, total: 4));
      expect(signupProgressFor(SignupStep.personalDetails), (step: 3, total: 4));
      expect(signupProgressFor(SignupStep.emailVerification), (step: 4, total: 4));
    });

    test('the last step fills the bar', () {
      final last = signupProgressFor(SignupStep.emailVerification)!;
      expect(last.step, last.total,
          reason: 'a bar that never reaches its end reads as an unfinished signup');
    });

    test('the inactive OTP step renders NO bar rather than a wrong one', () {
      // Reachable by deep link or a stale cached route. "2 of 4" for a step
      // outside the journey is worse than nothing; PhoneFlowScaffold hides the
      // bar on a null step.
      expect(signupProgressFor(SignupStep.phoneOtp), isNull);
      expect(signupStepNumber(SignupStep.phoneOtp), isNull);
      // The total still answers, so a screen cannot crash reading it.
      expect(signupStepTotal(SignupStep.phoneOtp), 4);
    });
  });

  group('SMS provider active', () {
    setUp(() async {
      await prefs.setBool(FeatureFlags.smsProviderActiveKey, true);
    });

    test('the OTP step returns to the sequence', () {
      expect(activeSignupSteps(), contains(SignupStep.phoneOtp));
      expect(activeSignupSteps().length, 5);
    });

    test('numbering shifts to 1..5 with the OTP second', () {
      expect(signupProgressFor(SignupStep.phoneEntry), (step: 1, total: 5));
      expect(signupProgressFor(SignupStep.phoneOtp), (step: 2, total: 5));
      expect(signupProgressFor(SignupStep.passcode), (step: 3, total: 5));
      expect(signupProgressFor(SignupStep.personalDetails), (step: 4, total: 5));
      expect(signupProgressFor(SignupStep.emailVerification), (step: 5, total: 5));
    });
  });

  group('invariants that must hold either way', () {
    for (final smsOn in [false, true]) {
      test('positions are contiguous from 1 (sms=$smsOn)', () async {
        if (smsOn) {
          await prefs.setBool(FeatureFlags.smsProviderActiveKey, true);
        } else {
          await prefs.remove(FeatureFlags.smsProviderActiveKey);
        }
        final steps = activeSignupSteps();
        final positions =
            steps.map((s) => signupProgressFor(s)!.step).toList();
        expect(positions, List<int>.generate(steps.length, (i) => i + 1),
            reason: 'a gap or repeat here is exactly the bug this file exists '
                'to prevent');
        // Every active step must agree on the total.
        expect(steps.map((s) => signupProgressFor(s)!.total).toSet(), {steps.length});
      });
    }

    test('phone entry and email verification are never removed', () async {
      // Phone entry: the number is needed for KYC even when we cannot OTP it.
      // Email: the one channel that is fully integrated.
      await prefs.remove(FeatureFlags.smsProviderActiveKey);
      expect(activeSignupSteps(), contains(SignupStep.phoneEntry));
      expect(activeSignupSteps(), contains(SignupStep.emailVerification));
      await prefs.setBool(FeatureFlags.smsProviderActiveKey, true);
      expect(activeSignupSteps(), contains(SignupStep.phoneEntry));
      expect(activeSignupSteps(), contains(SignupStep.emailVerification));
    });
  });
}
