import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/src/features/widgets/enable_biometric_verification.dart';


class EnableBiometricAccessScreen extends StatefulWidget {
  const EnableBiometricAccessScreen({super.key});

  @override
  State<EnableBiometricAccessScreen> createState() =>
      _EnableBiometricAccessScreenState();
}

class _EnableBiometricAccessScreenState
    extends State<EnableBiometricAccessScreen> {

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
        child: EnableBiometricVerification(),
      ),
    );
  }
}
