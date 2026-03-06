import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Dialog showing transfer details during voice sessions.
/// User can confirm or cancel the transfer.
class VoiceTransferSummaryCard extends StatelessWidget {
  final Map<String, dynamic> transferDetails;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const VoiceTransferSummaryCard({
    super.key,
    required this.transferDetails,
    required this.onConfirm,
    required this.onCancel,
  });

  String _formatAmount(num amount, String currency) {
    final formatter = NumberFormat('#,##0.00');
    return '$currency ${formatter.format(amount)}';
  }

  String _typeLabel(String transferType) {
    switch (transferType) {
      case 'internal':
        return 'LazerVault Transfer';
      case 'domestic':
        return 'Domestic Bank Transfer';
      case 'international':
        return 'International Transfer';
      case 'phone':
        return 'Phone Transfer';
      default:
        return transferType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = (transferDetails['amount'] as num?) ?? 0;
    final currency = transferDetails['currency'] as String? ?? 'NGN';
    final recipient = transferDetails['recipient'] as String? ?? 'Unknown';
    final transferType = transferDetails['transfer_type'] as String? ?? 'internal';
    final fee = (transferDetails['fee'] as num?) ?? 0;
    final total = (transferDetails['total'] as num?) ?? amount;

    return Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header icon
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send_rounded,
                color: const Color(0xFF3B82F6),
                size: 28.sp,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Confirm Transfer',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20.h),

            // Details
            _buildDetailRow('To', recipient),
            _buildDivider(),
            _buildDetailRow('Type', _typeLabel(transferType)),
            _buildDivider(),
            _buildDetailRow('Amount', _formatAmount(amount, currency)),
            if (fee > 0) ...[
              _buildDivider(),
              _buildDetailRow('Fee', _formatAmount(fee, currency)),
            ],
            _buildDivider(),
            _buildDetailRow(
              'Total',
              _formatAmount(total, currency),
              isBold: true,
            ),

            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF9CA3AF),
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: const Color(0xFF2D2D2D), height: 1);
  }
}
