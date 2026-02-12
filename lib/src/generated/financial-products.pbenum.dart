//
//  Generated code. Do not modify.
//  source: financial-products.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Auto-save trigger types
class AutoSaveTriggerType extends $pb.ProtobufEnum {
  static const AutoSaveTriggerType AUTO_SAVE_TRIGGER_UNKNOWN = AutoSaveTriggerType._(0, _omitEnumNames ? '' : 'AUTO_SAVE_TRIGGER_UNKNOWN');
  static const AutoSaveTriggerType AUTO_SAVE_TRIGGER_ON_DEPOSIT = AutoSaveTriggerType._(1, _omitEnumNames ? '' : 'AUTO_SAVE_TRIGGER_ON_DEPOSIT');
  static const AutoSaveTriggerType AUTO_SAVE_TRIGGER_SCHEDULED = AutoSaveTriggerType._(2, _omitEnumNames ? '' : 'AUTO_SAVE_TRIGGER_SCHEDULED');
  static const AutoSaveTriggerType AUTO_SAVE_TRIGGER_ROUND_UP = AutoSaveTriggerType._(3, _omitEnumNames ? '' : 'AUTO_SAVE_TRIGGER_ROUND_UP');

  static const $core.List<AutoSaveTriggerType> values = <AutoSaveTriggerType> [
    AUTO_SAVE_TRIGGER_UNKNOWN,
    AUTO_SAVE_TRIGGER_ON_DEPOSIT,
    AUTO_SAVE_TRIGGER_SCHEDULED,
    AUTO_SAVE_TRIGGER_ROUND_UP,
  ];

  static final $core.Map<$core.int, AutoSaveTriggerType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutoSaveTriggerType? valueOf($core.int value) => _byValue[value];

  const AutoSaveTriggerType._($core.int v, $core.String n) : super(v, n);
}

/// Schedule frequency for scheduled auto-saves
class AutoSaveScheduleFrequency extends $pb.ProtobufEnum {
  static const AutoSaveScheduleFrequency AUTO_SAVE_FREQUENCY_UNKNOWN = AutoSaveScheduleFrequency._(0, _omitEnumNames ? '' : 'AUTO_SAVE_FREQUENCY_UNKNOWN');
  static const AutoSaveScheduleFrequency AUTO_SAVE_FREQUENCY_DAILY = AutoSaveScheduleFrequency._(1, _omitEnumNames ? '' : 'AUTO_SAVE_FREQUENCY_DAILY');
  static const AutoSaveScheduleFrequency AUTO_SAVE_FREQUENCY_WEEKLY = AutoSaveScheduleFrequency._(2, _omitEnumNames ? '' : 'AUTO_SAVE_FREQUENCY_WEEKLY');
  static const AutoSaveScheduleFrequency AUTO_SAVE_FREQUENCY_BIWEEKLY = AutoSaveScheduleFrequency._(3, _omitEnumNames ? '' : 'AUTO_SAVE_FREQUENCY_BIWEEKLY');
  static const AutoSaveScheduleFrequency AUTO_SAVE_FREQUENCY_MONTHLY = AutoSaveScheduleFrequency._(4, _omitEnumNames ? '' : 'AUTO_SAVE_FREQUENCY_MONTHLY');

  static const $core.List<AutoSaveScheduleFrequency> values = <AutoSaveScheduleFrequency> [
    AUTO_SAVE_FREQUENCY_UNKNOWN,
    AUTO_SAVE_FREQUENCY_DAILY,
    AUTO_SAVE_FREQUENCY_WEEKLY,
    AUTO_SAVE_FREQUENCY_BIWEEKLY,
    AUTO_SAVE_FREQUENCY_MONTHLY,
  ];

  static final $core.Map<$core.int, AutoSaveScheduleFrequency> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutoSaveScheduleFrequency? valueOf($core.int value) => _byValue[value];

  const AutoSaveScheduleFrequency._($core.int v, $core.String n) : super(v, n);
}

/// Auto-save rule status
class AutoSaveRuleStatus extends $pb.ProtobufEnum {
  static const AutoSaveRuleStatus AUTO_SAVE_STATUS_UNKNOWN = AutoSaveRuleStatus._(0, _omitEnumNames ? '' : 'AUTO_SAVE_STATUS_UNKNOWN');
  static const AutoSaveRuleStatus AUTO_SAVE_STATUS_ACTIVE = AutoSaveRuleStatus._(1, _omitEnumNames ? '' : 'AUTO_SAVE_STATUS_ACTIVE');
  static const AutoSaveRuleStatus AUTO_SAVE_STATUS_PAUSED = AutoSaveRuleStatus._(2, _omitEnumNames ? '' : 'AUTO_SAVE_STATUS_PAUSED');
  static const AutoSaveRuleStatus AUTO_SAVE_STATUS_COMPLETED = AutoSaveRuleStatus._(3, _omitEnumNames ? '' : 'AUTO_SAVE_STATUS_COMPLETED');
  static const AutoSaveRuleStatus AUTO_SAVE_STATUS_CANCELLED = AutoSaveRuleStatus._(4, _omitEnumNames ? '' : 'AUTO_SAVE_STATUS_CANCELLED');

