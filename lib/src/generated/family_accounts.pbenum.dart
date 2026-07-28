// This is a generated file - do not edit.
//
// Generated from family_accounts.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FundDistributionMode extends $pb.ProtobufEnum {
  static const FundDistributionMode FUND_DISTRIBUTION_MODE_UNSPECIFIED =
      FundDistributionMode._(
          0, _omitEnumNames ? '' : 'FUND_DISTRIBUTION_MODE_UNSPECIFIED');
  static const FundDistributionMode SHARED_POOL =
      FundDistributionMode._(1, _omitEnumNames ? '' : 'SHARED_POOL');
  static const FundDistributionMode EQUAL_SPLIT =
      FundDistributionMode._(2, _omitEnumNames ? '' : 'EQUAL_SPLIT');
  static const FundDistributionMode CUSTOM_ALLOCATION =
      FundDistributionMode._(3, _omitEnumNames ? '' : 'CUSTOM_ALLOCATION');

  static const $core.List<FundDistributionMode> values = <FundDistributionMode>[
    FUND_DISTRIBUTION_MODE_UNSPECIFIED,
    SHARED_POOL,
    EQUAL_SPLIT,
    CUSTOM_ALLOCATION,
  ];

  static final $core.List<FundDistributionMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static FundDistributionMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FundDistributionMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
