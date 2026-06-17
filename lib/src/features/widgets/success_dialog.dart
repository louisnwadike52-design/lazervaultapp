import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({super.key});

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
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
              imagePath: "assets/images/success.png",
              height: 100.0.h,
              width: 100.0.w,
            ),
            SizedBox(height: 8.0.h),
            Text(
              "Success",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: HybridHexColor.fromHex("#262626"),
              ),
            ),
            SizedBox(height: 8.0.h),
            Text(
              "Sent \$5000 successfully",
              style: TextStyle(
                fontSize: 14.sp,
                color: HybridHexColor.fromHex("#A3A3A3"),
              ),
            ),
            SizedBox(height: 16.0.h),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.sendFundReceipt,
                  arguments: Transaction(
                      type: TransactionType.billPay,
                      amount: 5000,
                      user: User(
                          id: 'dummy_id',
                          firstName: 'Louis',
                          lastName: 'Nwadike',
                          email: 'dummy@example.com',
                          verified: false,
                          isEmailVerified: false,
                          createdAt: DateTime.fromMillisecondsSinceEpoch(0),
                          updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
                          )
                    )
                ),
              style: ElevatedButton.styleFrom(
                backgroundColor: HybridHexColor.fromHex("#3784F9"),
                foregroundColor: Colors.white,
              ),
              child: Text(
                "View Receipt",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.dashboard),
              child: Text(
                "Back to home",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: HybridHexColor.fromHex("#3784F9"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
