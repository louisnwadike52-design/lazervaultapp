import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';

class AvatarWithDetails extends StatelessWidget {
  const AvatarWithDetails(
      {required this.avatar, this.title, this.subTitle, super.key});

  final String avatar;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 32.0.r,
          backgroundImage: AssetImage(avatar),
        ),
        title == null
            ? const SizedBox.shrink()
            : Column(children: [
                SizedBox(height: 12.0.h),
                Text(
                  title ?? "",
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex("#262626"),
                  ),
                ),
              ]),
        subTitle == null
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 12.0.h),
                  Text(
                    subTitle ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: HexColor.fromHex("#A3A3A3"),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
