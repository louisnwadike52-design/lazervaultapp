import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/core/utilities/format_int_to_currency.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class TransferFunds extends StatefulWidget {
  final TransferTransaction transaction;
  final User user;

  const TransferFunds({
    super.key,
    required this.transaction,
    required this.user,
  });

  @override
  State<TransferFunds> createState() => _TransferFundsState();
}

class _TransferFundsState extends State<TransferFunds> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemedAppBar(
          title: ScreenName.selectRecipient.displayName,
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
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SenderInformation(widget: widget),
                SizedBox(height: 32.0.h),
                ReceiverInformation(widget: widget),
                SizedBox(height: 80.0.h),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.reviewTransferFunds, arguments: {
                'transaction': widget.transaction,
                'user': widget.user
              });
            },
            child: const Text("Send Request"),
          ),
        ),
      ],
    );
  }
}

class ReceiverInformation extends StatelessWidget {
  const ReceiverInformation({
    super.key,
    required this.widget,
  });

  final TransferFunds widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UniversalImageLoader(
              imagePath: AppData.dollarMoneyReceive,
              height: 28.0.h,
              width: 28.0.w,
            ),
            SizedBox(width: 8.0.w), // Corrected spacing
            Text(
              'Receiver Information',
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.w500,
                color: HybridHexColor.fromHex("#262626"),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12.0.h,
          children: [
            BuildFormField(
              name: 'accountNo',
              labelText: 'Account No',
              placeholder: '67787687786876',
            ),
            BuildFormField(
              name: 'bank',
              labelText: 'Bank Name',
              placeholder: 'Llyods Bank',
            ),
            BuildFormField(
              name: 'amount',
              labelText: 'Amount',
              placeholder:
                  formatIntToCurrency(amount: widget.transaction.amount),
            ),
            BuildFormField(
              name: 'transferFee',
              labelText: 'Transfer fee',
              placeholder: 0.00.toString(),
            ),
          ],
        ),
      ],
    );
  }
}

class SenderInformation extends StatelessWidget {
  const SenderInformation({
    super.key,
    required this.widget,
  });

  final TransferFunds widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UniversalImageLoader(
              imagePath: AppData.dollarMoneySend,
              height: 28.0.h,
              width: 28.0.w,
            ),
            SizedBox(width: 8.0.w), // Corrected spacing
            Text(
              'Sender Information',
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.w500,
                color: HybridHexColor.fromHex("#262626"),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuildFormField(
              name: 'AccountNo',
              labelText: 'Account No',
              placeholder: '67787687786876',
            ),
            SizedBox(height: 8.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Balance',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                    color: HybridHexColor.fromHex("#3784F9"),
                  ),
                ),
                Text(
                  formatIntToCurrency(amount: widget.transaction.amount),
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w500,
                    color: HybridHexColor.fromHex("#3784F9"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
