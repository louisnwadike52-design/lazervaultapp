import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/scan_entities.dart';

class ScanTypeCard extends StatefulWidget {
  final ScanType scanType;
  final VoidCallback onTap;

  const ScanTypeCard({
    super.key,
    required this.scanType,
    required this.onTap,
  });

  @override
  State<ScanTypeCard> createState() => _ScanTypeCardState();
}

class _ScanTypeCardState extends State<ScanTypeCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isPressed
                ? const Color.fromARGB(255, 78, 3, 208)
                : const Color(0xFF2D2D2D),
            width: isPressed ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? const Color.fromARGB(255, 78, 3, 208).withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
              blurRadius: isPressed ? 15 : 8,
              offset: isPressed ? const Offset(0, 6) : const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 78, 3, 208).withOpacity(0.2),
                    const Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _getIconForScanType(widget.scanType),
                  size: 28.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Title
            Text(
              widget.scanType.displayName,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),

            // Description
            Text(
              widget.scanType.description,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Colors.grey[400],
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
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