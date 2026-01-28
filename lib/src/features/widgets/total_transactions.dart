import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/core/utilities/generate_currency_string.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class TotalTransactions extends StatefulWidget {
  const TotalTransactions({
    required this.title,
    required this.transactions,
    super.key,
  });
  final String title;
  final List<TransactionCard> transactions;

  @override
  State<TotalTransactions> createState() => _TotalTransactionsState();
}

class _TotalTransactionsState extends State<TotalTransactions> {
  late String _title;
  late List<TransactionCard> _transactions;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _transactions = widget.transactions;
  }

  @override
  void didUpdateWidget(covariant TotalTransactions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title) {
      setState(() {
        _title = widget.title;
      });
    }
    if (oldWidget.transactions != widget.transactions) {
      setState(() {
        _transactions = widget.transactions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveController = ResponsiveController(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: HybridHexColor.fromHex("#262626"),
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 12.h), // Spacing between title and list
        Container(
          height: !responsiveController.isMobile
              ? 300
              : 150.h, // Fixed height for the ListView
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return Container(
                width: !responsiveController.isMobile ? 150 : 90.0,
                margin: const EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  color: _transactions[index].backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: UniversalImageLoader(
                        imagePath: _transactions[index].image,
                        width: 48.0,
                        height: 48.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        _transactions[index].transaction.type.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.sp,
                          color: _transactions[index].titleColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        generateCurrencyString(
                          amount: _transactions[index].transaction.amount,
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                          color: _transactions[index].subTitleColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
