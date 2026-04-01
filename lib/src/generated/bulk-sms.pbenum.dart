///
//  Generated code. Do not modify.
//  source: bulk-sms.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CampaignStatus extends $pb.ProtobufEnum {
  static const CampaignStatus CAMPAIGN_STATUS_UNSPECIFIED = CampaignStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_UNSPECIFIED');
  static const CampaignStatus CAMPAIGN_STATUS_PENDING = CampaignStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_PENDING');
  static const CampaignStatus CAMPAIGN_STATUS_SENDING = CampaignStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_SENDING');
  static const CampaignStatus CAMPAIGN_STATUS_COMPLETED = CampaignStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_COMPLETED');
  static const CampaignStatus CAMPAIGN_STATUS_FAILED = CampaignStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_FAILED');
  static const CampaignStatus CAMPAIGN_STATUS_SCHEDULED = CampaignStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_SCHEDULED');
  static const CampaignStatus CAMPAIGN_STATUS_CANCELLED = CampaignStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_CANCELLED');
  static const CampaignStatus CAMPAIGN_STATUS_PARTIALLY_COMPLETED = CampaignStatus._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CAMPAIGN_STATUS_PARTIALLY_COMPLETED');

  static const $core.List<CampaignStatus> values = <CampaignStatus> [
    CAMPAIGN_STATUS_UNSPECIFIED,
    CAMPAIGN_STATUS_PENDING,
    CAMPAIGN_STATUS_SENDING,
    CAMPAIGN_STATUS_COMPLETED,
    CAMPAIGN_STATUS_FAILED,
    CAMPAIGN_STATUS_SCHEDULED,
    CAMPAIGN_STATUS_CANCELLED,
    CAMPAIGN_STATUS_PARTIALLY_COMPLETED,
  ];

  static final $core.Map<$core.int, CampaignStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CampaignStatus? valueOf($core.int value) => _byValue[value];

  const CampaignStatus._($core.int v, $core.String n) : super(v, n);
}

class DeliveryStatus extends $pb.ProtobufEnum {
  static const DeliveryStatus DELIVERY_STATUS_UNSPECIFIED = DeliveryStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_UNSPECIFIED');
  static const DeliveryStatus DELIVERY_STATUS_PENDING = DeliveryStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_PENDING');
  static const DeliveryStatus DELIVERY_STATUS_SENT = DeliveryStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_SENT');
  static const DeliveryStatus DELIVERY_STATUS_DELIVERED = DeliveryStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_DELIVERED');
  static const DeliveryStatus DELIVERY_STATUS_FAILED = DeliveryStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_FAILED');
  static const DeliveryStatus DELIVERY_STATUS_DND_FILTERED = DeliveryStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_DND_FILTERED');
  static const DeliveryStatus DELIVERY_STATUS_INVALID_NUMBER = DeliveryStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_INVALID_NUMBER');
  static const DeliveryStatus DELIVERY_STATUS_REJECTED = DeliveryStatus._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELIVERY_STATUS_REJECTED');

  static const $core.List<DeliveryStatus> values = <DeliveryStatus> [
    DELIVERY_STATUS_UNSPECIFIED,
    DELIVERY_STATUS_PENDING,
    DELIVERY_STATUS_SENT,
    DELIVERY_STATUS_DELIVERED,
    DELIVERY_STATUS_FAILED,
    DELIVERY_STATUS_DND_FILTERED,
    DELIVERY_STATUS_INVALID_NUMBER,
    DELIVERY_STATUS_REJECTED,
  ];

  static final $core.Map<$core.int, DeliveryStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DeliveryStatus? valueOf($core.int value) => _byValue[value];

  const DeliveryStatus._($core.int v, $core.String n) : super(v, n);
}

class SenderIdStatus extends $pb.ProtobufEnum {
  static const SenderIdStatus SENDER_ID_STATUS_UNSPECIFIED = SenderIdStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDER_ID_STATUS_UNSPECIFIED');
  static const SenderIdStatus SENDER_ID_STATUS_PENDING = SenderIdStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDER_ID_STATUS_PENDING');
  static const SenderIdStatus SENDER_ID_STATUS_APPROVED = SenderIdStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDER_ID_STATUS_APPROVED');
  static const SenderIdStatus SENDER_ID_STATUS_REJECTED = SenderIdStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENDER_ID_STATUS_REJECTED');

  static const $core.List<SenderIdStatus> values = <SenderIdStatus> [
    SENDER_ID_STATUS_UNSPECIFIED,
    SENDER_ID_STATUS_PENDING,
    SENDER_ID_STATUS_APPROVED,
    SENDER_ID_STATUS_REJECTED,
  ];

  static final $core.Map<$core.int, SenderIdStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SenderIdStatus? valueOf($core.int value) => _byValue[value];

  const SenderIdStatus._($core.int v, $core.String n) : super(v, n);
}

