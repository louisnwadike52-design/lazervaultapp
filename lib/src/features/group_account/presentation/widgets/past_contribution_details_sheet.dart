import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../data/datasources/past_memberships_remote_data_source.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import 'contribution_type_badge.dart';
import 'member_card.dart';
import 'payment_group_widgets.dart';
import 'status_pill.dart';

/// Bottom-sheet variant of the past-contribution detail screen.
/// Mirrors the cycles-history `CycleDetailsBottomSheet` pattern so
/// the two history surfaces feel like the same feature: tap a row →
/// modal slides up with the full breakdown. Loads the aggregated
/// detail bundle once on open and re-uses every sub-widget that the
/// active-membership detail screen already exposes.
class PastContributionDetailsSheet extends StatefulWidget {
  final String contributionId;
  final PastContributionEntry? seedEntry;

  const PastContributionDetailsSheet({
    super.key,
    required this.contributionId,
    this.seedEntry,
  });

  /// Convenience launcher — keeps the call-site identical to
  /// `CycleDetailsBottomSheet.show` so the two history surfaces stay
  /// visually + behaviourally consistent.
  static Future<void> show(
    BuildContext context, {
    required String contributionId,
    PastContributionEntry? seedEntry,
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
          child: PastContributionDetailsSheet(
            contributionId: contributionId,
            seedEntry: seedEntry,
          ),
        ),
      ),
    );
  }

  @override
  State<PastContributionDetailsSheet> createState() =>
      _PastContributionDetailsSheetState();
}

