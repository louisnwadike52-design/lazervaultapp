import 'package:flutter/material.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/widgets/pay_electricity_bill.dart';


class PayElectricityBillScreen extends StatefulWidget {
  const PayElectricityBillScreen({super.key});

  @override
  State<PayElectricityBillScreen> createState() =>
      _PayElectricityBillScreenState();
}

class _PayElectricityBillScreenState extends State<PayElectricityBillScreen> {


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
        child: PayElectricityBill(),
      ),
    );
  }
}
