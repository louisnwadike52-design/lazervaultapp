import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer skeletons for the Plan My Day surfaces. Mirrors the real layout so a
/// day-change / pull-to-refresh reads as "this section is updating" rather than
/// a jarring full-screen spinner. Palette matches the dark theme cards used
/// across the feature (0xFF1F1F1F card, 0xFF2D2D2D border).
class _Shell extends StatelessWidget {
  final Widget child;
  const _Shell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1F1F1F),
      highlightColor: const Color(0xFF3D3D3D),
      period: const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

Widget _box({
  required double width,
  required double height,
  double radius = 6,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

/// One task/schedule row placeholder (a card with a leading dot + two text
/// lines + a trailing chip).
Widget _rowCard() {
  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: const Color(0xFF2D2D2D)),
    ),
    child: Row(
      children: [
        _box(width: 22.w, height: 22.w, radius: 11.r),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(width: 160.w, height: 13.h),
              SizedBox(height: 7.h),
              _box(width: 80.w, height: 11.h),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        _box(width: 34.w, height: 12.h),
      ],
    ),
  );
}

Widget _sectionHeader({double width = 90}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Row(
      children: [
        _box(width: width.w, height: 15.h),
        SizedBox(width: 8.w),
        _box(width: 22.w, height: 15.h, radius: 8.r),
      ],
    ),
  );
}

/// The Day view's changing sections (schedule / events / tasks). Rendered under
/// the live header + week strip while a day-change or refresh is in flight.
class PlanDaySectionsSkeleton extends StatelessWidget {
  const PlanDaySectionsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(width: 96),
          _rowCard(),
          _rowCard(),
          SizedBox(height: 22.h),
          _sectionHeader(width: 70),
          _rowCard(),
          _rowCard(),
          _rowCard(),
        ],
      ),
    );
  }
}

/// The stat chips + progress bar inside the day header, shimmered while the
/// counts for a freshly-selected day are still unknown.
class PlanDayHeaderStatsSkeleton extends StatelessWidget {
  const PlanDayHeaderStatsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shell(
      child: Column(
        children: [
          _box(width: double.infinity, height: 6.h, radius: 4.r),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: _box(width: double.infinity, height: 32.h, radius: 10.r)),
              SizedBox(width: 10.w),
              Expanded(child: _box(width: double.infinity, height: 32.h, radius: 10.r)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Full-page Day skeleton for the very first load (no cached content yet).
class PlanDayFullSkeleton extends StatelessWidget {
  const PlanDayFullSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shell(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 96.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                children: [
                  _box(width: 150.w, height: 16.h),
                  SizedBox(height: 14.h),
                  _box(width: double.infinity, height: 6.h, radius: 4.r),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(child: _box(width: double.infinity, height: 32.h, radius: 10.r)),
                      SizedBox(width: 10.w),
                      Expanded(child: _box(width: double.infinity, height: 32.h, radius: 10.r)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Week strip
            SizedBox(
              height: 74.h,
              child: Row(
                children: [
                  for (int i = 0; i < 7; i++) ...[
                    if (i > 0) SizedBox(width: 6.w),
                    Expanded(child: _box(width: double.infinity, height: 74.h, radius: 12.r)),
                  ],
                ],
              ),
            ),
            SizedBox(height: 14.h),
            _box(width: double.infinity, height: 70.h, radius: 16.r), // inbox card
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(child: _box(width: double.infinity, height: 44.h, radius: 12.r)),
                SizedBox(width: 8.w),
                Expanded(child: _box(width: double.infinity, height: 44.h, radius: 12.r)),
                SizedBox(width: 8.w),
                Expanded(child: _box(width: double.infinity, height: 44.h, radius: 12.r)),
              ],
            ),
            SizedBox(height: 22.h),
            _sectionHeader(width: 96),
            _rowCard(),
            _rowCard(),
            _rowCard(),
          ],
        ),
      ),
    );
  }
}

/// Contacts list first-load skeleton (People segment).
class PlanContactsSkeleton extends StatelessWidget {
  const PlanContactsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shell(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        itemCount: 8,
        itemBuilder: (_, __) => Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              _box(width: 44.w, height: 44.w, radius: 22.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(width: 140.w, height: 14.h),
                    SizedBox(height: 7.h),
                    _box(width: 90.w, height: 11.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Contact profile first-load skeleton.
class PlanContactDetailSkeleton extends StatelessWidget {
  const PlanContactDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shell(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _box(width: 56.w, height: 56.w, radius: 28.r),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(width: 150.w, height: 18.h),
                    SizedBox(height: 8.h),
                    _box(width: 100.w, height: 12.h),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _box(width: double.infinity, height: 90.h, radius: 12.r),
            SizedBox(height: 20.h),
            _box(width: 90.w, height: 15.h),
            SizedBox(height: 10.h),
            _rowCard(),
            _rowCard(),
            SizedBox(height: 20.h),
            _box(width: 110.w, height: 15.h),
            SizedBox(height: 10.h),
            _rowCard(),
            _rowCard(),
          ],
        ),
      ),
    );
  }
}

/// Board first-load skeleton — gradient-ish progress header + filter pills +
/// a few task cards.
class PlanBoardSkeleton extends StatelessWidget {
  const PlanBoardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
            child: Row(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  if (i > 0) SizedBox(width: 8.w),
                  _box(width: 78.w, height: 34.h, radius: 20.r),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
            child: Column(
              children: [
                _rowCard(),
                _rowCard(),
                _rowCard(),
                _rowCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
