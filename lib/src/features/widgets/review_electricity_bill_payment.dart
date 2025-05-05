import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/utilities/display_success_dialog.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:lazervault/src/features/widgets/flat_tile.dart';

class ReviewElectricityBillPayment extends StatefulWidget {
  final ElectricityBillDetails electricityBillDetails;

  const ReviewElectricityBillPayment(
      {super.key, required this.electricityBillDetails});

  @override
  State<ReviewElectricityBillPayment> createState() =>
      _ReviewElectricityBillPaymentState();
}

class _ReviewElectricityBillPaymentState
    extends State<ReviewElectricityBillPayment> {
  late final List<FlatTile> transactionTiles;

  @override
  void initState() {
    super.initState();
    transactionTiles = [
      FlatTile(
        name: ElectricityBillDetailsAttr.name.displayName,
        value: "Louis Nwadike",
      ),
      FlatTile(
        name: ElectricityBillDetailsAttr.amount.displayName,
        value: widget.electricityBillDetails.amount.toString(),
      ),
      FlatTile(
        name: ElectricityBillDetailsAttr.billNo.displayName,
        value: widget.electricityBillDetails.billId.toString(),
      ),
      FlatTile(
        name: ElectricityBillDetailsAttr.month.displayName,
        value: widget.electricityBillDetails.month.toString(),
      ),
      FlatTile(
        name: ElectricityBillDetailsAttr.status.displayName,
        value: widget.electricityBillDetails.status.displayName,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20.0.h,
        children: [
          AvatarWithDetails(
            avatar: AppData.dp,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 32.0.h),
            height: responsiveController.screenHeight * 0.5,
            child: ListView.builder(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              itemCount: transactionTiles.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  transactionTiles[index],
                  SizedBox(height: 20.0.h)
                ]);
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () => displaySuccessDialog(
              context: context,
              iconPath: "assets/images/electric-payment-success.png",
              title: "Paid",
              subtitle: "Your electricity bill has been paid successfully",
              confirmationText: "Done",
              dismissText: "Back to home",
              onConfirm: () => Get.offAllNamed(AppRoutes.dashboard),
              onDismiss: () => Get.offAllNamed(AppRoutes.dashboard),
            ),
            child: Text(
              "Make payment",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
