// This is a generated file - do not edit.
//
// Generated from payroll.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'payroll.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'payroll.pbenum.dart';

class Employee extends $pb.GeneratedMessage {
  factory Employee({
    $core.String? id,
    $core.String? userId,
    $core.String? businessId,
    $core.String? fullName,
    $core.String? email,
    $core.String? phone,
    $core.String? nin,
    $core.String? bankAccountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    EmploymentType? employmentType,
    $fixnum.Int64? payRate,
    PayFrequency? payFrequency,
    $core.String? department,
    $core.String? jobTitle,
    $core.String? startDate,
    EmployeeStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (businessId != null) result.businessId = businessId;
    if (fullName != null) result.fullName = fullName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (nin != null) result.nin = nin;
    if (bankAccountNumber != null) result.bankAccountNumber = bankAccountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (employmentType != null) result.employmentType = employmentType;
    if (payRate != null) result.payRate = payRate;
    if (payFrequency != null) result.payFrequency = payFrequency;
    if (department != null) result.department = department;
    if (jobTitle != null) result.jobTitle = jobTitle;
    if (startDate != null) result.startDate = startDate;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Employee._();

  factory Employee.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Employee.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Employee',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'businessId')
    ..aOS(4, _omitFieldNames ? '' : 'fullName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'phone')
    ..aOS(7, _omitFieldNames ? '' : 'nin')
    ..aOS(8, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(9, _omitFieldNames ? '' : 'bankCode')
    ..aOS(10, _omitFieldNames ? '' : 'bankName')
    ..e<EmploymentType>(
        11, _omitFieldNames ? '' : 'employmentType', $pb.PbFieldType.OE,
        defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME,
        valueOf: EmploymentType.valueOf,
        enumValues: EmploymentType.values)
    ..aInt64(12, _omitFieldNames ? '' : 'payRate')
    ..e<PayFrequency>(
        13, _omitFieldNames ? '' : 'payFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY,
        valueOf: PayFrequency.valueOf,
        enumValues: PayFrequency.values)
    ..aOS(14, _omitFieldNames ? '' : 'department')
    ..aOS(15, _omitFieldNames ? '' : 'jobTitle')
    ..aOS(16, _omitFieldNames ? '' : 'startDate')
    ..e<EmployeeStatus>(17, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE,
        valueOf: EmployeeStatus.valueOf,
        enumValues: EmployeeStatus.values)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Employee clone() => Employee()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Employee copyWith(void Function(Employee) updates) =>
      super.copyWith((message) => updates(message as Employee)) as Employee;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Employee create() => Employee._();
  @$core.override
  Employee createEmptyInstance() => create();
  static $pb.PbList<Employee> createRepeated() => $pb.PbList<Employee>();
  @$core.pragma('dart2js:noInline')
  static Employee getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Employee>(create);
  static Employee? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessId => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBusinessId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fullName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get nin => $_getSZ(6);
  @$pb.TagNumber(7)
  set nin($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNin() => $_has(6);
  @$pb.TagNumber(7)
  void clearNin() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankAccountNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankAccountNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBankAccountNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankAccountNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankCode($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasBankCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankCode() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get bankName => $_getSZ(9);
  @$pb.TagNumber(10)
  set bankName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBankName() => $_has(9);
  @$pb.TagNumber(10)
  void clearBankName() => $_clearField(10);

  @$pb.TagNumber(11)
  EmploymentType get employmentType => $_getN(10);
  @$pb.TagNumber(11)
  set employmentType(EmploymentType value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasEmploymentType() => $_has(10);
  @$pb.TagNumber(11)
  void clearEmploymentType() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get payRate => $_getI64(11);
  @$pb.TagNumber(12)
  set payRate($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPayRate() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayRate() => $_clearField(12);

  @$pb.TagNumber(13)
  PayFrequency get payFrequency => $_getN(12);
  @$pb.TagNumber(13)
  set payFrequency(PayFrequency value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasPayFrequency() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayFrequency() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get department => $_getSZ(13);
  @$pb.TagNumber(14)
  set department($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDepartment() => $_has(13);
  @$pb.TagNumber(14)
  void clearDepartment() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get jobTitle => $_getSZ(14);
  @$pb.TagNumber(15)
  set jobTitle($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasJobTitle() => $_has(14);
  @$pb.TagNumber(15)
  void clearJobTitle() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get startDate => $_getSZ(15);
  @$pb.TagNumber(16)
  set startDate($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasStartDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearStartDate() => $_clearField(16);

  @$pb.TagNumber(17)
  EmployeeStatus get status => $_getN(16);
  @$pb.TagNumber(17)
  set status(EmployeeStatus value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearStatus() => $_clearField(17);

  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);
}

class PayRun extends $pb.GeneratedMessage {
  factory PayRun({
    $core.String? id,
    $core.String? businessId,
    $core.String? payPeriodStart,
    $core.String? payPeriodEnd,
    PayRunStatus? status,
    $fixnum.Int64? totalGross,
    $fixnum.Int64? totalDeductions,
    $fixnum.Int64? totalNet,
    $fixnum.Int64? totalEmployerContributions,
    $core.int? employeeCount,
    $core.String? createdBy,
    $core.String? approvedBy,
    $1.Timestamp? createdAt,
    $1.Timestamp? processedAt,
    $core.String? name,
    $core.bool? isRecurring,
    RecurrenceFrequency? recurrenceFrequency,
    $core.String? nextScheduledDate,
    $core.bool? autoApprove,
    $core.Iterable<$core.String>? employeeIds,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (payPeriodStart != null) result.payPeriodStart = payPeriodStart;
    if (payPeriodEnd != null) result.payPeriodEnd = payPeriodEnd;
    if (status != null) result.status = status;
    if (totalGross != null) result.totalGross = totalGross;
    if (totalDeductions != null) result.totalDeductions = totalDeductions;
    if (totalNet != null) result.totalNet = totalNet;
    if (totalEmployerContributions != null)
      result.totalEmployerContributions = totalEmployerContributions;
    if (employeeCount != null) result.employeeCount = employeeCount;
    if (createdBy != null) result.createdBy = createdBy;
    if (approvedBy != null) result.approvedBy = approvedBy;
    if (createdAt != null) result.createdAt = createdAt;
    if (processedAt != null) result.processedAt = processedAt;
    if (name != null) result.name = name;
    if (isRecurring != null) result.isRecurring = isRecurring;
    if (recurrenceFrequency != null)
      result.recurrenceFrequency = recurrenceFrequency;
    if (nextScheduledDate != null) result.nextScheduledDate = nextScheduledDate;
    if (autoApprove != null) result.autoApprove = autoApprove;
    if (employeeIds != null) result.employeeIds.addAll(employeeIds);
    return result;
  }

  PayRun._();

  factory PayRun.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayRun.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayRun',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'payPeriodStart')
    ..aOS(4, _omitFieldNames ? '' : 'payPeriodEnd')
    ..e<PayRunStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PayRunStatus.PAY_RUN_STATUS_DRAFT,
        valueOf: PayRunStatus.valueOf,
        enumValues: PayRunStatus.values)
    ..aInt64(6, _omitFieldNames ? '' : 'totalGross')
    ..aInt64(7, _omitFieldNames ? '' : 'totalDeductions')
    ..aInt64(8, _omitFieldNames ? '' : 'totalNet')
    ..aInt64(9, _omitFieldNames ? '' : 'totalEmployerContributions')
    ..a<$core.int>(
        10, _omitFieldNames ? '' : 'employeeCount', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'createdBy')
    ..aOS(12, _omitFieldNames ? '' : 'approvedBy')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'processedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(15, _omitFieldNames ? '' : 'name')
    ..aOB(16, _omitFieldNames ? '' : 'isRecurring')
    ..e<RecurrenceFrequency>(
        17, _omitFieldNames ? '' : 'recurrenceFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: RecurrenceFrequency.RECURRENCE_FREQUENCY_NONE,
        valueOf: RecurrenceFrequency.valueOf,
        enumValues: RecurrenceFrequency.values)
    ..aOS(18, _omitFieldNames ? '' : 'nextScheduledDate')
    ..aOB(19, _omitFieldNames ? '' : 'autoApprove')
    ..pPS(20, _omitFieldNames ? '' : 'employeeIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayRun clone() => PayRun()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayRun copyWith(void Function(PayRun) updates) =>
      super.copyWith((message) => updates(message as PayRun)) as PayRun;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayRun create() => PayRun._();
  @$core.override
  PayRun createEmptyInstance() => create();
  static $pb.PbList<PayRun> createRepeated() => $pb.PbList<PayRun>();
  @$core.pragma('dart2js:noInline')
  static PayRun getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayRun>(create);
  static PayRun? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payPeriodStart => $_getSZ(2);
  @$pb.TagNumber(3)
  set payPeriodStart($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayPeriodStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayPeriodStart() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get payPeriodEnd => $_getSZ(3);
  @$pb.TagNumber(4)
  set payPeriodEnd($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayPeriodEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayPeriodEnd() => $_clearField(4);

  @$pb.TagNumber(5)
  PayRunStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(PayRunStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalGross => $_getI64(5);
  @$pb.TagNumber(6)
  set totalGross($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalGross() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalGross() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalDeductions => $_getI64(6);
  @$pb.TagNumber(7)
  set totalDeductions($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalDeductions() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalDeductions() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalNet => $_getI64(7);
  @$pb.TagNumber(8)
  set totalNet($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalNet() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalNet() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get totalEmployerContributions => $_getI64(8);
  @$pb.TagNumber(9)
  set totalEmployerContributions($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalEmployerContributions() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalEmployerContributions() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get employeeCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set employeeCount($core.int value) => $_setSignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasEmployeeCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearEmployeeCount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdBy => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdBy($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedBy() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedBy() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get approvedBy => $_getSZ(11);
  @$pb.TagNumber(12)
  set approvedBy($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasApprovedBy() => $_has(11);
  @$pb.TagNumber(12)
  void clearApprovedBy() => $_clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get processedAt => $_getN(13);
  @$pb.TagNumber(14)
  set processedAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasProcessedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearProcessedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureProcessedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.String get name => $_getSZ(14);
  @$pb.TagNumber(15)
  set name($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasName() => $_has(14);
  @$pb.TagNumber(15)
  void clearName() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isRecurring => $_getBF(15);
  @$pb.TagNumber(16)
  set isRecurring($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIsRecurring() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsRecurring() => $_clearField(16);

  @$pb.TagNumber(17)
  RecurrenceFrequency get recurrenceFrequency => $_getN(16);
  @$pb.TagNumber(17)
  set recurrenceFrequency(RecurrenceFrequency value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasRecurrenceFrequency() => $_has(16);
  @$pb.TagNumber(17)
  void clearRecurrenceFrequency() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get nextScheduledDate => $_getSZ(17);
  @$pb.TagNumber(18)
  set nextScheduledDate($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasNextScheduledDate() => $_has(17);
  @$pb.TagNumber(18)
  void clearNextScheduledDate() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.bool get autoApprove => $_getBF(18);
  @$pb.TagNumber(19)
  set autoApprove($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(19)
  $core.bool hasAutoApprove() => $_has(18);
  @$pb.TagNumber(19)
  void clearAutoApprove() => $_clearField(19);

  @$pb.TagNumber(20)
  $pb.PbList<$core.String> get employeeIds => $_getList(19);
}

class InventoryItem extends $pb.GeneratedMessage {
  factory InventoryItem({
    $core.String? id,
    $core.String? businessId,
    $core.String? name,
    $core.String? description,
    $core.String? category,
    $core.int? quantity,
    $fixnum.Int64? unitPrice,
    $core.String? unit,
    $core.String? sku,
    $core.String? location,
    $core.int? minimumStockLevel,
    InventoryItemStatus? status,
    $core.String? notes,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (quantity != null) result.quantity = quantity;
    if (unitPrice != null) result.unitPrice = unitPrice;
    if (unit != null) result.unit = unit;
    if (sku != null) result.sku = sku;
    if (location != null) result.location = location;
    if (minimumStockLevel != null) result.minimumStockLevel = minimumStockLevel;
    if (status != null) result.status = status;
    if (notes != null) result.notes = notes;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  InventoryItem._();

  factory InventoryItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aInt64(7, _omitFieldNames ? '' : 'unitPrice')
    ..aOS(8, _omitFieldNames ? '' : 'unit')
    ..aOS(9, _omitFieldNames ? '' : 'sku')
    ..aOS(10, _omitFieldNames ? '' : 'location')
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'minimumStockLevel', $pb.PbFieldType.O3)
    ..e<InventoryItemStatus>(
        12, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE,
        valueOf: InventoryItemStatus.valueOf,
        enumValues: InventoryItemStatus.values)
    ..aOS(13, _omitFieldNames ? '' : 'notes')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryItem clone() => InventoryItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryItem copyWith(void Function(InventoryItem) updates) =>
      super.copyWith((message) => updates(message as InventoryItem))
          as InventoryItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryItem create() => InventoryItem._();
  @$core.override
  InventoryItem createEmptyInstance() => create();
  static $pb.PbList<InventoryItem> createRepeated() =>
      $pb.PbList<InventoryItem>();
  @$core.pragma('dart2js:noInline')
  static InventoryItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryItem>(create);
  static InventoryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get quantity => $_getIZ(5);
  @$pb.TagNumber(6)
  set quantity($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get unitPrice => $_getI64(6);
  @$pb.TagNumber(7)
  set unitPrice($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUnitPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnitPrice() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get unit => $_getSZ(7);
  @$pb.TagNumber(8)
  set unit($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUnit() => $_has(7);
  @$pb.TagNumber(8)
  void clearUnit() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get sku => $_getSZ(8);
  @$pb.TagNumber(9)
  set sku($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSku() => $_has(8);
  @$pb.TagNumber(9)
  void clearSku() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get location => $_getSZ(9);
  @$pb.TagNumber(10)
  set location($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLocation() => $_has(9);
  @$pb.TagNumber(10)
  void clearLocation() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get minimumStockLevel => $_getIZ(10);
  @$pb.TagNumber(11)
  set minimumStockLevel($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMinimumStockLevel() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinimumStockLevel() => $_clearField(11);

  @$pb.TagNumber(12)
  InventoryItemStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(InventoryItemStatus value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get notes => $_getSZ(12);
  @$pb.TagNumber(13)
  set notes($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasNotes() => $_has(12);
  @$pb.TagNumber(13)
  void clearNotes() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($1.Timestamp value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => $_clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureUpdatedAt() => $_ensure(14);
}

class InventoryAdjustment extends $pb.GeneratedMessage {
  factory InventoryAdjustment({
    $core.String? id,
    $core.String? itemId,
    $core.String? businessId,
    AdjustmentType? adjustmentType,
    $core.int? quantityChange,
    $core.int? quantityBefore,
    $core.int? quantityAfter,
    $core.String? reason,
    $core.String? adjustedBy,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (itemId != null) result.itemId = itemId;
    if (businessId != null) result.businessId = businessId;
    if (adjustmentType != null) result.adjustmentType = adjustmentType;
    if (quantityChange != null) result.quantityChange = quantityChange;
    if (quantityBefore != null) result.quantityBefore = quantityBefore;
    if (quantityAfter != null) result.quantityAfter = quantityAfter;
    if (reason != null) result.reason = reason;
    if (adjustedBy != null) result.adjustedBy = adjustedBy;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  InventoryAdjustment._();

  factory InventoryAdjustment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryAdjustment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryAdjustment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'itemId')
    ..aOS(3, _omitFieldNames ? '' : 'businessId')
    ..e<AdjustmentType>(
        4, _omitFieldNames ? '' : 'adjustmentType', $pb.PbFieldType.OE,
        defaultOrMaker: AdjustmentType.ADJUSTMENT_TYPE_ADD,
        valueOf: AdjustmentType.valueOf,
        enumValues: AdjustmentType.values)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'quantityChange', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'quantityBefore', $pb.PbFieldType.O3)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'quantityAfter', $pb.PbFieldType.O3)
    ..aOS(8, _omitFieldNames ? '' : 'reason')
    ..aOS(9, _omitFieldNames ? '' : 'adjustedBy')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryAdjustment clone() => InventoryAdjustment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryAdjustment copyWith(void Function(InventoryAdjustment) updates) =>
      super.copyWith((message) => updates(message as InventoryAdjustment))
          as InventoryAdjustment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryAdjustment create() => InventoryAdjustment._();
  @$core.override
  InventoryAdjustment createEmptyInstance() => create();
  static $pb.PbList<InventoryAdjustment> createRepeated() =>
      $pb.PbList<InventoryAdjustment>();
  @$core.pragma('dart2js:noInline')
  static InventoryAdjustment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryAdjustment>(create);
  static InventoryAdjustment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessId => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBusinessId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessId() => $_clearField(3);

  @$pb.TagNumber(4)
  AdjustmentType get adjustmentType => $_getN(3);
  @$pb.TagNumber(4)
  set adjustmentType(AdjustmentType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAdjustmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdjustmentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get quantityChange => $_getIZ(4);
  @$pb.TagNumber(5)
  set quantityChange($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantityChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantityChange() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get quantityBefore => $_getIZ(5);
  @$pb.TagNumber(6)
  set quantityBefore($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQuantityBefore() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantityBefore() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get quantityAfter => $_getIZ(6);
  @$pb.TagNumber(7)
  set quantityAfter($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasQuantityAfter() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantityAfter() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get adjustedBy => $_getSZ(8);
  @$pb.TagNumber(9)
  set adjustedBy($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAdjustedBy() => $_has(8);
  @$pb.TagNumber(9)
  void clearAdjustedBy() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);
}

class CategorySummary extends $pb.GeneratedMessage {
  factory CategorySummary({
    $core.String? category,
    $core.int? itemCount,
    $fixnum.Int64? totalValue,
    $core.int? lowStockCount,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (itemCount != null) result.itemCount = itemCount;
    if (totalValue != null) result.totalValue = totalValue;
    if (lowStockCount != null) result.lowStockCount = lowStockCount;
    return result;
  }

  CategorySummary._();

  factory CategorySummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CategorySummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategorySummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'itemCount', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'totalValue')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'lowStockCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategorySummary clone() => CategorySummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategorySummary copyWith(void Function(CategorySummary) updates) =>
      super.copyWith((message) => updates(message as CategorySummary))
          as CategorySummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategorySummary create() => CategorySummary._();
  @$core.override
  CategorySummary createEmptyInstance() => create();
  static $pb.PbList<CategorySummary> createRepeated() =>
      $pb.PbList<CategorySummary>();
  @$core.pragma('dart2js:noInline')
  static CategorySummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CategorySummary>(create);
  static CategorySummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get itemCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set itemCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalValue => $_getI64(2);
  @$pb.TagNumber(3)
  set totalValue($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get lowStockCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set lowStockCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLowStockCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearLowStockCount() => $_clearField(4);
}

class PaySlip extends $pb.GeneratedMessage {
  factory PaySlip({
    $core.String? id,
    $core.String? payRunId,
    $core.String? employeeId,
    $core.String? employeeName,
    $fixnum.Int64? grossPay,
    $fixnum.Int64? incomeTax,
    $fixnum.Int64? nationalInsurance,
    $fixnum.Int64? studentLoanRepayment,
    $fixnum.Int64? pensionContribution,
    $fixnum.Int64? otherDeductions,
    $fixnum.Int64? totalDeductions,
    $fixnum.Int64? netPay,
    $fixnum.Int64? employerNic,
    $fixnum.Int64? employerPension,
    $core.double? hoursWorked,
    $core.double? overtimeHours,
    $fixnum.Int64? overtimePay,
    $fixnum.Int64? bonuses,
    $fixnum.Int64? commissions,
    PaymentStatus? paymentStatus,
    $core.String? paymentReference,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (payRunId != null) result.payRunId = payRunId;
    if (employeeId != null) result.employeeId = employeeId;
    if (employeeName != null) result.employeeName = employeeName;
    if (grossPay != null) result.grossPay = grossPay;
    if (incomeTax != null) result.incomeTax = incomeTax;
    if (nationalInsurance != null) result.nationalInsurance = nationalInsurance;
    if (studentLoanRepayment != null)
      result.studentLoanRepayment = studentLoanRepayment;
    if (pensionContribution != null)
      result.pensionContribution = pensionContribution;
    if (otherDeductions != null) result.otherDeductions = otherDeductions;
    if (totalDeductions != null) result.totalDeductions = totalDeductions;
    if (netPay != null) result.netPay = netPay;
    if (employerNic != null) result.employerNic = employerNic;
    if (employerPension != null) result.employerPension = employerPension;
    if (hoursWorked != null) result.hoursWorked = hoursWorked;
    if (overtimeHours != null) result.overtimeHours = overtimeHours;
    if (overtimePay != null) result.overtimePay = overtimePay;
    if (bonuses != null) result.bonuses = bonuses;
    if (commissions != null) result.commissions = commissions;
    if (paymentStatus != null) result.paymentStatus = paymentStatus;
    if (paymentReference != null) result.paymentReference = paymentReference;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  PaySlip._();

  factory PaySlip.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaySlip.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaySlip',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'payRunId')
    ..aOS(3, _omitFieldNames ? '' : 'employeeId')
    ..aOS(4, _omitFieldNames ? '' : 'employeeName')
    ..aInt64(5, _omitFieldNames ? '' : 'grossPay')
    ..aInt64(6, _omitFieldNames ? '' : 'incomeTax')
    ..aInt64(7, _omitFieldNames ? '' : 'nationalInsurance')
    ..aInt64(8, _omitFieldNames ? '' : 'studentLoanRepayment')
    ..aInt64(9, _omitFieldNames ? '' : 'pensionContribution')
    ..aInt64(10, _omitFieldNames ? '' : 'otherDeductions')
    ..aInt64(11, _omitFieldNames ? '' : 'totalDeductions')
    ..aInt64(12, _omitFieldNames ? '' : 'netPay')
    ..aInt64(13, _omitFieldNames ? '' : 'employerNic')
    ..aInt64(14, _omitFieldNames ? '' : 'employerPension')
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'hoursWorked', $pb.PbFieldType.OD)
    ..a<$core.double>(
        16, _omitFieldNames ? '' : 'overtimeHours', $pb.PbFieldType.OD)
    ..aInt64(17, _omitFieldNames ? '' : 'overtimePay')
    ..aInt64(18, _omitFieldNames ? '' : 'bonuses')
    ..aInt64(19, _omitFieldNames ? '' : 'commissions')
    ..e<PaymentStatus>(
        20, _omitFieldNames ? '' : 'paymentStatus', $pb.PbFieldType.OE,
        defaultOrMaker: PaymentStatus.PAYMENT_STATUS_PENDING,
        valueOf: PaymentStatus.valueOf,
        enumValues: PaymentStatus.values)
    ..aOS(21, _omitFieldNames ? '' : 'paymentReference')
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaySlip clone() => PaySlip()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaySlip copyWith(void Function(PaySlip) updates) =>
      super.copyWith((message) => updates(message as PaySlip)) as PaySlip;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaySlip create() => PaySlip._();
  @$core.override
  PaySlip createEmptyInstance() => create();
  static $pb.PbList<PaySlip> createRepeated() => $pb.PbList<PaySlip>();
  @$core.pragma('dart2js:noInline')
  static PaySlip getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaySlip>(create);
  static PaySlip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payRunId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payRunId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayRunId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get employeeId => $_getSZ(2);
  @$pb.TagNumber(3)
  set employeeId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmployeeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployeeId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get employeeName => $_getSZ(3);
  @$pb.TagNumber(4)
  set employeeName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmployeeName() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmployeeName() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get grossPay => $_getI64(4);
  @$pb.TagNumber(5)
  set grossPay($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGrossPay() => $_has(4);
  @$pb.TagNumber(5)
  void clearGrossPay() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get incomeTax => $_getI64(5);
  @$pb.TagNumber(6)
  set incomeTax($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIncomeTax() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncomeTax() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get nationalInsurance => $_getI64(6);
  @$pb.TagNumber(7)
  set nationalInsurance($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNationalInsurance() => $_has(6);
  @$pb.TagNumber(7)
  void clearNationalInsurance() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get studentLoanRepayment => $_getI64(7);
  @$pb.TagNumber(8)
  set studentLoanRepayment($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStudentLoanRepayment() => $_has(7);
  @$pb.TagNumber(8)
  void clearStudentLoanRepayment() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get pensionContribution => $_getI64(8);
  @$pb.TagNumber(9)
  set pensionContribution($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPensionContribution() => $_has(8);
  @$pb.TagNumber(9)
  void clearPensionContribution() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get otherDeductions => $_getI64(9);
  @$pb.TagNumber(10)
  set otherDeductions($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasOtherDeductions() => $_has(9);
  @$pb.TagNumber(10)
  void clearOtherDeductions() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get totalDeductions => $_getI64(10);
  @$pb.TagNumber(11)
  set totalDeductions($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTotalDeductions() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalDeductions() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get netPay => $_getI64(11);
  @$pb.TagNumber(12)
  set netPay($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasNetPay() => $_has(11);
  @$pb.TagNumber(12)
  void clearNetPay() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get employerNic => $_getI64(12);
  @$pb.TagNumber(13)
  set employerNic($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEmployerNic() => $_has(12);
  @$pb.TagNumber(13)
  void clearEmployerNic() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get employerPension => $_getI64(13);
  @$pb.TagNumber(14)
  set employerPension($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasEmployerPension() => $_has(13);
  @$pb.TagNumber(14)
  void clearEmployerPension() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get hoursWorked => $_getN(14);
  @$pb.TagNumber(15)
  set hoursWorked($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasHoursWorked() => $_has(14);
  @$pb.TagNumber(15)
  void clearHoursWorked() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.double get overtimeHours => $_getN(15);
  @$pb.TagNumber(16)
  set overtimeHours($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasOvertimeHours() => $_has(15);
  @$pb.TagNumber(16)
  void clearOvertimeHours() => $_clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get overtimePay => $_getI64(16);
  @$pb.TagNumber(17)
  set overtimePay($fixnum.Int64 value) => $_setInt64(16, value);
  @$pb.TagNumber(17)
  $core.bool hasOvertimePay() => $_has(16);
  @$pb.TagNumber(17)
  void clearOvertimePay() => $_clearField(17);

  @$pb.TagNumber(18)
  $fixnum.Int64 get bonuses => $_getI64(17);
  @$pb.TagNumber(18)
  set bonuses($fixnum.Int64 value) => $_setInt64(17, value);
  @$pb.TagNumber(18)
  $core.bool hasBonuses() => $_has(17);
  @$pb.TagNumber(18)
  void clearBonuses() => $_clearField(18);

  @$pb.TagNumber(19)
  $fixnum.Int64 get commissions => $_getI64(18);
  @$pb.TagNumber(19)
  set commissions($fixnum.Int64 value) => $_setInt64(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCommissions() => $_has(18);
  @$pb.TagNumber(19)
  void clearCommissions() => $_clearField(19);

  @$pb.TagNumber(20)
  PaymentStatus get paymentStatus => $_getN(19);
  @$pb.TagNumber(20)
  set paymentStatus(PaymentStatus value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasPaymentStatus() => $_has(19);
  @$pb.TagNumber(20)
  void clearPaymentStatus() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get paymentReference => $_getSZ(20);
  @$pb.TagNumber(21)
  set paymentReference($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasPaymentReference() => $_has(20);
  @$pb.TagNumber(21)
  void clearPaymentReference() => $_clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get createdAt => $_getN(21);
  @$pb.TagNumber(22)
  set createdAt($1.Timestamp value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasCreatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearCreatedAt() => $_clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureCreatedAt() => $_ensure(21);
}

class DeductionSummary extends $pb.GeneratedMessage {
  factory DeductionSummary({
    $core.String? type,
    $fixnum.Int64? amount,
    $core.String? description,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    return result;
  }

  DeductionSummary._();

  factory DeductionSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeductionSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeductionSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeductionSummary clone() => DeductionSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeductionSummary copyWith(void Function(DeductionSummary) updates) =>
      super.copyWith((message) => updates(message as DeductionSummary))
          as DeductionSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeductionSummary create() => DeductionSummary._();
  @$core.override
  DeductionSummary createEmptyInstance() => create();
  static $pb.PbList<DeductionSummary> createRepeated() =>
      $pb.PbList<DeductionSummary>();
  @$core.pragma('dart2js:noInline')
  static DeductionSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeductionSummary>(create);
  static DeductionSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);
}

class PayrollPaginationInfo extends $pb.GeneratedMessage {
  factory PayrollPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
  }) {
    final result = create();
    if (currentPage != null) result.currentPage = currentPage;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalItems != null) result.totalItems = totalItems;
    if (itemsPerPage != null) result.itemsPerPage = itemsPerPage;
    return result;
  }

  PayrollPaginationInfo._();

  factory PayrollPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PayrollPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PayrollPaginationInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayrollPaginationInfo clone() =>
      PayrollPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayrollPaginationInfo copyWith(
          void Function(PayrollPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as PayrollPaginationInfo))
          as PayrollPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayrollPaginationInfo create() => PayrollPaginationInfo._();
  @$core.override
  PayrollPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PayrollPaginationInfo> createRepeated() =>
      $pb.PbList<PayrollPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PayrollPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PayrollPaginationInfo>(create);
  static PayrollPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => $_clearField(4);
}

class AddEmployeeRequest extends $pb.GeneratedMessage {
  factory AddEmployeeRequest({
    $core.String? fullName,
    $core.String? email,
    $core.String? phone,
    $core.String? nin,
    $core.String? bankAccountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    EmploymentType? employmentType,
    $fixnum.Int64? payRate,
    PayFrequency? payFrequency,
    $core.String? department,
    $core.String? jobTitle,
    $core.String? startDate,
    $core.String? userId,
  }) {
    final result = create();
    if (fullName != null) result.fullName = fullName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (nin != null) result.nin = nin;
    if (bankAccountNumber != null) result.bankAccountNumber = bankAccountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (employmentType != null) result.employmentType = employmentType;
    if (payRate != null) result.payRate = payRate;
    if (payFrequency != null) result.payFrequency = payFrequency;
    if (department != null) result.department = department;
    if (jobTitle != null) result.jobTitle = jobTitle;
    if (startDate != null) result.startDate = startDate;
    if (userId != null) result.userId = userId;
    return result;
  }

  AddEmployeeRequest._();

  factory AddEmployeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddEmployeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddEmployeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'phone')
    ..aOS(4, _omitFieldNames ? '' : 'nin')
    ..aOS(5, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'bankCode')
    ..aOS(7, _omitFieldNames ? '' : 'bankName')
    ..e<EmploymentType>(
        8, _omitFieldNames ? '' : 'employmentType', $pb.PbFieldType.OE,
        defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME,
        valueOf: EmploymentType.valueOf,
        enumValues: EmploymentType.values)
    ..aInt64(9, _omitFieldNames ? '' : 'payRate')
    ..e<PayFrequency>(
        10, _omitFieldNames ? '' : 'payFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY,
        valueOf: PayFrequency.valueOf,
        enumValues: PayFrequency.values)
    ..aOS(11, _omitFieldNames ? '' : 'department')
    ..aOS(12, _omitFieldNames ? '' : 'jobTitle')
    ..aOS(13, _omitFieldNames ? '' : 'startDate')
    ..aOS(14, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddEmployeeRequest clone() => AddEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddEmployeeRequest copyWith(void Function(AddEmployeeRequest) updates) =>
      super.copyWith((message) => updates(message as AddEmployeeRequest))
          as AddEmployeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddEmployeeRequest create() => AddEmployeeRequest._();
  @$core.override
  AddEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<AddEmployeeRequest> createRepeated() =>
      $pb.PbList<AddEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static AddEmployeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddEmployeeRequest>(create);
  static AddEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get nin => $_getSZ(3);
  @$pb.TagNumber(4)
  set nin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNin() => $_has(3);
  @$pb.TagNumber(4)
  void clearNin() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankAccountNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBankAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankAccountNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => $_clearField(7);

  @$pb.TagNumber(8)
  EmploymentType get employmentType => $_getN(7);
  @$pb.TagNumber(8)
  set employmentType(EmploymentType value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEmploymentType() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmploymentType() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get payRate => $_getI64(8);
  @$pb.TagNumber(9)
  set payRate($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPayRate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPayRate() => $_clearField(9);

  @$pb.TagNumber(10)
  PayFrequency get payFrequency => $_getN(9);
  @$pb.TagNumber(10)
  set payFrequency(PayFrequency value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPayFrequency() => $_has(9);
  @$pb.TagNumber(10)
  void clearPayFrequency() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get department => $_getSZ(10);
  @$pb.TagNumber(11)
  set department($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDepartment() => $_has(10);
  @$pb.TagNumber(11)
  void clearDepartment() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get jobTitle => $_getSZ(11);
  @$pb.TagNumber(12)
  set jobTitle($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasJobTitle() => $_has(11);
  @$pb.TagNumber(12)
  void clearJobTitle() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get startDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set startDate($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasStartDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearStartDate() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get userId => $_getSZ(13);
  @$pb.TagNumber(14)
  set userId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasUserId() => $_has(13);
  @$pb.TagNumber(14)
  void clearUserId() => $_clearField(14);
}

class AddEmployeeResponse extends $pb.GeneratedMessage {
  factory AddEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (employee != null) result.employee = employee;
    return result;
  }

  AddEmployeeResponse._();

  factory AddEmployeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddEmployeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddEmployeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Employee>(3, _omitFieldNames ? '' : 'employee',
        subBuilder: Employee.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddEmployeeResponse clone() => AddEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddEmployeeResponse copyWith(void Function(AddEmployeeResponse) updates) =>
      super.copyWith((message) => updates(message as AddEmployeeResponse))
          as AddEmployeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddEmployeeResponse create() => AddEmployeeResponse._();
  @$core.override
  AddEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<AddEmployeeResponse> createRepeated() =>
      $pb.PbList<AddEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static AddEmployeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddEmployeeResponse>(create);
  static AddEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Employee get employee => $_getN(2);
  @$pb.TagNumber(3)
  set employee(Employee value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmployee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployee() => $_clearField(3);
  @$pb.TagNumber(3)
  Employee ensureEmployee() => $_ensure(2);
}

class UpdateEmployeeRequest extends $pb.GeneratedMessage {
  factory UpdateEmployeeRequest({
    $core.String? employeeId,
    $core.String? fullName,
    $core.String? email,
    $core.String? phone,
    $core.String? nin,
    $core.String? bankAccountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    EmploymentType? employmentType,
    $fixnum.Int64? payRate,
    PayFrequency? payFrequency,
    $core.String? department,
    $core.String? jobTitle,
    EmployeeStatus? status,
  }) {
    final result = create();
    if (employeeId != null) result.employeeId = employeeId;
    if (fullName != null) result.fullName = fullName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (nin != null) result.nin = nin;
    if (bankAccountNumber != null) result.bankAccountNumber = bankAccountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (employmentType != null) result.employmentType = employmentType;
    if (payRate != null) result.payRate = payRate;
    if (payFrequency != null) result.payFrequency = payFrequency;
    if (department != null) result.department = department;
    if (jobTitle != null) result.jobTitle = jobTitle;
    if (status != null) result.status = status;
    return result;
  }

  UpdateEmployeeRequest._();

  factory UpdateEmployeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateEmployeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateEmployeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..aOS(2, _omitFieldNames ? '' : 'fullName')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'phone')
    ..aOS(5, _omitFieldNames ? '' : 'nin')
    ..aOS(6, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'bankName')
    ..e<EmploymentType>(
        9, _omitFieldNames ? '' : 'employmentType', $pb.PbFieldType.OE,
        defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME,
        valueOf: EmploymentType.valueOf,
        enumValues: EmploymentType.values)
    ..aInt64(10, _omitFieldNames ? '' : 'payRate')
    ..e<PayFrequency>(
        11, _omitFieldNames ? '' : 'payFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY,
        valueOf: PayFrequency.valueOf,
        enumValues: PayFrequency.values)
    ..aOS(12, _omitFieldNames ? '' : 'department')
    ..aOS(13, _omitFieldNames ? '' : 'jobTitle')
    ..e<EmployeeStatus>(14, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE,
        valueOf: EmployeeStatus.valueOf,
        enumValues: EmployeeStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateEmployeeRequest clone() =>
      UpdateEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateEmployeeRequest copyWith(
          void Function(UpdateEmployeeRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateEmployeeRequest))
          as UpdateEmployeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeRequest create() => UpdateEmployeeRequest._();
  @$core.override
  UpdateEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateEmployeeRequest> createRepeated() =>
      $pb.PbList<UpdateEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateEmployeeRequest>(create);
  static UpdateEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get nin => $_getSZ(4);
  @$pb.TagNumber(5)
  set nin($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNin() => $_has(4);
  @$pb.TagNumber(5)
  void clearNin() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankAccountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankAccountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBankAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankName() => $_clearField(8);

  @$pb.TagNumber(9)
  EmploymentType get employmentType => $_getN(8);
  @$pb.TagNumber(9)
  set employmentType(EmploymentType value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasEmploymentType() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmploymentType() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get payRate => $_getI64(9);
  @$pb.TagNumber(10)
  set payRate($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPayRate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPayRate() => $_clearField(10);

  @$pb.TagNumber(11)
  PayFrequency get payFrequency => $_getN(10);
  @$pb.TagNumber(11)
  set payFrequency(PayFrequency value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasPayFrequency() => $_has(10);
  @$pb.TagNumber(11)
  void clearPayFrequency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get department => $_getSZ(11);
  @$pb.TagNumber(12)
  set department($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDepartment() => $_has(11);
  @$pb.TagNumber(12)
  void clearDepartment() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get jobTitle => $_getSZ(12);
  @$pb.TagNumber(13)
  set jobTitle($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasJobTitle() => $_has(12);
  @$pb.TagNumber(13)
  void clearJobTitle() => $_clearField(13);

  @$pb.TagNumber(14)
  EmployeeStatus get status => $_getN(13);
  @$pb.TagNumber(14)
  set status(EmployeeStatus value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => $_clearField(14);
}

class UpdateEmployeeResponse extends $pb.GeneratedMessage {
  factory UpdateEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (employee != null) result.employee = employee;
    return result;
  }

  UpdateEmployeeResponse._();

  factory UpdateEmployeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateEmployeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateEmployeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Employee>(3, _omitFieldNames ? '' : 'employee',
        subBuilder: Employee.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateEmployeeResponse clone() =>
      UpdateEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateEmployeeResponse copyWith(
          void Function(UpdateEmployeeResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateEmployeeResponse))
          as UpdateEmployeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeResponse create() => UpdateEmployeeResponse._();
  @$core.override
  UpdateEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateEmployeeResponse> createRepeated() =>
      $pb.PbList<UpdateEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateEmployeeResponse>(create);
  static UpdateEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Employee get employee => $_getN(2);
  @$pb.TagNumber(3)
  set employee(Employee value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmployee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployee() => $_clearField(3);
  @$pb.TagNumber(3)
  Employee ensureEmployee() => $_ensure(2);
}

class RemoveEmployeeRequest extends $pb.GeneratedMessage {
  factory RemoveEmployeeRequest({
    $core.String? employeeId,
  }) {
    final result = create();
    if (employeeId != null) result.employeeId = employeeId;
    return result;
  }

  RemoveEmployeeRequest._();

  factory RemoveEmployeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveEmployeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveEmployeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveEmployeeRequest clone() =>
      RemoveEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveEmployeeRequest copyWith(
          void Function(RemoveEmployeeRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveEmployeeRequest))
          as RemoveEmployeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeRequest create() => RemoveEmployeeRequest._();
  @$core.override
  RemoveEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveEmployeeRequest> createRepeated() =>
      $pb.PbList<RemoveEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveEmployeeRequest>(create);
  static RemoveEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => $_clearField(1);
}

class RemoveEmployeeResponse extends $pb.GeneratedMessage {
  factory RemoveEmployeeResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  RemoveEmployeeResponse._();

  factory RemoveEmployeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveEmployeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveEmployeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveEmployeeResponse clone() =>
      RemoveEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveEmployeeResponse copyWith(
          void Function(RemoveEmployeeResponse) updates) =>
      super.copyWith((message) => updates(message as RemoveEmployeeResponse))
          as RemoveEmployeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeResponse create() => RemoveEmployeeResponse._();
  @$core.override
  RemoveEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveEmployeeResponse> createRepeated() =>
      $pb.PbList<RemoveEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveEmployeeResponse>(create);
  static RemoveEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetEmployeeRequest extends $pb.GeneratedMessage {
  factory GetEmployeeRequest({
    $core.String? employeeId,
  }) {
    final result = create();
    if (employeeId != null) result.employeeId = employeeId;
    return result;
  }

  GetEmployeeRequest._();

  factory GetEmployeeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEmployeeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEmployeeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEmployeeRequest clone() => GetEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEmployeeRequest copyWith(void Function(GetEmployeeRequest) updates) =>
      super.copyWith((message) => updates(message as GetEmployeeRequest))
          as GetEmployeeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEmployeeRequest create() => GetEmployeeRequest._();
  @$core.override
  GetEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<GetEmployeeRequest> createRepeated() =>
      $pb.PbList<GetEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEmployeeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEmployeeRequest>(create);
  static GetEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => $_clearField(1);
}

class GetEmployeeResponse extends $pb.GeneratedMessage {
  factory GetEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (employee != null) result.employee = employee;
    return result;
  }

  GetEmployeeResponse._();

  factory GetEmployeeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEmployeeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEmployeeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Employee>(3, _omitFieldNames ? '' : 'employee',
        subBuilder: Employee.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEmployeeResponse clone() => GetEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEmployeeResponse copyWith(void Function(GetEmployeeResponse) updates) =>
      super.copyWith((message) => updates(message as GetEmployeeResponse))
          as GetEmployeeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEmployeeResponse create() => GetEmployeeResponse._();
  @$core.override
  GetEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<GetEmployeeResponse> createRepeated() =>
      $pb.PbList<GetEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEmployeeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEmployeeResponse>(create);
  static GetEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Employee get employee => $_getN(2);
  @$pb.TagNumber(3)
  set employee(Employee value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmployee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployee() => $_clearField(3);
  @$pb.TagNumber(3)
  Employee ensureEmployee() => $_ensure(2);
}

class ListEmployeesRequest extends $pb.GeneratedMessage {
  factory ListEmployeesRequest({
    $core.int? page,
    $core.int? limit,
    EmployeeStatus? status,
    $core.String? department,
    $core.String? search,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (status != null) result.status = status;
    if (department != null) result.department = department;
    if (search != null) result.search = search;
    return result;
  }

  ListEmployeesRequest._();

  factory ListEmployeesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListEmployeesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListEmployeesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<EmployeeStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE,
        valueOf: EmployeeStatus.valueOf,
        enumValues: EmployeeStatus.values)
    ..aOS(4, _omitFieldNames ? '' : 'department')
    ..aOS(5, _omitFieldNames ? '' : 'search')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEmployeesRequest clone() =>
      ListEmployeesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEmployeesRequest copyWith(void Function(ListEmployeesRequest) updates) =>
      super.copyWith((message) => updates(message as ListEmployeesRequest))
          as ListEmployeesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListEmployeesRequest create() => ListEmployeesRequest._();
  @$core.override
  ListEmployeesRequest createEmptyInstance() => create();
  static $pb.PbList<ListEmployeesRequest> createRepeated() =>
      $pb.PbList<ListEmployeesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListEmployeesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListEmployeesRequest>(create);
  static ListEmployeesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  EmployeeStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(EmployeeStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get department => $_getSZ(3);
  @$pb.TagNumber(4)
  set department($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDepartment() => $_has(3);
  @$pb.TagNumber(4)
  void clearDepartment() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get search => $_getSZ(4);
  @$pb.TagNumber(5)
  set search($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSearch() => $_has(4);
  @$pb.TagNumber(5)
  void clearSearch() => $_clearField(5);
}

class ListEmployeesResponse extends $pb.GeneratedMessage {
  factory ListEmployeesResponse({
    $core.Iterable<Employee>? employees,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (employees != null) result.employees.addAll(employees);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListEmployeesResponse._();

  factory ListEmployeesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListEmployeesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListEmployeesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Employee>(1, _omitFieldNames ? '' : 'employees', $pb.PbFieldType.PM,
        subBuilder: Employee.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEmployeesResponse clone() =>
      ListEmployeesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListEmployeesResponse copyWith(
          void Function(ListEmployeesResponse) updates) =>
      super.copyWith((message) => updates(message as ListEmployeesResponse))
          as ListEmployeesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListEmployeesResponse create() => ListEmployeesResponse._();
  @$core.override
  ListEmployeesResponse createEmptyInstance() => create();
  static $pb.PbList<ListEmployeesResponse> createRepeated() =>
      $pb.PbList<ListEmployeesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEmployeesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListEmployeesResponse>(create);
  static ListEmployeesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Employee> get employees => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class CreatePayRunRequest extends $pb.GeneratedMessage {
  factory CreatePayRunRequest({
    $core.String? payPeriodStart,
    $core.String? payPeriodEnd,
    $core.String? name,
    $core.Iterable<$core.String>? employeeIds,
    $core.bool? isRecurring,
    RecurrenceFrequency? recurrenceFrequency,
    $core.bool? autoApprove,
  }) {
    final result = create();
    if (payPeriodStart != null) result.payPeriodStart = payPeriodStart;
    if (payPeriodEnd != null) result.payPeriodEnd = payPeriodEnd;
    if (name != null) result.name = name;
    if (employeeIds != null) result.employeeIds.addAll(employeeIds);
    if (isRecurring != null) result.isRecurring = isRecurring;
    if (recurrenceFrequency != null)
      result.recurrenceFrequency = recurrenceFrequency;
    if (autoApprove != null) result.autoApprove = autoApprove;
    return result;
  }

  CreatePayRunRequest._();

  factory CreatePayRunRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePayRunRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePayRunRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payPeriodStart')
    ..aOS(2, _omitFieldNames ? '' : 'payPeriodEnd')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..pPS(4, _omitFieldNames ? '' : 'employeeIds')
    ..aOB(5, _omitFieldNames ? '' : 'isRecurring')
    ..e<RecurrenceFrequency>(
        6, _omitFieldNames ? '' : 'recurrenceFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: RecurrenceFrequency.RECURRENCE_FREQUENCY_NONE,
        valueOf: RecurrenceFrequency.valueOf,
        enumValues: RecurrenceFrequency.values)
    ..aOB(7, _omitFieldNames ? '' : 'autoApprove')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePayRunRequest clone() => CreatePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePayRunRequest copyWith(void Function(CreatePayRunRequest) updates) =>
      super.copyWith((message) => updates(message as CreatePayRunRequest))
          as CreatePayRunRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePayRunRequest create() => CreatePayRunRequest._();
  @$core.override
  CreatePayRunRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePayRunRequest> createRepeated() =>
      $pb.PbList<CreatePayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePayRunRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePayRunRequest>(create);
  static CreatePayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payPeriodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set payPeriodStart($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayPeriodStart() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get payPeriodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set payPeriodEnd($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayPeriodEnd() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get employeeIds => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get isRecurring => $_getBF(4);
  @$pb.TagNumber(5)
  set isRecurring($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsRecurring() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsRecurring() => $_clearField(5);

  @$pb.TagNumber(6)
  RecurrenceFrequency get recurrenceFrequency => $_getN(5);
  @$pb.TagNumber(6)
  set recurrenceFrequency(RecurrenceFrequency value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasRecurrenceFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecurrenceFrequency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get autoApprove => $_getBF(6);
  @$pb.TagNumber(7)
  set autoApprove($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAutoApprove() => $_has(6);
  @$pb.TagNumber(7)
  void clearAutoApprove() => $_clearField(7);
}

class CreatePayRunResponse extends $pb.GeneratedMessage {
  factory CreatePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (payRun != null) result.payRun = payRun;
    return result;
  }

  CreatePayRunResponse._();

  factory CreatePayRunResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePayRunResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePayRunResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePayRunResponse clone() =>
      CreatePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePayRunResponse copyWith(void Function(CreatePayRunResponse) updates) =>
      super.copyWith((message) => updates(message as CreatePayRunResponse))
          as CreatePayRunResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePayRunResponse create() => CreatePayRunResponse._();
  @$core.override
  CreatePayRunResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePayRunResponse> createRepeated() =>
      $pb.PbList<CreatePayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePayRunResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePayRunResponse>(create);
  static CreatePayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => $_clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);
}

class CalculatePayRunRequest extends $pb.GeneratedMessage {
  factory CalculatePayRunRequest({
    $core.String? payRunId,
  }) {
    final result = create();
    if (payRunId != null) result.payRunId = payRunId;
    return result;
  }

  CalculatePayRunRequest._();

  factory CalculatePayRunRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculatePayRunRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculatePayRunRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculatePayRunRequest clone() =>
      CalculatePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculatePayRunRequest copyWith(
          void Function(CalculatePayRunRequest) updates) =>
      super.copyWith((message) => updates(message as CalculatePayRunRequest))
          as CalculatePayRunRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculatePayRunRequest create() => CalculatePayRunRequest._();
  @$core.override
  CalculatePayRunRequest createEmptyInstance() => create();
  static $pb.PbList<CalculatePayRunRequest> createRepeated() =>
      $pb.PbList<CalculatePayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculatePayRunRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculatePayRunRequest>(create);
  static CalculatePayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => $_clearField(1);
}

class CalculatePayRunResponse extends $pb.GeneratedMessage {
  factory CalculatePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
    $core.Iterable<PaySlip>? paySlips,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (payRun != null) result.payRun = payRun;
    if (paySlips != null) result.paySlips.addAll(paySlips);
    return result;
  }

  CalculatePayRunResponse._();

  factory CalculatePayRunResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculatePayRunResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculatePayRunResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..pc<PaySlip>(4, _omitFieldNames ? '' : 'paySlips', $pb.PbFieldType.PM,
        subBuilder: PaySlip.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculatePayRunResponse clone() =>
      CalculatePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculatePayRunResponse copyWith(
          void Function(CalculatePayRunResponse) updates) =>
      super.copyWith((message) => updates(message as CalculatePayRunResponse))
          as CalculatePayRunResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculatePayRunResponse create() => CalculatePayRunResponse._();
  @$core.override
  CalculatePayRunResponse createEmptyInstance() => create();
  static $pb.PbList<CalculatePayRunResponse> createRepeated() =>
      $pb.PbList<CalculatePayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculatePayRunResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculatePayRunResponse>(create);
  static CalculatePayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => $_clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<PaySlip> get paySlips => $_getList(3);
}

class ApprovePayRunRequest extends $pb.GeneratedMessage {
  factory ApprovePayRunRequest({
    $core.String? payRunId,
  }) {
    final result = create();
    if (payRunId != null) result.payRunId = payRunId;
    return result;
  }

  ApprovePayRunRequest._();

  factory ApprovePayRunRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApprovePayRunRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApprovePayRunRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApprovePayRunRequest clone() =>
      ApprovePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApprovePayRunRequest copyWith(void Function(ApprovePayRunRequest) updates) =>
      super.copyWith((message) => updates(message as ApprovePayRunRequest))
          as ApprovePayRunRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApprovePayRunRequest create() => ApprovePayRunRequest._();
  @$core.override
  ApprovePayRunRequest createEmptyInstance() => create();
  static $pb.PbList<ApprovePayRunRequest> createRepeated() =>
      $pb.PbList<ApprovePayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static ApprovePayRunRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApprovePayRunRequest>(create);
  static ApprovePayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => $_clearField(1);
}

class ApprovePayRunResponse extends $pb.GeneratedMessage {
  factory ApprovePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (payRun != null) result.payRun = payRun;
    return result;
  }

  ApprovePayRunResponse._();

  factory ApprovePayRunResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ApprovePayRunResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ApprovePayRunResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApprovePayRunResponse clone() =>
      ApprovePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ApprovePayRunResponse copyWith(
          void Function(ApprovePayRunResponse) updates) =>
      super.copyWith((message) => updates(message as ApprovePayRunResponse))
          as ApprovePayRunResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ApprovePayRunResponse create() => ApprovePayRunResponse._();
  @$core.override
  ApprovePayRunResponse createEmptyInstance() => create();
  static $pb.PbList<ApprovePayRunResponse> createRepeated() =>
      $pb.PbList<ApprovePayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static ApprovePayRunResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ApprovePayRunResponse>(create);
  static ApprovePayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => $_clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);
}

class ProcessPayRunRequest extends $pb.GeneratedMessage {
  factory ProcessPayRunRequest({
    $core.String? payRunId,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
  }) {
    final result = create();
    if (payRunId != null) result.payRunId = payRunId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    return result;
  }

  ProcessPayRunRequest._();

  factory ProcessPayRunRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessPayRunRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessPayRunRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayRunRequest clone() =>
      ProcessPayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayRunRequest copyWith(void Function(ProcessPayRunRequest) updates) =>
      super.copyWith((message) => updates(message as ProcessPayRunRequest))
          as ProcessPayRunRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPayRunRequest create() => ProcessPayRunRequest._();
  @$core.override
  ProcessPayRunRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPayRunRequest> createRepeated() =>
      $pb.PbList<ProcessPayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayRunRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessPayRunRequest>(create);
  static ProcessPayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionPin => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionPin($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionPin() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => $_clearField(3);
}

class ProcessPayRunResponse extends $pb.GeneratedMessage {
  factory ProcessPayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
    $core.int? successfulPayments,
    $core.int? failedPayments,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (payRun != null) result.payRun = payRun;
    if (successfulPayments != null)
      result.successfulPayments = successfulPayments;
    if (failedPayments != null) result.failedPayments = failedPayments;
    return result;
  }

  ProcessPayRunResponse._();

  factory ProcessPayRunResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessPayRunResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessPayRunResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'successfulPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayRunResponse clone() =>
      ProcessPayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPayRunResponse copyWith(
          void Function(ProcessPayRunResponse) updates) =>
      super.copyWith((message) => updates(message as ProcessPayRunResponse))
          as ProcessPayRunResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPayRunResponse create() => ProcessPayRunResponse._();
  @$core.override
  ProcessPayRunResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPayRunResponse> createRepeated() =>
      $pb.PbList<ProcessPayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayRunResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessPayRunResponse>(create);
  static ProcessPayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => $_clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get successfulPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set successfulPayments($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSuccessfulPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccessfulPayments() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get failedPayments => $_getIZ(4);
  @$pb.TagNumber(5)
  set failedPayments($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFailedPayments() => $_has(4);
  @$pb.TagNumber(5)
  void clearFailedPayments() => $_clearField(5);
}

class GetPayRunRequest extends $pb.GeneratedMessage {
  factory GetPayRunRequest({
    $core.String? payRunId,
  }) {
    final result = create();
    if (payRunId != null) result.payRunId = payRunId;
    return result;
  }

  GetPayRunRequest._();

  factory GetPayRunRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPayRunRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPayRunRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayRunRequest clone() => GetPayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayRunRequest copyWith(void Function(GetPayRunRequest) updates) =>
      super.copyWith((message) => updates(message as GetPayRunRequest))
          as GetPayRunRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayRunRequest create() => GetPayRunRequest._();
  @$core.override
  GetPayRunRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayRunRequest> createRepeated() =>
      $pb.PbList<GetPayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayRunRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPayRunRequest>(create);
  static GetPayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => $_clearField(1);
}

class GetPayRunResponse extends $pb.GeneratedMessage {
  factory GetPayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (payRun != null) result.payRun = payRun;
    return result;
  }

  GetPayRunResponse._();

  factory GetPayRunResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPayRunResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPayRunResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayRunResponse clone() => GetPayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayRunResponse copyWith(void Function(GetPayRunResponse) updates) =>
      super.copyWith((message) => updates(message as GetPayRunResponse))
          as GetPayRunResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayRunResponse create() => GetPayRunResponse._();
  @$core.override
  GetPayRunResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayRunResponse> createRepeated() =>
      $pb.PbList<GetPayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayRunResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPayRunResponse>(create);
  static GetPayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => $_clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);
}

class ListPayRunsRequest extends $pb.GeneratedMessage {
  factory ListPayRunsRequest({
    $core.int? page,
    $core.int? limit,
    PayRunStatus? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (status != null) result.status = status;
    return result;
  }

  ListPayRunsRequest._();

  factory ListPayRunsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPayRunsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPayRunsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<PayRunStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PayRunStatus.PAY_RUN_STATUS_DRAFT,
        valueOf: PayRunStatus.valueOf,
        enumValues: PayRunStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPayRunsRequest clone() => ListPayRunsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPayRunsRequest copyWith(void Function(ListPayRunsRequest) updates) =>
      super.copyWith((message) => updates(message as ListPayRunsRequest))
          as ListPayRunsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPayRunsRequest create() => ListPayRunsRequest._();
  @$core.override
  ListPayRunsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPayRunsRequest> createRepeated() =>
      $pb.PbList<ListPayRunsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPayRunsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPayRunsRequest>(create);
  static ListPayRunsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  PayRunStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(PayRunStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class ListPayRunsResponse extends $pb.GeneratedMessage {
  factory ListPayRunsResponse({
    $core.Iterable<PayRun>? payRuns,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (payRuns != null) result.payRuns.addAll(payRuns);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListPayRunsResponse._();

  factory ListPayRunsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPayRunsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPayRunsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<PayRun>(1, _omitFieldNames ? '' : 'payRuns', $pb.PbFieldType.PM,
        subBuilder: PayRun.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPayRunsResponse clone() => ListPayRunsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPayRunsResponse copyWith(void Function(ListPayRunsResponse) updates) =>
      super.copyWith((message) => updates(message as ListPayRunsResponse))
          as ListPayRunsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPayRunsResponse create() => ListPayRunsResponse._();
  @$core.override
  ListPayRunsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPayRunsResponse> createRepeated() =>
      $pb.PbList<ListPayRunsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPayRunsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPayRunsResponse>(create);
  static ListPayRunsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PayRun> get payRuns => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetPaySlipRequest extends $pb.GeneratedMessage {
  factory GetPaySlipRequest({
    $core.String? paySlipId,
  }) {
    final result = create();
    if (paySlipId != null) result.paySlipId = paySlipId;
    return result;
  }

  GetPaySlipRequest._();

  factory GetPaySlipRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaySlipRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaySlipRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paySlipId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaySlipRequest clone() => GetPaySlipRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaySlipRequest copyWith(void Function(GetPaySlipRequest) updates) =>
      super.copyWith((message) => updates(message as GetPaySlipRequest))
          as GetPaySlipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaySlipRequest create() => GetPaySlipRequest._();
  @$core.override
  GetPaySlipRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaySlipRequest> createRepeated() =>
      $pb.PbList<GetPaySlipRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaySlipRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaySlipRequest>(create);
  static GetPaySlipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paySlipId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paySlipId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaySlipId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaySlipId() => $_clearField(1);
}

class GetPaySlipResponse extends $pb.GeneratedMessage {
  factory GetPaySlipResponse({
    $core.bool? success,
    $core.String? message,
    PaySlip? paySlip,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (paySlip != null) result.paySlip = paySlip;
    return result;
  }

  GetPaySlipResponse._();

  factory GetPaySlipResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaySlipResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaySlipResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PaySlip>(3, _omitFieldNames ? '' : 'paySlip',
        subBuilder: PaySlip.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaySlipResponse clone() => GetPaySlipResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaySlipResponse copyWith(void Function(GetPaySlipResponse) updates) =>
      super.copyWith((message) => updates(message as GetPaySlipResponse))
          as GetPaySlipResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaySlipResponse create() => GetPaySlipResponse._();
  @$core.override
  GetPaySlipResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaySlipResponse> createRepeated() =>
      $pb.PbList<GetPaySlipResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaySlipResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaySlipResponse>(create);
  static GetPaySlipResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PaySlip get paySlip => $_getN(2);
  @$pb.TagNumber(3)
  set paySlip(PaySlip value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPaySlip() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaySlip() => $_clearField(3);
  @$pb.TagNumber(3)
  PaySlip ensurePaySlip() => $_ensure(2);
}

class ListPaySlipsRequest extends $pb.GeneratedMessage {
  factory ListPaySlipsRequest({
    $core.String? payRunId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (payRunId != null) result.payRunId = payRunId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListPaySlipsRequest._();

  factory ListPaySlipsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPaySlipsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPaySlipsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaySlipsRequest clone() => ListPaySlipsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaySlipsRequest copyWith(void Function(ListPaySlipsRequest) updates) =>
      super.copyWith((message) => updates(message as ListPaySlipsRequest))
          as ListPaySlipsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaySlipsRequest create() => ListPaySlipsRequest._();
  @$core.override
  ListPaySlipsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPaySlipsRequest> createRepeated() =>
      $pb.PbList<ListPaySlipsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPaySlipsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPaySlipsRequest>(create);
  static ListPaySlipsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class ListPaySlipsResponse extends $pb.GeneratedMessage {
  factory ListPaySlipsResponse({
    $core.Iterable<PaySlip>? paySlips,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (paySlips != null) result.paySlips.addAll(paySlips);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListPaySlipsResponse._();

  factory ListPaySlipsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPaySlipsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPaySlipsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<PaySlip>(1, _omitFieldNames ? '' : 'paySlips', $pb.PbFieldType.PM,
        subBuilder: PaySlip.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaySlipsResponse clone() =>
      ListPaySlipsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPaySlipsResponse copyWith(void Function(ListPaySlipsResponse) updates) =>
      super.copyWith((message) => updates(message as ListPaySlipsResponse))
          as ListPaySlipsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaySlipsResponse create() => ListPaySlipsResponse._();
  @$core.override
  ListPaySlipsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPaySlipsResponse> createRepeated() =>
      $pb.PbList<ListPaySlipsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPaySlipsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPaySlipsResponse>(create);
  static ListPaySlipsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PaySlip> get paySlips => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetPayrollSummaryRequest extends $pb.GeneratedMessage {
  factory GetPayrollSummaryRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final result = create();
    if (periodStart != null) result.periodStart = periodStart;
    if (periodEnd != null) result.periodEnd = periodEnd;
    return result;
  }

  GetPayrollSummaryRequest._();

  factory GetPayrollSummaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPayrollSummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPayrollSummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodStart')
    ..aOS(2, _omitFieldNames ? '' : 'periodEnd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayrollSummaryRequest clone() =>
      GetPayrollSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayrollSummaryRequest copyWith(
          void Function(GetPayrollSummaryRequest) updates) =>
      super.copyWith((message) => updates(message as GetPayrollSummaryRequest))
          as GetPayrollSummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryRequest create() => GetPayrollSummaryRequest._();
  @$core.override
  GetPayrollSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayrollSummaryRequest> createRepeated() =>
      $pb.PbList<GetPayrollSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPayrollSummaryRequest>(create);
  static GetPayrollSummaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodStart($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodStart() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodEnd($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodEnd() => $_clearField(2);
}

class GetPayrollSummaryResponse extends $pb.GeneratedMessage {
  factory GetPayrollSummaryResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? totalEmployees,
    $core.int? totalPayRuns,
    $fixnum.Int64? totalGrossPaid,
    $fixnum.Int64? totalDeductions,
    $fixnum.Int64? totalNetPaid,
    $fixnum.Int64? totalEmployerContributions,
    $core.Iterable<DeductionSummary>? deductionBreakdown,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (totalEmployees != null) result.totalEmployees = totalEmployees;
    if (totalPayRuns != null) result.totalPayRuns = totalPayRuns;
    if (totalGrossPaid != null) result.totalGrossPaid = totalGrossPaid;
    if (totalDeductions != null) result.totalDeductions = totalDeductions;
    if (totalNetPaid != null) result.totalNetPaid = totalNetPaid;
    if (totalEmployerContributions != null)
      result.totalEmployerContributions = totalEmployerContributions;
    if (deductionBreakdown != null)
      result.deductionBreakdown.addAll(deductionBreakdown);
    return result;
  }

  GetPayrollSummaryResponse._();

  factory GetPayrollSummaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPayrollSummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPayrollSummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'totalEmployees', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPayRuns', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'totalGrossPaid')
    ..aInt64(6, _omitFieldNames ? '' : 'totalDeductions')
    ..aInt64(7, _omitFieldNames ? '' : 'totalNetPaid')
    ..aInt64(8, _omitFieldNames ? '' : 'totalEmployerContributions')
    ..pc<DeductionSummary>(
        9, _omitFieldNames ? '' : 'deductionBreakdown', $pb.PbFieldType.PM,
        subBuilder: DeductionSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayrollSummaryResponse clone() =>
      GetPayrollSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayrollSummaryResponse copyWith(
          void Function(GetPayrollSummaryResponse) updates) =>
      super.copyWith((message) => updates(message as GetPayrollSummaryResponse))
          as GetPayrollSummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryResponse create() => GetPayrollSummaryResponse._();
  @$core.override
  GetPayrollSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayrollSummaryResponse> createRepeated() =>
      $pb.PbList<GetPayrollSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPayrollSummaryResponse>(create);
  static GetPayrollSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalEmployees => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalEmployees($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalEmployees() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalEmployees() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPayRuns => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPayRuns($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPayRuns() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPayRuns() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalGrossPaid => $_getI64(4);
  @$pb.TagNumber(5)
  set totalGrossPaid($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalGrossPaid() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalGrossPaid() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDeductions => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDeductions($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalDeductions() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDeductions() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalNetPaid => $_getI64(6);
  @$pb.TagNumber(7)
  set totalNetPaid($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalNetPaid() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalNetPaid() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalEmployerContributions => $_getI64(7);
  @$pb.TagNumber(8)
  set totalEmployerContributions($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalEmployerContributions() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalEmployerContributions() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<DeductionSummary> get deductionBreakdown => $_getList(8);
}

class GetTaxReportRequest extends $pb.GeneratedMessage {
  factory GetTaxReportRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final result = create();
    if (periodStart != null) result.periodStart = periodStart;
    if (periodEnd != null) result.periodEnd = periodEnd;
    return result;
  }

  GetTaxReportRequest._();

  factory GetTaxReportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaxReportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaxReportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodStart')
    ..aOS(2, _omitFieldNames ? '' : 'periodEnd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxReportRequest clone() => GetTaxReportRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxReportRequest copyWith(void Function(GetTaxReportRequest) updates) =>
      super.copyWith((message) => updates(message as GetTaxReportRequest))
          as GetTaxReportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaxReportRequest create() => GetTaxReportRequest._();
  @$core.override
  GetTaxReportRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaxReportRequest> createRepeated() =>
      $pb.PbList<GetTaxReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaxReportRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaxReportRequest>(create);
  static GetTaxReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodStart($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodStart() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodEnd($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodEnd() => $_clearField(2);
}

class GetTaxReportResponse extends $pb.GeneratedMessage {
  factory GetTaxReportResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? totalPaye,
    $fixnum.Int64? totalNhf,
    $fixnum.Int64? totalPensionEmployee,
    $fixnum.Int64? totalPensionEmployer,
    $fixnum.Int64? totalNsitf,
    $fixnum.Int64? totalItf,
    $core.Iterable<EmployeeTaxSummary>? employeeSummaries,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (totalPaye != null) result.totalPaye = totalPaye;
    if (totalNhf != null) result.totalNhf = totalNhf;
    if (totalPensionEmployee != null)
      result.totalPensionEmployee = totalPensionEmployee;
    if (totalPensionEmployer != null)
      result.totalPensionEmployer = totalPensionEmployer;
    if (totalNsitf != null) result.totalNsitf = totalNsitf;
    if (totalItf != null) result.totalItf = totalItf;
    if (employeeSummaries != null)
      result.employeeSummaries.addAll(employeeSummaries);
    return result;
  }

  GetTaxReportResponse._();

  factory GetTaxReportResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaxReportResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaxReportResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aInt64(3, _omitFieldNames ? '' : 'totalPaye')
    ..aInt64(4, _omitFieldNames ? '' : 'totalNhf')
    ..aInt64(5, _omitFieldNames ? '' : 'totalPensionEmployee')
    ..aInt64(6, _omitFieldNames ? '' : 'totalPensionEmployer')
    ..aInt64(7, _omitFieldNames ? '' : 'totalNsitf')
    ..aInt64(8, _omitFieldNames ? '' : 'totalItf')
    ..pc<EmployeeTaxSummary>(
        9, _omitFieldNames ? '' : 'employeeSummaries', $pb.PbFieldType.PM,
        subBuilder: EmployeeTaxSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxReportResponse clone() =>
      GetTaxReportResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxReportResponse copyWith(void Function(GetTaxReportResponse) updates) =>
      super.copyWith((message) => updates(message as GetTaxReportResponse))
          as GetTaxReportResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaxReportResponse create() => GetTaxReportResponse._();
  @$core.override
  GetTaxReportResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaxReportResponse> createRepeated() =>
      $pb.PbList<GetTaxReportResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaxReportResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaxReportResponse>(create);
  static GetTaxReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalPaye => $_getI64(2);
  @$pb.TagNumber(3)
  set totalPaye($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalPaye() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaye() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalNhf => $_getI64(3);
  @$pb.TagNumber(4)
  set totalNhf($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalNhf() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalNhf() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalPensionEmployee => $_getI64(4);
  @$pb.TagNumber(5)
  set totalPensionEmployee($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPensionEmployee() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPensionEmployee() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalPensionEmployer => $_getI64(5);
  @$pb.TagNumber(6)
  set totalPensionEmployer($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalPensionEmployer() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPensionEmployer() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalNsitf => $_getI64(6);
  @$pb.TagNumber(7)
  set totalNsitf($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalNsitf() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalNsitf() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalItf => $_getI64(7);
  @$pb.TagNumber(8)
  set totalItf($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalItf() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalItf() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<EmployeeTaxSummary> get employeeSummaries => $_getList(8);
}

class EmployeeTaxSummary extends $pb.GeneratedMessage {
  factory EmployeeTaxSummary({
    $core.String? employeeId,
    $core.String? employeeName,
    $fixnum.Int64? grossPay,
    $fixnum.Int64? paye,
    $fixnum.Int64? nhf,
    $fixnum.Int64? pension,
    $fixnum.Int64? netPay,
  }) {
    final result = create();
    if (employeeId != null) result.employeeId = employeeId;
    if (employeeName != null) result.employeeName = employeeName;
    if (grossPay != null) result.grossPay = grossPay;
    if (paye != null) result.paye = paye;
    if (nhf != null) result.nhf = nhf;
    if (pension != null) result.pension = pension;
    if (netPay != null) result.netPay = netPay;
    return result;
  }

  EmployeeTaxSummary._();

  factory EmployeeTaxSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EmployeeTaxSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmployeeTaxSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..aOS(2, _omitFieldNames ? '' : 'employeeName')
    ..aInt64(3, _omitFieldNames ? '' : 'grossPay')
    ..aInt64(4, _omitFieldNames ? '' : 'paye')
    ..aInt64(5, _omitFieldNames ? '' : 'nhf')
    ..aInt64(6, _omitFieldNames ? '' : 'pension')
    ..aInt64(7, _omitFieldNames ? '' : 'netPay')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmployeeTaxSummary clone() => EmployeeTaxSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmployeeTaxSummary copyWith(void Function(EmployeeTaxSummary) updates) =>
      super.copyWith((message) => updates(message as EmployeeTaxSummary))
          as EmployeeTaxSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmployeeTaxSummary create() => EmployeeTaxSummary._();
  @$core.override
  EmployeeTaxSummary createEmptyInstance() => create();
  static $pb.PbList<EmployeeTaxSummary> createRepeated() =>
      $pb.PbList<EmployeeTaxSummary>();
  @$core.pragma('dart2js:noInline')
  static EmployeeTaxSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EmployeeTaxSummary>(create);
  static EmployeeTaxSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get employeeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set employeeName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmployeeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmployeeName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get grossPay => $_getI64(2);
  @$pb.TagNumber(3)
  set grossPay($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGrossPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrossPay() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get paye => $_getI64(3);
  @$pb.TagNumber(4)
  set paye($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaye() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaye() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get nhf => $_getI64(4);
  @$pb.TagNumber(5)
  set nhf($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNhf() => $_has(4);
  @$pb.TagNumber(5)
  void clearNhf() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get pension => $_getI64(5);
  @$pb.TagNumber(6)
  set pension($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPension() => $_has(5);
  @$pb.TagNumber(6)
  void clearPension() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get netPay => $_getI64(6);
  @$pb.TagNumber(7)
  set netPay($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNetPay() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetPay() => $_clearField(7);
}

class CreateInventoryItemRequest extends $pb.GeneratedMessage {
  factory CreateInventoryItemRequest({
    $core.String? name,
    $core.String? description,
    $core.String? category,
    $core.int? quantity,
    $fixnum.Int64? unitPrice,
    $core.String? unit,
    $core.String? sku,
    $core.String? location,
    $core.int? minimumStockLevel,
    $core.String? notes,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (quantity != null) result.quantity = quantity;
    if (unitPrice != null) result.unitPrice = unitPrice;
    if (unit != null) result.unit = unit;
    if (sku != null) result.sku = sku;
    if (location != null) result.location = location;
    if (minimumStockLevel != null) result.minimumStockLevel = minimumStockLevel;
    if (notes != null) result.notes = notes;
    return result;
  }

  CreateInventoryItemRequest._();

  factory CreateInventoryItemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInventoryItemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInventoryItemRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'unitPrice')
    ..aOS(6, _omitFieldNames ? '' : 'unit')
    ..aOS(7, _omitFieldNames ? '' : 'sku')
    ..aOS(8, _omitFieldNames ? '' : 'location')
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'minimumStockLevel', $pb.PbFieldType.O3)
    ..aOS(10, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInventoryItemRequest clone() =>
      CreateInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInventoryItemRequest copyWith(
          void Function(CreateInventoryItemRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateInventoryItemRequest))
          as CreateInventoryItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemRequest create() => CreateInventoryItemRequest._();
  @$core.override
  CreateInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInventoryItemRequest> createRepeated() =>
      $pb.PbList<CreateInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInventoryItemRequest>(create);
  static CreateInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPrice => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPrice($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get unit => $_getSZ(5);
  @$pb.TagNumber(6)
  set unit($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUnit() => $_has(5);
  @$pb.TagNumber(6)
  void clearUnit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sku => $_getSZ(6);
  @$pb.TagNumber(7)
  set sku($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSku() => $_has(6);
  @$pb.TagNumber(7)
  void clearSku() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get location => $_getSZ(7);
  @$pb.TagNumber(8)
  set location($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearLocation() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get minimumStockLevel => $_getIZ(8);
  @$pb.TagNumber(9)
  set minimumStockLevel($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMinimumStockLevel() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinimumStockLevel() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => $_clearField(10);
}

class CreateInventoryItemResponse extends $pb.GeneratedMessage {
  factory CreateInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (item != null) result.item = item;
    return result;
  }

  CreateInventoryItemResponse._();

  factory CreateInventoryItemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInventoryItemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInventoryItemResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<InventoryItem>(3, _omitFieldNames ? '' : 'item',
        subBuilder: InventoryItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInventoryItemResponse clone() =>
      CreateInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInventoryItemResponse copyWith(
          void Function(CreateInventoryItemResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateInventoryItemResponse))
          as CreateInventoryItemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemResponse create() =>
      CreateInventoryItemResponse._();
  @$core.override
  CreateInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInventoryItemResponse> createRepeated() =>
      $pb.PbList<CreateInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInventoryItemResponse>(create);
  static CreateInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);
}

class UpdateInventoryItemRequest extends $pb.GeneratedMessage {
  factory UpdateInventoryItemRequest({
    $core.String? itemId,
    $core.String? name,
    $core.String? description,
    $core.String? category,
    $fixnum.Int64? unitPrice,
    $core.String? unit,
    $core.String? sku,
    $core.String? location,
    $core.int? minimumStockLevel,
    InventoryItemStatus? status,
    $core.String? notes,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (unitPrice != null) result.unitPrice = unitPrice;
    if (unit != null) result.unit = unit;
    if (sku != null) result.sku = sku;
    if (location != null) result.location = location;
    if (minimumStockLevel != null) result.minimumStockLevel = minimumStockLevel;
    if (status != null) result.status = status;
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdateInventoryItemRequest._();

  factory UpdateInventoryItemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInventoryItemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInventoryItemRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aInt64(5, _omitFieldNames ? '' : 'unitPrice')
    ..aOS(6, _omitFieldNames ? '' : 'unit')
    ..aOS(7, _omitFieldNames ? '' : 'sku')
    ..aOS(8, _omitFieldNames ? '' : 'location')
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'minimumStockLevel', $pb.PbFieldType.O3)
    ..e<InventoryItemStatus>(
        10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE,
        valueOf: InventoryItemStatus.valueOf,
        enumValues: InventoryItemStatus.values)
    ..aOS(11, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInventoryItemRequest clone() =>
      UpdateInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInventoryItemRequest copyWith(
          void Function(UpdateInventoryItemRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateInventoryItemRequest))
          as UpdateInventoryItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemRequest create() => UpdateInventoryItemRequest._();
  @$core.override
  UpdateInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInventoryItemRequest> createRepeated() =>
      $pb.PbList<UpdateInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInventoryItemRequest>(create);
  static UpdateInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPrice => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPrice($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get unit => $_getSZ(5);
  @$pb.TagNumber(6)
  set unit($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUnit() => $_has(5);
  @$pb.TagNumber(6)
  void clearUnit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get sku => $_getSZ(6);
  @$pb.TagNumber(7)
  set sku($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSku() => $_has(6);
  @$pb.TagNumber(7)
  void clearSku() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get location => $_getSZ(7);
  @$pb.TagNumber(8)
  set location($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearLocation() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get minimumStockLevel => $_getIZ(8);
  @$pb.TagNumber(9)
  set minimumStockLevel($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMinimumStockLevel() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinimumStockLevel() => $_clearField(9);

  @$pb.TagNumber(10)
  InventoryItemStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(InventoryItemStatus value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => $_clearField(11);
}

class UpdateInventoryItemResponse extends $pb.GeneratedMessage {
  factory UpdateInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (item != null) result.item = item;
    return result;
  }

  UpdateInventoryItemResponse._();

  factory UpdateInventoryItemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInventoryItemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInventoryItemResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<InventoryItem>(3, _omitFieldNames ? '' : 'item',
        subBuilder: InventoryItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInventoryItemResponse clone() =>
      UpdateInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInventoryItemResponse copyWith(
          void Function(UpdateInventoryItemResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateInventoryItemResponse))
          as UpdateInventoryItemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemResponse create() =>
      UpdateInventoryItemResponse._();
  @$core.override
  UpdateInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInventoryItemResponse> createRepeated() =>
      $pb.PbList<UpdateInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInventoryItemResponse>(create);
  static UpdateInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);
}

class DeleteInventoryItemRequest extends $pb.GeneratedMessage {
  factory DeleteInventoryItemRequest({
    $core.String? itemId,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    return result;
  }

  DeleteInventoryItemRequest._();

  factory DeleteInventoryItemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteInventoryItemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteInventoryItemRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInventoryItemRequest clone() =>
      DeleteInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInventoryItemRequest copyWith(
          void Function(DeleteInventoryItemRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteInventoryItemRequest))
          as DeleteInventoryItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemRequest create() => DeleteInventoryItemRequest._();
  @$core.override
  DeleteInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteInventoryItemRequest> createRepeated() =>
      $pb.PbList<DeleteInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteInventoryItemRequest>(create);
  static DeleteInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);
}

class DeleteInventoryItemResponse extends $pb.GeneratedMessage {
  factory DeleteInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteInventoryItemResponse._();

  factory DeleteInventoryItemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteInventoryItemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteInventoryItemResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInventoryItemResponse clone() =>
      DeleteInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInventoryItemResponse copyWith(
          void Function(DeleteInventoryItemResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteInventoryItemResponse))
          as DeleteInventoryItemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemResponse create() =>
      DeleteInventoryItemResponse._();
  @$core.override
  DeleteInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteInventoryItemResponse> createRepeated() =>
      $pb.PbList<DeleteInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteInventoryItemResponse>(create);
  static DeleteInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetInventoryItemRequest extends $pb.GeneratedMessage {
  factory GetInventoryItemRequest({
    $core.String? itemId,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    return result;
  }

  GetInventoryItemRequest._();

  factory GetInventoryItemRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventoryItemRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventoryItemRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryItemRequest clone() =>
      GetInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryItemRequest copyWith(
          void Function(GetInventoryItemRequest) updates) =>
      super.copyWith((message) => updates(message as GetInventoryItemRequest))
          as GetInventoryItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventoryItemRequest create() => GetInventoryItemRequest._();
  @$core.override
  GetInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventoryItemRequest> createRepeated() =>
      $pb.PbList<GetInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryItemRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventoryItemRequest>(create);
  static GetInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);
}

class GetInventoryItemResponse extends $pb.GeneratedMessage {
  factory GetInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (item != null) result.item = item;
    return result;
  }

  GetInventoryItemResponse._();

  factory GetInventoryItemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventoryItemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventoryItemResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<InventoryItem>(3, _omitFieldNames ? '' : 'item',
        subBuilder: InventoryItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryItemResponse clone() =>
      GetInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryItemResponse copyWith(
          void Function(GetInventoryItemResponse) updates) =>
      super.copyWith((message) => updates(message as GetInventoryItemResponse))
          as GetInventoryItemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventoryItemResponse create() => GetInventoryItemResponse._();
  @$core.override
  GetInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventoryItemResponse> createRepeated() =>
      $pb.PbList<GetInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryItemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventoryItemResponse>(create);
  static GetInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);
}

class ListInventoryItemsRequest extends $pb.GeneratedMessage {
  factory ListInventoryItemsRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? category,
    $core.String? search,
    $core.bool? lowStockOnly,
    InventoryItemStatus? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (category != null) result.category = category;
    if (search != null) result.search = search;
    if (lowStockOnly != null) result.lowStockOnly = lowStockOnly;
    if (status != null) result.status = status;
    return result;
  }

  ListInventoryItemsRequest._();

  factory ListInventoryItemsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListInventoryItemsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListInventoryItemsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'search')
    ..aOB(5, _omitFieldNames ? '' : 'lowStockOnly')
    ..e<InventoryItemStatus>(
        6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE,
        valueOf: InventoryItemStatus.valueOf,
        enumValues: InventoryItemStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInventoryItemsRequest clone() =>
      ListInventoryItemsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInventoryItemsRequest copyWith(
          void Function(ListInventoryItemsRequest) updates) =>
      super.copyWith((message) => updates(message as ListInventoryItemsRequest))
          as ListInventoryItemsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsRequest create() => ListInventoryItemsRequest._();
  @$core.override
  ListInventoryItemsRequest createEmptyInstance() => create();
  static $pb.PbList<ListInventoryItemsRequest> createRepeated() =>
      $pb.PbList<ListInventoryItemsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListInventoryItemsRequest>(create);
  static ListInventoryItemsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get search => $_getSZ(3);
  @$pb.TagNumber(4)
  set search($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSearch() => $_has(3);
  @$pb.TagNumber(4)
  void clearSearch() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get lowStockOnly => $_getBF(4);
  @$pb.TagNumber(5)
  set lowStockOnly($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLowStockOnly() => $_has(4);
  @$pb.TagNumber(5)
  void clearLowStockOnly() => $_clearField(5);

  @$pb.TagNumber(6)
  InventoryItemStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(InventoryItemStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);
}

class ListInventoryItemsResponse extends $pb.GeneratedMessage {
  factory ListInventoryItemsResponse({
    $core.Iterable<InventoryItem>? items,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListInventoryItemsResponse._();

  factory ListInventoryItemsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListInventoryItemsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListInventoryItemsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InventoryItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: InventoryItem.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInventoryItemsResponse clone() =>
      ListInventoryItemsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListInventoryItemsResponse copyWith(
          void Function(ListInventoryItemsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListInventoryItemsResponse))
          as ListInventoryItemsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsResponse create() => ListInventoryItemsResponse._();
  @$core.override
  ListInventoryItemsResponse createEmptyInstance() => create();
  static $pb.PbList<ListInventoryItemsResponse> createRepeated() =>
      $pb.PbList<ListInventoryItemsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListInventoryItemsResponse>(create);
  static ListInventoryItemsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InventoryItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class AdjustInventoryQuantityRequest extends $pb.GeneratedMessage {
  factory AdjustInventoryQuantityRequest({
    $core.String? itemId,
    AdjustmentType? adjustmentType,
    $core.int? quantity,
    $core.String? reason,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (adjustmentType != null) result.adjustmentType = adjustmentType;
    if (quantity != null) result.quantity = quantity;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdjustInventoryQuantityRequest._();

  factory AdjustInventoryQuantityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdjustInventoryQuantityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdjustInventoryQuantityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..e<AdjustmentType>(
        2, _omitFieldNames ? '' : 'adjustmentType', $pb.PbFieldType.OE,
        defaultOrMaker: AdjustmentType.ADJUSTMENT_TYPE_ADD,
        valueOf: AdjustmentType.valueOf,
        enumValues: AdjustmentType.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdjustInventoryQuantityRequest clone() =>
      AdjustInventoryQuantityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdjustInventoryQuantityRequest copyWith(
          void Function(AdjustInventoryQuantityRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdjustInventoryQuantityRequest))
          as AdjustInventoryQuantityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityRequest create() =>
      AdjustInventoryQuantityRequest._();
  @$core.override
  AdjustInventoryQuantityRequest createEmptyInstance() => create();
  static $pb.PbList<AdjustInventoryQuantityRequest> createRepeated() =>
      $pb.PbList<AdjustInventoryQuantityRequest>();
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdjustInventoryQuantityRequest>(create);
  static AdjustInventoryQuantityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  AdjustmentType get adjustmentType => $_getN(1);
  @$pb.TagNumber(2)
  set adjustmentType(AdjustmentType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAdjustmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdjustmentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);
}

class AdjustInventoryQuantityResponse extends $pb.GeneratedMessage {
  factory AdjustInventoryQuantityResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
    InventoryAdjustment? adjustment,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (item != null) result.item = item;
    if (adjustment != null) result.adjustment = adjustment;
    return result;
  }

  AdjustInventoryQuantityResponse._();

  factory AdjustInventoryQuantityResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdjustInventoryQuantityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdjustInventoryQuantityResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<InventoryItem>(3, _omitFieldNames ? '' : 'item',
        subBuilder: InventoryItem.create)
    ..aOM<InventoryAdjustment>(4, _omitFieldNames ? '' : 'adjustment',
        subBuilder: InventoryAdjustment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdjustInventoryQuantityResponse clone() =>
      AdjustInventoryQuantityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdjustInventoryQuantityResponse copyWith(
          void Function(AdjustInventoryQuantityResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdjustInventoryQuantityResponse))
          as AdjustInventoryQuantityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityResponse create() =>
      AdjustInventoryQuantityResponse._();
  @$core.override
  AdjustInventoryQuantityResponse createEmptyInstance() => create();
  static $pb.PbList<AdjustInventoryQuantityResponse> createRepeated() =>
      $pb.PbList<AdjustInventoryQuantityResponse>();
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdjustInventoryQuantityResponse>(
          create);
  static AdjustInventoryQuantityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);

  @$pb.TagNumber(4)
  InventoryAdjustment get adjustment => $_getN(3);
  @$pb.TagNumber(4)
  set adjustment(InventoryAdjustment value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAdjustment() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdjustment() => $_clearField(4);
  @$pb.TagNumber(4)
  InventoryAdjustment ensureAdjustment() => $_ensure(3);
}

class GetInventoryHistoryRequest extends $pb.GeneratedMessage {
  factory GetInventoryHistoryRequest({
    $core.String? itemId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetInventoryHistoryRequest._();

  factory GetInventoryHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventoryHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventoryHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryHistoryRequest clone() =>
      GetInventoryHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryHistoryRequest copyWith(
          void Function(GetInventoryHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInventoryHistoryRequest))
          as GetInventoryHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryRequest create() => GetInventoryHistoryRequest._();
  @$core.override
  GetInventoryHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventoryHistoryRequest> createRepeated() =>
      $pb.PbList<GetInventoryHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventoryHistoryRequest>(create);
  static GetInventoryHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetInventoryHistoryResponse extends $pb.GeneratedMessage {
  factory GetInventoryHistoryResponse({
    $core.Iterable<InventoryAdjustment>? adjustments,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (adjustments != null) result.adjustments.addAll(adjustments);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetInventoryHistoryResponse._();

  factory GetInventoryHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventoryHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventoryHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InventoryAdjustment>(
        1, _omitFieldNames ? '' : 'adjustments', $pb.PbFieldType.PM,
        subBuilder: InventoryAdjustment.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryHistoryResponse clone() =>
      GetInventoryHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryHistoryResponse copyWith(
          void Function(GetInventoryHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInventoryHistoryResponse))
          as GetInventoryHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryResponse create() =>
      GetInventoryHistoryResponse._();
  @$core.override
  GetInventoryHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventoryHistoryResponse> createRepeated() =>
      $pb.PbList<GetInventoryHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventoryHistoryResponse>(create);
  static GetInventoryHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InventoryAdjustment> get adjustments => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetInventorySummaryRequest extends $pb.GeneratedMessage {
  factory GetInventorySummaryRequest() => create();

  GetInventorySummaryRequest._();

  factory GetInventorySummaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventorySummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventorySummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventorySummaryRequest clone() =>
      GetInventorySummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventorySummaryRequest copyWith(
          void Function(GetInventorySummaryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInventorySummaryRequest))
          as GetInventorySummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryRequest create() => GetInventorySummaryRequest._();
  @$core.override
  GetInventorySummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventorySummaryRequest> createRepeated() =>
      $pb.PbList<GetInventorySummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventorySummaryRequest>(create);
  static GetInventorySummaryRequest? _defaultInstance;
}

class GetInventorySummaryResponse extends $pb.GeneratedMessage {
  factory GetInventorySummaryResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? totalItems,
    $core.int? lowStockItems,
    $fixnum.Int64? totalInventoryValue,
    $core.Iterable<CategorySummary>? categories,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (totalItems != null) result.totalItems = totalItems;
    if (lowStockItems != null) result.lowStockItems = lowStockItems;
    if (totalInventoryValue != null)
      result.totalInventoryValue = totalInventoryValue;
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  GetInventorySummaryResponse._();

  factory GetInventorySummaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventorySummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventorySummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'lowStockItems', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'totalInventoryValue')
    ..pc<CategorySummary>(
        6, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: CategorySummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventorySummaryResponse clone() =>
      GetInventorySummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventorySummaryResponse copyWith(
          void Function(GetInventorySummaryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInventorySummaryResponse))
          as GetInventorySummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryResponse create() =>
      GetInventorySummaryResponse._();
  @$core.override
  GetInventorySummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventorySummaryResponse> createRepeated() =>
      $pb.PbList<GetInventorySummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventorySummaryResponse>(create);
  static GetInventorySummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get lowStockItems => $_getIZ(3);
  @$pb.TagNumber(4)
  set lowStockItems($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLowStockItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearLowStockItems() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalInventoryValue => $_getI64(4);
  @$pb.TagNumber(5)
  set totalInventoryValue($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalInventoryValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalInventoryValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<CategorySummary> get categories => $_getList(5);
}

class Customer extends $pb.GeneratedMessage {
  factory Customer({
    $core.String? id,
    $core.String? businessId,
    $core.String? name,
    $core.String? businessName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    $core.String? city,
    $core.String? state,
    $core.String? country,
    $core.String? tin,
    $core.String? bankAccountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    CustomerSegment? segment,
    CustomerStatus? status,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (name != null) result.name = name;
    if (businessName != null) result.businessName = businessName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    if (city != null) result.city = city;
    if (state != null) result.state = state;
    if (country != null) result.country = country;
    if (tin != null) result.tin = tin;
    if (bankAccountNumber != null) result.bankAccountNumber = bankAccountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (segment != null) result.segment = segment;
    if (status != null) result.status = status;
    if (tags != null) result.tags.addAll(tags);
    if (notes != null) result.notes = notes;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Customer._();

  factory Customer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Customer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Customer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'businessName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'phone')
    ..aOS(7, _omitFieldNames ? '' : 'address')
    ..aOS(8, _omitFieldNames ? '' : 'city')
    ..aOS(9, _omitFieldNames ? '' : 'state')
    ..aOS(10, _omitFieldNames ? '' : 'country')
    ..aOS(11, _omitFieldNames ? '' : 'tin')
    ..aOS(12, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(13, _omitFieldNames ? '' : 'bankCode')
    ..aOS(14, _omitFieldNames ? '' : 'bankName')
    ..e<CustomerSegment>(
        15, _omitFieldNames ? '' : 'segment', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE,
        valueOf: CustomerSegment.valueOf,
        enumValues: CustomerSegment.values)
    ..e<CustomerStatus>(16, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerStatus.CUSTOMER_STATUS_ACTIVE,
        valueOf: CustomerStatus.valueOf,
        enumValues: CustomerStatus.values)
    ..pPS(17, _omitFieldNames ? '' : 'tags')
    ..aOS(18, _omitFieldNames ? '' : 'notes')
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Customer clone() => Customer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Customer copyWith(void Function(Customer) updates) =>
      super.copyWith((message) => updates(message as Customer)) as Customer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Customer create() => Customer._();
  @$core.override
  Customer createEmptyInstance() => create();
  static $pb.PbList<Customer> createRepeated() => $pb.PbList<Customer>();
  @$core.pragma('dart2js:noInline')
  static Customer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Customer>(create);
  static Customer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get businessName => $_getSZ(3);
  @$pb.TagNumber(4)
  set businessName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBusinessName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBusinessName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get address => $_getSZ(6);
  @$pb.TagNumber(7)
  set address($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearAddress() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get city => $_getSZ(7);
  @$pb.TagNumber(8)
  set city($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCity() => $_has(7);
  @$pb.TagNumber(8)
  void clearCity() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get state => $_getSZ(8);
  @$pb.TagNumber(9)
  set state($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasState() => $_has(8);
  @$pb.TagNumber(9)
  void clearState() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get country => $_getSZ(9);
  @$pb.TagNumber(10)
  set country($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCountry() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountry() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get tin => $_getSZ(10);
  @$pb.TagNumber(11)
  set tin($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTin() => $_has(10);
  @$pb.TagNumber(11)
  void clearTin() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankAccountNumber => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankAccountNumber($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBankAccountNumber() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankAccountNumber() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get bankCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set bankCode($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBankCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearBankCode() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get bankName => $_getSZ(13);
  @$pb.TagNumber(14)
  set bankName($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasBankName() => $_has(13);
  @$pb.TagNumber(14)
  void clearBankName() => $_clearField(14);

  @$pb.TagNumber(15)
  CustomerSegment get segment => $_getN(14);
  @$pb.TagNumber(15)
  set segment(CustomerSegment value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasSegment() => $_has(14);
  @$pb.TagNumber(15)
  void clearSegment() => $_clearField(15);

  @$pb.TagNumber(16)
  CustomerStatus get status => $_getN(15);
  @$pb.TagNumber(16)
  set status(CustomerStatus value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => $_clearField(16);

  @$pb.TagNumber(17)
  $pb.PbList<$core.String> get tags => $_getList(16);

  @$pb.TagNumber(18)
  $core.String get notes => $_getSZ(17);
  @$pb.TagNumber(18)
  set notes($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasNotes() => $_has(17);
  @$pb.TagNumber(18)
  void clearNotes() => $_clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get createdAt => $_getN(18);
  @$pb.TagNumber(19)
  set createdAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureCreatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get updatedAt => $_getN(19);
  @$pb.TagNumber(20)
  set updatedAt($1.Timestamp value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => $_clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureUpdatedAt() => $_ensure(19);
}

class CustomerFinancialProfile extends $pb.GeneratedMessage {
  factory CustomerFinancialProfile({
    $core.String? customerId,
    $fixnum.Int64? totalInvoiced,
    $fixnum.Int64? totalPaid,
    $fixnum.Int64? outstanding,
    $core.int? avgPaymentDays,
    $core.int? totalInvoices,
    $core.int? paidInvoices,
    $core.int? overdueInvoices,
    $1.Timestamp? lastPaymentDate,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (totalInvoiced != null) result.totalInvoiced = totalInvoiced;
    if (totalPaid != null) result.totalPaid = totalPaid;
    if (outstanding != null) result.outstanding = outstanding;
    if (avgPaymentDays != null) result.avgPaymentDays = avgPaymentDays;
    if (totalInvoices != null) result.totalInvoices = totalInvoices;
    if (paidInvoices != null) result.paidInvoices = paidInvoices;
    if (overdueInvoices != null) result.overdueInvoices = overdueInvoices;
    if (lastPaymentDate != null) result.lastPaymentDate = lastPaymentDate;
    return result;
  }

  CustomerFinancialProfile._();

  factory CustomerFinancialProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CustomerFinancialProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomerFinancialProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..aInt64(2, _omitFieldNames ? '' : 'totalInvoiced')
    ..aInt64(3, _omitFieldNames ? '' : 'totalPaid')
    ..aInt64(4, _omitFieldNames ? '' : 'outstanding')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'avgPaymentDays', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'totalInvoices', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'paidInvoices', $pb.PbFieldType.O3)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'overdueInvoices', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'lastPaymentDate',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerFinancialProfile clone() =>
      CustomerFinancialProfile()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerFinancialProfile copyWith(
          void Function(CustomerFinancialProfile) updates) =>
      super.copyWith((message) => updates(message as CustomerFinancialProfile))
          as CustomerFinancialProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomerFinancialProfile create() => CustomerFinancialProfile._();
  @$core.override
  CustomerFinancialProfile createEmptyInstance() => create();
  static $pb.PbList<CustomerFinancialProfile> createRepeated() =>
      $pb.PbList<CustomerFinancialProfile>();
  @$core.pragma('dart2js:noInline')
  static CustomerFinancialProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomerFinancialProfile>(create);
  static CustomerFinancialProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalInvoiced => $_getI64(1);
  @$pb.TagNumber(2)
  set totalInvoiced($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalInvoiced() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalInvoiced() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalPaid => $_getI64(2);
  @$pb.TagNumber(3)
  set totalPaid($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalPaid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaid() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get outstanding => $_getI64(3);
  @$pb.TagNumber(4)
  set outstanding($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOutstanding() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutstanding() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get avgPaymentDays => $_getIZ(4);
  @$pb.TagNumber(5)
  set avgPaymentDays($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvgPaymentDays() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvgPaymentDays() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalInvoices => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalInvoices($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalInvoices() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalInvoices() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get paidInvoices => $_getIZ(6);
  @$pb.TagNumber(7)
  set paidInvoices($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaidInvoices() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaidInvoices() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get overdueInvoices => $_getIZ(7);
  @$pb.TagNumber(8)
  set overdueInvoices($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOverdueInvoices() => $_has(7);
  @$pb.TagNumber(8)
  void clearOverdueInvoices() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get lastPaymentDate => $_getN(8);
  @$pb.TagNumber(9)
  set lastPaymentDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasLastPaymentDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastPaymentDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureLastPaymentDate() => $_ensure(8);
}

class CustomerNote extends $pb.GeneratedMessage {
  factory CustomerNote({
    $core.String? id,
    $core.String? customerId,
    $core.String? businessId,
    $core.String? content,
    $core.String? createdBy,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (customerId != null) result.customerId = customerId;
    if (businessId != null) result.businessId = businessId;
    if (content != null) result.content = content;
    if (createdBy != null) result.createdBy = createdBy;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  CustomerNote._();

  factory CustomerNote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CustomerNote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomerNote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'customerId')
    ..aOS(3, _omitFieldNames ? '' : 'businessId')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aOS(5, _omitFieldNames ? '' : 'createdBy')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerNote clone() => CustomerNote()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerNote copyWith(void Function(CustomerNote) updates) =>
      super.copyWith((message) => updates(message as CustomerNote))
          as CustomerNote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomerNote create() => CustomerNote._();
  @$core.override
  CustomerNote createEmptyInstance() => create();
  static $pb.PbList<CustomerNote> createRepeated() =>
      $pb.PbList<CustomerNote>();
  @$core.pragma('dart2js:noInline')
  static CustomerNote getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomerNote>(create);
  static CustomerNote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCustomerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessId => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBusinessId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdBy => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdBy($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedBy() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedBy() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);
}

class CustomerStatementEntry extends $pb.GeneratedMessage {
  factory CustomerStatementEntry({
    $core.String? id,
    $core.String? type,
    $core.String? reference,
    $core.String? description,
    $fixnum.Int64? amount,
    $fixnum.Int64? balance,
    $1.Timestamp? date,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (reference != null) result.reference = reference;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (balance != null) result.balance = balance;
    if (date != null) result.date = date;
    return result;
  }

  CustomerStatementEntry._();

  factory CustomerStatementEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CustomerStatementEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomerStatementEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aInt64(6, _omitFieldNames ? '' : 'balance')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerStatementEntry clone() =>
      CustomerStatementEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerStatementEntry copyWith(
          void Function(CustomerStatementEntry) updates) =>
      super.copyWith((message) => updates(message as CustomerStatementEntry))
          as CustomerStatementEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomerStatementEntry create() => CustomerStatementEntry._();
  @$core.override
  CustomerStatementEntry createEmptyInstance() => create();
  static $pb.PbList<CustomerStatementEntry> createRepeated() =>
      $pb.PbList<CustomerStatementEntry>();
  @$core.pragma('dart2js:noInline')
  static CustomerStatementEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomerStatementEntry>(create);
  static CustomerStatementEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get balance => $_getI64(5);
  @$pb.TagNumber(6)
  set balance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get date => $_getN(6);
  @$pb.TagNumber(7)
  set date($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDate() => $_ensure(6);
}

class CustomerSummary extends $pb.GeneratedMessage {
  factory CustomerSummary({
    $core.int? totalCustomers,
    $core.int? activeCustomers,
    $core.int? vipCustomers,
    $core.int? overdueCustomers,
    $fixnum.Int64? totalOutstanding,
    $fixnum.Int64? totalRevenue,
  }) {
    final result = create();
    if (totalCustomers != null) result.totalCustomers = totalCustomers;
    if (activeCustomers != null) result.activeCustomers = activeCustomers;
    if (vipCustomers != null) result.vipCustomers = vipCustomers;
    if (overdueCustomers != null) result.overdueCustomers = overdueCustomers;
    if (totalOutstanding != null) result.totalOutstanding = totalOutstanding;
    if (totalRevenue != null) result.totalRevenue = totalRevenue;
    return result;
  }

  CustomerSummary._();

  factory CustomerSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CustomerSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CustomerSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalCustomers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'activeCustomers', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'vipCustomers', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'overdueCustomers', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'totalOutstanding')
    ..aInt64(6, _omitFieldNames ? '' : 'totalRevenue')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerSummary clone() => CustomerSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CustomerSummary copyWith(void Function(CustomerSummary) updates) =>
      super.copyWith((message) => updates(message as CustomerSummary))
          as CustomerSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomerSummary create() => CustomerSummary._();
  @$core.override
  CustomerSummary createEmptyInstance() => create();
  static $pb.PbList<CustomerSummary> createRepeated() =>
      $pb.PbList<CustomerSummary>();
  @$core.pragma('dart2js:noInline')
  static CustomerSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CustomerSummary>(create);
  static CustomerSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalCustomers => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalCustomers($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalCustomers() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalCustomers() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeCustomers => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeCustomers($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveCustomers() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveCustomers() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get vipCustomers => $_getIZ(2);
  @$pb.TagNumber(3)
  set vipCustomers($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVipCustomers() => $_has(2);
  @$pb.TagNumber(3)
  void clearVipCustomers() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get overdueCustomers => $_getIZ(3);
  @$pb.TagNumber(4)
  set overdueCustomers($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOverdueCustomers() => $_has(3);
  @$pb.TagNumber(4)
  void clearOverdueCustomers() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalOutstanding => $_getI64(4);
  @$pb.TagNumber(5)
  set totalOutstanding($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalOutstanding() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalOutstanding() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalRevenue => $_getI64(5);
  @$pb.TagNumber(6)
  set totalRevenue($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalRevenue() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalRevenue() => $_clearField(6);
}

class CreateCustomerRequest extends $pb.GeneratedMessage {
  factory CreateCustomerRequest({
    $core.String? name,
    $core.String? businessName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    $core.String? city,
    $core.String? state,
    $core.String? country,
    $core.String? tin,
    $core.String? bankAccountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    CustomerSegment? segment,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (businessName != null) result.businessName = businessName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    if (city != null) result.city = city;
    if (state != null) result.state = state;
    if (country != null) result.country = country;
    if (tin != null) result.tin = tin;
    if (bankAccountNumber != null) result.bankAccountNumber = bankAccountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (segment != null) result.segment = segment;
    if (tags != null) result.tags.addAll(tags);
    if (notes != null) result.notes = notes;
    return result;
  }

  CreateCustomerRequest._();

  factory CreateCustomerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCustomerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCustomerRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'businessName')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'phone')
    ..aOS(5, _omitFieldNames ? '' : 'address')
    ..aOS(6, _omitFieldNames ? '' : 'city')
    ..aOS(7, _omitFieldNames ? '' : 'state')
    ..aOS(8, _omitFieldNames ? '' : 'country')
    ..aOS(9, _omitFieldNames ? '' : 'tin')
    ..aOS(10, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(11, _omitFieldNames ? '' : 'bankCode')
    ..aOS(12, _omitFieldNames ? '' : 'bankName')
    ..e<CustomerSegment>(
        13, _omitFieldNames ? '' : 'segment', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE,
        valueOf: CustomerSegment.valueOf,
        enumValues: CustomerSegment.values)
    ..pPS(14, _omitFieldNames ? '' : 'tags')
    ..aOS(15, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomerRequest clone() =>
      CreateCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomerRequest copyWith(
          void Function(CreateCustomerRequest) updates) =>
      super.copyWith((message) => updates(message as CreateCustomerRequest))
          as CreateCustomerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCustomerRequest create() => CreateCustomerRequest._();
  @$core.override
  CreateCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCustomerRequest> createRepeated() =>
      $pb.PbList<CreateCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomerRequest>(create);
  static CreateCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessName => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get address => $_getSZ(4);
  @$pb.TagNumber(5)
  set address($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddress() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get city => $_getSZ(5);
  @$pb.TagNumber(6)
  set city($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get state => $_getSZ(6);
  @$pb.TagNumber(7)
  set state($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasState() => $_has(6);
  @$pb.TagNumber(7)
  void clearState() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get country => $_getSZ(7);
  @$pb.TagNumber(8)
  set country($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountry() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get tin => $_getSZ(8);
  @$pb.TagNumber(9)
  set tin($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTin() => $_has(8);
  @$pb.TagNumber(9)
  void clearTin() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get bankAccountNumber => $_getSZ(9);
  @$pb.TagNumber(10)
  set bankAccountNumber($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBankAccountNumber() => $_has(9);
  @$pb.TagNumber(10)
  void clearBankAccountNumber() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankCode => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankCode($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBankCode() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankCode() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankName => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBankName() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankName() => $_clearField(12);

  @$pb.TagNumber(13)
  CustomerSegment get segment => $_getN(12);
  @$pb.TagNumber(13)
  set segment(CustomerSegment value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasSegment() => $_has(12);
  @$pb.TagNumber(13)
  void clearSegment() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbList<$core.String> get tags => $_getList(13);

  @$pb.TagNumber(15)
  $core.String get notes => $_getSZ(14);
  @$pb.TagNumber(15)
  set notes($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasNotes() => $_has(14);
  @$pb.TagNumber(15)
  void clearNotes() => $_clearField(15);
}

class CreateCustomerResponse extends $pb.GeneratedMessage {
  factory CreateCustomerResponse({
    $core.bool? success,
    $core.String? message,
    Customer? customer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (customer != null) result.customer = customer;
    return result;
  }

  CreateCustomerResponse._();

  factory CreateCustomerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateCustomerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateCustomerResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Customer>(3, _omitFieldNames ? '' : 'customer',
        subBuilder: Customer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomerResponse clone() =>
      CreateCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateCustomerResponse copyWith(
          void Function(CreateCustomerResponse) updates) =>
      super.copyWith((message) => updates(message as CreateCustomerResponse))
          as CreateCustomerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateCustomerResponse create() => CreateCustomerResponse._();
  @$core.override
  CreateCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCustomerResponse> createRepeated() =>
      $pb.PbList<CreateCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateCustomerResponse>(create);
  static CreateCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Customer get customer => $_getN(2);
  @$pb.TagNumber(3)
  set customer(Customer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomer() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomer() => $_clearField(3);
  @$pb.TagNumber(3)
  Customer ensureCustomer() => $_ensure(2);
}

class UpdateCustomerRequest extends $pb.GeneratedMessage {
  factory UpdateCustomerRequest({
    $core.String? customerId,
    $core.String? name,
    $core.String? businessName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    $core.String? city,
    $core.String? state,
    $core.String? country,
    $core.String? tin,
    $core.String? bankAccountNumber,
    $core.String? bankCode,
    $core.String? bankName,
    CustomerSegment? segment,
    CustomerStatus? status,
    $core.Iterable<$core.String>? tags,
    $core.String? notes,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (name != null) result.name = name;
    if (businessName != null) result.businessName = businessName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    if (city != null) result.city = city;
    if (state != null) result.state = state;
    if (country != null) result.country = country;
    if (tin != null) result.tin = tin;
    if (bankAccountNumber != null) result.bankAccountNumber = bankAccountNumber;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (segment != null) result.segment = segment;
    if (status != null) result.status = status;
    if (tags != null) result.tags.addAll(tags);
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdateCustomerRequest._();

  factory UpdateCustomerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCustomerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCustomerRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'businessName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..aOS(6, _omitFieldNames ? '' : 'address')
    ..aOS(7, _omitFieldNames ? '' : 'city')
    ..aOS(8, _omitFieldNames ? '' : 'state')
    ..aOS(9, _omitFieldNames ? '' : 'country')
    ..aOS(10, _omitFieldNames ? '' : 'tin')
    ..aOS(11, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(12, _omitFieldNames ? '' : 'bankCode')
    ..aOS(13, _omitFieldNames ? '' : 'bankName')
    ..e<CustomerSegment>(
        14, _omitFieldNames ? '' : 'segment', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE,
        valueOf: CustomerSegment.valueOf,
        enumValues: CustomerSegment.values)
    ..e<CustomerStatus>(15, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerStatus.CUSTOMER_STATUS_ACTIVE,
        valueOf: CustomerStatus.valueOf,
        enumValues: CustomerStatus.values)
    ..pPS(16, _omitFieldNames ? '' : 'tags')
    ..aOS(17, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomerRequest clone() =>
      UpdateCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomerRequest copyWith(
          void Function(UpdateCustomerRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCustomerRequest))
          as UpdateCustomerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCustomerRequest create() => UpdateCustomerRequest._();
  @$core.override
  UpdateCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCustomerRequest> createRepeated() =>
      $pb.PbList<UpdateCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCustomerRequest>(create);
  static UpdateCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessName => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBusinessName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get address => $_getSZ(5);
  @$pb.TagNumber(6)
  set address($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get city => $_getSZ(6);
  @$pb.TagNumber(7)
  set city($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCity() => $_has(6);
  @$pb.TagNumber(7)
  void clearCity() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get state => $_getSZ(7);
  @$pb.TagNumber(8)
  set state($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasState() => $_has(7);
  @$pb.TagNumber(8)
  void clearState() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get country => $_getSZ(8);
  @$pb.TagNumber(9)
  set country($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCountry() => $_has(8);
  @$pb.TagNumber(9)
  void clearCountry() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get tin => $_getSZ(9);
  @$pb.TagNumber(10)
  set tin($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTin() => $_has(9);
  @$pb.TagNumber(10)
  void clearTin() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankAccountNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankAccountNumber($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBankAccountNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankAccountNumber() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankCode($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBankCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankCode() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get bankName => $_getSZ(12);
  @$pb.TagNumber(13)
  set bankName($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBankName() => $_has(12);
  @$pb.TagNumber(13)
  void clearBankName() => $_clearField(13);

  @$pb.TagNumber(14)
  CustomerSegment get segment => $_getN(13);
  @$pb.TagNumber(14)
  set segment(CustomerSegment value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasSegment() => $_has(13);
  @$pb.TagNumber(14)
  void clearSegment() => $_clearField(14);

  @$pb.TagNumber(15)
  CustomerStatus get status => $_getN(14);
  @$pb.TagNumber(15)
  set status(CustomerStatus value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => $_clearField(15);

  @$pb.TagNumber(16)
  $pb.PbList<$core.String> get tags => $_getList(15);

  @$pb.TagNumber(17)
  $core.String get notes => $_getSZ(16);
  @$pb.TagNumber(17)
  set notes($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasNotes() => $_has(16);
  @$pb.TagNumber(17)
  void clearNotes() => $_clearField(17);
}

class UpdateCustomerResponse extends $pb.GeneratedMessage {
  factory UpdateCustomerResponse({
    $core.bool? success,
    $core.String? message,
    Customer? customer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (customer != null) result.customer = customer;
    return result;
  }

  UpdateCustomerResponse._();

  factory UpdateCustomerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCustomerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCustomerResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Customer>(3, _omitFieldNames ? '' : 'customer',
        subBuilder: Customer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomerResponse clone() =>
      UpdateCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCustomerResponse copyWith(
          void Function(UpdateCustomerResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateCustomerResponse))
          as UpdateCustomerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCustomerResponse create() => UpdateCustomerResponse._();
  @$core.override
  UpdateCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCustomerResponse> createRepeated() =>
      $pb.PbList<UpdateCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateCustomerResponse>(create);
  static UpdateCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Customer get customer => $_getN(2);
  @$pb.TagNumber(3)
  set customer(Customer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomer() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomer() => $_clearField(3);
  @$pb.TagNumber(3)
  Customer ensureCustomer() => $_ensure(2);
}

class DeleteCustomerRequest extends $pb.GeneratedMessage {
  factory DeleteCustomerRequest({
    $core.String? customerId,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    return result;
  }

  DeleteCustomerRequest._();

  factory DeleteCustomerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCustomerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCustomerRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomerRequest clone() =>
      DeleteCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomerRequest copyWith(
          void Function(DeleteCustomerRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteCustomerRequest))
          as DeleteCustomerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCustomerRequest create() => DeleteCustomerRequest._();
  @$core.override
  DeleteCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomerRequest> createRepeated() =>
      $pb.PbList<DeleteCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCustomerRequest>(create);
  static DeleteCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);
}

class DeleteCustomerResponse extends $pb.GeneratedMessage {
  factory DeleteCustomerResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteCustomerResponse._();

  factory DeleteCustomerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteCustomerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteCustomerResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomerResponse clone() =>
      DeleteCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteCustomerResponse copyWith(
          void Function(DeleteCustomerResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteCustomerResponse))
          as DeleteCustomerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteCustomerResponse create() => DeleteCustomerResponse._();
  @$core.override
  DeleteCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomerResponse> createRepeated() =>
      $pb.PbList<DeleteCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteCustomerResponse>(create);
  static DeleteCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetCustomerRequest extends $pb.GeneratedMessage {
  factory GetCustomerRequest({
    $core.String? customerId,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    return result;
  }

  GetCustomerRequest._();

  factory GetCustomerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerRequest clone() => GetCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerRequest copyWith(void Function(GetCustomerRequest) updates) =>
      super.copyWith((message) => updates(message as GetCustomerRequest))
          as GetCustomerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerRequest create() => GetCustomerRequest._();
  @$core.override
  GetCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerRequest> createRepeated() =>
      $pb.PbList<GetCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerRequest>(create);
  static GetCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);
}

class GetCustomerResponse extends $pb.GeneratedMessage {
  factory GetCustomerResponse({
    $core.bool? success,
    $core.String? message,
    Customer? customer,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (customer != null) result.customer = customer;
    return result;
  }

  GetCustomerResponse._();

  factory GetCustomerResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Customer>(3, _omitFieldNames ? '' : 'customer',
        subBuilder: Customer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerResponse clone() => GetCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerResponse copyWith(void Function(GetCustomerResponse) updates) =>
      super.copyWith((message) => updates(message as GetCustomerResponse))
          as GetCustomerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerResponse create() => GetCustomerResponse._();
  @$core.override
  GetCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerResponse> createRepeated() =>
      $pb.PbList<GetCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerResponse>(create);
  static GetCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Customer get customer => $_getN(2);
  @$pb.TagNumber(3)
  set customer(Customer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCustomer() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomer() => $_clearField(3);
  @$pb.TagNumber(3)
  Customer ensureCustomer() => $_ensure(2);
}

class ListCustomersRequest extends $pb.GeneratedMessage {
  factory ListCustomersRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? search,
    CustomerSegment? segment,
    CustomerStatus? status,
    $core.String? tag,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (search != null) result.search = search;
    if (segment != null) result.segment = segment;
    if (status != null) result.status = status;
    if (tag != null) result.tag = tag;
    return result;
  }

  ListCustomersRequest._();

  factory ListCustomersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCustomersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCustomersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'search')
    ..e<CustomerSegment>(
        4, _omitFieldNames ? '' : 'segment', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE,
        valueOf: CustomerSegment.valueOf,
        enumValues: CustomerSegment.values)
    ..e<CustomerStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: CustomerStatus.CUSTOMER_STATUS_ACTIVE,
        valueOf: CustomerStatus.valueOf,
        enumValues: CustomerStatus.values)
    ..aOS(6, _omitFieldNames ? '' : 'tag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomersRequest clone() =>
      ListCustomersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomersRequest copyWith(void Function(ListCustomersRequest) updates) =>
      super.copyWith((message) => updates(message as ListCustomersRequest))
          as ListCustomersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCustomersRequest create() => ListCustomersRequest._();
  @$core.override
  ListCustomersRequest createEmptyInstance() => create();
  static $pb.PbList<ListCustomersRequest> createRepeated() =>
      $pb.PbList<ListCustomersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCustomersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCustomersRequest>(create);
  static ListCustomersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => $_clearField(3);

  @$pb.TagNumber(4)
  CustomerSegment get segment => $_getN(3);
  @$pb.TagNumber(4)
  set segment(CustomerSegment value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSegment() => $_has(3);
  @$pb.TagNumber(4)
  void clearSegment() => $_clearField(4);

  @$pb.TagNumber(5)
  CustomerStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(CustomerStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get tag => $_getSZ(5);
  @$pb.TagNumber(6)
  set tag($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTag() => $_has(5);
  @$pb.TagNumber(6)
  void clearTag() => $_clearField(6);
}

class ListCustomersResponse extends $pb.GeneratedMessage {
  factory ListCustomersResponse({
    $core.Iterable<Customer>? customers,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (customers != null) result.customers.addAll(customers);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListCustomersResponse._();

  factory ListCustomersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCustomersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCustomersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Customer>(1, _omitFieldNames ? '' : 'customers', $pb.PbFieldType.PM,
        subBuilder: Customer.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomersResponse clone() =>
      ListCustomersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomersResponse copyWith(
          void Function(ListCustomersResponse) updates) =>
      super.copyWith((message) => updates(message as ListCustomersResponse))
          as ListCustomersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCustomersResponse create() => ListCustomersResponse._();
  @$core.override
  ListCustomersResponse createEmptyInstance() => create();
  static $pb.PbList<ListCustomersResponse> createRepeated() =>
      $pb.PbList<ListCustomersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCustomersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCustomersResponse>(create);
  static ListCustomersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Customer> get customers => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetCustomerFinancialProfileRequest extends $pb.GeneratedMessage {
  factory GetCustomerFinancialProfileRequest({
    $core.String? customerId,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    return result;
  }

  GetCustomerFinancialProfileRequest._();

  factory GetCustomerFinancialProfileRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerFinancialProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerFinancialProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerFinancialProfileRequest clone() =>
      GetCustomerFinancialProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerFinancialProfileRequest copyWith(
          void Function(GetCustomerFinancialProfileRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetCustomerFinancialProfileRequest))
          as GetCustomerFinancialProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileRequest create() =>
      GetCustomerFinancialProfileRequest._();
  @$core.override
  GetCustomerFinancialProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerFinancialProfileRequest> createRepeated() =>
      $pb.PbList<GetCustomerFinancialProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerFinancialProfileRequest>(
          create);
  static GetCustomerFinancialProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);
}

class GetCustomerFinancialProfileResponse extends $pb.GeneratedMessage {
  factory GetCustomerFinancialProfileResponse({
    $core.bool? success,
    $core.String? message,
    CustomerFinancialProfile? profile,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (profile != null) result.profile = profile;
    return result;
  }

  GetCustomerFinancialProfileResponse._();

  factory GetCustomerFinancialProfileResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerFinancialProfileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerFinancialProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<CustomerFinancialProfile>(3, _omitFieldNames ? '' : 'profile',
        subBuilder: CustomerFinancialProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerFinancialProfileResponse clone() =>
      GetCustomerFinancialProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerFinancialProfileResponse copyWith(
          void Function(GetCustomerFinancialProfileResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetCustomerFinancialProfileResponse))
          as GetCustomerFinancialProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileResponse create() =>
      GetCustomerFinancialProfileResponse._();
  @$core.override
  GetCustomerFinancialProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerFinancialProfileResponse> createRepeated() =>
      $pb.PbList<GetCustomerFinancialProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetCustomerFinancialProfileResponse>(create);
  static GetCustomerFinancialProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  CustomerFinancialProfile get profile => $_getN(2);
  @$pb.TagNumber(3)
  set profile(CustomerFinancialProfile value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProfile() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfile() => $_clearField(3);
  @$pb.TagNumber(3)
  CustomerFinancialProfile ensureProfile() => $_ensure(2);
}

class GetCustomerSummaryRequest extends $pb.GeneratedMessage {
  factory GetCustomerSummaryRequest() => create();

  GetCustomerSummaryRequest._();

  factory GetCustomerSummaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerSummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerSummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerSummaryRequest clone() =>
      GetCustomerSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerSummaryRequest copyWith(
          void Function(GetCustomerSummaryRequest) updates) =>
      super.copyWith((message) => updates(message as GetCustomerSummaryRequest))
          as GetCustomerSummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryRequest create() => GetCustomerSummaryRequest._();
  @$core.override
  GetCustomerSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerSummaryRequest> createRepeated() =>
      $pb.PbList<GetCustomerSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerSummaryRequest>(create);
  static GetCustomerSummaryRequest? _defaultInstance;
}

class GetCustomerSummaryResponse extends $pb.GeneratedMessage {
  factory GetCustomerSummaryResponse({
    $core.bool? success,
    $core.String? message,
    CustomerSummary? summary,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (summary != null) result.summary = summary;
    return result;
  }

  GetCustomerSummaryResponse._();

  factory GetCustomerSummaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerSummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerSummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<CustomerSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: CustomerSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerSummaryResponse clone() =>
      GetCustomerSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerSummaryResponse copyWith(
          void Function(GetCustomerSummaryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomerSummaryResponse))
          as GetCustomerSummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryResponse create() => GetCustomerSummaryResponse._();
  @$core.override
  GetCustomerSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerSummaryResponse> createRepeated() =>
      $pb.PbList<GetCustomerSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerSummaryResponse>(create);
  static GetCustomerSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  CustomerSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(CustomerSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  CustomerSummary ensureSummary() => $_ensure(2);
}

class AddCustomerNoteRequest extends $pb.GeneratedMessage {
  factory AddCustomerNoteRequest({
    $core.String? customerId,
    $core.String? content,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (content != null) result.content = content;
    return result;
  }

  AddCustomerNoteRequest._();

  factory AddCustomerNoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddCustomerNoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddCustomerNoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCustomerNoteRequest clone() =>
      AddCustomerNoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCustomerNoteRequest copyWith(
          void Function(AddCustomerNoteRequest) updates) =>
      super.copyWith((message) => updates(message as AddCustomerNoteRequest))
          as AddCustomerNoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteRequest create() => AddCustomerNoteRequest._();
  @$core.override
  AddCustomerNoteRequest createEmptyInstance() => create();
  static $pb.PbList<AddCustomerNoteRequest> createRepeated() =>
      $pb.PbList<AddCustomerNoteRequest>();
  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddCustomerNoteRequest>(create);
  static AddCustomerNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => $_clearField(2);
}

class AddCustomerNoteResponse extends $pb.GeneratedMessage {
  factory AddCustomerNoteResponse({
    $core.bool? success,
    $core.String? message,
    CustomerNote? note,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (note != null) result.note = note;
    return result;
  }

  AddCustomerNoteResponse._();

  factory AddCustomerNoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddCustomerNoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddCustomerNoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<CustomerNote>(3, _omitFieldNames ? '' : 'note',
        subBuilder: CustomerNote.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCustomerNoteResponse clone() =>
      AddCustomerNoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddCustomerNoteResponse copyWith(
          void Function(AddCustomerNoteResponse) updates) =>
      super.copyWith((message) => updates(message as AddCustomerNoteResponse))
          as AddCustomerNoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteResponse create() => AddCustomerNoteResponse._();
  @$core.override
  AddCustomerNoteResponse createEmptyInstance() => create();
  static $pb.PbList<AddCustomerNoteResponse> createRepeated() =>
      $pb.PbList<AddCustomerNoteResponse>();
  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddCustomerNoteResponse>(create);
  static AddCustomerNoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  CustomerNote get note => $_getN(2);
  @$pb.TagNumber(3)
  set note(CustomerNote value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => $_clearField(3);
  @$pb.TagNumber(3)
  CustomerNote ensureNote() => $_ensure(2);
}

class ListCustomerNotesRequest extends $pb.GeneratedMessage {
  factory ListCustomerNotesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListCustomerNotesRequest._();

  factory ListCustomerNotesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCustomerNotesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCustomerNotesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomerNotesRequest clone() =>
      ListCustomerNotesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomerNotesRequest copyWith(
          void Function(ListCustomerNotesRequest) updates) =>
      super.copyWith((message) => updates(message as ListCustomerNotesRequest))
          as ListCustomerNotesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesRequest create() => ListCustomerNotesRequest._();
  @$core.override
  ListCustomerNotesRequest createEmptyInstance() => create();
  static $pb.PbList<ListCustomerNotesRequest> createRepeated() =>
      $pb.PbList<ListCustomerNotesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCustomerNotesRequest>(create);
  static ListCustomerNotesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class ListCustomerNotesResponse extends $pb.GeneratedMessage {
  factory ListCustomerNotesResponse({
    $core.Iterable<CustomerNote>? notes,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (notes != null) result.notes.addAll(notes);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListCustomerNotesResponse._();

  factory ListCustomerNotesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListCustomerNotesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListCustomerNotesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<CustomerNote>(1, _omitFieldNames ? '' : 'notes', $pb.PbFieldType.PM,
        subBuilder: CustomerNote.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomerNotesResponse clone() =>
      ListCustomerNotesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListCustomerNotesResponse copyWith(
          void Function(ListCustomerNotesResponse) updates) =>
      super.copyWith((message) => updates(message as ListCustomerNotesResponse))
          as ListCustomerNotesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesResponse create() => ListCustomerNotesResponse._();
  @$core.override
  ListCustomerNotesResponse createEmptyInstance() => create();
  static $pb.PbList<ListCustomerNotesResponse> createRepeated() =>
      $pb.PbList<ListCustomerNotesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListCustomerNotesResponse>(create);
  static ListCustomerNotesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CustomerNote> get notes => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetCustomerStatementRequest extends $pb.GeneratedMessage {
  factory GetCustomerStatementRequest({
    $core.String? customerId,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetCustomerStatementRequest._();

  factory GetCustomerStatementRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerStatementRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerStatementRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerStatementRequest clone() =>
      GetCustomerStatementRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerStatementRequest copyWith(
          void Function(GetCustomerStatementRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomerStatementRequest))
          as GetCustomerStatementRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementRequest create() =>
      GetCustomerStatementRequest._();
  @$core.override
  GetCustomerStatementRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerStatementRequest> createRepeated() =>
      $pb.PbList<GetCustomerStatementRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerStatementRequest>(create);
  static GetCustomerStatementRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get endDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set endDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => $_clearField(3);
}

class GetCustomerStatementResponse extends $pb.GeneratedMessage {
  factory GetCustomerStatementResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<CustomerStatementEntry>? entries,
    $fixnum.Int64? openingBalance,
    $fixnum.Int64? closingBalance,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (entries != null) result.entries.addAll(entries);
    if (openingBalance != null) result.openingBalance = openingBalance;
    if (closingBalance != null) result.closingBalance = closingBalance;
    return result;
  }

  GetCustomerStatementResponse._();

  factory GetCustomerStatementResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCustomerStatementResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCustomerStatementResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<CustomerStatementEntry>(
        3, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: CustomerStatementEntry.create)
    ..aInt64(4, _omitFieldNames ? '' : 'openingBalance')
    ..aInt64(5, _omitFieldNames ? '' : 'closingBalance')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerStatementResponse clone() =>
      GetCustomerStatementResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCustomerStatementResponse copyWith(
          void Function(GetCustomerStatementResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCustomerStatementResponse))
          as GetCustomerStatementResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementResponse create() =>
      GetCustomerStatementResponse._();
  @$core.override
  GetCustomerStatementResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerStatementResponse> createRepeated() =>
      $pb.PbList<GetCustomerStatementResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCustomerStatementResponse>(create);
  static GetCustomerStatementResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<CustomerStatementEntry> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get openingBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set openingBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOpeningBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearOpeningBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get closingBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set closingBalance($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasClosingBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearClosingBalance() => $_clearField(5);
}

class TaxObligation extends $pb.GeneratedMessage {
  factory TaxObligation({
    $core.String? id,
    $core.String? businessId,
    TaxType? taxType,
    $core.String? period,
    $fixnum.Int64? amount,
    TaxObligationStatus? status,
    $1.Timestamp? dueDate,
    $1.Timestamp? filedDate,
    $1.Timestamp? paidDate,
    $core.String? reference,
    $core.String? notes,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (taxType != null) result.taxType = taxType;
    if (period != null) result.period = period;
    if (amount != null) result.amount = amount;
    if (status != null) result.status = status;
    if (dueDate != null) result.dueDate = dueDate;
    if (filedDate != null) result.filedDate = filedDate;
    if (paidDate != null) result.paidDate = paidDate;
    if (reference != null) result.reference = reference;
    if (notes != null) result.notes = notes;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  TaxObligation._();

  factory TaxObligation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaxObligation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaxObligation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..e<TaxType>(3, _omitFieldNames ? '' : 'taxType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxType.TAX_TYPE_VAT,
        valueOf: TaxType.valueOf,
        enumValues: TaxType.values)
    ..aOS(4, _omitFieldNames ? '' : 'period')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..e<TaxObligationStatus>(
        6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING,
        valueOf: TaxObligationStatus.valueOf,
        enumValues: TaxObligationStatus.values)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'dueDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'filedDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'paidDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(10, _omitFieldNames ? '' : 'reference')
    ..aOS(11, _omitFieldNames ? '' : 'notes')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxObligation clone() => TaxObligation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxObligation copyWith(void Function(TaxObligation) updates) =>
      super.copyWith((message) => updates(message as TaxObligation))
          as TaxObligation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaxObligation create() => TaxObligation._();
  @$core.override
  TaxObligation createEmptyInstance() => create();
  static $pb.PbList<TaxObligation> createRepeated() =>
      $pb.PbList<TaxObligation>();
  @$core.pragma('dart2js:noInline')
  static TaxObligation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaxObligation>(create);
  static TaxObligation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxType get taxType => $_getN(2);
  @$pb.TagNumber(3)
  set taxType(TaxType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTaxType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaxType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get period => $_getSZ(3);
  @$pb.TagNumber(4)
  set period($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  TaxObligationStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(TaxObligationStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get dueDate => $_getN(6);
  @$pb.TagNumber(7)
  set dueDate($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDueDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDueDate() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDueDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get filedDate => $_getN(7);
  @$pb.TagNumber(8)
  set filedDate($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasFiledDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFiledDate() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureFiledDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get paidDate => $_getN(8);
  @$pb.TagNumber(9)
  set paidDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPaidDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaidDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensurePaidDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(9);
  @$pb.TagNumber(10)
  set reference($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearReference() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $1.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureUpdatedAt() => $_ensure(12);
}

class TaxCalendarEvent extends $pb.GeneratedMessage {
  factory TaxCalendarEvent({
    TaxType? taxType,
    $core.String? description,
    $1.Timestamp? dueDate,
    $core.bool? isFiled,
    $core.bool? isPaid,
    $core.String? period,
  }) {
    final result = create();
    if (taxType != null) result.taxType = taxType;
    if (description != null) result.description = description;
    if (dueDate != null) result.dueDate = dueDate;
    if (isFiled != null) result.isFiled = isFiled;
    if (isPaid != null) result.isPaid = isPaid;
    if (period != null) result.period = period;
    return result;
  }

  TaxCalendarEvent._();

  factory TaxCalendarEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaxCalendarEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaxCalendarEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<TaxType>(1, _omitFieldNames ? '' : 'taxType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxType.TAX_TYPE_VAT,
        valueOf: TaxType.valueOf,
        enumValues: TaxType.values)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'dueDate',
        subBuilder: $1.Timestamp.create)
    ..aOB(4, _omitFieldNames ? '' : 'isFiled')
    ..aOB(5, _omitFieldNames ? '' : 'isPaid')
    ..aOS(6, _omitFieldNames ? '' : 'period')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxCalendarEvent clone() => TaxCalendarEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxCalendarEvent copyWith(void Function(TaxCalendarEvent) updates) =>
      super.copyWith((message) => updates(message as TaxCalendarEvent))
          as TaxCalendarEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaxCalendarEvent create() => TaxCalendarEvent._();
  @$core.override
  TaxCalendarEvent createEmptyInstance() => create();
  static $pb.PbList<TaxCalendarEvent> createRepeated() =>
      $pb.PbList<TaxCalendarEvent>();
  @$core.pragma('dart2js:noInline')
  static TaxCalendarEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaxCalendarEvent>(create);
  static TaxCalendarEvent? _defaultInstance;

  @$pb.TagNumber(1)
  TaxType get taxType => $_getN(0);
  @$pb.TagNumber(1)
  set taxType(TaxType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTaxType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTaxType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get dueDate => $_getN(2);
  @$pb.TagNumber(3)
  set dueDate($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDueDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDueDate() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDueDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get isFiled => $_getBF(3);
  @$pb.TagNumber(4)
  set isFiled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsFiled() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsFiled() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isPaid => $_getBF(4);
  @$pb.TagNumber(5)
  set isPaid($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsPaid() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPaid() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get period => $_getSZ(5);
  @$pb.TagNumber(6)
  set period($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPeriod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPeriod() => $_clearField(6);
}

class TaxDocument extends $pb.GeneratedMessage {
  factory TaxDocument({
    $core.String? id,
    $core.String? businessId,
    TaxDocumentType? documentType,
    $core.String? name,
    $core.String? fileUrl,
    $1.Timestamp? expiryDate,
    $core.String? notes,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (documentType != null) result.documentType = documentType;
    if (name != null) result.name = name;
    if (fileUrl != null) result.fileUrl = fileUrl;
    if (expiryDate != null) result.expiryDate = expiryDate;
    if (notes != null) result.notes = notes;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  TaxDocument._();

  factory TaxDocument.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaxDocument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaxDocument',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..e<TaxDocumentType>(
        3, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT,
        valueOf: TaxDocumentType.valueOf,
        enumValues: TaxDocumentType.values)
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'fileUrl')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'expiryDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(7, _omitFieldNames ? '' : 'notes')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxDocument clone() => TaxDocument()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxDocument copyWith(void Function(TaxDocument) updates) =>
      super.copyWith((message) => updates(message as TaxDocument))
          as TaxDocument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaxDocument create() => TaxDocument._();
  @$core.override
  TaxDocument createEmptyInstance() => create();
  static $pb.PbList<TaxDocument> createRepeated() => $pb.PbList<TaxDocument>();
  @$core.pragma('dart2js:noInline')
  static TaxDocument getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaxDocument>(create);
  static TaxDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxDocumentType get documentType => $_getN(2);
  @$pb.TagNumber(3)
  set documentType(TaxDocumentType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFileUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get expiryDate => $_getN(5);
  @$pb.TagNumber(6)
  set expiryDate($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasExpiryDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiryDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureExpiryDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get notes => $_getSZ(6);
  @$pb.TagNumber(7)
  set notes($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNotes() => $_has(6);
  @$pb.TagNumber(7)
  void clearNotes() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);
}

class VATEntry extends $pb.GeneratedMessage {
  factory VATEntry({
    $core.String? id,
    $core.String? businessId,
    $core.String? description,
    $fixnum.Int64? baseAmount,
    $fixnum.Int64? vatAmount,
    VATDirection? direction,
    $core.String? invoiceReference,
    $core.String? period,
    $1.Timestamp? transactionDate,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (description != null) result.description = description;
    if (baseAmount != null) result.baseAmount = baseAmount;
    if (vatAmount != null) result.vatAmount = vatAmount;
    if (direction != null) result.direction = direction;
    if (invoiceReference != null) result.invoiceReference = invoiceReference;
    if (period != null) result.period = period;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  VATEntry._();

  factory VATEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VATEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VATEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aInt64(4, _omitFieldNames ? '' : 'baseAmount')
    ..aInt64(5, _omitFieldNames ? '' : 'vatAmount')
    ..e<VATDirection>(6, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE,
        defaultOrMaker: VATDirection.VAT_DIRECTION_OUTPUT,
        valueOf: VATDirection.valueOf,
        enumValues: VATDirection.values)
    ..aOS(7, _omitFieldNames ? '' : 'invoiceReference')
    ..aOS(8, _omitFieldNames ? '' : 'period')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VATEntry clone() => VATEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VATEntry copyWith(void Function(VATEntry) updates) =>
      super.copyWith((message) => updates(message as VATEntry)) as VATEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VATEntry create() => VATEntry._();
  @$core.override
  VATEntry createEmptyInstance() => create();
  static $pb.PbList<VATEntry> createRepeated() => $pb.PbList<VATEntry>();
  @$core.pragma('dart2js:noInline')
  static VATEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VATEntry>(create);
  static VATEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get baseAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set baseAmount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBaseAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearBaseAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get vatAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set vatAmount($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVatAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearVatAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  VATDirection get direction => $_getN(5);
  @$pb.TagNumber(6)
  set direction(VATDirection value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDirection() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirection() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get invoiceReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set invoiceReference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasInvoiceReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearInvoiceReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get period => $_getSZ(7);
  @$pb.TagNumber(8)
  set period($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPeriod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriod() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);
}

class WHTEntry extends $pb.GeneratedMessage {
  factory WHTEntry({
    $core.String? id,
    $core.String? businessId,
    $core.String? vendorName,
    $fixnum.Int64? paymentAmount,
    $core.double? whtRate,
    $fixnum.Int64? whtAmount,
    $core.String? paymentReference,
    $core.String? period,
    $1.Timestamp? transactionDate,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (vendorName != null) result.vendorName = vendorName;
    if (paymentAmount != null) result.paymentAmount = paymentAmount;
    if (whtRate != null) result.whtRate = whtRate;
    if (whtAmount != null) result.whtAmount = whtAmount;
    if (paymentReference != null) result.paymentReference = paymentReference;
    if (period != null) result.period = period;
    if (transactionDate != null) result.transactionDate = transactionDate;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  WHTEntry._();

  factory WHTEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WHTEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WHTEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'vendorName')
    ..aInt64(4, _omitFieldNames ? '' : 'paymentAmount')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'whtRate', $pb.PbFieldType.OD)
    ..aInt64(6, _omitFieldNames ? '' : 'whtAmount')
    ..aOS(7, _omitFieldNames ? '' : 'paymentReference')
    ..aOS(8, _omitFieldNames ? '' : 'period')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'transactionDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WHTEntry clone() => WHTEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WHTEntry copyWith(void Function(WHTEntry) updates) =>
      super.copyWith((message) => updates(message as WHTEntry)) as WHTEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WHTEntry create() => WHTEntry._();
  @$core.override
  WHTEntry createEmptyInstance() => create();
  static $pb.PbList<WHTEntry> createRepeated() => $pb.PbList<WHTEntry>();
  @$core.pragma('dart2js:noInline')
  static WHTEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WHTEntry>(create);
  static WHTEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get vendorName => $_getSZ(2);
  @$pb.TagNumber(3)
  set vendorName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVendorName() => $_has(2);
  @$pb.TagNumber(3)
  void clearVendorName() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get paymentAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set paymentAmount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get whtRate => $_getN(4);
  @$pb.TagNumber(5)
  set whtRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWhtRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearWhtRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get whtAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set whtAmount($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasWhtAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearWhtAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentReference($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentReference() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get period => $_getSZ(7);
  @$pb.TagNumber(8)
  set period($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPeriod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriod() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);
}

class TaxDashboardSummary extends $pb.GeneratedMessage {
  factory TaxDashboardSummary({
    $fixnum.Int64? vatDue,
    $fixnum.Int64? payeDue,
    $fixnum.Int64? whtDue,
    $fixnum.Int64? citEstimated,
    $core.int? pendingObligations,
    $core.int? overdueObligations,
    $core.Iterable<TaxCalendarEvent>? upcomingDeadlines,
  }) {
    final result = create();
    if (vatDue != null) result.vatDue = vatDue;
    if (payeDue != null) result.payeDue = payeDue;
    if (whtDue != null) result.whtDue = whtDue;
    if (citEstimated != null) result.citEstimated = citEstimated;
    if (pendingObligations != null)
      result.pendingObligations = pendingObligations;
    if (overdueObligations != null)
      result.overdueObligations = overdueObligations;
    if (upcomingDeadlines != null)
      result.upcomingDeadlines.addAll(upcomingDeadlines);
    return result;
  }

  TaxDashboardSummary._();

  factory TaxDashboardSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TaxDashboardSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TaxDashboardSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'vatDue')
    ..aInt64(2, _omitFieldNames ? '' : 'payeDue')
    ..aInt64(3, _omitFieldNames ? '' : 'whtDue')
    ..aInt64(4, _omitFieldNames ? '' : 'citEstimated')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'pendingObligations', $pb.PbFieldType.O3)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'overdueObligations', $pb.PbFieldType.O3)
    ..pc<TaxCalendarEvent>(
        7, _omitFieldNames ? '' : 'upcomingDeadlines', $pb.PbFieldType.PM,
        subBuilder: TaxCalendarEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxDashboardSummary clone() => TaxDashboardSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TaxDashboardSummary copyWith(void Function(TaxDashboardSummary) updates) =>
      super.copyWith((message) => updates(message as TaxDashboardSummary))
          as TaxDashboardSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaxDashboardSummary create() => TaxDashboardSummary._();
  @$core.override
  TaxDashboardSummary createEmptyInstance() => create();
  static $pb.PbList<TaxDashboardSummary> createRepeated() =>
      $pb.PbList<TaxDashboardSummary>();
  @$core.pragma('dart2js:noInline')
  static TaxDashboardSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TaxDashboardSummary>(create);
  static TaxDashboardSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get vatDue => $_getI64(0);
  @$pb.TagNumber(1)
  set vatDue($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVatDue() => $_has(0);
  @$pb.TagNumber(1)
  void clearVatDue() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get payeDue => $_getI64(1);
  @$pb.TagNumber(2)
  set payeDue($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayeDue() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayeDue() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get whtDue => $_getI64(2);
  @$pb.TagNumber(3)
  set whtDue($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWhtDue() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhtDue() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get citEstimated => $_getI64(3);
  @$pb.TagNumber(4)
  set citEstimated($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCitEstimated() => $_has(3);
  @$pb.TagNumber(4)
  void clearCitEstimated() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pendingObligations => $_getIZ(4);
  @$pb.TagNumber(5)
  set pendingObligations($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPendingObligations() => $_has(4);
  @$pb.TagNumber(5)
  void clearPendingObligations() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get overdueObligations => $_getIZ(5);
  @$pb.TagNumber(6)
  set overdueObligations($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOverdueObligations() => $_has(5);
  @$pb.TagNumber(6)
  void clearOverdueObligations() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<TaxCalendarEvent> get upcomingDeadlines => $_getList(6);
}

class GetTaxDashboardRequest extends $pb.GeneratedMessage {
  factory GetTaxDashboardRequest() => create();

  GetTaxDashboardRequest._();

  factory GetTaxDashboardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaxDashboardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaxDashboardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxDashboardRequest clone() =>
      GetTaxDashboardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxDashboardRequest copyWith(
          void Function(GetTaxDashboardRequest) updates) =>
      super.copyWith((message) => updates(message as GetTaxDashboardRequest))
          as GetTaxDashboardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardRequest create() => GetTaxDashboardRequest._();
  @$core.override
  GetTaxDashboardRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaxDashboardRequest> createRepeated() =>
      $pb.PbList<GetTaxDashboardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaxDashboardRequest>(create);
  static GetTaxDashboardRequest? _defaultInstance;
}

class GetTaxDashboardResponse extends $pb.GeneratedMessage {
  factory GetTaxDashboardResponse({
    $core.bool? success,
    $core.String? message,
    TaxDashboardSummary? dashboard,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (dashboard != null) result.dashboard = dashboard;
    return result;
  }

  GetTaxDashboardResponse._();

  factory GetTaxDashboardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaxDashboardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaxDashboardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TaxDashboardSummary>(3, _omitFieldNames ? '' : 'dashboard',
        subBuilder: TaxDashboardSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxDashboardResponse clone() =>
      GetTaxDashboardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxDashboardResponse copyWith(
          void Function(GetTaxDashboardResponse) updates) =>
      super.copyWith((message) => updates(message as GetTaxDashboardResponse))
          as GetTaxDashboardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardResponse create() => GetTaxDashboardResponse._();
  @$core.override
  GetTaxDashboardResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaxDashboardResponse> createRepeated() =>
      $pb.PbList<GetTaxDashboardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaxDashboardResponse>(create);
  static GetTaxDashboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxDashboardSummary get dashboard => $_getN(2);
  @$pb.TagNumber(3)
  set dashboard(TaxDashboardSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDashboard() => $_has(2);
  @$pb.TagNumber(3)
  void clearDashboard() => $_clearField(3);
  @$pb.TagNumber(3)
  TaxDashboardSummary ensureDashboard() => $_ensure(2);
}

class GetTaxCalendarRequest extends $pb.GeneratedMessage {
  factory GetTaxCalendarRequest({
    $core.int? year,
    $core.int? month,
  }) {
    final result = create();
    if (year != null) result.year = year;
    if (month != null) result.month = month;
    return result;
  }

  GetTaxCalendarRequest._();

  factory GetTaxCalendarRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaxCalendarRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaxCalendarRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'month', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxCalendarRequest clone() =>
      GetTaxCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxCalendarRequest copyWith(
          void Function(GetTaxCalendarRequest) updates) =>
      super.copyWith((message) => updates(message as GetTaxCalendarRequest))
          as GetTaxCalendarRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarRequest create() => GetTaxCalendarRequest._();
  @$core.override
  GetTaxCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaxCalendarRequest> createRepeated() =>
      $pb.PbList<GetTaxCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaxCalendarRequest>(create);
  static GetTaxCalendarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => $_clearField(2);
}

class GetTaxCalendarResponse extends $pb.GeneratedMessage {
  factory GetTaxCalendarResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<TaxCalendarEvent>? events,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (events != null) result.events.addAll(events);
    return result;
  }

  GetTaxCalendarResponse._();

  factory GetTaxCalendarResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTaxCalendarResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTaxCalendarResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<TaxCalendarEvent>(
        3, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: TaxCalendarEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxCalendarResponse clone() =>
      GetTaxCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTaxCalendarResponse copyWith(
          void Function(GetTaxCalendarResponse) updates) =>
      super.copyWith((message) => updates(message as GetTaxCalendarResponse))
          as GetTaxCalendarResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarResponse create() => GetTaxCalendarResponse._();
  @$core.override
  GetTaxCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaxCalendarResponse> createRepeated() =>
      $pb.PbList<GetTaxCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTaxCalendarResponse>(create);
  static GetTaxCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<TaxCalendarEvent> get events => $_getList(2);
}

class CreateTaxObligationRequest extends $pb.GeneratedMessage {
  factory CreateTaxObligationRequest({
    TaxType? taxType,
    $core.String? period,
    $fixnum.Int64? amount,
    $core.String? dueDate,
    $core.String? notes,
  }) {
    final result = create();
    if (taxType != null) result.taxType = taxType;
    if (period != null) result.period = period;
    if (amount != null) result.amount = amount;
    if (dueDate != null) result.dueDate = dueDate;
    if (notes != null) result.notes = notes;
    return result;
  }

  CreateTaxObligationRequest._();

  factory CreateTaxObligationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTaxObligationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTaxObligationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<TaxType>(1, _omitFieldNames ? '' : 'taxType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxType.TAX_TYPE_VAT,
        valueOf: TaxType.valueOf,
        enumValues: TaxType.values)
    ..aOS(2, _omitFieldNames ? '' : 'period')
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'dueDate')
    ..aOS(5, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTaxObligationRequest clone() =>
      CreateTaxObligationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTaxObligationRequest copyWith(
          void Function(CreateTaxObligationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateTaxObligationRequest))
          as CreateTaxObligationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationRequest create() => CreateTaxObligationRequest._();
  @$core.override
  CreateTaxObligationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTaxObligationRequest> createRepeated() =>
      $pb.PbList<CreateTaxObligationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTaxObligationRequest>(create);
  static CreateTaxObligationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TaxType get taxType => $_getN(0);
  @$pb.TagNumber(1)
  set taxType(TaxType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTaxType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTaxType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get period => $_getSZ(1);
  @$pb.TagNumber(2)
  set period($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriod() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get dueDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set dueDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDueDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDueDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get notes => $_getSZ(4);
  @$pb.TagNumber(5)
  set notes($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotes() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotes() => $_clearField(5);
}

class CreateTaxObligationResponse extends $pb.GeneratedMessage {
  factory CreateTaxObligationResponse({
    $core.bool? success,
    $core.String? message,
    TaxObligation? obligation,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (obligation != null) result.obligation = obligation;
    return result;
  }

  CreateTaxObligationResponse._();

  factory CreateTaxObligationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTaxObligationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTaxObligationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TaxObligation>(3, _omitFieldNames ? '' : 'obligation',
        subBuilder: TaxObligation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTaxObligationResponse clone() =>
      CreateTaxObligationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTaxObligationResponse copyWith(
          void Function(CreateTaxObligationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateTaxObligationResponse))
          as CreateTaxObligationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationResponse create() =>
      CreateTaxObligationResponse._();
  @$core.override
  CreateTaxObligationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTaxObligationResponse> createRepeated() =>
      $pb.PbList<CreateTaxObligationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTaxObligationResponse>(create);
  static CreateTaxObligationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxObligation get obligation => $_getN(2);
  @$pb.TagNumber(3)
  set obligation(TaxObligation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasObligation() => $_has(2);
  @$pb.TagNumber(3)
  void clearObligation() => $_clearField(3);
  @$pb.TagNumber(3)
  TaxObligation ensureObligation() => $_ensure(2);
}

class UpdateTaxObligationRequest extends $pb.GeneratedMessage {
  factory UpdateTaxObligationRequest({
    $core.String? obligationId,
    TaxObligationStatus? status,
    $fixnum.Int64? amount,
    $core.String? reference,
    $core.String? notes,
  }) {
    final result = create();
    if (obligationId != null) result.obligationId = obligationId;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (reference != null) result.reference = reference;
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdateTaxObligationRequest._();

  factory UpdateTaxObligationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTaxObligationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTaxObligationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'obligationId')
    ..e<TaxObligationStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING,
        valueOf: TaxObligationStatus.valueOf,
        enumValues: TaxObligationStatus.values)
    ..aInt64(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'reference')
    ..aOS(5, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaxObligationRequest clone() =>
      UpdateTaxObligationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaxObligationRequest copyWith(
          void Function(UpdateTaxObligationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateTaxObligationRequest))
          as UpdateTaxObligationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationRequest create() => UpdateTaxObligationRequest._();
  @$core.override
  UpdateTaxObligationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTaxObligationRequest> createRepeated() =>
      $pb.PbList<UpdateTaxObligationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTaxObligationRequest>(create);
  static UpdateTaxObligationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get obligationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set obligationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasObligationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObligationId() => $_clearField(1);

  @$pb.TagNumber(2)
  TaxObligationStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(TaxObligationStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get notes => $_getSZ(4);
  @$pb.TagNumber(5)
  set notes($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotes() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotes() => $_clearField(5);
}

class UpdateTaxObligationResponse extends $pb.GeneratedMessage {
  factory UpdateTaxObligationResponse({
    $core.bool? success,
    $core.String? message,
    TaxObligation? obligation,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (obligation != null) result.obligation = obligation;
    return result;
  }

  UpdateTaxObligationResponse._();

  factory UpdateTaxObligationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTaxObligationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTaxObligationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TaxObligation>(3, _omitFieldNames ? '' : 'obligation',
        subBuilder: TaxObligation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaxObligationResponse clone() =>
      UpdateTaxObligationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTaxObligationResponse copyWith(
          void Function(UpdateTaxObligationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateTaxObligationResponse))
          as UpdateTaxObligationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationResponse create() =>
      UpdateTaxObligationResponse._();
  @$core.override
  UpdateTaxObligationResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTaxObligationResponse> createRepeated() =>
      $pb.PbList<UpdateTaxObligationResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTaxObligationResponse>(create);
  static UpdateTaxObligationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxObligation get obligation => $_getN(2);
  @$pb.TagNumber(3)
  set obligation(TaxObligation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasObligation() => $_has(2);
  @$pb.TagNumber(3)
  void clearObligation() => $_clearField(3);
  @$pb.TagNumber(3)
  TaxObligation ensureObligation() => $_ensure(2);
}

class ListTaxObligationsRequest extends $pb.GeneratedMessage {
  factory ListTaxObligationsRequest({
    $core.int? page,
    $core.int? limit,
    TaxType? taxType,
    TaxObligationStatus? status,
    $core.int? year,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (taxType != null) result.taxType = taxType;
    if (status != null) result.status = status;
    if (year != null) result.year = year;
    return result;
  }

  ListTaxObligationsRequest._();

  factory ListTaxObligationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTaxObligationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTaxObligationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TaxType>(3, _omitFieldNames ? '' : 'taxType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxType.TAX_TYPE_VAT,
        valueOf: TaxType.valueOf,
        enumValues: TaxType.values)
    ..e<TaxObligationStatus>(
        4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING,
        valueOf: TaxObligationStatus.valueOf,
        enumValues: TaxObligationStatus.values)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxObligationsRequest clone() =>
      ListTaxObligationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxObligationsRequest copyWith(
          void Function(ListTaxObligationsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTaxObligationsRequest))
          as ListTaxObligationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsRequest create() => ListTaxObligationsRequest._();
  @$core.override
  ListTaxObligationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListTaxObligationsRequest> createRepeated() =>
      $pb.PbList<ListTaxObligationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTaxObligationsRequest>(create);
  static ListTaxObligationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxType get taxType => $_getN(2);
  @$pb.TagNumber(3)
  set taxType(TaxType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTaxType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaxType() => $_clearField(3);

  @$pb.TagNumber(4)
  TaxObligationStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(TaxObligationStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get year => $_getIZ(4);
  @$pb.TagNumber(5)
  set year($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYear() => $_has(4);
  @$pb.TagNumber(5)
  void clearYear() => $_clearField(5);
}

class ListTaxObligationsResponse extends $pb.GeneratedMessage {
  factory ListTaxObligationsResponse({
    $core.Iterable<TaxObligation>? obligations,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (obligations != null) result.obligations.addAll(obligations);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListTaxObligationsResponse._();

  factory ListTaxObligationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTaxObligationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTaxObligationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaxObligation>(
        1, _omitFieldNames ? '' : 'obligations', $pb.PbFieldType.PM,
        subBuilder: TaxObligation.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxObligationsResponse clone() =>
      ListTaxObligationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxObligationsResponse copyWith(
          void Function(ListTaxObligationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListTaxObligationsResponse))
          as ListTaxObligationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsResponse create() => ListTaxObligationsResponse._();
  @$core.override
  ListTaxObligationsResponse createEmptyInstance() => create();
  static $pb.PbList<ListTaxObligationsResponse> createRepeated() =>
      $pb.PbList<ListTaxObligationsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTaxObligationsResponse>(create);
  static ListTaxObligationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaxObligation> get obligations => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class UploadTaxDocumentRequest extends $pb.GeneratedMessage {
  factory UploadTaxDocumentRequest({
    TaxDocumentType? documentType,
    $core.String? name,
    $core.String? fileUrl,
    $core.String? expiryDate,
    $core.String? notes,
  }) {
    final result = create();
    if (documentType != null) result.documentType = documentType;
    if (name != null) result.name = name;
    if (fileUrl != null) result.fileUrl = fileUrl;
    if (expiryDate != null) result.expiryDate = expiryDate;
    if (notes != null) result.notes = notes;
    return result;
  }

  UploadTaxDocumentRequest._();

  factory UploadTaxDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadTaxDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadTaxDocumentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..e<TaxDocumentType>(
        1, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT,
        valueOf: TaxDocumentType.valueOf,
        enumValues: TaxDocumentType.values)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'fileUrl')
    ..aOS(4, _omitFieldNames ? '' : 'expiryDate')
    ..aOS(5, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadTaxDocumentRequest clone() =>
      UploadTaxDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadTaxDocumentRequest copyWith(
          void Function(UploadTaxDocumentRequest) updates) =>
      super.copyWith((message) => updates(message as UploadTaxDocumentRequest))
          as UploadTaxDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentRequest create() => UploadTaxDocumentRequest._();
  @$core.override
  UploadTaxDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadTaxDocumentRequest> createRepeated() =>
      $pb.PbList<UploadTaxDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadTaxDocumentRequest>(create);
  static UploadTaxDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TaxDocumentType get documentType => $_getN(0);
  @$pb.TagNumber(1)
  set documentType(TaxDocumentType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFileUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get expiryDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set expiryDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiryDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiryDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get notes => $_getSZ(4);
  @$pb.TagNumber(5)
  set notes($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNotes() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotes() => $_clearField(5);
}

class UploadTaxDocumentResponse extends $pb.GeneratedMessage {
  factory UploadTaxDocumentResponse({
    $core.bool? success,
    $core.String? message,
    TaxDocument? document,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (document != null) result.document = document;
    return result;
  }

  UploadTaxDocumentResponse._();

  factory UploadTaxDocumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadTaxDocumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadTaxDocumentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<TaxDocument>(3, _omitFieldNames ? '' : 'document',
        subBuilder: TaxDocument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadTaxDocumentResponse clone() =>
      UploadTaxDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadTaxDocumentResponse copyWith(
          void Function(UploadTaxDocumentResponse) updates) =>
      super.copyWith((message) => updates(message as UploadTaxDocumentResponse))
          as UploadTaxDocumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentResponse create() => UploadTaxDocumentResponse._();
  @$core.override
  UploadTaxDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadTaxDocumentResponse> createRepeated() =>
      $pb.PbList<UploadTaxDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadTaxDocumentResponse>(create);
  static UploadTaxDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxDocument get document => $_getN(2);
  @$pb.TagNumber(3)
  set document(TaxDocument value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDocument() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocument() => $_clearField(3);
  @$pb.TagNumber(3)
  TaxDocument ensureDocument() => $_ensure(2);
}

class ListTaxDocumentsRequest extends $pb.GeneratedMessage {
  factory ListTaxDocumentsRequest({
    $core.int? page,
    $core.int? limit,
    TaxDocumentType? documentType,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (documentType != null) result.documentType = documentType;
    return result;
  }

  ListTaxDocumentsRequest._();

  factory ListTaxDocumentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTaxDocumentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTaxDocumentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TaxDocumentType>(
        3, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT,
        valueOf: TaxDocumentType.valueOf,
        enumValues: TaxDocumentType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxDocumentsRequest clone() =>
      ListTaxDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxDocumentsRequest copyWith(
          void Function(ListTaxDocumentsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTaxDocumentsRequest))
          as ListTaxDocumentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsRequest create() => ListTaxDocumentsRequest._();
  @$core.override
  ListTaxDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListTaxDocumentsRequest> createRepeated() =>
      $pb.PbList<ListTaxDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTaxDocumentsRequest>(create);
  static ListTaxDocumentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  TaxDocumentType get documentType => $_getN(2);
  @$pb.TagNumber(3)
  set documentType(TaxDocumentType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => $_clearField(3);
}

class ListTaxDocumentsResponse extends $pb.GeneratedMessage {
  factory ListTaxDocumentsResponse({
    $core.Iterable<TaxDocument>? documents,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (documents != null) result.documents.addAll(documents);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListTaxDocumentsResponse._();

  factory ListTaxDocumentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTaxDocumentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTaxDocumentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<TaxDocument>(1, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM,
        subBuilder: TaxDocument.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxDocumentsResponse clone() =>
      ListTaxDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTaxDocumentsResponse copyWith(
          void Function(ListTaxDocumentsResponse) updates) =>
      super.copyWith((message) => updates(message as ListTaxDocumentsResponse))
          as ListTaxDocumentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsResponse create() => ListTaxDocumentsResponse._();
  @$core.override
  ListTaxDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListTaxDocumentsResponse> createRepeated() =>
      $pb.PbList<ListTaxDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTaxDocumentsResponse>(create);
  static ListTaxDocumentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TaxDocument> get documents => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class DeleteTaxDocumentRequest extends $pb.GeneratedMessage {
  factory DeleteTaxDocumentRequest({
    $core.String? documentId,
  }) {
    final result = create();
    if (documentId != null) result.documentId = documentId;
    return result;
  }

  DeleteTaxDocumentRequest._();

  factory DeleteTaxDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteTaxDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTaxDocumentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaxDocumentRequest clone() =>
      DeleteTaxDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaxDocumentRequest copyWith(
          void Function(DeleteTaxDocumentRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteTaxDocumentRequest))
          as DeleteTaxDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentRequest create() => DeleteTaxDocumentRequest._();
  @$core.override
  DeleteTaxDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTaxDocumentRequest> createRepeated() =>
      $pb.PbList<DeleteTaxDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTaxDocumentRequest>(create);
  static DeleteTaxDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => $_clearField(1);
}

class DeleteTaxDocumentResponse extends $pb.GeneratedMessage {
  factory DeleteTaxDocumentResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteTaxDocumentResponse._();

  factory DeleteTaxDocumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteTaxDocumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteTaxDocumentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaxDocumentResponse clone() =>
      DeleteTaxDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteTaxDocumentResponse copyWith(
          void Function(DeleteTaxDocumentResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteTaxDocumentResponse))
          as DeleteTaxDocumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentResponse create() => DeleteTaxDocumentResponse._();
  @$core.override
  DeleteTaxDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteTaxDocumentResponse> createRepeated() =>
      $pb.PbList<DeleteTaxDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteTaxDocumentResponse>(create);
  static DeleteTaxDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetVATScheduleRequest extends $pb.GeneratedMessage {
  factory GetVATScheduleRequest({
    $core.String? period,
  }) {
    final result = create();
    if (period != null) result.period = period;
    return result;
  }

  GetVATScheduleRequest._();

  factory GetVATScheduleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVATScheduleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVATScheduleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'period')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVATScheduleRequest clone() =>
      GetVATScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVATScheduleRequest copyWith(
          void Function(GetVATScheduleRequest) updates) =>
      super.copyWith((message) => updates(message as GetVATScheduleRequest))
          as GetVATScheduleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVATScheduleRequest create() => GetVATScheduleRequest._();
  @$core.override
  GetVATScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<GetVATScheduleRequest> createRepeated() =>
      $pb.PbList<GetVATScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVATScheduleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVATScheduleRequest>(create);
  static GetVATScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);
}

class GetVATScheduleResponse extends $pb.GeneratedMessage {
  factory GetVATScheduleResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<VATEntry>? entries,
    $fixnum.Int64? totalOutputVat,
    $fixnum.Int64? totalInputVat,
    $fixnum.Int64? netVatPayable,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (entries != null) result.entries.addAll(entries);
    if (totalOutputVat != null) result.totalOutputVat = totalOutputVat;
    if (totalInputVat != null) result.totalInputVat = totalInputVat;
    if (netVatPayable != null) result.netVatPayable = netVatPayable;
    return result;
  }

  GetVATScheduleResponse._();

  factory GetVATScheduleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetVATScheduleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVATScheduleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<VATEntry>(3, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: VATEntry.create)
    ..aInt64(4, _omitFieldNames ? '' : 'totalOutputVat')
    ..aInt64(5, _omitFieldNames ? '' : 'totalInputVat')
    ..aInt64(6, _omitFieldNames ? '' : 'netVatPayable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVATScheduleResponse clone() =>
      GetVATScheduleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetVATScheduleResponse copyWith(
          void Function(GetVATScheduleResponse) updates) =>
      super.copyWith((message) => updates(message as GetVATScheduleResponse))
          as GetVATScheduleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVATScheduleResponse create() => GetVATScheduleResponse._();
  @$core.override
  GetVATScheduleResponse createEmptyInstance() => create();
  static $pb.PbList<GetVATScheduleResponse> createRepeated() =>
      $pb.PbList<GetVATScheduleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVATScheduleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVATScheduleResponse>(create);
  static GetVATScheduleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<VATEntry> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalOutputVat => $_getI64(3);
  @$pb.TagNumber(4)
  set totalOutputVat($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalOutputVat() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalOutputVat() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalInputVat => $_getI64(4);
  @$pb.TagNumber(5)
  set totalInputVat($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalInputVat() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalInputVat() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get netVatPayable => $_getI64(5);
  @$pb.TagNumber(6)
  set netVatPayable($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNetVatPayable() => $_has(5);
  @$pb.TagNumber(6)
  void clearNetVatPayable() => $_clearField(6);
}

class RecordVATTransactionRequest extends $pb.GeneratedMessage {
  factory RecordVATTransactionRequest({
    $core.String? description,
    $fixnum.Int64? baseAmount,
    VATDirection? direction,
    $core.String? invoiceReference,
    $core.String? period,
    $core.String? transactionDate,
  }) {
    final result = create();
    if (description != null) result.description = description;
    if (baseAmount != null) result.baseAmount = baseAmount;
    if (direction != null) result.direction = direction;
    if (invoiceReference != null) result.invoiceReference = invoiceReference;
    if (period != null) result.period = period;
    if (transactionDate != null) result.transactionDate = transactionDate;
    return result;
  }

  RecordVATTransactionRequest._();

  factory RecordVATTransactionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordVATTransactionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordVATTransactionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..aInt64(2, _omitFieldNames ? '' : 'baseAmount')
    ..e<VATDirection>(3, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE,
        defaultOrMaker: VATDirection.VAT_DIRECTION_OUTPUT,
        valueOf: VATDirection.valueOf,
        enumValues: VATDirection.values)
    ..aOS(4, _omitFieldNames ? '' : 'invoiceReference')
    ..aOS(5, _omitFieldNames ? '' : 'period')
    ..aOS(6, _omitFieldNames ? '' : 'transactionDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordVATTransactionRequest clone() =>
      RecordVATTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordVATTransactionRequest copyWith(
          void Function(RecordVATTransactionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RecordVATTransactionRequest))
          as RecordVATTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionRequest create() =>
      RecordVATTransactionRequest._();
  @$core.override
  RecordVATTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<RecordVATTransactionRequest> createRepeated() =>
      $pb.PbList<RecordVATTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordVATTransactionRequest>(create);
  static RecordVATTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get baseAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set baseAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBaseAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  VATDirection get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(VATDirection value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get invoiceReference => $_getSZ(3);
  @$pb.TagNumber(4)
  set invoiceReference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInvoiceReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvoiceReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get period => $_getSZ(4);
  @$pb.TagNumber(5)
  set period($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionDate() => $_clearField(6);
}

class RecordVATTransactionResponse extends $pb.GeneratedMessage {
  factory RecordVATTransactionResponse({
    $core.bool? success,
    $core.String? message,
    VATEntry? entry,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (entry != null) result.entry = entry;
    return result;
  }

  RecordVATTransactionResponse._();

  factory RecordVATTransactionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordVATTransactionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordVATTransactionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<VATEntry>(3, _omitFieldNames ? '' : 'entry',
        subBuilder: VATEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordVATTransactionResponse clone() =>
      RecordVATTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordVATTransactionResponse copyWith(
          void Function(RecordVATTransactionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RecordVATTransactionResponse))
          as RecordVATTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionResponse create() =>
      RecordVATTransactionResponse._();
  @$core.override
  RecordVATTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<RecordVATTransactionResponse> createRepeated() =>
      $pb.PbList<RecordVATTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordVATTransactionResponse>(create);
  static RecordVATTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  VATEntry get entry => $_getN(2);
  @$pb.TagNumber(3)
  set entry(VATEntry value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearEntry() => $_clearField(3);
  @$pb.TagNumber(3)
  VATEntry ensureEntry() => $_ensure(2);
}

class GetWHTScheduleRequest extends $pb.GeneratedMessage {
  factory GetWHTScheduleRequest({
    $core.String? period,
  }) {
    final result = create();
    if (period != null) result.period = period;
    return result;
  }

  GetWHTScheduleRequest._();

  factory GetWHTScheduleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWHTScheduleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWHTScheduleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'period')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWHTScheduleRequest clone() =>
      GetWHTScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWHTScheduleRequest copyWith(
          void Function(GetWHTScheduleRequest) updates) =>
      super.copyWith((message) => updates(message as GetWHTScheduleRequest))
          as GetWHTScheduleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleRequest create() => GetWHTScheduleRequest._();
  @$core.override
  GetWHTScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<GetWHTScheduleRequest> createRepeated() =>
      $pb.PbList<GetWHTScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWHTScheduleRequest>(create);
  static GetWHTScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);
}

class GetWHTScheduleResponse extends $pb.GeneratedMessage {
  factory GetWHTScheduleResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<WHTEntry>? entries,
    $fixnum.Int64? totalWhtDeducted,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (entries != null) result.entries.addAll(entries);
    if (totalWhtDeducted != null) result.totalWhtDeducted = totalWhtDeducted;
    return result;
  }

  GetWHTScheduleResponse._();

  factory GetWHTScheduleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWHTScheduleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWHTScheduleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<WHTEntry>(3, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: WHTEntry.create)
    ..aInt64(4, _omitFieldNames ? '' : 'totalWhtDeducted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWHTScheduleResponse clone() =>
      GetWHTScheduleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWHTScheduleResponse copyWith(
          void Function(GetWHTScheduleResponse) updates) =>
      super.copyWith((message) => updates(message as GetWHTScheduleResponse))
          as GetWHTScheduleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleResponse create() => GetWHTScheduleResponse._();
  @$core.override
  GetWHTScheduleResponse createEmptyInstance() => create();
  static $pb.PbList<GetWHTScheduleResponse> createRepeated() =>
      $pb.PbList<GetWHTScheduleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWHTScheduleResponse>(create);
  static GetWHTScheduleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<WHTEntry> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalWhtDeducted => $_getI64(3);
  @$pb.TagNumber(4)
  set totalWhtDeducted($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalWhtDeducted() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalWhtDeducted() => $_clearField(4);
}

class RecordWHTDeductionRequest extends $pb.GeneratedMessage {
  factory RecordWHTDeductionRequest({
    $core.String? vendorName,
    $fixnum.Int64? paymentAmount,
    $core.double? whtRate,
    $core.String? paymentReference,
    $core.String? period,
    $core.String? transactionDate,
  }) {
    final result = create();
    if (vendorName != null) result.vendorName = vendorName;
    if (paymentAmount != null) result.paymentAmount = paymentAmount;
    if (whtRate != null) result.whtRate = whtRate;
    if (paymentReference != null) result.paymentReference = paymentReference;
    if (period != null) result.period = period;
    if (transactionDate != null) result.transactionDate = transactionDate;
    return result;
  }

  RecordWHTDeductionRequest._();

  factory RecordWHTDeductionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordWHTDeductionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordWHTDeductionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vendorName')
    ..aInt64(2, _omitFieldNames ? '' : 'paymentAmount')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'whtRate', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'paymentReference')
    ..aOS(5, _omitFieldNames ? '' : 'period')
    ..aOS(6, _omitFieldNames ? '' : 'transactionDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordWHTDeductionRequest clone() =>
      RecordWHTDeductionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordWHTDeductionRequest copyWith(
          void Function(RecordWHTDeductionRequest) updates) =>
      super.copyWith((message) => updates(message as RecordWHTDeductionRequest))
          as RecordWHTDeductionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionRequest create() => RecordWHTDeductionRequest._();
  @$core.override
  RecordWHTDeductionRequest createEmptyInstance() => create();
  static $pb.PbList<RecordWHTDeductionRequest> createRepeated() =>
      $pb.PbList<RecordWHTDeductionRequest>();
  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordWHTDeductionRequest>(create);
  static RecordWHTDeductionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorName => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVendorName() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorName() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get paymentAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set paymentAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get whtRate => $_getN(2);
  @$pb.TagNumber(3)
  set whtRate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWhtRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhtRate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentReference => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentReference($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentReference() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get period => $_getSZ(4);
  @$pb.TagNumber(5)
  set period($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionDate() => $_clearField(6);
}

class RecordWHTDeductionResponse extends $pb.GeneratedMessage {
  factory RecordWHTDeductionResponse({
    $core.bool? success,
    $core.String? message,
    WHTEntry? entry,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (entry != null) result.entry = entry;
    return result;
  }

  RecordWHTDeductionResponse._();

  factory RecordWHTDeductionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecordWHTDeductionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecordWHTDeductionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<WHTEntry>(3, _omitFieldNames ? '' : 'entry',
        subBuilder: WHTEntry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordWHTDeductionResponse clone() =>
      RecordWHTDeductionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecordWHTDeductionResponse copyWith(
          void Function(RecordWHTDeductionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RecordWHTDeductionResponse))
          as RecordWHTDeductionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionResponse create() => RecordWHTDeductionResponse._();
  @$core.override
  RecordWHTDeductionResponse createEmptyInstance() => create();
  static $pb.PbList<RecordWHTDeductionResponse> createRepeated() =>
      $pb.PbList<RecordWHTDeductionResponse>();
  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecordWHTDeductionResponse>(create);
  static RecordWHTDeductionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  WHTEntry get entry => $_getN(2);
  @$pb.TagNumber(3)
  set entry(WHTEntry value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearEntry() => $_clearField(3);
  @$pb.TagNumber(3)
  WHTEntry ensureEntry() => $_ensure(2);
}

class GetPAYESummaryRequest extends $pb.GeneratedMessage {
  factory GetPAYESummaryRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final result = create();
    if (periodStart != null) result.periodStart = periodStart;
    if (periodEnd != null) result.periodEnd = periodEnd;
    return result;
  }

  GetPAYESummaryRequest._();

  factory GetPAYESummaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPAYESummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPAYESummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodStart')
    ..aOS(2, _omitFieldNames ? '' : 'periodEnd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPAYESummaryRequest clone() =>
      GetPAYESummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPAYESummaryRequest copyWith(
          void Function(GetPAYESummaryRequest) updates) =>
      super.copyWith((message) => updates(message as GetPAYESummaryRequest))
          as GetPAYESummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryRequest create() => GetPAYESummaryRequest._();
  @$core.override
  GetPAYESummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPAYESummaryRequest> createRepeated() =>
      $pb.PbList<GetPAYESummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPAYESummaryRequest>(create);
  static GetPAYESummaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodStart($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodStart() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodEnd($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodEnd() => $_clearField(2);
}

class GetPAYESummaryResponse extends $pb.GeneratedMessage {
  factory GetPAYESummaryResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? totalPaye,
    $core.int? employeeCount,
    $core.Iterable<EmployeeTaxSummary>? employeeSummaries,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (totalPaye != null) result.totalPaye = totalPaye;
    if (employeeCount != null) result.employeeCount = employeeCount;
    if (employeeSummaries != null)
      result.employeeSummaries.addAll(employeeSummaries);
    return result;
  }

  GetPAYESummaryResponse._();

  factory GetPAYESummaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPAYESummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPAYESummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aInt64(3, _omitFieldNames ? '' : 'totalPaye')
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'employeeCount', $pb.PbFieldType.O3)
    ..pc<EmployeeTaxSummary>(
        5, _omitFieldNames ? '' : 'employeeSummaries', $pb.PbFieldType.PM,
        subBuilder: EmployeeTaxSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPAYESummaryResponse clone() =>
      GetPAYESummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPAYESummaryResponse copyWith(
          void Function(GetPAYESummaryResponse) updates) =>
      super.copyWith((message) => updates(message as GetPAYESummaryResponse))
          as GetPAYESummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryResponse create() => GetPAYESummaryResponse._();
  @$core.override
  GetPAYESummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPAYESummaryResponse> createRepeated() =>
      $pb.PbList<GetPAYESummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPAYESummaryResponse>(create);
  static GetPAYESummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalPaye => $_getI64(2);
  @$pb.TagNumber(3)
  set totalPaye($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalPaye() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaye() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get employeeCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set employeeCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmployeeCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmployeeCount() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<EmployeeTaxSummary> get employeeSummaries => $_getList(4);
}

class GetCITEstimationRequest extends $pb.GeneratedMessage {
  factory GetCITEstimationRequest({
    $core.int? year,
  }) {
    final result = create();
    if (year != null) result.year = year;
    return result;
  }

  GetCITEstimationRequest._();

  factory GetCITEstimationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCITEstimationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCITEstimationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCITEstimationRequest clone() =>
      GetCITEstimationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCITEstimationRequest copyWith(
          void Function(GetCITEstimationRequest) updates) =>
      super.copyWith((message) => updates(message as GetCITEstimationRequest))
          as GetCITEstimationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCITEstimationRequest create() => GetCITEstimationRequest._();
  @$core.override
  GetCITEstimationRequest createEmptyInstance() => create();
  static $pb.PbList<GetCITEstimationRequest> createRepeated() =>
      $pb.PbList<GetCITEstimationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCITEstimationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCITEstimationRequest>(create);
  static GetCITEstimationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => $_clearField(1);
}

class GetCITEstimationResponse extends $pb.GeneratedMessage {
  factory GetCITEstimationResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? annualRevenue,
    $fixnum.Int64? annualExpenses,
    $fixnum.Int64? taxableIncome,
    $core.double? citRate,
    $fixnum.Int64? estimatedCit,
    $core.String? taxBand,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (annualRevenue != null) result.annualRevenue = annualRevenue;
    if (annualExpenses != null) result.annualExpenses = annualExpenses;
    if (taxableIncome != null) result.taxableIncome = taxableIncome;
    if (citRate != null) result.citRate = citRate;
    if (estimatedCit != null) result.estimatedCit = estimatedCit;
    if (taxBand != null) result.taxBand = taxBand;
    return result;
  }

  GetCITEstimationResponse._();

  factory GetCITEstimationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCITEstimationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCITEstimationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aInt64(3, _omitFieldNames ? '' : 'annualRevenue')
    ..aInt64(4, _omitFieldNames ? '' : 'annualExpenses')
    ..aInt64(5, _omitFieldNames ? '' : 'taxableIncome')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'citRate', $pb.PbFieldType.OD)
    ..aInt64(7, _omitFieldNames ? '' : 'estimatedCit')
    ..aOS(8, _omitFieldNames ? '' : 'taxBand')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCITEstimationResponse clone() =>
      GetCITEstimationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCITEstimationResponse copyWith(
          void Function(GetCITEstimationResponse) updates) =>
      super.copyWith((message) => updates(message as GetCITEstimationResponse))
          as GetCITEstimationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCITEstimationResponse create() => GetCITEstimationResponse._();
  @$core.override
  GetCITEstimationResponse createEmptyInstance() => create();
  static $pb.PbList<GetCITEstimationResponse> createRepeated() =>
      $pb.PbList<GetCITEstimationResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCITEstimationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCITEstimationResponse>(create);
  static GetCITEstimationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get annualRevenue => $_getI64(2);
  @$pb.TagNumber(3)
  set annualRevenue($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAnnualRevenue() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnnualRevenue() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get annualExpenses => $_getI64(3);
  @$pb.TagNumber(4)
  set annualExpenses($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAnnualExpenses() => $_has(3);
  @$pb.TagNumber(4)
  void clearAnnualExpenses() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get taxableIncome => $_getI64(4);
  @$pb.TagNumber(5)
  set taxableIncome($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTaxableIncome() => $_has(4);
  @$pb.TagNumber(5)
  void clearTaxableIncome() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get citRate => $_getN(5);
  @$pb.TagNumber(6)
  set citRate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCitRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearCitRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get estimatedCit => $_getI64(6);
  @$pb.TagNumber(7)
  set estimatedCit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEstimatedCit() => $_has(6);
  @$pb.TagNumber(7)
  void clearEstimatedCit() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get taxBand => $_getSZ(7);
  @$pb.TagNumber(8)
  set taxBand($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTaxBand() => $_has(7);
  @$pb.TagNumber(8)
  void clearTaxBand() => $_clearField(8);
}

class Supplier extends $pb.GeneratedMessage {
  factory Supplier({
    $core.String? id,
    $core.String? businessId,
    $core.String? name,
    $core.String? contactName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    SupplierStatus? status,
    $core.String? notes,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (name != null) result.name = name;
    if (contactName != null) result.contactName = contactName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    if (status != null) result.status = status;
    if (notes != null) result.notes = notes;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Supplier._();

  factory Supplier.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Supplier.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Supplier',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'contactName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'phone')
    ..aOS(7, _omitFieldNames ? '' : 'address')
    ..e<SupplierStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SupplierStatus.SUPPLIER_STATUS_ACTIVE,
        valueOf: SupplierStatus.valueOf,
        enumValues: SupplierStatus.values)
    ..aOS(9, _omitFieldNames ? '' : 'notes')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Supplier clone() => Supplier()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Supplier copyWith(void Function(Supplier) updates) =>
      super.copyWith((message) => updates(message as Supplier)) as Supplier;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Supplier create() => Supplier._();
  @$core.override
  Supplier createEmptyInstance() => create();
  static $pb.PbList<Supplier> createRepeated() => $pb.PbList<Supplier>();
  @$core.pragma('dart2js:noInline')
  static Supplier getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Supplier>(create);
  static Supplier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get contactName => $_getSZ(3);
  @$pb.TagNumber(4)
  set contactName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContactName() => $_has(3);
  @$pb.TagNumber(4)
  void clearContactName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get address => $_getSZ(6);
  @$pb.TagNumber(7)
  set address($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearAddress() => $_clearField(7);

  @$pb.TagNumber(8)
  SupplierStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(SupplierStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get notes => $_getSZ(8);
  @$pb.TagNumber(9)
  set notes($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasNotes() => $_has(8);
  @$pb.TagNumber(9)
  void clearNotes() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureUpdatedAt() => $_ensure(10);
}

class PurchaseOrder extends $pb.GeneratedMessage {
  factory PurchaseOrder({
    $core.String? id,
    $core.String? businessId,
    $core.String? supplierId,
    $core.String? supplierName,
    PurchaseOrderStatus? status,
    $core.Iterable<PurchaseOrderItem>? items,
    $fixnum.Int64? totalAmount,
    $core.String? notes,
    $core.String? reference,
    $1.Timestamp? expectedDate,
    $1.Timestamp? receivedDate,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (businessId != null) result.businessId = businessId;
    if (supplierId != null) result.supplierId = supplierId;
    if (supplierName != null) result.supplierName = supplierName;
    if (status != null) result.status = status;
    if (items != null) result.items.addAll(items);
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (notes != null) result.notes = notes;
    if (reference != null) result.reference = reference;
    if (expectedDate != null) result.expectedDate = expectedDate;
    if (receivedDate != null) result.receivedDate = receivedDate;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  PurchaseOrder._();

  factory PurchaseOrder.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseOrder.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseOrder',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'supplierId')
    ..aOS(4, _omitFieldNames ? '' : 'supplierName')
    ..e<PurchaseOrderStatus>(
        5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PurchaseOrderStatus.PURCHASE_ORDER_STATUS_DRAFT,
        valueOf: PurchaseOrderStatus.valueOf,
        enumValues: PurchaseOrderStatus.values)
    ..pc<PurchaseOrderItem>(
        6, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: PurchaseOrderItem.create)
    ..aInt64(7, _omitFieldNames ? '' : 'totalAmount')
    ..aOS(8, _omitFieldNames ? '' : 'notes')
    ..aOS(9, _omitFieldNames ? '' : 'reference')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'expectedDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, _omitFieldNames ? '' : 'receivedDate',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseOrder clone() => PurchaseOrder()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseOrder copyWith(void Function(PurchaseOrder) updates) =>
      super.copyWith((message) => updates(message as PurchaseOrder))
          as PurchaseOrder;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseOrder create() => PurchaseOrder._();
  @$core.override
  PurchaseOrder createEmptyInstance() => create();
  static $pb.PbList<PurchaseOrder> createRepeated() =>
      $pb.PbList<PurchaseOrder>();
  @$core.pragma('dart2js:noInline')
  static PurchaseOrder getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseOrder>(create);
  static PurchaseOrder? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get supplierId => $_getSZ(2);
  @$pb.TagNumber(3)
  set supplierId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSupplierId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupplierId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get supplierName => $_getSZ(3);
  @$pb.TagNumber(4)
  set supplierName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSupplierName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSupplierName() => $_clearField(4);

  @$pb.TagNumber(5)
  PurchaseOrderStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(PurchaseOrderStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<PurchaseOrderItem> get items => $_getList(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set totalAmount($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get notes => $_getSZ(7);
  @$pb.TagNumber(8)
  set notes($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNotes() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotes() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get expectedDate => $_getN(9);
  @$pb.TagNumber(10)
  set expectedDate($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExpectedDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpectedDate() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureExpectedDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get receivedDate => $_getN(10);
  @$pb.TagNumber(11)
  set receivedDate($1.Timestamp value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasReceivedDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceivedDate() => $_clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureReceivedDate() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $1.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($1.Timestamp value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureUpdatedAt() => $_ensure(12);
}

class PurchaseOrderItem extends $pb.GeneratedMessage {
  factory PurchaseOrderItem({
    $core.String? itemId,
    $core.String? itemName,
    $core.int? quantityOrdered,
    $core.int? quantityReceived,
    $fixnum.Int64? unitPrice,
    $fixnum.Int64? totalPrice,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (itemName != null) result.itemName = itemName;
    if (quantityOrdered != null) result.quantityOrdered = quantityOrdered;
    if (quantityReceived != null) result.quantityReceived = quantityReceived;
    if (unitPrice != null) result.unitPrice = unitPrice;
    if (totalPrice != null) result.totalPrice = totalPrice;
    return result;
  }

  PurchaseOrderItem._();

  factory PurchaseOrderItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseOrderItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseOrderItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..aOS(2, _omitFieldNames ? '' : 'itemName')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'quantityOrdered', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'quantityReceived', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'unitPrice')
    ..aInt64(6, _omitFieldNames ? '' : 'totalPrice')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseOrderItem clone() => PurchaseOrderItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseOrderItem copyWith(void Function(PurchaseOrderItem) updates) =>
      super.copyWith((message) => updates(message as PurchaseOrderItem))
          as PurchaseOrderItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseOrderItem create() => PurchaseOrderItem._();
  @$core.override
  PurchaseOrderItem createEmptyInstance() => create();
  static $pb.PbList<PurchaseOrderItem> createRepeated() =>
      $pb.PbList<PurchaseOrderItem>();
  @$core.pragma('dart2js:noInline')
  static PurchaseOrderItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseOrderItem>(create);
  static PurchaseOrderItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemName => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemName() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantityOrdered => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantityOrdered($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantityOrdered() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantityOrdered() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantityReceived => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantityReceived($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantityReceived() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantityReceived() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPrice => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPrice($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalPrice => $_getI64(5);
  @$pb.TagNumber(6)
  set totalPrice($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPrice() => $_clearField(6);
}

class InventoryValuation extends $pb.GeneratedMessage {
  factory InventoryValuation({
    $fixnum.Int64? totalValue,
    $core.int? totalItems,
    $core.Iterable<CategoryValuation>? categories,
  }) {
    final result = create();
    if (totalValue != null) result.totalValue = totalValue;
    if (totalItems != null) result.totalItems = totalItems;
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  InventoryValuation._();

  factory InventoryValuation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryValuation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryValuation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'totalValue')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..pc<CategoryValuation>(
        3, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: CategoryValuation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryValuation clone() => InventoryValuation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryValuation copyWith(void Function(InventoryValuation) updates) =>
      super.copyWith((message) => updates(message as InventoryValuation))
          as InventoryValuation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryValuation create() => InventoryValuation._();
  @$core.override
  InventoryValuation createEmptyInstance() => create();
  static $pb.PbList<InventoryValuation> createRepeated() =>
      $pb.PbList<InventoryValuation>();
  @$core.pragma('dart2js:noInline')
  static InventoryValuation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryValuation>(create);
  static InventoryValuation? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalValue => $_getI64(0);
  @$pb.TagNumber(1)
  set totalValue($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalItems => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalItems($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalItems() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalItems() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<CategoryValuation> get categories => $_getList(2);
}

class CategoryValuation extends $pb.GeneratedMessage {
  factory CategoryValuation({
    $core.String? category,
    $core.int? itemCount,
    $fixnum.Int64? totalValue,
    $core.double? percentage,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (itemCount != null) result.itemCount = itemCount;
    if (totalValue != null) result.totalValue = totalValue;
    if (percentage != null) result.percentage = percentage;
    return result;
  }

  CategoryValuation._();

  factory CategoryValuation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CategoryValuation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CategoryValuation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'itemCount', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'totalValue')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'percentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryValuation clone() => CategoryValuation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CategoryValuation copyWith(void Function(CategoryValuation) updates) =>
      super.copyWith((message) => updates(message as CategoryValuation))
          as CategoryValuation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CategoryValuation create() => CategoryValuation._();
  @$core.override
  CategoryValuation createEmptyInstance() => create();
  static $pb.PbList<CategoryValuation> createRepeated() =>
      $pb.PbList<CategoryValuation>();
  @$core.pragma('dart2js:noInline')
  static CategoryValuation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CategoryValuation>(create);
  static CategoryValuation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get itemCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set itemCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalValue => $_getI64(2);
  @$pb.TagNumber(3)
  set totalValue($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => $_clearField(4);
}

class ExpiryAlert extends $pb.GeneratedMessage {
  factory ExpiryAlert({
    $core.String? itemId,
    $core.String? itemName,
    $core.String? category,
    $core.int? quantity,
    $1.Timestamp? expiryDate,
    $core.int? daysUntilExpiry,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (itemName != null) result.itemName = itemName;
    if (category != null) result.category = category;
    if (quantity != null) result.quantity = quantity;
    if (expiryDate != null) result.expiryDate = expiryDate;
    if (daysUntilExpiry != null) result.daysUntilExpiry = daysUntilExpiry;
    return result;
  }

  ExpiryAlert._();

  factory ExpiryAlert.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExpiryAlert.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExpiryAlert',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..aOS(2, _omitFieldNames ? '' : 'itemName')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'expiryDate',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'daysUntilExpiry', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpiryAlert clone() => ExpiryAlert()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpiryAlert copyWith(void Function(ExpiryAlert) updates) =>
      super.copyWith((message) => updates(message as ExpiryAlert))
          as ExpiryAlert;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpiryAlert create() => ExpiryAlert._();
  @$core.override
  ExpiryAlert createEmptyInstance() => create();
  static $pb.PbList<ExpiryAlert> createRepeated() => $pb.PbList<ExpiryAlert>();
  @$core.pragma('dart2js:noInline')
  static ExpiryAlert getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExpiryAlert>(create);
  static ExpiryAlert? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemName => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasItemName() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get expiryDate => $_getN(4);
  @$pb.TagNumber(5)
  set expiryDate($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiryDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiryDate() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureExpiryDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get daysUntilExpiry => $_getIZ(5);
  @$pb.TagNumber(6)
  set daysUntilExpiry($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDaysUntilExpiry() => $_has(5);
  @$pb.TagNumber(6)
  void clearDaysUntilExpiry() => $_clearField(6);
}

class CreateSupplierRequest extends $pb.GeneratedMessage {
  factory CreateSupplierRequest({
    $core.String? name,
    $core.String? contactName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    $core.String? notes,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (contactName != null) result.contactName = contactName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    if (notes != null) result.notes = notes;
    return result;
  }

  CreateSupplierRequest._();

  factory CreateSupplierRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSupplierRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSupplierRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'contactName')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'phone')
    ..aOS(5, _omitFieldNames ? '' : 'address')
    ..aOS(6, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupplierRequest clone() =>
      CreateSupplierRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupplierRequest copyWith(
          void Function(CreateSupplierRequest) updates) =>
      super.copyWith((message) => updates(message as CreateSupplierRequest))
          as CreateSupplierRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSupplierRequest create() => CreateSupplierRequest._();
  @$core.override
  CreateSupplierRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSupplierRequest> createRepeated() =>
      $pb.PbList<CreateSupplierRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSupplierRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSupplierRequest>(create);
  static CreateSupplierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contactName => $_getSZ(1);
  @$pb.TagNumber(2)
  set contactName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContactName() => $_has(1);
  @$pb.TagNumber(2)
  void clearContactName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get address => $_getSZ(4);
  @$pb.TagNumber(5)
  set address($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddress() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get notes => $_getSZ(5);
  @$pb.TagNumber(6)
  set notes($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNotes() => $_has(5);
  @$pb.TagNumber(6)
  void clearNotes() => $_clearField(6);
}

class CreateSupplierResponse extends $pb.GeneratedMessage {
  factory CreateSupplierResponse({
    $core.bool? success,
    $core.String? message,
    Supplier? supplier,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (supplier != null) result.supplier = supplier;
    return result;
  }

  CreateSupplierResponse._();

  factory CreateSupplierResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateSupplierResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateSupplierResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Supplier>(3, _omitFieldNames ? '' : 'supplier',
        subBuilder: Supplier.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupplierResponse clone() =>
      CreateSupplierResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateSupplierResponse copyWith(
          void Function(CreateSupplierResponse) updates) =>
      super.copyWith((message) => updates(message as CreateSupplierResponse))
          as CreateSupplierResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateSupplierResponse create() => CreateSupplierResponse._();
  @$core.override
  CreateSupplierResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSupplierResponse> createRepeated() =>
      $pb.PbList<CreateSupplierResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSupplierResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateSupplierResponse>(create);
  static CreateSupplierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Supplier get supplier => $_getN(2);
  @$pb.TagNumber(3)
  set supplier(Supplier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSupplier() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupplier() => $_clearField(3);
  @$pb.TagNumber(3)
  Supplier ensureSupplier() => $_ensure(2);
}

class UpdateSupplierRequest extends $pb.GeneratedMessage {
  factory UpdateSupplierRequest({
    $core.String? supplierId,
    $core.String? name,
    $core.String? contactName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    SupplierStatus? status,
    $core.String? notes,
  }) {
    final result = create();
    if (supplierId != null) result.supplierId = supplierId;
    if (name != null) result.name = name;
    if (contactName != null) result.contactName = contactName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (address != null) result.address = address;
    if (status != null) result.status = status;
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdateSupplierRequest._();

  factory UpdateSupplierRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSupplierRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSupplierRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'supplierId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'contactName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..aOS(6, _omitFieldNames ? '' : 'address')
    ..e<SupplierStatus>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SupplierStatus.SUPPLIER_STATUS_ACTIVE,
        valueOf: SupplierStatus.valueOf,
        enumValues: SupplierStatus.values)
    ..aOS(8, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSupplierRequest clone() =>
      UpdateSupplierRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSupplierRequest copyWith(
          void Function(UpdateSupplierRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateSupplierRequest))
          as UpdateSupplierRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSupplierRequest create() => UpdateSupplierRequest._();
  @$core.override
  UpdateSupplierRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSupplierRequest> createRepeated() =>
      $pb.PbList<UpdateSupplierRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSupplierRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSupplierRequest>(create);
  static UpdateSupplierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supplierId => $_getSZ(0);
  @$pb.TagNumber(1)
  set supplierId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSupplierId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupplierId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get contactName => $_getSZ(2);
  @$pb.TagNumber(3)
  set contactName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContactName() => $_has(2);
  @$pb.TagNumber(3)
  void clearContactName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get address => $_getSZ(5);
  @$pb.TagNumber(6)
  set address($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => $_clearField(6);

  @$pb.TagNumber(7)
  SupplierStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(SupplierStatus value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get notes => $_getSZ(7);
  @$pb.TagNumber(8)
  set notes($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNotes() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotes() => $_clearField(8);
}

class UpdateSupplierResponse extends $pb.GeneratedMessage {
  factory UpdateSupplierResponse({
    $core.bool? success,
    $core.String? message,
    Supplier? supplier,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (supplier != null) result.supplier = supplier;
    return result;
  }

  UpdateSupplierResponse._();

  factory UpdateSupplierResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSupplierResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSupplierResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Supplier>(3, _omitFieldNames ? '' : 'supplier',
        subBuilder: Supplier.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSupplierResponse clone() =>
      UpdateSupplierResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSupplierResponse copyWith(
          void Function(UpdateSupplierResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateSupplierResponse))
          as UpdateSupplierResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSupplierResponse create() => UpdateSupplierResponse._();
  @$core.override
  UpdateSupplierResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSupplierResponse> createRepeated() =>
      $pb.PbList<UpdateSupplierResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSupplierResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSupplierResponse>(create);
  static UpdateSupplierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  Supplier get supplier => $_getN(2);
  @$pb.TagNumber(3)
  set supplier(Supplier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSupplier() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupplier() => $_clearField(3);
  @$pb.TagNumber(3)
  Supplier ensureSupplier() => $_ensure(2);
}

class DeleteSupplierRequest extends $pb.GeneratedMessage {
  factory DeleteSupplierRequest({
    $core.String? supplierId,
  }) {
    final result = create();
    if (supplierId != null) result.supplierId = supplierId;
    return result;
  }

  DeleteSupplierRequest._();

  factory DeleteSupplierRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteSupplierRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteSupplierRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'supplierId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSupplierRequest clone() =>
      DeleteSupplierRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSupplierRequest copyWith(
          void Function(DeleteSupplierRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteSupplierRequest))
          as DeleteSupplierRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSupplierRequest create() => DeleteSupplierRequest._();
  @$core.override
  DeleteSupplierRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteSupplierRequest> createRepeated() =>
      $pb.PbList<DeleteSupplierRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteSupplierRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteSupplierRequest>(create);
  static DeleteSupplierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supplierId => $_getSZ(0);
  @$pb.TagNumber(1)
  set supplierId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSupplierId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupplierId() => $_clearField(1);
}

class DeleteSupplierResponse extends $pb.GeneratedMessage {
  factory DeleteSupplierResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeleteSupplierResponse._();

  factory DeleteSupplierResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteSupplierResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteSupplierResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSupplierResponse clone() =>
      DeleteSupplierResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSupplierResponse copyWith(
          void Function(DeleteSupplierResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteSupplierResponse))
          as DeleteSupplierResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSupplierResponse create() => DeleteSupplierResponse._();
  @$core.override
  DeleteSupplierResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteSupplierResponse> createRepeated() =>
      $pb.PbList<DeleteSupplierResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteSupplierResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteSupplierResponse>(create);
  static DeleteSupplierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class ListSuppliersRequest extends $pb.GeneratedMessage {
  factory ListSuppliersRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? search,
    SupplierStatus? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (search != null) result.search = search;
    if (status != null) result.status = status;
    return result;
  }

  ListSuppliersRequest._();

  factory ListSuppliersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSuppliersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSuppliersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'search')
    ..e<SupplierStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SupplierStatus.SUPPLIER_STATUS_ACTIVE,
        valueOf: SupplierStatus.valueOf,
        enumValues: SupplierStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSuppliersRequest clone() =>
      ListSuppliersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSuppliersRequest copyWith(void Function(ListSuppliersRequest) updates) =>
      super.copyWith((message) => updates(message as ListSuppliersRequest))
          as ListSuppliersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSuppliersRequest create() => ListSuppliersRequest._();
  @$core.override
  ListSuppliersRequest createEmptyInstance() => create();
  static $pb.PbList<ListSuppliersRequest> createRepeated() =>
      $pb.PbList<ListSuppliersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSuppliersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSuppliersRequest>(create);
  static ListSuppliersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => $_clearField(3);

  @$pb.TagNumber(4)
  SupplierStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(SupplierStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

class ListSuppliersResponse extends $pb.GeneratedMessage {
  factory ListSuppliersResponse({
    $core.Iterable<Supplier>? suppliers,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (suppliers != null) result.suppliers.addAll(suppliers);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListSuppliersResponse._();

  factory ListSuppliersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSuppliersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSuppliersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Supplier>(1, _omitFieldNames ? '' : 'suppliers', $pb.PbFieldType.PM,
        subBuilder: Supplier.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSuppliersResponse clone() =>
      ListSuppliersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSuppliersResponse copyWith(
          void Function(ListSuppliersResponse) updates) =>
      super.copyWith((message) => updates(message as ListSuppliersResponse))
          as ListSuppliersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSuppliersResponse create() => ListSuppliersResponse._();
  @$core.override
  ListSuppliersResponse createEmptyInstance() => create();
  static $pb.PbList<ListSuppliersResponse> createRepeated() =>
      $pb.PbList<ListSuppliersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSuppliersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSuppliersResponse>(create);
  static ListSuppliersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Supplier> get suppliers => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class CreatePurchaseOrderRequest extends $pb.GeneratedMessage {
  factory CreatePurchaseOrderRequest({
    $core.String? supplierId,
    $core.Iterable<PurchaseOrderItem>? items,
    $core.String? notes,
    $core.String? expectedDate,
  }) {
    final result = create();
    if (supplierId != null) result.supplierId = supplierId;
    if (items != null) result.items.addAll(items);
    if (notes != null) result.notes = notes;
    if (expectedDate != null) result.expectedDate = expectedDate;
    return result;
  }

  CreatePurchaseOrderRequest._();

  factory CreatePurchaseOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePurchaseOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePurchaseOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'supplierId')
    ..pc<PurchaseOrderItem>(
        2, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: PurchaseOrderItem.create)
    ..aOS(3, _omitFieldNames ? '' : 'notes')
    ..aOS(4, _omitFieldNames ? '' : 'expectedDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePurchaseOrderRequest clone() =>
      CreatePurchaseOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePurchaseOrderRequest copyWith(
          void Function(CreatePurchaseOrderRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreatePurchaseOrderRequest))
          as CreatePurchaseOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderRequest create() => CreatePurchaseOrderRequest._();
  @$core.override
  CreatePurchaseOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePurchaseOrderRequest> createRepeated() =>
      $pb.PbList<CreatePurchaseOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePurchaseOrderRequest>(create);
  static CreatePurchaseOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supplierId => $_getSZ(0);
  @$pb.TagNumber(1)
  set supplierId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSupplierId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupplierId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PurchaseOrderItem> get items => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get expectedDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set expectedDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpectedDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpectedDate() => $_clearField(4);
}

class CreatePurchaseOrderResponse extends $pb.GeneratedMessage {
  factory CreatePurchaseOrderResponse({
    $core.bool? success,
    $core.String? message,
    PurchaseOrder? purchaseOrder,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (purchaseOrder != null) result.purchaseOrder = purchaseOrder;
    return result;
  }

  CreatePurchaseOrderResponse._();

  factory CreatePurchaseOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePurchaseOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePurchaseOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PurchaseOrder>(3, _omitFieldNames ? '' : 'purchaseOrder',
        subBuilder: PurchaseOrder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePurchaseOrderResponse clone() =>
      CreatePurchaseOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePurchaseOrderResponse copyWith(
          void Function(CreatePurchaseOrderResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreatePurchaseOrderResponse))
          as CreatePurchaseOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderResponse create() =>
      CreatePurchaseOrderResponse._();
  @$core.override
  CreatePurchaseOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePurchaseOrderResponse> createRepeated() =>
      $pb.PbList<CreatePurchaseOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePurchaseOrderResponse>(create);
  static CreatePurchaseOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrder get purchaseOrder => $_getN(2);
  @$pb.TagNumber(3)
  set purchaseOrder(PurchaseOrder value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPurchaseOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurchaseOrder() => $_clearField(3);
  @$pb.TagNumber(3)
  PurchaseOrder ensurePurchaseOrder() => $_ensure(2);
}

class GetPurchaseOrderRequest extends $pb.GeneratedMessage {
  factory GetPurchaseOrderRequest({
    $core.String? purchaseOrderId,
  }) {
    final result = create();
    if (purchaseOrderId != null) result.purchaseOrderId = purchaseOrderId;
    return result;
  }

  GetPurchaseOrderRequest._();

  factory GetPurchaseOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPurchaseOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPurchaseOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseOrderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPurchaseOrderRequest clone() =>
      GetPurchaseOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPurchaseOrderRequest copyWith(
          void Function(GetPurchaseOrderRequest) updates) =>
      super.copyWith((message) => updates(message as GetPurchaseOrderRequest))
          as GetPurchaseOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderRequest create() => GetPurchaseOrderRequest._();
  @$core.override
  GetPurchaseOrderRequest createEmptyInstance() => create();
  static $pb.PbList<GetPurchaseOrderRequest> createRepeated() =>
      $pb.PbList<GetPurchaseOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPurchaseOrderRequest>(create);
  static GetPurchaseOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseOrderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseOrderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseOrderId() => $_clearField(1);
}

class GetPurchaseOrderResponse extends $pb.GeneratedMessage {
  factory GetPurchaseOrderResponse({
    $core.bool? success,
    $core.String? message,
    PurchaseOrder? purchaseOrder,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (purchaseOrder != null) result.purchaseOrder = purchaseOrder;
    return result;
  }

  GetPurchaseOrderResponse._();

  factory GetPurchaseOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPurchaseOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPurchaseOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PurchaseOrder>(3, _omitFieldNames ? '' : 'purchaseOrder',
        subBuilder: PurchaseOrder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPurchaseOrderResponse clone() =>
      GetPurchaseOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPurchaseOrderResponse copyWith(
          void Function(GetPurchaseOrderResponse) updates) =>
      super.copyWith((message) => updates(message as GetPurchaseOrderResponse))
          as GetPurchaseOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderResponse create() => GetPurchaseOrderResponse._();
  @$core.override
  GetPurchaseOrderResponse createEmptyInstance() => create();
  static $pb.PbList<GetPurchaseOrderResponse> createRepeated() =>
      $pb.PbList<GetPurchaseOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPurchaseOrderResponse>(create);
  static GetPurchaseOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrder get purchaseOrder => $_getN(2);
  @$pb.TagNumber(3)
  set purchaseOrder(PurchaseOrder value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPurchaseOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurchaseOrder() => $_clearField(3);
  @$pb.TagNumber(3)
  PurchaseOrder ensurePurchaseOrder() => $_ensure(2);
}

class ListPurchaseOrdersRequest extends $pb.GeneratedMessage {
  factory ListPurchaseOrdersRequest({
    $core.int? page,
    $core.int? limit,
    PurchaseOrderStatus? status,
    $core.String? supplierId,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    if (status != null) result.status = status;
    if (supplierId != null) result.supplierId = supplierId;
    return result;
  }

  ListPurchaseOrdersRequest._();

  factory ListPurchaseOrdersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPurchaseOrdersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPurchaseOrdersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<PurchaseOrderStatus>(
        3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: PurchaseOrderStatus.PURCHASE_ORDER_STATUS_DRAFT,
        valueOf: PurchaseOrderStatus.valueOf,
        enumValues: PurchaseOrderStatus.values)
    ..aOS(4, _omitFieldNames ? '' : 'supplierId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchaseOrdersRequest clone() =>
      ListPurchaseOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchaseOrdersRequest copyWith(
          void Function(ListPurchaseOrdersRequest) updates) =>
      super.copyWith((message) => updates(message as ListPurchaseOrdersRequest))
          as ListPurchaseOrdersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersRequest create() => ListPurchaseOrdersRequest._();
  @$core.override
  ListPurchaseOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<ListPurchaseOrdersRequest> createRepeated() =>
      $pb.PbList<ListPurchaseOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPurchaseOrdersRequest>(create);
  static ListPurchaseOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrderStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(PurchaseOrderStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get supplierId => $_getSZ(3);
  @$pb.TagNumber(4)
  set supplierId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSupplierId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSupplierId() => $_clearField(4);
}

class ListPurchaseOrdersResponse extends $pb.GeneratedMessage {
  factory ListPurchaseOrdersResponse({
    $core.Iterable<PurchaseOrder>? purchaseOrders,
    PayrollPaginationInfo? pagination,
  }) {
    final result = create();
    if (purchaseOrders != null) result.purchaseOrders.addAll(purchaseOrders);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListPurchaseOrdersResponse._();

  factory ListPurchaseOrdersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListPurchaseOrdersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPurchaseOrdersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<PurchaseOrder>(
        1, _omitFieldNames ? '' : 'purchaseOrders', $pb.PbFieldType.PM,
        subBuilder: PurchaseOrder.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchaseOrdersResponse clone() =>
      ListPurchaseOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListPurchaseOrdersResponse copyWith(
          void Function(ListPurchaseOrdersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListPurchaseOrdersResponse))
          as ListPurchaseOrdersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersResponse create() => ListPurchaseOrdersResponse._();
  @$core.override
  ListPurchaseOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<ListPurchaseOrdersResponse> createRepeated() =>
      $pb.PbList<ListPurchaseOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPurchaseOrdersResponse>(create);
  static ListPurchaseOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PurchaseOrder> get purchaseOrders => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class ReceivePurchaseOrderRequest extends $pb.GeneratedMessage {
  factory ReceivePurchaseOrderRequest({
    $core.String? purchaseOrderId,
    $core.Iterable<PurchaseOrderItem>? receivedItems,
  }) {
    final result = create();
    if (purchaseOrderId != null) result.purchaseOrderId = purchaseOrderId;
    if (receivedItems != null) result.receivedItems.addAll(receivedItems);
    return result;
  }

  ReceivePurchaseOrderRequest._();

  factory ReceivePurchaseOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceivePurchaseOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceivePurchaseOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseOrderId')
    ..pc<PurchaseOrderItem>(
        2, _omitFieldNames ? '' : 'receivedItems', $pb.PbFieldType.PM,
        subBuilder: PurchaseOrderItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceivePurchaseOrderRequest clone() =>
      ReceivePurchaseOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceivePurchaseOrderRequest copyWith(
          void Function(ReceivePurchaseOrderRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ReceivePurchaseOrderRequest))
          as ReceivePurchaseOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderRequest create() =>
      ReceivePurchaseOrderRequest._();
  @$core.override
  ReceivePurchaseOrderRequest createEmptyInstance() => create();
  static $pb.PbList<ReceivePurchaseOrderRequest> createRepeated() =>
      $pb.PbList<ReceivePurchaseOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceivePurchaseOrderRequest>(create);
  static ReceivePurchaseOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseOrderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseOrderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PurchaseOrderItem> get receivedItems => $_getList(1);
}

class ReceivePurchaseOrderResponse extends $pb.GeneratedMessage {
  factory ReceivePurchaseOrderResponse({
    $core.bool? success,
    $core.String? message,
    PurchaseOrder? purchaseOrder,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (purchaseOrder != null) result.purchaseOrder = purchaseOrder;
    return result;
  }

  ReceivePurchaseOrderResponse._();

  factory ReceivePurchaseOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceivePurchaseOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceivePurchaseOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PurchaseOrder>(3, _omitFieldNames ? '' : 'purchaseOrder',
        subBuilder: PurchaseOrder.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceivePurchaseOrderResponse clone() =>
      ReceivePurchaseOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceivePurchaseOrderResponse copyWith(
          void Function(ReceivePurchaseOrderResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ReceivePurchaseOrderResponse))
          as ReceivePurchaseOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderResponse create() =>
      ReceivePurchaseOrderResponse._();
  @$core.override
  ReceivePurchaseOrderResponse createEmptyInstance() => create();
  static $pb.PbList<ReceivePurchaseOrderResponse> createRepeated() =>
      $pb.PbList<ReceivePurchaseOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceivePurchaseOrderResponse>(create);
  static ReceivePurchaseOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrder get purchaseOrder => $_getN(2);
  @$pb.TagNumber(3)
  set purchaseOrder(PurchaseOrder value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPurchaseOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurchaseOrder() => $_clearField(3);
  @$pb.TagNumber(3)
  PurchaseOrder ensurePurchaseOrder() => $_ensure(2);
}

class GetInventoryValuationRequest extends $pb.GeneratedMessage {
  factory GetInventoryValuationRequest() => create();

  GetInventoryValuationRequest._();

  factory GetInventoryValuationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventoryValuationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventoryValuationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryValuationRequest clone() =>
      GetInventoryValuationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryValuationRequest copyWith(
          void Function(GetInventoryValuationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInventoryValuationRequest))
          as GetInventoryValuationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationRequest create() =>
      GetInventoryValuationRequest._();
  @$core.override
  GetInventoryValuationRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventoryValuationRequest> createRepeated() =>
      $pb.PbList<GetInventoryValuationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventoryValuationRequest>(create);
  static GetInventoryValuationRequest? _defaultInstance;
}

class GetInventoryValuationResponse extends $pb.GeneratedMessage {
  factory GetInventoryValuationResponse({
    $core.bool? success,
    $core.String? message,
    InventoryValuation? valuation,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (valuation != null) result.valuation = valuation;
    return result;
  }

  GetInventoryValuationResponse._();

  factory GetInventoryValuationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInventoryValuationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInventoryValuationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<InventoryValuation>(3, _omitFieldNames ? '' : 'valuation',
        subBuilder: InventoryValuation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryValuationResponse clone() =>
      GetInventoryValuationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInventoryValuationResponse copyWith(
          void Function(GetInventoryValuationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInventoryValuationResponse))
          as GetInventoryValuationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationResponse create() =>
      GetInventoryValuationResponse._();
  @$core.override
  GetInventoryValuationResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventoryValuationResponse> createRepeated() =>
      $pb.PbList<GetInventoryValuationResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInventoryValuationResponse>(create);
  static GetInventoryValuationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  InventoryValuation get valuation => $_getN(2);
  @$pb.TagNumber(3)
  set valuation(InventoryValuation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasValuation() => $_has(2);
  @$pb.TagNumber(3)
  void clearValuation() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryValuation ensureValuation() => $_ensure(2);
}

class GetExpiryAlertsRequest extends $pb.GeneratedMessage {
  factory GetExpiryAlertsRequest({
    $core.int? daysAhead,
  }) {
    final result = create();
    if (daysAhead != null) result.daysAhead = daysAhead;
    return result;
  }

  GetExpiryAlertsRequest._();

  factory GetExpiryAlertsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExpiryAlertsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExpiryAlertsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'daysAhead', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpiryAlertsRequest clone() =>
      GetExpiryAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpiryAlertsRequest copyWith(
          void Function(GetExpiryAlertsRequest) updates) =>
      super.copyWith((message) => updates(message as GetExpiryAlertsRequest))
          as GetExpiryAlertsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsRequest create() => GetExpiryAlertsRequest._();
  @$core.override
  GetExpiryAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpiryAlertsRequest> createRepeated() =>
      $pb.PbList<GetExpiryAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExpiryAlertsRequest>(create);
  static GetExpiryAlertsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daysAhead => $_getIZ(0);
  @$pb.TagNumber(1)
  set daysAhead($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDaysAhead() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaysAhead() => $_clearField(1);
}

class GetExpiryAlertsResponse extends $pb.GeneratedMessage {
  factory GetExpiryAlertsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<ExpiryAlert>? alerts,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (alerts != null) result.alerts.addAll(alerts);
    return result;
  }

  GetExpiryAlertsResponse._();

  factory GetExpiryAlertsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExpiryAlertsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExpiryAlertsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<ExpiryAlert>(3, _omitFieldNames ? '' : 'alerts', $pb.PbFieldType.PM,
        subBuilder: ExpiryAlert.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpiryAlertsResponse clone() =>
      GetExpiryAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExpiryAlertsResponse copyWith(
          void Function(GetExpiryAlertsResponse) updates) =>
      super.copyWith((message) => updates(message as GetExpiryAlertsResponse))
          as GetExpiryAlertsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsResponse create() => GetExpiryAlertsResponse._();
  @$core.override
  GetExpiryAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpiryAlertsResponse> createRepeated() =>
      $pb.PbList<GetExpiryAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExpiryAlertsResponse>(create);
  static GetExpiryAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<ExpiryAlert> get alerts => $_getList(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
