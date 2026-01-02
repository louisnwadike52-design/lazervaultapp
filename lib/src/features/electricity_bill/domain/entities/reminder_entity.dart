import 'package:equatable/equatable.dart';

enum ReminderStatus {
  active,
  completed,
  cancelled,
}

extension ReminderStatusExtension on ReminderStatus {
  String get displayName {
    switch (this) {
      case ReminderStatus.active:
        return 'Active';
      case ReminderStatus.completed:
        return 'Completed';
      case ReminderStatus.cancelled:
        return 'Cancelled';
    }
  }

  static ReminderStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return ReminderStatus.active;
      case 'completed':
        return ReminderStatus.completed;
      case 'cancelled':
        return ReminderStatus.cancelled;
      default:
        return ReminderStatus.active;
    }
  }
}

enum ReminderRecurrenceType {
  daily,
  weekly,
  monthly,
}

extension ReminderRecurrenceTypeExtension on ReminderRecurrenceType {
  String get displayName {
    switch (this) {
      case ReminderRecurrenceType.daily:
        return 'Daily';
      case ReminderRecurrenceType.weekly:
        return 'Weekly';
      case ReminderRecurrenceType.monthly:
        return 'Monthly';
    }
  }

  static ReminderRecurrenceType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'daily':
        return ReminderRecurrenceType.daily;
      case 'weekly':
        return ReminderRecurrenceType.weekly;
      case 'monthly':
        return ReminderRecurrenceType.monthly;
      default:
        return ReminderRecurrenceType.monthly;
    }
  }
}

class PaymentReminderEntity extends Equatable {
  final String id;
  final String userId;
  final String? beneficiaryId;
  final String title;
  final String description;
  final double? amount;
  final DateTime reminderDate;
  final bool isRecurring;
  final ReminderRecurrenceType? recurrenceType;
  final ReminderStatus status;
  final DateTime? notifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PaymentReminderEntity({
    required this.id,
    required this.userId,
    this.beneficiaryId,
    required this.title,
    required this.description,
    this.amount,
    required this.reminderDate,
    required this.isRecurring,
    this.recurrenceType,
    required this.status,
    this.notifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == ReminderStatus.active;
  bool get isCompleted => status == ReminderStatus.completed;
  bool get isCancelled => status == ReminderStatus.cancelled;
  bool get isDue => DateTime.now().isAfter(reminderDate);
  bool get hasBeenNotified => notifiedAt != null;
  bool get hasBeneficiary => beneficiaryId != null;
  bool get hasAmount => amount != null;

  String get recurrenceDescription {
    if (!isRecurring || recurrenceType == null) {
      return 'One-time';
    }
    return recurrenceType!.displayName;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        beneficiaryId,
        title,
        description,
        amount,
        reminderDate,
        isRecurring,
        recurrenceType,
        status,
        notifiedAt,
        createdAt,
        updatedAt,
      ];
}
