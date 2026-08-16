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
            // Wider slot so the back button's tappable background chip fits.
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Material(
                color: Colors.white.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  // Larger tappable background than the bare icon.
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No route to go back.")),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(11),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            title: Text(ScreenName.reviewFundsTransfer.displayName),
            centerTitle: true,
          ),
            body: ReviewFundsTransfer(recipient: widget.recipient),
        );
  }
}
