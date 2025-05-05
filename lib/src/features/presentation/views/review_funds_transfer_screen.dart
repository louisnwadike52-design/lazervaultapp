import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/recipient.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/review_funds_transfer.dart';

class ReviewFundsTransferScreen extends StatefulWidget {
  const ReviewFundsTransferScreen({super.key, required this.recipient});

  final Recipient recipient;

  @override
  State<ReviewFundsTransferScreen> createState() =>
      _ReviewFundsTransferScreenState();
}

class _ReviewFundsTransferScreenState extends State<ReviewFundsTransferScreen> {


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
    return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Get.back();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No route to go back.")),
                  );
                }
              },
            ),
            title: Text(ScreenName.reviewFundsTransfer.displayName),
            centerTitle: true,
          ),
            body: ReviewFundsTransfer(recipient: widget.recipient),
        );
  }
}
