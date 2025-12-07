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

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  @override
  void initState() {
    super.initState();
    // Get email and token from route parameters
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = Get.arguments as Map<String, dynamic>?;
      final email = args?['email'] as String? ?? '';
      final token = args?['token'] as String? ?? '';

      context.read<AuthenticationCubit>().startResetPassword(
            email: email,
            token: token,
          );
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
        if (state is PasswordResetSuccess) {
          _showSuccessSnackbar(
            'Password Reset',
            'Your password has been reset successfully',
          );
          // Navigate to login after a delay
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Get.offAllNamed(AppRoutes.emailSignIn);
            }
          });
        } else if (state is AuthenticationError) {
          _showErrorSnackbar('Error', state.message);
        }
      },
      builder: (context, state) {
        // Handle non-reset password states
        if (state is! ResetPasswordInProgress) {
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

        final resetPasswordState = state;
        final isLoading = resetPasswordState.isLoading;

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
                    top: responsiveController.screenHeight * 0.1),
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
                          Text(
                            'Create New Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.primaryFont,
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          Text(
                            'Please, enter a new password below, different from the previous one.',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                              color: AppColors.secondaryFont,
                            ),
                          ),
                          SizedBox(height: 40.0.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              BuildFormField(
                                name: 'password',
                                placeholder: 'Password',
                                obscureText: true,
                                textInputType: TextInputType.visiblePassword,
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                onChanged: (password) {
                                  context
                                      .read<AuthenticationCubit>()
                                      .resetPasswordNewPasswordChanged(password);
                                },
                                disabled: isLoading,
                              ),
                              SizedBox(height: 8.0.h),
                              BuildFormField(
                                name: 'confirmPassword',
                                placeholder: 'Confirm password',
                                obscureText: true,
                                textInputType: TextInputType.visiblePassword,
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                onChanged: (password) {
                                  context
                                      .read<AuthenticationCubit>()
                                      .resetPasswordConfirmPasswordChanged(
                                          password);
                                },
                                disabled: isLoading,
                              ),
                            ],
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
                                    .submitResetPassword();
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
                                "Confirm",
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
