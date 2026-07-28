import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/betting_entities.dart';

/// Proto → domain mappers for the betting feature.
class BettingMappers {
  static BettingPlatform platform(pb.BettingPlatform p) => BettingPlatform(
        code: p.code,
        name: p.name,
        logoUrl: p.logoUrl,
        isActive: p.isActive,
        minAmount: p.minAmount,
        maxAmount: p.maxAmount,
      );

  static BettingAccountVerification verification(
          pb.VerifyBettingAccountResponse p) =>
      BettingAccountVerification(
        valid: p.valid,
        accountName: p.accountName,
        message: p.message,
      );

  static BettingBeneficiary beneficiary(pb.BettingBeneficiary p) =>
      BettingBeneficiary(
        id: p.id,
        platform: p.platform,
        accountUserid: p.accountUserid,
        accountName: p.accountName,
        nickname: p.nickname,
        isDefault: p.isDefault,
        createdAt: p.createdAt,
      );

  static BettingFundingRecord funding(pb.BillPayment p) => BettingFundingRecord(
        id: p.id,
        platform: p.providerId,
        customerNumber: p.customerNumber,
        amount: p.amount,
        status: p.status,
        reference: p.reference,
        createdAt: p.createdAt,
      );
}
