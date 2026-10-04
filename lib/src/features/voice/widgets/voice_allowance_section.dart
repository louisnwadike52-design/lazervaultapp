import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Monthly voice allowance, and the way to turn pay-as-you-go OFF.
///
/// THE GAP THIS CLOSES
/// -------------------
/// The pay-as-you-go sheet lets someone opt IN when a call is refused, and the
/// server has always accepted a withdrawal — but nothing in the app offered
/// one. Consent you cannot withdraw where you gave it is not really consent,
/// and "you can turn this off any time in Voice settings" was written on the
/// opt-in sheet while that setting did not exist.
///
/// It also answers the question the sheet could only answer too late: how many
/// minutes are left. Previously the only way to learn about the allowance was
/// to be refused by it.
///
/// Renders NOTHING when billing is off (the shipped default), so the section
/// does not advertise a charge that cannot happen.
class VoiceAllowanceSection extends StatefulWidget {
  const VoiceAllowanceSection({
    super.key,
    required this.loadStatus,
    required this.setOptIn,
    this.dark = true,
  });

  /// Returns the `/voice/billing/status` payload, or null when it cannot be
  /// read. Null must render as "unknown", never as "no allowance left".
  final Future<Map<String, dynamic>?> Function() loadStatus;

  /// Records or withdraws consent. Returns true when saved.
  final Future<bool> Function(bool optedIn) setOptIn;

  final bool dark;

  @override
  State<VoiceAllowanceSection> createState() => _VoiceAllowanceSectionState();
}

class _VoiceAllowanceSectionState extends State<VoiceAllowanceSection> {
  Map<String, dynamic>? _status;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final s = await widget.loadStatus();
      if (!mounted) return;
      setState(() {
        _status = s;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      // Never surface a raw server error on a money surface.
      setState(() {
        _loading = false;
        _error = 'Could not load your voice usage.';
      });
    }
  }

  Future<void> _toggle(bool on) async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final ok = await widget.setOptIn(on);
      if (!mounted) return;
      if (!ok) {
        setState(() {
          _saving = false;
          _error = on
              ? 'Could not turn on pay-as-you-go.'
              : 'Could not turn it off. Please try again.';
        });
        return;
      }
      // Re-read rather than assuming: the server is the authority on whether
      // consent was recorded, and on the terms it was recorded against.
      await _load();
      if (mounted) setState(() => _saving = false);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Server not reachable. Please try again shortly.';
      });
    }
  }

  int _int(Object? v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('${v ?? ''}') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final fg = widget.dark ? Colors.white : const Color(0xFF1A1A1A);
    final muted = fg.withValues(alpha: 0.5);

    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: SizedBox(
          height: 16.h,
          width: 16.h,
          child: CircularProgressIndicator(strokeWidth: 2, color: muted),
        ),
      );
    }

    final s = _status;
    // Unknown, or the operator has billing off: say nothing rather than
    // advertise a charge that cannot happen.
    if (s == null || s['billing_enabled'] != true) {
      if (_error != null) {
        return Text(_error!,
            style: TextStyle(color: const Color(0xFFFCA5A5), fontSize: 11.sp));
      }
      return const SizedBox.shrink();
    }

    final free = _int(s['free_minutes']);
    final used = _int(s['used_minutes']);
    final optedIn = s['opted_in'] == true;
    final paygAvailable = s['payg_enabled'] == true;
    final remaining = free > 0 ? (free - used < 0 ? 0 : free - used) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: widget.dark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F4F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(child: _stat('Used this month', '$used min', fg, muted)),
              Container(width: 1, height: 26.h, color: muted.withValues(alpha: 0.3)),
              Expanded(
                child: _stat(
                  free > 0 ? 'Remaining' : 'Included',
                  free > 0 ? '${remaining ?? 0} min' : 'Unlimited',
                  fg,
                  muted,
                ),
              ),
            ],
          ),
        ),
        if (paygAvailable || optedIn) ...[
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pay-as-you-go',
                        style: TextStyle(
                            color: fg,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 2.h),
                    Text(
                      optedIn
                          ? 'On — conversations past your included minutes are '
                              'charged on what you actually use.'
                          : 'Off — conversations stop once your included '
                              'minutes are used.',
                      style: TextStyle(color: muted, fontSize: 11.sp, height: 1.4),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              if (_saving)
                SizedBox(
                  height: 16.h,
                  width: 16.h,
                  child: CircularProgressIndicator(strokeWidth: 2, color: muted),
                )
              else
                Switch(
                  value: optedIn,
                  onChanged: (v) => _toggle(v),
                  activeTrackColor: const Color(0xFF8B5CF6),
                ),
            ],
          ),
        ],
        if (_error != null) ...[
          SizedBox(height: 8.h),
          Text(_error!,
              style: TextStyle(color: const Color(0xFFFCA5A5), fontSize: 11.sp)),
        ],
      ],
    );
  }

  Widget _stat(String label, String value, Color fg, Color muted) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: TextStyle(
                color: fg, fontSize: 15.sp, fontWeight: FontWeight.w700)),
        SizedBox(height: 2.h),
        Text(label, style: TextStyle(color: muted, fontSize: 10.sp)),
      ],
    );
  }
}
