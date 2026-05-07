import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/cycle_details_bottom_sheet.dart';

/// Lists every cycle of a contribution, oldest at the bottom (the
/// list is rendered in cycle_index DESC server-side so the live or
/// most-recent closed cycle is on top — matching how the history
/// screen reads top-down).
///
/// Visual treatment: dark scaffold, no borders, elevation +
/// background contrast on each card. Tapping a card opens
/// [CycleDetailsBottomSheet] with the per-cycle deep dive.
class ContributionCyclesHistoryScreen extends StatefulWidget {
  final Contribution contribution;

  const ContributionCyclesHistoryScreen({super.key, required this.contribution});

  @override
  State<ContributionCyclesHistoryScreen> createState() =>
      _ContributionCyclesHistoryScreenState();
}

class _ContributionCyclesHistoryScreenState
    extends State<ContributionCyclesHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
    });
  }

  void _load() {
    context.read<GroupAccountCubit>().loadContributionCycles(
          contributionId: widget.contribution.id,
          includeInProgress: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Expanded(
              child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
                buildWhen: (prev, curr) =>
                    curr is ContributionCyclesLoading ||
                    curr is ContributionCyclesLoaded ||
                    curr is GroupAccountError,
                listener: (ctx, state) {
                  if (state is GroupAccountError) {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFFEF4444),
                      ),
                    );
                  }
                },
                builder: (ctx, state) {
                  if (state is ContributionCyclesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 78, 3, 208)),
                      ),
                    );
                  }
                  if (state is ContributionCyclesLoaded &&
                      state.contributionId == widget.contribution.id) {
                    return _buildList(state.cycles);
                  }
                  if (state is GroupAccountError) {
                    return _buildError(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: const BoxDecoration(color: Color(0xFF1F1F1F)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contribution.title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Cycles History',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: _load,
            icon: Icon(Icons.refresh, color: Colors.white, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<ContributionCycle> cycles) {
    if (cycles.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timeline,
                  size: 64.sp, color: const Color(0xFF6B7280)),
              SizedBox(height: 16.h),
              Text(
                'No cycles yet',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Your first cycle will appear here once it starts.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => _load(),
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color.fromARGB(255, 78, 3, 208),
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        itemCount: cycles.length,
        itemBuilder: (context, i) {
          final c = cycles[i];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildCycleCard(c),
          );
        },
      ),
    );
  }

  Widget _buildCycleCard(ContributionCycle c) {
    final accent = _statusColor(c.status);
    final dateFmt = DateFormat('MMM d, yyyy');
    final progress = c.progressPercent / 100.0;
    final raised =
        '${widget.contribution.currency} ${_fmtAmount(c.raisedAmount)}';
    final target =
        '${widget.contribution.currency} ${_fmtAmount(c.targetAmount)}';

    return GestureDetector(
      onTap: () => CycleDetailsBottomSheet.show(
        context,
        contribution: widget.contribution,
        cycleIndex: c.cycleIndex,
        summary: c,
      ),
      child: Container(
        // Elevation + background contrast instead of borders.
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Cycle ${c.cycleIndex}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                _buildStatusPill(c.status, accent),
                const Spacer(),
                Icon(Icons.chevron_right,
                    color: Colors.grey[600], size: 20.sp),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        raised,
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'of $target',
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
                      '${c.progressPercent.toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${c.paymentCount} payments',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(3.r),
              child: LinearProgressIndicator(
                minHeight: 5.h,
                value: progress.clamp(0.0, 1.0),
                backgroundColor: const Color(0xFF2D2D2D),
                valueColor: AlwaysStoppedAnimation<Color>(accent),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 12.sp, color: Colors.grey[500]),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    c.endedAt != null
                        ? '${dateFmt.format(c.startedAt.toLocal())}  →  ${dateFmt.format(c.endedAt!.toLocal())}'
                        : 'Started ${dateFmt.format(c.startedAt.toLocal())}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[400],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (c.receiverName.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(Icons.emoji_events,
                      size: 12.sp, color: const Color(0xFFF59E0B)),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      'Received by ${c.receiverName}',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[300],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            if (!c.isLive && c.pendingMembersCount > 0) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(Icons.warning_amber,
                      size: 12.sp, color: const Color(0xFFFB923C)),
                  SizedBox(width: 4.w),
                  Text(
                    '${c.pendingMembersCount} unpaid at close',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFFFB923C),
                    ),
                  ),
                ],
              ),
            ],
            if (c.closeReason.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Text(
                c.closeReason,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[500],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPill(ContributionCycleStatus status, Color accent) {
    final label = switch (status) {
      ContributionCycleStatus.inProgress => 'Live',
      ContributionCycleStatus.closedSettled => 'Settled',
      ContributionCycleStatus.closedFailed => 'Failed',
      ContributionCycleStatus.closedCancelled => 'Cancelled',
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: accent,
        ),
      ),
    );
  }

  Color _statusColor(ContributionCycleStatus status) {
    switch (status) {
      case ContributionCycleStatus.inProgress:
        return const Color(0xFF6366F1);
      case ContributionCycleStatus.closedSettled:
        return const Color(0xFF10B981);
      case ContributionCycleStatus.closedFailed:
        return const Color(0xFFEF4444);
      case ContributionCycleStatus.closedCancelled:
        return const Color(0xFF6B7280);
    }
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _load,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtAmount(double amount) =>
      NumberFormat('#,##0.00').format(amount);
}
