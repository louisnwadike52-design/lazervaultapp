import 'package:flutter/foundation.dart';
import 'package:showcaseview/showcaseview.dart' show TooltipPosition;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/app_services_builder.dart';
import 'package:lazervault/core/services/account_update_announcement_service.dart';
import 'package:lazervault/src/features/onboarding/dashboard_walkthrough.dart';
import 'package:lazervault/src/features/widgets/all_services_bottom_sheet.dart';
import 'package:lazervault/src/features/account_cards_summary/presentation/view/dashboard_card_summary.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/cubit/dashboard_rates_cubit.dart';
import 'package:lazervault/src/features/widgets/dashboard/exchange_rates.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/widgets/dashboard/generate_bank_card.dart';
import 'package:lazervault/src/features/widgets/dashboard/invite_friends.dart';
import 'package:lazervault/src/features/widgets/dashboard/dashboard_adverts_carousel.dart';
import 'package:lazervault/src/features/widgets/dashboard/monthly_summary.dart';
import 'package:lazervault/src/features/widgets/dashboard/portfolio.dart';
import 'package:lazervault/src/features/widgets/recent_history.dart';
import 'package:lazervault/src/features/widgets/dashboard/trending_crowdfunds.dart';
import 'package:lazervault/src/features/widgets/dashboard/public_groups.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/leaderboard_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/dashboard/widgets/dashboard_action_sheet.dart';
import 'package:lazervault/src/features/widgets/dashboard/dashboard_refresh_signal.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'dashboard_widgets.dart';


class Dashboard extends StatefulWidget {
  /// Switches the bottom-nav to the AI Chat tab (index 2).
  final VoidCallback? onSwitchToAiChat;

  /// Opens the voice command bottom sheet.
  final VoidCallback? onOpenVoiceAgent;

  /// Navigates to the profile / settings screen.
  final VoidCallback? onOpenProfile;

  const Dashboard({
    super.key,
    this.onSwitchToAiChat,
    this.onOpenVoiceAgent,
    this.onOpenProfile,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final FamilyAccountCubit _familyInviteCubit;

  // Cache last known invitations so banner doesn't flash during loading
  List<PendingInvitation> _cachedInvitations = [];

  // Track error snackbar to avoid repeated display
  bool _hasShownErrorSnackbar = false;

  @override
  void initState() {
    super.initState();
    _familyInviteCubit = serviceLocator<FamilyAccountCubit>();
    _familyInviteCubit.loadPendingInvitations();
    // First-run coach-mark tour — gated PER ACCOUNT so every new signup / first
    // login gets it even if another account already toured this device. Resolve
    // the current user id here (the dashboard is post-auth, so the profile is
    // present); a blank id no-ops. Starts after first frame.
    final walkthroughUserId =
        context.read<AuthenticationCubit>().currentProfile?.user.id ?? '';
    DashboardWalkthrough.maybeStart(context, userId: walkthroughUserId);
    // Server-driven account-update announcement (VA provider migration):
    // shown once per user per version, after first frame so it can never
    // block dashboard load. Best-effort end to end.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AccountUpdateAnnouncementService.instance
          .maybeShow(context, userId: walkthroughUserId);
    });
  }

  @override
  void dispose() {
    _swipeProgress.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Allow error snackbar to show again on explicit refresh
    _hasShownErrorSnackbar = false;

    // Refresh dashboard data by fetching account summaries
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;

      // Get active country from ProfileCubit
      final profileState = context.read<ProfileCubit>().state;
      String? activeCountry;
      if (profileState is ProfileLoaded) {
        activeCountry = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : null;
      }

      // Refresh account summaries. manualRefresh keeps the cards on screen and
      // shows a small "Refreshing…" pill on the card (feedback even when the
      // balance is unchanged); the network fetch always runs and re-persists the
      // cache, so balances are revalidated regardless.
      await context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
            accessToken: accessToken,
            country: activeCountry,
            manualRefresh: true,
          );

