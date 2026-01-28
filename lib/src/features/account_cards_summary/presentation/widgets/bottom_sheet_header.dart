import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
     return Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.credit_card_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Card Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
  }
} 