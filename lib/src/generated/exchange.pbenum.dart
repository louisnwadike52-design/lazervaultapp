//
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum for transaction status
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

  const ExchangeStatus._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
