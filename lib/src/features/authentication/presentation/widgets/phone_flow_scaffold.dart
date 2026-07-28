import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utilities/auth_background.dart';

/// Shared chrome for every screen in the phone+passcode onboarding flow.
///
/// Layout (production design):
///  - A light curved-edges background ([_curvedBg]) — or, for passcode-entry
///    screens, the dark login-passcode photo ([darkBackground]).
///  - A minimal top bar holding only the back button (over the coloured curve).
///  - All content lives in ONE scroll view in the BODY: the step progress bar
///    (below the curve, on the white area), the title/subtitle, the screen's
///    [children], and the primary CTA at the end. No sticky bottom panel.
///  - An optional [footer] (e.g. "Already have an account? Log in") floats over
///    the background at the very bottom — used by the first slide only.
///  - Tapping outside an input dismisses the keyboard; the scroll view keeps the
///    focused field + CTA clear of the keyboard.
class PhoneFlowScaffold extends StatelessWidget {
  static const Color _brandPurple = Color(0xFF4834D4);

  /// Curved-edges background shared with sign_up_screen / login.
  static const String _curvedBg = 'assets/images/bg/up-down-curve-bg.png';

  static const Color _ink = Color(0xFF262626); // title on the light body
  static const Color _muted = Color(0xFF6B7280); // subtitle on the light body
  static const Color _progressTrack = Color(0xFFE5E7EB); // unfilled (light bg)

  final String title;
  final String? subtitle;

  /// 1-based step index used to render the progress bar. Pass null to hide it.
  final int? step;
  final int totalSteps;

  /// Body content rendered between the title and the primary CTA.
  final List<Widget> children;

  /// Primary CTA label, rendered in the body after [children]. Null hides it
  /// (e.g. the passcode keypad drives itself).
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final bool isLoading;

  /// Optional secondary action rendered under the primary CTA in the body
  /// (e.g. the OTP "Skip for now").
  final Widget? secondaryAction;

  /// Whether to show the back button (default true). The first slide passes
  /// false — its [footer] login link is the way out.
  final bool showBack;

  /// Custom back handler for BOTH the app-bar back button AND the Android
  /// system back gesture. When null (default) back pops the route (Get.back).
  /// Screens with an internal multi-step phase (e.g. the switch-user login's
  /// phone → passcode phases) pass this to move BACK a phase instead of popping
  /// the whole route — otherwise back from the passcode step pops to whatever
  /// pushed the login (the signup phone screen) instead of the login's phone
  /// step.
  final VoidCallback? onBack;

  /// When true, use the dark login-passcode background (photo + scrim) and white
  /// text, so passcode-entry screens read as a distinct surface.
  final bool darkBackground;

  /// Floats over the background at the very bottom (white text on the purple
  /// curve). Used by the first slide for the "Already have an account?" link.
  /// Hidden while the keyboard is up.
  final Widget? footer;

  /// Show the Lazervault mark at the right edge of the heading. On by default
  /// for the signup flow; pass false for login/recovery screens
  /// (switch-user, reset passcode) which aren't part of signup.
  final bool showHeadingLogo;

  const PhoneFlowScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.step,
    this.totalSteps = 4,
    required this.children,
    this.primaryLabel,
    this.onPrimary,
    this.isLoading = false,
    this.secondaryAction,
    this.showBack = true,
    this.darkBackground = false,
    this.footer,
    this.showHeadingLogo = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = darkBackground ? Colors.white : _ink;
    final subtitleColor =
        darkBackground ? Colors.white.withValues(alpha: 0.85) : _muted;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    final scaffold = Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        // Tap anywhere outside an input to dismiss the keyboard.
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            if (darkBackground) ...[
              DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AuthBackground.current),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const SizedBox.expand(),
              ),
              Container(color: Colors.black.withValues(alpha: 0.65)),
            ] else
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_curvedBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                          24.w, 8.h, 24.w, 24.h + bottomInset),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (step != null) ...[
                            // Sits below the curve, on the white body.
                            SizedBox(height: 22.h),
                            _StepProgress(
                                step: step!,
                                total: totalSteps,
                                dark: darkBackground),
                            SizedBox(height: 28.h),
                          ] else
                            // No progress bar — give the title the same clear
                            // start below the curve so the top doesn't read as
                            // cramped against it.
                            SizedBox(height: 56.h),
                          // Title with the Lazervault mark pinned to the right
                          // edge of the heading — keeps the brand present
                          // without a tall logo block pushing content down.
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: titleColor,
                                  ),
                                ),
                              ),
                              if (showHeadingLogo) ...[
                                SizedBox(width: 12.w),
                                Image.asset(
                                  'assets/images/logos/lazervault-logo-only.png',
                                  height: 40.h,
                                  width: 40.w,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ],
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: 8.h),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                  fontSize: 14.sp, color: subtitleColor),
                            ),
                          ],
                          SizedBox(height: 28.h),
                          ...children,
                          if (primaryLabel != null) ...[
                            SizedBox(height: 28.h),
                            _buildPrimaryButton(),
                            if (secondaryAction != null) ...[
                              SizedBox(height: 8.h),
                              secondaryAction!,
                            ],
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Footer floats on the background bottom (first slide only). Hidden
            // while the keyboard is up so it never overlaps the input.
            if (footer != null && bottomInset == 0)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Center(child: footer!),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    // No custom back handler → default behaviour (route pop via Get.back).
    if (onBack == null) return scaffold;
    // With a custom handler, intercept the Android system back too so it moves
    // a phase back instead of popping the whole route.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        onBack!();
      },
      child: scaffold,
    );
  }

  Widget _buildTopBar() {
    // Back button (white, over the curve/photo) — or a small spacer when hidden.
    if (!showBack) return SizedBox(height: 48.h);
    return SizedBox(
      height: 48.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack ?? () => Get.back<void>(),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _brandPurple,
          foregroundColor: Colors.white,
          disabledBackgroundColor: _brandPurple.withValues(alpha: 0.5),
          disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        onPressed: isLoading ? null : onPrimary,
        child: isLoading
            ? LazerVaultLoader(size: 22)
            : Text(
                primaryLabel!,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}

/// A thin segmented progress bar. On the light body it uses the brand colour for
/// completed segments + a light-gray track; on the dark variant it stays white-
/// based (completed = solid white, remaining = translucent white).
class _StepProgress extends StatelessWidget {
  final int step;
  final int total;
  final bool dark;

  const _StepProgress(
      {required this.step, required this.total, required this.dark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final filled = i < step;
        final Color color = dark
            ? (filled ? Colors.white : Colors.white.withValues(alpha: 0.35))
            : (filled
                ? PhoneFlowScaffold._brandPurple
                : PhoneFlowScaffold._progressTrack);
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            height: 5.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        );
      }),
    );
  }
}