  static const $core.List<AutoSaveRuleStatus> values = <AutoSaveRuleStatus> [
    AUTO_SAVE_STATUS_UNKNOWN,
    AUTO_SAVE_STATUS_ACTIVE,
    AUTO_SAVE_STATUS_PAUSED,
    AUTO_SAVE_STATUS_COMPLETED,
    AUTO_SAVE_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, AutoSaveRuleStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutoSaveRuleStatus? valueOf($core.int value) => _byValue[value];

  const AutoSaveRuleStatus._($core.int v, $core.String n) : super(v, n);
}

/// Amount calculation type
class AutoSaveAmountType extends $pb.ProtobufEnum {
  static const AutoSaveAmountType AUTO_SAVE_AMOUNT_UNKNOWN = AutoSaveAmountType._(0, _omitEnumNames ? '' : 'AUTO_SAVE_AMOUNT_UNKNOWN');
  static const AutoSaveAmountType AUTO_SAVE_AMOUNT_FIXED = AutoSaveAmountType._(1, _omitEnumNames ? '' : 'AUTO_SAVE_AMOUNT_FIXED');
  static const AutoSaveAmountType AUTO_SAVE_AMOUNT_PERCENTAGE = AutoSaveAmountType._(2, _omitEnumNames ? '' : 'AUTO_SAVE_AMOUNT_PERCENTAGE');

  static const $core.List<AutoSaveAmountType> values = <AutoSaveAmountType> [
    AUTO_SAVE_AMOUNT_UNKNOWN,
    AUTO_SAVE_AMOUNT_FIXED,
    AUTO_SAVE_AMOUNT_PERCENTAGE,
  ];

  static final $core.Map<$core.int, AutoSaveAmountType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutoSaveAmountType? valueOf($core.int value) => _byValue[value];

