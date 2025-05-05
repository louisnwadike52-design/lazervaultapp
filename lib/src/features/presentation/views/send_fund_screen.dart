import 'package:flutter/material.dart';
// Import for SystemUiOverlayStyle
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/send_fund.dart';

class SendFundScreen extends StatefulWidget {
  const SendFundScreen({super.key, required this.recipient});

  final User recipient;

  @override
  State<SendFundScreen> createState() => _SendFundScreenState();
}

class _SendFundScreenState extends State<SendFundScreen> {

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
      body: SendFund(recipient: widget.recipient),
    );
  }
}
