import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/core/data/app_data.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String? email;

  const EmailVerificationScreen({super.key, this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize the cubit state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmailVerificationCubit>().updateVerificationCode('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation - verification is mandatory
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<EmailVerificationCubit, EmailVerificationState>(
          listener: (context, state) {
            switch (state) {
              case EmailVerificationSuccess():
                // Navigate to passcode setup on success
                Get.offAllNamed(AppRoutes.passcodeSetup);
                break;

              // Skip case removed - verification is now mandatory
              // case EmailVerificationSkipped():
              //   Get.offAllNamed(AppRoutes.passcodeSetup);
              //   break;

              case EmailVerificationFailure():
              // Show error message
              Get.snackbar(
                'Error',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 3),
              );
              break;

            case EmailVerificationInProgress():
              if (state.errorMessage.isNotEmpty) {
                Get.snackbar(
                  'Error',
                  state.errorMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                  duration: const Duration(seconds: 3),
                );
              }
              if (state.successMessage.isNotEmpty) {
                Get.snackbar(
                  'Success',
                  state.successMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                  duration: const Duration(seconds: 2),
                );
              }
              break;

            default:
              break;
          }
        },
        child: BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
          builder: (context, state) {
            final isLoading = state is EmailVerificationInProgress && state.isLoading;
            final isResending = state is EmailVerificationInProgress && state.isResending;

            return Stack(
              children: [
                // Background - white color
                Positioned.fill(
                  child: Container(
                    color: Colors.white,
                  ),
                ),

                // Content
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 48.h),

                          // Logo
                          Center(
                            child: UniversalImageLoader(
                              imagePath: AppData.appLogo,
                              width: 120.w,
                              height: 120.h,
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Title
                          Text(
                            'Verify Your Email',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 8.h),

                          // Subtitle
                          Text(
                            widget.email != null
                                ? 'We sent a verification code to\n${widget.email}'
                                : 'Enter the verification code sent to your email',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 40.h),

                          // Verification Code Input
                          VerificationCodeInput(
                            onChanged: (code) {
                              context
                                  .read<EmailVerificationCubit>()
                                  .updateVerificationCode(code);
                            },
                            onCompleted: (code) {
                              context
                                  .read<EmailVerificationCubit>()
                                  .updateVerificationCode(code);
                              // Auto-submit when all 6 digits are entered
                              context
                                  .read<EmailVerificationCubit>()
                                  .verifyEmail();
                            },
                          ),

                          SizedBox(height: 24.h),

                          // Loading Indicator
                          if (isLoading)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if (!isLoading) SizedBox(height: 24.h),

                          // Resend Code Button - Centered (Skip removed - verification is mandatory)
                          Center(
                            child: TextButton(
                              onPressed: isResending || isLoading
                                  ? null
                                  : () {
                                      context
                                          .read<EmailVerificationCubit>()
                                          .resendVerificationEmail();
                                    },
                              child: Text(
                                isResending
                                    ? 'Sending...'
                                    : 'Resend Code',
                                style: TextStyle(
                                  color: isResending || isLoading
                                      ? Colors.grey
                                      : Theme.of(context).primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
