import 'package:flutter/material.dart';
import 'package:lazervault/src/features/widgets/facial_registration_camera.dart';

class FaceScan extends StatelessWidget {
  const FaceScan({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the new camera-based facial registration widget
    return const FacialRegistrationCamera();
  }
}
