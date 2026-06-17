import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Saved exam candidate for education PIN purchases. Each beneficiary is
/// provider-scoped (e.g., WAEC, JAMB) and tracks the last purchase
/// so users can one-tap repurchase.
class EducationBeneficiary extends Equatable {
  final String id;
  final String userId;
  final String candidateNumber;
  final String examType;
  final String providerCode;
  final String providerName;
  final String? nickname;
  final String? candidateName;
  final double? lastAmount;
  final String? lastPurchaseAt;
  final int purchaseCount;
  final String createdAt;
  final String? updatedAt;

  const EducationBeneficiary({
    required this.id,
    required this.userId,
    required this.candidateNumber,
    required this.examType,
    required this.providerCode,
    required this.providerName,
    this.nickname,
    this.candidateName,
    this.lastAmount,
    this.lastPurchaseAt,
    this.purchaseCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory EducationBeneficiary.fromProto(pb.EducationBeneficiary proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return EducationBeneficiary(
      id: proto.id,
      userId: proto.userId,
      candidateNumber: proto.candidateNumber,
      examType: proto.examType,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      nickname: proto.nickname.isEmpty ? null : proto.nickname,
      candidateName: proto.candidateName.isEmpty ? null : proto.candidateName,
      lastAmount: proto.hasLastAmount() ? proto.lastAmount : null,
      lastPurchaseAt: tsToIso(proto.hasLastPurchaseAt(), proto.lastPurchaseAt),
      purchaseCount: proto.hasPurchaseCount() ? proto.purchaseCount : 0,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props =>
      [id, candidateNumber, providerCode, purchaseCount];
}
