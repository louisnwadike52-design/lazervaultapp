import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/logger.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';

/// Mandatory BVN capture in the signup flow — sits AFTER the personal-info /
/// transaction-PIN steps and BEFORE dashboard access.
///
/// The BVN is verified independently (auth-service `verifyIdentity` → banking,
/// which mints the Flutterwave virtual account off a valid BVN) so a real NUBAN
/// exists before the user reaches the dashboard. On success we persist the BVN
/// (encrypted) via [SecureStorageService.saveBvn] so the optional Mono Prove
/// widget can pre-fill it instead of starting empty.
///
/// Mono KYC remains skippable; the BVN here is not. Flutterwave's VA creation
/// only needs the BVN (name/DOB come from the earlier signup pages), so this
/// screen collects nothing else.
class BVNSignupScreen extends StatelessWidget {
  const BVNSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KYCCubit>(
      create: (_) => serviceLocator<KYCCubit>(),
      child: const _BVNSignupView(),
    );
  }
}

class _BVNSignupView extends StatefulWidget {
  const _BVNSignupView();

  @override
  State<_BVNSignupView> createState() => _BVNSignupViewState();
}

class _BVNSignupViewState extends State<_BVNSignupView> {
  static const Color _brandPurple = Color(0xFF4834D4);
  static const Color _brandPurpleDeep = Color(0xFF2D2B6B);

  final TextEditingController _bvnController = TextEditingController();
  final FocusNode _bvnFocus = FocusNode();

  bool _obscure = false;
  bool _submitting = false;
  String? _inlineError;

  bool get _isValid => _bvnController.text.trim().length == 11;

  @override
  void initState() {
    super.initState();
    _bvnController.addListener(() {
      if (_inlineError != null) setState(() => _inlineError = null);
      setState(() {}); // refresh CTA enabled-state + counter
    });
    AppLogger.event('kyc_bvn_signup', 'screen_open', screen: 'bvn_signup');
  }

  @override
  void dispose() {
    _bvnController.dispose();
    _bvnFocus.dispose();
    super.dispose();
  }

  ({String firstName, String lastName, String phone, String userId})
      _profile() {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      if (profile != null) {
        return (
          firstName: profile.user.firstName,
          lastName: profile.user.lastName,
          phone: profile.user.phoneNumber ?? '',
          userId: profile.user.id,
        );
      }
    } catch (_) {/* profile not available yet — backend resolves what it can */}
    return (firstName: '', lastName: '', phone: '', userId: '');
  }

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    final bvn = _bvnController.text.trim();
    if (bvn.length != 11) {
      setState(() => _inlineError = 'Your BVN must be exactly 11 digits.');
      return;
    }
    final p = _profile();
    setState(() {
      _submitting = true;
      _inlineError = null;
    });
    AppLogger.event('kyc_bvn_signup', 'verify_start', screen: 'bvn_signup');
    context.read<KYCCubit>().verifyID(
          IDVerificationRequest(
            userId: p.userId,
            idType: IDType.bvn,
            idNumber: bvn,
            firstName: p.firstName,
            lastName: p.lastName,
            // Flutterwave VA creation needs only the BVN; DOB comes from the
            // earlier signup pages and is validated server-side against records.
            dateOfBirth: '',
            phoneNumber: p.phone,
          ),
        );
  }

  Future<void> _onVerified() async {
    // Persist the verified BVN (encrypted) so the optional Mono Prove widget can
    // pre-fill it later instead of starting empty.
    try {
      await serviceLocator<SecureStorageService>()
          .saveBvn(_bvnController.text.trim());
    } catch (_) {/* non-fatal — verification already succeeded server-side */}
    AppLogger.event('kyc_bvn_signup', 'verify_success', screen: 'bvn_signup');
    if (!mounted) return;
    final args = Get.arguments;
    final next = (args is Map && args['nextRoute'] is String)
        ? args['nextRoute'] as String
        : AppRoutes.dashboard;
    Get.offAllNamed(next);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KYCCubit, KYCState>(
      listener: (context, state) {
        if (state is IDVerificationSuccess) {
          _onVerified();
        } else if (state is KYCError) {
          setState(() {
            _submitting = false;
            _inlineError = (state.userMessage != null &&
                    state.userMessage!.isNotEmpty)
                ? state.userMessage
                : 'We couldn\'t verify that BVN. Please check it and try again.';
          });
          AppLogger.event('kyc_bvn_signup', 'verify_error',
              level: 'warn', screen: 'bvn_signup');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF6F5FB),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg/up-down-curve-bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          SizedBox(height: 20.h),
                          _buildMatchBanner(),
                          SizedBox(height: 16.h),
                          _buildBvnCard(),
                          SizedBox(height: 16.h),
                          _buildPrivacyNote(),
                        ],
                      ),
                    ),
                  ),
                  _buildStickyCta(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: Colors.black87),
            onPressed: _submitting ? null : () => Get.back(),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: _brandPurple.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Final step',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _brandPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_brandPurple, _brandPurpleDeep],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: _brandPurple.withValues(alpha: 0.28),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(Icons.verified_user_rounded, color: Colors.white, size: 28.sp),
        ),
        SizedBox(height: 16.h),
        Text(
          'Verify your identity',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
            height: 1.1,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter your Bank Verification Number (BVN) to activate your account. '
          'This creates your secure account number and unlocks deposits, '
          'transfers and withdrawals.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildMatchBanner() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFF6C453), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_rounded, color: const Color(0xFFB7791F), size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Your name and date of birth must match the records linked to '
              'this BVN. Mismatched details will fail verification.',
              style: TextStyle(
                fontSize: 12.5.sp,
                color: const Color(0xFF7A5A12),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBvnCard() {
    final hasError = _inlineError != null;
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Verification Number',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: _bvnController,
            focusNode: _bvnFocus,
            enabled: !_submitting,
            keyboardType: TextInputType.number,
            obscureText: _obscure,
            maxLength: 11,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Colors.black87,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            decoration: InputDecoration(
              counterText: '',
              hintText: '2 2 2 2 2 2 2 2 2 2 2',
              hintStyle: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 2,
                color: Colors.black26,
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Icon(Icons.pin_rounded,
                  color: _brandPurple.withValues(alpha: 0.7), size: 20.sp),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: Colors.black38,
                  size: 20.sp,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
              filled: true,
              fillColor: const Color(0xFFF6F5FB),
              contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFE53935) : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: hasError ? const Color(0xFFE53935) : _brandPurple,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  hasError
                      ? _inlineError!
                      : 'Dial *565*0# on your registered line to get your BVN.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: hasError ? const Color(0xFFE53935) : Colors.black45,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${_bvnController.text.trim().length}/11',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600,
                  color: _isValid ? const Color(0xFF10B981) : Colors.black38,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lock_rounded, size: 15.sp, color: Colors.black38),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'Your BVN is encrypted and used only to verify your identity. '
            'We never see or store your banking password.',
            style: TextStyle(
              fontSize: 11.5.sp,
              color: Colors.black45,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyCta() {
    final enabled = _isValid && !_submitting;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brandPurple, _brandPurpleDeep],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: _brandPurple,
            disabledBackgroundColor: Colors.white.withValues(alpha: 0.55),
            disabledForegroundColor: _brandPurple.withValues(alpha: 0.5),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
          ),
          onPressed: enabled ? _submit : null,
          child: _submitting
              ? LazerVaultLoader(size: 22)
              : Text(
                  'Verify & Continue',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
