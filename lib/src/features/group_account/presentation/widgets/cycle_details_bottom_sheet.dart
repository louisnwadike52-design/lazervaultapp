import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

/// Per-cycle detail sheet — opened by tapping a row on
/// [ContributionCyclesHistoryScreen]. Loads the cycle details bundle
/// (summary + member snapshot + cycle-scoped payments) once on open
/// and renders four tabs: Members, Payments, Receiver, Pending.
///
/// Design: dark surface, no borders, elevation via shadow + colour
/// contrast. Same idiom as the parent history screen.
class CycleDetailsBottomSheet extends StatefulWidget {
  final Contribution contribution;
  final int cycleIndex;
  // Optional pre-resolved summary from the list screen — used as the
  // header placeholder so the sheet doesn't flash an empty state
  // while the details RPC is in flight.
  final ContributionCycle? summary;

  const CycleDetailsBottomSheet({
    super.key,
    required this.contribution,
    required this.cycleIndex,
    this.summary,
  });

  static Future<void> show(
    BuildContext context, {
    required Contribution contribution,
    required int cycleIndex,
    ContributionCycle? summary,
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
          child: CycleDetailsBottomSheet(
            contribution: contribution,
            cycleIndex: cycleIndex,
            summary: summary,
          ),
        ),
      ),
    );
  }

  @override
  State<CycleDetailsBottomSheet> createState() =>
      _CycleDetailsBottomSheetState();
}

