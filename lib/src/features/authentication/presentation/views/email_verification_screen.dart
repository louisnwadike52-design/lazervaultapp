import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_state.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
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
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the cubit state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmailVerificationCubit>().updateVerificationCode('');
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<EmailVerificationCubit, EmailVerificationState>(
        listener: (context, state) {
          switch (state) {
            case EmailVerificationSuccess():
              Get.snackbar(
                'Success',
                'Email verified successfully!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: EdgeInsets.all(15.w),
                borderRadius: 10.r,
              );
              // Navigate to dashboard
              Get.offAllNamed(AppRoutes.dashboard);
              break;

            case EmailVerificationSkipped():
              // Navigate to dashboard even if skipped
              Get.offAllNamed(AppRoutes.dashboard);
              break;

            case EmailVerificationInProgress():
              if (state.errorMessage.isNotEmpty) {
                Get.snackbar(
                  'Error',
                  state.errorMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
                );
              }
              if (state.successMessage.isNotEmpty) {
                Get.snackbar(
                  'Success',
                  state.successMessage,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(15.w),
                  borderRadius: 10.r,
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 60.h),

                          // Logo
                          Center(
                            child: UniversalImageLoader(
                              imagePath: AppData.appLogo,
                              width: 120.w,
                              height: 120.h,
                            ),
                          ),

                          SizedBox(height: 40.h),

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

                          SizedBox(height: 12.h),

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
                          BuildFormField(
                            name: 'verification_code',
                            placeholder: 'Enter 6-digit code',
                            labelText: 'Verification Code',
                            controller: _codeController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 6,
                            onChanged: (value) {
                              context
                                  .read<EmailVerificationCubit>()
                                  .updateVerificationCode(value);
                            },
                          ),

                          SizedBox(height: 20.h),

                          // Resend Code Button
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: isResending
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
                                  color: isResending
                                      ? Colors.grey
                                      : Theme.of(context).primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),

                          // Verify Button
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context
                                        .read<EmailVerificationCubit>()
                                        .verifyEmail();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Verify Email',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),

                          SizedBox(height: 16.h),

                          // Skip Button
                          OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    // Show confirmation dialog
                                    _showSkipConfirmationDialog(context);
                                  },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.5,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Skip for Now',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          SizedBox(height: 40.h),
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

  void _showSkipConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Skip Email Verification?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'You can verify your email later from your profile settings. Some features may be limited until you verify your email.',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<EmailVerificationCubit>().skipVerification();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
