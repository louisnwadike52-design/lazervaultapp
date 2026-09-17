import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/uplift/data/services/uplift_guide_preference.dart';

/// What each LazerFunds tab is for, in the user's terms.
///
/// The wording answers the question someone actually has on arrival — "what am
/// I looking at and what happens if I tap something" — rather than describing
/// the feature. Money is involved in all three, and the difference between
/// committing funds and requesting them is the thing a newcomer is most likely
/// to get wrong.
class UpliftGuideCopy {
  final String title;
  final String body;
  final IconData icon;

  const UpliftGuideCopy({
    required this.title,
    required this.body,
    required this.icon,
  });

  static const Map<String, UpliftGuideCopy> byTab = {
    UpliftGuidePreference.tabDiscover: UpliftGuideCopy(
      icon: Icons.explore_outlined,
      title: 'Businesses raising funds',
      body:
          'These are real businesses asking for capital. Open one to see what '
          'they do, how much they need and what they are offering in return. '
          'Nothing is committed until you fund a milestone and confirm it with '
          'your PIN.',
    ),
    UpliftGuidePreference.tabMyFunds: UpliftGuideCopy(
      icon: Icons.volunteer_activism_outlined,
      title: 'Money you have committed',
      body:
          'Funds you have backed live here. Money is released to the business '
          'milestone by milestone rather than all at once, so you can follow '
          'what has been paid out and what is still held.',
    ),
    UpliftGuidePreference.tabMyApplications: UpliftGuideCopy(
      icon: Icons.inbox_outlined,
      title: 'Funding you have asked for',
      body:
          'Raises you have created, and where each one stands. Once funded, you '
          'receive money as you complete milestones — each release is reviewed '
          'before it pays out.',
    ),
  };
}

/// The first-run explainer for one LazerFunds tab.
///
/// An inline card rather than a modal or a coach-mark overlay. A modal on
/// arrival blocks the thing the user came to look at and trains them to dismiss
/// without reading; an inline card sits above the content, is readable
/// alongside it, and can be ignored by simply scrolling — which is the honest
/// outcome for someone who does not want it.
class UpliftGuideCard extends StatelessWidget {
  const UpliftGuideCard({
    super.key,
    required this.tabId,
    required this.onDismiss,
    required this.onNeverShowAgain,
  });

  final String tabId;

  /// Close this card only. The tab is marked seen, so it does not come back on
  /// its own, but the other tabs still get their turn.
  final VoidCallback onDismiss;

  /// The standing choice: stop showing these anywhere. Mirrored by the
  /// Settings toggle, so a user who regrets it has a way back that does not
  /// involve reinstalling.
  final VoidCallback onNeverShowAgain;

  @override
  Widget build(BuildContext context) {
    final copy = UpliftGuideCopy.byTab[tabId];
    if (copy == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1430),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF4E03D0).withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(copy.icon, color: const Color(0xFF9B6DFF), size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  copy.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Close is a plain icon, not a button: dismissing an explainer is
              // the cheap, reversible action and should not compete with the
              // content for attention.
              GestureDetector(
                onTap: onDismiss,
                child: Icon(Icons.close, color: Colors.grey[500], size: 18.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            copy.body,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.5.sp,
              height: 1.45,
            ),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onNeverShowAgain,
              child: Padding(
                // A real tap target: this is the control someone reaches for
                // when they are already mildly irritated.
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                child: Text(
                  "Don't show these again",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9B6DFF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
