//
//  Generated code. Do not modify.
//  source: banking.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Credit Score Source
class CreditScoreSource extends $pb.ProtobufEnum {
  static const CreditScoreSource CREDIT_SCORE_SOURCE_UNSPECIFIED = CreditScoreSource._(0, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_UNSPECIFIED');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_LAZERVAULT = CreditScoreSource._(1, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_LAZERVAULT');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_EXTERNAL = CreditScoreSource._(2, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_EXTERNAL');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_COMBINED = CreditScoreSource._(3, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_COMBINED');

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


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
