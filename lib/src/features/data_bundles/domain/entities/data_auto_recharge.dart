import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import 'data_beneficiary.dart';

/// Data auto-recharge ("Rollover") schedule. Mirrors `AirtimeAutoRecharge`
/// but variation-locked: every run re-buys the SAME data plan
/// (`variationId` + `planName`) so users don't get surprise pricing when
/// providers retire bundles.
class DataAutoRecharge extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String phoneNumber;
  final String networkCode;
  final String networkName;
  final String variationId;
  final String planName;
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
  final String countryCode;
  final String createdAt;
  final DataBeneficiary? beneficiary;

  const DataAutoRecharge({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.phoneNumber,
    required this.networkCode,
    required this.networkName,
    required this.variationId,
    required this.planName,
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
    this.countryCode = 'NG',
    required this.createdAt,
    this.beneficiary,
  });

  factory DataAutoRecharge.fromProto(pb.DataAutoRecharge proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return DataAutoRecharge(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      phoneNumber: proto.phoneNumber,
      networkCode: proto.networkCode,
      networkName: proto.networkName,
      variationId: proto.variationId,
      planName: proto.planName,
      amount: proto.amount,
      currency: proto.currency,
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
      countryCode: proto.hasBeneficiary() && proto.beneficiary.countryCode.isNotEmpty
          ? proto.beneficiary.countryCode
          : 'NG',
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      beneficiary: proto.hasBeneficiary()
          ? DataBeneficiary.fromProto(proto.beneficiary)
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, phoneNumber, variationId, amount, frequency, status];
}
