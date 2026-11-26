import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// A custom button widget that shows a loading state
class AppLoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final IconData? icon;

  const AppLoadingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.fontSize,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Theme.of(context).primaryColor;
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: textColor ?? Colors.white,
          // A LOADING BUTTON MUST STILL LOOK LIKE A BUTTON.
          //
          // `onPressed: null` is how this widget blocks a second tap, but it
          // also puts Material into its DISABLED colours — which ignore
          // `backgroundColor` entirely and fall back to
          // `onSurface.withOpacity(0.12)`. On the dark KYC/auth screens that
          // is very nearly the page colour, so the moment the user tapped,
          // the button vanished and left a bare loader floating on black.
          // Reported 2026-11-09 on "Verify Your Identity", where it reads as
          // a broken screen at the exact moment we ask for someone's BVN.
          //
          // Keep the brand colour, just dimmed, so the control stays visible
          // and obviously busy rather than obviously broken.
          disabledBackgroundColor: bg.withValues(alpha: 0.55),
          disabledForegroundColor:
              (textColor ?? Colors.white).withValues(alpha: 0.9),
          padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          ),
          elevation: 0,
        ),
        child: isLoading ? _buildLoadingState() : _buildNormalState(),
      ),
    );
  }

  Widget _buildLoadingState() {
    // Branded loader instead of the generic spinner so every button
    // shows the company logo while it's working. Size matches the
    // previous 24px spinner so existing button layouts are pixel-stable.
    //
    // Centred explicitly: ElevatedButton centres its child, but the loader is
    // the ONLY thing in the button while loading, so any future change to the
    // button's padding would otherwise shift it off-axis.
    return const Center(child: LazerVaultLoader.small());
  }

  Widget _buildNormalState() {
    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
