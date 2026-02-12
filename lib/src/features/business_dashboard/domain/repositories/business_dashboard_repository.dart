import '../entities/business_summary_entity.dart';

abstract class BusinessDashboardRepository {
  Future<BusinessSummaryEntity> getBusinessSummary({
    required String accountId,
    required String period,
  });

  Future<List<RecentBusinessTransaction>> getRecentTransactions({
    required String accountId,
    int limit = 10,
  });
}
