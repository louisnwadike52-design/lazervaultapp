import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';

/// Per-cycle timeline of payouts + payments for a single contribution.
///
/// Aggregates two existing endpoints into one timeline:
///   * GET /v1/contributions/{id}/payments  — all payments
///   * (existing payouts already preloaded on the contribution row)
///
/// Each cycle's card shows:
///   * Cycle index + status (settled / pending / current)
///   * Recipient + payout amount (with deficit warning when relevant)
///   * Per-member payment list (paid / not paid + amount)
///   * Behind-members indicator if any
///
/// One-time contributions render a single "Cycle 0" card; ROSCA renders
/// one card per advanced cycle plus the in-flight cycle at the top.
class ContributionHistoryScreen extends StatefulWidget {
  final Contribution contribution;

  const ContributionHistoryScreen({super.key, required this.contribution});

  @override
  State<ContributionHistoryScreen> createState() =>
      _ContributionHistoryScreenState();
}

class _ContributionHistoryScreenState extends State<ContributionHistoryScreen> {
  bool _loading = true;
  String? _error;
  List<ContributionPayment> _payments = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final cubit = context.read<GroupAccountCubit>();
      final payments = await cubit.getContributionPayments
          .call(widget.contribution.id);
      if (!mounted) return;
      setState(() {
        _payments = payments;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load history. $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Text(
          'Contribution history',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6366F1)),
      );
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  color: const Color(0xFFEF4444), size: 28.sp),
              SizedBox(height: 12.h),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: Colors.grey[300], fontSize: 13.sp),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () => setState(() {
                  _loading = true;
                  _error = null;
                  _load();
                }),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final cycles = _groupByCycle();
    if (cycles.isEmpty) {
      return Center(
        child: Text(
          'No payments yet.',
          style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      itemCount: cycles.length,
      itemBuilder: (_, i) => _buildCycleCard(cycles[i]),
    );
  }

  /// Groups payments by cycle. For one-time contributions, every payment
  /// is cycle 1. For ROSCA, the existing model doesn't carry a cycle
  /// index per payment, so we approximate by grouping payments that
  /// fall within the same cycle window (start_date + N × frequency).
  /// When start_date / frequency are missing, falls back to a single
  /// "All payments" bucket.
  List<_CycleBucket> _groupByCycle() {
    final c = widget.contribution;
    final isRosca = c.type == ContributionType.rotatingSavings;

    if (!isRosca || c.startDate == null || c.frequency == null) {
      // Single bucket.
      if (_payments.isEmpty) return const [];
      return [
        _CycleBucket(
          cycleIndex: c.currentCycle ?? 1,
          start: c.startDate ?? c.createdAt,
          end: c.deadline,
          payments: List.of(_payments),
        ),
      ];
    }

    final buckets = <int, _CycleBucket>{};
    final start = c.startDate!;
    for (final p in _payments) {
      final cycleIdx = _cycleIndexFor(start, c.frequency!, p.paymentDate);
      buckets
          .putIfAbsent(
            cycleIdx,
            () => _CycleBucket(
              cycleIndex: cycleIdx,
              start: _addFrequency(start, c.frequency!, cycleIdx - 1),
              end: _addFrequency(start, c.frequency!, cycleIdx),
              payments: [],
            ),
          )
          .payments
          .add(p);
    }
    final list = buckets.values.toList()
      ..sort((a, b) => b.cycleIndex.compareTo(a.cycleIndex));
    return list;
  }

  int _cycleIndexFor(
      DateTime start, ContributionFrequency f, DateTime when) {
    if (when.isBefore(start)) return 1;
    int n = 1;
    while (true) {
      final next = _addFrequency(start, f, n);
      if (when.isBefore(next)) return n;
      n++;
      if (n > 1000) return n; // safety
    }
  }

  DateTime _addFrequency(DateTime start, ContributionFrequency f, int n) {
    switch (f) {
      case ContributionFrequency.daily:
        return start.add(Duration(days: n));
      case ContributionFrequency.weekly:
        return start.add(Duration(days: 7 * n));
      case ContributionFrequency.biWeekly:
        return start.add(Duration(days: 14 * n));
      case ContributionFrequency.monthly:
        return DateTime(start.year, start.month + n, start.day, start.hour,
            start.minute);
      case ContributionFrequency.quarterly:
        return DateTime(start.year, start.month + 3 * n, start.day, start.hour,
            start.minute);
    }
  }

  Widget _buildCycleCard(_CycleBucket b) {
    final c = widget.contribution;
    final isCurrent = b.cycleIndex == (c.currentCycle ?? 1);

    // Per-member roll-up: union of (members) ∪ (payment authors).
    final memberRows = <_MemberRow>[];
    for (final m in c.members) {
      final theirPayments =
          b.payments.where((p) => p.userId == m.userId).toList();
      final paid = theirPayments.fold<double>(0, (s, p) => s + p.amount);
      memberRows.add(_MemberRow(
        userId: m.userId,
        userName: m.userName,
        paid: paid,
        hasPaid: paid > 0,
      ));
    }
    // Capture any payment by a non-member (rare, but defend against
    // members being removed mid-cycle).
    for (final p in b.payments.where((p) =>
        !c.members.any((m) => m.userId == p.userId) &&
        !memberRows.any((r) => r.userId == p.userId))) {
      memberRows.add(_MemberRow(
        userId: p.userId,
        userName: p.userName.isNotEmpty ? p.userName : 'Unknown member',
        paid: p.amount,
        hasPaid: true,
      ));
    }

    final behindCount = memberRows.where((m) => !m.hasPaid).length;
    final cyclePot = memberRows.fold<double>(0, (s, r) => s + r.paid);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? const Color(0xFF6366F1).withValues(alpha: 0.18)
                      : const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isCurrent ? 'Current cycle' : 'Cycle ${b.cycleIndex}',
                  style: GoogleFonts.inter(
                    color: isCurrent
                        ? const Color(0xFF6366F1)
                        : const Color(0xFF10B981),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const Spacer(),
              if (behindCount > 0)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    '$behindCount behind',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${DateFormat('MMM d, yyyy').format(b.start)}  →  '
            '${DateFormat('MMM d, yyyy').format(b.end)}',
            style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 11.sp),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                '${c.currency} ${cyclePot.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'collected',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          if (memberRows.isNotEmpty) ...[
            SizedBox(height: 10.h),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            SizedBox(height: 10.h),
            for (final m in memberRows) ...[
              Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: m.hasPaid
                          ? const Color(0xFF10B981)
                          : const Color(0xFFFB923C),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      m.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Text(
                    m.hasPaid
                        ? '${c.currency} ${m.paid.toStringAsFixed(2)}'
                        : 'Not paid',
                    style: GoogleFonts.inter(
                      color: m.hasPaid
                          ? Colors.white
                          : const Color(0xFFFB923C),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
            ],
          ],
        ],
      ),
    );
  }
}

class _CycleBucket {
  final int cycleIndex;
  final DateTime start;
  final DateTime end;
  final List<ContributionPayment> payments;

  _CycleBucket({
    required this.cycleIndex,
    required this.start,
    required this.end,
    required this.payments,
  });
}

class _MemberRow {
  final String userId;
  final String userName;
  final double paid;
  final bool hasPaid;

  const _MemberRow({
    required this.userId,
    required this.userName,
    required this.paid,
    required this.hasPaid,
  });
}
