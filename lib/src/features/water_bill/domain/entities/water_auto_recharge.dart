import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import 'water_beneficiary.dart';

/// Water auto-recharge schedule. Each schedule re-pays the same water
/// account at a recurring cadence.
class WaterAutoRecharge extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String accountNumber;
  final String providerCode;
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
  final WaterBeneficiary? beneficiary;

  const WaterAutoRecharge({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.accountNumber,
    required this.providerCode,
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

  factory WaterAutoRecharge.fromProto(pb.WaterAutoRecharge proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return WaterAutoRecharge(
      id: proto.id,
      userId: proto.userId,
      beneficiaryId: proto.beneficiaryId,
      accountNumber: proto.accountNumber,
      providerCode: proto.providerCode,
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
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      beneficiary: proto.hasBeneficiary()
          ? WaterBeneficiary.fromProto(proto.beneficiary)
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, accountNumber, amount, frequency, status];
}
