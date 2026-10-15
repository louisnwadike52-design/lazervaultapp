import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/id_pay_entity.dart';
import 'id_pay_status_badge.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

class IDPayCard extends StatelessWidget {
  final IDPayEntity idPay;
  final VoidCallback? onTap;

  const IDPayCard({super.key, required this.idPay, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // THE NAME LEADS, THE CODE SUPPORTS IT.
                //
                // A list of "PAY-A3K9X2 / PAY-H786KF / PAY-RSW6DQ" is
                // unreadable the moment somebody has more than two, and the
                // code is not what they remember the request by. Named rows
                // lead with the name; unnamed ones keep exactly the old
                // layout, so nothing created before this field looks broken.
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: idPay.payId));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('PayID copied')),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (idPay.hasTitle)
                          Text(
                            idPay.title.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                idPay.displayPayId,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:
                                      InvoiceThemeColors.primaryPurpleLight,
                                  fontSize: idPay.hasTitle ? 13.sp : 16.sp,
                                  fontWeight: idPay.hasTitle
                                      ? FontWeight.w600
                                      : FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.copy,
                                size: 14.sp, color: const Color(0xFF9CA3AF)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                IDPayStatusBadge(status: idPay.status),
              ],
            ),
            SizedBox(height: 12.h),
            if (idPay.description.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  idPay.description,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idPay.isFixed
                          ? '${idPay.currency} ${idPay.amount.toStringAsFixed(2)}'
                          : 'Flexible Amount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (idPay.isFlexible &&
                        (idPay.minAmount > 0 || idPay.maxAmount > 0))
                      Text(
                        '${idPay.minAmount > 0 ? "Min: ${idPay.currency} ${idPay.minAmount.toStringAsFixed(2)}" : ""}'
                        '${idPay.minAmount > 0 && idPay.maxAmount > 0 ? " - " : ""}'
                        '${idPay.maxAmount > 0 ? "Max: ${idPay.currency} ${idPay.maxAmount.toStringAsFixed(2)}" : ""}',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11.sp,
                        ),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      idPay.type.displayName,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    if (idPay.paymentCount > 0)
                      Text(
                        '${idPay.paymentCount} payment${idPay.paymentCount > 1 ? 's' : ''}',
                        style: TextStyle(
                          color: const Color(0xFF10B981),
                          fontSize: 11.sp,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
