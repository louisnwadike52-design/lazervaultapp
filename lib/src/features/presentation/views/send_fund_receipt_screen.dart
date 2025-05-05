import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/widgets/send_fund_receipt.dart';

class SendFundReceiptScreen extends StatefulWidget {
  const SendFundReceiptScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  State<SendFundReceiptScreen> createState() => _SendFundReceiptScreenState();
}

class _SendFundReceiptScreenState extends State<SendFundReceiptScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Get.offAllNamed(AppRoutes.dashboard);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No route to go back.")),
                  );
                }
              },
            ),
            title: Text(ScreenName.sendFundReceipt.displayName),
            centerTitle: true,
          ),
      body: SendFundReceipt(transaction: widget.transaction),
    );
  }
}
