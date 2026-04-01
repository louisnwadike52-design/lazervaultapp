///
//  Generated code. Do not modify.
//  source: banking.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CreditScoreSource extends $pb.ProtobufEnum {
  static const CreditScoreSource CREDIT_SCORE_SOURCE_UNSPECIFIED = CreditScoreSource._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREDIT_SCORE_SOURCE_UNSPECIFIED');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_LAZERVAULT = CreditScoreSource._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREDIT_SCORE_SOURCE_LAZERVAULT');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_EXTERNAL = CreditScoreSource._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREDIT_SCORE_SOURCE_EXTERNAL');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_COMBINED = CreditScoreSource._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREDIT_SCORE_SOURCE_COMBINED');

  static const $core.List<CreditScoreSource> values = <CreditScoreSource> [
    CREDIT_SCORE_SOURCE_UNSPECIFIED,
    CREDIT_SCORE_SOURCE_LAZERVAULT,
    CREDIT_SCORE_SOURCE_EXTERNAL,
    CREDIT_SCORE_SOURCE_COMBINED,
  ];

  static final $core.Map<$core.int, CreditScoreSource> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreditScoreSource? valueOf($core.int value) => _byValue[value];

  const CreditScoreSource._($core.int v, $core.String n) : super(v, n);
}

