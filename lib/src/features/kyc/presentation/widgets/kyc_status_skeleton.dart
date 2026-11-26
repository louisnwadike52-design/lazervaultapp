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

  // Kept in step with bvn_verification_screen's surface tokens. The skeleton is
  // the FIRST thing drawn on that screen and the real cards replace it in
  // place, so a different shade here reads as the page changing colour under
  // the user rather than as content arriving.
  //
  // THESE WERE DARK (#17171C / #212128) ON A LIGHT PAGE. The comment above
  // claimed they tracked the screen's surface tokens, and they did not: that
  // screen's ground is `_bg` #F6F5FB with white cards (bvn_verification_screen
  // L59-60). So opening Identity Verification from Settings painted a column of
  // near-black blocks over a near-white page for as long as the status took to
  // load — which reads as a rendering fault, not as loading, and is the first
  // thing a customer sees on the screen that asks for their BVN.
  //
  // Now: a light placeholder a shade below the page ground, with a near-white
  // sweep. The contrast against #F6F5FB is deliberately gentle — a skeleton is
  // meant to be ignorable, and a hard edge against a pale page draws more
  // attention than the content that replaces it.
  static const Color _card = Color(0xFFE6E4EF);
  static const Color _highlight = Color(0xFFF7F6FB);

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
            // The header is CENTRED on the real screen — a badge, then a
            // centred title and a centred two-line subtitle. A left-aligned
            // skeleton makes the content appear to slide sideways when it
            // lands, which reads as a layout bug rather than a load.
            SizedBox(height: 8.h),
            Center(child: _box(width: 84.w, height: 84.w, radius: 42)),
            SizedBox(height: 18.h),
            Center(child: _box(width: 210.w, height: 24.h, radius: 6)),
            SizedBox(height: 10.h),
            Center(child: _box(width: 280.w, height: 12.h, radius: 4)),
            SizedBox(height: 6.h),
            Center(child: _box(width: 200.w, height: 12.h, radius: 4)),

            SizedBox(height: 22.h),
            // Tier card — taller than it was, because it now carries the
            // three-segment tier rail under its heading row.
            _box(width: double.infinity, height: 124.h, radius: 18),

            SizedBox(height: 12.h),
            // "What you'll need" — heading, three icon rows, a footnote.
            _box(width: double.infinity, height: 232.h, radius: 18),

            SizedBox(height: 18.h),
            // The numbered next-tier steps.
            _box(width: double.infinity, height: 120.h, radius: 18),

            SizedBox(height: 22.h),
            // The CTA, so the button does not appear to jump in late.
            _box(width: double.infinity, height: 54.h, radius: 16),
          ],
        ),
      ),
    );
  }
}
