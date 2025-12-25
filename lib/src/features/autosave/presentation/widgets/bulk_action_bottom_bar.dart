import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulkActionBottomBar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const BulkActionBottomBar({
    Key? key,
    required this.selectedCount,
    required this.onPause,
    required this.onResume,
    required this.onDelete,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$selectedCount selected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPause,
            icon: const Icon(Icons.pause, color: Color(0xFFF59E0B)),
            tooltip: 'Pause Selected',
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: onResume,
            icon: const Icon(Icons.play_arrow, color: Color(0xFF10B981)),
            tooltip: 'Resume Selected',
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, color: Color(0xFFEF4444)),
            tooltip: 'Delete Selected',
          ),
        ],
      ),
    );
  }
}
