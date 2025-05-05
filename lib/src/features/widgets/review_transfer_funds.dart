import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/core/utilities/display_success_dialog.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/flat_tile.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';

class ReviewTransferFunds extends StatefulWidget {
  final TransferTransaction transaction;
  final User user;

  const ReviewTransferFunds({
    super.key,
    required this.transaction,
    required this.user,
  });

  @override
  State<ReviewTransferFunds> createState() => _ReviewTransferFundsState();
}

class _ReviewTransferFundsState extends State<ReviewTransferFunds> {
  late final List<FlatTile> transactionTiles;

  @override
  void initState() {
    super.initState();
    transactionTiles = [
      FlatTile(
        name: TransactionAttribute.name.displayName,
        value: "${widget.user.firstName} ${widget.user.lastName}".trim(),
      ),
      FlatTile(
        name: TransactionAttribute.bank.displayName,
        value: widget.transaction.amount.toString(),
      ),
      FlatTile(
        name: TransactionAttribute.accountNo.displayName,
        value: widget.transaction.accountNo.toString(),
      ),
      FlatTile(
        name: TransactionAttribute.transferType.displayName,
        value: "One time payment",
      ),
      FlatTile(
        name: TransactionAttribute.transferFee.displayName,
        value: widget.transaction.transferFee.toString(),
      ),
      FlatTile(
        name: TransactionAttribute.dateTime.displayName,
        value: widget.transaction.dateTime.toString(),
      ),
    ];
  }

  void _showVerifyOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Fit content height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Verify OTP",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0.h),
                Text(
                  "Please enter your verification code sent to your phone number *********53",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: HexColor.fromHex("#A3A3A3"),
                  ),
                  textAlign: TextAlign.center,
                ),
                BuildFormField(
                  textInputType: TextInputType.number,
                  placeholder: "Enter OTP",
                  name: 'otp',
                ),
                SizedBox(height: 8.0.h),
                Row(
                  spacing: 8.0.w,
                  children: [
                    Text(
                      "Didn't receive OTP?",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: HexColor.fromHex("#A3A3A3"),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(onPressed: () {}, child: Text("Resend"))
                  ],
                ),
                SizedBox(height: 12.0.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50), // Full width
                  ),
                  onPressed: () => displaySuccessDialog(
                    context: context,
                    iconPath: "assets/images/transfer-funds.png",
                    title: "Transfer successful",
                    subtitle: "The money transfer was successful",
                    confirmationText: "View receipt",
                    dismissText: "Back to home",
                    onConfirm: () => Get.offAllNamed(AppRoutes.dashboard),
                    onDismiss: () => Get.offAllNamed(AppRoutes.dashboard),
                  ),
                  child: Text(
                    "Verify",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);
    return Column(
      children: [
        ThemedAppBar(
          title: ScreenName.reviewTransferFunds.displayName,
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
                AvatarWithDetails(
                  avatar: AppData.dp,
                ),
                SizedBox(height: 32.0.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 32.0.h),
                  height: responsiveController.screenHeight * 0.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: transactionTiles.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          transactionTiles[index],
                          SizedBox(height: 20.0.h),
                        ],
                      );
                    },
                  ),
                ),
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
              minimumSize: const Size(double.infinity, 50), // Full width
            ),
            onPressed: () {
              _showVerifyOtpBottomSheet(context); // Show the bottom sheet
            },
            child: Text(
              "Continue",
            ),
          ),
        ),
      ],
    );
  }
}
