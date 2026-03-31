//
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CrowdfundStatus extends $pb.ProtobufEnum {
  static const CrowdfundStatus CROWDFUND_STATUS_UNSPECIFIED = CrowdfundStatus._(0, _omitEnumNames ? '' : 'CROWDFUND_STATUS_UNSPECIFIED');
  static const CrowdfundStatus CROWDFUND_STATUS_ACTIVE = CrowdfundStatus._(1, _omitEnumNames ? '' : 'CROWDFUND_STATUS_ACTIVE');
  static const CrowdfundStatus CROWDFUND_STATUS_PAUSED = CrowdfundStatus._(2, _omitEnumNames ? '' : 'CROWDFUND_STATUS_PAUSED');
  static const CrowdfundStatus CROWDFUND_STATUS_COMPLETED = CrowdfundStatus._(3, _omitEnumNames ? '' : 'CROWDFUND_STATUS_COMPLETED');
  static const CrowdfundStatus CROWDFUND_STATUS_CANCELLED = CrowdfundStatus._(4, _omitEnumNames ? '' : 'CROWDFUND_STATUS_CANCELLED');

  static const $core.List<CrowdfundStatus> values = <CrowdfundStatus> [
    CROWDFUND_STATUS_UNSPECIFIED,
    CROWDFUND_STATUS_ACTIVE,
    CROWDFUND_STATUS_PAUSED,
    CROWDFUND_STATUS_COMPLETED,
    CROWDFUND_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, CrowdfundStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CrowdfundStatus? valueOf($core.int value) => _byValue[value];

  const CrowdfundStatus._($core.int v, $core.String n) : super(v, n);
}

class CrowdfundVisibility extends $pb.ProtobufEnum {
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_UNSPECIFIED = CrowdfundVisibility._(0, _omitEnumNames ? '' : 'CROWDFUND_VISIBILITY_UNSPECIFIED');
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_PUBLIC = CrowdfundVisibility._(1, _omitEnumNames ? '' : 'CROWDFUND_VISIBILITY_PUBLIC');
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_PRIVATE = CrowdfundVisibility._(2, _omitEnumNames ? '' : 'CROWDFUND_VISIBILITY_PRIVATE');
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_UNLISTED = CrowdfundVisibility._(3, _omitEnumNames ? '' : 'CROWDFUND_VISIBILITY_UNLISTED');

  static const $core.List<CrowdfundVisibility> values = <CrowdfundVisibility> [
    CROWDFUND_VISIBILITY_UNSPECIFIED,
    CROWDFUND_VISIBILITY_PUBLIC,
    CROWDFUND_VISIBILITY_PRIVATE,
    CROWDFUND_VISIBILITY_UNLISTED,
  ];

  static final $core.Map<$core.int, CrowdfundVisibility> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CrowdfundVisibility? valueOf($core.int value) => _byValue[value];

  const CrowdfundVisibility._($core.int v, $core.String n) : super(v, n);
}

class DonationStatus extends $pb.ProtobufEnum {
  static const DonationStatus DONATION_STATUS_UNSPECIFIED = DonationStatus._(0, _omitEnumNames ? '' : 'DONATION_STATUS_UNSPECIFIED');
  static const DonationStatus DONATION_STATUS_PENDING = DonationStatus._(1, _omitEnumNames ? '' : 'DONATION_STATUS_PENDING');
  static const DonationStatus DONATION_STATUS_PROCESSING = DonationStatus._(2, _omitEnumNames ? '' : 'DONATION_STATUS_PROCESSING');
  static const DonationStatus DONATION_STATUS_COMPLETED = DonationStatus._(3, _omitEnumNames ? '' : 'DONATION_STATUS_COMPLETED');
  static const DonationStatus DONATION_STATUS_FAILED = DonationStatus._(4, _omitEnumNames ? '' : 'DONATION_STATUS_FAILED');
  static const DonationStatus DONATION_STATUS_REFUNDED = DonationStatus._(5, _omitEnumNames ? '' : 'DONATION_STATUS_REFUNDED');

  static const $core.List<DonationStatus> values = <DonationStatus> [
    DONATION_STATUS_UNSPECIFIED,
    DONATION_STATUS_PENDING,
    DONATION_STATUS_PROCESSING,
    DONATION_STATUS_COMPLETED,
    DONATION_STATUS_FAILED,
    DONATION_STATUS_REFUNDED,
  ];

  static final $core.Map<$core.int, DonationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DonationStatus? valueOf($core.int value) => _byValue[value];

  const DonationStatus._($core.int v, $core.String n) : super(v, n);
}

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
