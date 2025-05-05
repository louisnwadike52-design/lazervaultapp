import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:local_auth/local_auth.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword>
    with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();

  // Existing fields
  double scanProgress = 0.0;
  bool isScanning = false;
  late AnimationController _controller;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  // Updated field: Use TextEditingController instead of an immutable String
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No route to go back."),
                      ),
                    );
                  }
                })),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.only(top: responsiveController.screenHeight * 0.1),
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
                              name: 'passcode',
                              placeholder: 'Password',
                              controller: _passwordController,
                              obscureText: isPasswordObscured,
                              textInputType: TextInputType.visiblePassword,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordObscured = !isPasswordObscured;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 8.0.h),
                            BuildFormField(
                              name: 'confirmPassword',
                              placeholder: 'Confirm password',
                              controller: _confirmPasswordController,
                              obscureText: isConfirmPasswordObscured,
                              textInputType: TextInputType.visiblePassword,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordObscured =
                                        !isConfirmPasswordObscured;
                                  });
                                },
                              ),
                            ),
                          ]),
                      SizedBox(height: 50.0.h),
                    ],
                  ),
                  SizedBox(height: responsiveController.screenHeight * 0.2),
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
                    onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                    child: Text(
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
  }
}
