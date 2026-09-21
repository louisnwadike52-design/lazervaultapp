import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

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
  static final List<IconData> _icons =
      kDashboardTabs.map((t) => t.icon).toList(growable: false);

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
        setState(() {
          _motionTabBarController.index = value;
        });
        widget.onTabChange(value);
      },
    );
  }
}
