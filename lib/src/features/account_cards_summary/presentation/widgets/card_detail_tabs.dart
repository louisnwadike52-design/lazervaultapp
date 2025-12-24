import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Needed for Get.width

class CardDetailTabs extends StatelessWidget {
  final bool showLocalDetails;
  final Function(bool) onTabSelected; // Callback to update parent state

  const CardDetailTabs({
    super.key,
    required this.showLocalDetails,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
             // Adjusted width calculation carefully
            left: showLocalDetails ? 0 : (Get.width * 0.9 - 40.w) / 2, // Use context width if possible, else Get.width
            child: Container(
               width: (Get.width * 0.9 - 40.w) / 2, // Width based on container padding (20.w * 2)
              height: 56.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.purple.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
            ),
          ),
          Row(
            children: [
              _buildTabItem(
                context,
                icon: Icons.credit_card,
                label: 'Local Card',
                isSelected: showLocalDetails,
                onTap: () => onTabSelected(true),
              ),
              _buildTabItem(
                context,
                icon: Icons.language,
                label: 'International',
                isSelected: !showLocalDetails,
                onTap: () => onTabSelected(false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent, // Ensure GestureDetector hits entire area
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                size: 20.sp,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 