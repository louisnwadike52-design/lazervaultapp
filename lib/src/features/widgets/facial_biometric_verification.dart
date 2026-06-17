import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';

class FacialBiometricVerification extends StatefulWidget {
  const FacialBiometricVerification({super.key});

  @override
  State<FacialBiometricVerification> createState() =>
      _FacialBiometricVerificationState();
}

class _FacialBiometricVerificationState
    extends State<FacialBiometricVerification>
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let's verify your identity",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColors.primaryFont,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(
                        textAlign: TextAlign.center,
                        'We\'re required by law to verify your identity before me manage your wallet.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                          color: AppColors.secondaryFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsiveController.screenHeight * 0.33,
                    child: Center(
                      child: UniversalImageLoader(
                        imagePath: 'assets/images/face-verification-scan.png',
                        width: 150.w,
                        height: 150.h,
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveController.screenHeight * 0.1),
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
                    onPressed: () => Get.toNamed(AppRoutes.faceScan),
                    child: Text(
                      "Verify my identity",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.proofOfResidence),
                    child: Text("I'll do this later",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold)),
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
