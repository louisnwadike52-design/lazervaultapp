// This is a generated file - do not edit.
//
// Generated from banking.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Credit Score Source
class CreditScoreSource extends $pb.ProtobufEnum {
  static const CreditScoreSource CREDIT_SCORE_SOURCE_UNSPECIFIED =
      CreditScoreSource._(
          0, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_UNSPECIFIED');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_LAZERVAULT =
      CreditScoreSource._(
          1, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_LAZERVAULT');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_EXTERNAL =
      CreditScoreSource._(
          2, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_EXTERNAL');
  static const CreditScoreSource CREDIT_SCORE_SOURCE_COMBINED =
      CreditScoreSource._(
          3, _omitEnumNames ? '' : 'CREDIT_SCORE_SOURCE_COMBINED');

  static const $core.List<CreditScoreSource> values = <CreditScoreSource>[
    CREDIT_SCORE_SOURCE_UNSPECIFIED,
    CREDIT_SCORE_SOURCE_LAZERVAULT,
    CREDIT_SCORE_SOURCE_EXTERNAL,
    CREDIT_SCORE_SOURCE_COMBINED,
  ];

  static final $core.List<CreditScoreSource?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static CreditScoreSource? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CreditScoreSource._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
