import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/banks_data.dart';

/// Withdrawal receipt — a withdrawal variant of the send-funds (Beam) transfer
/// receipt: same dark layout (status icon, title, amount, status badge, details
/// card, action button) plus a QR code encoding the reference so it can be
/// scanned to verify/look up the payout. The payout is asynchronous (held now,
/// sent to the bank, settled via webhook/reconciler), so a processing status
/// reads as "on its way" rather than a final "completed".
class WithdrawalReceiptScreen extends StatelessWidget {
  final double amount;
  final double fee;
  final double totalDebited;
  final String bankName;
  final String accountNumber; // masked is fine
  final String reference;
  final String currencySymbol;
  final String status; // backend status: pending|processing|completed|failed

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
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);
  static const _orange = Color(0xFFF97316);
  static const _onOrange = Color(0xFF1A1206);

  bool get _completed => status == 'completed' || status == 'successful';
  bool get _failed => status == 'failed';

  Color get _statusColor => _completed
      ? _success
      : _failed
          ? _error
          : _orange;

  IconData get _statusIcon => _completed
      ? Icons.check_rounded
      : _failed
          ? Icons.close_rounded
          : Icons.north_east_rounded;

  String get _statusTitle => _completed
      ? 'Withdrawal complete'
      : _failed
          ? 'Withdrawal failed'
          : 'Withdrawal on its way';

  String get _statusLabel => _completed
      ? 'Completed'
      : _failed
          ? 'Failed'
          : 'Processing';

  String _money(double v) =>
      '$currencySymbol${v.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}';

  @override
  Widget build(BuildContext context) {
    final destBank = BanksData.displayName(bankName, null);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.dashboard);
      },
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
          title: Text('Withdrawal Receipt',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      // Status icon
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: _statusColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_statusIcon, color: _statusColor, size: 42.sp),
                      ),
                      SizedBox(height: 16.h),
                      Text(_statusTitle,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 6.h),
                      Text(_money(amount),
                          style: GoogleFonts.inter(color: _textSecondary, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: 10.h),
                      _statusBadge(),
                      SizedBox(height: 24.h),

                      // QR code for the reference
                      _buildQrCard(),
                      SizedBox(height: 16.h),

                      // Details card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(color: _divider),
                        ),
                        child: Column(
                          children: [
                            _row('Reference', reference, isCopyable: true, context: context),
                            _dividerLine(),
                            _row('To', '$destBank\n$accountNumber'),
                            _dividerLine(),
                            _row('Amount', _money(amount)),
                            _row('Fee', _money(fee)),
                            _row('Total debited', _money(totalDebited),
                                isBold: true, valueColor: _orange),
                            _dividerLine(),
                            _row('Status', _statusLabel, valueColor: _statusColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: _statusColor.withValues(alpha: 0.4)),
      ),
      child: Text(_statusLabel,
          style: GoogleFonts.inter(color: _statusColor, fontSize: 12.sp, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildQrCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          QrImageView(
            data: reference,
            version: QrVersions.auto,
            size: 150.w,
            backgroundColor: Colors.white,
            eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF0A0A0A)),
            dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square, color: Color(0xFF0A0A0A)),
          ),
          SizedBox(height: 10.h),
          Text('Scan to verify this withdrawal',
              style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 11.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 2.h),
          Text(reference,
              style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 12.sp, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: reference));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reference copied', style: GoogleFonts.inter()),
                    backgroundColor: _success,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: Icon(Icons.copy_rounded, size: 18.sp),
              label: Text('Copy ref',
                  style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: _divider),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              style: ElevatedButton.styleFrom(
                backgroundColor: _orange,
                foregroundColor: _onOrange,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text('Done',
                  style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w800, color: _onOrange)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerLine() => Divider(color: _divider, height: 16.h);

  Widget _row(String label, String value,
      {bool isBold = false, bool isCopyable = false, Color? valueColor, BuildContext? context}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp)),
          SizedBox(width: 16.w),
          Flexible(
            child: GestureDetector(
              onTap: isCopyable && context != null
                  ? () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copied to clipboard', style: GoogleFonts.inter()),
                          backgroundColor: _success,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(value,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(
                          color: valueColor ?? Colors.white,
                          fontSize: 13.sp,
                          fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                        )),
                  ),
                  if (isCopyable) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.copy_rounded, color: const Color(0xFF6B7280), size: 14.sp),
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
