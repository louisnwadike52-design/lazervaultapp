import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/bulk_sms_state.dart';
import 'bulk_sms_theme.dart';

/// Brief "dispatching" beat shown after the PIN-confirmed send/schedule
/// completes, before handing off to the receipt. The money move already
/// happened on the review screen — this is a visual confirmation hop.
class CampaignProcessingScreen extends StatefulWidget {
  const CampaignProcessingScreen({super.key});

  @override
  State<CampaignProcessingScreen> createState() =>
      _CampaignProcessingScreenState();
}

class _CampaignProcessingScreenState extends State<CampaignProcessingScreen> {
  SmsSendResultEntity? _result;
  bool _scheduled = false;
  int _recipientCount = 0;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _result = args['result'] as SmsSendResultEntity?;
      _scheduled = (args['scheduled'] as bool?) ?? false;
      _recipientCount = (args['recipientCount'] as int?) ?? 0;
    }
    _advance();
  }

  Future<void> _advance() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    Get.offNamed(AppRoutes.bulkSmsReceipt, arguments: {
      'result': _result,
      'scheduled': _scheduled,
      'recipientCount': _recipientCount,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BulkSmsTheme.bg,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 64.w,
              height: 64.w,
              child: const CircularProgressIndicator(
                color: BulkSmsTheme.primary,
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              _scheduled ? 'Scheduling campaign' : 'Dispatching campaign',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _scheduled
                  ? 'Queuing your message for later delivery…'
                  : 'Sending to $_recipientCount recipients…',
              style: TextStyle(
                  color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }
}
