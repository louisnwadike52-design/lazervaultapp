// This is a generated file - do not edit.
//
// Generated from split_bill.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enums
class SplitBillStatus extends $pb.ProtobufEnum {
  static const SplitBillStatus SPLIT_BILL_STATUS_ACTIVE =
      SplitBillStatus._(0, _omitEnumNames ? '' : 'SPLIT_BILL_STATUS_ACTIVE');
  static const SplitBillStatus SPLIT_BILL_STATUS_COMPLETED =
      SplitBillStatus._(1, _omitEnumNames ? '' : 'SPLIT_BILL_STATUS_COMPLETED');
  static const SplitBillStatus SPLIT_BILL_STATUS_CANCELLED =
      SplitBillStatus._(2, _omitEnumNames ? '' : 'SPLIT_BILL_STATUS_CANCELLED');
  static const SplitBillStatus SPLIT_BILL_STATUS_EXPIRED =
      SplitBillStatus._(3, _omitEnumNames ? '' : 'SPLIT_BILL_STATUS_EXPIRED');

  static const $core.List<SplitBillStatus> values = <SplitBillStatus>[
    SPLIT_BILL_STATUS_ACTIVE,
    SPLIT_BILL_STATUS_COMPLETED,
    SPLIT_BILL_STATUS_CANCELLED,
    SPLIT_BILL_STATUS_EXPIRED,
  ];

  static final $core.List<SplitBillStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SplitBillStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SplitBillStatus._(super.value, super.name);
}

class SplitBillParticipantStatus extends $pb.ProtobufEnum {
  static const SplitBillParticipantStatus
      SPLIT_BILL_PARTICIPANT_STATUS_PENDING = SplitBillParticipantStatus._(
          0, _omitEnumNames ? '' : 'SPLIT_BILL_PARTICIPANT_STATUS_PENDING');
  static const SplitBillParticipantStatus SPLIT_BILL_PARTICIPANT_STATUS_PAID =
      SplitBillParticipantStatus._(
          1, _omitEnumNames ? '' : 'SPLIT_BILL_PARTICIPANT_STATUS_PAID');
  static const SplitBillParticipantStatus
      SPLIT_BILL_PARTICIPANT_STATUS_DECLINED = SplitBillParticipantStatus._(
          2, _omitEnumNames ? '' : 'SPLIT_BILL_PARTICIPANT_STATUS_DECLINED');

  static const $core.List<SplitBillParticipantStatus> values =
      <SplitBillParticipantStatus>[
    SPLIT_BILL_PARTICIPANT_STATUS_PENDING,
    SPLIT_BILL_PARTICIPANT_STATUS_PAID,
    SPLIT_BILL_PARTICIPANT_STATUS_DECLINED,
  ];

  static final $core.List<SplitBillParticipantStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SplitBillParticipantStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SplitBillParticipantStatus._(super.value, super.name);
}

class SplitMethod extends $pb.ProtobufEnum {
  static const SplitMethod SPLIT_METHOD_EQUAL =
      SplitMethod._(0, _omitEnumNames ? '' : 'SPLIT_METHOD_EQUAL');
  static const SplitMethod SPLIT_METHOD_CUSTOM =
      SplitMethod._(1, _omitEnumNames ? '' : 'SPLIT_METHOD_CUSTOM');
  static const SplitMethod SPLIT_METHOD_PERCENTAGE =
      SplitMethod._(2, _omitEnumNames ? '' : 'SPLIT_METHOD_PERCENTAGE');

  static const $core.List<SplitMethod> values = <SplitMethod>[
    SPLIT_METHOD_EQUAL,
    SPLIT_METHOD_CUSTOM,
    SPLIT_METHOD_PERCENTAGE,
  ];

  static final $core.List<SplitMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SplitMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SplitMethod._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
