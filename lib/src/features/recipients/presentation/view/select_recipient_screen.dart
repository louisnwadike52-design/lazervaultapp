import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/select_recipients.dart';

class SelectRecipientScreen extends StatefulWidget {
  const SelectRecipientScreen({super.key});

  @override
  State<SelectRecipientScreen> createState() => _SelectRecipientScreenState();
}

class _SelectRecipientScreenState extends State<SelectRecipientScreen> {
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
    // Short flow (admin-gated) is requested via route arguments. In short mode
    // the add-recipient UI is inline under the filters, so the "add" FAB is
    // hidden to avoid a duplicate path.
    final args = Get.arguments;
    final shortFlow = args is Map && args['shortFlow'] == true;
    final preselected = args is Map && args['preselectedRecipient'] is RecipientModel
        ? args['preselectedRecipient'] as RecipientModel
        : null;
    final autoContinue = args is Map && args['autoContinue'] == true;
    final prefillAmount = args is Map && args['prefillAmount'] is int
        ? args['prefillAmount'] as int
        : null;
    // The purple header sits behind the status bar (no AppBar), so force light
    // (white) status-bar icons for contrast against it.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: Scaffold(
      // NOTE: the entrance animation lives INSIDE SelectRecipients, wrapping
      // only the white content sheet (Scan-QR strip down) so the purple header
      // + search bar stay static. Don't re-wrap the whole widget here.
      body: SelectRecipients(
        shortFlow: shortFlow,
        preselectedRecipient: preselected,
        autoContinue: autoContinue,
        prefillAmountMinor: prefillAmount,
      ),
      // Floating Action Button for adding recipients — long flow only.
      floatingActionButton: shortFlow
          ? null
          : FloatingActionButton(
              onPressed: () => Get.toNamed(AppRoutes.addRecipient),
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              elevation: 4,
              child: Icon(Icons.add, size: 28.sp),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
