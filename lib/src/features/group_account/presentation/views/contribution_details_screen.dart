import 'dart:async';

import 'package:flutter/material.dart';
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
import '../widgets/contribution_chat_bottom_sheet.dart';
import '../widgets/exit_contribution_bottom_sheet.dart';
import 'contribution_cycles_history_screen.dart';
import 'edit_contribution_screen.dart';
import 'past_contributions_screen.dart';
import '../widgets/payment_group_widgets.dart';

class ContributionDetailsScreen extends StatefulWidget {
  final String contributionId;
  final Contribution? contribution;

  const ContributionDetailsScreen({
    super.key,
    required this.contributionId,
    this.contribution,
  });

  @override
  State<ContributionDetailsScreen> createState() => _ContributionDetailsScreenState();
}

class _ContributionDetailsScreenState extends State<ContributionDetailsScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 3, vsync: this);
    _currentContribution = widget.contribution;
    _loadContributionDetails();
    _loadLocalPayments();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    _transcriptSub?.cancel();
    _transcriptSub = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      // Refresh payments when app resumes (e.g., returning from payment screen)
      _refreshPayments();
      // Also re-sync group state so pending-invite shadow rows get
      // promoted to active (or removed on decline/expire) without
      // requiring a manual pull-to-refresh.
      final groupId = _currentContribution?.groupId ?? widget.contribution?.groupId;
      if (groupId != null && groupId.isNotEmpty) {
        context.read<GroupAccountCubit>().loadGroupDetails(groupId);
      }
    }
  }

  Future<void> _loadLocalPayments() async {
    try {
      final payments = await context.read<GroupAccountCubit>().getContributionPayments.call(widget.contributionId);
      if (mounted) {
        setState(() {
          _localPayments = payments;
        });
      }
    } catch (_) {
      // Payments will remain empty on error
    }
  }

  void _loadContributionDetails() {
    // Load contribution details if not provided
    if (_currentContribution == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GroupAccountCubit>().loadContributionDetails(widget.contributionId);
      });
    }
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
              current is ContributionPaymentSuccess ||
              current is ContributionPaymentFailed ||
              current is GroupAccountError,
          listener: (context, state) {
            if (state is GroupAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is GroupAccountGroupLoaded) {
              // Update the current contribution from the loaded group data
              // This ensures statistics update after payment
              final updatedContribution = state.contributions
                  .where((c) => c.id == widget.contributionId)
                  .firstOrNull;
              final cubit = context.read<GroupAccountCubit>();
              final myUserId = cubit.currentUserId;
              final myMember = myUserId != null
                  ? state.members
                      .where((m) => m.userId == myUserId)
                      .firstOrNull
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              // Refresh payments list
              _loadLocalPayments();
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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
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
    // Get current user info for permission display
    final cubit = context.read<GroupAccountCubit>();
    final currentUserId = cubit.currentUserId;
    final isCreator = currentUserId != null && contribution.createdBy == currentUserId;
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
            group.members.any(
                (m) => m.userId == currentUserId && m.role == GroupMemberRole.admin));
    final isAdmin = isCreator || isGroupAdmin;

    return Column(
      children: [
        _buildHeader(contribution),
        _buildContributionSummary(contribution),
        // Payout receiver banner — surfaces the scheduled-payout state
        // (pending_receiver / ready / scheduled / in_flight / settled
        // / failed / exhausted) with the right CTA for the role. Only
        // admin/creator gets actionable buttons; members see read-only
        // status. The banner self-loads + polls in_flight states.
        PayoutReceiverBanner(
          contribution: contribution,
          cycleIndex: contribution.type == ContributionType.rotatingSavings
              ? (contribution.currentCycle ?? 1)
              : 0,
          isAdmin: isAdmin,
          // SCHEDULED state is rendered as a compact chip in the
          // status row below; the banner only owns the actionable /
          // exceptional states (pending, ready, in_flight, failed,
          // exhausted, settled).
          hideScheduled: true,
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
        _buildStatusChipsRow(contribution, isCreator, isMember, isAdmin),
        if (contribution.hasExternalLinks) _buildExternalLinksSection(contribution),
        SizedBox(height: 8.h),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(contribution),
              _buildPaymentsTab(contribution),
              _buildMembersTab(contribution),
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
        iconColor:
            hasPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
        label: 'Auto-debit',
        value: hasPaid ? 'Covered' : 'On',
        onTap: () => _showAutoDebitDialog(contribution, hasPaid: hasPaid),
      ));
    }
    if (showAutoPayout) {
      // The chip itself decides whether to render based on the live
      // payout-receiver status. We always include it in the layout
      // candidates; if backend says we're not in SCHEDULED, the chip
      // returns SizedBox.shrink() and the wrap collapses cleanly.
      chips.add(AutoPayoutScheduledChip(
        contribution: contribution,
        cycleIndex: contribution.type == ContributionType.rotatingSavings
            ? (contribution.currentCycle ?? 1)
            : 0,
        isAdmin: isAdmin,
        onReceiverChanged: _loadContributionDetails,
      ));
    }
    chips.add(roleChip);

    if (chips.length == 1) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
        child: chips.first,
      );
    }

    return Padding(
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
    );
  }

  String _roleLabel(bool isCreator, bool isMember) =>
      isCreator ? 'Creator' : isMember ? 'Member' : 'Viewer';

  Color _roleColor(bool isCreator, bool isMember) => isCreator
      ? const Color(0xFFEF4444)
      : isMember
          ? const Color(0xFF10B981)
          : const Color(0xFF3B82F6);

  IconData _roleIcon(bool isCreator, bool isMember) =>
      isCreator ? Icons.star : isMember ? Icons.person : Icons.visibility;

  void _showRoleDialog(Contribution contribution, bool isCreator, bool isMember) {
    final permissions = isCreator
        ? const ['Edit contribution', 'Add members', 'View all payments', 'Delete contribution']
        : isMember
            ? const ['Make payments', 'View payments', 'Download receipts']
            : const ['View contribution', 'Request to join'];
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
        primaryAction: !isMember && !isCreator
            ? _DialogAction(
                label: 'Request to join',
                onTap: () {
                  Navigator.of(dialogCtx, rootNavigator: false).pop();
                  _showJoinContributionDialog(contribution);
                },
              )
            : null,
      ),
    );
  }

  void _showAutoDebitDialog(Contribution contribution, {required bool hasPaid}) {
    final due = contribution.nextPaymentDate;
    final dueLabel = due != null
        ? DateFormat('MMM dd, yyyy').format(due)
        : 'the next cycle close';
    final amountLabel = contribution.regularAmount != null && contribution.regularAmount! > 0
        ? '${contribution.currency} ${_fmtAmount(contribution.regularAmount!)}'
        : null;

    final accent = hasPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C);
    final title = hasPaid ? 'You\'re covered' : 'Auto-debit is on';

    final body = hasPaid
        ? 'You\'ve already paid for this cycle, so no auto-charge will run for you.'
        : amountLabel != null
            ? 'If you don\'t pay $amountLabel manually before $dueLabel, we\'ll auto-debit it from your account.'
            : 'If you don\'t pay manually before $dueLabel, we\'ll auto-debit your account.';

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => _StatusDetailDialog(
        accent: accent,
        icon: hasPaid ? Icons.check_circle : Icons.bolt,
        title: title,
        sections: [
          _DialogSection(heading: 'How it works', body: body),
        ],
      ),
    );
  }

  void _showJoinContributionDialog(Contribution contribution) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Join Contribution',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Would you like to join "${contribution.title}"? This will add you as a contributing member.',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              final cubit = context.read<GroupAccountCubit>();
              final userId = cubit.currentUserId;
              if (userId != null && userId.isNotEmpty) {
                cubit.addMembersToContributionAccount(
                  contributionId: contribution.id,
                  groupId: contribution.groupId,
                  memberUserIds: [userId],
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Unable to join: user not authenticated'),
                    backgroundColor: Color(0xFFEF4444),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
            ),
            child: Text(
              'Join',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(Contribution contribution) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contribution.title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Contribution Details',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
                // ROSCA / one-time pill in the header — surfaces the
                // payout model up where the title sits, instead of
                // burying it next to the description further down the
                // screen. Intrinsic-width badge so the row doesn't
                // stretch; clipped if the title squeezes the column.
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        ContributionTypeBadge(type: contribution.type),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Chat',
            icon: Icon(Icons.chat_bubble_outline,
                color: Colors.white, size: 22.sp),
            onPressed: () {
              final cubit = context.read<GroupAccountCubit>();
              final me = cubit.currentUserId;
              if (me == null) return;
              final myName = contribution.members
                      .where((m) => m.userId == me)
                      .map((m) => m.userName)
                      .followedBy(['You'])
                      .first;
              ContributionChatBottomSheet.show(
                context,
                contribution: contribution,
                currentUserId: me,
                currentUserName: myName,
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24.sp,
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
                      Icon(Icons.timeline,
                          color: Colors.white, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'View Cycles History',
                        style: GoogleFonts.inter(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Past Contributions — same caller, different
                // contribution(s). Always visible because the entry
                // surfaces the *user's* exit history, not anything
                // about the contribution they're currently viewing.
                PopupMenuItem(
                  value: 'past_contributions',
                  child: Row(
                    children: [
                      Icon(Icons.history_edu,
                          color: Colors.white, size: 20.sp),
                      SizedBox(width: 12.w),
                      Text(
                        'Past contributions',
                        style: GoogleFonts.inter(color: Colors.white),
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
                value: '${contribution.currency} ${_fmtAmount(contribution.currentAmount)}',
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
                value: '${progressPercentage.toStringAsFixed(progressPercentage < 10 && progressPercentage > 0 ? 1 : 0)}%',
                icon: Icons.trending_up,
              ),
            ],
          ),
          if (partialCount > 0 || fullyPaidCount > 0) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 6.h),
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
                '${contribution.currency} ${_fmtAmount(contribution.currentAmount)}',
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
              Text(
                contribution.isCompleted
                    ? 'Completed'
                    : contribution.isOverdue
                        ? 'Overdue'
                        : 'Active',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: contribution.isCompleted
                      ? const Color(0xFF10B981)
                      : contribution.isOverdue
                          ? const Color(0xFFEF4444)
                          : Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
              Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 14.sp),
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

  Widget _buildTabBar() {
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
          Tab(text: 'Overview'),
          Tab(text: 'Payments'),
          Tab(text: 'Members'),
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
    final remaining =
        (contribution.targetAmount - contribution.currentAmount)
            .clamp(0.0, double.infinity);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCard(
            title: 'Remaining Amount',
            value:
                '${contribution.currency} ${remaining.toStringAsFixed(2)}',
            icon: Icons.account_balance_wallet,
            color: const Color(0xFF3B82F6),
          ),
          SizedBox(height: 16.h),
          _buildStatCard(
            title: 'Days Remaining',
            value: _calculateDaysRemaining(contribution.deadline),
            icon: Icons.schedule,
            color: contribution.isOverdue
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
         localPayment.transactionId == staticPayment.transactionId)
      );

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
    groups.sort((a, b) => b.latestPaymentDate.compareTo(a.latestPaymentDate));

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
    final byUser = <String, List<ContributionPayment>>{};
    for (final p in payments) {
      byUser.putIfAbsent(p.userId, () => []).add(p);
    }

    final memberByUser = <String, ContributionMember>{
      for (final m in contribution.members) m.userId: m,
    };

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
      final latest = list.first;

      out.add(_UserPaymentGroup(
        userId: userId,
        userName: latest.userName.isNotEmpty
            ? latest.userName
            : (member?.userName ?? ''),
        member: member,
        payments: list,
        totalPaid: totalPaid,
        totalInFlight: totalInFlight,
        totalRefunded: totalRefunded,
        expectedAmount: expected,
        remaining: remaining,
        latestPaymentDate: latest.paymentDate,
        currency: latest.currency,
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

    for (final payment in allPayments) {
      userPayments.putIfAbsent(payment.userId, () => []).add(payment);
    }

    // Get all contribution members (assigned members). Declined
    // shadow rows are kept server-side for audit but hidden from the
    // default roster view — re-adding the user via the add-members
    // sheet auto-clears the declined shadow first (cubit pre-clears
    // before AddMembersToContribution), so a fresh invite re-issues
    // cleanly without the user noticing the prior decline.
    final contributionMembers = contribution.members
        .where((m) =>
            m.membershipStatus != ContributionMembershipStatus.declined)
        .toList();
    final hasMembers = contributionMembers.isNotEmpty || userPayments.isNotEmpty;

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

    return ListView(
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
                        ? '${contributionMembers.length} member${contributionMembers.length == 1 ? '' : 's'} assigned'
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        // Members list or empty state
        if (!hasMembers)
          _buildEmptyMembersInline()
        else
          ...List.generate(
            contributionMembers.length + userPayments.entries.where((e) =>
                !contributionMembers.any((m) => m.userId == e.key)).length,
            (index) {
              // Show assigned members first
              if (index < contributionMembers.length) {
                final member = contributionMembers[index];
                final payments = userPayments[member.userId] ?? [];
                final totalPaid = payments.fold<double>(0, (sum, p) => sum + p.amount);

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
                );
              }

              // Show payers who aren't assigned members
              final nonAssignedPayers = userPayments.entries
                  .where((e) => !contributionMembers.any((m) => m.userId == e.key))
                  .toList();
              final payerIndex = index - contributionMembers.length;
              if (payerIndex < nonAssignedPayers.length) {
                final entry = nonAssignedPayers[payerIndex];
                final payments = entry.value;
                final totalAmount = payments.fold<double>(0, (sum, p) => sum + p.amount);

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
  }) {
    final displayName = userName.isNotEmpty
        ? userName
        : (username != null && username.isNotEmpty)
            ? '@$username'
            : (email != null && email.isNotEmpty ? email.split('@').first : 'Unknown User');
    final progressPercent = expectedAmount > 0 ? (totalPaid / expectedAmount * 100).clamp(0.0, 100.0) : 0.0;
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
              backgroundImage: profileImage != null ? NetworkImage(profileImage) : null,
              child: profileImage == null
                  ? Text(
                      displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
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
                      if (isPendingInvite) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFB923C)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.mail_outline,
                                  size: 10.sp,
                                  color: const Color(0xFFFB923C)),
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
                      ] else if (isPaid) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.2),
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
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
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
                          if (username != null && username.isNotEmpty) '@$username',
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
            group.members.any(
                (m) => m.userId == myUserId && m.role == GroupMemberRole.admin));
    final isAdmin = isCreator || isGroupAdmin;
    final isSelf = member != null && myUserId != null && member.userId == myUserId;
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
          text: _buildShareText(contribution),
          subject: contribution.title,
        ));
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
            child: ContributionCyclesHistoryScreen(
                contribution: contribution),
          ),
        );
        break;
      case 'past_contributions':
        // Threading the same cubit through preserves auth + cached
        // groups so the past-contributions list lands instantly.
        final pastCubit = context.read<GroupAccountCubit>();
        Get.to(
          () => BlocProvider<GroupAccountCubit>.value(
            value: pastCubit,
            child: const PastContributionsScreen(),
          ),
        );
        break;
    }
  }

  String _buildShareText(Contribution contribution) {
    final raised = '${contribution.currency} ${_fmtAmount(contribution.currentAmount)}';
    final target = '${contribution.currency} ${_fmtAmount(contribution.targetAmount)}';
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
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        );
      }
    });

    cubit.generateTranscriptForContribution(contribution.id);
  }

  void _showTranscriptDialog(ContributionTranscript transcript, Contribution contribution) {
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
                                style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy_outlined, color: Colors.white, size: 20.sp),
                          tooltip: 'Copy summary',
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(
                              text: _buildTranscriptText(transcript, contribution),
                            ));
                            if (!sheetCtx.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Transcript copied'),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.ios_share, color: Colors.white, size: 20.sp),
                          tooltip: 'Share transcript',
                          onPressed: () {
                            SharePlus.instance.share(ShareParams(
                              text: _buildTranscriptText(transcript, contribution),
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
                    _transcriptKv('Generated', DateFormat('MMM dd, yyyy · HH:mm').format(transcript.generatedAt)),
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
                          style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 12.sp))
                    else
                      ...transcript.memberContributions.entries.map((e) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
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
                          style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 12.sp))
                    else
                      ...transcript.payments.map((p) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                                      p.userName.isNotEmpty ? p.userName : 'Unknown',
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13.sp),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      DateFormat('MMM dd, yyyy · HH:mm').format(p.paymentDate),
                                      style: GoogleFonts.inter(
                                          color: Colors.grey[500], fontSize: 11.sp),
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
          Text(label, style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12.sp)),
          Text(value,
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  String _buildTranscriptText(ContributionTranscript transcript, Contribution contribution) {
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
                  const Color(0xFF2A2A3E).withValues(alpha: 0.95),
                  const Color(0xFF1F1F35).withValues(alpha: 0.98),
                ],
              ),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24.r)),
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
                padding: EdgeInsets.symmetric(
                    horizontal: 8.w, vertical: 4.h),
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
              _summaryStat(
                  'Attempts', '${group.attemptCount}', Colors.white),
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
              const Color(0xFF2A2A3E).withValues(alpha: 0.95),
              const Color(0xFF1F1F35).withValues(alpha: 0.98),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),          boxShadow: [
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
                    color: _getPaymentStatusColor(payment.status).withValues(alpha: 0.2),
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
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
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
              color: const Color(0xFF6366F1),
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
              _buildAmountRow('Contribution Amount', '${payment.currency} ${payment.amount.toStringAsFixed(2)}'),
              SizedBox(height: 8.h),
              _buildAmountRow('Processing Fee', '${payment.currency} 0.00', isSubtle: true),
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
            Icon(Icons.lock_outline,
                size: 18.sp, color: Colors.grey[400]),
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
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Generating Receipt...',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
        text: shareText,
        subject: 'Payment Receipt for ${_currentContribution?.title ?? 'Contribution'}',
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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

Powered by LazerVault 🚀
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
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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

  Widget _buildAmountRow(String label, String amount, {bool isSubtle = false, bool isTotal = false}) {
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
            color: isTotal ? const Color(0xFF10B981) : (isSubtle ? Colors.grey[500] : Colors.white),
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

  void _showAddMembersDialog(Contribution contribution) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<GroupAccountCubit>(),
        child: AddMembersToContributionDialog(
          contribution: contribution,
          onMembersAdded: () {
            _refreshPayments();
            // Also reload contribution details to update the members list
            context.read<GroupAccountCubit>().loadContributionDetails(contribution.id);
          },
        ),
      ),
    );
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }
}

