import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/haptics_service.dart';

/// The 3x3 + (0, backspace) numeric keypad shared by the login screen
/// (`passcode_sign_in.dart`) and the settings passcode setup/change flow
/// (`passcode_flow_screen.dart`).
///
/// Fires [Haptics.keyTap] on every digit and on backspace, so call sites do
/// NOT need to add their own keypad haptics. Disabled state greys the buttons
/// and swallows taps (used while a passcode is being submitted).
class PasscodeKeypad extends StatelessWidget {
  /// Called with the pressed digit ('0'-'9').
  final ValueChanged<String> onDigit;

  /// Called when backspace is pressed.
  final VoidCallback onBackspace;

  /// When true, all buttons are greyed out and taps are ignored.
  final bool disabled;

  /// Digit text colour (enabled state).
  final Color digitColor;

  /// Backspace icon colour (enabled state).
  final Color iconColor;

  /// Per-digit circular button background.
  final Color buttonColor;

  /// Optional border for each digit button (login uses none, the flow screen
  /// uses a subtle outline).
  final Color? buttonBorderColor;

  /// Digit text size (logical sp, before screenutil scaling).
  final double digitFontSize;

  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const PasscodeKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.disabled = false,
    this.digitColor = Colors.white,
    this.iconColor = Colors.white,
    this.buttonColor = const Color(0x26FFFFFF), // white @ 15%
    this.buttonBorderColor,
    this.digitFontSize = 24,
    this.mainAxisSpacing = 18,
    this.crossAxisSpacing = 25,
    this.childAspectRatio = 1.6,
  });

  void _handleDigit(String d) {
    if (disabled) return;
    Haptics.keyTap();
    onDigit(d);
  }

  void _handleBackspace() {
    if (disabled) return;
    Haptics.keyTap();
    onBackspace();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: mainAxisSpacing.h,
      crossAxisSpacing: crossAxisSpacing.w,
      childAspectRatio: childAspectRatio,
      children: [
        for (var i = 1; i <= 9; i++) _digitButton(context, '$i'),
        const SizedBox.shrink(),
        _digitButton(context, '0'),
        _iconButton(),
      ],
    );
  }

  Widget _digitButton(BuildContext context, String d) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled ? null : () => _handleDigit(d),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor,
            border: buttonBorderColor != null
                ? Border.all(color: buttonBorderColor!)
                : null,
          ),
          child: Text(
            d,
            style: TextStyle(
              fontSize: digitFontSize.sp,
              fontWeight: FontWeight.w500,
              color: disabled ? Colors.grey : digitColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton() {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled ? null : _handleBackspace,
        child: Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.backspace_outlined,
            size: 28.sp,
            color: disabled ? Colors.grey : iconColor,
          ),
        ),
      ),
    );
  }
}
