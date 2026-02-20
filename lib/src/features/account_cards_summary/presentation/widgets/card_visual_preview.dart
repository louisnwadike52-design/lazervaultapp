import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardVisualPreview extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final VoidCallback onShowPin; // Callback to trigger PIN reveal dialog

  const CardVisualPreview({ 
    super.key, 
    required this.accountArgs, 
    required this.onShowPin 
  });

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 200.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A237E),
              Color(0xFF0D47A1),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LazerVault', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                    onPressed: onShowPin, // Use the callback
                    icon: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.white,
                        size: 24.sp,
                    ),
                    tooltip: 'View PIN',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountArgs["accountNumber"] as String, // Use passed args
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CARD HOLDER',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      'EXPIRES',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Get cardholder name from args, fallback to accountNumber if not available
                      (accountArgs["cardHolderName"] as String? ??
                       accountArgs["name"] as String? ??
                       accountArgs["holderName"] as String? ??
                       accountArgs["accountNumber"] as String).toUpperCase().substring(0,
                         (accountArgs["cardHolderName"] as String? ??
                          accountArgs["name"] as String? ??
                          accountArgs["holderName"] as String? ??
                          accountArgs["accountNumber"] as String).length > 13 ? 13 : null),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      // Get expiry from args, fallback to default
                      (accountArgs["expiry"] as String? ??
                       accountArgs["expiryDate"] as String? ??
                       '12/25'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }
} 