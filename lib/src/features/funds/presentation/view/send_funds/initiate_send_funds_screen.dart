import 'package:flutter/material.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/initiate_send_funds.dart';

class InitiateSendFundsScreen extends StatefulWidget {
  const InitiateSendFundsScreen({super.key, required this.recipient});
  final RecipientModel recipient;

  @override
  State<InitiateSendFundsScreen> createState() => _InitiateSendFundsScreenState();
}

class _InitiateSendFundsScreenState extends State<InitiateSendFundsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   AppColors.secondaryBackgroundColor,
      body: InitiateSendFunds(recipient: widget.recipient)
    );
    }
} 