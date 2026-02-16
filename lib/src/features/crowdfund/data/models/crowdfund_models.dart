import 'dart:convert';
import 'package:lazervault/src/generated/crowdfund.pb.dart' as pb;
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';

// ============================================================================
// MODEL CLASSES
// ============================================================================

class CrowdfundCreatorModel extends CrowdfundCreator {
  const CrowdfundCreatorModel({
    required super.userId,
    required super.username,
    required super.firstName,
    required super.lastName,
    super.profilePicture,
    required super.verified,
    super.verifiedAt,
    required super.facialRecognitionEnabled,
  });

  factory CrowdfundCreatorModel.fromProto(pb.CrowdfundCreatorMessage proto) {
    return CrowdfundCreatorModel(
      userId: proto.userId.toInt(),
      username: proto.username,
      firstName: proto.firstName,
      lastName: proto.lastName,
      profilePicture: proto.profilePicture.isEmpty ? null : proto.profilePicture,
      verified: proto.verified,
      verifiedAt: proto.hasVerifiedAt() ? proto.verifiedAt.toDateTime() : null,
      facialRecognitionEnabled: proto.facialRecognitionEnabled,
    );
  }
}

class CrowdfundModel extends Crowdfund {
  const CrowdfundModel({
    required super.id,
    required super.creatorUserId,
    required super.creator,
    required super.title,
    required super.description,
    required super.story,
    required super.crowdfundCode,
    required super.targetAmount,
    required super.currentAmount,
    required super.currency,
    super.deadline,
    required super.category,
    required super.status,
    super.imageUrl,
    required super.visibility,
    super.metadata,
    required super.donorCount,
    required super.progressPercentage,
    required super.createdAt,
    required super.updatedAt,
    super.recentDonations,
  });

  factory CrowdfundModel.fromProto(pb.CrowdfundMessage proto) {
    return CrowdfundModel(
      id: proto.id,
      creatorUserId: proto.creatorUserId.toInt(),
      creator: CrowdfundCreatorModel.fromProto(proto.creator),
      title: proto.title,
      description: proto.description,
      story: proto.story,
      crowdfundCode: proto.crowdfundCode,
      targetAmount: proto.targetAmount.toDouble() / 100, // Convert from cents
      currentAmount: proto.currentAmount.toDouble() / 100,
      currency: proto.currency,
      deadline: proto.hasDeadline() ? proto.deadline.toDateTime() : null,
      category: proto.category,
      status: _statusFromProto(proto.status),
      imageUrl: proto.imageUrl.isEmpty ? null : proto.imageUrl,
      visibility: _visibilityFromProto(proto.visibility),
      metadata: proto.metadata.isEmpty ? null : jsonDecode(proto.metadata),
      donorCount: proto.donorCount,
      progressPercentage: proto.progressPercentage,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
      recentDonations: proto.recentDonations
          .map((d) => CrowdfundDonationModel.fromProto(d))
          .toList(),
    );
  }

  static CrowdfundStatus _statusFromProto(pb.CrowdfundStatus status) {
    switch (status) {
      case pb.CrowdfundStatus.CROWDFUND_STATUS_ACTIVE:
        return CrowdfundStatus.active;
      case pb.CrowdfundStatus.CROWDFUND_STATUS_PAUSED:
        return CrowdfundStatus.paused;
      case pb.CrowdfundStatus.CROWDFUND_STATUS_COMPLETED:
        return CrowdfundStatus.completed;
      case pb.CrowdfundStatus.CROWDFUND_STATUS_CANCELLED:
        return CrowdfundStatus.cancelled;
      default:
        return CrowdfundStatus.active;
    }
  }

  static CrowdfundVisibility _visibilityFromProto(
      pb.CrowdfundVisibility visibility) {
    switch (visibility) {
      case pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_PUBLIC:
        return CrowdfundVisibility.public;
      case pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_PRIVATE:
        return CrowdfundVisibility.private;
      case pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_UNLISTED:
        return CrowdfundVisibility.unlisted;
      default:
        return CrowdfundVisibility.public;
    }
  }

}

class CrowdfundDonorModel extends CrowdfundDonor {
  const CrowdfundDonorModel({
    required super.userId,
    required super.displayName,
    super.profilePicture,
    required super.isAnonymous,
    required super.isCreator,
  });

  factory CrowdfundDonorModel.fromProto(pb.CrowdfundDonorMessage proto) {
    return CrowdfundDonorModel(
      userId: proto.userId.toInt(),
      displayName: proto.displayName,
      profilePicture:
          proto.profilePicture.isEmpty ? null : proto.profilePicture,
      isAnonymous: proto.isAnonymous,
      isCreator: proto.isCreator,
    );
  }
}

class CrowdfundDonationModel extends CrowdfundDonation {
  const CrowdfundDonationModel({
    required super.id,
    required super.crowdfundId,
    required super.donorUserId,
    required super.donor,
    required super.amount,
    required super.currency,
    required super.donationDate,
    required super.status,
    super.transactionId,
    super.receiptId,
    super.message,
    required super.isAnonymous,
    required super.paymentMethod,
    super.metadata,
  });

