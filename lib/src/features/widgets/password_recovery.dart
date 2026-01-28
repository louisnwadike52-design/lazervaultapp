import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  String _deliveryMethod = 'SMS'; // Default to SMS
  String _email = ''; // Store email locally

  @override
  void initState() {
    super.initState();
    // Initialize forgot password state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationCubit>().startForgotPassword();
    });
  }

  void _showErrorSnackbar(String title, String message) {
    if (mounted && Get.isSnackbarOpen == false) {
      Get.snackbar(
        title,
        message,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  void _showSuccessSnackbar(String title, String message) {
    if (mounted && Get.isSnackbarOpen == false) {
      Get.snackbar(
        title,
        message,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(15.w),
        borderRadius: 10.r,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordResetEmailSent) {
          _showSuccessSnackbar(
            'Code Sent',
            'Please check your ${_deliveryMethod == 'EMAIL' ? 'email' : 'SMS'} for verification code',
          );
          // Navigate to verification screen with stored email
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted && _email.isNotEmpty) {
              Get.toNamed(
                AppRoutes.passwordRecoveryVerification,
                arguments: {
                  'email': _email,
                  'deliveryMethod': _deliveryMethod,
                },
              );
            }
          });
        } else if (state is AuthenticationError) {
          _showErrorSnackbar('Error', state.message);
        }
      },
      builder: (context, state) {
        // If we're in a successful state, show the form with success indication
        // The listener will handle navigation
        if (state is PasswordResetEmailSent) {
          // Show the form but keep everything disabled
          return Column(
            children: [
              ThemedAppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: null, // Disable back during navigation
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: responsiveController.screenHeight * 0.08),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UniversalImageLoader(
                              imagePath:
                                  'assets/images/profile/password-recovery.png',
                              width: 50.w,
                              height: 50.h,
                            ),
                            SizedBox(height: 20.0.h),
                            Text(
                              'Password Recovery',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: AppColors.primaryFont,
                              ),
                            ),
                            SizedBox(height: 8.0.h),
                            Text(
                              'Check your email for password reset instructions',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                                color: AppColors.secondaryFont,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        // Handle non-forgot password states - show initial loading
        if (state is! ForgotPasswordInProgress) {
          return Column(
            children: [
              ThemedAppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Get.back();
                    }
                  },
                ),
              ),
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        final forgotPasswordState = state;
        final isLoading = forgotPasswordState.isLoading;

        return Column(
          children: [
            ThemedAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: isLoading ? null : () {
                  if (Navigator.canPop(context)) {
                    Get.back();
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: responsiveController.screenHeight * 0.08),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UniversalImageLoader(
                            imagePath:
                                'assets/images/profile/password-recovery.png',
                            width: 50.w,
                            height: 50.h,
                          ),
                          SizedBox(height: 20.0.h),
                          Text(
                            'Password Recovery',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.primaryFont,
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          Text(
                            'Enter your registered email below to receive password instructions',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                              color: AppColors.secondaryFont,
                            ),
                          ),
                          SizedBox(height: 30.0.h),
                          // Delivery Method Selection
                          Text(
                            'Send verification code via:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.primaryFont,
                            ),
                          ),
                          SizedBox(height: 12.0.h),
                          RadioGroup<String>(
                            groupValue: _deliveryMethod,
                            onChanged: (value) {
                                  if (isLoading) return;
                                    setState(() {
                                      _deliveryMethod = value ?? _deliveryMethod;
                                    });
                                  },
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text(
                                      'SMS',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    value: 'SMS',
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text(
                                      'Email',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    value: 'EMAIL',
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.0.h),
                          BuildFormField(
                            leading: const Icon(Icons.email_outlined,
                                color: AppColors.secondaryFont),
                            name: 'passwordRecoveryEmail',
                            placeholder: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (email) {
                              setState(() {
                                _email = email;
                              });
                              context
                                  .read<AuthenticationCubit>()
                                  .forgotPasswordEmailChanged(email);
                            },
                            disabled: isLoading,
                          ),
                          SizedBox(height: 50.0.h),
                        ],
                      ),
                      SizedBox(
                          height: responsiveController.screenHeight * 0.2),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 32.0,
                          ),
                          minimumSize: Size(double.infinity, 36.h),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                context
                                    .read<AuthenticationCubit>()
                                    .submitForgotPassword();
                              },
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                "Send me a mail",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
