import 'dart:async';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_status_skeleton.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_saving_overlay.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_session_cooldown_modal.dart';
import 'package:lazervault/src/features/kyc/domain/kyc_session_cooldown.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_update_details_cta.dart';
import 'package:flutter/material.dart';
import 'package:lazervault/core/network/network_timeouts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../../core/shared_widgets/app_loading_button.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../../funds/domain/services/pending_deposit.dart';
import '../../../funds/presentation/widgets/directpay_authorization_sheet.dart';
import '../../data/services/prove_kyc_http_service.dart';
import '../../domain/repositories/kyc_repository.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_profile_fix.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_name_comparison.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_name_correction_sheet.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_gate_exit_cta.dart';
import 'package:lazervault/src/features/kyc/domain/pending_signup_identity.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';
import 'package:lazervault/src/features/support/presentation/support_contact_cta.dart';
import 'package:lazervault/src/features/kyc/presentation/views/bvn_signup_screen.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

// ── Surface system ───────────────────────────────────────────────────────────
//
// LIGHT, ON THE SHARED CURVED BACKGROUND. This screen was the last dark one in
// the identity flow: a customer walked the curved, light BVN/NIN capture screen
// and then landed here on flat black, which read as a different app. It now
// uses the same `up-down-curve-bg.png` ground as the capture screen, sign-up,
// sign-in and password recovery, so the whole journey is one surface.
//
// THE BACKGROUND HAS TWO BANDS, AND CONTRAST MUST BE CHOSEN PER BAND. The top
// of the image is deep brand purple; below the curve it is near-white. Anything
// drawn in the top band (the back arrow) is WHITE; everything in the scrolling
// body is dark ink on white cards. Getting this wrong is not subtle but it IS
// invisible in a simulator screenshot taken against the wrong band — the
// "Final step" chip on the capture screen was purple-on-purple for exactly this
// reason.
//
// DEPTH, NOT HAIRLINES — kept from the dark design, because the reasoning holds
// either way. Every card used to be a fill ringed by a 1px border; at this
// screen's real size those borders are sub-pixel on most devices, alias into
// grey fuzz, and stack into noise on a page already dense with text. Reported
// 2026-11-09 — "no tiny borders on widgets". Cards are separated by ELEVATION
// and luminance instead: the page sits at _bg, a card lifts to _surface
// (white), anything nested inside a card lifts to _surfaceHigh. Tinted (status)
// cards carry meaning in a low-alpha fill of their own colour.
const Color _bg = Color(0xFFF6F5FB); // the page ground under the curve
const Color _surface = Colors.white; // a card on the page
const Color _surfaceHigh = Color(0xFFF2F1F9); // a card inside a card
const Color _textPrimary = Color(0xFF14131A);
// 0xFF6B6A7B on white is ~5.3:1 — above the 4.5:1 AA floor. The dark theme's
// #9A9AA8 would be ~2.6:1 here, which is the failure mode a straight palette
// swap invites.
const Color _textSecondary = Color(0xFF6B6A7B);
// THE BRAND PURPLE the curved background is painted in, so the CTA and the
// accents belong to the artwork rather than sitting on top of it. The old
// indigo #6366F1 was chosen against black and reads as a different brand here.
const Color _accent = Color(0xFF4834D4);
// Status colours DARKENED for a light ground. The dark theme's #10B981 /
// #FB923C / #EF4444 are tuned to glow on black; as text or icons on white they
// sit around 2-3:1. These are the same hues pulled down into AA range.
const Color _success = Color(0xFF047857);
const Color _warning = Color(0xFFB45309);
const Color _danger = Color(0xFFB3261E);

// Retained for the shared widgets this screen passes a surface colour into
// (KycNameComparison takes `surface:`), so their look stays consistent with
// the new system rather than drifting back to the old one.
const Color _card = _surface;

/// Radius used by every card on this screen. One value, so nothing looks
/// accidentally squarer or rounder than its neighbour.
const double _radius = 18;

/// A tinted, rounded-square icon holder.
///
/// Bare icons floating in a text row read as decoration; a chip gives the icon
/// a deliberate place and lets the tint carry the status (indigo = neutral,
/// amber = blocked, green = done) without needing a border to delimit it.
class _IconChip extends StatelessWidget {
  const _IconChip(this.icon, {this.color = _accent, this.size = 38});

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular((size * 0.32).r),
      ),
      child: Icon(icon, color: color, size: (size * 0.5).sp),
    );
  }
}

/// What the customer chose when a signup NIN was refused.
enum _PendingIdentityAction { fixDetails, continueAnyway }

/// Three-segment progress rail for the KYC tier ladder.
///
/// The tier was previously stated only in prose ("You're at Tier 1. To reach
/// Tier 2: add your BVN."), which makes a three-step ladder feel like a flat
/// state. A rail shows at a glance that there are three rungs, which one you
/// are on, and that the rest are reachable.
class _TierRail extends StatelessWidget {
  const _TierRail({required this.tier, required this.tone});

