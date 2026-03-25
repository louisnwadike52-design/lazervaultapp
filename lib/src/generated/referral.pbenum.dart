// This is a generated file - do not edit.
//
// Generated from referral.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Referral status enum
class ReferralStatus extends $pb.ProtobufEnum {
  static const ReferralStatus REFERRAL_STATUS_PENDING =
      ReferralStatus._(0, _omitEnumNames ? '' : 'REFERRAL_STATUS_PENDING');
  static const ReferralStatus REFERRAL_STATUS_COMPLETED =
      ReferralStatus._(1, _omitEnumNames ? '' : 'REFERRAL_STATUS_COMPLETED');
  static const ReferralStatus REFERRAL_STATUS_FAILED =
      ReferralStatus._(2, _omitEnumNames ? '' : 'REFERRAL_STATUS_FAILED');
  static const ReferralStatus REFERRAL_STATUS_CANCELLED =
      ReferralStatus._(3, _omitEnumNames ? '' : 'REFERRAL_STATUS_CANCELLED');

  static const $core.List<ReferralStatus> values = <ReferralStatus>[
    REFERRAL_STATUS_PENDING,
    REFERRAL_STATUS_COMPLETED,
    REFERRAL_STATUS_FAILED,
    REFERRAL_STATUS_CANCELLED,
  ];

  static final $core.List<ReferralStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ReferralStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReferralStatus._(super.value, super.name);
}

/// Point source types
class PointSource extends $pb.ProtobufEnum {
  static const PointSource POINT_SOURCE_REFERRAL =
      PointSource._(0, _omitEnumNames ? '' : 'POINT_SOURCE_REFERRAL');
  static const PointSource POINT_SOURCE_SIGNUP_BONUS =
      PointSource._(1, _omitEnumNames ? '' : 'POINT_SOURCE_SIGNUP_BONUS');
  static const PointSource POINT_SOURCE_FIRST_TRANSACTION =
      PointSource._(2, _omitEnumNames ? '' : 'POINT_SOURCE_FIRST_TRANSACTION');
  static const PointSource POINT_SOURCE_MONTHLY_ACTIVE =
      PointSource._(3, _omitEnumNames ? '' : 'POINT_SOURCE_MONTHLY_ACTIVE');
  static const PointSource POINT_SOURCE_ACHIEVEMENT =
      PointSource._(4, _omitEnumNames ? '' : 'POINT_SOURCE_ACHIEVEMENT');
  static const PointSource POINT_SOURCE_REDEMPTION =
      PointSource._(5, _omitEnumNames ? '' : 'POINT_SOURCE_REDEMPTION');

  static const $core.List<PointSource> values = <PointSource>[
    POINT_SOURCE_REFERRAL,
    POINT_SOURCE_SIGNUP_BONUS,
    POINT_SOURCE_FIRST_TRANSACTION,
    POINT_SOURCE_MONTHLY_ACTIVE,
    POINT_SOURCE_ACHIEVEMENT,
    POINT_SOURCE_REDEMPTION,
  ];

  static final $core.List<PointSource?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static PointSource? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PointSource._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
