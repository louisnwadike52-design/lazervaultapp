import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/countries.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:lazervault/src/features/widgets/flat_tile.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Country selectedCountry = AppData.countries.first;
  final notificationsController = ValueNotifier<bool>(true);
  final fingerPrintController = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemedAppBar(
          title: ScreenName.myAccount.displayName,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Get.back();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No route to go back."),
                  ),
                );
              }
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AvatarWithDetails(
                  avatar: "assets/images/dp.png",
                  title: "Jane Cooper",
                ),
                const SizedBox(height: 16.0),
                FlatTile(
                  name: 'Account Number',
                  value: '78675657898976',
                ),
                const SizedBox(height: 16.0),
                FlatTile(
                  name: 'Account Type',
                  value: 'Savings',
                ),
                const SizedBox(height: 16.0),
                FlatTile(
                  name: 'Bank Name',
                  value: 'Llyods Bank',
                ),
                const SizedBox(height: 16.0),
                FlatTile(
                  name: 'Branch',
                  value: 'London',
                ),
                SizedBox(height: 32.0.h),
                Text(
                  "Share Information",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0.sp,
                  ),
                ),
                SizedBox(height: 16.0.h),
                Text("QR Code"),
                SizedBox(height: 24.0.h),
                Center(
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(
                      errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                    ),
                    data: '78675657898976',
                    width: 200.w,
                    height: 200.h,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