      // Refresh family invitations
      _familyInviteCubit.loadPendingInvitations();

      // Broadcast the manual refresh so sections that own their own cubit
      // instance (e.g. Recent Transactions) hard-reload + revalidate their cache
      // in place. A shared serviceLocator fetch can't reach those factory
      // instances, so they subscribe to this signal instead.
      DashboardRefreshSignal.instance.fire();
    }
  }

  String _getBaseCurrency() {
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      final currency = profileState.preferences.currency;
      if (currency.isNotEmpty) return currency;
    }
    return 'NGN';
  }

  /// Summaries list from cubit when data is available (including post–WebSocket updates).
  List<AccountSummaryEntity>? _accountSummariesFromState(
      AccountCardsSummaryState state) {
    if (state is AccountCardsSummaryLoaded) {
      return state.accountSummaries;
    }
    if (state is AccountBalanceUpdated) {
      return state.accountSummaries;
    }
    return null;
  }

  /// True when the account currently shown in the top carousel is Family &
  /// Friends — detected by the [isFamilyAccount] flag (name-independent), not
  /// the card's label.
  ///
  /// The carousel activates a family card by its [spendingAccountId] (the
  /// family virtual/pool account), which is NOT the same as the summary [id].
  /// So we match the active id against BOTH — exactly like [AccountCarousel]
  /// does when it restores the active page. Matching only [id] meant a family
  /// card never registered as active and the "create another" CTA stayed hidden.
  bool _activeCarouselAccountIsFamily(
    List<AccountSummaryEntity> summaries,
    String? activeAccountId,
  ) {
    if (activeAccountId == null || activeAccountId.isEmpty) return false;
    for (final a in summaries) {
      if (a.id == activeAccountId || a.spendingAccountId == activeAccountId) {
        return a.isFamilyAccount ||
            a.accountTypeEnum == VirtualAccountType.family;
      }
    }
    return false;
  }

  // Accumulates downward overscroll attempts at the top of the list. When it
  // crosses [_kSwipeDownTriggerPx] within a single gesture we open the
  // quick-action sheet. Reset on every scroll start/end so a small natural
  // overscroll never accidentally opens the sheet.
  double _topOverscrollAccum = 0;
  static const double _kSwipeDownTriggerPx = 80.0;
  // Mirrors [_topOverscrollAccum] / [_kSwipeDownTriggerPx] (clamped 0..1).
  // A ValueNotifier so the swipe-progress indicator can rebuild on every
  // overscroll frame without re-running the whole dashboard tree.
  final ValueNotifier<double> _swipeProgress = ValueNotifier<double>(0);
  // Latches when the threshold trips so we don't fire haptic repeatedly
  // while the user keeps holding the gesture after the sheet is queued.
  bool _swipeArmed = false;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0) return false;
    if (notification is ScrollStartNotification ||
        notification is ScrollEndNotification) {
      _topOverscrollAccum = 0;
      _swipeArmed = false;
      if (_swipeProgress.value != 0) _swipeProgress.value = 0;
      return false;
    }
    if (notification is OverscrollNotification &&
        notification.overscroll < 0 &&
        notification.metrics.pixels <= 0) {
      _topOverscrollAccum += notification.overscroll.abs();
      _swipeProgress.value =
          (_topOverscrollAccum / _kSwipeDownTriggerPx).clamp(0.0, 1.0);
      if (!_swipeArmed && _topOverscrollAccum >= _kSwipeDownTriggerPx) {
        _swipeArmed = true;
        HapticFeedback.mediumImpact();
        _openQuickActionSheet();
      }
    }
    return false;
  }

  void _openQuickActionSheet() {
    if (!mounted) return;
    showDashboardActionSheet(
      context,
      onRefreshAccounts: _onRefresh,
      onOpenAiChat: () {
        if (!mounted) return;
        widget.onSwitchToAiChat?.call();
      },
      onOpenProfile: () {
        if (!mounted) return;
        widget.onOpenProfile?.call();
      },
      onOpenVoiceAgent: () async {
        if (!mounted) return;
        // Refresh first so the voice agent sees fresh balances.
        try {
          await _onRefresh();
        } catch (_) {
          // Refresh failure should not block opening the voice agent.
        }
        if (!mounted) return;
        widget.onOpenVoiceAgent?.call();
      },
      // Open the P2P financial-connections list. Pushed (Get.toNamed) so Back
      // pops straight back to the dashboard — same route the Send Funds →
      // Select Recipient flow uses, so back-navigation is consistent from
      // every entry point.
      onMessageFinancialConnections: () =>
          Get.toNamed(AppRoutes.financialConnections),
      // Search across EVERY platform service (deduped across account types) via
      // the existing searchable all-services sheet (real-time filter + tap-to-
      // navigate).
      onSearchServices: () =>
          showAllServicesBottomSheet(context, AppServicesBuilder.getAllServices()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Wallet/account section. In Showcase (advert) mode it renders
                  // a touch shorter so the adverts carousel + compact services
                  // still sit above the fold. Rebuilds live on layout switch.
                  DashboardWalkthrough.step(
                    key: DashboardWalkthrough.accountsKey,
                    title: 'Your accounts',
                    body:
                        'Personal, family, family & friends and business — swipe to switch. Pull down anytime to refresh.',
                    child: ValueListenableBuilder<int>(
                      valueListenable: FeatureFlags.dashboardLayoutRevision,
                      builder: (context, _, __) => DashboardCardSummary(
                        compact: FeatureFlags.dashboardShowcaseLayout,
                      ),
                    ),
                  ),
                  _buildPendingInvitationsBanner(),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Quick services + (classic) refer-a-friend OR (showcase)
                        // compact services + adverts carousel. The user picks the
                        // layout in Settings → Dashboard layout; this region
                        // rebuilds live when they switch.
                        ValueListenableBuilder<int>(
                          valueListenable:
                              FeatureFlags.dashboardLayoutRevision,
                          builder: (context, _, __) {
                            final showcase =
                                FeatureFlags.dashboardShowcaseLayout;
                            return Column(
                              children: [
                                DashboardWalkthrough.step(
                                  key: DashboardWalkthrough.servicesKey,
                                  title: 'Your services',
                                  body:
                                      'These reorder by how often you use them (toggle in Settings). Tap “View all” to see everything and rearrange.',
                                  child: AppServicesBuilder(compact: showcase),
                                ),
                                SizedBox(height: 16.0.h),
                                // Adverts carousel + refer-a-friend are hidden when
                                // a Family & Friends card is active so that screen
                                // stays clean — only the (self-gating) create-another
                                // family CTA shows there.
                                _familyAwareBottomExtras(showcase),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 16.0.h),
                        DashboardWalkthrough.step(
                          key: DashboardWalkthrough.historyKey,
                          title: 'Recent activity',
                          body:
                              'Your latest transactions at a glance — tap any to see its receipt.',
                          // Lower on the page → tooltip sits ABOVE, pointing down.
                          position: TooltipPosition.top,
                          child: RecentHistory(),
                        ),
                        SizedBox(height: 16.0.h),
                        BlocProvider(
                          create: (_) => serviceLocator<LeaderboardCubit>(),
                          child: const TrendingCrowdfunds(),
                        ),
                        SizedBox(height: 16.0.h),
                        BlocProvider.value(
                          value: serviceLocator<GroupAccountCubit>(),
                          child: const PublicGroups(),
                        ),
                        // Cards section: force-hidden in the view layer
                        // regardless of the admin flag. The widget + its
                        // routes/repository + `FeatureFlags.dashboardCardsVisible`
                        // stay wired — to re-enable, just delete the `false &&`
                        // guard below. (Hidden because the Cards product surface
                        // isn't ready for testers yet; keeping the flag wiring
                        // intact means the admin toggle resumes working when
                        // the guard is lifted.)
                        // ignore: dead_code
                        if (false && FeatureFlags.dashboardCardsVisible) ...[
                          SizedBox(height: 16.0.h),
                          GenerateBankCard(),
                        ],
                        SizedBox(height: 16.0.h),
                        Portfolio(),
                        SizedBox(height: 16.0.h),
                        BlocProvider(
                          create: (_) => serviceLocator<DashboardRatesCubit>()
                            ..loadRates(_getBaseCurrency()),
                          child: const ExchangeRates(),
                        ),
                        SizedBox(height: 16.0.h),
                        MonthlySummary(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Swipe-down progress chip — appears at the top while the user is
          // pulling and animates with their drag, then disappears once the
          // sheet opens or the gesture ends.
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: _SwipeDownIndicator(progress: _swipeProgress),
              ),
            ),
          ),
        ],
    );
  }

  Widget _buildPendingInvitationsBanner() {
    return BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
      bloc: _familyInviteCubit,
      listener: (context, state) {
        if (state is InvitationAccepted) {
          Get.snackbar(
            'Invitation Accepted',
            'You have joined the family account!',
            backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          // Refresh dashboard to show the new family card
          _onRefresh();
        } else if (state is InvitationDeclined) {
          Get.snackbar(
            'Invitation Declined',
            'The invitation has been declined.',
            backgroundColor: const Color(0xFF9CA3AF).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          _familyInviteCubit.loadPendingInvitations();
        } else if (state is FamilyAccountError) {
          // Show error snackbar only once to avoid repeated popups on network failure
          if (!_hasShownErrorSnackbar) {
            _hasShownErrorSnackbar = true;
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
          // Do NOT retry here — user can pull-to-refresh to retry
        }
      },
      builder: (context, state) {
        // Update cache when fresh data arrives
        if (state is PendingInvitationsLoaded) {
          _cachedInvitations = state.invitations
              .where((inv) => !inv.isExpired)
              .toList();
        } else if (state is InvitationAccepted || state is InvitationDeclined) {
          // Clear cache — will be repopulated when loadPendingInvitations completes
          _cachedInvitations = [];
        }

        // Show cached invitations during loading (prevents flash)
        final invitations = _cachedInvitations;
        if (invitations.isEmpty) return const SizedBox.shrink();

        final isProcessing = state is FamilyAccountLoading;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              ...invitations
                  .map((invite) => _buildInviteCard(invite, isProcessing: isProcessing)),
              if (invitations.length > 1)
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.familyInvitations),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View All Invitations',
                          style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: const Color(0xFF3B82F6),
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// CTA card for creating Family & Friends accounts (max 3).
  /// Only visible when a Family & Friends card is the active card in the top
  /// carousel (swipe to a family card to reveal it) and the user has fewer than
  /// 3 family accounts. Tapping "+" opens the consolidated create flow.
  /// Bottom-of-dashboard extras (adverts carousel + refer-a-friend), gated by the
  /// ACTIVE account type. On a Family & Friends card we render ONLY the
  /// create-another family CTA (which self-hides when not applicable) so the
  /// family screen stays clean — no adverts, no invite block.
  Widget _familyAwareBottomExtras(bool showcase) {
    final accountManager = serviceLocator<AccountManager>();
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        final summaries = _accountSummariesFromState(state);
        return StreamBuilder<String?>(
          stream: accountManager.accountIdStream,
          initialData: accountManager.activeAccountId,
          builder: (context, snapshot) {
            final isFamilyActive = summaries != null &&
                _activeCarouselAccountIsFamily(summaries, snapshot.data);
            if (isFamilyActive) {
              return _buildFamilyFriendsCTA();
            }
            return Column(
              children: [
                if (showcase) ...[
                  const DashboardAdvertsCarousel(),
                  SizedBox(height: 16.0.h),
                ],
                _buildFamilyFriendsCTA(),
                if (showcase)
                  const InviteFriendsCompact()
                else
                  InviteFriends(),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFamilyFriendsCTA() {
    final accountManager = serviceLocator<AccountManager>();

    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        final summaries = _accountSummariesFromState(state);
        if (summaries == null || summaries.isEmpty) {
          return const SizedBox.shrink();
        }

        return StreamBuilder<String?>(
          stream: accountManager.accountIdStream,
          initialData: accountManager.activeAccountId,
          builder: (context, snapshot) {
            final activeId = snapshot.data;
            if (!_activeCarouselAccountIsFamily(summaries, activeId)) {
              return const SizedBox.shrink();
            }

            // Consolidation: don't offer "create ANOTHER family account" while
            // the active Family & Friends account is still PENDING SETUP. The
            // user should finish setting up this first account — via the card's
            // "Get Started" or the services "Setup Now", which now share one
            // canonical flow — before starting a second. Otherwise three
            // overlapping CTAs (get started / setup now / add-another) compete on
            // the same pending slide, with divergent destinations.
            AccountSummaryEntity? activeFamily;
            for (final a in summaries) {
              if ((a.id == activeId || a.spendingAccountId == activeId) &&
                  (a.isFamilyAccount ||
                      a.accountTypeEnum == VirtualAccountType.family)) {
                activeFamily = a;
                break;
              }
            }
            final isPendingSetup = activeFamily == null ||
                activeFamily.isFamilyPendingSetup ||
                !activeFamily.isFamilyAccount;
            if (isPendingSetup) return const SizedBox.shrink();

            final familyCount = summaries
                .where((a) => a.accountTypeEnum == VirtualAccountType.family)
                .length;

            if (familyCount >= 3) return const SizedBox.shrink();

            final slotsRemaining = 3 - familyCount;

            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A1A3E), Color(0xFF2D2B6B)],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A1A3E).withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.family_restroom,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Family & Friends',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Share & manage money together. $slotsRemaining ${slotsRemaining == 1 ? 'slot' : 'slots'} available.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12.sp,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.familyCreate),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: const Color(0xFF1A1A3E),
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInviteCard(PendingInvitation invite, {bool isProcessing = false}) {
    final isExpired = invite.isExpired;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isExpired
              ? const Color(0xFFEF4444).withValues(alpha: 0.3)
              : const Color(0xFF2D2B6B).withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: isExpired
                      ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                      : const Color(0xFF2D2B6B).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isExpired ? Icons.timer_off : Icons.family_restroom,
                  color: isExpired
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF2D2B6B),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isExpired
                          ? 'Expired Invitation'
                          : 'Family Account Invitation',
                      style: TextStyle(
                        color: isExpired
                            ? const Color(0xFFEF4444)
                            : Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${invite.creatorName} invited you to "${invite.familyName}"',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!isExpired)
                Text(
                  invite.daysUntilExpiration <= 0
                      ? '<1d left'
                      : '${invite.daysUntilExpiration}d left',
                  style: TextStyle(
                    color: invite.daysUntilExpiration <= 1
                        ? const Color(0xFFEF4444)
                        : const Color(0xFFFB923C),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          if (isExpired)
            Center(
              child: TextButton(
                onPressed: () => _familyInviteCubit.declineInvitation(invite.invitationToken),
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: OutlinedButton(
                      onPressed: isProcessing
                          ? null
                          : () => _familyInviteCubit.declineInvitation(invite.invitationToken),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF9CA3AF),
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Decline',
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: isProcessing
                          ? null
                          : () => _familyInviteCubit.acceptInvitation(invite.invitationToken),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D2B6B),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF2D2B6B).withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: isProcessing
                          ? LazerVaultLoader(size: 18)
                          : Text(
                              'Accept',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                            ),
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
