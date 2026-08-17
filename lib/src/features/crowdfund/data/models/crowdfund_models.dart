import 'dart:convert';
import 'package:lazervault/src/generated/crowdfund.pb.dart' as pb;
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';
part 'crowdfund_models_widgets.dart';


/// Safely decode JSON, returning null on malformed input
Map<String, dynamic>? _safeJsonDecode(String json) {
  try {
    final result = jsonDecode(json);
    return result is Map<String, dynamic> ? result : null;
  } catch (_) {
    return null;
  }
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
          ? (DateTime.tryParse(proto.createdAt) ?? DateTime.now())
          : DateTime.now(),
      updatedAt: proto.updatedAt.isNotEmpty
          ? (DateTime.tryParse(proto.updatedAt) ?? DateTime.now())
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
