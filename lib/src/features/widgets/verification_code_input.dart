import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';

/// A standard 6-digit verification code input widget with individual boxes
/// and SMS autofill support.
///
/// Features:
/// - 6 individual styled boxes for each digit
/// - Auto-focus and auto-advance between boxes
/// - SMS autofill support (auto-reads OTP from SMS)
/// - Backspace handling
/// - Theme-based styling
class VerificationCodeInput extends StatefulWidget {
  /// Callback when the complete 6-digit code is entered
  final ValueChanged<String>? onCompleted;

  /// Callback when the code changes
  final ValueChanged<String>? onChanged;

  /// Initial code value
  final String? initialValue;

  /// Whether to enable SMS autofill (default: true)
  final bool enableSmsAutofill;

  const VerificationCodeInput({
    super.key,
    this.onCompleted,
    this.onChanged,
    this.initialValue,
    this.enableSmsAutofill = true,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput>
    with CodeAutoFill {
  String _code = '';

  @override
  void initState() {
    super.initState();

    // Initialize with initial value if provided
    if (widget.initialValue != null && widget.initialValue!.length <= 6) {
      _code = widget.initialValue!;
    }

    // Setup SMS autofill
    if (widget.enableSmsAutofill) {
      listenForCode();
    }
  }

  @override
  void codeUpdated() {
    // This is called when SMS autofill detects a code
    if (code != null && code!.length >= 6) {
      final otpCode = code!.substring(0, 6);
      setState(() {
        _code = otpCode;
      });
      widget.onChanged?.call(otpCode);
      widget.onCompleted?.call(otpCode);
    }
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: PinFieldAutoFill(
        codeLength: 6,
        autoFocus: true,
        decoration: BoxLooseDecoration(
          strokeColorBuilder: FixedColorBuilder(
            primaryColor.withValues(alpha: 0.3),
          ),
          bgColorBuilder: FixedColorBuilder(Colors.white),
          textStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          gapSpace: 8.w,
          radius: Radius.circular(12.r),
          strokeWidth: 2,
        ),
        currentCode: _code,
        onCodeChanged: (code) {
          if (code != null) {
            setState(() {
              _code = code;
            });
            widget.onChanged?.call(code);
            if (code.length == 6) {
              widget.onCompleted?.call(code);
            }
          }
        },
        onCodeSubmitted: (code) {
          if (code.length == 6) {
            widget.onCompleted?.call(code);
          }
        },
      ),
    );
  }
}
