import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_modal.dart';
import 'package:lazervault/src/features/widgets/category_selection.dart';

/// Result of the short-flow amount sheet: the amount plus the optional
/// scheduling / recurring / category the user attached (parity with the long
/// flow). Replaces the old bare `int` return.
class SendFundsAmountResult {
  final int amountMinor;
  final DateTime? scheduledAt;
  final ServiceCategory? category;
  final RecurringTransferConfig? recurring;
  const SendFundsAmountResult({
    required this.amountMinor,
    this.scheduledAt,
    this.category,
    this.recurring,
  });
}

/// Short-flow amount entry — a bottom sheet that collects the transfer amount
/// (major units typed; returned in MINOR units) and shows a live fee from
/// [TransferCubit.getTransferFee]. Returns the amount in minor units via
/// `Navigator.pop<int>`, or `null` if cancelled.
///
/// The long flow keeps its full screen; this is the streamlined modal used when
/// the admin enables the short send-funds flow.
class SendFundsAmountSheet extends StatefulWidget {
  final String recipientName;
  final String bankName;
  final String currency; // ISO code, e.g. "NGN"
  final String transferType; // "internal" | "external"
  final String? destinationBankCode;
  final double availableBalanceMajor;

  /// Human label for the source account being debited (the dashboard's active
  /// swiped account) — e.g. "Main • ••••7890". Shown so the user sees which
  /// account + balance the payment uses.
  final String sourceAccountLabel;

  /// The screen's TransferCubit (provided above the sheet). Reused for the
  /// live fee quote so we don't construct a second instance.
  final TransferCubit transferCubit;

  const SendFundsAmountSheet({
    super.key,
    required this.recipientName,
    required this.bankName,
    required this.currency,
    required this.transferType,
    required this.transferCubit,
    required this.availableBalanceMajor,
    required this.sourceAccountLabel,
    this.destinationBankCode,
    this.initialAmountMinor,
  });

  /// Optional pre-filled amount in MINOR units (e.g. from a scanned amount-QR).
  /// Converted to the major-unit display value on open.
  final int? initialAmountMinor;

  // Matches the SelectRecipients sheet theme (white surface, purple accent).
  static const Color _bg = Colors.white;
  static const Color _card = Color(0xFFF3F4F6);
  static const Color _purple = Color.fromARGB(255, 78, 3, 208);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _error = Color(0xFFEF4444);

  @override
  State<SendFundsAmountSheet> createState() => _SendFundsAmountSheetState();
}

