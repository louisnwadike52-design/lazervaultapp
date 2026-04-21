import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import 'cable_tv_beneficiary.dart';

/// Cable TV auto-recharge (auto-renew) schedule. Each schedule re-buys
/// the SAME subscription package (`variationCode` + `packageName`) at a
/// recurring cadence. The `subscriptionType` distinguishes between
/// "renew" (extend existing) and "change" (switch package).
class CableTVAutoRecharge extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String smartCardNumber;
  final String providerCode;
  final String variationCode;
  final String packageName;
  final double amount;
  final String currency;
  final String subscriptionType;
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
  final CableTVBeneficiary? beneficiary;

  const CableTVAutoRecharge({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.smartCardNumber,
    required this.providerCode,
    required this.variationCode,
    required this.packageName,
    required this.amount,
    required this.currency,
    required this.subscriptionType,
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

  factory CableTVAutoRecharge.fromProto(pb.CableTVAutoRecharge proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return CableTVAutoRecharge(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      smartCardNumber: proto.smartCardNumber,
      providerCode: proto.providerCode,
      variationCode: proto.variationCode,
      packageName: proto.packageName,
      amount: proto.amount,
      currency: proto.currency,
      subscriptionType: proto.subscriptionType,
      frequency: proto.frequency,
      dayOfWeek: proto.dayOfWeek,
      dayOfMonth: proto.dayOfMonth,
      executionHour: proto.executionHour,
      executionMinute: proto.executionMinute,
      nextRunDate: tsToIso(proto.hasNextRunDate(), proto.nextRunDate) ?? '',
      lastRunDate: tsToIso(proto.hasLastRunDate(), proto.lastRunDate),
      status: proto.status,
      failureCount: proto.failureCount,
      maxRetries: proto.maxRetries,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      beneficiary: proto.hasBeneficiary()
          ? CableTVBeneficiary.fromProto(proto.beneficiary)
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, smartCardNumber, variationCode, amount, frequency, status];
}
