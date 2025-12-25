///
//  Generated code. Do not modify.
//  source: crowdfund.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CrowdfundStatus extends $pb.ProtobufEnum {
  static const CrowdfundStatus CROWDFUND_STATUS_UNSPECIFIED = CrowdfundStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_STATUS_UNSPECIFIED');
  static const CrowdfundStatus CROWDFUND_STATUS_ACTIVE = CrowdfundStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_STATUS_ACTIVE');
  static const CrowdfundStatus CROWDFUND_STATUS_PAUSED = CrowdfundStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_STATUS_PAUSED');
  static const CrowdfundStatus CROWDFUND_STATUS_COMPLETED = CrowdfundStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_STATUS_COMPLETED');
  static const CrowdfundStatus CROWDFUND_STATUS_CANCELLED = CrowdfundStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_STATUS_CANCELLED');

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
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_UNSPECIFIED = CrowdfundVisibility._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_VISIBILITY_UNSPECIFIED');
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_PUBLIC = CrowdfundVisibility._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_VISIBILITY_PUBLIC');
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_PRIVATE = CrowdfundVisibility._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_VISIBILITY_PRIVATE');
  static const CrowdfundVisibility CROWDFUND_VISIBILITY_UNLISTED = CrowdfundVisibility._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CROWDFUND_VISIBILITY_UNLISTED');

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
  static const DonationStatus DONATION_STATUS_UNSPECIFIED = DonationStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONATION_STATUS_UNSPECIFIED');
  static const DonationStatus DONATION_STATUS_PENDING = DonationStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONATION_STATUS_PENDING');
  static const DonationStatus DONATION_STATUS_PROCESSING = DonationStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONATION_STATUS_PROCESSING');
  static const DonationStatus DONATION_STATUS_COMPLETED = DonationStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONATION_STATUS_COMPLETED');
  static const DonationStatus DONATION_STATUS_FAILED = DonationStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONATION_STATUS_FAILED');
  static const DonationStatus DONATION_STATUS_REFUNDED = DonationStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DONATION_STATUS_REFUNDED');

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

