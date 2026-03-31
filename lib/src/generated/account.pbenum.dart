//
//  Generated code. Do not modify.
//  source: account.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// VirtualAccountType represents the type of virtual account
class VirtualAccountType extends $pb.ProtobufEnum {
  static const VirtualAccountType ACCOUNT_TYPE_UNSPECIFIED = VirtualAccountType._(0, _omitEnumNames ? '' : 'ACCOUNT_TYPE_UNSPECIFIED');
  static const VirtualAccountType ACCOUNT_TYPE_PERSONAL = VirtualAccountType._(1, _omitEnumNames ? '' : 'ACCOUNT_TYPE_PERSONAL');
  static const VirtualAccountType ACCOUNT_TYPE_SAVINGS = VirtualAccountType._(2, _omitEnumNames ? '' : 'ACCOUNT_TYPE_SAVINGS');
  static const VirtualAccountType ACCOUNT_TYPE_INVESTMENT = VirtualAccountType._(3, _omitEnumNames ? '' : 'ACCOUNT_TYPE_INVESTMENT');
  static const VirtualAccountType ACCOUNT_TYPE_FAMILY = VirtualAccountType._(4, _omitEnumNames ? '' : 'ACCOUNT_TYPE_FAMILY');
  static const VirtualAccountType ACCOUNT_TYPE_BUSINESS = VirtualAccountType._(5, _omitEnumNames ? '' : 'ACCOUNT_TYPE_BUSINESS');
  static const VirtualAccountType ACCOUNT_TYPE_MAIN = VirtualAccountType._(6, _omitEnumNames ? '' : 'ACCOUNT_TYPE_MAIN');
  static const VirtualAccountType ACCOUNT_TYPE_USD = VirtualAccountType._(7, _omitEnumNames ? '' : 'ACCOUNT_TYPE_USD');
  static const VirtualAccountType ACCOUNT_TYPE_GBP = VirtualAccountType._(8, _omitEnumNames ? '' : 'ACCOUNT_TYPE_GBP');
  static const VirtualAccountType ACCOUNT_TYPE_EUR = VirtualAccountType._(9, _omitEnumNames ? '' : 'ACCOUNT_TYPE_EUR');

  static const $core.List<VirtualAccountType> values = <VirtualAccountType> [
    ACCOUNT_TYPE_UNSPECIFIED,
    ACCOUNT_TYPE_PERSONAL,
    ACCOUNT_TYPE_SAVINGS,
    ACCOUNT_TYPE_INVESTMENT,
    ACCOUNT_TYPE_FAMILY,
    ACCOUNT_TYPE_BUSINESS,
    ACCOUNT_TYPE_MAIN,
    ACCOUNT_TYPE_USD,
    ACCOUNT_TYPE_GBP,
    ACCOUNT_TYPE_EUR,
  ];

  static final $core.Map<$core.int, VirtualAccountType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VirtualAccountType? valueOf($core.int value) => _byValue[value];

  const VirtualAccountType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