  const AutoSaveAmountType._($core.int v, $core.String n) : super(v, n);
}

/// Notification channel types
class NotificationChannelType extends $pb.ProtobufEnum {
  static const NotificationChannelType NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED = NotificationChannelType._(0, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED');
  static const NotificationChannelType NOTIFICATION_CHANNEL_TYPE_TELEGRAM = NotificationChannelType._(1, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_TYPE_TELEGRAM');
  static const NotificationChannelType NOTIFICATION_CHANNEL_TYPE_DISCORD = NotificationChannelType._(2, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_TYPE_DISCORD');
  static const NotificationChannelType NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS = NotificationChannelType._(3, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS');
  static const NotificationChannelType NOTIFICATION_CHANNEL_TYPE_SLACK = NotificationChannelType._(4, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_TYPE_SLACK');

  static const $core.List<NotificationChannelType> values = <NotificationChannelType> [
    NOTIFICATION_CHANNEL_TYPE_UNSPECIFIED,
    NOTIFICATION_CHANNEL_TYPE_TELEGRAM,
    NOTIFICATION_CHANNEL_TYPE_DISCORD,
    NOTIFICATION_CHANNEL_TYPE_WHATSAPP_BUSINESS,
    NOTIFICATION_CHANNEL_TYPE_SLACK,
  ];

  static final $core.Map<$core.int, NotificationChannelType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationChannelType? valueOf($core.int value) => _byValue[value];

  const NotificationChannelType._($core.int v, $core.String n) : super(v, n);
}

/// Notification channel status
class NotificationChannelStatus extends $pb.ProtobufEnum {
  static const NotificationChannelStatus NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED = NotificationChannelStatus._(0, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED');
  static const NotificationChannelStatus NOTIFICATION_CHANNEL_STATUS_PENDING = NotificationChannelStatus._(1, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_STATUS_PENDING');
  static const NotificationChannelStatus NOTIFICATION_CHANNEL_STATUS_ACTIVE = NotificationChannelStatus._(2, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_STATUS_ACTIVE');
  static const NotificationChannelStatus NOTIFICATION_CHANNEL_STATUS_PAUSED = NotificationChannelStatus._(3, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_STATUS_PAUSED');
  static const NotificationChannelStatus NOTIFICATION_CHANNEL_STATUS_ERROR = NotificationChannelStatus._(4, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_STATUS_ERROR');
  static const NotificationChannelStatus NOTIFICATION_CHANNEL_STATUS_DISCONNECTED = NotificationChannelStatus._(5, _omitEnumNames ? '' : 'NOTIFICATION_CHANNEL_STATUS_DISCONNECTED');

  static const $core.List<NotificationChannelStatus> values = <NotificationChannelStatus> [
    NOTIFICATION_CHANNEL_STATUS_UNSPECIFIED,
    NOTIFICATION_CHANNEL_STATUS_PENDING,
    NOTIFICATION_CHANNEL_STATUS_ACTIVE,
    NOTIFICATION_CHANNEL_STATUS_PAUSED,
    NOTIFICATION_CHANNEL_STATUS_ERROR,
    NOTIFICATION_CHANNEL_STATUS_DISCONNECTED,
  ];

  static final $core.Map<$core.int, NotificationChannelStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationChannelStatus? valueOf($core.int value) => _byValue[value];

  const NotificationChannelStatus._($core.int v, $core.String n) : super(v, n);
}

/// Notification event types
class NotificationEventType extends $pb.ProtobufEnum {
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_UNSPECIFIED = NotificationEventType._(0, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_UNSPECIFIED');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_NEW_DONATION = NotificationEventType._(1, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_NEW_DONATION');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED = NotificationEventType._(2, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_GOAL_REACHED = NotificationEventType._(3, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_GOAL_REACHED');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR = NotificationEventType._(4, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_LARGE_DONATION = NotificationEventType._(5, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_LARGE_DONATION');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY = NotificationEventType._(6, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING = NotificationEventType._(7, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED = NotificationEventType._(8, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED');
  static const NotificationEventType NOTIFICATION_EVENT_TYPE_WITHDRAWAL = NotificationEventType._(9, _omitEnumNames ? '' : 'NOTIFICATION_EVENT_TYPE_WITHDRAWAL');

  static const $core.List<NotificationEventType> values = <NotificationEventType> [
    NOTIFICATION_EVENT_TYPE_UNSPECIFIED,
    NOTIFICATION_EVENT_TYPE_NEW_DONATION,
    NOTIFICATION_EVENT_TYPE_MILESTONE_REACHED,
    NOTIFICATION_EVENT_TYPE_GOAL_REACHED,
    NOTIFICATION_EVENT_TYPE_NEW_CONTRIBUTOR,
    NOTIFICATION_EVENT_TYPE_LARGE_DONATION,
    NOTIFICATION_EVENT_TYPE_DAILY_SUMMARY,
    NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDING,
    NOTIFICATION_EVENT_TYPE_CAMPAIGN_ENDED,
    NOTIFICATION_EVENT_TYPE_WITHDRAWAL,
  ];

  static final $core.Map<$core.int, NotificationEventType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotificationEventType? valueOf($core.int value) => _byValue[value];

  const NotificationEventType._($core.int v, $core.String n) : super(v, n);
}

class LeaderboardSortBy extends $pb.ProtobufEnum {
  static const LeaderboardSortBy LEADERBOARD_SORT_UNSPECIFIED = LeaderboardSortBy._(0, _omitEnumNames ? '' : 'LEADERBOARD_SORT_UNSPECIFIED');
  static const LeaderboardSortBy LEADERBOARD_SORT_MOST_FUNDED = LeaderboardSortBy._(1, _omitEnumNames ? '' : 'LEADERBOARD_SORT_MOST_FUNDED');
  static const LeaderboardSortBy LEADERBOARD_SORT_MOST_DONORS = LeaderboardSortBy._(2, _omitEnumNames ? '' : 'LEADERBOARD_SORT_MOST_DONORS');
  static const LeaderboardSortBy LEADERBOARD_SORT_TRENDING = LeaderboardSortBy._(3, _omitEnumNames ? '' : 'LEADERBOARD_SORT_TRENDING');
  static const LeaderboardSortBy LEADERBOARD_SORT_NEARLY_COMPLETE = LeaderboardSortBy._(4, _omitEnumNames ? '' : 'LEADERBOARD_SORT_NEARLY_COMPLETE');
  static const LeaderboardSortBy LEADERBOARD_SORT_NEWEST = LeaderboardSortBy._(5, _omitEnumNames ? '' : 'LEADERBOARD_SORT_NEWEST');

  static const $core.List<LeaderboardSortBy> values = <LeaderboardSortBy> [
    LEADERBOARD_SORT_UNSPECIFIED,
    LEADERBOARD_SORT_MOST_FUNDED,
    LEADERBOARD_SORT_MOST_DONORS,
    LEADERBOARD_SORT_TRENDING,
    LEADERBOARD_SORT_NEARLY_COMPLETE,
    LEADERBOARD_SORT_NEWEST,
  ];

  static final $core.Map<$core.int, LeaderboardSortBy> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LeaderboardSortBy? valueOf($core.int value) => _byValue[value];

  const LeaderboardSortBy._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
