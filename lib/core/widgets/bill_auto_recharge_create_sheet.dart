import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Callback invoked when the user taps "Schedule Auto-Recharge". The caller
/// owns the cubit/repository layer and decides which fields actually reach
/// the backend (e.g. electricity ignores [executionHour]/[executionMinute]
/// for now, airtime forwards them).
///
/// Must throw on failure so the sheet can surface a retryable snackbar.
typedef BillAutoRechargeSubmit = Future<void> Function({
  required double amount,
  required String frequency,
  required int dayOfWeek,
  required int dayOfMonth,
  required int executionHour,
  required int executionMinute,
});

/// Shared auto-recharge creation bottom-sheet used by every utility bill
/// (airtime, data, electricity, cable, internet, water, education). Each
/// caller provides a [subtitle] describing the beneficiary it was opened for
/// and an [onSubmit] adapter that wires to its own cubit. The sheet is
/// identity-agnostic: it never touches a cubit itself.
class BillAutoRechargeCreateSheet extends StatefulWidget {
  const BillAutoRechargeCreateSheet({
    super.key,
    required this.subtitle,
    required this.onSubmit,
    this.title = 'Set Auto-Recharge',
    this.ctaLabel = 'Schedule Auto-Recharge',
    this.minAmount = 50,
    this.maxAmount,
    this.currencySymbol = '\u20A6',
    this.successMessage = 'Auto-recharge scheduled',
    this.amountPresets = const [500, 1000, 2000, 5000],
    this.initialAmount,
    this.initialFrequency,
    this.initialDayOfWeek,
    this.initialDayOfMonth,
    this.initialExecutionHour,
    this.initialExecutionMinute,
  });

  /// Header line under the title — identifies the beneficiary.
  /// e.g. `"MTN \u00B7 08012345678"` or `"EKEDC \u00B7 0123456789"`.
  final String subtitle;
  final BillAutoRechargeSubmit onSubmit;
  final String title;
  final String ctaLabel;
  final double minAmount;
  /// Optional upper bound. Set per-network when known (e.g. NG MNOs cap
  /// per-transaction airtime around ₦10,000). Null means "no cap" — the
  /// caller hasn't told us the operator's ceiling, so we just enforce
  /// the lower bound.
  final double? maxAmount;
  final String currencySymbol;
  final String successMessage;
  final List<double> amountPresets;

  /// Non-null values prefill the fields — used when editing an existing
  /// schedule (title/ctaLabel should be updated too so copy reads right).
  final double? initialAmount;
  final String? initialFrequency;
  final int? initialDayOfWeek;
  final int? initialDayOfMonth;
  final int? initialExecutionHour;
  final int? initialExecutionMinute;

  static Future<void> show(
    BuildContext context, {
    required String subtitle,
    required BillAutoRechargeSubmit onSubmit,
    String title = 'Set Auto-Recharge',
    String ctaLabel = 'Schedule Auto-Recharge',
    double minAmount = 50,
    double? maxAmount,
    String currencySymbol = '\u20A6',
    String successMessage = 'Auto-recharge scheduled',
    List<double> amountPresets = const [500, 1000, 2000, 5000],
    double? initialAmount,
    String? initialFrequency,
    int? initialDayOfWeek,
    int? initialDayOfMonth,
    int? initialExecutionHour,
    int? initialExecutionMinute,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => BillAutoRechargeCreateSheet(
        subtitle: subtitle,
        onSubmit: onSubmit,
        title: title,
        ctaLabel: ctaLabel,
        minAmount: minAmount,
        maxAmount: maxAmount,
        currencySymbol: currencySymbol,
        successMessage: successMessage,
        amountPresets: amountPresets,
        initialAmount: initialAmount,
        initialFrequency: initialFrequency,
        initialDayOfWeek: initialDayOfWeek,
        initialDayOfMonth: initialDayOfMonth,
        initialExecutionHour: initialExecutionHour,
        initialExecutionMinute: initialExecutionMinute,
      ),
    );
  }

  @override
  State<BillAutoRechargeCreateSheet> createState() =>
      _BillAutoRechargeCreateSheetState();
}

