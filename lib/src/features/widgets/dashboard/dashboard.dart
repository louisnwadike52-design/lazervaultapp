import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/app_services_builder.dart';
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
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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

      // Refresh account summaries
      await context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
            accessToken: accessToken,
            country: activeCountry,
          );

      // Refresh family invitations
      _familyInviteCubit.loadPendingInvitations();
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
                  ValueListenableBuilder<int>(
                    valueListenable: FeatureFlags.dashboardLayoutRevision,
                    builder: (context, _, __) => DashboardCardSummary(
                      compact: FeatureFlags.dashboardShowcaseLayout,
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
                                AppServicesBuilder(compact: showcase),
                                SizedBox(height: 16.0.h),
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
                        ),
                        SizedBox(height: 16.0.h),
                        RecentHistory(),
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

/// Pill chip rendered at the top of the dashboard while the user is pulling
/// down. Reads from a [ValueNotifier<double>] (0..1) so only this widget
/// rebuilds during the drag — not the whole dashboard tree.
class _SwipeDownIndicator extends StatelessWidget {
  final ValueListenable<double> progress;

  const _SwipeDownIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: progress,
      builder: (_, value, __) {
        if (value <= 0.0) return const SizedBox.shrink();
        final ready = value >= 1.0;
        final scale = 0.85 + 0.15 * value;
        // Opacity comes in fast so even a tiny pull confirms the gesture is
        // being read.
        final opacity = (value * 1.6).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, value * 8),
            child: Transform.scale(
              scale: scale,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: ready
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6).withValues(
                            alpha: 0.4 + 0.6 * value,
                          ),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      ready
                          ? Icons.check_circle_rounded
                          : Icons.swipe_down_rounded,
                      size: 14.sp,
                      color: ready
                          ? const Color(0xFF10B981)
                          : Colors.white,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      ready ? 'Release for actions' : 'Pull to open actions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
