import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// HOW LONG THE CODE ITSELF IS GOOD FOR.
///
/// ## Why this is not the resend countdown
///
/// An OTP screen has TWO clocks and they are different numbers:
///
///   * the RESEND COOLDOWN — how long before another code may be requested,
///     60s by default, tunable as `auth_otp_resend_cooldown_seconds`;
///   * the CODE'S LIFETIME — how long the code already sent stays valid,
///     120s, tunable as `auth_otp_ttl_email_seconds` /
///     `auth_otp_ttl_sms_seconds`.
///
/// The passcode-reset screen showed only the first and never read the second,
/// so an operator who set the window to 120 on the dashboard watched the app
/// count down from 60 and reasonably concluded the setting had not taken. It
/// had — the number on screen was answering a different question.
///
/// Both are now shown, each labelled as what it is.
///
/// ## The value comes from the server, always
///
/// `seconds` is the window the server says it ACTUALLY MINTED
/// (`RequestPasscodeResetResponse.expires_in`, derived from OTPExpiresAt), not
/// a constant compiled in here. A countdown that restates a number the
/// database did not honour is how the app and the code come to disagree about
/// when it dies.
class OtpExpiryCountdown extends StatefulWidget {
  const OtpExpiryCountdown({
    super.key,
    required this.seconds,
    this.color,
    this.expiredColor,
  });

  /// Lifetime of the code just sent, in seconds, as reported by the server.
  /// Zero or negative renders nothing — a server that did not say must not be
  /// guessed for.
  final int seconds;

  final Color? color;
  final Color? expiredColor;

  @override
  State<OtpExpiryCountdown> createState() => _OtpExpiryCountdownState();
}

class _OtpExpiryCountdownState extends State<OtpExpiryCountdown> {
  Timer? _timer;
  late int _left = widget.seconds;

  @override
  void initState() {
    super.initState();
    _arm();
  }

  @override
  void didUpdateWidget(covariant OtpExpiryCountdown old) {
    super.didUpdateWidget(old);
    // A fresh code restarts the clock. Without this a resend left the old
    // countdown running and the screen expired a code that was just issued.
    if (old.seconds != widget.seconds) {
      _left = widget.seconds;
      _arm();
    }
  }

  void _arm() {
    _timer?.cancel();
    if (_left <= 0) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _left--;
        if (_left <= 0) t.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  static String _mmss(int s) {
    final m = s ~/ 60;
    final r = s % 60;
    return '$m:${r.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seconds <= 0) return const SizedBox.shrink();
    final expired = _left <= 0;
    return Text(
      // Said plainly, because the consequence is plain: after this the code
      // stops working and the customer needs another one.
      expired
          ? 'That code has expired — request a new one'
          : 'Code expires in ${_mmss(_left)}',
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: expired
            ? (widget.expiredColor ?? const Color(0xFFEF4444))
            : (widget.color ?? Colors.white70),
      ),
    );
  }
}
