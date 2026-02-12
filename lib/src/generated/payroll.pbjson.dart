//
//  Generated code. Do not modify.
//  source: payroll.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use employmentTypeDescriptor instead')
const EmploymentType$json = {
  '1': 'EmploymentType',
  '2': [
    {'1': 'EMPLOYMENT_TYPE_FULL_TIME', '2': 0},
    {'1': 'EMPLOYMENT_TYPE_PART_TIME', '2': 1},
    {'1': 'EMPLOYMENT_TYPE_CONTRACT', '2': 2},
  ],
};

/// Descriptor for `EmploymentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List employmentTypeDescriptor = $convert.base64Decode(
    'Cg5FbXBsb3ltZW50VHlwZRIdChlFTVBMT1lNRU5UX1RZUEVfRlVMTF9USU1FEAASHQoZRU1QTE'
    '9ZTUVOVF9UWVBFX1BBUlRfVElNRRABEhwKGEVNUExPWU1FTlRfVFlQRV9DT05UUkFDVBAC');

@$core.Deprecated('Use payFrequencyDescriptor instead')
const PayFrequency$json = {
  '1': 'PayFrequency',
  '2': [
    {'1': 'PAY_FREQUENCY_MONTHLY', '2': 0},
    {'1': 'PAY_FREQUENCY_BIWEEKLY', '2': 1},
    {'1': 'PAY_FREQUENCY_WEEKLY', '2': 2},
  ],
};

/// Descriptor for `PayFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payFrequencyDescriptor = $convert.base64Decode(
    'CgxQYXlGcmVxdWVuY3kSGQoVUEFZX0ZSRVFVRU5DWV9NT05USExZEAASGgoWUEFZX0ZSRVFVRU'
    '5DWV9CSVdFRUtMWRABEhgKFFBBWV9GUkVRVUVOQ1lfV0VFS0xZEAI=');

@$core.Deprecated('Use employeeStatusDescriptor instead')
const EmployeeStatus$json = {
  '1': 'EmployeeStatus',
  '2': [
    {'1': 'EMPLOYEE_STATUS_ACTIVE', '2': 0},
    {'1': 'EMPLOYEE_STATUS_INACTIVE', '2': 1},
    {'1': 'EMPLOYEE_STATUS_TERMINATED', '2': 2},
  ],
};

/// Descriptor for `EmployeeStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List employeeStatusDescriptor = $convert.base64Decode(
    'Cg5FbXBsb3llZVN0YXR1cxIaChZFTVBMT1lFRV9TVEFUVVNfQUNUSVZFEAASHAoYRU1QTE9ZRU'
    'VfU1RBVFVTX0lOQUNUSVZFEAESHgoaRU1QTE9ZRUVfU1RBVFVTX1RFUk1JTkFURUQQAg==');

@$core.Deprecated('Use payRunStatusDescriptor instead')
const PayRunStatus$json = {
  '1': 'PayRunStatus',
  '2': [
    {'1': 'PAY_RUN_STATUS_DRAFT', '2': 0},
    {'1': 'PAY_RUN_STATUS_CALCULATING', '2': 1},
    {'1': 'PAY_RUN_STATUS_READY', '2': 2},
    {'1': 'PAY_RUN_STATUS_APPROVED', '2': 3},
    {'1': 'PAY_RUN_STATUS_PROCESSING', '2': 4},
    {'1': 'PAY_RUN_STATUS_COMPLETED', '2': 5},
    {'1': 'PAY_RUN_STATUS_FAILED', '2': 6},
  ],
};

/// Descriptor for `PayRunStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payRunStatusDescriptor = $convert.base64Decode(
    'CgxQYXlSdW5TdGF0dXMSGAoUUEFZX1JVTl9TVEFUVVNfRFJBRlQQABIeChpQQVlfUlVOX1NUQV'
    'RVU19DQUxDVUxBVElORxABEhgKFFBBWV9SVU5fU1RBVFVTX1JFQURZEAISGwoXUEFZX1JVTl9T'
    'VEFUVVNfQVBQUk9WRUQQAxIdChlQQVlfUlVOX1NUQVRVU19QUk9DRVNTSU5HEAQSHAoYUEFZX1'
    'JVTl9TVEFUVVNfQ09NUExFVEVEEAUSGQoVUEFZX1JVTl9TVEFUVVNfRkFJTEVEEAY=');

