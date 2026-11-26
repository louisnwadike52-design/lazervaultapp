import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/kyc/domain/kyc_session_cooldown.dart';

/// "Your details are saved — try again in N minutes."
///
/// Shown when the customer corrected a detail and asked to verify again inside
/// the billed-session reuse window. The correction IS saved; the only thing
/// waiting is a fresh provider session that carries it.
///
/// ## The number is the server's, not ours
///
/// [KycSessionCooldownException.retryAfter] comes back on the initiate
/// response, computed from the server's clock against an admin-tunable window
/// (`kyc.mono.session_reuse_seconds`). Counting down from a constant compiled
/// into the app would drift the moment an operator changed that setting — and
/// drift in the cheerful direction, re-offering the attempt early, straight
/// into the same refusal.
///
/// ## Why it counts down live
///
/// A static "try again in 7 minutes" gives the customer nothing to do but
/// guess when to come back, on a screen they are already stuck on. The timer
/// runs, and the button becomes live by itself.
Future<bool> showKycSessionCooldownModal({
  required BuildContext context,
  required KycSessionCooldownException cooldown,
}) async {
  final retry = await showDialog<bool>(
    context: context,
    // Dismissible: this is a wait, not a trap, and the customer may well want
    // to put the phone down rather than watch a timer.
    barrierDismissible: true,
    builder: (ctx) => _CooldownDialog(cooldown: cooldown),
  );
  return retry ?? false;
}

class _CooldownDialog extends StatefulWidget {
  final KycSessionCooldownException cooldown;
  const _CooldownDialog({required this.cooldown});

  @override
  State<_CooldownDialog> createState() => _CooldownDialogState();
}

class _CooldownDialogState extends State<_CooldownDialog> {
  late DateTime _readyAt;
  late Duration _left;

  @override
  void initState() {
    super.initState();
    // An absolute instant, not a decrementing counter: a ticker that misses
    // beats while the app is backgrounded would leave the dialog claiming
    // minutes that have already passed.
    _readyAt = DateTime.now().add(widget.cooldown.retryAfter);
    _left = widget.cooldown.retryAfter;
    _tick();
  }

  void _tick() async {
    while (mounted && _left.inSeconds > 0) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        final remaining = _readyAt.difference(DateTime.now());
        _left = remaining.isNegative ? Duration.zero : remaining;
      });
    }
  }

  String get _countdown {
    final s = _left.inSeconds;
    if (s <= 0) return 'now';
    final m = s ~/ 60;
    final r = s % 60;
    if (m == 0) return '$r second${r == 1 ? '' : 's'}';
    return '$m:${r.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final ready = _left.inSeconds <= 0;
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      title: Text(
        ready ? 'Ready to try again' : 'Your details are saved',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ready
                ? 'We can start a fresh verification check with your updated '
                    'details now.'
                : 'A verification check is still running with your previous '
                    'details. We need to start a fresh one so it uses what you '
                    'just changed.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),
          if (!ready) ...[
            SizedBox(height: 16.h),
            Center(
              child: Column(
                children: [
                  Text(
                    _countdown,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'until you can try again',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 14.h),
          Text(
            'Nothing is lost — your changes are already saved to your profile.',
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 11.5.sp,
              height: 1.45,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Close',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
        ),
        ElevatedButton(
          // Live only once the wait is over, so the button can never send the
          // customer back into the same refusal.
          onPressed: ready ? () => Navigator.pop(context, true) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4834D4),
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFF4834D4).withValues(alpha: 0.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          ),
          child: Text('Try again',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
