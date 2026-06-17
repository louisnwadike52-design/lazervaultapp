///
//  Generated code. Do not modify.
//  source: split_bill.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SplitBillStatus extends $pb.ProtobufEnum {
  static const SplitBillStatus SPLIT_BILL_STATUS_ACTIVE = SplitBillStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_STATUS_ACTIVE');
  static const SplitBillStatus SPLIT_BILL_STATUS_COMPLETED = SplitBillStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_STATUS_COMPLETED');
  static const SplitBillStatus SPLIT_BILL_STATUS_CANCELLED = SplitBillStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_STATUS_CANCELLED');
  static const SplitBillStatus SPLIT_BILL_STATUS_EXPIRED = SplitBillStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_STATUS_EXPIRED');

  static const $core.List<SplitBillStatus> values = <SplitBillStatus> [
    SPLIT_BILL_STATUS_ACTIVE,
    SPLIT_BILL_STATUS_COMPLETED,
    SPLIT_BILL_STATUS_CANCELLED,
    SPLIT_BILL_STATUS_EXPIRED,
  ];

  static final $core.Map<$core.int, SplitBillStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SplitBillStatus? valueOf($core.int value) => _byValue[value];

  const SplitBillStatus._($core.int v, $core.String n) : super(v, n);
}

class SplitBillParticipantStatus extends $pb.ProtobufEnum {
  static const SplitBillParticipantStatus SPLIT_BILL_PARTICIPANT_STATUS_PENDING = SplitBillParticipantStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_PARTICIPANT_STATUS_PENDING');
  static const SplitBillParticipantStatus SPLIT_BILL_PARTICIPANT_STATUS_PAID = SplitBillParticipantStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_PARTICIPANT_STATUS_PAID');
  static const SplitBillParticipantStatus SPLIT_BILL_PARTICIPANT_STATUS_DECLINED = SplitBillParticipantStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_BILL_PARTICIPANT_STATUS_DECLINED');

  static const $core.List<SplitBillParticipantStatus> values = <SplitBillParticipantStatus> [
    SPLIT_BILL_PARTICIPANT_STATUS_PENDING,
    SPLIT_BILL_PARTICIPANT_STATUS_PAID,
    SPLIT_BILL_PARTICIPANT_STATUS_DECLINED,
  ];

  static final $core.Map<$core.int, SplitBillParticipantStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SplitBillParticipantStatus? valueOf($core.int value) => _byValue[value];

  const SplitBillParticipantStatus._($core.int v, $core.String n) : super(v, n);
}

class SplitMethod extends $pb.ProtobufEnum {
  static const SplitMethod SPLIT_METHOD_EQUAL = SplitMethod._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_METHOD_EQUAL');
  static const SplitMethod SPLIT_METHOD_CUSTOM = SplitMethod._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_METHOD_CUSTOM');
  static const SplitMethod SPLIT_METHOD_PERCENTAGE = SplitMethod._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SPLIT_METHOD_PERCENTAGE');

  static const $core.List<SplitMethod> values = <SplitMethod> [
    SPLIT_METHOD_EQUAL,
    SPLIT_METHOD_CUSTOM,
    SPLIT_METHOD_PERCENTAGE,
  ];

  static final $core.Map<$core.int, SplitMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SplitMethod? valueOf($core.int value) => _byValue[value];

  const SplitMethod._($core.int v, $core.String n) : super(v, n);
}

