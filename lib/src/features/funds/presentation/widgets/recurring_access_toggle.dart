import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Persistent Access Toggle - Lets user choose between one-time and persistent bank access
/// One-time: Uses Mono DirectPay (user authorizes each transaction)
/// Persistent: Uses Mono Mandate (user authorizes once, the authorisation persists for future debits)
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
                            'Keep this account linked',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            isRecurringEnabled
                                ? 'The authorisation persists so you won\'t approve again'
                                : 'You will approve each deposit individually',
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