  factory CrowdfundDonationModel.fromProto(pb.CrowdfundDonationMessage proto) {
    return CrowdfundDonationModel(
      id: proto.id,
      crowdfundId: proto.crowdfundId,
      donorUserId: proto.donorUserId.toInt(),
      donor: CrowdfundDonorModel.fromProto(proto.donor),
      amount: proto.amount.toDouble() / 100,
      currency: proto.currency,
      donationDate: proto.donationDate.toDateTime(),
      status: _donationStatusFromProto(proto.status),
      transactionId:
          proto.transactionId.isEmpty ? null : proto.transactionId,
      receiptId: proto.receiptId.isEmpty ? null : proto.receiptId,
      message: proto.message.isEmpty ? null : proto.message,
      isAnonymous: proto.isAnonymous,
      paymentMethod: proto.paymentMethod,
      metadata: proto.metadata.isEmpty ? null : jsonDecode(proto.metadata),
    );
  }

  static DonationStatus _donationStatusFromProto(pb.DonationStatus status) {
    switch (status) {
      case pb.DonationStatus.DONATION_STATUS_PENDING:
        return DonationStatus.pending;
      case pb.DonationStatus.DONATION_STATUS_PROCESSING:
        return DonationStatus.processing;
      case pb.DonationStatus.DONATION_STATUS_COMPLETED:
        return DonationStatus.completed;
      case pb.DonationStatus.DONATION_STATUS_FAILED:
        return DonationStatus.failed;
      case pb.DonationStatus.DONATION_STATUS_REFUNDED:
        return DonationStatus.refunded;
      default:
        return DonationStatus.pending;
    }
  }
}

class CrowdfundReceiptModel extends CrowdfundReceipt {
  const CrowdfundReceiptModel({
    required super.id,
    required super.donationId,
    required super.crowdfundId,
    required super.crowdfundTitle,
    required super.donorUserId,
    required super.donorName,
    required super.amount,
    required super.currency,
    required super.donationDate,
    required super.generatedAt,
    required super.receiptNumber,
    super.receiptData,
  });

  factory CrowdfundReceiptModel.fromProto(pb.CrowdfundReceiptMessage proto) {
    return CrowdfundReceiptModel(
      id: proto.id,
      donationId: proto.donationId,
      crowdfundId: proto.crowdfundId,
      crowdfundTitle: proto.crowdfundTitle,
      donorUserId: proto.donorUserId.toInt(),
      donorName: proto.donorName,
      amount: proto.amount.toDouble() / 100,
      currency: proto.currency,
      donationDate: proto.donationDate.toDateTime(),
      generatedAt: proto.generatedAt.toDateTime(),
      receiptNumber: proto.receiptNumber,
      receiptData:
          proto.receiptData.isEmpty ? null : jsonDecode(proto.receiptData),
    );
  }
}

class CrowdfundStatisticsModel extends CrowdfundStatistics {
  const CrowdfundStatisticsModel({
    required super.crowdfundId,
    required super.totalRaised,
    required super.targetAmount,
    required super.progressPercentage,
    required super.donorCount,
    required super.averageDonation,
    required super.largestDonation,
    required super.daysRemaining,
    required super.isCompleted,
    required super.createdAt,
  });

  factory CrowdfundStatisticsModel.fromProto(
      pb.GetCrowdfundStatisticsResponse proto) {
    return CrowdfundStatisticsModel(
      crowdfundId: proto.crowdfundId,
      totalRaised: proto.totalRaised.toDouble() / 100,
      targetAmount: proto.targetAmount.toDouble() / 100,
      progressPercentage: proto.progressPercentage,
      donorCount: proto.donorCount,
      averageDonation: proto.averageDonation.toDouble() / 100,
      largestDonation: proto.largestDonation.toDouble() / 100,
      daysRemaining: proto.daysRemaining,
      isCompleted: proto.isCompleted,
      createdAt: proto.createdAt.toDateTime(),
    );
  }
}

// ============================================================================
// LEADERBOARD MODELS
// ============================================================================

class LeaderboardEntryModel extends LeaderboardEntry {
  const LeaderboardEntryModel({
    required super.rank,
    required super.crowdfund,
  });

  factory LeaderboardEntryModel.fromProto(pb.LeaderboardCrowdfundEntry proto) {
    if (!proto.hasCrowdfund()) {
      throw ArgumentError('LeaderboardCrowdfundEntry missing crowdfund data');
    }
    return LeaderboardEntryModel(
      rank: proto.rank > 0 ? proto.rank : 1,
      crowdfund: CrowdfundModel.fromProto(proto.crowdfund),
    );
  }
}

// ============================================================================
// CAMPAIGN WALLET MODELS
// ============================================================================

/// Model for withdrawal results from a campaign wallet
class CrowdfundWithdrawalResultModel extends CrowdfundWithdrawalResult {
  const CrowdfundWithdrawalResultModel({
    required super.crowdfundId,
    required super.amountWithdrawn,
    required super.remainingBalance,
    required super.destinationAccountId,
    required super.destinationNewBalance,
    required super.message,
  });
}

