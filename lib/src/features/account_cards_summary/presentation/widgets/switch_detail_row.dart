import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchDetailRow extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final bool isCardActive; // Need card status to potentially disable switch
  final Function(bool) onChanged;

  const SwitchDetailRow({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.isCardActive, 
    required this.onChanged,
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
              color: isCardActive
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.3), 
              fontSize: 14.sp,
            ),
          ),
          GestureDetector(
            onTap: isCardActive ? () => onChanged(!isEnabled) : null, 
            child: Container(
              width: 44.w,
              height: 24.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: (isCardActive && isEnabled)
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.1),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: (isCardActive && isEnabled)
                        ? 20.w
                        : 2.w,
                    top: 2.h,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (isCardActive && isEnabled)
                            ? Colors.green[400]
                            : Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 