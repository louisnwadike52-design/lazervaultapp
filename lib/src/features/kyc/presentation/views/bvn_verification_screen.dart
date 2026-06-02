import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../widgets/build_form_field.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../domain/entities/kyc_tier_entity.dart';
import '../cubits/kyc_cubit.dart';
import '../widgets/light_theme/kyc_header.dart';
import '../widgets/light_theme/kyc_info_card.dart';
import '../widgets/light_theme/kyc_light_scaffold.dart';
import '../widgets/light_theme/kyc_primary_button.dart';
import '../widgets/light_theme/kyc_skip_button.dart';
import '../widgets/light_theme/kyc_terms_checkbox.dart';
import 'mono_identity_screen.dart';

/// New BVN Verification Screen - Matches Signup Theme
/// Light background, BuildFormField widgets, no name/DOB fields (already collected)
class BVNVerificationScreen extends StatefulWidget {
  const BVNVerificationScreen({super.key});

  @override
  State<BVNVerificationScreen> createState() => _BVNVerificationScreenState();
}

class _BVNVerificationScreenState extends State<BVNVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bvnController = TextEditingController();
  bool _acceptTerms = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KycLightScaffold(
      child: BlocListener<KYCCubit, KYCState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is IDVerificationSuccess) {
            _handleVerificationSuccess(context, state.response);
          } else if (state is VerificationSessionCreated) {
            _handleSessionCreated(context, state.session);
          } else if (state is VerificationConfirmed) {
            _handleVerificationConfirmed(context);
          } else if (state is KYCError) {
            _showErrorDialog(context, state);
          }
        },
        child: BlocBuilder<KYCCubit, KYCState>(
          builder: (context, state) {
            final isLoading = state is KYCLoading;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const KycHeader(
                    title: 'Verify Your Identity',
                    subtitle: 'Enter your BVN to complete Tier 2 verification',
                  ),
                  const KycInfoCard(
                    icon: Icons.info_outline,
                    text:
                        'We verify your BVN securely with our partner. Your information is encrypted and only used for CBN compliance.',
                  ),
                  SizedBox(height: 24.h),
                  BuildFormField(
                    name: 'bvn',
                    placeholder: 'Enter your 11-digit BVN',
                    keyboardType: TextInputType.number,
                    prefixIcon:
                        const Icon(Icons.badge, color: Colors.black45),
                    controller: _bvnController,
                    maxLength: 11,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'BVN is required';
                      }
                      if (value.length != 11) {
                        return 'BVN must be 11 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildBenefitsSection(context),
                  SizedBox(height: 32.h),
                  KycTermsCheckbox(
                    value: _acceptTerms,
                    onChanged: (v) => setState(() => _acceptTerms = v),
                  ),
                  SizedBox(height: 24.h),
                  KycPrimaryButton(
                    text: 'Verify BVN',
                    onPressed: isLoading ? null : _submitBVN,
                    isLoading: isLoading,
                  ),
                  SizedBox(height: 16.h),
                  KycSkipButton(onPressed: () => _skipForNow(context)),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already verified?',
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.black54),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.dashboard),
                        child: Text(
                          'Go to Dashboard',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why verify your BVN?',
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildBenefit(
            icon: Icons.account_balance_wallet,
            title: 'Higher Limits',
            description: 'Send up to ₦500,000 daily after verification',
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
            description: 'Unlock all features and services',
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
        Icon(
          icon,
          size: 16.sp,
          color: Colors.black54,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _submitBVN() {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      Get.snackbar(
        'Terms Required',
        'Please accept the terms to continue',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final authCubit = context.read<AuthenticationCubit>();
    final cubit = context.read<KYCCubit>();
    final userId = authCubit.userId ?? '';

    // Get user data from signup state
    String? firstName;
    String? lastName;
    String? dateOfBirth;
    String? phoneNumber;

    final authState = authCubit.state;
    if (authState is SignUpInProgress) {
      firstName = authState.firstName;
      lastName = authState.lastName;
      dateOfBirth = authState.selectedDate?.toIso8601String();
      phoneNumber = authState.phoneNumber;
    } else if (authCubit.currentProfile != null) {
      firstName = authCubit.currentProfile!.user.firstName;
      lastName = authCubit.currentProfile!.user.lastName;
      // dateOfBirth is not stored in User entity, will be retrieved from backend
      phoneNumber = authCubit.currentProfile!.user.phoneNumber;
    }

    // Strip non-digits (defensive — paste may include hyphens/spaces).
    final cleanBvn =
        _bvnController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');

    cubit.createVerificationSession(
      userId: userId,
      targetTier: KYCTier.tier2,
      countryCode: 'NG',
      idType: IDType.bvn,
      idNumber: cleanBvn,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      dateOfBirth: dateOfBirth ?? '',
      phoneNumber: phoneNumber,
    );
  }

  void _handleSessionCreated(BuildContext context, VerificationSession session) {
    if (!mounted) return;

    // Navigate to Mono identity verification.
    if (session.sessionUrl != null && session.sessionUrl!.isNotEmpty) {
      _navigateToMonoVerification(context, session);
      return;
    }
    // No URL came back — surface to the user instead of silently leaving
    // the button stuck on the loading state. The cubit will not emit
    // another terminal state from here, so we have to drop the spinner
    // ourselves.
    setState(() => _isSubmitting = false);
    Get.snackbar(
      'Verification unavailable',
      'We couldn\'t start the verification. Please try again.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  void _navigateToMonoVerification(BuildContext context, VerificationSession session) {
    final authCubit = context.read<AuthenticationCubit>();

    // Navigate to Mono identity screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<KYCCubit>(),
          child: MonoIdentityScreen(
            sessionToken: session.sessionToken!,
            verificationId: session.verificationId,
            userName: '${authCubit.currentProfile?.user.firstName ?? ''} ${authCubit.currentProfile?.user.lastName ?? ''}'.trim(),
            userEmail: authCubit.currentProfile?.user.email ?? '',
            onSuccess: (authCode) {
              // Confirm verification with Mono auth code
              context.read<KYCCubit>().confirmVerification(
                verificationId: session.verificationId,
                provider: 'mono',
                providerAuthCode: authCode,
              );
              // Navigate to dashboard after successful verification
              Get.offAllNamed(AppRoutes.dashboard);
            },
            onClose: () {
              setState(() => _isSubmitting = false);
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  void _handleVerificationSuccess(BuildContext context, VerifyIDResponse response) {
    setState(() => _isSubmitting = false);

    Get.snackbar(
      'BVN Verification',
      response.message ?? 'Verification submitted successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    // Navigate to dashboard after success
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.dashboard);
    });
  }

  void _handleVerificationConfirmed(BuildContext context) {
    setState(() => _isSubmitting = false);

    Get.snackbar(
      'Verification Complete',
      'Your identity has been verified successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    // Navigate to dashboard
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.dashboard);
    });
  }

  void _skipForNow(BuildContext context) {
    final cubit = context.read<KYCCubit>();
    final authCubit = context.read<AuthenticationCubit>();
    final userId = authCubit.userId ?? '';

    // Call backend to skip KYC
    cubit.skipKYCUpgrade(userId: userId, skipTier2: true);

    // Navigate to dashboard directly
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void _showErrorDialog(BuildContext context, KYCError state) {
    setState(() => _isSubmitting = false);

    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Container(
                width: 40.h,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Verification Failed',
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            state.userMessage ?? state.failure.message,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: Colors.black54,
                  fontSize: 14.sp,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                // Retry
                _submitBVN();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
