import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utilities/format_int_to_currency.dart';

class AccountSummary extends StatefulWidget {
  final String accountType;
  final double balance;
  final String accountNumber;
  final VoidCallback onDeposit;
  final VoidCallback onWithdraw;
  const AccountSummary({
    super.key,
    required this.accountType,
    required this.balance,
    required this.accountNumber,
    required this.onDeposit,
    required this.onWithdraw,
  });

  @override
  State<AccountSummary> createState() => _AccountSummaryState();
}

class _AccountSummaryState extends State<AccountSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16.0),
        Text(widget.accountType,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 8.0),
        Text(formatIntToCurrency(amount: widget.balance).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Account Number: ${widget.accountNumber}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(width: 8.0.w),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.copy,
                  color: Colors.white,
                  size: 14.0.sp,
                )),
          ],
        ),
        SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: widget.onDeposit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 201, 172, 239),
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0.h),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Deposit",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.0.w),
                  Transform.rotate(
                    angle: -0.785398,
                    child: const Icon(
                      Icons.arrow_downward,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0.w),
            ElevatedButton(
              onPressed: widget.onWithdraw,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 201, 172, 239),
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0.h),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Withdraw",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.0.w),
                  Transform.rotate(
                    angle: 0.785398,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
