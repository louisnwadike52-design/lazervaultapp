//
//  Generated code. Do not modify.
//  source: payroll.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EmploymentType extends $pb.ProtobufEnum {
  static const EmploymentType EMPLOYMENT_TYPE_FULL_TIME = EmploymentType._(0, _omitEnumNames ? '' : 'EMPLOYMENT_TYPE_FULL_TIME');
  static const EmploymentType EMPLOYMENT_TYPE_PART_TIME = EmploymentType._(1, _omitEnumNames ? '' : 'EMPLOYMENT_TYPE_PART_TIME');
  static const EmploymentType EMPLOYMENT_TYPE_CONTRACT = EmploymentType._(2, _omitEnumNames ? '' : 'EMPLOYMENT_TYPE_CONTRACT');

  static const $core.List<EmploymentType> values = <EmploymentType> [
    EMPLOYMENT_TYPE_FULL_TIME,
    EMPLOYMENT_TYPE_PART_TIME,
    EMPLOYMENT_TYPE_CONTRACT,
  ];

  static final $core.Map<$core.int, EmploymentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EmploymentType? valueOf($core.int value) => _byValue[value];

  const EmploymentType._($core.int v, $core.String n) : super(v, n);
}

class PayFrequency extends $pb.ProtobufEnum {
  static const PayFrequency PAY_FREQUENCY_MONTHLY = PayFrequency._(0, _omitEnumNames ? '' : 'PAY_FREQUENCY_MONTHLY');
  static const PayFrequency PAY_FREQUENCY_BIWEEKLY = PayFrequency._(1, _omitEnumNames ? '' : 'PAY_FREQUENCY_BIWEEKLY');
  static const PayFrequency PAY_FREQUENCY_WEEKLY = PayFrequency._(2, _omitEnumNames ? '' : 'PAY_FREQUENCY_WEEKLY');

  static const $core.List<PayFrequency> values = <PayFrequency> [
    PAY_FREQUENCY_MONTHLY,
    PAY_FREQUENCY_BIWEEKLY,
    PAY_FREQUENCY_WEEKLY,
  ];

  static final $core.Map<$core.int, PayFrequency> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PayFrequency? valueOf($core.int value) => _byValue[value];

  const PayFrequency._($core.int v, $core.String n) : super(v, n);
}

class EmployeeStatus extends $pb.ProtobufEnum {
  static const EmployeeStatus EMPLOYEE_STATUS_ACTIVE = EmployeeStatus._(0, _omitEnumNames ? '' : 'EMPLOYEE_STATUS_ACTIVE');
  static const EmployeeStatus EMPLOYEE_STATUS_INACTIVE = EmployeeStatus._(1, _omitEnumNames ? '' : 'EMPLOYEE_STATUS_INACTIVE');
  static const EmployeeStatus EMPLOYEE_STATUS_TERMINATED = EmployeeStatus._(2, _omitEnumNames ? '' : 'EMPLOYEE_STATUS_TERMINATED');

  static const $core.List<EmployeeStatus> values = <EmployeeStatus> [
    EMPLOYEE_STATUS_ACTIVE,
    EMPLOYEE_STATUS_INACTIVE,
    EMPLOYEE_STATUS_TERMINATED,
  ];

  static final $core.Map<$core.int, EmployeeStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EmployeeStatus? valueOf($core.int value) => _byValue[value];

  const EmployeeStatus._($core.int v, $core.String n) : super(v, n);
}

class PayRunStatus extends $pb.ProtobufEnum {
  static const PayRunStatus PAY_RUN_STATUS_DRAFT = PayRunStatus._(0, _omitEnumNames ? '' : 'PAY_RUN_STATUS_DRAFT');
  static const PayRunStatus PAY_RUN_STATUS_CALCULATING = PayRunStatus._(1, _omitEnumNames ? '' : 'PAY_RUN_STATUS_CALCULATING');
  static const PayRunStatus PAY_RUN_STATUS_READY = PayRunStatus._(2, _omitEnumNames ? '' : 'PAY_RUN_STATUS_READY');
  static const PayRunStatus PAY_RUN_STATUS_APPROVED = PayRunStatus._(3, _omitEnumNames ? '' : 'PAY_RUN_STATUS_APPROVED');
  static const PayRunStatus PAY_RUN_STATUS_PROCESSING = PayRunStatus._(4, _omitEnumNames ? '' : 'PAY_RUN_STATUS_PROCESSING');
  static const PayRunStatus PAY_RUN_STATUS_COMPLETED = PayRunStatus._(5, _omitEnumNames ? '' : 'PAY_RUN_STATUS_COMPLETED');
  static const PayRunStatus PAY_RUN_STATUS_FAILED = PayRunStatus._(6, _omitEnumNames ? '' : 'PAY_RUN_STATUS_FAILED');

  static const $core.List<PayRunStatus> values = <PayRunStatus> [
    PAY_RUN_STATUS_DRAFT,
    PAY_RUN_STATUS_CALCULATING,
    PAY_RUN_STATUS_READY,
    PAY_RUN_STATUS_APPROVED,
    PAY_RUN_STATUS_PROCESSING,
    PAY_RUN_STATUS_COMPLETED,
    PAY_RUN_STATUS_FAILED,
  ];

  static final $core.Map<$core.int, PayRunStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PayRunStatus? valueOf($core.int value) => _byValue[value];

  const PayRunStatus._($core.int v, $core.String n) : super(v, n);
}

class PaymentStatus extends $pb.ProtobufEnum {
  static const PaymentStatus PAYMENT_STATUS_PENDING = PaymentStatus._(0, _omitEnumNames ? '' : 'PAYMENT_STATUS_PENDING');
  static const PaymentStatus PAYMENT_STATUS_PAID = PaymentStatus._(1, _omitEnumNames ? '' : 'PAYMENT_STATUS_PAID');
  static const PaymentStatus PAYMENT_STATUS_FAILED = PaymentStatus._(2, _omitEnumNames ? '' : 'PAYMENT_STATUS_FAILED');

  static const $core.List<PaymentStatus> values = <PaymentStatus> [
    PAYMENT_STATUS_PENDING,
    PAYMENT_STATUS_PAID,
    PAYMENT_STATUS_FAILED,
  ];

  static final $core.Map<$core.int, PaymentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentStatus? valueOf($core.int value) => _byValue[value];

  const PaymentStatus._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
