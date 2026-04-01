///
//  Generated code. Do not modify.
//  source: family_accounts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class FundDistributionMode extends $pb.ProtobufEnum {
  static const FundDistributionMode FUND_DISTRIBUTION_MODE_UNSPECIFIED = FundDistributionMode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FUND_DISTRIBUTION_MODE_UNSPECIFIED');
  static const FundDistributionMode SHARED_POOL = FundDistributionMode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SHARED_POOL');
  static const FundDistributionMode EQUAL_SPLIT = FundDistributionMode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EQUAL_SPLIT');
  static const FundDistributionMode CUSTOM_ALLOCATION = FundDistributionMode._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOM_ALLOCATION');

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

