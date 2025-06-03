import 'package:flutter/material.dart';
import 'package:lazervault/core/extensions/app_colors.dart';

import 'package:lazervault/src/features/widgets/request_funds.dart';

class RequestFundsScreen extends StatefulWidget {
  const RequestFundsScreen({super.key});

  @override
  State<RequestFundsScreen> createState() => _RequestFundsScreenState();
}

class _RequestFundsScreenState extends State<RequestFundsScreen> {


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
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: RequestFunds(),
      ),
    );
  }
}
