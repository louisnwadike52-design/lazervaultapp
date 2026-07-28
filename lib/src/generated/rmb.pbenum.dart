///
//  Generated code. Do not modify.
//  source: rmb.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class RmbRail extends $pb.ProtobufEnum {
  static const RmbRail RAIL_UNSPECIFIED = RmbRail._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RAIL_UNSPECIFIED');
  static const RmbRail ALIPAY = RmbRail._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALIPAY');
  static const RmbRail WECHAT = RmbRail._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WECHAT');
  static const RmbRail UNIONPAY = RmbRail._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNIONPAY');
  static const RmbRail BANK = RmbRail._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BANK');

  static const $core.List<RmbRail> values = <RmbRail> [
    RAIL_UNSPECIFIED,
    ALIPAY,
    WECHAT,
    UNIONPAY,
    BANK,
  ];

  static final $core.Map<$core.int, RmbRail> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RmbRail? valueOf($core.int value) => _byValue[value];

  const RmbRail._($core.int v, $core.String n) : super(v, n);
}

class RmbStatus extends $pb.ProtobufEnum {
  static const RmbStatus RMB_STATUS_UNSPECIFIED = RmbStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_STATUS_UNSPECIFIED');
  static const RmbStatus RMB_PENDING = RmbStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_PENDING');
  static const RmbStatus RMB_PROCESSING = RmbStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_PROCESSING');
  static const RmbStatus RMB_COMPLETED = RmbStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_COMPLETED');
  static const RmbStatus RMB_FAILED = RmbStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_FAILED');
  static const RmbStatus RMB_REFUNDED = RmbStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_REFUNDED');
  static const RmbStatus RMB_PENDING_COMPLIANCE = RmbStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_PENDING_COMPLIANCE');
  static const RmbStatus RMB_CANCELLED = RmbStatus._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RMB_CANCELLED');

  static const $core.List<RmbStatus> values = <RmbStatus> [
    RMB_STATUS_UNSPECIFIED,
    RMB_PENDING,
    RMB_PROCESSING,
    RMB_COMPLETED,
    RMB_FAILED,
    RMB_REFUNDED,
    RMB_PENDING_COMPLIANCE,
    RMB_CANCELLED,
  ];

  static final $core.Map<$core.int, RmbStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RmbStatus? valueOf($core.int value) => _byValue[value];

  const RmbStatus._($core.int v, $core.String n) : super(v, n);
}

