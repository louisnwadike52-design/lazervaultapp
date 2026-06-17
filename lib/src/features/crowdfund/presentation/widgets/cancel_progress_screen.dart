import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';

/// Live cancel-in-progress screen. Polls the campaign detail
/// endpoint every 5s while status==cancelling (the refund counters
/// are denormalized on the campaign row, so a single fetch refreshes
/// progress) and surfaces a success / partial-failure terminal
/// state once status flips to cancelled.
///
/// Polling is the fallback path; if a Crowdfund WS topic ever lands
/// for these events, swap the timer for a WS subscription per the
/// project's `feedback_no_polling_use_websockets` memory.
class CancelProgressScreen extends StatefulWidget {
  final String crowdfundId;
  final Crowdfund initialCrowdfund;
  final int refundsQueued;
  final int totalContributions;

  const CancelProgressScreen({
    super.key,
    required this.crowdfundId,
    required this.initialCrowdfund,
    required this.refundsQueued,
    required this.totalContributions,
  });

  @override
  State<CancelProgressScreen> createState() => _CancelProgressScreenState();
}

class _CancelProgressScreenState extends State<CancelProgressScreen> {
  late Crowdfund _crowdfund;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _crowdfund = widget.initialCrowdfund;
    // Trigger one immediate refresh — the synchronous Cancel response
    // is the campaign as it was at queue time, but the worker may
    // have already started.
    _refresh();
    _poll = Timer.periodic(const Duration(seconds: 5), (_) => _refresh());
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  void _refresh() {
    if (!mounted) return;
    if (_crowdfund.isCancelled) {
      _poll?.cancel();
      return;
    }
    context.read<CrowdfundCubit>().loadCrowdfundDetails(widget.crowdfundId);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Non-dismissible while cancellation is in flight. Once status
      // flips to cancelled (or some refunds remain failed), the user
      // can pop normally.
      canPop: !_crowdfund.isCancelling,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          title: Text(
            'Refunding contributors',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          // Hide the back arrow while cancellation is in flight.
          automaticallyImplyLeading: !_crowdfund.isCancelling,
        ),
        body: BlocListener<CrowdfundCubit, CrowdfundState>(
          listenWhen: (prev, curr) => curr is CrowdfundDetailsLoaded,
          listener: (ctx, state) {
            if (state is CrowdfundDetailsLoaded &&
                state.crowdfund.id == widget.crowdfundId) {
              setState(() => _crowdfund = state.crowdfund);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusBanner(),
                  SizedBox(height: 20.h),
                  _progressCard(),
                  SizedBox(height: 16.h),
                  if (_crowdfund.refundsFailed > 0) _failedCallout(),
                  const Spacer(),
                  if (!_crowdfund.isCancelling) _doneCta(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBanner() {
    final isDone = _crowdfund.isCancelled;
    final hasFailures = _crowdfund.refundsFailed > 0;
    final color = isDone
        ? (hasFailures ? const Color(0xFFFB923C) : const Color(0xFF10B981))
        : const Color(0xFFF59E0B);
    final label = isDone
        ? (hasFailures
            ? 'Refunds complete — some need help'
            : 'All contributors refunded')
        : 'Refunding contributors…';
    final icon = isDone
        ? (hasFailures ? Icons.warning_amber : Icons.check_circle)
        : Icons.sync;
    return Row(
      children: [
        Icon(icon, color: color, size: 22.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _progressCard() {
    final total = widget.totalContributions == 0
        ? widget.refundsQueued
        : widget.totalContributions;
    final completed = _crowdfund.refundsCompleted;
    final pct = total > 0 ? (completed / total).clamp(0.0, 1.0) : 1.0;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Refunded',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '$completed / $total',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8.h,
              backgroundColor: const Color(0xFF0A0A0A),
              valueColor: AlwaysStoppedAnimation<Color>(
                _crowdfund.refundsFailed > 0
                    ? const Color(0xFFFB923C)
                    : const Color(0xFF10B981),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 8.h,
            children: [
              _statChip('Pending', _crowdfund.refundsPending,
                  const Color(0xFFF59E0B)),
              _statChip('Failed', _crowdfund.refundsFailed,
                  const Color(0xFFEF4444)),
              _statChip(
                  'Refunded total',
                  null,
                  const Color(0xFF10B981),
                  amount:
                      '${_crowdfund.currency} ${_fmt(_crowdfund.totalRefunded)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label, int? count, Color color, {String? amount}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        amount != null ? '$label: $amount' : '$label: $count',
        style: GoogleFonts.inter(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _failedCallout() {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(top: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_crowdfund.refundsFailed} refund${_crowdfund.refundsFailed == 1 ? "" : "s"} need help',
            style: GoogleFonts.inter(
              color: const Color(0xFFEF4444),
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Common cause: a contributor closed their primary account. Support can route these manually — share the campaign code ${_crowdfund.crowdfundCode}.',
            style: GoogleFonts.inter(
              color: const Color(0xFFFB923C),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _doneCta() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4E03D0),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Done',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  String _fmt(double value) {
    if (value <= 0) return '0';
    final isInt = value == value.roundToDouble();
    final whole = value.floor();
    final frac =
        isInt ? '' : '.${((value - whole) * 100).round().toString().padLeft(2, '0')}';
    final w = whole.toString();
    final buf = StringBuffer();
    for (var i = 0; i < w.length; i++) {
      if (i > 0 && (w.length - i) % 3 == 0) buf.write(',');
      buf.write(w[i]);
    }
    return buf.toString() + frac;
  }
}
