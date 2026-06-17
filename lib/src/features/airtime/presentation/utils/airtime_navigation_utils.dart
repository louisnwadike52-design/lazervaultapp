import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';

/// Shared utility to repeat an airtime transaction from any screen.
void repeatAirtimeTransaction(BuildContext context, AirtimeTransaction transaction) {
  try {
    final country = DefaultCountries.nigeria;

    final networkProvider = NetworkProvider(
      id: transaction.networkProvider.name.toLowerCase(),
      type: transaction.networkProvider,
      name: transaction.networkProvider.displayName,
      shortName: transaction.networkProvider.shortName,
      logo: transaction.networkProvider.logo,
      primaryColor: transaction.networkProvider.primaryColor,
      prefixes: transaction.networkProvider.prefixes,
      countryCode: 'NG',
    );

    Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
      'country': country,
      'networkProvider': networkProvider,
      'prefillPhone': transaction.recipientPhoneNumber,
      'prefillName': transaction.recipientName,
      'prefillAmount': transaction.amount,
      'isRepeatTransaction': true,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.repeat, color: Colors.white, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Repeating transaction...',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Failed to repeat transaction. Please try again.'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
