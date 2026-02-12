import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

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
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _motionTabBarController = MotionTabBarController(
        initialIndex: widget.initialIndex,
        length: 4,
        vsync: this,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController?.dispose();
  }

  @override
  void didUpdateWidget(covariant BottomNavMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    _motionTabBarController!.index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      controller: _motionTabBarController,
      initialSelectedTab: "Dashboard",
      labels: const ["Dashboard", "AI Budgeting", "AI Chat", "Lifestyle"],
      icons: const [
        Icons.dashboard_rounded,
        Icons.account_balance_wallet_rounded,
        Icons.smart_toy_rounded,
        Icons.party_mode
      ],
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
          _motionTabBarController!.index = value;
        });
        widget.onTabChange(value);
      },
    );
  }
}