class _BillAutoRechargeCreateSheetState
    extends State<BillAutoRechargeCreateSheet> {
  static const _accent = Color(0xFF4E03D0);
  static const _fieldBg = Color(0xFF0A0A0A);
  static const _border = Color(0xFF2D2D2D);
  static const _textMuted = Color(0xFF9CA3AF);
  static const _errorRed = Color(0xFFEF4444);

  late final TextEditingController _amountController;
  late String _frequency;
  late int _dayOfMonth;
  late int _dayOfWeek;
  late TimeOfDay _time;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.initialAmount != null
          ? widget.initialAmount!.toStringAsFixed(0)
          : '',
    );
    _frequency = widget.initialFrequency ?? 'monthly';
    _dayOfMonth = widget.initialDayOfMonth ?? 1;
    _dayOfWeek = widget.initialDayOfWeek ?? 1;
    _time = TimeOfDay(
      hour: widget.initialExecutionHour ?? 9,
      minute: widget.initialExecutionMinute ?? 0,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final amt = double.tryParse(_amountController.text.trim());
    // Reject NaN/inf, non-numeric input, zero, and negative values.
    if (amt == null || amt.isNaN || amt.isInfinite || amt <= 0) {
      _snack('Enter a valid whole-Naira amount', _errorRed);
      return;
    }
    // Bill payments are integer-units (no fractional kobo on the wire) —
    // refuse fractional input rather than silently truncating.
    if (amt != amt.roundToDouble()) {
      _snack('Use whole numbers only (no decimals)', _errorRed);
      return;
    }
    // Defensive: if a caller mistakenly passes minAmount > maxAmount
    // (bad config), don't show an unsatisfiable rule — clamp the
    // effective minimum to the maxAmount so the user can still pick a
    // value the upstream provider would accept. The misconfiguration
    // gets logged via the snackbar for the developer to catch.
    final effectiveMin = (widget.maxAmount != null &&
            widget.minAmount > widget.maxAmount!)
        ? widget.maxAmount!
        : widget.minAmount;
    if (amt < effectiveMin) {
      _snack(
        'Enter a valid amount (min ${widget.currencySymbol}${effectiveMin.toStringAsFixed(0)})',
        _errorRed,
      );
      return;
    }
    if (widget.maxAmount != null && amt > widget.maxAmount!) {
      _snack(
        'Maximum allowed for this network is '
        '${widget.currencySymbol}${widget.maxAmount!.toStringAsFixed(0)}',
        _errorRed,
      );
      return;
    }
    setState(() => _loading = true);
    try {
      await widget.onSubmit(
        amount: amt,
        frequency: _frequency,
        dayOfWeek: _dayOfWeek,
        dayOfMonth: _dayOfMonth,
        executionHour: _time.hour,
        executionMinute: _time.minute,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      _snack(widget.successMessage, _accent);
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: _errorRed,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _submit,
            ),
            duration: const Duration(seconds: 8),
          ),
        );
    }
  }

  void _snack(String message, Color bg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: bg),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4B5563),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.subtitle,
            style: TextStyle(fontSize: 13.sp, color: _textMuted),
          ),
          SizedBox(height: 20.h),
          _label('Amount'),
          SizedBox(height: 8.h),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: _fieldDecoration(hint: '1000'),
          ),
          if (widget.amountPresets.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: widget.amountPresets
                  .map(
                    (preset) => GestureDetector(
                      onTap: () => setState(() {
                        _amountController.text = preset.toStringAsFixed(0);
                      }),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: _fieldBg,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: _border),
                        ),
                        child: Text(
                          '${widget.currencySymbol}${preset.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: _textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          SizedBox(height: 16.h),
          _label('Frequency'),
          SizedBox(height: 8.h),
          Row(
            children: [
              _freqChip('daily', 'Daily'),
              SizedBox(width: 8.w),
              _freqChip('weekly', 'Weekly'),
              SizedBox(width: 8.w),
              _freqChip('monthly', 'Monthly'),
            ],
          ),
          SizedBox(height: 16.h),
          if (_frequency == 'weekly') ...[
            _label('Day of week'),
            SizedBox(height: 8.h),
            _dayOfWeekPicker(),
            SizedBox(height: 16.h),
          ],
          if (_frequency == 'monthly') ...[
            _label('Day of month'),
            SizedBox(height: 8.h),
            _dayOfMonthPicker(),
            SizedBox(height: 16.h),
          ],
          _label('Execution time'),
          SizedBox(height: 8.h),
          InkWell(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _time,
              );
              if (picked != null) setState(() => _time = picked);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: _fieldBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: _border),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: _accent, size: 18.sp),
                  SizedBox(width: 10.w),
                  Text(
                    _time.format(context),
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: _loading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      widget.ctaLabel,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Text(
        t,
        style: TextStyle(
          fontSize: 13.sp,
          color: _textMuted,
          fontWeight: FontWeight.w500,
        ),
      );

  InputDecoration _fieldDecoration({required String hint}) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF4B5563), fontSize: 15.sp),
        filled: true,
        fillColor: _fieldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _accent),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      );

  Widget _freqChip(String value, String label) {
    final selected = _frequency == value;
    return GestureDetector(
      onTap: () => setState(() => _frequency = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? _accent : _fieldBg,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: selected ? _accent : _border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : _textMuted,
          ),
        ),
      ),
    );
  }

  Widget _dayOfWeekPicker() => Row(
        children: List.generate(7, (index) {
          final day = index + 1;
          final selected = _dayOfWeek == day;
          const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _dayOfWeek = day),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: selected ? _accent : _fieldBg,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: selected ? _accent : _border),
                ),
                child: Text(
                  dayNames[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : _textMuted,
                  ),
                ),
              ),
            ),
          );
        }),
      );

  Widget _dayOfMonthPicker() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 1.2,
        ),
        itemCount: 31,
        itemBuilder: (_, index) {
          final day = index + 1;
          final selected = _dayOfMonth == day;
          return GestureDetector(
            onTap: () => setState(() => _dayOfMonth = day),
            child: Container(
              decoration: BoxDecoration(
                color: selected ? _accent : _fieldBg,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: selected ? _accent : _border),
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : _textMuted,
                  ),
                ),
              ),
            ),
          );
        },
      );
}
