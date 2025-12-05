///
//  Generated code. Do not modify.
//  source: exchange.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ExchangeStatus extends $pb.ProtobufEnum {
  static const ExchangeStatus PENDING = ExchangeStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PENDING');
  static const ExchangeStatus PROCESSING = ExchangeStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PROCESSING');
  static const ExchangeStatus COMPLETED = ExchangeStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETED');
  static const ExchangeStatus FAILED = ExchangeStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILED');
  static const ExchangeStatus CANCELLED = ExchangeStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CANCELLED');

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

