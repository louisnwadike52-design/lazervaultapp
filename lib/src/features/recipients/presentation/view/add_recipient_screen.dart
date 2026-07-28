import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/mixins/bank_scan_flow_mixin.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/add_recipient.dart';

class AddRecipientScreen extends StatefulWidget {
  const AddRecipientScreen({super.key});

  @override
  State<AddRecipientScreen> createState() => _AddRecipientScreenState();
}

/// Long-flow standalone "Add recipient" screen. Hosts the shared
/// [BankScanFlowMixin] so the in-box "Scan Account" button here runs the exact
/// same live-camera → OCR → verify → route pipeline as the short flow, then
/// navigates into send-funds (this screen never sits inside the short-flow
/// inline-send host, so a resolved scan always routes via initiateSendFunds).
class _AddRecipientScreenState extends State<AddRecipientScreen>
    with BankScanFlowMixin<AddRecipientScreen> {
  String _country = 'NG';

  @override
  void initState() {
    super.initState();
    try {
      _country = serviceLocator<LocaleManager>().currentCountry;
    } catch (_) {
      _country = 'NG';
    }
  }

  @override
  String get scanCountry => _country;

  @override
  void onScanRecipientResolved(RecipientModel recipient,
          {Map<String, dynamic>? sendFundsArgs}) =>
      Get.toNamed(AppRoutes.initiateSendFunds,
          arguments: sendFundsArgs ?? recipient);

  @override
  Widget build(BuildContext context) {
    return AddRecipient(
      onScanAccount: FeatureFlags.scanAccountDetailsIsEnabled
          ? launchBankDetailsScan
          : null,
    );
  }
}