class _CycleDetailsBottomSheetState extends State<CycleDetailsBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  ContributionCycleDetails? _details;
  bool _loading = true;
  String? _error;
  // Pending-tab sub-filter ("started" = paid_amount > 0; "missed" =
  // paid_amount == 0).
  String _pendingFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _load() {
    setState(() {
      _loading = true;
      _error = null;
    });
    context.read<GroupAccountCubit>().loadContributionCycleDetails(
          contributionId: widget.contribution.id,
          cycleIndex: widget.cycleIndex,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listener: (ctx, state) {
        if (state is ContributionCycleDetailsLoaded &&
            state.details.summary.contributionId == widget.contribution.id &&
            state.details.summary.cycleIndex == widget.cycleIndex) {
          setState(() {
            _details = state.details;
            _loading = false;
            _error = null;
          });
        } else if (state is GroupAccountError && _loading) {
          setState(() {
            _loading = false;
            _error = state.message;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              _buildHandle(),
              _buildHeader(),
              _buildTabBar(),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.only(top: 12.h, bottom: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF4B5563),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    final summary = _details?.summary ?? widget.summary;
    final dateFmt = DateFormat('MMM d, yyyy');
    final accent = _statusColor(summary?.status);
    final raised = summary != null
        ? '${widget.contribution.currency} ${_fmt(summary.raisedAmount)}'
        : '—';
    final target = summary != null
        ? '${widget.contribution.currency} ${_fmt(summary.targetAmount)}'
        : '—';

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Cycle ${widget.cycleIndex}',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (summary != null) _buildStatusPill(summary.status, accent),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: Icon(Icons.close,
                    color: Colors.grey[400], size: 20.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            raised,
            style: GoogleFonts.inter(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'of $target raised',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
          ),
          if (summary != null) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 12.sp, color: Colors.grey[500]),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    summary.endedAt != null
                        ? '${dateFmt.format(summary.startedAt.toLocal())}  →  ${dateFmt.format(summary.endedAt!.toLocal())}'
                        : 'Started ${dateFmt.format(summary.startedAt.toLocal())}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TabBar(
        controller: _tabs,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: const Color.fromARGB(255, 78, 3, 208),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle:
            GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400),
        labelPadding: EdgeInsets.symmetric(horizontal: 14.w),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Members'),
          Tab(text: 'Payments'),
          Tab(text: 'Receiver'),
          Tab(text: 'Pending'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 78, 3, 208)),
        ),
      );
    }
    if (_error != null) {
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
                _error!,
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
    final d = _details;
    if (d == null) return const SizedBox.shrink();
    return TabBarView(
      controller: _tabs,
      children: [
        _buildMembersTab(d),
        _buildPaymentsTab(d),
        _buildReceiverTab(d),
        _buildPendingTab(d),
      ],
    );
  }

  // -----------------------------------------------------------
  // Members tab — full snapshot list with filter chips
  // -----------------------------------------------------------
  Widget _buildMembersTab(ContributionCycleDetails d) {
    if (d.members.isEmpty) {
      return _emptyState(
          icon: Icons.group_outlined,
          title: 'No members captured',
          message:
              'This cycle ran without any active members at close.');
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: d.members.length,
      itemBuilder: (_, i) => _buildMemberRow(d.members[i]),
    );
  }

  Widget _buildMemberRow(ContributionCycleMemberSnapshot m) {
    Color tint;
    String label;
    if (m.hasPaid) {
      tint = const Color(0xFF10B981);
      label = 'Paid';
    } else if (m.paidAmount > 0) {
      tint = const Color(0xFFFB923C);
      label = 'Partial';
    } else {
      tint = const Color(0xFFEF4444);
      label = 'Missed';
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color.fromARGB(255, 78, 3, 208),
            child: Text(
              _initials(m.userName),
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        m.userName.isNotEmpty ? m.userName : 'Member',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (m.wasReceiver) ...[
                      SizedBox(width: 6.w),
                      Icon(Icons.emoji_events,
                          size: 13.sp, color: const Color(0xFFF59E0B)),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  '${widget.contribution.currency} ${_fmt(m.paidAmount)}'
                  ' / ${widget.contribution.currency} ${_fmt(m.expectedAmount)}',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: tint,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------
  // Payments tab — chronological list scoped to this cycle.
  // -----------------------------------------------------------
  Widget _buildPaymentsTab(ContributionCycleDetails d) {
    if (d.payments.isEmpty) {
      return _emptyState(
          icon: Icons.payments_outlined,
          title: 'No payments yet',
          message: 'Payments to this cycle will appear here.');
    }
    final dateFmt = DateFormat('MMM dd, yyyy · h:mma');
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: d.payments.length,
      itemBuilder: (_, i) {
        final p = d.payments[i];
        final completed = p.status == PaymentStatus.completed;
        final tint = completed
            ? const Color(0xFF10B981)
            : const Color(0xFFFB923C);
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Icon(
                  completed ? Icons.check_circle : Icons.access_time,
                  size: 18.sp,
                  color: tint,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.userName.isNotEmpty ? p.userName : 'Member',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      dateFmt.format(p.paymentDate.toLocal()),
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${p.currency} ${_fmt(p.amount)}',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // -----------------------------------------------------------
  // Receiver tab — payout outcome for the cycle.
  // -----------------------------------------------------------
  Widget _buildReceiverTab(ContributionCycleDetails d) {
    final s = d.summary;
    final receiverName = s.receiverName.isNotEmpty
        ? s.receiverName
        : (s.receiverUserId ?? '');

    if (s.isFailed) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: _infoCard(
          icon: Icons.error_outline,
          tint: const Color(0xFFEF4444),
          title: 'Payout failed',
          body: s.closeReason.isNotEmpty
              ? s.closeReason
              : 'The cycle closed without a successful payout.',
        ),
      );
    }
    if (s.isCancelled) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: _infoCard(
          icon: Icons.cancel_outlined,
          tint: const Color(0xFF6B7280),
          title: 'Cycle cancelled',
          body: s.closeReason.isNotEmpty
              ? s.closeReason
              : 'This cycle was stopped before payout.',
        ),
      );
    }
    if (receiverName.isEmpty) {
      return _emptyState(
          icon: Icons.person_outline,
          title: 'No receiver yet',
          message:
              'A receiver will be assigned when the cycle progresses toward close.');
    }
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: const Color(0xFFF59E0B),
                  child: Icon(Icons.emoji_events,
                      size: 22.sp, color: Colors.white),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiverName,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        s.isLive
                            ? 'Scheduled receiver'
                            : 'Received this cycle',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _kvRow('Amount',
                '${widget.contribution.currency} ${_fmt(s.raisedAmount)}'),
            if (s.deficitAmount > 0)
              _kvRow('Deficit',
                  '${widget.contribution.currency} ${_fmt(s.deficitAmount)}',
                  tint: const Color(0xFFFB923C)),
            if (s.payoutTransactionId != null &&
                s.payoutTransactionId!.isNotEmpty)
              _kvRow('Transaction', _shortId(s.payoutTransactionId!)),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------
  // Pending tab — members who didn't pay or paid partially.
  // -----------------------------------------------------------
  Widget _buildPendingTab(ContributionCycleDetails d) {
    final missed = d.members.where((m) => m.isPending).toList();
    final partial = d.members.where((m) => m.isPartial).toList();
    if (missed.isEmpty && partial.isEmpty) {
      return _emptyState(
          icon: Icons.check_circle_outline,
          title: 'Everyone paid',
          message: 'No outstanding contributions for this cycle.');
    }
    final filterAll = _pendingFilter == 'all';
    final filterStarted = _pendingFilter == 'started';
    final filterMissed = _pendingFilter == 'missed';
    final showStarted = filterAll || filterStarted;
    final showMissed = filterAll || filterMissed;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
          child: Row(
            children: [
              _filterChip('All', _pendingFilter == 'all', () {
                setState(() => _pendingFilter = 'all');
              }),
              SizedBox(width: 8.w),
              _filterChip('Started', _pendingFilter == 'started', () {
                setState(() => _pendingFilter = 'started');
              }, count: partial.length),
              SizedBox(width: 8.w),
              _filterChip('Missed', _pendingFilter == 'missed', () {
                setState(() => _pendingFilter = 'missed');
              }, count: missed.length),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
            children: [
              if (showStarted && partial.isNotEmpty) ...[
                _sectionLabel(
                    'Started but incomplete (${partial.length})'),
                SizedBox(height: 8.h),
                ...partial.map(_buildMemberRow),
                SizedBox(height: 12.h),
              ],
              if (showMissed && missed.isNotEmpty) ...[
                _sectionLabel('Did not pay (${missed.length})'),
                SizedBox(height: 8.h),
                ...missed.map(_buildMemberRow),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------
  // Shared bits
  // -----------------------------------------------------------
  Widget _filterChip(String label, bool active, VoidCallback onTap,
      {int? count}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: active
              ? const Color.fromARGB(255, 78, 3, 208)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          count != null ? '$label · $count' : label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.grey[400],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: Colors.grey[500],
      ),
    );
  }

  Widget _kvRow(String key, String value, {Color? tint}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Text(
            key,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: Colors.grey[500],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: tint ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required Color tint,
    required String title,
    required String body,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tint, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56.sp, color: const Color(0xFF6B7280)),
            SizedBox(height: 12.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.grey[500],
              ),
            ),
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

  Color _statusColor(ContributionCycleStatus? status) {
    switch (status) {
      case ContributionCycleStatus.inProgress:
        return const Color(0xFF6366F1);
      case ContributionCycleStatus.closedSettled:
        return const Color(0xFF10B981);
      case ContributionCycleStatus.closedFailed:
        return const Color(0xFFEF4444);
      case ContributionCycleStatus.closedCancelled:
        return const Color(0xFF6B7280);
      case null:
        return const Color(0xFF6366F1);
    }
  }

  String _initials(String name) {
    if (name.isEmpty) return 'M';
    final parts = name.trim().split(RegExp(r'\s+'));
    final first = parts.first.isNotEmpty ? parts.first[0] : '';
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  String _fmt(double amount) =>
      NumberFormat('#,##0.00').format(amount);

  String _shortId(String id) =>
      id.length <= 12 ? id : '${id.substring(0, 8)}…${id.substring(id.length - 4)}';
}
