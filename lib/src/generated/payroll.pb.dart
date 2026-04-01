///
//  Generated code. Do not modify.
//  source: payroll.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'payroll.pbenum.dart';

export 'payroll.pbenum.dart';

class Employee extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Employee', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nin')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccountNumber')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..e<EmploymentType>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employmentType', $pb.PbFieldType.OE, defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME, valueOf: EmploymentType.valueOf, enumValues: EmploymentType.values)
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRate')
    ..e<PayFrequency>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payFrequency', $pb.PbFieldType.OE, defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY, valueOf: PayFrequency.valueOf, enumValues: PayFrequency.values)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'department')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobTitle')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..e<EmployeeStatus>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE, valueOf: EmployeeStatus.valueOf, enumValues: EmployeeStatus.values)
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Employee._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (fullName != null) {
      _result.fullName = fullName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (nin != null) {
      _result.nin = nin;
    }
    if (bankAccountNumber != null) {
      _result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (employmentType != null) {
      _result.employmentType = employmentType;
    }
    if (payRate != null) {
      _result.payRate = payRate;
    }
    if (payFrequency != null) {
      _result.payFrequency = payFrequency;
    }
    if (department != null) {
      _result.department = department;
    }
    if (jobTitle != null) {
      _result.jobTitle = jobTitle;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Employee.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Employee.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Employee clone() => Employee()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Employee copyWith(void Function(Employee) updates) => super.copyWith((message) => updates(message as Employee)) as Employee; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Employee create() => Employee._();
  Employee createEmptyInstance() => create();
  static $pb.PbList<Employee> createRepeated() => $pb.PbList<Employee>();
  @$core.pragma('dart2js:noInline')
  static Employee getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Employee>(create);
  static Employee? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessId => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBusinessId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fullName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get nin => $_getSZ(6);
  @$pb.TagNumber(7)
  set nin($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNin() => $_has(6);
  @$pb.TagNumber(7)
  void clearNin() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankAccountNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankAccountNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBankAccountNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankAccountNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get bankCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set bankCode($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBankCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearBankCode() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get bankName => $_getSZ(9);
  @$pb.TagNumber(10)
  set bankName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBankName() => $_has(9);
  @$pb.TagNumber(10)
  void clearBankName() => clearField(10);

  @$pb.TagNumber(11)
  EmploymentType get employmentType => $_getN(10);
  @$pb.TagNumber(11)
  set employmentType(EmploymentType v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasEmploymentType() => $_has(10);
  @$pb.TagNumber(11)
  void clearEmploymentType() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get payRate => $_getI64(11);
  @$pb.TagNumber(12)
  set payRate($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPayRate() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayRate() => clearField(12);

  @$pb.TagNumber(13)
  PayFrequency get payFrequency => $_getN(12);
  @$pb.TagNumber(13)
  set payFrequency(PayFrequency v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasPayFrequency() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayFrequency() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get department => $_getSZ(13);
  @$pb.TagNumber(14)
  set department($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDepartment() => $_has(13);
  @$pb.TagNumber(14)
  void clearDepartment() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get jobTitle => $_getSZ(14);
  @$pb.TagNumber(15)
  set jobTitle($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasJobTitle() => $_has(14);
  @$pb.TagNumber(15)
  void clearJobTitle() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get startDate => $_getSZ(15);
  @$pb.TagNumber(16)
  set startDate($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasStartDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearStartDate() => clearField(16);

  @$pb.TagNumber(17)
  EmployeeStatus get status => $_getN(16);
  @$pb.TagNumber(17)
  set status(EmployeeStatus v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearStatus() => clearField(17);

  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);
}

class PayRun extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayRun', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payPeriodStart')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payPeriodEnd')
    ..e<PayRunStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayRunStatus.PAY_RUN_STATUS_DRAFT, valueOf: PayRunStatus.valueOf, enumValues: PayRunStatus.values)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGross')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDeductions')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalNet')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalEmployerContributions')
    ..a<$core.int>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeCount', $pb.PbFieldType.O3)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdBy')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedBy')
    ..aOM<$1.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processedAt', subBuilder: $1.Timestamp.create)
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRecurring')
    ..e<RecurrenceFrequency>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrenceFrequency', $pb.PbFieldType.OE, defaultOrMaker: RecurrenceFrequency.RECURRENCE_FREQUENCY_NONE, valueOf: RecurrenceFrequency.valueOf, enumValues: RecurrenceFrequency.values)
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextScheduledDate')
    ..aOB(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoApprove')
    ..pPS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeIds')
    ..hasRequiredFields = false
  ;

  PayRun._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (payPeriodStart != null) {
      _result.payPeriodStart = payPeriodStart;
    }
    if (payPeriodEnd != null) {
      _result.payPeriodEnd = payPeriodEnd;
    }
    if (status != null) {
      _result.status = status;
    }
    if (totalGross != null) {
      _result.totalGross = totalGross;
    }
    if (totalDeductions != null) {
      _result.totalDeductions = totalDeductions;
    }
    if (totalNet != null) {
      _result.totalNet = totalNet;
    }
    if (totalEmployerContributions != null) {
      _result.totalEmployerContributions = totalEmployerContributions;
    }
    if (employeeCount != null) {
      _result.employeeCount = employeeCount;
    }
    if (createdBy != null) {
      _result.createdBy = createdBy;
    }
    if (approvedBy != null) {
      _result.approvedBy = approvedBy;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (processedAt != null) {
      _result.processedAt = processedAt;
    }
    if (name != null) {
      _result.name = name;
    }
    if (isRecurring != null) {
      _result.isRecurring = isRecurring;
    }
    if (recurrenceFrequency != null) {
      _result.recurrenceFrequency = recurrenceFrequency;
    }
    if (nextScheduledDate != null) {
      _result.nextScheduledDate = nextScheduledDate;
    }
    if (autoApprove != null) {
      _result.autoApprove = autoApprove;
    }
    if (employeeIds != null) {
      _result.employeeIds.addAll(employeeIds);
    }
    return _result;
  }
  factory PayRun.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayRun.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayRun clone() => PayRun()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayRun copyWith(void Function(PayRun) updates) => super.copyWith((message) => updates(message as PayRun)) as PayRun; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayRun create() => PayRun._();
  PayRun createEmptyInstance() => create();
  static $pb.PbList<PayRun> createRepeated() => $pb.PbList<PayRun>();
  @$core.pragma('dart2js:noInline')
  static PayRun getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayRun>(create);
  static PayRun? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get payPeriodStart => $_getSZ(2);
  @$pb.TagNumber(3)
  set payPeriodStart($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayPeriodStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayPeriodStart() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get payPeriodEnd => $_getSZ(3);
  @$pb.TagNumber(4)
  set payPeriodEnd($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayPeriodEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayPeriodEnd() => clearField(4);

  @$pb.TagNumber(5)
  PayRunStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(PayRunStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalGross => $_getI64(5);
  @$pb.TagNumber(6)
  set totalGross($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalGross() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalGross() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalDeductions => $_getI64(6);
  @$pb.TagNumber(7)
  set totalDeductions($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalDeductions() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalDeductions() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalNet => $_getI64(7);
  @$pb.TagNumber(8)
  set totalNet($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalNet() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalNet() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get totalEmployerContributions => $_getI64(8);
  @$pb.TagNumber(9)
  set totalEmployerContributions($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTotalEmployerContributions() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalEmployerContributions() => clearField(9);

  @$pb.TagNumber(10)
  $core.int get employeeCount => $_getIZ(9);
  @$pb.TagNumber(10)
  set employeeCount($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasEmployeeCount() => $_has(9);
  @$pb.TagNumber(10)
  void clearEmployeeCount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdBy => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdBy($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedBy() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedBy() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get approvedBy => $_getSZ(11);
  @$pb.TagNumber(12)
  set approvedBy($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasApprovedBy() => $_has(11);
  @$pb.TagNumber(12)
  void clearApprovedBy() => clearField(12);

  @$pb.TagNumber(13)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(13)
  set createdAt($1.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);

  @$pb.TagNumber(14)
  $1.Timestamp get processedAt => $_getN(13);
  @$pb.TagNumber(14)
  set processedAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasProcessedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearProcessedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureProcessedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $core.String get name => $_getSZ(14);
  @$pb.TagNumber(15)
  set name($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasName() => $_has(14);
  @$pb.TagNumber(15)
  void clearName() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isRecurring => $_getBF(15);
  @$pb.TagNumber(16)
  set isRecurring($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasIsRecurring() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsRecurring() => clearField(16);

  @$pb.TagNumber(17)
  RecurrenceFrequency get recurrenceFrequency => $_getN(16);
  @$pb.TagNumber(17)
  set recurrenceFrequency(RecurrenceFrequency v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasRecurrenceFrequency() => $_has(16);
  @$pb.TagNumber(17)
  void clearRecurrenceFrequency() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get nextScheduledDate => $_getSZ(17);
  @$pb.TagNumber(18)
  set nextScheduledDate($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNextScheduledDate() => $_has(17);
  @$pb.TagNumber(18)
  void clearNextScheduledDate() => clearField(18);

  @$pb.TagNumber(19)
  $core.bool get autoApprove => $_getBF(18);
  @$pb.TagNumber(19)
  set autoApprove($core.bool v) { $_setBool(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasAutoApprove() => $_has(18);
  @$pb.TagNumber(19)
  void clearAutoApprove() => clearField(19);

  @$pb.TagNumber(20)
  $core.List<$core.String> get employeeIds => $_getList(19);
}

class InventoryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InventoryItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitPrice')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unit')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sku')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumStockLevel', $pb.PbFieldType.O3)
    ..e<InventoryItemStatus>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE, valueOf: InventoryItemStatus.valueOf, enumValues: InventoryItemStatus.values)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOM<$1.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  InventoryItem._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (unitPrice != null) {
      _result.unitPrice = unitPrice;
    }
    if (unit != null) {
      _result.unit = unit;
    }
    if (sku != null) {
      _result.sku = sku;
    }
    if (location != null) {
      _result.location = location;
    }
    if (minimumStockLevel != null) {
      _result.minimumStockLevel = minimumStockLevel;
    }
    if (status != null) {
      _result.status = status;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory InventoryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InventoryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InventoryItem clone() => InventoryItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InventoryItem copyWith(void Function(InventoryItem) updates) => super.copyWith((message) => updates(message as InventoryItem)) as InventoryItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InventoryItem create() => InventoryItem._();
  InventoryItem createEmptyInstance() => create();
  static $pb.PbList<InventoryItem> createRepeated() => $pb.PbList<InventoryItem>();
  @$core.pragma('dart2js:noInline')
  static InventoryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InventoryItem>(create);
  static InventoryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get quantity => $_getIZ(5);
  @$pb.TagNumber(6)
  set quantity($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get unitPrice => $_getI64(6);
  @$pb.TagNumber(7)
  set unitPrice($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUnitPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnitPrice() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get unit => $_getSZ(7);
  @$pb.TagNumber(8)
  set unit($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUnit() => $_has(7);
  @$pb.TagNumber(8)
  void clearUnit() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get sku => $_getSZ(8);
  @$pb.TagNumber(9)
  set sku($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSku() => $_has(8);
  @$pb.TagNumber(9)
  void clearSku() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get location => $_getSZ(9);
  @$pb.TagNumber(10)
  set location($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLocation() => $_has(9);
  @$pb.TagNumber(10)
  void clearLocation() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get minimumStockLevel => $_getIZ(10);
  @$pb.TagNumber(11)
  set minimumStockLevel($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMinimumStockLevel() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinimumStockLevel() => clearField(11);

  @$pb.TagNumber(12)
  InventoryItemStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(InventoryItemStatus v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get notes => $_getSZ(12);
  @$pb.TagNumber(13)
  set notes($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasNotes() => $_has(12);
  @$pb.TagNumber(13)
  void clearNotes() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($1.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureUpdatedAt() => $_ensure(14);
}

class InventoryAdjustment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InventoryAdjustment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..e<AdjustmentType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adjustmentType', $pb.PbFieldType.OE, defaultOrMaker: AdjustmentType.ADJUSTMENT_TYPE_ADD, valueOf: AdjustmentType.valueOf, enumValues: AdjustmentType.values)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantityChange', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantityBefore', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantityAfter', $pb.PbFieldType.O3)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adjustedBy')
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  InventoryAdjustment._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (itemId != null) {
      _result.itemId = itemId;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (adjustmentType != null) {
      _result.adjustmentType = adjustmentType;
    }
    if (quantityChange != null) {
      _result.quantityChange = quantityChange;
    }
    if (quantityBefore != null) {
      _result.quantityBefore = quantityBefore;
    }
    if (quantityAfter != null) {
      _result.quantityAfter = quantityAfter;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (adjustedBy != null) {
      _result.adjustedBy = adjustedBy;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory InventoryAdjustment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InventoryAdjustment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InventoryAdjustment clone() => InventoryAdjustment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InventoryAdjustment copyWith(void Function(InventoryAdjustment) updates) => super.copyWith((message) => updates(message as InventoryAdjustment)) as InventoryAdjustment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InventoryAdjustment create() => InventoryAdjustment._();
  InventoryAdjustment createEmptyInstance() => create();
  static $pb.PbList<InventoryAdjustment> createRepeated() => $pb.PbList<InventoryAdjustment>();
  @$core.pragma('dart2js:noInline')
  static InventoryAdjustment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InventoryAdjustment>(create);
  static InventoryAdjustment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemId => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasItemId() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessId => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBusinessId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessId() => clearField(3);

  @$pb.TagNumber(4)
  AdjustmentType get adjustmentType => $_getN(3);
  @$pb.TagNumber(4)
  set adjustmentType(AdjustmentType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAdjustmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdjustmentType() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get quantityChange => $_getIZ(4);
  @$pb.TagNumber(5)
  set quantityChange($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQuantityChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantityChange() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get quantityBefore => $_getIZ(5);
  @$pb.TagNumber(6)
  set quantityBefore($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQuantityBefore() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantityBefore() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get quantityAfter => $_getIZ(6);
  @$pb.TagNumber(7)
  set quantityAfter($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuantityAfter() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantityAfter() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get adjustedBy => $_getSZ(8);
  @$pb.TagNumber(9)
  set adjustedBy($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasAdjustedBy() => $_has(8);
  @$pb.TagNumber(9)
  void clearAdjustedBy() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);
}

class InventoryCategorySummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InventoryCategorySummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemCount', $pb.PbFieldType.O3)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lowStockCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  InventoryCategorySummary._() : super();
  factory InventoryCategorySummary({
    $core.String? category,
    $core.int? itemCount,
    $fixnum.Int64? totalValue,
    $core.int? lowStockCount,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (itemCount != null) {
      _result.itemCount = itemCount;
    }
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    if (lowStockCount != null) {
      _result.lowStockCount = lowStockCount;
    }
    return _result;
  }
  factory InventoryCategorySummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InventoryCategorySummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InventoryCategorySummary clone() => InventoryCategorySummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InventoryCategorySummary copyWith(void Function(InventoryCategorySummary) updates) => super.copyWith((message) => updates(message as InventoryCategorySummary)) as InventoryCategorySummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InventoryCategorySummary create() => InventoryCategorySummary._();
  InventoryCategorySummary createEmptyInstance() => create();
  static $pb.PbList<InventoryCategorySummary> createRepeated() => $pb.PbList<InventoryCategorySummary>();
  @$core.pragma('dart2js:noInline')
  static InventoryCategorySummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InventoryCategorySummary>(create);
  static InventoryCategorySummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get itemCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set itemCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasItemCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemCount() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalValue => $_getI64(2);
  @$pb.TagNumber(3)
  set totalValue($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get lowStockCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set lowStockCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLowStockCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearLowStockCount() => clearField(4);
}

class PaySlip extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaySlip', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRunId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeName')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'grossPay')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomeTax')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nationalInsurance')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'studentLoanRepayment')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pensionContribution')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otherDeductions')
    ..aInt64(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDeductions')
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netPay')
    ..aInt64(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employerNic')
    ..aInt64(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employerPension')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hoursWorked', $pb.PbFieldType.OD)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overtimeHours', $pb.PbFieldType.OD)
    ..aInt64(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overtimePay')
    ..aInt64(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bonuses')
    ..aInt64(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissions')
    ..e<PaymentStatus>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentStatus', $pb.PbFieldType.OE, defaultOrMaker: PaymentStatus.PAYMENT_STATUS_PENDING, valueOf: PaymentStatus.valueOf, enumValues: PaymentStatus.values)
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOM<$1.Timestamp>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PaySlip._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (payRunId != null) {
      _result.payRunId = payRunId;
    }
    if (employeeId != null) {
      _result.employeeId = employeeId;
    }
    if (employeeName != null) {
      _result.employeeName = employeeName;
    }
    if (grossPay != null) {
      _result.grossPay = grossPay;
    }
    if (incomeTax != null) {
      _result.incomeTax = incomeTax;
    }
    if (nationalInsurance != null) {
      _result.nationalInsurance = nationalInsurance;
    }
    if (studentLoanRepayment != null) {
      _result.studentLoanRepayment = studentLoanRepayment;
    }
    if (pensionContribution != null) {
      _result.pensionContribution = pensionContribution;
    }
    if (otherDeductions != null) {
      _result.otherDeductions = otherDeductions;
    }
    if (totalDeductions != null) {
      _result.totalDeductions = totalDeductions;
    }
    if (netPay != null) {
      _result.netPay = netPay;
    }
    if (employerNic != null) {
      _result.employerNic = employerNic;
    }
    if (employerPension != null) {
      _result.employerPension = employerPension;
    }
    if (hoursWorked != null) {
      _result.hoursWorked = hoursWorked;
    }
    if (overtimeHours != null) {
      _result.overtimeHours = overtimeHours;
    }
    if (overtimePay != null) {
      _result.overtimePay = overtimePay;
    }
    if (bonuses != null) {
      _result.bonuses = bonuses;
    }
    if (commissions != null) {
      _result.commissions = commissions;
    }
    if (paymentStatus != null) {
      _result.paymentStatus = paymentStatus;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory PaySlip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaySlip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaySlip clone() => PaySlip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaySlip copyWith(void Function(PaySlip) updates) => super.copyWith((message) => updates(message as PaySlip)) as PaySlip; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaySlip create() => PaySlip._();
  PaySlip createEmptyInstance() => create();
  static $pb.PbList<PaySlip> createRepeated() => $pb.PbList<PaySlip>();
  @$core.pragma('dart2js:noInline')
  static PaySlip getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaySlip>(create);
  static PaySlip? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get payRunId => $_getSZ(1);
  @$pb.TagNumber(2)
  set payRunId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayRunId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayRunId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get employeeId => $_getSZ(2);
  @$pb.TagNumber(3)
  set employeeId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmployeeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployeeId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get employeeName => $_getSZ(3);
  @$pb.TagNumber(4)
  set employeeName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmployeeName() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmployeeName() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get grossPay => $_getI64(4);
  @$pb.TagNumber(5)
  set grossPay($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGrossPay() => $_has(4);
  @$pb.TagNumber(5)
  void clearGrossPay() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get incomeTax => $_getI64(5);
  @$pb.TagNumber(6)
  set incomeTax($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIncomeTax() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncomeTax() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get nationalInsurance => $_getI64(6);
  @$pb.TagNumber(7)
  set nationalInsurance($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNationalInsurance() => $_has(6);
  @$pb.TagNumber(7)
  void clearNationalInsurance() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get studentLoanRepayment => $_getI64(7);
  @$pb.TagNumber(8)
  set studentLoanRepayment($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStudentLoanRepayment() => $_has(7);
  @$pb.TagNumber(8)
  void clearStudentLoanRepayment() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get pensionContribution => $_getI64(8);
  @$pb.TagNumber(9)
  set pensionContribution($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPensionContribution() => $_has(8);
  @$pb.TagNumber(9)
  void clearPensionContribution() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get otherDeductions => $_getI64(9);
  @$pb.TagNumber(10)
  set otherDeductions($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasOtherDeductions() => $_has(9);
  @$pb.TagNumber(10)
  void clearOtherDeductions() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get totalDeductions => $_getI64(10);
  @$pb.TagNumber(11)
  set totalDeductions($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTotalDeductions() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalDeductions() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get netPay => $_getI64(11);
  @$pb.TagNumber(12)
  set netPay($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNetPay() => $_has(11);
  @$pb.TagNumber(12)
  void clearNetPay() => clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get employerNic => $_getI64(12);
  @$pb.TagNumber(13)
  set employerNic($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasEmployerNic() => $_has(12);
  @$pb.TagNumber(13)
  void clearEmployerNic() => clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get employerPension => $_getI64(13);
  @$pb.TagNumber(14)
  set employerPension($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasEmployerPension() => $_has(13);
  @$pb.TagNumber(14)
  void clearEmployerPension() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get hoursWorked => $_getN(14);
  @$pb.TagNumber(15)
  set hoursWorked($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasHoursWorked() => $_has(14);
  @$pb.TagNumber(15)
  void clearHoursWorked() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get overtimeHours => $_getN(15);
  @$pb.TagNumber(16)
  set overtimeHours($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasOvertimeHours() => $_has(15);
  @$pb.TagNumber(16)
  void clearOvertimeHours() => clearField(16);

  @$pb.TagNumber(17)
  $fixnum.Int64 get overtimePay => $_getI64(16);
  @$pb.TagNumber(17)
  set overtimePay($fixnum.Int64 v) { $_setInt64(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasOvertimePay() => $_has(16);
  @$pb.TagNumber(17)
  void clearOvertimePay() => clearField(17);

  @$pb.TagNumber(18)
  $fixnum.Int64 get bonuses => $_getI64(17);
  @$pb.TagNumber(18)
  set bonuses($fixnum.Int64 v) { $_setInt64(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasBonuses() => $_has(17);
  @$pb.TagNumber(18)
  void clearBonuses() => clearField(18);

  @$pb.TagNumber(19)
  $fixnum.Int64 get commissions => $_getI64(18);
  @$pb.TagNumber(19)
  set commissions($fixnum.Int64 v) { $_setInt64(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCommissions() => $_has(18);
  @$pb.TagNumber(19)
  void clearCommissions() => clearField(19);

  @$pb.TagNumber(20)
  PaymentStatus get paymentStatus => $_getN(19);
  @$pb.TagNumber(20)
  set paymentStatus(PaymentStatus v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasPaymentStatus() => $_has(19);
  @$pb.TagNumber(20)
  void clearPaymentStatus() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get paymentReference => $_getSZ(20);
  @$pb.TagNumber(21)
  set paymentReference($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasPaymentReference() => $_has(20);
  @$pb.TagNumber(21)
  void clearPaymentReference() => clearField(21);

  @$pb.TagNumber(22)
  $1.Timestamp get createdAt => $_getN(21);
  @$pb.TagNumber(22)
  set createdAt($1.Timestamp v) { setField(22, v); }
  @$pb.TagNumber(22)
  $core.bool hasCreatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearCreatedAt() => clearField(22);
  @$pb.TagNumber(22)
  $1.Timestamp ensureCreatedAt() => $_ensure(21);
}

class DeductionSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeductionSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  DeductionSummary._() : super();
  factory DeductionSummary({
    $core.String? type,
    $fixnum.Int64? amount,
    $core.String? description,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory DeductionSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeductionSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeductionSummary clone() => DeductionSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeductionSummary copyWith(void Function(DeductionSummary) updates) => super.copyWith((message) => updates(message as DeductionSummary)) as DeductionSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeductionSummary create() => DeductionSummary._();
  DeductionSummary createEmptyInstance() => create();
  static $pb.PbList<DeductionSummary> createRepeated() => $pb.PbList<DeductionSummary>();
  @$core.pragma('dart2js:noInline')
  static DeductionSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeductionSummary>(create);
  static DeductionSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class PayrollPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayrollPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PayrollPaginationInfo._() : super();
  factory PayrollPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    return _result;
  }
  factory PayrollPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayrollPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayrollPaginationInfo clone() => PayrollPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayrollPaginationInfo copyWith(void Function(PayrollPaginationInfo) updates) => super.copyWith((message) => updates(message as PayrollPaginationInfo)) as PayrollPaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayrollPaginationInfo create() => PayrollPaginationInfo._();
  PayrollPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PayrollPaginationInfo> createRepeated() => $pb.PbList<PayrollPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PayrollPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayrollPaginationInfo>(create);
  static PayrollPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);
}

class AddEmployeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddEmployeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nin')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccountNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..e<EmploymentType>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employmentType', $pb.PbFieldType.OE, defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME, valueOf: EmploymentType.valueOf, enumValues: EmploymentType.values)
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRate')
    ..e<PayFrequency>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payFrequency', $pb.PbFieldType.OE, defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY, valueOf: PayFrequency.valueOf, enumValues: PayFrequency.values)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'department')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobTitle')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  AddEmployeeRequest._() : super();
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
    final _result = create();
    if (fullName != null) {
      _result.fullName = fullName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (nin != null) {
      _result.nin = nin;
    }
    if (bankAccountNumber != null) {
      _result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (employmentType != null) {
      _result.employmentType = employmentType;
    }
    if (payRate != null) {
      _result.payRate = payRate;
    }
    if (payFrequency != null) {
      _result.payFrequency = payFrequency;
    }
    if (department != null) {
      _result.department = department;
    }
    if (jobTitle != null) {
      _result.jobTitle = jobTitle;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory AddEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEmployeeRequest clone() => AddEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEmployeeRequest copyWith(void Function(AddEmployeeRequest) updates) => super.copyWith((message) => updates(message as AddEmployeeRequest)) as AddEmployeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddEmployeeRequest create() => AddEmployeeRequest._();
  AddEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<AddEmployeeRequest> createRepeated() => $pb.PbList<AddEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static AddEmployeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddEmployeeRequest>(create);
  static AddEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFullName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get nin => $_getSZ(3);
  @$pb.TagNumber(4)
  set nin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNin() => $_has(3);
  @$pb.TagNumber(4)
  void clearNin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get bankAccountNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set bankAccountNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBankAccountNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearBankAccountNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => clearField(7);

  @$pb.TagNumber(8)
  EmploymentType get employmentType => $_getN(7);
  @$pb.TagNumber(8)
  set employmentType(EmploymentType v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasEmploymentType() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmploymentType() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get payRate => $_getI64(8);
  @$pb.TagNumber(9)
  set payRate($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPayRate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPayRate() => clearField(9);

  @$pb.TagNumber(10)
  PayFrequency get payFrequency => $_getN(9);
  @$pb.TagNumber(10)
  set payFrequency(PayFrequency v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPayFrequency() => $_has(9);
  @$pb.TagNumber(10)
  void clearPayFrequency() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get department => $_getSZ(10);
  @$pb.TagNumber(11)
  set department($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDepartment() => $_has(10);
  @$pb.TagNumber(11)
  void clearDepartment() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get jobTitle => $_getSZ(11);
  @$pb.TagNumber(12)
  set jobTitle($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasJobTitle() => $_has(11);
  @$pb.TagNumber(12)
  void clearJobTitle() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get startDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set startDate($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasStartDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearStartDate() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get userId => $_getSZ(13);
  @$pb.TagNumber(14)
  set userId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasUserId() => $_has(13);
  @$pb.TagNumber(14)
  void clearUserId() => clearField(14);
}

class AddEmployeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddEmployeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Employee>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employee', subBuilder: Employee.create)
    ..hasRequiredFields = false
  ;

  AddEmployeeResponse._() : super();
  factory AddEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (employee != null) {
      _result.employee = employee;
    }
    return _result;
  }
  factory AddEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEmployeeResponse clone() => AddEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEmployeeResponse copyWith(void Function(AddEmployeeResponse) updates) => super.copyWith((message) => updates(message as AddEmployeeResponse)) as AddEmployeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddEmployeeResponse create() => AddEmployeeResponse._();
  AddEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<AddEmployeeResponse> createRepeated() => $pb.PbList<AddEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static AddEmployeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddEmployeeResponse>(create);
  static AddEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Employee get employee => $_getN(2);
  @$pb.TagNumber(3)
  set employee(Employee v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmployee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployee() => clearField(3);
  @$pb.TagNumber(3)
  Employee ensureEmployee() => $_ensure(2);
}

class UpdateEmployeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateEmployeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nin')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccountNumber')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..e<EmploymentType>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employmentType', $pb.PbFieldType.OE, defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME, valueOf: EmploymentType.valueOf, enumValues: EmploymentType.values)
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRate')
    ..e<PayFrequency>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payFrequency', $pb.PbFieldType.OE, defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY, valueOf: PayFrequency.valueOf, enumValues: PayFrequency.values)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'department')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobTitle')
    ..e<EmployeeStatus>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE, valueOf: EmployeeStatus.valueOf, enumValues: EmployeeStatus.values)
    ..hasRequiredFields = false
  ;

  UpdateEmployeeRequest._() : super();
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
    final _result = create();
    if (employeeId != null) {
      _result.employeeId = employeeId;
    }
    if (fullName != null) {
      _result.fullName = fullName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (nin != null) {
      _result.nin = nin;
    }
    if (bankAccountNumber != null) {
      _result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (employmentType != null) {
      _result.employmentType = employmentType;
    }
    if (payRate != null) {
      _result.payRate = payRate;
    }
    if (payFrequency != null) {
      _result.payFrequency = payFrequency;
    }
    if (department != null) {
      _result.department = department;
    }
    if (jobTitle != null) {
      _result.jobTitle = jobTitle;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory UpdateEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateEmployeeRequest clone() => UpdateEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateEmployeeRequest copyWith(void Function(UpdateEmployeeRequest) updates) => super.copyWith((message) => updates(message as UpdateEmployeeRequest)) as UpdateEmployeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeRequest create() => UpdateEmployeeRequest._();
  UpdateEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateEmployeeRequest> createRepeated() => $pb.PbList<UpdateEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateEmployeeRequest>(create);
  static UpdateEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fullName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fullName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFullName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFullName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get nin => $_getSZ(4);
  @$pb.TagNumber(5)
  set nin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNin() => $_has(4);
  @$pb.TagNumber(5)
  void clearNin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get bankAccountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set bankAccountNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBankAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearBankAccountNumber() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBankCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get bankName => $_getSZ(7);
  @$pb.TagNumber(8)
  set bankName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBankName() => $_has(7);
  @$pb.TagNumber(8)
  void clearBankName() => clearField(8);

  @$pb.TagNumber(9)
  EmploymentType get employmentType => $_getN(8);
  @$pb.TagNumber(9)
  set employmentType(EmploymentType v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEmploymentType() => $_has(8);
  @$pb.TagNumber(9)
  void clearEmploymentType() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get payRate => $_getI64(9);
  @$pb.TagNumber(10)
  set payRate($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPayRate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPayRate() => clearField(10);

  @$pb.TagNumber(11)
  PayFrequency get payFrequency => $_getN(10);
  @$pb.TagNumber(11)
  set payFrequency(PayFrequency v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasPayFrequency() => $_has(10);
  @$pb.TagNumber(11)
  void clearPayFrequency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get department => $_getSZ(11);
  @$pb.TagNumber(12)
  set department($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDepartment() => $_has(11);
  @$pb.TagNumber(12)
  void clearDepartment() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get jobTitle => $_getSZ(12);
  @$pb.TagNumber(13)
  set jobTitle($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasJobTitle() => $_has(12);
  @$pb.TagNumber(13)
  void clearJobTitle() => clearField(13);

  @$pb.TagNumber(14)
  EmployeeStatus get status => $_getN(13);
  @$pb.TagNumber(14)
  set status(EmployeeStatus v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => clearField(14);
}

class UpdateEmployeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateEmployeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Employee>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employee', subBuilder: Employee.create)
    ..hasRequiredFields = false
  ;

  UpdateEmployeeResponse._() : super();
  factory UpdateEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (employee != null) {
      _result.employee = employee;
    }
    return _result;
  }
  factory UpdateEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateEmployeeResponse clone() => UpdateEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateEmployeeResponse copyWith(void Function(UpdateEmployeeResponse) updates) => super.copyWith((message) => updates(message as UpdateEmployeeResponse)) as UpdateEmployeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeResponse create() => UpdateEmployeeResponse._();
  UpdateEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateEmployeeResponse> createRepeated() => $pb.PbList<UpdateEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateEmployeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateEmployeeResponse>(create);
  static UpdateEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Employee get employee => $_getN(2);
  @$pb.TagNumber(3)
  set employee(Employee v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmployee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployee() => clearField(3);
  @$pb.TagNumber(3)
  Employee ensureEmployee() => $_ensure(2);
}

class RemoveEmployeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveEmployeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeId')
    ..hasRequiredFields = false
  ;

  RemoveEmployeeRequest._() : super();
  factory RemoveEmployeeRequest({
    $core.String? employeeId,
  }) {
    final _result = create();
    if (employeeId != null) {
      _result.employeeId = employeeId;
    }
    return _result;
  }
  factory RemoveEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveEmployeeRequest clone() => RemoveEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveEmployeeRequest copyWith(void Function(RemoveEmployeeRequest) updates) => super.copyWith((message) => updates(message as RemoveEmployeeRequest)) as RemoveEmployeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeRequest create() => RemoveEmployeeRequest._();
  RemoveEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveEmployeeRequest> createRepeated() => $pb.PbList<RemoveEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveEmployeeRequest>(create);
  static RemoveEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => clearField(1);
}

class RemoveEmployeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveEmployeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RemoveEmployeeResponse._() : super();
  factory RemoveEmployeeResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RemoveEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveEmployeeResponse clone() => RemoveEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveEmployeeResponse copyWith(void Function(RemoveEmployeeResponse) updates) => super.copyWith((message) => updates(message as RemoveEmployeeResponse)) as RemoveEmployeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeResponse create() => RemoveEmployeeResponse._();
  RemoveEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveEmployeeResponse> createRepeated() => $pb.PbList<RemoveEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveEmployeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveEmployeeResponse>(create);
  static RemoveEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetEmployeeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEmployeeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeId')
    ..hasRequiredFields = false
  ;

  GetEmployeeRequest._() : super();
  factory GetEmployeeRequest({
    $core.String? employeeId,
  }) {
    final _result = create();
    if (employeeId != null) {
      _result.employeeId = employeeId;
    }
    return _result;
  }
  factory GetEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEmployeeRequest clone() => GetEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEmployeeRequest copyWith(void Function(GetEmployeeRequest) updates) => super.copyWith((message) => updates(message as GetEmployeeRequest)) as GetEmployeeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEmployeeRequest create() => GetEmployeeRequest._();
  GetEmployeeRequest createEmptyInstance() => create();
  static $pb.PbList<GetEmployeeRequest> createRepeated() => $pb.PbList<GetEmployeeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEmployeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEmployeeRequest>(create);
  static GetEmployeeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => clearField(1);
}

class GetEmployeeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEmployeeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Employee>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employee', subBuilder: Employee.create)
    ..hasRequiredFields = false
  ;

  GetEmployeeResponse._() : super();
  factory GetEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (employee != null) {
      _result.employee = employee;
    }
    return _result;
  }
  factory GetEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEmployeeResponse clone() => GetEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEmployeeResponse copyWith(void Function(GetEmployeeResponse) updates) => super.copyWith((message) => updates(message as GetEmployeeResponse)) as GetEmployeeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEmployeeResponse create() => GetEmployeeResponse._();
  GetEmployeeResponse createEmptyInstance() => create();
  static $pb.PbList<GetEmployeeResponse> createRepeated() => $pb.PbList<GetEmployeeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEmployeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEmployeeResponse>(create);
  static GetEmployeeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Employee get employee => $_getN(2);
  @$pb.TagNumber(3)
  set employee(Employee v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmployee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmployee() => clearField(3);
  @$pb.TagNumber(3)
  Employee ensureEmployee() => $_ensure(2);
}

class ListEmployeesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEmployeesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<EmployeeStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE, valueOf: EmployeeStatus.valueOf, enumValues: EmployeeStatus.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'department')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'search')
    ..hasRequiredFields = false
  ;

  ListEmployeesRequest._() : super();
  factory ListEmployeesRequest({
    $core.int? page,
    $core.int? limit,
    EmployeeStatus? status,
    $core.String? department,
    $core.String? search,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (status != null) {
      _result.status = status;
    }
    if (department != null) {
      _result.department = department;
    }
    if (search != null) {
      _result.search = search;
    }
    return _result;
  }
  factory ListEmployeesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEmployeesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEmployeesRequest clone() => ListEmployeesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEmployeesRequest copyWith(void Function(ListEmployeesRequest) updates) => super.copyWith((message) => updates(message as ListEmployeesRequest)) as ListEmployeesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEmployeesRequest create() => ListEmployeesRequest._();
  ListEmployeesRequest createEmptyInstance() => create();
  static $pb.PbList<ListEmployeesRequest> createRepeated() => $pb.PbList<ListEmployeesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListEmployeesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEmployeesRequest>(create);
  static ListEmployeesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  EmployeeStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(EmployeeStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get department => $_getSZ(3);
  @$pb.TagNumber(4)
  set department($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDepartment() => $_has(3);
  @$pb.TagNumber(4)
  void clearDepartment() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get search => $_getSZ(4);
  @$pb.TagNumber(5)
  set search($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSearch() => $_has(4);
  @$pb.TagNumber(5)
  void clearSearch() => clearField(5);
}

class ListEmployeesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEmployeesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Employee>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employees', $pb.PbFieldType.PM, subBuilder: Employee.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListEmployeesResponse._() : super();
  factory ListEmployeesResponse({
    $core.Iterable<Employee>? employees,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (employees != null) {
      _result.employees.addAll(employees);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListEmployeesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEmployeesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEmployeesResponse clone() => ListEmployeesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEmployeesResponse copyWith(void Function(ListEmployeesResponse) updates) => super.copyWith((message) => updates(message as ListEmployeesResponse)) as ListEmployeesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEmployeesResponse create() => ListEmployeesResponse._();
  ListEmployeesResponse createEmptyInstance() => create();
  static $pb.PbList<ListEmployeesResponse> createRepeated() => $pb.PbList<ListEmployeesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEmployeesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEmployeesResponse>(create);
  static ListEmployeesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Employee> get employees => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class CreatePayRunRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePayRunRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payPeriodStart')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payPeriodEnd')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeIds')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRecurring')
    ..e<RecurrenceFrequency>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recurrenceFrequency', $pb.PbFieldType.OE, defaultOrMaker: RecurrenceFrequency.RECURRENCE_FREQUENCY_NONE, valueOf: RecurrenceFrequency.valueOf, enumValues: RecurrenceFrequency.values)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'autoApprove')
    ..hasRequiredFields = false
  ;

  CreatePayRunRequest._() : super();
  factory CreatePayRunRequest({
    $core.String? payPeriodStart,
    $core.String? payPeriodEnd,
    $core.String? name,
    $core.Iterable<$core.String>? employeeIds,
    $core.bool? isRecurring,
    RecurrenceFrequency? recurrenceFrequency,
    $core.bool? autoApprove,
  }) {
    final _result = create();
    if (payPeriodStart != null) {
      _result.payPeriodStart = payPeriodStart;
    }
    if (payPeriodEnd != null) {
      _result.payPeriodEnd = payPeriodEnd;
    }
    if (name != null) {
      _result.name = name;
    }
    if (employeeIds != null) {
      _result.employeeIds.addAll(employeeIds);
    }
    if (isRecurring != null) {
      _result.isRecurring = isRecurring;
    }
    if (recurrenceFrequency != null) {
      _result.recurrenceFrequency = recurrenceFrequency;
    }
    if (autoApprove != null) {
      _result.autoApprove = autoApprove;
    }
    return _result;
  }
  factory CreatePayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePayRunRequest clone() => CreatePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePayRunRequest copyWith(void Function(CreatePayRunRequest) updates) => super.copyWith((message) => updates(message as CreatePayRunRequest)) as CreatePayRunRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePayRunRequest create() => CreatePayRunRequest._();
  CreatePayRunRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePayRunRequest> createRepeated() => $pb.PbList<CreatePayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePayRunRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePayRunRequest>(create);
  static CreatePayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payPeriodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set payPeriodStart($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayPeriodStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get payPeriodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set payPeriodEnd($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayPeriodEnd() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get employeeIds => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get isRecurring => $_getBF(4);
  @$pb.TagNumber(5)
  set isRecurring($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsRecurring() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsRecurring() => clearField(5);

  @$pb.TagNumber(6)
  RecurrenceFrequency get recurrenceFrequency => $_getN(5);
  @$pb.TagNumber(6)
  set recurrenceFrequency(RecurrenceFrequency v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecurrenceFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecurrenceFrequency() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get autoApprove => $_getBF(6);
  @$pb.TagNumber(7)
  set autoApprove($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAutoApprove() => $_has(6);
  @$pb.TagNumber(7)
  void clearAutoApprove() => clearField(7);
}

class CreatePayRunResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePayRunResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PayRun>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false
  ;

  CreatePayRunResponse._() : super();
  factory CreatePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (payRun != null) {
      _result.payRun = payRun;
    }
    return _result;
  }
  factory CreatePayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePayRunResponse clone() => CreatePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePayRunResponse copyWith(void Function(CreatePayRunResponse) updates) => super.copyWith((message) => updates(message as CreatePayRunResponse)) as CreatePayRunResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePayRunResponse create() => CreatePayRunResponse._();
  CreatePayRunResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePayRunResponse> createRepeated() => $pb.PbList<CreatePayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePayRunResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePayRunResponse>(create);
  static CreatePayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);
}

class CalculatePayRunRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculatePayRunRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRunId')
    ..hasRequiredFields = false
  ;

  CalculatePayRunRequest._() : super();
  factory CalculatePayRunRequest({
    $core.String? payRunId,
  }) {
    final _result = create();
    if (payRunId != null) {
      _result.payRunId = payRunId;
    }
    return _result;
  }
  factory CalculatePayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculatePayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculatePayRunRequest clone() => CalculatePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculatePayRunRequest copyWith(void Function(CalculatePayRunRequest) updates) => super.copyWith((message) => updates(message as CalculatePayRunRequest)) as CalculatePayRunRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculatePayRunRequest create() => CalculatePayRunRequest._();
  CalculatePayRunRequest createEmptyInstance() => create();
  static $pb.PbList<CalculatePayRunRequest> createRepeated() => $pb.PbList<CalculatePayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculatePayRunRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculatePayRunRequest>(create);
  static CalculatePayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => clearField(1);
}

class CalculatePayRunResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CalculatePayRunResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PayRun>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRun', subBuilder: PayRun.create)
    ..pc<PaySlip>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paySlips', $pb.PbFieldType.PM, subBuilder: PaySlip.create)
    ..hasRequiredFields = false
  ;

  CalculatePayRunResponse._() : super();
  factory CalculatePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
    $core.Iterable<PaySlip>? paySlips,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (payRun != null) {
      _result.payRun = payRun;
    }
    if (paySlips != null) {
      _result.paySlips.addAll(paySlips);
    }
    return _result;
  }
  factory CalculatePayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculatePayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculatePayRunResponse clone() => CalculatePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculatePayRunResponse copyWith(void Function(CalculatePayRunResponse) updates) => super.copyWith((message) => updates(message as CalculatePayRunResponse)) as CalculatePayRunResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CalculatePayRunResponse create() => CalculatePayRunResponse._();
  CalculatePayRunResponse createEmptyInstance() => create();
  static $pb.PbList<CalculatePayRunResponse> createRepeated() => $pb.PbList<CalculatePayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculatePayRunResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculatePayRunResponse>(create);
  static CalculatePayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<PaySlip> get paySlips => $_getList(3);
}

class ApprovePayRunRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApprovePayRunRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRunId')
    ..hasRequiredFields = false
  ;

  ApprovePayRunRequest._() : super();
  factory ApprovePayRunRequest({
    $core.String? payRunId,
  }) {
    final _result = create();
    if (payRunId != null) {
      _result.payRunId = payRunId;
    }
    return _result;
  }
  factory ApprovePayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApprovePayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApprovePayRunRequest clone() => ApprovePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApprovePayRunRequest copyWith(void Function(ApprovePayRunRequest) updates) => super.copyWith((message) => updates(message as ApprovePayRunRequest)) as ApprovePayRunRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApprovePayRunRequest create() => ApprovePayRunRequest._();
  ApprovePayRunRequest createEmptyInstance() => create();
  static $pb.PbList<ApprovePayRunRequest> createRepeated() => $pb.PbList<ApprovePayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static ApprovePayRunRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApprovePayRunRequest>(create);
  static ApprovePayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => clearField(1);
}

class ApprovePayRunResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ApprovePayRunResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PayRun>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false
  ;

  ApprovePayRunResponse._() : super();
  factory ApprovePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (payRun != null) {
      _result.payRun = payRun;
    }
    return _result;
  }
  factory ApprovePayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApprovePayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApprovePayRunResponse clone() => ApprovePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApprovePayRunResponse copyWith(void Function(ApprovePayRunResponse) updates) => super.copyWith((message) => updates(message as ApprovePayRunResponse)) as ApprovePayRunResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ApprovePayRunResponse create() => ApprovePayRunResponse._();
  ApprovePayRunResponse createEmptyInstance() => create();
  static $pb.PbList<ApprovePayRunResponse> createRepeated() => $pb.PbList<ApprovePayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static ApprovePayRunResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ApprovePayRunResponse>(create);
  static ApprovePayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);
}

class ProcessPayRunRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPayRunRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRunId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  ProcessPayRunRequest._() : super();
  factory ProcessPayRunRequest({
    $core.String? payRunId,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
  }) {
    final _result = create();
    if (payRunId != null) {
      _result.payRunId = payRunId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    return _result;
  }
  factory ProcessPayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPayRunRequest clone() => ProcessPayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPayRunRequest copyWith(void Function(ProcessPayRunRequest) updates) => super.copyWith((message) => updates(message as ProcessPayRunRequest)) as ProcessPayRunRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessPayRunRequest create() => ProcessPayRunRequest._();
  ProcessPayRunRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPayRunRequest> createRepeated() => $pb.PbList<ProcessPayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayRunRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPayRunRequest>(create);
  static ProcessPayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionPin => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionPin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionPin() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get sourceAccountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set sourceAccountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSourceAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSourceAccountId() => clearField(3);
}

class ProcessPayRunResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPayRunResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PayRun>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRun', subBuilder: PayRun.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successfulPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ProcessPayRunResponse._() : super();
  factory ProcessPayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
    $core.int? successfulPayments,
    $core.int? failedPayments,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (payRun != null) {
      _result.payRun = payRun;
    }
    if (successfulPayments != null) {
      _result.successfulPayments = successfulPayments;
    }
    if (failedPayments != null) {
      _result.failedPayments = failedPayments;
    }
    return _result;
  }
  factory ProcessPayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPayRunResponse clone() => ProcessPayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPayRunResponse copyWith(void Function(ProcessPayRunResponse) updates) => super.copyWith((message) => updates(message as ProcessPayRunResponse)) as ProcessPayRunResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProcessPayRunResponse create() => ProcessPayRunResponse._();
  ProcessPayRunResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPayRunResponse> createRepeated() => $pb.PbList<ProcessPayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPayRunResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPayRunResponse>(create);
  static ProcessPayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get successfulPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set successfulPayments($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSuccessfulPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuccessfulPayments() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get failedPayments => $_getIZ(4);
  @$pb.TagNumber(5)
  set failedPayments($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFailedPayments() => $_has(4);
  @$pb.TagNumber(5)
  void clearFailedPayments() => clearField(5);
}

class GetPayRunRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayRunRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRunId')
    ..hasRequiredFields = false
  ;

  GetPayRunRequest._() : super();
  factory GetPayRunRequest({
    $core.String? payRunId,
  }) {
    final _result = create();
    if (payRunId != null) {
      _result.payRunId = payRunId;
    }
    return _result;
  }
  factory GetPayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayRunRequest clone() => GetPayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayRunRequest copyWith(void Function(GetPayRunRequest) updates) => super.copyWith((message) => updates(message as GetPayRunRequest)) as GetPayRunRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayRunRequest create() => GetPayRunRequest._();
  GetPayRunRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayRunRequest> createRepeated() => $pb.PbList<GetPayRunRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayRunRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayRunRequest>(create);
  static GetPayRunRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => clearField(1);
}

class GetPayRunResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayRunResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PayRun>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false
  ;

  GetPayRunResponse._() : super();
  factory GetPayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (payRun != null) {
      _result.payRun = payRun;
    }
    return _result;
  }
  factory GetPayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayRunResponse clone() => GetPayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayRunResponse copyWith(void Function(GetPayRunResponse) updates) => super.copyWith((message) => updates(message as GetPayRunResponse)) as GetPayRunResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayRunResponse create() => GetPayRunResponse._();
  GetPayRunResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayRunResponse> createRepeated() => $pb.PbList<GetPayRunResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayRunResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayRunResponse>(create);
  static GetPayRunResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PayRun get payRun => $_getN(2);
  @$pb.TagNumber(3)
  set payRun(PayRun v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayRun() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayRun() => clearField(3);
  @$pb.TagNumber(3)
  PayRun ensurePayRun() => $_ensure(2);
}

class ListPayRunsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListPayRunsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<PayRunStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayRunStatus.PAY_RUN_STATUS_DRAFT, valueOf: PayRunStatus.valueOf, enumValues: PayRunStatus.values)
    ..hasRequiredFields = false
  ;

  ListPayRunsRequest._() : super();
  factory ListPayRunsRequest({
    $core.int? page,
    $core.int? limit,
    PayRunStatus? status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ListPayRunsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPayRunsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPayRunsRequest clone() => ListPayRunsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPayRunsRequest copyWith(void Function(ListPayRunsRequest) updates) => super.copyWith((message) => updates(message as ListPayRunsRequest)) as ListPayRunsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListPayRunsRequest create() => ListPayRunsRequest._();
  ListPayRunsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPayRunsRequest> createRepeated() => $pb.PbList<ListPayRunsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPayRunsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPayRunsRequest>(create);
  static ListPayRunsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  PayRunStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(PayRunStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class ListPayRunsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListPayRunsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PayRun>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRuns', $pb.PbFieldType.PM, subBuilder: PayRun.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListPayRunsResponse._() : super();
  factory ListPayRunsResponse({
    $core.Iterable<PayRun>? payRuns,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (payRuns != null) {
      _result.payRuns.addAll(payRuns);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListPayRunsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPayRunsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPayRunsResponse clone() => ListPayRunsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPayRunsResponse copyWith(void Function(ListPayRunsResponse) updates) => super.copyWith((message) => updates(message as ListPayRunsResponse)) as ListPayRunsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListPayRunsResponse create() => ListPayRunsResponse._();
  ListPayRunsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPayRunsResponse> createRepeated() => $pb.PbList<ListPayRunsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPayRunsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPayRunsResponse>(create);
  static ListPayRunsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PayRun> get payRuns => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetPaySlipRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaySlipRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paySlipId')
    ..hasRequiredFields = false
  ;

  GetPaySlipRequest._() : super();
  factory GetPaySlipRequest({
    $core.String? paySlipId,
  }) {
    final _result = create();
    if (paySlipId != null) {
      _result.paySlipId = paySlipId;
    }
    return _result;
  }
  factory GetPaySlipRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaySlipRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaySlipRequest clone() => GetPaySlipRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaySlipRequest copyWith(void Function(GetPaySlipRequest) updates) => super.copyWith((message) => updates(message as GetPaySlipRequest)) as GetPaySlipRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPaySlipRequest create() => GetPaySlipRequest._();
  GetPaySlipRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaySlipRequest> createRepeated() => $pb.PbList<GetPaySlipRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaySlipRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaySlipRequest>(create);
  static GetPaySlipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paySlipId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paySlipId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaySlipId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaySlipId() => clearField(1);
}

class GetPaySlipResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaySlipResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PaySlip>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paySlip', subBuilder: PaySlip.create)
    ..hasRequiredFields = false
  ;

  GetPaySlipResponse._() : super();
  factory GetPaySlipResponse({
    $core.bool? success,
    $core.String? message,
    PaySlip? paySlip,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (paySlip != null) {
      _result.paySlip = paySlip;
    }
    return _result;
  }
  factory GetPaySlipResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaySlipResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaySlipResponse clone() => GetPaySlipResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaySlipResponse copyWith(void Function(GetPaySlipResponse) updates) => super.copyWith((message) => updates(message as GetPaySlipResponse)) as GetPaySlipResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPaySlipResponse create() => GetPaySlipResponse._();
  GetPaySlipResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaySlipResponse> createRepeated() => $pb.PbList<GetPaySlipResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaySlipResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaySlipResponse>(create);
  static GetPaySlipResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PaySlip get paySlip => $_getN(2);
  @$pb.TagNumber(3)
  set paySlip(PaySlip v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaySlip() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaySlip() => clearField(3);
  @$pb.TagNumber(3)
  PaySlip ensurePaySlip() => $_ensure(2);
}

class ListPaySlipsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListPaySlipsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payRunId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListPaySlipsRequest._() : super();
  factory ListPaySlipsRequest({
    $core.String? payRunId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (payRunId != null) {
      _result.payRunId = payRunId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory ListPaySlipsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaySlipsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaySlipsRequest clone() => ListPaySlipsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaySlipsRequest copyWith(void Function(ListPaySlipsRequest) updates) => super.copyWith((message) => updates(message as ListPaySlipsRequest)) as ListPaySlipsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListPaySlipsRequest create() => ListPaySlipsRequest._();
  ListPaySlipsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPaySlipsRequest> createRepeated() => $pb.PbList<ListPaySlipsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPaySlipsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPaySlipsRequest>(create);
  static ListPaySlipsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get payRunId => $_getSZ(0);
  @$pb.TagNumber(1)
  set payRunId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayRunId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayRunId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class ListPaySlipsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListPaySlipsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PaySlip>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paySlips', $pb.PbFieldType.PM, subBuilder: PaySlip.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListPaySlipsResponse._() : super();
  factory ListPaySlipsResponse({
    $core.Iterable<PaySlip>? paySlips,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (paySlips != null) {
      _result.paySlips.addAll(paySlips);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListPaySlipsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaySlipsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaySlipsResponse clone() => ListPaySlipsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaySlipsResponse copyWith(void Function(ListPaySlipsResponse) updates) => super.copyWith((message) => updates(message as ListPaySlipsResponse)) as ListPaySlipsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListPaySlipsResponse create() => ListPaySlipsResponse._();
  ListPaySlipsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPaySlipsResponse> createRepeated() => $pb.PbList<ListPaySlipsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPaySlipsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPaySlipsResponse>(create);
  static ListPaySlipsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PaySlip> get paySlips => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetPayrollSummaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayrollSummaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodStart')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodEnd')
    ..hasRequiredFields = false
  ;

  GetPayrollSummaryRequest._() : super();
  factory GetPayrollSummaryRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final _result = create();
    if (periodStart != null) {
      _result.periodStart = periodStart;
    }
    if (periodEnd != null) {
      _result.periodEnd = periodEnd;
    }
    return _result;
  }
  factory GetPayrollSummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayrollSummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryRequest clone() => GetPayrollSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryRequest copyWith(void Function(GetPayrollSummaryRequest) updates) => super.copyWith((message) => updates(message as GetPayrollSummaryRequest)) as GetPayrollSummaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryRequest create() => GetPayrollSummaryRequest._();
  GetPayrollSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayrollSummaryRequest> createRepeated() => $pb.PbList<GetPayrollSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayrollSummaryRequest>(create);
  static GetPayrollSummaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodStart($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodEnd($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodEnd() => clearField(2);
}

class GetPayrollSummaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayrollSummaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalEmployees', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayRuns', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGrossPaid')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDeductions')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalNetPaid')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalEmployerContributions')
    ..pc<DeductionSummary>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deductionBreakdown', $pb.PbFieldType.PM, subBuilder: DeductionSummary.create)
    ..hasRequiredFields = false
  ;

  GetPayrollSummaryResponse._() : super();
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
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (totalEmployees != null) {
      _result.totalEmployees = totalEmployees;
    }
    if (totalPayRuns != null) {
      _result.totalPayRuns = totalPayRuns;
    }
    if (totalGrossPaid != null) {
      _result.totalGrossPaid = totalGrossPaid;
    }
    if (totalDeductions != null) {
      _result.totalDeductions = totalDeductions;
    }
    if (totalNetPaid != null) {
      _result.totalNetPaid = totalNetPaid;
    }
    if (totalEmployerContributions != null) {
      _result.totalEmployerContributions = totalEmployerContributions;
    }
    if (deductionBreakdown != null) {
      _result.deductionBreakdown.addAll(deductionBreakdown);
    }
    return _result;
  }
  factory GetPayrollSummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayrollSummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryResponse clone() => GetPayrollSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryResponse copyWith(void Function(GetPayrollSummaryResponse) updates) => super.copyWith((message) => updates(message as GetPayrollSummaryResponse)) as GetPayrollSummaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryResponse create() => GetPayrollSummaryResponse._();
  GetPayrollSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayrollSummaryResponse> createRepeated() => $pb.PbList<GetPayrollSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayrollSummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayrollSummaryResponse>(create);
  static GetPayrollSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalEmployees => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalEmployees($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalEmployees() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalEmployees() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPayRuns => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPayRuns($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalPayRuns() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPayRuns() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalGrossPaid => $_getI64(4);
  @$pb.TagNumber(5)
  set totalGrossPaid($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalGrossPaid() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalGrossPaid() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalDeductions => $_getI64(5);
  @$pb.TagNumber(6)
  set totalDeductions($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalDeductions() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalDeductions() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalNetPaid => $_getI64(6);
  @$pb.TagNumber(7)
  set totalNetPaid($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalNetPaid() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalNetPaid() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalEmployerContributions => $_getI64(7);
  @$pb.TagNumber(8)
  set totalEmployerContributions($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalEmployerContributions() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalEmployerContributions() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<DeductionSummary> get deductionBreakdown => $_getList(8);
}

class GetTaxReportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTaxReportRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodStart')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodEnd')
    ..hasRequiredFields = false
  ;

  GetTaxReportRequest._() : super();
  factory GetTaxReportRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final _result = create();
    if (periodStart != null) {
      _result.periodStart = periodStart;
    }
    if (periodEnd != null) {
      _result.periodEnd = periodEnd;
    }
    return _result;
  }
  factory GetTaxReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxReportRequest clone() => GetTaxReportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxReportRequest copyWith(void Function(GetTaxReportRequest) updates) => super.copyWith((message) => updates(message as GetTaxReportRequest)) as GetTaxReportRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTaxReportRequest create() => GetTaxReportRequest._();
  GetTaxReportRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaxReportRequest> createRepeated() => $pb.PbList<GetTaxReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaxReportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaxReportRequest>(create);
  static GetTaxReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodStart($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodEnd($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodEnd() => clearField(2);
}

class GetTaxReportResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTaxReportResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPaye')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalNhf')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPensionEmployee')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPensionEmployer')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalNsitf')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItf')
    ..pc<EmployeeTaxSummary>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeSummaries', $pb.PbFieldType.PM, subBuilder: EmployeeTaxSummary.create)
    ..hasRequiredFields = false
  ;

  GetTaxReportResponse._() : super();
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
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (totalPaye != null) {
      _result.totalPaye = totalPaye;
    }
    if (totalNhf != null) {
      _result.totalNhf = totalNhf;
    }
    if (totalPensionEmployee != null) {
      _result.totalPensionEmployee = totalPensionEmployee;
    }
    if (totalPensionEmployer != null) {
      _result.totalPensionEmployer = totalPensionEmployer;
    }
    if (totalNsitf != null) {
      _result.totalNsitf = totalNsitf;
    }
    if (totalItf != null) {
      _result.totalItf = totalItf;
    }
    if (employeeSummaries != null) {
      _result.employeeSummaries.addAll(employeeSummaries);
    }
    return _result;
  }
  factory GetTaxReportResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxReportResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxReportResponse clone() => GetTaxReportResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxReportResponse copyWith(void Function(GetTaxReportResponse) updates) => super.copyWith((message) => updates(message as GetTaxReportResponse)) as GetTaxReportResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTaxReportResponse create() => GetTaxReportResponse._();
  GetTaxReportResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaxReportResponse> createRepeated() => $pb.PbList<GetTaxReportResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaxReportResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaxReportResponse>(create);
  static GetTaxReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalPaye => $_getI64(2);
  @$pb.TagNumber(3)
  set totalPaye($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPaye() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaye() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalNhf => $_getI64(3);
  @$pb.TagNumber(4)
  set totalNhf($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalNhf() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalNhf() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalPensionEmployee => $_getI64(4);
  @$pb.TagNumber(5)
  set totalPensionEmployee($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalPensionEmployee() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPensionEmployee() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalPensionEmployer => $_getI64(5);
  @$pb.TagNumber(6)
  set totalPensionEmployer($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalPensionEmployer() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPensionEmployer() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalNsitf => $_getI64(6);
  @$pb.TagNumber(7)
  set totalNsitf($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalNsitf() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalNsitf() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalItf => $_getI64(7);
  @$pb.TagNumber(8)
  set totalItf($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalItf() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalItf() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<EmployeeTaxSummary> get employeeSummaries => $_getList(8);
}

class EmployeeTaxSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmployeeTaxSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeName')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'grossPay')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paye')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nhf')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pension')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netPay')
    ..hasRequiredFields = false
  ;

  EmployeeTaxSummary._() : super();
  factory EmployeeTaxSummary({
    $core.String? employeeId,
    $core.String? employeeName,
    $fixnum.Int64? grossPay,
    $fixnum.Int64? paye,
    $fixnum.Int64? nhf,
    $fixnum.Int64? pension,
    $fixnum.Int64? netPay,
  }) {
    final _result = create();
    if (employeeId != null) {
      _result.employeeId = employeeId;
    }
    if (employeeName != null) {
      _result.employeeName = employeeName;
    }
    if (grossPay != null) {
      _result.grossPay = grossPay;
    }
    if (paye != null) {
      _result.paye = paye;
    }
    if (nhf != null) {
      _result.nhf = nhf;
    }
    if (pension != null) {
      _result.pension = pension;
    }
    if (netPay != null) {
      _result.netPay = netPay;
    }
    return _result;
  }
  factory EmployeeTaxSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmployeeTaxSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmployeeTaxSummary clone() => EmployeeTaxSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmployeeTaxSummary copyWith(void Function(EmployeeTaxSummary) updates) => super.copyWith((message) => updates(message as EmployeeTaxSummary)) as EmployeeTaxSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EmployeeTaxSummary create() => EmployeeTaxSummary._();
  EmployeeTaxSummary createEmptyInstance() => create();
  static $pb.PbList<EmployeeTaxSummary> createRepeated() => $pb.PbList<EmployeeTaxSummary>();
  @$core.pragma('dart2js:noInline')
  static EmployeeTaxSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmployeeTaxSummary>(create);
  static EmployeeTaxSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get employeeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set employeeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmployeeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmployeeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get employeeName => $_getSZ(1);
  @$pb.TagNumber(2)
  set employeeName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmployeeName() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmployeeName() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get grossPay => $_getI64(2);
  @$pb.TagNumber(3)
  set grossPay($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGrossPay() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrossPay() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get paye => $_getI64(3);
  @$pb.TagNumber(4)
  set paye($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaye() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaye() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get nhf => $_getI64(4);
  @$pb.TagNumber(5)
  set nhf($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNhf() => $_has(4);
  @$pb.TagNumber(5)
  void clearNhf() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get pension => $_getI64(5);
  @$pb.TagNumber(6)
  set pension($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPension() => $_has(5);
  @$pb.TagNumber(6)
  void clearPension() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get netPay => $_getI64(6);
  @$pb.TagNumber(7)
  set netPay($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNetPay() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetPay() => clearField(7);
}

class CreateInventoryItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInventoryItemRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitPrice')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unit')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sku')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumStockLevel', $pb.PbFieldType.O3)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  CreateInventoryItemRequest._() : super();
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
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (unitPrice != null) {
      _result.unitPrice = unitPrice;
    }
    if (unit != null) {
      _result.unit = unit;
    }
    if (sku != null) {
      _result.sku = sku;
    }
    if (location != null) {
      _result.location = location;
    }
    if (minimumStockLevel != null) {
      _result.minimumStockLevel = minimumStockLevel;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory CreateInventoryItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInventoryItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInventoryItemRequest clone() => CreateInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInventoryItemRequest copyWith(void Function(CreateInventoryItemRequest) updates) => super.copyWith((message) => updates(message as CreateInventoryItemRequest)) as CreateInventoryItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemRequest create() => CreateInventoryItemRequest._();
  CreateInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInventoryItemRequest> createRepeated() => $pb.PbList<CreateInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInventoryItemRequest>(create);
  static CreateInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPrice => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPrice($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get unit => $_getSZ(5);
  @$pb.TagNumber(6)
  set unit($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUnit() => $_has(5);
  @$pb.TagNumber(6)
  void clearUnit() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sku => $_getSZ(6);
  @$pb.TagNumber(7)
  set sku($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSku() => $_has(6);
  @$pb.TagNumber(7)
  void clearSku() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get location => $_getSZ(7);
  @$pb.TagNumber(8)
  set location($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearLocation() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get minimumStockLevel => $_getIZ(8);
  @$pb.TagNumber(9)
  set minimumStockLevel($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinimumStockLevel() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinimumStockLevel() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get notes => $_getSZ(9);
  @$pb.TagNumber(10)
  set notes($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNotes() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotes() => clearField(10);
}

class CreateInventoryItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInventoryItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<InventoryItem>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: InventoryItem.create)
    ..hasRequiredFields = false
  ;

  CreateInventoryItemResponse._() : super();
  factory CreateInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (item != null) {
      _result.item = item;
    }
    return _result;
  }
  factory CreateInventoryItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInventoryItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInventoryItemResponse clone() => CreateInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInventoryItemResponse copyWith(void Function(CreateInventoryItemResponse) updates) => super.copyWith((message) => updates(message as CreateInventoryItemResponse)) as CreateInventoryItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemResponse create() => CreateInventoryItemResponse._();
  CreateInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInventoryItemResponse> createRepeated() => $pb.PbList<CreateInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInventoryItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInventoryItemResponse>(create);
  static CreateInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);
}

class UpdateInventoryItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInventoryItemRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitPrice')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unit')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sku')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location')
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minimumStockLevel', $pb.PbFieldType.O3)
    ..e<InventoryItemStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE, valueOf: InventoryItemStatus.valueOf, enumValues: InventoryItemStatus.values)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  UpdateInventoryItemRequest._() : super();
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
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (unitPrice != null) {
      _result.unitPrice = unitPrice;
    }
    if (unit != null) {
      _result.unit = unit;
    }
    if (sku != null) {
      _result.sku = sku;
    }
    if (location != null) {
      _result.location = location;
    }
    if (minimumStockLevel != null) {
      _result.minimumStockLevel = minimumStockLevel;
    }
    if (status != null) {
      _result.status = status;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory UpdateInventoryItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInventoryItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInventoryItemRequest clone() => UpdateInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInventoryItemRequest copyWith(void Function(UpdateInventoryItemRequest) updates) => super.copyWith((message) => updates(message as UpdateInventoryItemRequest)) as UpdateInventoryItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemRequest create() => UpdateInventoryItemRequest._();
  UpdateInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInventoryItemRequest> createRepeated() => $pb.PbList<UpdateInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInventoryItemRequest>(create);
  static UpdateInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPrice => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPrice($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get unit => $_getSZ(5);
  @$pb.TagNumber(6)
  set unit($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUnit() => $_has(5);
  @$pb.TagNumber(6)
  void clearUnit() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sku => $_getSZ(6);
  @$pb.TagNumber(7)
  set sku($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSku() => $_has(6);
  @$pb.TagNumber(7)
  void clearSku() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get location => $_getSZ(7);
  @$pb.TagNumber(8)
  set location($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearLocation() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get minimumStockLevel => $_getIZ(8);
  @$pb.TagNumber(9)
  set minimumStockLevel($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinimumStockLevel() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinimumStockLevel() => clearField(9);

  @$pb.TagNumber(10)
  InventoryItemStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(InventoryItemStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => clearField(11);
}

class UpdateInventoryItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInventoryItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<InventoryItem>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: InventoryItem.create)
    ..hasRequiredFields = false
  ;

  UpdateInventoryItemResponse._() : super();
  factory UpdateInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (item != null) {
      _result.item = item;
    }
    return _result;
  }
  factory UpdateInventoryItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInventoryItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInventoryItemResponse clone() => UpdateInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInventoryItemResponse copyWith(void Function(UpdateInventoryItemResponse) updates) => super.copyWith((message) => updates(message as UpdateInventoryItemResponse)) as UpdateInventoryItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemResponse create() => UpdateInventoryItemResponse._();
  UpdateInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInventoryItemResponse> createRepeated() => $pb.PbList<UpdateInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInventoryItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInventoryItemResponse>(create);
  static UpdateInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);
}

class DeleteInventoryItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteInventoryItemRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..hasRequiredFields = false
  ;

  DeleteInventoryItemRequest._() : super();
  factory DeleteInventoryItemRequest({
    $core.String? itemId,
  }) {
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    return _result;
  }
  factory DeleteInventoryItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInventoryItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInventoryItemRequest clone() => DeleteInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInventoryItemRequest copyWith(void Function(DeleteInventoryItemRequest) updates) => super.copyWith((message) => updates(message as DeleteInventoryItemRequest)) as DeleteInventoryItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemRequest create() => DeleteInventoryItemRequest._();
  DeleteInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteInventoryItemRequest> createRepeated() => $pb.PbList<DeleteInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteInventoryItemRequest>(create);
  static DeleteInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);
}

class DeleteInventoryItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteInventoryItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteInventoryItemResponse._() : super();
  factory DeleteInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteInventoryItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInventoryItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInventoryItemResponse clone() => DeleteInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInventoryItemResponse copyWith(void Function(DeleteInventoryItemResponse) updates) => super.copyWith((message) => updates(message as DeleteInventoryItemResponse)) as DeleteInventoryItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemResponse create() => DeleteInventoryItemResponse._();
  DeleteInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteInventoryItemResponse> createRepeated() => $pb.PbList<DeleteInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteInventoryItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteInventoryItemResponse>(create);
  static DeleteInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetInventoryItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventoryItemRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..hasRequiredFields = false
  ;

  GetInventoryItemRequest._() : super();
  factory GetInventoryItemRequest({
    $core.String? itemId,
  }) {
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    return _result;
  }
  factory GetInventoryItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventoryItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventoryItemRequest clone() => GetInventoryItemRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventoryItemRequest copyWith(void Function(GetInventoryItemRequest) updates) => super.copyWith((message) => updates(message as GetInventoryItemRequest)) as GetInventoryItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventoryItemRequest create() => GetInventoryItemRequest._();
  GetInventoryItemRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventoryItemRequest> createRepeated() => $pb.PbList<GetInventoryItemRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventoryItemRequest>(create);
  static GetInventoryItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);
}

class GetInventoryItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventoryItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<InventoryItem>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: InventoryItem.create)
    ..hasRequiredFields = false
  ;

  GetInventoryItemResponse._() : super();
  factory GetInventoryItemResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (item != null) {
      _result.item = item;
    }
    return _result;
  }
  factory GetInventoryItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventoryItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventoryItemResponse clone() => GetInventoryItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventoryItemResponse copyWith(void Function(GetInventoryItemResponse) updates) => super.copyWith((message) => updates(message as GetInventoryItemResponse)) as GetInventoryItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventoryItemResponse create() => GetInventoryItemResponse._();
  GetInventoryItemResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventoryItemResponse> createRepeated() => $pb.PbList<GetInventoryItemResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventoryItemResponse>(create);
  static GetInventoryItemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);
}

class ListInventoryItemsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListInventoryItemsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'search')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lowStockOnly')
    ..e<InventoryItemStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE, valueOf: InventoryItemStatus.valueOf, enumValues: InventoryItemStatus.values)
    ..hasRequiredFields = false
  ;

  ListInventoryItemsRequest._() : super();
  factory ListInventoryItemsRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? category,
    $core.String? search,
    $core.bool? lowStockOnly,
    InventoryItemStatus? status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (category != null) {
      _result.category = category;
    }
    if (search != null) {
      _result.search = search;
    }
    if (lowStockOnly != null) {
      _result.lowStockOnly = lowStockOnly;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ListInventoryItemsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListInventoryItemsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListInventoryItemsRequest clone() => ListInventoryItemsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListInventoryItemsRequest copyWith(void Function(ListInventoryItemsRequest) updates) => super.copyWith((message) => updates(message as ListInventoryItemsRequest)) as ListInventoryItemsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsRequest create() => ListInventoryItemsRequest._();
  ListInventoryItemsRequest createEmptyInstance() => create();
  static $pb.PbList<ListInventoryItemsRequest> createRepeated() => $pb.PbList<ListInventoryItemsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInventoryItemsRequest>(create);
  static ListInventoryItemsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get search => $_getSZ(3);
  @$pb.TagNumber(4)
  set search($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSearch() => $_has(3);
  @$pb.TagNumber(4)
  void clearSearch() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get lowStockOnly => $_getBF(4);
  @$pb.TagNumber(5)
  set lowStockOnly($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLowStockOnly() => $_has(4);
  @$pb.TagNumber(5)
  void clearLowStockOnly() => clearField(5);

  @$pb.TagNumber(6)
  InventoryItemStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(InventoryItemStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);
}

class ListInventoryItemsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListInventoryItemsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InventoryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InventoryItem.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListInventoryItemsResponse._() : super();
  factory ListInventoryItemsResponse({
    $core.Iterable<InventoryItem>? items,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListInventoryItemsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListInventoryItemsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListInventoryItemsResponse clone() => ListInventoryItemsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListInventoryItemsResponse copyWith(void Function(ListInventoryItemsResponse) updates) => super.copyWith((message) => updates(message as ListInventoryItemsResponse)) as ListInventoryItemsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsResponse create() => ListInventoryItemsResponse._();
  ListInventoryItemsResponse createEmptyInstance() => create();
  static $pb.PbList<ListInventoryItemsResponse> createRepeated() => $pb.PbList<ListInventoryItemsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListInventoryItemsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInventoryItemsResponse>(create);
  static ListInventoryItemsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InventoryItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class AdjustInventoryQuantityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdjustInventoryQuantityRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..e<AdjustmentType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adjustmentType', $pb.PbFieldType.OE, defaultOrMaker: AdjustmentType.ADJUSTMENT_TYPE_ADD, valueOf: AdjustmentType.valueOf, enumValues: AdjustmentType.values)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  AdjustInventoryQuantityRequest._() : super();
  factory AdjustInventoryQuantityRequest({
    $core.String? itemId,
    AdjustmentType? adjustmentType,
    $core.int? quantity,
    $core.String? reason,
  }) {
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    if (adjustmentType != null) {
      _result.adjustmentType = adjustmentType;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory AdjustInventoryQuantityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdjustInventoryQuantityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdjustInventoryQuantityRequest clone() => AdjustInventoryQuantityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdjustInventoryQuantityRequest copyWith(void Function(AdjustInventoryQuantityRequest) updates) => super.copyWith((message) => updates(message as AdjustInventoryQuantityRequest)) as AdjustInventoryQuantityRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityRequest create() => AdjustInventoryQuantityRequest._();
  AdjustInventoryQuantityRequest createEmptyInstance() => create();
  static $pb.PbList<AdjustInventoryQuantityRequest> createRepeated() => $pb.PbList<AdjustInventoryQuantityRequest>();
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdjustInventoryQuantityRequest>(create);
  static AdjustInventoryQuantityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);

  @$pb.TagNumber(2)
  AdjustmentType get adjustmentType => $_getN(1);
  @$pb.TagNumber(2)
  set adjustmentType(AdjustmentType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdjustmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdjustmentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => clearField(4);
}

class AdjustInventoryQuantityResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdjustInventoryQuantityResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<InventoryItem>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'item', subBuilder: InventoryItem.create)
    ..aOM<InventoryAdjustment>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adjustment', subBuilder: InventoryAdjustment.create)
    ..hasRequiredFields = false
  ;

  AdjustInventoryQuantityResponse._() : super();
  factory AdjustInventoryQuantityResponse({
    $core.bool? success,
    $core.String? message,
    InventoryItem? item,
    InventoryAdjustment? adjustment,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (item != null) {
      _result.item = item;
    }
    if (adjustment != null) {
      _result.adjustment = adjustment;
    }
    return _result;
  }
  factory AdjustInventoryQuantityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdjustInventoryQuantityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdjustInventoryQuantityResponse clone() => AdjustInventoryQuantityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdjustInventoryQuantityResponse copyWith(void Function(AdjustInventoryQuantityResponse) updates) => super.copyWith((message) => updates(message as AdjustInventoryQuantityResponse)) as AdjustInventoryQuantityResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityResponse create() => AdjustInventoryQuantityResponse._();
  AdjustInventoryQuantityResponse createEmptyInstance() => create();
  static $pb.PbList<AdjustInventoryQuantityResponse> createRepeated() => $pb.PbList<AdjustInventoryQuantityResponse>();
  @$core.pragma('dart2js:noInline')
  static AdjustInventoryQuantityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdjustInventoryQuantityResponse>(create);
  static AdjustInventoryQuantityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  InventoryItem get item => $_getN(2);
  @$pb.TagNumber(3)
  set item(InventoryItem v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasItem() => $_has(2);
  @$pb.TagNumber(3)
  void clearItem() => clearField(3);
  @$pb.TagNumber(3)
  InventoryItem ensureItem() => $_ensure(2);

  @$pb.TagNumber(4)
  InventoryAdjustment get adjustment => $_getN(3);
  @$pb.TagNumber(4)
  set adjustment(InventoryAdjustment v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAdjustment() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdjustment() => clearField(4);
  @$pb.TagNumber(4)
  InventoryAdjustment ensureAdjustment() => $_ensure(3);
}

class GetInventoryHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventoryHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInventoryHistoryRequest._() : super();
  factory GetInventoryHistoryRequest({
    $core.String? itemId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetInventoryHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventoryHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventoryHistoryRequest clone() => GetInventoryHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventoryHistoryRequest copyWith(void Function(GetInventoryHistoryRequest) updates) => super.copyWith((message) => updates(message as GetInventoryHistoryRequest)) as GetInventoryHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryRequest create() => GetInventoryHistoryRequest._();
  GetInventoryHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventoryHistoryRequest> createRepeated() => $pb.PbList<GetInventoryHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventoryHistoryRequest>(create);
  static GetInventoryHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetInventoryHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventoryHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InventoryAdjustment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adjustments', $pb.PbFieldType.PM, subBuilder: InventoryAdjustment.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetInventoryHistoryResponse._() : super();
  factory GetInventoryHistoryResponse({
    $core.Iterable<InventoryAdjustment>? adjustments,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (adjustments != null) {
      _result.adjustments.addAll(adjustments);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetInventoryHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventoryHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventoryHistoryResponse clone() => GetInventoryHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventoryHistoryResponse copyWith(void Function(GetInventoryHistoryResponse) updates) => super.copyWith((message) => updates(message as GetInventoryHistoryResponse)) as GetInventoryHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryResponse create() => GetInventoryHistoryResponse._();
  GetInventoryHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventoryHistoryResponse> createRepeated() => $pb.PbList<GetInventoryHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventoryHistoryResponse>(create);
  static GetInventoryHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InventoryAdjustment> get adjustments => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetInventorySummaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventorySummaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInventorySummaryRequest._() : super();
  factory GetInventorySummaryRequest() => create();
  factory GetInventorySummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventorySummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventorySummaryRequest clone() => GetInventorySummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventorySummaryRequest copyWith(void Function(GetInventorySummaryRequest) updates) => super.copyWith((message) => updates(message as GetInventorySummaryRequest)) as GetInventorySummaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryRequest create() => GetInventorySummaryRequest._();
  GetInventorySummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventorySummaryRequest> createRepeated() => $pb.PbList<GetInventorySummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventorySummaryRequest>(create);
  static GetInventorySummaryRequest? _defaultInstance;
}

class GetInventorySummaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventorySummaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lowStockItems', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalInventoryValue')
    ..pc<InventoryCategorySummary>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: InventoryCategorySummary.create)
    ..hasRequiredFields = false
  ;

  GetInventorySummaryResponse._() : super();
  factory GetInventorySummaryResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? totalItems,
    $core.int? lowStockItems,
    $fixnum.Int64? totalInventoryValue,
    $core.Iterable<InventoryCategorySummary>? categories,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (lowStockItems != null) {
      _result.lowStockItems = lowStockItems;
    }
    if (totalInventoryValue != null) {
      _result.totalInventoryValue = totalInventoryValue;
    }
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    return _result;
  }
  factory GetInventorySummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventorySummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventorySummaryResponse clone() => GetInventorySummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventorySummaryResponse copyWith(void Function(GetInventorySummaryResponse) updates) => super.copyWith((message) => updates(message as GetInventorySummaryResponse)) as GetInventorySummaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryResponse create() => GetInventorySummaryResponse._();
  GetInventorySummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventorySummaryResponse> createRepeated() => $pb.PbList<GetInventorySummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventorySummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventorySummaryResponse>(create);
  static GetInventorySummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get lowStockItems => $_getIZ(3);
  @$pb.TagNumber(4)
  set lowStockItems($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLowStockItems() => $_has(3);
  @$pb.TagNumber(4)
  void clearLowStockItems() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalInventoryValue => $_getI64(4);
  @$pb.TagNumber(5)
  set totalInventoryValue($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalInventoryValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalInventoryValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<InventoryCategorySummary> get categories => $_getList(5);
}

class Customer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Customer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tin')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccountNumber')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..e<CustomerSegment>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'segment', $pb.PbFieldType.OE, defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE, valueOf: CustomerSegment.valueOf, enumValues: CustomerSegment.values)
    ..e<CustomerStatus>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CustomerStatus.CUSTOMER_STATUS_ACTIVE, valueOf: CustomerStatus.valueOf, enumValues: CustomerStatus.values)
    ..pPS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOM<$1.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Customer._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (businessName != null) {
      _result.businessName = businessName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (address != null) {
      _result.address = address;
    }
    if (city != null) {
      _result.city = city;
    }
    if (state != null) {
      _result.state = state;
    }
    if (country != null) {
      _result.country = country;
    }
    if (tin != null) {
      _result.tin = tin;
    }
    if (bankAccountNumber != null) {
      _result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (segment != null) {
      _result.segment = segment;
    }
    if (status != null) {
      _result.status = status;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Customer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Customer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Customer clone() => Customer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Customer copyWith(void Function(Customer) updates) => super.copyWith((message) => updates(message as Customer)) as Customer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Customer create() => Customer._();
  Customer createEmptyInstance() => create();
  static $pb.PbList<Customer> createRepeated() => $pb.PbList<Customer>();
  @$core.pragma('dart2js:noInline')
  static Customer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Customer>(create);
  static Customer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get businessName => $_getSZ(3);
  @$pb.TagNumber(4)
  set businessName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBusinessName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBusinessName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get address => $_getSZ(6);
  @$pb.TagNumber(7)
  set address($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearAddress() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get city => $_getSZ(7);
  @$pb.TagNumber(8)
  set city($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCity() => $_has(7);
  @$pb.TagNumber(8)
  void clearCity() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get state => $_getSZ(8);
  @$pb.TagNumber(9)
  set state($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasState() => $_has(8);
  @$pb.TagNumber(9)
  void clearState() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get country => $_getSZ(9);
  @$pb.TagNumber(10)
  set country($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCountry() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountry() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get tin => $_getSZ(10);
  @$pb.TagNumber(11)
  set tin($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTin() => $_has(10);
  @$pb.TagNumber(11)
  void clearTin() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankAccountNumber => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankAccountNumber($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBankAccountNumber() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankAccountNumber() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get bankCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set bankCode($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBankCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearBankCode() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get bankName => $_getSZ(13);
  @$pb.TagNumber(14)
  set bankName($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasBankName() => $_has(13);
  @$pb.TagNumber(14)
  void clearBankName() => clearField(14);

  @$pb.TagNumber(15)
  CustomerSegment get segment => $_getN(14);
  @$pb.TagNumber(15)
  set segment(CustomerSegment v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasSegment() => $_has(14);
  @$pb.TagNumber(15)
  void clearSegment() => clearField(15);

  @$pb.TagNumber(16)
  CustomerStatus get status => $_getN(15);
  @$pb.TagNumber(16)
  set status(CustomerStatus v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasStatus() => $_has(15);
  @$pb.TagNumber(16)
  void clearStatus() => clearField(16);

  @$pb.TagNumber(17)
  $core.List<$core.String> get tags => $_getList(16);

  @$pb.TagNumber(18)
  $core.String get notes => $_getSZ(17);
  @$pb.TagNumber(18)
  set notes($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNotes() => $_has(17);
  @$pb.TagNumber(18)
  void clearNotes() => clearField(18);

  @$pb.TagNumber(19)
  $1.Timestamp get createdAt => $_getN(18);
  @$pb.TagNumber(19)
  set createdAt($1.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureCreatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $1.Timestamp get updatedAt => $_getN(19);
  @$pb.TagNumber(20)
  set updatedAt($1.Timestamp v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => clearField(20);
  @$pb.TagNumber(20)
  $1.Timestamp ensureUpdatedAt() => $_ensure(19);
}

class CustomerFinancialProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CustomerFinancialProfile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalInvoiced')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPaid')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outstanding')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avgPaymentDays', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalInvoices', $pb.PbFieldType.O3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidInvoices', $pb.PbFieldType.O3)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overdueInvoices', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastPaymentDate', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CustomerFinancialProfile._() : super();
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
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (totalInvoiced != null) {
      _result.totalInvoiced = totalInvoiced;
    }
    if (totalPaid != null) {
      _result.totalPaid = totalPaid;
    }
    if (outstanding != null) {
      _result.outstanding = outstanding;
    }
    if (avgPaymentDays != null) {
      _result.avgPaymentDays = avgPaymentDays;
    }
    if (totalInvoices != null) {
      _result.totalInvoices = totalInvoices;
    }
    if (paidInvoices != null) {
      _result.paidInvoices = paidInvoices;
    }
    if (overdueInvoices != null) {
      _result.overdueInvoices = overdueInvoices;
    }
    if (lastPaymentDate != null) {
      _result.lastPaymentDate = lastPaymentDate;
    }
    return _result;
  }
  factory CustomerFinancialProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomerFinancialProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomerFinancialProfile clone() => CustomerFinancialProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomerFinancialProfile copyWith(void Function(CustomerFinancialProfile) updates) => super.copyWith((message) => updates(message as CustomerFinancialProfile)) as CustomerFinancialProfile; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CustomerFinancialProfile create() => CustomerFinancialProfile._();
  CustomerFinancialProfile createEmptyInstance() => create();
  static $pb.PbList<CustomerFinancialProfile> createRepeated() => $pb.PbList<CustomerFinancialProfile>();
  @$core.pragma('dart2js:noInline')
  static CustomerFinancialProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomerFinancialProfile>(create);
  static CustomerFinancialProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get totalInvoiced => $_getI64(1);
  @$pb.TagNumber(2)
  set totalInvoiced($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalInvoiced() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalInvoiced() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalPaid => $_getI64(2);
  @$pb.TagNumber(3)
  set totalPaid($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPaid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaid() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get outstanding => $_getI64(3);
  @$pb.TagNumber(4)
  set outstanding($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutstanding() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutstanding() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get avgPaymentDays => $_getIZ(4);
  @$pb.TagNumber(5)
  set avgPaymentDays($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAvgPaymentDays() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvgPaymentDays() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get totalInvoices => $_getIZ(5);
  @$pb.TagNumber(6)
  set totalInvoices($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalInvoices() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalInvoices() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get paidInvoices => $_getIZ(6);
  @$pb.TagNumber(7)
  set paidInvoices($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaidInvoices() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaidInvoices() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get overdueInvoices => $_getIZ(7);
  @$pb.TagNumber(8)
  set overdueInvoices($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOverdueInvoices() => $_has(7);
  @$pb.TagNumber(8)
  void clearOverdueInvoices() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get lastPaymentDate => $_getN(8);
  @$pb.TagNumber(9)
  set lastPaymentDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasLastPaymentDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearLastPaymentDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureLastPaymentDate() => $_ensure(8);
}

class CustomerNote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CustomerNote', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdBy')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CustomerNote._() : super();
  factory CustomerNote({
    $core.String? id,
    $core.String? customerId,
    $core.String? businessId,
    $core.String? content,
    $core.String? createdBy,
    $1.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (content != null) {
      _result.content = content;
    }
    if (createdBy != null) {
      _result.createdBy = createdBy;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory CustomerNote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomerNote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomerNote clone() => CustomerNote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomerNote copyWith(void Function(CustomerNote) updates) => super.copyWith((message) => updates(message as CustomerNote)) as CustomerNote; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CustomerNote create() => CustomerNote._();
  CustomerNote createEmptyInstance() => create();
  static $pb.PbList<CustomerNote> createRepeated() => $pb.PbList<CustomerNote>();
  @$core.pragma('dart2js:noInline')
  static CustomerNote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomerNote>(create);
  static CustomerNote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get customerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set customerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessId => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBusinessId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdBy => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdBy($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedBy() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedBy() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);
}

class CustomerStatementEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CustomerStatementEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance')
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CustomerStatementEntry._() : super();
  factory CustomerStatementEntry({
    $core.String? id,
    $core.String? type,
    $core.String? reference,
    $core.String? description,
    $fixnum.Int64? amount,
    $fixnum.Int64? balance,
    $1.Timestamp? date,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (date != null) {
      _result.date = date;
    }
    return _result;
  }
  factory CustomerStatementEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomerStatementEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomerStatementEntry clone() => CustomerStatementEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomerStatementEntry copyWith(void Function(CustomerStatementEntry) updates) => super.copyWith((message) => updates(message as CustomerStatementEntry)) as CustomerStatementEntry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CustomerStatementEntry create() => CustomerStatementEntry._();
  CustomerStatementEntry createEmptyInstance() => create();
  static $pb.PbList<CustomerStatementEntry> createRepeated() => $pb.PbList<CustomerStatementEntry>();
  @$core.pragma('dart2js:noInline')
  static CustomerStatementEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomerStatementEntry>(create);
  static CustomerStatementEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get balance => $_getI64(5);
  @$pb.TagNumber(6)
  set balance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearBalance() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get date => $_getN(6);
  @$pb.TagNumber(7)
  set date($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDate() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDate() => $_ensure(6);
}

class CustomerSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CustomerSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCustomers', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeCustomers', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vipCustomers', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overdueCustomers', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalOutstanding')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRevenue')
    ..hasRequiredFields = false
  ;

  CustomerSummary._() : super();
  factory CustomerSummary({
    $core.int? totalCustomers,
    $core.int? activeCustomers,
    $core.int? vipCustomers,
    $core.int? overdueCustomers,
    $fixnum.Int64? totalOutstanding,
    $fixnum.Int64? totalRevenue,
  }) {
    final _result = create();
    if (totalCustomers != null) {
      _result.totalCustomers = totalCustomers;
    }
    if (activeCustomers != null) {
      _result.activeCustomers = activeCustomers;
    }
    if (vipCustomers != null) {
      _result.vipCustomers = vipCustomers;
    }
    if (overdueCustomers != null) {
      _result.overdueCustomers = overdueCustomers;
    }
    if (totalOutstanding != null) {
      _result.totalOutstanding = totalOutstanding;
    }
    if (totalRevenue != null) {
      _result.totalRevenue = totalRevenue;
    }
    return _result;
  }
  factory CustomerSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomerSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomerSummary clone() => CustomerSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomerSummary copyWith(void Function(CustomerSummary) updates) => super.copyWith((message) => updates(message as CustomerSummary)) as CustomerSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CustomerSummary create() => CustomerSummary._();
  CustomerSummary createEmptyInstance() => create();
  static $pb.PbList<CustomerSummary> createRepeated() => $pb.PbList<CustomerSummary>();
  @$core.pragma('dart2js:noInline')
  static CustomerSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomerSummary>(create);
  static CustomerSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalCustomers => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalCustomers($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalCustomers() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalCustomers() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get activeCustomers => $_getIZ(1);
  @$pb.TagNumber(2)
  set activeCustomers($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveCustomers() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveCustomers() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get vipCustomers => $_getIZ(2);
  @$pb.TagNumber(3)
  set vipCustomers($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVipCustomers() => $_has(2);
  @$pb.TagNumber(3)
  void clearVipCustomers() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get overdueCustomers => $_getIZ(3);
  @$pb.TagNumber(4)
  set overdueCustomers($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOverdueCustomers() => $_has(3);
  @$pb.TagNumber(4)
  void clearOverdueCustomers() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalOutstanding => $_getI64(4);
  @$pb.TagNumber(5)
  set totalOutstanding($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalOutstanding() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalOutstanding() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalRevenue => $_getI64(5);
  @$pb.TagNumber(6)
  set totalRevenue($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalRevenue() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalRevenue() => clearField(6);
}

class CreateCustomerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCustomerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tin')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccountNumber')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..e<CustomerSegment>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'segment', $pb.PbFieldType.OE, defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE, valueOf: CustomerSegment.valueOf, enumValues: CustomerSegment.values)
    ..pPS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  CreateCustomerRequest._() : super();
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
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (businessName != null) {
      _result.businessName = businessName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (address != null) {
      _result.address = address;
    }
    if (city != null) {
      _result.city = city;
    }
    if (state != null) {
      _result.state = state;
    }
    if (country != null) {
      _result.country = country;
    }
    if (tin != null) {
      _result.tin = tin;
    }
    if (bankAccountNumber != null) {
      _result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (segment != null) {
      _result.segment = segment;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory CreateCustomerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCustomerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateCustomerRequest clone() => CreateCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateCustomerRequest copyWith(void Function(CreateCustomerRequest) updates) => super.copyWith((message) => updates(message as CreateCustomerRequest)) as CreateCustomerRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateCustomerRequest create() => CreateCustomerRequest._();
  CreateCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<CreateCustomerRequest> createRepeated() => $pb.PbList<CreateCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateCustomerRequest>(create);
  static CreateCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessName => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get address => $_getSZ(4);
  @$pb.TagNumber(5)
  set address($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddress() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get city => $_getSZ(5);
  @$pb.TagNumber(6)
  set city($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCity() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get state => $_getSZ(6);
  @$pb.TagNumber(7)
  set state($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasState() => $_has(6);
  @$pb.TagNumber(7)
  void clearState() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get country => $_getSZ(7);
  @$pb.TagNumber(8)
  set country($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountry() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get tin => $_getSZ(8);
  @$pb.TagNumber(9)
  set tin($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTin() => $_has(8);
  @$pb.TagNumber(9)
  void clearTin() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get bankAccountNumber => $_getSZ(9);
  @$pb.TagNumber(10)
  set bankAccountNumber($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBankAccountNumber() => $_has(9);
  @$pb.TagNumber(10)
  void clearBankAccountNumber() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankCode => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankCode($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBankCode() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankCode() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankName => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBankName() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankName() => clearField(12);

  @$pb.TagNumber(13)
  CustomerSegment get segment => $_getN(12);
  @$pb.TagNumber(13)
  set segment(CustomerSegment v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasSegment() => $_has(12);
  @$pb.TagNumber(13)
  void clearSegment() => clearField(13);

  @$pb.TagNumber(14)
  $core.List<$core.String> get tags => $_getList(13);

  @$pb.TagNumber(15)
  $core.String get notes => $_getSZ(14);
  @$pb.TagNumber(15)
  set notes($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasNotes() => $_has(14);
  @$pb.TagNumber(15)
  void clearNotes() => clearField(15);
}

class CreateCustomerResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateCustomerResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Customer>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customer', subBuilder: Customer.create)
    ..hasRequiredFields = false
  ;

  CreateCustomerResponse._() : super();
  factory CreateCustomerResponse({
    $core.bool? success,
    $core.String? message,
    Customer? customer,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (customer != null) {
      _result.customer = customer;
    }
    return _result;
  }
  factory CreateCustomerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateCustomerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateCustomerResponse clone() => CreateCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateCustomerResponse copyWith(void Function(CreateCustomerResponse) updates) => super.copyWith((message) => updates(message as CreateCustomerResponse)) as CreateCustomerResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateCustomerResponse create() => CreateCustomerResponse._();
  CreateCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<CreateCustomerResponse> createRepeated() => $pb.PbList<CreateCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateCustomerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateCustomerResponse>(create);
  static CreateCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Customer get customer => $_getN(2);
  @$pb.TagNumber(3)
  set customer(Customer v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomer() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomer() => clearField(3);
  @$pb.TagNumber(3)
  Customer ensureCustomer() => $_ensure(2);
}

class UpdateCustomerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCustomerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tin')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankAccountNumber')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..e<CustomerSegment>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'segment', $pb.PbFieldType.OE, defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE, valueOf: CustomerSegment.valueOf, enumValues: CustomerSegment.values)
    ..e<CustomerStatus>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CustomerStatus.CUSTOMER_STATUS_ACTIVE, valueOf: CustomerStatus.valueOf, enumValues: CustomerStatus.values)
    ..pPS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  UpdateCustomerRequest._() : super();
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
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (businessName != null) {
      _result.businessName = businessName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (address != null) {
      _result.address = address;
    }
    if (city != null) {
      _result.city = city;
    }
    if (state != null) {
      _result.state = state;
    }
    if (country != null) {
      _result.country = country;
    }
    if (tin != null) {
      _result.tin = tin;
    }
    if (bankAccountNumber != null) {
      _result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (segment != null) {
      _result.segment = segment;
    }
    if (status != null) {
      _result.status = status;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory UpdateCustomerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCustomerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCustomerRequest clone() => UpdateCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCustomerRequest copyWith(void Function(UpdateCustomerRequest) updates) => super.copyWith((message) => updates(message as UpdateCustomerRequest)) as UpdateCustomerRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateCustomerRequest create() => UpdateCustomerRequest._();
  UpdateCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCustomerRequest> createRepeated() => $pb.PbList<UpdateCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCustomerRequest>(create);
  static UpdateCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get businessName => $_getSZ(2);
  @$pb.TagNumber(3)
  set businessName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBusinessName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBusinessName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get address => $_getSZ(5);
  @$pb.TagNumber(6)
  set address($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get city => $_getSZ(6);
  @$pb.TagNumber(7)
  set city($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCity() => $_has(6);
  @$pb.TagNumber(7)
  void clearCity() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get state => $_getSZ(7);
  @$pb.TagNumber(8)
  set state($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasState() => $_has(7);
  @$pb.TagNumber(8)
  void clearState() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get country => $_getSZ(8);
  @$pb.TagNumber(9)
  set country($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCountry() => $_has(8);
  @$pb.TagNumber(9)
  void clearCountry() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get tin => $_getSZ(9);
  @$pb.TagNumber(10)
  set tin($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTin() => $_has(9);
  @$pb.TagNumber(10)
  void clearTin() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get bankAccountNumber => $_getSZ(10);
  @$pb.TagNumber(11)
  set bankAccountNumber($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBankAccountNumber() => $_has(10);
  @$pb.TagNumber(11)
  void clearBankAccountNumber() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get bankCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set bankCode($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBankCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearBankCode() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get bankName => $_getSZ(12);
  @$pb.TagNumber(13)
  set bankName($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBankName() => $_has(12);
  @$pb.TagNumber(13)
  void clearBankName() => clearField(13);

  @$pb.TagNumber(14)
  CustomerSegment get segment => $_getN(13);
  @$pb.TagNumber(14)
  set segment(CustomerSegment v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasSegment() => $_has(13);
  @$pb.TagNumber(14)
  void clearSegment() => clearField(14);

  @$pb.TagNumber(15)
  CustomerStatus get status => $_getN(14);
  @$pb.TagNumber(15)
  set status(CustomerStatus v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => clearField(15);

  @$pb.TagNumber(16)
  $core.List<$core.String> get tags => $_getList(15);

  @$pb.TagNumber(17)
  $core.String get notes => $_getSZ(16);
  @$pb.TagNumber(17)
  set notes($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasNotes() => $_has(16);
  @$pb.TagNumber(17)
  void clearNotes() => clearField(17);
}

class UpdateCustomerResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCustomerResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Customer>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customer', subBuilder: Customer.create)
    ..hasRequiredFields = false
  ;

  UpdateCustomerResponse._() : super();
  factory UpdateCustomerResponse({
    $core.bool? success,
    $core.String? message,
    Customer? customer,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (customer != null) {
      _result.customer = customer;
    }
    return _result;
  }
  factory UpdateCustomerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCustomerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCustomerResponse clone() => UpdateCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCustomerResponse copyWith(void Function(UpdateCustomerResponse) updates) => super.copyWith((message) => updates(message as UpdateCustomerResponse)) as UpdateCustomerResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateCustomerResponse create() => UpdateCustomerResponse._();
  UpdateCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCustomerResponse> createRepeated() => $pb.PbList<UpdateCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCustomerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCustomerResponse>(create);
  static UpdateCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Customer get customer => $_getN(2);
  @$pb.TagNumber(3)
  set customer(Customer v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomer() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomer() => clearField(3);
  @$pb.TagNumber(3)
  Customer ensureCustomer() => $_ensure(2);
}

class DeleteCustomerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteCustomerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..hasRequiredFields = false
  ;

  DeleteCustomerRequest._() : super();
  factory DeleteCustomerRequest({
    $core.String? customerId,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    return _result;
  }
  factory DeleteCustomerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteCustomerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteCustomerRequest clone() => DeleteCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteCustomerRequest copyWith(void Function(DeleteCustomerRequest) updates) => super.copyWith((message) => updates(message as DeleteCustomerRequest)) as DeleteCustomerRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteCustomerRequest create() => DeleteCustomerRequest._();
  DeleteCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomerRequest> createRepeated() => $pb.PbList<DeleteCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteCustomerRequest>(create);
  static DeleteCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);
}

class DeleteCustomerResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteCustomerResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteCustomerResponse._() : super();
  factory DeleteCustomerResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteCustomerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteCustomerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteCustomerResponse clone() => DeleteCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteCustomerResponse copyWith(void Function(DeleteCustomerResponse) updates) => super.copyWith((message) => updates(message as DeleteCustomerResponse)) as DeleteCustomerResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteCustomerResponse create() => DeleteCustomerResponse._();
  DeleteCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteCustomerResponse> createRepeated() => $pb.PbList<DeleteCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteCustomerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteCustomerResponse>(create);
  static DeleteCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetCustomerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..hasRequiredFields = false
  ;

  GetCustomerRequest._() : super();
  factory GetCustomerRequest({
    $core.String? customerId,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    return _result;
  }
  factory GetCustomerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerRequest clone() => GetCustomerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerRequest copyWith(void Function(GetCustomerRequest) updates) => super.copyWith((message) => updates(message as GetCustomerRequest)) as GetCustomerRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerRequest create() => GetCustomerRequest._();
  GetCustomerRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerRequest> createRepeated() => $pb.PbList<GetCustomerRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerRequest>(create);
  static GetCustomerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);
}

class GetCustomerResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Customer>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customer', subBuilder: Customer.create)
    ..hasRequiredFields = false
  ;

  GetCustomerResponse._() : super();
  factory GetCustomerResponse({
    $core.bool? success,
    $core.String? message,
    Customer? customer,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (customer != null) {
      _result.customer = customer;
    }
    return _result;
  }
  factory GetCustomerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerResponse clone() => GetCustomerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerResponse copyWith(void Function(GetCustomerResponse) updates) => super.copyWith((message) => updates(message as GetCustomerResponse)) as GetCustomerResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerResponse create() => GetCustomerResponse._();
  GetCustomerResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerResponse> createRepeated() => $pb.PbList<GetCustomerResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerResponse>(create);
  static GetCustomerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Customer get customer => $_getN(2);
  @$pb.TagNumber(3)
  set customer(Customer v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomer() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomer() => clearField(3);
  @$pb.TagNumber(3)
  Customer ensureCustomer() => $_ensure(2);
}

class ListCustomersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListCustomersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'search')
    ..e<CustomerSegment>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'segment', $pb.PbFieldType.OE, defaultOrMaker: CustomerSegment.CUSTOMER_SEGMENT_NONE, valueOf: CustomerSegment.valueOf, enumValues: CustomerSegment.values)
    ..e<CustomerStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CustomerStatus.CUSTOMER_STATUS_ACTIVE, valueOf: CustomerStatus.valueOf, enumValues: CustomerStatus.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag')
    ..hasRequiredFields = false
  ;

  ListCustomersRequest._() : super();
  factory ListCustomersRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? search,
    CustomerSegment? segment,
    CustomerStatus? status,
    $core.String? tag,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (search != null) {
      _result.search = search;
    }
    if (segment != null) {
      _result.segment = segment;
    }
    if (status != null) {
      _result.status = status;
    }
    if (tag != null) {
      _result.tag = tag;
    }
    return _result;
  }
  factory ListCustomersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCustomersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCustomersRequest clone() => ListCustomersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCustomersRequest copyWith(void Function(ListCustomersRequest) updates) => super.copyWith((message) => updates(message as ListCustomersRequest)) as ListCustomersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListCustomersRequest create() => ListCustomersRequest._();
  ListCustomersRequest createEmptyInstance() => create();
  static $pb.PbList<ListCustomersRequest> createRepeated() => $pb.PbList<ListCustomersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCustomersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCustomersRequest>(create);
  static ListCustomersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => clearField(3);

  @$pb.TagNumber(4)
  CustomerSegment get segment => $_getN(3);
  @$pb.TagNumber(4)
  set segment(CustomerSegment v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSegment() => $_has(3);
  @$pb.TagNumber(4)
  void clearSegment() => clearField(4);

  @$pb.TagNumber(5)
  CustomerStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(CustomerStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get tag => $_getSZ(5);
  @$pb.TagNumber(6)
  set tag($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTag() => $_has(5);
  @$pb.TagNumber(6)
  void clearTag() => clearField(6);
}

class ListCustomersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListCustomersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Customer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customers', $pb.PbFieldType.PM, subBuilder: Customer.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListCustomersResponse._() : super();
  factory ListCustomersResponse({
    $core.Iterable<Customer>? customers,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (customers != null) {
      _result.customers.addAll(customers);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListCustomersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCustomersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCustomersResponse clone() => ListCustomersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCustomersResponse copyWith(void Function(ListCustomersResponse) updates) => super.copyWith((message) => updates(message as ListCustomersResponse)) as ListCustomersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListCustomersResponse create() => ListCustomersResponse._();
  ListCustomersResponse createEmptyInstance() => create();
  static $pb.PbList<ListCustomersResponse> createRepeated() => $pb.PbList<ListCustomersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCustomersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCustomersResponse>(create);
  static ListCustomersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Customer> get customers => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetCustomerFinancialProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerFinancialProfileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..hasRequiredFields = false
  ;

  GetCustomerFinancialProfileRequest._() : super();
  factory GetCustomerFinancialProfileRequest({
    $core.String? customerId,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    return _result;
  }
  factory GetCustomerFinancialProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerFinancialProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerFinancialProfileRequest clone() => GetCustomerFinancialProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerFinancialProfileRequest copyWith(void Function(GetCustomerFinancialProfileRequest) updates) => super.copyWith((message) => updates(message as GetCustomerFinancialProfileRequest)) as GetCustomerFinancialProfileRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileRequest create() => GetCustomerFinancialProfileRequest._();
  GetCustomerFinancialProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerFinancialProfileRequest> createRepeated() => $pb.PbList<GetCustomerFinancialProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerFinancialProfileRequest>(create);
  static GetCustomerFinancialProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);
}

class GetCustomerFinancialProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerFinancialProfileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<CustomerFinancialProfile>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profile', subBuilder: CustomerFinancialProfile.create)
    ..hasRequiredFields = false
  ;

  GetCustomerFinancialProfileResponse._() : super();
  factory GetCustomerFinancialProfileResponse({
    $core.bool? success,
    $core.String? message,
    CustomerFinancialProfile? profile,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (profile != null) {
      _result.profile = profile;
    }
    return _result;
  }
  factory GetCustomerFinancialProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerFinancialProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerFinancialProfileResponse clone() => GetCustomerFinancialProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerFinancialProfileResponse copyWith(void Function(GetCustomerFinancialProfileResponse) updates) => super.copyWith((message) => updates(message as GetCustomerFinancialProfileResponse)) as GetCustomerFinancialProfileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileResponse create() => GetCustomerFinancialProfileResponse._();
  GetCustomerFinancialProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerFinancialProfileResponse> createRepeated() => $pb.PbList<GetCustomerFinancialProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerFinancialProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerFinancialProfileResponse>(create);
  static GetCustomerFinancialProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  CustomerFinancialProfile get profile => $_getN(2);
  @$pb.TagNumber(3)
  set profile(CustomerFinancialProfile v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProfile() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfile() => clearField(3);
  @$pb.TagNumber(3)
  CustomerFinancialProfile ensureProfile() => $_ensure(2);
}

class GetCustomerSummaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerSummaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetCustomerSummaryRequest._() : super();
  factory GetCustomerSummaryRequest() => create();
  factory GetCustomerSummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerSummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerSummaryRequest clone() => GetCustomerSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerSummaryRequest copyWith(void Function(GetCustomerSummaryRequest) updates) => super.copyWith((message) => updates(message as GetCustomerSummaryRequest)) as GetCustomerSummaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryRequest create() => GetCustomerSummaryRequest._();
  GetCustomerSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerSummaryRequest> createRepeated() => $pb.PbList<GetCustomerSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerSummaryRequest>(create);
  static GetCustomerSummaryRequest? _defaultInstance;
}

class GetCustomerSummaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerSummaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<CustomerSummary>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'summary', subBuilder: CustomerSummary.create)
    ..hasRequiredFields = false
  ;

  GetCustomerSummaryResponse._() : super();
  factory GetCustomerSummaryResponse({
    $core.bool? success,
    $core.String? message,
    CustomerSummary? summary,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (summary != null) {
      _result.summary = summary;
    }
    return _result;
  }
  factory GetCustomerSummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerSummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerSummaryResponse clone() => GetCustomerSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerSummaryResponse copyWith(void Function(GetCustomerSummaryResponse) updates) => super.copyWith((message) => updates(message as GetCustomerSummaryResponse)) as GetCustomerSummaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryResponse create() => GetCustomerSummaryResponse._();
  GetCustomerSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerSummaryResponse> createRepeated() => $pb.PbList<GetCustomerSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerSummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerSummaryResponse>(create);
  static GetCustomerSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  CustomerSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(CustomerSummary v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => clearField(3);
  @$pb.TagNumber(3)
  CustomerSummary ensureSummary() => $_ensure(2);
}

class AddCustomerNoteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddCustomerNoteRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'content')
    ..hasRequiredFields = false
  ;

  AddCustomerNoteRequest._() : super();
  factory AddCustomerNoteRequest({
    $core.String? customerId,
    $core.String? content,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory AddCustomerNoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddCustomerNoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddCustomerNoteRequest clone() => AddCustomerNoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddCustomerNoteRequest copyWith(void Function(AddCustomerNoteRequest) updates) => super.copyWith((message) => updates(message as AddCustomerNoteRequest)) as AddCustomerNoteRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteRequest create() => AddCustomerNoteRequest._();
  AddCustomerNoteRequest createEmptyInstance() => create();
  static $pb.PbList<AddCustomerNoteRequest> createRepeated() => $pb.PbList<AddCustomerNoteRequest>();
  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddCustomerNoteRequest>(create);
  static AddCustomerNoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);
}

class AddCustomerNoteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddCustomerNoteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<CustomerNote>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note', subBuilder: CustomerNote.create)
    ..hasRequiredFields = false
  ;

  AddCustomerNoteResponse._() : super();
  factory AddCustomerNoteResponse({
    $core.bool? success,
    $core.String? message,
    CustomerNote? note,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (note != null) {
      _result.note = note;
    }
    return _result;
  }
  factory AddCustomerNoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddCustomerNoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddCustomerNoteResponse clone() => AddCustomerNoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddCustomerNoteResponse copyWith(void Function(AddCustomerNoteResponse) updates) => super.copyWith((message) => updates(message as AddCustomerNoteResponse)) as AddCustomerNoteResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteResponse create() => AddCustomerNoteResponse._();
  AddCustomerNoteResponse createEmptyInstance() => create();
  static $pb.PbList<AddCustomerNoteResponse> createRepeated() => $pb.PbList<AddCustomerNoteResponse>();
  @$core.pragma('dart2js:noInline')
  static AddCustomerNoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddCustomerNoteResponse>(create);
  static AddCustomerNoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  CustomerNote get note => $_getN(2);
  @$pb.TagNumber(3)
  set note(CustomerNote v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearNote() => clearField(3);
  @$pb.TagNumber(3)
  CustomerNote ensureNote() => $_ensure(2);
}

class ListCustomerNotesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListCustomerNotesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListCustomerNotesRequest._() : super();
  factory ListCustomerNotesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory ListCustomerNotesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCustomerNotesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCustomerNotesRequest clone() => ListCustomerNotesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCustomerNotesRequest copyWith(void Function(ListCustomerNotesRequest) updates) => super.copyWith((message) => updates(message as ListCustomerNotesRequest)) as ListCustomerNotesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesRequest create() => ListCustomerNotesRequest._();
  ListCustomerNotesRequest createEmptyInstance() => create();
  static $pb.PbList<ListCustomerNotesRequest> createRepeated() => $pb.PbList<ListCustomerNotesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCustomerNotesRequest>(create);
  static ListCustomerNotesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class ListCustomerNotesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListCustomerNotesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CustomerNote>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes', $pb.PbFieldType.PM, subBuilder: CustomerNote.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListCustomerNotesResponse._() : super();
  factory ListCustomerNotesResponse({
    $core.Iterable<CustomerNote>? notes,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (notes != null) {
      _result.notes.addAll(notes);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListCustomerNotesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListCustomerNotesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListCustomerNotesResponse clone() => ListCustomerNotesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListCustomerNotesResponse copyWith(void Function(ListCustomerNotesResponse) updates) => super.copyWith((message) => updates(message as ListCustomerNotesResponse)) as ListCustomerNotesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesResponse create() => ListCustomerNotesResponse._();
  ListCustomerNotesResponse createEmptyInstance() => create();
  static $pb.PbList<ListCustomerNotesResponse> createRepeated() => $pb.PbList<ListCustomerNotesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListCustomerNotesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListCustomerNotesResponse>(create);
  static ListCustomerNotesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CustomerNote> get notes => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class GetCustomerStatementRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerStatementRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  GetCustomerStatementRequest._() : super();
  factory GetCustomerStatementRequest({
    $core.String? customerId,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetCustomerStatementRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerStatementRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerStatementRequest clone() => GetCustomerStatementRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerStatementRequest copyWith(void Function(GetCustomerStatementRequest) updates) => super.copyWith((message) => updates(message as GetCustomerStatementRequest)) as GetCustomerStatementRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementRequest create() => GetCustomerStatementRequest._();
  GetCustomerStatementRequest createEmptyInstance() => create();
  static $pb.PbList<GetCustomerStatementRequest> createRepeated() => $pb.PbList<GetCustomerStatementRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerStatementRequest>(create);
  static GetCustomerStatementRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get endDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set endDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);
}

class GetCustomerStatementResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCustomerStatementResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<CustomerStatementEntry>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: CustomerStatementEntry.create)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'openingBalance')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'closingBalance')
    ..hasRequiredFields = false
  ;

  GetCustomerStatementResponse._() : super();
  factory GetCustomerStatementResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<CustomerStatementEntry>? entries,
    $fixnum.Int64? openingBalance,
    $fixnum.Int64? closingBalance,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (openingBalance != null) {
      _result.openingBalance = openingBalance;
    }
    if (closingBalance != null) {
      _result.closingBalance = closingBalance;
    }
    return _result;
  }
  factory GetCustomerStatementResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCustomerStatementResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCustomerStatementResponse clone() => GetCustomerStatementResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCustomerStatementResponse copyWith(void Function(GetCustomerStatementResponse) updates) => super.copyWith((message) => updates(message as GetCustomerStatementResponse)) as GetCustomerStatementResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementResponse create() => GetCustomerStatementResponse._();
  GetCustomerStatementResponse createEmptyInstance() => create();
  static $pb.PbList<GetCustomerStatementResponse> createRepeated() => $pb.PbList<GetCustomerStatementResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCustomerStatementResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCustomerStatementResponse>(create);
  static GetCustomerStatementResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<CustomerStatementEntry> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get openingBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set openingBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOpeningBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearOpeningBalance() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get closingBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set closingBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasClosingBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearClosingBalance() => clearField(5);
}

class TaxObligation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaxObligation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..e<TaxType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxType', $pb.PbFieldType.OE, defaultOrMaker: TaxType.TAX_TYPE_VAT, valueOf: TaxType.valueOf, enumValues: TaxType.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..e<TaxObligationStatus>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING, valueOf: TaxObligationStatus.valueOf, enumValues: TaxObligationStatus.values)
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filedDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidDate', subBuilder: $1.Timestamp.create)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOM<$1.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TaxObligation._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (taxType != null) {
      _result.taxType = taxType;
    }
    if (period != null) {
      _result.period = period;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (filedDate != null) {
      _result.filedDate = filedDate;
    }
    if (paidDate != null) {
      _result.paidDate = paidDate;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory TaxObligation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaxObligation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaxObligation clone() => TaxObligation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaxObligation copyWith(void Function(TaxObligation) updates) => super.copyWith((message) => updates(message as TaxObligation)) as TaxObligation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaxObligation create() => TaxObligation._();
  TaxObligation createEmptyInstance() => create();
  static $pb.PbList<TaxObligation> createRepeated() => $pb.PbList<TaxObligation>();
  @$core.pragma('dart2js:noInline')
  static TaxObligation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaxObligation>(create);
  static TaxObligation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  TaxType get taxType => $_getN(2);
  @$pb.TagNumber(3)
  set taxType(TaxType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTaxType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaxType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get period => $_getSZ(3);
  @$pb.TagNumber(4)
  set period($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPeriod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPeriod() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  TaxObligationStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(TaxObligationStatus v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get dueDate => $_getN(6);
  @$pb.TagNumber(7)
  set dueDate($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDueDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearDueDate() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureDueDate() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get filedDate => $_getN(7);
  @$pb.TagNumber(8)
  set filedDate($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasFiledDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFiledDate() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureFiledDate() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get paidDate => $_getN(8);
  @$pb.TagNumber(9)
  set paidDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaidDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaidDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensurePaidDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get reference => $_getSZ(9);
  @$pb.TagNumber(10)
  set reference($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReference() => $_has(9);
  @$pb.TagNumber(10)
  void clearReference() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get notes => $_getSZ(10);
  @$pb.TagNumber(11)
  set notes($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNotes() => $_has(10);
  @$pb.TagNumber(11)
  void clearNotes() => clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $1.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($1.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureUpdatedAt() => $_ensure(12);
}

class TaxCalendarEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaxCalendarEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<TaxType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxType', $pb.PbFieldType.OE, defaultOrMaker: TaxType.TAX_TYPE_VAT, valueOf: TaxType.valueOf, enumValues: TaxType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOM<$1.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate', subBuilder: $1.Timestamp.create)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isFiled')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPaid')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..hasRequiredFields = false
  ;

  TaxCalendarEvent._() : super();
  factory TaxCalendarEvent({
    TaxType? taxType,
    $core.String? description,
    $1.Timestamp? dueDate,
    $core.bool? isFiled,
    $core.bool? isPaid,
    $core.String? period,
  }) {
    final _result = create();
    if (taxType != null) {
      _result.taxType = taxType;
    }
    if (description != null) {
      _result.description = description;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (isFiled != null) {
      _result.isFiled = isFiled;
    }
    if (isPaid != null) {
      _result.isPaid = isPaid;
    }
    if (period != null) {
      _result.period = period;
    }
    return _result;
  }
  factory TaxCalendarEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaxCalendarEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaxCalendarEvent clone() => TaxCalendarEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaxCalendarEvent copyWith(void Function(TaxCalendarEvent) updates) => super.copyWith((message) => updates(message as TaxCalendarEvent)) as TaxCalendarEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaxCalendarEvent create() => TaxCalendarEvent._();
  TaxCalendarEvent createEmptyInstance() => create();
  static $pb.PbList<TaxCalendarEvent> createRepeated() => $pb.PbList<TaxCalendarEvent>();
  @$core.pragma('dart2js:noInline')
  static TaxCalendarEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaxCalendarEvent>(create);
  static TaxCalendarEvent? _defaultInstance;

  @$pb.TagNumber(1)
  TaxType get taxType => $_getN(0);
  @$pb.TagNumber(1)
  set taxType(TaxType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTaxType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTaxType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get dueDate => $_getN(2);
  @$pb.TagNumber(3)
  set dueDate($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDueDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDueDate() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDueDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get isFiled => $_getBF(3);
  @$pb.TagNumber(4)
  set isFiled($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsFiled() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsFiled() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isPaid => $_getBF(4);
  @$pb.TagNumber(5)
  set isPaid($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsPaid() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsPaid() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get period => $_getSZ(5);
  @$pb.TagNumber(6)
  set period($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPeriod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPeriod() => clearField(6);
}

class TaxDocument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaxDocument', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..e<TaxDocumentType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT, valueOf: TaxDocumentType.valueOf, enumValues: TaxDocumentType.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileUrl')
    ..aOM<$1.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate', subBuilder: $1.Timestamp.create)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOM<$1.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TaxDocument._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (name != null) {
      _result.name = name;
    }
    if (fileUrl != null) {
      _result.fileUrl = fileUrl;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TaxDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaxDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaxDocument clone() => TaxDocument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaxDocument copyWith(void Function(TaxDocument) updates) => super.copyWith((message) => updates(message as TaxDocument)) as TaxDocument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaxDocument create() => TaxDocument._();
  TaxDocument createEmptyInstance() => create();
  static $pb.PbList<TaxDocument> createRepeated() => $pb.PbList<TaxDocument>();
  @$core.pragma('dart2js:noInline')
  static TaxDocument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaxDocument>(create);
  static TaxDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  TaxDocumentType get documentType => $_getN(2);
  @$pb.TagNumber(3)
  set documentType(TaxDocumentType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFileUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileUrl() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get expiryDate => $_getN(5);
  @$pb.TagNumber(6)
  set expiryDate($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpiryDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiryDate() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureExpiryDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get notes => $_getSZ(6);
  @$pb.TagNumber(7)
  set notes($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNotes() => $_has(6);
  @$pb.TagNumber(7)
  void clearNotes() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);
}

class VATEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VATEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'baseAmount')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vatAmount')
    ..e<VATDirection>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: VATDirection.VAT_DIRECTION_OUTPUT, valueOf: VATDirection.valueOf, enumValues: VATDirection.values)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceReference')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  VATEntry._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (description != null) {
      _result.description = description;
    }
    if (baseAmount != null) {
      _result.baseAmount = baseAmount;
    }
    if (vatAmount != null) {
      _result.vatAmount = vatAmount;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (invoiceReference != null) {
      _result.invoiceReference = invoiceReference;
    }
    if (period != null) {
      _result.period = period;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory VATEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VATEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VATEntry clone() => VATEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VATEntry copyWith(void Function(VATEntry) updates) => super.copyWith((message) => updates(message as VATEntry)) as VATEntry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VATEntry create() => VATEntry._();
  VATEntry createEmptyInstance() => create();
  static $pb.PbList<VATEntry> createRepeated() => $pb.PbList<VATEntry>();
  @$core.pragma('dart2js:noInline')
  static VATEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VATEntry>(create);
  static VATEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get baseAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set baseAmount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBaseAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearBaseAmount() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get vatAmount => $_getI64(4);
  @$pb.TagNumber(5)
  set vatAmount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVatAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearVatAmount() => clearField(5);

  @$pb.TagNumber(6)
  VATDirection get direction => $_getN(5);
  @$pb.TagNumber(6)
  set direction(VATDirection v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDirection() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirection() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get invoiceReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set invoiceReference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInvoiceReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearInvoiceReference() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get period => $_getSZ(7);
  @$pb.TagNumber(8)
  set period($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPeriod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriod() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);
}

class WHTEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'WHTEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vendorName')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentAmount')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whtRate', $pb.PbFieldType.OD)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whtAmount')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aOM<$1.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  WHTEntry._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (vendorName != null) {
      _result.vendorName = vendorName;
    }
    if (paymentAmount != null) {
      _result.paymentAmount = paymentAmount;
    }
    if (whtRate != null) {
      _result.whtRate = whtRate;
    }
    if (whtAmount != null) {
      _result.whtAmount = whtAmount;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (period != null) {
      _result.period = period;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory WHTEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WHTEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WHTEntry clone() => WHTEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WHTEntry copyWith(void Function(WHTEntry) updates) => super.copyWith((message) => updates(message as WHTEntry)) as WHTEntry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WHTEntry create() => WHTEntry._();
  WHTEntry createEmptyInstance() => create();
  static $pb.PbList<WHTEntry> createRepeated() => $pb.PbList<WHTEntry>();
  @$core.pragma('dart2js:noInline')
  static WHTEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WHTEntry>(create);
  static WHTEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get vendorName => $_getSZ(2);
  @$pb.TagNumber(3)
  set vendorName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVendorName() => $_has(2);
  @$pb.TagNumber(3)
  void clearVendorName() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get paymentAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set paymentAmount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get whtRate => $_getN(4);
  @$pb.TagNumber(5)
  set whtRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWhtRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearWhtRate() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get whtAmount => $_getI64(5);
  @$pb.TagNumber(6)
  set whtAmount($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasWhtAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearWhtAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentReference => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentReference($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaymentReference() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentReference() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get period => $_getSZ(7);
  @$pb.TagNumber(8)
  set period($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPeriod() => $_has(7);
  @$pb.TagNumber(8)
  void clearPeriod() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get transactionDate => $_getN(8);
  @$pb.TagNumber(9)
  set transactionDate($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasTransactionDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearTransactionDate() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureTransactionDate() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);
}

class TaxDashboardSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TaxDashboardSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vatDue')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payeDue')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whtDue')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'citEstimated')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingObligations', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overdueObligations', $pb.PbFieldType.O3)
    ..pc<TaxCalendarEvent>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'upcomingDeadlines', $pb.PbFieldType.PM, subBuilder: TaxCalendarEvent.create)
    ..hasRequiredFields = false
  ;

  TaxDashboardSummary._() : super();
  factory TaxDashboardSummary({
    $fixnum.Int64? vatDue,
    $fixnum.Int64? payeDue,
    $fixnum.Int64? whtDue,
    $fixnum.Int64? citEstimated,
    $core.int? pendingObligations,
    $core.int? overdueObligations,
    $core.Iterable<TaxCalendarEvent>? upcomingDeadlines,
  }) {
    final _result = create();
    if (vatDue != null) {
      _result.vatDue = vatDue;
    }
    if (payeDue != null) {
      _result.payeDue = payeDue;
    }
    if (whtDue != null) {
      _result.whtDue = whtDue;
    }
    if (citEstimated != null) {
      _result.citEstimated = citEstimated;
    }
    if (pendingObligations != null) {
      _result.pendingObligations = pendingObligations;
    }
    if (overdueObligations != null) {
      _result.overdueObligations = overdueObligations;
    }
    if (upcomingDeadlines != null) {
      _result.upcomingDeadlines.addAll(upcomingDeadlines);
    }
    return _result;
  }
  factory TaxDashboardSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaxDashboardSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaxDashboardSummary clone() => TaxDashboardSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaxDashboardSummary copyWith(void Function(TaxDashboardSummary) updates) => super.copyWith((message) => updates(message as TaxDashboardSummary)) as TaxDashboardSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TaxDashboardSummary create() => TaxDashboardSummary._();
  TaxDashboardSummary createEmptyInstance() => create();
  static $pb.PbList<TaxDashboardSummary> createRepeated() => $pb.PbList<TaxDashboardSummary>();
  @$core.pragma('dart2js:noInline')
  static TaxDashboardSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaxDashboardSummary>(create);
  static TaxDashboardSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get vatDue => $_getI64(0);
  @$pb.TagNumber(1)
  set vatDue($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVatDue() => $_has(0);
  @$pb.TagNumber(1)
  void clearVatDue() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get payeDue => $_getI64(1);
  @$pb.TagNumber(2)
  set payeDue($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPayeDue() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayeDue() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get whtDue => $_getI64(2);
  @$pb.TagNumber(3)
  set whtDue($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWhtDue() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhtDue() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get citEstimated => $_getI64(3);
  @$pb.TagNumber(4)
  set citEstimated($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCitEstimated() => $_has(3);
  @$pb.TagNumber(4)
  void clearCitEstimated() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pendingObligations => $_getIZ(4);
  @$pb.TagNumber(5)
  set pendingObligations($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPendingObligations() => $_has(4);
  @$pb.TagNumber(5)
  void clearPendingObligations() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get overdueObligations => $_getIZ(5);
  @$pb.TagNumber(6)
  set overdueObligations($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOverdueObligations() => $_has(5);
  @$pb.TagNumber(6)
  void clearOverdueObligations() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<TaxCalendarEvent> get upcomingDeadlines => $_getList(6);
}

class GetTaxDashboardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTaxDashboardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetTaxDashboardRequest._() : super();
  factory GetTaxDashboardRequest() => create();
  factory GetTaxDashboardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxDashboardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxDashboardRequest clone() => GetTaxDashboardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxDashboardRequest copyWith(void Function(GetTaxDashboardRequest) updates) => super.copyWith((message) => updates(message as GetTaxDashboardRequest)) as GetTaxDashboardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardRequest create() => GetTaxDashboardRequest._();
  GetTaxDashboardRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaxDashboardRequest> createRepeated() => $pb.PbList<GetTaxDashboardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaxDashboardRequest>(create);
  static GetTaxDashboardRequest? _defaultInstance;
}

class GetTaxDashboardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTaxDashboardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TaxDashboardSummary>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dashboard', subBuilder: TaxDashboardSummary.create)
    ..hasRequiredFields = false
  ;

  GetTaxDashboardResponse._() : super();
  factory GetTaxDashboardResponse({
    $core.bool? success,
    $core.String? message,
    TaxDashboardSummary? dashboard,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (dashboard != null) {
      _result.dashboard = dashboard;
    }
    return _result;
  }
  factory GetTaxDashboardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxDashboardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxDashboardResponse clone() => GetTaxDashboardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxDashboardResponse copyWith(void Function(GetTaxDashboardResponse) updates) => super.copyWith((message) => updates(message as GetTaxDashboardResponse)) as GetTaxDashboardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardResponse create() => GetTaxDashboardResponse._();
  GetTaxDashboardResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaxDashboardResponse> createRepeated() => $pb.PbList<GetTaxDashboardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaxDashboardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaxDashboardResponse>(create);
  static GetTaxDashboardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  TaxDashboardSummary get dashboard => $_getN(2);
  @$pb.TagNumber(3)
  set dashboard(TaxDashboardSummary v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDashboard() => $_has(2);
  @$pb.TagNumber(3)
  void clearDashboard() => clearField(3);
  @$pb.TagNumber(3)
  TaxDashboardSummary ensureDashboard() => $_ensure(2);
}

class GetTaxCalendarRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTaxCalendarRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'year', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTaxCalendarRequest._() : super();
  factory GetTaxCalendarRequest({
    $core.int? year,
    $core.int? month,
  }) {
    final _result = create();
    if (year != null) {
      _result.year = year;
    }
    if (month != null) {
      _result.month = month;
    }
    return _result;
  }
  factory GetTaxCalendarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxCalendarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxCalendarRequest clone() => GetTaxCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxCalendarRequest copyWith(void Function(GetTaxCalendarRequest) updates) => super.copyWith((message) => updates(message as GetTaxCalendarRequest)) as GetTaxCalendarRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarRequest create() => GetTaxCalendarRequest._();
  GetTaxCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetTaxCalendarRequest> createRepeated() => $pb.PbList<GetTaxCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaxCalendarRequest>(create);
  static GetTaxCalendarRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => clearField(2);
}

class GetTaxCalendarResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTaxCalendarResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<TaxCalendarEvent>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', $pb.PbFieldType.PM, subBuilder: TaxCalendarEvent.create)
    ..hasRequiredFields = false
  ;

  GetTaxCalendarResponse._() : super();
  factory GetTaxCalendarResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<TaxCalendarEvent>? events,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (events != null) {
      _result.events.addAll(events);
    }
    return _result;
  }
  factory GetTaxCalendarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxCalendarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxCalendarResponse clone() => GetTaxCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxCalendarResponse copyWith(void Function(GetTaxCalendarResponse) updates) => super.copyWith((message) => updates(message as GetTaxCalendarResponse)) as GetTaxCalendarResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarResponse create() => GetTaxCalendarResponse._();
  GetTaxCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetTaxCalendarResponse> createRepeated() => $pb.PbList<GetTaxCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTaxCalendarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTaxCalendarResponse>(create);
  static GetTaxCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<TaxCalendarEvent> get events => $_getList(2);
}

class CreateTaxObligationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTaxObligationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<TaxType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxType', $pb.PbFieldType.OE, defaultOrMaker: TaxType.TAX_TYPE_VAT, valueOf: TaxType.valueOf, enumValues: TaxType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  CreateTaxObligationRequest._() : super();
  factory CreateTaxObligationRequest({
    TaxType? taxType,
    $core.String? period,
    $fixnum.Int64? amount,
    $core.String? dueDate,
    $core.String? notes,
  }) {
    final _result = create();
    if (taxType != null) {
      _result.taxType = taxType;
    }
    if (period != null) {
      _result.period = period;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory CreateTaxObligationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTaxObligationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTaxObligationRequest clone() => CreateTaxObligationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTaxObligationRequest copyWith(void Function(CreateTaxObligationRequest) updates) => super.copyWith((message) => updates(message as CreateTaxObligationRequest)) as CreateTaxObligationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationRequest create() => CreateTaxObligationRequest._();
  CreateTaxObligationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTaxObligationRequest> createRepeated() => $pb.PbList<CreateTaxObligationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTaxObligationRequest>(create);
  static CreateTaxObligationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TaxType get taxType => $_getN(0);
  @$pb.TagNumber(1)
  set taxType(TaxType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTaxType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTaxType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get period => $_getSZ(1);
  @$pb.TagNumber(2)
  set period($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriod() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dueDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set dueDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDueDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDueDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get notes => $_getSZ(4);
  @$pb.TagNumber(5)
  set notes($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNotes() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotes() => clearField(5);
}

class CreateTaxObligationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateTaxObligationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TaxObligation>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'obligation', subBuilder: TaxObligation.create)
    ..hasRequiredFields = false
  ;

  CreateTaxObligationResponse._() : super();
  factory CreateTaxObligationResponse({
    $core.bool? success,
    $core.String? message,
    TaxObligation? obligation,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (obligation != null) {
      _result.obligation = obligation;
    }
    return _result;
  }
  factory CreateTaxObligationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateTaxObligationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateTaxObligationResponse clone() => CreateTaxObligationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateTaxObligationResponse copyWith(void Function(CreateTaxObligationResponse) updates) => super.copyWith((message) => updates(message as CreateTaxObligationResponse)) as CreateTaxObligationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationResponse create() => CreateTaxObligationResponse._();
  CreateTaxObligationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTaxObligationResponse> createRepeated() => $pb.PbList<CreateTaxObligationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTaxObligationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateTaxObligationResponse>(create);
  static CreateTaxObligationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  TaxObligation get obligation => $_getN(2);
  @$pb.TagNumber(3)
  set obligation(TaxObligation v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasObligation() => $_has(2);
  @$pb.TagNumber(3)
  void clearObligation() => clearField(3);
  @$pb.TagNumber(3)
  TaxObligation ensureObligation() => $_ensure(2);
}

class UpdateTaxObligationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateTaxObligationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'obligationId')
    ..e<TaxObligationStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING, valueOf: TaxObligationStatus.valueOf, enumValues: TaxObligationStatus.values)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  UpdateTaxObligationRequest._() : super();
  factory UpdateTaxObligationRequest({
    $core.String? obligationId,
    TaxObligationStatus? status,
    $fixnum.Int64? amount,
    $core.String? reference,
    $core.String? notes,
  }) {
    final _result = create();
    if (obligationId != null) {
      _result.obligationId = obligationId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory UpdateTaxObligationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTaxObligationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTaxObligationRequest clone() => UpdateTaxObligationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTaxObligationRequest copyWith(void Function(UpdateTaxObligationRequest) updates) => super.copyWith((message) => updates(message as UpdateTaxObligationRequest)) as UpdateTaxObligationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationRequest create() => UpdateTaxObligationRequest._();
  UpdateTaxObligationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateTaxObligationRequest> createRepeated() => $pb.PbList<UpdateTaxObligationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTaxObligationRequest>(create);
  static UpdateTaxObligationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get obligationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set obligationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObligationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObligationId() => clearField(1);

  @$pb.TagNumber(2)
  TaxObligationStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(TaxObligationStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amount => $_getI64(2);
  @$pb.TagNumber(3)
  set amount($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reference => $_getSZ(3);
  @$pb.TagNumber(4)
  set reference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get notes => $_getSZ(4);
  @$pb.TagNumber(5)
  set notes($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNotes() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotes() => clearField(5);
}

class UpdateTaxObligationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateTaxObligationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TaxObligation>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'obligation', subBuilder: TaxObligation.create)
    ..hasRequiredFields = false
  ;

  UpdateTaxObligationResponse._() : super();
  factory UpdateTaxObligationResponse({
    $core.bool? success,
    $core.String? message,
    TaxObligation? obligation,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (obligation != null) {
      _result.obligation = obligation;
    }
    return _result;
  }
  factory UpdateTaxObligationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTaxObligationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTaxObligationResponse clone() => UpdateTaxObligationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTaxObligationResponse copyWith(void Function(UpdateTaxObligationResponse) updates) => super.copyWith((message) => updates(message as UpdateTaxObligationResponse)) as UpdateTaxObligationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationResponse create() => UpdateTaxObligationResponse._();
  UpdateTaxObligationResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateTaxObligationResponse> createRepeated() => $pb.PbList<UpdateTaxObligationResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateTaxObligationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTaxObligationResponse>(create);
  static UpdateTaxObligationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  TaxObligation get obligation => $_getN(2);
  @$pb.TagNumber(3)
  set obligation(TaxObligation v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasObligation() => $_has(2);
  @$pb.TagNumber(3)
  void clearObligation() => clearField(3);
  @$pb.TagNumber(3)
  TaxObligation ensureObligation() => $_ensure(2);
}

class ListTaxObligationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTaxObligationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TaxType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxType', $pb.PbFieldType.OE, defaultOrMaker: TaxType.TAX_TYPE_VAT, valueOf: TaxType.valueOf, enumValues: TaxType.values)
    ..e<TaxObligationStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING, valueOf: TaxObligationStatus.valueOf, enumValues: TaxObligationStatus.values)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'year', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListTaxObligationsRequest._() : super();
  factory ListTaxObligationsRequest({
    $core.int? page,
    $core.int? limit,
    TaxType? taxType,
    TaxObligationStatus? status,
    $core.int? year,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (taxType != null) {
      _result.taxType = taxType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (year != null) {
      _result.year = year;
    }
    return _result;
  }
  factory ListTaxObligationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTaxObligationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTaxObligationsRequest clone() => ListTaxObligationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTaxObligationsRequest copyWith(void Function(ListTaxObligationsRequest) updates) => super.copyWith((message) => updates(message as ListTaxObligationsRequest)) as ListTaxObligationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsRequest create() => ListTaxObligationsRequest._();
  ListTaxObligationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListTaxObligationsRequest> createRepeated() => $pb.PbList<ListTaxObligationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTaxObligationsRequest>(create);
  static ListTaxObligationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  TaxType get taxType => $_getN(2);
  @$pb.TagNumber(3)
  set taxType(TaxType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTaxType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaxType() => clearField(3);

  @$pb.TagNumber(4)
  TaxObligationStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(TaxObligationStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get year => $_getIZ(4);
  @$pb.TagNumber(5)
  set year($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasYear() => $_has(4);
  @$pb.TagNumber(5)
  void clearYear() => clearField(5);
}

class ListTaxObligationsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTaxObligationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaxObligation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'obligations', $pb.PbFieldType.PM, subBuilder: TaxObligation.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListTaxObligationsResponse._() : super();
  factory ListTaxObligationsResponse({
    $core.Iterable<TaxObligation>? obligations,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (obligations != null) {
      _result.obligations.addAll(obligations);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListTaxObligationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTaxObligationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTaxObligationsResponse clone() => ListTaxObligationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTaxObligationsResponse copyWith(void Function(ListTaxObligationsResponse) updates) => super.copyWith((message) => updates(message as ListTaxObligationsResponse)) as ListTaxObligationsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsResponse create() => ListTaxObligationsResponse._();
  ListTaxObligationsResponse createEmptyInstance() => create();
  static $pb.PbList<ListTaxObligationsResponse> createRepeated() => $pb.PbList<ListTaxObligationsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTaxObligationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTaxObligationsResponse>(create);
  static ListTaxObligationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaxObligation> get obligations => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class UploadTaxDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadTaxDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<TaxDocumentType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT, valueOf: TaxDocumentType.valueOf, enumValues: TaxDocumentType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  UploadTaxDocumentRequest._() : super();
  factory UploadTaxDocumentRequest({
    TaxDocumentType? documentType,
    $core.String? name,
    $core.String? fileUrl,
    $core.String? expiryDate,
    $core.String? notes,
  }) {
    final _result = create();
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (name != null) {
      _result.name = name;
    }
    if (fileUrl != null) {
      _result.fileUrl = fileUrl;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory UploadTaxDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadTaxDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadTaxDocumentRequest clone() => UploadTaxDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadTaxDocumentRequest copyWith(void Function(UploadTaxDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadTaxDocumentRequest)) as UploadTaxDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentRequest create() => UploadTaxDocumentRequest._();
  UploadTaxDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadTaxDocumentRequest> createRepeated() => $pb.PbList<UploadTaxDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadTaxDocumentRequest>(create);
  static UploadTaxDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TaxDocumentType get documentType => $_getN(0);
  @$pb.TagNumber(1)
  set documentType(TaxDocumentType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFileUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get expiryDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set expiryDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiryDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiryDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get notes => $_getSZ(4);
  @$pb.TagNumber(5)
  set notes($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNotes() => $_has(4);
  @$pb.TagNumber(5)
  void clearNotes() => clearField(5);
}

class UploadTaxDocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadTaxDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<TaxDocument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'document', subBuilder: TaxDocument.create)
    ..hasRequiredFields = false
  ;

  UploadTaxDocumentResponse._() : super();
  factory UploadTaxDocumentResponse({
    $core.bool? success,
    $core.String? message,
    TaxDocument? document,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (document != null) {
      _result.document = document;
    }
    return _result;
  }
  factory UploadTaxDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadTaxDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadTaxDocumentResponse clone() => UploadTaxDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadTaxDocumentResponse copyWith(void Function(UploadTaxDocumentResponse) updates) => super.copyWith((message) => updates(message as UploadTaxDocumentResponse)) as UploadTaxDocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentResponse create() => UploadTaxDocumentResponse._();
  UploadTaxDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadTaxDocumentResponse> createRepeated() => $pb.PbList<UploadTaxDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadTaxDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadTaxDocumentResponse>(create);
  static UploadTaxDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  TaxDocument get document => $_getN(2);
  @$pb.TagNumber(3)
  set document(TaxDocument v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocument() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocument() => clearField(3);
  @$pb.TagNumber(3)
  TaxDocument ensureDocument() => $_ensure(2);
}

class ListTaxDocumentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTaxDocumentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<TaxDocumentType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT, valueOf: TaxDocumentType.valueOf, enumValues: TaxDocumentType.values)
    ..hasRequiredFields = false
  ;

  ListTaxDocumentsRequest._() : super();
  factory ListTaxDocumentsRequest({
    $core.int? page,
    $core.int? limit,
    TaxDocumentType? documentType,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    return _result;
  }
  factory ListTaxDocumentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTaxDocumentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTaxDocumentsRequest clone() => ListTaxDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTaxDocumentsRequest copyWith(void Function(ListTaxDocumentsRequest) updates) => super.copyWith((message) => updates(message as ListTaxDocumentsRequest)) as ListTaxDocumentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsRequest create() => ListTaxDocumentsRequest._();
  ListTaxDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListTaxDocumentsRequest> createRepeated() => $pb.PbList<ListTaxDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTaxDocumentsRequest>(create);
  static ListTaxDocumentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  TaxDocumentType get documentType => $_getN(2);
  @$pb.TagNumber(3)
  set documentType(TaxDocumentType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => clearField(3);
}

class ListTaxDocumentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTaxDocumentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TaxDocument>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: TaxDocument.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListTaxDocumentsResponse._() : super();
  factory ListTaxDocumentsResponse({
    $core.Iterable<TaxDocument>? documents,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListTaxDocumentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTaxDocumentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTaxDocumentsResponse clone() => ListTaxDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTaxDocumentsResponse copyWith(void Function(ListTaxDocumentsResponse) updates) => super.copyWith((message) => updates(message as ListTaxDocumentsResponse)) as ListTaxDocumentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsResponse create() => ListTaxDocumentsResponse._();
  ListTaxDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListTaxDocumentsResponse> createRepeated() => $pb.PbList<ListTaxDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTaxDocumentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTaxDocumentsResponse>(create);
  static ListTaxDocumentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TaxDocument> get documents => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class DeleteTaxDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteTaxDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId')
    ..hasRequiredFields = false
  ;

  DeleteTaxDocumentRequest._() : super();
  factory DeleteTaxDocumentRequest({
    $core.String? documentId,
  }) {
    final _result = create();
    if (documentId != null) {
      _result.documentId = documentId;
    }
    return _result;
  }
  factory DeleteTaxDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteTaxDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteTaxDocumentRequest clone() => DeleteTaxDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteTaxDocumentRequest copyWith(void Function(DeleteTaxDocumentRequest) updates) => super.copyWith((message) => updates(message as DeleteTaxDocumentRequest)) as DeleteTaxDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentRequest create() => DeleteTaxDocumentRequest._();
  DeleteTaxDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteTaxDocumentRequest> createRepeated() => $pb.PbList<DeleteTaxDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteTaxDocumentRequest>(create);
  static DeleteTaxDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => clearField(1);
}

class DeleteTaxDocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteTaxDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteTaxDocumentResponse._() : super();
  factory DeleteTaxDocumentResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteTaxDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteTaxDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteTaxDocumentResponse clone() => DeleteTaxDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteTaxDocumentResponse copyWith(void Function(DeleteTaxDocumentResponse) updates) => super.copyWith((message) => updates(message as DeleteTaxDocumentResponse)) as DeleteTaxDocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentResponse create() => DeleteTaxDocumentResponse._();
  DeleteTaxDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteTaxDocumentResponse> createRepeated() => $pb.PbList<DeleteTaxDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteTaxDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteTaxDocumentResponse>(create);
  static DeleteTaxDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetVATScheduleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetVATScheduleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..hasRequiredFields = false
  ;

  GetVATScheduleRequest._() : super();
  factory GetVATScheduleRequest({
    $core.String? period,
  }) {
    final _result = create();
    if (period != null) {
      _result.period = period;
    }
    return _result;
  }
  factory GetVATScheduleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVATScheduleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVATScheduleRequest clone() => GetVATScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVATScheduleRequest copyWith(void Function(GetVATScheduleRequest) updates) => super.copyWith((message) => updates(message as GetVATScheduleRequest)) as GetVATScheduleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetVATScheduleRequest create() => GetVATScheduleRequest._();
  GetVATScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<GetVATScheduleRequest> createRepeated() => $pb.PbList<GetVATScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVATScheduleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVATScheduleRequest>(create);
  static GetVATScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);
}

class GetVATScheduleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetVATScheduleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<VATEntry>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: VATEntry.create)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalOutputVat')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalInputVat')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netVatPayable')
    ..hasRequiredFields = false
  ;

  GetVATScheduleResponse._() : super();
  factory GetVATScheduleResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<VATEntry>? entries,
    $fixnum.Int64? totalOutputVat,
    $fixnum.Int64? totalInputVat,
    $fixnum.Int64? netVatPayable,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (totalOutputVat != null) {
      _result.totalOutputVat = totalOutputVat;
    }
    if (totalInputVat != null) {
      _result.totalInputVat = totalInputVat;
    }
    if (netVatPayable != null) {
      _result.netVatPayable = netVatPayable;
    }
    return _result;
  }
  factory GetVATScheduleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVATScheduleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVATScheduleResponse clone() => GetVATScheduleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVATScheduleResponse copyWith(void Function(GetVATScheduleResponse) updates) => super.copyWith((message) => updates(message as GetVATScheduleResponse)) as GetVATScheduleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetVATScheduleResponse create() => GetVATScheduleResponse._();
  GetVATScheduleResponse createEmptyInstance() => create();
  static $pb.PbList<GetVATScheduleResponse> createRepeated() => $pb.PbList<GetVATScheduleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetVATScheduleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVATScheduleResponse>(create);
  static GetVATScheduleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<VATEntry> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalOutputVat => $_getI64(3);
  @$pb.TagNumber(4)
  set totalOutputVat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalOutputVat() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalOutputVat() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalInputVat => $_getI64(4);
  @$pb.TagNumber(5)
  set totalInputVat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalInputVat() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalInputVat() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get netVatPayable => $_getI64(5);
  @$pb.TagNumber(6)
  set netVatPayable($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNetVatPayable() => $_has(5);
  @$pb.TagNumber(6)
  void clearNetVatPayable() => clearField(6);
}

class RecordVATTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordVATTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'baseAmount')
    ..e<VATDirection>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: VATDirection.VAT_DIRECTION_OUTPUT, valueOf: VATDirection.valueOf, enumValues: VATDirection.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invoiceReference')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate')
    ..hasRequiredFields = false
  ;

  RecordVATTransactionRequest._() : super();
  factory RecordVATTransactionRequest({
    $core.String? description,
    $fixnum.Int64? baseAmount,
    VATDirection? direction,
    $core.String? invoiceReference,
    $core.String? period,
    $core.String? transactionDate,
  }) {
    final _result = create();
    if (description != null) {
      _result.description = description;
    }
    if (baseAmount != null) {
      _result.baseAmount = baseAmount;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (invoiceReference != null) {
      _result.invoiceReference = invoiceReference;
    }
    if (period != null) {
      _result.period = period;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    return _result;
  }
  factory RecordVATTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordVATTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordVATTransactionRequest clone() => RecordVATTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordVATTransactionRequest copyWith(void Function(RecordVATTransactionRequest) updates) => super.copyWith((message) => updates(message as RecordVATTransactionRequest)) as RecordVATTransactionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionRequest create() => RecordVATTransactionRequest._();
  RecordVATTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<RecordVATTransactionRequest> createRepeated() => $pb.PbList<RecordVATTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordVATTransactionRequest>(create);
  static RecordVATTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get baseAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set baseAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBaseAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseAmount() => clearField(2);

  @$pb.TagNumber(3)
  VATDirection get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(VATDirection v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get invoiceReference => $_getSZ(3);
  @$pb.TagNumber(4)
  set invoiceReference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInvoiceReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvoiceReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get period => $_getSZ(4);
  @$pb.TagNumber(5)
  set period($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionDate() => clearField(6);
}

class RecordVATTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordVATTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<VATEntry>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entry', subBuilder: VATEntry.create)
    ..hasRequiredFields = false
  ;

  RecordVATTransactionResponse._() : super();
  factory RecordVATTransactionResponse({
    $core.bool? success,
    $core.String? message,
    VATEntry? entry,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (entry != null) {
      _result.entry = entry;
    }
    return _result;
  }
  factory RecordVATTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordVATTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordVATTransactionResponse clone() => RecordVATTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordVATTransactionResponse copyWith(void Function(RecordVATTransactionResponse) updates) => super.copyWith((message) => updates(message as RecordVATTransactionResponse)) as RecordVATTransactionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionResponse create() => RecordVATTransactionResponse._();
  RecordVATTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<RecordVATTransactionResponse> createRepeated() => $pb.PbList<RecordVATTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static RecordVATTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordVATTransactionResponse>(create);
  static RecordVATTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  VATEntry get entry => $_getN(2);
  @$pb.TagNumber(3)
  set entry(VATEntry v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearEntry() => clearField(3);
  @$pb.TagNumber(3)
  VATEntry ensureEntry() => $_ensure(2);
}

class GetWHTScheduleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWHTScheduleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..hasRequiredFields = false
  ;

  GetWHTScheduleRequest._() : super();
  factory GetWHTScheduleRequest({
    $core.String? period,
  }) {
    final _result = create();
    if (period != null) {
      _result.period = period;
    }
    return _result;
  }
  factory GetWHTScheduleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWHTScheduleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWHTScheduleRequest clone() => GetWHTScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWHTScheduleRequest copyWith(void Function(GetWHTScheduleRequest) updates) => super.copyWith((message) => updates(message as GetWHTScheduleRequest)) as GetWHTScheduleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleRequest create() => GetWHTScheduleRequest._();
  GetWHTScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<GetWHTScheduleRequest> createRepeated() => $pb.PbList<GetWHTScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWHTScheduleRequest>(create);
  static GetWHTScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);
}

class GetWHTScheduleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWHTScheduleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<WHTEntry>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: WHTEntry.create)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalWhtDeducted')
    ..hasRequiredFields = false
  ;

  GetWHTScheduleResponse._() : super();
  factory GetWHTScheduleResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<WHTEntry>? entries,
    $fixnum.Int64? totalWhtDeducted,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (entries != null) {
      _result.entries.addAll(entries);
    }
    if (totalWhtDeducted != null) {
      _result.totalWhtDeducted = totalWhtDeducted;
    }
    return _result;
  }
  factory GetWHTScheduleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWHTScheduleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWHTScheduleResponse clone() => GetWHTScheduleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWHTScheduleResponse copyWith(void Function(GetWHTScheduleResponse) updates) => super.copyWith((message) => updates(message as GetWHTScheduleResponse)) as GetWHTScheduleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleResponse create() => GetWHTScheduleResponse._();
  GetWHTScheduleResponse createEmptyInstance() => create();
  static $pb.PbList<GetWHTScheduleResponse> createRepeated() => $pb.PbList<GetWHTScheduleResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWHTScheduleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWHTScheduleResponse>(create);
  static GetWHTScheduleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<WHTEntry> get entries => $_getList(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get totalWhtDeducted => $_getI64(3);
  @$pb.TagNumber(4)
  set totalWhtDeducted($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalWhtDeducted() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalWhtDeducted() => clearField(4);
}

class RecordWHTDeductionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordWHTDeductionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vendorName')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentAmount')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'whtRate', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'period')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate')
    ..hasRequiredFields = false
  ;

  RecordWHTDeductionRequest._() : super();
  factory RecordWHTDeductionRequest({
    $core.String? vendorName,
    $fixnum.Int64? paymentAmount,
    $core.double? whtRate,
    $core.String? paymentReference,
    $core.String? period,
    $core.String? transactionDate,
  }) {
    final _result = create();
    if (vendorName != null) {
      _result.vendorName = vendorName;
    }
    if (paymentAmount != null) {
      _result.paymentAmount = paymentAmount;
    }
    if (whtRate != null) {
      _result.whtRate = whtRate;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (period != null) {
      _result.period = period;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    return _result;
  }
  factory RecordWHTDeductionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordWHTDeductionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordWHTDeductionRequest clone() => RecordWHTDeductionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordWHTDeductionRequest copyWith(void Function(RecordWHTDeductionRequest) updates) => super.copyWith((message) => updates(message as RecordWHTDeductionRequest)) as RecordWHTDeductionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionRequest create() => RecordWHTDeductionRequest._();
  RecordWHTDeductionRequest createEmptyInstance() => create();
  static $pb.PbList<RecordWHTDeductionRequest> createRepeated() => $pb.PbList<RecordWHTDeductionRequest>();
  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordWHTDeductionRequest>(create);
  static RecordWHTDeductionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vendorName => $_getSZ(0);
  @$pb.TagNumber(1)
  set vendorName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVendorName() => $_has(0);
  @$pb.TagNumber(1)
  void clearVendorName() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get paymentAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set paymentAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get whtRate => $_getN(2);
  @$pb.TagNumber(3)
  set whtRate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWhtRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhtRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentReference => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentReference($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentReference() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentReference() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get period => $_getSZ(4);
  @$pb.TagNumber(5)
  set period($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeriod() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeriod() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionDate() => clearField(6);
}

class RecordWHTDeductionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecordWHTDeductionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<WHTEntry>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entry', subBuilder: WHTEntry.create)
    ..hasRequiredFields = false
  ;

  RecordWHTDeductionResponse._() : super();
  factory RecordWHTDeductionResponse({
    $core.bool? success,
    $core.String? message,
    WHTEntry? entry,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (entry != null) {
      _result.entry = entry;
    }
    return _result;
  }
  factory RecordWHTDeductionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecordWHTDeductionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecordWHTDeductionResponse clone() => RecordWHTDeductionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecordWHTDeductionResponse copyWith(void Function(RecordWHTDeductionResponse) updates) => super.copyWith((message) => updates(message as RecordWHTDeductionResponse)) as RecordWHTDeductionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionResponse create() => RecordWHTDeductionResponse._();
  RecordWHTDeductionResponse createEmptyInstance() => create();
  static $pb.PbList<RecordWHTDeductionResponse> createRepeated() => $pb.PbList<RecordWHTDeductionResponse>();
  @$core.pragma('dart2js:noInline')
  static RecordWHTDeductionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecordWHTDeductionResponse>(create);
  static RecordWHTDeductionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  WHTEntry get entry => $_getN(2);
  @$pb.TagNumber(3)
  set entry(WHTEntry v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearEntry() => clearField(3);
  @$pb.TagNumber(3)
  WHTEntry ensureEntry() => $_ensure(2);
}

class GetPAYESummaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPAYESummaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodStart')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'periodEnd')
    ..hasRequiredFields = false
  ;

  GetPAYESummaryRequest._() : super();
  factory GetPAYESummaryRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final _result = create();
    if (periodStart != null) {
      _result.periodStart = periodStart;
    }
    if (periodEnd != null) {
      _result.periodEnd = periodEnd;
    }
    return _result;
  }
  factory GetPAYESummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPAYESummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPAYESummaryRequest clone() => GetPAYESummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPAYESummaryRequest copyWith(void Function(GetPAYESummaryRequest) updates) => super.copyWith((message) => updates(message as GetPAYESummaryRequest)) as GetPAYESummaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryRequest create() => GetPAYESummaryRequest._();
  GetPAYESummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPAYESummaryRequest> createRepeated() => $pb.PbList<GetPAYESummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPAYESummaryRequest>(create);
  static GetPAYESummaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get periodStart => $_getSZ(0);
  @$pb.TagNumber(1)
  set periodStart($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriodStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriodStart() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get periodEnd => $_getSZ(1);
  @$pb.TagNumber(2)
  set periodEnd($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPeriodEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearPeriodEnd() => clearField(2);
}

class GetPAYESummaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPAYESummaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPaye')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeCount', $pb.PbFieldType.O3)
    ..pc<EmployeeTaxSummary>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employeeSummaries', $pb.PbFieldType.PM, subBuilder: EmployeeTaxSummary.create)
    ..hasRequiredFields = false
  ;

  GetPAYESummaryResponse._() : super();
  factory GetPAYESummaryResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? totalPaye,
    $core.int? employeeCount,
    $core.Iterable<EmployeeTaxSummary>? employeeSummaries,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (totalPaye != null) {
      _result.totalPaye = totalPaye;
    }
    if (employeeCount != null) {
      _result.employeeCount = employeeCount;
    }
    if (employeeSummaries != null) {
      _result.employeeSummaries.addAll(employeeSummaries);
    }
    return _result;
  }
  factory GetPAYESummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPAYESummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPAYESummaryResponse clone() => GetPAYESummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPAYESummaryResponse copyWith(void Function(GetPAYESummaryResponse) updates) => super.copyWith((message) => updates(message as GetPAYESummaryResponse)) as GetPAYESummaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryResponse create() => GetPAYESummaryResponse._();
  GetPAYESummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPAYESummaryResponse> createRepeated() => $pb.PbList<GetPAYESummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPAYESummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPAYESummaryResponse>(create);
  static GetPAYESummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalPaye => $_getI64(2);
  @$pb.TagNumber(3)
  set totalPaye($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPaye() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPaye() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get employeeCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set employeeCount($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmployeeCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmployeeCount() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<EmployeeTaxSummary> get employeeSummaries => $_getList(4);
}

class GetCITEstimationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCITEstimationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'year', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCITEstimationRequest._() : super();
  factory GetCITEstimationRequest({
    $core.int? year,
  }) {
    final _result = create();
    if (year != null) {
      _result.year = year;
    }
    return _result;
  }
  factory GetCITEstimationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCITEstimationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCITEstimationRequest clone() => GetCITEstimationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCITEstimationRequest copyWith(void Function(GetCITEstimationRequest) updates) => super.copyWith((message) => updates(message as GetCITEstimationRequest)) as GetCITEstimationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCITEstimationRequest create() => GetCITEstimationRequest._();
  GetCITEstimationRequest createEmptyInstance() => create();
  static $pb.PbList<GetCITEstimationRequest> createRepeated() => $pb.PbList<GetCITEstimationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCITEstimationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCITEstimationRequest>(create);
  static GetCITEstimationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);
}

class GetCITEstimationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCITEstimationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'annualRevenue')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'annualExpenses')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxableIncome')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'citRate', $pb.PbFieldType.OD)
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'estimatedCit')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'taxBand')
    ..hasRequiredFields = false
  ;

  GetCITEstimationResponse._() : super();
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
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (annualRevenue != null) {
      _result.annualRevenue = annualRevenue;
    }
    if (annualExpenses != null) {
      _result.annualExpenses = annualExpenses;
    }
    if (taxableIncome != null) {
      _result.taxableIncome = taxableIncome;
    }
    if (citRate != null) {
      _result.citRate = citRate;
    }
    if (estimatedCit != null) {
      _result.estimatedCit = estimatedCit;
    }
    if (taxBand != null) {
      _result.taxBand = taxBand;
    }
    return _result;
  }
  factory GetCITEstimationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCITEstimationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCITEstimationResponse clone() => GetCITEstimationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCITEstimationResponse copyWith(void Function(GetCITEstimationResponse) updates) => super.copyWith((message) => updates(message as GetCITEstimationResponse)) as GetCITEstimationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetCITEstimationResponse create() => GetCITEstimationResponse._();
  GetCITEstimationResponse createEmptyInstance() => create();
  static $pb.PbList<GetCITEstimationResponse> createRepeated() => $pb.PbList<GetCITEstimationResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCITEstimationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCITEstimationResponse>(create);
  static GetCITEstimationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get annualRevenue => $_getI64(2);
  @$pb.TagNumber(3)
  set annualRevenue($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAnnualRevenue() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnnualRevenue() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get annualExpenses => $_getI64(3);
  @$pb.TagNumber(4)
  set annualExpenses($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAnnualExpenses() => $_has(3);
  @$pb.TagNumber(4)
  void clearAnnualExpenses() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get taxableIncome => $_getI64(4);
  @$pb.TagNumber(5)
  set taxableIncome($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTaxableIncome() => $_has(4);
  @$pb.TagNumber(5)
  void clearTaxableIncome() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get citRate => $_getN(5);
  @$pb.TagNumber(6)
  set citRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCitRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearCitRate() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get estimatedCit => $_getI64(6);
  @$pb.TagNumber(7)
  set estimatedCit($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEstimatedCit() => $_has(6);
  @$pb.TagNumber(7)
  void clearEstimatedCit() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get taxBand => $_getSZ(7);
  @$pb.TagNumber(8)
  set taxBand($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTaxBand() => $_has(7);
  @$pb.TagNumber(8)
  void clearTaxBand() => clearField(8);
}

class Supplier extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Supplier', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..e<SupplierStatus>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SupplierStatus.SUPPLIER_STATUS_ACTIVE, valueOf: SupplierStatus.valueOf, enumValues: SupplierStatus.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Supplier._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (contactName != null) {
      _result.contactName = contactName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (address != null) {
      _result.address = address;
    }
    if (status != null) {
      _result.status = status;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Supplier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Supplier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Supplier clone() => Supplier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Supplier copyWith(void Function(Supplier) updates) => super.copyWith((message) => updates(message as Supplier)) as Supplier; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Supplier create() => Supplier._();
  Supplier createEmptyInstance() => create();
  static $pb.PbList<Supplier> createRepeated() => $pb.PbList<Supplier>();
  @$core.pragma('dart2js:noInline')
  static Supplier getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Supplier>(create);
  static Supplier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get contactName => $_getSZ(3);
  @$pb.TagNumber(4)
  set contactName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContactName() => $_has(3);
  @$pb.TagNumber(4)
  void clearContactName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get address => $_getSZ(6);
  @$pb.TagNumber(7)
  set address($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearAddress() => clearField(7);

  @$pb.TagNumber(8)
  SupplierStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(SupplierStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get notes => $_getSZ(8);
  @$pb.TagNumber(9)
  set notes($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasNotes() => $_has(8);
  @$pb.TagNumber(9)
  void clearNotes() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureUpdatedAt() => $_ensure(10);
}

class PurchaseOrder extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseOrder', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'businessId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplierId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplierName')
    ..e<PurchaseOrderStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PurchaseOrderStatus.PURCHASE_ORDER_STATUS_DRAFT, valueOf: PurchaseOrderStatus.valueOf, enumValues: PurchaseOrderStatus.values)
    ..pc<PurchaseOrderItem>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: PurchaseOrderItem.create)
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expectedDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receivedDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PurchaseOrder._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (businessId != null) {
      _result.businessId = businessId;
    }
    if (supplierId != null) {
      _result.supplierId = supplierId;
    }
    if (supplierName != null) {
      _result.supplierName = supplierName;
    }
    if (status != null) {
      _result.status = status;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (expectedDate != null) {
      _result.expectedDate = expectedDate;
    }
    if (receivedDate != null) {
      _result.receivedDate = receivedDate;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory PurchaseOrder.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseOrder.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseOrder clone() => PurchaseOrder()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseOrder copyWith(void Function(PurchaseOrder) updates) => super.copyWith((message) => updates(message as PurchaseOrder)) as PurchaseOrder; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseOrder create() => PurchaseOrder._();
  PurchaseOrder createEmptyInstance() => create();
  static $pb.PbList<PurchaseOrder> createRepeated() => $pb.PbList<PurchaseOrder>();
  @$core.pragma('dart2js:noInline')
  static PurchaseOrder getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseOrder>(create);
  static PurchaseOrder? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get businessId => $_getSZ(1);
  @$pb.TagNumber(2)
  set businessId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBusinessId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBusinessId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get supplierId => $_getSZ(2);
  @$pb.TagNumber(3)
  set supplierId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSupplierId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupplierId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get supplierName => $_getSZ(3);
  @$pb.TagNumber(4)
  set supplierName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSupplierName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSupplierName() => clearField(4);

  @$pb.TagNumber(5)
  PurchaseOrderStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(PurchaseOrderStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<PurchaseOrderItem> get items => $_getList(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get totalAmount => $_getI64(6);
  @$pb.TagNumber(7)
  set totalAmount($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get notes => $_getSZ(7);
  @$pb.TagNumber(8)
  set notes($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNotes() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotes() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get reference => $_getSZ(8);
  @$pb.TagNumber(9)
  set reference($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReference() => $_has(8);
  @$pb.TagNumber(9)
  void clearReference() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get expectedDate => $_getN(9);
  @$pb.TagNumber(10)
  set expectedDate($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpectedDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpectedDate() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureExpectedDate() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get receivedDate => $_getN(10);
  @$pb.TagNumber(11)
  set receivedDate($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasReceivedDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceivedDate() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureReceivedDate() => $_ensure(10);

  @$pb.TagNumber(12)
  $1.Timestamp get createdAt => $_getN(11);
  @$pb.TagNumber(12)
  set createdAt($1.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureCreatedAt() => $_ensure(11);

  @$pb.TagNumber(13)
  $1.Timestamp get updatedAt => $_getN(12);
  @$pb.TagNumber(13)
  set updatedAt($1.Timestamp v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => clearField(13);
  @$pb.TagNumber(13)
  $1.Timestamp ensureUpdatedAt() => $_ensure(12);
}

class PurchaseOrderItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseOrderItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemName')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantityOrdered', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantityReceived', $pb.PbFieldType.O3)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitPrice')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPrice')
    ..hasRequiredFields = false
  ;

  PurchaseOrderItem._() : super();
  factory PurchaseOrderItem({
    $core.String? itemId,
    $core.String? itemName,
    $core.int? quantityOrdered,
    $core.int? quantityReceived,
    $fixnum.Int64? unitPrice,
    $fixnum.Int64? totalPrice,
  }) {
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    if (itemName != null) {
      _result.itemName = itemName;
    }
    if (quantityOrdered != null) {
      _result.quantityOrdered = quantityOrdered;
    }
    if (quantityReceived != null) {
      _result.quantityReceived = quantityReceived;
    }
    if (unitPrice != null) {
      _result.unitPrice = unitPrice;
    }
    if (totalPrice != null) {
      _result.totalPrice = totalPrice;
    }
    return _result;
  }
  factory PurchaseOrderItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseOrderItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseOrderItem clone() => PurchaseOrderItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseOrderItem copyWith(void Function(PurchaseOrderItem) updates) => super.copyWith((message) => updates(message as PurchaseOrderItem)) as PurchaseOrderItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseOrderItem create() => PurchaseOrderItem._();
  PurchaseOrderItem createEmptyInstance() => create();
  static $pb.PbList<PurchaseOrderItem> createRepeated() => $pb.PbList<PurchaseOrderItem>();
  @$core.pragma('dart2js:noInline')
  static PurchaseOrderItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseOrderItem>(create);
  static PurchaseOrderItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemName => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasItemName() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantityOrdered => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantityOrdered($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantityOrdered() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantityOrdered() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantityReceived => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantityReceived($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantityReceived() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantityReceived() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unitPrice => $_getI64(4);
  @$pb.TagNumber(5)
  set unitPrice($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalPrice => $_getI64(5);
  @$pb.TagNumber(6)
  set totalPrice($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPrice() => clearField(6);
}

class InventoryValuation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InventoryValuation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..pc<CategoryValuation>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: CategoryValuation.create)
    ..hasRequiredFields = false
  ;

  InventoryValuation._() : super();
  factory InventoryValuation({
    $fixnum.Int64? totalValue,
    $core.int? totalItems,
    $core.Iterable<CategoryValuation>? categories,
  }) {
    final _result = create();
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    return _result;
  }
  factory InventoryValuation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InventoryValuation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InventoryValuation clone() => InventoryValuation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InventoryValuation copyWith(void Function(InventoryValuation) updates) => super.copyWith((message) => updates(message as InventoryValuation)) as InventoryValuation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InventoryValuation create() => InventoryValuation._();
  InventoryValuation createEmptyInstance() => create();
  static $pb.PbList<InventoryValuation> createRepeated() => $pb.PbList<InventoryValuation>();
  @$core.pragma('dart2js:noInline')
  static InventoryValuation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InventoryValuation>(create);
  static InventoryValuation? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalValue => $_getI64(0);
  @$pb.TagNumber(1)
  set totalValue($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalItems => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalItems($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalItems() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalItems() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<CategoryValuation> get categories => $_getList(2);
}

class CategoryValuation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CategoryValuation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemCount', $pb.PbFieldType.O3)
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'percentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CategoryValuation._() : super();
  factory CategoryValuation({
    $core.String? category,
    $core.int? itemCount,
    $fixnum.Int64? totalValue,
    $core.double? percentage,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (itemCount != null) {
      _result.itemCount = itemCount;
    }
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    if (percentage != null) {
      _result.percentage = percentage;
    }
    return _result;
  }
  factory CategoryValuation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategoryValuation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CategoryValuation clone() => CategoryValuation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CategoryValuation copyWith(void Function(CategoryValuation) updates) => super.copyWith((message) => updates(message as CategoryValuation)) as CategoryValuation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CategoryValuation create() => CategoryValuation._();
  CategoryValuation createEmptyInstance() => create();
  static $pb.PbList<CategoryValuation> createRepeated() => $pb.PbList<CategoryValuation>();
  @$core.pragma('dart2js:noInline')
  static CategoryValuation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CategoryValuation>(create);
  static CategoryValuation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get itemCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set itemCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasItemCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemCount() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get totalValue => $_getI64(2);
  @$pb.TagNumber(3)
  set totalValue($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get percentage => $_getN(3);
  @$pb.TagNumber(4)
  set percentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => clearField(4);
}

class ExpiryAlert extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExpiryAlert', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate', subBuilder: $1.Timestamp.create)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysUntilExpiry', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ExpiryAlert._() : super();
  factory ExpiryAlert({
    $core.String? itemId,
    $core.String? itemName,
    $core.String? category,
    $core.int? quantity,
    $1.Timestamp? expiryDate,
    $core.int? daysUntilExpiry,
  }) {
    final _result = create();
    if (itemId != null) {
      _result.itemId = itemId;
    }
    if (itemName != null) {
      _result.itemName = itemName;
    }
    if (category != null) {
      _result.category = category;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (daysUntilExpiry != null) {
      _result.daysUntilExpiry = daysUntilExpiry;
    }
    return _result;
  }
  factory ExpiryAlert.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExpiryAlert.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExpiryAlert clone() => ExpiryAlert()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExpiryAlert copyWith(void Function(ExpiryAlert) updates) => super.copyWith((message) => updates(message as ExpiryAlert)) as ExpiryAlert; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExpiryAlert create() => ExpiryAlert._();
  ExpiryAlert createEmptyInstance() => create();
  static $pb.PbList<ExpiryAlert> createRepeated() => $pb.PbList<ExpiryAlert>();
  @$core.pragma('dart2js:noInline')
  static ExpiryAlert getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpiryAlert>(create);
  static ExpiryAlert? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get itemName => $_getSZ(1);
  @$pb.TagNumber(2)
  set itemName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasItemName() => $_has(1);
  @$pb.TagNumber(2)
  void clearItemName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get expiryDate => $_getN(4);
  @$pb.TagNumber(5)
  set expiryDate($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiryDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiryDate() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureExpiryDate() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get daysUntilExpiry => $_getIZ(5);
  @$pb.TagNumber(6)
  set daysUntilExpiry($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDaysUntilExpiry() => $_has(5);
  @$pb.TagNumber(6)
  void clearDaysUntilExpiry() => clearField(6);
}

class CreateSupplierRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSupplierRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  CreateSupplierRequest._() : super();
  factory CreateSupplierRequest({
    $core.String? name,
    $core.String? contactName,
    $core.String? email,
    $core.String? phone,
    $core.String? address,
    $core.String? notes,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (contactName != null) {
      _result.contactName = contactName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (address != null) {
      _result.address = address;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory CreateSupplierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSupplierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSupplierRequest clone() => CreateSupplierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSupplierRequest copyWith(void Function(CreateSupplierRequest) updates) => super.copyWith((message) => updates(message as CreateSupplierRequest)) as CreateSupplierRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateSupplierRequest create() => CreateSupplierRequest._();
  CreateSupplierRequest createEmptyInstance() => create();
  static $pb.PbList<CreateSupplierRequest> createRepeated() => $pb.PbList<CreateSupplierRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateSupplierRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSupplierRequest>(create);
  static CreateSupplierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contactName => $_getSZ(1);
  @$pb.TagNumber(2)
  set contactName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContactName() => $_has(1);
  @$pb.TagNumber(2)
  void clearContactName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get address => $_getSZ(4);
  @$pb.TagNumber(5)
  set address($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddress() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get notes => $_getSZ(5);
  @$pb.TagNumber(6)
  set notes($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasNotes() => $_has(5);
  @$pb.TagNumber(6)
  void clearNotes() => clearField(6);
}

class CreateSupplierResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateSupplierResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Supplier>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplier', subBuilder: Supplier.create)
    ..hasRequiredFields = false
  ;

  CreateSupplierResponse._() : super();
  factory CreateSupplierResponse({
    $core.bool? success,
    $core.String? message,
    Supplier? supplier,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (supplier != null) {
      _result.supplier = supplier;
    }
    return _result;
  }
  factory CreateSupplierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateSupplierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateSupplierResponse clone() => CreateSupplierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateSupplierResponse copyWith(void Function(CreateSupplierResponse) updates) => super.copyWith((message) => updates(message as CreateSupplierResponse)) as CreateSupplierResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateSupplierResponse create() => CreateSupplierResponse._();
  CreateSupplierResponse createEmptyInstance() => create();
  static $pb.PbList<CreateSupplierResponse> createRepeated() => $pb.PbList<CreateSupplierResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateSupplierResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateSupplierResponse>(create);
  static CreateSupplierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Supplier get supplier => $_getN(2);
  @$pb.TagNumber(3)
  set supplier(Supplier v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSupplier() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupplier() => clearField(3);
  @$pb.TagNumber(3)
  Supplier ensureSupplier() => $_ensure(2);
}

class UpdateSupplierRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSupplierRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplierId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contactName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..e<SupplierStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SupplierStatus.SUPPLIER_STATUS_ACTIVE, valueOf: SupplierStatus.valueOf, enumValues: SupplierStatus.values)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  UpdateSupplierRequest._() : super();
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
    final _result = create();
    if (supplierId != null) {
      _result.supplierId = supplierId;
    }
    if (name != null) {
      _result.name = name;
    }
    if (contactName != null) {
      _result.contactName = contactName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (address != null) {
      _result.address = address;
    }
    if (status != null) {
      _result.status = status;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory UpdateSupplierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSupplierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSupplierRequest clone() => UpdateSupplierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSupplierRequest copyWith(void Function(UpdateSupplierRequest) updates) => super.copyWith((message) => updates(message as UpdateSupplierRequest)) as UpdateSupplierRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSupplierRequest create() => UpdateSupplierRequest._();
  UpdateSupplierRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSupplierRequest> createRepeated() => $pb.PbList<UpdateSupplierRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSupplierRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSupplierRequest>(create);
  static UpdateSupplierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supplierId => $_getSZ(0);
  @$pb.TagNumber(1)
  set supplierId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSupplierId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupplierId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get contactName => $_getSZ(2);
  @$pb.TagNumber(3)
  set contactName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasContactName() => $_has(2);
  @$pb.TagNumber(3)
  void clearContactName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get address => $_getSZ(5);
  @$pb.TagNumber(6)
  set address($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearAddress() => clearField(6);

  @$pb.TagNumber(7)
  SupplierStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(SupplierStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get notes => $_getSZ(7);
  @$pb.TagNumber(8)
  set notes($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNotes() => $_has(7);
  @$pb.TagNumber(8)
  void clearNotes() => clearField(8);
}

class UpdateSupplierResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSupplierResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<Supplier>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplier', subBuilder: Supplier.create)
    ..hasRequiredFields = false
  ;

  UpdateSupplierResponse._() : super();
  factory UpdateSupplierResponse({
    $core.bool? success,
    $core.String? message,
    Supplier? supplier,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (supplier != null) {
      _result.supplier = supplier;
    }
    return _result;
  }
  factory UpdateSupplierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSupplierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSupplierResponse clone() => UpdateSupplierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSupplierResponse copyWith(void Function(UpdateSupplierResponse) updates) => super.copyWith((message) => updates(message as UpdateSupplierResponse)) as UpdateSupplierResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSupplierResponse create() => UpdateSupplierResponse._();
  UpdateSupplierResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSupplierResponse> createRepeated() => $pb.PbList<UpdateSupplierResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSupplierResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSupplierResponse>(create);
  static UpdateSupplierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Supplier get supplier => $_getN(2);
  @$pb.TagNumber(3)
  set supplier(Supplier v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSupplier() => $_has(2);
  @$pb.TagNumber(3)
  void clearSupplier() => clearField(3);
  @$pb.TagNumber(3)
  Supplier ensureSupplier() => $_ensure(2);
}

class DeleteSupplierRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteSupplierRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplierId')
    ..hasRequiredFields = false
  ;

  DeleteSupplierRequest._() : super();
  factory DeleteSupplierRequest({
    $core.String? supplierId,
  }) {
    final _result = create();
    if (supplierId != null) {
      _result.supplierId = supplierId;
    }
    return _result;
  }
  factory DeleteSupplierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteSupplierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteSupplierRequest clone() => DeleteSupplierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteSupplierRequest copyWith(void Function(DeleteSupplierRequest) updates) => super.copyWith((message) => updates(message as DeleteSupplierRequest)) as DeleteSupplierRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteSupplierRequest create() => DeleteSupplierRequest._();
  DeleteSupplierRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteSupplierRequest> createRepeated() => $pb.PbList<DeleteSupplierRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteSupplierRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteSupplierRequest>(create);
  static DeleteSupplierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supplierId => $_getSZ(0);
  @$pb.TagNumber(1)
  set supplierId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSupplierId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupplierId() => clearField(1);
}

class DeleteSupplierResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteSupplierResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteSupplierResponse._() : super();
  factory DeleteSupplierResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteSupplierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteSupplierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteSupplierResponse clone() => DeleteSupplierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteSupplierResponse copyWith(void Function(DeleteSupplierResponse) updates) => super.copyWith((message) => updates(message as DeleteSupplierResponse)) as DeleteSupplierResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteSupplierResponse create() => DeleteSupplierResponse._();
  DeleteSupplierResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteSupplierResponse> createRepeated() => $pb.PbList<DeleteSupplierResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteSupplierResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteSupplierResponse>(create);
  static DeleteSupplierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class ListSuppliersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListSuppliersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'search')
    ..e<SupplierStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SupplierStatus.SUPPLIER_STATUS_ACTIVE, valueOf: SupplierStatus.valueOf, enumValues: SupplierStatus.values)
    ..hasRequiredFields = false
  ;

  ListSuppliersRequest._() : super();
  factory ListSuppliersRequest({
    $core.int? page,
    $core.int? limit,
    $core.String? search,
    SupplierStatus? status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (search != null) {
      _result.search = search;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ListSuppliersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSuppliersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSuppliersRequest clone() => ListSuppliersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSuppliersRequest copyWith(void Function(ListSuppliersRequest) updates) => super.copyWith((message) => updates(message as ListSuppliersRequest)) as ListSuppliersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListSuppliersRequest create() => ListSuppliersRequest._();
  ListSuppliersRequest createEmptyInstance() => create();
  static $pb.PbList<ListSuppliersRequest> createRepeated() => $pb.PbList<ListSuppliersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSuppliersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSuppliersRequest>(create);
  static ListSuppliersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get search => $_getSZ(2);
  @$pb.TagNumber(3)
  set search($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSearch() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearch() => clearField(3);

  @$pb.TagNumber(4)
  SupplierStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(SupplierStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class ListSuppliersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListSuppliersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Supplier>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suppliers', $pb.PbFieldType.PM, subBuilder: Supplier.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListSuppliersResponse._() : super();
  factory ListSuppliersResponse({
    $core.Iterable<Supplier>? suppliers,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (suppliers != null) {
      _result.suppliers.addAll(suppliers);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListSuppliersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSuppliersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSuppliersResponse clone() => ListSuppliersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSuppliersResponse copyWith(void Function(ListSuppliersResponse) updates) => super.copyWith((message) => updates(message as ListSuppliersResponse)) as ListSuppliersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListSuppliersResponse create() => ListSuppliersResponse._();
  ListSuppliersResponse createEmptyInstance() => create();
  static $pb.PbList<ListSuppliersResponse> createRepeated() => $pb.PbList<ListSuppliersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSuppliersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSuppliersResponse>(create);
  static ListSuppliersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Supplier> get suppliers => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class CreatePurchaseOrderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePurchaseOrderRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplierId')
    ..pc<PurchaseOrderItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: PurchaseOrderItem.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expectedDate')
    ..hasRequiredFields = false
  ;

  CreatePurchaseOrderRequest._() : super();
  factory CreatePurchaseOrderRequest({
    $core.String? supplierId,
    $core.Iterable<PurchaseOrderItem>? items,
    $core.String? notes,
    $core.String? expectedDate,
  }) {
    final _result = create();
    if (supplierId != null) {
      _result.supplierId = supplierId;
    }
    if (items != null) {
      _result.items.addAll(items);
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (expectedDate != null) {
      _result.expectedDate = expectedDate;
    }
    return _result;
  }
  factory CreatePurchaseOrderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePurchaseOrderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePurchaseOrderRequest clone() => CreatePurchaseOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePurchaseOrderRequest copyWith(void Function(CreatePurchaseOrderRequest) updates) => super.copyWith((message) => updates(message as CreatePurchaseOrderRequest)) as CreatePurchaseOrderRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderRequest create() => CreatePurchaseOrderRequest._();
  CreatePurchaseOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePurchaseOrderRequest> createRepeated() => $pb.PbList<CreatePurchaseOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePurchaseOrderRequest>(create);
  static CreatePurchaseOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get supplierId => $_getSZ(0);
  @$pb.TagNumber(1)
  set supplierId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSupplierId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSupplierId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<PurchaseOrderItem> get items => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get expectedDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set expectedDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpectedDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpectedDate() => clearField(4);
}

class CreatePurchaseOrderResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePurchaseOrderResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PurchaseOrder>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseOrder', subBuilder: PurchaseOrder.create)
    ..hasRequiredFields = false
  ;

  CreatePurchaseOrderResponse._() : super();
  factory CreatePurchaseOrderResponse({
    $core.bool? success,
    $core.String? message,
    PurchaseOrder? purchaseOrder,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (purchaseOrder != null) {
      _result.purchaseOrder = purchaseOrder;
    }
    return _result;
  }
  factory CreatePurchaseOrderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePurchaseOrderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePurchaseOrderResponse clone() => CreatePurchaseOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePurchaseOrderResponse copyWith(void Function(CreatePurchaseOrderResponse) updates) => super.copyWith((message) => updates(message as CreatePurchaseOrderResponse)) as CreatePurchaseOrderResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderResponse create() => CreatePurchaseOrderResponse._();
  CreatePurchaseOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePurchaseOrderResponse> createRepeated() => $pb.PbList<CreatePurchaseOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePurchaseOrderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePurchaseOrderResponse>(create);
  static CreatePurchaseOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrder get purchaseOrder => $_getN(2);
  @$pb.TagNumber(3)
  set purchaseOrder(PurchaseOrder v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPurchaseOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurchaseOrder() => clearField(3);
  @$pb.TagNumber(3)
  PurchaseOrder ensurePurchaseOrder() => $_ensure(2);
}

class GetPurchaseOrderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPurchaseOrderRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseOrderId')
    ..hasRequiredFields = false
  ;

  GetPurchaseOrderRequest._() : super();
  factory GetPurchaseOrderRequest({
    $core.String? purchaseOrderId,
  }) {
    final _result = create();
    if (purchaseOrderId != null) {
      _result.purchaseOrderId = purchaseOrderId;
    }
    return _result;
  }
  factory GetPurchaseOrderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPurchaseOrderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPurchaseOrderRequest clone() => GetPurchaseOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPurchaseOrderRequest copyWith(void Function(GetPurchaseOrderRequest) updates) => super.copyWith((message) => updates(message as GetPurchaseOrderRequest)) as GetPurchaseOrderRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderRequest create() => GetPurchaseOrderRequest._();
  GetPurchaseOrderRequest createEmptyInstance() => create();
  static $pb.PbList<GetPurchaseOrderRequest> createRepeated() => $pb.PbList<GetPurchaseOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPurchaseOrderRequest>(create);
  static GetPurchaseOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseOrderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseOrderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchaseOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseOrderId() => clearField(1);
}

class GetPurchaseOrderResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPurchaseOrderResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PurchaseOrder>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseOrder', subBuilder: PurchaseOrder.create)
    ..hasRequiredFields = false
  ;

  GetPurchaseOrderResponse._() : super();
  factory GetPurchaseOrderResponse({
    $core.bool? success,
    $core.String? message,
    PurchaseOrder? purchaseOrder,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (purchaseOrder != null) {
      _result.purchaseOrder = purchaseOrder;
    }
    return _result;
  }
  factory GetPurchaseOrderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPurchaseOrderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPurchaseOrderResponse clone() => GetPurchaseOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPurchaseOrderResponse copyWith(void Function(GetPurchaseOrderResponse) updates) => super.copyWith((message) => updates(message as GetPurchaseOrderResponse)) as GetPurchaseOrderResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderResponse create() => GetPurchaseOrderResponse._();
  GetPurchaseOrderResponse createEmptyInstance() => create();
  static $pb.PbList<GetPurchaseOrderResponse> createRepeated() => $pb.PbList<GetPurchaseOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPurchaseOrderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPurchaseOrderResponse>(create);
  static GetPurchaseOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrder get purchaseOrder => $_getN(2);
  @$pb.TagNumber(3)
  set purchaseOrder(PurchaseOrder v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPurchaseOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurchaseOrder() => clearField(3);
  @$pb.TagNumber(3)
  PurchaseOrder ensurePurchaseOrder() => $_ensure(2);
}

class ListPurchaseOrdersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListPurchaseOrdersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<PurchaseOrderStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PurchaseOrderStatus.PURCHASE_ORDER_STATUS_DRAFT, valueOf: PurchaseOrderStatus.valueOf, enumValues: PurchaseOrderStatus.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supplierId')
    ..hasRequiredFields = false
  ;

  ListPurchaseOrdersRequest._() : super();
  factory ListPurchaseOrdersRequest({
    $core.int? page,
    $core.int? limit,
    PurchaseOrderStatus? status,
    $core.String? supplierId,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (status != null) {
      _result.status = status;
    }
    if (supplierId != null) {
      _result.supplierId = supplierId;
    }
    return _result;
  }
  factory ListPurchaseOrdersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPurchaseOrdersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPurchaseOrdersRequest clone() => ListPurchaseOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPurchaseOrdersRequest copyWith(void Function(ListPurchaseOrdersRequest) updates) => super.copyWith((message) => updates(message as ListPurchaseOrdersRequest)) as ListPurchaseOrdersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersRequest create() => ListPurchaseOrdersRequest._();
  ListPurchaseOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<ListPurchaseOrdersRequest> createRepeated() => $pb.PbList<ListPurchaseOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPurchaseOrdersRequest>(create);
  static ListPurchaseOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrderStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(PurchaseOrderStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get supplierId => $_getSZ(3);
  @$pb.TagNumber(4)
  set supplierId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSupplierId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSupplierId() => clearField(4);
}

class ListPurchaseOrdersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListPurchaseOrdersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PurchaseOrder>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseOrders', $pb.PbFieldType.PM, subBuilder: PurchaseOrder.create)
    ..aOM<PayrollPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  ListPurchaseOrdersResponse._() : super();
  factory ListPurchaseOrdersResponse({
    $core.Iterable<PurchaseOrder>? purchaseOrders,
    PayrollPaginationInfo? pagination,
  }) {
    final _result = create();
    if (purchaseOrders != null) {
      _result.purchaseOrders.addAll(purchaseOrders);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory ListPurchaseOrdersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPurchaseOrdersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPurchaseOrdersResponse clone() => ListPurchaseOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPurchaseOrdersResponse copyWith(void Function(ListPurchaseOrdersResponse) updates) => super.copyWith((message) => updates(message as ListPurchaseOrdersResponse)) as ListPurchaseOrdersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersResponse create() => ListPurchaseOrdersResponse._();
  ListPurchaseOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<ListPurchaseOrdersResponse> createRepeated() => $pb.PbList<ListPurchaseOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPurchaseOrdersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPurchaseOrdersResponse>(create);
  static ListPurchaseOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PurchaseOrder> get purchaseOrders => $_getList(0);

  @$pb.TagNumber(2)
  PayrollPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(PayrollPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  PayrollPaginationInfo ensurePagination() => $_ensure(1);
}

class ReceivePurchaseOrderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReceivePurchaseOrderRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseOrderId')
    ..pc<PurchaseOrderItem>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receivedItems', $pb.PbFieldType.PM, subBuilder: PurchaseOrderItem.create)
    ..hasRequiredFields = false
  ;

  ReceivePurchaseOrderRequest._() : super();
  factory ReceivePurchaseOrderRequest({
    $core.String? purchaseOrderId,
    $core.Iterable<PurchaseOrderItem>? receivedItems,
  }) {
    final _result = create();
    if (purchaseOrderId != null) {
      _result.purchaseOrderId = purchaseOrderId;
    }
    if (receivedItems != null) {
      _result.receivedItems.addAll(receivedItems);
    }
    return _result;
  }
  factory ReceivePurchaseOrderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReceivePurchaseOrderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReceivePurchaseOrderRequest clone() => ReceivePurchaseOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReceivePurchaseOrderRequest copyWith(void Function(ReceivePurchaseOrderRequest) updates) => super.copyWith((message) => updates(message as ReceivePurchaseOrderRequest)) as ReceivePurchaseOrderRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderRequest create() => ReceivePurchaseOrderRequest._();
  ReceivePurchaseOrderRequest createEmptyInstance() => create();
  static $pb.PbList<ReceivePurchaseOrderRequest> createRepeated() => $pb.PbList<ReceivePurchaseOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReceivePurchaseOrderRequest>(create);
  static ReceivePurchaseOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseOrderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseOrderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchaseOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseOrderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<PurchaseOrderItem> get receivedItems => $_getList(1);
}

class ReceivePurchaseOrderResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReceivePurchaseOrderResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<PurchaseOrder>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseOrder', subBuilder: PurchaseOrder.create)
    ..hasRequiredFields = false
  ;

  ReceivePurchaseOrderResponse._() : super();
  factory ReceivePurchaseOrderResponse({
    $core.bool? success,
    $core.String? message,
    PurchaseOrder? purchaseOrder,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (purchaseOrder != null) {
      _result.purchaseOrder = purchaseOrder;
    }
    return _result;
  }
  factory ReceivePurchaseOrderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReceivePurchaseOrderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReceivePurchaseOrderResponse clone() => ReceivePurchaseOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReceivePurchaseOrderResponse copyWith(void Function(ReceivePurchaseOrderResponse) updates) => super.copyWith((message) => updates(message as ReceivePurchaseOrderResponse)) as ReceivePurchaseOrderResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderResponse create() => ReceivePurchaseOrderResponse._();
  ReceivePurchaseOrderResponse createEmptyInstance() => create();
  static $pb.PbList<ReceivePurchaseOrderResponse> createRepeated() => $pb.PbList<ReceivePurchaseOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static ReceivePurchaseOrderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReceivePurchaseOrderResponse>(create);
  static ReceivePurchaseOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PurchaseOrder get purchaseOrder => $_getN(2);
  @$pb.TagNumber(3)
  set purchaseOrder(PurchaseOrder v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPurchaseOrder() => $_has(2);
  @$pb.TagNumber(3)
  void clearPurchaseOrder() => clearField(3);
  @$pb.TagNumber(3)
  PurchaseOrder ensurePurchaseOrder() => $_ensure(2);
}

class GetInventoryValuationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventoryValuationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInventoryValuationRequest._() : super();
  factory GetInventoryValuationRequest() => create();
  factory GetInventoryValuationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventoryValuationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventoryValuationRequest clone() => GetInventoryValuationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventoryValuationRequest copyWith(void Function(GetInventoryValuationRequest) updates) => super.copyWith((message) => updates(message as GetInventoryValuationRequest)) as GetInventoryValuationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationRequest create() => GetInventoryValuationRequest._();
  GetInventoryValuationRequest createEmptyInstance() => create();
  static $pb.PbList<GetInventoryValuationRequest> createRepeated() => $pb.PbList<GetInventoryValuationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventoryValuationRequest>(create);
  static GetInventoryValuationRequest? _defaultInstance;
}

class GetInventoryValuationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInventoryValuationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<InventoryValuation>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'valuation', subBuilder: InventoryValuation.create)
    ..hasRequiredFields = false
  ;

  GetInventoryValuationResponse._() : super();
  factory GetInventoryValuationResponse({
    $core.bool? success,
    $core.String? message,
    InventoryValuation? valuation,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (valuation != null) {
      _result.valuation = valuation;
    }
    return _result;
  }
  factory GetInventoryValuationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInventoryValuationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInventoryValuationResponse clone() => GetInventoryValuationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInventoryValuationResponse copyWith(void Function(GetInventoryValuationResponse) updates) => super.copyWith((message) => updates(message as GetInventoryValuationResponse)) as GetInventoryValuationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationResponse create() => GetInventoryValuationResponse._();
  GetInventoryValuationResponse createEmptyInstance() => create();
  static $pb.PbList<GetInventoryValuationResponse> createRepeated() => $pb.PbList<GetInventoryValuationResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInventoryValuationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInventoryValuationResponse>(create);
  static GetInventoryValuationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  InventoryValuation get valuation => $_getN(2);
  @$pb.TagNumber(3)
  set valuation(InventoryValuation v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasValuation() => $_has(2);
  @$pb.TagNumber(3)
  void clearValuation() => clearField(3);
  @$pb.TagNumber(3)
  InventoryValuation ensureValuation() => $_ensure(2);
}

class GetExpiryAlertsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetExpiryAlertsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'daysAhead', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetExpiryAlertsRequest._() : super();
  factory GetExpiryAlertsRequest({
    $core.int? daysAhead,
  }) {
    final _result = create();
    if (daysAhead != null) {
      _result.daysAhead = daysAhead;
    }
    return _result;
  }
  factory GetExpiryAlertsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpiryAlertsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpiryAlertsRequest clone() => GetExpiryAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpiryAlertsRequest copyWith(void Function(GetExpiryAlertsRequest) updates) => super.copyWith((message) => updates(message as GetExpiryAlertsRequest)) as GetExpiryAlertsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsRequest create() => GetExpiryAlertsRequest._();
  GetExpiryAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetExpiryAlertsRequest> createRepeated() => $pb.PbList<GetExpiryAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpiryAlertsRequest>(create);
  static GetExpiryAlertsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get daysAhead => $_getIZ(0);
  @$pb.TagNumber(1)
  set daysAhead($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDaysAhead() => $_has(0);
  @$pb.TagNumber(1)
  void clearDaysAhead() => clearField(1);
}

class GetExpiryAlertsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetExpiryAlertsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<ExpiryAlert>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alerts', $pb.PbFieldType.PM, subBuilder: ExpiryAlert.create)
    ..hasRequiredFields = false
  ;

  GetExpiryAlertsResponse._() : super();
  factory GetExpiryAlertsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<ExpiryAlert>? alerts,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (alerts != null) {
      _result.alerts.addAll(alerts);
    }
    return _result;
  }
  factory GetExpiryAlertsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExpiryAlertsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExpiryAlertsResponse clone() => GetExpiryAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExpiryAlertsResponse copyWith(void Function(GetExpiryAlertsResponse) updates) => super.copyWith((message) => updates(message as GetExpiryAlertsResponse)) as GetExpiryAlertsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsResponse create() => GetExpiryAlertsResponse._();
  GetExpiryAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetExpiryAlertsResponse> createRepeated() => $pb.PbList<GetExpiryAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExpiryAlertsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExpiryAlertsResponse>(create);
  static GetExpiryAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<ExpiryAlert> get alerts => $_getList(2);
}

