import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// LazerVaultLoader — the canonical app-branded loader.
///
/// Replaces `CircularProgressIndicator()` wherever we want a branded
/// loader: in buttons, in list-loading rows, in full-screen states. The
/// company logo rotates a full turn every [duration] (default 1500ms).
///
/// Pass [size] for the diameter (defaults to 24.r so it slots into a
/// button or list-row spinner slot). Pass [labeled] + [label] for the
/// "Loading X" labelled row pattern.
///
/// Drop-in for inline `CircularProgressIndicator`:
///   Before: `const Center(child: CircularProgressIndicator())`
///   After:  `const Center(child: LazerVaultLoader())`
class LazerVaultLoader extends StatefulWidget {
  /// Diameter of the rotating logo in logical pixels (passed through ScreenUtil).
  final double? size;

  /// One full rotation duration. Default 1500ms — matches the natural
  /// "thinking" cadence the rest of the app uses.
  final Duration duration;

  /// Optional alpha applied to the logo. 1.0 = opaque, 0.5 = ghosted.
  /// Useful when overlaying on a coloured surface.
  final double opacity;

  const LazerVaultLoader({
    super.key,
    this.size,
    this.duration = const Duration(milliseconds: 1500),
    this.opacity = 1.0,
  });

  /// Compact (12px) — micro-spinner inline with body text, in a chip's
  /// suffix slot, or any place a CircularProgressIndicator would have
  /// been "strokeWidth: 1.5" tiny.
  const LazerVaultLoader.tiny({super.key})
      : size = 12,
        duration = const Duration(milliseconds: 1500),
        opacity = 1.0;

  /// Default (20px) — slots into a button, list-row spinner, or any
  /// inline "loading" microsurface. The animated brand mark reads as
  /// a comfortable small icon at this size; if you need a chip-suffix
  /// truly-tiny variant use `.tiny()` instead.
  const LazerVaultLoader.small({super.key})
      : size = 20,
        duration = const Duration(milliseconds: 1500),
        opacity = 1.0;

  /// Card / sheet centred loader (28px).
  const LazerVaultLoader.medium({super.key})
      : size = 28,
        duration = const Duration(milliseconds: 1500),
        opacity = 1.0;

  /// Full-page (48px). Reduced from 72px — the animated logo at 72
  /// dominated the surface; 48px still reads as the page-level loader.
  const LazerVaultLoader.large({super.key})
      : size = 48,
        duration = const Duration(milliseconds: 1500),
        opacity = 1.0;

  @override
  State<LazerVaultLoader> createState() => _LazerVaultLoaderState();
}

class _LazerVaultLoaderState extends State<LazerVaultLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dim = (widget.size ?? 24).r;
    return RepaintBoundary(
      child: SizedBox(
        width: dim,
        height: dim,
        child: RotationTransition(
          turns: _controller,
          child: Opacity(
            opacity: widget.opacity,
            child: Image.asset(
              'assets/images/logos/app-logo.png',
              width: dim,
              height: dim,
              fit: BoxFit.contain,
              // Fallback to CircularProgressIndicator if the asset can't
              // resolve — avoids a hard crash in dev/test builds where
              // assets haven't been re-baked.
              errorBuilder: (_, __, ___) => SizedBox(
                width: dim,
                height: dim,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// LazerVaultLoadingRow — labelled inline loader: "Loading X" with the
/// rotating logo on the right. Used for list-section loading states
/// where the operator wants to know what's being fetched.
///
///   LazerVaultLoadingRow(label: 'Loading linked accounts')
class LazerVaultLoadingRow extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final double? loaderSize;

  const LazerVaultLoadingRow({
    super.key,
    required this.label,
    this.padding,
    this.labelStyle,
    this.loaderSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: labelStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
            ),
          ),
          SizedBox(width: 12.w),
          LazerVaultLoader(size: loaderSize ?? 20),
        ],
      ),
    );
  }
}
