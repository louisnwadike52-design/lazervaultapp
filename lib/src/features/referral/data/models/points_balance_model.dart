import 'package:lazervault/src/features/referral/domain/entities/points_balance_entity.dart';
import 'package:lazervault/src/generated/referral.pb.dart' as proto;

class PointsBalanceModel extends PointsBalanceEntity {
  const PointsBalanceModel({
    required super.totalEarned,
    required super.totalRedeemed,
    required super.currentBalance,
    super.tier,
  });

  factory PointsBalanceModel.fromProto(proto.PointsBalance protoBalance) {
    return PointsBalanceModel(
      totalEarned: protoBalance.totalEarned,
      totalRedeemed: protoBalance.totalRedeemed,
      currentBalance: protoBalance.currentBalance,
      tier: protoBalance.tier.isNotEmpty ? protoBalance.tier : 'bronze',
    );
  }
}
