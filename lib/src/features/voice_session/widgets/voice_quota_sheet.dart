import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// What the server told us when it refused to start a voice session.
///
/// Built from the `voice_quota_exceeded` event the agent emits at session
/// start, before any model tokens are spent.
@immutable
class VoiceQuotaInfo {
  const VoiceQuotaInfo({
    required this.freeMinutes,
    required this.usedMinutes,
    required this.needsPaygOptIn,
    this.reason = '',
  });

  final int freeMinutes;
  final int usedMinutes;

  /// Whether pay-as-you-go is available to offer.
  ///
  /// FALSE means the operator has turned it off, and the sheet must then say
  /// "you have used your minutes" WITHOUT an opt-in — offering to buy
  /// something that cannot be bought is worse than saying no.
  final bool needsPaygOptIn;

  final String reason;

  int get remainingMinutes =>
      freeMinutes - usedMinutes < 0 ? 0 : freeMinutes - usedMinutes;

  factory VoiceQuotaInfo.fromEvent(Map<String, dynamic> data) {
    int asInt(Object? v) {
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse('${v ?? ''}') ?? 0;
    }

    return VoiceQuotaInfo(
      freeMinutes: asInt(data['free_minutes']),
      usedMinutes: asInt(data['used_minutes']),
      // Defaults to FALSE. A malformed or partial event must not offer
      // pay-as-you-go — the user would accept a charge the server has not
      // agreed to apply.
      needsPaygOptIn: data['needs_payg_optin'] == true,
      reason: (data['reason'] ?? '').toString(),
    );
  }
}

/// Shows the monthly-allowance sheet. Returns true when the user opted in.
///
/// Deliberately a bottom sheet rather than an AlertDialog: it carries real
/// explanation (what was used, how charging works, that it is per-usage rather
/// than a subscription) and a dialog that size reads as an error.
Future<bool> showVoiceQuotaSheet(
  BuildContext context, {
  required VoiceQuotaInfo info,
  required Future<bool> Function() onOptIn,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _VoiceQuotaSheet(info: info, onOptIn: onOptIn),
  );
  return result == true;
}

class _VoiceQuotaSheet extends StatefulWidget {
  const _VoiceQuotaSheet({required this.info, required this.onOptIn});

  final VoiceQuotaInfo info;
  final Future<bool> Function() onOptIn;

  @override
  State<_VoiceQuotaSheet> createState() => _VoiceQuotaSheetState();
}

class _VoiceQuotaSheetState extends State<_VoiceQuotaSheet> {
  bool _busy = false;
  String? _error;

  Future<void> _optIn() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final ok = await widget.onOptIn();
      if (!mounted) return;
      if (ok) {
        Navigator.of(context).pop(true);
        return;
      }
      setState(() {
        _busy = false;
        _error = 'Could not turn on pay-as-you-go. Please try again.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        // Never surface a raw server error here: this sheet is about money, and
        // an allow-list or SQL string would be both confusing and a leak.
        _error = 'Server not reachable. Please try again shortly.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.info;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.graphic_eq,
                  color: const Color(0xFF8B5CF6), size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'You’ve used this month’s voice minutes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // The numbers, stated plainly. "You've used your minutes" without
          // saying how many invites an argument.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _Stat(label: 'Used', value: '${info.usedMinutes} min'),
                ),
                Container(width: 1, height: 26.h, color: Colors.white12),
                Expanded(
                  child: _Stat(
                      label: 'Included', value: '${info.freeMinutes} min'),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          if (info.needsPaygOptIn) ...[
            Text(
              'Keep talking with pay-as-you-go',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              // Honest about the basis. It is NOT a flat per-minute rate, and
              // promising one would be wrong in both directions: a quiet
              // minute costs almost nothing and a busy one costs much more.
              'You’ll only be charged for what you actually use — measured '
              'on the AI model usage of each conversation, converted to naira. '
              'Short or quiet calls cost very little. There is no subscription, '
              'and you can turn this off any time in Voice settings.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
                height: 1.45,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_balance_wallet_outlined,
                    size: 14.sp, color: Colors.white.withValues(alpha: 0.5)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Charged to your personal NGN account after each call. '
                    'Per-call and monthly limits apply, so a long conversation '
                    'cannot run up an unexpected bill.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ] else
            Text(
              // Pay-as-you-go is unavailable. Say so without dangling an
              // option that does not exist.
              'Your voice minutes reset at the start of next month. '
              'Everything else in the app works as normal in the meantime.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
                height: 1.45,
              ),
            ),
          if (_error != null) ...[
            SizedBox(height: 10.h),
            Text(_error!,
                style:
                    TextStyle(color: const Color(0xFFFCA5A5), fontSize: 11.sp)),
          ],
          SizedBox(height: 18.h),
          if (info.needsPaygOptIn)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        _busy ? null : () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: const BorderSide(color: Colors.white24),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: const Text('Not now'),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _busy ? null : _optIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: _busy
                        ? SizedBox(
                            height: 16.h,
                            width: 16.h,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Turn on'),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A3A3A),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: const Text('Got it'),
              ),
            ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 2.h),
        Text(label,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5), fontSize: 10.sp)),
      ],
    );
  }
}
