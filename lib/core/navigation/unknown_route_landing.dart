import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

/// WHERE A LINK GOES WHEN NOTHING KNOWS WHERE IT GOES.
///
/// `unknownRoute` used to render an empty purple Scaffold. That was deliberate
/// — it matches the native splash, so a misrouted boot does not flash white —
/// but it is also a dead end: a push whose route this build does not register
/// put the customer on a blank screen with no control on it and no way back.
/// Reported 2026-11-25 against a marketing push.
///
/// The purple frame is KEPT for the one frame it is needed, and then the
/// customer is moved somewhere real. An unknown destination is not an error
/// worth a screen; it is a link this build is too old (or too new) to
/// understand, and the honest answer is the home they were trying to reach.
///
/// WHERE "REAL" IS DEPENDS ON THE SESSION. Sending a logged-out visitor to the
/// dashboard would bounce them through the auth gate and lose the intent
/// anyway, so they go to the login route and the notification layer's own
/// stash replays anything it captured once they are in.
class UnknownRouteLanding extends StatefulWidget {
  const UnknownRouteLanding({super.key});

  /// Seam for tests: overrides the session check.
  static bool Function()? debugIsAuthenticated;

  @override
  State<UnknownRouteLanding> createState() => _UnknownRouteLandingState();
}

class _UnknownRouteLandingState extends State<UnknownRouteLanding> {
  @override
  void initState() {
    super.initState();
    // After the first frame: pushing during build throws, and a thrown
    // navigation is exactly the kind of failure that reads to a customer as
    // the app being broken.
    WidgetsBinding.instance.addPostFrameCallback((_) => _land());
  }

  void _land() {
    if (!mounted) return;
    final target =
        _authenticated() ? AppRoutes.dashboard : AppRoutes.signIn;
    // offNamed, not toNamed: the dead route must not stay on the stack, or
    // the OS back button returns the customer to the blank frame.
    Get.offNamed(target);
  }

  bool _authenticated() {
    final override = UnknownRouteLanding.debugIsAuthenticated;
    if (override != null) return override();
    try {
      final s = serviceLocator<AuthenticationCubit>().state;
      return s is AuthenticationSuccess || s is AuthenticationAuthenticated;
    } catch (_) {
      // No cubit yet (a cold boot straight into an unknown route). Treat as
      // logged out: the login route resolves onward for a live session, and
      // the dashboard would not for a dead one.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // The same purple as the native splash, for the single frame this is up.
    return const Scaffold(
      backgroundColor: Color(0xFF3D2F8B),
      body: SizedBox.shrink(),
    );
  }
}
