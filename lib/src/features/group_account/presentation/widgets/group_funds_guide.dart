import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// "How it works" and "Terms and conditions" for joint funds.
///
/// Same shape as the Escrow Pay guide — a short slide deck and a clause
/// list, both reachable from the three-dot menu — because the two features
/// pose the same question to a first-time user: who holds my money, and
/// what happens when somebody does not do their part.
///
/// SHORT ON PURPOSE. Three slides and six clauses, one or two sentences
/// each. A guide longer than the thing it explains is a guide nobody
/// finishes, and an unread disclaimer protects no one.

class GroupFundsGuideSlide {
  final IconData icon;
  final Color tint;
  final String title;
  final String body;

  /// A concrete case, in the user's own world. The abstract description of
  /// a rotating pool means nothing until you picture the people in it.
  final String? example;

  const GroupFundsGuideSlide({
    required this.icon,
    required this.tint,
    required this.title,
    required this.body,
    this.example,
  });
}

const List<GroupFundsGuideSlide> kGroupFundsGuideSlides = [
  GroupFundsGuideSlide(
    icon: Icons.groups_2_outlined,
    tint: Color(0xFF8B5CF6),
    title: 'Start with the people',
    body: 'A group is the set of people who save together. Create one and '
        'invite them — nothing moves until you add a goal.',
    example: 'Your university class, or an alumni set. Everyone joins the '
        'one group and stays there.',
  ),
  GroupFundsGuideSlide(
    icon: Icons.card_giftcard_outlined,
    tint: Color(0xFF3B82F6),
    title: 'One-time: everyone pays, one person is paid',
    body: 'Pick a goal, a target and a date, and choose who receives it. '
        'Members pay in whatever they want. On the date, the pot is paid '
        'out to the person you chose.',
    example: 'A classmate is getting married. Create a one-time goal in '
        'their name; on the day, what the class raised goes to them.',
  ),
  GroupFundsGuideSlide(
    icon: Icons.sync_alt_rounded,
    tint: Color(0xFF10B981),
    title: 'Esusu: the same amount, a different person each cycle',
    body: 'Everyone pays a fixed share each cycle and one member collects '
        'the whole pot. Next cycle it is the next member, until everyone '
        'has had a turn.',
    example: 'Twelve of you put in ₦50,000 a month. Each month one person '
        'takes the ₦600,000, in the order you agreed.',
  ),
  GroupFundsGuideSlide(
    icon: Icons.account_balance_wallet_outlined,
    tint: Color(0xFFF59E0B),
    title: 'We move the money, you choose the people',
    body: 'Lazervault holds the pot and pays it out on the agreed trigger. '
        'We cannot make a member pay. Save with people you trust.',
    example: 'A member who stops paying does not stop the group — their '
        'turn is held back until they are up to date.',
  ),
];

/// Shows the guide. Returns true when the reader reached the end.
Future<bool> showGroupFundsHowItWorks(BuildContext context) async {
  final done = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // Dismissible: a guide you cannot escape is an obstacle, and the menu
    // brings it back whenever it is wanted.
    builder: (ctx) => const _GroupFundsGuideSheet(),
  );
  return done ?? false;
}

class _GroupFundsGuideSheet extends StatefulWidget {
  const _GroupFundsGuideSheet();

  @override
  State<_GroupFundsGuideSheet> createState() => _GroupFundsGuideSheetState();
}

class _GroupFundsGuideSheetState extends State<_GroupFundsGuideSheet> {
  final _pages = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _next() {
    if (_index >= kGroupFundsGuideSlides.length - 1) {
      Navigator.of(context).pop(true);
      return;
    }
    _pages.nextPage(
        duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
  }

  void _back() {
    // On the first slide Back LEAVES, rather than being a dead control —
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
    final last = _index == kGroupFundsGuideSlides.length - 1;
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.80),
      margin: EdgeInsets.fromLTRB(
          14.w, MediaQuery.of(context).padding.top + 14.h, 14.w, 14.h),
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'How joint funds work',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(false),
                icon: Icon(Icons.close,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Flexible(
            child: PageView.builder(
              controller: _pages,
              onPageChanged: (i) => setState(() => _index = i),
              itemCount: kGroupFundsGuideSlides.length,
              itemBuilder: (_, i) => _Slide(slide: kGroupFundsGuideSlides[i]),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < kGroupFundsGuideSlides.length; i++)
                Container(
                  width: i == _index ? 18.w : 6.w,
                  height: 6.h,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: i == _index
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _back,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF3D3D3D)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    _index == 0 ? 'Close' : 'Back',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    last ? 'Got it' : 'Next',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700),
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

class _Slide extends StatelessWidget {
  final GroupFundsGuideSlide slide;
  const _Slide({required this.slide});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: slide.tint.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(slide.icon, color: slide.tint, size: 26.sp),
          ),
          SizedBox(height: 14.h),
          Text(
            slide.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            slide.body,
            style: GoogleFonts.inter(
              color: const Color(0xFFD1D5DB),
              fontSize: 13.5.sp,
              height: 1.45,
            ),
          ),
          if (slide.example != null) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline, color: slide.tint, size: 15.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      slide.example!,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.5.sp,
                        height: 1.4,
                      ),
                    ),
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
