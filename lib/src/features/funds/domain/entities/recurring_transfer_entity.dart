import 'package:equatable/equatable.dart';

enum RecurringFrequency {
  daily,
  weekly,
  biweekly,
  monthly;

  String get label {
    switch (this) {
      case RecurringFrequency.daily:
        return 'Daily';
      case RecurringFrequency.weekly:
        return 'Weekly';
      case RecurringFrequency.biweekly:
        return 'Bi-Weekly';
      case RecurringFrequency.monthly:
        return 'Monthly';
    }
  }
}

enum RecurringTransferStatus {
  active,
  paused,
  cancelled,
  expired;

  String get label {
    switch (this) {
      case RecurringTransferStatus.active:
        return 'Active';
      case RecurringTransferStatus.paused:
        return 'Paused';
      case RecurringTransferStatus.cancelled:
        return 'Cancelled';
      case RecurringTransferStatus.expired:
        return 'Expired';
    }
  }
}

class RecurringTransferEntity extends Equatable {
  final String id;
  final String userId;
  final String accountId;
  final String recipientAccountNumber;
  final String recipientName;
  final String recipientBankCode;
  final String recipientBankName;
  final String transferType;
  final double amount;
  final String currency;
  final String description;
  final RecurringFrequency frequency;
  final int scheduleDay;
  final String scheduleTime;
  final RecurringTransferStatus status;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? nextRunAt;
  final int totalExecutions;
  final int successfulExecutions;
  final int failedExecutions;
  final int consecutiveFailures;
  final DateTime? lastExecutedAt;
  final String lastFailureReason;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RecurringTransferEntity({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.recipientAccountNumber,
    required this.recipientName,
    this.recipientBankCode = '',
    this.recipientBankName = '',
    this.transferType = 'internal',
    required this.amount,
    required this.currency,
    this.description = '',
    required this.frequency,
    this.scheduleDay = 0,
    this.scheduleTime = '09:00',
    required this.status,
    required this.startDate,
    this.endDate,
    this.nextRunAt,
    this.totalExecutions = 0,
    this.successfulExecutions = 0,
    this.failedExecutions = 0,
    this.consecutiveFailures = 0,
    this.lastExecutedAt,
    this.lastFailureReason = '',
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == RecurringTransferStatus.active;
  bool get isPaused => status == RecurringTransferStatus.paused;
  bool get isInternal => transferType == 'internal';

  String get scheduleDescription {
    final time = scheduleTime;
    switch (frequency) {
      case RecurringFrequency.daily:
        return 'Every day at $time';
      case RecurringFrequency.weekly:
        return 'Every ${_dayName(scheduleDay)} at $time';
      case RecurringFrequency.biweekly:
        return 'Every other ${_dayName(scheduleDay)} at $time';
      case RecurringFrequency.monthly:
        if (scheduleDay >= 29) {
          return 'On the last day of every month at $time';
        }
        return 'On the ${_ordinal(scheduleDay)} of every month at $time';
    }
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

  @override
  List<Object?> get props => [
        id, userId, accountId, recipientAccountNumber, recipientName,
        amount, currency, frequency, scheduleDay, scheduleTime,
        status, nextRunAt, totalExecutions, successfulExecutions,
        failedExecutions, consecutiveFailures, updatedAt,
      ];
}

class RecurringTransferExecutionEntity extends Equatable {
  final String id;
  final String recurringTransferId;
  final String? paymentId;
  final String reference;
  final String status;
  final double amount;
  final double fee;
  final String currency;
  final String failureReason;
  final DateTime scheduledFor;
  final DateTime executedAt;

  const RecurringTransferExecutionEntity({
    required this.id,
    required this.recurringTransferId,
    this.paymentId,
    required this.reference,
    required this.status,
    required this.amount,
    this.fee = 0,
    required this.currency,
    this.failureReason = '',
    required this.scheduledFor,
    required this.executedAt,
  });

  bool get isSuccess => status == 'success';

  @override
  List<Object?> get props => [id, recurringTransferId, status, amount, executedAt];
}
