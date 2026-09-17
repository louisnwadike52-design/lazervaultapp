import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/family_account/data/datasources/family_slots_data_source.dart';
import 'package:lazervault/src/generated/family_accounts.pbgrpc.dart'
    as family_pb;

/// Buying and managing PAID family-account slots.
///
/// The free allowance is an admin tunable. Anything beyond it is a slot the
/// user pays a monthly maintenance fee for, and this is the only place that
/// fee is explained before it is charged — the purchase debits the wallet the
/// moment it is confirmed, so the price and the recurrence are stated up front
/// rather than discovered on a statement.
class FamilySlotsSheet extends StatefulWidget {
  const FamilySlotsSheet({
    super.key,
    required this.dataSource,
    this.onChanged,
  });

  final FamilySlotsDataSource dataSource;

  /// Fired after capacity changes so the screen behind refreshes rather than
  /// showing the pre-purchase quota.
  final VoidCallback? onChanged;

  @override
  State<FamilySlotsSheet> createState() => _FamilySlotsSheetState();
}

class _FamilySlotsSheetState extends State<FamilySlotsSheet> {
  static const _bg = Color(0xFF121212);
  static const _card = Color(0xFF1C1C1E);
  static const _border = Color(0xFF2A2A2C);
  static const _accent = Color(0xFF4E03D0);
  static const _muted = Color(0xFF9CA3AF);
  static const _danger = Color(0xFFEF4444);
  static const _ok = Color(0xFF10B981);

  /// ONE key for the life of this sheet.
  ///
  /// Generated per sheet rather than per tap: if a confirm times out and the
  /// user taps again, the same key returns the slot already bought instead of
  /// selling — and charging for — a second one.
  final String _idempotencyKey = const Uuid().v4();

  family_pb.GetFamilyCapacityResponse? _capacity;
  List<family_pb.FamilyPaidSlot> _slots = const [];
  bool _loading = true;
  bool _buying = false;
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
      final results = await Future.wait([
        widget.dataSource.getCapacity(),
        widget.dataSource.listSlots(),
      ]);
      if (!mounted) return;
      setState(() {
        _capacity = results[0] as family_pb.GetFamilyCapacityResponse;
        _slots = results[1] as List<family_pb.FamilyPaidSlot>;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  /// Kobo in, naira out. Takes a plain int so both the proto's Int64 fields
  /// (via .toInt()) and computed totals go through one formatter.
  String _money(int minor, String currency) {
    final symbol = currency == 'NGN' ? '₦' : '$currency ';
    return NumberFormat.currency(symbol: symbol, decimalDigits: 2)
        .format(minor / 100.0);
  }

  Future<void> _confirmAndBuy() async {
    final cap = _capacity;
    if (cap == null || _buying) return;

    final price = _money(cap.extraSlotFeeMinor.toInt(), cap.currency);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Add a family slot',
            style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        content: Text(
          // States all three things people get wrong about a subscription:
          // what it costs, that it repeats, and that it comes out of the wallet.
          '$price will be charged to your wallet now, then every month until '
          'you cancel.\n\nThis lets you create one more Family & Friends account.',
          style: TextStyle(color: _muted, fontSize: 13.sp, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: TextStyle(color: _muted)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Pay $price',
                style: const TextStyle(
                    color: _accent, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _buying = true);
    try {
      final resp = await widget.dataSource
          .requestExtraSlot(idempotencyKey: _idempotencyKey);
      if (!mounted) return;
      setState(() => _buying = false);
      // The server returns capacity with the purchase, so the sheet redraws
      // from the response instead of a second round trip.
      if (resp.hasCapacity()) {
        setState(() => _capacity = resp.capacity);
      }
      await _load();
      widget.onChanged?.call();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resp.message.isEmpty ? 'Slot added' : resp.message),
          backgroundColor: _ok,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _buying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_friendly(e)), backgroundColor: _danger),
      );
    }
  }

  /// Turns the one failure that actually happens into something actionable.
  String _friendly(Object e) {
    final raw = e.toString();
    if (raw.toLowerCase().contains('insufficient')) {
      return 'Not enough in your wallet to cover the maintenance fee.';
    }
    return raw.replaceFirst('Exception: ', '');
  }