class _SendFundsAmountSheetState extends State<SendFundsAmountSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  Timer? _feeDebounce;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Pre-fill from a scanned amount-QR. Stored/entered value is MAJOR units;
    // convert the incoming MINOR units and drop a trailing ".00" for whole
    // amounts so it reads cleanly.
    final minor = widget.initialAmountMinor;
    if (minor != null && minor > 0) {
      final major = minor / 100.0;
      _controller.text = major == major.roundToDouble()
          ? major.toStringAsFixed(0)
          : major.toStringAsFixed(2);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _onChanged();
      });
    }
  }

  // Optional extras (parity with the long flow). Schedule and recurring are
  // mutually exclusive — setting one clears the other.
  DateTime? _scheduledAt;
  ServiceCategory? _category;
  RecurringTransferConfig? _recurring;

  Future<void> _pickCategory() async {
    final picked = await CategorySelectionBottomSheet.show(
      context,
      serviceName: 'transfer',
      categories: ServiceCategory.commonTransferCategories,
      selectedCategory: _category,
    );
    if (picked != null && mounted) setState(() => _category = picked);
  }

  Future<void> _pickSchedule() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 90)),
      helpText: 'Schedule transfer date',
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt ?? now),
      helpText: 'Schedule transfer time',
    );
    if (time == null || !mounted) return;
    setState(() {
      _scheduledAt =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      _recurring = null; // mutual exclusivity
    });
  }

  Future<void> _toggleRecurring(bool on) async {
    if (!on) {
      setState(() => _recurring = null);
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecurringTransferModal(
        initialConfig: _recurring,
        onConfigured: (config) {
          if (!mounted) return;
          setState(() {
            _recurring = config;
            _scheduledAt = null; // mutual exclusivity
          });
        },
      ),
    );
  }

  static const List<int> _quickAmounts = [1000, 2000, 5000, 10000];

  String get _symbol {
    switch (widget.currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'GHS':
        return 'GH₵';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '${widget.currency} ';
    }
  }

  /// Amount in minor units from the major-unit text, or 0 if invalid.
  int get _amountMinor {
    final v = double.tryParse(_controller.text.trim());
    if (v == null || v <= 0) return 0;
    return (v * 100).round();
  }

  void _onChanged() {
    setState(() => _error = null);
    _feeDebounce?.cancel();
    final minor = _amountMinor;
    if (minor <= 0) return;
    // Internal transfers are free; still quote so the receipt total is right.
    _feeDebounce = Timer(const Duration(milliseconds: 350), () {
      widget.transferCubit.getTransferFee(
        amountMinorUnits: minor,
        currency: widget.currency,
        transferType:
            widget.transferType == 'internal' ? 'internal' : 'domestic',
        destinationBankCode: widget.destinationBankCode,
      );
    });
  }

  String _formatSchedule(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final hh = d.hour.toString().padLeft(2, '0');
    final mn = d.minute.toString().padLeft(2, '0');
    return '$dd/$mm $hh:$mn';
  }

  Widget _optionTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: SendFundsAmountSheet._purple),
            SizedBox(width: 10.w),
            // Label takes the middle (exactly like the Repeat row's Expanded
            // column) so the pill CTA is pushed flush to the right edge —
            // matching the Repeat switch's alignment. Previously the label was
            // followed by a Spacer + a flex:1 Flexible pill, which split the free
            // space and left the pill short of the right edge.
            Expanded(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: SendFundsAmountSheet._textPrimary)),
            ),
            SizedBox(width: 8.w),
            // Compact pill CTA pinned to the right edge (last child ⇒ its right
            // edge is the row's right edge, same as the Switch below).
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 170.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: SendFundsAmountSheet._purple.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color:
                          SendFundsAmountSheet._purple.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(value,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: SendFundsAmountSheet._purple)),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16.sp, color: SendFundsAmountSheet._purple),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continue() {
    final minor = _amountMinor;
    if (minor <= 0) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    // Include the fee in the balance check when a matching quote is loaded
    // (best-effort; the backend hold is the authoritative guard).
    final lastFee = widget.transferCubit.lastFeeLoaded;
    final feeMinor = lastFee?.fee ?? 0;
    if ((minor + feeMinor) / 100.0 > widget.availableBalanceMajor) {
      setState(() => _error = feeMinor > 0
          ? 'Amount + fee exceeds your available balance'
          : 'Amount exceeds your available balance');
      return;
    }
    Navigator.of(context).pop(SendFundsAmountResult(
      amountMinor: minor,
      scheduledAt: _scheduledAt,
      category: _category,
      recurring: _recurring,
    ));
  }

  @override
  void dispose() {
    _feeDebounce?.cancel();
    _controller.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottomInset = media.viewInsets.bottom;
    // Cap the sheet to the space above the keyboard and let the content scroll,
    // so a tall sheet (amount + quick amounts + fee + extras + CTA) stays
    // anchored above the keyboard instead of clipping off the top of the screen
    // when the keyboard opens.
    final maxSheetHeight =
        media.size.height - media.padding.top - bottomInset - 24.h;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxSheetHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: SendFundsAmountSheet._bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle centered, with a close (X) at the top-right. The
                // sheet is non-dismissible by tapping outside, so the X is the
                // explicit way out (e.g. on an insufficient-balance state).
                Row(
                  children: [
                    SizedBox(width: 22.sp),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        Icons.close_rounded,
                        size: 22.sp,
                        color: SendFundsAmountSheet._textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Recipient header — avatar + name + bank.
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor:
                          SendFundsAmountSheet._purple.withValues(alpha: 0.12),
                      child: Text(
                        widget.recipientName.isNotEmpty
                            ? widget.recipientName[0].toUpperCase()
                            : '?',
                        style: GoogleFonts.inter(
                          color: SendFundsAmountSheet._purple,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.recipientName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: SendFundsAmountSheet._textPrimary,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            widget.bankName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: SendFundsAmountSheet._textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Source account (the dashboard's active swiped account) + balance.
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: SendFundsAmountSheet._card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined,
                          color: SendFundsAmountSheet._purple, size: 20.sp),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From',
                                style: GoogleFonts.inter(
                                    color: SendFundsAmountSheet._textSecondary,
                                    fontSize: 11.sp)),
                            SizedBox(height: 1.h),
                            Text(
                              widget.sourceAccountLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: SendFundsAmountSheet._textPrimary,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Balance',
                              style: GoogleFonts.inter(
                                  color: SendFundsAmountSheet._textSecondary,
                                  fontSize: 11.sp)),
                          SizedBox(height: 1.h),
                          Text(
                            '$_symbol${widget.availableBalanceMajor.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: SendFundsAmountSheet._textPrimary,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Amount',
                    style: GoogleFonts.inter(
                        color: SendFundsAmountSheet._textSecondary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                // Centered hero amount — symbol prefix + large value. A tap
                // anywhere in the box focuses the field (not just the tiny "0").
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _amountFocus.requestFocus(),
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    decoration: BoxDecoration(
                      color:
                          SendFundsAmountSheet._purple.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _error != null
                            ? SendFundsAmountSheet._error
                            : SendFundsAmountSheet._purple
                                .withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                    // Symbol + value scale together as ONE centered group. A wide
                    // amount shrinks to fit the box (scaleDown) instead of clipping,
                    // so long values are never truncated and always get full room.
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              _symbol,
                              style: GoogleFonts.inter(
                                color: SendFundsAmountSheet._textSecondary,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          IntrinsicWidth(
                            child: TextField(
                              controller: _controller,
                              focusNode: _amountFocus,
                              onChanged: (_) => _onChanged(),
                              autofocus: true,
                              textAlign: TextAlign.center,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}')),
                              ],
                              style: GoogleFonts.inter(
                                color: SendFundsAmountSheet._textPrimary,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w800,
                                height: 1.0,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                hintText: '0',
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.grey.shade300,
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_error != null) ...[
                  SizedBox(height: 8.h),
                  Text(_error!,
                      style: GoogleFonts.inter(
                          color: SendFundsAmountSheet._error, fontSize: 12.sp)),
                ],
                SizedBox(height: 14.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: _quickAmounts.map((a) {
                    return GestureDetector(
                      onTap: () {
                        _controller.text = a.toString();
                        _onChanged();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 9.h),
                        decoration: BoxDecoration(
                          color: SendFundsAmountSheet._purple
                              .withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: SendFundsAmountSheet._purple
                                  .withValues(alpha: 0.25)),
                        ),
                        child: Text(
                          '$_symbol${_grouped(a)}',
                          style: GoogleFonts.inter(
                            color: SendFundsAmountSheet._purple,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),
                // Live fee — internal is free; external quotes via the cubit.
                BlocBuilder<TransferCubit, TransferState>(
                  bloc: widget.transferCubit,
                  buildWhen: (_, s) =>
                      s is TransferFeeLoaded ||
                      s is TransferFeeLoading ||
                      s is TransferFeeError,
                  builder: (context, state) {
                    if (state is TransferFeeLoaded) {
                      final fee = state.fee / 100.0;
                      final total = state.totalAmount / 100.0;
                      return _feeRow(
                        'Fee: $_symbol${fee.toStringAsFixed(2)}',
                        'Total: $_symbol${total.toStringAsFixed(2)}',
                      );
                    }
                    if (state is TransferFeeLoading) {
                      return Text('Calculating fee…',
                          style: GoogleFonts.inter(
                              color: SendFundsAmountSheet._textSecondary,
                              fontSize: 12.sp));
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Divider(color: SendFundsAmountSheet._card, height: 26.h),
                // Optional extras — parity with the long flow.
                _optionTile(
                  icon: Icons.category_outlined,
                  label: 'Category',
                  value: _category?.displayName ?? 'Optional',
                  onTap: _pickCategory,
                ),
                if (_recurring == null)
                  _optionTile(
                    icon: Icons.schedule,
                    label: 'Schedule',
                    value: _scheduledAt == null
                        ? 'Send now'
                        : _formatSchedule(_scheduledAt!),
                    onTap: _pickSchedule,
                  ),
                if (_scheduledAt == null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      children: [
                        Icon(Icons.repeat,
                            size: 18.sp, color: SendFundsAmountSheet._purple),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Repeat',
                                  style: GoogleFonts.inter(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          SendFundsAmountSheet._textPrimary)),
                              if (_recurring != null)
                                Text(_recurring!.summary,
                                    style: GoogleFonts.inter(
                                        fontSize: 11.sp,
                                        color: SendFundsAmountSheet
                                            ._textSecondary)),
                            ],
                          ),
                        ),
                        Switch(
                          value: _recurring != null,
                          onChanged: _toggleRecurring,
                          activeThumbColor: SendFundsAmountSheet._purple,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 18.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SendFundsAmountSheet._purple,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Thousands separator for the quick-amount chips (e.g. 5000 → "5,000").
  String _grouped(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  Widget _feeRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: GoogleFonts.inter(
                color: SendFundsAmountSheet._textSecondary, fontSize: 12.sp)),
        Text(right,
            style: GoogleFonts.inter(
                color: SendFundsAmountSheet._textPrimary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
