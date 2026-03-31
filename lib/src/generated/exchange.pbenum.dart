//
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExchangeStatus extends $pb.ProtobufEnum {
  static const ExchangeStatus PENDING = ExchangeStatus._(0, _omitEnumNames ? '' : 'PENDING');
  static const ExchangeStatus PROCESSING = ExchangeStatus._(1, _omitEnumNames ? '' : 'PROCESSING');
  static const ExchangeStatus COMPLETED = ExchangeStatus._(2, _omitEnumNames ? '' : 'COMPLETED');
  static const ExchangeStatus FAILED = ExchangeStatus._(3, _omitEnumNames ? '' : 'FAILED');
  static const ExchangeStatus CANCELLED = ExchangeStatus._(4, _omitEnumNames ? '' : 'CANCELLED');

  static const $core.List<ExchangeStatus> values = <ExchangeStatus> [
    PENDING,
    PROCESSING,
    COMPLETED,
    FAILED,
    CANCELLED,
  ];

  static final $core.Map<$core.int, ExchangeStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExchangeStatus? valueOf($core.int value) => _byValue[value];

  const ExchangeStatus._($core.int v, $core.String n) : super(v, n);
}

class ExchangeType extends $pb.ProtobufEnum {
  static const ExchangeType EXCHANGE_TYPE_UNSPECIFIED = ExchangeType._(0, _omitEnumNames ? '' : 'EXCHANGE_TYPE_UNSPECIFIED');
  static const ExchangeType CONVERSION = ExchangeType._(1, _omitEnumNames ? '' : 'CONVERSION');
  static const ExchangeType INTERNATIONAL = ExchangeType._(2, _omitEnumNames ? '' : 'INTERNATIONAL');

  static const $core.List<ExchangeType> values = <ExchangeType> [
    EXCHANGE_TYPE_UNSPECIFIED,
    CONVERSION,
    INTERNATIONAL,
  ];

  static final $core.Map<$core.int, ExchangeType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExchangeType? valueOf($core.int value) => _byValue[value];

  const ExchangeType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
