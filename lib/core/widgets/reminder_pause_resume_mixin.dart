import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../services/reminder_status_service.dart';

/// Shared pause/resume wiring for every bill-payment reminder list screen.
///
/// Screens mix this in, then:
///  - read [busyReminderId] to render a per-row spinner (`isProcessing:
///    busyReminderId == r.id` on [BillReminderItem]), and
///  - call [runReminderStatusChange] from the row's Pause/Resume tap.
///
/// The call is single-shot (no auto-retry) and re-fires the screen's own
/// reload on success; on failure it surfaces the server's friendly message
/// through the screen's existing snackbar affordance — never a raw exception.
mixin ReminderPauseResumeMixin<T extends StatefulWidget> on State<T> {
  /// Id of the reminder whose status change is in flight, or null when idle.
  String? busyReminderId;

  Future<void> runReminderStatusChange({
    required String billType,
    required String reminderId,
    required bool pause,
    required VoidCallback onSuccessReload,
  }) async {
    // Ignore taps while another (or the same) row is mid-flight — single-shot,
    // never a looping retry.
    if (busyReminderId != null) return;

    setState(() => busyReminderId = reminderId);

    final service = GetIt.I<ReminderStatusService>();
    final result = pause
        ? await service.pauseReminder(billType, reminderId)
        : await service.resumeReminder(billType, reminderId);

    if (!mounted) return;
    setState(() => busyReminderId = null);

    if (result.ok) {
      onSuccessReload();
    } else {
      Get.snackbar(
        'Error',
        result.message ?? 'Could not update the reminder.',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
  }
}
