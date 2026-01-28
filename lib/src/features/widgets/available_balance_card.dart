import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/typedef.dart';
import 'package:lazervault/core/utilities/generate_currency_string.dart';
import 'package:lazervault/src/features/widgets/time_period_menu.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';

class AvailableBalanceCard extends StatelessWidget {
  const AvailableBalanceCard(
      {required this.amount, required this.onTimePeriodSelected, super.key});

  final int amount;
  final void Function(TimePeriod timePeriod) onTimePeriodSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(generateCurrencyString(amount: amount),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: HybridHexColor.fromHex("#262626"),
                  )),
              TimePeriodMenu()
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Current Balance",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: HybridHexColor.fromHex("#A3A3A3"),
                  )),
              Text("Jun 06 - 12",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: HybridHexColor.fromHex("#A3A3A3"),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
