import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;
  final bool isPositive;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isHighlighted = false,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted
                  ? (isPositive ? Colors.green[300] : Colors.red[300])
                  : Colors.white,
              fontSize: 14.sp,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 