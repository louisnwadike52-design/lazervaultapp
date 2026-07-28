import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// Settings → Security → Lock account. A user deliberately locks themselves out
/// of login AND transactions for a chosen timeframe. No early unlock — it just
/// elapses. Arming it revokes the current session, so the user is signed out
/// immediately and can't get back in (or transact) until the timer ends.
class LockAccountSheet extends StatefulWidget {
  /// Emergency lock = the same duration-based self-lock, but presented as an
  /// urgent one-purpose action (danger styling, `reason:'emergency'`, defaults
  /// to the longest duration). Same backend RPC — no server change.
  final bool emergency;

  const LockAccountSheet({super.key, this.emergency = false});

  static Future<void> show(BuildContext context, {bool emergency = false}) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: const Color(0xFF1F1F1F),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => LockAccountSheet(emergency: emergency),
      );

  @override
  State<LockAccountSheet> createState() => _LockAccountSheetState();
}

class _LockAccountSheetState extends State<LockAccountSheet> {
  static const Color _card = Color(0xFF2A2A2A);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _brand = Color(0xFF4834D4);
  static const Color _danger = Color(0xFFEF4444);

  // (label, seconds)
  static const List<(String, int)> _presets = [
    ('1 hour', 3600),
    ('8 hours', 28800),
    ('24 hours', 86400),
    ('3 days', 259200),
    ('7 days', 604800),
    ('30 days', 2592000),
  ];

  int? _selectedSeconds;
  bool _confirmStep = false;
  bool _busy = false;
  // Mutable so the single consolidated sheet can flip between a scheduled lock
  // and an emergency lock in-place (they share one backend RPC; emergency only
  // changes the default duration, the `reason`, and the danger styling).
  late bool _emergency;

  // Accent = danger red for the emergency variant, brand purple otherwise.
  Color get _accent => _emergency ? _danger : _brand;

  @override
  void initState() {
    super.initState();
    _emergency = widget.emergency;
    // Emergency lock defaults to the longest lock so the urgent action is a
    // single decisive confirm; the user can still shorten it before confirming.
    if (_emergency) _selectedSeconds = _presets.last.$2;
  }

  void _setEmergency(bool on) {
    setState(() {
      _emergency = on;
      // Default emergency to the longest lock when nothing chosen yet.
      if (on && _selectedSeconds == null) _selectedSeconds = _presets.last.$2;
    });
  }

  String _labelFor(int s) => _presets.firstWhere((p) => p.$2 == s, orElse: () => ('the selected time', s)).$1;

  Future<void> _lock() async {
    if (_selectedSeconds == null || _busy) return;
    setState(() => _busy = true);
    final result = await serviceLocator<IAuthRepository>().requestAccountLock(
      durationSeconds: _selectedSeconds!,
      reason: _emergency ? 'emergency' : 'scheduled',
    );
    if (!mounted) return;
    setState(() => _busy = false);

    result.fold(
      (failure) => Get.snackbar('Lock account', failure.message,
          snackPosition: SnackPosition.BOTTOM, backgroundColor: _danger, colorText: Colors.white,
          margin: EdgeInsets.all(12.w)),
      (lockedUntil) async {
        // Session is revoked server-side — wipe local + return to the auth entry.
        try {
          await serviceLocator<SecureStorageService>().clearAll();
        } catch (_) {}
        // AFTER the wipe: (1) persist the deadline + reason so the login screens
        // (and the boot router) surface the lock proactively with a live countdown
        // — no server round-trip; (2) restore has_seen_onboarding so a RETURNING
        // user who locked isn't shown the intro carousel again once it elapses
        // (clearAll wiped that flag too).
        try {
          final ss = serviceLocator<SecureStorageService>();
          await ss.setSelfLockUntil(lockedUntil,
              reason: _emergency ? 'emergency' : 'scheduled');
          await serviceLocator<FlutterSecureStorage>()
              .write(key: 'has_seen_onboarding', value: 'true');
        } catch (_) {}
        Navigator.of(context).pop();
        // Land on the LOGIN screen for the mode (not the signup entry), where the
        // countdown modal shows.
        Get.offAllNamed(AppRoutes.freshLoginEntry);
        Get.snackbar('Account locked',
            'You\'re locked out until ${_fmt(lockedUntil)}. There\'s no early unlock.',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: _card, colorText: Colors.white,
            margin: EdgeInsets.all(12.w), duration: const Duration(seconds: 6));
      },
    );
  }

