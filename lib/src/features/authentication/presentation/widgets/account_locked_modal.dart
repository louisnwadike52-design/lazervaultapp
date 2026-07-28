import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Detects a self-lock (or failed-login lockout) error from the auth backend and
/// extracts the unlock time. The backend returns "account is (self-)locked until
/// <RFC3339>" from the login gate; both shapes are handled here so the login
/// screens can show a countdown instead of a raw error.
DateTime? parseAccountLockUntil(String? message) {
  if (message == null) return null;
  final lower = message.toLowerCase();
  if (!lower.contains('locked until')) return null;
  // Grab the ISO-8601 timestamp after "until".
  final m = RegExp(r'until\s+([0-9T:\-+.Zz]+)').firstMatch(message);
  if (m == null) return null;
  return DateTime.tryParse(m.group(1)!.trim());
}

/// True when the error is a self-lock (owner locked themselves) vs a failed-login
/// lockout — lets the modal use the right copy.
bool isSelfLock(String? message) =>
    (message ?? '').toLowerCase().contains('self-locked');

/// Proactively surfaces the locked modal on a login screen when a self-lock
/// deadline is cached locally (written when the user armed a lock / emergency
/// lock). This makes the lock reflect on ARRIVAL — a live countdown — instead of
/// only after a failed login attempt. The cache self-clears once elapsed
/// (`getSelfLockUntil`), so this is a no-op the moment the lock ends. The backend
/// login gate remains the source of truth for the actual block.
Future<void> maybeShowSelfLockOnLaunch(BuildContext context) async {
  final ss = serviceLocator<SecureStorageService>();
  final until = await ss.getSelfLockUntil();
  if (until == null || !context.mounted) return;
  final emergency = (await ss.getSelfLockReason()) == 'emergency';
  if (!context.mounted) return;
  await showAccountLockedModal(context, until, selfLock: true, emergency: emergency);
}

/// Full-screen blocking modal shown on the login screens when the account is
/// locked. Live countdown to the unlock time; the only way out is to wait.
Future<void> showAccountLockedModal(BuildContext context, DateTime until,
    {bool selfLock = true, bool emergency = false}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) =>
        _AccountLockedDialog(until: until, selfLock: selfLock, emergency: emergency),
  );
}

class _AccountLockedDialog extends StatefulWidget {
  final DateTime until;
  final bool selfLock;
  final bool emergency;
  const _AccountLockedDialog(
      {required this.until, required this.selfLock, this.emergency = false});

  @override
  State<_AccountLockedDialog> createState() => _AccountLockedDialogState();
}

class _AccountLockedDialogState extends State<_AccountLockedDialog> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final rem = widget.until.difference(DateTime.now());
    if (!mounted) return;
    setState(() => _remaining = rem.isNegative ? Duration.zero : rem);
    if (rem.isNegative) {
      _timer?.cancel();
      // Lock elapsed — let the user retry.
      if (mounted) Navigator.of(context).maybePop();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _countdown {
    final d = _remaining;
    final days = d.inDays;
    final h = d.inHours % 24, m = d.inMinutes % 60, s = d.inSeconds % 60;
    if (days > 0) return '${days}d ${h}h ${m}m';
    if (h > 0) return '${h}h ${m}m ${s}s';
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: (widget.emergency ? const Color(0xFFEF4444) : const Color(0xFF4834D4))
                  .withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.emergency ? Icons.gpp_bad_rounded : Icons.lock_clock_rounded,
              color: widget.emergency ? const Color(0xFFEF4444) : const Color(0xFF8B7FE8),
              size: 30.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(widget.emergency ? 'Emergency lock active' : 'Account locked',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 10.h),
          Text(
            widget.emergency
                ? 'You emergency-locked this account. Sign-in and all transactions are blocked until the timer ends — there\'s no early unlock.'
                : widget.selfLock
                    ? 'You locked your account. Sign-in and all transactions are paused — there\'s no early unlock.'
                    : 'Too many attempts. Your account is temporarily locked.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.5.sp, height: 1.45),
          ),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(children: [
              Text('Unlocks in', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
              SizedBox(height: 4.h),
              Text(_countdown,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
            ]),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text('OK', style: GoogleFonts.inter(color: const Color(0xFF8B7FE8), fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
