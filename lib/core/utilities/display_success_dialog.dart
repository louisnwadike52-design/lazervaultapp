import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

void displaySuccessDialog({
  required BuildContext context,
  required String iconPath,
  required String title,
  required String subtitle,
  required String confirmationText,
  required String dismissText,
  required VoidCallback onConfirm,
  required VoidCallback onDismiss,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 32.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UniversalImageLoader(
                imagePath: iconPath,
                height: 100.0.h,
                width: 100.0.w,
              ),
              SizedBox(height: 8.0.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: HexColor.fromHex("#262626"),
                ),
              ),
              SizedBox(height: 8.0.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: HexColor.fromHex("#A3A3A3"),
                ),
              ),
              SizedBox(height: 16.0.h),
              ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor.fromHex("#3784F9"),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  confirmationText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: onDismiss,
                child: Text(
                  dismissText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: HexColor.fromHex("#3784F9"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
