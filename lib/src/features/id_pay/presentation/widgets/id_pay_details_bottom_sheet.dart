import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../services/id_pay_pdf_service.dart';
import 'id_pay_status_badge.dart';

class IDPayDetailsBottomSheet extends StatefulWidget {
  final IDPayEntity idPay;

  const IDPayDetailsBottomSheet({
    super.key,
    required this.idPay,
  });

  @override
  State<IDPayDetailsBottomSheet> createState() =>
      _IDPayDetailsBottomSheetState();
}

class _IDPayDetailsBottomSheetState extends State<IDPayDetailsBottomSheet> {
  bool _isDownloadingInvoice = false;

  Future<void> _downloadInvoice() async {
    if (_isDownloadingInvoice) return;

    setState(() => _isDownloadingInvoice = true);

    try {
      await IDPayPdfService.shareInvoice(idPay: widget.idPay);

      Get.snackbar(
        'Success',
        'Invoice generated successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate invoice: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      if (mounted) setState(() => _isDownloadingInvoice = false);
    }
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$currency ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final idPay = widget.idPay;

    Color statusColor;
    IconData statusIcon;
    String statusText;
    if (idPay.isPaid) {
      statusColor = const Color(0xFF3B82F6);
      statusIcon = Icons.check_circle;
      statusText = 'PAID';
    } else if (idPay.status == IDPayStatus.cancelled) {
      statusColor = const Color(0xFFEF4444);
      statusIcon = Icons.cancel;
      statusText = 'CANCELLED';
    } else if (idPay.status == IDPayStatus.expired || idPay.isExpired) {
      statusColor = const Color(0xFF9CA3AF);
      statusIcon = Icons.timer_off;
      statusText = 'EXPIRED';
    } else {
      statusColor = const Color(0xFF10B981);
      statusIcon = Icons.radio_button_checked;
      statusText = 'ACTIVE';
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'IDPay Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  statusText,
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // PayID
          _buildDetailRow('PayID', idPay.displayPayId),
          SizedBox(height: 16.h),

          // Type
          _buildDetailRow('Type', idPay.type.displayName),
          SizedBox(height: 16.h),

          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),

          // Amount
          if (idPay.isFixed) ...[
            _buildDetailRow(
              'Amount',
              '${_currencySymbol(idPay.currency)}${idPay.amount.toStringAsFixed(2)}',
              valueColor:
                  idPay.isPaid ? const Color(0xFF10B981) : const Color(0xFF3B82F6),
              isBold: true,
            ),
          ] else ...[
            _buildDetailRow(
              'Amount',
              'Flexible',
              valueColor: const Color(0xFF3B82F6),
              isBold: true,
            ),
            if (idPay.minAmount > 0) ...[
              SizedBox(height: 12.h),
              _buildDetailRow(
                'Min',
                '${_currencySymbol(idPay.currency)}${idPay.minAmount.toStringAsFixed(2)}',
              ),
            ],
            if (idPay.maxAmount > 0) ...[
              SizedBox(height: 12.h),
              _buildDetailRow(
                'Max',
                '${_currencySymbol(idPay.currency)}${idPay.maxAmount.toStringAsFixed(2)}',
              ),
            ],
          ],

          if (idPay.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', idPay.description),
          ],

          SizedBox(height: 16.h),
          _buildDetailRow(
            'Total Received',
            '${_currencySymbol(idPay.currency)}${idPay.totalReceived.toStringAsFixed(2)}',
            valueColor:
                idPay.totalReceived > 0 ? const Color(0xFF10B981) : null,
          ),

          SizedBox(height: 16.h),
          _buildDetailRow(
            'Payments',
            '${idPay.paymentCount}',
          ),

          SizedBox(height: 16.h),
          _buildDetailRow(
            'Created',
            DateFormat('MMM dd, yyyy - hh:mm a').format(idPay.createdAt),
          ),

          SizedBox(height: 16.h),
          _buildDetailRow(
            'Expires',
            DateFormat('MMM dd, yyyy - hh:mm a').format(idPay.expiresAt),
          ),

          SizedBox(height: 24.h),

          // Copy PayID + Share row
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: idPay.displayPayId));
                    Get.snackbar(
                      'Copied',
                      'PayID copied to clipboard',
                      backgroundColor: const Color(0xFF10B981),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                        color: Color(0xFF3B82F6), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: Icon(Icons.copy, size: 18.sp,
                      color: const Color(0xFF3B82F6)),
                  label: Text(
                    'Copy ID',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isDownloadingInvoice ? null : _downloadInvoice,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                        color: Color(0xFF60A5FA), width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isDownloadingInvoice
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF60A5FA),
                          ),
                        )
                      : Icon(Icons.description_outlined,
                          size: 18.sp, color: const Color(0xFF60A5FA)),
                  label: Text(
                    'Invoice',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // View Full Details button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed('/id-pay/details',
                    arguments: {'idPay': idPay});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              icon: Icon(Icons.open_in_new, size: 18.sp, color: Colors.white),
              label: Text(
                'View Full Details',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: isBold ? 18.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
