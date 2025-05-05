import 'package:flutter/material.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/widgets/stocks/stocks.dart';

class StocksScreen extends StatefulWidget {
  const StocksScreen({super.key});

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryBackgroundColor,
        body: SafeArea(child: Stocks()));
  }
}
