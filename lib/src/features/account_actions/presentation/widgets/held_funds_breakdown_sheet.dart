import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;

/// Why money is unavailable, itemised.
///
/// The account card shows an available balance and a total, and the difference
/// is money the user cannot spend. Nothing explained it — the card carried a
/// "Held" line gated on `reserved_balance`, which is zero on most accounts, so
/// the commonest cause (locked savings) produced a silently missing balance and
/// no way to ask about it.
///
/// Two different things end up here and they are NOT interchangeable:
///
///   * a HOLD — a payment in flight. You wait; it resolves on its own.
///   * a LOCK — savings the user deliberately put away, with a date.
///
/// Presenting them identically would tell someone their own savings were a
/// pending transaction, so each gets its own icon, wording and timing line.
class HeldFundsBreakdownSheet extends StatefulWidget {
  const HeldFundsBreakdownSheet({
    super.key,
    required this.accountId,
    required this.currencySymbol,
    required this.client,
  });

  final String accountId;
  final String currencySymbol;
  final accounts_pb.AccountsServiceClient client;

  @override
  State<HeldFundsBreakdownSheet> createState() =>
      _HeldFundsBreakdownSheetState();
}

class _HeldFundsBreakdownSheetState extends State<HeldFundsBreakdownSheet> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1C1C1E);
  static const _border = Color(0xFF2A2A2C);

  accounts_pb.GetMyAccountHoldsResponse? _data;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await widget.client.getMyAccountHolds(
        accounts_pb.GetMyAccountHoldsRequest(accountId: widget.accountId),
      );
      if (!mounted) return;
      setState(() {
        _data = res;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load the breakdown. Please try again.';
        _loading = false;
      });
    }
  }

  String _money(Int64ish minor) =>
      '${widget.currencySymbol}${(minor / 100).toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Money on hold',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "This is the part of your balance you can't spend right now.",
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 12.5.sp,
              ),
            ),
            SizedBox(height: 14.h),
            Flexible(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: const Center(child: LazerVaultLoader.medium()),
      );
    }

    if (_error != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            Icon(Icons.wifi_off_rounded, color: Colors.grey[600], size: 30.sp),
            SizedBox(height: 10.h),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            TextButton(onPressed: _load, child: const Text('Try again')),
          ],
        ),
      );
    }

    final data = _data!;
    final holds = data.holds;
    final gap = data.unavailableBalance.toInt();
    final listed = data.totalHeld.toInt();

    if (holds.isEmpty && gap <= 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 34.h),
        child: Column(
          children: [
            Icon(Icons.check_circle_outline,
                color: const Color(0xFF10B981), size: 32.sp),
            SizedBox(height: 10.h),
            Text(
              'Nothing is on hold',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'Your whole balance is available to spend.',
              style: GoogleFonts.inter(
                  color: Colors.grey[500], fontSize: 12.5.sp),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _totalRow(gap),
          SizedBox(height: 12.h),
          ...holds.map(_holdTile),
          // The list and the balance can disagree — a row may be missing, or
          // stale. Saying so is better than a tidy list that quietly adds up to
          // the wrong number: the person reading this is the only one who can
          // report it, and hiding it guarantees nobody does.
          if (listed != gap) _discrepancyNote(listed: listed, gap: gap),
        ],
      ),
    );
  }

  Widget _totalRow(int gap) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF4E03D0).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'On hold in total',
            style:
                GoogleFonts.inter(color: Colors.grey[400], fontSize: 11.5.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            _money(gap),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _holdTile(accounts_pb.MyAccountHold h) {
    final isLock = h.kind == 'lock';
    final colour =
        isLock ? const Color(0xFF8B5CF6) : const Color(0xFFF59E0B);

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: colour.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              isLock ? Icons.lock_outline_rounded : Icons.hourglass_top_rounded,
              color: colour,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _titleFor(h),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _subtitleFor(h),
                  style: GoogleFonts.inter(
                      color: Colors.grey[500], fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            _money(h.amount.toInt()),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// A lock carries the name its owner gave it, which identifies the money
  /// better than anything we could generate. A hold carries the reserving
  /// service's reason, which is serviceable but often terse.
  String _titleFor(accounts_pb.MyAccountHold h) {
    final raw = h.reason.trim();
    if (raw.isNotEmpty) return raw;
    return h.kind == 'lock' ? 'Locked savings' : 'Pending payment';
  }

  String _subtitleFor(accounts_pb.MyAccountHold h) {
    final isLock = h.kind == 'lock';
    final when = h.expiresAt.trim();

    if (when.isEmpty) {
      // No date is a real state for both, and each means something different —
      // inventing a date for either would be worse than saying so.
      return isLock
          ? 'No fixed date — unlock it whenever you want'
          : 'Held until the payment finishes';
    }

    final parsed = DateTime.tryParse(when);
    if (parsed == null) {
      return isLock ? 'Locked savings' : 'Pending payment';
    }
    final date = DateFormat('d MMM yyyy').format(parsed.toLocal());
    return isLock ? 'Unlocks $date' : 'Frees up by $date';
  }

  Widget _discrepancyNote({required int listed, required int gap}) {
    final missing = gap - listed;
    return Container(
      margin: EdgeInsets.only(top: 4.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded,
              color: const Color(0xFFF59E0B), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              missing > 0
                  ? "${_money(missing)} of the hold isn't itemised above. "
                      'Contact support and we will trace it.'
                  : "The items above add up to more than what's on hold. "
                      'Contact support and we will check it.',
              style: GoogleFonts.inter(
                  color: Colors.grey[300], fontSize: 12.sp, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

/// protobuf Int64 and plain int both reach [_money]; this keeps the call sites
/// readable without sprinkling `.toInt()` through the widget tree.
typedef Int64ish = int;
