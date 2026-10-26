/// WHERE "HAS THIS PERSON DONE KYC?" IS ANSWERED, ONCE.
///
/// The question is asked from a lot of places — the post-login router, the
/// login prompt, every service CTA that needs a verified holder — and each of
/// them previously answered it for itself from whatever field was to hand. The
/// two fields disagree in ordinary cases, so answering locally produced gates
/// that contradicted each other:
///
///   * `kyc_status` is the state of the VERIFICATION ATTEMPT
///     (`not_started` | `pending_review` | `approved` | `rejected`).
///   * `kyc_tier` is the CBN tier the attempt earned (1 basic, 2 BVN,
///     3 BVN+NIN+liveness). See `microservices/shared/kyctiers`.
///
/// Both ride every auth response on the `User` proto, so no call needs making
/// to answer this.
///
/// ## The state that matters most is the middle one
///
/// `pending_review` is the reason this is an enum and not a bool. Someone whose
/// documents are with us has DONE what we asked; they are simply waiting. Treat
/// them as unverified and the product nags them on every login and walks them
/// back into a form they already filled, where a second submission is the
/// likeliest outcome. Treat them as verified and they get a virtual account the
/// compliance check has not cleared. Neither is right, so neither is what
/// happens: [KycState.inReview] blocks nothing and prompts nobody.
library;

import 'package:lazervault/core/config/feature_flags.dart';

/// How far along a holder's identity verification is.
enum KycState {
  /// Never started, or started and thrown away. The only state that prompts.
  unverified,

  /// Submitted and with us. Prompts nobody — see the note above.
  inReview,

  /// Came back rejected. Needs doing again, and needs saying differently from
  /// "you have not started", or the user retries the same thing unchanged.
  rejected,

  /// Done. No gate, no prompt, anywhere.
  verified;

  /// True when a KYC-requiring service should let this holder through.
  ///
  /// [inReview] is deliberately NOT included. The holder has done their part,
  /// but a virtual account issued against an uncleared check is the exact thing
  /// the check exists to prevent — so services stay closed while telling the
  /// user it is us they are waiting on, not them.
  bool get allowsKycRequiredService => this == KycState.verified;

  /// True when the holder should be asked to verify.
  ///
  /// [inReview] is excluded for the reason above, and [verified] obviously.
  bool get shouldPrompt => this == KycState.unverified || this == KycState.rejected;
}

/// The tier a holder must reach to count as verified.
///
/// Tier 2 is BVN-verified, which is what mints a NUBAN and what the crypto rail
/// asks for (`crypto.min_kyc_tier`, default 2). Tier 1 is the unverified
/// baseline every account starts on, so it must never read as done.
const int kMinVerifiedKycTier = 2;

/// Resolve a holder's KYC state from the two fields every auth response carries.
///
/// EITHER field can establish verification, and that is on purpose rather than
/// sloppiness. The tier is the durable fact — it is what the limit engine and
/// the virtual-account minter read, and it is synced monotonically through
/// Kafka. The status is the attempt's own record. They can legitimately fall
/// out of step in the window between a tier upgrade landing and a status write,
/// and in that window the holder IS verified by every measure that spends their
/// money. Requiring both would gate a verified user on a race.
///
/// Unknown and empty statuses fall through to the tier, so a status value added
/// server-side tomorrow degrades to "judge by tier" rather than to "unverified
/// — go and do it again".
KycState resolveKycState({String? status, int? tier}) {
  final t = tier ?? 0;
  if (t >= kMinVerifiedKycTier) return KycState.verified;

  switch ((status ?? '').trim().toLowerCase()) {
    case 'approved':
    case 'verified':
    case 'completed':
      return KycState.verified;
    case 'pending_review':
    case 'pending':
    case 'in_review':
    case 'processing':
      return KycState.inReview;
    case 'rejected':
    case 'failed':
    case 'declined':
      return KycState.rejected;
    default:
      // not_started, empty, or anything we do not recognise.
      return KycState.unverified;
  }
}

/// The KYC inputs the post-login router needs, as ONE value.
///
/// Both halves travel together deliberately. They were nearly two independent
/// optional parameters, which is a shape that fails quietly: a call site can
/// pass a correct [state] and forget [isRequired], and the gate then silently
/// never fires. The router asks for one required value instead, so a surface
/// either answers the question or does not compile.
class KycLoginGate {
  const KycLoginGate({required this.state, required this.isRequired});

  /// How far this holder has got.
  final KycState state;

  /// Whether the platform currently treats verification as mandatory
  /// (`kyc_required_on_signup`, admin-tunable).
  final bool isRequired;

  /// Build from the two fields every auth response carries, reading the live
  /// admin setting for the requirement.
  ///
  /// Takes the raw fields rather than a `User` so this stays in core and does
  /// not reach into the authentication feature.
  factory KycLoginGate.forHolder({String? kycStatus, int? kycTier}) {
    return KycLoginGate(
      state: resolveKycState(status: kycStatus, tier: kycTier),
      isRequired: FeatureFlags.isKycRequired,
    );
  }

  /// A gate that blocks nobody. For surfaces with no holder to speak of, and
  /// for tests that are not exercising KYC.
  static const KycLoginGate none =
      KycLoginGate(state: KycState.verified, isRequired: false);

  /// True when login must divert into verification instead of the dashboard.
  ///
  /// Requires BOTH an admin who asked for it and a holder who has not done it.
  /// With the setting off this is always false and verification is asked for by
  /// the dismissible prompt instead.
  bool get blocksDashboard => isRequired && state.shouldPrompt;

  /// True when the dismissible once-per-login prompt should be shown.
  ///
  /// The complement of [blocksDashboard] among holders who need to verify: if
  /// the hard gate is on, the user never reaches a dashboard to be prompted on.
  bool get shouldPromptOnDashboard => !isRequired && state.shouldPrompt;
}
