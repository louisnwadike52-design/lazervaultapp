import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BackNavigator extends StatelessWidget {
    final VoidCallback? onPressed;
  const BackNavigator({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
          } else {
            Get.back();
          }
        },
        child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
      ),
    );
  }
}
