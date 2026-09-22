import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The step-progress header used by the app's multi-step creation flows.
///
/// WHY THIS IS A SHARED WIDGET
/// ---------------------------
/// This was a private `_buildProgressIndicators()` on the invoice carousel's State,
/// and it had already been copy-pasted once into the crowdfund carousel. A third
/// copy for the FCY KYC flow would have made the same 60 lines exist three times
/// with three chances to drift — which is exactly how the accent colour got out of
/// step in the first place (see below).
///
/// THE ACCENT
/// ----------
/// The invoice original fills the bar with a gradient from `0xFF3B82F6` (blue) to
/// the `0xFF4E03D0` brand purple, and paints the active dot pure blue. So the dots
/// never matched the brand and the bar was half-wrong. Here the gradient runs
/// within the purple family and the dots use the same accent, so one value drives
/// all of it and the default actually looks like the product.
///
/// `accent` is overridable because the exchange surface has its own token
/// (`ExchangeTheme.primary`) and a flow living there should match its host.
///
/// COMPLETION COLOUR
/// -----------------
/// The last step turning green is kept from the original: it is a genuine signal
/// ("this is the step that submits"), not decoration, and users of the invoice flow
/// already read it that way.
class WizardProgressBar extends StatelessWidget {
  const WizardProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.accent = const Color(0xFF7C5CFF),
    this.accentDeep = const Color(0xFF4E03D0),
    this.completionColor = const Color(0xFF10B981),
    this.padding,
  });

  /// Zero-based index of the step being shown.
  final int currentStep;

  /// Total number of steps. Must be >= 1; the bar is a no-op below that rather
  /// than dividing by zero — a variable-length flow can legitimately collapse to
  /// nothing when every field was prefilled.
  final int totalSteps;

  /// Leading colour of the fill gradient and the colour of the active dot.
  final Color accent;

  /// Trailing colour of the fill gradient.
  final Color accentDeep;

  /// Fill colour on the final step.
  final Color completionColor;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (totalSteps < 1) return const SizedBox.shrink();

    // Clamped so an out-of-range step cannot overflow the track or produce a
    // negative width — a variable-length flow can shrink under a step while it is
    // being rebuilt.
    final step = currentStep.clamp(0, totalSteps - 1);
    final isLast = step == totalSteps - 1;

    final horizontal = 20.w;
    final effectivePadding = padding ??
        EdgeInsets.symmetric(horizontal: horizontal, vertical: 16.h);

    return Padding(
      padding: effectivePadding,
      child: Column(
        children: [
          // LayoutBuilder rather than MediaQuery: the original subtracted a
          // hardcoded 40.w from the screen width, which silently mismeasured
          // whenever the bar was not at exactly that inset. This measures the space
          // it was actually given.
          LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              return Stack(
                children: [
                  Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 4.h,
                    width: trackWidth * ((step + 1) / totalSteps),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isLast
                            ? [completionColor, completionColor.withValues(alpha: 0.75)]
                            : [accent, accentDeep],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalSteps,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: step == index ? 24.w : 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  // Same accent as the bar. The original used a different blue
                  // here, so the dots and the fill disagreed.
                  color: step == index
                      ? accent
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
