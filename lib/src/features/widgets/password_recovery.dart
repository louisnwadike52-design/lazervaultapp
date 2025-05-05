import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery>
    with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();

  // Existing fields
  double scanProgress = 0.0;
  bool isScanning = false;
  late AnimationController _controller;
  bool isPasswordObscured = true;

  // Updated field: Use TextEditingController instead of an immutable String
  final TextEditingController _passcodeController = TextEditingController();

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
    _passcodeController.dispose();
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
                EdgeInsets.only(top: responsiveController.screenHeight * 0.08),
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
                      SizedBox(height: 45.0.h),
                      const BuildFormField(
                          leading: Icon(Icons.email_outlined,
                              color: AppColors.secondaryFont),
                          name: 'passwordRecoveryEmail',
                          placeholder: 'Enter your email'),
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
                    onPressed: () => Get.toNamed(AppRoutes.otpVerification),
                    child: Text(
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
  }
}
