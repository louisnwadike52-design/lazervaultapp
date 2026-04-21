import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Saved smart card for cable TV subscriptions. Each beneficiary is
/// provider-scoped (e.g., DSTV, GOtv, Startimes) and tracks the last
/// subscription so users can one-tap renew.
class CableTVBeneficiary extends Equatable {
  final String id;
  final String userId;
  final String smartCardNumber;
  final String providerCode;
  final String providerName;
  final String? nickname;
  final String? customerName;
  final String? currentPackage;
  final double? lastAmount;
  final String? lastVariationCode;
  final String? lastPackageName;
  final String? lastTopupAt;
  final int topupCount;
  final String createdAt;
  final String? updatedAt;

  const CableTVBeneficiary({
    required this.id,
    required this.userId,
    required this.smartCardNumber,
    required this.providerCode,
    required this.providerName,
    this.nickname,
    this.customerName,
    this.currentPackage,
    this.lastAmount,
    this.lastVariationCode,
    this.lastPackageName,
    this.lastTopupAt,
    this.topupCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  factory CableTVBeneficiary.fromProto(pb.CableTVBeneficiary proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return CableTVBeneficiary(
      id: proto.id,
      userId: proto.userId,
      smartCardNumber: proto.smartCardNumber,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      nickname: proto.nickname.isEmpty ? null : proto.nickname,
      customerName: proto.customerName.isEmpty ? null : proto.customerName,
      currentPackage:
          proto.currentPackage.isEmpty ? null : proto.currentPackage,
      lastAmount: proto.hasLastAmount() ? proto.lastAmount : null,
      lastVariationCode:
          proto.lastVariationCode.isEmpty ? null : proto.lastVariationCode,
      lastPackageName:
          proto.lastPackageName.isEmpty ? null : proto.lastPackageName,
      lastTopupAt: tsToIso(proto.hasLastTopupAt(), proto.lastTopupAt),
      topupCount: proto.hasTopupCount() ? proto.topupCount : 0,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props =>
      [id, smartCardNumber, providerCode, topupCount];
}
