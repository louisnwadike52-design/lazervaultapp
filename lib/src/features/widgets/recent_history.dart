import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/recent_history_list.dart';

class RecentHistory extends StatelessWidget {
  const RecentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent History",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 78, 3, 208),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 16.sp,
                      color: Color.fromARGB(255, 78, 3, 208),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "This Month",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 20.sp,
                      color: Color.fromARGB(255, 78, 3, 208),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          RecentHistoryList()
        ],
      ),
    );
  }
}
