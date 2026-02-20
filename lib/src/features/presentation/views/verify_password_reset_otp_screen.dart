import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/src/features/widgets/verify_password_reset_otp.dart';

class VerifyPasswordResetOTPScreen extends StatefulWidget {
  const VerifyPasswordResetOTPScreen({super.key});

  @override
  State<VerifyPasswordResetOTPScreen> createState() => _VerifyPasswordResetOTPScreenState();
}

class _VerifyPasswordResetOTPScreenState extends State<VerifyPasswordResetOTPScreen> {

  @override
  void initState() {
    super.initState();
    // Set status bar icons to white
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
        child: const VerifyPasswordResetOTP(),
      ),
    );
  }
}
