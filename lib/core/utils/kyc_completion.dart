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

import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// How far along a holder's identity verification is.
enum KycState {
  /// WE DO NOT KNOW. Neither field was populated at all.
  ///
  /// Distinct from [unverified], and the distinction is load-bearing. The
  /// server gives every real account a `kyc_status`, defaulted to
  /// `'not_started'` in the users table — so a genuinely unverified holder
  /// arrives carrying that string and resolves to [unverified] correctly.
  /// Both fields EMPTY therefore does not mean "not verified"; it means the
  /// payload never carried them.
  ///
  /// That happens: `UserModel.fromProto` maps the `common` proto, which has no
  /// KYC fields at all, and it is what builds the profile behind BIOMETRIC and
  /// VOICE login. Folding this into [unverified] made every Face ID unlock
  /// prompt a fully verified user to go and verify — on the app's most-used
  /// daily path, telling people the app had forgotten something it had not.
  ///
  /// Prompts nobody and blocks nobody. Absence of evidence is not evidence.
  unknown,

  /// Never started, or started and thrown away. The only state that prompts.
  unverified,

  /// Submitted and with us. Prompts nobody — see the note above.
  inReview,

  /// Came back rejected. Needs doing again, and needs saying differently from
  /// "you have not started", or the user retries the same thing unchanged.
  rejected,

  /// Done. No gate, no prompt, anywhere.
  verified;

  /// True when the holder should be asked to verify.
  ///
  /// [inReview] is excluded — that holder has done their part and is waiting on
  /// us, so walking them back into the form invites a second submission of
  /// documents already with us. [unknown] is excluded because we have nothing
  /// to base the ask on. [verified] obviously.
  bool get shouldPrompt =>
      this == KycState.unverified || this == KycState.rejected;
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

  final s = (status ?? '').trim().toLowerCase();

  // Nothing to go on at all: no usable tier AND no status. See [KycState.unknown]
  // — a real account always carries a status, so this is an unpopulated payload
  // rather than an unverified person.
  if (t <= 0 && s.isEmpty) return KycState.unknown;

  switch (s) {
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
      // 'not_started', or a value added server-side that we do not recognise.
      // Both mean a real account that has not got there yet.
      return KycState.unverified;
  }
}

/// THE LAST KYC STATE A FULL LOGIN SAW.
///
/// # WHY A MIRROR IS NEEDED AT ALL
///
/// Credential logins — passcode, email, phone, 2FA, step-up, social — all carry
/// `kyc_tier` and `kyc_status` on the auth `User` proto, so the gate can read
/// them straight off the response. BIOMETRIC and VOICE login do not: they
/// rebuild the profile from ProfileCubit, whose user comes through
/// `UserModel.fromProto` and the `common` proto, which has no KYC fields.
///
/// Face ID is the dominant daily unlock for anyone who has opted into it. With
/// nothing to read, [KycState.unknown] correctly stops the app nagging a
/// verified user — but it also means the once-per-login prompt would never fire
/// on the path most people actually use, which is most of the feature gone.
///
/// So every login that DOES carry the fields records them, and a login that
/// does not falls back to what the last one saw.
///
/// # STALENESS IS ACCEPTABLE HERE, AND ONLY HERE
///
/// The mirror can lag: verify on a second device and this one still holds the
/// old answer until its next full login. The cost of that is one dismissible
/// prompt shown to someone who has already verified — mildly annoying, and
/// self-correcting.
///
/// It is NOT used for the hard gate. [KycLoginGate.forHolder] only consults the
/// mirror for the PROMPT; a stale mirror must never be able to refuse someone
/// the dashboard, which is why the blocking path reads live fields only.
class KycSnapshot {
  KycSnapshot._();

  static const String _tierKey = 'kyc_snapshot_tier';
  static const String _statusKey = 'kyc_snapshot_status';

  static SharedPreferences? _prefs;

  /// Load the mirror. Call once at startup, alongside FeatureFlags.init.
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (_) {
      // A prompt is never worth failing startup for.
    }
  }

  /// Record what a login actually saw.
  ///
  /// Ignores an empty reading rather than storing it: a biometric login must
  /// not erase what the last credential login knew, which is the whole point.
  static Future<void> remember({int? tier, String? status}) async {
    final t = tier ?? 0;
    final s = (status ?? '').trim();
    if (t <= 0 && s.isEmpty) return;
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      _prefs = prefs;
      await prefs.setInt(_tierKey, t);
      await prefs.setString(_statusKey, s);
    } catch (_) {/* best effort */}
  }

  /// Forget it. Called on logout and user switch, so the next person on this
  /// device is never judged by the last person's verification.
  static Future<void> clear() async {
    try {
      final prefs = _prefs ?? await SharedPreferences.getInstance();
      _prefs = prefs;
      await prefs.remove(_tierKey);
      await prefs.remove(_statusKey);
    } catch (_) {/* best effort */}
  }

  static int get tier => _prefs?.getInt(_tierKey) ?? 0;
  static String get status => _prefs?.getString(_statusKey) ?? '';
}

/// The KYC inputs the post-login router needs, as ONE value.
///
/// Both halves travel together deliberately. They were nearly two independent
/// optional parameters, which is a shape that fails quietly: a call site can
/// pass a correct [state] and forget [isRequired], and the gate then silently
/// never fires. The router asks for one required value instead, so a surface
/// either answers the question or does not compile.
class KycLoginGate {
  const KycLoginGate({
    required this.state,
    required this.isRequired,
    this.fromMirror = false,
  });

  /// How far this holder has got.
  final KycState state;

  /// Whether the platform currently treats verification as mandatory
  /// (`kyc_required_on_signup`, admin-tunable).
  final bool isRequired;

  /// True when [state] came from [KycSnapshot] rather than from this login's
  /// own payload. Such a reading may be stale, so it is allowed to prompt but
  /// never to block — see [blocksDashboard].
  final bool fromMirror;

  /// Build from the two fields every auth response carries, reading the live
  /// admin setting for the requirement.
  ///
  /// Takes the raw fields rather than a `User` so this stays in core and does
  /// not reach into the authentication feature.
  factory KycLoginGate.forHolder({String? kycStatus, int? kycTier}) {
    var state = resolveKycState(status: kycStatus, tier: kycTier);

    // The payload carried nothing — biometric or voice login. Fall back to what
    // the last credential login recorded. See [KycSnapshot].
    //
    // Only ever consulted when the live fields are ABSENT, so a present value
    // always wins and the mirror can never contradict the server.
    if (state == KycState.unknown) {
      state = resolveKycState(
        status: KycSnapshot.status,
        tier: KycSnapshot.tier,
      );
    }

    return KycLoginGate(
      state: state,
      isRequired: FeatureFlags.isKycRequired,
      // A mirrored reading must not be able to refuse someone the dashboard.
      // It is good enough to ASK with and not good enough to BLOCK on.
      fromMirror: resolveKycState(status: kycStatus, tier: kycTier) ==
          KycState.unknown,
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
  bool get blocksDashboard =>
      isRequired && state.shouldPrompt && !fromMirror;

  /// True when the dismissible once-per-login prompt should be shown.
  ///
  /// The complement of [blocksDashboard] among holders who need to verify: if
  /// the hard gate is on, the user never reaches a dashboard to be prompted on.
  bool get shouldPromptOnDashboard =>
      !blocksDashboard && state.shouldPrompt;
}
