import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Auto-mandate Toggle - lets the user opt into an auto-mandate when linking a bank.
/// Off (one-time): Uses Mono DirectPay (user authorises each deposit at their bank).
/// On (auto-mandate): Creates a Mono mandate so future deposits are seamless (DebitMandate,
/// no per-deposit approval). The account is still linked either way; the mandate is what
/// makes it "Persistent" for instant future deposits.
class RecurringAccessToggle extends StatelessWidget {
  final bool isRecurringEnabled;
  final ValueChanged<bool> onToggle;

  const RecurringAccessToggle({
    super.key,
    required this.isRecurringEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isRecurringEnabled
              ? const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        isRecurringEnabled ? Icons.link : Icons.looks_one,
                        color: const Color.fromARGB(255, 78, 3, 208),
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set up auto-mandate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            isRecurringEnabled
                                ? 'Future deposits are instant. No bank approval each time'
                                : 'You will approve each deposit at your bank',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Switch(
                value: isRecurringEnabled,
                onChanged: onToggle,
                activeThumbColor: const Color.fromARGB(255, 78, 3, 208),
                activeTrackColor: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                inactiveThumbColor: Colors.white.withValues(alpha: 0.6),
                inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
              ),
            ],
          ),
          if (isRecurringEnabled) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA502).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFFFFA502).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFFFA502),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'You can revoke access anytime in Settings',
                      style: TextStyle(
                        color: const Color(0xFFFFA502),
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
