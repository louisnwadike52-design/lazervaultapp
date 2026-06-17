import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import 'airtime_beneficiary.dart';

/// Airtime auto-recharge schedule. Mirrors `InternetAutoRecharge`
/// but for airtime top-ups. Amount (not a package) is the recurring unit.
class AirtimeAutoRecharge extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String phoneNumber;
  final String networkCode;
  final String networkName;
  final double amount;
  final String currency;
  final String frequency;
  final int dayOfWeek;
  final int dayOfMonth;
  final int executionHour;
  final int executionMinute;
  final String nextRunDate;
  final String? lastRunDate;
  final String status;
  final int failureCount;
  final int maxRetries;
  final String createdAt;
  final AirtimeBeneficiary? beneficiary;

  const AirtimeAutoRecharge({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.phoneNumber,
    required this.networkCode,
    required this.networkName,
    required this.amount,
    required this.currency,
    required this.frequency,
    this.dayOfWeek = 0,
    this.dayOfMonth = 1,
    this.executionHour = 9,
    this.executionMinute = 0,
    required this.nextRunDate,
    this.lastRunDate,
    required this.status,
    this.failureCount = 0,
    this.maxRetries = 3,
    required this.createdAt,
    this.beneficiary,
  });

  factory AirtimeAutoRecharge.fromProto(pb.AirtimeAutoRecharge proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return AirtimeAutoRecharge(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      phoneNumber: proto.phoneNumber,
      networkCode: proto.networkCode,
      networkName: proto.networkName,
      amount: proto.amount,
      currency: proto.currency,
      frequency: proto.frequency,
      dayOfWeek: proto.dayOfWeek,
      dayOfMonth: proto.dayOfMonth,
      // Proto doesn't yet expose execution hour/minute on the AutoRecharge
      // message itself; default to 09:00 local.
      nextRunDate: tsToIso(proto.hasNextRunDate(), proto.nextRunDate) ?? '',
      lastRunDate: tsToIso(proto.hasLastRunDate(), proto.lastRunDate),
      status: proto.status,
      failureCount: proto.failureCount,
      maxRetries: proto.maxRetries,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      beneficiary: proto.hasBeneficiary()
          ? AirtimeBeneficiary.fromProto(proto.beneficiary)
          : null,
    );
  }

  /// Local-only mutator used by reactive list updates (pause / resume
  /// flip the status without re-fetching the row from the backend).
  AirtimeAutoRecharge copyWith({String? status}) {
    return AirtimeAutoRecharge(
      id: id,
      userId: userId,
      beneficiaryId: beneficiaryId,
      phoneNumber: phoneNumber,
      networkCode: networkCode,
      networkName: networkName,
      amount: amount,
      currency: currency,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      executionHour: executionHour,
      executionMinute: executionMinute,
      nextRunDate: nextRunDate,
      lastRunDate: lastRunDate,
      status: status ?? this.status,
      failureCount: failureCount,
      maxRetries: maxRetries,
      createdAt: createdAt,
      beneficiary: beneficiary,
    );
  }

  @override
  List<Object?> get props =>
      [id, phoneNumber, amount, frequency, status, nextRunDate];
}
