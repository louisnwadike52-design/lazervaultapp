import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Internet-subscription reminder. Mirrors `DataReminder` but scoped to
/// internet so notification copy says "internet" and the optional
/// pre-fill on the create flow is a provider package_id, not a data
/// variation.
class InternetReminder extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String title;
  final String? description;
  final String reminderDate;
  final double? amount;
  final String? packageId;
  final String? currency;
  final bool isRecurring;
  final String? recurrenceType;
  final String status;
  final String? notifiedAt;
  final String createdAt;
  final String? updatedAt;

  const InternetReminder({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.title,
    this.description,
    required this.reminderDate,
    this.amount,
    this.packageId,
    this.currency,
    this.isRecurring = false,
    this.recurrenceType,
    required this.status,
    this.notifiedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory InternetReminder.fromProto(pb.InternetReminder proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return InternetReminder(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      title: proto.title,
      description: proto.description.isEmpty ? null : proto.description,
      reminderDate: tsToIso(proto.hasReminderDate(), proto.reminderDate) ?? '',
      amount: proto.hasAmount() ? proto.amount : null,
      packageId: proto.packageId.isEmpty ? null : proto.packageId,
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

  /// copyWith enables the reminder cubit to patch the in-memory list
  /// reactively after a status/update mutation instead of reloading the
  /// entire reminders page through its Loading → Loaded cycle.
  InternetReminder copyWith({
    String? id,
    String? userId,
    String? beneficiaryId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? packageId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
    String? status,
    String? notifiedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    return InternetReminder(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      title: title ?? this.title,
      description: description ?? this.description,
      reminderDate: reminderDate ?? this.reminderDate,
      amount: amount ?? this.amount,
      packageId: packageId ?? this.packageId,
      currency: currency ?? this.currency,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      status: status ?? this.status,
      notifiedAt: notifiedAt ?? this.notifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, title, reminderDate, status];
}
