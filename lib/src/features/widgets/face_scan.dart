import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/widgets/facial_registration_camera.dart';

class FaceScan extends StatelessWidget {
  const FaceScan({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the new camera-based facial registration widget
    return const FacialRegistrationCamera();
  }
}
