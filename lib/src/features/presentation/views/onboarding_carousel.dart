import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingCarousel extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingCarousel(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Image.network(
          image,
          fit: BoxFit.cover,
          height: 300.h,
          width: 300.w,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.error, size: 100.sp),
        ),
      ),
      SizedBox(height: 40.h),
      Expanded(
          child: Column(
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 16.h),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
        ],
      ))
    ]);
  }
}
