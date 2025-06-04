import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isPressed
                ? const Color.fromARGB(255, 78, 3, 208)
                : Colors.grey[200]!,
            width: isPressed ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? const Color.fromARGB(255, 78, 3, 208).withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isPressed ? 15 : 10,
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
                    const Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                    const Color.fromARGB(255, 78, 3, 208).withOpacity(0.05),
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
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),

            // Description
            Text(
              widget.scanType.description,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey[600],
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