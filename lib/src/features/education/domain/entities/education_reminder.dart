import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Education exam date / payment reminder. The backend
/// `EducationReminderTimerWorker` fires notifications at the exact
/// `reminder_date` -- this entity only renders state.
class EducationReminder extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String title;
  final String? description;
  final String reminderDate;
  final double? amount;
  final String? currency;
  final bool isRecurring;
  final String? recurrenceType;
  final String status;
  final String? notifiedAt;
  final String createdAt;
  final String? updatedAt;

  const EducationReminder({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.title,
    this.description,
    required this.reminderDate,
    this.amount,
    this.currency,
    this.isRecurring = false,
    this.recurrenceType,
    required this.status,
    this.notifiedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory EducationReminder.fromProto(pb.EducationReminder proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return EducationReminder(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      title: proto.title,
      description: proto.description.isEmpty ? null : proto.description,
      reminderDate: tsToIso(proto.hasReminderDate(), proto.reminderDate) ?? '',
      amount: proto.hasAmount() ? proto.amount : null,
      currency: proto.currency.isEmpty ? null : proto.currency,
      isRecurring: proto.isRecurring,
      recurrenceType:
          proto.recurrenceType.isEmpty ? null : proto.recurrenceType,
      status: proto.status,
      notifiedAt: tsToIso(proto.hasNotifiedAt(), proto.notifiedAt),
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props => [id, title, reminderDate, status];
}