class _PastContributionDetailsSheetState
    extends State<PastContributionDetailsSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final auth = context.read<AuthenticationCubit>().state;
    final token = auth is AuthenticationSuccess
        ? auth.profile.session.accessToken
        : null;
    context.read<GroupAccountCubit>().loadPastContributionDetails(
          widget.contributionId,
          accessToken: token,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle.
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
                    child: Text(
                      widget.seedEntry?.contribution.title ??
                          'Past contribution',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
              child:
                  BlocBuilder<GroupAccountCubit, GroupAccountState>(
                buildWhen: (a, b) =>
                    b is PastContributionDetailsLoading ||
                    b is PastContributionDetailsLoaded ||
                    b is PastContributionDetailsError,
                builder: (context, state) {
                  if (state is PastContributionDetailsLoading) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
                  if (state is PastContributionDetailsError) {
                    return _ErrorView(
                      message: state.message,
                      onRetry: _load,
                    );
                  }
                  if (state is PastContributionDetailsLoaded) {
                    final details =
                        state.details as PastContributionDetails;
                    return RefreshIndicator(
                      backgroundColor: const Color(0xFF1F1F1F),
                      color: const Color.fromARGB(255, 78, 3, 208),
                      onRefresh: () async => _load(),
                      child:
                          _PastDetailsBody(details: details),
                    );
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
}

/// Opens a breakdown sheet listing every attempt the user made,
/// mirroring the Payments-tab drill-in. Each row uses
/// `PaymentBreakdownRow` from the shared widget file. Tapping a row
/// pops back here so the breakdown stays inside the modal stack the
/// user already opened.
void _showCallerBreakdownSheet(
    BuildContext context, UserPaymentGroup group) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    useRootNavigator: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetCtx) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your payments — ${group.attemptCount} attempt${group.attemptCount == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(sheetCtx).pop(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, i) => PaymentBreakdownRow(
                    payment: group.payments[i],
                    onTap: () => _showAttemptDetailsDialog(
                        sheetCtx, group.payments[i]),
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemCount: group.payments.length,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Per-attempt detail dialog. Read-only view of every captured field
/// for one payment record so the user can drill from breakdown row →
/// full receipt-style details (date, status, amount, currency, ref,
/// notes). Avoids reusing the active-screen receipt path because that
/// requires a payment ID known to the caller's group membership; this
/// works directly from the in-memory payment row.
void _showAttemptDetailsDialog(
    BuildContext context, ContributionPayment payment) {
  final fmt = NumberFormat('#,##0.##');
  showDialog(
    context: context,
    builder: (_) {
      Widget kv(String k, String v) => Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110.w,
                  child: Text(
                    k,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 11.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    v,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
      return Dialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    payment.status == PaymentStatus.completed
                        ? Icons.check_circle
                        : payment.status == PaymentStatus.refunded
                            ? Icons.undo
                            : Icons.receipt_long,
                    color: payment.status == PaymentStatus.completed
                        ? const Color(0xFF10B981)
                        : payment.status == PaymentStatus.refunded
                            ? const Color.fromARGB(255, 78, 3, 208)
                            : const Color(0xFFF59E0B),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Payment details',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(color: Color(0xFF2D2D2D)),
              SizedBox(height: 8.h),
              kv('Amount',
                  '${payment.currency} ${fmt.format(payment.amount)}'),
              kv('Status', payment.status.displayName),
              kv('Date',
                  DateFormat('MMM d, yyyy • HH:mm:ss').format(payment.paymentDate)),
              if (payment.transactionId != null &&
                  payment.transactionId!.isNotEmpty)
                kv('Transaction ID', payment.transactionId!),
              if (payment.receiptId != null &&
                  payment.receiptId!.isNotEmpty)
                kv('Receipt ID', payment.receiptId!),
              if (payment.notes != null && payment.notes!.isNotEmpty)
                kv('Notes', payment.notes!),
            ],
          ),
        ),
      );
    },
  );
}

class _PastDetailsBody extends StatelessWidget {
  final PastContributionDetails details;
  const _PastDetailsBody({required this.details});

  @override
  Widget build(BuildContext context) {
    final summary = details.membershipSummary;
    final c = details.contribution;
    final fmt = NumberFormat('#,##0.##');

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        // Summary banner
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title.isNotEmpty ? c.title : 'Contribution',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          summary.group.name.isNotEmpty
                              ? summary.group.name
                              : 'Group',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ContributionTypeBadge(type: c.type),
                ],
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 6.w,
                runSpacing: 4.h,
                children: [
                  if (summary.removedAtCycleIndex > 0)
                    StatusPill(
                      text: summary.selfExit
                          ? 'Left at cycle ${summary.removedAtCycleIndex}'
                          : 'Removed at cycle ${summary.removedAtCycleIndex}',
                      color: const Color(0xFF6366F1),
                      icon: summary.selfExit
                          ? Icons.logout
                          : Icons.person_remove_alt_1_outlined,
                    ),
                  if (StatusPill.refund(status: summary.refundStatus) !=
                      null)
                    StatusPill.refund(status: summary.refundStatus)!,
                  if (summary.refundAmount > 0)
                    StatusPill(
                      text:
                          'Refund ${c.currency} ${fmt.format(summary.refundAmount / 100)}',
                      color: const Color(0xFF10B981),
                      icon: Icons.account_balance_wallet,
                    ),
                  if (summary.forfeitedAmount > 0)
                    StatusPill(
                      text:
                          'Forfeited ${c.currency} ${fmt.format(summary.forfeitedAmount / 100)}',
                      color: const Color(0xFFEF4444),
                      icon: Icons.block,
                    ),
                ],
              ),
              if (summary.removedAt != null) ...[
                SizedBox(height: 8.h),
                Text(
                  '${summary.selfExit ? 'Left' : 'Removed'} on ${DateFormat('MMM d, yyyy').format(summary.removedAt!)}',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11.sp,
                  ),
                ),
              ],
              if (summary.refundFailedReason.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  'Refund issue: ${summary.refundFailedReason}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFCA5A5),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: 16.h),

        if (details.activeCycleAtExit != null) ...[
          _ActiveCycleAtExitBanner(cycle: details.activeCycleAtExit!),
          SizedBox(height: 14.h),
        ],

        // Your payments — same per-user grouping the active Payments
        // tab uses. For the past-contribution sheet there's exactly
        // one payer (the caller themselves) so we render a single
        // group card collapsing every attempt with Partial / Refunded /
        // Pending pills, and tapping it opens the per-attempt
        // breakdown bottom sheet (identical UX to the active screen).
        Text(
          'Your payments',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        if (details.myPayments.isEmpty)
          _emptySection(
              'No payments made',
              'You exited this contribution before making a payment.')
        else
          () {
            final caller = details.myPayments.first.userId;
            // Caller's expected share — pulled from their own
            // ContributionMember row when present so the % progress
            // matches what they saw on the active screen.
            double expected = 0.0;
            for (final m in details.members) {
              if (m.userId == caller && m.expectedAmount > 0) {
                expected = m.expectedAmount;
                break;
              }
            }
            final groups = UserPaymentGroup.groupByUser(
              payments: details.myPayments,
              expectedAmountByUserId: {caller: expected},
              currency: c.currency,
            );
            if (groups.isEmpty) {
              return _emptySection('No payments made', '');
            }
            final group = groups.first;
            return PaymentGroupCard(
              group: group,
              onTap: () => _showCallerBreakdownSheet(context, group),
            );
          }(),

        SizedBox(height: 18.h),

        Text(
          'Members',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        if (details.members.isEmpty)
          _emptySection('No member records', '')
        else
          ...details.members.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: MemberCard(
                  member: GroupMember(
                    id: m.id,
                    userId: m.userId,
                    userName: m.userName,
                    email: m.email,
                    profileImage: m.profileImage,
                    role: GroupMemberRole.member,
                    status: GroupMemberStatus.active,
                    isPartial: false,
                    joinedAt: m.joinedAt,
                  ),
                  group: GroupAccount(
                    id: c.groupId,
                    name: summary.group.name,
                    description: summary.group.description,
                    visibility: summary.group.visibility,
                    adminId: summary.group.adminId,
                    members: const [],
                    contributions: const [],
                    status: summary.group.status,
                    imageUrl: summary.group.imageUrl,
                    createdAt: summary.group.createdAt,
                    updatedAt: summary.group.updatedAt,
                  ),
                  contributions: const [],
                  onTap: null,
                ),
              )),

        SizedBox(height: 18.h),

        Text(
          'Closed cycles',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        if (details.closedCycles.isEmpty)
          _emptySection('No closed cycles',
              'No cycles have closed for this contribution yet.')
        else
          ...details.closedCycles.map(
            (raw) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _ClosedCycleRow(raw: raw, currency: c.currency),
            ),
          ),

        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _emptySection(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}


class _ClosedCycleRow extends StatelessWidget {
  final Map<String, dynamic> raw;
  final String currency;
  const _ClosedCycleRow({required this.raw, required this.currency});

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0.##');
    final cycleIndex = (raw['cycleIndex'] as num?)?.toInt() ?? 0;
    final raisedAmount =
        double.tryParse('${raw['raisedAmount'] ?? 0}') ?? 0;
    final targetAmount =
        double.tryParse('${raw['targetAmount'] ?? 0}') ?? 0;
    final receiverName = (raw['receiverName'] as String?) ?? '';
    final closedAtStr = raw['endedAt'] as String?;
    final closedAt = closedAtStr != null
        ? DateTime.tryParse(closedAtStr)
        : null;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$cycleIndex',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cycle $cycleIndex',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (receiverName.isNotEmpty)
                  Text(
                    'Recipient: $receiverName',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 11.sp,
                    ),
                  ),
                if (closedAt != null)
                  Text(
                    'Closed ${DateFormat('MMM d, yyyy').format(closedAt)}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 10.sp,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$currency ${fmt.format(raisedAmount)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (targetAmount > 0)
                Text(
                  'of $currency ${fmt.format(targetAmount)}',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 10.sp,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveCycleAtExitBanner extends StatelessWidget {
  final Map<String, dynamic> cycle;
  const _ActiveCycleAtExitBanner({required this.cycle});

  @override
  Widget build(BuildContext context) {
    final cycleIndex = (cycle['cycleIndex'] as num?)?.toInt() ?? 0;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.history,
              color: const Color(0xFFFB923C), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              cycleIndex > 0
                  ? 'Cycle $cycleIndex was active when your membership ended.'
                  : 'A cycle was running when your membership ended.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