  /// Current tier, 1-3. Values outside that range are clamped rather than
  /// trusted: this is server data, and a rail is not worth a crash.
  final int tier;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    final current = tier.clamp(0, 3);
    return Row(
      children: [
        for (var t = 1; t <= 3; t++) ...[
          if (t > 1) SizedBox(width: 6.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: t <= current
                        ? tone
                        : Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  'Tier $t',
                  style: GoogleFonts.inter(
                    fontSize: 10.5.sp,
                    fontWeight:
                        t == current ? FontWeight.w700 : FontWeight.w500,
                    color: t <= current ? _textPrimary : _textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// A borderless raised card. [tint] fills it with a status colour instead of
/// the neutral surface.
class _Card extends StatelessWidget {
  const _Card({required this.child, this.tint, this.padding});

  final Widget child;
  final Color? tint;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: tint == null ? _surface : tint!.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(_radius.r),
      ),
      child: child,
    );
  }
}

/// Identity Verification — Mono Prove 3-tier KYC via the hosted widget.
///
/// We no longer collect the BVN/NIN in-app. The Mono Prove widget collects the
/// identity number AND performs the biometric ownership check itself, so this
/// screen is a single "Verify Identity" intro + button. The button starts a
/// real Prove session (no identity sent — the widget asks for it), opens it in
/// an in-app WebView, then reads the authoritative result by reference.
///
/// The screen is tier-aware: it loads the user's current KYC standing first,
/// shows where they are and what's left for the next tier, and (because Mono's
/// Prove Wallet resumes a known phone) a retry continues from the remaining
/// step rather than restarting. When the flow is reached as part of signup and
/// verification can't be finished, the user can skip and continue onboarding.
class BVNVerificationScreen extends StatefulWidget {
  const BVNVerificationScreen({super.key});

  @override
  State<BVNVerificationScreen> createState() => _BVNVerificationScreenState();
}

class _BVNVerificationScreenState extends State<BVNVerificationScreen> {
  late final ProveKycHttpService _prove =
      ProveKycHttpService(serviceLocator<SecureStorageService>());

  // The onboarding flags are touched by code using two different
  // FlutterSecureStorage configs: the signup cubit writes with the DEFAULT
  // config, while main.dart reads with encryptedSharedPreferences:true. On
  // Android these are different backends, so we read from both and write to both
  // to stay consistent with whichever code touches the flag next.
  static const _flagsDefault = FlutterSecureStorage();
  static const _flagsEncrypted = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  Future<String?> _readFlag(String key) async {
    try {
      final v = await _flagsDefault.read(key: key);
      if (v != null) return v;
    } catch (_) {/* fall through */}
    try {
      return await _flagsEncrypted.read(key: key);
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeFlag(String key, String value) async {
    for (final s in [_flagsDefault, _flagsEncrypted]) {
      try {
        await s.write(key: key, value: value);
      } catch (_) {/* best-effort on both backends */}
    }
  }

  Future<void> _deleteFlag(String key) async {
    for (final s in [_flagsDefault, _flagsEncrypted]) {
      try {
        await s.delete(key: key);
      } catch (_) {/* best-effort on both backends */}
    }
  }

  bool _isSubmitting = false;

  /// Skip the BVN-lookup interception and go straight to Mono Prove.
  ///
  /// Set by a caller that has ALREADY exhausted the BVN lookup — chiefly the
  /// identity screen when every delivery route Mono offered refused. Without
  /// it those customers are trapped: the interception below would bounce them
  /// back to the lookup that cannot reach them, every single time, and Prove
  /// is the one route that does not depend on the phone number their bank
  /// holds. Latched into state on first read so a second tap behaves the same
  /// as the first.
  late final bool _skipBvnLookup = (() {
    final args = Get.arguments;
    return args is Map && args['skipBvnLookup'] == true;
  })();
  bool _loadingStatus = true;
  bool _fromSignup = false;
  ProveKycStatus? _status;

  @override
  void initState() {
    super.initState();
    // LIGHT status-bar icons — still correct after the redesign, for a
    // different reason. The page is no longer a dark screen, but the top of
    // the curved background IS deep brand purple and that is the band the
    // status bar sits in. The comment used to say "dark screen", which would
    // have invited someone flipping the palette to flip this too and put dark
    // icons on a purple header.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _loadSupportEmail();
    _init();
  }

  Future<void> _init() async {
    final pending = await _readFlag('kyc_onboarding_pending');
    _fromSignup = pending == 'true';
    try {
      final st = await _prove.status();
      if (mounted) setState(() => _status = st);
    } catch (_) {
      // One silent retry after a short pause — a transient blip used to leave
      // the tier card stale/empty with no recovery until a full re-entry.
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        try {
          final st = await _prove.status();
          if (mounted) setState(() => _status = st);
        } catch (_) {/* screen still works without it */}
      }
    } finally {
      if (mounted) setState(() => _loadingStatus = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;
    final isMaxTier = status?.isMaxTier ?? false;

    // LIGHT STATUS BAR, ON BOTH PLATFORMS.
    //
    // AppBar.systemOverlayStyle below is honoured on Android but is not
    // reliable on iOS behind a transparent app bar with
    // extendBodyBehindAppBar — which is this screen exactly. Reported
    // 2026-11-10 with the iOS clock rendering dark against the purple
    // band, the same contrast failure the back arrow had. AnnotatedRegion
    // is the pattern the rest of the app uses for this (batch_transfer,
    // select_recipient, themed_app_bar) and it applies on both.
    // THE OS BACK GESTURE MUST DO WHAT THE ARROW DOES — INCLUDING WHEN THE
    // ARROW IS NOT DRAWN.
    //
    // The arrow is hidden when this screen is the onboarding ROOT (signup's
    // PIN setup ends with `Get.offAllNamed` here), which left Android's back
    // press with nothing to pop and therefore CLOSING THE APP, on somebody
    // signed in and part-way through verifying.
    //
    // `canPop` is false in BOTH cases, not just the gate one. When back IS
    // allowed the pop still has to go through `_onBack`, because that clears
    // the pending deposit first — a plain pop would leave a saved deposit to
    // auto-resume a bank link behind an unfinished verification, which is the
    // thing `_onBack` was written to prevent. `_onBack` pops with
    // `Get.back()` / `Navigator.pop()`, both unconditional, so this cannot
    // loop on itself.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || !mounted) return;
        if (_canLeaveBack) {
          _onBack();
          return;
        }
        // Below Tier 2 there is no skip, so the only honest exit is the one
        // the "Not you?" link offers — sign out and use another account.
        KycGateExitCta.confirmExit(context);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
      backgroundColor: _bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // The curved artwork IS the header, so the status-bar icons must be
        // light over its purple band. Without this the system clock and
        // battery render dark-on-dark on Android.
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // NO ARROW WHERE BACK CANNOT WORK.
        //
        // transaction_pin_setup_screen ends onboarding with
        // `Get.offAllNamed(AppRoutes.kycBVNVerification)`, which makes this
        // screen the navigation ROOT — and `_onBack` ends in `Get.back()`. So
        // the arrow was drawn, tapped, and did nothing, at the exact moment the
        // customer is deciding whether to trust the app with money.
        //
        // The screen already reasons about this case everywhere else
        // (`_isOnboardingRoot`, the skip CTA, `KycGateExitCta`); the app bar
        // was the one place that did not. Guarded on canPop rather than on
        // `_onBack != null`: `_onBack` IS a pop, it just clears a pending
        // deposit first.
        automaticallyImplyLeading: false,
        // THE ARROW AND THE ACTION MUST AGREE ABOUT WHICH NAVIGATOR.
        //
        // The guard above was `Navigator.of(context).canPop()` while `_onBack`
        // ends in `Get.back()` — two different navigators. GetX pops its own
        // route stack, so a screen reached in a way GetX did not record, or
        // reached via `Get.offAllNamed` (signup's PIN setup -> KYC) with some
        // other Navigator still able to pop, drew an arrow that did nothing.
        // Reported 2026-11-08 with the arrow visible and inert.
        //
        // Now it asks `_canLeaveBack`, which is the same predicate the rest of
        // the screen already reasons with (`_isOnboardingRoot` — `_fromSignup`
        // OR an unpoppable navigator). And `_onBack` is guaranteed to DO
        // something, so the pair cannot drift apart again.
        // WHITE, because this row sits in the PURPLE band of the curved
        // background. It was _textPrimary, which is now near-black ink — the
        // same contrast failure the capture screen's back arrow had, where a
        // dark arrow on the brand header was invisible until it happened to
        // overlap the white curve.
        leading: _canLeaveBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _onBack,
              )
            : null,
      ),
      body: Stack(
        children: [
          // THE SHARED CURVED GROUND. Same asset as bvn_signup_screen,
          // sign_up_screen, email_sign_in_screen, phone_flow_scaffold and
          // password_recovery — so the identity journey does not change
          // surface halfway through.
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg/up-down-curve-bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            // THE VIEWPORT HEIGHT, so the verified state can push its CTA to the
            // foot of the screen. `Expanded` needs a bounded parent and a scroll
            // view gives none, so without this the verified branch would throw
            // instead of laying out. minHeight subtracts this view's own vertical
            // padding, or the content would be forced a padding taller than the
            // screen and scroll a few pixels for no reason.
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              // 20w side gutters to match the capture screen; the old 16w made
              // the cards sit visibly wider than the ones before them.
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 8.h - 24.h,
                ),
                child: IntrinsicHeight(
                  child: _loadingStatus
                  // A SKELETON, NOT THE REAL SCREEN WITH A PROGRESS BAR.
                  //
                  // This branch used to render the header unconditionally, which
                  // meant an already-verified customer opened a page headed
                  // "Verify Your Identity" — status was still null, so isMaxTier
                  // was false — waited behind a two-pixel progress line, and
                  // watched it rewrite itself into "You're Verified" with a tier
                  // card. The first paint was not a loading state; it was a
                  // confident wrong answer, and the reflow made it look broken.
                  //
                  // Nothing is claimed until the status is known.
                  ? const KycStatusSkeleton()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(
                          title: isMaxTier
                              ? 'You\'re Verified'
                              : 'Verify Your Identity',
                          subtitle: isMaxTier
                              ? 'Your identity is fully verified. You have full access.'
                              : 'Complete a quick, secure check to unlock higher limits and full access',
                        ),
                        if (status != null && status.tier > 0)
                          _buildTierCard(status),
                        if (!isMaxTier) ...[
                          _buildWhatYouNeedCard(),
                          // Surface profile-readiness (valid email required; NG-phone note)
                          // so the user fixes blockers before opening the secure check.
                          _buildReadinessNotices(),
                          SizedBox(height: 18.h),
                          _buildBenefitsSection(status),
                        ],
                        // VERIFIED CONTENT IS SHORT, AND THE GROUND IS NOT.
                        //
                        // up-down-curve-bg.png carries a purple curve at the TOP **and**
                        // one at the BOTTOM. On the capture screen the content is tall
                        // enough to meet the lower curve, so it reads as a frame. In the
                        // verified state there are only two cards, so the column ended
                        // around two-thirds down and the lower curve was left sweeping
                        // through empty white beside the CTA — a stray purple wedge,
                        // which is exactly how it looked on 2026-11-10.
                        //
                        // Expanding here pushes the CTA to the foot of the viewport so the
                        // lower curve frames it as intended. ONLY when verified: the
                        // unverified column is long enough to scroll and keeps its rhythm.
                        if (isMaxTier)
                          const Expanded(child: SizedBox.shrink())
                        else
                          SizedBox(height: 22.h),
                        SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: AppLoadingButton(
                            onPressed: _isSubmitting
                                ? null
                                : (isMaxTier
                                    ? _finishVerified
                                    : _startVerification),
                            isLoading: _isSubmitting,
                            // Tier 3 is the final tier — show a terminal "Done", not a
                            // "Continue" that implies there's a further step. A Tier-2 user
                            // is one liveness/NIN step away from the top, so frame their CTA
                            // explicitly as the upgrade to Tier 3.
                            text: isMaxTier
                                ? 'Done'
                                : (status != null && status.tier >= 2
                                    ? 'Upgrade to Tier 3'
                                    : (status != null && status.tier > 0
                                        ? 'Continue Verification'
                                        : 'Verify Identity')),
                            backgroundColor: _accent,
                            textColor: Colors.white,
                            // Matches the card radius so the CTA belongs to the
                            // same family as everything above it; the default 8
                            // read as a different design next to 18r cards.
                            borderRadius: BorderRadius.circular(16.r),
                            fontSize: 16.sp,
                          ),
                        ),
                        if (!isMaxTier && _allowSkip) ...[
                          SizedBox(height: 16.h),
                          Center(
                            child: TextButton(
                              // A HELD HOLDER IS NOT SKIPPING, AND MUST NOT BE SENT
                              // THROUGH THE SKIP PATH.
                              //
                              // `_allowSkip` admits `_heldForReview` so the button shows
                              // while an operator compares two names. `_skipForNow`'s
                              // authority guard is `!_reachedTier2`, which REFUSES such a
                              // holder — so the button appeared, was tapped, and answered
                              // "Verification required". A control that is present and
                              // inert is worse than an absent one, and this one appeared
                              // at the exact moment the customer is waiting on us.
                              //
                              // It must not simply be admitted into _skipForNow either:
                              // that writes has_skipped_kyc and calls skipKYCUpgrade,
                              // which persists a tier server-side. The hold GRANTS
                              // NOTHING by design — see _heldForReview — so the deferral
                              // is its own path, writing nothing.
                              onPressed: (_heldForReview || _nameRefused) &&
                                      !_reachedTier2
                                  ? _deferWhileUnderReview
                                  : _skipForNow,
                              style: TextButton.styleFrom(
                                foregroundColor: _accent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.h),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              // Prominent TEXT CTA (no border) — consistent with the
                              // email/phone verification skips: clearly secondary to the
                              // primary CTA but easy to find (accent colour, bold, arrow).
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    // "Skip" is the wrong word for a holder whose check
                                    // is RUNNING: nothing is being skipped, they are
                                    // being let go of the screen while they wait.
                                    (_heldForReview || _nameRefused) &&
                                            !_reachedTier2
                                        ? 'Continue to dashboard'
                                        : 'Skip for now',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      color: _accent,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Icon(Icons.arrow_forward_rounded,
                                      size: 18.sp, color: _accent),
                                ],
                              ),
                            ),
                          ),
                        ],
                        // THE ONLY WAY OUT WHEN THERE IS NO OTHER ONE.
                        //
                        // Verification is compulsory below Tier 2 and there is no skip —
                        // correct. But when this screen is ALSO the navigation root
                        // (offAllNamed from signup, or from the post-login router when
                        // kyc_required_on_signup is on), the back arrow pops an empty
                        // stack and nothing else here signs out. Someone who cannot
                        // verify on this device had the app rendered unusable with no
                        // route even back to login.
                        //
                        // Shown only in exactly that corner: root AND no skip. With a
                        // skip, or a stack to pop, there is already a way out.
                        if (_isOnboardingRoot && !_allowSkip)
                          const KycGateExitCta(),

                        // ALWAYS AVAILABLE, not only after a failure.
                        //
                        // The refusal that needs this is the one we can least
                        // classify: Mono returns `data_verification_failed` with
                        // no field and no reason, so a name mismatch looks like
                        // any other failure and the error dialog cannot know to
                        // offer it. And often no dialog appears at all — the
                        // customer closes the widget themselves, or the app is
                        // killed mid-session and resumes here. In every one of
                        // those they are looking at a screen whose only button
                        // repeats what just failed.
                        //
                        // Hidden once verified: there is nothing left to correct,
                        // and the name becomes immutable at that point anyway.
                        if (!isMaxTier && !_reachedTier2)
                          KycUpdateDetailsCta(
                            onReturned: (changed) async {
                              if (!mounted) return;
                              // Re-read the status either way: the profile moved,
                              // and the notices above it are derived from it.
                              setState(() {});
                              if (changed) await _startVerification();
                            },
                          ),
                      ],
                    ),
                  ),
                ),
            ),
            ),
          ),
        ],
      ),
      ),
    ),
    );
  }

  /// Centered logo + title + subtitle header on the dark background.
  /// The operator-published support address, or null when none is set.
  /// See SupportEmailLine — nothing is hardcoded and an unset value removes
  /// the line rather than printing an address nobody monitors.
  String? _supportEmail;

  Future<void> _loadSupportEmail() async {
    try {
      final settings = await SupportApi(serviceLocator<SecureStorageService>())
          .supportSettings();
      if (!mounted) return;
      setState(() => _supportEmail = settings.contactEmail);
    } catch (_) {/* optional by design */}
  }

  Widget _buildHeader({required String title, String? subtitle}) {
    // A HERO CARD, NOT TEXT FLOATING ON THE ARTWORK.
    //
    // The illustration, the title and the subtitle live together on a white
    // card that floats over the curved background — which is what makes the
    // contrast question answerable instead of a guess.
    //
    // The curve's purple band ends at a height that depends on the device's
    // aspect ratio, so "is this text over purple or over white?" has no fixed
    // answer: on a tall phone the title clears the curve, on a short one it
    // does not. Dark ink directly on the artwork is therefore legible on some
    // devices and invisible on others — exactly how the capture screen's
    // "Final step" chip came to be purple-on-purple, legible only where it
    // happened to overlap the white curve.
    //
    // Putting the block on its own opaque surface removes the dependency: the
    // only thing left in the purple band is the back arrow, which is white.
    //
    // The ILLUSTRATION replaces a shield glyph in a haloed disc. The disc was
    // an improvement on the bare app logo that preceded it, but it is still a
    // UI affordance standing in for a picture; the onboarding screens open
    // with real illustrations and this is the same kind of moment — a person
    // deciding whether to hand over their identity. face-verification-scan
    // depicts exactly what the check does (a liveness capture), so it informs
    // rather than decorates.
    final bool verified = _status?.isMaxTier ?? false;
    final Color tone = verified ? _success : _accent;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 4.h, bottom: 14.h),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: verified
                // Verified is a STATE, not an instruction — a scan illustration
                // would tell someone who is already done to do it again.
                ? Container(
                    width: 96.w,
                    height: 96.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: tone.withValues(alpha: 0.12),
                    ),
                    child:
                        Icon(Icons.verified_rounded, color: tone, size: 46.sp),
                  )
                : Image.asset(
                    'assets/images/face-verification-scan.png',
                    width: 104.w,
                    height: 104.w,
                    fit: BoxFit.contain,
                    // A MISSING ASSET MUST NOT BLANK THE HEADER. Asset bundles
                    // have been wrong before (a flavour that did not ship an
                    // image), and this screen gates the account — it has to
                    // render something meaningful either way.
                    errorBuilder: (_, __, ___) => Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tone.withValues(alpha: 0.12),
                      ),
                      child:
                          Icon(Icons.shield_outlined, color: tone, size: 44.sp),
                    ),
                  ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: _textPrimary,
              letterSpacing: -0.4,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            SizedBox(height: 8.h),
            // Held to a readable measure — full-bleed centred body text on a
            // phone wraps into a ragged block that is hard to scan.
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300.w),
                child: Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: _textSecondary,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          // The hero card has its own bottom padding, so the old 22h spacer
          // would double it.
        ],
      ),
    );
  }

  /// What the customer has to have in hand before they start.
  ///
  /// This replaced a single 60-word paragraph that carried four separate
  /// facts — who runs the check, what to have ready, what camera access is
  /// for, what the data is used for — in one unbroken block beside one small
  /// padlock. Nobody reads that on a phone; they skim it, start the check
  /// without their NIN, and abandon it half way. The same four facts are
  /// three scannable rows and one footnote here.
  Widget _buildWhatYouNeedCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What you\'ll need',
            style: GoogleFonts.inter(
              color: _textPrimary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _needRow(
            Icons.badge_outlined,
            'Your BVN and NIN',
            'Both 11-digit numbers, exactly as they are registered.',
          ),
          SizedBox(height: 14.h),
          _needRow(
            Icons.camera_alt_outlined,
            'Camera access',
            'For a quick liveness selfie — no document photo needed.',
          ),
          SizedBox(height: 14.h),
          _needRow(
            Icons.schedule_rounded,
            'About two minutes',
            'Finish all three steps to reach Tier 3 and its highest limits.',
          ),
          SizedBox(height: 16.h),
          // The privacy line is a footnote, not a headline — it reassures,
          // it is not a thing the customer has to go and fetch, so it must
          // not compete with the three rows above it.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lock_outline_rounded,
                  size: 14.sp, color: _textSecondary),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Run by our licensed verification partner. Encrypted, and '
                  'used only for CBN compliance.',
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 11.5.sp,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _needRow(IconData icon, String title, String body) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconChip(icon, size: 36),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: _textPrimary,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                body,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===== Profile readiness (email + NG phone) =====

  /// Lightweight email sanity check — mirrors backend `looksLikeEmail`
  /// (non-empty local part, an "@", a dotted domain). A valid email is a HARD
  /// requirement for Mono Prove (banking-service prove_kyc.go), so we catch a
  /// missing/invalid one here with an actionable message instead of letting the
  /// Prove session start and fail.
  bool _isValidEmail(String s) {
    final v = s.trim();
    final at = v.indexOf('@');
    if (at <= 0 || at >= v.length - 1) return false;
    return v.indexOf('.', at + 1) >= 0;
  }

  /// True when `phone` is a genuine Nigerian mobile (0 + [789] + 9 digits) once
  /// normalised. Mirrors backend `isValidNGMobile`. A non-NG number (e.g. a UK
  /// +44) or a placeholder normalises to something that is NOT an NG mobile —
  /// in that case the backend omits the pre-fill and the Prove widget collects
  /// the BVN-linked phone, so this only drives a reassuring note, never a block.
  bool _looksLikeNGMobile(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    String local;
    if (digits.startsWith('234') && digits.length == 13) {
      local = '0${digits.substring(3)}';
    } else if (digits.startsWith('2340') && digits.length == 14) {
      local = digits.substring(3);
    } else if (digits.length == 10) {
      local = '0$digits';
    } else if (digits.startsWith('0') && digits.length == 11) {
      local = digits;
    } else {
      local = digits;
    }
    return RegExp(r'^0[789]\d{9}$').hasMatch(local);
  }

  ({String email, String phone}) _profileContact() {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      if (profile != null) {
        return (
          email: profile.user.email,
          phone: profile.user.phoneNumber ?? '',
        );
      }
    } catch (_) {/* profile not available yet */}
    return (email: '', phone: '');
  }

  /// Renders readiness notices driven by the profile's email/phone state:
  ///  - a blocking-style warning when the email is missing/invalid (the user
  ///    must fix it before Prove will start), with a CTA to edit their profile;
  ///  - a neutral, reassuring note when the profile phone isn't an NG mobile,
  ///    so a foreign/placeholder-phone user knows they'll enter their Nigerian
  ///    (BVN-linked) number inside the secure check rather than being surprised.
  Widget _buildReadinessNotices() {
    final contact = _profileContact();
    final emailOk = _isValidEmail(contact.email);
    final phoneIsNG = _looksLikeNGMobile(contact.phone);

    final notices = <Widget>[];
    if (!emailOk) {
      notices.add(_buildNoticeCard(
        icon: Icons.alternate_email_rounded,
        color: _warning,
        title: 'Add a valid email first',
        body:
            'Identity verification needs a valid email on your profile. Add or '
            'fix it, then come back to verify.',
        actionLabel: 'Update email',
        onAction: () => Get.toNamed(AppRoutes.myAccount),
      ));
    }
    if (emailOk && !phoneIsNG) {
      // BLOCKING, not informational — and it says so now.
      //
      // This used to promise "during the secure check you'll enter the
      // Nigerian phone number linked to your BVN", which was not true on two
      // counts. Mono Prove requires a valid NG mobile ON THE INITIATE PAYLOAD
      // (an empty one is a 400, "phone should not be empty"), so banking-service
      // refuses BEFORE Mono is ever reached and asks the user to update their
      // profile. There is no in-widget step to enter it at. The customer was
      // told to wait for a prompt that never came, then hit a wall.
      //
      // So it is styled as the blocker it is and carries the same "go fix it"
      // action as the email notice directly above, which has the identical
      // shape: verification cannot start until the profile is right.
      //
      // It does NOT claim the number must be the one on their BVN. Not every
      // Nigerian number is BVN-linked; Mono's FAQ only says you "should
      // ensure" it is, and nothing here compares the two.
      notices.add(_buildNoticeCard(
        icon: Icons.phone_iphone_rounded,
        color: _warning,
        title: 'Add a Nigerian phone number',
        body: 'Verifying a Nigerian identity needs a Nigerian mobile number on '
            'your profile. Add or fix it, then come back to verify. One linked '
            'to your BVN is best if you have it, but it doesn\'t have to be.',
        // WHEN SMS IS OFF, "UPDATE PHONE" GOES NOWHERE.
        //
        // ChangePhoneScreen is entirely OTP-driven and self-disables when
        // SmsPolicy.canChangePhoneNumber is false — so with the platform SMS
        // switch off this notice offered a button to a screen that refuses,
        // on a gate the customer cannot pass without changing the number. No
        // verify, no change, no support route: three dead ends on one card.
        //
        // The sibling notice on kyc_update_details_screen already checks the
        // policy and says so on the row; this one did not. Same answer here,
        // with support as the route that still exists.
        actionLabel:
            SmsPolicy.canChangePhoneNumber ? 'Update phone' : 'Contact support',
        // openKycProfileFix, not a trip through Settings. It is the
        // purpose-built path this screen already uses for a failed check
        // (see the error dialog below), it lands directly on
        // ChangePhoneScreen, and it reports whether the number actually
        // changed - so a user who fixes it is put straight back into
        // verification instead of having to find their way here again.
        onAction: () async {
          if (!SmsPolicy.canChangePhoneNumber) {
            // A human is the only route left: the number must change and the
            // one mechanism for changing it needs an SMS we cannot send.
            await openKycProfileFix(
              KycProfileField.support,
              supportSubject: 'I need a Nigerian phone number on my account',
              supportMessage:
                  'Verification needs a Nigerian mobile number on my profile, '
                  'and I cannot change my number in the app at the moment.\n\n'
                  'Please can you update it so I can finish verifying?',
            );
            if (!mounted) return;
            setState(() {});
            return;
          }
          final changed = await openKycProfileFix(KycProfileField.phone);
          if (!mounted) return;
          if (changed) setState(() {});
        },
      ));
    }
    if (notices.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 12.h),
        for (final n in notices) ...[n, SizedBox(height: 8.h)],
      ],
    );
  }

  /// A compact tinted notice card (warning or info) with an optional CTA.
  Widget _buildNoticeCard({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return _Card(
      tint: color,
      padding: EdgeInsets.all(15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconChip(icon, color: color, size: 34),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: _textPrimary,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      body,
                      style: GoogleFonts.inter(
                        color: _textPrimary.withValues(alpha: 0.82),
                        fontSize: 12.5.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(
                  foregroundColor: color,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  actionLabel,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Shows the user's current tier and what's needed for the next one.
  Widget _buildTierCard(ProveKycStatus status) {
    final bool atTop = status.isMaxTier;
    final Color tone = atTop ? _success : _accent;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        // A soft diagonal wash rather than a flat tint + outline: it separates
        // this card from the neutral ones below it by itself, so it needs no
        // border to be read as "your status".
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tone.withValues(alpha: 0.20),
            tone.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(_radius.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconChip(
                atTop
                    ? Icons.verified_rounded
                    : Icons.workspace_premium_rounded,
                color: tone,
                size: 34,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'You\'re on ${status.tierName}',
                  style: GoogleFonts.inter(
                    color: _textPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // "2 of 3" answers the question the tier name alone leaves open:
              // how much further is there to go?
              Text(
                '${status.tier} of 3',
                style: GoogleFonts.inter(
                  color: tone,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _TierRail(tier: status.tier, tone: tone),
          // A HELD NAME DECISION GETS THE COMPARISON INSTEAD OF THE PARAGRAPH.
          //
          // The server's `message` already contains both names, and still
          // does — builds older than proto fields 17/18 depend on that and
          // there is no floor on how old an install can be. Where the
          // structured names ARE present, two labelled rows answer the
          // customer's actual question (which one is wrong?) far better than
          // a sentence they have to parse, so the card replaces the message
          // rather than printing both and saying it twice.
          // WE CHANGED THEIR NAME — SAY SO, AND LET THEM THROUGH.
          //
          // Checked BEFORE nameUnderReview: both arrive on failureReason and
          // only the reason string separates them, so the resolved case must
          // win or a customer who is already through sees a review card
          // asking them to wait.
          //
          // The CTA is _finishVerified, not a bare navigation. That handler
          // already carries every edge case this screen has: it clears
          // kyc_onboarding_pending, resumes a deposit if that is where they
          // came from (but never from the onboarding root), refreshes the
          // auth profile so Settings does not show a stale Tier 1, refetches
          // the accounts whose NUBANs verification has just minted, and then
          // picks offAllNamed(dashboard) from the onboarding root versus
          // Get.back(true) from Settings. Re-implementing any of that here
          // would be a second, worse copy.
          if (status.nameAutoAdopted) ...[
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                // Nested inside the tier card, so it lifts to _surfaceHigh
                // rather than being outlined — the step up in luminance is
                // what says "this is a panel within a panel".
                color: _surfaceHigh,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const _IconChip(Icons.check_rounded,
                          color: _success, size: 30),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'We used the name on your BVN',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // The two names, labelled, when the server sent them. It
                  // omits one only in the degraded case, and then `message`
                  // carries the same meaning in prose — so the fallback is
                  // the message, never a row with a blank in it.
                  if (status.profileName.isNotEmpty &&
                      status.bvnName.isNotEmpty) ...[
                    _adoptedNameRow('You entered', status.profileName, false),
                    SizedBox(height: 6.h),
                    _adoptedNameRow('Your BVN reads', status.bvnName, true),
                    SizedBox(height: 10.h),
                  ],
                  Text(
                    status.message.isNotEmpty
                        ? status.message
                        : 'Your identity is verified using the name on your '
                            'BVN record.',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: _textSecondary, height: 1.45),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _finishVerified,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        disabledBackgroundColor:
                            _accent.withValues(alpha: 0.55),
                        disabledForegroundColor:
                            Colors.white.withValues(alpha: 0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text('Proceed to dashboard',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (status.nameUnderReview)
            KycNameComparison(
              bvnName: status.bvnName,
              profileName: status.profileName,
              textPrimary: _textPrimary,
              textSecondary: _textSecondary,
              accent: _accent,
              surface: _card,
              correctionReceived: status.nameCorrectionReceived,
              onAdoptBvnName: () => _adoptBvnName(status),
              onRaiseCorrection: () => _raiseNameCorrection(status),
            )
          else if (_nameRefused) ...[
            // A REFUSAL NEEDS A NEXT STEP, NOT JUST A VERDICT.
            //
            // The server deliberately does not echo the BVN holder's name
            // here, so there is no comparison to show and nothing for the
            // customer to adopt or correct — both of those endpoints answer
            // NO_HELD_REVIEW. All we can honestly do is say what happened,
            // say who moves next, and point at the door.
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: _warning.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const _IconChip(Icons.error_outline_rounded,
                          color: _warning, size: 30),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'We could not match your name',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    status.message.isNotEmpty
                        ? status.message
                        : 'The name on your profile did not match the name on '
                            'your BVN record.',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: _textSecondary, height: 1.45),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'You can keep using Lazervault while this is sorted out. '
                    'Tap “Continue to dashboard” below — your account stays on '
                    'Tier 1 until the name is resolved, and you can try '
                    'verification again any time from Settings.',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: _textSecondary, height: 1.45),
                  ),
                ],
              ),
            ),
          ] else if (status.message.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              status.message,
              style: GoogleFonts.inter(
                  color: _textSecondary, fontSize: 12.5.sp, height: 1.4),
            ),
          ],
          // A Tier-2 user is one step (NIN + liveness) from the top — surface an
          // explicit "Upgrade to Tier 3" hint so they know it's reachable from
          // here. (isMaxTier users never see this card with this branch.)
          if (status.tier >= 2 && !status.isMaxTier) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.workspace_premium, size: 16.sp, color: _success),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Upgrade to Tier 3 for the highest, unlimited limits. '
                    'Add your second ID (NIN) and complete the liveness check.',
                    style: GoogleFonts.inter(
                      color: _textPrimary.withValues(alpha: 0.85),
                      fontSize: 12.5.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(ProveKycStatus? status) {
    // When we know what's outstanding for the next tier, show those concrete
    // steps; otherwise show the generic "what you unlock" list.
    final reqs = status?.nextRequirements ?? const [];
    if (reqs.isNotEmpty) {
      return _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'To reach Tier ${status!.nextTier}',
                  style: GoogleFonts.inter(
                    color: _textPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  reqs.length == 1 ? '1 step' : '${reqs.length} steps',
                  style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            // NUMBERED, not a column of identical empty radio circles. The
            // old list used `radio_button_unchecked` for every row, which
            // reads as a set of controls you are meant to tap — on a screen
            // where nothing in that card is tappable. Numbers say "these are
            // the steps, in this order, and there are this many".
            for (var i = 0; i < reqs.length; i++) ...[
              if (i > 0) SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: GoogleFonts.inter(
                        color: _accent,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Text(
                        _requirementLabel(reqs[i]),
                        style: GoogleFonts.inter(
                          color: _textPrimary.withValues(alpha: 0.92),
                          fontSize: 13.5.sp,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What you unlock',
            style: GoogleFonts.inter(
              color: _textPrimary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _buildBenefit(
            icon: Icons.trending_up_rounded,
            title: 'Higher limits',
            // NO FIGURE HERE. This branch runs when the server has told us
            // nothing about the next tier, so we do not know the number — and
            // the per-tier limits are admin-tunable (GET/PUT /kyc/limits), so
            // any constant typed here is wrong the moment an operator edits
            // them. The previous copy promised "up to ₦200,000 daily", which
            // matched no tier in the table.
            description:
                'Send and receive far more once your identity is verified.',
          ),
          SizedBox(height: 14.h),
          _buildBenefit(
            icon: Icons.account_balance_rounded,
            title: 'Your own account number',
            description:
                'Receive bank transfers straight into your Lazervault wallet.',
          ),
          SizedBox(height: 14.h),
          _buildBenefit(
            icon: Icons.lock_open_rounded,
            title: 'Full access',
            description: 'Deposits, withdrawals, cards and every service.',
          ),
        ],
      ),
    );
  }

  /// Sentence-case a server-supplied requirement so the numbered list reads
  /// evenly. The server sends short imperatives ("Add your BVN"); this only
  /// guards against an empty string reaching the row.
  String _requirementLabel(String raw) {
    final t = raw.trim();
    return t.isEmpty ? 'Complete the next step' : t;
  }

  Widget _buildBenefit({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IconChip(icon, size: 36),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: _textPrimary,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Shown BEFORE the Prove flow: verification checks the BVN/NIN + a live selfie
  /// against the holder's official NIBSS/NIMC records, so any mismatch in name,
  /// DOB or the ID number will fail. Returns true only if the user taps Continue.
  Future<bool?> _showPreKycMatchWarning() {
    const purple = Color(0xFF4E03D0);
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        // _surface, not a hardcoded near-black: this dialog opens over the
        // now-light screen, and the literal made it a dark box floating on a
        // white page with ink that no longer contrasts against it.
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: purple.withValues(alpha: 0.18),
                      shape: BoxShape.circle),
                  child:
                      const Icon(Icons.badge_outlined, color: purple, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Before you verify',
                      style: GoogleFonts.inter(
                          color: _textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w700)),
                ),
              ]),
              const SizedBox(height: 16),
              Text(
                'We verify your identity against your official records. Make sure your '
                'details EXACTLY match what is registered on your BVN/NIN:',
                style: GoogleFonts.inter(
                    color: _textPrimary.withValues(alpha: 0.82),
                    fontSize: 13.5,
                    height: 1.45),
              ),
              const SizedBox(height: 12),
              ..._kycMatchPoint('Your full name (spelling + order)'),
              ..._kycMatchPoint('Your date of birth'),
              ..._kycMatchPoint('The BVN / NIN number you enter'),
              ..._kycMatchPoint('A clear, well-lit live selfie of your face'),
              const SizedBox(height: 12),
              Text(
                'If any of these don’t match, verification will fail, that’s the '
                'verification partner, not the app.',
                style: GoogleFonts.inter(
                    color: _textSecondary,
                    fontSize: 12.5,
                    height: 1.4),
              ),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text('Cancel',
                        style: GoogleFonts.inter(
                            color: _textSecondary,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text('Continue',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _kycMatchPoint(String text) => [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.check_circle_outline,
                color: Color(0xFF4E03D0), size: 17),
            const SizedBox(width: 9),
            Expanded(
              child: Text(text,
                  style: GoogleFonts.inter(
                      color: _textPrimary.withValues(alpha: 0.9),
                      fontSize: 13,
                      height: 1.35)),
            ),
          ]),
        ),
      ];

  /// Explain a refused signup NIN, and let the customer choose.
  ///
  /// Returns `true` to carry on into the Prove widget regardless.
  ///
  /// NO NAME IS ECHOED BACK. On a genuine mismatch the server has evidence
  /// that the asker is not the holder of that number, so printing the
  /// holder's name would hand one customer another person's name — the same
  /// reasoning ProveKycStatus already applies to `name_mismatch`, where
  /// bvnName/profileName are deliberately left empty.
  Future<_PendingIdentityAction?> _showPendingIdentityDialog(
      PendingIdentityResult result) {
    final isTaken = result.outcome == PendingIdentityOutcome.alreadyRegistered;
    return showDialog<_PendingIdentityAction>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 14.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _IconChip(
                    isTaken ? Icons.person_off_outlined : Icons.badge_outlined,
                    color: _warning,
                    size: 38,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      isTaken
                          ? 'That NIN is already in use'
                          : 'That NIN does not match your name',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: _textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Text(
                isTaken
                    ? 'This NIN is already linked to another Lazervault '
                        'account. If it is yours, contact support so we can '
                        'sort it out.'
                    : 'The NIN you gave at signup is registered under a '
                        'different name. Check the number, and check that '
                        'your first and last name here are spelt exactly as '
                        'they appear on your NIN.',
                style: GoogleFonts.inter(
                    fontSize: 13.sp, color: _textSecondary, height: 1.5),
              ),
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(ctx).pop(_PendingIdentityAction.fixDetails),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text(isTaken ? 'Contact support' : 'Fix my details',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w700)),
                ),
              ),
              // "CONTINUE ANYWAY" IS WITHHELD FOR AN ALREADY-REGISTERED
              // NUMBER. Prove dedups the same table at COMPLETION
              // (prove_kyc.go), so continuing spends camera permission,
              // liveness and ID entry — plus a billed Mono session — to reach
              // the identical refusal. It stays for a NAME mismatch, which
              // Prove's own check may well accept.
              if (!isTaken) ...[
                SizedBox(height: 6.h),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx)
                        .pop(_PendingIdentityAction.continueAnyway),
                    style:
                        TextButton.styleFrom(foregroundColor: _textSecondary),
                    child: Text('Continue anyway',
                        style: GoogleFonts.inter(
                            fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startVerification() async {
    if (_isSubmitting) return;

    // ALREADY-BLOCKED CUSTOMERS GO THROUGH THE NEW BVN FLOW, NOT THE WIDGET
    // THAT BLOCKED THEM.
    //
    // Everyone who ever failed verification arrives back HERE — from the KYC
    // tile in Settings, from the boot router's pending flag, or from the
    // upgrade prompt a transfer cap now shows. Before this, tapping the CTA
    // put them straight back into the Mono Prove widget: the same hosted
    // session, the same name comparison, the same refusal. The fix shipped
    // for them only helped people who had not started yet.
    //
    // When the admin has the BVN branch on and we hold no BVN for this
    // customer, send them to the identity screen instead. Its three-step
    // consent flow asks Mono for the registry record directly, adopts the
    // registered name (date-of-birth gated) and reaches Tier 2 with an
    // account number — without the widget that refused them.
    //
    // Pushed, not offAllNamed: they may have come from Settings and must get
    // back there. The identity screen's own _nextRoute handles the onboarding
    // case where this screen was the root.
    //
    // THE SERVER'S TIER DECIDES, NOT THIS DEVICE'S KEYSTORE.
    //
    // This first asked only "is a BVN in secure storage?", and
    // SecureStorageService.saveBvn has exactly ONE caller — the new flow's
    // success path. So two large groups had no local BVN despite being
    // verified:
    //
    //   * everyone who reached Tier 2 through the older Mono Prove flow,
    //     which never wrote it;
    //   * anyone who reinstalled or switched device, since the keystore is
    //     per-install.
    //
    // For them, tapping "Upgrade to Tier 3" from Settings was sent back to
    // the BVN capture screen to redo the whole number-and-OTP dance for a
    // BVN the server already holds. A Tier-2 holder wants the LIVENESS check
    // and their NIN — which is exactly what the Prove widget does — so the
    // tier is the fact that matters and it comes from the server.
    //
    // Both signals must say "not verified" before we intercept: the tier
    // (authoritative, survives reinstalls) and the keystore (covers the
    // window where a verification succeeded but the tier sync has not landed
    // yet). A null status means the fetch failed, and 0 then falls through to
    // the keystore check rather than stranding anyone.
    final knownTier = _status?.tier ?? 0;
    if (IdentityKind.active.isBvn && !_skipBvnLookup && knownTier < 2) {
      var haveBvn = false;
      try {
        final stored = await serviceLocator<SecureStorageService>().getBvn();
        haveBvn = stored != null && stored.trim().isNotEmpty;
      } catch (_) {/* unknown — prefer offering the newer path */}
      if (!mounted) return;
      if (!haveBvn) {
        await Get.toNamed(AppRoutes.bvnSignup);
        if (!mounted) return;
        // They may have verified while away; re-read so the card is current.
        await _refreshStatusQuietly();
        return;
      }
    }

    // Pre-flight warning: Mono Prove verifies the BVN/NIN + a live selfie against
    // the holder's OFFICIAL records (NIBSS/NIMC). If the user's full name, date of
    // birth, or BVN/NIN don't EXACTLY match those records, verification will fail.
    // Surface that up front so a genuine data mismatch isn't mistaken for an app
    // bug (this was a real prod confusion point).
    final proceed = await _showPreKycMatchWarning();
    if (proceed != true || !mounted) return;

    // Pre-flight: a valid email is a HARD requirement for Mono Prove. Catch a
    // missing/invalid one HERE — before the camera permission + webview — with
    // an actionable message, instead of opening the secure check only for the
    // backend to reject it with a raw email error.
    final contact = _profileContact();
    if (!_isValidEmail(contact.email)) {
      _showErrorDialog(
        'Add a valid email first',
        'We need a valid email on your profile to verify your identity. '
            'Please add or update it, then try again.',
        primaryLabel: 'Update email',
        onPrimary: () {
          Get.back();
          Get.toNamed(AppRoutes.myAccount);
        },
        showSkip: _fromSignup && _allowSkip,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Resolve the user's name/phone/email captured at signup (best-effort).
    var firstName = '';
    var lastName = '';
    var phone = '';
    var email = '';
    var userId = '';
    var dob = '';
    try {
      final auth = context.read<AuthenticationCubit>();
      final profile = auth.currentProfile;
      if (profile != null) {
        firstName = profile.user.firstName;
        lastName = profile.user.lastName;
        phone = profile.user.phoneNumber ?? '';
        email = profile.user.email;
        userId = profile.user.id;
        dob = profile.user.dateOfBirth ?? '';
      }
    } catch (_) {/* profile not available — backend resolves what it can */}

    // GET THE LEGAL NAME RIGHT BEFORE MONO IS EVER ASKED.
    //
    // Mono requires `customer.name` on initiate and verifies it against the
    // government record, so the name is the claim being checked — not an
    // input the customer can correct inside the widget. The commonest refusal
    // is not a typo but ORDER: NIMC stores firstname/surname separately and a
    // live lookup of a blocked customer returned `firstname: JEREMIAH,
    // surname: JOHN` against a profile reading John / Jeremiah. He confirmed
    // his details repeatedly and was right every time.
    //
    // If a NIN was typed on the signup names page it is stashed, unverified,
    // because no session existed there. Spend it here: the lookup adopts the
    // registry's order server-side, and prove_kyc.go initiates with that name.
    // This runs under the CTA's existing spinner, which is already up.
    final pending = await resolvePendingSignupIdentity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dob,
      phoneNumber: phone,
    );
    if (!mounted) return;
    if (pending.needsAttention) {
      // Stop and say so — but never dead-end. A refusal here means the number
      // and the name disagree, which is the customer's to resolve, and
      // continuing would hit the identical refusal inside the widget with far
      // less explanation. "Continue anyway" is always offered: this check did
      // not exist a week ago and must not become a new way to be stuck.
      setState(() => _isSubmitting = false);
      final choice = await _showPendingIdentityDialog(pending);
      if (!mounted) return;
      switch (choice) {
        case _PendingIdentityAction.continueAnyway:
          setState(() => _isSubmitting = true);
        case _PendingIdentityAction.fixDetails:
          // A CONTROL THAT GOES SOMEWHERE. openKycProfileFix is the
          // purpose-built router this screen already uses for every other
          // refusal: `name` opens KycUpdateDetailsScreen and reports true only
          // once the saved profile actually reads back changed, and `support`
          // opens the ticket screen — the enum value written for exactly
          // "already linked to another account", where retrying submits the
          // same number against the same row and fails identically.
          // SAME THREE-WAY CHOICE AS `_handleFailure`, and the same reason
          // the date of birth comes first when we hold none: the refusal
          // behind `mismatch` IS `IDENTITY_DETAILS_MISMATCH`, which
          // banking-service returns only when there was no date to compare.
          final field =
              pending.outcome == PendingIdentityOutcome.alreadyRegistered
                  ? KycProfileField.support
                  : kycProfileFieldFor(pending.message,
                      code: 'IDENTITY_DETAILS_MISMATCH',
                      profileHasDateOfBirth: dob.trim().isNotEmpty);
          // A ticket the agent can act on. Only reached for a NIN stashed at
          // signup, so the subject can name it precisely.
          // COPY THAT MATCHES THE FIELD. It is only ever used when the
          // destination is a ticket — `support`, or a date of birth the server
          // has locked — and a ticket describing the wrong problem costs a
          // round trip with an agent.
          final changed = await openKycProfileFix(
            field,
            supportSubject: field == KycProfileField.dateOfBirth
                ? 'Please add my date of birth so I can verify'
                : 'NIN already linked to another account',
            supportMessage: field == KycProfileField.dateOfBirth
                ? 'My account has no date of birth, so my NIN cannot be '
                    'checked against one.\n\n'
                    'Please can you add it so I can finish verifying?'
                : 'I gave my NIN during sign-up and was told it is already '
                    'linked to another Lazervault account.\n\n'
                    'The NIN is mine. Please can you check which account holds '
                    'it and release it so I can finish verifying?',
          );
          if (!mounted) return;
          setState(() {});
          // Only re-enter verification when something really changed, so a
          // customer who backed out is not bounced straight into the same
          // refusal.
          if (changed) await _startVerification();
          return;
        case null:
          return;
      }
    } else if (pending.outcome == PendingIdentityOutcome.verified) {
      // The profile name may have just been realigned to the registry's
      // order; re-read it so the session is initiated with what was stored.
      try {
        final profile = context.read<AuthenticationCubit>().currentProfile;
        if (profile != null) {
          firstName = profile.user.firstName;
          lastName = profile.user.lastName;
        }
      } catch (_) {/* keep what we already resolved */}
    }

    // Mono Prove does a live facial/biometric check that calls getUserMedia()
    // inside the webview. If the OS-level camera permission isn't granted FIRST,
    // the widget's SPA throws and renders a generic "client-side exception".
    // Enforce the grant here, before we ever open the webview.
    //
    // ASKED AFTER THE IDENTITY RESOLVE, NOT BEFORE. A refused NIN means we
    // never open the webview at all, so requesting the camera first spent the
    // customer's one permission prompt — the one Android only shows twice —
    // on a session that was about to be stopped anyway, and made the refusal
    // land after an unrelated system dialog.
    final ok = await _ensureCameraPermission();
    if (!mounted) return;
    if (!ok) {
      // The spinner is already up by this point (it was not when this check
      // ran earlier), so it has to come down on a denial or the CTA stays
      // disabled with nothing happening.
      setState(() => _isSubmitting = false);
      return;
    }

    // Pre-fill the BVN the user already entered + verified at signup (stored
    // encrypted) so the Prove widget starts on the ownership/liveness step
    // instead of asking for the number again. Empty if none on file.
    var storedBvn = '';
    try {
      storedBvn = (await serviceLocator<SecureStorageService>().getBvn()) ?? '';
    } catch (_) {/* no stored BVN — the hosted widget will collect it */}

    try {
      // 1) Start the real Mono Prove session. The BVN verified at signup is
      //    passed through when present; otherwise the hosted widget collects it.
      final session = await _prove.initiate(
        idNumber: storedBvn,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        tier: 'tier_1',
      );
      if (!mounted) return;

      // 2) Complete it in an in-app WebView (Prove handles identity capture,
      //    ownership + facial recognition); it redirects to lazervault://kyc/callback.
      final sheetResult = await showDirectPayAuthorizationSheet(
        context: context,
        paymentUrl: session.monoUrl,
        paymentId: session.reference,
        reference: session.reference,
        redirectPath: '/kyc/callback',
        flow: DirectPayFlow.kyc,
      );
      if (!mounted) return;

      // The user closed/cancelled the verification window. Client-side this is
      // INDISTINGUISHABLE from a genuine completion whose success redirect
      // raced or was missed. Don't call complete() (on a true abandon there is
      // no Mono customer yet → raw "customer not found"); instead run the
      // bounded status reconcile, which polls the server /status endpoint
      // (self-heals via GetProveKYCStatus). A real completion lands the tier
      // within a few polls; a true abandon simply advances nothing. The
      // server-side Prove reconciler is the ultimate backstop if the app is
      // gone entirely.
      if (!sheetResult.success) {
        setState(() => _isSubmitting = false);
        // Tell the user what's happening instead of silently returning — this
        // is the single most common path (widget closed) and it used to render
        // as "nothing happened". The long reconcile below keeps checking and
        // surfaces an explicit verified/failed modal when the answer lands.
        _showKycStatusSheet(
          state: 'checking',
          message:
              'We\'re confirming your verification with our identity partner. '
              'This can take a few minutes, you can keep using the app; '
              'we\'ll notify you the moment it completes.',
        );
        _reconcileAfterProcessing();
        return;
      }

      // 3) Read the authoritative result by reference.
      final result = await _prove.complete(reference: session.reference);
      if (!mounted) return;
      setState(() => _isSubmitting = false);

      // Refresh the cached status so the card reflects the new tier.
      _refreshStatusQuietly();

      if (result.verified || result.tier >= 2) {
        // Verified (Tier 2+). Celebrate with the tier-aware message.
        _toast(
          result.message.isNotEmpty
              ? result.message
              : 'Your identity has been verified.',
          color: _success,
        );
        _finishVerified();
      } else if (result.tier >= 1) {
        // Partial progress (Tier 1). Tell them what's left; let them continue.
        setState(() => _status = ProveKycStatus(
              verified: false,
              tier: result.tier,
              tierName: result.tierName,
              completedSteps: result.completedSteps,
              nextTier: result.nextTier,
              nextRequirements: result.nextRequirements,
              message: result.message,
            ));
        _showProgressDialog(result);
      } else if (result.status == 'processing' || result.status == 'pending') {
        // Mono finalises verification asynchronously — don't show a failure.
        // Tell the user it's processing and reconcile the tier via the status
        // endpoint (the mono.prove webhook completes it server-side in seconds).
        _toast(
          result.message.isNotEmpty
              ? result.message
              : 'Your verification is processing. We\'ll update your tier shortly.',
          color: _accent,
        );
        _reconcileAfterProcessing();
      } else {
        _handleFailure(
          'Verification not completed',
          result.message.isNotEmpty
              ? result.message
              : 'We couldn\'t confirm your verification. Please finish the steps in the verification window and try again.',
        );
      }
    } on KycSessionCooldownException catch (e) {
      // A WAIT, NOT A FAILURE — and the difference matters here more than
      // anywhere else on this screen.
      //
      // The customer has just corrected a detail and asked to try again. The
      // only thing in the way is that a session carrying the OLD detail is
      // still inside its billed reuse window, so a fresh one cannot be minted
      // yet. Routing this through _handleFailure would tell somebody who did
      // exactly what we asked that verification failed — and send them to
      // support for a problem that resolves itself on a timer.
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      final retry = await showKycSessionCooldownModal(
        context: context,
        cooldown: e,
      );
      // The modal's button only goes live once the wait has actually elapsed,
      // so a true here cannot bounce straight back into the same refusal.
      if (retry && mounted) await _startVerification();
    } on ProveKycException catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      _handleFailure('We couldn\'t verify your identity', e.message,
          code: e.code);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      // Non-API failures here are almost always the verification service being
      // unreachable (banking-service down / network drop) — show a clear
      // temporarily-unavailable message, not a "check your connection" that
      // wrongly blames the user.
      _handleFailure(
        'Temporarily unavailable',
        'Identity verification is temporarily unavailable right now. Please '
            'try again in a moment.',
      );
    }
  }

  Future<void> _refreshStatusQuietly() async {
    try {
      final st = await _prove.status();
      if (mounted) setState(() => _status = st);
    } catch (_) {/* ignore */}
  }

  /// After a "processing" completion, reconcile the KYC status until Mono's
  /// webhook lands it server-side. Field data: the success webhook arrives
  /// 2.6–15.4 MINUTES after the widget closes — the old 4×3s window was ~75×
  /// too short and read every slow success as a silent failure. Backoff:
  /// 4×3s, then 6×10s, then 8×30s (~5.2 min foreground). Terminal outcomes
  /// surface as explicit modals; on budget exhaustion the user is told the
  /// push will deliver the result.
  bool _reconciling = false;

  Future<void> _reconcileAfterProcessing() async {
    if (_reconciling) return; // one loop at a time — retries re-enter here
    _reconciling = true;
    try {
      await _reconcileLoop();
    } finally {
      _reconciling = false;
    }
  }

  Future<void> _reconcileLoop() async {
    Duration delayFor(int attempt) {
      if (attempt < 4) return const Duration(seconds: 3);
      if (attempt < 10) return const Duration(seconds: 10);
      return const Duration(seconds: 30);
    }

    for (var attempt = 0; attempt < 18; attempt++) {
      await Future.delayed(delayFor(attempt));
      if (!mounted) return;
      try {
        final st = await _prove.status();
        if (!mounted) return;
        setState(() => _status = st);
        if (st.verified || st.tier >= 2) {
          _dismissStatusSheetIfAny();
          // AWAIT the sheet: _finishVerified ends in Get.back(), which pops the
          // TOPMOST route — firing it while the sheet is open would pop the
          // sheet instead of the screen and strand the user here.
          await _showKycStatusSheet(
            state: 'verified',
            message: st.message.isNotEmpty
                ? st.message
                : 'Your identity has been verified.',
          );
          if (!mounted) return;
          _finishVerified();
          return;
        }
        if (st.sessionFailed) {
          // "cancelled" can race a genuine completion (the widget emits cancel
          // when closed AFTER finishing) — give the success webhook a few more
          // polls before surfacing a failure for that reason only.
          if (st.failureReason == 'cancelled' && attempt < 15) {
            continue;
          }
          _dismissStatusSheetIfAny();
          _showKycStatusSheet(
            state: 'failed',
            reason: st.failureReason,
            message: st.message,
          );
          return;
        }
      } catch (_) {/* keep trying within the bound */}
    }
    if (!mounted) return;
    _dismissStatusSheetIfAny();
    _showKycStatusSheet(
      state: 'still_processing',
      message: 'Verification is taking longer than usual. We\'ll send you a '
          'notification the moment it completes, you can safely leave '
          'this screen.',
    );
  }

  /// Context of the currently-presented KYC status sheet (null when none).
  /// Popping via the SHEET'S OWN context (checked mounted) can never pop the
  /// screen itself — a raw rootNavigator.pop() raced user-dismissal and could
  /// eat the KYC screen.
  BuildContext? _statusSheetCtx;
  bool get _statusSheetOpen => _statusSheetCtx != null;

  void _dismissStatusSheetIfAny() {
    final ctx = _statusSheetCtx;
    _statusSheetCtx = null;
    if (ctx != null && ctx.mounted) {
      // Only pop while the sheet's route is actually current — during the
      // ~200ms dismiss animation the context is still mounted but a pop would
      // land on the ROUTE BELOW (this screen).
      final route = ModalRoute.of(ctx);
      if (route != null && route.isCurrent) {
        Navigator.of(ctx).pop();
      }
    }
  }

  /// Explicit, state-keyed status modal for the verification lifecycle:
  /// checking / verified / failed (cancelled | expired | data_mismatch |
  /// rejected) / still_processing.
  Future<void> _showKycStatusSheet({
    required String state,
    String reason = '',
    String message = '',
  }) async {
    if (!mounted) return;
    if (_statusSheetOpen) _dismissStatusSheetIfAny();
    IconData icon;
    Color color;
    String title;
    String body = message;
    var showRetry = false;
    switch (state) {
      case 'verified':
        icon = Icons.verified_rounded;
        color = _success;
        title = 'Identity verified 🎉';
        if (body.isEmpty) body = 'Your identity has been verified.';
        break;
      case 'failed':
        icon = Icons.error_outline_rounded;
        color = const Color(0xFFEF4444);
        showRetry = true;
        switch (reason) {
          case 'cancelled':
            title = 'Verification cancelled';
            if (body.isEmpty) {
              body =
                  'Your last verification attempt was cancelled before it finished. Please try again.';
            }
            break;
          case 'expired':
            title = 'Session expired';
            if (body.isEmpty) {
              body = 'Your verification session expired. Please try again.';
            }
            break;
          case 'rejected':
            title = 'Verification not approved';
            if (body.isEmpty) {
              body =
                  'The facial check couldn\'t be approved. Make sure you\'re in good lighting and try again.';
            }
            break;
          default: // data_mismatch
            title = 'Details didn\'t match';
            if (body.isEmpty) {
              body =
                  'Check that your name, date of birth and BVN/NIN are exactly as they appear on your BVN record, then try again.';
            }
        }
        break;
      case 'still_processing':
        icon = Icons.notifications_active_outlined;
        color = _accent;
        title = 'Still processing';
        break;
      default: // checking
        icon = Icons.hourglass_top_rounded;
        color = _accent;
        title = 'Confirming your verification';
    }
    BuildContext? mine;
    await showAppBottomSheet<void>(
      context: context,
      // _surface — same reason as _showPreKycMatchWarning: a literal dark
      // sheet on a light screen.
      backgroundColor: _surface,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        mine = ctx;
        _statusSheetCtx = ctx;
        return _statusSheetBody(ctx,
            icon: icon,
            color: color,
            title: title,
            body: body,
            state: state,
            showRetry: showRetry);
      },
    );
    // Clear only OUR sheet's context (identity check against this call's own
    // token): a replacement sheet may already have stored its ctx here, and
    // nulling that would let a later dismiss/show pair stack sheets.
    // ignore: use_build_context_synchronously — identity comparison only, the
    // context is never USED after the await.
    if (identical(_statusSheetCtx, mine)) {
      _statusSheetCtx = null;
    }
  }

  Widget _statusSheetBody(BuildContext ctx,
      {required IconData icon,
      required Color color,
      required String title,
      required String body,
      required String state,
      required bool showRetry}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 30.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(icon, color: color, size: 44.sp),
          SizedBox(height: 14.h),
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary)),
          SizedBox(height: 8.h),
          Text(body,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 13.5.sp,
                  height: 1.45,
                  color: _textSecondary)),
          SizedBox(height: 20.h),
          if (showRetry)
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _startVerification();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: const Text('Try again'),
            )
          else
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withValues(alpha: 0.9),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(state == 'verified' ? 'Done' : 'Okay'),
            ),
        ],
      ),
    );
  }

  /// Request camera + microphone BEFORE opening the Prove webview. Returns true
  /// only when camera is granted. Handles denied / permanently-denied cleanly so
  /// the user never lands on Mono's broken "client-side exception" page.
  Future<bool> _ensureCameraPermission() async {
    final cam = await Permission.camera.status;
    if (cam.isGranted) {
      final mic = await Permission.microphone.status;
      if (!mic.isGranted) await Permission.microphone.request();
      return true;
    }

    final result = await Permission.camera.request();
    if (result.isGranted) {
      final mic = await Permission.microphone.status;
      if (!mic.isGranted) await Permission.microphone.request();
      return true;
    }

    if (!mounted) return false;
    if (result.isPermanentlyDenied) {
      _showErrorDialog(
        'Camera access needed',
        'Identity verification uses your camera for a quick liveness check. '
            'Please enable camera access in Settings, then try again.',
        primaryLabel: 'Open Settings',
        onPrimary: () {
          Get.back();
          openAppSettings();
        },
      );
    } else {
      _showErrorDialog(
        'Camera access needed',
        'We need camera access to verify your identity. Please allow it and try again.',
      );
    }
    return false;
  }

  /// True when this screen is the navigation ROOT — i.e. it was reached via
  /// signup's `Get.offAllNamed` (PIN setup -> KYC), so there is nothing to pop
  /// back to. In that case Skip/Done must route forward to the dashboard rather
  /// than `Get.back` (which would strand the user on a dead-end screen).
  bool get _isOnboardingRoot =>
      _fromSignup || !(Navigator.of(context).canPop());

  /// True once the user has reached KYC Tier 2 — i.e. their BVN has been
  /// inserted/verified (which is what mints their virtual account). Reads the
  /// authoritative banking Prove status; defaults to false until it loads so we
  /// stay compulsory when the tier is still unknown.
  bool get _reachedTier2 =>
      (_status?.tier ?? 0) >= 2 || (_status?.verified ?? false);

  /// KYC is COMPULSORY until the user reaches Tier 2 (BVN inserted). Below Tier 2
  /// the step cannot be skipped ANYWHERE it appears — signup, the login gate, or
  /// Settings — because a user must insert their BVN (and get their virtual
  /// account) before deferring. Once at Tier 2+ they may skip and upgrade later
  /// (e.g. Tier 3 liveness) from Settings. This replaces the old onboarding-root
  /// binary so a tier-1 user who quit signup is re-gated (non-skippable) on the
  /// next login, while a Prove-verified user is never force-blocked.
  bool get _allowSkip => _reachedTier2 || _heldForReview || _nameRefused;

  /// True when Prove REFUSED on the name rather than holding it for review.
  ///
  /// WHY THIS IS A THIRD WAY OUT, AND WHY THAT IS NOT A LOOSENING.
  ///
  /// A customer in this state has no action left on this screen. Every
  /// self-service path refuses them, by design:
  ///
  ///   skip            — not Tier 2
  ///   defer           — _heldForReview requires failureReason 'name_review'
  ///                     AND both names; a REFUSAL deliberately omits them,
  ///                     because the server has evidence the asker is not the
  ///                     BVN holder and will not echo that person's name back
  ///   correct my name — banking returns NO_HELD_REVIEW
  ///   adopt BVN name  — banking returns NO_HELD_REVIEW
  ///
  /// So the screen told them to contact support and then kept them on it.
  /// That is not compulsion, it is a trap, and it is a guaranteed drop-off:
  /// reported by a customer who hit exactly this on 2026-11-06 after her name
  /// did not match, tried changing it, and was told to contact support with
  /// nowhere to go.
  ///
  /// The gate's purpose is to make a customer DO something they have not done.
  /// Here there is nothing left for them to do — resolving it is ours. That is
  /// the same reasoning that already admits _heldForReview, and this is the
  /// same situation one step further along: held means we are deciding,
  /// refused means we have decided and only support can move it.
  ///
  /// Nothing is granted. It routes through _deferWhileUnderReview, which
  /// writes no skip flag, calls no skip RPC and changes no tier — they are
  /// still Tier 1 and every money path still gates on that. They can simply
  /// read the rest of the app, and retry verification from Settings when the
  /// name is sorted out.
  bool get _nameRefused => (_status?.failureReason ?? '') == 'name_mismatch';

  /// One labelled name row in the adoption notice.
  ///
  /// The adopted name is emphasised and the entered one is not, so a glance
  /// answers "which one am I now?" without reading the sentence below it.
  Widget _adoptedNameRow(String label, String value, bool emphasised) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.w,
          child: Text(label,
              style: GoogleFonts.inter(fontSize: 12.sp, color: _textSecondary)),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: emphasised ? _textPrimary : _textSecondary,
              fontWeight: emphasised ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  /// True when the verification is HELD on a name review — done on the
  /// customer's side, waiting on ours.
  ///
  /// WHY THIS OPENS THE GATE. Below Tier 2 the step is compulsory, which is
  /// right for someone who has not submitted. A held review is not that
  /// person: they completed a Prove session, passed its facial check, and a
  /// human now has to compare two spellings — which can take days. With skip
  /// gated on Tier 2 alone, and the tier deliberately withheld while a name
  /// decision is outstanding (see proveNameDecisionHoldsTier), such a
  /// customer was pinned to this screen with no skip, nothing to pop back to,
  /// and only "Sign in as someone else" — locked out of the app for a delay
  /// that is entirely ours.
  ///
  /// IT GRANTS NOTHING. The tier stays at 1, so every money gate still reads
  /// an unverified holder and the limits are unchanged; this only decides
  /// whether they may put the screen down while they wait.
  ///
  /// A REFUSAL IS EXCLUDED on purpose. `name_mismatch` means the two records
  /// had nothing in common — the evidence says this is not their BVN — so
  /// that holder stays gated, with the correction sheet as their route.
  bool get _heldForReview => _status?.nameUnderReview ?? false;

  /// Finish a successful/complete verification: clear the onboarding flag and
  /// route to the right place (dashboard when at the onboarding root, otherwise
  /// back to wherever the user came from, e.g. Settings).
  ///
  /// Deposit-resume: when this screen was reached MID-DEPOSIT (the deposit
  /// screen routed here with `{'returnTo': 'deposit'}` and saved a
  /// PendingDeposit), we don't pop into a dead stack — we refresh the KYC tier
  /// / auth profile and route forward to a FRESH deposit screen with
  /// `resumePending: true` so it restores the context and continues the
  /// deposit. Carries the saved selected card the deposit route requires.
  Future<void> _finishVerified() async {
    // Capture the cubit BEFORE any await so we don't touch BuildContext across
    // an async gap (the _deleteFlag await below).
    final auth = context.read<AuthenticationCubit>();
    _refetchAccountsAfterVerification();

    await _deleteFlag('kyc_onboarding_pending');

    final returnTo =
        (Get.arguments is Map) ? (Get.arguments as Map)['returnTo'] : null;
    final pending = serviceLocator<PendingDeposit>();

    // Resume a deposit only when we were sent here from a deposit AND there is
    // a saved context to resume into, and this screen isn't the onboarding
    // root (signup must still land on the dashboard).
    if (returnTo == 'deposit' && pending.pending && !_isOnboardingRoot) {
      // Refresh the auth profile so the app reflects the just-passed KYC and a
      // second attempt won't fail again with KYC_REQUIRED. Best-effort.
      try {
        // BOUNDED. Verification has already succeeded; this read only decides
        // how fresh the profile is when the deposit resumes, and an unbounded
        // wait holds a verified customer on the KYC screen for as long as the
        // socket stays open. `probe` is the tier for an enrichment with a
        // usable fallback — the backend re-checks KYC at the operation
        // boundary either way.
        await auth.refreshProfile().timeout(NetworkTimeouts.probe);
      } catch (_) {/* non-blocking — backend re-checks KYC authoritatively */}
      if (!mounted) return;

      // Rebuild the deposit screen fresh and ask it to resume. The deposit
      // route resolves the card from `args['selectedCard']` (a Map), so the
      // resume marker must live INSIDE that map to survive the resolution —
      // we embed it in the card copy. The PendingDeposit.pending flag is the
      // real source of truth; the marker is the explicit nav signal.
      // offNamed replaces THIS (KYC) route.
      final card = Map<String, dynamic>.from(
        pending.selectedCard ?? const <String, dynamic>{},
      )..['resumePending'] = true;
      // offNamedUntil (not offNamed): this screen was PUSHED on top of the
      // original deposit screen (Get.toNamed in _saveAndGoToKyc), so offNamed
      // would replace only THIS route and leave the stale deposit screen alive
      // beneath the resumed one (leaked controllers + a back-gesture landing on
      // a stale duplicate). Unwind down to the dashboard (the deposit screen's
      // natural parent) and push a single fresh deposit screen to resume.
      Get.offNamedUntil(
        AppRoutes.depositFunds,
        (route) => route.settings.name == AppRoutes.dashboard || route.isFirst,
        arguments: {
          ...card,
          'selectedCard': card,
        },
      );
      return;
    }

    // Refresh the auth profile on EVERY successful completion (not just the
    // deposit-resume branch) so the app reflects the just-upgraded tier the
    // moment the user lands back — the KYC settings tile listens for this and
    // re-reads the fresh tier, so Settings never shows a stale Tier 1.
    try {
      // Bounded for the same reason as the branch above: this is the last
      // thing between a passed verification and the screen the customer is
      // waiting for, so it must not be able to hold the door.
      await auth.refreshProfile().timeout(NetworkTimeouts.probe);
    } catch (_) {/* non-blocking — backend re-checks KYC authoritatively */}
    if (!mounted) return;

    if (_isOnboardingRoot) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.back(result: true);
    }
  }

  /// Pull the account summaries again once verification has passed.
  ///
  /// Verification is what mints the account NUMBERS: accounts-service hears
  /// the tier upgrade and provisions a NUBAN per account, about three seconds
  /// later. The dashboard only refetches when it is re-mounted, and returning
  /// here with `Get.back` does not re-mount it — so the person who had just
  /// verified looked at a card with no number until they pulled to refresh or
  /// relaunched, and reported that their KYC "had not reflected".
  ///
  /// Two silent refreshes: one now, one after the provisioning window. Both
  /// go to the app-wide summaries cubit (provided above the dashboard) so the
  /// instance the cards listen to is the one that changes. Best-effort.
  void _refetchAccountsAfterVerification() {
    AccountCardsSummaryCubit? cubit;
    String? userId;
    String? token;
    try {
      cubit = context.read<AccountCardsSummaryCubit>();
      final auth = context.read<AuthenticationCubit>().state;
      if (auth is AuthenticationSuccess) {
        userId = auth.profile.user.id;
        token = auth.profile.session.accessToken;
      }
    } catch (_) {
      return;
    }
    if (cubit == null || userId == null || userId.isEmpty) return;
    final c = cubit;
    final uid = userId;
    Future<void> refresh() async {
      try {
        if (c.isClosed) return;
        await c.fetchAccountSummaries(
            userId: uid, accessToken: token, silent: true, manualRefresh: true);
      } catch (_) {/* best-effort */}
    }

    unawaited(refresh());
    unawaited(Future.delayed(const Duration(seconds: 8), refresh));
  }

  /// Back from KYC without verifying. When we were sent here mid-deposit, the
  /// deposit screen is still alive UNDER this route, so popping returns the
  /// user to the form cleanly. We DROP the saved PendingDeposit so the deposit
  /// never auto-resumes the link without a completed verification — the user
  /// just sees the form again and can retry (where the gate will re-fire if
  /// they're still unverified). Never strands them on KYC.
  /// True when there is somewhere real to go back to.
  ///
  /// `_isOnboardingRoot` is the screen's own existing answer to "is this the
  /// root", and it already folds in `_fromSignup` — the case
  /// `Navigator.canPop()` alone gets wrong, because signup reaches this screen
  /// through `Get.offAllNamed` and the only thing left behind it is nothing.
  bool get _canLeaveBack => !_isOnboardingRoot;

  /// Leave this screen. NEVER A DEAD TAP.
  ///
  /// This was a bare `Get.back()`. GetX pops GetX's stack; when that stack has
  /// nothing on it the call silently does nothing, and the customer is left
  /// pressing an arrow on a KYC screen — the exact moment they are deciding
  /// whether to trust us with money.
  ///
  /// So it now tries the navigators in the order that matches how this screen
  /// is reached, and ends with a route forward rather than a shrug:
  ///
  ///  1. GetX, for the ordinary `Get.toNamed` push (keeps `Get.back(result:)`
  ///     semantics the callers of this screen rely on);
  ///  2. the ambient Navigator, for a route pushed outside GetX;
  ///  3. the dashboard, when neither can pop. A customer who got here somehow
  ///     and wants out must land somewhere usable. The KYC gate re-fires on
  ///     the next launch while they are below Tier 2, so this defers the
  ///     check, it does not evade it.
  void _onBack() {
    final returnTo =
        (Get.arguments is Map) ? (Get.arguments as Map)['returnTo'] : null;
    if (returnTo == 'deposit') {
      // Drop the saved deposit so it cannot auto-resume a bank link behind an
      // unfinished verification.
      serviceLocator<PendingDeposit>().clear();
    }

    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
      return;
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }
    Get.offAllNamed(AppRoutes.dashboard);
  }

  /// Skip KYC for now. From onboarding we smartly continue to the dashboard and
  /// remember the skip so onboarding doesn't loop; from Settings we just go back.
  ///
  /// Skipping must ALSO settle the user on a sane default tier server-side — a
  /// skipped user is a real, usable account at the base tier, not a tier-less
  /// limbo. We call auth-service's authoritative `SkipKYCUpgrade`, which assigns
  /// the base tier (Tier 1) and returns it. This is best-effort and never blocks
  /// the skip: if the network is down we still advance onboarding (the local
  /// `has_skipped_kyc` flag prevents a loop, and the tier reconciles on the next
  /// authenticated KYC status read).
  /// Lets a holder whose name decision is OUTSTANDING put the screen down.
  ///
  /// Deliberately NOT [_skipForNow]. That path writes `has_skipped_kyc`, calls
  /// `skipKYCUpgrade` (which persists a tier server-side) and deletes
  /// `kyc_onboarding_pending`. All three are wrong here: the hold grants
  /// nothing, the tier stays at 1, every money gate still reads an unverified
  /// holder, and the review is still outstanding — so the gate must come back
  /// on the next launch, where this same deferral will be available again.
  /// Reminded, never sealed in.
  ///
  /// The one thing it keeps from [_skipForNow] is dropping an in-flight
  /// deposit: leaving this screen for the dashboard must not auto-resume a
  /// deposit the holder never completed.
  Future<void> _deferWhileUnderReview() async {
    serviceLocator<PendingDeposit>().clear();
    if (!mounted) return;
    if (_isOnboardingRoot) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.back(result: false);
    }
  }

  Future<void> _skipForNow() async {
    // KYC is COMPULSORY below Tier 2 — there is no skip until the BVN is inserted
    // (which mints the virtual account). This is the authority guard: even if a
    // skip control is ever surfaced below Tier 2, it cannot bypass verification
    // (never clears the pending flag, never routes to the dashboard). At Tier 2+
    // the user may defer and upgrade later from Settings.
    if (!_reachedTier2) {
      // A HELD OR NAME-REFUSED HOLDER CANNOT "INSERT THEIR BVN".
      //
      // The screen body already knows this: it routes exactly this holder to
      // _deferWhileUnderReview rather than here. The error dialog's "Skip for
      // now" did not, so closing it fired a snackbar telling someone to do
      // the one thing their account state forbids — and nothing moved.
      //
      // Same decision as the body, so the two cannot disagree.
      if (_heldForReview || _nameRefused) {
        _deferWhileUnderReview();
        return;
      }
      if (mounted) {
        Get.snackbar(
          'Verification required',
          'Please insert your BVN to activate your account. You can add extra verification later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return;
    }
    // Read the user id synchronously (before any await) so we don't touch the
    // BuildContext across an async gap.
    final userId = context.read<AuthenticationCubit>().userId ?? '';

    await _writeFlag('has_skipped_kyc', 'true');

    // Persist the default tier server-side (authoritative). Best-effort — a
    // failure here must not strand the user mid-onboarding.
    try {
      if (userId.isNotEmpty) {
        await serviceLocator<KYCRepository>().skipKYCUpgrade(userId: userId);
      }
    } catch (_) {
      // Network/auth hiccup — the local skip flag still lets onboarding proceed
      // and the tier reconciles on the next KYC status read.
    }
    if (!mounted) return;

    // Drop any in-flight deposit context unconditionally — a user who skips
    // verification must never auto-resume a deposit without completing it. This
    // also covers the onboarding-root branch (where we leave for the dashboard
    // and would otherwise strand a stale deposit context in the singleton).
    serviceLocator<PendingDeposit>().clear();

    if (_isOnboardingRoot) {
      await _deleteFlag('kyc_onboarding_pending');
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.back(result: false);
    }
  }

  /// Failure handler.
  ///
  /// When the refusal is about the user's OWN profile — no Nigerian phone, no
  /// email, no name — "Try Again" is the wrong button: it re-runs the same
  /// check against the same profile and fails identically. Those get a button
  /// that goes to the editor instead, and a phone change comes back here and
  /// retries on its own, because the user only left to satisfy this screen.
  ///
  /// Everything else keeps Cancel + Try Again; during signup a "Skip for now"
  /// is added so a stuck user can finish onboarding.
  /// [code] is the provider error code when the refusal carried one.
  ///
  /// Preferred over the message text where it exists: a code survives a copy
  /// edit, and the refusals that carry one are the ones where falling through
  /// to "Try Again" is most expensive — see kycProfileFieldFor.
  /// Does the SESSION profile carry a date of birth?
  ///
  /// The session copy, not ProfileCubit's: `UpdateUserProfile`/`GetUserProfile`
  /// answer with the COMMON proto, which has no `date_of_birth` field at all,
  /// so ProfileCubit's user reports null for every holder. This is also the
  /// copy that is read when a verification session is initiated, so it is the
  /// right one to reason about.
  bool _hasDateOfBirthOnFile() {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      return (profile?.user.dateOfBirth ?? '').trim().isNotEmpty;
    } catch (_) {
      // Unknown, not absent. Returning true keeps the previous destination
      // (the name editor) rather than sending a customer who may well have a
      // date of birth into an editor for one.
      return true;
    }
  }

  void _handleFailure(String title, String message, {String? code}) {
    // TELL THE CLASSIFIER WHETHER WE HOLD A DATE OF BIRTH.
    //
    // It decides where an `IDENTITY_DETAILS_MISMATCH` goes, and the right
    // answer depends on this: banking-service refuses a name difference only
    // when it has no date of birth to corroborate with, so a profile with none
    // is unblocked by SUPPLYING one, while a name edit is a guess against a
    // registry spelling the customer is deliberately never shown.
    final field = kycProfileFieldFor(message,
        code: code, profileHasDateOfBirth: _hasDateOfBirthOnFile());
    if (field != KycProfileField.none) {
      _showErrorDialog(
        title,
        message,
        primaryLabel: kycProfileFixLabel(field),
        onPrimary: () async {
          // Close the dialog FIRST. _showErrorDialog only pops it in its
          // default handler, so a custom onPrimary that pushes a screen
          // would stack it on top of a dialog that is still open — and the
          // user would come back to a modal they thought they had dismissed.
          Get.back();
          // The server's own sentence is the best description of the problem
          // we have here, so it becomes the body rather than a paraphrase.
          // Only used when the field is `support`; the editors ignore it.
          final changed = await openKycProfileFix(
            field,
            supportSubject: 'Help with my identity verification',
            supportMessage: 'I cannot complete identity verification.\n\n'
                '$title\n$message\n\n'
                'Please can you help me finish verifying?',
          );
          if (!mounted) return;
          if (changed) _startVerification();
        },
        showSkip: _fromSignup && _allowSkip,
      );
      return;
    }
    _showErrorDialog(title, message, showSkip: _fromSignup && _allowSkip);
  }

  /// Take the BVN record's spelling onto the profile, in one tap.
  ///
  /// Confirmed first, because it rewrites the name on the account — but NOT
  /// treated as risky beyond that: the customer cannot choose the value, only
  /// accept the one the provider already returned. The dialog therefore shows
  /// them exactly what the name will become rather than asking them to trust
  /// a verb.
  Future<void> _adoptBvnName(ProveKycStatus status) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Use your BVN name?'),
        content: Text(
          'Your profile name will become:\n\n${status.bvnName}\n\n'
          'This is the name on the BVN record you just verified against. '
          'Your verification continues automatically.',
          style: TextStyle(fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Use this name'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      // BEHIND THE BLOCKING OVERLAY, like every other identity write.
      //
      // This rewrites the name on the account and re-runs the verification
      // gate on the server. With nothing on screen while it was in flight,
      // a congested cell looked exactly like a tap that did nothing — and
      // the next tap is a SECOND identity write against a provider that
      // counts attempts. The overlay is modal and always comes down.
      final message = await runKycSave<String>(
        context,
        message: 'Updating your name…',
        action: () => _prove.adoptBvnName(),
      );
      if (!mounted) return;
      _toast(
        message.isNotEmpty ? message : 'Your name now matches your BVN record.',
        color: _success,
      );
      // The server re-runs the gate as part of the call, so this re-read
      // picks up the resulting verified state rather than guessing at it.
      await _refreshStatusQuietly();
    } on TimeoutException {
      if (!mounted) return;
      // NOT worded as a refusal: the write may well have landed, and the
      // re-read below is what settles it. Telling someone it failed over a
      // change that applied sends them to support for nothing.
      _toast('That is taking longer than usual. We will check where it got to.',
          color: _danger);
      await _refreshStatusQuietly();
    } on ProveKycException catch (e) {
      if (!mounted) return;
      _toast(e.message, color: _danger);
    } catch (_) {
      if (!mounted) return;
      _toast('We could not update your name just now. Please try again.',
          color: _danger);
    }
  }

  /// Raise the customer's account of a held name mismatch.
  ///
  /// NOT A RENAME. Names are immutable here, so there is nothing for the app
  /// to write — this records what the customer says is wrong, against the
  /// verification an operator is already reviewing. An earlier version of
  /// this card offered "Update my profile name" and sent them to a Settings
  /// field that silently discards the edit; that was the dead end
  /// kyc_profile_fix.dart exists to prevent.
  Future<void> _raiseNameCorrection(ProveKycStatus status) async {
    final result = await showKycNameCorrectionSheet(
      context,
      bvnName: status.bvnName,
      profileName: status.profileName,
    );
    // Dismissed is NOT an empty submission — send nothing at all.
    if (result == null || !mounted) return;
    try {
      // Same reason as _adoptBvnName: the sheet closes, the screen looks
      // idle, and the server's own refusal for a duplicate submission
      // ("you just sent this") is what a second tap earns.
      final message = await runKycSave<String>(
        context,
        message: 'Sending your correction…',
        action: () => _prove.submitNameCorrection(
          claim: result.claim,
          correctName: result.correctName,
          note: result.note,
        ),
      );
      if (!mounted) return;
      _toast(
        message.isNotEmpty
            ? message
            : 'Thanks — we\'ve sent this to the review team.',
        color: _success,
      );
      // Re-read so the card switches to "we have your correction" from the
      // server's own answer rather than optimistically from this screen.
      await _refreshStatusQuietly();
    } on TimeoutException {
      if (!mounted) return;
      _toast('That is taking longer than usual. We will check where it got to.',
          color: _danger);
      await _refreshStatusQuietly();
    } on ProveKycException catch (e) {
      if (!mounted) return;
      // The server's refusals ARE the guidance here ("you just sent this",
      // "we already have it") — shown verbatim.
      _toast(e.message, color: _danger);
    } catch (_) {
      if (!mounted) return;
      _toast('We could not send that just now. Please try again.',
          color: _danger);
    }
  }

  void _toast(String message, {required Color color}) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      messageText: Text(message,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500)),
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      margin: EdgeInsets.all(12.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 3),
    );
  }

  /// Tier-progress dialog (verified a lower tier; shows what's left).
  void _showProgressDialog(ProveCompleteResult result) {
    Get.dialog(
      Dialog(
        backgroundColor: _card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _success.withValues(alpha: 0.15),
                ),
                child: Icon(Icons.trending_up_rounded,
                    color: _success, size: 28.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                'You\'re on ${result.tierName}',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: _textPrimary,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              Text(
                result.message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: _textSecondary, fontSize: 13.5.sp, height: 1.4),
              ),
              SupportEmailLine(
                address: _supportEmail,
                subject: 'Identity verification — could not complete',
                color: _textSecondary,
                linkColor: _accent,
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  if (_fromSignup && _allowSkip)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          _skipForNow();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(
                                color: _textPrimary.withValues(alpha: 0.18)),
                          ),
                        ),
                        child: Text('Skip for now',
                            style: GoogleFonts.inter(
                                color: _textPrimary, fontSize: 14.sp)),
                      ),
                    ),
                  if (_fromSignup && _allowSkip) SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        _startVerification();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text('Continue',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dark, high-contrast error dialog. Primary defaults to "Try Again"; callers
  /// can override it (e.g. "Open Settings"). During signup a "Skip for now"
  /// option is added so a stuck user can continue onboarding.
  void _showErrorDialog(
    String title,
    String message, {
    String primaryLabel = 'Try Again',
    VoidCallback? onPrimary,
    bool showSkip = false,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: _card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _danger.withValues(alpha: 0.15),
                ),
                child: Icon(Icons.error_outline_rounded,
                    color: _danger, size: 28.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: _textPrimary,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              // THE PUBLISHED ADDRESS, ON THE SCREEN WHERE PEOPLE GET STUCK.
              //
              // This dialog is the one a blocked customer actually meets — it
              // is what was on screen when a verified-email user was told to
              // add an email. A ticket is the better channel, but a failure
              // screen that offers only the thing that just failed is a dead
              // end, so the operator's published address sits beside it.
              //
              // Server-provided with no default: unset renders nothing.
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 13.5.sp,
                  height: 1.4,
                ),
              ),
              SupportEmailLine(
                address: _supportEmail,
                subject: 'Identity verification — $title',
                color: _textSecondary,
                linkColor: _accent,
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                              color: _textPrimary.withValues(alpha: 0.18)),
                        ),
                      ),
                      child: Text('Cancel',
                          style: GoogleFonts.inter(
                              color: _textPrimary, fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPrimary ??
                          () {
                            Get.back();
                            _startVerification();
                          },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(primaryLabel,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
              if (showSkip) ...[
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    Get.back();
                    _skipForNow();
                  },
                  child: Text('Skip for now and continue',
                      style: GoogleFonts.inter(
                          color: _textSecondary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
