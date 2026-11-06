import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// The Identity Verification screen WHILE ITS STATUS IS STILL LOADING.
///
/// WHAT THIS REPLACES. The screen used to render its real content
/// immediately — the header read "Verify Your Identity", the tier card was
/// simply absent because status was null, and a two-pixel
/// LinearProgressIndicator sat between them. A customer who was already
/// verified therefore opened a screen telling them to verify, waited, and
/// watched it rewrite itself into "You're Verified" with a tier card. The
/// first paint was not a loading state, it was a confident wrong answer.
///
/// A skeleton is the honest version: it says "something goes here and we do
/// not know what yet" without naming either outcome. The blocks deliberately
/// mirror the real layout — header, tier card, info card, benefits, CTA — so
/// the page does not visibly reflow when the content arrives.
///
/// Colours are the screen's own constants rather than the crypto skeleton's,
/// which is tuned for a different surface.
class KycStatusSkeleton extends StatelessWidget {
  const KycStatusSkeleton({super.key});

  static const Color _card = Color(0xFF1F1F1F);
  static const Color _highlight = Color(0xFF2D2D2D);

  Widget _box({required double width, required double height, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _card,
      highlightColor: _highlight,
      period: const Duration(milliseconds: 1200),
      // Excluded from semantics: a screen reader announcing a row of empty
      // placeholder boxes is noise. The real content announces itself when it
      // replaces this.
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header — title then subtitle, two lines because the real
            // subtitle wraps at every phone width we support.
            _box(width: 200.w, height: 22.h, radius: 6),
            SizedBox(height: 10.h),
            _box(width: double.infinity, height: 12.h, radius: 4),
            SizedBox(height: 6.h),
            _box(width: 220.w, height: 12.h, radius: 4),

            SizedBox(height: 20.h),
            // Tier card.
            _box(width: double.infinity, height: 88.h, radius: 14),

            SizedBox(height: 16.h),
            // Info card — the long explanatory paragraph.
            _box(width: double.infinity, height: 96.h, radius: 12),

            SizedBox(height: 18.h),
            // Benefits list: a heading and three rows.
            _box(width: 120.w, height: 14.h, radius: 4),
            SizedBox(height: 12.h),
            for (var i = 0; i < 3; i++) ...[
              Row(
                children: [
                  _box(width: 18.w, height: 18.h, radius: 9),
                  SizedBox(width: 10.w),
                  _box(width: (i.isEven ? 200 : 160).w, height: 12.h, radius: 4),
                ],
              ),
              SizedBox(height: 10.h),
            ],

            SizedBox(height: 20.h),
            // The CTA, so the button does not appear to jump in late.
            _box(width: double.infinity, height: 50.h, radius: 12),
          ],
        ),
      ),
    );
  }
}
