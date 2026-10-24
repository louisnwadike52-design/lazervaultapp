library;

import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_withdrawal_record.dart';

/// "Has this campaign been withdrawn from, and how much?"
///
/// Built once from the creator's full withdrawal list so the campaign LIST can
/// badge every card without a call per card. The alternative considered and
/// rejected was inferring it — a campaign whose pot is zero and whose refunds
/// are zero "must" have been withdrawn — which is equally true of a campaign
/// nobody ever funded, and would brand it Withdrawn.
class CrowdfundWithdrawalIndex {
  const CrowdfundWithdrawalIndex._(this._byCampaign);

  final Map<String, List<CrowdfundWithdrawalRecord>> _byCampaign;

  static const empty = CrowdfundWithdrawalIndex._({});

  factory CrowdfundWithdrawalIndex.from(
      Iterable<CrowdfundWithdrawalRecord> records) {
    final map = <String, List<CrowdfundWithdrawalRecord>>{};
    for (final r in records) {
      // SETTLED ONLY. A pending or failed payout has moved no money, and
      // badging a campaign Withdrawn on one tells the creator their funds
      // have gone when they are still in the pot.
      if (!r.isSettled) continue;
      if (r.crowdfundId.trim().isEmpty) continue;
      map.putIfAbsent(r.crowdfundId, () => []).add(r);
    }
    for (final list in map.values) {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    return CrowdfundWithdrawalIndex._(map);
  }

  bool hasWithdrawals(String crowdfundId) =>
      _byCampaign.containsKey(crowdfundId);

  /// Gross total taken out of a campaign, in major units.
  double totalWithdrawn(String crowdfundId) =>
      (_byCampaign[crowdfundId] ?? const [])
          .fold<double>(0, (sum, r) => sum + r.amount);

  /// Most recent settled payout, or null.
  CrowdfundWithdrawalRecord? latest(String crowdfundId) {
    final list = _byCampaign[crowdfundId];
    return (list == null || list.isEmpty) ? null : list.first;
  }

  int count(String crowdfundId) =>
      (_byCampaign[crowdfundId] ?? const []).length;

  bool get isEmpty => _byCampaign.isEmpty;
}
