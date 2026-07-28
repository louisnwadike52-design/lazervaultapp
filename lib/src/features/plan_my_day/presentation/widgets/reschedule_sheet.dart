import 'package:flutter/material.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';

/// Opens a date picker to move a task to another day ("Change day").
///
/// Reschedule is just a due-date change, so this reuses [cubit.rescheduleTask]
/// → updateTask(dueDate:). The backend's parseDueDate accepts the RFC3339 the
/// repo sends. Returns the picked date (or null if dismissed).
Future<DateTime?> showReschedulePicker(
  BuildContext context, {
  required Task task,
  required PlanMyDayCubit cubit,
  DateTime? initialDate,
}) async {
  final now = DateTime.now();
  final picked = await showDatePicker(
    context: context,
    initialDate: task.dueDate ?? initialDate ?? now,
    firstDate: DateTime(now.year - 1),
    lastDate: DateTime(now.year + 5),
    helpText: 'Move task to day',
  );
  if (picked != null) {
    await cubit.rescheduleTask(task.id, picked);
  }
  return picked;
}