/// Contribution member details bottom sheet
class _ContributionMemberDetailsSheet extends StatelessWidget {
  final String userName;
  final String? email;
  final String? username;
  final String? profileImage;
  final double totalPaid;
  final double expectedAmount;
  final int paymentCount;
  final String currency;
  final bool hasPaidCurrentCycle;
  final DateTime joinedAt;
  final ContributionMember? member;
  // Show the Remove button (admin-only). Caller decides; we just
  // render. Both flags can be false (member viewing someone else's
  // row → no actions), one true (admin viewing someone-else / self
  // viewing self), but not both true at once.
  final bool canRemove;
  final bool canLeave;
  final VoidCallback? onRemove;
  final VoidCallback? onLeave;
  /// Per-member payment history (newest first preferred). When this
  /// list has more than one element OR the single element is a
  /// partial, the sheet renders a "Payment breakdown" section so the
  /// caller can drill into each attempt. Empty list = hide the
  /// section entirely.
  final List<ContributionPayment> memberPayments;
  /// Tapped from a breakdown row. Caller is responsible for popping
  /// this sheet first if it wants to chain another modal (the sheet
  /// itself does not pop on tap).
  final void Function(ContributionPayment payment)? onPaymentTap;

  const _ContributionMemberDetailsSheet({
    required this.userName,
    this.email,
    this.username,
    this.profileImage,
    required this.totalPaid,
    required this.expectedAmount,
    required this.paymentCount,
    required this.currency,
    required this.hasPaidCurrentCycle,
    required this.joinedAt,
    this.member,
    this.canRemove = false,
    this.canLeave = false,
    this.onRemove,
    this.onLeave,
    this.memberPayments = const [],
    this.onPaymentTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercent = expectedAmount > 0
        ? (totalPaid / expectedAmount * 100).clamp(0.0, 100.0)
        : 0.0;
    // PREVIOUSLY: `isPaid = totalPaid >= expectedAmount` returned true
    // for a brand-new member where expectedAmount==0 (the cycle's
    // expected share hasn't been computed yet) → "Fully Paid" badge
    // on someone who's never paid a cent. Require an actual non-zero
    // share before claiming paid.
    final isPaid = expectedAmount > 0 && totalPaid >= expectedAmount;
    final showCurrentCycle = hasPaidCurrentCycle && totalPaid > 0;
    final remaining = (expectedAmount - totalPaid).clamp(0.0, expectedAmount);

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Avatar
          CircleAvatar(
            radius: 40.r,
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
            backgroundImage: profileImage != null
                ? NetworkImage(profileImage!)
                : null,
            child: profileImage == null
                ? Text(
                    userName.isNotEmpty
                        ? userName[0].toUpperCase()
                        : 'U',
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            userName,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),

          // Username (if known) — `@handle` shown subtly under the
          // display name. We pull this from GroupMember by user_id at
          // the parent screen level since ContributionMember itself
          // doesn't carry the canonical handle.
          if (username != null && username!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Text(
                '@$username',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF6366F1),
                ),
              ),
            ),

          // Email
          if (email != null && email!.isNotEmpty)
            Text(
              email!,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
          SizedBox(height: 12.h),

          // Status badge. Cascades isPaid → showCurrentCycle → pending.
          // Note that for a freshly-added member with expected==0, all
          // three are false-ish so the badge falls through to
          // "Pending Payment" — exactly what we want, instead of
          // "Fully Paid" which the old comparison produced.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPaid
                      ? const Color(0xFF10B981).withValues(alpha: 0.1)
                      : showCurrentCycle
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                          : const Color(0xFFF59E0B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isPaid
                      ? 'Fully Paid'
                      : showCurrentCycle
                          ? 'Current Cycle Paid'
                          : 'Pending Payment',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isPaid
                        ? const Color(0xFF10B981)
                        : showCurrentCycle
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFFF59E0B),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Progress bar
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contribution Progress',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${progressPercent.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: isPaid
                            ? const Color(0xFF10B981)
                            : const Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: progressPercent / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isPaid
                                  ? [const Color(0xFF10B981), const Color(0xFF34D399)]
                                  : [const Color.fromARGB(255, 78, 3, 208), const Color.fromARGB(255, 78, 3, 208)],
                            ),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Paid: $currency ${totalPaid.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      'Target: $currency ${expectedAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Details rows
          _buildDetailRow(Icons.calendar_today, 'Joined', _formatDate(joinedAt)),
          _buildDetailRow(Icons.payment, 'Payments Made', '$paymentCount payment${paymentCount == 1 ? '' : 's'}'),
          _buildDetailRow(
            Icons.account_balance_wallet,
            'Remaining',
            '$currency ${remaining.toStringAsFixed(2)}',
            valueColor: remaining > 0 ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
          ),

          // Per-attempt payment breakdown. Mirrors the Payments-tab
          // bottom sheet so the same data shows wherever a user lands
          // — Members tab tap or Payments tab tap. Hidden when there
          // are no payments yet (e.g. an invite-only shadow row).
          if (memberPayments.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment breakdown',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tap any payment to see its full transaction details.',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ...(() {
              // Sort newest first so the most recent partial sits at
              // the top of the list. We don't mutate the input —
              // taking a defensive copy keeps the caller's ordering.
              final sorted = List<ContributionPayment>.from(memberPayments)
                ..sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
              return sorted.map((p) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _PaymentBreakdownRow(
                      payment: p,
                      onTap: onPaymentTap == null
                          ? () {}
                          : () => onPaymentTap!(p),
                    ),
                  ));
            })(),
          ],

          SizedBox(height: 24.h),

          // Action buttons. Mutually exclusive: an admin sees Remove
          // (someone else); the member viewing their own row sees
          // Leave; everyone else sees only Close. Both action paths
          // hit the same server endpoint
          // (RemoveMemberFromContribution) — the server treats
          // userID == memberUserID as self-leave (no admin gate).
          if (canRemove && onRemove != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRemove,
                icon: Icon(Icons.person_remove_alt_1_outlined,
                    size: 18.sp),
                label: Text(
                  'Remove from contribution',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.15),
                  foregroundColor: const Color(0xFFEF4444),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(
                        color: Color(0xFFEF4444), width: 1.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          if (canLeave && onLeave != null) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onLeave,
                icon: Icon(Icons.logout, size: 18.sp),
                label: Text(
                  'Leave contribution',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.15),
                  foregroundColor: const Color(0xFFEF4444),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: const BorderSide(
                        color: Color(0xFFEF4444), width: 1.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],

          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[500], size: 18.sp),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey[400],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// _StatusChip is a borderless elevated tile used by the contribution-
// details "status row" (auto-debit + role). Designed as a compact,
// horizontally-scaled chip the user taps to see full detail in a
// dialog. Uses Material elevation rather than a border to set the
// chip apart from its background.
class _StatusChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _StatusChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1F1F1F),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(icon, color: iconColor, size: 14.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: iconColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[600], size: 16.sp),
            ],
          ),
        ),
      ),
    );
  }
}

