//
//  Generated code. Do not modify.
//  source: id_pay.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enums
class IDPayType extends $pb.ProtobufEnum {
  static const IDPayType ID_PAY_TYPE_UNSPECIFIED = IDPayType._(0, _omitEnumNames ? '' : 'ID_PAY_TYPE_UNSPECIFIED');
  static const IDPayType ID_PAY_ONE_TIME = IDPayType._(1, _omitEnumNames ? '' : 'ID_PAY_ONE_TIME');
  static const IDPayType ID_PAY_RECURRING = IDPayType._(2, _omitEnumNames ? '' : 'ID_PAY_RECURRING');

  static const $core.List<IDPayType> values = <IDPayType> [
    ID_PAY_TYPE_UNSPECIFIED,
    ID_PAY_ONE_TIME,
    ID_PAY_RECURRING,
  ];

  static final $core.Map<$core.int, IDPayType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IDPayType? valueOf($core.int value) => _byValue[value];

  const IDPayType._($core.int v, $core.String n) : super(v, n);
}

class IDPayAmountMode extends $pb.ProtobufEnum {
  static const IDPayAmountMode ID_PAY_AMOUNT_UNSPECIFIED = IDPayAmountMode._(0, _omitEnumNames ? '' : 'ID_PAY_AMOUNT_UNSPECIFIED');
  static const IDPayAmountMode ID_PAY_FIXED = IDPayAmountMode._(1, _omitEnumNames ? '' : 'ID_PAY_FIXED');
  static const IDPayAmountMode ID_PAY_FLEXIBLE = IDPayAmountMode._(2, _omitEnumNames ? '' : 'ID_PAY_FLEXIBLE');

  static const $core.List<IDPayAmountMode> values = <IDPayAmountMode> [
    ID_PAY_AMOUNT_UNSPECIFIED,
    ID_PAY_FIXED,
    ID_PAY_FLEXIBLE,
  ];

  static final $core.Map<$core.int, IDPayAmountMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IDPayAmountMode? valueOf($core.int value) => _byValue[value];

  const IDPayAmountMode._($core.int v, $core.String n) : super(v, n);
}

class IDPayStatus extends $pb.ProtobufEnum {
  static const IDPayStatus ID_PAY_STATUS_UNSPECIFIED = IDPayStatus._(0, _omitEnumNames ? '' : 'ID_PAY_STATUS_UNSPECIFIED');
  static const IDPayStatus ID_PAY_ACTIVE = IDPayStatus._(1, _omitEnumNames ? '' : 'ID_PAY_ACTIVE');
  static const IDPayStatus ID_PAY_PAID = IDPayStatus._(2, _omitEnumNames ? '' : 'ID_PAY_PAID');
  static const IDPayStatus ID_PAY_EXPIRED = IDPayStatus._(3, _omitEnumNames ? '' : 'ID_PAY_EXPIRED');
  static const IDPayStatus ID_PAY_CANCELLED = IDPayStatus._(4, _omitEnumNames ? '' : 'ID_PAY_CANCELLED');

  static const $core.List<IDPayStatus> values = <IDPayStatus> [
    ID_PAY_STATUS_UNSPECIFIED,
    ID_PAY_ACTIVE,
    ID_PAY_PAID,
    ID_PAY_EXPIRED,
    ID_PAY_CANCELLED,
  ];

  static final $core.Map<$core.int, IDPayStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static IDPayStatus? valueOf($core.int value) => _byValue[value];

  const IDPayStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
