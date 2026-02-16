import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/id_pay_entity.dart';

class IDPayStatusBadge extends StatelessWidget {
  final IDPayStatus status;

  const IDPayStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: _textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (status) {
      case IDPayStatus.active:
        return const Color(0xFF10B981).withValues(alpha: 0.15);
      case IDPayStatus.paid:
        return const Color(0xFF3B82F6).withValues(alpha: 0.15);
      case IDPayStatus.expired:
        return const Color(0xFF9CA3AF).withValues(alpha: 0.15);
      case IDPayStatus.cancelled:
        return const Color(0xFFEF4444).withValues(alpha: 0.15);
    }
  }

  Color get _textColor {
    switch (status) {
      case IDPayStatus.active:
        return const Color(0xFF10B981);
      case IDPayStatus.paid:
        return const Color(0xFF3B82F6);
      case IDPayStatus.expired:
        return const Color(0xFF9CA3AF);
      case IDPayStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }
}
