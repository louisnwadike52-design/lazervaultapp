import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
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
    return Scaffold(
      body: SelectRecipients(shortFlow: shortFlow),
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
    );
  }
}
