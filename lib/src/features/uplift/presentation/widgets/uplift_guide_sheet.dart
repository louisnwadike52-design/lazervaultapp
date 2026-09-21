import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';

/// The full "how does this work" explainer for Lazerfunds.
///
/// The per-tab [UpliftGuideCard] answers "what am I looking at" on arrival. This
/// answers the larger question someone has before they commit money or ask for
/// it: who the two sides are, what happens between applying and being paid, and
/// where the money physically sits in between. It is reachable at any time from
/// the help icon, because the moment someone wants it is rarely the moment it
/// appeared on its own.
Future<void> showUpliftGuideSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _UpliftGuideSheet(),
  );
}

class _UpliftGuideSheet extends StatelessWidget {
  const _UpliftGuideSheet();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: kUpBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
          border: Border.all(color: kUpPrimary.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            _grabber(),
            _header(context),
            Divider(color: kUpDivider, height: 1),
            Expanded(
              child: ListView(
                controller: controller,
                padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 28.h),
                children: const [
                  _SidesBlock(),
                  SizedBox(height: 22),
                  _JourneyBlock(),
                  SizedBox(height: 22),
                  _MoneyBlock(),
                  SizedBox(height: 22),
                  _TabsBlock(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _grabber() => Container(
        width: 42.w,
        height: 4.h,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: kUpDivider,
          borderRadius: BorderRadius.circular(2.r),
        ),
      );

  Widget _header(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(18.w, 0, 10.w, 12.h),
        child: Row(
          children: [
            Icon(Icons.auto_stories_outlined, color: kUpPrimarySoft, size: 20.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                'How Lazerfunds works',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Close',
              icon: Icon(Icons.close, color: kUpTextSecondary, size: 20.sp),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      );
}

/// Section scaffolding — a small caps label over the content, used by every
/// block so the sheet reads as one document rather than four cards.
class _Section extends StatelessWidget {
  const _Section({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            color: kUpPrimarySoft,
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }
}

class _SidesBlock extends StatelessWidget {
  const _SidesBlock();

  @override
  Widget build(BuildContext context) {
    return _Section(
      label: 'Two sides',
      child: Column(
        children: const [
          _SideCard(
            icon: Icons.volunteer_activism_outlined,
            title: 'You have money to back businesses',
            body:
                'You open a fund: how much you are putting up, the most any one '
                'business can take, and the kind of business you want to back. '
                'Businesses then apply to you.',
          ),
          SizedBox(height: 10),
          _SideCard(
            icon: Icons.storefront_outlined,
            title: 'You need capital for your business',
            body:
                'You browse open funds in Discover and apply to the ones that '
                'fit. You set out what you do, what you need it for, and the '
                'milestones you will hit along the way.',
          ),
        ],
      ),
    );
  }
}

class _SideCard extends StatelessWidget {
  const _SideCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: kUpCard,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: kUpPrimary.withValues(alpha: 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kUpPrimarySoft, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The steps are numbered because they genuinely happen in this order — each
/// one is gated on the one before it, and the ordering is the thing people get
/// wrong (money is not sent when an application is accepted).
class _JourneyBlock extends StatelessWidget {
  const _JourneyBlock();

  static const _steps = <List<String>>[
    ['A fund opens', 'A funder puts up capital and says what they will back.'],
    ['Businesses apply', 'Applications land with the funder, who can compare them side by side.'],
    [
      'Offer and counter',
      'The funder can accept, decline, or counter with a different amount. The business can accept the counter or walk away.'
    ],
    [
      'Money goes into the fund pool',
      'On acceptance the funder commits the amount with their PIN. It leaves their wallet and is held — it is not yet the business’s to spend.'
    ],
    [
      'Milestones release it',
      'The business completes a milestone and requests release. The funder reviews it, and only that slice is paid out.'
    ],
    [
      'Receipts, either way',
      'Every commitment, release and refund produces a receipt you can open or share.'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      label: 'How a raise runs',
      child: Column(
        children: [
          for (var i = 0; i < _steps.length; i++)
            _Step(
              index: i + 1,
              title: _steps[i][0],
              body: _steps[i][1],
              isLast: i == _steps.length - 1,
            ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.index,
    required this.title,
    required this.body,
    required this.isLast,
  });

  final int index;
  final String title;
  final String body;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kUpPrimary.withValues(alpha: 0.16),
                  border: Border.all(color: kUpPrimary.withValues(alpha: 0.5)),
                ),
                child: Text(
                  '$index',
                  style: GoogleFonts.inter(
                    color: kUpPrimarySoft,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 1.5.w, color: kUpDivider),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    body,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoneyBlock extends StatelessWidget {
  const _MoneyBlock();

  @override
  Widget build(BuildContext context) {
    return _Section(
      label: 'Where the money sits',
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: kUpCard,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: kUpSuccess.withValues(alpha: 0.28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lock_outline, color: kUpSuccess, size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Committed money is held, not handed over',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'Funds you commit move into that raise\'s pool. The business '
              'cannot draw on them at will — each release is requested against '
              'a milestone and reviewed before it pays out. Anything never '
              'released can come back to you as a refund, and both sides can '
              'see the running totals at any time.',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabsBlock extends StatelessWidget {
  const _TabsBlock();

  @override
  Widget build(BuildContext context) {
    return _Section(
      label: 'The three tabs',
      child: Column(
        children: const [
          _TabRow(
            icon: Icons.explore_outlined,
            name: 'Discover',
            body: 'Open funds you can apply to.',
          ),
          _TabRow(
            icon: Icons.volunteer_activism_outlined,
            name: 'My Funds',
            body: 'Funds you opened, and what you have committed and released.',
          ),
          _TabRow(
            icon: Icons.inbox_outlined,
            name: 'My Applications',
            body: 'Raises you applied for, and where each one stands.',
          ),
        ],
      ),
    );
  }
}

class _TabRow extends StatelessWidget {
  const _TabRow({required this.icon, required this.name, required this.body});

  final IconData icon;
  final String name;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kUpPrimarySoft, size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  height: 1.45,
                ),
                children: [
                  TextSpan(
                    text: '$name — ',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
