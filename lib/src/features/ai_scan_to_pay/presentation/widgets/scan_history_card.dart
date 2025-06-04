import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/scan_entities.dart';

class ScanHistoryCard extends StatelessWidget {
  final ScanSession session;
  final VoidCallback onTap;

  const ScanHistoryCard({
    super.key,
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Status indicator and icon
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: _getStatusColor(session.status).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForScanType(session.scanType),
                    size: 24.sp,
                    color: _getStatusColor(session.status),
                  ),
                ),
                SizedBox(width: 16.w),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Scan type and status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            session.scanType.displayName,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(session.status).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              session.status.displayName,
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(session.status),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      
                      // Date and time
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14.sp,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            DateFormat('MMM dd, yyyy • hh:mm a').format(session.createdAt),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      
                      // Additional info if available
                      if (session.extractedData != null) ...[
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 14.sp,
                              color: const Color(0xFF10B981),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Data extracted successfully',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFF10B981),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ScanStatus status) {
    switch (status) {
      case ScanStatus.completed:
        return const Color(0xFF10B981);
      case ScanStatus.pending:
        return const Color(0xFFF59E0B);
      case ScanStatus.scanning:
      case ScanStatus.analyzing:
      case ScanStatus.extracting:
        return const Color.fromARGB(255, 78, 3, 208);
      case ScanStatus.failed:
        return const Color(0xFFEF4444);
      case ScanStatus.cancelled:
        return Colors.grey;
    }
  }

  IconData _getIconForScanType(ScanType scanType) {
    switch (scanType) {
      case ScanType.accountDetails:
        return Icons.account_balance;
      case ScanType.invoice:
        return Icons.receipt_long;
      case ScanType.barcode:
        return Icons.qr_code_2;
      case ScanType.utilityBill:
        return Icons.receipt;
      case ScanType.giftCard:
        return Icons.card_giftcard;
      case ScanType.qrCode:
        return Icons.qr_code_scanner;
      case ScanType.receipt:
        return Icons.receipt_outlined;
      case ScanType.bankDetails:
        return Icons.account_balance_wallet;
    }
  }
} 