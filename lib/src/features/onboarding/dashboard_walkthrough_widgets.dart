part of 'dashboard_walkthrough.dart';

/// Brand-purple coach-mark card with a directional beak + accent border that
/// points at its target. Uses the context-free [ShowcaseView] controller so it
/// never depends on overlay context.
class _CoachCard extends StatelessWidget {
  const _CoachCard({
    required this.indexKey,
    required this.title,
    required this.body,
    required this.position,
  });

  // The target's key — its "n / total" number is derived from its live position
  // in the tour, so a conditional/added step never needs manual renumbering.
  final GlobalKey indexKey;
  final String title;
  final String body;
  final TooltipPosition position;

  // Purplish theme.
  static const _card = Color(0xFF1E1533); // dark purple-tinted card
  static const _accent = Color(0xFF8B5CF6); // vivid purple — pointer/border/step
  static const _button = Color(0xFF6F42C1); // Next button
  static const _textSecondary = Color(0xFFB8A9DC); // soft lavender-grey

  int get index => DashboardWalkthrough.stepIndexOf(indexKey);
  bool get _isLast => index >= DashboardWalkthrough.totalSteps;

  /// Which edge of the card faces (points at) the target.
  AxisDirection get _pointDirection {
    switch (position) {
      case TooltipPosition.bottom: // tooltip below target → point UP
        return AxisDirection.up;
      case TooltipPosition.top: // tooltip above target → point DOWN
        return AxisDirection.down;
      case TooltipPosition.left: // tooltip left of target → point RIGHT
        return AxisDirection.right;
      case TooltipPosition.right: // tooltip right of target → point LEFT
        return AxisDirection.left;
    }
  }

  @override
  Widget build(BuildContext context) {
    final beak = _Beak(direction: _pointDirection, color: _accent);
    final card = _buildCard();

    // Arrange [beak · card] so the beak sits on the target-facing edge.
    switch (_pointDirection) {
      case AxisDirection.up:
        return _wrap(Column(mainAxisSize: MainAxisSize.min, children: [beak, card]));
      case AxisDirection.down:
        return _wrap(Column(mainAxisSize: MainAxisSize.min, children: [card, beak]));
      case AxisDirection.left:
        return _wrap(Row(mainAxisSize: MainAxisSize.min, children: [beak, card]));
      case AxisDirection.right:
        return _wrap(Row(mainAxisSize: MainAxisSize.min, children: [card, beak]));
    }
  }

  Widget _wrap(Widget child) => Material(color: Colors.transparent, child: child);

  Widget _buildCard() {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.w),
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        // UNIFORM border only — Flutter forbids a borderRadius with a
        // non-uniform (per-side colored) Border and throws during paint,
        // which aborts painting the card's text children (blank card). The
        // directional beak already points at the target.
        border: Border.all(color: _accent.withValues(alpha: 0.55), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: 0.25),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index / ${DashboardWalkthrough.totalSteps}',
            style: TextStyle(
              color: _accent,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            body,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12.5.sp,
              height: 1.35,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Subtle Skip — always available, low emphasis.
              TextButton(
                onPressed: () {
                  ShowcaseView.get().dismiss();
                  DashboardWalkthrough.markSeen();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Prominent Next / Done — draws the user through the tour.
              ElevatedButton(
                onPressed: () {
                  if (_isLast) {
                    ShowcaseView.get().dismiss();
                    DashboardWalkthrough.markSeen();
                  } else {
                    ShowcaseView.get().next();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _button,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _isLast ? 'Done' : 'Next',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small solid triangle "beak" pointing in [direction], drawn in [color] so
/// the coach card visibly points at its target. For up/down it's a wide-based
/// horizontal triangle; for left/right a tall vertical one.
class _Beak extends StatelessWidget {
  const _Beak({required this.direction, required this.color});

  final AxisDirection direction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool vertical =
        direction == AxisDirection.up || direction == AxisDirection.down;
    final double w = vertical ? 18.w : 9.w;
    final double h = vertical ? 9.h : 18.h;
    return CustomPaint(
      size: Size(w, h),
      painter: _BeakPainter(direction: direction, color: color),
    );
  }
}

class _BeakPainter extends CustomPainter {
  _BeakPainter({required this.direction, required this.color});

  final AxisDirection direction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    switch (direction) {
      case AxisDirection.up: // apex at top-center, base along the bottom
        path
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        break;
      case AxisDirection.down: // apex at bottom-center, base along the top
        path
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width / 2, size.height)
          ..close();
        break;
      case AxisDirection.left: // apex at left-center, base along the right
        path
          ..moveTo(0, size.height / 2)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..close();
        break;
      case AxisDirection.right: // apex at right-center, base along the left
        path
          ..moveTo(size.width, size.height / 2)
          ..lineTo(0, 0)
          ..lineTo(0, size.height)
          ..close();
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BeakPainter oldDelegate) =>
      oldDelegate.direction != direction || oldDelegate.color != color;
}
