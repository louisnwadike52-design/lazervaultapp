import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';

class FaceScan extends StatefulWidget {
  const FaceScan({super.key});

  @override
  State<FaceScan> createState() => _FaceScanState();
}

class _FaceScanState extends State<FaceScan>
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
              }),
          title: 'Take a photo',
          titleColor: Colors.white,
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
                  child: Center(
                      child: Column(
                    children: [
                      UniversalImageLoader(
                          imagePath: 'assets/images/face-scanning.png',
                          width: 250.0.w,
                          height: 350.0.h),
                      SizedBox(height: 16.0.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Move your face closer',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            Text(
                              'The whole face should be inside the frame without free space left',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  )))),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.0.h),
          child: GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.dashboard),
            child: UniversalImageLoader(
              imagePath: 'assets/images/camera.png',
              height: 100.0.h,
              width: 100.0.w,
            ),
          ),
        ),
      ],
    );
  }
}
