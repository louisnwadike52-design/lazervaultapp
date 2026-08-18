import 'dart:io';
import 'package:lazervault/src/features/fraud_detection/presentation/fraud_freeze_flow.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/presentation/views/bottom_nav_menu.dart';
import 'package:lazervault/src/features/ai_chats/presentation/view/ai_chats_screen.dart';
import 'package:lazervault/src/features/widgets/themed_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lazervault/src/features/dashboard/managers/voice_setup_manager.dart';
import 'package:lazervault/src/features/dashboard/widgets/voice_setup_prompt_modal.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/pending_chat_navigation.dart';
import 'package:lazervault/core/services/panic_balance_service.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:shake/shake.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/lifestyle_screen.dart';
import 'package:lazervault/src/features/widgets/dashboard/dashboard.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/core/services/app_update_service.dart';
import 'package:lazervault/core/services/app_patch_service.dart';
import 'package:lazervault/src/features/app_update/cubit/app_update_cubit.dart';
import 'package:lazervault/src/features/app_update/widgets/update_banner.dart';
import 'package:lazervault/src/features/app_update/widgets/update_modal.dart';
import 'package:lazervault/src/features/app_update/widgets/forced_update_screen.dart';
import 'package:lazervault/src/features/onboarding/dashboard_walkthrough.dart';

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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController nameController = TextEditingController();

  /// Drives the in-app update surface (banner / one-time modal / forced gate).
  /// The check is local + non-blocking (cached config + PackageInfo).
  late final AppUpdateCubit _updateCubit = serviceLocator<AppUpdateCubit>();
  Screen activeScreen = const Screen(name: ScreenName.dashboard);
  late TabController _tabController;
  int _currentIndex = 0;
  bool isDrawerOpen = false;

  /// The currently-active bottom-nav tab index, exposed to tab children that
  /// need to react to becoming visible. The AI Chat tab (index 2) listens to
  /// this so it can scroll its conversation to the bottom every time the user
  /// opens it — TabBarView keeps the page alive, so its initState only fires
  /// once and wouldn't otherwise re-scroll on re-entry.
  final ValueNotifier<int> _activeTab = ValueNotifier<int>(0);



  void _handleOnTabChange(int index) {
    setState(() {
      _currentIndex = index;
      activeScreen = Screen(name: DashboardScreen.tabItems[index].name);
    });
    // Notify tab children (e.g. AI Chat) that the active tab changed so they
    // can react to becoming visible. Set even when the index is unchanged is
    // harmless (ValueNotifier only fires on a real value change).
    _activeTab.value = index;
    _tabController.animateTo(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Open the dashboard on a specific bottom-nav tab when navigated with an
  /// `initialTab` argument (e.g. the LazerBeam receipt returns to the Beam tab,
  /// index 3). Reuses the same `Get.arguments`-map convention as
  /// `openVoiceSheet`. No animation — this runs on the first frame.
  void _applyInitialTab() {
    final args = Get.arguments;
    if (args is! Map) return;
    final raw = args['initialTab'];
    if (raw is! int || raw < 0 || raw >= DashboardScreen.tabItems.length) return;
    if (raw == _currentIndex) return;
    setState(() {
      _currentIndex = raw;
      activeScreen = Screen(name: DashboardScreen.tabItems[raw].name);
    });
    _activeTab.value = raw;
    _tabController.index = raw;
  }

  static const MethodChannel _settingsChannel =
      MethodChannel('com.lazervault.app/settings');

  /// Back handling for the dashboard (the authenticated home / root route).
  /// It must NEVER finish the task → cold relaunch → passcode/login gate (which
  /// the user perceives as "Back logged me out"). Precedence:
  ///   1. Not on the first tab → Back returns to the dashboard tab.
  ///   2. On the root tab → send the app to the BACKGROUND (Android), keeping
  ///      the live session so re-opening (within the inactivity window) resumes
  ///      straight onto the dashboard. iOS has no OS Back button, so this is a
  ///      no-op there. The Scaffold drawer, being deeper in the tree, still
  ///      closes itself on Back before this handler runs.
  Future<void> _handleDashboardBack(bool didPop) async {
    if (didPop) return;
    if (_currentIndex != 0) {
      _handleOnTabChange(0);
      return;
    }
    if (Platform.isAndroid) {
      try {
        await _settingsChannel.invokeMethod('moveTaskToBack');
      } catch (_) {
        // Best-effort — never crash the app shell on a Back press.
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: DashboardScreen.tabItems.length, vsync: this);
    _tabController.addListener(_onTabChanged);

    // Panic Balance trigger: shaking the phone twice toggles the decoy (the
    // other trigger is a long-press on the balance). Requiring two shakes avoids
    // accidental toggles from a single jolt. Gated on the user's shake-trigger
    // switch; toggle() also no-ops until the feature is set up, so a stray shake
    // never surprises anyone. See the fields above for why we count ourselves.
    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (_) {
        final panic = serviceLocator<PanicBalanceService>();
        if (!panic.shakeTriggerEnabled) {
          _panicShakeCount = 0; // don't carry a stale first shake across disable
          return;
        }
        final now = DateTime.now().millisecondsSinceEpoch;
        // Start (or restart) the sequence on the first shake, or if the window
        // since the first shake has elapsed.
        if (_panicShakeCount == 0 ||
            now - _firstPanicShakeMs > _kPanicShakeWindowMs) {
          _panicShakeCount = 1;
          _firstPanicShakeMs = now;
          return;
        }
        // Second qualifying shake within the window → toggle once, then reset so
        // the next toggle requires two fresh shakes again.
        _panicShakeCount = 0;
        _firstPanicShakeMs = 0;
        panic.toggle();
      },
    );

    // Best-effort: sync the Panic Balance config from the server (so AI-set
    // presets appear here and edits propagate). Never blocks; local is the
    // source of truth for display.
    final panic = serviceLocator<PanicBalanceService>();
    panic.configureSync(
      baseUrl: EndpointRegistry.instance.httpCore,
      accessTokenProvider: () =>
          serviceLocator<SecureStorageService>().getAccessToken(),
    );
    panic.syncFromServer();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _applyInitialTab();
      // If a P2P push was tapped while signed out (cold start), the dashboard
      // is the first authenticated screen — open the stashed conversation now
      // (pushed on top, so Back returns here).
      PendingChatNavigation.instance.consumeAndNavigate();
      // Shorebird OTA: if a Dart-only patch was downloaded in the background,
      // gently nudge a restart to apply it. No-op on non-Shorebird builds.
      _maybeNudgePatchRestart();
      // Kick off a background check+download so a newer patch is staged for the
      // NEXT restart (auto_update:false → never applied mid-session). Fire-and-
      // forget; safe no-op on plain store builds.
      serviceLocator<AppPatchService>().checkAndDownloadUpdate();
      // Fraud freeze is security-critical: resolve it FIRST and let it own the
      // screen, so voice-setup / update modals can't stack on top of it. The
      // other prompts (which check _fraudModalActive) fire only once it's done.
      await _maybeCheckFraudFreeze();
      if (!mounted) return;
      _checkAndShowVoiceSetup();
      _checkAutoOpenVoiceSheet();
      // Background app-update check (store version). Never blocks launch.
      _updateCubit.checkNow();
    });
  }

  /// True while the fraud freeze modal is on screen — other land-time modals
  /// (voice setup, optional-update) check this so they don't stack on top of the
  /// security-critical unfreeze dialog.
  bool _fraudModalActive = false;

  /// If the account is frozen for suspicious activity, surface the freeze modal
  /// with a tx-PIN self-unfreeze the moment the user lands on the dashboard (and
  /// again on resume, in case an enforce-block froze it mid-session). Guarded so
  /// it never stacks on itself; best-effort (a status-call failure is silent).
  Future<void> _maybeCheckFraudFreeze() async {
    if (_fraudModalActive || !mounted) return;
    _fraudModalActive = true;
    try {
      await checkAndShowFraudFreeze(context);
    } finally {
      _fraudModalActive = false;
    }
  }

  /// Show a non-blocking snackbar when a downloaded OTA code-push patch is staged
  /// for the next restart. Best-effort; silent when nothing is pending.
  Future<void> _maybeNudgePatchRestart() async {
    final ready =
        await serviceLocator<AppPatchService>().isPatchReadyForRestart();
    if (!ready || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF1F1F1F),
        duration: Duration(seconds: 6),
        content: Text(
          'Update ready — fully close and reopen the app to apply it.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Re-check on resume so an admin bump (or crossing the min-build line while
    // backgrounded) surfaces without requiring a cold start.
    if (state == AppLifecycleState.resumed) {
      _updateCubit.checkNow();
      // Check-on-resume: stage any newer OTA patch for the next restart. Safe
      // no-op on non-Shorebird builds; never swaps code in the current session.
      serviceLocator<AppPatchService>().checkAndDownloadUpdate();
      // Re-check fraud freeze on resume: an enforce-block can freeze the account
      // mid-session (e.g. a transfer bounced while backgrounded), and the modal
      // must re-surface without a cold start. Guarded so it never stacks.
      _maybeCheckFraudFreeze();
    }
  }

  ShakeDetector? _shakeDetector;

  // Panic Balance shake trigger: two deliberate shakes toggle the decoy. We do
  // the counting ourselves (the `shake` package is left at minimumShakeCount:1
  // so it reports every individual shake) because the package never resets its
  // own counter after firing — that would let a single stray jolt flip the
  // decoy back moments after a genuine double-shake, revealing the real balance
  // in exactly the unsafe moment this feature exists to guard against. We reset
  // our count on every toggle, so each toggle needs two fresh shakes and a lone
  // bump never triggers one.
  int _panicShakeCount = 0;
  int _firstPanicShakeMs = 0;
  static const int _kPanicShakeWindowMs = 1500;

  /// Check if voice setup is needed and show modal prompt
  Future<void> _checkAndShowVoiceSetup() async {
    if (!_kShowVoiceSetupDashboardPrompt) return;

    // Skip setup prompt if we're auto-opening the voice sheet (enrollment just completed)
    if (_autoOpenVoiceSheetRequested) return;

    // Don't stack on top of the security-critical fraud freeze dialog.
    if (_fraudModalActive) return;

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
    // Self-sizing sheet (DraggableScrollableSheet: 90% → full screen).
    Get.bottomSheet(
      VoiceCommandSheet(skipActivationCheck: true),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }

  /// Gated entry point for EXPLICITLY opening the voice agent (the dashboard
  /// quick-action sheet's "Voice agent" item, post-refresh, etc.). Runs the
  /// SAME enrollment check + setup-modal follow-up as the proactive
  /// [_checkAndShowVoiceSetup] so these paths can't bypass setup and drop the
  /// user into a voice session they haven't enrolled for. Only opens the voice
  /// command sheet when enrollment is complete.
  Future<void> _openVoiceAgentGated() async {
    if (!mounted) return;
    final setupManager = VoiceSetupManager(
      voiceManager: VoiceActivationManager(),
    );
    final status = await setupManager.checkVoiceSetupStatus();
    final skipCount = await setupManager.getSkipCount();
    if (!mounted) return;

    switch (status) {
      case VoiceSetupStatus.completed:
      case VoiceSetupStatus.notApplicable:
        _openVoiceCommandSheet();
        break;
      case VoiceSetupStatus.mandatory:
        _showVoiceSetupModal(canDismiss: false, skipCount: skipCount);
        break;
      case VoiceSetupStatus.pending:
      case VoiceSetupStatus.dismissed:
        // Not enrolled — even if the proactive prompt was recently skipped, an
        // explicit tap to use voice should still route through setup.
        _showVoiceSetupModal(canDismiss: true, skipCount: skipCount);
        break;
    }
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
    WidgetsBinding.instance.removeObserver(this);
    _updateCubit.close();
    _shakeDetector?.stopListening();
    _activeTab.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /// Open the platform store for an update.
  Future<void> _openUpdateStore(AppUpdateInfo info) =>
      _updateCubit.service.openStore(info);

  /// Show the one-time optional modal for [info] if it hasn't been shown for
  /// this latest build yet, then mark it seen.
  Future<void> _maybeShowUpdateModal(AppUpdateInfo info) async {
    // Defer the optional-update modal while the fraud freeze dialog owns the
    // screen — it'll resurface on the next check once the freeze is handled.
    if (_fraudModalActive) return;
    final should =
        await _updateCubit.service.shouldShowOptionalModal(info.latestBuild);
    if (!should || !mounted) return;
    await _updateCubit.service.markOptionalModalSeen(info.latestBuild);
    if (!mounted) return;
    await showUpdateModal(
      context,
      info: info,
      onUpdate: () => _openUpdateStore(info),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Back on the dashboard must not exit → cold relaunch → login gate.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _handleDashboardBack(didPop),
      child: BlocProvider<AppUpdateCubit>.value(
      value: _updateCubit,
      child: BlocConsumer<AppUpdateCubit, AppUpdateState>(
        // Show the one-time optional modal whenever an optional update surfaces;
        // shouldShowOptionalModal() de-dupes so it only appears once per build.
        listenWhen: (prev, curr) => curr is AppUpdateOptional,
        listener: (context, state) {
          if (state is AppUpdateOptional) {
            _maybeShowUpdateModal(state.info);
          }
        },
        builder: (context, updateState) {
          // Below the minimum supported build → block the whole app with a
          // non-dismissible gate (replaces the dashboard entirely).
          if (updateState is AppUpdateForced) {
            return ForcedUpdateScreen(
              info: updateState.info,
              onUpdate: () => _openUpdateStore(updateState.info),
            );
          }
          final Widget? updateBanner = updateState is AppUpdateOptional
              ? UpdateBanner(
                  info: updateState.info,
                  onUpdate: () => _openUpdateStore(updateState.info),
                  onDismiss: _updateCubit.dismissOptional,
                )
              : null;
          return DashboardWalkthrough.wrapShowcase(
            builder: (context) => DefaultTabController(
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
              // The bottom nav is toured item-by-item for the high-value items.
              // Rather than reach into the adaptive nav bar for per-item keys,
              // overlay five equal transparent slots across it — only the toured
              // ones carry a coach-mark (IgnorePointer, so real taps still reach
              // the nav once the tour is done).
              bottomNavigationBar: Stack(
                children: [
                  _buildAdaptiveBottomNav(),
                  DashboardWalkthrough.bottomNavTourTargets(),
                ],
              ),
              body: Column(
                children: [
                  if (updateBanner != null) updateBanner,
                  Expanded(
                    child: Stack(
          children: [
            TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: DashboardScreen.tabItems
                  .asMap()
                  .entries
                  .map((entry) {
                    // Pass tab-switch + voice-open callbacks to the dashboard
                    // tab so the swipe-down quick-actions sheet can drive them.
                    if (entry.key == 0) {
                      return _buildDashboardTab();
                    }
                    // Pass tab-switch callback to the lifestyle tab so SprayMe
                    // bottom nav can jump back to any dashboard tab.
                    if (entry.key == 4) {
                      return _buildLifestyleTab();
                    }
                    // AI Chat tab: hand it the active-tab notifier so it scrolls
                    // its conversation to the bottom every time it's opened.
                    if (entry.key == 2) {
                      return AiChats(activeTab: _activeTab, chatTabIndex: 2);
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
                  ),
                ],
              ),
              extendBody: _currentIndex >= 2,
            ),
          ));
        },
      ),
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
            height: 58.0,
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
    return NewLifestyleScreen(onSwitchTab: _handleOnTabChange);
  }

  /// Builds the dashboard tab with quick-action callbacks wired in. Mirrors
  /// the providers from [Screen.dashboard] so the dashboard tree has the same
  /// dependencies as the rest of the app.
  Widget _buildDashboardTab() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<ProfileCubit>()..getUserProfile(),
        ),
        BlocProvider.value(
          value: serviceLocator<StatisticsCubit>(),
        ),
      ],
      child: Dashboard(
        onSwitchToAiChat: () {
          if (!mounted) return;
          // AI chat lives at index 2 of [DashboardScreen.tabItems].
          if (_currentIndex == 2) return;
          _handleOnTabChange(2);
        },
        onOpenVoiceAgent: () {
          if (!mounted) return;
          _openVoiceAgentGated();
        },
        onOpenProfile: () {
          if (!mounted) return;
          Get.toNamed(AppRoutes.profileSettings);
        },
      ),
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
