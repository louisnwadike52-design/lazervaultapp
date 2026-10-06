import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

import 'package:lazervault/core/config/locale_gating.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_tabs.dart';

class BottomNavMenu extends StatefulWidget {
  final int initialIndex;
  final void Function(int) onTabChange;

  const BottomNavMenu(
      {super.key, required this.initialIndex, required this.onTabChange});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu>
    with TickerProviderStateMixin {
  late final MotionTabBarController _motionTabBarController;

  static final List<String> _labels =
      kDashboardTabs.map((t) => t.label).toList(growable: false);

  /// Icons for the CURRENT region: a destination this region cannot use shows
  /// a padlock in place of its glyph.
  ///
  /// THE GAP THIS CLOSES
  /// -------------------
  /// There are two bottom navs. The curved one (tabs 2–4) dimmed disabled
  /// destinations and drew a lock; THIS one — the bar on Dashboard and AI
  /// analytics, where a session starts — drew every tab as if it worked.
  /// `_handleOnTabChange` in the parent did refuse the navigation, so tapping
  /// Beam in Kenya produced a message and no movement, but nothing on screen
  /// said so beforehand. Reported as "the nav items should be disabled even
  /// when the dashboard is the active tab, and not until the chatbot is
  /// clicked" — the chatbot tab is exactly where the OTHER, gated nav takes
  /// over.
  ///
  /// NOT a static: the region changes at runtime when the user switches their
  /// account, so this has to be read per build.
  ///
  /// The entry is REPLACED, never removed. The nav is addressed by index
  /// (deep links and receipt returns pass `initialTab`), so dropping one
  /// would retarget those links at whatever slid into its place.
  List<IconData> get _icons => [
        for (final t in kDashboardTabs)
          LocaleGating.navAllowed(t.label)
              ? t.icon
              : Icons.lock_outline_rounded,
      ];

  @override
  void initState() {
    super.initState();
    // No setState here: initState already runs before the first build, so
    // calling it only schedules a redundant frame.
    _motionTabBarController = MotionTabBarController(
      initialIndex: widget.initialIndex,
      length: kDashboardTabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // Dispose our own resources BEFORE super.dispose(), which tears down the
    // State's ticker provider the controller is attached to.
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BottomNavMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex &&
        _motionTabBarController.index != widget.initialIndex) {
      _motionTabBarController.index = widget.initialIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      controller: _motionTabBarController,
      // Derived from the CURRENT index, never hardcoded.
      //
      // This bar is only mounted for tabs 0–1; tabs 2–4 render a different nav
      // entirely. So arriving from Lifestyle or AI chat MOUNTS this widget
      // fresh, and a hardcoded "Dashboard" here made the bar paint its first
      // frame with Dashboard selected before didUpdateWidget corrected it —
      // the visible "jumps to Dashboard, then to the tab I tapped" flicker.
      initialSelectedTab: dashboardTabLabel(widget.initialIndex),
      labels: _labels,
      icons: _icons,
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      tabIconColor: Colors.grey.shade400,
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor: Colors.indigo,
      tabIconSelectedColor: Colors.white,
      tabBarColor: Colors.white,
      onTabItemSelected: (int value) {
        // Do NOT move the highlight for a destination we are about to refuse.
        //
        // The parent blocks the navigation and explains why, but this bar had
        // already slid its indicator onto the tab it never opened — the
        // indicator sat on Beam while the dashboard stayed on screen, which
        // reads as a broken nav rather than a withheld feature. Mirrors
        // `letIndexChange` on the curved bar.
        if (!LocaleGating.navAllowed(dashboardTabLabel(value))) {
          widget.onTabChange(value); // parent shows the region message
          return;
        }
        setState(() {
          _motionTabBarController.index = value;
        });
        widget.onTabChange(value);
      },
    );
  }
}
