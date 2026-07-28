import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Whether [isoDateOfBirth] (`YYYY-MM-DD`) falls on today's month + day.
///
/// Tolerant of the couple of DOB shapes the backend has stored over time
/// (`YYYY-MM-DD`, or a full ISO timestamp) — it only ever compares month/day,
/// never the year, so it lights up every year on the day.
bool isBirthdayToday(String? isoDateOfBirth) {
  final md = _monthDay(isoDateOfBirth);
  if (md == null) return false;
  final now = DateTime.now();
  return md.$1 == now.month && md.$2 == now.day;
}

/// Parse a stored DOB into (month, day). Returns null when unparseable.
(int, int)? _monthDay(String? iso) {
  final raw = (iso ?? '').trim();
  if (raw.isEmpty) return null;
  // Fast path: leading `YYYY-MM-DD`.
  final m = RegExp(r'^\d{4}-(\d{2})-(\d{2})').firstMatch(raw);
  if (m != null) {
    final month = int.tryParse(m.group(1)!);
    final day = int.tryParse(m.group(2)!);
    if (month != null && day != null && month >= 1 && month <= 12) {
      return (month, day);
    }
  }
  final parsed = DateTime.tryParse(raw);
  if (parsed != null) return (parsed.month, parsed.day);
  return null;
}

/// A warm, celebratory birthday banner shown on the Settings page on the user's
/// birthday. Deep-purple brand gradient, the Lazervault wordmark, a soft looping
/// confetti fall, and a family-friendly greeting. Self-contained — the confetti
/// is painted (no extra package) so it ships with the app binary.
class BirthdayCelebrationCard extends StatefulWidget {
  final String firstName;

  const BirthdayCelebrationCard({super.key, required this.firstName});

  @override
  State<BirthdayCelebrationCard> createState() =>
      _BirthdayCelebrationCardState();
}

class _BirthdayCelebrationCardState extends State<BirthdayCelebrationCard>
    with TickerProviderStateMixin {
  late final AnimationController _confettiController;
  late final AnimationController _entranceController;
  late final List<_Confetto> _confetti;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    final rng = math.Random(42); // fixed seed → stable, non-jittery layout
    _confetti = List.generate(28, (_) => _Confetto.random(rng));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.firstName.trim().isEmpty
        ? 'there'
        : widget.firstName.trim();
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutBack,
      ),
      child: FadeTransition(
        opacity: _entranceController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4E03D0), Color(0xFF7C3AED), Color(0xFFDB2777)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Stack(
              children: [
                // Looping confetti behind the content.
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _confettiController,
                    builder: (context, _) => CustomPaint(
                      painter: _ConfettiPainter(
                        progress: _confettiController.value,
                        confetti: _confetti,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 22.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Lazervault logo in a frosted chip.
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Image.asset(
                              'assets/images/logos/lazervault-logo-only.png',
                              width: 26.w,
                              height: 26.w,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.card_giftcard_rounded,
                                color: Colors.white,
                                size: 26.w,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            '🎉 It\'s your day!',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const Spacer(),
                          Text('🎂', style: TextStyle(fontSize: 22.sp)),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Happy Birthday, $name!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'From all of us at Lazervault — wishing you a wonderful '
                        'year ahead, filled with joy, good health, and big wins. '
                        'Thank you for being part of the family. 💜',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 13.sp,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One confetto's fixed traits; its vertical position is derived from the shared
/// animation [progress] so the whole field falls in a gentle loop.
class _Confetto {
  final double xFraction; // 0..1 horizontal position
  final double phase; // 0..1 offset so pieces don't fall in lockstep
  final double size;
  final double swayAmplitude;
  final double rotationSpeed;
  final Color color;

  const _Confetto({
    required this.xFraction,
    required this.phase,
    required this.size,
    required this.swayAmplitude,
    required this.rotationSpeed,
    required this.color,
  });

  factory _Confetto.random(math.Random rng) {
    const palette = [
      Color(0xFFFFFFFF),
      Color(0xFFFFD166),
      Color(0xFF06D6A0),
      Color(0xFFFF6B6B),
      Color(0xFF4CC9F0),
      Color(0xFFFFC8DD),
    ];
    return _Confetto(
      xFraction: rng.nextDouble(),
      phase: rng.nextDouble(),
      size: 5.0 + rng.nextDouble() * 6.0,
      swayAmplitude: 6.0 + rng.nextDouble() * 14.0,
      rotationSpeed: 0.5 + rng.nextDouble() * 2.5,
      color: palette[rng.nextInt(palette.length)],
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final double progress; // 0..1 loop
  final List<_Confetto> confetti;

  _ConfettiPainter({required this.progress, required this.confetti});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final c in confetti) {
      // Each piece cycles top→bottom on its own phase-shifted clock.
      final t = (progress + c.phase) % 1.0;
      final dy = t * (size.height + 24) - 12;
      final sway = math.sin((t * 2 * math.pi) + c.phase * 6) * c.swayAmplitude;
      final dx = c.xFraction * size.width + sway;
      // Fade in near the top and out near the bottom so pieces don't pop.
      final opacity = (math.sin(t * math.pi)).clamp(0.0, 1.0);
      paint.color = c.color.withValues(alpha: 0.85 * opacity);

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(t * c.rotationSpeed * 2 * math.pi);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: c.size,
            height: c.size * 0.6,
          ),
          Radius.circular(c.size * 0.2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}
