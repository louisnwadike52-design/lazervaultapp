import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/crowdfund.pbgrpc.dart' as pb;
import 'package:lazervault/src/generated/crowdfund.pb.dart' as pb_msg;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import 'package:fixnum/fixnum.dart' as fixnum;
import '../models/crowdfund_models.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';

class CrowdfundGrpcDataSource {
  final pb.CrowdfundServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  CrowdfundGrpcDataSource({
    required pb.CrowdfundServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  pb_timestamp.Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return pb_timestamp.Timestamp.fromDateTime(dateTime);
  }

  fixnum.Int64 _amountToInt64(double amount) {
    return fixnum.Int64((amount * 100).toInt());
  }

  pb.CrowdfundVisibility _visibilityToProto(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_PUBLIC;
      case CrowdfundVisibility.private:
        return pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_PRIVATE;
      case CrowdfundVisibility.unlisted:
        return pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_UNLISTED;
    }
  }

  pb.CrowdfundStatus _statusToProto(CrowdfundStatus status) {
    switch (status) {
      case CrowdfundStatus.active:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_ACTIVE;
      case CrowdfundStatus.paused:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_PAUSED;
      case CrowdfundStatus.completed:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_COMPLETED;
      case CrowdfundStatus.cancelled:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_CANCELLED;
    }
  }

  // ============================================================================
  // CROWDFUND MANAGEMENT
  // ============================================================================

  Future<CrowdfundModel> createCrowdfund({
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
      final request = pb.CreateCrowdfundRequest()
        ..title = title
        ..description = description
        ..story = story
        ..targetAmount = _amountToInt64(targetAmount)
        ..currency = currency
        ..category = category
        ..visibility = _visibilityToProto(visibility);

      if (deadline != null) {
        request.deadline = _dateTimeToTimestamp(deadline);
      }

      if (imageUrl != null) {
        request.imageUrl = imageUrl;
      }

      if (metadata != null) {
        request.metadata = metadata.toString();
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.createCrowdfund(request, options: callOptions);

      return CrowdfundModel.fromProto(response.crowdfund);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to create crowdfund'}');
    }
  }

