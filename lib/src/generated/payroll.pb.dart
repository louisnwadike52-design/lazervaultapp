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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'payroll.pbenum.dart';

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (businessId != null) {
      $result.businessId = businessId;
    }
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phone != null) {
      $result.phone = phone;
    }
    if (nin != null) {
      $result.nin = nin;
    }
    if (bankAccountNumber != null) {
      $result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (employmentType != null) {
      $result.employmentType = employmentType;
    }
    if (payRate != null) {
      $result.payRate = payRate;
    }
    if (payFrequency != null) {
      $result.payFrequency = payFrequency;
    }
    if (department != null) {
      $result.department = department;
    }
    if (jobTitle != null) {
      $result.jobTitle = jobTitle;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  Employee._() : super();
  factory Employee.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Employee.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Employee', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
    ..e<EmploymentType>(11, _omitFieldNames ? '' : 'employmentType', $pb.PbFieldType.OE, defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME, valueOf: EmploymentType.valueOf, enumValues: EmploymentType.values)
    ..aInt64(12, _omitFieldNames ? '' : 'payRate')
    ..e<PayFrequency>(13, _omitFieldNames ? '' : 'payFrequency', $pb.PbFieldType.OE, defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY, valueOf: PayFrequency.valueOf, enumValues: PayFrequency.values)
    ..aOS(14, _omitFieldNames ? '' : 'department')
    ..aOS(15, _omitFieldNames ? '' : 'jobTitle')
    ..aOS(16, _omitFieldNames ? '' : 'startDate')
    ..e<EmployeeStatus>(17, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE, valueOf: EmployeeStatus.valueOf, enumValues: EmployeeStatus.values)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Employee clone() => Employee()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Employee copyWith(void Function(Employee) updates) => super.copyWith((message) => updates(message as Employee)) as Employee;

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
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (businessId != null) {
      $result.businessId = businessId;
    }
    if (payPeriodStart != null) {
      $result.payPeriodStart = payPeriodStart;
    }
    if (payPeriodEnd != null) {
      $result.payPeriodEnd = payPeriodEnd;
    }
    if (status != null) {
      $result.status = status;
    }
    if (totalGross != null) {
      $result.totalGross = totalGross;
    }
    if (totalDeductions != null) {
      $result.totalDeductions = totalDeductions;
    }
    if (totalNet != null) {
      $result.totalNet = totalNet;
    }
    if (totalEmployerContributions != null) {
      $result.totalEmployerContributions = totalEmployerContributions;
    }
    if (employeeCount != null) {
      $result.employeeCount = employeeCount;
    }
    if (createdBy != null) {
      $result.createdBy = createdBy;
    }
    if (approvedBy != null) {
      $result.approvedBy = approvedBy;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (processedAt != null) {
      $result.processedAt = processedAt;
    }
    return $result;
  }
  PayRun._() : super();
  factory PayRun.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayRun.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayRun', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'businessId')
    ..aOS(3, _omitFieldNames ? '' : 'payPeriodStart')
    ..aOS(4, _omitFieldNames ? '' : 'payPeriodEnd')
    ..e<PayRunStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayRunStatus.PAY_RUN_STATUS_DRAFT, valueOf: PayRunStatus.valueOf, enumValues: PayRunStatus.values)
    ..aInt64(6, _omitFieldNames ? '' : 'totalGross')
    ..aInt64(7, _omitFieldNames ? '' : 'totalDeductions')
    ..aInt64(8, _omitFieldNames ? '' : 'totalNet')
    ..aInt64(9, _omitFieldNames ? '' : 'totalEmployerContributions')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'employeeCount', $pb.PbFieldType.O3)
    ..aOS(11, _omitFieldNames ? '' : 'createdBy')
    ..aOS(12, _omitFieldNames ? '' : 'approvedBy')
    ..aOM<$1.Timestamp>(13, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'processedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayRun clone() => PayRun()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayRun copyWith(void Function(PayRun) updates) => super.copyWith((message) => updates(message as PayRun)) as PayRun;

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (payRunId != null) {
      $result.payRunId = payRunId;
    }
    if (employeeId != null) {
      $result.employeeId = employeeId;
    }
    if (employeeName != null) {
      $result.employeeName = employeeName;
    }
    if (grossPay != null) {
      $result.grossPay = grossPay;
    }
    if (incomeTax != null) {
      $result.incomeTax = incomeTax;
    }
    if (nationalInsurance != null) {
      $result.nationalInsurance = nationalInsurance;
    }
    if (studentLoanRepayment != null) {
      $result.studentLoanRepayment = studentLoanRepayment;
    }
    if (pensionContribution != null) {
      $result.pensionContribution = pensionContribution;
    }
    if (otherDeductions != null) {
      $result.otherDeductions = otherDeductions;
    }
    if (totalDeductions != null) {
      $result.totalDeductions = totalDeductions;
    }
    if (netPay != null) {
      $result.netPay = netPay;
    }
    if (employerNic != null) {
      $result.employerNic = employerNic;
    }
    if (employerPension != null) {
      $result.employerPension = employerPension;
    }
    if (hoursWorked != null) {
      $result.hoursWorked = hoursWorked;
    }
    if (overtimeHours != null) {
      $result.overtimeHours = overtimeHours;
    }
    if (overtimePay != null) {
      $result.overtimePay = overtimePay;
    }
    if (bonuses != null) {
      $result.bonuses = bonuses;
    }
    if (commissions != null) {
      $result.commissions = commissions;
    }
    if (paymentStatus != null) {
      $result.paymentStatus = paymentStatus;
    }
    if (paymentReference != null) {
      $result.paymentReference = paymentReference;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  PaySlip._() : super();
  factory PaySlip.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaySlip.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaySlip', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
    ..a<$core.double>(15, _omitFieldNames ? '' : 'hoursWorked', $pb.PbFieldType.OD)
    ..a<$core.double>(16, _omitFieldNames ? '' : 'overtimeHours', $pb.PbFieldType.OD)
    ..aInt64(17, _omitFieldNames ? '' : 'overtimePay')
    ..aInt64(18, _omitFieldNames ? '' : 'bonuses')
    ..aInt64(19, _omitFieldNames ? '' : 'commissions')
    ..e<PaymentStatus>(20, _omitFieldNames ? '' : 'paymentStatus', $pb.PbFieldType.OE, defaultOrMaker: PaymentStatus.PAYMENT_STATUS_PENDING, valueOf: PaymentStatus.valueOf, enumValues: PaymentStatus.values)
    ..aOS(21, _omitFieldNames ? '' : 'paymentReference')
    ..aOM<$1.Timestamp>(22, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaySlip clone() => PaySlip()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaySlip copyWith(void Function(PaySlip) updates) => super.copyWith((message) => updates(message as PaySlip)) as PaySlip;

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
  factory DeductionSummary({
    $core.String? type,
    $fixnum.Int64? amount,
    $core.String? description,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  DeductionSummary._() : super();
  factory DeductionSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeductionSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeductionSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeductionSummary clone() => DeductionSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeductionSummary copyWith(void Function(DeductionSummary) updates) => super.copyWith((message) => updates(message as DeductionSummary)) as DeductionSummary;

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
  factory PayrollPaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
  }) {
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (totalItems != null) {
      $result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      $result.itemsPerPage = itemsPerPage;
    }
    return $result;
  }
  PayrollPaginationInfo._() : super();
  factory PayrollPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayrollPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayrollPaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayrollPaginationInfo clone() => PayrollPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayrollPaginationInfo copyWith(void Function(PayrollPaginationInfo) updates) => super.copyWith((message) => updates(message as PayrollPaginationInfo)) as PayrollPaginationInfo;

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
    final $result = create();
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phone != null) {
      $result.phone = phone;
    }
    if (nin != null) {
      $result.nin = nin;
    }
    if (bankAccountNumber != null) {
      $result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (employmentType != null) {
      $result.employmentType = employmentType;
    }
    if (payRate != null) {
      $result.payRate = payRate;
    }
    if (payFrequency != null) {
      $result.payFrequency = payFrequency;
    }
    if (department != null) {
      $result.department = department;
    }
    if (jobTitle != null) {
      $result.jobTitle = jobTitle;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  AddEmployeeRequest._() : super();
  factory AddEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddEmployeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullName')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'phone')
    ..aOS(4, _omitFieldNames ? '' : 'nin')
    ..aOS(5, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(6, _omitFieldNames ? '' : 'bankCode')
    ..aOS(7, _omitFieldNames ? '' : 'bankName')
    ..e<EmploymentType>(8, _omitFieldNames ? '' : 'employmentType', $pb.PbFieldType.OE, defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME, valueOf: EmploymentType.valueOf, enumValues: EmploymentType.values)
    ..aInt64(9, _omitFieldNames ? '' : 'payRate')
    ..e<PayFrequency>(10, _omitFieldNames ? '' : 'payFrequency', $pb.PbFieldType.OE, defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY, valueOf: PayFrequency.valueOf, enumValues: PayFrequency.values)
    ..aOS(11, _omitFieldNames ? '' : 'department')
    ..aOS(12, _omitFieldNames ? '' : 'jobTitle')
    ..aOS(13, _omitFieldNames ? '' : 'startDate')
    ..aOS(14, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEmployeeRequest clone() => AddEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEmployeeRequest copyWith(void Function(AddEmployeeRequest) updates) => super.copyWith((message) => updates(message as AddEmployeeRequest)) as AddEmployeeRequest;

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
  factory AddEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (employee != null) {
      $result.employee = employee;
    }
    return $result;
  }
  AddEmployeeResponse._() : super();
  factory AddEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddEmployeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Employee>(3, _omitFieldNames ? '' : 'employee', subBuilder: Employee.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddEmployeeResponse clone() => AddEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddEmployeeResponse copyWith(void Function(AddEmployeeResponse) updates) => super.copyWith((message) => updates(message as AddEmployeeResponse)) as AddEmployeeResponse;

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
    final $result = create();
    if (employeeId != null) {
      $result.employeeId = employeeId;
    }
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phone != null) {
      $result.phone = phone;
    }
    if (nin != null) {
      $result.nin = nin;
    }
    if (bankAccountNumber != null) {
      $result.bankAccountNumber = bankAccountNumber;
    }
    if (bankCode != null) {
      $result.bankCode = bankCode;
    }
    if (bankName != null) {
      $result.bankName = bankName;
    }
    if (employmentType != null) {
      $result.employmentType = employmentType;
    }
    if (payRate != null) {
      $result.payRate = payRate;
    }
    if (payFrequency != null) {
      $result.payFrequency = payFrequency;
    }
    if (department != null) {
      $result.department = department;
    }
    if (jobTitle != null) {
      $result.jobTitle = jobTitle;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  UpdateEmployeeRequest._() : super();
  factory UpdateEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateEmployeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..aOS(2, _omitFieldNames ? '' : 'fullName')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'phone')
    ..aOS(5, _omitFieldNames ? '' : 'nin')
    ..aOS(6, _omitFieldNames ? '' : 'bankAccountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'bankCode')
    ..aOS(8, _omitFieldNames ? '' : 'bankName')
    ..e<EmploymentType>(9, _omitFieldNames ? '' : 'employmentType', $pb.PbFieldType.OE, defaultOrMaker: EmploymentType.EMPLOYMENT_TYPE_FULL_TIME, valueOf: EmploymentType.valueOf, enumValues: EmploymentType.values)
    ..aInt64(10, _omitFieldNames ? '' : 'payRate')
    ..e<PayFrequency>(11, _omitFieldNames ? '' : 'payFrequency', $pb.PbFieldType.OE, defaultOrMaker: PayFrequency.PAY_FREQUENCY_MONTHLY, valueOf: PayFrequency.valueOf, enumValues: PayFrequency.values)
    ..aOS(12, _omitFieldNames ? '' : 'department')
    ..aOS(13, _omitFieldNames ? '' : 'jobTitle')
    ..e<EmployeeStatus>(14, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE, valueOf: EmployeeStatus.valueOf, enumValues: EmployeeStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateEmployeeRequest clone() => UpdateEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateEmployeeRequest copyWith(void Function(UpdateEmployeeRequest) updates) => super.copyWith((message) => updates(message as UpdateEmployeeRequest)) as UpdateEmployeeRequest;

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
  factory UpdateEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (employee != null) {
      $result.employee = employee;
    }
    return $result;
  }
  UpdateEmployeeResponse._() : super();
  factory UpdateEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateEmployeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Employee>(3, _omitFieldNames ? '' : 'employee', subBuilder: Employee.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateEmployeeResponse clone() => UpdateEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateEmployeeResponse copyWith(void Function(UpdateEmployeeResponse) updates) => super.copyWith((message) => updates(message as UpdateEmployeeResponse)) as UpdateEmployeeResponse;

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
  factory RemoveEmployeeRequest({
    $core.String? employeeId,
  }) {
    final $result = create();
    if (employeeId != null) {
      $result.employeeId = employeeId;
    }
    return $result;
  }
  RemoveEmployeeRequest._() : super();
  factory RemoveEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveEmployeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveEmployeeRequest clone() => RemoveEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveEmployeeRequest copyWith(void Function(RemoveEmployeeRequest) updates) => super.copyWith((message) => updates(message as RemoveEmployeeRequest)) as RemoveEmployeeRequest;

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
  factory RemoveEmployeeResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RemoveEmployeeResponse._() : super();
  factory RemoveEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveEmployeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveEmployeeResponse clone() => RemoveEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveEmployeeResponse copyWith(void Function(RemoveEmployeeResponse) updates) => super.copyWith((message) => updates(message as RemoveEmployeeResponse)) as RemoveEmployeeResponse;

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
  factory GetEmployeeRequest({
    $core.String? employeeId,
  }) {
    final $result = create();
    if (employeeId != null) {
      $result.employeeId = employeeId;
    }
    return $result;
  }
  GetEmployeeRequest._() : super();
  factory GetEmployeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEmployeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEmployeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEmployeeRequest clone() => GetEmployeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEmployeeRequest copyWith(void Function(GetEmployeeRequest) updates) => super.copyWith((message) => updates(message as GetEmployeeRequest)) as GetEmployeeRequest;

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
  factory GetEmployeeResponse({
    $core.bool? success,
    $core.String? message,
    Employee? employee,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (employee != null) {
      $result.employee = employee;
    }
    return $result;
  }
  GetEmployeeResponse._() : super();
  factory GetEmployeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEmployeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEmployeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Employee>(3, _omitFieldNames ? '' : 'employee', subBuilder: Employee.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEmployeeResponse clone() => GetEmployeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEmployeeResponse copyWith(void Function(GetEmployeeResponse) updates) => super.copyWith((message) => updates(message as GetEmployeeResponse)) as GetEmployeeResponse;

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
  factory ListEmployeesRequest({
    $core.int? page,
    $core.int? limit,
    EmployeeStatus? status,
    $core.String? department,
    $core.String? search,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (status != null) {
      $result.status = status;
    }
    if (department != null) {
      $result.department = department;
    }
    if (search != null) {
      $result.search = search;
    }
    return $result;
  }
  ListEmployeesRequest._() : super();
  factory ListEmployeesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEmployeesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListEmployeesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<EmployeeStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: EmployeeStatus.EMPLOYEE_STATUS_ACTIVE, valueOf: EmployeeStatus.valueOf, enumValues: EmployeeStatus.values)
    ..aOS(4, _omitFieldNames ? '' : 'department')
    ..aOS(5, _omitFieldNames ? '' : 'search')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEmployeesRequest clone() => ListEmployeesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEmployeesRequest copyWith(void Function(ListEmployeesRequest) updates) => super.copyWith((message) => updates(message as ListEmployeesRequest)) as ListEmployeesRequest;

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
  factory ListEmployeesResponse({
    $core.Iterable<Employee>? employees,
    PayrollPaginationInfo? pagination,
  }) {
    final $result = create();
    if (employees != null) {
      $result.employees.addAll(employees);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  ListEmployeesResponse._() : super();
  factory ListEmployeesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEmployeesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListEmployeesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Employee>(1, _omitFieldNames ? '' : 'employees', $pb.PbFieldType.PM, subBuilder: Employee.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEmployeesResponse clone() => ListEmployeesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEmployeesResponse copyWith(void Function(ListEmployeesResponse) updates) => super.copyWith((message) => updates(message as ListEmployeesResponse)) as ListEmployeesResponse;

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
  factory CreatePayRunRequest({
    $core.String? payPeriodStart,
    $core.String? payPeriodEnd,
  }) {
    final $result = create();
    if (payPeriodStart != null) {
      $result.payPeriodStart = payPeriodStart;
    }
    if (payPeriodEnd != null) {
      $result.payPeriodEnd = payPeriodEnd;
    }
    return $result;
  }
  CreatePayRunRequest._() : super();
  factory CreatePayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePayRunRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payPeriodStart')
    ..aOS(2, _omitFieldNames ? '' : 'payPeriodEnd')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePayRunRequest clone() => CreatePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePayRunRequest copyWith(void Function(CreatePayRunRequest) updates) => super.copyWith((message) => updates(message as CreatePayRunRequest)) as CreatePayRunRequest;

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
}

class CreatePayRunResponse extends $pb.GeneratedMessage {
  factory CreatePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (payRun != null) {
      $result.payRun = payRun;
    }
    return $result;
  }
  CreatePayRunResponse._() : super();
  factory CreatePayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePayRunResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePayRunResponse clone() => CreatePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePayRunResponse copyWith(void Function(CreatePayRunResponse) updates) => super.copyWith((message) => updates(message as CreatePayRunResponse)) as CreatePayRunResponse;

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
  factory CalculatePayRunRequest({
    $core.String? payRunId,
  }) {
    final $result = create();
    if (payRunId != null) {
      $result.payRunId = payRunId;
    }
    return $result;
  }
  CalculatePayRunRequest._() : super();
  factory CalculatePayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculatePayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CalculatePayRunRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculatePayRunRequest clone() => CalculatePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculatePayRunRequest copyWith(void Function(CalculatePayRunRequest) updates) => super.copyWith((message) => updates(message as CalculatePayRunRequest)) as CalculatePayRunRequest;

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
  factory CalculatePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
    $core.Iterable<PaySlip>? paySlips,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (payRun != null) {
      $result.payRun = payRun;
    }
    if (paySlips != null) {
      $result.paySlips.addAll(paySlips);
    }
    return $result;
  }
  CalculatePayRunResponse._() : super();
  factory CalculatePayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculatePayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CalculatePayRunResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..pc<PaySlip>(4, _omitFieldNames ? '' : 'paySlips', $pb.PbFieldType.PM, subBuilder: PaySlip.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculatePayRunResponse clone() => CalculatePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculatePayRunResponse copyWith(void Function(CalculatePayRunResponse) updates) => super.copyWith((message) => updates(message as CalculatePayRunResponse)) as CalculatePayRunResponse;

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
  factory ApprovePayRunRequest({
    $core.String? payRunId,
  }) {
    final $result = create();
    if (payRunId != null) {
      $result.payRunId = payRunId;
    }
    return $result;
  }
  ApprovePayRunRequest._() : super();
  factory ApprovePayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApprovePayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ApprovePayRunRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApprovePayRunRequest clone() => ApprovePayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApprovePayRunRequest copyWith(void Function(ApprovePayRunRequest) updates) => super.copyWith((message) => updates(message as ApprovePayRunRequest)) as ApprovePayRunRequest;

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
  factory ApprovePayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (payRun != null) {
      $result.payRun = payRun;
    }
    return $result;
  }
  ApprovePayRunResponse._() : super();
  factory ApprovePayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ApprovePayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ApprovePayRunResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ApprovePayRunResponse clone() => ApprovePayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ApprovePayRunResponse copyWith(void Function(ApprovePayRunResponse) updates) => super.copyWith((message) => updates(message as ApprovePayRunResponse)) as ApprovePayRunResponse;

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
  factory ProcessPayRunRequest({
    $core.String? payRunId,
    $core.String? transactionPin,
    $core.String? sourceAccountId,
  }) {
    final $result = create();
    if (payRunId != null) {
      $result.payRunId = payRunId;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (sourceAccountId != null) {
      $result.sourceAccountId = sourceAccountId;
    }
    return $result;
  }
  ProcessPayRunRequest._() : super();
  factory ProcessPayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessPayRunRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(3, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPayRunRequest clone() => ProcessPayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPayRunRequest copyWith(void Function(ProcessPayRunRequest) updates) => super.copyWith((message) => updates(message as ProcessPayRunRequest)) as ProcessPayRunRequest;

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
  factory ProcessPayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
    $core.int? successfulPayments,
    $core.int? failedPayments,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (payRun != null) {
      $result.payRun = payRun;
    }
    if (successfulPayments != null) {
      $result.successfulPayments = successfulPayments;
    }
    if (failedPayments != null) {
      $result.failedPayments = failedPayments;
    }
    return $result;
  }
  ProcessPayRunResponse._() : super();
  factory ProcessPayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessPayRunResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'successfulPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPayRunResponse clone() => ProcessPayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPayRunResponse copyWith(void Function(ProcessPayRunResponse) updates) => super.copyWith((message) => updates(message as ProcessPayRunResponse)) as ProcessPayRunResponse;

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
  factory GetPayRunRequest({
    $core.String? payRunId,
  }) {
    final $result = create();
    if (payRunId != null) {
      $result.payRunId = payRunId;
    }
    return $result;
  }
  GetPayRunRequest._() : super();
  factory GetPayRunRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayRunRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPayRunRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayRunRequest clone() => GetPayRunRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayRunRequest copyWith(void Function(GetPayRunRequest) updates) => super.copyWith((message) => updates(message as GetPayRunRequest)) as GetPayRunRequest;

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
  factory GetPayRunResponse({
    $core.bool? success,
    $core.String? message,
    PayRun? payRun,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (payRun != null) {
      $result.payRun = payRun;
    }
    return $result;
  }
  GetPayRunResponse._() : super();
  factory GetPayRunResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayRunResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPayRunResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PayRun>(3, _omitFieldNames ? '' : 'payRun', subBuilder: PayRun.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayRunResponse clone() => GetPayRunResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayRunResponse copyWith(void Function(GetPayRunResponse) updates) => super.copyWith((message) => updates(message as GetPayRunResponse)) as GetPayRunResponse;

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
  factory ListPayRunsRequest({
    $core.int? page,
    $core.int? limit,
    PayRunStatus? status,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  ListPayRunsRequest._() : super();
  factory ListPayRunsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPayRunsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPayRunsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..e<PayRunStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PayRunStatus.PAY_RUN_STATUS_DRAFT, valueOf: PayRunStatus.valueOf, enumValues: PayRunStatus.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPayRunsRequest clone() => ListPayRunsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPayRunsRequest copyWith(void Function(ListPayRunsRequest) updates) => super.copyWith((message) => updates(message as ListPayRunsRequest)) as ListPayRunsRequest;

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
  factory ListPayRunsResponse({
    $core.Iterable<PayRun>? payRuns,
    PayrollPaginationInfo? pagination,
  }) {
    final $result = create();
    if (payRuns != null) {
      $result.payRuns.addAll(payRuns);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  ListPayRunsResponse._() : super();
  factory ListPayRunsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPayRunsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPayRunsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PayRun>(1, _omitFieldNames ? '' : 'payRuns', $pb.PbFieldType.PM, subBuilder: PayRun.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPayRunsResponse clone() => ListPayRunsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPayRunsResponse copyWith(void Function(ListPayRunsResponse) updates) => super.copyWith((message) => updates(message as ListPayRunsResponse)) as ListPayRunsResponse;

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
  factory GetPaySlipRequest({
    $core.String? paySlipId,
  }) {
    final $result = create();
    if (paySlipId != null) {
      $result.paySlipId = paySlipId;
    }
    return $result;
  }
  GetPaySlipRequest._() : super();
  factory GetPaySlipRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaySlipRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaySlipRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paySlipId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaySlipRequest clone() => GetPaySlipRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaySlipRequest copyWith(void Function(GetPaySlipRequest) updates) => super.copyWith((message) => updates(message as GetPaySlipRequest)) as GetPaySlipRequest;

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
  factory GetPaySlipResponse({
    $core.bool? success,
    $core.String? message,
    PaySlip? paySlip,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (paySlip != null) {
      $result.paySlip = paySlip;
    }
    return $result;
  }
  GetPaySlipResponse._() : super();
  factory GetPaySlipResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaySlipResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaySlipResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PaySlip>(3, _omitFieldNames ? '' : 'paySlip', subBuilder: PaySlip.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaySlipResponse clone() => GetPaySlipResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaySlipResponse copyWith(void Function(GetPaySlipResponse) updates) => super.copyWith((message) => updates(message as GetPaySlipResponse)) as GetPaySlipResponse;

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
  factory ListPaySlipsRequest({
    $core.String? payRunId,
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (payRunId != null) {
      $result.payRunId = payRunId;
    }
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  ListPaySlipsRequest._() : super();
  factory ListPaySlipsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaySlipsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPaySlipsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payRunId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaySlipsRequest clone() => ListPaySlipsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaySlipsRequest copyWith(void Function(ListPaySlipsRequest) updates) => super.copyWith((message) => updates(message as ListPaySlipsRequest)) as ListPaySlipsRequest;

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
  factory ListPaySlipsResponse({
    $core.Iterable<PaySlip>? paySlips,
    PayrollPaginationInfo? pagination,
  }) {
    final $result = create();
    if (paySlips != null) {
      $result.paySlips.addAll(paySlips);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  ListPaySlipsResponse._() : super();
  factory ListPaySlipsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaySlipsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPaySlipsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PaySlip>(1, _omitFieldNames ? '' : 'paySlips', $pb.PbFieldType.PM, subBuilder: PaySlip.create)
    ..aOM<PayrollPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: PayrollPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaySlipsResponse clone() => ListPaySlipsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaySlipsResponse copyWith(void Function(ListPaySlipsResponse) updates) => super.copyWith((message) => updates(message as ListPaySlipsResponse)) as ListPaySlipsResponse;

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
  factory GetPayrollSummaryRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final $result = create();
    if (periodStart != null) {
      $result.periodStart = periodStart;
    }
    if (periodEnd != null) {
      $result.periodEnd = periodEnd;
    }
    return $result;
  }
  GetPayrollSummaryRequest._() : super();
  factory GetPayrollSummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayrollSummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPayrollSummaryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodStart')
    ..aOS(2, _omitFieldNames ? '' : 'periodEnd')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryRequest clone() => GetPayrollSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryRequest copyWith(void Function(GetPayrollSummaryRequest) updates) => super.copyWith((message) => updates(message as GetPayrollSummaryRequest)) as GetPayrollSummaryRequest;

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
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (totalEmployees != null) {
      $result.totalEmployees = totalEmployees;
    }
    if (totalPayRuns != null) {
      $result.totalPayRuns = totalPayRuns;
    }
    if (totalGrossPaid != null) {
      $result.totalGrossPaid = totalGrossPaid;
    }
    if (totalDeductions != null) {
      $result.totalDeductions = totalDeductions;
    }
    if (totalNetPaid != null) {
      $result.totalNetPaid = totalNetPaid;
    }
    if (totalEmployerContributions != null) {
      $result.totalEmployerContributions = totalEmployerContributions;
    }
    if (deductionBreakdown != null) {
      $result.deductionBreakdown.addAll(deductionBreakdown);
    }
    return $result;
  }
  GetPayrollSummaryResponse._() : super();
  factory GetPayrollSummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayrollSummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPayrollSummaryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalEmployees', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPayRuns', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'totalGrossPaid')
    ..aInt64(6, _omitFieldNames ? '' : 'totalDeductions')
    ..aInt64(7, _omitFieldNames ? '' : 'totalNetPaid')
    ..aInt64(8, _omitFieldNames ? '' : 'totalEmployerContributions')
    ..pc<DeductionSummary>(9, _omitFieldNames ? '' : 'deductionBreakdown', $pb.PbFieldType.PM, subBuilder: DeductionSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryResponse clone() => GetPayrollSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayrollSummaryResponse copyWith(void Function(GetPayrollSummaryResponse) updates) => super.copyWith((message) => updates(message as GetPayrollSummaryResponse)) as GetPayrollSummaryResponse;

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
  factory GetTaxReportRequest({
    $core.String? periodStart,
    $core.String? periodEnd,
  }) {
    final $result = create();
    if (periodStart != null) {
      $result.periodStart = periodStart;
    }
    if (periodEnd != null) {
      $result.periodEnd = periodEnd;
    }
    return $result;
  }
  GetTaxReportRequest._() : super();
  factory GetTaxReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaxReportRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'periodStart')
    ..aOS(2, _omitFieldNames ? '' : 'periodEnd')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxReportRequest clone() => GetTaxReportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxReportRequest copyWith(void Function(GetTaxReportRequest) updates) => super.copyWith((message) => updates(message as GetTaxReportRequest)) as GetTaxReportRequest;

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
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (totalPaye != null) {
      $result.totalPaye = totalPaye;
    }
    if (totalNhf != null) {
      $result.totalNhf = totalNhf;
    }
    if (totalPensionEmployee != null) {
      $result.totalPensionEmployee = totalPensionEmployee;
    }
    if (totalPensionEmployer != null) {
      $result.totalPensionEmployer = totalPensionEmployer;
    }
    if (totalNsitf != null) {
      $result.totalNsitf = totalNsitf;
    }
    if (totalItf != null) {
      $result.totalItf = totalItf;
    }
    if (employeeSummaries != null) {
      $result.employeeSummaries.addAll(employeeSummaries);
    }
    return $result;
  }
  GetTaxReportResponse._() : super();
  factory GetTaxReportResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTaxReportResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTaxReportResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aInt64(3, _omitFieldNames ? '' : 'totalPaye')
    ..aInt64(4, _omitFieldNames ? '' : 'totalNhf')
    ..aInt64(5, _omitFieldNames ? '' : 'totalPensionEmployee')
    ..aInt64(6, _omitFieldNames ? '' : 'totalPensionEmployer')
    ..aInt64(7, _omitFieldNames ? '' : 'totalNsitf')
    ..aInt64(8, _omitFieldNames ? '' : 'totalItf')
    ..pc<EmployeeTaxSummary>(9, _omitFieldNames ? '' : 'employeeSummaries', $pb.PbFieldType.PM, subBuilder: EmployeeTaxSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTaxReportResponse clone() => GetTaxReportResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTaxReportResponse copyWith(void Function(GetTaxReportResponse) updates) => super.copyWith((message) => updates(message as GetTaxReportResponse)) as GetTaxReportResponse;

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
  factory EmployeeTaxSummary({
    $core.String? employeeId,
    $core.String? employeeName,
    $fixnum.Int64? grossPay,
    $fixnum.Int64? paye,
    $fixnum.Int64? nhf,
    $fixnum.Int64? pension,
    $fixnum.Int64? netPay,
  }) {
    final $result = create();
    if (employeeId != null) {
      $result.employeeId = employeeId;
    }
    if (employeeName != null) {
      $result.employeeName = employeeName;
    }
    if (grossPay != null) {
      $result.grossPay = grossPay;
    }
    if (paye != null) {
      $result.paye = paye;
    }
    if (nhf != null) {
      $result.nhf = nhf;
    }
    if (pension != null) {
      $result.pension = pension;
    }
    if (netPay != null) {
      $result.netPay = netPay;
    }
    return $result;
  }
  EmployeeTaxSummary._() : super();
  factory EmployeeTaxSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmployeeTaxSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmployeeTaxSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'employeeId')
    ..aOS(2, _omitFieldNames ? '' : 'employeeName')
    ..aInt64(3, _omitFieldNames ? '' : 'grossPay')
    ..aInt64(4, _omitFieldNames ? '' : 'paye')
    ..aInt64(5, _omitFieldNames ? '' : 'nhf')
    ..aInt64(6, _omitFieldNames ? '' : 'pension')
    ..aInt64(7, _omitFieldNames ? '' : 'netPay')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmployeeTaxSummary clone() => EmployeeTaxSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmployeeTaxSummary copyWith(void Function(EmployeeTaxSummary) updates) => super.copyWith((message) => updates(message as EmployeeTaxSummary)) as EmployeeTaxSummary;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
