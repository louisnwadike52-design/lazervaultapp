import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The centered row of 6 (configurable) dots that fill as a passcode is typed.
///
/// Shared by the login screen (`passcode_sign_in.dart`) and the settings
/// passcode setup/change flow (`passcode_flow_screen.dart`) so the two can't
/// drift. Wrap this in a [ShakeWidget] at the call site to get the
/// Revolut-style "wrong passcode" shake.
class PasscodeDots extends StatelessWidget {
  /// How many dots to render.
  final int length;

  /// How many dots are currently filled (number of digits entered so far).
  final int filled;

  /// Colour of a filled dot.
  final Color activeColor;

  /// Colour of an empty dot.
  final Color inactiveColor;

  /// Dot diameter (logical px, before screenutil scaling).
  final double size;

  /// Horizontal gap between dots (logical px, before screenutil scaling).
  final double spacing;

  const PasscodeDots({
    super.key,
    required this.filled,
    this.length = 6,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x4DFFFFFF), // white @ 30%
    this.size = 18,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        final isActive = index < filled;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: spacing.w),
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
