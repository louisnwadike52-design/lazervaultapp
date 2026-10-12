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
import '../widgets/past_group_details_sheet.dart';
import '../widgets/status_pill.dart';
import '../../domain/usecases/group_account_usecases.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Lists every group the caller has been removed from or left
/// voluntarily. Mirrors PastContributionsScreen — same pill-style
/// segmented tabs (swipeable left/right) so the two screens feel
/// like one feature.
class PastGroupsScreen extends StatefulWidget {
  const PastGroupsScreen({super.key});

  @override
  State<PastGroupsScreen> createState() => _PastGroupsScreenState();
}

class _PastGroupsScreenState extends State<PastGroupsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    // Three: why the membership ended (Removed / Left), plus the rows the
    // user has cleared off this very list. Deleted is a VISIBILITY, not a
    // reason — it is an independent axis, which is why it gets its own tab
    // rather than being folded into the other two.
    _tab = TabController(length: 3, vsync: this);
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
          'Past groups',
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
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
      body: TabBarView(
        controller: _tab,
        children: const [
          _PastGroupsList(filter: 'removed'),
          _PastGroupsList(filter: 'left'),
          // Everything the user deleted, whichever way they left it.
          _PastGroupsList(filter: '', visibility: 'hidden'),
        ],
      ),
    );
  }
}

class _PastGroupsList extends StatefulWidget {
  final String filter;

  /// '' / 'visible' leaves out rows the user deleted; 'hidden' shows only
  /// those. Independent of [filter], which is about WHY the membership
  /// ended.
  final String visibility;

  const _PastGroupsList({required this.filter, this.visibility = ''});

  @override
  State<_PastGroupsList> createState() => _PastGroupsListState();
}

class _PastGroupsListState extends State<_PastGroupsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // Same one-shot guard as the past-contributions pane — prevents the
  // builder/Loading/build feedback loop that produced non-stop
  // re-renders before this fix.
  bool _kickedOff = false;

  // Per-pane last-good cache. Without this, when the OTHER tab fires
  // a load the cubit emits Loaded(filter='other') and this pane's
  // BlocBuilder reverts to a spinner — visible as a flicker on the
  // tab the user previously rendered.
  List<PastGroupEntry>? _lastGood;
  bool _lastGoodEmpty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final s = context.read<GroupAccountCubit>().state;
      // Both axes, or the Deleted pane would accept the Left pane's result
      // (same filter '' on an older build) and show the wrong rows.
      if (s is PastGroupsLoaded &&
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
    context.read<GroupAccountCubit>().loadPastGroups(
          filter: widget.filter,
          visibility: widget.visibility,
          accessToken: token,
        );
  }

  Widget _renderList(List<PastGroupEntry> entries) {
    if (entries.isEmpty) {
      return _emptyState(widget.filter);
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
          child: _PastGroupCard(
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
          b is PastGroupsLoading ||
          b is PastGroupsLoaded ||
          b is PastGroupsError,
      builder: (context, state) {
        if (state is PastGroupsLoaded &&
            state.filter == widget.filter &&
            state.visibility == widget.visibility) {
          _lastGood = state.entries.cast<PastGroupEntry>().toList();
          _lastGoodEmpty = _lastGood!.isEmpty;
          return _renderList(_lastGood!);
        }
        if (state is PastGroupsError && _lastGood == null) {
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
                    state.message,
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      _kickedOff = true;
                      _load();
                    },
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
        // Sibling-tab state OR fresh Loading: hold the cached list
        // on screen rather than reverting to a spinner. Kills the
        // cross-tab flicker.
        if (_lastGood != null) {
          return _lastGoodEmpty
              ? _emptyState(widget.filter)
              : _renderList(_lastGood!);
        }
        // First ever build before initState's post-frame fired.
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

  Widget _emptyState(String filter) {
    final label = filter == 'left'
        ? 'You haven\'t left any groups yet.'
        : 'No past groups to show.';
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups, size: 64.sp, color: Colors.grey[600]),
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
          ],
        ),
      ),
    );
  }
}

class _PastGroupCard extends StatelessWidget {
  final PastGroupEntry entry;

  /// Re-reads the pane after a delete or a restore, because the row has
  /// just moved to a different tab and leaving it on screen would be the
  /// list disagreeing with itself.
  final VoidCallback onChanged;

  const _PastGroupCard({required this.entry, required this.onChanged});

  /// Remove from my lists, or put it back.
  ///
  /// "Delete" here never deletes: the group, its contributions, its payouts
  /// and every report that counts them are untouched, and so is every other
  /// member's view. It is a per-user hide, which is why the row reappears
  /// under Deleted rather than vanishing.
  Future<void> _toggleHidden(BuildContext context) async {
    final cubit = context.read<GroupAccountCubit>();
    final messenger = ScaffoldMessenger.of(context);

    final error = entry.hidden
        ? await cubit.restoreToMyLists(
            itemType: DashboardItemTypes.group,
            itemId: entry.group.id,
          )
        : await cubit.removeFromMyLists(
            itemType: DashboardItemTypes.group,
            itemId: entry.group.id,
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
          ? 'Restored to your past groups'
          : 'Removed from your lists — find it under Deleted'),
      backgroundColor: const Color(0xFF10B981),
      behavior: SnackBarBehavior.floating,
    ));
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PastGroupDetailsSheet.show(
        context,
        entry: entry,
      ),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor:
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
              child: Text(
                entry.group.name.isNotEmpty
                    ? entry.group.name[0].toUpperCase()
                    : 'G',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 78, 3, 208),
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.group.name.isNotEmpty ? entry.group.name : 'Group',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: [
                      StatusPill(
                        text: entry.selfExit ? 'Left' : 'Removed',
                        color: const Color(0xFF4E03D0),
                        icon: entry.selfExit
                            ? Icons.logout
                            : Icons.person_remove_alt_1_outlined,
                      ),
                      if (entry.activeContributionsAtExit > 0)
                        StatusPill(
                          text:
                              '${entry.activeContributionsAtExit} active at exit',
                          color: const Color(0xFFFB923C),
                          icon: Icons.bolt,
                        ),
                    ],
                  ),
                  if (entry.leftAt != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      'on ${DateFormat('MMM d, yyyy').format(entry.leftAt!)}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, size: 18.sp, color: Colors.grey[600]),
              color: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
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
            Icon(Icons.chevron_right, size: 20.sp, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