  Future<void> _cancelSlot(family_pb.FamilyPaidSlot slot) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Cancel this slot?',
            style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        content: Text(
          // The reassuring half matters: people expect cancelling to take away
          // what they already paid for.
          'You keep it until the end of the month you\'ve already paid for, '
          'then it stops renewing.\n\nIf you\'re using more accounts than your '
          'allowance covers, you won\'t be able to create new ones afterwards.',
          style: TextStyle(color: _muted, fontSize: 13.sp, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Keep it', style: TextStyle(color: _muted)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Cancel slot', style: TextStyle(color: _danger)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    try {
      final msg = await widget.dataSource.cancelSlot(slotId: slot.id);
      await _load();
      widget.onChanged?.call();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: _card),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_friendly(e)), backgroundColor: _danger),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
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
            SizedBox(height: 16.h),
            Text('Family account slots',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            Text('Extra accounts beyond your free allowance',
                style: TextStyle(color: _muted, fontSize: 12.sp)),
            SizedBox(height: 16.h),
            if (_loading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: const Center(child: LazerVaultLoader()),
              )
            else if (_error != null)
              _errorBlock()
            else ...[
              _capacityCard(),
              SizedBox(height: 16.h),
              _buyButton(),
              if (_slots.isNotEmpty) ...[
                SizedBox(height: 20.h),
                Text('Your slots',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _slots.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (_, i) => _slotRow(_slots[i]),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _errorBlock() => Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: _danger, size: 32.sp),
            SizedBox(height: 8.h),
            Text(_friendly(_error!),
                textAlign: TextAlign.center,
                style: TextStyle(color: _muted, fontSize: 13.sp)),
            SizedBox(height: 12.h),
            TextButton(
                onPressed: _load,
                child:
                    const Text('Try again', style: TextStyle(color: _accent))),
          ],
        ),
      );

  Widget _capacityCard() {
    final cap = _capacity!;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          _statRow('Accounts you\'ve created', '${cap.used} of ${cap.total}'),
          SizedBox(height: 10.h),
          _statRow('Free allowance', '${cap.freeAllowance}'),
          if (cap.paidSlots > 0) ...[
            SizedBox(height: 10.h),
            _statRow('Paid slots', '${cap.paidSlots}'),
          ],
          if (cap.chargeableSlots > 0) ...[
            SizedBox(height: 10.h),
            _statRow(
              'Billed monthly',
              _money(cap.chargeableSlots * cap.extraSlotFeeMinor.toInt(),
                  cap.currency),
            ),
          ],
          // A suspended slot grants nothing, which is the whole point of
          // suspending it — so it is called out rather than folded into a count.
          if (cap.suspendedSlots > 0) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: _danger.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.pause_circle_outline, color: _danger, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      '${cap.suspendedSlots} slot${cap.suspendedSlots == 1 ? '' : 's'} '
                      'paused — we couldn\'t collect the fee. Top up your wallet '
                      'and it\'ll retry.',
                      style: TextStyle(color: _danger, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statRow(String label, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: _muted, fontSize: 13.sp)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
        ],
      );

  Widget _buyButton() {
    final cap = _capacity!;
    final price = _money(cap.extraSlotFeeMinor.toInt(), cap.currency);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _buying ? null : _confirmAndBuy,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          disabledBackgroundColor: _accent.withValues(alpha: 0.4),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: _buying
            ? SizedBox(
                height: 18.h,
                width: 18.h,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Text('Add a slot — $price/month',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _slotRow(family_pb.FamilyPaidSlot slot) {
    final cancelled = slot.status == 'cancelled';
    final suspended = slot.status == 'suspended';
    final colour = cancelled
        ? _muted
        : suspended
            ? _danger
            : _ok;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_money(slot.feeMinor.toInt(), slot.currency)} / month',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(_slotSubtitle(slot),
                    style: TextStyle(color: colour, fontSize: 11.sp)),
              ],
            ),
          ),
          if (!cancelled)
            TextButton(
              onPressed: () => _cancelSlot(slot),
              child: Text('Cancel',
                  style: TextStyle(color: _muted, fontSize: 12.sp)),
            ),
        ],
      ),
    );
  }

  String _slotSubtitle(family_pb.FamilyPaidSlot slot) {
    switch (slot.status) {
      case 'cancelled':
        return 'Cancelled';
      case 'suspended':
        return slot.lastFailureReason.isEmpty
            ? 'Paused — payment failed'
            : 'Paused — ${slot.lastFailureReason}';
      default:
        final next = _shortDate(slot.nextChargeAt);
        return next == null ? 'Active' : 'Renews $next';
    }
  }

  /// Timestamps arrive as RFC3339 strings, empty when unset. An unparseable or
  /// missing date shows nothing rather than "1 Jan 1970".
  String? _shortDate(String raw) {
    if (raw.isEmpty) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return null;
    return DateFormat('d MMM yyyy').format(parsed.toLocal());
  }
}