@$core.Deprecated('Use paymentStatusDescriptor instead')
const PaymentStatus$json = {
  '1': 'PaymentStatus',
  '2': [
    {'1': 'PAYMENT_STATUS_PENDING', '2': 0},
    {'1': 'PAYMENT_STATUS_PAID', '2': 1},
    {'1': 'PAYMENT_STATUS_FAILED', '2': 2},
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50U3RhdHVzEhoKFlBBWU1FTlRfU1RBVFVTX1BFTkRJTkcQABIXChNQQVlNRU5UX1'
    'NUQVRVU19QQUlEEAESGQoVUEFZTUVOVF9TVEFUVVNfRkFJTEVEEAI=');

@$core.Deprecated('Use employeeDescriptor instead')
const Employee$json = {
  '1': 'Employee',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'business_id', '3': 3, '4': 1, '5': 9, '10': 'businessId'},
    {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'nin', '3': 7, '4': 1, '5': 9, '10': 'nin'},
    {'1': 'bank_account_number', '3': 8, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    {'1': 'bank_code', '3': 9, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 10, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'employment_type', '3': 11, '4': 1, '5': 14, '6': '.pb.EmploymentType', '10': 'employmentType'},
    {'1': 'pay_rate', '3': 12, '4': 1, '5': 3, '10': 'payRate'},
    {'1': 'pay_frequency', '3': 13, '4': 1, '5': 14, '6': '.pb.PayFrequency', '10': 'payFrequency'},
    {'1': 'department', '3': 14, '4': 1, '5': 9, '10': 'department'},
    {'1': 'job_title', '3': 15, '4': 1, '5': 9, '10': 'jobTitle'},
    {'1': 'start_date', '3': 16, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'status', '3': 17, '4': 1, '5': 14, '6': '.pb.EmployeeStatus', '10': 'status'},
    {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `Employee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List employeeDescriptor = $convert.base64Decode(
    'CghFbXBsb3llZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh8KC2'
    'J1c2luZXNzX2lkGAMgASgJUgpidXNpbmVzc0lkEhsKCWZ1bGxfbmFtZRgEIAEoCVIIZnVsbE5h'
    'bWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEhQKBXBob25lGAYgASgJUgVwaG9uZRIQCgNuaW4YBy'
    'ABKAlSA25pbhIuChNiYW5rX2FjY291bnRfbnVtYmVyGAggASgJUhFiYW5rQWNjb3VudE51bWJl'
    'chIbCgliYW5rX2NvZGUYCSABKAlSCGJhbmtDb2RlEhsKCWJhbmtfbmFtZRgKIAEoCVIIYmFua0'
    '5hbWUSOwoPZW1wbG95bWVudF90eXBlGAsgASgOMhIucGIuRW1wbG95bWVudFR5cGVSDmVtcGxv'
    'eW1lbnRUeXBlEhkKCHBheV9yYXRlGAwgASgDUgdwYXlSYXRlEjUKDXBheV9mcmVxdWVuY3kYDS'
    'ABKA4yEC5wYi5QYXlGcmVxdWVuY3lSDHBheUZyZXF1ZW5jeRIeCgpkZXBhcnRtZW50GA4gASgJ'
    'UgpkZXBhcnRtZW50EhsKCWpvYl90aXRsZRgPIAEoCVIIam9iVGl0bGUSHQoKc3RhcnRfZGF0ZR'
    'gQIAEoCVIJc3RhcnREYXRlEioKBnN0YXR1cxgRIAEoDjISLnBiLkVtcGxveWVlU3RhdHVzUgZz'
    'dGF0dXMSOQoKY3JlYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCW'
    'NyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFt'
    'cFIJdXBkYXRlZEF0');

@$core.Deprecated('Use payRunDescriptor instead')
const PayRun$json = {
  '1': 'PayRun',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    {'1': 'pay_period_start', '3': 3, '4': 1, '5': 9, '10': 'payPeriodStart'},
    {'1': 'pay_period_end', '3': 4, '4': 1, '5': 9, '10': 'payPeriodEnd'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.PayRunStatus', '10': 'status'},
    {'1': 'total_gross', '3': 6, '4': 1, '5': 3, '10': 'totalGross'},
    {'1': 'total_deductions', '3': 7, '4': 1, '5': 3, '10': 'totalDeductions'},
    {'1': 'total_net', '3': 8, '4': 1, '5': 3, '10': 'totalNet'},
    {'1': 'total_employer_contributions', '3': 9, '4': 1, '5': 3, '10': 'totalEmployerContributions'},
    {'1': 'employee_count', '3': 10, '4': 1, '5': 5, '10': 'employeeCount'},
    {'1': 'created_by', '3': 11, '4': 1, '5': 9, '10': 'createdBy'},
    {'1': 'approved_by', '3': 12, '4': 1, '5': 9, '10': 'approvedBy'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    {'1': 'processed_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processedAt'},
  ],
};

/// Descriptor for `PayRun`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payRunDescriptor = $convert.base64Decode(
    'CgZQYXlSdW4SDgoCaWQYASABKAlSAmlkEh8KC2J1c2luZXNzX2lkGAIgASgJUgpidXNpbmVzc0'
    'lkEigKEHBheV9wZXJpb2Rfc3RhcnQYAyABKAlSDnBheVBlcmlvZFN0YXJ0EiQKDnBheV9wZXJp'
    'b2RfZW5kGAQgASgJUgxwYXlQZXJpb2RFbmQSKAoGc3RhdHVzGAUgASgOMhAucGIuUGF5UnVuU3'
    'RhdHVzUgZzdGF0dXMSHwoLdG90YWxfZ3Jvc3MYBiABKANSCnRvdGFsR3Jvc3MSKQoQdG90YWxf'
    'ZGVkdWN0aW9ucxgHIAEoA1IPdG90YWxEZWR1Y3Rpb25zEhsKCXRvdGFsX25ldBgIIAEoA1IIdG'
    '90YWxOZXQSQAocdG90YWxfZW1wbG95ZXJfY29udHJpYnV0aW9ucxgJIAEoA1IadG90YWxFbXBs'
    'b3llckNvbnRyaWJ1dGlvbnMSJQoOZW1wbG95ZWVfY291bnQYCiABKAVSDWVtcGxveWVlQ291bn'
    'QSHQoKY3JlYXRlZF9ieRgLIAEoCVIJY3JlYXRlZEJ5Eh8KC2FwcHJvdmVkX2J5GAwgASgJUgph'
    'cHByb3ZlZEJ5EjkKCmNyZWF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgljcmVhdGVkQXQSPQoMcHJvY2Vzc2VkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRp'
    'bWVzdGFtcFILcHJvY2Vzc2VkQXQ=');

@$core.Deprecated('Use paySlipDescriptor instead')
const PaySlip$json = {
  '1': 'PaySlip',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'pay_run_id', '3': 2, '4': 1, '5': 9, '10': 'payRunId'},
    {'1': 'employee_id', '3': 3, '4': 1, '5': 9, '10': 'employeeId'},
    {'1': 'employee_name', '3': 4, '4': 1, '5': 9, '10': 'employeeName'},
    {'1': 'gross_pay', '3': 5, '4': 1, '5': 3, '10': 'grossPay'},
    {'1': 'income_tax', '3': 6, '4': 1, '5': 3, '10': 'incomeTax'},
    {'1': 'national_insurance', '3': 7, '4': 1, '5': 3, '10': 'nationalInsurance'},
    {'1': 'student_loan_repayment', '3': 8, '4': 1, '5': 3, '10': 'studentLoanRepayment'},
    {'1': 'pension_contribution', '3': 9, '4': 1, '5': 3, '10': 'pensionContribution'},
    {'1': 'other_deductions', '3': 10, '4': 1, '5': 3, '10': 'otherDeductions'},
    {'1': 'total_deductions', '3': 11, '4': 1, '5': 3, '10': 'totalDeductions'},
    {'1': 'net_pay', '3': 12, '4': 1, '5': 3, '10': 'netPay'},
    {'1': 'employer_nic', '3': 13, '4': 1, '5': 3, '10': 'employerNic'},
    {'1': 'employer_pension', '3': 14, '4': 1, '5': 3, '10': 'employerPension'},
    {'1': 'hours_worked', '3': 15, '4': 1, '5': 1, '10': 'hoursWorked'},
    {'1': 'overtime_hours', '3': 16, '4': 1, '5': 1, '10': 'overtimeHours'},
    {'1': 'overtime_pay', '3': 17, '4': 1, '5': 3, '10': 'overtimePay'},
    {'1': 'bonuses', '3': 18, '4': 1, '5': 3, '10': 'bonuses'},
    {'1': 'commissions', '3': 19, '4': 1, '5': 3, '10': 'commissions'},
    {'1': 'payment_status', '3': 20, '4': 1, '5': 14, '6': '.pb.PaymentStatus', '10': 'paymentStatus'},
    {'1': 'payment_reference', '3': 21, '4': 1, '5': 9, '10': 'paymentReference'},
    {'1': 'created_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `PaySlip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paySlipDescriptor = $convert.base64Decode(
    'CgdQYXlTbGlwEg4KAmlkGAEgASgJUgJpZBIcCgpwYXlfcnVuX2lkGAIgASgJUghwYXlSdW5JZB'
    'IfCgtlbXBsb3llZV9pZBgDIAEoCVIKZW1wbG95ZWVJZBIjCg1lbXBsb3llZV9uYW1lGAQgASgJ'
    'UgxlbXBsb3llZU5hbWUSGwoJZ3Jvc3NfcGF5GAUgASgDUghncm9zc1BheRIdCgppbmNvbWVfdG'
    'F4GAYgASgDUglpbmNvbWVUYXgSLQoSbmF0aW9uYWxfaW5zdXJhbmNlGAcgASgDUhFuYXRpb25h'
    'bEluc3VyYW5jZRI0ChZzdHVkZW50X2xvYW5fcmVwYXltZW50GAggASgDUhRzdHVkZW50TG9hbl'
    'JlcGF5bWVudBIxChRwZW5zaW9uX2NvbnRyaWJ1dGlvbhgJIAEoA1ITcGVuc2lvbkNvbnRyaWJ1'
    'dGlvbhIpChBvdGhlcl9kZWR1Y3Rpb25zGAogASgDUg9vdGhlckRlZHVjdGlvbnMSKQoQdG90YW'
    'xfZGVkdWN0aW9ucxgLIAEoA1IPdG90YWxEZWR1Y3Rpb25zEhcKB25ldF9wYXkYDCABKANSBm5l'
    'dFBheRIhCgxlbXBsb3llcl9uaWMYDSABKANSC2VtcGxveWVyTmljEikKEGVtcGxveWVyX3Blbn'
    'Npb24YDiABKANSD2VtcGxveWVyUGVuc2lvbhIhCgxob3Vyc193b3JrZWQYDyABKAFSC2hvdXJz'
    'V29ya2VkEiUKDm92ZXJ0aW1lX2hvdXJzGBAgASgBUg1vdmVydGltZUhvdXJzEiEKDG92ZXJ0aW'
    '1lX3BheRgRIAEoA1ILb3ZlcnRpbWVQYXkSGAoHYm9udXNlcxgSIAEoA1IHYm9udXNlcxIgCgtj'
    'b21taXNzaW9ucxgTIAEoA1ILY29tbWlzc2lvbnMSOAoOcGF5bWVudF9zdGF0dXMYFCABKA4yES'
    '5wYi5QYXltZW50U3RhdHVzUg1wYXltZW50U3RhdHVzEisKEXBheW1lbnRfcmVmZXJlbmNlGBUg'
    'ASgJUhBwYXltZW50UmVmZXJlbmNlEjkKCmNyZWF0ZWRfYXQYFiABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use deductionSummaryDescriptor instead')
const DeductionSummary$json = {
  '1': 'DeductionSummary',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `DeductionSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deductionSummaryDescriptor = $convert.base64Decode(
    'ChBEZWR1Y3Rpb25TdW1tYXJ5EhIKBHR5cGUYASABKAlSBHR5cGUSFgoGYW1vdW50GAIgASgDUg'
    'ZhbW91bnQSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9u');

@$core.Deprecated('Use payrollPaginationInfoDescriptor instead')
const PayrollPaginationInfo$json = {
  '1': 'PayrollPaginationInfo',
  '2': [
    {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
  ],
};

/// Descriptor for `PayrollPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payrollPaginationInfoDescriptor = $convert.base64Decode(
    'ChVQYXlyb2xsUGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UG'
    'FnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEo'
    'BVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdl');

@$core.Deprecated('Use addEmployeeRequestDescriptor instead')
const AddEmployeeRequest$json = {
  '1': 'AddEmployeeRequest',
  '2': [
    {'1': 'full_name', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'nin', '3': 4, '4': 1, '5': 9, '10': 'nin'},
    {'1': 'bank_account_number', '3': 5, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'employment_type', '3': 8, '4': 1, '5': 14, '6': '.pb.EmploymentType', '10': 'employmentType'},
    {'1': 'pay_rate', '3': 9, '4': 1, '5': 3, '10': 'payRate'},
    {'1': 'pay_frequency', '3': 10, '4': 1, '5': 14, '6': '.pb.PayFrequency', '10': 'payFrequency'},
    {'1': 'department', '3': 11, '4': 1, '5': 9, '10': 'department'},
    {'1': 'job_title', '3': 12, '4': 1, '5': 9, '10': 'jobTitle'},
    {'1': 'start_date', '3': 13, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'user_id', '3': 14, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `AddEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEmployeeRequestDescriptor = $convert.base64Decode(
    'ChJBZGRFbXBsb3llZVJlcXVlc3QSGwoJZnVsbF9uYW1lGAEgASgJUghmdWxsTmFtZRIUCgVlbW'
    'FpbBgCIAEoCVIFZW1haWwSFAoFcGhvbmUYAyABKAlSBXBob25lEhAKA25pbhgEIAEoCVIDbmlu'
    'Ei4KE2JhbmtfYWNjb3VudF9udW1iZXIYBSABKAlSEWJhbmtBY2NvdW50TnVtYmVyEhsKCWJhbm'
    'tfY29kZRgGIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAcgASgJUghiYW5rTmFtZRI7Cg9l'
    'bXBsb3ltZW50X3R5cGUYCCABKA4yEi5wYi5FbXBsb3ltZW50VHlwZVIOZW1wbG95bWVudFR5cG'
    'USGQoIcGF5X3JhdGUYCSABKANSB3BheVJhdGUSNQoNcGF5X2ZyZXF1ZW5jeRgKIAEoDjIQLnBi'
    'LlBheUZyZXF1ZW5jeVIMcGF5RnJlcXVlbmN5Eh4KCmRlcGFydG1lbnQYCyABKAlSCmRlcGFydG'
    '1lbnQSGwoJam9iX3RpdGxlGAwgASgJUghqb2JUaXRsZRIdCgpzdGFydF9kYXRlGA0gASgJUglz'
    'dGFydERhdGUSFwoHdXNlcl9pZBgOIAEoCVIGdXNlcklk');

@$core.Deprecated('Use addEmployeeResponseDescriptor instead')
const AddEmployeeResponse$json = {
  '1': 'AddEmployeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'employee', '3': 3, '4': 1, '5': 11, '6': '.pb.Employee', '10': 'employee'},
  ],
};

/// Descriptor for `AddEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEmployeeResponseDescriptor = $convert.base64Decode(
    'ChNBZGRFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2'
    'FnZRgCIAEoCVIHbWVzc2FnZRIoCghlbXBsb3llZRgDIAEoCzIMLnBiLkVtcGxveWVlUghlbXBs'
    'b3llZQ==');

@$core.Deprecated('Use updateEmployeeRequestDescriptor instead')
const UpdateEmployeeRequest$json = {
  '1': 'UpdateEmployeeRequest',
  '2': [
    {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
    {'1': 'full_name', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'nin', '3': 5, '4': 1, '5': 9, '10': 'nin'},
    {'1': 'bank_account_number', '3': 6, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    {'1': 'employment_type', '3': 9, '4': 1, '5': 14, '6': '.pb.EmploymentType', '10': 'employmentType'},
    {'1': 'pay_rate', '3': 10, '4': 1, '5': 3, '10': 'payRate'},
    {'1': 'pay_frequency', '3': 11, '4': 1, '5': 14, '6': '.pb.PayFrequency', '10': 'payFrequency'},
    {'1': 'department', '3': 12, '4': 1, '5': 9, '10': 'department'},
    {'1': 'job_title', '3': 13, '4': 1, '5': 9, '10': 'jobTitle'},
    {'1': 'status', '3': 14, '4': 1, '5': 14, '6': '.pb.EmployeeStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEmployeeRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVFbXBsb3llZVJlcXVlc3QSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSW'
    'QSGwoJZnVsbF9uYW1lGAIgASgJUghmdWxsTmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSFAoF'
    'cGhvbmUYBCABKAlSBXBob25lEhAKA25pbhgFIAEoCVIDbmluEi4KE2JhbmtfYWNjb3VudF9udW'
    '1iZXIYBiABKAlSEWJhbmtBY2NvdW50TnVtYmVyEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0Nv'
    'ZGUSGwoJYmFua19uYW1lGAggASgJUghiYW5rTmFtZRI7Cg9lbXBsb3ltZW50X3R5cGUYCSABKA'
    '4yEi5wYi5FbXBsb3ltZW50VHlwZVIOZW1wbG95bWVudFR5cGUSGQoIcGF5X3JhdGUYCiABKANS'
    'B3BheVJhdGUSNQoNcGF5X2ZyZXF1ZW5jeRgLIAEoDjIQLnBiLlBheUZyZXF1ZW5jeVIMcGF5Rn'
    'JlcXVlbmN5Eh4KCmRlcGFydG1lbnQYDCABKAlSCmRlcGFydG1lbnQSGwoJam9iX3RpdGxlGA0g'
    'ASgJUghqb2JUaXRsZRIqCgZzdGF0dXMYDiABKA4yEi5wYi5FbXBsb3llZVN0YXR1c1IGc3RhdH'
    'Vz');

@$core.Deprecated('Use updateEmployeeResponseDescriptor instead')
const UpdateEmployeeResponse$json = {
  '1': 'UpdateEmployeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'employee', '3': 3, '4': 1, '5': 11, '6': '.pb.Employee', '10': 'employee'},
  ],
};

/// Descriptor for `UpdateEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEmployeeResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghlbXBsb3llZRgDIAEoCzIMLnBiLkVtcGxveWVlUghl'
    'bXBsb3llZQ==');

@$core.Deprecated('Use removeEmployeeRequestDescriptor instead')
const RemoveEmployeeRequest$json = {
  '1': 'RemoveEmployeeRequest',
  '2': [
    {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
  ],
};

/// Descriptor for `RemoveEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeEmployeeRequestDescriptor = $convert.base64Decode(
    'ChVSZW1vdmVFbXBsb3llZVJlcXVlc3QSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSW'
    'Q=');

@$core.Deprecated('Use removeEmployeeResponseDescriptor instead')
const RemoveEmployeeResponse$json = {
  '1': 'RemoveEmployeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeEmployeeResponseDescriptor = $convert.base64Decode(
    'ChZSZW1vdmVFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbW'
    'Vzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use getEmployeeRequestDescriptor instead')
const GetEmployeeRequest$json = {
  '1': 'GetEmployeeRequest',
  '2': [
    {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
  ],
};

/// Descriptor for `GetEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEmployeeRequestDescriptor = $convert.base64Decode(
    'ChJHZXRFbXBsb3llZVJlcXVlc3QSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSWQ=');

@$core.Deprecated('Use getEmployeeResponseDescriptor instead')
const GetEmployeeResponse$json = {
  '1': 'GetEmployeeResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'employee', '3': 3, '4': 1, '5': 11, '6': '.pb.Employee', '10': 'employee'},
  ],
};

/// Descriptor for `GetEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEmployeeResponseDescriptor = $convert.base64Decode(
    'ChNHZXRFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2'
    'FnZRgCIAEoCVIHbWVzc2FnZRIoCghlbXBsb3llZRgDIAEoCzIMLnBiLkVtcGxveWVlUghlbXBs'
    'b3llZQ==');

@$core.Deprecated('Use listEmployeesRequestDescriptor instead')
const ListEmployeesRequest$json = {
  '1': 'ListEmployeesRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.EmployeeStatus', '10': 'status'},
    {'1': 'department', '3': 4, '4': 1, '5': 9, '10': 'department'},
    {'1': 'search', '3': 5, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `ListEmployeesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEmployeesRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0RW1wbG95ZWVzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgAS'
    'gFUgVsaW1pdBIqCgZzdGF0dXMYAyABKA4yEi5wYi5FbXBsb3llZVN0YXR1c1IGc3RhdHVzEh4K'
    'CmRlcGFydG1lbnQYBCABKAlSCmRlcGFydG1lbnQSFgoGc2VhcmNoGAUgASgJUgZzZWFyY2g=');

@$core.Deprecated('Use listEmployeesResponseDescriptor instead')
const ListEmployeesResponse$json = {
  '1': 'ListEmployeesResponse',
  '2': [
    {'1': 'employees', '3': 1, '4': 3, '5': 11, '6': '.pb.Employee', '10': 'employees'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListEmployeesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEmployeesResponseDescriptor = $convert.base64Decode(
    'ChVMaXN0RW1wbG95ZWVzUmVzcG9uc2USKgoJZW1wbG95ZWVzGAEgAygLMgwucGIuRW1wbG95ZW'
    'VSCWVtcGxveWVlcxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25J'
    'bmZvUgpwYWdpbmF0aW9u');

@$core.Deprecated('Use createPayRunRequestDescriptor instead')
const CreatePayRunRequest$json = {
  '1': 'CreatePayRunRequest',
  '2': [
    {'1': 'pay_period_start', '3': 1, '4': 1, '5': 9, '10': 'payPeriodStart'},
    {'1': 'pay_period_end', '3': 2, '4': 1, '5': 9, '10': 'payPeriodEnd'},
  ],
};

/// Descriptor for `CreatePayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPayRunRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVQYXlSdW5SZXF1ZXN0EigKEHBheV9wZXJpb2Rfc3RhcnQYASABKAlSDnBheVBlcm'
    'lvZFN0YXJ0EiQKDnBheV9wZXJpb2RfZW5kGAIgASgJUgxwYXlQZXJpb2RFbmQ=');

@$core.Deprecated('Use createPayRunResponseDescriptor instead')
const CreatePayRunResponse$json = {
  '1': 'CreatePayRunResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
  ],
};

/// Descriptor for `CreatePayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPayRunResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQYXlSdW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USIwoHcGF5X3J1bhgDIAEoCzIKLnBiLlBheVJ1blIGcGF5UnVu');

@$core.Deprecated('Use calculatePayRunRequestDescriptor instead')
const CalculatePayRunRequest$json = {
  '1': 'CalculatePayRunRequest',
  '2': [
    {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
  ],
};

/// Descriptor for `CalculatePayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculatePayRunRequestDescriptor = $convert.base64Decode(
    'ChZDYWxjdWxhdGVQYXlSdW5SZXF1ZXN0EhwKCnBheV9ydW5faWQYASABKAlSCHBheVJ1bklk');

@$core.Deprecated('Use calculatePayRunResponseDescriptor instead')
const CalculatePayRunResponse$json = {
  '1': 'CalculatePayRunResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
    {'1': 'pay_slips', '3': 4, '4': 3, '5': 11, '6': '.pb.PaySlip', '10': 'paySlips'},
  ],
};

/// Descriptor for `CalculatePayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculatePayRunResponseDescriptor = $convert.base64Decode(
    'ChdDYWxjdWxhdGVQYXlSdW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB2'
    '1lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoHcGF5X3J1bhgDIAEoCzIKLnBiLlBheVJ1blIGcGF5'
    'UnVuEigKCXBheV9zbGlwcxgEIAMoCzILLnBiLlBheVNsaXBSCHBheVNsaXBz');

@$core.Deprecated('Use approvePayRunRequestDescriptor instead')
const ApprovePayRunRequest$json = {
  '1': 'ApprovePayRunRequest',
  '2': [
    {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
  ],
};

/// Descriptor for `ApprovePayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approvePayRunRequestDescriptor = $convert.base64Decode(
    'ChRBcHByb3ZlUGF5UnVuUmVxdWVzdBIcCgpwYXlfcnVuX2lkGAEgASgJUghwYXlSdW5JZA==');

@$core.Deprecated('Use approvePayRunResponseDescriptor instead')
const ApprovePayRunResponse$json = {
  '1': 'ApprovePayRunResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
  ],
};

/// Descriptor for `ApprovePayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approvePayRunResponseDescriptor = $convert.base64Decode(
    'ChVBcHByb3ZlUGF5UnVuUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdlEiMKB3BheV9ydW4YAyABKAsyCi5wYi5QYXlSdW5SBnBheVJ1'
    'bg==');

@$core.Deprecated('Use processPayRunRequestDescriptor instead')
const ProcessPayRunRequest$json = {
  '1': 'ProcessPayRunRequest',
  '2': [
    {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
    {'1': 'transaction_pin', '3': 2, '4': 1, '5': 9, '10': 'transactionPin'},
    {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `ProcessPayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayRunRequestDescriptor = $convert.base64Decode(
    'ChRQcm9jZXNzUGF5UnVuUmVxdWVzdBIcCgpwYXlfcnVuX2lkGAEgASgJUghwYXlSdW5JZBInCg'
    '90cmFuc2FjdGlvbl9waW4YAiABKAlSDnRyYW5zYWN0aW9uUGluEioKEXNvdXJjZV9hY2NvdW50'
    'X2lkGAMgASgJUg9zb3VyY2VBY2NvdW50SWQ=');

@$core.Deprecated('Use processPayRunResponseDescriptor instead')
const ProcessPayRunResponse$json = {
  '1': 'ProcessPayRunResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
    {'1': 'successful_payments', '3': 4, '4': 1, '5': 5, '10': 'successfulPayments'},
    {'1': 'failed_payments', '3': 5, '4': 1, '5': 5, '10': 'failedPayments'},
  ],
};

/// Descriptor for `ProcessPayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayRunResponseDescriptor = $convert.base64Decode(
    'ChVQcm9jZXNzUGF5UnVuUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZX'
    'NzYWdlGAIgASgJUgdtZXNzYWdlEiMKB3BheV9ydW4YAyABKAsyCi5wYi5QYXlSdW5SBnBheVJ1'
    'bhIvChNzdWNjZXNzZnVsX3BheW1lbnRzGAQgASgFUhJzdWNjZXNzZnVsUGF5bWVudHMSJwoPZm'
    'FpbGVkX3BheW1lbnRzGAUgASgFUg5mYWlsZWRQYXltZW50cw==');

@$core.Deprecated('Use getPayRunRequestDescriptor instead')
const GetPayRunRequest$json = {
  '1': 'GetPayRunRequest',
  '2': [
    {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
  ],
};

/// Descriptor for `GetPayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayRunRequestDescriptor = $convert.base64Decode(
    'ChBHZXRQYXlSdW5SZXF1ZXN0EhwKCnBheV9ydW5faWQYASABKAlSCHBheVJ1bklk');

@$core.Deprecated('Use getPayRunResponseDescriptor instead')
const GetPayRunResponse$json = {
  '1': 'GetPayRunResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
  ],
};

/// Descriptor for `GetPayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayRunResponseDescriptor = $convert.base64Decode(
    'ChFHZXRQYXlSdW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2'
    'UYAiABKAlSB21lc3NhZ2USIwoHcGF5X3J1bhgDIAEoCzIKLnBiLlBheVJ1blIGcGF5UnVu');

@$core.Deprecated('Use listPayRunsRequestDescriptor instead')
const ListPayRunsRequest$json = {
  '1': 'ListPayRunsRequest',
  '2': [
    {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.PayRunStatus', '10': 'status'},
  ],
};

/// Descriptor for `ListPayRunsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPayRunsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0UGF5UnVuc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBV'
    'IFbGltaXQSKAoGc3RhdHVzGAMgASgOMhAucGIuUGF5UnVuU3RhdHVzUgZzdGF0dXM=');

@$core.Deprecated('Use listPayRunsResponseDescriptor instead')
const ListPayRunsResponse$json = {
  '1': 'ListPayRunsResponse',
  '2': [
    {'1': 'pay_runs', '3': 1, '4': 3, '5': 11, '6': '.pb.PayRun', '10': 'payRuns'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPayRunsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPayRunsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0UGF5UnVuc1Jlc3BvbnNlEiUKCHBheV9ydW5zGAEgAygLMgoucGIuUGF5UnVuUgdwYX'
    'lSdW5zEjkKCnBhZ2luYXRpb24YAiABKAsyGS5wYi5QYXlyb2xsUGFnaW5hdGlvbkluZm9SCnBh'
    'Z2luYXRpb24=');

@$core.Deprecated('Use getPaySlipRequestDescriptor instead')
const GetPaySlipRequest$json = {
  '1': 'GetPaySlipRequest',
  '2': [
    {'1': 'pay_slip_id', '3': 1, '4': 1, '5': 9, '10': 'paySlipId'},
  ],
};

/// Descriptor for `GetPaySlipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaySlipRequestDescriptor = $convert.base64Decode(
    'ChFHZXRQYXlTbGlwUmVxdWVzdBIeCgtwYXlfc2xpcF9pZBgBIAEoCVIJcGF5U2xpcElk');

@$core.Deprecated('Use getPaySlipResponseDescriptor instead')
const GetPaySlipResponse$json = {
  '1': 'GetPaySlipResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'pay_slip', '3': 3, '4': 1, '5': 11, '6': '.pb.PaySlip', '10': 'paySlip'},
  ],
};

/// Descriptor for `GetPaySlipResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaySlipResponseDescriptor = $convert.base64Decode(
    'ChJHZXRQYXlTbGlwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYW'
    'dlGAIgASgJUgdtZXNzYWdlEiYKCHBheV9zbGlwGAMgASgLMgsucGIuUGF5U2xpcFIHcGF5U2xp'
    'cA==');

@$core.Deprecated('Use listPaySlipsRequestDescriptor instead')
const ListPaySlipsRequest$json = {
  '1': 'ListPaySlipsRequest',
  '2': [
    {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
    {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListPaySlipsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaySlipsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0UGF5U2xpcHNSZXF1ZXN0EhwKCnBheV9ydW5faWQYASABKAlSCHBheVJ1bklkEhIKBH'
    'BhZ2UYAiABKAVSBHBhZ2USFAoFbGltaXQYAyABKAVSBWxpbWl0');

@$core.Deprecated('Use listPaySlipsResponseDescriptor instead')
const ListPaySlipsResponse$json = {
  '1': 'ListPaySlipsResponse',
  '2': [
    {'1': 'pay_slips', '3': 1, '4': 3, '5': 11, '6': '.pb.PaySlip', '10': 'paySlips'},
    {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPaySlipsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaySlipsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UGF5U2xpcHNSZXNwb25zZRIoCglwYXlfc2xpcHMYASADKAsyCy5wYi5QYXlTbGlwUg'
    'hwYXlTbGlwcxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZv'
    'UgpwYWdpbmF0aW9u');

@$core.Deprecated('Use getPayrollSummaryRequestDescriptor instead')
const GetPayrollSummaryRequest$json = {
  '1': 'GetPayrollSummaryRequest',
  '2': [
    {'1': 'period_start', '3': 1, '4': 1, '5': 9, '10': 'periodStart'},
    {'1': 'period_end', '3': 2, '4': 1, '5': 9, '10': 'periodEnd'},
  ],
};

/// Descriptor for `GetPayrollSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayrollSummaryRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXlyb2xsU3VtbWFyeVJlcXVlc3QSIQoMcGVyaW9kX3N0YXJ0GAEgASgJUgtwZXJpb2'
    'RTdGFydBIdCgpwZXJpb2RfZW5kGAIgASgJUglwZXJpb2RFbmQ=');

@$core.Deprecated('Use getPayrollSummaryResponseDescriptor instead')
const GetPayrollSummaryResponse$json = {
  '1': 'GetPayrollSummaryResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'total_employees', '3': 3, '4': 1, '5': 5, '10': 'totalEmployees'},
    {'1': 'total_pay_runs', '3': 4, '4': 1, '5': 5, '10': 'totalPayRuns'},
    {'1': 'total_gross_paid', '3': 5, '4': 1, '5': 3, '10': 'totalGrossPaid'},
    {'1': 'total_deductions', '3': 6, '4': 1, '5': 3, '10': 'totalDeductions'},
    {'1': 'total_net_paid', '3': 7, '4': 1, '5': 3, '10': 'totalNetPaid'},
    {'1': 'total_employer_contributions', '3': 8, '4': 1, '5': 3, '10': 'totalEmployerContributions'},
    {'1': 'deduction_breakdown', '3': 9, '4': 3, '5': 11, '6': '.pb.DeductionSummary', '10': 'deductionBreakdown'},
  ],
};

/// Descriptor for `GetPayrollSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayrollSummaryResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXlyb2xsU3VtbWFyeVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGA'
    'oHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRInCg90b3RhbF9lbXBsb3llZXMYAyABKAVSDnRvdGFs'
    'RW1wbG95ZWVzEiQKDnRvdGFsX3BheV9ydW5zGAQgASgFUgx0b3RhbFBheVJ1bnMSKAoQdG90YW'
    'xfZ3Jvc3NfcGFpZBgFIAEoA1IOdG90YWxHcm9zc1BhaWQSKQoQdG90YWxfZGVkdWN0aW9ucxgG'
    'IAEoA1IPdG90YWxEZWR1Y3Rpb25zEiQKDnRvdGFsX25ldF9wYWlkGAcgASgDUgx0b3RhbE5ldF'
    'BhaWQSQAocdG90YWxfZW1wbG95ZXJfY29udHJpYnV0aW9ucxgIIAEoA1IadG90YWxFbXBsb3ll'
    'ckNvbnRyaWJ1dGlvbnMSRQoTZGVkdWN0aW9uX2JyZWFrZG93bhgJIAMoCzIULnBiLkRlZHVjdG'
    'lvblN1bW1hcnlSEmRlZHVjdGlvbkJyZWFrZG93bg==');

@$core.Deprecated('Use getTaxReportRequestDescriptor instead')
const GetTaxReportRequest$json = {
  '1': 'GetTaxReportRequest',
  '2': [
    {'1': 'period_start', '3': 1, '4': 1, '5': 9, '10': 'periodStart'},
    {'1': 'period_end', '3': 2, '4': 1, '5': 9, '10': 'periodEnd'},
  ],
};

/// Descriptor for `GetTaxReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxReportRequestDescriptor = $convert.base64Decode(
    'ChNHZXRUYXhSZXBvcnRSZXF1ZXN0EiEKDHBlcmlvZF9zdGFydBgBIAEoCVILcGVyaW9kU3Rhcn'
    'QSHQoKcGVyaW9kX2VuZBgCIAEoCVIJcGVyaW9kRW5k');

@$core.Deprecated('Use getTaxReportResponseDescriptor instead')
const GetTaxReportResponse$json = {
  '1': 'GetTaxReportResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'total_paye', '3': 3, '4': 1, '5': 3, '10': 'totalPaye'},
    {'1': 'total_nhf', '3': 4, '4': 1, '5': 3, '10': 'totalNhf'},
    {'1': 'total_pension_employee', '3': 5, '4': 1, '5': 3, '10': 'totalPensionEmployee'},
    {'1': 'total_pension_employer', '3': 6, '4': 1, '5': 3, '10': 'totalPensionEmployer'},
    {'1': 'total_nsitf', '3': 7, '4': 1, '5': 3, '10': 'totalNsitf'},
    {'1': 'total_itf', '3': 8, '4': 1, '5': 3, '10': 'totalItf'},
    {'1': 'employee_summaries', '3': 9, '4': 3, '5': 11, '6': '.pb.EmployeeTaxSummary', '10': 'employeeSummaries'},
  ],
};

/// Descriptor for `GetTaxReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxReportResponseDescriptor = $convert.base64Decode(
    'ChRHZXRUYXhSZXBvcnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USHQoKdG90YWxfcGF5ZRgDIAEoA1IJdG90YWxQYXllEhsKCXRv'
    'dGFsX25oZhgEIAEoA1IIdG90YWxOaGYSNAoWdG90YWxfcGVuc2lvbl9lbXBsb3llZRgFIAEoA1'
    'IUdG90YWxQZW5zaW9uRW1wbG95ZWUSNAoWdG90YWxfcGVuc2lvbl9lbXBsb3llchgGIAEoA1IU'
    'dG90YWxQZW5zaW9uRW1wbG95ZXISHwoLdG90YWxfbnNpdGYYByABKANSCnRvdGFsTnNpdGYSGw'
    'oJdG90YWxfaXRmGAggASgDUgh0b3RhbEl0ZhJFChJlbXBsb3llZV9zdW1tYXJpZXMYCSADKAsy'
    'Fi5wYi5FbXBsb3llZVRheFN1bW1hcnlSEWVtcGxveWVlU3VtbWFyaWVz');

@$core.Deprecated('Use employeeTaxSummaryDescriptor instead')
const EmployeeTaxSummary$json = {
  '1': 'EmployeeTaxSummary',
  '2': [
    {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
    {'1': 'employee_name', '3': 2, '4': 1, '5': 9, '10': 'employeeName'},
    {'1': 'gross_pay', '3': 3, '4': 1, '5': 3, '10': 'grossPay'},
    {'1': 'paye', '3': 4, '4': 1, '5': 3, '10': 'paye'},
    {'1': 'nhf', '3': 5, '4': 1, '5': 3, '10': 'nhf'},
    {'1': 'pension', '3': 6, '4': 1, '5': 3, '10': 'pension'},
    {'1': 'net_pay', '3': 7, '4': 1, '5': 3, '10': 'netPay'},
  ],
};

/// Descriptor for `EmployeeTaxSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List employeeTaxSummaryDescriptor = $convert.base64Decode(
    'ChJFbXBsb3llZVRheFN1bW1hcnkSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSWQSIw'
    'oNZW1wbG95ZWVfbmFtZRgCIAEoCVIMZW1wbG95ZWVOYW1lEhsKCWdyb3NzX3BheRgDIAEoA1II'
    'Z3Jvc3NQYXkSEgoEcGF5ZRgEIAEoA1IEcGF5ZRIQCgNuaGYYBSABKANSA25oZhIYCgdwZW5zaW'
    '9uGAYgASgDUgdwZW5zaW9uEhcKB25ldF9wYXkYByABKANSBm5ldFBheQ==');

