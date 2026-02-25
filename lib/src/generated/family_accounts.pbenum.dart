//
//  Generated code. Do not modify.
//  source: family_accounts.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FundDistributionMode extends $pb.ProtobufEnum {
  static const FundDistributionMode FUND_DISTRIBUTION_MODE_UNSPECIFIED = FundDistributionMode._(0, _omitEnumNames ? '' : 'FUND_DISTRIBUTION_MODE_UNSPECIFIED');
  static const FundDistributionMode SHARED_POOL = FundDistributionMode._(1, _omitEnumNames ? '' : 'SHARED_POOL');
  static const FundDistributionMode EQUAL_SPLIT = FundDistributionMode._(2, _omitEnumNames ? '' : 'EQUAL_SPLIT');
  static const FundDistributionMode CUSTOM_ALLOCATION = FundDistributionMode._(3, _omitEnumNames ? '' : 'CUSTOM_ALLOCATION');

  static const $core.List<FundDistributionMode> values = <FundDistributionMode> [
    FUND_DISTRIBUTION_MODE_UNSPECIFIED,
    SHARED_POOL,
    EQUAL_SPLIT,
    CUSTOM_ALLOCATION,
  ];

  static final $core.Map<$core.int, FundDistributionMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FundDistributionMode? valueOf($core.int value) => _byValue[value];

  const FundDistributionMode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
