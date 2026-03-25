// This is a generated file - do not edit.
//
// Generated from exchange.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExchangeStatus extends $pb.ProtobufEnum {
  static const ExchangeStatus PENDING =
      ExchangeStatus._(0, _omitEnumNames ? '' : 'PENDING');
  static const ExchangeStatus PROCESSING =
      ExchangeStatus._(1, _omitEnumNames ? '' : 'PROCESSING');
  static const ExchangeStatus COMPLETED =
      ExchangeStatus._(2, _omitEnumNames ? '' : 'COMPLETED');
  static const ExchangeStatus FAILED =
      ExchangeStatus._(3, _omitEnumNames ? '' : 'FAILED');
  static const ExchangeStatus CANCELLED =
      ExchangeStatus._(4, _omitEnumNames ? '' : 'CANCELLED');

  static const $core.List<ExchangeStatus> values = <ExchangeStatus>[
    PENDING,
    PROCESSING,
    COMPLETED,
    FAILED,
    CANCELLED,
  ];

  static final $core.List<ExchangeStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ExchangeStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ExchangeStatus._(super.value, super.name);
}

class ExchangeType extends $pb.ProtobufEnum {
  static const ExchangeType EXCHANGE_TYPE_UNSPECIFIED =
      ExchangeType._(0, _omitEnumNames ? '' : 'EXCHANGE_TYPE_UNSPECIFIED');
  static const ExchangeType CONVERSION =
      ExchangeType._(1, _omitEnumNames ? '' : 'CONVERSION');
  static const ExchangeType INTERNATIONAL =
      ExchangeType._(2, _omitEnumNames ? '' : 'INTERNATIONAL');

  static const $core.List<ExchangeType> values = <ExchangeType>[
    EXCHANGE_TYPE_UNSPECIFIED,
    CONVERSION,
    INTERNATIONAL,
  ];

  static final $core.List<ExchangeType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ExchangeType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ExchangeType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
