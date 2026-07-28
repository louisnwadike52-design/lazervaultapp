// This is a generated file - do not edit.
//
// Generated from bulk-sms.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CampaignStatus extends $pb.ProtobufEnum {
  static const CampaignStatus CAMPAIGN_STATUS_UNSPECIFIED =
      CampaignStatus._(0, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_UNSPECIFIED');
  static const CampaignStatus CAMPAIGN_STATUS_PENDING =
      CampaignStatus._(1, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_PENDING');
  static const CampaignStatus CAMPAIGN_STATUS_SENDING =
      CampaignStatus._(2, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_SENDING');
  static const CampaignStatus CAMPAIGN_STATUS_COMPLETED =
      CampaignStatus._(3, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_COMPLETED');
  static const CampaignStatus CAMPAIGN_STATUS_FAILED =
      CampaignStatus._(4, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_FAILED');
  static const CampaignStatus CAMPAIGN_STATUS_SCHEDULED =
      CampaignStatus._(5, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_SCHEDULED');
  static const CampaignStatus CAMPAIGN_STATUS_CANCELLED =
      CampaignStatus._(6, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_CANCELLED');
  static const CampaignStatus CAMPAIGN_STATUS_PARTIALLY_COMPLETED =
      CampaignStatus._(
          7, _omitEnumNames ? '' : 'CAMPAIGN_STATUS_PARTIALLY_COMPLETED');

  static const $core.List<CampaignStatus> values = <CampaignStatus>[
    CAMPAIGN_STATUS_UNSPECIFIED,
    CAMPAIGN_STATUS_PENDING,
    CAMPAIGN_STATUS_SENDING,
    CAMPAIGN_STATUS_COMPLETED,
    CAMPAIGN_STATUS_FAILED,
    CAMPAIGN_STATUS_SCHEDULED,
    CAMPAIGN_STATUS_CANCELLED,
    CAMPAIGN_STATUS_PARTIALLY_COMPLETED,
  ];

  static final $core.List<CampaignStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static CampaignStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CampaignStatus._(super.value, super.name);
}

class DeliveryStatus extends $pb.ProtobufEnum {
  static const DeliveryStatus DELIVERY_STATUS_UNSPECIFIED =
      DeliveryStatus._(0, _omitEnumNames ? '' : 'DELIVERY_STATUS_UNSPECIFIED');
  static const DeliveryStatus DELIVERY_STATUS_PENDING =
      DeliveryStatus._(1, _omitEnumNames ? '' : 'DELIVERY_STATUS_PENDING');
  static const DeliveryStatus DELIVERY_STATUS_SENT =
      DeliveryStatus._(2, _omitEnumNames ? '' : 'DELIVERY_STATUS_SENT');
  static const DeliveryStatus DELIVERY_STATUS_DELIVERED =
      DeliveryStatus._(3, _omitEnumNames ? '' : 'DELIVERY_STATUS_DELIVERED');
  static const DeliveryStatus DELIVERY_STATUS_FAILED =
      DeliveryStatus._(4, _omitEnumNames ? '' : 'DELIVERY_STATUS_FAILED');
  static const DeliveryStatus DELIVERY_STATUS_DND_FILTERED =
      DeliveryStatus._(5, _omitEnumNames ? '' : 'DELIVERY_STATUS_DND_FILTERED');
  static const DeliveryStatus DELIVERY_STATUS_INVALID_NUMBER = DeliveryStatus._(
      6, _omitEnumNames ? '' : 'DELIVERY_STATUS_INVALID_NUMBER');
  static const DeliveryStatus DELIVERY_STATUS_REJECTED =
      DeliveryStatus._(7, _omitEnumNames ? '' : 'DELIVERY_STATUS_REJECTED');

  static const $core.List<DeliveryStatus> values = <DeliveryStatus>[
    DELIVERY_STATUS_UNSPECIFIED,
    DELIVERY_STATUS_PENDING,
    DELIVERY_STATUS_SENT,
    DELIVERY_STATUS_DELIVERED,
    DELIVERY_STATUS_FAILED,
    DELIVERY_STATUS_DND_FILTERED,
    DELIVERY_STATUS_INVALID_NUMBER,
    DELIVERY_STATUS_REJECTED,
  ];

  static final $core.List<DeliveryStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static DeliveryStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const DeliveryStatus._(super.value, super.name);
}

class SenderIdStatus extends $pb.ProtobufEnum {
  static const SenderIdStatus SENDER_ID_STATUS_UNSPECIFIED =
      SenderIdStatus._(0, _omitEnumNames ? '' : 'SENDER_ID_STATUS_UNSPECIFIED');
  static const SenderIdStatus SENDER_ID_STATUS_PENDING =
      SenderIdStatus._(1, _omitEnumNames ? '' : 'SENDER_ID_STATUS_PENDING');
  static const SenderIdStatus SENDER_ID_STATUS_APPROVED =
      SenderIdStatus._(2, _omitEnumNames ? '' : 'SENDER_ID_STATUS_APPROVED');
  static const SenderIdStatus SENDER_ID_STATUS_REJECTED =
      SenderIdStatus._(3, _omitEnumNames ? '' : 'SENDER_ID_STATUS_REJECTED');

  static const $core.List<SenderIdStatus> values = <SenderIdStatus>[
    SENDER_ID_STATUS_UNSPECIFIED,
    SENDER_ID_STATUS_PENDING,
    SENDER_ID_STATUS_APPROVED,
    SENDER_ID_STATUS_REJECTED,
  ];

  static final $core.List<SenderIdStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SenderIdStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SenderIdStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
