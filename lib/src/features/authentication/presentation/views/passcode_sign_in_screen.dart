import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:lazervault/core/utilities/rotating_auth_background.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/passcode_sign_in.dart';

class PasscodeSignInScreen extends StatefulWidget {
  const PasscodeSignInScreen({super.key});

  @override
  State<PasscodeSignInScreen> createState() => _PasscodeSignInScreenState();
}

class _PasscodeSignInScreenState extends State<PasscodeSignInScreen> {


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
      body: Stack(
        children: [
          // Full-bleed background that cross-fades to a new bundled photo
          // every 5 seconds (compressed webp variants).
          const Positioned.fill(
            child: RotatingAuthBackground(interval: Duration(seconds: 7)),
          ),
          // NOTE: the dark scrim for readability is rendered INSIDE PasscodeSignIn
          // (single light overlay) — no screen-level overlay here, otherwise the
          // two compound and the background photo goes too dark on low brightness.
          const PasscodeSignIn(),
        ],
      ),
    );
  }
}
