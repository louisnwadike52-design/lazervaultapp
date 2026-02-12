import '../entities/crowdfund_entities.dart';

/// Abstract repository interface for crowdfund operations
/// Following clean architecture, this is defined in the domain layer
abstract class CrowdfundRepository {
  // Crowdfund Management
  Future<Crowdfund> createCrowdfund({
    required String title,
    required String description,
    required String story,
    required double targetAmount,
    required String currency,
    DateTime? deadline,
    required String category,
    String? imageUrl,
    required CrowdfundVisibility visibility,
    Map<String, dynamic>? metadata,
  });

  Future<Crowdfund> getCrowdfund(String crowdfundId);

  Future<List<Crowdfund>> listCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
    String? sortBy,
    CrowdfundVisibility? visibility,
  });

  Future<List<Crowdfund>> searchCrowdfunds({
    required String query,
    int limit = 10,
  });

  Future<Crowdfund> updateCrowdfund({
    required String crowdfundId,
    String? title,
    String? description,
    String? story,
    DateTime? deadline,
    CrowdfundStatus? status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  });

  Future<void> deleteCrowdfund(String crowdfundId);

  // Donation Operations
  Future<CrowdfundDonation> makeDonation({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    int? sourceAccountId,
  });

  Future<List<CrowdfundDonation>> getCrowdfundDonations({
    required String crowdfundId,
    int page = 1,
    int pageSize = 20,
  });

  Future<List<CrowdfundDonation>> getUserDonations({
    int page = 1,
    int pageSize = 20,
  });

  // Receipt Operations
  Future<CrowdfundReceipt> generateDonationReceipt(String donationId);

  Future<List<CrowdfundReceipt>> getUserReceipts({
    int page = 1,
    int pageSize = 20,
  });

  // Statistics
  Future<CrowdfundStatistics> getCrowdfundStatistics(String crowdfundId);

  // Leaderboard
  Future<List<LeaderboardEntry>> getCrowdfundLeaderboard({
    LeaderboardSortBy sortBy = LeaderboardSortBy.mostFunded,
    String? category,
    int limit = 20,
    int offset = 0,
  });
}
