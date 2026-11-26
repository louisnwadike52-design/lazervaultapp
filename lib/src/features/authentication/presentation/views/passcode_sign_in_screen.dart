import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:lazervault/core/utilities/rotating_auth_background.dart';
import 'package:lazervault/core/config/feature_flags.dart';
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
          // every 10 seconds (compressed webp variants).
          //
          // THE PACE IS A SETTING, NOT A LITERAL.
          //
          // This was `const Duration(seconds: 10)`, chosen because each swap
          // costs a GPU texture upload on the raster thread and this screen's
          // whole job is to stay responsive while someone taps a passcode —
          // a longer interval cuts that work and widens the quiet gap around
          // each fade. That reasoning still holds and is the argument against
          // going much below the current default; it is not an argument for
          // the number living in the binary, where changing it costs a release
          // and a store review.
          //
          // Default 7s, admin-tunable via auth_background_rotate_seconds, and
          // bounded 2–120s on READ so a bad value cannot wedge the sign-in
          // screen (see FeatureFlags.authBackgroundRotateInterval).
          Positioned.fill(
            child: RotatingAuthBackground(
              interval: FeatureFlags.authBackgroundRotateInterval,
            ),
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
