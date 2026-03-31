import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/presentation/views/bottom_nav_menu.dart';
import 'package:lazervault/src/features/widgets/themed_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lazervault/src/features/dashboard/managers/voice_setup_manager.dart';
import 'package:lazervault/src/features/dashboard/widgets/voice_setup_prompt_modal.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_cubit.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/lifestyle_screen.dart';

/// Set to `true` to show the voice banking setup bottom sheet when the dashboard loads.
const bool _kShowVoiceSetupDashboardPrompt = false;

class DashboardScreen extends StatefulWidget {
  static final List<Screen> tabItems = [
    ScreenName.dashboard,
    ScreenName.statistics,
    ScreenName.aiChat,
    ScreenName.moveMoney,
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowVoiceSetup();
      _checkAutoOpenVoiceSheet();
    });
  }

  /// Check if voice setup is needed and show modal prompt
  Future<void> _checkAndShowVoiceSetup() async {
    if (!_kShowVoiceSetupDashboardPrompt) return;

    // Skip setup prompt if we're auto-opening the voice sheet (enrollment just completed)
    if (_autoOpenVoiceSheetRequested) return;

    final setupManager = VoiceSetupManager(
      voiceManager: VoiceActivationManager(),
    );

    final status = await setupManager.checkVoiceSetupStatus();
    final skipCount = await setupManager.getSkipCount();

    if (!mounted) return;

    switch (status) {
      case VoiceSetupStatus.pending:
        _showVoiceSetupModal(canDismiss: true, skipCount: skipCount);
        break;
      case VoiceSetupStatus.mandatory:
        _showVoiceSetupModal(canDismiss: false, skipCount: skipCount);
        break;
      case VoiceSetupStatus.dismissed:
      case VoiceSetupStatus.completed:
      case VoiceSetupStatus.notApplicable:
        // Do nothing
        break;
    }
  }

  bool _autoOpenVoiceSheetRequested = false;

  /// Auto-open voice command sheet if navigated with openVoiceSheet argument
  /// (e.g., after completing voice enrollment via "Start Conversation" button)
  void _checkAutoOpenVoiceSheet() {
    final args = Get.arguments;
    if (args is Map && args['openVoiceSheet'] == true) {
      _autoOpenVoiceSheetRequested = true;
      // Delay to let dashboard fully render and avoid collision with voice setup modal
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted || !_autoOpenVoiceSheetRequested) return;
        _autoOpenVoiceSheetRequested = false;
        _openVoiceCommandSheet();
      });
    }
  }

  /// Open the voice command bottom sheet directly (enrollment already verified)
  void _openVoiceCommandSheet() {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(skipActivationCheck: true),
      ),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }

  /// Show voice setup modal bottom sheet
  void _showVoiceSetupModal({required bool canDismiss, int? skipCount}) {
    showModalBottomSheet(
      context: context,
      isDismissible: canDismiss,
      enableDrag: canDismiss,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoiceSetupPromptModal(
        canDismiss: canDismiss,
        skipCount: skipCount,
        onSetupNow: () {
          Navigator.pop(context);
          Get.toNamed(AppRoutes.voiceActivationPrompt);
        },
        onSetupLater: canDismiss
            ? () async {
                final setupManager = VoiceSetupManager(
                  voiceManager: VoiceActivationManager(),
                );
                await setupManager.incrementSkipCount();
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            : null,
      ),
    );
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
    } else {
      _handleOnTabChange(_tabController.index);
    }
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
        backgroundColor: Colors.white,
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
                  .asMap()
                  .entries
                  .map((entry) {
                    // Pass tab-switch callback to the lifestyle tab so SprayMe
                    // bottom nav can jump back to any dashboard tab.
                    if (entry.key == 4) {
                      return _buildLifestyleTab();
                    }
                    return entry.value.widget;
                  })
                  .toList(),
            ),
            if (_currentIndex >= 2)
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
        extendBody: _currentIndex >= 2,
      ),
    );
  }

  Widget _buildAdaptiveBottomNav() {
    // Use curved navigation for AI Chat tab (index 2)
    if (_currentIndex >= 2) {
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
              _buildCurvedNavItem(4),
            ],
            color: Color(0xFF1E1E1E),
            buttonBackgroundColor: Colors.blue.withValues(alpha: 0.2),
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
                : Colors.white.withValues(alpha: 0.7),
          ),
          if (index != _currentIndex) ...[
            SizedBox(height: 4),
            Text(
              _getTabLabel(index),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
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
        return Icons.swap_horiz_rounded;
      case 4:
        return Icons.event_note_rounded;
      case 5:
        return Icons.party_mode;
      default:
        return Icons.circle;
    }
  }

  Widget _buildLifestyleTab() {
    return BlocProvider(
      create: (_) => serviceLocator<LifestyleCubit>()..loadCategories(),
      child: NewLifestyleScreen(onSwitchTab: _handleOnTabChange),
    );
  }

  // Add this helper method to get tab labels
  String _getTabLabel(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Statistics';
      case 2:
        return 'AI Chat';
      case 3:
        return 'Beam';
      case 4:
        return 'Lifestyle';
      default:
        return '';
    }
  }
}
