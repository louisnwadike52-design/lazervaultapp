///
//  Generated code. Do not modify.
//  source: referral.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ReferralStatus extends $pb.ProtobufEnum {
  static const ReferralStatus REFERRAL_STATUS_PENDING = ReferralStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REFERRAL_STATUS_PENDING');
  static const ReferralStatus REFERRAL_STATUS_COMPLETED = ReferralStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REFERRAL_STATUS_COMPLETED');
  static const ReferralStatus REFERRAL_STATUS_FAILED = ReferralStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REFERRAL_STATUS_FAILED');
  static const ReferralStatus REFERRAL_STATUS_CANCELLED = ReferralStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REFERRAL_STATUS_CANCELLED');

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

