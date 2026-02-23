import 'package:flutter/material.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';

class RecurringTransferConfig {
  final RecurringFrequency frequency;
  final int scheduleDay;
  final TimeOfDay scheduleTime;
  final DateTime? endDate;

  const RecurringTransferConfig({
    required this.frequency,
    required this.scheduleDay,
    required this.scheduleTime,
    this.endDate,
  });

  String get scheduleTimeString {
    final h = scheduleTime.hour.toString().padLeft(2, '0');
    final m = scheduleTime.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get summary {
    final time = scheduleTimeString;
    String desc;
    switch (frequency) {
      case RecurringFrequency.daily:
        desc = 'Every day at $time';
      case RecurringFrequency.weekly:
        desc = 'Every ${_dayName(scheduleDay)} at $time';
      case RecurringFrequency.biweekly:
        desc = 'Every other ${_dayName(scheduleDay)} at $time';
      case RecurringFrequency.monthly:
        desc = scheduleDay >= 29
            ? 'On the last day of every month at $time'
            : 'On the ${_ordinal(scheduleDay)} of every month at $time';
    }
    if (endDate != null) {
      desc += ', until ${endDate!.day}/${endDate!.month}/${endDate!.year}';
    } else {
      desc += ', until cancelled';
    }
    return desc;
  }

  static String _dayName(int day) {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[day % 7];
  }

  static String _ordinal(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }
}
