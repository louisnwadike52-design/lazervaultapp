import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
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
    return const Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/seed/lazervaultsignin/1080/1920',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox.expand(),
          ),
          PasscodeSignIn(),
        ],
      ),
    );
  }
}