// _StatusDetailDialog is the modal opened by tapping a _StatusChip.
// Sections render as heading + body or heading + bullet list. An
// optional primaryAction renders as a CTA at the bottom.
class _StatusDetailDialog extends StatelessWidget {
  final Color accent;
  final IconData icon;
  final String title;
  final List<_DialogSection> sections;
  final _DialogAction? primaryAction;

  const _StatusDetailDialog({
    required this.accent,
    required this.icon,
    required this.title,
    required this.sections,
    this.primaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420.w),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: accent, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey[400], size: 20.sp),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
                    tooltip: 'Close',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < sections.length; i++) ...[
                        if (i > 0) SizedBox(height: 14.h),
                        _renderSection(sections[i], accent),
                      ],
                    ],
                  ),
                ),
              ),
              if (primaryAction != null) ...[
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: primaryAction!.onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      primaryAction!.label,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderSection(_DialogSection s, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.heading,
          style: GoogleFonts.inter(
            color: accent,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6.h),
        if (s.body != null)
          Text(
            s.body!,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 13.sp,
              height: 1.45,
            ),
          ),
        if (s.bullets != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: s.bullets!
                .map(
                  (b) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h, right: 8.w),
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            b,
                            style: GoogleFonts.inter(
                              color: Colors.grey[300],
                              fontSize: 13.sp,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _DialogSection {
  final String heading;
  final String? body;
  final List<String>? bullets;

  const _DialogSection({required this.heading, this.body, this.bullets});
}

class _DialogAction {
  final String label;
  final VoidCallback onTap;

  const _DialogAction({required this.label, required this.onTap});
}

// _CompactInfoBanner is a generic collapsible info row used by the
// auto-debit notice. Default state shows icon + title only (~32px tall);
// expanding reveals the body copy. The body is rendered inline rather
// than in a separate scroll region so the user keeps their place when
// dismissing.
class _CompactInfoBanner extends StatefulWidget {
  final IconData icon;
  final Color accent;
  final String title;
  final String body;

  const _CompactInfoBanner({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
  });

  @override
  State<_CompactInfoBanner> createState() => _CompactInfoBannerState();
}

class _CompactInfoBannerState extends State<_CompactInfoBanner> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: widget.accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(8.r),
            child: Row(
              children: [
                Icon(widget.icon, color: widget.accent, size: 14.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey[500],
                  size: 16.sp,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: 6.h),
            Text(
              widget.body,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 11.sp,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// _CompactRoleBanner is a single-row collapsed role chip with a chevron.
// Default state is ~36px tall (icon + role label + Join CTA / chevron),
// expanding inline to show the permissions list when tapped. Replaces
// the previous always-expanded banner that consumed ~110px regardless
// of whether the user cared about the permission detail.
class _CompactRoleBanner extends StatefulWidget {
  final String roleLabel;
  final Color roleColor;
  final IconData roleIcon;
  final List<String> permissions;
  final bool showJoinCta;
  final VoidCallback onJoin;

  const _CompactRoleBanner({
    required this.roleLabel,
    required this.roleColor,
    required this.roleIcon,
    required this.permissions,
    required this.showJoinCta,
    required this.onJoin,
  });

  @override
  State<_CompactRoleBanner> createState() => _CompactRoleBannerState();
}

class _CompactRoleBannerState extends State<_CompactRoleBanner> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: widget.roleColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: widget.roleColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(8.r),
            child: Row(
              children: [
                Icon(widget.roleIcon, color: widget.roleColor, size: 14.sp),
                SizedBox(width: 8.w),
                Text(
                  'Role: ',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  widget.roleLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: widget.roleColor,
                  ),
                ),
                const Spacer(),
                if (widget.showJoinCta)
                  GestureDetector(
                    onTap: widget.onJoin,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: widget.roleColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Join',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[500],
                    size: 16.sp,
                  ),
              ],
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: widget.permissions
                  .map((p) => Text(
                        '• $p',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
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

class _UserPaymentGroup extends _UserPaymentGroupBase {
  const _UserPaymentGroup({
    required super.userId,
    required super.userName,
    required super.member,
    required super.payments,
    required super.totalPaid,
    required super.totalInFlight,
    required super.totalRefunded,
    required super.expectedAmount,
    required super.remaining,
    required super.latestPaymentDate,
    required super.currency,
  });

}

/// Thin private alias around the now-public `PaymentGroupCard`.
/// Existing callers in this file pass `_UserPaymentGroup` (which
/// extends `UserPaymentGroup`), so the delegating constructor takes
/// the typed field as-is and forwards to the public widget.
class _PaymentGroupCard extends StatelessWidget {
  final _UserPaymentGroup group;
  final VoidCallback onTap;

  const _PaymentGroupCard({required this.group, required this.onTap});

  @override
  Widget build(BuildContext context) =>
      PaymentGroupCard(group: group, onTap: onTap);
}


/// Thin private alias around the now-public `PaymentBreakdownRow`.
/// Keeps the existing call-sites in this file unchanged while the
/// public widget is reused by the past-contribution sheet too.
class _PaymentBreakdownRow extends StatelessWidget {
  final ContributionPayment payment;
  final VoidCallback onTap;
  const _PaymentBreakdownRow(
      {required this.payment, required this.onTap});
  @override
  Widget build(BuildContext context) =>
      PaymentBreakdownRow(payment: payment, onTap: onTap);
}
