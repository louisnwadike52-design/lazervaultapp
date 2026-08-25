import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_transaction.dart';

/// Shared utility to repeat an airtime transaction from any screen.
///
/// Lands on the MAIN airtime quick-buy (Buy tab) with the previous
/// transaction's phone, amount and network prefilled — the separate legacy
/// purchase flow (recipient-input → amount → review → processing) was
/// removed in favour of the single-page quick-buy.
void repeatAirtimeTransaction(
    BuildContext context, AirtimeTransaction transaction) {
  Get.toNamed(AppRoutes.airtime, preventDuplicates: false, arguments: {
    'phoneNumber': transaction.recipientPhoneNumber,
    'amount': transaction.amount,
    'networkCode': transaction.networkProvider.name,
  });
}
