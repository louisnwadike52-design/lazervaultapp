import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A phone already on an account must be rejected on the PHONE screen.
///
/// What the user hit: they entered a number that already had an account,
/// sailed through the phone step, and met "phone number already registered,
/// please log in" on the EMAIL screen — a phone error on a screen with no
/// phone field, two steps after the field that caused it.
///
/// The cause was a client-side short-circuit. RequestSignupPhoneOTP checks the
/// number is unregistered BEFORE it considers sending anything
/// (auth_phone_verification.go: FindByPhone, then the resend cooldown, then
/// the send), so it is the only duplicate-phone check in the signup journey.
/// The cubit returned early when SmsPolicy said no code could be sent, so with
/// no SMS provider live — which is the case today — that check never ran.
void main() {
  _phoneScreenShowsIt();
  late String cubit;

  setUpAll(() {
    cubit = File(
            'lib/src/features/authentication/cubit/phone_passcode_cubit.dart')
        .readAsStringSync();
  });

  test('the signup phone step always asks the server', () {
    expect(
      cubit.contains('SmsPolicy.showSignupOtpStep'),
      isFalse,
      reason: 'the client short-circuit is back. Skipping the request skips '
          'the ONLY duplicate-phone check in signup, so a taken number is not '
          'caught until the email screen — two steps too late, on a screen '
          'with no phone field to correct.',
    );
    expect(cubit.contains('_authRepository.requestSignupPhoneOtp('), isTrue,
        reason: 'the request itself is gone; nothing would check the number');
  });

  test('an SMS-unavailable refusal still lets signup continue', () {
    // The server is the authority on whether a code can be delivered. With no
    // provider it answers ErrSmsUnavailable without sending, and signup must
    // proceed with phone_verified=false rather than dead-ending.
    expect(cubit.contains('_isSmsUnavailable(failure.message)'), isTrue,
        reason: 'without this branch, every signup fails on the phone step '
            'the moment the SMS provider is off');
    expect(cubit.contains('skipPhoneVerification()'), isTrue);
  });

  test('the skip actually runs — it is not swallowed by the loading state', () {
    // skipPhoneVerification() opens with `if (state is PhonePasscodeLoading)
    // return;`, and the state is always Loading inside result.fold because it
    // is emitted immediately before the request. So the branch silently did
    // nothing and stranded the user on the phone screen with no error and no
    // progress — the safety net for exactly today's no-SMS case could never
    // fire.
    final at = cubit.indexOf('_isSmsUnavailable(failure.message)');
    expect(at, greaterThan(-1));
    // The CALL, not the mention of it in the comment above it.
    final skip = cubit.indexOf('await skipPhoneVerification();', at);
    final leaveLoading = cubit.indexOf('PhonePasscodeInitial()', at);
    expect(leaveLoading, greaterThan(-1),
        reason: 'nothing leaves the loading state before the skip');
    expect(leaveLoading, lessThan(skip),
        reason: 'the state must be cleared BEFORE skipPhoneVerification(), or '
            'its own loading guard early-returns and the skip does nothing');
  });

  test('a duplicate is surfaced as such, not as a generic failure', () {
    expect(cubit.contains('_isAlreadyRegistered(failure.message)'), isTrue,
        reason: 'the phone screen needs to say "already registered, log in" '
            'rather than a generic error, or the user retries the same number');
  });
}

/// The other half of the chain: the phone screen must be able to SHOW it.
///
/// Moving the check earlier is only useful if the phone screen renders the
/// result. It already did — the handling was sitting there unreachable while
/// the short-circuit skipped the call that produces it.
void _phoneScreenShowsIt() {
  late String entry;
  late String emailStep;

  setUpAll(() {
    entry = File(
            'lib/src/features/authentication/presentation/views/phone_entry_screen.dart')
        .readAsStringSync();
    emailStep = File(
            'lib/src/features/authentication/presentation/views/phone_email_verification_screen.dart')
        .readAsStringSync();
  });

  test('the phone screen handles alreadyRegistered specifically', () {
    expect(entry.contains('state.alreadyRegistered'), isTrue,
        reason: 'without this the duplicate shows as a generic error and the '
            'user retries the same number');
    expect(entry.contains('Account exists'), isTrue);
  });

  test('and offers a way out, not just a refusal', () {
    // A dead end on "this number is taken" is how someone abandons signup.
    expect(entry.contains('LoginFlowResolver.resolveLoginRoute()'), isTrue,
        reason: 'the Log in action is what makes the refusal actionable');
  });

  test('the email step still owns the EMAIL duplicate', () {
    // SignupWithPhone checks phone BEFORE email, which is why the phone error
    // used to surface here. The email error legitimately belongs on this
    // screen, because this is where submitSignup is called — that must not
    // have been moved by the phone fix.
    expect(emailStep.contains('submitSignup(email: email)'), isTrue,
        reason: 'the email step must still submit, or the email duplicate '
            'would surface somewhere else instead');
  });
}
