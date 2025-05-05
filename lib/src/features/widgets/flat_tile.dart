import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/transaction.dart';

class FlatTile extends StatelessWidget {
  const FlatTile({required this.name, required this.value, super.key});
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(name,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp,
              color: HexColor.fromHex("#262626"))),
      Text(
        value,
        style: TextStyle(
            fontSize: 14.0.sp,
            color: name == TransactionAttribute.status
                ? Colors.blue
                : HexColor.fromHex("#A3A3A3")),
      )
    ]);
  }
}
