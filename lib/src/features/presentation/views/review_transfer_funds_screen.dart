import 'package:flutter/material.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/review_transfer_funds.dart';

class ReviewTransferFundsScreen extends StatefulWidget {
  const ReviewTransferFundsScreen(
      {super.key, required this.user, required this.transaction});
  final User user;
  final TransferTransaction transaction;

  @override
  State<ReviewTransferFundsScreen> createState() =>
      _ReviewTransferFundsScreenState();
}

class _ReviewTransferFundsScreenState extends State<ReviewTransferFundsScreen> {


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
      body: ReviewTransferFunds(
        user: widget.user,
        transaction: widget.transaction,
      ),
    );
  }
}
