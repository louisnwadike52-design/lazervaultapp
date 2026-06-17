import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/recipient.dart';
import 'package:lazervault/core/utilities/generate_currency_string.dart';
import 'package:lazervault/src/features/widgets/flat_tile.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';

class ReviewFundsTransfer extends StatefulWidget {
  const ReviewFundsTransfer({super.key, required this.recipient});

  final Recipient recipient;

  @override
  State<ReviewFundsTransfer> createState() => _ReviewFundsTransferState();
}

class _ReviewFundsTransferState extends State<ReviewFundsTransfer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0.h),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 67, 87, 234),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 4.0.w,
              children: [
                Icon(Icons.star, color: Colors.white, size: 24.sp),
                const Text(
                  "You get +0.0pts as reward for this transfer",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 16.0.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                spacing: 16.0.h,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8.0.w,
                    children: [
                      RoundedCenteredImage(
                          imagePath: AppData.defaultAvatar,
                          size: 50.0.w,
                          backgroundColor:
                              const Color.fromARGB(0, 221, 219, 219)),
                      Icon(Icons.arrow_forward, size: 24.sp),
                      RoundedCenteredImage(
                          imagePath: AppData.defaultAvatar,
                          size: 50.0.w,
                          backgroundColor:
                              const Color.fromARGB(0, 221, 219, 219)),
                    ],
                  ),
                  FlatTile(
                      name: "You're sending",
                      value: generateCurrencyString(amount: 5689)),
                  FlatTile(
                      name: "They'll receive",
                      value: generateCurrencyString(amount: 5689)),
                  FlatTile(
                      name: "Transfer Fees",
                      value: generateCurrencyString(amount: 0.00)),
                ],
              )),
          Container(
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 16.0.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                spacing: 16.0.h,
                children: [
                  FlatTile(name: "To", value: "Louis Nwadike"),
                  FlatTile(name: "Account Number", value: "00000000000000000"),
                  FlatTile(name: "Bank Name", value: "First Bank"),
                  FlatTile(name: "Estimated Time Delivery", value: "1 minute"),
                ],
              )),
          SizedBox(height: 32.0.h),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.inputPin);
              },
              child: Text("Confirm Transfer",
                  style: TextStyle(fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }
}
