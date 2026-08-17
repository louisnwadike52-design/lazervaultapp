part of 'account_carousel.dart';

// Type definition for the callback when a card's details are requested
typedef OnShowDetailsCallback = void Function(Map<String, dynamic> accountArgs);

/// Time windows offered in the trend-period picker. Order matters — the
/// bottom sheet renders them in declaration order.
enum _TrendPeriod {
  day('Last 24 hours', 'Day-on-day change', 'day'),
  week('Last 7 days', 'Week-on-week change', 'week'),
  month('Last 30 days', 'Month-on-month change', 'month'),
  year('Last 12 months', 'Year-on-year change', 'year');

  final String label;
  final String subtitle;
  // Backend period token sent to GetUserAccounts / persisted in the cubit.
  final String api;
  const _TrendPeriod(this.label, this.subtitle, this.api);

  static _TrendPeriod fromApi(String api) => _TrendPeriod.values
      .firstWhere((p) => p.api == api, orElse: () => _TrendPeriod.month);
}

/// Frost treatment painted over a FROZEN account card: a cold white sheen, a
/// row of icicles hanging from the top edge, and a light frost down both sides —
/// so a frozen card reads unmistakably as "iced over" at a glance. Purely
/// decorative and non-interactive (IgnorePointer), sits above the card art but
/// below the content so text/badges stay legible.
class _FrozenFrostOverlay extends StatelessWidget {
  const _FrozenFrostOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              // Cold white diagonal sheen so the whole card looks frosted.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.16),
                        Colors.white.withValues(alpha: 0.02),
                        Colors.white.withValues(alpha: 0.12),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Frost down the LEFT edge.
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  width: 26.w,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.35),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Frost down the RIGHT edge.
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  width: 26.w,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.white.withValues(alpha: 0.35),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Icicles hanging from the top edge.
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 22.h,
                  child: CustomPaint(painter: _IciclePainter()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Draws a row of translucent-white icicles of varying length hanging from the
/// top edge, giving a frozen card its "iced-over" fringe.
class _IciclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.55),
          Colors.white.withValues(alpha: 0.12),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Deterministic varied lengths (no RNG — keeps rebuilds stable).
    const pattern = <double>[1.0, 0.55, 0.8, 0.4, 0.9, 0.5, 0.7, 0.45, 0.85, 0.6];
    final count = pattern.length;
    final slot = size.width / count;
    final halfBase = slot * 0.42;
    for (int i = 0; i < count; i++) {
      final cx = slot * i + slot / 2;
      final len = size.height * pattern[i];
      final path = Path()
        ..moveTo(cx - halfBase, 0)
        ..lineTo(cx + halfBase, 0)
        ..lineTo(cx, len)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _IciclePainter oldDelegate) => false;
}
