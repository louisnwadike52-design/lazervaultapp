import 'package:equatable/equatable.dart';

enum AirtimeReminderRecurrenceType {
  daily,
  weekly,
  monthly,
}

class AirtimeReminderEntity extends Equatable {
  final String id;
  final String userId;
  final String? beneficiaryId;
  final String title;
  final String description;
  final DateTime reminderDate;
  final double? amount;
  final String currency;
  final bool isRecurring;
  final AirtimeReminderRecurrenceType? recurrenceType;
  final String status;
  final DateTime? notifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AirtimeReminderEntity({
    required this.id,
    required this.userId,
    this.beneficiaryId,
    required this.title,
    required this.description,
    required this.reminderDate,
    this.amount,
    this.currency = 'NGN',
    this.isRecurring = false,
    this.recurrenceType,
    required this.status,
    this.notifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasBeneficiary => beneficiaryId != null && beneficiaryId!.isNotEmpty;
  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';

  @override
  List<Object?> get props => [
        id,
        userId,
        beneficiaryId,
        title,
        description,
        reminderDate,
        amount,
        currency,
        isRecurring,
        recurrenceType,
        status,
        notifiedAt,
        createdAt,
        updatedAt,
      ];
}
