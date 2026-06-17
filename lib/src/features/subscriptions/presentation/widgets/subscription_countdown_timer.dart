import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Live countdown timer that ticks every second.
/// Shows "Xd Xh Xm" for active subscriptions, "Expired" for past.
class SubscriptionCountdownTimer extends StatefulWidget {
  final DateTime? expiresAt;

  const SubscriptionCountdownTimer({super.key, this.expiresAt});

  @override
  State<SubscriptionCountdownTimer> createState() =>
      _SubscriptionCountdownTimerState();
}

class _SubscriptionCountdownTimerState
    extends State<SubscriptionCountdownTimer> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemaining();
    // Only start timer if there's an expiry date that hasn't passed
    if (widget.expiresAt != null && _remaining > Duration.zero) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _calculateRemaining();
        // Stop ticking once expired
        if (_remaining <= Duration.zero) {
          _timer?.cancel();
          _timer = null;
        }
      });
    }
  }

  void _calculateRemaining() {
    if (widget.expiresAt == null) return;
    final now = DateTime.now();
    final diff = widget.expiresAt!.difference(now);
    if (mounted) {
      setState(() {
        _remaining = diff.isNegative ? Duration.zero : diff;
      });
    }
  }

  @override
  void didUpdateWidget(covariant SubscriptionCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expiresAt != widget.expiresAt) {
      _calculateRemaining();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    if (d <= Duration.zero) return 'Expired';
    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    }
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    final seconds = d.inSeconds.remainder(60);
    return '${minutes}m ${seconds}s';
  }

  Color get _countdownColor {
    if (widget.expiresAt == null) return const Color(0xFF9CA3AF);
    if (_remaining <= Duration.zero) return const Color(0xFFEF4444);
    if (_remaining.inDays <= 1) return const Color(0xFFEF4444);
    if (_remaining.inDays <= 3) return const Color(0xFFFB923C);
    return const Color(0xFF10B981);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expiresAt == null) {
      return Text(
        'No expiry',
        style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          _remaining <= Duration.zero ? Icons.timer_off : Icons.timer_outlined,
          color: _countdownColor,
          size: 18.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          _formatDuration(_remaining),
          style: TextStyle(
            color: _countdownColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
