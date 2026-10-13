import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../data/datasources/past_memberships_remote_data_source.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../../domain/usecases/group_account_usecases.dart';
import '../widgets/contribution_type_badge.dart';
import '../widgets/past_contribution_details_sheet.dart';
import '../widgets/status_pill.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Lists every contribution the caller has been removed from or left
/// voluntarily. Two tabs (Removed / Left) drive the same backend RPC
/// with a different `filter` query param so ROSCA admins can find the
/// "removed by admin" cases at a glance separately from the user's
/// own self-exits.
class PastContributionsScreen extends StatefulWidget {
  const PastContributionsScreen({super.key});

  @override
  State<PastContributionsScreen> createState() =>
      _PastContributionsScreenState();
}

class _PastContributionsScreenState extends State<PastContributionsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    // Three: why the membership ended, plus the rows the user has cleared
    // off this list. See past_groups_screen.dart for why Deleted is its own
    // tab rather than a filter value.
    _tab = TabController(length: 3, vsync: this);
    // Each tab pane (`_PastContributionsList`) handles its own load
    // when it becomes visible, so the parent only owns the controller.
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Past contributions',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
            // Pill-style segmented tab. Container background gives the
            // resting bar; the indicator is a coloured pill that snaps
            // beneath the active tab. Pure presentation — same TabBar
            // controller drives the swipeable TabBarView below so a
            // left/right finger drag changes filter.
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
              ),
              child: TabBar(
                controller: _tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[500],
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                indicatorPadding: EdgeInsets.all(2.w),
                labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 13.sp),
                tabs: const [
                  Tab(text: 'Removed'),
                  Tab(text: 'Left'),
                  Tab(text: 'Deleted'),
                ],
              ),
            ),
          ),
        ),
      ),
      // Swipeable left/right via TabBarView. Each pane subscribes to
      // the cubit but only renders when its own filter matches the
      // currently-loaded state — that prevents the right-hand pane
      // from briefly showing the left pane's data during a swipe.
      body: TabBarView(
        controller: _tab,
        children: const [
          _PastContributionsList(filter: 'removed'),
          _PastContributionsList(filter: 'left'),
          _PastContributionsList(filter: '', visibility: 'hidden'),
        ],
      ),
    );
  }
}

/// One tab pane. Reads `PastContributionsLoaded` from the cubit but
/// only renders when the loaded state's filter matches its own (the
/// other pane's load is in-flight or stale otherwise). Loads on
/// becoming visible the first time.
class _PastContributionsList extends StatefulWidget {
  final String filter;

  /// '' / 'visible' leaves out rows the user deleted; 'hidden' shows only
  /// those. Independent of [filter].
  final String visibility;

  const _PastContributionsList({required this.filter, this.visibility = ''});

  @override
  State<_PastContributionsList> createState() => _PastContributionsListState();
}

class _PastContributionsListState extends State<_PastContributionsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // One-shot guard. The previous implementation kicked off a load
  // from inside `builder` via addPostFrameCallback, which the cubit's
  // Loading emit then rebuilt — feeding back into the same callback
  // schedule and producing an infinite re-render loop. Loading
  // exclusively from initState (gated on this flag) breaks the cycle.
  bool _kickedOff = false;

  // Per-pane last-good cache. The cubit only stores ONE
  // PastContributionsLoaded at a time, so when the OTHER tab's load
  // emits a Loaded(filter='other'), this pane's BlocBuilder rebuilds
  // with a non-matching state and would otherwise revert to the
  // spinner — visible on-screen as a flicker on the previously
  // rendered tab. Caching last-good entries locally keeps the
  // rendered roster stable across cross-tab loads.
  List<PastContributionEntry>? _lastGood;
  bool _lastGoodEmpty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final s = context.read<GroupAccountCubit>().state;
      // Skip if we already have this filter loaded (e.g. user
      // navigated back into the tab it had already opened).
      if (s is PastContributionsLoaded &&
          s.filter == widget.filter &&
          s.visibility == widget.visibility) {
        return;
      }
      _kickedOff = true;
      _load();
    });
  }

  void _load() {
    final auth = context.read<AuthenticationCubit>().state;
    final token =
        auth is AuthenticationSuccess ? auth.profile.session.accessToken : null;
    context.read<GroupAccountCubit>().loadPastContributions(
          filter: widget.filter,
          visibility: widget.visibility,
          accessToken: token,
        );
  }

  Widget _renderList(List<PastContributionEntry> entries) {
    if (entries.isEmpty) {
      return _EmptyState(filter: widget.filter);
    }
    return RefreshIndicator(
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      onRefresh: () async => _load(),
      child: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: entries.length,
        itemBuilder: (_, i) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _PastContributionCard(
            entry: entries[i],
            onChanged: _load,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GroupAccountCubit, GroupAccountState>(
      buildWhen: (a, b) =>
          b is PastContributionsLoading ||
          b is PastContributionsLoaded ||
          b is PastContributionsError,
      builder: (context, state) {
        if (state is PastContributionsLoaded &&
            state.filter == widget.filter &&
            state.visibility == widget.visibility) {
          // Refresh the local cache. Saved on the State so the next
          // rebuild against a sibling-tab state still has data to
          // render — no flicker when the other tab loads.
          _lastGood = state.entries.cast<PastContributionEntry>().toList();
          _lastGoodEmpty = _lastGood!.isEmpty;
          return _renderList(_lastGood!);
        }
        if (state is PastContributionsError && (_lastGood == null)) {
          // Only surface the full error view when we don't already
          // have data on screen. If we DO have a cached list, keep
          // showing it and let pull-to-refresh / Retry recover.
          return _ErrorView(
              message: state.message,
              onRetry: () {
                _kickedOff = true;
                _load();
              });
        }
        // Sibling-tab state OR fresh Loading. If we have cached data,
        // keep rendering it — that's what kills the cross-tab flicker.
        if (_lastGood != null) {
          return _lastGoodEmpty
              ? _EmptyState(filter: widget.filter)
              : _renderList(_lastGood!);
        }
        // No cache yet — first ever build. initState owns the load
        // kick-off; this branch only runs when no kick-off has fired
        // yet (rare race when the cubit emits a sibling state before
        // initState's post-frame ran).
        if (!_kickedOff) {
          _kickedOff = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _load();
          });
        }
        return const Center(child: LazerVaultLoader.small());
      },
    );
  }
}

