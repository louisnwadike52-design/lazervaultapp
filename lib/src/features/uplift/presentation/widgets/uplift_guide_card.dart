import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/uplift/data/services/uplift_guide_preference.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';

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

/// Shows one tab's explainer in a dialog, on demand.
///
/// The inline [UpliftGuideCard] is a FIRST-RUN affordance: it appears once and
/// the user can dismiss it, or turn the set off entirely. That left the copy
/// unreachable the moment it was dismissed — and the moment someone wants to
/// know what "My Funds" means is rarely the first second they land on it.
///
/// A dialog rather than the inline card here, because this one was ASKED for:
/// an explainer you opened deliberately should take focus and be dismissed
/// deliberately, where one that appears on its own must not block the content
/// you came to read.
///
/// Same [UpliftGuideCopy] as the card — one source for the words, so the
/// dialog and the banner can never drift into describing the tab differently.
Future<void> showUpliftTabInfo(BuildContext context, String tabId) {
  final copy = UpliftGuideCopy.byTab[tabId];
  if (copy == null) return Future<void>.value();
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF17151F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(copy.icon, color: kUpPrimary, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              copy.title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        copy.body,
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 13.sp,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text('Got it',
              style: GoogleFonts.inter(
                  color: kUpPrimary, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

/// The compact, permanent way back to a tab's explainer.
///
/// Rendered where the dismissed [UpliftGuideCard] used to sit, so the space
/// collapses to one line instead of vanishing — the information stays
/// reachable without the banner being permanent.
class UpliftTabInfoLink extends StatelessWidget {
  const UpliftTabInfoLink({super.key, required this.tabId});

  final String tabId;

  @override
  Widget build(BuildContext context) {
    final copy = UpliftGuideCopy.byTab[tabId];
    if (copy == null) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () => showUpliftTabInfo(context, tabId),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(Icons.info_outline,
            size: 15.sp, color: Colors.white.withValues(alpha: 0.45)),
        label: Text(
          'About ${copy.title.toLowerCase()}',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.45),
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
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
        border: Border.all(color: kUpPrimary.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(copy.icon, color: kUpPrimarySoft, size: 20.sp),
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
                    color: kUpPrimarySoft,
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
