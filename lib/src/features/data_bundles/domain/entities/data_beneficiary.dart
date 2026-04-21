import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Saved contact for data-bundle purchases. Mirrors `AirtimeBeneficiary` —
/// scoped to data only on the backend (`data_beneficiaries` table) so users
/// never see airtime contacts mixed into data flows.
class DataBeneficiary extends Equatable {
  final String id;
  final String userId;
  final String phoneNumber;
  final String networkCode;
  final String networkName;
  final String? nickname;
  final String countryCode;
  final String? operatorId;
  final double? lastAmount;
  final String? lastVariationId;
  final String? lastPlanName;
  final String? lastTopupAt;
  final int topupCount;
  final String createdAt;
  final String? updatedAt;

  const DataBeneficiary({
    required this.id,
    required this.userId,
    required this.phoneNumber,
    required this.networkCode,
    required this.networkName,
    this.nickname,
    required this.countryCode,
    this.operatorId,
    this.lastAmount,
    this.lastVariationId,
    this.lastPlanName,
    this.lastTopupAt,
    this.topupCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory DataBeneficiary.fromProto(pb.DataBeneficiary proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return DataBeneficiary(
      id: proto.id,
      userId: proto.userId,
      phoneNumber: proto.phoneNumber,
      networkCode: proto.networkCode,
      networkName: proto.networkName,
      nickname: proto.nickname.isEmpty ? null : proto.nickname,
      countryCode: proto.countryCode,
      operatorId: proto.operatorId.isEmpty ? null : proto.operatorId,
      lastAmount: proto.hasLastAmount() ? proto.lastAmount : null,
      lastVariationId:
          proto.lastVariationId.isEmpty ? null : proto.lastVariationId,
      lastPlanName: proto.lastPlanName.isEmpty ? null : proto.lastPlanName,
      lastTopupAt: tsToIso(proto.hasLastTopupAt(), proto.lastTopupAt),
      topupCount: proto.hasTopupCount() ? proto.topupCount : 0,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props => [id, phoneNumber, networkCode, topupCount];
}
