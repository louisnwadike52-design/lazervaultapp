import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared "resend verification code" control used by EVERY OTP/verification
/// screen (email + phone, both the email_password and phone_passcode flows).
///
/// Self-contained: it owns its own countdown timer so each screen no longer
/// duplicates the cooldown bookkeeping. While counting down it renders a muted
/// "Resend code in {n}s"; at zero it renders a tappable "Resend code" button.
/// On tap it awaits [onResend] (which performs the network resend and returns
/// the next cooldown in seconds) and restarts the countdown.
///
/// Pass [dark] = true on dark surfaces (e.g. the phone_passcode PhoneFlowScaffold
/// dark variant) so the colours read correctly; defaults to the light/white
/// verification-screen palette.
class ResendCodeButton extends StatefulWidget {
  /// Cooldown already in effect when the screen first shows (a code was sent
  /// during signup/login). 0 → the button is immediately tappable.
  final int initialSeconds;

  /// Performs the resend and returns the new cooldown (seconds). Defaults to 60
  /// when the future resolves to null.
  final Future<int?> Function() onResend;

  final bool dark;
  final String label;
  final String prompt; // optional leading text, e.g. "Didn't receive the code?"

  const ResendCodeButton({
    super.key,
    this.initialSeconds = 0,
    required this.onResend,
    this.dark = false,
    this.label = 'Resend code',
    this.prompt = '',
  });

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  int _seconds = 0;
  Timer? _timer;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialSeconds > 0) _start(widget.initialSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start(int seconds) {
    _timer?.cancel();
    setState(() => _seconds = seconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_seconds <= 1) {
        t.cancel();
        setState(() => _seconds = 0);
      } else {
        setState(() => _seconds -= 1);
      }
    });
  }

  Future<void> _onTap() async {
    if (_busy || _seconds > 0) return;
    setState(() => _busy = true);
    try {
      final next = await widget.onResend();
      if (!mounted) return;
      _start(next ?? 60);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final muted = widget.dark
        ? Colors.white.withValues(alpha: 0.7)
        : const Color(0xFF6B7280);
    final accent = const Color(0xFF4834D4);

    if (_seconds > 0) {
      final txt = widget.prompt.isNotEmpty
          ? '${widget.prompt} Resend in ${_seconds}s'
          : 'Resend code in ${_seconds}s';
      return Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.sp, color: muted),
      );
    }

    return TextButton(
      onPressed: _busy ? null : _onTap,
      child: Text(
        widget.label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: widget.dark ? Colors.white : accent,
          decoration: TextDecoration.underline,
          decorationColor: widget.dark ? Colors.white : accent,
        ),
      ),
    );
  }
}
