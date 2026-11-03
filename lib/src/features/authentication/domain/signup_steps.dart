import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';

/// THE SIGNUP SEQUENCE, IN ONE PLACE, WITH CONDITIONAL STEPS REMOVED RATHER
/// THAN SKIPPED.
///
/// THE BUG THIS FIXES. Every signup screen passed a hardcoded `step:` and
/// `totalSteps: 5` to [PhoneFlowScaffold]:
///
///   1 phone entry · 2 phone OTP · 3 passcode · 4 personal details · 5 email
///
/// When no SMS provider is active the OTP step is skipped, so the customer
/// walks 1 → 3 → 4 → 5 and the progress bar reads "1 of 5", then "3 of 5" —
/// a visible hole where step 2 should be, and a total that counts a step that
/// will never be shown. The bar then never fills on the last screen either,
/// because 5 of 5 was only reachable through the step that was removed.
///
/// A skipped step is still IN the sequence. The operator's requirement was that
/// it be TAKEN OUT of it: "it shouldn't just skip that progress, but it should
/// be taken out of the progress so that the filling isn't there".
///
/// SO POSITION IS DERIVED, NEVER DECLARED. A screen says WHICH step it is; this
/// file decides where that sits among the steps actually being shown. Add,
/// remove or reorder a step here and every screen's bar follows — there is no
/// second list to keep in step, which is what made the original wrong.
///
/// THE UI MUST ASK BEFORE IT RENDERS. [activeSignupSteps] reads [SmsPolicy],
/// which reads the admin snapshot already on the device, so this is a
/// synchronous local lookup with no request on the signup path. The settings
/// are fetched and cached before the first auth screen (EndpointRegistry →
/// FeatureFlags.applyRemoteSnapshot), which is why rendering can depend on them
/// at all.
enum SignupStep {
  /// Enter the phone number. Always shown — the number is needed for KYC even
  /// when we cannot OTP it, because our partners require a BVN-linked number.
  phoneEntry,

  /// Verify that number by SMS. CONDITIONAL: present only when a code can
  /// actually be delivered.
  phoneOtp,

  /// Create the passcode. Always shown; it is the account's credential.
  passcode,

  /// Name, date of birth, etc.
  personalDetails,

  /// Verify the email. Always shown, and deliberately last-but-always: email
  /// is fully integrated, so it is the verification channel we can rely on
  /// whatever the SMS provider is doing.
  emailVerification,
}

/// The steps actually shown to this customer, in order.
///
/// The ONLY place the conditionality lives. A caller that wants a position must
/// go through [signupProgressFor] rather than re-deriving it.
List<SignupStep> activeSignupSteps() => <SignupStep>[
      SignupStep.phoneEntry,
      // REMOVED, not skipped, when no OTP can be delivered.
      if (SmsPolicy.showSignupOtpStep) SignupStep.phoneOtp,
      SignupStep.passcode,
      SignupStep.personalDetails,
      SignupStep.emailVerification,
    ];

/// Where [step] sits in the sequence the customer is actually walking.
///
/// Returns null when the step is not in the active sequence — which the caller
/// should render as NO progress bar. That case is reachable: the OTP screen can
/// be opened directly by a deep link or an older cached route while SMS is off,
/// and showing "2 of 4" for a step that is not part of the journey is worse
/// than showing nothing. [PhoneFlowScaffold] already treats a null `step` as
/// "hide the bar", so this composes with it directly.
({int step, int total})? signupProgressFor(SignupStep step) {
  final steps = activeSignupSteps();
  final i = steps.indexOf(step);
  if (i < 0) return null;
  return (step: i + 1, total: steps.length);
}

/// The 1-based position, or null to hide the bar.
///
/// Convenience for the scaffold's `step:` argument, so a screen reads
/// `step: signupStepNumber(SignupStep.passcode)` instead of unpacking a record
/// inline five times.
int? signupStepNumber(SignupStep step) => signupProgressFor(step)?.step;

/// The total to render alongside it.
///
/// Falls back to the full sequence length when the step is not active, so a
/// screen that renders the total without checking cannot divide by null. The
/// bar is hidden in that case anyway ([signupStepNumber] returns null), so the
/// value is never actually shown.
int signupStepTotal(SignupStep step) =>
    signupProgressFor(step)?.total ?? activeSignupSteps().length;
