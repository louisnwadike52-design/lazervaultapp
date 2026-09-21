import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/screens/plan_my_day_screen.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/screens/sprayme_home_screen.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';
import 'package:lazervault/src/features/referral/presentation/widgets/lazer_points_nav_widget.dart';
import 'package:lazervault/src/features/lifestyle/presentation/widgets/lifestyle_view_mode.dart';

// ─── Main Screen ───────────────────────────────────────────────────────────────
class NewLifestyleScreen extends StatefulWidget {
  /// Optional callback to switch the parent dashboard to a specific tab.
  final void Function(int tabIndex)? onSwitchTab;

  const NewLifestyleScreen({super.key, this.onSwitchTab});

  @override
  State<NewLifestyleScreen> createState() => _NewLifestyleScreenState();
}

class _NewLifestyleScreenState extends State<NewLifestyleScreen> {
  LifestyleViewMode _viewMode = LifestyleViewMode.banner;

  @override
  void initState() {
    super.initState();
    // Best-effort restore; the screen renders in the default layout until this
    // resolves rather than waiting on storage.
    LifestyleViewModePrefs.load().then((m) {
      if (mounted) setState(() => _viewMode = m);
    });
  }

  void _setViewMode(LifestyleViewMode m) {
    if (m == _viewMode) return;
    setState(() => _viewMode = m);
    LifestyleViewModePrefs.save(m);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          children: [
            // Rewards, above the fold. LazerPoints were reachable only through
            // the referral dashboard, so a reward earned on ordinary spending
            // sat behind a feature about inviting friends — and a balance
            // nobody sees is a balance nobody converts. The widget hides itself
            // if it cannot load, rather than holding the top of the screen with
            // an error the user cannot act on from here.
            // Title row — support entry pinned to the header's top right.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lifestyle',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Celebrate together and stay on top of your day',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                LifestyleViewModeButton(
                  mode: _viewMode,
                  onChanged: _setViewMode,
                ),
                // P2P messages → financial connections (Get.toNamed pushes it,
                // so Back returns here to Lifestyle).
                IconButton(
                  tooltip: 'Messages',
                  icon: Icon(
                    Icons.forum_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 24.sp,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Get.toNamed(AppRoutes.financialConnections);
                  },
                ),
                IconButton(
                  tooltip: 'Contact support',
                  icon: Icon(
                    Icons.support_agent_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 24.sp,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SupportTicketsScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // The entries, in whichever layout the user chose.
            _buildEntries(),
            SizedBox(height: 24.h),

            // Rewards. LazerPoints were reachable only through the referral
            // dashboard, so a reward earned on ordinary spending sat behind a
            // feature about inviting friends — and a balance nobody sees is a
            // balance nobody converts. It sits BELOW the services now: it is a
            // running total to check, not the reason you opened this tab, and
            // above the fold it pushed the actual destinations off-screen. The
            // widget hides itself if it cannot load, rather than holding space
            // with an error the user cannot act on from here.
            const LazerPointsNavWidget(),

            // Bottom padding for nav bar
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  // ── Entries ────────────────────────────────────────────────────────────────

  /// The hub's destinations, described once.
  ///
  /// The two banners used to be hand-written twice over, so every layout added
  /// here would have meant re-writing each entry again. Describing them as data
  /// means banner/grid/list are three renderers over one list, and a third
  /// destination is one entry, not three widgets.
  List<_LifestyleEntry> get _entries => [
        _LifestyleEntry(
          title: 'Lazerspray',
          subtitle: 'Spray money, send gifts & celebrate together in real-time',
          emoji: '\u{1F389}',
          colors: const [Color(0xFFFF6B00), Color(0xFFFF2D87)],
          onTap: _openSprayMe,
        ),
        _LifestyleEntry(
          title: 'Plan My Day',
          subtitle: 'Organize tasks, events & boost your productivity',
          emoji: '\u{1F4C5}',
          colors: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          onTap: _openPlanMyDay,
        ),
      ];

  Widget _buildEntries() {
    final entries = _entries;
    switch (_viewMode) {
      case LifestyleViewMode.grid:
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          // Taller than wide: the subtitle is a full sentence and clipping it
          // to one line would leave two tiles that read as bare labels.
          childAspectRatio: 0.95,
          children: [for (final e in entries) _gridTile(e)],
        );
      case LifestyleViewMode.list:
        return Column(
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              if (i > 0) SizedBox(height: 10.h),
              _listRow(entries[i]),
            ],
          ],
        );
      case LifestyleViewMode.banner:
        return Column(
          children: [
            for (var i = 0; i < entries.length; i++) ...[
              if (i > 0) SizedBox(height: 16.h),
              _bannerCard(entries[i]),
            ],
          ],
        );
    }
  }

  BoxDecoration _entryDecoration(_LifestyleEntry e, double radius) =>
      BoxDecoration(
        gradient: LinearGradient(
          colors: e.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: e.colors.first.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  Widget _emojiChip(String emoji, double pad, double size) => Container(
        padding: EdgeInsets.all(pad),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(emoji, style: TextStyle(fontSize: size)),
      );

  Widget _bannerCard(_LifestyleEntry e) {
    return GestureDetector(
      onTap: e.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: _entryDecoration(e, 16.r),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    e.subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            _emojiChip(e.emoji, 12.w, 28.sp),
          ],
        ),
      ),
    );
  }

  Widget _gridTile(_LifestyleEntry e) {
    return GestureDetector(
      onTap: e.onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: _entryDecoration(e, 16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _emojiChip(e.emoji, 10.w, 24.sp),
            const Spacer(),
            Text(
              e.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              e.subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 11.sp,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listRow(_LifestyleEntry e) {
    return GestureDetector(
      onTap: e.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: _entryDecoration(e, 12.r),
        child: Row(
          children: [
            _emojiChip(e.emoji, 8.w, 18.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                e.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.white.withValues(alpha: 0.8), size: 20.sp),
          ],
        ),
      ),
    );
  }

  void _openSprayMe() {
    HapticFeedback.lightImpact();
    Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<SprayMeCubit>(),
          child: const SprayMeHomeScreen(),
        ),
      ),
    );
    // No pop-result handling: Lazerspray no longer draws its own bottom nav, so
    // nothing pops an index back. Back simply returns to the Lifestyle tab.
    // onSwitchTab stays on NewLifestyleScreen for the hub's OTHER destinations.
  }

  void _openPlanMyDay() {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<PlanMyDayCubit>(),
          child: const PlanMyDayScreen(),
        ),
      ),
    );
  }
}

/// One hub destination. Plain data so the three layouts stay renderers.
class _LifestyleEntry {
  const _LifestyleEntry({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.colors,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> colors;
  final VoidCallback onTap;
}
