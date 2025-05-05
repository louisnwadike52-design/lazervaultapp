import 'package:flutter/material.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/transfer_funds.dart';

class TransferFundsScreen extends StatefulWidget {
  const TransferFundsScreen(
      {super.key, required this.user, required this.transaction});
  final User user;
  final TransferTransaction transaction;

  @override
  State<TransferFundsScreen> createState() => _TransferFundsScreenState();
}

class _TransferFundsScreenState extends State<TransferFundsScreen> {


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
      body: TransferFunds(
        user: widget.user,
        transaction: widget.transaction,
      ),
    );
  }
}
