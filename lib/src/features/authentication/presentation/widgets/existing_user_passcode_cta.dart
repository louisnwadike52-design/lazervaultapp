import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// `Log in as <name> with your passcode` — the way back to the account this
/// device already holds.
///
/// WHY IT EXISTS. The switch-user screens are reached in two different moods.
/// One is "I want to sign in as somebody else", which is what they are built
/// for. The other is "I got here by accident, or by a deep link, or by signing
/// out, and I just want back into MY account" — and from there, until now, the
/// only route back was to type a full phone number and passcode, or an email
/// and password, for an account the phone could already unlock with four
/// digits. People do not find that on their own; they assume they are locked
/// out.
///
/// SHOWS NOTHING WHEN THERE IS NOTHING TO OFFER. It renders only when
/// [LoginFlowResolver.hasCachedReturningUser] is true, which is the same
/// condition the passcode lock screen itself needs to be usable — so the CTA
/// can never lead to a screen with no identity to unlock. On a fresh install
/// it occupies no space at all.
///
/// ONLY WHEN THE SCREEN WAS REACHED BY RESUMPTION, not whenever an account
/// happens to be cached.
///
/// The offer answers one question — "how do I get back into my own account?" —
/// and that question is only live when the customer did not choose to be here:
/// the app was opened, a session timed out, a deep link landed them on auth,
/// they signed out. In those cases the stack was cleared and there is no back
/// button, so the CTA is the only way home.
///
/// When they NAVIGATED here deliberately — from onboarding, from "switch
/// user", from "forgot passcode" — the back button is already the way back,
/// and the CTA is both redundant and actively wrong: it invites somebody who
/// has just asked to sign in as a different person to sign in as the previous
/// one.
///
/// THE TEST IS THE BACK BUTTON ITSELF. `canPop` is false exactly when the
/// stack was cleared, which is what every resumption path does and what no
/// deliberate navigation does — with one exception, the email "switch user",
/// which clears the stack on purpose and therefore says so with
/// `switchUser: true`. Deriving it from the stack rather than from a flag
/// passed at each call site means a new resumption path gets the right
/// behaviour without anyone remembering to opt in.
///
/// WHITE TEXT ON PURPOSE. It sits over the bottom purple wave of the auth
/// background, where the theme's default foreground is near-black and
/// effectively invisible — the same trap documented on the sign-up footer
/// beside it.
class ExistingUserPasscodeCta extends StatefulWidget {
  const ExistingUserPasscodeCta({super.key, this.enabled = true});

  /// The route argument a deliberate account switch sets to suppress the CTA.
  /// Named here rather than written out at the call site so the two cannot
  /// drift apart.
  static const String switchUserArg = 'switchUser';

  /// False while a submit is in flight, so the CTA cannot navigate out from
  /// under a request the user has already started.
  final bool enabled;

  @override
  State<ExistingUserPasscodeCta> createState() =>
      _ExistingUserPasscodeCtaState();
}

class _ExistingUserPasscodeCtaState extends State<ExistingUserPasscodeCta> {
  /// null = still deciding. Distinct from false so the widget does not flash
  /// into view and out again on a slow secure-storage read.
  bool? _available;
  String _label = 'Log in with your passcode';

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  Future<void> _resolve() async {
    final has = await LoginFlowResolver.hasCachedReturningUser();
    if (!mounted) return;
    if (!has) {
      setState(() => _available = false);
      return;
    }
    // The NAME is a courtesy, not a requirement. An older session may have
    // cached an identity with no name against it, and "Log in with your
    // passcode" is still the right offer — so a failed name read must not
    // hide the CTA.
    String? name;
    try {
      name = await serviceLocator<SecureStorageService>().getUserFullName();
    } catch (_) {
      name = null;
    }
    if (!mounted) return;
    final first = (name ?? '').trim().split(RegExp(r'\s+')).first;
    setState(() {
      _available = true;
      // FIRST NAME ONLY. This is a sign-in screen that anybody holding the
      // phone can see, and a full name on it is more identity than the moment
      // needs.
      _label = first.isEmpty
          ? 'Log in with your passcode'
          : 'Log in as $first with your passcode';
    });
  }

  /// Whether this screen was reached by resumption rather than by choice.
  ///
  /// Read at build time, not in initState: `Navigator.of` needs an ancestor
  /// that is not yet attached when initState runs, and the answer cannot
  /// change for the life of this route anyway.
  bool _reachedByResumption(BuildContext context) {
    final args = Get.arguments;
    if (args is Map && args[ExistingUserPasscodeCta.switchUserArg] == true) {
      // They asked for a different account. Offering the old one back is the
      // opposite of what was requested.
      return false;
    }
    // A back button is a way home, so the CTA would be a second one.
    //
    // maybeOf, not of: this widget is rendered inside auth screens that are
    // always under a Navigator today, but a missing one must degrade to
    // hiding the CTA rather than throwing on a sign-in screen.
    return !(Navigator.maybeOf(context)?.canPop() ?? false);
  }

  @override
  Widget build(BuildContext context) {
    if (_available != true) return const SizedBox.shrink();
    if (!_reachedByResumption(context)) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: TextButton(
        onPressed: widget.enabled
            ? () => Get.toNamed(AppRoutes.passcodeLogin)
            : null,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_open_outlined,
                size: 15.w, color: Colors.white.withValues(alpha: 0.9)),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                _label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
