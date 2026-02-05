import 'package:equatable/equatable.dart';

/// Notification channel types
enum NotificationChannelType {
  unspecified,
  telegram,
  discord,
  whatsappBusiness,
  slack;

  String get displayName {
    switch (this) {
      case NotificationChannelType.telegram:
        return 'Telegram';
      case NotificationChannelType.discord:
        return 'Discord';
      case NotificationChannelType.whatsappBusiness:
        return 'WhatsApp Business';
      case NotificationChannelType.slack:
        return 'Slack';
      default:
        return 'Unknown';
    }
  }

  String get iconAsset {
    switch (this) {
      case NotificationChannelType.telegram:
        return 'assets/icons/telegram.png';
      case NotificationChannelType.discord:
        return 'assets/icons/discord.png';
      case NotificationChannelType.whatsappBusiness:
        return 'assets/icons/whatsapp.png';
      case NotificationChannelType.slack:
        return 'assets/icons/slack.png';
      default:
        return 'assets/icons/bell.png';
    }
  }

  int get brandColor {
    switch (this) {
      case NotificationChannelType.telegram:
        return 0xFF0088CC;
      case NotificationChannelType.discord:
        return 0xFF5865F2;
      case NotificationChannelType.whatsappBusiness:
        return 0xFF25D366;
      case NotificationChannelType.slack:
        return 0xFF4A154B;
      default:
        return 0xFF6B7280;
    }
  }
}

/// Notification channel status
enum NotificationChannelStatus {
  unspecified,
  pending,
  active,
  paused,
  error,
  disconnected;

  String get displayName {
    switch (this) {
      case NotificationChannelStatus.pending:
        return 'Pending Verification';
      case NotificationChannelStatus.active:
        return 'Active';
      case NotificationChannelStatus.paused:
        return 'Paused';
      case NotificationChannelStatus.error:
        return 'Error';
      case NotificationChannelStatus.disconnected:
        return 'Disconnected';
      default:
        return 'Unknown';
    }
  }

  int get statusColor {
    switch (this) {
      case NotificationChannelStatus.active:
        return 0xFF10B981;
      case NotificationChannelStatus.pending:
        return 0xFFFB923C;
      case NotificationChannelStatus.paused:
        return 0xFF6B7280;
      case NotificationChannelStatus.error:
        return 0xFFEF4444;
      default:
        return 0xFF6B7280;
    }
  }
}

/// Notification event types
enum NotificationEventType {
  unspecified,
  newDonation,
  milestoneReached,
  goalReached,
  newContributor,
  largeDonation,
  dailySummary,
  campaignEnding,
  campaignEnded,
  withdrawal;

  String get displayName {
    switch (this) {
      case NotificationEventType.newDonation:
        return 'New Donations';
      case NotificationEventType.milestoneReached:
        return 'Milestones (25%, 50%, 75%)';
      case NotificationEventType.goalReached:
        return 'Goal Reached';
      case NotificationEventType.newContributor:
        return 'First-time Contributors';
      case NotificationEventType.largeDonation:
        return 'Large Donations';
      case NotificationEventType.dailySummary:
        return 'Daily Summary';
      case NotificationEventType.campaignEnding:
        return 'Campaign Ending Soon';
      case NotificationEventType.campaignEnded:
        return 'Campaign Ended';
      case NotificationEventType.withdrawal:
        return 'Withdrawals';
      default:
        return 'Unknown';
    }
  }

  String get description {
    switch (this) {
      case NotificationEventType.newDonation:
        return 'Notify when someone donates';
      case NotificationEventType.milestoneReached:
        return 'Notify at funding milestones';
      case NotificationEventType.goalReached:
        return 'Notify when campaign is fully funded';
      case NotificationEventType.newContributor:
        return 'Highlight first-time supporters';
      case NotificationEventType.largeDonation:
        return 'Alert for donations above threshold';
      case NotificationEventType.dailySummary:
        return 'Daily progress summary';
      case NotificationEventType.campaignEnding:
        return 'Reminder when deadline approaches';
      case NotificationEventType.campaignEnded:
        return 'Notify when campaign ends';
      case NotificationEventType.withdrawal:
        return 'Notify when funds are withdrawn';
      default:
        return '';
    }
  }
}

