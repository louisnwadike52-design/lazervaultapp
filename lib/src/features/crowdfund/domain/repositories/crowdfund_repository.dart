import '../entities/crowdfund_entities.dart';
import '../entities/notification_channel_entities.dart';

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
    required String sourceAccountId,
    required String transactionPin,
    required String transactionId,
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

  // Campaign Wallet Operations
  Future<List<Crowdfund>> getMyCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
  });

  Future<CrowdfundWithdrawalResult> withdrawFromCrowdfund({
    required String crowdfundId,
    required double amount,
    required String transactionPin,
    required String transactionId,
    String? destinationAccountId,
    String? destinationAccountType,
  });

  /// Read-only fee quote: returns the platform commission + net for
  /// a hypothetical withdrawal so the sheet can render the breakdown
  /// before the user confirms a PIN.
  Future<CrowdfundWithdrawalFeeQuote> getCrowdfundWithdrawalFeeQuote({
    required String crowdfundId,
    required double amount,
  });

  Future<CampaignWalletBalance> getCampaignWalletBalance(String crowdfundId);

  // Notification Channel Operations
  Future<NotificationChannel> connectNotificationChannel({
    required String crowdfundId,
    required NotificationChannelType channelType,
    required String channelName,
    String? telegramChatId,
    String? discordWebhookUrl,
    String? discordServerName,
    String? discordChannelName,
    String? slackWebhookUrl,
    String? slackWorkspaceName,
    String? slackChannelName,
    String? whatsappRecipientId,
    List<NotificationEventType>? enabledEvents,
  });

  Future<void> disconnectNotificationChannel(String channelId);

  Future<List<NotificationChannel>> getNotificationChannels(String crowdfundId);

  Future<NotificationChannel> updateNotificationChannel({
    required String channelId,
    String? channelName,
    List<NotificationEventType>? enabledEvents,
    NotificationChannelStatus? status,
  });

  Future<bool> testNotificationChannel(String channelId);
}
