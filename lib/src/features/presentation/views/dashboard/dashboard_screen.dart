import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/presentation/views/bottom_nav_menu.dart';
import 'package:lazervault/src/features/widgets/themed_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DashboardScreen extends StatefulWidget {
  static final List<Screen> tabItems = [
    ScreenName.dashboard,
    ScreenName.statistics,
        ScreenName.aiChat,
    ScreenName.lifeStyle,

  ].map((name) => Screen(name: name)).toList();

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  Screen activeScreen = const Screen(name: ScreenName.dashboard);
  late TabController _tabController;
  int _currentIndex = 0;
  bool isDrawerOpen = false;



  void _handleOnTabChange(int index) {
    setState(() {
      _currentIndex = index;
      activeScreen = Screen(name: DashboardScreen.tabItems[index].name);
    });
    _tabController.animateTo(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: DashboardScreen.tabItems.length, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
    } else {
      _handleOnTabChange(_tabController.index);
    }
  }

  void _handleNavigateToScreen() {
    Get.toNamed(AppRoutes.newCard);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _currentIndex,
      length: DashboardScreen.tabItems.length,
      child: Scaffold(
        backgroundColor: _currentIndex == 2 ? Color(0xFF1E1E1E) : Colors.white,
        drawer: ThemedDrawer(),
        onDrawerChanged: (isOpened) {
          setState(() {
            isDrawerOpen = isOpened;
          });
        },
        bottomNavigationBar: _buildAdaptiveBottomNav(),
        body: Stack(
          children: [
            TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: DashboardScreen.tabItems
                  .map((screen) => screen.widget)
                  .toList(),
            ),
            if (_currentIndex == 2)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ),
          ],
        ),
        extendBody: _currentIndex == 2,
      ),
    );
  }

  Widget _buildAdaptiveBottomNav() {
    // Use curved navigation for AI Chat tab (index 2)
    if (_currentIndex == 2 || _currentIndex == 3) {
      return Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF1E1E1E),
              ],
            ),
          ),
          child: CurvedNavigationBar(
            index: _currentIndex,
            height: 65.0,
            items: [
              _buildCurvedNavItem(0),
              _buildCurvedNavItem(1),
              _buildCurvedNavItem(2),
              _buildCurvedNavItem(3),
            ],
            color: Color(0xFF1E1E1E),
            buttonBackgroundColor: Colors.blue.withOpacity(0.2),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            onTap: _handleOnTabChange,
            letIndexChange: (index) => true,
          ),
        ),
      );
    }

    // Use MotionTabBar for other tabs
    return BottomNavMenu(
      initialIndex: _currentIndex,
      onTabChange: _handleOnTabChange,
    );
  }

  Widget _buildCurvedNavItem(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIconData(index),
            size: 24,
            color: index == _currentIndex 
                    ? Colors.blue 
                : Colors.white.withOpacity(0.7),
          ),
          if (index != _currentIndex) ...[
            SizedBox(height: 4),
            Text(
              _getTabLabel(index),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard_rounded;
      case 1:
        return Icons.analytics_rounded;
      case 2:
        return Icons.smart_toy_rounded;
      case 3:
        return Icons.party_mode;
      default:
        return Icons.circle;
    }
  }

  // Add this helper method to get tab labels
  String _getTabLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Stats';
      case 2:
        return 'AI Chat';
      case 3:
        return 'Life Style';
      default:
        return '';
    }
  }
}
