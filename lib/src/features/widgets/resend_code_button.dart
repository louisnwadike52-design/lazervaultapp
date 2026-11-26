import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sms_dnd_notice.dart';

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

  /// Performs the resend and returns the new cooldown in seconds.
  ///
  /// RETURN null WHEN NO CODE WAS SENT — a refusal, a rate limit, an offline
  /// failure. A cooldown is a statement that a code just went out and the next
  /// one has to wait; running one after a refusal tells the customer to wait
  /// for something that never happened. It also contradicts the error they are
  /// looking at: "too many codes requested, try again in 24 minutes" sat above
  /// a cheerful "Resend in 57s", because this used to substitute 60 for null
  /// and start counting regardless.
  ///
  /// Returning null leaves the button tappable, which is the honest state: the
  /// server is the authority on whether another code may be sent, and it says
  /// so in the message it already returned.
  final Future<int?> Function() onResend;

  final bool dark;
  final String label;
  final String prompt; // optional leading text, e.g. "Didn't receive the code?"

  /// Show the DND delivery notice once the first cooldown has elapsed.
  ///
  /// SMS screens only. DND is a phone-network register, so mounting this on an
  /// email verification screen would show the customer advice that cannot
  /// possibly apply to them.
  final bool showSmsDndHelp;

  const ResendCodeButton({
    super.key,
    this.initialSeconds = 0,
    required this.onResend,
    this.dark = false,
    this.label = 'Resend code',
    this.prompt = '',
    this.showSmsDndHelp = false,
  });

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  int _seconds = 0;
  Timer? _timer;
  bool _busy = false;

  /// How many cooldowns have run down to zero on this screen.
  ///
  /// Gates the DND notice on "the customer WAITED and still has nothing",
  /// not merely on "the resend button is tappable". With initialSeconds = 0
  /// the button is live immediately and nobody has waited for anything, so
  /// troubleshooting advice would be premature and would read as the app
  /// blaming the user before its own code had a chance to arrive.
  int _cooldownsElapsed = 0;

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
        setState(() {
          _seconds = 0;
          _cooldownsElapsed += 1;
        });
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
      // NO FABRICATED COOLDOWN. null means nothing was sent, so there is
      // nothing to count down from — see the note on [onResend].
      if (next != null && next > 0) _start(next);
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

    final button = TextButton(
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

    if (!widget.showSmsDndHelp || _cooldownsElapsed == 0) return button;

    // The notice decides for itself whether this many waits is enough — the
    // threshold is an admin setting, not something each screen hardcodes.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        SmsDndNotice(dark: widget.dark, cooldownsElapsed: _cooldownsElapsed),
      ],
    );
  }
}
