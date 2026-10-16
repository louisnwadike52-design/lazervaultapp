import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lazervault/src/features/group_account/presentation/widgets/select_payout_receiver_bottom_sheet.dart';
import 'package:lazervault/src/features/group_account/presentation/widgets/start_esusu_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/contribution_type_badge.dart';
import '../widgets/add_members_to_contribution_dialog.dart';
import '../widgets/payout_receiver_banner.dart';
import 'contribution_payment_confirmation_screen.dart';
import 'contribution_chat_screen.dart';
import '../../data/datasources/contribution_chat_remote_data_source.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../widgets/exit_contribution_bottom_sheet.dart';
import 'contribution_cycles_history_screen.dart';
import 'package:lazervault/core/shared_widgets/scroll_more_hint.dart';
import 'edit_contribution_screen.dart';
import '../widgets/payment_group_widgets.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import '../widgets/mention_picker.dart';
import '../utils/group_funds_palette.dart';
import '../widgets/full_text_details_dialog.dart';
import '../widgets/auto_debit_attempts_sheet.dart';
part 'contribution_details_sheets.dart';
part 'contribution_details_banners.dart';
part 'contribution_details_payment_widgets.dart';

class ContributionDetailsScreen extends StatefulWidget {
  final String contributionId;
  final Contribution? contribution;

  const ContributionDetailsScreen({
    super.key,
    required this.contributionId,
    this.contribution,
  });

  @override
  State<ContributionDetailsScreen> createState() =>
      _ContributionDetailsScreenState();
}

