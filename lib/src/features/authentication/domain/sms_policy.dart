import 'package:lazervault/core/config/feature_flags.dart';

/// What the app may do with SMS right now, in one place.
///
/// WHY A POLICY MODULE RATHER THAN READING THE FLAGS AT EACH SITE.
/// SMS touches signup verification, login step-up, two-factor and passcode
/// recovery. Those are four different screens in three different features,
/// and the decision each makes has to be the SAME decision — a login that
/// demands a code the signup never set up is worse than either behaviour on
/// its own. Reading `FeatureFlags.smsOtpEnabled` at each call site invites
/// exactly that drift, which is the shape of bug this codebase keeps
/// rediscovering elsewhere (see shared/txnstatus for the backend version).
///
/// HOW IT IS READ, AND WHY IT NEVER BLOCKS. Every getter below resolves
/// synchronously from SharedPreferences, which FeatureFlags.init() populates
/// at launch and a background settings poll refreshes. There is no await, no
/// network call and no future on any of these paths, so a screen can ask in
/// `build()` or in a navigation callback without a frame drop and without a
/// loading state. That is deliberate: a "checking whether to show this step"
/// spinner in the middle of signup would be worse than the step itself.
///
/// BEFORE THE FIRST SNAPSHOT RESOLVES the defaults apply, and they are chosen
/// to fail in the safe direction — SMS unavailable. An OTP screen that cannot
/// work is a dead end; skipping one that could have worked costs nothing,
/// because the account is simply created with phone_verified=false and the
/// number can be verified later.
class SmsPolicy {
  const SmsPolicy._();

  /// Whether a one-time SMS code can actually be delivered.
  static bool get available => FeatureFlags.smsOtpEnabled;

  /// Whether the signup journey should include the phone-OTP step.
  ///
  /// False means the step is NOT RENDERED — not shown-and-skippable. A user
  /// part-way through creating an account should not be asked for a code
  /// that will never arrive and left to work out that skipping is correct.
  static bool get showSignupOtpStep => available;

  /// Whether a login may be stepped up with an SMS code.
  ///
  /// Matters beyond tidiness: accounts created while SMS was off have
  /// phone_verified=false, so demanding an SMS step-up at login would lock
  /// out precisely the users who signed up during this period.
  static bool get showLoginOtpStep => available;

  /// Whether SMS may be offered as a two-factor method.
  ///
  /// When false the option is shown but DISABLED with a reason, rather than
  /// hidden. Two-factor is a security setting a careful user goes looking
  /// for; silently removing the method they expect reads as the feature
  /// being broken, whereas "unavailable right now" is a fact they can act on
  /// by choosing another method.
  static bool get canUseSmsTwoFactor => available;

  /// Whether passcode/PIN recovery may send an SMS code.
  static bool get canRecoverBySms => available;

  /// Whether to tell the user their number must match their BVN.
  ///
  /// Independent of the OTP switches: the BVN match matters to KYC whether or
  /// not we can verify the number ourselves. It defaults ON while SMS is off,
  /// because then the number reaches our KYC partners with no verification of
  /// ours behind it — and a mismatch surfaces as a failed verification days
  /// later, long after the user has forgotten what they typed.
  static bool get showBvnPhoneNotice => FeatureFlags.bvnPhoneNoticeEnabled;

  /// Why an SMS-dependent option is unavailable, for the UI to render.
  ///
  /// Deliberately does not name the provider or say "suspended": that is our
  /// problem, not something the user can act on, and naming a vendor in a
  /// consumer app invites questions we do not want to answer in a support
  /// queue.
  static const String unavailableReason =
      'SMS codes are temporarily unavailable. Please use another method.';
}
