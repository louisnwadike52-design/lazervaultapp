import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../../core/shared_widgets/app_loading_button.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../funds/domain/services/pending_deposit.dart';
import '../../../funds/presentation/widgets/directpay_authorization_sheet.dart';
import '../../data/services/prove_kyc_http_service.dart';
import '../../domain/repositories/kyc_repository.dart';

/// Dark-theme palette (matches the rest of the app — see the platform conventions).
const Color _bg = Color(0xFF0A0A0A);
const Color _card = Color(0xFF1F1F1F);
const Color _divider = Color(0xFF2D2D2D);
const Color _textPrimary = Colors.white;
const Color _textSecondary = Color(0xFF9CA3AF);
const Color _accent = Color(0xFF6366F1); // KYC indigo accent
const Color _success = Color(0xFF10B981);
const Color _warning = Color(0xFFFB923C);
const Color _danger = Color(0xFFEF4444);

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
  bool _loadingStatus = true;
  bool _fromSignup = false;
  ProveKycStatus? _status;

  @override
  void initState() {
    super.initState();
    // Dark screen: light status-bar icons.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _init();
  }

  Future<void> _init() async {
    final pending = await _readFlag('kyc_onboarding_pending');
    _fromSignup = pending == 'true';
    try {
      final st = await _prove.status();
      if (mounted) setState(() => _status = st);
    } catch (_) {
      // Status is best-effort; the screen still works without it.
    } finally {
      if (mounted) setState(() => _loadingStatus = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;
    final isMaxTier = status?.isMaxTier ?? false;

    return Scaffold(
      backgroundColor: _bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _textPrimary),
          onPressed: _onBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(
                title: isMaxTier ? 'You\'re Verified' : 'Verify Your Identity',
                subtitle: isMaxTier
                    ? 'Your identity is fully verified. You have full access.'
                    : 'Complete a quick, secure check to unlock higher limits and full access',
              ),
              if (_loadingStatus)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const LinearProgressIndicator(
                    minHeight: 2,
                    backgroundColor: _divider,
                    valueColor: AlwaysStoppedAnimation<Color>(_accent),
                  ),
                ),
              if (status != null && status.tier > 0) _buildTierCard(status),
              if (!isMaxTier) ...[
                _buildInfoCard(
                  'You will be guided through a secure check by our verification partner. Have your BVN and NIN handy and allow camera access for a quick liveness check. Completing your BVN, NIN and the liveness check reaches Tier 3, the highest tier with unlimited limits. Your information is encrypted and only used for CBN compliance.',
                ),
                // Surface profile-readiness (valid email required; NG-phone note)
                // so the user fixes blockers before opening the secure check.
                _buildReadinessNotices(),
                SizedBox(height: 18.h),
                _buildBenefitsSection(status),
              ],
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: AppLoadingButton(
                  onPressed: _isSubmitting
                      ? null
                      : (isMaxTier ? _finishVerified : _startVerification),
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
                ),
              ),
              if (!isMaxTier) ...[
                SizedBox(height: 16.h),
                Center(
                  child: TextButton(
                    onPressed: _skipForNow,
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
                          'Skip for now',
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
            ],
          ),
        ),
      ),
    );
  }

  /// Centered logo + title + subtitle header on the dark background.
  Widget _buildHeader({required String title, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16.h),
        Center(
          child: SizedBox(
            width: 70.h,
            height: 70.h,
            child: Image.asset(
              'assets/logo/app_logo.png',
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.account_balance_wallet,
                size: 70,
                color: _accent,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: _textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: _textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(height: 20.h),
      ],
    );
  }

  /// Tinted info panel explaining the secure verification.
  Widget _buildInfoCard(String text) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: _accent, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: _textPrimary.withValues(alpha: 0.85),
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
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
      notices.add(_buildNoticeCard(
        icon: Icons.phone_iphone_rounded,
        color: _accent,
        title: 'Have your Nigerian number ready',
        body:
            'Your profile phone isn\'t a Nigerian number. During the secure '
            'check you\'ll enter the Nigerian phone number linked to your BVN.',
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
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 20.sp),
              SizedBox(width: 10.w),
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
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
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
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user_rounded, size: 18.sp, color: _accent),
              SizedBox(width: 8.w),
              Text(
                'You\'re on ${status.tierName}',
                style: GoogleFonts.inter(
                  color: _textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (status.message.isNotEmpty) ...[
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
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To reach Tier ${status!.nextTier}',
              style: GoogleFonts.inter(
                color: _textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            ...reqs.map((r) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    children: [
                      Icon(Icons.radio_button_unchecked,
                          size: 16.sp, color: _textSecondary),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(r,
                            style: GoogleFonts.inter(
                                color: _textPrimary.withValues(alpha: 0.85),
                                fontSize: 13.sp)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What you unlock',
            style: GoogleFonts.inter(
              color: _textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildBenefit(
            icon: Icons.account_balance_wallet,
            title: 'Higher Limits',
            description: 'Send up to ₦200,000 daily after verification',
          ),
          SizedBox(height: 8.h),
          _buildBenefit(
            icon: Icons.security,
            title: 'Enhanced Security',
            description: 'Keep your account secure with verified identity',
          ),
          SizedBox(height: 8.h),
          _buildBenefit(
            icon: Icons.verified,
            title: 'Full Access',
            description: 'Unlock deposits, withdrawals and all services',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefit({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: _accent),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: _textPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                    color: _textSecondary, fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _startVerification() async {
    if (_isSubmitting) return;

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
        showSkip: _fromSignup,
      );
      return;
    }

    // Mono Prove does a live facial/biometric check that calls getUserMedia()
    // inside the webview. If the OS-level camera permission isn't granted FIRST,
    // the widget's SPA throws and renders a generic "client-side exception".
    // Enforce the grant here, before we ever open the webview.
    final ok = await _ensureCameraPermission();
    if (!ok || !mounted) return;

    setState(() => _isSubmitting = true);

    // Resolve the user's name/phone/email captured at signup (best-effort).
    var firstName = '';
    var lastName = '';
    var phone = '';
    var email = '';
    try {
      final auth = context.read<AuthenticationCubit>();
      final profile = auth.currentProfile;
      if (profile != null) {
        firstName = profile.user.firstName;
        lastName = profile.user.lastName;
        phone = profile.user.phoneNumber ?? '';
        email = profile.user.email;
      }
    } catch (_) {/* profile not available — backend resolves what it can */}

    try {
      // 1) Start the real Mono Prove session. No identity number is sent — the
      //    hosted widget collects the BVN/NIN itself.
      final session = await _prove.initiate(
        idNumber: '',
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

      // If the user closed/cancelled the verification window without finishing,
      // there is no Mono customer yet — don't call complete() (it would fail
      // with a raw "customer not found"). Just reset to the screen quietly.
      if (!sheetResult.success) {
        setState(() => _isSubmitting = false);
        _refreshStatusQuietly();
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
    } on ProveKycException catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      _handleFailure('We couldn\'t verify your identity', e.message);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      _handleFailure(
        'We couldn\'t verify your identity',
        'Something went wrong. Please check your connection and try again.',
      );
    }
  }

  Future<void> _refreshStatusQuietly() async {
    try {
      final st = await _prove.status();
      if (mounted) setState(() => _status = st);
    } catch (_) {/* ignore */}
  }

  /// After a "processing" completion, briefly reconcile the KYC status so the
  /// tier card reflects the verification once the mono.prove webhook lands it
  /// server-side. Bounded (not a continuous poll); stops as soon as the tier
  /// advances or the user leaves the screen.
  Future<void> _reconcileAfterProcessing() async {
    for (var attempt = 0; attempt < 4; attempt++) {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      try {
        final st = await _prove.status();
        if (!mounted) return;
        setState(() => _status = st);
        if (st.verified || st.tier >= 2) {
          _toast('Your identity has been verified.', color: _success);
          _finishVerified();
          return;
        }
      } catch (_) {/* keep trying within the bound */}
    }
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

    await _deleteFlag('kyc_onboarding_pending');

    final returnTo = (Get.arguments is Map)
        ? (Get.arguments as Map)['returnTo']
        : null;
    final pending = serviceLocator<PendingDeposit>();

    // Resume a deposit only when we were sent here from a deposit AND there is
    // a saved context to resume into, and this screen isn't the onboarding
    // root (signup must still land on the dashboard).
    if (returnTo == 'deposit' && pending.pending && !_isOnboardingRoot) {
      // Refresh the auth profile so the app reflects the just-passed KYC and a
      // second attempt won't fail again with KYC_REQUIRED. Best-effort.
      try {
        await auth.refreshProfile();
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
        (route) =>
            route.settings.name == AppRoutes.dashboard || route.isFirst,
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
      await auth.refreshProfile();
    } catch (_) {/* non-blocking — backend re-checks KYC authoritatively */}
    if (!mounted) return;

    if (_isOnboardingRoot) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.back(result: true);
    }
  }

  /// Back from KYC without verifying. When we were sent here mid-deposit, the
  /// deposit screen is still alive UNDER this route, so popping returns the
  /// user to the form cleanly. We DROP the saved PendingDeposit so the deposit
  /// never auto-resumes the link without a completed verification — the user
  /// just sees the form again and can retry (where the gate will re-fire if
  /// they're still unverified). Never strands them on KYC.
  void _onBack() {
    final returnTo = (Get.arguments is Map)
        ? (Get.arguments as Map)['returnTo']
        : null;
    if (returnTo == 'deposit') {
      serviceLocator<PendingDeposit>().clear();
    }
    Get.back();
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
  Future<void> _skipForNow() async {
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

  /// Failure handler. Always offers Cancel + Try Again; during signup it also
  /// offers "Skip for now" so a stuck user can continue onboarding.
  void _handleFailure(String title, String message) {
    _showErrorDialog(title, message, showSkip: _fromSignup);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
              SizedBox(height: 22.h),
              Row(
                children: [
                  if (_fromSignup)
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
                                color: Colors.white.withValues(alpha: 0.15)),
                          ),
                        ),
                        child: Text('Skip for now',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 14.sp)),
                      ),
                    ),
                  if (_fromSignup) SizedBox(width: 12.w),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 13.5.sp,
                  height: 1.4,
                ),
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
                              color: Colors.white.withValues(alpha: 0.15)),
                        ),
                      ),
                      child: Text('Cancel',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 14.sp)),
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
