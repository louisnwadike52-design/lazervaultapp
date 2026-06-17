import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Saved airtime contact. Mirrors `InternetBeneficiary`/`DataBeneficiary`,
/// but scoped to airtime (phone + network + optional country).
class AirtimeBeneficiary extends Equatable {
  final String id;
  final String userId;
  final String phoneNumber;
  final String networkCode;
  final String networkName;
  final String? nickname;
  final String countryCode;
  final String? operatorId;
  final double? lastAmount;
  final String? lastTopupAt;
  final int topupCount;
  final String createdAt;
  final String? updatedAt;

  const AirtimeBeneficiary({
    required this.id,
    required this.userId,
    required this.phoneNumber,
    required this.networkCode,
    required this.networkName,
    this.nickname,
    this.countryCode = 'NG',
    this.operatorId,
    this.lastAmount,
    this.lastTopupAt,
    this.topupCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory AirtimeBeneficiary.fromProto(pb.AirtimeBeneficiary proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return AirtimeBeneficiary(
      id: proto.id,
      userId: proto.userId,
      phoneNumber: proto.phoneNumber,
      networkCode: proto.networkCode,
      networkName: proto.networkName,
      nickname: proto.nickname.isEmpty ? null : proto.nickname,
      countryCode: proto.countryCode.isEmpty ? 'NG' : proto.countryCode,
      operatorId: proto.operatorId.isEmpty ? null : proto.operatorId,
      lastAmount: proto.hasLastAmount() ? proto.lastAmount : null,
      lastTopupAt: tsToIso(proto.hasLastTopupAt(), proto.lastTopupAt),
      topupCount: proto.hasTopupCount() ? proto.topupCount : 0,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props =>
      [id, phoneNumber, networkCode, nickname, topupCount];
}
