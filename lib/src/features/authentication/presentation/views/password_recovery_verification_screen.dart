import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/core/data/app_data.dart';

class PasswordRecoveryVerificationScreen extends StatefulWidget {
  final String email;
  final String deliveryMethod;

  const PasswordRecoveryVerificationScreen({
    super.key,
    required this.email,
    this.deliveryMethod = 'SMS',
  });

  @override
  State<PasswordRecoveryVerificationScreen> createState() =>
      _PasswordRecoveryVerificationScreenState();
}

class _PasswordRecoveryVerificationScreenState
    extends State<PasswordRecoveryVerificationScreen> {
  String _verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          switch (state) {
            case PasswordRecoveryCodeVerified():
              // Navigate to create new password screen with reset token
              Get.offAllNamed(
                AppRoutes.createNewPassword,
                arguments: {
                  'email': widget.email,
                  'resetToken': state.resetToken,
                },
              );
              break;

            case AuthenticationFailure():
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

            case PasswordRecoveryResendSuccess():
              // Show success message for code resend
              Get.snackbar(
                'Success',
                state.message,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12.r,
                duration: const Duration(seconds: 2),
              );
              break;

            default:
              break;
          }
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final isLoading = state is PasswordRecoveryVerificationInProgress;
            final isResending = state is PasswordRecoveryResendInProgress;

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
                            'Verify Reset Code',
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
                            'We sent a 6-digit verification code to\n${widget.email}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 8.h),

                          // Delivery method indicator
                          Text(
                            widget.deliveryMethod == 'EMAIL'
                                ? 'Check your email inbox'
                                : 'Check your SMS messages',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 40.h),

                          // Verification Code Input
                          VerificationCodeInput(
                            onChanged: (code) {
                              setState(() {
                                _verificationCode = code;
                              });
                            },
                            onCompleted: (code) {
                              setState(() {
                                _verificationCode = code;
                              });
                              // Auto-submit when all 6 digits are entered
                              context
                                  .read<AuthenticationCubit>()
                                  .verifyPasswordResetCode(
                                    widget.email,
                                    code,
                                  );
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

                          // Verify Button
                          if (!isLoading && _verificationCode.length == 6)
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<AuthenticationCubit>()
                                    .verifyPasswordResetCode(
                                      widget.email,
                                      _verificationCode,
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                minimumSize: Size(double.infinity, 48.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Verify Code',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          SizedBox(height: 16.h),

                          // Resend Code and Back Links Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: isResending || isLoading
                                    ? null
                                    : () {
                                        context
                                            .read<AuthenticationCubit>()
                                            .resendPasswordResetCode(
                                              widget.email,
                                              widget.deliveryMethod,
                                            );
                                      },
                                child: Text(
                                  isResending ? 'Sending...' : 'Resend Code',
                                  style: TextStyle(
                                    color: isResending || isLoading
                                        ? Colors.grey
                                        : Theme.of(context).primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        Get.back();
                                      },
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    color:
                                        isLoading ? Colors.grey : Colors.black54,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
