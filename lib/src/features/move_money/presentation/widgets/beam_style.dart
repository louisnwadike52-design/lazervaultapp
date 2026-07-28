import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Shared LazerBeam visual language, aligned with the crypto **swap** screen
/// (`swap_crypto_screen.dart`): deep purple gradient CTAs with a glow, diagonal
/// gradient cards, and purple-tinted section icon chips. Use these across the
/// Beam dashboard, both transfer flows, and the history screens so LazerBeam
/// reads as the same product family as Swap.
class BeamStyle {
  BeamStyle._();

  /// Primary brand purple (same as the swap button + `transfer` service color).
  static const Color purple = Color.fromARGB(255, 78, 3, 208);

  /// Lighter gradient partner for the purple CTA / accents.
  static const Color purpleLight = Color(0xFF8B7CF6);

  static const Color surfaceTop = Color(0xFF1F1F1F);
  static const Color surfaceBottom = Color(0xFF2D2D2D);
  static const Color innerSurface = Color(0xFF0A0A0A);
  static const Color hairline = Color(0xFF2D2D2D);
  static const Color muted = Color(0xFF9CA3AF);

  /// Diagonal gradient card matching the swap interface card.
  static BoxDecoration card({double radius = 20}) => BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [surfaceTop, surfaceBottom],
        ),
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  /// Near-black inner card (the From/To amount slots on the swap screen).
  static BoxDecoration innerCard({double radius = 14, Color? borderColor}) =>
      BoxDecoration(
        color: innerSurface,
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(
          color: borderColor ?? Colors.white.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );

  /// Purple-tinted gradient card used for hero / summary blocks.
  static BoxDecoration accentCard({double radius = 20}) => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [purple.withValues(alpha: 0.14), surfaceTop],
        ),
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(color: purple.withValues(alpha: 0.25)),
      );
}

/// The Beam primary CTA: a purple gradient pill with a soft glow, matching the
/// swap screen's main button. Falls back to a flat disabled state.
class BeamGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final double height;

  const BeamGradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    final active = enabled && !isLoading;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: height.h,
      decoration: BoxDecoration(
        gradient: active
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [BeamStyle.purple, BeamStyle.purpleLight],
              )
            : LinearGradient(colors: [
                Colors.grey.withValues(alpha: 0.30),
                Colors.grey.withValues(alpha: 0.12),
              ]),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: active
            ? [
                BoxShadow(
                  color: BeamStyle.purple.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: active ? onTap : null,
          child: Center(
            child: isLoading
                ? LazerVaultLoader.small()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// The purple gradient SQUARE swap button that sits between the From/To cards
/// on the swap screen (rotating up/down arrows, soft glow). Greys out when
/// [onTap] is null.
class BeamSwapButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  const BeamSwapButton({
    super.key,
    required this.onTap,
    this.icon = Icons.swap_vert_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final active = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [BeamStyle.purple, BeamStyle.purpleLight],
                )
              : LinearGradient(colors: [
                  Colors.grey.withValues(alpha: 0.30),
                  Colors.grey.withValues(alpha: 0.15),
                ]),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: BeamStyle.purple.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(icon, color: Colors.white, size: 22.sp),
      ),
    );
  }
}

/// A section header with a purple-tinted icon chip + title, and optional
/// trailing action (e.g. "View all"). Mirrors the swap screen's card headers.
class BeamSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;

  const BeamSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: BeamStyle.purple.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Icon(icon, color: BeamStyle.purpleLight, size: 17.sp),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}
