// This is a generated file - do not edit.
//
// Generated from rmb.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RmbRail extends $pb.ProtobufEnum {
  static const RmbRail RAIL_UNSPECIFIED =
      RmbRail._(0, _omitEnumNames ? '' : 'RAIL_UNSPECIFIED');
  static const RmbRail ALIPAY = RmbRail._(1, _omitEnumNames ? '' : 'ALIPAY');
  static const RmbRail WECHAT = RmbRail._(2, _omitEnumNames ? '' : 'WECHAT');
  static const RmbRail UNIONPAY =
      RmbRail._(3, _omitEnumNames ? '' : 'UNIONPAY');
  static const RmbRail BANK = RmbRail._(4, _omitEnumNames ? '' : 'BANK');

  static const $core.List<RmbRail> values = <RmbRail>[
    RAIL_UNSPECIFIED,
    ALIPAY,
    WECHAT,
    UNIONPAY,
    BANK,
  ];

  static final $core.List<RmbRail?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static RmbRail? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RmbRail._(super.value, super.name);
}

class RmbStatus extends $pb.ProtobufEnum {
  static const RmbStatus RMB_STATUS_UNSPECIFIED =
      RmbStatus._(0, _omitEnumNames ? '' : 'RMB_STATUS_UNSPECIFIED');
  static const RmbStatus RMB_PENDING =
      RmbStatus._(1, _omitEnumNames ? '' : 'RMB_PENDING');
  static const RmbStatus RMB_PROCESSING =
      RmbStatus._(2, _omitEnumNames ? '' : 'RMB_PROCESSING');
  static const RmbStatus RMB_COMPLETED =
      RmbStatus._(3, _omitEnumNames ? '' : 'RMB_COMPLETED');
  static const RmbStatus RMB_FAILED =
      RmbStatus._(4, _omitEnumNames ? '' : 'RMB_FAILED');
  static const RmbStatus RMB_REFUNDED =
      RmbStatus._(5, _omitEnumNames ? '' : 'RMB_REFUNDED');
  static const RmbStatus RMB_PENDING_COMPLIANCE =
      RmbStatus._(6, _omitEnumNames ? '' : 'RMB_PENDING_COMPLIANCE');
  static const RmbStatus RMB_CANCELLED =
      RmbStatus._(7, _omitEnumNames ? '' : 'RMB_CANCELLED');

  static const $core.List<RmbStatus> values = <RmbStatus>[
    RMB_STATUS_UNSPECIFIED,
    RMB_PENDING,
    RMB_PROCESSING,
    RMB_COMPLETED,
    RMB_FAILED,
    RMB_REFUNDED,
    RMB_PENDING_COMPLIANCE,
    RMB_CANCELLED,
  ];

  static final $core.List<RmbStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 7);
  static RmbStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RmbStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
