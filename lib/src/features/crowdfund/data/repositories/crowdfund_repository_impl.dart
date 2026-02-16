import 'package:lazervault/src/generated/crowdfund.pb.dart' as pb;
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';
import '../../domain/repositories/crowdfund_repository.dart';
import '../datasources/crowdfund_grpc_data_source.dart';

class CrowdfundRepositoryImpl implements CrowdfundRepository {
  final CrowdfundGrpcDataSource remoteDataSource;

  CrowdfundRepositoryImpl(this.remoteDataSource);

  @override
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
  }) async {
    try {
      return await remoteDataSource.createCrowdfund(
        title: title,
        description: description,
        story: story,
        targetAmount: targetAmount,
        currency: currency,
        deadline: deadline,
        category: category,
        imageUrl: imageUrl,
        visibility: visibility,
        metadata: metadata,
      );
    } catch (e) {
      throw Exception('Failed to create crowdfund: $e');
    }
  }

  @override
  Future<Crowdfund> getCrowdfund(String crowdfundId) async {
    try {
      return await remoteDataSource.getCrowdfund(crowdfundId);
    } catch (e) {
      throw Exception('Failed to get crowdfund: $e');
    }
  }

  @override
  Future<List<Crowdfund>> listCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
    String? sortBy,
    CrowdfundVisibility? visibility,
  }) async {
    try {
      return await remoteDataSource.listCrowdfunds(
        page: page,
        pageSize: pageSize,
        statusFilter: statusFilter,
        categoryFilter: categoryFilter,
        myCrowdfundsOnly: myCrowdfundsOnly,
        sortBy: sortBy,
        visibility: visibility,
      );
    } catch (e) {
      throw Exception('Failed to list crowdfunds: $e');
    }
  }

  @override
  Future<List<Crowdfund>> searchCrowdfunds({
    required String query,
    int limit = 10,
  }) async {
    try {
      return await remoteDataSource.searchCrowdfunds(
        query: query,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to search crowdfunds: $e');
    }
  }

  @override
  Future<Crowdfund> updateCrowdfund({
    required String crowdfundId,
    String? title,
    String? description,
    String? story,
    DateTime? deadline,
    CrowdfundStatus? status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      return await remoteDataSource.updateCrowdfund(
        crowdfundId: crowdfundId,
        title: title,
        description: description,
        story: story,
        deadline: deadline,
        status: status,
        imageUrl: imageUrl,
        metadata: metadata,
      );
    } catch (e) {
      throw Exception('Failed to update crowdfund: $e');
    }
  }

  @override
  Future<void> deleteCrowdfund(String crowdfundId) async {
    try {
      await remoteDataSource.deleteCrowdfund(crowdfundId);
    } catch (e) {
      throw Exception('Failed to delete crowdfund: $e');
    }
  }

  @override
  Future<CrowdfundDonation> makeDonation({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    String? sourceAccountId,
  }) async {
    try {
      return await remoteDataSource.makeDonation(
        crowdfundId: crowdfundId,
        amount: amount,
        message: message,
        isAnonymous: isAnonymous,
        sourceAccountId: sourceAccountId,
      );
    } catch (e) {
      throw Exception('Failed to make donation: $e');
    }
  }

  @override
  Future<List<CrowdfundDonation>> getCrowdfundDonations({
    required String crowdfundId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      return await remoteDataSource.getCrowdfundDonations(
        crowdfundId: crowdfundId,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to get donations: $e');
    }
  }

  @override
  Future<List<CrowdfundDonation>> getUserDonations({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      return await remoteDataSource.getUserDonations(
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to get user donations: $e');
    }
  }

  @override
  Future<CrowdfundReceipt> generateDonationReceipt(String donationId) async {
    try {
      return await remoteDataSource.generateDonationReceipt(donationId);
    } catch (e) {
      throw Exception('Failed to generate receipt: $e');
    }
  }

  @override
  Future<List<CrowdfundReceipt>> getUserReceipts({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      return await remoteDataSource.getUserReceipts(
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to get receipts: $e');
    }
  }

  @override
  Future<CrowdfundStatistics> getCrowdfundStatistics(String crowdfundId) async {
    try {
      return await remoteDataSource.getCrowdfundStatistics(crowdfundId);
    } catch (e) {
      throw Exception('Failed to get statistics: $e');
    }
  }

  @override
  Future<List<LeaderboardEntry>> getCrowdfundLeaderboard({
    LeaderboardSortBy sortBy = LeaderboardSortBy.mostFunded,
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final pbSortBy = _leaderboardSortByToProto(sortBy);
      return await remoteDataSource.getCrowdfundLeaderboard(
        sortBy: pbSortBy,
        category: category,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw Exception('Failed to get leaderboard: $e');
    }
  }

  static pb.LeaderboardSortBy _leaderboardSortByToProto(LeaderboardSortBy sortBy) {
    switch (sortBy) {
      case LeaderboardSortBy.mostFunded:
        return pb.LeaderboardSortBy.LEADERBOARD_SORT_MOST_FUNDED;
      case LeaderboardSortBy.mostDonors:
        return pb.LeaderboardSortBy.LEADERBOARD_SORT_MOST_DONORS;
      case LeaderboardSortBy.trending:
        return pb.LeaderboardSortBy.LEADERBOARD_SORT_TRENDING;
      case LeaderboardSortBy.nearlyComplete:
        return pb.LeaderboardSortBy.LEADERBOARD_SORT_NEARLY_COMPLETE;
      case LeaderboardSortBy.newest:
        return pb.LeaderboardSortBy.LEADERBOARD_SORT_NEWEST;
    }
  }

  // Campaign Wallet Operations

  @override
  Future<List<Crowdfund>> getMyCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
  }) async {
    try {
      return await remoteDataSource.getMyCrowdfunds(
        page: page,
        pageSize: pageSize,
        statusFilter: statusFilter,
      );
    } catch (e) {
      throw Exception('Failed to get my crowdfunds: $e');
    }
  }

  @override
  Future<CrowdfundWithdrawalResult> withdrawFromCrowdfund({
    required String crowdfundId,
    required double amount,
    required String transactionPin,
    String? destinationAccountId,
    String? destinationAccountType,
  }) async {
    try {
      return await remoteDataSource.withdrawFromCrowdfund(
        crowdfundId: crowdfundId,
        amount: amount,
        transactionPin: transactionPin,
        destinationAccountId: destinationAccountId,
        destinationAccountType: destinationAccountType,
      );
    } catch (e) {
      throw Exception('Failed to withdraw from crowdfund: $e');
    }
  }

  @override
  Future<CampaignWalletBalance> getCampaignWalletBalance(
      String crowdfundId) async {
    try {
      return await remoteDataSource.getCampaignWalletBalance(crowdfundId);
    } catch (e) {
      throw Exception('Failed to get campaign wallet balance: $e');
    }
  }

  // Notification Channel Operations

  @override
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
    List<NotificationEventType>? enabledEvents,
  }) async {
    try {
      return await remoteDataSource.connectNotificationChannel(
        crowdfundId: crowdfundId,
        channelType: channelType,
        channelName: channelName,
        telegramChatId: telegramChatId,
        discordWebhookUrl: discordWebhookUrl,
        discordServerName: discordServerName,
        discordChannelName: discordChannelName,
        slackWebhookUrl: slackWebhookUrl,
        slackWorkspaceName: slackWorkspaceName,
        slackChannelName: slackChannelName,
        enabledEvents: enabledEvents,
      );
    } catch (e) {
      throw Exception('Failed to connect notification channel: $e');
    }
  }

  @override
  Future<void> disconnectNotificationChannel(String channelId) async {
    try {
      await remoteDataSource.disconnectNotificationChannel(channelId);
    } catch (e) {
      throw Exception('Failed to disconnect notification channel: $e');
    }
  }

  @override
  Future<List<NotificationChannel>> getNotificationChannels(
      String crowdfundId) async {
    try {
      return await remoteDataSource.getNotificationChannels(crowdfundId);
    } catch (e) {
      throw Exception('Failed to get notification channels: $e');
    }
  }

  @override
  Future<NotificationChannel> updateNotificationChannel({
    required String channelId,
    String? channelName,
    List<NotificationEventType>? enabledEvents,
    NotificationChannelStatus? status,
  }) async {
    try {
      return await remoteDataSource.updateNotificationChannel(
        channelId: channelId,
        channelName: channelName,
        enabledEvents: enabledEvents,
        status: status,
      );
    } catch (e) {
      throw Exception('Failed to update notification channel: $e');
    }
  }

  @override
  Future<bool> testNotificationChannel(String channelId) async {
    try {
      return await remoteDataSource.testNotificationChannel(channelId);
    } catch (e) {
      throw Exception('Failed to test notification channel: $e');
    }
  }
}
