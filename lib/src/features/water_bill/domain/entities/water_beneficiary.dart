import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Saved account number for water bill payments. Each beneficiary is
/// provider-scoped (e.g., LSWC, FCT-WB) and tracks the last payment
/// so users can one-tap repay.
class WaterBeneficiary extends Equatable {
  final String id;
  final String userId;
  final String accountNumber;
  final String providerCode;
  final String providerName;
  final String? nickname;
  final String? customerName;
  final double? lastAmount;
  final String? lastTopupAt;
  final int topupCount;
  final String createdAt;
  final String? updatedAt;

  const WaterBeneficiary({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.providerCode,
    required this.providerName,
    this.nickname,
    this.customerName,
    this.lastAmount,
    this.lastTopupAt,
    this.topupCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory WaterBeneficiary.fromProto(pb.WaterBeneficiary proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return WaterBeneficiary(
      id: proto.id,
      userId: proto.userId,
      accountNumber: proto.accountNumber,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      nickname: proto.nickname.isEmpty ? null : proto.nickname,
      customerName: proto.customerName.isEmpty ? null : proto.customerName,
      lastAmount: proto.hasLastAmount() ? proto.lastAmount : null,
      lastTopupAt: tsToIso(proto.hasLastTopupAt(), proto.lastTopupAt),
      topupCount: proto.hasTopupCount() ? proto.topupCount : 0,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props =>
      [id, accountNumber, providerCode, topupCount];
}
