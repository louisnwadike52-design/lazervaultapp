import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Receipt shown after a pay run is processed (money is debited from the
/// business wallet and paid to employees). Reached from
/// `pay_run_details_screen` on `PayRunProcessed`. Mirrors the dark receipt
/// language used by the batch-transfer receipt, with a business (orange)
/// accent on the title chrome.
///
/// Arguments (`Get.arguments`, a string-keyed map):
///   name, periodStart, periodEnd, totalNet (double), currency,
///   employeeCount, successfulPayments, failedPayments, reference,
///   sourceAccountName, sourceAccountLast4, processedAt (ISO8601 or null),
///   payRunId.
class PayRunReceiptScreen extends StatefulWidget {
  const PayRunReceiptScreen({super.key});

  @override
  State<PayRunReceiptScreen> createState() => _PayRunReceiptScreenState();
}

class _PayRunReceiptScreenState extends State<PayRunReceiptScreen>
    with TickerProviderStateMixin {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _label = Color(0xFF9CA3AF);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);
  static const _orange = Color(0xFFFB923C);

  late final AnimationController _fadeController;
  late final AnimationController _checkController;
  late final Animation<double> _fade;
  late final Animation<double> _checkScale;

  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    _data = (Get.arguments as Map?)?.cast<String, dynamic>() ?? {};
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _checkScale =
        CurvedAnimation(parent: _checkController, curve: Curves.elasticOut);
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _checkController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _checkController.dispose();
    super.dispose();
  }

  // --- Data helpers ---
  String get _currencySymbol {
    switch ((_data['currency'] ?? 'NGN').toString().toUpperCase()) {
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'USD':
        return '\$';
      case 'ZAR':
        return 'R';
      default:
        return '₦';
    }
  }

  double get _totalNet => (_data['totalNet'] as num?)?.toDouble() ?? 0.0;
  int get _employeeCount => (_data['employeeCount'] as num?)?.toInt() ?? 0;
  int get _successful => (_data['successfulPayments'] as num?)?.toInt() ?? 0;
  int get _failed => (_data['failedPayments'] as num?)?.toInt() ?? 0;

  bool get _allPaid => _failed == 0;
  bool get _nonePaid => _successful == 0 && _employeeCount > 0;

  String get _formattedAmount =>
      '$_currencySymbol${NumberFormat('#,##0.00').format(_totalNet)}';

  String get _reference =>
      (_data['reference'] ?? _data['payRunId'] ?? '').toString();

  String get _processedAt {
    final raw = _data['processedAt']?.toString();
    final dt = (raw != null && raw.isNotEmpty)
        ? DateTime.tryParse(raw)?.toLocal()
        : DateTime.now();
    return DateFormat('MMM dd, yyyy • HH:mm').format(dt ?? DateTime.now());
  }

  String get _period {
    final start = _data['periodStart']?.toString();
    final end = _data['periodEnd']?.toString();
    if (start == null || start.isEmpty || end == null || end.isEmpty) {
      return '—';
    }
    String fmt(String s) {
      final d = DateTime.tryParse(s);
      return d != null ? DateFormat('MMM dd').format(d) : s;
    }

    return '${fmt(start)} – ${fmt(end)}';
  }

  Color get _headerColor =>
      _nonePaid ? _red : (_allPaid ? _green : _orange);

  String get _headerTitle {
    if (_nonePaid) return 'Payment Failed';
    if (_allPaid) return 'Payroll Paid';
    return 'Partially Paid';
  }

  String get _headerSubtitle {
    if (_nonePaid) return 'No employees were paid in this run';
    if (_allPaid) return 'All employees have been paid successfully';
    return '$_successful of $_employeeCount employees were paid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildStatusCard(),
                      SizedBox(height: 16.h),
                      _buildAmountCard(),
                      SizedBox(height: 16.h),
                      _buildDetailsCard(),
                    ],
                  ),
                ),
              ),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _goToPayrollHome,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pay Run Receipt',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700)),
                Text(_data['name']?.toString() ?? 'Payroll',
                    style: GoogleFonts.inter(
                        color: _label, fontSize: 12.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: _headerColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _headerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          ScaleTransition(
            scale: _checkScale,
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: _headerColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _nonePaid
                    ? Icons.close_rounded
                    : (_allPaid ? Icons.check_rounded : Icons.priority_high_rounded),
                color: Colors.white,
                size: 40.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(_headerTitle,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 6.h),
          Text(_headerSubtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _label, fontSize: 13.sp)),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          Text('Total Net Pay',
              style: GoogleFonts.inter(color: _label, fontSize: 13.sp)),
          SizedBox(height: 8.h),
          Text(_formattedAmount,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pill(Icons.groups_outlined, '$_employeeCount employees', _label),
              SizedBox(width: 8.w),
              _pill(Icons.check_circle_outline, '$_successful paid', _green),
              if (_failed > 0) ...[
                SizedBox(width: 8.w),
                _pill(Icons.error_outline, '$_failed failed', _red),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 5.w),
          Text(text,
              style: GoogleFonts.inter(
                  color: color, fontSize: 11.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    final src = _data['sourceAccountName']?.toString();
    final last4 = _data['sourceAccountLast4']?.toString();
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_outlined, color: _orange, size: 18.sp),
              SizedBox(width: 8.w),
              Text('Transaction Details',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 14.h),
          _detailRow('Pay Period', _period),
          if (src != null && src.isNotEmpty)
            _detailRow(
                'Paid From',
                last4 != null && last4.isNotEmpty
                    ? '$src •••• $last4'
                    : src),
          _detailRow('Date & Time', _processedAt),
          _detailRow(
              'Status',
              _nonePaid ? 'Failed' : (_allPaid ? 'Completed' : 'Partial'),
              valueColor: _headerColor),
          if (_reference.isNotEmpty)
            _detailRow('Reference', _reference, copyable: true),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value,
      {Color? valueColor, bool copyable = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(label,
                style: GoogleFonts.inter(color: _label, fontSize: 13.sp)),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: GestureDetector(
              onTap: copyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Reference copied',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600)),
                          backgroundColor: _card,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(value,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(
                            color: valueColor ?? Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                  if (copyable) ...[
                    SizedBox(width: 6.w),
                    Icon(Icons.copy_rounded, color: _label, size: 14.sp),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      decoration: const BoxDecoration(color: _bg),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final id =
                    (_data['payRunId'] ?? _data['reference'])?.toString();
                if (id != null && id.isNotEmpty) {
                  Get.toNamed(AppRoutes.payRunDetails, parameters: {'id': id});
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: _border),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: Text('View Pay Slips',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _goToPayrollHome,
              style: ElevatedButton.styleFrom(
                backgroundColor: _orange,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: Text('Done',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  void _goToPayrollHome() {
    Get.until((route) => route.settings.name == AppRoutes.payroll);
  }
}