class _ContributionDetailsScreenState extends State<ContributionDetailsScreen>
    // TickerProviderStateMixin, not SingleTicker: the tab count is not fixed
    // (see [_syncTabController]) and SingleTickerProviderStateMixin asserts on
    // a second ticker even after the first is disposed.
    with
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  late TabController _tabController;
  Contribution? _currentContribution;
  List<ContributionPayment> _localPayments = [];
  // Cached so the Contribute FAB can be role-gated without re-reading
  // cubit state on every paint. Populated from the
  // GroupAccountGroupLoaded listener.
  GroupMember? _currentGroupMember;

  // Live transcript-generation subscription. Tracked at the State level so
  // the dispose() path can cancel it cleanly — without this, an in-flight
  // generate after the user pops the screen would call setState on an
  // unmounted widget AND leak the cubit-stream listener.
  StreamSubscription<GroupAccountState>? _transcriptSub;

  /// Keeps an OPEN details screen honest while OTHER members act.
  ///
  /// Nearly everything on this screen is other people's money moving: a member
  /// pays, the pot grows, arrears clear, the payout becomes triggerable. It
  /// refreshed only on open, on app resume, on pull-to-refresh and after the
  /// viewer's OWN action — so an admin sitting on it while the last member paid
  /// kept reading the receiver as behind, and the Trigger Payout button kept
  /// offering a payout whose state had already moved underneath it. That stale
  /// button is what made "Try again" look like the thing to press on a cycle
  /// that had already been paid.
  ///
  /// Deliberately a SLOW poll. PayoutReceiverBanner already polls every 3s
  /// while a payout is IN_FLIGHT, which is the only window where seconds
  /// matter; this covers the minutes-long window while contributions trickle
  /// in.
  Timer? _refreshTimer;
  static const Duration _refreshEvery = Duration(seconds: 20);

  /// Last settled tab index, so the tab listener fires once per change rather
  /// than on every frame of the indicator animation.
  int _lastTabIndex = 0;

  void _startAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(_refreshEvery, (_) {
      if (!mounted) return;
      // Never refresh from under a modal — a PIN sheet, a confirm dialog, a
      // member sheet. Those are opened AGAINST a contribution snapshot, and
      // swapping it mid-flow is how a confirm ends up acting on different
      // numbers than the ones the user read.
      if (ModalRoute.of(context)?.isCurrent != true) return;
      _loadContributionDetails(force: true);
    });
  }

  void _stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  /// Switching INTO a tab is exactly when its staleness becomes visible, so
  /// re-read then as well as on the timer.
  void _onTabChanged() {
    if (!mounted) return;
    final index = _tabController.index;
    if (index == _lastTabIndex) return;
    _lastTabIndex = index;
    _loadContributionDetails(force: true);
    _loadLocalPayments();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _startAutoRefresh();
    _currentContribution = widget.contribution;
    _loadContributionDetails();
    _loadLocalPayments();
    _refreshChatUnread(widget.contributionId);
  }

  /// Unread messages waiting in this contribution's chat. Drives the badge on
  /// the chat CTA so new messages are discoverable without opening it.
  int _chatUnread = 0;

  /// Whether the auto-payout chip is currently painting anything.
  ///
  /// It only renders while the payout is SCHEDULED and decides that for
  /// itself after fetching. Reserving a layout slot for it before it has
  /// decided meant a zero-height chip took half a row, which pushed the Role
  /// tile onto a row of its own — the row the tab bar then clipped.
  bool _autoPayoutChipVisible = false;
  final ContributionChatRemoteDataSource _chatDs =
      ContributionChatRemoteDataSource();

  /// Best-effort: a chat-badge failure must never disturb the details screen,
  /// so every error simply leaves the badge as it was.
  Future<void> _refreshChatUnread(String contributionId) async {
    if (contributionId.isEmpty) return;
    try {
      final auth = context.read<AuthenticationCubit>().state;
      if (auth is! AuthenticationSuccess) return;
      final state = await _chatDs.chatState(
        token: auth.profile.session.accessToken,
        contributionId: contributionId,
      );
      if (!mounted) return;
      if (state.unreadCount != _chatUnread) {
        setState(() => _chatUnread = state.unreadCount);
      }
    } catch (_) {
      // Badge is cosmetic — never surface.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAutoRefresh();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _transcriptSub?.cancel();
    _transcriptSub = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // A timer that keeps firing in the background spends the user's data and
    // battery on a screen nobody is looking at, and lands its result on a
    // widget that may be disposed before it returns.
    if (state != AppLifecycleState.resumed) {
      _stopAutoRefresh();
      return;
    }
    if (mounted) {
      _startAutoRefresh();
      // Refresh payments when app resumes (e.g., returning from payment screen)
      _refreshPayments();
      // Also re-sync group state so pending-invite shadow rows get
      // promoted to active (or removed on decline/expire) without
      // requiring a manual pull-to-refresh.
      final groupId =
          _currentContribution?.groupId ?? widget.contribution?.groupId;
      if (groupId != null && groupId.isNotEmpty) {
        context.read<GroupAccountCubit>().loadGroupDetails(groupId);
      }
    }
  }

  Future<void> _loadLocalPayments() async {
    try {
      final payments = await context
          .read<GroupAccountCubit>()
          .getContributionPayments
          .call(widget.contributionId);
      if (mounted) {
        setState(() {
          _localPayments = payments;
        });
      }
    } catch (_) {
      // Payments will remain empty on error
    }
  }

  /// Fetch the contribution.
  ///
  /// [force] re-reads even when one is already held. Without it this was a
  /// first-load only: the `== null` guard meant every later call — after a
  /// payment, on pull-to-refresh, on app resume — did nothing, so the header
  /// kept reporting whatever was true when the screen opened. That is what
  /// made the statistics disagree with the payments list underneath them.
  void _loadContributionDetails({bool force = false}) {
    if (_currentContribution != null && !force) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context
          .read<GroupAccountCubit>()
          .loadContributionDetails(widget.contributionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
          // Only rebuild for the states the body renders. Side-effect
          // states (success snack-bars, navigation) still fire the listener.
          buildWhen: (previous, current) =>
              current is GroupAccountLoading ||
              current is GroupAccountGroupLoaded ||
              // The state a DEEP LINK arrives on. Without it in this list the
              // screen never rebuilt after the fetch landed and sat on the
              // loading view for good.
              current is ContributionDetailsLoaded ||
              current is ContributionPaymentSuccess ||
              current is ContributionPaymentFailed ||
              current is GroupAccountError,
          listener: (context, state) {
            if (state is GroupAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is ContributionDetailsLoaded) {
              // Arrived by id alone — a push tap, an in-app notification tap,
              // a share link. This is the ONLY state that carries a
              // contribution without a group behind it.
              if (state.contribution.id == widget.contributionId && mounted) {
                setState(() {
                  _currentContribution = state.contribution;
                  if (state.payments.isNotEmpty) {
                    _localPayments = state.payments;
                  }
                });
                // The group is what tells this screen the viewer's ROLE, and
                // the deep link had no group id until now. Fetching it here —
                // after the contribution is already on screen — fills in the
                // admin-only controls without making the first paint wait.
                final gid = state.contribution.groupId;
                if (gid.isNotEmpty) {
                  context.read<GroupAccountCubit>().loadGroupDetails(gid);
                }
              }
            } else if (state is GroupAccountGroupLoaded) {
              // Update the current contribution from the loaded group data
              // This ensures statistics update after payment
              final updatedContribution = state.contributions
                  .where((c) => c.id == widget.contributionId)
                  .firstOrNull;
              final cubit = context.read<GroupAccountCubit>();
              final myUserId = cubit.currentUserId;
              final myMember = myUserId != null
                  ? state.members.where((m) => m.userId == myUserId).firstOrNull
                  : null;
              if (updatedContribution != null && mounted) {
                setState(() {
                  _currentContribution = updatedContribution;
                  _currentGroupMember = myMember;
                });
                // Also refresh local payments to ensure UI is up to date
                _loadLocalPayments();
              } else if (myMember != _currentGroupMember && mounted) {
                setState(() => _currentGroupMember = myMember);
              }
            } else if (state is ContributionPaymentSuccess) {
              // Show success message and refresh data
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFF10B981),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              // Refresh the list AND the statistics above it — a payment
              // changes both, and refreshing only the list left the header
              // reporting the figures from before the money moved.
              _refreshPayments();
            } else if (state is ContributionMembersAdded) {
              // Members were added - the cubit already calls loadGroupDetails
              // which will emit GroupAccountGroupLoaded and update _currentContribution
              // Note: The dialog shows the snackbar, so we don't show one here to avoid duplicates
            }
          },
          builder: (context, state) {
            if (_currentContribution == null && state is GroupAccountLoading) {
              return _buildLoadingView();
            } else if (_currentContribution != null) {
              return _buildContributionDetailsView(_currentContribution!);
            } else if (state is GroupAccountError) {
              return _buildErrorView(state.message);
            }

            return _buildLoadingView();
          },
        ),
      ),
      floatingActionButton: _shouldShowContributeFab()
          ? FloatingActionButton.extended(
              onPressed: () => _navigateToMakePayment(_currentContribution!),
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              icon: Icon(Icons.payment, size: 20.sp),
              label: Text(
                'Contribute',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading contribution details...',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load contribution',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContributionDetailsView(Contribution contribution) {
    // The Cycles tab comes and goes with the contribution's state, and
    // TabController.length must match the children built below.
    _syncTabController(contribution);
    // Get current user info for permission display
    final cubit = context.read<GroupAccountCubit>();
    final currentUserId = cubit.currentUserId;
    final isCreator =
        currentUserId != null && contribution.createdBy == currentUserId;
    final isMember = currentUserId != null &&
        contribution.members.any((m) => m.userId == currentUserId);
    // Group admin is anyone who is either the group's adminId OR a
    // member with role=admin. Receiver-flow CTAs (Set Receiver, Trigger
    // Payout, Change, Retry) require admin-level authority server-side,
    // and "creator" is too narrow — group admins routinely manage
    // contributions they didn't personally create. Falling back to the
    // cubit's last-loaded group snapshot for role lookup.
    final group = cubit.lastLoadedGroup;
    // Same cross-group guard as _shouldShowContributeFab: only trust
    // role metadata from lastLoadedGroup when its id matches THIS
    // contribution's group_id. Otherwise we'd hand admin-only CTAs
    // (Set Receiver, Trigger Payout) to someone who has no role on
    // this group, just because they recently visited a group they
    // do admin elsewhere.
    final isGroupAdmin = currentUserId != null &&
        group != null &&
        group.id == contribution.groupId &&
        (group.adminId == currentUserId ||
            group.members.any((m) =>
                m.userId == currentUserId && m.role == GroupMemberRole.admin));
    final isAdmin = isCreator || isGroupAdmin;

    return Column(
      children: [
        _buildHeader(contribution),
        // SCROLLABLE above the tabs.
        //
        // Everything between the header and the tab bar is a variable number
        // of cards — summary, start/receiver actions, status chips, external
        // links — and on a small screen with several of them showing, the tab
        // bar was pushed off the bottom and Overview / Payments / Members
        // became unreachable. Flexible lets this block give way to the tabs
        // rather than shoving them off, and the scroll view means nothing
        // inside it is lost when it does.
        Flexible(
          // Pull-to-refresh here as well as on each tab. This block carries
          // the summary, the Start / Receiver pair and the payout banner —
          // exactly the things that change when somebody else acts — and it
          // is where a user whose eye is on the CTA will pull.
          child: RefreshIndicator(
            onRefresh: () async => _loadContributionDetails(force: true),
            color: GroupFundsPalette.onDark,
            backgroundColor: const Color(0xFF1F1F1F),
            // This block is a VARIABLE stack of cards, so whether it overflows
            // depends on the contribution's state and the device. When it does
            // there was nothing on screen to say so — it just looked finished.
            // The hint shows only when it actually scrolls and fades at the
            // bottom.
            child: ScrollMoreHint(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildContributionSummary(contribution),
                    // Directly under the statistics, above everything else that competes
                    // for attention. An esusu that has not started is the one state where
                    // nothing else on this screen can proceed — no payment, no payout, no
                    // rotation — so the action that unblocks it belongs at the top rather
                    // than only on the card in the list behind.
                    // Not started: Start and Set receiver as ONE compact pair.
                    //
                    // Both used to be full-width banners with their whole explanation
                    // inline. Stacked under the summary card they filled the screen and
                    // pushed the tab bar off the bottom, so Overview / Payments /
                    // Members could not be reached at all on a phone. The detail now
                    // lives in a dialog behind each button, which is where somebody
                    // about to take an irreversible action (starting locks the roster)
                    // should be reading it anyway.
                    if (contribution.awaitingOpen)
                      _buildAwaitingOpenActions(contribution, isAdmin),
                    // Payout receiver banner — surfaces the scheduled-payout state
                    // (pending_receiver / ready / scheduled / in_flight / settled
                    // / failed / exhausted) with the right CTA for the role. Only
                    // admin/creator gets actionable buttons; members see read-only
                    // status. The banner self-loads + polls in_flight states.
                    PayoutReceiverBanner(
                      contribution: contribution,
                      cycleIndex:
                          contribution.type == ContributionType.rotatingSavings
                              ? (contribution.currentCycle ?? 1)
                              : 0,
                      isAdmin: isAdmin,
                      // SCHEDULED state is rendered as a compact chip in the
                      // status row below; the banner only owns the actionable /
                      // exceptional states (pending, ready, in_flight, failed,
                      // exhausted, settled).
                      hideScheduled: true,
                      // Offered in the compact pair above while the circle has not
                      // started, so the tall version here would be a second copy of the
                      // same action.
                      hidePendingReceiver: contribution.awaitingOpen,
                      // After a manual trigger settles, the saga creates a new
                      // payout_transaction + zeros current_amount on the
                      // contribution. Refreshing the contribution details here
                      // makes the Payments / Overview tabs reflect the new state
                      // without the user pulling-to-refresh.
                      onStateChanged: _loadContributionDetails,
                    ),
                    // Status chips row: auto-debit + auto-payout (when scheduled)
                    // + role rendered side-by-side. Each chip is borderless, uses
                    // elevation, and opens a styled dialog with the full detail
                    // when tapped. Wraps to two rows on narrow screens.
                    _buildStatusChipsRow(
                        contribution, isCreator, isMember, isAdmin),
                    if (contribution.hasExternalLinks)
                      _buildExternalLinksSection(contribution),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildTabBar(contribution),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(contribution),
              _buildPaymentsTab(contribution),
              _buildMembersTab(contribution),
              // Same screen the overflow menu and the Cycles chip open, with
              // its own Scaffold and back header dropped. Reusing it means the
              // cycle cards, the per-cycle bottom sheet and the loading /
              // error states are the ones already in production, not a second
              // implementation that can drift.
              if (_showCyclesTab(contribution))
                ContributionCyclesHistoryScreen(
                  contribution: contribution,
                  embedded: true,
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Renders the auto-debit + auto-payout (when scheduled) + role
  /// chips side-by-side. Each chip is a borderless elevated tile that
  /// opens a detail dialog on tap.
  ///
  /// Layout strategy: the row uses LayoutBuilder so the chips stay
  /// readable when the screen is narrow or when all three chips are
  /// visible at once.
  ///   - If each chip would get >= ~110.w on one row, render in a
  ///     single Row with Expanded children.
  ///   - Otherwise wrap to two-per-row using Wrap. This avoids the
  ///     classic "RenderFlex overflow" message when three chips share
  ///     a 320-pt screen.
  ///
  /// The auto-payout chip self-fetches the receiver state and
  /// collapses to nothing unless status == SCHEDULED, so it only
  /// takes a row slot when there's something to surface.
  Widget _buildStatusChipsRow(
    Contribution contribution,
    bool isCreator,
    bool isMember,
    bool isAdmin,
  ) {
    final cubit = context.read<GroupAccountCubit>();
    final currentUserId = cubit.currentUserId;
    final me = currentUserId == null
        ? null
        : contribution.members
            .where((m) => m.userId == currentUserId)
            .cast<ContributionMember?>()
            .firstOrNull;

    // Auto-debit visibility mirrors _buildAutoDebitBanner's gates:
    // contribution must have auto_pay enabled AND the current user
    // must actually be a contribution member (group admins viewing
    // shouldn't see "you'll be charged" copy).
    final showAutoDebit = contribution.autoPayEnabled && me != null;
    final showAutoPayout = contribution.autoPayoutEnabled;

    final roleChip = _StatusChip(
      icon: _roleIcon(isCreator, isMember),
      iconColor: _roleColor(isCreator, isMember),
      label: 'Role',
      value: _roleLabel(isCreator, isMember),
      onTap: () => _showRoleDialog(contribution, isCreator, isMember),
    );

    final chips = <Widget>[];
    if (showAutoDebit) {
      final hasPaid = me.hasPaidCurrentCycle;
      chips.add(_StatusChip(
        icon: hasPaid ? Icons.check_circle : Icons.bolt,
        iconColor: hasPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
        label: 'Auto-debit',
        value: hasPaid ? 'Covered' : 'On',
        onTap: () => _showAutoDebitDialog(contribution, hasPaid: hasPaid),
      ));
    } else if (me != null) {
      // AUTO-DEBIT OFF — SHOWN, NOT HIDDEN.
      //
      // The flag was settable only at creation, so a circle created with it
      // off nagged its members "payment past due" every cycle with nothing
      // anywhere that could answer the nag. The chip said nothing because it
      // rendered only when the flag was already on, which is the one state
      // where nobody needs to find the control.
      chips.add(_StatusChip(
        icon: Icons.bolt_outlined,
        iconColor: const Color(0xFF9CA3AF),
        label: 'Auto-debit',
        value: 'Off',
        onTap: () => _showEnableAutoDebitDialog(contribution, isAdmin: isAdmin),
      ));
    }
    final autoPayoutChip = !showAutoPayout
        ? null
        : AutoPayoutScheduledChip(
            contribution: contribution,
            cycleIndex: contribution.type == ContributionType.rotatingSavings
                ? (contribution.currentCycle ?? 1)
                : 0,
            isAdmin: isAdmin,
            onReceiverChanged: _loadContributionDetails,
            // Only drives the SPACING below. It must never decide whether the
            // chip is in the tree — see the comment on autoPayoutRow.
            onVisibilityChanged: (visible) {
              if (!mounted || _autoPayoutChipVisible == visible) return;
              setState(() => _autoPayoutChipVisible = visible);
            },
          );
    chips.add(roleChip);

    // The auto-payout chip lives on its OWN row, at a FIXED position, always
    // mounted.
    //
    // It used to be moved between the chip row and a parked Offstage as its
    // visibility changed, and that moved it to a different position in the
    // widget tree — which destroys its State and builds a new one. The new
    // State starts with no fetched data, so its first build reports "not
    // visible", which moved it back, which built another new State, which
    // fetched again... an endless rebuild loop with a network request per
    // lap. On screen that is the flicker reported as "items glitching like
    // multiple rerendering".
    //
    // Keeping it in one place fixes it outright: the chip renders
    // SizedBox.shrink() while there is nothing to show, which costs no height
    // and no row slot, so the original problem it was moved to solve — an
    // invisible chip stealing half a row and pushing Role under the tab bar —
    // does not arise either. Only the gap above it is conditional, and a
    // changed padding value does not relocate anything.
    // "Previous cycles", beside auto-payout.
    //
    // The cycle history screen already existed and was reachable only from the
    // overflow menu, which is where things go to not be found. It sits here
    // because a rotation's past cycles are the natural companion to its next
    // payout — same question ("what has this circle actually done"), one tap
    // apart.
    //
    // Only once the circle has STARTED. Before that there is genuinely no
    // history, and a CTA that opens an empty list teaches the user it is not
    // worth tapping again.
    final showCycles =
        contribution.isRotatingSavings && !contribution.awaitingOpen;
    final cyclesChip = !showCycles
        ? null
        : _StatusChip(
            icon: Icons.history_rounded,
            iconColor: const Color(0xFF9CA3AF),
            label: 'Cycles',
            value: 'View past',
            onTap: () => _openCyclesHistory(contribution),
          );

    final autoPayoutRow = autoPayoutChip == null && cyclesChip == null
        ? null
        : Padding(
            // Same 20.w gutter the chip row above uses — this sits OUTSIDE
            // that row's Padding, so it has to carry its own.
            padding: EdgeInsets.fromLTRB(
                20.w,
                (_autoPayoutChipVisible || cyclesChip != null) ? 8.h : 0,
                20.w,
                0),
            // STATIC shape, whatever the auto-payout chip decides to render.
            //
            // Both slots are always in the tree when this row exists, so the
            // auto-payout chip never changes position — moving it is what
            // destroyed its State and produced the endless fetch-rebuild loop
            // documented above. It collapses to SizedBox.shrink() on its own
            // when it has nothing to say, which costs no height.
            child: autoPayoutChip == null
                ? cyclesChip
                : Row(
                    children: [
                      Expanded(child: autoPayoutChip),
                      if (cyclesChip != null) ...[
                        SizedBox(width: 10.w),
                        Expanded(child: cyclesChip),
                      ],
                    ],
                  ),
          );

    Widget withAutoPayout(Widget row) => autoPayoutRow == null
        ? row
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [row, autoPayoutRow],
          );

    if (chips.length == 1) {
      return withAutoPayout(Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        child: chips.first,
      ));
    }

    return withAutoPayout(Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final spacing = 10.w;
          // Minimum width per chip to keep the value text legible.
          // Below this we wrap to two-per-row to avoid clipping the
          // chevron + value + label stack.
          const minChipWidth = 130.0;
          final perChipSingleRow =
              (constraints.maxWidth - spacing * (chips.length - 1)) /
                  chips.length;
          if (perChipSingleRow >= minChipWidth) {
            return Row(
              children: [
                for (int i = 0; i < chips.length; i++) ...[
                  if (i > 0) SizedBox(width: spacing),
                  Expanded(child: chips[i]),
                ],
              ],
            );
          }
          // Fallback: two-per-row Wrap. Width is half-row minus
          // spacing; if there's an odd chip out it takes full row.
          final twoPerRow = (constraints.maxWidth - spacing) / 2;
          return Wrap(
            spacing: spacing,
            runSpacing: 8.h,
            children: [
              for (final c in chips)
                SizedBox(
                  width: chips.length.isOdd && c == chips.last
                      ? constraints.maxWidth
                      : twoPerRow,
                  child: c,
                ),
            ],
          );
        },
      ),
    ));
  }

  String _roleLabel(bool isCreator, bool isMember) => isCreator
      ? 'Creator'
      : isMember
          ? 'Member'
          : 'Viewer';

  Color _roleColor(bool isCreator, bool isMember) => isCreator
      ? const Color(0xFFEF4444)
      : isMember
          ? const Color(0xFF10B981)
          : const Color(0xFF3B82F6);

  IconData _roleIcon(bool isCreator, bool isMember) => isCreator
      ? Icons.star
      : isMember
          ? Icons.person
          : Icons.visibility;

  void _showRoleDialog(
      Contribution contribution, bool isCreator, bool isMember) {
    final permissions = isCreator
        ? const [
            'Edit contribution',
            'Add members',
            'View all payments',
            'Delete contribution'
          ]
        : isMember
            ? const ['Make payments', 'View payments', 'Download receipts']
            // NOT 'Request to join'. Membership of a contribution is granted
            // by an admin — either when the contribution is created or by
            // adding members to it afterwards — and that sends an invite. A
            // self-service request was a second, parallel way in that nobody
            // administers: it added the requester immediately with no admin
            // decision, which is not "requesting" anything.
            : const ['View contribution'];
    final color = _roleColor(isCreator, isMember);
    final icon = _roleIcon(isCreator, isMember);
    final label = _roleLabel(isCreator, isMember);

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (dialogCtx) => _StatusDetailDialog(
        accent: color,
        icon: icon,
        title: 'You\'re a $label',
        sections: [
          _DialogSection(
            heading: 'Your role',
            body:
                'This describes the actions you can take on this contribution.',
          ),
          _DialogSection(
            heading: 'Permissions',
            bullets: permissions,
          ),
        ],
        // No action for a non-member. An admin adds them and the invite
        // arrives; there is nothing for them to do from here.
        primaryAction: null,
      ),
    );
  }

  /// Offers to turn auto-debit ON for this contribution.
  ///
  /// Server-side this is an ADMIN edit (the same ActionEditContribution gate
  /// as the target amount), so a plain member is told who can do it rather
  /// than being shown a button that will come back refused. The flag is
  /// per-CONTRIBUTION, not per-member — that is how the backend models it,
  /// and saying so plainly is better than implying a personal setting that
  /// would quietly change the circle for everyone.
  void _showEnableAutoDebitDialog(Contribution contribution,
      {required bool isAdmin}) {
    final amountLabel = contribution.regularAmount != null &&
            contribution.regularAmount! > 0
        ? '${contribution.currency} ${_fmtAmount(contribution.regularAmount!)}'
        : 'each share';
    final sections = <_DialogSection>[
      _DialogSection(
        heading: 'What it does',
        body: 'With auto-debit on, $amountLabel is collected from each '
            "member's wallet at the start of every cycle. If a wallet is "
            'short, we try again once a day and tell that member why — '
            'instead of everyone getting a "past due" reminder they have to '
            'act on by hand.',
      ),
      _DialogSection(
        heading: 'It applies to the whole circle',
        body: 'This is a setting on the contribution, so turning it on turns '
            'it on for every member. Nobody is charged anything they did not '
            'already owe for the cycle.',
      ),
    ];
    if (!isAdmin) {
      sections.add(const _DialogSection(
        heading: 'Who can turn it on',
        body: 'Only the group admin can change this. Ask them to switch '
            'auto-debit on, or keep paying your share from the Contribute '
            'button.',
      ));
    }

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (dialogCtx) => _StatusDetailDialog(
        accent: const Color(0xFF9CA3AF),
        icon: Icons.bolt_outlined,
        title: 'Auto-debit is off',
        sections: sections,
        primaryAction: !isAdmin
            ? null
            : _DialogAction(
                label: 'Turn auto-debit on',
                onTap: () {
                  Navigator.of(dialogCtx).pop();
                  _setAutoDebit(contribution, true);
                },
              ),
      ),
    );
  }

  /// Writes the flag and re-reads the contribution.
  ///
  /// The server charges the current cycle immediately when this goes from off
  /// to on — somebody switching it on has just been told their share is past
  /// due, and leaving them looking at the same nag would make the switch
  /// appear to do nothing. So the re-read matters: it is what replaces
  /// "past due" with "Covered" on this screen.
  Future<void> _setAutoDebit(Contribution contribution, bool on) async {
    final messenger = ScaffoldMessenger.of(context);
    final cubit = context.read<GroupAccountCubit>();
    await cubit.updateContributionDetails(
      contribution.copyWith(autoPayEnabled: on),
    );
    if (!mounted) return;
    // updateContributionDetails reports failure as a STATE, not an exception
    // (it rolls its optimistic patch back and emits GroupAccountError), and
    // this screen's listener already surfaces that. So the only thing left to
    // decide is whether to claim success — and claiming it after a refusal is
    // exactly the "setting that silently did nothing" this change exists to
    // remove.
    if (cubit.state is GroupAccountError) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(on
            ? 'Auto-debit is on. We will collect each share automatically.'
            : 'Auto-debit is off. Members pay their share manually.'),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
    // Re-read: the server charges the current cycle the moment this goes from
    // off to on, so this is what turns "past due" into "Covered" on screen.
    _loadContributionDetails(force: true);
  }

  void _showAutoDebitDialog(Contribution contribution,
      {required bool hasPaid}) {
    // The viewer's own member row, resolved the same way the chips row does —
    // the attempt history below is about THIS person, not the circle.
    final currentUserId = context.read<GroupAccountCubit>().currentUserId;
    final me = currentUserId == null
        ? null
        : contribution.members
            .where((m) => m.userId == currentUserId)
            .cast<ContributionMember?>()
            .firstOrNull;
    // A one-time contribution has no cycles. It is collected once and that
    // closes it, so "the next cycle close" describes something that will
    // never happen and "you've already paid for this cycle" implies another
    // one is coming.
    final isOneTime = contribution.type == ContributionType.oneTime;
    // One-time has no next payment date; its deadline IS the date.
    final due = contribution.nextPaymentDate ??
        (isOneTime ? contribution.deadline : null);
    final dueLabel = due != null
        ? DateFormat('MMM dd, yyyy').format(due)
        : (isOneTime ? 'the due date' : 'the next cycle close');
    final amountLabel = contribution.regularAmount != null &&
            contribution.regularAmount! > 0
        ? '${contribution.currency} ${_fmtAmount(contribution.regularAmount!)}'
        : null;

    final accent = hasPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C);
    final title = hasPaid ? 'You\'re covered' : 'Auto-debit is on';

    // WHEN the debit happens, correctly.
    //
    // This said "if you don't pay before <the cycle close>, we'll auto-debit"
    // — which described the old behaviour, where auto-pay only ran from the
    // overdue sweep after the cycle had already closed. The debit now runs
    // when the cycle STARTS, so the copy would have been a plain untruth about
    // somebody's money.
    final body = hasPaid
        ? (isOneTime
            ? 'You\'ve already paid, so no auto-charge will run for you.'
            : 'You\'ve already paid for this cycle, so no auto-charge will run for you.')
        : isOneTime
            ? (amountLabel != null
                ? 'If you haven\'t paid $amountLabel by $dueLabel, we\'ll auto-debit it from your account.'
                : 'If you haven\'t paid by $dueLabel, we\'ll auto-debit your account.')
            : (amountLabel != null
                ? 'We collect $amountLabel from your account at the start of each cycle. If it doesn\'t go through, we try again once a day until it does.'
                : 'We collect your share from your account at the start of each cycle. If it doesn\'t go through, we try again once a day until it does.');

    final sections = <_DialogSection>[
      _DialogSection(heading: 'How it works', body: body),
    ];

    // What we have actually TRIED, for this member, this cycle.
    //
    // Until this existed the attempt history lived only in the service's own
    // table: auto-pay could fail, retry and exhaust its attempts while the
    // member saw nothing but "behind". Somebody whose card was empty on the
    // 1st deserves to know we tried, how many times, and what the bank said.
    final attempts = me?.autoChargeAttempts ?? 0;
    if (me != null && attempts > 0) {
      final when = me.autoChargeLastAttemptAt;
      final whenLabel = when != null
          ? DateFormat('MMM d, h:mm a').format(when.toLocal())
          : null;
      final reason = me.autoChargeLastError.trim();
      final buf = StringBuffer();
      buf.write(attempts == 1 ? 'We tried once' : 'We tried $attempts times');
      if (whenLabel != null) buf.write(', last on $whenLabel');
      buf.write('. ');
      if (me.autoChargeExhausted) {
        buf.write('We have stopped trying for this cycle, so please pay '
            'manually.');
      } else if (me.autoChargeTriedAndFailed) {
        buf.write('We will try again tomorrow. You can also pay manually '
            'at any time.');
      } else {
        buf.write('It went through.');
      }
      if (reason.isNotEmpty && !me.autoChargeStatus.startsWith('succ')) {
        buf.write('\n\nLast reason: $reason');
      }
      sections.add(_DialogSection(
        heading: me.autoChargeExhausted ? 'We stopped trying' : 'What we tried',
        body: buf.toString(),
      ));
    }

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (dialogCtx) => _StatusDetailDialog(
        accent: accent,
        icon: hasPaid ? Icons.check_circle : Icons.bolt,
        title: title,
        sections: sections,
        // The dialog answers "what happened to ME". This opens the rest of the
        // cycle — every member's auto-debit state — which is the question an
        // admin actually has when a pot is short, and which a member asking
        // "is it just me?" wants too.
        primaryAction: _DialogAction(
          label: 'See all attempts this cycle',
          onTap: () {
            Navigator.of(dialogCtx).pop();
            _showAutoDebitAttemptsSheet(contribution);
          },
        ),
      ),
    );
  }

  /// Every member's auto-debit state for the current cycle.
  ///
  /// A BOTTOM SHEET rather than another dialog: this is a list that can run to
  /// the length of the roster, and it is reached by drilling in rather than by
  /// being interrupted.
  ///
  /// Built from the roster already loaded — each ContributionMember carries its
  /// own autoCharge status, attempt count, last attempt and last error — so it
  /// costs no extra round-trip and cannot disagree with the Members tab.
  void _showAutoDebitAttemptsSheet(Contribution contribution) {
    final members = contribution.members
        .where((m) => m.isActiveParticipant)
        .toList()
      // Anything that needs attention first: exhausted, then failed, then
      // pending, then the ones that went through. A list sorted by name buries
      // the one row somebody opened this to find.
      ..sort((a, b) => _autoChargeRank(a).compareTo(_autoChargeRank(b)));

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => AutoDebitAttemptsSheet(
        contribution: contribution,
        members: members,
        cycle: contribution.currentCycle ?? 1,
      ),
    );
  }

  /// Sort weight: the rows that need a human come first.
  int _autoChargeRank(ContributionMember m) {
    if (m.autoChargeExhausted) return 0;
    if (m.autoChargeTriedAndFailed) return 1;
    if (m.autoChargeStatus == 'pending') return 2;
    if (m.autoChargeStatus.startsWith('succ')) return 4;
    return 3;
  }

  Widget _buildHeader(Contribution contribution) {
    // Deliberately tight. Everything on this screen that matters — the
    // summary, the Start / Receiver pair, the tabs — has to fit above the
    // fold on a phone, and the header was spending ~96pt of that on a title
    // the user just tapped to get here. Sizes below are the smallest that
    // keep the title legible at one line.
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 9.h, 8.w, 9.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tapping the header title opens the name and description in
                // full. The header clips to one line so the action icons fit,
                // which makes the one piece of text identifying this circle
                // the piece you cannot finish reading. This is the only place
                // the affordance lives — on the list it stole the tap that
                // opens the contribution.
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => showFullTextDetailsDialog(
                    context,
                    title: contribution.title,
                    description: contribution.description,
                    subtitle: contribution.isRotatingSavings
                        ? 'Esusu · Rotating'
                        : 'One-time goal',
                    icon: contribution.isRotatingSavings
                        ? Icons.sync
                        : Icons.flag_outlined,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contribution.title,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Contribution Details',
                        style: GoogleFonts.inter(
                          fontSize: 10.5.sp,
                          color: Colors.grey[400],
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                // ROSCA / one-time pill in the header — surfaces the
                // payout model up where the title sits, instead of
                // burying it next to the description further down the
                // screen. Intrinsic-width badge so the row doesn't
                // stretch; clipped if the title squeezes the column.
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ContributionTypeBadge(type: contribution.type),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Chat',
            // Default IconButton reserves 48x48; three of those set the
            // header's floor height on their own.
            padding: EdgeInsets.all(6.w),
            constraints: const BoxConstraints(),
            visualDensity: VisualDensity.compact,
            // Unread badge: without it nobody learns there are new messages
            // until they happen to open the chat. Count comes from the chat
            // state endpoint (messages from others past the caller's read
            // watermark) and refreshes whenever this screen rebuilds.
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.chat_bubble_outline,
                    color: Colors.white, size: 19.sp),
                if (_chatUnread > 0)
                  Positioned(
                    right: -4.w,
                    top: -3.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: _chatUnread > 9 ? 4.w : 0, vertical: 1.h),
                      constraints:
                          BoxConstraints(minWidth: 15.w, minHeight: 15.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: Center(
                        child: Text(
                          _chatUnread > 99 ? '99+' : '$_chatUnread',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              final cubit = context.read<GroupAccountCubit>();
              final me = cubit.currentUserId;
              if (me == null) return;
              final auth = context.read<AuthenticationCubit>().state;
              if (auth is! AuthenticationSuccess) return;
              // Full-screen chat (was an in-memory bottom sheet): messages are
              // persisted server-side now, with read receipts, typing presence
              // and replies. Token is read lazily so a refresh mid-conversation
              // is picked up without rebuilding the screen.
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (_) => ContributionChatScreen(
                      contributionId: contribution.id,
                      contributionTitle: contribution.title,
                      currentUserId: me,
                      // Supplied from here because the chat screen has no
                      // member list of its own. ACTIVE members only — the
                      // server rejects anyone else anyway, and offering a name
                      // that silently fails to tag is worse than not offering
                      // it. Deriving candidates from who has spoken would make
                      // a quiet member impossible to mention.
                      mentionCandidates: cubit.state is GroupAccountGroupLoaded
                          ? (cubit.state as GroupAccountGroupLoaded)
                              .members
                              .where(
                                  (m) => m.status == GroupMemberStatus.active)
                              .map((m) => MentionCandidate(
                                    userId: m.userId,
                                    name: m.userName.trim().isNotEmpty
                                        ? m.userName.trim()
                                        : 'Member',
                                    username: m.userUsername,
                                  ))
                              .toList()
                          : const [],
                      tokenProvider: () {
                        final s = context.read<AuthenticationCubit>().state;
                        return s is AuthenticationSuccess
                            ? s.profile.session.accessToken
                            : '';
                      },
                    ),
                  ))
                  // Opening the chat marks it read, so refresh the badge on
                  // the way back instead of leaving a stale count.
                  .then((_) => _refreshChatUnread(contribution.id));
            },
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.all(6.w),
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 20.sp,
            ),
            color: const Color(0xFF1F1F1F),
            itemBuilder: (context) {
              // Edit is admin-only. The creator owns the contribution
              // (contribution.createdBy) — server-side editContribution
              // is also admin-gated, so this just keeps the affordance
              // honest.
              final currentUserId =
                  context.read<GroupAccountCubit>().currentUserId;
              final canEditContribution = currentUserId != null &&
                  contribution.createdBy == currentUserId;

              // Can the person reading this leave it?
              //
              // Only an ACTIVE member can, and only while the contribution
              // is still running: the exit saga refuses a settled one-time
              // (the funds are already disbursed), so offering the item
              // there would offer a guaranteed failure. The sheet still
              // asks the server for the real preview — this only decides
              // whether to show the affordance.
              final myMembership = currentUserId == null
                  ? null
                  : contribution.members
                      .where((m) =>
                          m.userId == currentUserId &&
                          m.membershipStatus ==
                              ContributionMembershipStatus.active)
                      .firstOrNull;
              final canExitContribution =
                  myMembership != null && !contribution.displayState.isTerminal;

              return [
                PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'Share',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                if (canEditContribution)
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 20.sp),
                        SizedBox(width: 12.w),
                        Text(
                          'Edit',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                // Cycles — rotating savings only, and only for someone who may
                // edit the contribution. The server refuses both cases, so
                // showing the item otherwise offers a guaranteed failure.
                if (canEditContribution &&
                    contribution.type == ContributionType.rotatingSavings)
                  PopupMenuItem(
                    value: 'cycles',
                    child: Row(
                      children: [
                        Icon(Icons.repeat_rounded,
                            color: Colors.white, size: 20.sp),
                        SizedBox(width: 12.w),
                        Text(
                          'Change cycles',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                // Change the payout receiver. Rotation only, admin/creator
                // only, and only once the circle has actually started — there
                // is no cycle to assign a receiver for before that, and the
                // Start / Receiver pair on the body already covers that case.
                //
                // Here as well as on the body because this is the menu people
                // open when they want to CHANGE something that is already
                // set; the body's banner only appears while the receiver is
                // still unset or the payout is in an exceptional state.
                if (canEditContribution &&
                    contribution.type == ContributionType.rotatingSavings &&
                    !contribution.awaitingOpen)
                  PopupMenuItem(
                    value: 'change_receiver',
                    child: Row(
                      children: [
                        Icon(Icons.swap_horiz_rounded,
                            color: Colors.white, size: 20.sp),
                        SizedBox(width: 12.w),
                        Text(
                          'Change payout receiver',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                PopupMenuItem(
                  value: 'transcript',
                  child: Row(
                    children: [
                      Icon(Icons.receipt_long,
                          color: Colors.white, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'Get Transcript',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'history',
                  child: Row(
                    children: [
                      Icon(Icons.timeline, color: Colors.white, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'View Cycles History',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Leaving. This is where a member looks for it — the
                // only other way in was a row inside the Members tab,
                // which is where you go to act on SOMEBODY ELSE.
                //
                // "Past contributions" moved to the group screen, which is
                // where a group's contributions are listed.
                if (canExitContribution)
                  PopupMenuItem(
                    value: 'exit_contribution',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red, size: 20.sp),
                        SizedBox(width: 12.w),
                        Text(
                          'Exit contribution',
                          style: GoogleFonts.inter(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
              ];
            },
            onSelected: (value) => _handleMenuAction(value, contribution),
          ),
        ],
      ),
    );
  }

  // Tightens the statistics container so the items below (tabs +
  // overview) are visible at-a-glance without scrolling. Removed the
  // duplicated description (already shown in the header above this
  // card) and reduced padding / inter-section spacing roughly 30%.
  // Numbers now render with thousands separators via _fmtAmount so
  // 30,000 reads as "30,000" not "30.0M" and not "30000.00".
  /// The "this has not started yet" call to action.
  ///
  /// Only the people who can actually start it get the button; everyone else
  /// gets the explanation, because a member seeing a disabled control they
  /// cannot use learns nothing about why the circle is idle.
  /// Start + Set receiver, side by side, each opening its own dialog.
  ///
  /// Replaces two stacked full-width banners that between them occupied most
  /// of the screen and pushed the tab bar out of reach. The explanatory copy
  /// is not lost — it moves into the dialog, in front of the button that
  /// commits the action, which is where it is actually read.
  Widget _buildAwaitingOpenActions(Contribution contribution, bool isAdmin) {
    final cubit = context.read<GroupAccountCubit>();
    final myUserId = cubit.currentUserId;
    final canStart = contribution.createdBy == myUserId ||
        GroupRolePermissions.canMember(
            _currentGroupMember, GroupAction.editContribution);
    final active = contribution.members
        .where((m) => m.membershipStatus == ContributionMembershipStatus.active)
        .length;

    // Who is currently down to collect, resolved to a name off the roster.
    //
    // null means genuinely nobody is set — not merely that we could not name
    // them — so a receiver whose roster row is missing still reports as set
    // rather than silently offering to "set" one that already exists.
    final receiverId = contribution.currentPayoutRecipient;
    final String? receiverName = receiverId == null
        ? null
        : (contribution.members
                .where((m) => m.userId == receiverId)
                .map((m) => m.userName.trim())
                .where((n) => n.isNotEmpty)
                .firstOrNull ??
            'Selected');

    if (!canStart && !isAdmin) {
      // A member who can do neither gets the sentence, not two dead buttons.
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1206),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF7A5B00)),
        ),
        child: Row(
          children: [
            Icon(Icons.play_circle_outline,
                color: const Color(0xFFF59E0B), size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'This esusu has not started. The creator sets the schedule '
                'and starts it; nobody can pay in until then.',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.5.sp,
                    height: 1.35),
              ),
            ),
          ],
        ),
      );
    }

    // The server refuses a circle of fewer than two ACCEPTED members, and it
    // used to be the only thing that said so — the creator pressed Start and
    // got a red sentence back. The requirement is knowable here, before the
    // tap, so it is stated here: the tile reads "Needs 1 more", the colour
    // drops to grey, and the sheet it opens explains what to do instead of
    // reporting a failure.
    //
    // minRotationMembers on the server. Kept as a named constant on this side
    // too so the two can be compared by eye rather than by memory.
    const minMembersToStart = 2;
    final shortBy = minMembersToStart - active;
    final canStartNow = shortBy <= 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Row(
        children: [
          if (canStart)
            Expanded(
              child: _compactAction(
                icon: canStartNow
                    ? Icons.play_arrow_rounded
                    : Icons.group_add_outlined,
                label: 'Start',
                sub: canStartNow
                    ? 'Set the schedule'
                    : 'Needs $shortBy more ${shortBy == 1 ? 'member' : 'members'}',
                color: canStartNow
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFF6B7280),
                onTap: () => canStartNow
                    ? _showStartDialog(contribution, active)
                    : _showNeedsMembersDialog(contribution, active),
              ),
            ),
          if (canStart && isAdmin) SizedBox(width: 10.w),
          if (isAdmin)
            Expanded(
              child: _compactAction(
                icon: receiverName == null
                    ? Icons.person_add_alt_1
                    : Icons.how_to_reg_rounded,
                label: 'Receiver',
                // Say WHO, not what the control is for.
                //
                // This read "Who gets paid" whether or not a receiver had been
                // chosen, and tapping it always opened an empty picker — so
                // setting a receiver looked like it had done nothing, and the
                // only way to change one was a menu item three taps away.
                sub: receiverName ?? 'Not set yet',
                color: receiverName == null
                    ? const Color(0xFFFB923C)
                    : const Color(0xFF10B981),
                onTap: () => receiverName == null
                    ? _showReceiverDialog(contribution)
                    : _showChangeReceiverFlow(contribution),
              ),
            ),
        ],
      ),
    );
  }

  Widget _compactAction({
    required IconData icon,
    required String label,
    required String sub,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.45)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 16.sp),
            ),
            SizedBox(width: 9.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700)),
                  Text(sub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: Colors.grey[500], fontSize: 10.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The detail that used to sit in the banner, in front of the button that
  /// commits it. Starting locks the roster, so it is worth a confirmation.
  /// Shown instead of the schedule sheet when the circle cannot legally
  /// start yet. Says the rule, says the count, and offers the action that
  /// fixes it — rather than letting the creator discover the rule by being
  /// refused.
  Future<void> _showNeedsMembersDialog(
      Contribution contribution, int active) async {
    final go = await _actionDialog(
      icon: Icons.group_add_outlined,
      color: const Color(0xFFF59E0B),
      title: active >= 1 ? 'Add one more member' : 'Add members first',
      body: 'An esusu is a rotation, so it needs at least 2 members who have '
          'ACCEPTED their invite before it can start. '
          '${active == 0 ? 'Nobody has' : active == 1 ? 'Only 1 person has' : '$active people have'} '
          'accepted so far.\n\nPeople you have invited who have not accepted '
          'yet do not count — they can still be added, and the circle will '
          'start once they are in.',
      cta: 'Add members',
    );
    if (go != true || !mounted) return;
    // Continue STRAIGHT to Start once the requirement is met.
    //
    // Adding the member was never the goal — starting was. Dropping the user
    // back on the details screen to hunt for Start again, immediately after
    // telling them Start was the thing they could not do yet, makes them
    // re-find a control they had already pressed.
    _showAddMembersDialog(contribution, onDone: () {
      if (!mounted) return;
      final fresh = _currentContribution ?? contribution;
      final nowActive = fresh.members
          .where(
              (m) => m.membershipStatus == ContributionMembershipStatus.active)
          .length;
      if (nowActive >= 2) _showStartDialog(fresh, nowActive);
    });
  }

  /// Members who were added but have not accepted their group invite yet.
  List<ContributionMember> _pendingInviteMembers(Contribution contribution) =>
      contribution.members.where((m) => m.isPendingInvite).toList();

  /// Starting with invites outstanding would silently drop those people.
  ///
  /// Starting FREEZES the roster and fixes the rotation order, so an unanswered
  /// invite has to be settled deliberately at that moment — the creator either
  /// waits for them, or removes them on purpose. The server refuses the open
  /// outright now; this asks the question before the tap, names exactly who is
  /// outstanding, and offers the way out, so the creator is never left with a
  /// refusal and no next step.
  Future<void> _showPendingInvitesBlockDialog(
      Contribution contribution, List<ContributionMember> pending) async {
    final names = pending
        .map((m) => m.userName.trim().isNotEmpty
            ? m.userName.trim()
            : (m.email.trim().isNotEmpty ? m.email.trim() : 'A member'))
        .toList();
    final shown = names.take(5).join('\n• ');
    final more = names.length > 5 ? '\n• and ${names.length - 5} more' : '';
    final go = await _actionDialog(
      icon: Icons.hourglass_top_rounded,
      color: const Color(0xFFFB923C),
      title: names.length == 1
          ? 'One invite is still unanswered'
          : '${names.length} invites are still unanswered',
      body: 'These people were added but have not accepted their group invite '
          'yet:\n\n• $shown$more\n\n'
          'Starting now would LOCK them out of the rotation — the roster '
          'freezes and they could not join afterwards. Wait for them to '
          'accept, or remove them first and start without them.',
      cta: 'Review members',
    );
    if (go != true || !mounted) return;
    // Straight to the roster, which is where removing them happens — rather
    // than closing the dialog onto the screen they started from with nothing
    // changed and no indication of where to go.
    _tabController.animateTo(2);
  }

  Future<void> _showStartDialog(Contribution contribution, int active) async {
    // Checked HERE as well as on the server, because the server's refusal
    // arrives after the creator has already chosen a schedule — three steps
    // past the point where the problem could have been explained.
    final pending = _pendingInviteMembers(contribution);
    if (pending.isNotEmpty) {
      await _showPendingInvitesBlockDialog(contribution, pending);
      return;
    }
    final go = await _actionDialog(
      icon: Icons.play_circle_outline,
      color: const Color(0xFFF59E0B),
      title: 'Start this esusu',
      body: 'Starting sets the schedule and LOCKS the member list: nobody '
          'can be added afterwards, and the rotation runs on the cycle '
          'length you pick next. $active '
          '${active == 1 ? 'person is' : 'people are'} in so far.',
      cta: 'Choose schedule',
    );
    if (go != true || !mounted) return;
    await _startEsusu(contribution);
  }

  /// Mirrors group-accounts' assertCanManageContribution for
  /// ActionEditContribution: a group admin or moderator, or the person who
  /// created this contribution while they are still an active member.
  ///
  /// Kept as one predicate so every surface that offers a roster change asks
  /// the same question the server will — a control that is visible and then
  /// refused teaches the user nothing except that the app is unreliable.
  bool _canManageThisContribution(Contribution contribution) {
    // The creator branch requires an ACTIVE membership, exactly as the server
    // does — assertCanManageContribution re-reads the group member row and
    // refuses a creator who has since been removed or suspended. Without that
    // clause here, a removed creator would still be shown the button and
    // refused on the tap, which is the failure this predicate exists to avoid.
    final me = _currentGroupMember;
    final myUserId = context.read<GroupAccountCubit>().currentUserId;
    if (myUserId != null &&
        myUserId.isNotEmpty &&
        contribution.createdBy == myUserId &&
        me != null &&
        me.status == GroupMemberStatus.active) {
      return true;
    }
    return GroupRolePermissions.canMember(me, GroupAction.editContribution);
  }

  /// Change who collects this cycle's pot, from the overflow menu.
  ///
  /// Gated by a confirmation that names the CURRENT receiver, so the admin
  /// sees who they are about to replace rather than discovering it after the
  /// fact. The picker that follows is itself a deliberate second action — it
  /// opens with nothing selected and its Set Receiver button stays the only
  /// way out that changes anything.
  ///
  /// The server still has the final say — it refuses a member who is behind,
  /// a non-member, and any reassignment once the payout is in flight or
  /// settled — and its sentence is shown verbatim if it does.
  /// Opens the cycle history, with the SAME cubit the overflow menu passes.
  ///
  /// The screen and the per-cycle sheets it opens both read the cycle list and
  /// per-cycle detail RPCs off this instance; handing them a fresh one would
  /// give them no loaded group and an empty list.
  /// Whether this contribution has cycles worth a tab of their own.
  ///
  /// A one-time collection has none at all, and a rotation that has not opened
  /// has none YET — showing an empty Cycles tab in either case is a dead end.
  bool _showCyclesTab(Contribution? c) =>
      c != null && c.isRotatingSavings && !c.awaitingOpen;

  /// Index of the Cycles tab, or -1 when it is not showing.
  int get _cyclesTabIndex => _showCyclesTab(_currentContribution) ? 3 : -1;

  /// Keeps [TabController.length] equal to the number of TabBar / TabBarView
  /// children, which Flutter requires at all times.
  ///
  /// The count is not fixed: a rotation gains its Cycles tab the moment it
  /// opens, and that can land while this screen is on screen (an admin starts
  /// it, or someone else does and the refresh brings it in). Rebuilding the
  /// controller is the only way to change the length, so this runs from build
  /// and is a no-op whenever the count already matches.
  void _syncTabController(Contribution? contribution) {
    final count = _showCyclesTab(contribution) ? 4 : 3;
    if (_tabController.length == count) return;
    final previous = _tabController.index;
    final old = _tabController;
    old.removeListener(_onTabChanged);
    _tabController = TabController(
      length: count,
      vsync: this,
      // Stay where the user was. Clamped because losing the Cycles tab while
      // standing on it would otherwise leave the controller out of range.
      initialIndex: previous.clamp(0, count - 1),
    )..addListener(_onTabChanged);
    _lastTabIndex = _tabController.index;
    // Disposed AFTER this frame: the outgoing TabBar / TabBarView are still
    // listening to it until they rebuild, and disposing mid-build makes the
    // next notification throw "used after being disposed".
    WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
  }

  /// Cycles, from the overflow menu or the Cycles chip.
  ///
  /// When the tab is showing, SWITCH TO IT rather than pushing the same screen
  /// on top of itself — otherwise the back stack holds two routes rendering
  /// the same list and Back from the pushed one lands on a details screen
  /// whose Cycles tab shows the very thing the user just dismissed. The push
  /// is kept for the states that have no tab.
  void _openCyclesHistory(Contribution contribution) {
    if (_cyclesTabIndex >= 0 && _tabController.length > _cyclesTabIndex) {
      _tabController.animateTo(_cyclesTabIndex);
      return;
    }
    final histCubit = context.read<GroupAccountCubit>();
    Get.to(
      () => BlocProvider<GroupAccountCubit>.value(
        value: histCubit,
        child: ContributionCyclesHistoryScreen(contribution: contribution),
      ),
    );
  }

  Future<void> _showChangeReceiverFlow(Contribution contribution) async {
    final current = contribution.currentPayoutRecipient;
    final currentName = current == null
        ? null
        : contribution.members
            .where((m) => m.userId == current)
            .map((m) => m.userName.trim())
            .where((n) => n.isNotEmpty)
            .firstOrNull;

    final cycle = contribution.currentCycle ?? 1;
    final go = await _actionDialog(
      icon: Icons.swap_horiz_rounded,
      color: const Color(0xFFFB923C),
      title: 'Change the payout receiver',
      body: currentName != null
          ? '$currentName is currently set to collect cycle $cycle. Picking '
              'somebody else hands this cycle\'s pot to them instead.\n\n'
              'You can change it until the payout fires; after that it is '
              'fixed.'
          : 'Nobody is set to collect cycle $cycle yet. Whoever you pick is '
              'paid by auto-payout, or by a manual trigger from an admin.\n\n'
              'You can change it until the payout fires.',
      cta: currentName != null ? 'Pick someone else' : 'Pick receiver',
    );
    if (go != true || !mounted) return;

    final res = await SelectPayoutReceiverBottomSheet.show(
      context: context,
      contribution: contribution,
      cycleIndex:
          contribution.type == ContributionType.rotatingSavings ? cycle : 0,
      currentReceiverUserId: current,
    );
    if (res == null || !mounted) return;

    // The sheet performed the change. Re-read rather than patching a field:
    // the receiver, the rotation badges and the payout banner all move at
    // once, and the member list paints "Next payout" from the contribution.
    _loadContributionDetails(force: true);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Payout receiver updated'),
      backgroundColor: const Color(0xFF10B981),
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> _showReceiverDialog(Contribution contribution) async {
    final go = await _actionDialog(
      icon: Icons.person_add_alt_1,
      color: const Color(0xFFFB923C),
      title: 'Set the payout receiver',
      body: 'Pick the member who receives this cycle\'s payout. Whoever is '
          'set here is paid by auto-payout, or by a manual trigger from an '
          'admin. You can change it until the payout fires.',
      cta: 'Pick receiver',
    );
    if (go != true || !mounted) return;
    final res = await SelectPayoutReceiverBottomSheet.show(
      context: context,
      contribution: contribution,
      cycleIndex: contribution.type == ContributionType.rotatingSavings
          ? (contribution.currentCycle ?? 1)
          : 0,
      // Pass the real value rather than a hardcoded null. The caller only
      // reaches here when nothing is set, but a stale snapshot would
      // otherwise present an already-chosen receiver as an empty picker.
      currentReceiverUserId: contribution.currentPayoutRecipient,
    );
    if (res != null && mounted) _loadContributionDetails(force: true);
  }

  Future<bool?> _actionDialog({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
    required String cta,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(title,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        content: Text(body,
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.5.sp,
                height: 1.45)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.r)),
            ),
            child: Text(cta,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  /// Collects the schedule, then starts the circle.
  Future<void> _startEsusu(Contribution contribution) async {
    final active = contribution.members
        .where((m) => m.membershipStatus == ContributionMembershipStatus.active)
        .toList();
    final choice = await showStartEsusuSheet(
      context,
      contribution: contribution,
      activeMembers: active.length,
      rotationNames: active
          .map((m) => m.userName.trim())
          .where((n) => n.isNotEmpty)
          .toList(),
    );
    if (choice == null || !mounted) return;
    final error = await context.read<GroupAccountCubit>().openEsusu(
          contribution.id,
          groupId: contribution.groupId,
          frequency: choice.frequency,
          totalCycles: choice.totalCycles,
          deadline: choice.endsOn,
        );
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    // The schedule, the roster and the badges all change at once, so re-read
    // rather than patching a field at a time.
    _loadContributionDetails(force: true);
    // And drop the cached contributions PAGE behind this screen. The group
    // details list renders "Not started" and a "Start esusu" button from that
    // cache, so without this the user starts the circle here, presses back,
    // and is offered Start again on the card they just used.
    if (!mounted) return;
    final cubit = context.read<GroupAccountCubit>();
    cubit.invalidatePages();
    unawaited(
        cubit.loadContributionsPage(contribution.groupId, 1, force: true));
  }

  Widget _buildContributionSummary(Contribution contribution) {
    final progressPercentage = contribution.progressPercentage;

    // Partial-aware stat inputs. The "Contributors" stat counts every
    // user who has made any payment attempt (completed, processing,
    // or even still-pending) so a single partial-paying member never
    // renders as zero contributors. We also count how many of those
    // contributors haven't yet hit their full expected share, so the
    // banner under the stats row can call them out — this is the
    // "show partials with a badge instead of hiding them" UX the user
    // asked for. Both reads merge local and server-side payment state
    // exactly the way the Payments tab does.
    final paymentLog = <ContributionPayment>[];
    final seenIds = <String>{};
    for (final p in _localPayments) {
      if (seenIds.add(p.id)) paymentLog.add(p);
    }
    for (final p in contribution.payments) {
      if (seenIds.add(p.id)) paymentLog.add(p);
    }
    // Contributors = distinct users with at least one non-failed
    // payment attempt. Failed/refunded attempts don't qualify because
    // no money ever moved (or it moved back).
    final contributorIds = <String>{};
    final paidByUser = <String, double>{};
    for (final p in paymentLog) {
      if (p.status == PaymentStatus.failed ||
          p.status == PaymentStatus.cancelled ||
          p.status == PaymentStatus.refunded) {
        continue;
      }
      contributorIds.add(p.userId);
      if (p.status == PaymentStatus.completed) {
        paidByUser.update(p.userId, (v) => v + p.amount,
            ifAbsent: () => p.amount);
      }
    }
    int partialCount = 0;
    int fullyPaidCount = 0;
    final memberByUser = <String, ContributionMember>{
      for (final m in contribution.members) m.userId: m,
    };
    for (final entry in paidByUser.entries) {
      final member = memberByUser[entry.key];
      final expected = _expectedShareFor(contribution, member);
      if (expected <= 0) continue;
      if (entry.value >= expected) {
        fullyPaidCount++;
      } else if (entry.value > 0) {
        partialCount++;
      }
    }

    // Mirrors the compact stat-row treatment from group_details_screen
    // (_buildGroupOverview): three-up KPI row, progress bar, totals
    // line. Same gradient + radius + spacing so the two pages feel
    // visually continuous as the user navigates from group → contribution.
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildContribStat(
                title: 'Raised',
                value:
                    '${contribution.currency} ${_fmtAmount(contribution.amountRaised)}',
                icon: Icons.account_balance_wallet,
              ),
              Container(
                width: 1,
                height: 32.h,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _buildContribStat(
                // Replaced the raw "Payments" attempt count with
                // "Contributors". The old count showed zero when the
                // only payment in flight was still pending; counting
                // distinct contributors gives the user immediate
                // signal that someone is paying, even before the
                // payment row clears the completed gate.
                title: 'Contributors',
                value: contributorIds.length.toString(),
                icon: Icons.groups_outlined,
              ),
              Container(
                width: 1,
                height: 32.h,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              _buildContribStat(
                // Progress reads from the contribution's currentAmount
                // (server-side, completed-only) so it stays anchored
                // to actual money in. Partial flags get their own row
                // below so users see "X partial, Y fully paid" instead
                // of the percentage being skewed by in-flight money.
                title: 'Progress',
                value:
                    '${progressPercentage.toStringAsFixed(progressPercentage < 10 && progressPercentage > 0 ? 1 : 0)}%',
                icon: Icons.trending_up,
              ),
            ],
          ),
          if (partialCount > 0 || fullyPaidCount > 0) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (fullyPaidCount > 0) ...[
                    Icon(Icons.check_circle,
                        color: const Color(0xFF10B981), size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '$fullyPaidCount fully paid',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  if (fullyPaidCount > 0 && partialCount > 0) ...[
                    SizedBox(width: 8.w),
                    Container(
                        width: 1,
                        height: 10.h,
                        color: Colors.white.withValues(alpha: 0.3)),
                    SizedBox(width: 8.w),
                  ],
                  if (partialCount > 0) ...[
                    Icon(Icons.donut_large,
                        color: const Color(0xFFFB923C), size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '$partialCount partial',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${contribution.currency} ${_fmtAmount(contribution.amountRaised)}',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                contribution.type == ContributionType.rotatingSavings
                    ? 'of ${contribution.currency} ${_fmtAmount(contribution.targetAmount)} pot'
                    : 'of ${contribution.currency} ${_fmtAmount(contribution.targetAmount)}',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Container(
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: (progressPercentage / 100).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The payout threshold, where the money it gates is being shown.
          //
          // minimum_balance is settable at creation and was then displayed
          // NOWHERE — its only appearance was inside the payout banner, to an
          // admin, and only once it was already blocking. So a member paying
          // into a pot could not see what it has to reach, and a payout that
          // had not happened looked like nothing more than a payout that had
          // not happened. Stated here, under the bar it governs, with the
          // remaining amount while it is short.
          if (_payoutThresholdLabel(contribution) != null) ...[
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.flag_outlined,
                    size: 11.sp, color: Colors.white.withValues(alpha: 0.75)),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    _payoutThresholdLabel(contribution)!,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Due ${DateFormat('MMM d, yyyy').format(contribution.deadline)}',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              _ContributionStateBadges(contribution: contribution),
            ],
          ),
        ],
      ),
    );
  }

  /// "Pays out at X" / "Y more before this can pay out".
  ///
  /// Null when no minimum is set, which is the common case — a contribution
  /// without one pays out on whatever it holds, and a line saying so would be
  /// noise on every circle that never had the setting.
  ///
  /// Mirrors PayoutReceiverBanner._potCoversMinimum, which mirrors the
  /// server's own guard (processPayoutCore: current_amount < minimum_balance
  /// → ErrInsufficientFunds). Three places now say the same thing; they agree
  /// because they are all phrased from the same two numbers.
  String? _payoutThresholdLabel(Contribution contribution) {
    final min = contribution.minimumBalance ?? 0;
    if (min <= 0) return null;
    final pot = contribution.currentAmount;
    final ccy = contribution.currency;
    if (pot >= min) {
      return 'Pays out at $ccy ${_fmtAmount(min)} — reached';
    }
    return '$ccy ${_fmtAmount(min - pot)} more before this can pay out '
        '(needs $ccy ${_fmtAmount(min)})';
  }

  // Same shape as group_details_screen's _buildOverviewStat — kept
  // private to this file rather than extracted to a shared util,
  // because the two screens have diverged enough that pulling them
  // into one helper would force one of the stat icons to stay mismatched.
  Widget _buildContribStat({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: Colors.white.withValues(alpha: 0.8), size: 14.sp),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  // Thousands-separated amount formatter. Mirrors contribution_card's
  // _formatAmount; defined inline so this screen doesn't pull in a
  // shared util just for one helper. Major units (post-_int64ToAmount).
  String _fmtAmount(double amount) {
    final hasFraction = amount != amount.truncateToDouble();
    final fmt = NumberFormat.decimalPattern();
    fmt.minimumFractionDigits = hasFraction ? 2 : 0;
    fmt.maximumFractionDigits = 2;
    return fmt.format(amount);
  }

  Widget _buildExternalLinksSection(Contribution contribution) {
    final links = contribution.externalLinks;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.link,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Social Media Links',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (links['whatsapp'] != null && links['whatsapp']!.isNotEmpty)
                _buildSocialButton(
                  label: 'WhatsApp',
                  icon: Icons.message,
                  color: const Color(0xFF25D366),
                  onTap: () => _launchLink(links['whatsapp']!),
                ),
              if (links['telegram'] != null && links['telegram']!.isNotEmpty)
                _buildSocialButton(
                  label: 'Telegram',
                  icon: Icons.send,
                  color: const Color(0xFF0088CC),
                  onTap: () => _launchLink(links['telegram']!),
                ),
              if (links['facebook'] != null && links['facebook']!.isNotEmpty)
                _buildSocialButton(
                  label: 'Facebook',
                  icon: Icons.facebook,
                  color: const Color(0xFF1877F2),
                  onTap: () => _launchLink(links['facebook']!),
                ),
              if (links['discord'] != null && links['discord']!.isNotEmpty)
                _buildSocialButton(
                  label: 'Discord',
                  icon: Icons.discord,
                  color: const Color(0xFF5865F2),
                  onTap: () => _launchLink(links['discord']!),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 16.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildTabBar(Contribution contribution) {
    final showCycles = _showCyclesTab(contribution);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color.fromARGB(255, 78, 3, 208),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          const Tab(text: 'Overview'),
          const Tab(text: 'Payments'),
          const Tab(text: 'Members'),
          if (showCycles) const Tab(text: 'Cycles'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Contribution contribution) {
    // Source of truth for Average Payment + completed-only stats.
    // Merges _localPayments (just-made, not yet refreshed from server)
    // with the proto-embedded list and dedups by id / transaction id —
    // same shape as _buildPaymentsTab so the two tabs never disagree.
    final completed = _completedPaymentsFor(contribution);
    final completedCount = completed.length;
    final completedSum =
        completed.fold<double>(0.0, (sum, p) => sum + p.amount);
    // Remaining is clamped at zero. Server caps overpay (validator on
    // the pay screen + DB check), but a brief over-shoot during a
    // race could otherwise surface as a negative "Remaining" — bad UX.
    final remaining = (contribution.targetAmount - contribution.amountRaised)
        .clamp(0.0, double.infinity);

    // Pull-to-refresh on EVERY tab, not just Payments. The statistics a user
    // wants to re-check live on this tab, and the only way to update them was
    // to leave the screen and come back.
    return RefreshIndicator(
      onRefresh: _refreshPayments,
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      child: SingleChildScrollView(
        // AlwaysScrollable so the gesture works even when the content is short
        // enough not to scroll on its own.
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // A finished contribution has nothing "remaining" — it has a
            // result. Showing a shortfall on a goal that has closed (or worse,
            // on one that was fully funded and paid out) describes a future
            // that is not coming.
            _buildStatCard(
              title: contribution.displayState.isTerminal
                  ? (contribution.paidOut ? 'Paid out' : 'Total raised')
                  : 'Remaining Amount',
              value: contribution.displayState.isTerminal
                  ? '${contribution.currency} '
                      '${(contribution.paidOut ? contribution.paidOutAmount : contribution.amountRaised).toStringAsFixed(2)}'
                  : '${contribution.currency} ${remaining.toStringAsFixed(2)}',
              icon: contribution.displayState.isTerminal
                  ? Icons.check_circle_outline
                  : Icons.account_balance_wallet,
              color: contribution.displayState.isTerminal
                  ? const Color(0xFF10B981)
                  : const Color(0xFF3B82F6),
            ),
            SizedBox(height: 16.h),
            // A finished contribution has no days remaining and cannot be
            // overdue. Showing "Overdue" in red beside a Completed badge was
            // the screen contradicting itself.
            _buildStatCard(
              // Reads off the same derived state as the badge, so the two
              // cannot disagree: a cancelled contribution is not "Closed" on
              // one card and "Cancelled" on the badge above it.
              title: contribution.displayState.isTerminal
                  ? contribution.displayState.label
                  : 'Days Remaining',
              value: contribution.displayState.isTerminal
                  ? DateFormat('MMM d, yyyy').format(contribution.deadline)
                  : _calculateDaysRemaining(contribution.deadline),
              icon: Icons.schedule,
              color: contribution.displayState.isTerminal
                  ? (contribution.displayState ==
                          ContributionDisplayState.cancelled
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981))
                  : contribution.isOverdue
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
            ),
            SizedBox(height: 16.h),
            _buildStatCard(
              title: 'Average Payment',
              // sum / count over **completed** payments only. Pending /
              // failed / refunded rows don't represent successful chunks
              // of money in, so excluding them keeps the average honest.
              // When everything that's landed has since been refunded
              // (count == 0), show "—" rather than misleading 0.00.
              value: completedCount > 0
                  ? '${contribution.currency} ${(completedSum / completedCount).toStringAsFixed(2)}'
                  : '${contribution.currency} —',
              icon: Icons.trending_up,
              color: const Color(0xFFF59E0B),
            ),
            SizedBox(height: 24.h),
            Text(
              'Description',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Text(
                contribution.description,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[300],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentsTab(Contribution contribution) {
    // Combine local payments with static contribution payments
    final allPayments = <ContributionPayment>[];

    // Add local payments first (these are newer)
    allPayments.addAll(_localPayments);

    // Add static payments, but avoid duplicates
    for (final staticPayment in contribution.payments) {
      final isDuplicate = allPayments.any((localPayment) =>
          localPayment.id == staticPayment.id ||
          (localPayment.transactionId != null &&
              staticPayment.transactionId != null &&
              localPayment.transactionId == staticPayment.transactionId));

      if (!isDuplicate) {
        allPayments.add(staticPayment);
      }
    }

    // Sort by payment date, newest first
    allPayments.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

    if (allPayments.isEmpty) {
      return _buildEmptyPayments();
    }

    // Group payments by user. The Payments tab now shows ONE row per
    // payer instead of one per attempt — partials by the same user
    // collapse into a single aggregated row with a "Partial" badge,
    // and the bottom sheet shows the per-attempt breakdown when tapped.
    // Members tab remains the per-user-with-cycle-stats view; this tab
    // is now the per-user transaction roll-up.
    final groups = _groupPaymentsByUser(allPayments, contribution);
    // Sort groups so the most recently active payer is on top — same
    // expectation users had from the per-attempt list.
    // Most recently settled payer on top; anyone who hasn't paid sorts below
    // them (null date) rather than crashing or jumping to the front.
    groups.sort((a, b) {
      final ad = a.latestPaymentDate;
      final bd = b.latestPaymentDate;
      if (ad == null && bd == null) return a.userName.compareTo(b.userName);
      if (ad == null) return 1;
      if (bd == null) return -1;
      return bd.compareTo(ad);
    });

    return RefreshIndicator(
      onRefresh: _refreshPayments,
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      child: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _PaymentGroupCard(
              group: group,
              onTap: () => _showPaymentGroupDetails(group, contribution),
            ),
          );
        },
      ),
    );
  }

  /// Buckets the flat payment stream by user_id and decorates each
  /// bucket with the partial-payment metrics the row + bottom sheet
  /// need (paid / expected / remaining / progress%). Per-cycle expected
  /// share is read off the matching `ContributionMember` row when one
  /// exists; otherwise we fall back to the contribution's regular_amount
  /// (ROSCA) or the configured target amount divided by member count
  /// (one-time). Falling back conservatively rather than throwing means
  /// even a payer who's no longer a member still renders cleanly.
  List<_UserPaymentGroup> _groupPaymentsByUser(
      List<ContributionPayment> payments, Contribution contribution) {
    final memberByUser = <String, ContributionMember>{
      for (final m in contribution.members) m.userId: m,
    };

    // Seed with EVERY active member, then fold the payments in.
    //
    // This was keyed off payment rows alone, so the Payments tab only listed
    // people who had already attempted one — a member who hasn't paid was
    // simply absent, which reads as "not part of this goal" rather than "owes
    // their share". The tab is a per-member ledger, so everyone belongs on it;
    // a payer who has since left the contribution still gets a row because the
    // payments loop below adds any user id the members map doesn't have.
    final byUser = <String, List<ContributionPayment>>{};
    for (final m in contribution.members) {
      if (m.userId.isEmpty) continue;
      if (m.membershipStatus == ContributionMembershipStatus.declined) continue;
      byUser.putIfAbsent(m.userId, () => []);
    }
    for (final p in payments) {
      byUser.putIfAbsent(p.userId, () => []).add(p);
    }

    final out = <_UserPaymentGroup>[];
    byUser.forEach((userId, list) {
      list.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

      double totalPaid = 0;
      double totalInFlight = 0;
      double totalRefunded = 0;
      for (final p in list) {
        switch (p.status) {
          case PaymentStatus.completed:
            totalPaid += p.amount;
            break;
          case PaymentStatus.pending:
          case PaymentStatus.processing:
          case PaymentStatus.awaitingVerification:
            totalInFlight += p.amount;
            break;
          case PaymentStatus.refunded:
          case PaymentStatus.refunding:
            totalRefunded += p.amount;
            break;
          default:
            break;
        }
      }

      final member = memberByUser[userId];
      final expected = _expectedShareFor(contribution, member);
      final remaining = (expected - totalPaid).clamp(0.0, double.infinity);
      // `list` can now be empty — members are seeded before payments are
      // folded in — so nothing here may assume a first element.
      final latest = list.isNotEmpty ? list.first : null;
      // Only settled money sets "last paid". A failed attempt used to supply
      // this date, producing "Last paid <date>" beside a ₦0 total.
      final lastSettled =
          list.where((p) => p.status == PaymentStatus.completed).firstOrNull;

      out.add(_UserPaymentGroup(
        userId: userId,
        userName: (latest?.userName.isNotEmpty ?? false)
            ? latest!.userName
            : (member?.userName ?? ''),
        member: member,
        payments: list,
        totalPaid: totalPaid,
        totalInFlight: totalInFlight,
        totalRefunded: totalRefunded,
        expectedAmount: expected,
        remaining: remaining,
        latestPaymentDate: lastSettled?.paymentDate,
        currency: latest?.currency ?? contribution.currency,
      ));
    });
    return out;
  }

  /// Per-user expected share. ROSCA: the configured regular_amount per
  /// cycle. One-time / ad-hoc: target_amount split evenly across
  /// active members — best effort, since the precise allocation rule
  /// is configured server-side and may not be plumbed through.
  double _expectedShareFor(
      Contribution contribution, ContributionMember? member) {
    if (member != null && member.expectedAmount > 0) {
      return member.expectedAmount;
    }
    if (contribution.type == ContributionType.rotatingSavings &&
        contribution.regularAmount != null &&
        contribution.regularAmount! > 0) {
      return contribution.regularAmount!;
    }
    final activeCount = contribution.members
        .where((m) =>
            m.membershipStatus != ContributionMembershipStatus.declined &&
            m.membershipStatus != ContributionMembershipStatus.pendingInvite)
        .length;
    if (activeCount > 0 && contribution.targetAmount > 0) {
      return contribution.targetAmount / activeCount;
    }
    return 0;
  }

  Future<void> _refreshPayments() async {
    // Both halves, always.
    //
    // This reloaded only the payments LIST, but the header — raised,
    // contributors, progress, the per-cycle pot — is read off
    // _currentContribution, which is replaced only when the cubit emits
    // GroupAccountGroupLoaded. So after a payment the list said "2 payments,
    // NGN 200" while the card above it still said "NGN 100 · 1 contributor ·
    // 10%", and the two disagreed until the screen was left and reopened.
    // force: the point of a refresh is to re-read something already held.
    // The header updates when GroupAccountGroupLoaded lands.
    _loadContributionDetails(force: true);
    await _loadLocalPayments();
  }

  Widget _buildMembersTab(Contribution contribution) {
    // Group payments by user
    final userPayments = <String, List<ContributionPayment>>{};

    // Merge local + static payments without the previous O(n²) `any()` scan
    // by indexing seen IDs and transaction IDs in two sets.
    final seenIds = <String>{};
    final seenTxIds = <String>{};
    final allPayments = <ContributionPayment>[];
    for (final p in _localPayments) {
      seenIds.add(p.id);
      if (p.transactionId != null) seenTxIds.add(p.transactionId!);
      allPayments.add(p);
    }
    for (final staticPayment in contribution.payments) {
      if (seenIds.contains(staticPayment.id)) continue;
      if (staticPayment.transactionId != null &&
          seenTxIds.contains(staticPayment.transactionId)) {
        continue;
      }
      seenIds.add(staticPayment.id);
      if (staticPayment.transactionId != null) {
        seenTxIds.add(staticPayment.transactionId!);
      }
      allPayments.add(staticPayment);
    }

    // Only money that actually landed counts toward a member's contribution.
    //
    // This grouped EVERY payment row regardless of status, so a member whose
    // payment failed was shown as "1 payment · NGN 100.00" while the pot header
    // correctly read NGN 0 raised / 0 contributors — the roster claimed someone
    // had paid when they hadn't, and the two numbers on the same screen
    // contradicted each other. Terminal-failed and in-flight rows are excluded;
    // the Payments tab is where attempts and their states belong.
    for (final payment in allPayments) {
      if (payment.status != PaymentStatus.completed) continue;
      userPayments.putIfAbsent(payment.userId, () => []).add(payment);
    }

    // Get all contribution members (assigned members). Declined
    // shadow rows are kept server-side for audit but hidden from the
    // default roster view — re-adding the user via the add-members
    // sheet auto-clears the declined shadow first (cubit pre-clears
    // before AddMembersToContribution), so a fresh invite re-issues
    // cleanly without the user noticing the prior decline.
    final contributionMembers = contribution.members
        .where(
            (m) => m.membershipStatus != ContributionMembershipStatus.declined)
        .toList();
    final hasMembers =
        contributionMembers.isNotEmpty || userPayments.isNotEmpty;

    // Count the two states apart.
    //
    // This line said "2 members assigned" while the Start tile two inches
    // above said "Needs 1 more member", and both were reading the same list:
    // one counted every row, the other counted only those who had accepted.
    // A pending_invite row is a person who has been asked, not a person who
    // is in, so it is reported as an invite — which is also the thing the
    // creator can act on.
    final acceptedCount =
        contributionMembers.where((m) => m.isActiveParticipant).length;
    final pendingInviteCount =
        contributionMembers.where((m) => m.isPendingInvite).length;
    final rosterSubtitle = pendingInviteCount == 0
        ? '$acceptedCount member${acceptedCount == 1 ? '' : 's'}'
        : '$acceptedCount member${acceptedCount == 1 ? '' : 's'} · '
            '$pendingInviteCount invite${pendingInviteCount == 1 ? '' : 's'} pending';

    // ContributionMember doesn't carry user_username — that field
    // lives on GroupMember. Pull the parent group's roster from the
    // cubit's cached snapshot so the member card / detail sheet can
    // show "@handle" without a per-row gRPC roundtrip.
    final cubit = context.read<GroupAccountCubit>();
    final groupMembers = (cubit.lastLoadedGroup?.id == contribution.groupId
            ? cubit.lastLoadedMembers
            : null) ??
        const <GroupMember>[];
    final usernameByUserId = <String, String>{
      for (final gm in groupMembers)
        if (gm.userUsername != null && gm.userUsername!.isNotEmpty)
          gm.userId: gm.userUsername!,
    };

    return RefreshIndicator(
      onRefresh: _refreshPayments,
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        children: [
          // Members header with add button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contribution Members',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      hasMembers
                          ? rosterSubtitle
                          : 'Add group members to track their contributions',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              // Hidden once an esusu has started: its roster is frozen and the
              // server refuses the add. A visible button that always fails is
              // worse than no button — the creator taps it, picks people, and
              // only then learns it was never possible.
              //
              // AND hidden from anyone who cannot actually add.
              // group-accounts gates AddMembersToContribution behind
              // assertCanManageContribution(ActionEditContribution), which
              // admits group admins/moderators and the contribution's own
              // creator — nobody else. The button was shown to every member
              // regardless, so a plain member could open the sheet, search,
              // pick people and only then be refused. Same predicate as the
              // server, evaluated before the tap.
              if ((!contribution.isRotatingSavings ||
                      contribution.awaitingOpen) &&
                  _canManageThisContribution(contribution))
                ElevatedButton.icon(
                  onPressed: () => _showAddMembersDialog(contribution),
                  icon: Icon(Icons.person_add_alt_1, size: 18.sp),
                  label: Text(
                    'Add',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                  ),
                )
              else
                // Says WHY it is gone. Without this the control simply vanishes
                // after the esusu starts, which reads as a bug.
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline,
                        size: 14.sp, color: const Color(0xFF9CA3AF)),
                    SizedBox(width: 6.w),
                    Text(
                      'Members fixed',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          SizedBox(height: 20.h),

          // Members list or empty state
          if (!hasMembers)
            _buildEmptyMembersInline()
          else
            ...List.generate(
              contributionMembers.length +
                  userPayments.entries
                      .where((e) =>
                          !contributionMembers.any((m) => m.userId == e.key))
                      .length,
              (index) {
                // Show assigned members first
                if (index < contributionMembers.length) {
                  final member = contributionMembers[index];
                  final payments = userPayments[member.userId] ?? [];
                  final totalPaid =
                      payments.fold<double>(0, (sum, p) => sum + p.amount);

                  return _buildMemberCard(
                    userName: member.userName,
                    email: member.email,
                    username: usernameByUserId[member.userId],
                    profileImage: member.profileImage,
                    totalPaid: totalPaid,
                    expectedAmount: member.expectedAmount,
                    paymentCount: payments.length,
                    currency: contribution.currency,
                    hasPaidCurrentCycle: member.hasPaidCurrentCycle,
                    member: member,
                    joinedAt: member.joinedAt,
                    memberPayments: payments,
                    // Only meaningful for a rotation: a one-time goal pays a
                    // named beneficiary once, so "next" is not a turn.
                    isNextReceiver: contribution.isRotatingSavings &&
                        contribution.currentPayoutRecipient != null &&
                        contribution.currentPayoutRecipient == member.userId,
                  );
                }

                // Show payers who aren't assigned members
                final nonAssignedPayers = userPayments.entries
                    .where((e) =>
                        !contributionMembers.any((m) => m.userId == e.key))
                    .toList();
                final payerIndex = index - contributionMembers.length;
                if (payerIndex < nonAssignedPayers.length) {
                  final entry = nonAssignedPayers[payerIndex];
                  final payments = entry.value;
                  final totalAmount =
                      payments.fold<double>(0, (sum, p) => sum + p.amount);

                  return _buildMemberCard(
                    userName: payments.first.userName,
                    email: null,
                    username: usernameByUserId[entry.key],
                    profileImage: null,
                    totalPaid: totalAmount,
                    expectedAmount: contribution.targetAmount,
                    paymentCount: payments.length,
                    currency: contribution.currency,
                    hasPaidCurrentCycle: true,
                    memberPayments: payments,
                    joinedAt: payments.first.paymentDate,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyMembersInline() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 32.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Members Added',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap the Add button above to assign\ngroup members to this contribution',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey[500],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard({
    required String userName,
    String? email,
    String? username,
    String? profileImage,
    required double totalPaid,
    required double expectedAmount,
    required int paymentCount,
    required String currency,
    required bool hasPaidCurrentCycle,
    ContributionMember? member,
    DateTime? joinedAt,
    List<ContributionPayment> memberPayments = const [],

    /// Whose turn it is to collect the pot this cycle.
    ///
    /// In a rotation the single most useful fact about the roster is which of
    /// these people is about to be paid, and the list said nothing about it —
    /// you had to open the receiver sheet to find out, and the sheet only
    /// tells you once you are already changing it.
    bool isNextReceiver = false,
  }) {
    final displayName = userName.isNotEmpty
        ? userName
        : (username != null && username.isNotEmpty)
            ? '@$username'
            : (email != null && email.isNotEmpty
                ? email.split('@').first
                : 'Unknown User');
    final progressPercent = expectedAmount > 0
        ? (totalPaid / expectedAmount * 100).clamp(0.0, 100.0)
        : 0.0;
    // PREVIOUS BUG: `isPaid = totalPaid >= expectedAmount` was true
    // when expectedAmount==0 (a brand-new member with no expected
    // share computed yet) → "Fully Paid" badge on someone who's never
    // paid anything. Require an actual non-zero expected share before
    // declaring paid.
    final isPaid = expectedAmount > 0 && totalPaid >= expectedAmount;
    // For users who literally haven't paid, suppress the optimistic
    // "current cycle paid" tag too — that flag comes from the
    // contribution_members.has_paid_current_cycle column which can
    // legitimately be true when expected is later set, but if
    // totalPaid == 0 we know nothing has actually moved.
    final showCurrentCycle = hasPaidCurrentCycle && totalPaid > 0;
    // Pending invite shadow rows: show "Invite Sent" instead of any
    // paid/current pill, since payment progress is meaningless until
    // the invite is accepted.
    final isPendingInvite = member?.isPendingInvite ?? false;

    return GestureDetector(
      onTap: () => _showMemberDetails(
        userName: userName,
        email: email,
        username: username,
        profileImage: profileImage,
        totalPaid: totalPaid,
        expectedAmount: expectedAmount,
        paymentCount: paymentCount,
        currency: currency,
        hasPaidCurrentCycle: showCurrentCycle,
        joinedAt: joinedAt ?? member?.joinedAt ?? DateTime.now(),
        member: member,
        memberPayments: memberPayments,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              backgroundImage:
                  profileImage != null ? NetworkImage(profileImage) : null,
              child: profileImage == null
                  ? Text(
                      displayName.isNotEmpty
                          ? displayName[0].toUpperCase()
                          : 'U',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          displayName,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isNextReceiver) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                                color: const Color(0xFF10B981)
                                    .withValues(alpha: 0.45)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.redeem_rounded,
                                  size: 10.sp, color: const Color(0xFF10B981)),
                              SizedBox(width: 3.w),
                              Text(
                                'Next payout',
                                style: GoogleFonts.inter(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (isPendingInvite) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFB923C).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mail_outline,
                                  size: 10.sp, color: const Color(0xFFFB923C)),
                              SizedBox(width: 3.w),
                              Text(
                                'Invite Sent',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFB923C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else if ((member?.missedCycles ?? 0) > 0) ...[
                        // CYCLES BEHIND. This number existed and was shown
                        // NOWHERE.
                        //
                        // missed_cycles is incremented server-side every time a
                        // cycle closes with the member unpaid, and until now it
                        // drove exactly one thing: the ordering of the payout
                        // receiver picker. Nobody could see it. A member could
                        // be three cycles behind and the roster showed the same
                        // row as everyone else, so the arrears that decide who
                        // may collect the pot were invisible to the people they
                        // apply to.
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFEF4444).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.history_toggle_off,
                                  size: 10.sp, color: const Color(0xFFEF4444)),
                              SizedBox(width: 3.w),
                              Text(
                                member!.missedCycles == 1
                                    ? '1 cycle behind'
                                    : '${member.missedCycles} cycles behind',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFEF4444),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else if (isPaid) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Paid',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ] else if (showCurrentCycle) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF3B82F6).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Current',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3B82F6),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Username + email row. Both optional — render
                  // whichever the backend gave us, separated by a dot
                  // when both are present so the row doesn't go double-
                  // height for users with full profiles.
                  if ((username != null && username.isNotEmpty) ||
                      (email != null && email.isNotEmpty))
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        [
                          if (username != null && username.isNotEmpty)
                            '@$username',
                          if (email != null && email.isNotEmpty) email,
                        ].join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  SizedBox(height: 2.h),
                  Text(
                    '$paymentCount payment${paymentCount == 1 ? '' : 's'}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$currency ${totalPaid.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${progressPercent.toStringAsFixed(1)}%',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: isPaid
                        ? const Color(0xFF10B981)
                        : const Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showMemberDetails({
    required String userName,
    String? email,
    String? username,
    String? profileImage,
    required double totalPaid,
    required double expectedAmount,
    required int paymentCount,
    required String currency,
    required bool hasPaidCurrentCycle,
    required DateTime joinedAt,
    ContributionMember? member,
    List<ContributionPayment> memberPayments = const [],
  }) {
    HapticFeedback.lightImpact();
    final cubit = context.read<GroupAccountCubit>();
    final myUserId = cubit.currentUserId;
    // Admin recompute. Mirrors _buildContributionDetailsView's gate.
    final c = _currentContribution;
    final isCreator = c != null && myUserId != null && c.createdBy == myUserId;
    final group = cubit.lastLoadedGroup;
    final isGroupAdmin = c != null &&
        myUserId != null &&
        group != null &&
        group.id == c.groupId &&
        (group.adminId == myUserId ||
            group.members.any((m) =>
                m.userId == myUserId && m.role == GroupMemberRole.admin));
    final isAdmin = isCreator || isGroupAdmin;
    final isSelf =
        member != null && myUserId != null && member.userId == myUserId;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => _ContributionMemberDetailsSheet(
        userName: userName,
        email: email,
        username: username,
        profileImage: profileImage,
        totalPaid: totalPaid,
        expectedAmount: expectedAmount,
        paymentCount: paymentCount,
        currency: currency,
        hasPaidCurrentCycle: hasPaidCurrentCycle,
        joinedAt: joinedAt,
        member: member,
        memberPayments: memberPayments,
        // Tap on a breakdown row pops this sheet first, then opens
        // the per-attempt details sheet so the back-stack stays
        // single-modal — pushing on top of an open bottom sheet
        // tends to misrender on Android.
        onPaymentTap: (p) {
          Navigator.of(sheetCtx).pop();
          _showPaymentDetails(p);
        },
        // Show "Remove" when the caller is admin AND it's not their
        // own row — admin doesn't remove themselves through this
        // flow, that's the Leave button.
        canRemove: isAdmin && !isSelf && member != null && c != null,
        // Show "Leave" only on the caller's own row.
        canLeave: isSelf && member != null && c != null,
        onRemove: () {
          Navigator.of(sheetCtx).pop();
          if (member != null && c != null) {
            _confirmRemoveContributionMember(member, c);
          }
        },
        onLeave: () {
          Navigator.of(sheetCtx).pop();
          if (c != null && myUserId != null) {
            _confirmLeaveContribution(c, myUserId);
          }
        },
      ),
    );
  }

  // Both _confirmRemoveContributionMember (admin removes someone)
  // and _confirmLeaveContribution (member leaves themselves) hand
  // off to ExitContributionBottomSheet, which handles the
  // PreviewMemberExit → confirmation → RemoveMember flow with the
  // refund / forfeit breakdown surfaced inline. The previous
  // AlertDialog stub didn't show the user any of the saga's
  // disposition before they hit Remove / Leave.
  void _confirmRemoveContributionMember(
      ContributionMember member, Contribution contribution) {
    ExitContributionBottomSheet.show(
      context,
      contributionId: contribution.id,
      groupId: contribution.groupId,
      memberUserId: member.userId,
      memberDisplayName:
          member.userName.isNotEmpty ? member.userName : 'this member',
      actorIsSelf: false,
    );
  }

  void _confirmLeaveContribution(Contribution contribution, String myUserId) {
    final myMember = contribution.members
        .where((m) => m.userId == myUserId)
        .map<ContributionMember?>((m) => m)
        .firstWhere((m) => true, orElse: () => null);
    ExitContributionBottomSheet.show(
      context,
      contributionId: contribution.id,
      groupId: contribution.groupId,
      memberUserId: myUserId,
      memberDisplayName: myMember?.userName ?? 'You',
      actorIsSelf: true,
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPayments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payment_outlined,
            size: 64.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No Payments Yet',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Be the first to contribute to this goal',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDaysRemaining(DateTime deadline) {
    // Compare in UTC against the deadline's UTC instant so a user
    // in UTC+1 doesn't see "1 day" while a UTC+0 user sees "0 days"
    // for the same moment. The deadline column is timestamptz; when
    // it round-trips through Dart it's already in local time on the
    // device, so we normalise both sides to UTC before subtracting.
    final now = DateTime.now().toUtc();
    final difference = deadline.toUtc().difference(now);

    if (difference.isNegative) {
      final overdueDays = (-difference.inDays);
      return overdueDays == 0
          ? 'Overdue'
          : 'Overdue by $overdueDays day${overdueDays == 1 ? '' : 's'}';
    } else if (difference.inDays == 0) {
      return 'Due today';
    } else {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'}';
    }
  }

  /// Returns the contribution's completed payments deduplicated against
  /// the local just-made buffer. Used by both the Overview-tab Average
  /// Payment and any future stat that must agree with what the
  /// Payments tab actually shows.
  List<ContributionPayment> _completedPaymentsFor(Contribution contribution) {
    final all = <ContributionPayment>[];
    final seenIds = <String>{};
    final seenTxIds = <String>{};
    for (final p in _localPayments) {
      if (seenIds.add(p.id)) {
        if (p.transactionId != null) seenTxIds.add(p.transactionId!);
        all.add(p);
      }
    }
    for (final p in contribution.payments) {
      if (seenIds.contains(p.id)) continue;
      if (p.transactionId != null && seenTxIds.contains(p.transactionId!)) {
        continue;
      }
      all.add(p);
    }
    return all
        .where((p) => p.status == PaymentStatus.completed)
        .toList(growable: false);
  }

  void _handleMenuAction(String action, Contribution contribution) {
    switch (action) {
      case 'share':
        // Native share sheet directly — no custom in-app sheet wrapper.
        // The user explicitly preferred system share UX so social/messenger
        // intents show as on-platform expected. WhatsApp / Telegram group
        // links are surfaced separately on the contribution details body
        // (creator section), so we don't need bespoke buttons here.
        SharePlus.instance.share(ShareParams(
          // iOS: a non-zero popover anchor is required — CGRectZero throws
          // PlatformException and the share silently fails on iPhone/iPad.
          sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
          text: _buildShareText(contribution),
          subject: contribution.title,
        ));
        break;
      case 'cycles':
        _showChangeCyclesDialog(contribution);
        break;
      case 'change_receiver':
        _showChangeReceiverFlow(contribution);
        break;
      case 'edit':
        // Reuse the existing EditContributionScreen. Returning from
        // the screen lands back here; the cubit's contribution state
        // refresh (triggered inside Edit's save flow) updates the
        // BlocBuilder in this view automatically.
        //
        // GetX `Get.to` pushes a new MaterialPageRoute on its OWN
        // Navigator stack, which doesn't inherit the BlocProvider
        // ancestors of THIS screen. Without `BlocProvider.value` the
        // edit screen's `context.read<GroupAccountCubit>()` would
        // throw a "ProviderNotFoundException: Could not find the
        // correct Provider<GroupAccountCubit>" — the bug user just
        // reported. Capture the cubit here and re-provide it on the
        // new route so the same singleton instance is reachable.
        final cubit = context.read<GroupAccountCubit>();
        Get.to(
          () => BlocProvider<GroupAccountCubit>.value(
            value: cubit,
            child: EditContributionScreen(contribution: contribution),
          ),
        );
        break;
      case 'transcript':
        _openTranscriptSheet(contribution);
        break;
      case 'history':
        // Wrap with BlocProvider.value so the cycles screen and any
        // bottom sheets it opens read the same GroupAccountCubit
        // instance (cycle list + per-cycle details RPCs).
        final histCubit = context.read<GroupAccountCubit>();
        Get.to(
          () => BlocProvider<GroupAccountCubit>.value(
            value: histCubit,
            child: ContributionCyclesHistoryScreen(contribution: contribution),
          ),
        );
        break;
      case 'exit_contribution':
        final myUserId = context.read<GroupAccountCubit>().currentUserId;
        if (myUserId != null) {
          // The same sheet the Members tab uses, with actorIsSelf: it
          // previews the refund / forfeit the saga will actually perform
          // before anything is confirmed.
          _confirmLeaveContribution(contribution, myUserId);
        }
        break;
    }
  }

  String _buildShareText(Contribution contribution) {
    final raised =
        '${contribution.currency} ${_fmtAmount(contribution.amountRaised)}';
    final target =
        '${contribution.currency} ${_fmtAmount(contribution.targetAmount)}';
    final deadline = DateFormat('MMM dd, yyyy').format(contribution.deadline);
    return [
      contribution.title,
      contribution.description,
      '',
      'Raised: $raised  /  Target: $target',
      'Deadline: $deadline',
    ].join('\n');
  }

  // ---------------------------------------------------------------
  // Transcript sheet — calls the cubit, shows a loading dialog while
  // it waits, then opens a styled bottom sheet with the transcript:
  // payments list, total raised, per-member breakdown. "Copy summary"
  // builds a paste-friendly text version.
  // ---------------------------------------------------------------
  void _openTranscriptSheet(Contribution contribution) {
    // Cancel any prior in-flight transcript request before starting a
    // new one — covers the rare double-tap race where the user opens the
    // 3-dots menu twice in quick succession.
    _transcriptSub?.cancel();
    _transcriptSub = null;

    final cubit = context.read<GroupAccountCubit>();

    // Loading overlay until the cubit emits a transcript-or-error
    // state.
    //
    // useRootNavigator: false is critical: when an error fires the
    // dialog must pop ONLY itself, not unwind to whatever route is
    // sitting at the root navigator (which under some launch flows
    // is the onboarding screen). Keeping the dialog scoped to the
    // local Navigator means cancel/back always returns to this
    // contribution screen.
    //
    // barrierDismissible: true lets the user cancel the request by
    // tapping outside the spinner or pressing back; the listener
    // detects the cancellation via a flag and bails out.
    final dialogNav = Navigator.of(context, rootNavigator: false);
    var userCancelled = false;
    showDialog(
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      builder: (_) => const PopScope(
        canPop: true,
        child: Center(
          child: LazerVaultLoader.small(),
        ),
      ),
    ).then((_) {
      // showDialog completes when the dialog is dismissed (either by
      // our explicit pop in the success/error branches, or by the user
      // tapping outside / hitting back). If the subscription is still
      // alive at this point, we got here BEFORE the cubit emitted —
      // i.e. the user cancelled, so flag the listener to drop the
      // late result.
      if (_transcriptSub != null) {
        userCancelled = true;
        _transcriptSub?.cancel();
        _transcriptSub = null;
      }
    });

    var dialogClosed = false;
    void closeDialogIfOpen() {
      if (dialogClosed) return;
      if (dialogNav.canPop()) dialogNav.pop();
      dialogClosed = true;
    }

    _transcriptSub = cubit.stream.listen((state) {
      // If the screen has been popped or the user dismissed the loader,
      // drop the result on the floor — no setState, no sheet on a
      // missing context.
      if (!mounted || userCancelled) {
        return;
      }
      if (state is GroupAccountTranscriptGenerated) {
        _transcriptSub?.cancel();
        _transcriptSub = null;
        closeDialogIfOpen();
        _showTranscriptDialog(state.transcript, contribution);
      } else if (state is GroupAccountError) {
        _transcriptSub?.cancel();
        _transcriptSub = null;
        closeDialogIfOpen();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transcript failed: ${state.message}'),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
          ),
        );
      }
    });

    cubit.generateTranscriptForContribution(contribution.id);
  }

  void _showTranscriptDialog(
      ContributionTranscript transcript, Contribution contribution) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      // Scope the sheet to the local Navigator so dismissal returns to
      // THIS contribution screen, not whatever sits at the root navigator
      // (which under deep-link / onboarding-resume flows can be the
      // onboarding page).
      useRootNavigator: false,
      builder: (sheetCtx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transcript',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                contribution.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    color: Colors.grey[400], fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy_outlined,
                              color: Colors.white, size: 20.sp),
                          tooltip: 'Copy summary',
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(
                              text: _buildTranscriptText(
                                  transcript, contribution),
                            ));
                            if (!sheetCtx.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Transcript copied'),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r)),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.ios_share,
                              color: Colors.white, size: 20.sp),
                          tooltip: 'Share transcript',
                          onPressed: () {
                            SharePlus.instance.share(ShareParams(
                              // iOS: a non-zero popover anchor is required — CGRectZero throws
                              // PlatformException and the share silently fails on iPhone/iPad.
                              sharePositionOrigin:
                                  const Rect.fromLTWH(0, 0, 1, 1),
                              text: _buildTranscriptText(
                                  transcript, contribution),
                              subject: 'Transcript ${contribution.title}',
                            ));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              const Divider(color: Color(0xFF2D2D2D), height: 1),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
                  children: [
                    _transcriptKv(
                        'Generated',
                        DateFormat('MMM dd, yyyy · HH:mm')
                            .format(transcript.generatedAt)),
                    _transcriptKv('Total raised',
                        '${transcript.currency} ${_fmtAmount(transcript.totalAmount)}'),
                    _transcriptKv('Payments', '${transcript.payments.length}'),
                    SizedBox(height: 16.h),
                    Text(
                      'Per-member breakdown',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (transcript.memberContributions.isEmpty)
                      Text('No member breakdown available.',
                          style: GoogleFonts.inter(
                              color: Colors.grey[500], fontSize: 12.sp))
                    else
                      ...transcript.memberContributions.entries.map((e) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          margin: EdgeInsets.only(bottom: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0A0A),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: const Color(0xFF2D2D2D)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.key,
                                  style: GoogleFonts.inter(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                              ),
                              Text(
                                '${transcript.currency} ${_fmtAmount(e.value)}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    SizedBox(height: 16.h),
                    Text(
                      'Payments',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (transcript.payments.isEmpty)
                      Text('No payments yet.',
                          style: GoogleFonts.inter(
                              color: Colors.grey[500], fontSize: 12.sp))
                    else
                      ...transcript.payments.map((p) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          margin: EdgeInsets.only(bottom: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0A0A),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: const Color(0xFF2D2D2D)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.userName.isNotEmpty
                                          ? p.userName
                                          : 'Unknown',
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13.sp),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      DateFormat('MMM dd, yyyy · HH:mm')
                                          .format(p.paymentDate),
                                      style: GoogleFonts.inter(
                                          color: Colors.grey[500],
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${p.currency} ${_fmtAmount(p.amount)}',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transcriptKv(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  GoogleFonts.inter(color: Colors.grey[400], fontSize: 12.sp)),
          Text(value,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _buildTranscriptText(
      ContributionTranscript transcript, Contribution contribution) {
    final lines = <String>[
      'Transcript: ${contribution.title}',
      'Generated: ${DateFormat('yyyy-MM-dd HH:mm').format(transcript.generatedAt)}',
      'Total raised: ${transcript.currency} ${_fmtAmount(transcript.totalAmount)}',
      'Payments: ${transcript.payments.length}',
      '',
      'Per-member breakdown:',
    ];
    if (transcript.memberContributions.isEmpty) {
      lines.add('  (none)');
    } else {
      for (final e in transcript.memberContributions.entries) {
        lines.add('  ${e.key}: ${transcript.currency} ${_fmtAmount(e.value)}');
      }
    }
    lines.addAll(['', 'Payments:']);
    if (transcript.payments.isEmpty) {
      lines.add('  (none)');
    } else {
      for (final p in transcript.payments) {
        final who = p.userName.isNotEmpty ? p.userName : 'Unknown';
        final when = DateFormat('yyyy-MM-dd').format(p.paymentDate);
        lines.add('  $when · $who · ${p.currency} ${_fmtAmount(p.amount)}');
      }
    }
    return lines.join('\n');
  }

  // Decides whether to render the Contribute FAB.
  //
  // Previously gated solely on
  // `GroupRolePermissions.canMember(_currentGroupMember, ...)`, which
  // depended on `_currentGroupMember` having been resolved via a
  // recent GroupAccountGroupLoaded emit. Users who landed here from
  // a deep link / back-navigation / cubit-shared snapshot ended up
  // with `_currentGroupMember == null` and an invisible CTA — the
  // bug user just reported.
  //
  // Loosened rule: show the FAB when the contribution is open AND
  // the caller is plausibly entitled to pay. Three independent
  // signals satisfy that:
  //   1. They're an active contribution member (per
  //      `contribution.members`).
  //   2. They're the contribution creator.
  //   3. They're a group admin (creator or role=admin) per the
  //      cubit's last-loaded group snapshot.
  //   4. They held the canonical canMember permission via
  //      `_currentGroupMember`.
  //
  // The server enforces real auth + group-membership at MakePayment
  // time, so a permissive client-side gate is safe — at worst a
  // stale UI shows a button that 401s on tap.
  bool _shouldShowContributeFab() {
    final c = _currentContribution;
    if (c == null || c.isCompleted) return false;
    // An esusu that has not been started has no cycle to pay into — the pot,
    // the schedule and the rotation are all decided at start. Offering
    // Contribute here produced a payment the server would refuse.
    if (c.awaitingOpen) return false;
    // ESUSU: nothing left to pay this cycle means no Contribute button.
    //
    // A rotation allocates each member a FIXED share per cycle — that is what
    // makes the pot (share x members) and the rotation fair. The server
    // enforces it (payments must equal regular_amount, or fall within the
    // remaining headroom when partials are allowed, and it refuses outright
    // once the cycle is settled), but the button was offered regardless, so
    // the only way to discover you had already paid was to go through the pay
    // screen and be refused at the end.
    //
    // One-time goals are deliberately NOT gated: there is no per-member share
    // there, people top up what they like, and that is the point of the type.
    if (c.isRotatingSavings && _myCycleShareIsSettled(c)) return false;
    if (GroupRolePermissions.canMember(
        _currentGroupMember, GroupAction.makeContribution)) {
      return true;
    }
    final cubit = context.read<GroupAccountCubit>();
    final myUserId = cubit.currentUserId;
    if (myUserId == null) return false;
    if (c.createdBy == myUserId) return true;
    if (c.members.any((m) => m.userId == myUserId)) return true;
    final group = cubit.lastLoadedGroup;
    // Guard: lastLoadedGroup may be a stale snapshot from a DIFFERENT
    // group the user just navigated away from. Only trust its role
    // metadata when its id matches the contribution's group_id —
    // otherwise we'd flash the Contribute FAB on a contribution the
    // user has no membership in.
    if (group != null && group.id == c.groupId) {
      if (group.adminId == myUserId) return true;
      if (group.members.any(
          (m) => m.userId == myUserId && m.role == GroupMemberRole.admin)) {
        return true;
      }
    }
    return false;
  }

  /// Whether THIS user has nothing left to pay into the current cycle.
  ///
  /// Mirrors the server's rule in payments.go so the two cannot disagree:
  ///   - partials off  -> the flag alone decides; a payment is all or nothing
  ///   - partials on   -> cumulative cycle_paid_amount has reached the share
  ///
  /// Unknown shape (no member row, no regular amount) answers FALSE: the
  /// server is the authority, and hiding the button on a guess would strand
  /// somebody who genuinely owes.
  bool _myCycleShareIsSettled(Contribution c) {
    final myUserId = context.read<GroupAccountCubit>().currentUserId;
    if (myUserId == null) return false;
    final me = c.members.where((m) => m.userId == myUserId).firstOrNull;
    if (me == null) return false;
    if (me.hasPaidCurrentCycle) return true;
    if (!c.allowPartialPayments) return false;
    final share = c.regularAmount ?? 0;
    if (share <= 0) return false;
    return me.cyclePaidAmount >= share;
  }

  void _navigateToMakePayment(Contribution contribution) {
    Get.toNamed(
      AppRoutes.makePayment,
      arguments: {
        'contributionId': contribution.id,
        'contribution': contribution,
      },
    );
  }

  /// Roles allowed to issue receipts or share full transaction details
  /// for the supplied payment. Admins/creators can always — they own
  /// the audit/operations flow. Otherwise, only the actual payer.
  /// Other members can VIEW the breakdown and per-attempt info, but
  /// not generate downstream artefacts (PDF receipt, social share)
  /// that mix in their own user identity with someone else's payment.
  bool _canIssueReceiptsFor(String payerUserId) {
    final cubit = context.read<GroupAccountCubit>();
    final currentUserId = cubit.currentUserId;
    if (currentUserId == null) return false;
    if (currentUserId == payerUserId) return true;
    final group = cubit.lastLoadedGroup;
    if (_currentContribution != null &&
        _currentContribution!.createdBy == currentUserId) {
      return true;
    }
    if (group != null &&
        group.id == _currentContribution?.groupId &&
        (group.adminId == currentUserId ||
            group.members.any((m) =>
                m.userId == currentUserId &&
                m.role == GroupMemberRole.admin))) {
      return true;
    }
    return false;
  }

  void _showPaymentGroupDetails(
      _UserPaymentGroup group, Contribution contribution) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1F1F1F).withValues(alpha: 0.95),
                  const Color(0xFF1F1F35).withValues(alpha: 0.98),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.all(24.w),
              children: [
                _buildPaymentGroupHeader(group),
                SizedBox(height: 16.h),
                _buildPaymentGroupProgress(group),
                SizedBox(height: 20.h),
                _buildPaymentDivider(),
                SizedBox(height: 16.h),
                Text(
                  'Payment breakdown',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Tap any payment to see its full transaction details.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 12.h),
                ...group.payments.map((p) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _PaymentBreakdownRow(
                        payment: p,
                        onTap: () => _showPaymentDetails(p),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentGroupHeader(_UserPaymentGroup group) {
    final formatter = NumberFormat('#,##0.##');
    final displayName =
        group.userName.isNotEmpty ? group.userName : 'Unknown User';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                '${group.currency} ${formatter.format(group.totalPaid)} paid'
                '${group.expectedAmount > 0 ? ' of ${group.currency} ${formatter.format(group.expectedAmount)}' : ''}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.close, color: Colors.white, size: 20.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentGroupProgress(_UserPaymentGroup group) {
    final formatter = NumberFormat('#,##0.##');
    final progress = (group.progressPercent / 100).clamp(0.0, 1.0);
    final accentColor = group.isComplete
        ? const Color(0xFF10B981)
        : group.isPartial
            ? const Color(0xFFFB923C)
            : const Color.fromARGB(255, 78, 3, 208);
    final stateLabel = group.isComplete
        ? 'Fully paid'
        : group.isPartial
            ? 'Partial — ${group.progressPercent.toStringAsFixed(0)}%'
            : group.isInFlightOnly
                ? 'Payment pending'
                : group.expectedAmount > 0
                    ? 'Not paid yet'
                    : 'Open contributions';
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accentColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  stateLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (group.expectedAmount > 0) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8.h,
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          Row(
            children: [
              _summaryStat(
                  'Paid',
                  '${group.currency} ${formatter.format(group.totalPaid)}',
                  Colors.white),
              _summaryStat(
                  'Remaining',
                  group.expectedAmount > 0
                      ? '${group.currency} ${formatter.format(group.remaining)}'
                      : '—',
                  group.remaining > 0 ? accentColor : const Color(0xFF10B981)),
              _summaryStat('Attempts', '${group.attemptCount}', Colors.white),
            ],
          ),
          if (group.totalInFlight > 0 || group.totalRefunded > 0) ...[
            SizedBox(height: 8.h),
            Wrap(
              spacing: 12.w,
              children: [
                if (group.totalInFlight > 0)
                  Text(
                    'Pending: ${group.currency} ${formatter.format(group.totalInFlight)}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                if (group.totalRefunded > 0)
                  Text(
                    'Refunded: ${group.currency} ${formatter.format(group.totalRefunded)}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _summaryStat(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey[400],
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDetails(ContributionPayment payment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1F1F1F).withValues(alpha: 0.95),
              const Color(0xFF1F1F35).withValues(alpha: 0.98),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaymentHeader(payment),
              SizedBox(height: 24.h),
              _buildPaymentDivider(),
              SizedBox(height: 24.h),
              _buildPaymentTransactionDetails(payment),
              SizedBox(height: 24.h),
              _buildPaymentDivider(),
              SizedBox(height: 24.h),
              _buildPaymentMethodInfo(payment),
              SizedBox(height: 24.h),
              _buildPaymentDivider(),
              SizedBox(height: 24.h),
              _buildPaymentAmountBreakdown(payment),
              SizedBox(height: 32.h),
              _buildPaymentActions(payment),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentHeader(ContributionPayment payment) {
    return Column(
      children: [
        // Close button and status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PAYMENT DETAILS',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getPaymentStatusColor(payment.status)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    payment.status.displayName.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: _getPaymentStatusColor(payment.status),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // Amount display
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 78, 3, 208),
                const Color.fromARGB(255, 78, 3, 208),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 78, 3, 208)
                    .withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Payment Amount',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${payment.currency} ${payment.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Paid by ${payment.userName.isNotEmpty ? payment.userName : 'Unknown User'}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDivider() {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTransactionDetails(ContributionPayment payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.receipt_long,
              color: const Color(0xFF4E03D0),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Transaction Details',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildEnhancedPaymentDetailRow(
          'Transaction ID',
          payment.transactionId ?? 'N/A',
          icon: Icons.fingerprint,
          copyable: payment.transactionId != null,
        ),
        _buildEnhancedPaymentDetailRow(
          'Date & Time',
          DateFormat('MMM dd, yyyy • HH:mm').format(payment.paymentDate),
          icon: Icons.schedule,
        ),
        _buildEnhancedPaymentDetailRow(
          'Payment Method',
          _getPaymentMethodName(payment),
          icon: _getPaymentMethodIcon(payment),
        ),
        if (payment.notes != null && payment.notes!.isNotEmpty)
          _buildEnhancedPaymentDetailRow(
            'Notes',
            payment.notes!,
            icon: Icons.note_alt,
            isMultiline: true,
          ),
      ],
    );
  }

  Widget _buildPaymentMethodInfo(ContributionPayment payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.payment,
              color: const Color(0xFF10B981),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Payment Information',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      _getPaymentMethodIcon(payment),
                      color: const Color(0xFF10B981),
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getPaymentMethodName(payment),
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _getPaymentMethodDescription(payment),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.verified,
                    color: const Color(0xFF10B981),
                    size: 16.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentAmountBreakdown(ContributionPayment payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: const Color(0xFFF59E0B),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Amount Breakdown',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildAmountRow('Contribution Amount',
                  '${payment.currency} ${payment.amount.toStringAsFixed(2)}'),
              SizedBox(height: 8.h),
              _buildAmountRow('Processing Fee', '${payment.currency} 0.00',
                  isSubtle: true),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              SizedBox(height: 12.h),
              _buildAmountRow(
                'Total Paid',
                '${payment.currency} ${payment.amount.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentActions(ContributionPayment payment) {
    // Receipts and share emit content tied to the *payer's* identity
    // (their name on the PDF, their wallet ref, their card brand).
    // Letting any group member generate those would be a privacy leak
    // — they could share another person's transaction trail. Gate to
    // admin / creator (operations / audit need this) and the actual
    // payer (their own data). Everyone else sees an explainer.
    final canIssue = _canIssueReceiptsFor(payment.userId);
    if (!canIssue) {
      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Icon(Icons.lock_outline, size: 18.sp, color: Colors.grey[400]),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                'Only the payer or a group admin can generate the receipt or share this transaction.',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _generateReceipt(payment),
            icon: Icon(Icons.receipt, size: 20.sp),
            label: Text(
              'Generate Receipt',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _sharePaymentDetails(payment),
            icon: Icon(Icons.share, size: 20.sp),
            label: Text(
              'Share Details',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _generateReceipt(ContributionPayment payment) async {
    try {
      // Close the bottom sheet first
      Navigator.pop(context);

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          // showDialog inserts no Material, and a Text without one inherits
          // Flutter's fallback debug style. The explicit style below overrides
          // the colour but NOT the decoration, so this rendered white text
          // under a yellow double underline.
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LazerVaultLoader.small(),
                  SizedBox(height: 16.h),
                  Text(
                    'Generating Receipt...',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Simulate receipt generation delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Close loading dialog
      if (mounted) Navigator.pop(context);

      // Navigate to receipt screen.
      //
      // cameFromPayment=false because this branch is the "Generate
      // Receipt" action on a PAST payment row (bottom sheet on the
      // payments tab), not the live payment flow. Back from the
      // receipt should pop the user back to the contribution
      // details where they tapped Generate, not unwind the entire
      // group-funds stack.
      if (mounted && _currentContribution != null) {
        Get.to(
          () => ContributionPaymentConfirmationScreen(
            contribution: _currentContribution!,
            payment: payment,
            paymentMethod: _getPaymentMethodName(payment),
            cameFromPayment: false,
          ),
        );
      }

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Receipt generated successfully!'),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if still open
      if (mounted) Navigator.pop(context);

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Failed to generate receipt'),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _sharePaymentDetails(ContributionPayment payment) async {
    try {
      // Generate shareable text
      final shareText = _generateShareText(payment);

      // Use HapticFeedback for better UX
      HapticFeedback.lightImpact();

      // Close the bottom sheet first
      Navigator.pop(context);

      // Share the payment details
      await SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
        text: shareText,
        subject:
            'Payment Receipt for ${_currentContribution?.title ?? 'Contribution'}',
      ));

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.share, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Payment details shared successfully!'),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Failed to share payment details'),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _generateShareText(ContributionPayment payment) {
    final contribution = _currentContribution;
    final paymentMethod = _getPaymentMethodName(payment);

    return '''
🎉 PAYMENT RECEIPT 🎉

💰 Amount: ${payment.currency} ${payment.amount.toStringAsFixed(2)}
📋 Contribution: ${contribution?.title ?? 'N/A'}
👤 Paid by: ${payment.userName.isNotEmpty ? payment.userName : 'Unknown User'}
📅 Date: ${DateFormat('MMM dd, yyyy • HH:mm').format(payment.paymentDate)}
💳 Method: $paymentMethod
🆔 Transaction ID: ${payment.transactionId ?? 'N/A'}
✅ Status: ${payment.status.displayName}

${payment.notes?.isNotEmpty == true ? '📝 Notes: ${payment.notes}\n' : ''}
${contribution != null ? '''
📊 Contribution Progress:
• Target: ${contribution.currency} ${contribution.targetAmount.toStringAsFixed(2)}
• Raised: ${contribution.currency} ${(contribution.currentAmount + payment.amount).toStringAsFixed(2)}
• Progress: ${((contribution.currentAmount + payment.amount) / contribution.targetAmount * 100).clamp(0.0, 100.0).toStringAsFixed(1)}%
''' : ''}
Thank you for your contribution! 🙏

Powered by Lazervault 🚀
''';
  }

  Widget _buildEnhancedPaymentDetailRow(
    String label,
    String value, {
    IconData? icon,
    bool copyable = false,
    bool isMultiline = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16.sp,
              color: Colors.grey[400],
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (copyable) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => _copyToClipboard(value),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.copy,
                  size: 16.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount,
      {bool isSubtle = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isSubtle ? Colors.grey[500] : Colors.white,
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal
                ? const Color(0xFF10B981)
                : (isSubtle ? Colors.grey[500] : Colors.white),
          ),
        ),
      ],
    );
  }

  Color _getPaymentStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return const Color(0xFFF59E0B);
      case PaymentStatus.processing:
        return const Color(0xFF3B82F6);
      case PaymentStatus.awaitingVerification:
        return const Color(0xFFF59E0B);
      case PaymentStatus.completed:
        return const Color(0xFF10B981);
      case PaymentStatus.failed:
        return const Color(0xFFEF4444);
      case PaymentStatus.cancelled:
        return const Color(0xFF6B7280);
      case PaymentStatus.refunding:
        return const Color(0xFFF59E0B);
      case PaymentStatus.refunded:
        return const Color.fromARGB(255, 78, 3, 208);
      case PaymentStatus.manualReview:
        return const Color(0xFFEF4444);
    }
  }

  String _getPaymentMethodName(ContributionPayment payment) {
    // Extract from metadata or default
    final metadata = payment.metadata;
    if (metadata != null && metadata['paymentMethod'] != null) {
      final method = metadata['paymentMethod'] as String;
      switch (method.toLowerCase()) {
        case 'bank_transfer':
          return 'Bank Transfer';
        case 'card':
          return 'Credit/Debit Card';
        case 'mobile_money':
          return 'Mobile Money';
        case 'crypto':
          return 'Cryptocurrency';
        default:
          return 'Unknown Method';
      }
    }
    return 'Payment';
  }

  String _getPaymentMethodDescription(ContributionPayment payment) {
    final metadata = payment.metadata;
    if (metadata != null && metadata['paymentMethod'] != null) {
      final method = metadata['paymentMethod'] as String;
      switch (method.toLowerCase()) {
        case 'bank_transfer':
          return 'Direct bank transfer';
        case 'card':
          return 'Visa, Mastercard, etc.';
        case 'mobile_money':
          return 'MTN, Vodafone, AirtelTigo';
        case 'crypto':
          return 'Bitcoin, Ethereum, USDT';
        default:
          return 'Electronic payment';
      }
    }
    return 'Electronic payment';
  }

  IconData _getPaymentMethodIcon(ContributionPayment payment) {
    final metadata = payment.metadata;
    if (metadata != null && metadata['paymentMethod'] != null) {
      final method = metadata['paymentMethod'] as String;
      switch (method.toLowerCase()) {
        case 'bank_transfer':
          return Icons.account_balance;
        case 'card':
          return Icons.credit_card;
        case 'mobile_money':
          return Icons.phone_android;
        case 'crypto':
          return Icons.currency_bitcoin;
        default:
          return Icons.payment;
      }
    }
    return Icons.payment;
  }

  /// [onDone] runs after the sheet closes, once the refreshed roster has
  /// landed — used by the Start flow to continue straight into scheduling
  /// when adding the member satisfied the two-member minimum.
  void _showAddMembersDialog(Contribution contribution,
      {VoidCallback? onDone}) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<GroupAccountCubit>(),
        child: AddMembersToContributionDialog(
          contribution: contribution,
          onMembersAdded: () {
            _refreshPayments();
            // Also reload contribution details to update the members list
            context
                .read<GroupAccountCubit>()
                .loadContributionDetails(contribution.id);
          },
        ),
      ),
    ).then((_) async {
      if (onDone == null || !mounted) return;
      // Re-read before deciding: onMembersAdded fires the reload but does
      // not await it, so _currentContribution may still hold the pre-add
      // roster at the moment the sheet closes. _loadContributionDetails is
      // fire-and-forget, so give the cubit a frame to emit before reading
      // the roster back.
      _loadContributionDetails(force: true);
      await Future<void>.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      onDone();
    });
  }

  void _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      HapticFeedback.lightImpact();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 16.sp),
                SizedBox(width: 8.w),
                Text(
                  'Copied to clipboard',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 16.sp),
                SizedBox(width: 8.w),
                Text(
                  'Failed to copy',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }
}

/// Aggregates one user's payment activity for a contribution. Built
/// client-side from the flat ContributionPayment stream so we don't
/// need a new RPC just to render the per-user roll-up. Decisions like
/// "is this a partial?" are derived from the totals + the user's
/// expected share so the data class is the single source of truth for
/// the row, the bottom sheet, and the breakdown.
// _UserPaymentGroup / _PaymentGroupCard / _PaymentBreakdownRow used to
// live here as private classes. They've been promoted to public widgets
// in `widgets/payment_group_widgets.dart` so the past-contribution sheet
// can reuse exactly the same row treatment without duplicating ~400
// lines of styling. The aliases below keep this file's existing call
// sites compiling without churn — they delegate straight to the
// promoted versions.
typedef _UserPaymentGroupBase = UserPaymentGroup;

/// Change-cycles dialog for a rotating-savings contribution.
///
/// Mounted as an extension so the 4k-line screen does not grow another inline
/// builder. The bounds it enforces MIRROR the server's, so the user is told the
/// limit before submitting rather than after:
///
///   * at least the current cycle — otherwise the UI would render "cycle 4 of 2"
///   * at least the member count — appending members already widens
///     total_cycles back up with a GREATEST(), so a smaller value is silently
///     undone and the admin thinks the save failed
extension ChangeCyclesDialog on _ContributionDetailsScreenState {
  void _showChangeCyclesDialog(Contribution contribution) {
    final current = contribution.currentCycle ?? 1;
    final memberCount = contribution.members.length;
    // The floor is whichever constraint binds harder.
    final minAllowed = current > memberCount ? current : memberCount;
    final controller = TextEditingController(
      text: (contribution.totalCycles ?? minAllowed).toString(),
    );
    String? error;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text('Change cycles',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 17.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How many payout rounds this rotation runs for. Everyone in the '
                'rotation needs a turn, so it cannot be fewer than the number '
                'of members.',
                style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13.sp),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                onChanged: (_) {
                  if (error != null) setDialogState(() => error = null);
                },
                decoration: InputDecoration(
                  labelText: 'Cycles',
                  labelStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6)),
                  errorText: error,
                  helperText:
                      'Currently on cycle $current · $memberCount members',
                  helperStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 11.sp),
                  filled: true,
                  fillColor: const Color(0xFF141414),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel',
                  style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white),
              onPressed: () {
                final n = int.tryParse(controller.text.trim());
                if (n == null || n < 1) {
                  setDialogState(() => error = 'Enter a whole number');
                  return;
                }
                if (n < minAllowed) {
                  setDialogState(() => error = n < current
                      ? 'Already on cycle $current'
                      : 'At least $memberCount — one per member');
                  return;
                }
                if (n == contribution.totalCycles) {
                  Navigator.pop(dialogContext);
                  return;
                }
                Navigator.pop(dialogContext);
                context.read<GroupAccountCubit>().updateContributionDetails(
                      contribution.copyWith(totalCycles: n),
                    );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The contribution's state, as badges rather than one word.
///
/// It used to render a single label — Completed / Overdue / Active — which
/// could not say the two things that matter most at the end of a one-time
/// contribution: that it finished, and that the money has actually been paid
/// out. A screen reading "Completed" while separately showing "Overdue" and a
/// full target still "remaining" is telling the user three different stories.
///
/// Overdue is suppressed once the contribution is finished. A deadline that
/// passed after the goal was met is not a problem, and flagging it red says
/// something is wrong when nothing is.
class _ContributionStateBadges extends StatelessWidget {
  const _ContributionStateBadges({required this.contribution});

  final Contribution contribution;

  /// True when money has actually reached a recipient — a COMPLETED payout,
  /// not a scheduled or pending one. "Paid out" is a statement about money
  /// having moved, so a pending row must not claim it.
  bool get _paidOut => contribution.payoutHistory
      .any((p) => p.status == PayoutTransactionStatus.completed);

  @override
  Widget build(BuildContext context) {
    final badges = <_StateBadgeSpec>[];

    switch (contribution.status) {
      case ContributionStatus.completed:
        // A one-time goal closes on TIME now, not on reaching its target, so
        // "Completed" would claim it met a goal it may have fallen short of.
        // "Closed" states the fact; whether it got there is what Raised and
        // the progress bar already say.
        final metTarget = contribution.targetAmount <= 0 ||
            contribution.amountRaised >= contribution.targetAmount;
        if (contribution.type == ContributionType.oneTime && !metTarget) {
          badges.add(const _StateBadgeSpec('Closed', Color(0xFF9CA3AF)));
        } else {
          badges.add(const _StateBadgeSpec('Completed', Color(0xFF10B981)));
        }
        break;
      case ContributionStatus.cancelled:
        badges.add(const _StateBadgeSpec('Cancelled', Color(0xFF9CA3AF)));
        break;
      case ContributionStatus.paused:
        badges.add(const _StateBadgeSpec('Paused', Color(0xFFFB923C)));
        break;
      case ContributionStatus.active:
        // Checked before the active/overdue split: a circle that has not
        // started is not overdue and not yet running, and saying "Active"
        // about it contradicts the Start button right above.
        if (contribution.awaitingOpen) {
          badges.add(const _StateBadgeSpec('Not started', Color(0xFF9CA3AF)));
          break;
        }
        // Only an UNFINISHED contribution can be overdue.
        if (contribution.isOverdue) {
          badges.add(const _StateBadgeSpec('Overdue', Color(0xFFEF4444)));
        } else {
          badges.add(const _StateBadgeSpec('Active', Color(0xFF60A5FA)));
        }
        break;
    }

    if (_paidOut) {
      badges.add(const _StateBadgeSpec('Paid out', Color(0xFF8B5CF6)));
    }

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        for (final b in badges)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: b.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: b.color.withValues(alpha: 0.55)),
            ),
            child: Text(
              b.label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: b.color,
              ),
            ),
          ),
      ],
    );
  }
}

class _StateBadgeSpec {
  const _StateBadgeSpec(this.label, this.color);
  final String label;
  final Color color;
}
