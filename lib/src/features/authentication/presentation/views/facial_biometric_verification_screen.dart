import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:lazervault/src/features/widgets/facial_biometric_verification.dart';

class FacialBiometricVerificationScreen extends StatefulWidget {
  const FacialBiometricVerificationScreen({super.key});

  @override
  State<FacialBiometricVerificationScreen> createState() =>
      _FacialBiometricVerificationScreenState();
}

class _FacialBiometricVerificationScreenState
    extends State<FacialBiometricVerificationScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg/up-down-curve-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FacialBiometricVerification(),
      ),
    );
  }
}