  String _fmt(DateTime dt) {
    final l = dt.toLocal();
    final h = l.hour % 12 == 0 ? 12 : l.hour % 12;
    final ap = l.hour < 12 ? 'AM' : 'PM';
    final m = l.minute.toString().padLeft(2, '0');
    return '${l.day}/${l.month}/${l.year} $h:$m $ap';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w, right: 20.w, top: 12.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey[700], borderRadius: BorderRadius.circular(2))),
          ),
          SizedBox(height: 18.h),
          Row(children: [
            Icon(_emergency ? Icons.gpp_bad_rounded : Icons.lock_clock_rounded,
                color: _accent, size: 22.sp),
            SizedBox(width: 10.w),
            Text(_emergency ? 'Emergency lock' : 'Lock account',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
          ]),
          SizedBox(height: 6.h),
          Text(
            _confirmStep
                ? 'You\'ll be signed out now and can\'t sign in or make any transactions until the timer ends. There is no early unlock.'
                : _emergency
                    ? 'Immediately lock this account — sign-in and all transactions are blocked until the timer ends. Use this if your device or account may be compromised.'
                    : 'Temporarily lock yourself out of signing in and all transactions. Pick how long.',
            style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp, height: 1.4),
          ),
          SizedBox(height: 18.h),
          if (!_confirmStep) ...[
            // Mode toggle — one sheet covers both a planned lock and an urgent
            // "my device/account may be compromised" lock.
            Row(
              children: [
                Expanded(child: _modeChip('Scheduled', !_emergency, () => _setEmergency(false))),
                SizedBox(width: 10.w),
                Expanded(child: _modeChip('Emergency', _emergency, () => _setEmergency(true))),
              ],
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 10.w, runSpacing: 10.h,
              children: _presets.map((p) {
                final sel = _selectedSeconds == p.$2;
                return ChoiceChip(
                  label: Text(p.$1),
                  selected: sel,
                  onSelected: (_) => setState(() => _selectedSeconds = p.$2),
                  labelStyle: GoogleFonts.inter(
                      color: sel ? Colors.white : _textSecondary, fontWeight: FontWeight.w600, fontSize: 13.sp),
                  backgroundColor: _card,
                  selectedColor: _accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide(color: sel ? _accent : _divider),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 22.h),
            _primaryBtn('Continue',
                _selectedSeconds == null ? null : () => setState(() => _confirmStep = true),
                danger: _emergency),
          ] else ...[
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: _danger.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: _danger.withValues(alpha: 0.3)),
              ),
              child: Row(children: [
                Icon(Icons.warning_amber_rounded, color: _danger, size: 20.sp),
                SizedBox(width: 10.w),
                Expanded(child: Text(
                  'Lock for ${_labelFor(_selectedSeconds!)}. No one — including you — can sign in or transact until it ends.',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5.sp, height: 1.35, fontWeight: FontWeight.w600))),
              ]),
            ),
            SizedBox(height: 20.h),
            Row(children: [
              Expanded(child: TextButton(
                onPressed: _busy ? null : () => setState(() => _confirmStep = false),
                child: Text('Back', style: GoogleFonts.inter(color: _textSecondary, fontWeight: FontWeight.w600)))),
              SizedBox(width: 12.w),
              Expanded(flex: 2, child: _primaryBtn(_busy ? '' : (_emergency ? 'Lock now' : 'Lock my account'), _busy ? null : _lock, danger: true, busy: _busy)),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _modeChip(String label, bool selected, VoidCallback onTap) {
    final accent = label == 'Emergency' ? _danger : _brand;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.15) : _card,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: selected ? accent : _divider),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: selected ? Colors.white : _textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  Widget _primaryBtn(String label, VoidCallback? onTap, {bool danger = false, bool busy = false}) {
    return SizedBox(
      width: double.infinity, height: 50.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: danger ? _danger : _brand,
          disabledBackgroundColor: (danger ? _danger : _brand).withValues(alpha: 0.4),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: busy
            ? SizedBox(width: 22.w, height: 22.w, child: const CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
            : Text(label, style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