/// Model for campaign wallet balance information
class CampaignWalletBalanceModel extends CampaignWalletBalance {
  const CampaignWalletBalanceModel({
    required super.crowdfundId,
    required super.campaignWalletId,
    required super.balance,
    required super.availableBalance,
    required super.currency,
  });
}

// ============================================================================
// NOTIFICATION CHANNEL MODELS
// ============================================================================

class NotificationChannelModel extends NotificationChannel {
  const NotificationChannelModel({
    required super.id,
    required super.crowdfundId,
    required super.creatorUserId,
    required super.channelType,
    required super.status,
    required super.channelName,
    super.channelUsername,
    required super.enabledEvents,
    required super.preferences,
    super.lastNotificationAt,
    required super.notificationCount,
    required super.failureCount,
    super.lastError,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NotificationChannelModel.fromProto(pb.NotificationChannelMessage proto) {
    return NotificationChannelModel(
      id: proto.id,
      crowdfundId: proto.crowdfundId,
      creatorUserId: proto.creatorUserId,
      channelType: _channelTypeFromProto(proto.channelType),
      status: _channelStatusFromProto(proto.status),
      channelName: proto.channelName,
      channelUsername: proto.channelUsername.isEmpty ? null : proto.channelUsername,
      enabledEvents: proto.enabledEvents
          .map((e) => _eventTypeFromProto(e))
          .toList(),
      preferences: proto.hasPreferences()
          ? _preferencesFromProto(proto.preferences)
          : NotificationPreferences.defaultPrefs(),
      lastNotificationAt: proto.lastNotificationAt.isNotEmpty
          ? DateTime.tryParse(proto.lastNotificationAt)
          : null,
      notificationCount: proto.notificationCount,
      failureCount: proto.failureCount,
      lastError: proto.lastError.isEmpty ? null : proto.lastError,
      createdAt: proto.createdAt.isNotEmpty
          ? DateTime.parse(proto.createdAt)
          : DateTime.now(),
      updatedAt: proto.updatedAt.isNotEmpty
          ? DateTime.parse(proto.updatedAt)
          : DateTime.now(),
    );
  }

  static NotificationChannelType _channelTypeFromProto(pb.NotificationChannelType type) {
    switch (type) {
      case pb.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_TELEGRAM:
        return NotificationChannelType.telegram;
      case pb.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_DISCORD:
        return NotificationChannelType.discord;
      case pb.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS:
        return NotificationChannelType.whatsappBusiness;
      case pb.NotificationChannelType.NOTIFICATION_CHANNEL_TYPE_SLACK:
        return NotificationChannelType.slack;
      default:
        return NotificationChannelType.unspecified;
    }
  }

  static NotificationChannelStatus _channelStatusFromProto(pb.NotificationChannelStatus status) {
    switch (status) {
      case pb.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_PENDING:
        return NotificationChannelStatus.pending;
      case pb.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_ACTIVE:
        return NotificationChannelStatus.active;
      case pb.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_PAUSED:
        return NotificationChannelStatus.paused;
      case pb.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_ERROR:
        return NotificationChannelStatus.error;
      case pb.NotificationChannelStatus.NOTIFICATION_CHANNEL_STATUS_DISCONNECTED:
        return NotificationChannelStatus.disconnected;
      default:
        return NotificationChannelStatus.unspecified;
    }
  }

  static NotificationEventType _eventTypeFromProto(pb.NotificationEventType type) {
    switch (type) {
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_NEW_DONATION:
        return NotificationEventType.newDonation;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED:
        return NotificationEventType.milestoneReached;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_GOAL_REACHED:
        return NotificationEventType.goalReached;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR:
        return NotificationEventType.newContributor;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_LARGE_DONATION:
        return NotificationEventType.largeDonation;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY:
        return NotificationEventType.dailySummary;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING:
        return NotificationEventType.campaignEnding;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED:
        return NotificationEventType.campaignEnded;
      case pb.NotificationEventType.NOTIFICATION_EVENT_TYPE_WITHDRAWAL:
        return NotificationEventType.withdrawal;
      default:
        return NotificationEventType.unspecified;
    }
  }

  static NotificationPreferences _preferencesFromProto(
      pb.NotificationPreferencesMessage proto) {
    return NotificationPreferences(
      includeDonorName: proto.includeDonorName,
      includeAmount: proto.includeAmount,
      includeMessage: proto.includeMessage,
      includeProgress: proto.includeProgress,
      includeLeaderboard: proto.includeLeaderboard,
      largeDonationThreshold: proto.largeDonationThreshold,
      messageTemplate: proto.messageTemplate.isEmpty ? null : proto.messageTemplate,
      language: proto.language.isEmpty ? 'en' : proto.language,
      quietHoursEnabled: proto.quietHoursEnabled,
      quietHoursStart: proto.quietHoursStart.isEmpty ? '22:00' : proto.quietHoursStart,
      quietHoursEnd: proto.quietHoursEnd.isEmpty ? '08:00' : proto.quietHoursEnd,
      timezone: proto.timezone.isEmpty ? 'Africa/Lagos' : proto.timezone,
    );
  }
}