class _PastContributionCard extends StatelessWidget {
  final PastContributionEntry entry;

  /// Re-reads the pane after a delete or a restore: the row has just moved
  /// to a different tab.
  final VoidCallback onChanged;

  const _PastContributionCard({required this.entry, required this.onChanged});

  /// See _PastGroupCard._toggleHidden — same contract. "Delete" is a
  /// per-user hide; nothing leaves the database and no other member's view
  /// changes.
  Future<void> _toggleHidden(BuildContext context) async {
    final cubit = context.read<GroupAccountCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final error = entry.hidden
        ? await cubit.restoreToMyLists(
            itemType: DashboardItemTypes.contribution,
            itemId: entry.contribution.id,
          )
        : await cubit.removeFromMyLists(
            itemType: DashboardItemTypes.contribution,
            itemId: entry.contribution.id,
          );

    if (error != null) {
      messenger.showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    messenger.showSnackBar(SnackBar(
      content: Text(entry.hidden
          ? 'Restored to your past contributions'
          : 'Removed from your lists — find it under Deleted'),
      backgroundColor: const Color(0xFF10B981),
      behavior: SnackBarBehavior.floating,
    ));
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0.##');
    final c = entry.contribution;
    final exitedAt = entry.removedAt;
    return GestureDetector(
      onTap: () {
        // Open the bottom-sheet detail (mirrors the cycles-history
        // pattern: tap a row → modal slides up with the breakdown).
        // The launcher itself threads BlocProvider.value with the
        // existing cubit so the loadPastContributionDetails call
        // shares state with this list screen.
        PastContributionDetailsSheet.show(
          context,
          contributionId: c.id,
          seedEntry: entry,
        );
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title.isNotEmpty
                            ? c.title
                            : 'Contribution ${c.id.substring(0, 6)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        entry.group.name.isNotEmpty
                            ? entry.group.name
                            : 'Group',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                ContributionTypeBadge(type: c.type),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert,
                      size: 18.sp, color: Colors.grey[600]),
                  color: const Color(0xFF1F1F1F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_) => [
                    PopupMenuItem<String>(
                      value: 'toggle',
                      child: Row(
                        children: [
                          Icon(
                            entry.hidden
                                ? Icons.restore_from_trash
                                : Icons.delete_outline,
                            size: 18.sp,
                            color: entry.hidden
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            entry.hidden ? 'Restore' : 'Remove from my lists',
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (_) => _toggleHidden(context),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: [
                if (entry.removedAtCycleIndex > 0)
                  StatusPill(
                    text: entry.selfExit
                        ? 'Left at cycle ${entry.removedAtCycleIndex}'
                        : 'Removed at cycle ${entry.removedAtCycleIndex}',
                    color: const Color(0xFF4E03D0),
                    icon: entry.selfExit
                        ? Icons.logout
                        : Icons.person_remove_alt_1_outlined,
                  ),
                if (entry.removedAtCycleIndex == 0)
                  StatusPill(
                    text: entry.selfExit ? 'Left' : 'Removed',
                    color: const Color(0xFF4E03D0),
                    icon: entry.selfExit
                        ? Icons.logout
                        : Icons.person_remove_alt_1_outlined,
                  ),
                if (StatusPill.refund(status: entry.refundStatus) != null)
                  StatusPill.refund(status: entry.refundStatus)!,
                if (entry.refundAmount > 0)
                  StatusPill(
                    text:
                        'Refund ${c.currency} ${fmt.format(entry.refundAmount / 100)}',
                    color: const Color(0xFF10B981),
                    icon: Icons.account_balance_wallet,
                  ),
                if (entry.forfeitedAmount > 0)
                  StatusPill(
                    text:
                        'Forfeited ${c.currency} ${fmt.format(entry.forfeitedAmount / 100)}',
                    color: const Color(0xFFEF4444),
                    icon: Icons.block,
                  ),
              ],
            ),
            if (exitedAt != null) ...[
              SizedBox(height: 8.h),
              Text(
                '${entry.selfExit ? 'Left' : 'Removed'} on ${DateFormat('MMM d, yyyy').format(exitedAt)}',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String filter;
  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    final label = filter == 'left'
        ? 'You haven\'t left any contributions yet.'
        : 'No past contributions to show.';
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_toggle_off,
                size: 64.sp, color: Colors.grey[600]),
            SizedBox(height: 16.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Contributions you exit show up here so you can review the history, refund status, and your past payments.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 56.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
            ),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
