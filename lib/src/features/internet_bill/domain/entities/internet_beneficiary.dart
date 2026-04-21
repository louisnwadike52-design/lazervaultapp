import 'package:equatable/equatable.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;

/// Saved ISP account for internet subscriptions. Mirrors `DataBeneficiary`,
/// scoped to internet only on the backend (`internet_beneficiaries` table)
/// so ISP accounts don't mix into airtime/data flows.
class InternetBeneficiary extends Equatable {
  final String id;
  final String userId;
  final String accountNumber;
  final String providerCode;
  final String providerName;
  final String? nickname;
  final double? lastAmount;
  final String? lastPackageId;
  final String? lastPlanName;
  final String? lastTopupAt;
  final int topupCount;
  final String createdAt;
  final String? updatedAt;

  const InternetBeneficiary({
    required this.id,
    required this.userId,
    required this.accountNumber,
    required this.providerCode,
    required this.providerName,
    this.nickname,
    this.lastAmount,
    this.lastPackageId,
    this.lastPlanName,
    this.lastTopupAt,
    this.topupCount = 0,
    required this.createdAt,
    this.updatedAt,
  });

  /// Clone with an updated nickname. Used by the beneficiary cubit to
  /// synthesise a local patch when the update RPC succeeds but the
  /// backend doesn't echo the row back — we already know the only
  /// field that changed, so we can keep the list rebuild in place
  /// instead of fetching the whole beneficiaries endpoint again.
  InternetBeneficiary copyWithNickname(String? nickname) {
    return InternetBeneficiary(
      id: id,
      userId: userId,
      accountNumber: accountNumber,
      providerCode: providerCode,
      providerName: providerName,
      nickname: (nickname != null && nickname.isEmpty) ? null : nickname,
      lastAmount: lastAmount,
      lastPackageId: lastPackageId,
      lastPlanName: lastPlanName,
      lastTopupAt: lastTopupAt,
      topupCount: topupCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory InternetBeneficiary.fromProto(pb.InternetBeneficiary proto) {
    String? tsToIso(bool has, dynamic ts) => has
        ? DateTime.fromMillisecondsSinceEpoch(
                ts.seconds.toInt() * 1000,
                isUtc: true)
            .toIso8601String()
        : null;
    return InternetBeneficiary(
      id: proto.id,
      userId: proto.userId,
      accountNumber: proto.accountNumber,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      nickname: proto.nickname.isEmpty ? null : proto.nickname,
      lastAmount: proto.hasLastAmount() ? proto.lastAmount : null,
      lastPackageId:
          proto.lastPackageId.isEmpty ? null : proto.lastPackageId,
      lastPlanName: proto.lastPlanName.isEmpty ? null : proto.lastPlanName,
      lastTopupAt: tsToIso(proto.hasLastTopupAt(), proto.lastTopupAt),
      topupCount: proto.hasTopupCount() ? proto.topupCount : 0,
      createdAt: tsToIso(proto.hasCreatedAt(), proto.createdAt) ?? '',
      updatedAt: tsToIso(proto.hasUpdatedAt(), proto.updatedAt),
    );
  }

  @override
  List<Object?> get props => [id, accountNumber, providerCode, topupCount];
}
