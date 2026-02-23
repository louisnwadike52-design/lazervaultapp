import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../domain/repositories/i_exchange_repository.dart';

class RateCountdownWidget extends StatefulWidget {
  final ExchangeRate rate;
  final VoidCallback onExpired;
  final VoidCallback? onRefresh;

  const RateCountdownWidget({
    super.key,
    required this.rate,
    required this.onExpired,
    this.onRefresh,
  });

  @override
  State<RateCountdownWidget> createState() => _RateCountdownWidgetState();
}

class _RateCountdownWidgetState extends State<RateCountdownWidget> {
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void didUpdateWidget(RateCountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rate.rateId != widget.rate.rateId ||
        oldWidget.rate.timestamp != widget.rate.timestamp) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    final elapsed = DateTime.now().difference(widget.rate.timestamp).inSeconds;
    _remainingSeconds = (widget.rate.rateValidSeconds - elapsed).clamp(0, widget.rate.rateValidSeconds);

    if (_remainingSeconds <= 0) {
      // Defer callback to avoid calling setState during build phase
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onExpired();
      });
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _remainingSeconds--;
      });
      if (_remainingSeconds <= 0) {
        timer.cancel();
        widget.onExpired();
      }
    });
  }

  Color get _color {
    if (_remainingSeconds > 30) return const Color(0xFF10B981);
    if (_remainingSeconds > 10) return const Color(0xFFFB923C);
    return const Color(0xFFEF4444);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingSeconds <= 0) {
      return GestureDetector(
        onTap: widget.onRefresh,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh, size: 14, color: Color(0xFFEF4444)),
              SizedBox(width: 4),
              Text(
                'Rate expired - Tap to refresh',
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    final timeStr = minutes > 0
        ? '${minutes}m ${seconds.toString().padLeft(2, '0')}s'
        : '${seconds}s';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, size: 14, color: _color),
          const SizedBox(width: 4),
          Text(
            'Rate valid for $timeStr',
            style: TextStyle(
              color: _color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