/// Notification channel entity
class NotificationChannel extends Equatable {
  final String id;
  final String crowdfundId;
  final String creatorUserId;
  final NotificationChannelType channelType;
  final NotificationChannelStatus status;
  final String channelName;
  final String? channelUsername;
  final List<NotificationEventType> enabledEvents;
  final NotificationPreferences preferences;
  final DateTime? lastNotificationAt;
  final int notificationCount;
  final int failureCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotificationChannel({
    required this.id,
    required this.crowdfundId,
    required this.creatorUserId,
    required this.channelType,
    required this.status,
    required this.channelName,
    this.channelUsername,
    required this.enabledEvents,
    required this.preferences,
    this.lastNotificationAt,
    required this.notificationCount,
    required this.failureCount,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == NotificationChannelStatus.active;
  bool get isPending => status == NotificationChannelStatus.pending;
  bool get hasError => status == NotificationChannelStatus.error;

  @override
  List<Object?> get props => [
        id,
        crowdfundId,
        channelType,
        status,
        channelName,
        enabledEvents,
        notificationCount,
      ];
}

/// Notification preferences
class NotificationPreferences extends Equatable {
  final bool includeDonorName;
  final bool includeAmount;
  final bool includeMessage;
  final bool includeProgress;
  final bool includeLeaderboard;
  final double largeDonationThreshold;
  final String? messageTemplate;
  final String language;
  final bool quietHoursEnabled;
  final String quietHoursStart;
  final String quietHoursEnd;
  final String timezone;

  const NotificationPreferences({
    this.includeDonorName = true,
    this.includeAmount = true,
    this.includeMessage = true,
    this.includeProgress = true,
    this.includeLeaderboard = false,
    this.largeDonationThreshold = 100000, // 1000 NGN in kobo
    this.messageTemplate,
    this.language = 'en',
    this.quietHoursEnabled = false,
    this.quietHoursStart = '22:00',
    this.quietHoursEnd = '08:00',
    this.timezone = 'Africa/Lagos',
  });

  factory NotificationPreferences.defaultPrefs() {
    return const NotificationPreferences();
  }

  NotificationPreferences copyWith({
    bool? includeDonorName,
    bool? includeAmount,
    bool? includeMessage,
    bool? includeProgress,
    bool? includeLeaderboard,
    double? largeDonationThreshold,
    String? messageTemplate,
    String? language,
    bool? quietHoursEnabled,
    String? quietHoursStart,
    String? quietHoursEnd,
    String? timezone,
  }) {
    return NotificationPreferences(
      includeDonorName: includeDonorName ?? this.includeDonorName,
      includeAmount: includeAmount ?? this.includeAmount,
      includeMessage: includeMessage ?? this.includeMessage,
      includeProgress: includeProgress ?? this.includeProgress,
      includeLeaderboard: includeLeaderboard ?? this.includeLeaderboard,
      largeDonationThreshold:
          largeDonationThreshold ?? this.largeDonationThreshold,
      messageTemplate: messageTemplate ?? this.messageTemplate,
      language: language ?? this.language,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      timezone: timezone ?? this.timezone,
    );
  }

  @override
  List<Object?> get props => [
        includeDonorName,
        includeAmount,
        includeMessage,
        includeProgress,
        largeDonationThreshold,
        quietHoursEnabled,
      ];
}

/// Notification delivery record
class NotificationDelivery extends Equatable {
  final String id;
  final String channelId;
  final String crowdfundId;
  final NotificationEventType eventType;
  final String eventData;
  final String messageContent;
  final bool success;
  final String? errorMessage;
  final int retryCount;
  final String? platformMessageId;
  final DateTime createdAt;
  final DateTime? deliveredAt;

  const NotificationDelivery({
    required this.id,
    required this.channelId,
    required this.crowdfundId,
    required this.eventType,
    required this.eventData,
    required this.messageContent,
    required this.success,
    this.errorMessage,
    required this.retryCount,
    this.platformMessageId,
    required this.createdAt,
    this.deliveredAt,
  });

  @override
  List<Object?> get props => [id, channelId, eventType, success, createdAt];
}

/// Telegram bot info
class TelegramBotInfo extends Equatable {
  final String botUsername;
  final String botName;
  final String botLink;
  final String instructions;

  const TelegramBotInfo({
    required this.botUsername,
    required this.botName,
    required this.botLink,
    required this.instructions,
  });

  @override
  List<Object?> get props => [botUsername, botLink];
}
