import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';

/// Receipt shown after a withdrawal is initiated. The payout is asynchronous
/// (held now, sent to the bank, settled via webhook/reconciler), so this reads
/// as "on its way" rather than a final "completed".
class WithdrawalReceiptScreen extends StatelessWidget {
  final double amount;
  final double fee;
  final double totalDebited;
  final String bankName;
  final String accountNumber; // masked is fine
  final String reference;
  final String currencySymbol;
  final String status; // backend status: pending|processing|completed

  const WithdrawalReceiptScreen({
    super.key,
    required this.amount,
    required this.fee,
    required this.totalDebited,
    required this.bankName,
    required this.accountNumber,
    required this.reference,
    this.currencySymbol = '₦',
    this.status = 'processing',
  });

  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF3B82F6);
  static const _success = Color(0xFF10B981);

  String _money(double v) =>
      '$currencySymbol${v.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}';

  bool get _completed => status == 'completed' || status == 'successful';

  Widget _bankLogoAvatar(String name, {double size = 48}) {
    final n = name.trim().isEmpty ? 'Bank' : name.trim();
    final initials = n.length >= 2 ? n.substring(0, 2).toUpperCase() : n.substring(0, 1).toUpperCase();
    final palettes = <List<Color>>[
      [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      [const Color(0xFF0EA5E9), const Color(0xFF2563EB)],
      [const Color(0xFF10B981), const Color(0xFF059669)],
      [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
      [const Color(0xFFEC4899), const Color(0xFF8B5CF6)],
      [const Color(0xFF14B8A6), const Color(0xFF0EA5E9)],
    ];
    final pair = palettes[n.codeUnits.fold<int>(0, (a, b) => a + b) % palettes.length];
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: pair, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14.r),
      ),
      alignment: Alignment.center,
      child: Text(initials, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.dashboard);
      },
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                  child: Column(
                    children: [
                      Container(
                        width: 84.w,
                        height: 84.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _success.withValues(alpha: 0.15),
                          border: Border.all(color: _success.withValues(alpha: 0.4), width: 2),
                        ),
                        child: Icon(_completed ? Icons.check_rounded : Icons.north_east_rounded,
                            color: _success, size: 42.sp),
                      ),
                      SizedBox(height: 18.h),
                      Text(_completed ? 'Withdrawal complete' : 'Withdrawal on its way',
                          style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800)),
                      SizedBox(height: 6.h),
                      Text(
                        _completed
                            ? 'Your money has been sent to $bankName.'
                            : 'We\'re sending your money to $bankName. It usually lands within minutes.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _textSecondary, fontSize: 13.sp),
                      ),
                      SizedBox(height: 22.h),
                      Text(_money(amount),
                          style: TextStyle(color: Colors.white, fontSize: 34.sp, fontWeight: FontWeight.w800)),
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.all(18.w),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(color: _divider),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _bankLogoAvatar(bankName),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(bankName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                                      SizedBox(height: 3.h),
                                      Text(accountNumber,
                                          style: TextStyle(color: _textSecondary, fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Divider(color: _divider, height: 1),
                            ),
                            _row('Amount', _money(amount)),
                            _row('Fee', _money(fee)),
                            _row('Total debited', _money(totalDebited), bold: true),
                            _row('Status', _completed ? 'Completed' : 'Processing',
                                valueColor: _completed ? _success : const Color(0xFFFB923C)),
                            _row('Reference', reference, copyable: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 20.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text('Done',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false, Color? valueColor, bool copyable = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: _textSecondary, fontSize: 13.sp)),
          const Spacer(),
          Flexible(
            child: GestureDetector(
              onTap: copyable
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      Get.snackbar('Copied', 'Reference copied',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: _accent.withValues(alpha: 0.9),
                          colorText: Colors.white,
                          margin: EdgeInsets.all(12.w));
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(value,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: valueColor ?? Colors.white,
                            fontSize: 13.sp,
                            fontWeight: bold ? FontWeight.w800 : FontWeight.w600)),
                  ),
                  if (copyable) ...[
                    SizedBox(width: 6.w),
                    Icon(Icons.copy_rounded, color: _textSecondary, size: 14.sp),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
