//
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Referral status enum
class ReferralStatus extends $pb.ProtobufEnum {
  static const ReferralStatus REFERRAL_STATUS_PENDING = ReferralStatus._(0, _omitEnumNames ? '' : 'REFERRAL_STATUS_PENDING');
  static const ReferralStatus REFERRAL_STATUS_COMPLETED = ReferralStatus._(1, _omitEnumNames ? '' : 'REFERRAL_STATUS_COMPLETED');
  static const ReferralStatus REFERRAL_STATUS_FAILED = ReferralStatus._(2, _omitEnumNames ? '' : 'REFERRAL_STATUS_FAILED');
  static const ReferralStatus REFERRAL_STATUS_CANCELLED = ReferralStatus._(3, _omitEnumNames ? '' : 'REFERRAL_STATUS_CANCELLED');

  static const $core.List<ReferralStatus> values = <ReferralStatus> [
    REFERRAL_STATUS_PENDING,
    REFERRAL_STATUS_COMPLETED,
    REFERRAL_STATUS_FAILED,
    REFERRAL_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, ReferralStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ReferralStatus? valueOf($core.int value) => _byValue[value];

  const ReferralStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
