import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../data/datasources/past_memberships_remote_data_source.dart';
import '../cubit/group_account_cubit.dart';
import 'contribution_type_badge.dart';
import 'past_contribution_details_sheet.dart';
import 'status_pill.dart';

/// Tap-into bottom sheet for a past group. Mirrors the
/// PastContributionDetailsSheet layout: drag handle + title row, then
/// a body listing every contribution within this group that the
/// caller used to be a member of (driven by ListPastContributions
/// filtered to the group_id, client-side). Each contribution row is
/// tappable and opens the per-contribution detail sheet so the user
/// can drill all the way through to their payments / refund pills.
class PastGroupDetailsSheet extends StatefulWidget {
  final PastGroupEntry entry;

  const PastGroupDetailsSheet({super.key, required this.entry});

  static Future<void> show(
    BuildContext context, {
    required PastGroupEntry entry,
  }) {
    final cubit = context.read<GroupAccountCubit>();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      builder: (_) => BlocProvider<GroupAccountCubit>.value(
        value: cubit,
        child: FractionallySizedBox(
          heightFactor: 0.92,
          child: PastGroupDetailsSheet(entry: entry),
        ),
      ),
    );
  }

  @override
  State<PastGroupDetailsSheet> createState() =>
      _PastGroupDetailsSheetState();
}

class _PastGroupDetailsSheetState extends State<PastGroupDetailsSheet> {
  // Loaded once on open; the cubit owns the in-flight state. Kept
  // here so the sheet's body filters by group_id without driving
  // the cubit through a noisy double-load on tab switches outside.
  List<PastContributionEntry> _entries = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final auth = context.read<AuthenticationCubit>().state;
    final token = auth is AuthenticationSuccess
        ? auth.profile.session.accessToken
        : null;
    if (token == null) {
      setState(() {
        _loading = false;
        _error = 'Not authenticated';
      });
      return;
    }
    try {
      // Reuse the existing data source — fetch the user's full past-
      // contribution list and filter to this group locally. Avoids
      // adding a backend group_id filter just for this view; the list
      // is small (a user's past memberships) so client-side is fine.
      final ds = PastMembershipsRemoteDataSource();
      final all = await ds.listPastContributions(token: token);
      final filtered = all
          .where((e) => e.contribution.groupId == widget.entry.group.id)
          .toList();
      if (!mounted) return;
      setState(() {
        _entries = filtered;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Failed to load: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0.##');
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.entry.group.name.isNotEmpty
                              ? widget.entry.group.name
                              : 'Group',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.entry.leftAt != null)
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Text(
                              '${widget.entry.selfExit ? 'Left' : 'Removed'} on ${DateFormat('MMM d, yyyy').format(widget.entry.leftAt!)}',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            Expanded(
              child: _buildBody(fmt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(NumberFormat fmt) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 48.sp, color: const Color(0xFFEF4444)),
              SizedBox(height: 12.h),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 13.sp),
              ),
              SizedBox(height: 12.h),
              ElevatedButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      onRefresh: _load,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.95),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.entry.group.description.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      widget.entry.group.description,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 4.h,
                  children: [
                    StatusPill(
                      text: widget.entry.selfExit ? 'Left' : 'Removed',
                      color: Colors.white.withValues(alpha: 0.95),
                      icon: widget.entry.selfExit
                          ? Icons.logout
                          : Icons.person_remove_alt_1_outlined,
                    ),
                    if (widget.entry.activeContributionsAtExit > 0)
                      StatusPill(
                        text:
                            '${widget.entry.activeContributionsAtExit} active at exit',
                        color: const Color(0xFFFB923C),
                        icon: Icons.bolt,
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Your contributions in this group',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap a row for the full breakdown — payments, members, cycles, refund status.',
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 8.h),
          if (_entries.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10.r),
                border:
                    Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Text(
                'You don\'t have any past contributions in this group.',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            )
          else
            ..._entries.map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _ContributionRow(entry: e, fmt: fmt),
                )),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _ContributionRow extends StatelessWidget {
  final PastContributionEntry entry;
  final NumberFormat fmt;
  const _ContributionRow({required this.entry, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final c = entry.contribution;
    return GestureDetector(
      onTap: () => PastContributionDetailsSheet.show(
        context,
        contributionId: c.id,
        seedEntry: entry,
      ),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    c.title.isNotEmpty
                        ? c.title
                        : 'Contribution',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ContributionTypeBadge(type: c.type),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right,
                    size: 18.sp, color: Colors.grey[600]),
              ],
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 4.h,
              children: [
                if (entry.removedAtCycleIndex > 0)
                  StatusPill(
                    text: entry.selfExit
                        ? 'Left at cycle ${entry.removedAtCycleIndex}'
                        : 'Removed at cycle ${entry.removedAtCycleIndex}',
                    color: const Color(0xFF6366F1),
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
            if (entry.removedAt != null) ...[
              SizedBox(height: 6.h),
              Text(
                '${entry.selfExit ? 'Left' : 'Removed'} on ${DateFormat('MMM d, yyyy').format(entry.removedAt!)}',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 10.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
