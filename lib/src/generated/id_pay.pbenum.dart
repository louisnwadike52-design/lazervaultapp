// This is a generated file - do not edit.
//
// Generated from id_pay.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enums
class IDPayType extends $pb.ProtobufEnum {
  static const IDPayType ID_PAY_TYPE_UNSPECIFIED =
      IDPayType._(0, _omitEnumNames ? '' : 'ID_PAY_TYPE_UNSPECIFIED');
  static const IDPayType ID_PAY_ONE_TIME =
      IDPayType._(1, _omitEnumNames ? '' : 'ID_PAY_ONE_TIME');
  static const IDPayType ID_PAY_RECURRING =
      IDPayType._(2, _omitEnumNames ? '' : 'ID_PAY_RECURRING');

  static const $core.List<IDPayType> values = <IDPayType>[
    ID_PAY_TYPE_UNSPECIFIED,
    ID_PAY_ONE_TIME,
    ID_PAY_RECURRING,
  ];

  static final $core.List<IDPayType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static IDPayType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IDPayType._(super.value, super.name);
}

class IDPayAmountMode extends $pb.ProtobufEnum {
  static const IDPayAmountMode ID_PAY_AMOUNT_UNSPECIFIED =
      IDPayAmountMode._(0, _omitEnumNames ? '' : 'ID_PAY_AMOUNT_UNSPECIFIED');
  static const IDPayAmountMode ID_PAY_FIXED =
      IDPayAmountMode._(1, _omitEnumNames ? '' : 'ID_PAY_FIXED');
  static const IDPayAmountMode ID_PAY_FLEXIBLE =
      IDPayAmountMode._(2, _omitEnumNames ? '' : 'ID_PAY_FLEXIBLE');

  static const $core.List<IDPayAmountMode> values = <IDPayAmountMode>[
    ID_PAY_AMOUNT_UNSPECIFIED,
    ID_PAY_FIXED,
    ID_PAY_FLEXIBLE,
  ];

  static final $core.List<IDPayAmountMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static IDPayAmountMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IDPayAmountMode._(super.value, super.name);
}

class IDPayStatus extends $pb.ProtobufEnum {
  static const IDPayStatus ID_PAY_STATUS_UNSPECIFIED =
      IDPayStatus._(0, _omitEnumNames ? '' : 'ID_PAY_STATUS_UNSPECIFIED');
  static const IDPayStatus ID_PAY_ACTIVE =
      IDPayStatus._(1, _omitEnumNames ? '' : 'ID_PAY_ACTIVE');
  static const IDPayStatus ID_PAY_PAID =
      IDPayStatus._(2, _omitEnumNames ? '' : 'ID_PAY_PAID');
  static const IDPayStatus ID_PAY_EXPIRED =
      IDPayStatus._(3, _omitEnumNames ? '' : 'ID_PAY_EXPIRED');
  static const IDPayStatus ID_PAY_CANCELLED =
      IDPayStatus._(4, _omitEnumNames ? '' : 'ID_PAY_CANCELLED');

  static const $core.List<IDPayStatus> values = <IDPayStatus>[
    ID_PAY_STATUS_UNSPECIFIED,
    ID_PAY_ACTIVE,
    ID_PAY_PAID,
    ID_PAY_EXPIRED,
    ID_PAY_CANCELLED,
  ];

  static final $core.List<IDPayStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static IDPayStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IDPayStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
