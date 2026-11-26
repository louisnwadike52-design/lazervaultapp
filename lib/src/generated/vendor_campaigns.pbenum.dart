// This is a generated file - do not edit.
//
// Generated from vendor_campaigns.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class VendorCampaignStatus extends $pb.ProtobufEnum {
  static const VendorCampaignStatus VENDOR_CAMPAIGN_STATUS_UNSPECIFIED =
      VendorCampaignStatus._(
          0, _omitEnumNames ? '' : 'VENDOR_CAMPAIGN_STATUS_UNSPECIFIED');
  static const VendorCampaignStatus VENDOR_CAMPAIGN_STATUS_SCHEDULED =
      VendorCampaignStatus._(
          1, _omitEnumNames ? '' : 'VENDOR_CAMPAIGN_STATUS_SCHEDULED');
  static const VendorCampaignStatus VENDOR_CAMPAIGN_STATUS_ACTIVE =
      VendorCampaignStatus._(
          2, _omitEnumNames ? '' : 'VENDOR_CAMPAIGN_STATUS_ACTIVE');
  static const VendorCampaignStatus VENDOR_CAMPAIGN_STATUS_CLOSED =
      VendorCampaignStatus._(
          3, _omitEnumNames ? '' : 'VENDOR_CAMPAIGN_STATUS_CLOSED');

  /// Reached its redemption limit and stopped itself. Distinct from CLOSED
  /// because "we ran out of budget" and "the evening ended" are different
  /// things for an operator to read.
  static const VendorCampaignStatus VENDOR_CAMPAIGN_STATUS_EXHAUSTED =
      VendorCampaignStatus._(
          4, _omitEnumNames ? '' : 'VENDOR_CAMPAIGN_STATUS_EXHAUSTED');
  static const VendorCampaignStatus VENDOR_CAMPAIGN_STATUS_CANCELLED =
      VendorCampaignStatus._(
          5, _omitEnumNames ? '' : 'VENDOR_CAMPAIGN_STATUS_CANCELLED');

  static const $core.List<VendorCampaignStatus> values = <VendorCampaignStatus>[
    VENDOR_CAMPAIGN_STATUS_UNSPECIFIED,
    VENDOR_CAMPAIGN_STATUS_SCHEDULED,
    VENDOR_CAMPAIGN_STATUS_ACTIVE,
    VENDOR_CAMPAIGN_STATUS_CLOSED,
    VENDOR_CAMPAIGN_STATUS_EXHAUSTED,
    VENDOR_CAMPAIGN_STATUS_CANCELLED,
  ];

  static final $core.List<VendorCampaignStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static VendorCampaignStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VendorCampaignStatus._(super.value, super.name);
}

class VendorStatus extends $pb.ProtobufEnum {
  static const VendorStatus VENDOR_STATUS_UNSPECIFIED =
      VendorStatus._(0, _omitEnumNames ? '' : 'VENDOR_STATUS_UNSPECIFIED');
  static const VendorStatus VENDOR_STATUS_ACTIVE =
      VendorStatus._(1, _omitEnumNames ? '' : 'VENDOR_STATUS_ACTIVE');
  static const VendorStatus VENDOR_STATUS_SUSPENDED =
      VendorStatus._(2, _omitEnumNames ? '' : 'VENDOR_STATUS_SUSPENDED');

  static const $core.List<VendorStatus> values = <VendorStatus>[
    VENDOR_STATUS_UNSPECIFIED,
    VENDOR_STATUS_ACTIVE,
    VENDOR_STATUS_SUSPENDED,
  ];

  static final $core.List<VendorStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static VendorStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VendorStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
