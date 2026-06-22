import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:lazervault/core/utilities/auth_background.dart';
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
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AuthBackground.current),
                fit: BoxFit.cover,
              ),
            ),
            child: const SizedBox.expand(),
          ),
          // Dark overlay so the foreground text/keypad stay readable regardless
          // of which (possibly bright) background photo was randomly selected.
          Container(color: Colors.black.withValues(alpha: 0.6)),
          const PasscodeSignIn(),
        ],
      ),
    );
  }
}
