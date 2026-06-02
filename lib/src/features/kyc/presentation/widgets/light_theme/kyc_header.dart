import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Standard KYC screen header: 70h centered logo, 24sp bold title,
/// 14sp w500 subtitle, with the spacing the BVN screen uses.
class KycHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String logoAsset;
  final IconData fallbackIcon;

  const KycHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.logoAsset = 'assets/logo/app_logo.png',
    this.fallbackIcon = Icons.account_balance_wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Container(
            width: 70.h,
            height: 70.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Image.asset(
              logoAsset,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(fallbackIcon, size: 70),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        SizedBox(height: 32.h),
      ],
    );
  }
}
