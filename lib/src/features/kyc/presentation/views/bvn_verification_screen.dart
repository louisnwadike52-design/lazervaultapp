import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/shared_widgets/app_loading_button.dart';
import '../../../widgets/build_form_field.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../domain/entities/kyc_tier_entity.dart';
import '../cubits/kyc_cubit.dart';
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
  void initState() {
    super.initState();
    // Set status bar icons to dark (for light background)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg/up-down-curve-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          BlocListener<KYCCubit, KYCState>(
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

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 60.h),

                        // Logo
                        Center(
                          child: Container(
                            width: 70.h,
                            height: 70.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Image.asset(
                              'assets/logo/app_logo.png',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.account_balance_wallet, size: 70),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Title
                        Text(
                          "Verify Your Identity",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          "Enter your BVN to complete Tier 2 verification",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 32.h),

                        // BVN Info Card
                        _buildBVNInfoCard(context),

                        SizedBox(height: 24.h),

                        // BVN Input Field
                        BuildFormField(
                          name: "bvn",
                          placeholder: "Enter your 11-digit BVN",
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(Icons.badge, color: Colors.black45),
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

                        // Benefits
                        _buildBenefitsSection(context),

                        SizedBox(height: 32.h),

                        // Terms Checkbox
                        _buildTermsCheckbox(context),

                        SizedBox(height: 24.h),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: AppLoadingButton(
                            onPressed: isLoading ? null : _submitBVN,
                            isLoading: isLoading,
                            text: 'Verify BVN',
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Skip Button
                        Center(
                          child: TextButton(
                            onPressed: () => _skipForNow(context),
                            child: Text(
                              'Skip for now',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Already have account link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already verified?",
                              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.dashboard),
                              child: Text(
                                "Go to Dashboard",
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBVNInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'We verify your BVN securely with our partner. Your information is encrypted and only used for CBN compliance.',
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
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

  Widget _buildTermsCheckbox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            activeColor: Colors.blue,
            value: _acceptTerms,
            onChanged: (value) => setState(() => _acceptTerms = value ?? false),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _acceptTerms = !_acceptTerms),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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

    // Create verification session with Mono
    cubit.createVerificationSession(
      userId: userId,
      targetTier: KYCTier.tier2,
      countryCode: 'NG',
      idType: IDType.bvn,
      idNumber: _bvnController.text.trim(),
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      dateOfBirth: dateOfBirth ?? '',
      phoneNumber: phoneNumber,
    );
  }

  void _handleSessionCreated(BuildContext context, VerificationSession session) {
    if (!mounted) return;

    // Navigate to Mono identity verification
    if (session.sessionUrl != null && session.sessionUrl!.isNotEmpty) {
      _navigateToMonoVerification(context, session);
    }
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
