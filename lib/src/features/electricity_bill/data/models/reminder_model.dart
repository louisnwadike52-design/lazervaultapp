import '../../domain/entities/reminder_entity.dart';
import 'package:lazervault/src/generated/electricity_bill.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class BillPaymentReminderModel extends PaymentReminderEntity {
  const BillPaymentReminderModel({
    required super.id,
    required super.userId,
    super.beneficiaryId,
    required super.title,
    required super.description,
    super.amount,
    required super.reminderDate,
    required super.isRecurring,
    super.recurrenceType,
    required super.status,
    super.notifiedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BillPaymentReminderModel.fromProto(pb.BillPaymentReminder proto) {
    return BillPaymentReminderModel(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.hasBeneficiaryId() ? proto.beneficiaryId : null,
      title: proto.title,
      description: proto.description,
      amount: proto.hasAmount() ? proto.amount : null,
      reminderDate: proto.reminderDate.toDateTime(),
      isRecurring: proto.isRecurring,
      recurrenceType: proto.hasRecurrenceType()
          ? ReminderRecurrenceTypeExtension.fromString(proto.recurrenceType)
          : null,
      status: ReminderStatusExtension.fromString(proto.status),
      notifiedAt: proto.hasNotifiedAt() ? proto.notifiedAt.toDateTime() : null,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.hasUpdatedAt() ? proto.updatedAt.toDateTime() : proto.createdAt.toDateTime(),
    );
  }

  pb.BillPaymentReminder toProto() {
    final proto = pb.BillPaymentReminder()
      ..id = id
      ..userId = userId
      ..title = title
      ..description = description
      ..reminderDate = $timestamp.Timestamp.fromDateTime(reminderDate)
      ..isRecurring = isRecurring
      ..status = status.name
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt);

    if (beneficiaryId != null) {
      proto.beneficiaryId = beneficiaryId!;
    }

    if (amount != null) {
      proto.amount = amount!;
    }

    if (recurrenceType != null) {
      proto.recurrenceType = recurrenceType!.name;
    }

    if (notifiedAt != null) {
      proto.notifiedAt = $timestamp.Timestamp.fromDateTime(notifiedAt!);
    }

    proto.updatedAt = $timestamp.Timestamp.fromDateTime(updatedAt);

    return proto;
  }
}
