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


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
