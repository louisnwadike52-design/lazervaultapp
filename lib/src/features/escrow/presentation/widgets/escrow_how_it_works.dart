import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/escrow_theme.dart';
import 'escrow_terms.dart';

/// The three-slide "how this works" guide, shown once before a first deal
/// and available any time from the info icon.
///
/// THREE SLIDES, NOT SEVEN. The flow has exactly three beats that change who
/// holds the money, and a guide longer than the thing it explains is a guide
/// nobody finishes. Everything else (disputes, refunds, cancellation) is an
/// EXCEPTION to those beats, so it rides on the slide whose beat it breaks
/// rather than claiming slides of its own.
class EscrowGuideSlide {
  final IconData icon;
  final Color tint;
  final String title;
  final String body;

  /// The exception that applies at this step. Shown as a quieter line under
  /// the body, because a user reading the happy path still needs to know
  /// what happens when it does not happen.
  final String? ifItGoesWrong;

  const EscrowGuideSlide({
    required this.icon,
    required this.tint,
    required this.title,
    required this.body,
    this.ifItGoesWrong,
  });
}

const List<EscrowGuideSlide> kEscrowGuideSlides = [
  EscrowGuideSlide(
    icon: Icons.storefront_outlined,
    tint: Color(0xFF8B5CF6),
    title: 'One of you makes an offer',
    body: 'A seller lists what they are selling, or a buyer asks for what '
        'they want. One other person is tagged on it, because this is a '
        'payment channel between two people, not a marketplace.',
    ifItGoesWrong: 'An offer sits under Offers until it is paid for. The '
        'moment the buyer pays, it moves into the tabs below as a live deal.',
  ),
  EscrowGuideSlide(
    icon: Icons.lock_outline_rounded,
    tint: Color(0xFF3B82F6),
    title: 'The buyer pays, and we hold it',
    body: 'Accepting an offer pays for it there and then. The money goes to '
        'Lazervault, not to the seller, and it stays locked while the seller '
        'gets on with delivering.',
    ifItGoesWrong: 'The seller can cancel before delivery is marked, which '
        'refunds the buyer in full, automatically.',
  ),
  EscrowGuideSlide(
    icon: Icons.verified_outlined,
    tint: Color(0xFF10B981),
    title: 'Delivery, then release',
    body: 'The seller marks it delivered. The buyer checks it and releases '
        'the funds, which pays the seller. Releasing is final.',
    ifItGoesWrong: 'Not happy? The buyer can request a refund, and either '
        'side can open a dispute. The money stays frozen while our team '
        'reviews what both of you submit.',
  ),
];

/// Shows the guide. Returns true when the user reached the end, false when
/// they backed out, so a first-run caller can decide whether to mark it seen.
Future<bool> showEscrowHowItWorks(BuildContext context) async {
  final done = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // Dismissible by design. A guide you cannot escape is an obstacle, and
    // the info icon brings it back whenever it is wanted.
    builder: (ctx) => const _GuideSheet(),
  );
  return done ?? false;
}

class _GuideSheet extends StatefulWidget {
  const _GuideSheet();

  @override
  State<_GuideSheet> createState() => _GuideSheetState();
}

class _GuideSheetState extends State<_GuideSheet> {
  final _pages = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _next() {
    if (_index >= kEscrowGuideSlides.length - 1) {
      // Reached the end: that is the only outcome that counts as "seen".
      Navigator.of(context).pop(true);
      return;
    }
    _pages.nextPage(
        duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
  }

  void _back() {
    // On the first slide, Back leaves — rather than being a dead control,
    // which is how a user decides a sheet is stuck.
    if (_index == 0) {
      Navigator.of(context).pop(false);
      return;
    }
    _pages.previousPage(
        duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final last = _index == kEscrowGuideSlides.length - 1;
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.80),
      margin: EdgeInsets.fromLTRB(
          14.w, MediaQuery.of(context).padding.top + 14.h, 14.w, 14.h),
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress as segments, one per slide: a bar that fills tells you
          // how far through you are, which a row of dots does not.
          Row(
            children: [
              for (var i = 0; i < kEscrowGuideSlides.length; i++) ...[
                if (i > 0) SizedBox(width: 6.w),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: i <= _index
                          ? EscrowTheme.primaryLight
                          : EscrowTheme.border,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text('Step ${_index + 1} of ${kEscrowGuideSlides.length}',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 11.sp)),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Skip',
                    style: GoogleFonts.inter(
                        color: EscrowTheme.textSecondary, fontSize: 12.sp)),
              ),
            ],
          ),
          Flexible(
            child: PageView.builder(
              controller: _pages,
              onPageChanged: (i) => setState(() => _index = i),
              itemCount: kEscrowGuideSlides.length,
              itemBuilder: (_, i) => _Slide(slide: kEscrowGuideSlides[i]),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _back,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: EscrowTheme.border),
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(_index == 0 ? 'Close' : 'Back',
                      style: GoogleFonts.inter(
                          color: EscrowTheme.textSecondary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EscrowTheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(last ? 'Got it' : 'Next',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final EscrowGuideSlide slide;
  const _Slide({required this.slide});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A tinted glyph rather than a bitmap: it scales to every screen,
          // needs no asset pipeline, and cannot ship at the wrong density.
          Center(
            child: Container(
              width: 84.w,
              height: 84.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    slide.tint.withValues(alpha: 0.30),
                    slide.tint.withValues(alpha: 0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: slide.tint.withValues(alpha: 0.55)),
              ),
              child: Icon(slide.icon, color: slide.tint, size: 38.sp),
            ),
          ),
          SizedBox(height: 16.h),
          Text(slide.title,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 8.h),
          Text(slide.body,
              style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary,
                  fontSize: 13.sp,
                  height: 1.5)),
          if (slide.ifItGoesWrong != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(11.w),
              decoration: BoxDecoration(
                color: slide.tint.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: slide.tint.withValues(alpha: 0.30)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 15.sp, color: slide.tint),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(slide.ifItGoesWrong!,
                        style: GoogleFonts.inter(
                            color: EscrowTheme.textSecondary,
                            fontSize: 11.5.sp,
                            height: 1.45)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The info-icon menu: the two documents, each opening its own sheet.
///
/// A chooser rather than one long sheet, because "what are the rules" and
/// "how do I do this" are different questions and a user arrives with one
/// of them, not both.
Future<void> showEscrowInfoMenu(BuildContext context) async {
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      margin: EdgeInsets.all(14.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.school_outlined,
                color: EscrowTheme.primaryLight, size: 22.sp),
            title: Text('How Escrow Pay works',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
            subtitle: Text('Three steps, and what happens if it goes wrong',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
            onTap: () async {
              Navigator.of(ctx).pop();
              // Awaited off the closed menu so the guide is not pushed over
              // a sheet that is still animating out.
              if (context.mounted) await showEscrowHowItWorks(context);
            },
          ),
          Divider(color: EscrowTheme.border, height: 1),
          ListTile(
            leading: Icon(Icons.gavel_rounded,
                color: EscrowTheme.primaryLight, size: 22.sp),
            title: Text('Terms and conditions',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
            subtitle: Text('The rules that apply to every deal',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
            onTap: () {
              Navigator.of(ctx).pop();
              if (context.mounted) showEscrowTermsSheet(context);
            },
          ),
        ],
      ),
    ),
  );
}
