// This is a generated file - do not edit.
//
// Generated from account.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// VirtualAccountType represents the type of virtual account
class VirtualAccountType extends $pb.ProtobufEnum {
  static const VirtualAccountType ACCOUNT_TYPE_UNSPECIFIED =
      VirtualAccountType._(0, _omitEnumNames ? '' : 'ACCOUNT_TYPE_UNSPECIFIED');
  static const VirtualAccountType ACCOUNT_TYPE_PERSONAL =
      VirtualAccountType._(1, _omitEnumNames ? '' : 'ACCOUNT_TYPE_PERSONAL');
  static const VirtualAccountType ACCOUNT_TYPE_SAVINGS =
      VirtualAccountType._(2, _omitEnumNames ? '' : 'ACCOUNT_TYPE_SAVINGS');
  static const VirtualAccountType ACCOUNT_TYPE_INVESTMENT =
      VirtualAccountType._(3, _omitEnumNames ? '' : 'ACCOUNT_TYPE_INVESTMENT');
  static const VirtualAccountType ACCOUNT_TYPE_FAMILY =
      VirtualAccountType._(4, _omitEnumNames ? '' : 'ACCOUNT_TYPE_FAMILY');
  static const VirtualAccountType ACCOUNT_TYPE_BUSINESS =
      VirtualAccountType._(5, _omitEnumNames ? '' : 'ACCOUNT_TYPE_BUSINESS');
  static const VirtualAccountType ACCOUNT_TYPE_MAIN =
      VirtualAccountType._(6, _omitEnumNames ? '' : 'ACCOUNT_TYPE_MAIN');
  static const VirtualAccountType ACCOUNT_TYPE_USD =
      VirtualAccountType._(7, _omitEnumNames ? '' : 'ACCOUNT_TYPE_USD');
  static const VirtualAccountType ACCOUNT_TYPE_GBP =
      VirtualAccountType._(8, _omitEnumNames ? '' : 'ACCOUNT_TYPE_GBP');
  static const VirtualAccountType ACCOUNT_TYPE_EUR =
      VirtualAccountType._(9, _omitEnumNames ? '' : 'ACCOUNT_TYPE_EUR');

  static const $core.List<VirtualAccountType> values = <VirtualAccountType>[
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

  static final $core.List<VirtualAccountType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 9);
  static VirtualAccountType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VirtualAccountType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