  Future<CrowdfundModel> getCrowdfund(String crowdfundId) async {
    try {
      final request = pb.GetCrowdfundRequest()..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfund(request, options: callOptions);

      return CrowdfundModel.fromProto(response.crowdfund);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get crowdfund'}');
    }
  }

  Future<List<CrowdfundModel>> listCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
    String? sortBy,
    CrowdfundVisibility? visibility,
  }) async {
    try {
      final request = pb.ListCrowdfundsRequest()
        ..page = page
        ..pageSize = pageSize
        ..myCrowdfundsOnly = myCrowdfundsOnly;

      if (statusFilter != null) {
        request.status = statusFilter;
      }

      if (categoryFilter != null) {
        request.category = categoryFilter;
      }

      if (sortBy != null) {
        request.sortBy = sortBy;
      }

      if (visibility != null) {
        request.visibility = _visibilityToProto(visibility);
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.listCrowdfunds(request, options: callOptions);

      return response.crowdfunds
          .map((cf) => CrowdfundModel.fromProto(cf))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to list crowdfunds'}');
    }
  }

  Future<List<CrowdfundModel>> searchCrowdfunds({
    required String query,
    int limit = 10,
  }) async {
    try {
      final request = pb.SearchCrowdfundsRequest()
        ..query = query
        ..limit = limit;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.searchCrowdfunds(request, options: callOptions);

      return response.crowdfunds
          .map((cf) => CrowdfundModel.fromProto(cf))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to search crowdfunds'}');
    }
  }

  Future<CrowdfundModel> updateCrowdfund({
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
      final request = pb.UpdateCrowdfundRequest()..crowdfundId = crowdfundId;

      if (title != null) request.title = title;
      if (description != null) request.description = description;
      if (story != null) request.story = story;
      if (deadline != null) request.deadline = _dateTimeToTimestamp(deadline);
      if (status != null) request.status = _statusToProto(status);
      if (imageUrl != null) request.imageUrl = imageUrl;
      if (metadata != null) request.metadata = metadata.toString();

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.updateCrowdfund(request, options: callOptions);

      return CrowdfundModel.fromProto(response.crowdfund);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update crowdfund'}');
    }
  }

  Future<void> deleteCrowdfund(String crowdfundId) async {
    try {
      final request = pb.DeleteCrowdfundRequest()..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.deleteCrowdfund(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to delete crowdfund'}');
    }
  }

  // ============================================================================
  // DONATION OPERATIONS
  // ============================================================================

  Future<CrowdfundDonationModel> makeDonation({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    String? sourceAccountId,
  }) async {
    try {
      final request = pb.MakeDonationRequest()
        ..crowdfundId = crowdfundId
        ..amount = _amountToInt64(amount)
        ..isAnonymous = isAnonymous;

      if (message != null) {
        request.message = message;
      }

      if (sourceAccountId != null) {
        request.sourceAccountId = sourceAccountId;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.makeDonation(request, options: callOptions);

      return CrowdfundDonationModel.fromProto(response.donation);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to make donation'}');
    }
  }

  Future<List<CrowdfundDonationModel>> getCrowdfundDonations({
    required String crowdfundId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetCrowdfundDonationsRequest()
        ..crowdfundId = crowdfundId
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfundDonations(request, options: callOptions);

      return response.donations
          .map((d) => CrowdfundDonationModel.fromProto(d))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get donations'}');
    }
  }

  Future<List<CrowdfundDonationModel>> getUserDonations({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetUserDonationsRequest()
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getUserDonations(request, options: callOptions);

      return response.donations
          .map((d) => CrowdfundDonationModel.fromProto(d))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get user donations'}');
    }
  }

  // ============================================================================
  // RECEIPT OPERATIONS
  // ============================================================================

  Future<CrowdfundReceiptModel> generateDonationReceipt(
      String donationId) async {
    try {
      final request = pb.GenerateDonationReceiptRequest()
        ..donationId = donationId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.generateDonationReceipt(request, options: callOptions);

      return CrowdfundReceiptModel.fromProto(response.receipt);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to generate receipt'}');
    }
  }

  Future<List<CrowdfundReceiptModel>> getUserReceipts({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetUserCrowdfundReceiptsRequest()
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getUserCrowdfundReceipts(request, options: callOptions);

      return response.receipts
          .map((r) => CrowdfundReceiptModel.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get receipts'}');
    }
  }

  // ============================================================================
  // STATISTICS
  // ============================================================================

  Future<CrowdfundStatisticsModel> getCrowdfundStatistics(
      String crowdfundId) async {
    try {
      final request = pb.GetCrowdfundStatisticsRequest()
        ..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfundStatistics(request, options: callOptions);

      return CrowdfundStatisticsModel.fromProto(response);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get statistics'}');
    }
  }

  // ============================================================================
  // CAMPAIGN WALLET OPERATIONS
  // ============================================================================

  /// Get all crowdfunds owned by the current user
  Future<List<CrowdfundModel>> getMyCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
  }) async {
    try {
      final request = pb.GetMyCrowdfundsRequest()
        ..page = page
        ..pageSize = pageSize;

      if (statusFilter != null) {
        request.status = statusFilter;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getMyCrowdfunds(request, options: callOptions);

      return response.crowdfunds
          .map((cf) => CrowdfundModel.fromProto(cf))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get my crowdfunds'}');
    }
  }

  /// Withdraw funds from a campaign wallet to a destination account
  ///
  /// [crowdfundId] - The ID of the crowdfund campaign
  /// [amount] - Amount to withdraw in major units (e.g., Naira)
  /// [transactionPin] - User's transaction PIN for authentication
  /// [destinationAccountId] - Optional specific account ID to withdraw to
  /// [destinationAccountType] - Optional account type (savings, personal, investment)
  ///                            Used if destinationAccountId is not provided
  Future<CrowdfundWithdrawalResultModel> withdrawFromCrowdfund({
    required String crowdfundId,
    required double amount,
    required String transactionPin,
    String? destinationAccountId,
    String? destinationAccountType,
  }) async {
    try {
      final request = pb.WithdrawFromCrowdfundRequest()
        ..crowdfundId = crowdfundId
        ..amount = _amountToInt64(amount)
        ..transactionPin = transactionPin;

      if (destinationAccountId != null) {
        request.destinationAccountId = destinationAccountId;
      }

      if (destinationAccountType != null) {
        request.destinationAccountType = destinationAccountType;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.withdrawFromCrowdfund(request, options: callOptions);

      return CrowdfundWithdrawalResultModel(
        crowdfundId: response.crowdfundId,
        amountWithdrawn: response.amountWithdrawn.toDouble() / 100,
        remainingBalance: response.remainingBalance.toDouble() / 100,
        destinationAccountId: response.destinationAccountId,
        destinationNewBalance: response.destinationNewBalance.toDouble() / 100,
        message: response.message,
      );
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to withdraw from crowdfund'}');
    }
  }

  // ============================================================================
  // LEADERBOARD OPERATIONS
  // ============================================================================

  /// Get crowdfund leaderboard
  Future<List<LeaderboardEntryModel>> getCrowdfundLeaderboard({
    required pb.LeaderboardSortBy sortBy,
    String? category,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final request = pb.GetCrowdfundLeaderboardRequest()
        ..sortBy = sortBy
        ..limit = limit
        ..offset = offset;

      if (category != null && category.isNotEmpty) {
        request.category = category;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfundLeaderboard(request, options: callOptions);

      return response.entries
          .map((e) => LeaderboardEntryModel.fromProto(e))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get leaderboard'}');
    }
  }

  /// Get the campaign wallet balance for a crowdfund
  Future<CampaignWalletBalanceModel> getCampaignWalletBalance(
      String crowdfundId) async {
    try {
      final request = pb.GetCampaignWalletBalanceRequest()
        ..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCampaignWalletBalance(request, options: callOptions);

      return CampaignWalletBalanceModel(
        crowdfundId: response.crowdfundId,
        campaignWalletId: response.campaignWalletId,
        balance: response.balance.toDouble() / 100,
        availableBalance: response.availableBalance.toDouble() / 100,
        currency: response.currency,
      );
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get campaign wallet balance'}');
    }
  }

  // ============================================================================
  // NOTIFICATION CHANNEL OPERATIONS
  // ============================================================================

  Future<NotificationChannelModel> connectNotificationChannel({
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
      final request = pb.ConnectNotificationChannelRequest()
        ..crowdfundId = crowdfundId
        ..channelType = _notificationChannelTypeToProto(channelType)
        ..channelName = channelName;

      if (channelType == NotificationChannelType.telegram && telegramChatId != null) {
        request.telegram = pb_msg.TelegramConnectionDataMessage()
          ..chatId = telegramChatId;
      } else if (channelType == NotificationChannelType.discord && discordWebhookUrl != null) {
        request.discord = pb_msg.DiscordConnectionDataMessage()
          ..webhookUrl = discordWebhookUrl;
        if (discordServerName != null) request.discord.serverName = discordServerName;
        if (discordChannelName != null) request.discord.channelName = discordChannelName;
      } else if (channelType == NotificationChannelType.slack && slackWebhookUrl != null) {
        request.slack = pb_msg.SlackConnectionDataMessage()
          ..webhookUrl = slackWebhookUrl;
        if (slackWorkspaceName != null) request.slack.workspaceName = slackWorkspaceName;
        if (slackChannelName != null) request.slack.channelName = slackChannelName;
      }

      if (enabledEvents != null) {
        request.enabledEvents.addAll(
          enabledEvents.map((e) => _notificationEventTypeToProto(e)),
        );
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.connectNotificationChannel(request, options: callOptions);

      return NotificationChannelModel.fromProto(response.channel);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to connect notification channel'}');
    }
  }

  Future<void> disconnectNotificationChannel(String channelId) async {
    try {
      final request = pb.DisconnectNotificationChannelRequest()
        ..channelId = channelId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.disconnectNotificationChannel(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to disconnect notification channel'}');
    }
  }

  Future<List<NotificationChannelModel>> getNotificationChannels(
      String crowdfundId) async {
    try {
      final request = pb.GetNotificationChannelsRequest()
        ..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getNotificationChannels(request, options: callOptions);

      return response.channels
          .map((ch) => NotificationChannelModel.fromProto(ch))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get notification channels'}');
    }
  }

  Future<NotificationChannelModel> updateNotificationChannel({
    required String channelId,
    String? channelName,
    List<NotificationEventType>? enabledEvents,
    NotificationChannelStatus? status,
  }) async {
    try {
      final request = pb.UpdateNotificationChannelRequest()
        ..channelId = channelId;

      if (channelName != null) request.channelName = channelName;
      if (status != null) request.status = _notificationChannelStatusToProto(status);
      if (enabledEvents != null) {
        request.enabledEvents.addAll(
          enabledEvents.map((e) => _notificationEventTypeToProto(e)),
        );
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.updateNotificationChannel(request, options: callOptions);

      return NotificationChannelModel.fromProto(response.channel);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update notification channel'}');
    }
  }

  Future<bool> testNotificationChannel(String channelId) async {
    try {
      final request = pb.TestNotificationChannelRequest()
        ..channelId = channelId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.testNotificationChannel(request, options: callOptions);

      return response.success;
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to test notification channel'}');
    }
  }

  // ============================================================================
  // NOTIFICATION ENUM CONVERTERS
  // ============================================================================

  pb_msg.NotificationChannelType _notificationChannelTypeToProto(
      NotificationChannelType type) {
    switch (type) {
      case NotificationChannelType.telegram:
        return pb_msg.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_TELEGRAM;
      case NotificationChannelType.discord:
        return pb_msg.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_DISCORD;
      case NotificationChannelType.whatsappBusiness:
        return pb_msg.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS;
      case NotificationChannelType.slack:
        return pb_msg.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_SLACK;
      default:
        return pb_msg.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED;
    }
  }

  pb_msg.NotificationChannelStatus _notificationChannelStatusToProto(
      NotificationChannelStatus status) {
    switch (status) {
      case NotificationChannelStatus.active:
        return pb_msg.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_ACTIVE;
      case NotificationChannelStatus.paused:
        return pb_msg.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_PAUSED;
      case NotificationChannelStatus.error:
        return pb_msg.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_ERROR;
      case NotificationChannelStatus.disconnected:
        return pb_msg.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_DISCONNECTED;
      default:
        return pb_msg.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED;
    }
  }

  pb_msg.NotificationEventType _notificationEventTypeToProto(
      NotificationEventType type) {
    switch (type) {
      case NotificationEventType.newDonation:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_NEW_DONATION;
      case NotificationEventType.milestoneReached:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED;
      case NotificationEventType.goalReached:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_GOAL_REACHED;
      case NotificationEventType.newContributor:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR;
      case NotificationEventType.largeDonation:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_LARGE_DONATION;
      case NotificationEventType.dailySummary:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY;
      case NotificationEventType.campaignEnding:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING;
      case NotificationEventType.campaignEnded:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED;
      case NotificationEventType.withdrawal:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_WITHDRAWAL;
      default:
        return pb_msg.NotificationEventType.NOTIFICATION_EVENT_TYPE_UNSPECIFIED;
    }
  }
}
