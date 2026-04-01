///
//  Generated code. Do not modify.
//  source: payroll.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use employmentTypeDescriptor instead')
const EmploymentType$json = const {
  '1': 'EmploymentType',
  '2': const [
    const {'1': 'EMPLOYMENT_TYPE_FULL_TIME', '2': 0},
    const {'1': 'EMPLOYMENT_TYPE_PART_TIME', '2': 1},
    const {'1': 'EMPLOYMENT_TYPE_CONTRACT', '2': 2},
  ],
};

/// Descriptor for `EmploymentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List employmentTypeDescriptor = $convert.base64Decode('Cg5FbXBsb3ltZW50VHlwZRIdChlFTVBMT1lNRU5UX1RZUEVfRlVMTF9USU1FEAASHQoZRU1QTE9ZTUVOVF9UWVBFX1BBUlRfVElNRRABEhwKGEVNUExPWU1FTlRfVFlQRV9DT05UUkFDVBAC');
@$core.Deprecated('Use payFrequencyDescriptor instead')
const PayFrequency$json = const {
  '1': 'PayFrequency',
  '2': const [
    const {'1': 'PAY_FREQUENCY_MONTHLY', '2': 0},
    const {'1': 'PAY_FREQUENCY_BIWEEKLY', '2': 1},
    const {'1': 'PAY_FREQUENCY_WEEKLY', '2': 2},
  ],
};

/// Descriptor for `PayFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payFrequencyDescriptor = $convert.base64Decode('CgxQYXlGcmVxdWVuY3kSGQoVUEFZX0ZSRVFVRU5DWV9NT05USExZEAASGgoWUEFZX0ZSRVFVRU5DWV9CSVdFRUtMWRABEhgKFFBBWV9GUkVRVUVOQ1lfV0VFS0xZEAI=');
@$core.Deprecated('Use employeeStatusDescriptor instead')
const EmployeeStatus$json = const {
  '1': 'EmployeeStatus',
  '2': const [
    const {'1': 'EMPLOYEE_STATUS_ACTIVE', '2': 0},
    const {'1': 'EMPLOYEE_STATUS_INACTIVE', '2': 1},
    const {'1': 'EMPLOYEE_STATUS_TERMINATED', '2': 2},
  ],
};

/// Descriptor for `EmployeeStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List employeeStatusDescriptor = $convert.base64Decode('Cg5FbXBsb3llZVN0YXR1cxIaChZFTVBMT1lFRV9TVEFUVVNfQUNUSVZFEAASHAoYRU1QTE9ZRUVfU1RBVFVTX0lOQUNUSVZFEAESHgoaRU1QTE9ZRUVfU1RBVFVTX1RFUk1JTkFURUQQAg==');
@$core.Deprecated('Use payRunStatusDescriptor instead')
const PayRunStatus$json = const {
  '1': 'PayRunStatus',
  '2': const [
    const {'1': 'PAY_RUN_STATUS_DRAFT', '2': 0},
    const {'1': 'PAY_RUN_STATUS_CALCULATING', '2': 1},
    const {'1': 'PAY_RUN_STATUS_READY', '2': 2},
    const {'1': 'PAY_RUN_STATUS_APPROVED', '2': 3},
    const {'1': 'PAY_RUN_STATUS_PROCESSING', '2': 4},
    const {'1': 'PAY_RUN_STATUS_COMPLETED', '2': 5},
    const {'1': 'PAY_RUN_STATUS_FAILED', '2': 6},
  ],
};

/// Descriptor for `PayRunStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List payRunStatusDescriptor = $convert.base64Decode('CgxQYXlSdW5TdGF0dXMSGAoUUEFZX1JVTl9TVEFUVVNfRFJBRlQQABIeChpQQVlfUlVOX1NUQVRVU19DQUxDVUxBVElORxABEhgKFFBBWV9SVU5fU1RBVFVTX1JFQURZEAISGwoXUEFZX1JVTl9TVEFUVVNfQVBQUk9WRUQQAxIdChlQQVlfUlVOX1NUQVRVU19QUk9DRVNTSU5HEAQSHAoYUEFZX1JVTl9TVEFUVVNfQ09NUExFVEVEEAUSGQoVUEFZX1JVTl9TVEFUVVNfRkFJTEVEEAY=');
@$core.Deprecated('Use paymentStatusDescriptor instead')
const PaymentStatus$json = const {
  '1': 'PaymentStatus',
  '2': const [
    const {'1': 'PAYMENT_STATUS_PENDING', '2': 0},
    const {'1': 'PAYMENT_STATUS_PAID', '2': 1},
    const {'1': 'PAYMENT_STATUS_FAILED', '2': 2},
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode('Cg1QYXltZW50U3RhdHVzEhoKFlBBWU1FTlRfU1RBVFVTX1BFTkRJTkcQABIXChNQQVlNRU5UX1NUQVRVU19QQUlEEAESGQoVUEFZTUVOVF9TVEFUVVNfRkFJTEVEEAI=');
@$core.Deprecated('Use recurrenceFrequencyDescriptor instead')
const RecurrenceFrequency$json = const {
  '1': 'RecurrenceFrequency',
  '2': const [
    const {'1': 'RECURRENCE_FREQUENCY_NONE', '2': 0},
    const {'1': 'RECURRENCE_FREQUENCY_WEEKLY', '2': 1},
    const {'1': 'RECURRENCE_FREQUENCY_BIWEEKLY', '2': 2},
    const {'1': 'RECURRENCE_FREQUENCY_MONTHLY', '2': 3},
  ],
};

/// Descriptor for `RecurrenceFrequency`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List recurrenceFrequencyDescriptor = $convert.base64Decode('ChNSZWN1cnJlbmNlRnJlcXVlbmN5Eh0KGVJFQ1VSUkVOQ0VfRlJFUVVFTkNZX05PTkUQABIfChtSRUNVUlJFTkNFX0ZSRVFVRU5DWV9XRUVLTFkQARIhCh1SRUNVUlJFTkNFX0ZSRVFVRU5DWV9CSVdFRUtMWRACEiAKHFJFQ1VSUkVOQ0VfRlJFUVVFTkNZX01PTlRITFkQAw==');
@$core.Deprecated('Use inventoryItemStatusDescriptor instead')
const InventoryItemStatus$json = const {
  '1': 'InventoryItemStatus',
  '2': const [
    const {'1': 'INVENTORY_ITEM_STATUS_ACTIVE', '2': 0},
    const {'1': 'INVENTORY_ITEM_STATUS_INACTIVE', '2': 1},
    const {'1': 'INVENTORY_ITEM_STATUS_DISCONTINUED', '2': 2},
  ],
};

/// Descriptor for `InventoryItemStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List inventoryItemStatusDescriptor = $convert.base64Decode('ChNJbnZlbnRvcnlJdGVtU3RhdHVzEiAKHElOVkVOVE9SWV9JVEVNX1NUQVRVU19BQ1RJVkUQABIiCh5JTlZFTlRPUllfSVRFTV9TVEFUVVNfSU5BQ1RJVkUQARImCiJJTlZFTlRPUllfSVRFTV9TVEFUVVNfRElTQ09OVElOVUVEEAI=');
@$core.Deprecated('Use adjustmentTypeDescriptor instead')
const AdjustmentType$json = const {
  '1': 'AdjustmentType',
  '2': const [
    const {'1': 'ADJUSTMENT_TYPE_ADD', '2': 0},
    const {'1': 'ADJUSTMENT_TYPE_REMOVE', '2': 1},
    const {'1': 'ADJUSTMENT_TYPE_SET', '2': 2},
  ],
};

/// Descriptor for `AdjustmentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List adjustmentTypeDescriptor = $convert.base64Decode('Cg5BZGp1c3RtZW50VHlwZRIXChNBREpVU1RNRU5UX1RZUEVfQUREEAASGgoWQURKVVNUTUVOVF9UWVBFX1JFTU9WRRABEhcKE0FESlVTVE1FTlRfVFlQRV9TRVQQAg==');
@$core.Deprecated('Use customerSegmentDescriptor instead')
const CustomerSegment$json = const {
  '1': 'CustomerSegment',
  '2': const [
    const {'1': 'CUSTOMER_SEGMENT_NONE', '2': 0},
    const {'1': 'CUSTOMER_SEGMENT_VIP', '2': 1},
    const {'1': 'CUSTOMER_SEGMENT_RETAIL', '2': 2},
    const {'1': 'CUSTOMER_SEGMENT_WHOLESALE', '2': 3},
    const {'1': 'CUSTOMER_SEGMENT_GOVERNMENT', '2': 4},
    const {'1': 'CUSTOMER_SEGMENT_OVERDUE', '2': 5},
  ],
};

/// Descriptor for `CustomerSegment`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List customerSegmentDescriptor = $convert.base64Decode('Cg9DdXN0b21lclNlZ21lbnQSGQoVQ1VTVE9NRVJfU0VHTUVOVF9OT05FEAASGAoUQ1VTVE9NRVJfU0VHTUVOVF9WSVAQARIbChdDVVNUT01FUl9TRUdNRU5UX1JFVEFJTBACEh4KGkNVU1RPTUVSX1NFR01FTlRfV0hPTEVTQUxFEAMSHwobQ1VTVE9NRVJfU0VHTUVOVF9HT1ZFUk5NRU5UEAQSHAoYQ1VTVE9NRVJfU0VHTUVOVF9PVkVSRFVFEAU=');
@$core.Deprecated('Use customerStatusDescriptor instead')
const CustomerStatus$json = const {
  '1': 'CustomerStatus',
  '2': const [
    const {'1': 'CUSTOMER_STATUS_ACTIVE', '2': 0},
    const {'1': 'CUSTOMER_STATUS_INACTIVE', '2': 1},
    const {'1': 'CUSTOMER_STATUS_BLOCKED', '2': 2},
  ],
};

/// Descriptor for `CustomerStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List customerStatusDescriptor = $convert.base64Decode('Cg5DdXN0b21lclN0YXR1cxIaChZDVVNUT01FUl9TVEFUVVNfQUNUSVZFEAASHAoYQ1VTVE9NRVJfU1RBVFVTX0lOQUNUSVZFEAESGwoXQ1VTVE9NRVJfU1RBVFVTX0JMT0NLRUQQAg==');
@$core.Deprecated('Use taxTypeDescriptor instead')
const TaxType$json = const {
  '1': 'TaxType',
  '2': const [
    const {'1': 'TAX_TYPE_VAT', '2': 0},
    const {'1': 'TAX_TYPE_PAYE', '2': 1},
    const {'1': 'TAX_TYPE_WHT', '2': 2},
    const {'1': 'TAX_TYPE_CIT', '2': 3},
  ],
};

/// Descriptor for `TaxType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List taxTypeDescriptor = $convert.base64Decode('CgdUYXhUeXBlEhAKDFRBWF9UWVBFX1ZBVBAAEhEKDVRBWF9UWVBFX1BBWUUQARIQCgxUQVhfVFlQRV9XSFQQAhIQCgxUQVhfVFlQRV9DSVQQAw==');
@$core.Deprecated('Use taxObligationStatusDescriptor instead')
const TaxObligationStatus$json = const {
  '1': 'TaxObligationStatus',
  '2': const [
    const {'1': 'TAX_OBLIGATION_STATUS_PENDING', '2': 0},
    const {'1': 'TAX_OBLIGATION_STATUS_FILED', '2': 1},
    const {'1': 'TAX_OBLIGATION_STATUS_PAID', '2': 2},
    const {'1': 'TAX_OBLIGATION_STATUS_OVERDUE', '2': 3},
  ],
};

/// Descriptor for `TaxObligationStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List taxObligationStatusDescriptor = $convert.base64Decode('ChNUYXhPYmxpZ2F0aW9uU3RhdHVzEiEKHVRBWF9PQkxJR0FUSU9OX1NUQVRVU19QRU5ESU5HEAASHwobVEFYX09CTElHQVRJT05fU1RBVFVTX0ZJTEVEEAESHgoaVEFYX09CTElHQVRJT05fU1RBVFVTX1BBSUQQAhIhCh1UQVhfT0JMSUdBVElPTl9TVEFUVVNfT1ZFUkRVRRAD');
@$core.Deprecated('Use taxDocumentTypeDescriptor instead')
const TaxDocumentType$json = const {
  '1': 'TaxDocumentType',
  '2': const [
    const {'1': 'TAX_DOCUMENT_TYPE_TIN_CERT', '2': 0},
    const {'1': 'TAX_DOCUMENT_TYPE_VAT_REGISTRATION', '2': 1},
    const {'1': 'TAX_DOCUMENT_TYPE_TAX_CLEARANCE', '2': 2},
    const {'1': 'TAX_DOCUMENT_TYPE_WHT_RECEIPT', '2': 3},
    const {'1': 'TAX_DOCUMENT_TYPE_FILING_RECEIPT', '2': 4},
  ],
};

/// Descriptor for `TaxDocumentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List taxDocumentTypeDescriptor = $convert.base64Decode('Cg9UYXhEb2N1bWVudFR5cGUSHgoaVEFYX0RPQ1VNRU5UX1RZUEVfVElOX0NFUlQQABImCiJUQVhfRE9DVU1FTlRfVFlQRV9WQVRfUkVHSVNUUkFUSU9OEAESIwofVEFYX0RPQ1VNRU5UX1RZUEVfVEFYX0NMRUFSQU5DRRACEiEKHVRBWF9ET0NVTUVOVF9UWVBFX1dIVF9SRUNFSVBUEAMSJAogVEFYX0RPQ1VNRU5UX1RZUEVfRklMSU5HX1JFQ0VJUFQQBA==');
@$core.Deprecated('Use vATDirectionDescriptor instead')
const VATDirection$json = const {
  '1': 'VATDirection',
  '2': const [
    const {'1': 'VAT_DIRECTION_OUTPUT', '2': 0},
    const {'1': 'VAT_DIRECTION_INPUT', '2': 1},
  ],
};

/// Descriptor for `VATDirection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List vATDirectionDescriptor = $convert.base64Decode('CgxWQVREaXJlY3Rpb24SGAoUVkFUX0RJUkVDVElPTl9PVVRQVVQQABIXChNWQVRfRElSRUNUSU9OX0lOUFVUEAE=');
@$core.Deprecated('Use purchaseOrderStatusDescriptor instead')
const PurchaseOrderStatus$json = const {
  '1': 'PurchaseOrderStatus',
  '2': const [
    const {'1': 'PURCHASE_ORDER_STATUS_DRAFT', '2': 0},
    const {'1': 'PURCHASE_ORDER_STATUS_SUBMITTED', '2': 1},
    const {'1': 'PURCHASE_ORDER_STATUS_RECEIVED', '2': 2},
    const {'1': 'PURCHASE_ORDER_STATUS_CANCELLED', '2': 3},
  ],
};

/// Descriptor for `PurchaseOrderStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List purchaseOrderStatusDescriptor = $convert.base64Decode('ChNQdXJjaGFzZU9yZGVyU3RhdHVzEh8KG1BVUkNIQVNFX09SREVSX1NUQVRVU19EUkFGVBAAEiMKH1BVUkNIQVNFX09SREVSX1NUQVRVU19TVUJNSVRURUQQARIiCh5QVVJDSEFTRV9PUkRFUl9TVEFUVVNfUkVDRUlWRUQQAhIjCh9QVVJDSEFTRV9PUkRFUl9TVEFUVVNfQ0FOQ0VMTEVEEAM=');
@$core.Deprecated('Use supplierStatusDescriptor instead')
const SupplierStatus$json = const {
  '1': 'SupplierStatus',
  '2': const [
    const {'1': 'SUPPLIER_STATUS_ACTIVE', '2': 0},
    const {'1': 'SUPPLIER_STATUS_INACTIVE', '2': 1},
  ],
};

/// Descriptor for `SupplierStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List supplierStatusDescriptor = $convert.base64Decode('Cg5TdXBwbGllclN0YXR1cxIaChZTVVBQTElFUl9TVEFUVVNfQUNUSVZFEAASHAoYU1VQUExJRVJfU1RBVFVTX0lOQUNUSVZFEAE=');
@$core.Deprecated('Use employeeDescriptor instead')
const Employee$json = const {
  '1': 'Employee',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'business_id', '3': 3, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'full_name', '3': 4, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'nin', '3': 7, '4': 1, '5': 9, '10': 'nin'},
    const {'1': 'bank_account_number', '3': 8, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    const {'1': 'bank_code', '3': 9, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 10, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'employment_type', '3': 11, '4': 1, '5': 14, '6': '.pb.EmploymentType', '10': 'employmentType'},
    const {'1': 'pay_rate', '3': 12, '4': 1, '5': 3, '10': 'payRate'},
    const {'1': 'pay_frequency', '3': 13, '4': 1, '5': 14, '6': '.pb.PayFrequency', '10': 'payFrequency'},
    const {'1': 'department', '3': 14, '4': 1, '5': 9, '10': 'department'},
    const {'1': 'job_title', '3': 15, '4': 1, '5': 9, '10': 'jobTitle'},
    const {'1': 'start_date', '3': 16, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'status', '3': 17, '4': 1, '5': 14, '6': '.pb.EmployeeStatus', '10': 'status'},
    const {'1': 'created_at', '3': 18, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `Employee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List employeeDescriptor = $convert.base64Decode('CghFbXBsb3llZRIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEh8KC2J1c2luZXNzX2lkGAMgASgJUgpidXNpbmVzc0lkEhsKCWZ1bGxfbmFtZRgEIAEoCVIIZnVsbE5hbWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEhQKBXBob25lGAYgASgJUgVwaG9uZRIQCgNuaW4YByABKAlSA25pbhIuChNiYW5rX2FjY291bnRfbnVtYmVyGAggASgJUhFiYW5rQWNjb3VudE51bWJlchIbCgliYW5rX2NvZGUYCSABKAlSCGJhbmtDb2RlEhsKCWJhbmtfbmFtZRgKIAEoCVIIYmFua05hbWUSOwoPZW1wbG95bWVudF90eXBlGAsgASgOMhIucGIuRW1wbG95bWVudFR5cGVSDmVtcGxveW1lbnRUeXBlEhkKCHBheV9yYXRlGAwgASgDUgdwYXlSYXRlEjUKDXBheV9mcmVxdWVuY3kYDSABKA4yEC5wYi5QYXlGcmVxdWVuY3lSDHBheUZyZXF1ZW5jeRIeCgpkZXBhcnRtZW50GA4gASgJUgpkZXBhcnRtZW50EhsKCWpvYl90aXRsZRgPIAEoCVIIam9iVGl0bGUSHQoKc3RhcnRfZGF0ZRgQIAEoCVIJc3RhcnREYXRlEioKBnN0YXR1cxgRIAEoDjISLnBiLkVtcGxveWVlU3RhdHVzUgZzdGF0dXMSOQoKY3JlYXRlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdBI5Cgp1cGRhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0');
@$core.Deprecated('Use payRunDescriptor instead')
const PayRun$json = const {
  '1': 'PayRun',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'pay_period_start', '3': 3, '4': 1, '5': 9, '10': 'payPeriodStart'},
    const {'1': 'pay_period_end', '3': 4, '4': 1, '5': 9, '10': 'payPeriodEnd'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.PayRunStatus', '10': 'status'},
    const {'1': 'total_gross', '3': 6, '4': 1, '5': 3, '10': 'totalGross'},
    const {'1': 'total_deductions', '3': 7, '4': 1, '5': 3, '10': 'totalDeductions'},
    const {'1': 'total_net', '3': 8, '4': 1, '5': 3, '10': 'totalNet'},
    const {'1': 'total_employer_contributions', '3': 9, '4': 1, '5': 3, '10': 'totalEmployerContributions'},
    const {'1': 'employee_count', '3': 10, '4': 1, '5': 5, '10': 'employeeCount'},
    const {'1': 'created_by', '3': 11, '4': 1, '5': 9, '10': 'createdBy'},
    const {'1': 'approved_by', '3': 12, '4': 1, '5': 9, '10': 'approvedBy'},
    const {'1': 'created_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'processed_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'processedAt'},
    const {'1': 'name', '3': 15, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'is_recurring', '3': 16, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_frequency', '3': 17, '4': 1, '5': 14, '6': '.pb.RecurrenceFrequency', '10': 'recurrenceFrequency'},
    const {'1': 'next_scheduled_date', '3': 18, '4': 1, '5': 9, '10': 'nextScheduledDate'},
    const {'1': 'auto_approve', '3': 19, '4': 1, '5': 8, '10': 'autoApprove'},
    const {'1': 'employee_ids', '3': 20, '4': 3, '5': 9, '10': 'employeeIds'},
  ],
};

/// Descriptor for `PayRun`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payRunDescriptor = $convert.base64Decode('CgZQYXlSdW4SDgoCaWQYASABKAlSAmlkEh8KC2J1c2luZXNzX2lkGAIgASgJUgpidXNpbmVzc0lkEigKEHBheV9wZXJpb2Rfc3RhcnQYAyABKAlSDnBheVBlcmlvZFN0YXJ0EiQKDnBheV9wZXJpb2RfZW5kGAQgASgJUgxwYXlQZXJpb2RFbmQSKAoGc3RhdHVzGAUgASgOMhAucGIuUGF5UnVuU3RhdHVzUgZzdGF0dXMSHwoLdG90YWxfZ3Jvc3MYBiABKANSCnRvdGFsR3Jvc3MSKQoQdG90YWxfZGVkdWN0aW9ucxgHIAEoA1IPdG90YWxEZWR1Y3Rpb25zEhsKCXRvdGFsX25ldBgIIAEoA1IIdG90YWxOZXQSQAocdG90YWxfZW1wbG95ZXJfY29udHJpYnV0aW9ucxgJIAEoA1IadG90YWxFbXBsb3llckNvbnRyaWJ1dGlvbnMSJQoOZW1wbG95ZWVfY291bnQYCiABKAVSDWVtcGxveWVlQ291bnQSHQoKY3JlYXRlZF9ieRgLIAEoCVIJY3JlYXRlZEJ5Eh8KC2FwcHJvdmVkX2J5GAwgASgJUgphcHByb3ZlZEJ5EjkKCmNyZWF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPQoMcHJvY2Vzc2VkX2F0GA4gASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFILcHJvY2Vzc2VkQXQSEgoEbmFtZRgPIAEoCVIEbmFtZRIhCgxpc19yZWN1cnJpbmcYECABKAhSC2lzUmVjdXJyaW5nEkoKFHJlY3VycmVuY2VfZnJlcXVlbmN5GBEgASgOMhcucGIuUmVjdXJyZW5jZUZyZXF1ZW5jeVITcmVjdXJyZW5jZUZyZXF1ZW5jeRIuChNuZXh0X3NjaGVkdWxlZF9kYXRlGBIgASgJUhFuZXh0U2NoZWR1bGVkRGF0ZRIhCgxhdXRvX2FwcHJvdmUYEyABKAhSC2F1dG9BcHByb3ZlEiEKDGVtcGxveWVlX2lkcxgUIAMoCVILZW1wbG95ZWVJZHM=');
@$core.Deprecated('Use inventoryItemDescriptor instead')
const InventoryItem$json = const {
  '1': 'InventoryItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 5, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'quantity', '3': 6, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'unit_price', '3': 7, '4': 1, '5': 3, '10': 'unitPrice'},
    const {'1': 'unit', '3': 8, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'sku', '3': 9, '4': 1, '5': 9, '10': 'sku'},
    const {'1': 'location', '3': 10, '4': 1, '5': 9, '10': 'location'},
    const {'1': 'minimum_stock_level', '3': 11, '4': 1, '5': 5, '10': 'minimumStockLevel'},
    const {'1': 'status', '3': 12, '4': 1, '5': 14, '6': '.pb.InventoryItemStatus', '10': 'status'},
    const {'1': 'notes', '3': 13, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `InventoryItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryItemDescriptor = $convert.base64Decode('Cg1JbnZlbnRvcnlJdGVtEg4KAmlkGAEgASgJUgJpZBIfCgtidXNpbmVzc19pZBgCIAEoCVIKYnVzaW5lc3NJZBISCgRuYW1lGAMgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgFIAEoCVIIY2F0ZWdvcnkSGgoIcXVhbnRpdHkYBiABKAVSCHF1YW50aXR5Eh0KCnVuaXRfcHJpY2UYByABKANSCXVuaXRQcmljZRISCgR1bml0GAggASgJUgR1bml0EhAKA3NrdRgJIAEoCVIDc2t1EhoKCGxvY2F0aW9uGAogASgJUghsb2NhdGlvbhIuChNtaW5pbXVtX3N0b2NrX2xldmVsGAsgASgFUhFtaW5pbXVtU3RvY2tMZXZlbBIvCgZzdGF0dXMYDCABKA4yFy5wYi5JbnZlbnRvcnlJdGVtU3RhdHVzUgZzdGF0dXMSFAoFbm90ZXMYDSABKAlSBW5vdGVzEjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');
@$core.Deprecated('Use inventoryAdjustmentDescriptor instead')
const InventoryAdjustment$json = const {
  '1': 'InventoryAdjustment',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'item_id', '3': 2, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'business_id', '3': 3, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'adjustment_type', '3': 4, '4': 1, '5': 14, '6': '.pb.AdjustmentType', '10': 'adjustmentType'},
    const {'1': 'quantity_change', '3': 5, '4': 1, '5': 5, '10': 'quantityChange'},
    const {'1': 'quantity_before', '3': 6, '4': 1, '5': 5, '10': 'quantityBefore'},
    const {'1': 'quantity_after', '3': 7, '4': 1, '5': 5, '10': 'quantityAfter'},
    const {'1': 'reason', '3': 8, '4': 1, '5': 9, '10': 'reason'},
    const {'1': 'adjusted_by', '3': 9, '4': 1, '5': 9, '10': 'adjustedBy'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `InventoryAdjustment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryAdjustmentDescriptor = $convert.base64Decode('ChNJbnZlbnRvcnlBZGp1c3RtZW50Eg4KAmlkGAEgASgJUgJpZBIXCgdpdGVtX2lkGAIgASgJUgZpdGVtSWQSHwoLYnVzaW5lc3NfaWQYAyABKAlSCmJ1c2luZXNzSWQSOwoPYWRqdXN0bWVudF90eXBlGAQgASgOMhIucGIuQWRqdXN0bWVudFR5cGVSDmFkanVzdG1lbnRUeXBlEicKD3F1YW50aXR5X2NoYW5nZRgFIAEoBVIOcXVhbnRpdHlDaGFuZ2USJwoPcXVhbnRpdHlfYmVmb3JlGAYgASgFUg5xdWFudGl0eUJlZm9yZRIlCg5xdWFudGl0eV9hZnRlchgHIAEoBVINcXVhbnRpdHlBZnRlchIWCgZyZWFzb24YCCABKAlSBnJlYXNvbhIfCgthZGp1c3RlZF9ieRgJIAEoCVIKYWRqdXN0ZWRCeRI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use inventoryCategorySummaryDescriptor instead')
const InventoryCategorySummary$json = const {
  '1': 'InventoryCategorySummary',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'item_count', '3': 2, '4': 1, '5': 5, '10': 'itemCount'},
    const {'1': 'total_value', '3': 3, '4': 1, '5': 3, '10': 'totalValue'},
    const {'1': 'low_stock_count', '3': 4, '4': 1, '5': 5, '10': 'lowStockCount'},
  ],
};

/// Descriptor for `InventoryCategorySummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryCategorySummaryDescriptor = $convert.base64Decode('ChhJbnZlbnRvcnlDYXRlZ29yeVN1bW1hcnkSGgoIY2F0ZWdvcnkYASABKAlSCGNhdGVnb3J5Eh0KCml0ZW1fY291bnQYAiABKAVSCWl0ZW1Db3VudBIfCgt0b3RhbF92YWx1ZRgDIAEoA1IKdG90YWxWYWx1ZRImCg9sb3dfc3RvY2tfY291bnQYBCABKAVSDWxvd1N0b2NrQ291bnQ=');
@$core.Deprecated('Use paySlipDescriptor instead')
const PaySlip$json = const {
  '1': 'PaySlip',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'pay_run_id', '3': 2, '4': 1, '5': 9, '10': 'payRunId'},
    const {'1': 'employee_id', '3': 3, '4': 1, '5': 9, '10': 'employeeId'},
    const {'1': 'employee_name', '3': 4, '4': 1, '5': 9, '10': 'employeeName'},
    const {'1': 'gross_pay', '3': 5, '4': 1, '5': 3, '10': 'grossPay'},
    const {'1': 'income_tax', '3': 6, '4': 1, '5': 3, '10': 'incomeTax'},
    const {'1': 'national_insurance', '3': 7, '4': 1, '5': 3, '10': 'nationalInsurance'},
    const {'1': 'student_loan_repayment', '3': 8, '4': 1, '5': 3, '10': 'studentLoanRepayment'},
    const {'1': 'pension_contribution', '3': 9, '4': 1, '5': 3, '10': 'pensionContribution'},
    const {'1': 'other_deductions', '3': 10, '4': 1, '5': 3, '10': 'otherDeductions'},
    const {'1': 'total_deductions', '3': 11, '4': 1, '5': 3, '10': 'totalDeductions'},
    const {'1': 'net_pay', '3': 12, '4': 1, '5': 3, '10': 'netPay'},
    const {'1': 'employer_nic', '3': 13, '4': 1, '5': 3, '10': 'employerNic'},
    const {'1': 'employer_pension', '3': 14, '4': 1, '5': 3, '10': 'employerPension'},
    const {'1': 'hours_worked', '3': 15, '4': 1, '5': 1, '10': 'hoursWorked'},
    const {'1': 'overtime_hours', '3': 16, '4': 1, '5': 1, '10': 'overtimeHours'},
    const {'1': 'overtime_pay', '3': 17, '4': 1, '5': 3, '10': 'overtimePay'},
    const {'1': 'bonuses', '3': 18, '4': 1, '5': 3, '10': 'bonuses'},
    const {'1': 'commissions', '3': 19, '4': 1, '5': 3, '10': 'commissions'},
    const {'1': 'payment_status', '3': 20, '4': 1, '5': 14, '6': '.pb.PaymentStatus', '10': 'paymentStatus'},
    const {'1': 'payment_reference', '3': 21, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'created_at', '3': 22, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `PaySlip`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paySlipDescriptor = $convert.base64Decode('CgdQYXlTbGlwEg4KAmlkGAEgASgJUgJpZBIcCgpwYXlfcnVuX2lkGAIgASgJUghwYXlSdW5JZBIfCgtlbXBsb3llZV9pZBgDIAEoCVIKZW1wbG95ZWVJZBIjCg1lbXBsb3llZV9uYW1lGAQgASgJUgxlbXBsb3llZU5hbWUSGwoJZ3Jvc3NfcGF5GAUgASgDUghncm9zc1BheRIdCgppbmNvbWVfdGF4GAYgASgDUglpbmNvbWVUYXgSLQoSbmF0aW9uYWxfaW5zdXJhbmNlGAcgASgDUhFuYXRpb25hbEluc3VyYW5jZRI0ChZzdHVkZW50X2xvYW5fcmVwYXltZW50GAggASgDUhRzdHVkZW50TG9hblJlcGF5bWVudBIxChRwZW5zaW9uX2NvbnRyaWJ1dGlvbhgJIAEoA1ITcGVuc2lvbkNvbnRyaWJ1dGlvbhIpChBvdGhlcl9kZWR1Y3Rpb25zGAogASgDUg9vdGhlckRlZHVjdGlvbnMSKQoQdG90YWxfZGVkdWN0aW9ucxgLIAEoA1IPdG90YWxEZWR1Y3Rpb25zEhcKB25ldF9wYXkYDCABKANSBm5ldFBheRIhCgxlbXBsb3llcl9uaWMYDSABKANSC2VtcGxveWVyTmljEikKEGVtcGxveWVyX3BlbnNpb24YDiABKANSD2VtcGxveWVyUGVuc2lvbhIhCgxob3Vyc193b3JrZWQYDyABKAFSC2hvdXJzV29ya2VkEiUKDm92ZXJ0aW1lX2hvdXJzGBAgASgBUg1vdmVydGltZUhvdXJzEiEKDG92ZXJ0aW1lX3BheRgRIAEoA1ILb3ZlcnRpbWVQYXkSGAoHYm9udXNlcxgSIAEoA1IHYm9udXNlcxIgCgtjb21taXNzaW9ucxgTIAEoA1ILY29tbWlzc2lvbnMSOAoOcGF5bWVudF9zdGF0dXMYFCABKA4yES5wYi5QYXltZW50U3RhdHVzUg1wYXltZW50U3RhdHVzEisKEXBheW1lbnRfcmVmZXJlbmNlGBUgASgJUhBwYXltZW50UmVmZXJlbmNlEjkKCmNyZWF0ZWRfYXQYFiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use deductionSummaryDescriptor instead')
const DeductionSummary$json = const {
  '1': 'DeductionSummary',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `DeductionSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deductionSummaryDescriptor = $convert.base64Decode('ChBEZWR1Y3Rpb25TdW1tYXJ5EhIKBHR5cGUYASABKAlSBHR5cGUSFgoGYW1vdW50GAIgASgDUgZhbW91bnQSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9u');
@$core.Deprecated('Use payrollPaginationInfoDescriptor instead')
const PayrollPaginationInfo$json = const {
  '1': 'PayrollPaginationInfo',
  '2': const [
    const {'1': 'current_page', '3': 1, '4': 1, '5': 5, '10': 'currentPage'},
    const {'1': 'total_pages', '3': 2, '4': 1, '5': 5, '10': 'totalPages'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'items_per_page', '3': 4, '4': 1, '5': 5, '10': 'itemsPerPage'},
  ],
};

/// Descriptor for `PayrollPaginationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payrollPaginationInfoDescriptor = $convert.base64Decode('ChVQYXlyb2xsUGFnaW5hdGlvbkluZm8SIQoMY3VycmVudF9wYWdlGAEgASgFUgtjdXJyZW50UGFnZRIfCgt0b3RhbF9wYWdlcxgCIAEoBVIKdG90YWxQYWdlcxIfCgt0b3RhbF9pdGVtcxgDIAEoBVIKdG90YWxJdGVtcxIkCg5pdGVtc19wZXJfcGFnZRgEIAEoBVIMaXRlbXNQZXJQYWdl');
@$core.Deprecated('Use addEmployeeRequestDescriptor instead')
const AddEmployeeRequest$json = const {
  '1': 'AddEmployeeRequest',
  '2': const [
    const {'1': 'full_name', '3': 1, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'nin', '3': 4, '4': 1, '5': 9, '10': 'nin'},
    const {'1': 'bank_account_number', '3': 5, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    const {'1': 'bank_code', '3': 6, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 7, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'employment_type', '3': 8, '4': 1, '5': 14, '6': '.pb.EmploymentType', '10': 'employmentType'},
    const {'1': 'pay_rate', '3': 9, '4': 1, '5': 3, '10': 'payRate'},
    const {'1': 'pay_frequency', '3': 10, '4': 1, '5': 14, '6': '.pb.PayFrequency', '10': 'payFrequency'},
    const {'1': 'department', '3': 11, '4': 1, '5': 9, '10': 'department'},
    const {'1': 'job_title', '3': 12, '4': 1, '5': 9, '10': 'jobTitle'},
    const {'1': 'start_date', '3': 13, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'user_id', '3': 14, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `AddEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEmployeeRequestDescriptor = $convert.base64Decode('ChJBZGRFbXBsb3llZVJlcXVlc3QSGwoJZnVsbF9uYW1lGAEgASgJUghmdWxsTmFtZRIUCgVlbWFpbBgCIAEoCVIFZW1haWwSFAoFcGhvbmUYAyABKAlSBXBob25lEhAKA25pbhgEIAEoCVIDbmluEi4KE2JhbmtfYWNjb3VudF9udW1iZXIYBSABKAlSEWJhbmtBY2NvdW50TnVtYmVyEhsKCWJhbmtfY29kZRgGIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAcgASgJUghiYW5rTmFtZRI7Cg9lbXBsb3ltZW50X3R5cGUYCCABKA4yEi5wYi5FbXBsb3ltZW50VHlwZVIOZW1wbG95bWVudFR5cGUSGQoIcGF5X3JhdGUYCSABKANSB3BheVJhdGUSNQoNcGF5X2ZyZXF1ZW5jeRgKIAEoDjIQLnBiLlBheUZyZXF1ZW5jeVIMcGF5RnJlcXVlbmN5Eh4KCmRlcGFydG1lbnQYCyABKAlSCmRlcGFydG1lbnQSGwoJam9iX3RpdGxlGAwgASgJUghqb2JUaXRsZRIdCgpzdGFydF9kYXRlGA0gASgJUglzdGFydERhdGUSFwoHdXNlcl9pZBgOIAEoCVIGdXNlcklk');
@$core.Deprecated('Use addEmployeeResponseDescriptor instead')
const AddEmployeeResponse$json = const {
  '1': 'AddEmployeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'employee', '3': 3, '4': 1, '5': 11, '6': '.pb.Employee', '10': 'employee'},
  ],
};

/// Descriptor for `AddEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addEmployeeResponseDescriptor = $convert.base64Decode('ChNBZGRFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghlbXBsb3llZRgDIAEoCzIMLnBiLkVtcGxveWVlUghlbXBsb3llZQ==');
@$core.Deprecated('Use updateEmployeeRequestDescriptor instead')
const UpdateEmployeeRequest$json = const {
  '1': 'UpdateEmployeeRequest',
  '2': const [
    const {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
    const {'1': 'full_name', '3': 2, '4': 1, '5': 9, '10': 'fullName'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'nin', '3': 5, '4': 1, '5': 9, '10': 'nin'},
    const {'1': 'bank_account_number', '3': 6, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    const {'1': 'bank_code', '3': 7, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 8, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'employment_type', '3': 9, '4': 1, '5': 14, '6': '.pb.EmploymentType', '10': 'employmentType'},
    const {'1': 'pay_rate', '3': 10, '4': 1, '5': 3, '10': 'payRate'},
    const {'1': 'pay_frequency', '3': 11, '4': 1, '5': 14, '6': '.pb.PayFrequency', '10': 'payFrequency'},
    const {'1': 'department', '3': 12, '4': 1, '5': 9, '10': 'department'},
    const {'1': 'job_title', '3': 13, '4': 1, '5': 9, '10': 'jobTitle'},
    const {'1': 'status', '3': 14, '4': 1, '5': 14, '6': '.pb.EmployeeStatus', '10': 'status'},
  ],
};

/// Descriptor for `UpdateEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEmployeeRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVFbXBsb3llZVJlcXVlc3QSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSWQSGwoJZnVsbF9uYW1lGAIgASgJUghmdWxsTmFtZRIUCgVlbWFpbBgDIAEoCVIFZW1haWwSFAoFcGhvbmUYBCABKAlSBXBob25lEhAKA25pbhgFIAEoCVIDbmluEi4KE2JhbmtfYWNjb3VudF9udW1iZXIYBiABKAlSEWJhbmtBY2NvdW50TnVtYmVyEhsKCWJhbmtfY29kZRgHIAEoCVIIYmFua0NvZGUSGwoJYmFua19uYW1lGAggASgJUghiYW5rTmFtZRI7Cg9lbXBsb3ltZW50X3R5cGUYCSABKA4yEi5wYi5FbXBsb3ltZW50VHlwZVIOZW1wbG95bWVudFR5cGUSGQoIcGF5X3JhdGUYCiABKANSB3BheVJhdGUSNQoNcGF5X2ZyZXF1ZW5jeRgLIAEoDjIQLnBiLlBheUZyZXF1ZW5jeVIMcGF5RnJlcXVlbmN5Eh4KCmRlcGFydG1lbnQYDCABKAlSCmRlcGFydG1lbnQSGwoJam9iX3RpdGxlGA0gASgJUghqb2JUaXRsZRIqCgZzdGF0dXMYDiABKA4yEi5wYi5FbXBsb3llZVN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use updateEmployeeResponseDescriptor instead')
const UpdateEmployeeResponse$json = const {
  '1': 'UpdateEmployeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'employee', '3': 3, '4': 1, '5': 11, '6': '.pb.Employee', '10': 'employee'},
  ],
};

/// Descriptor for `UpdateEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateEmployeeResponseDescriptor = $convert.base64Decode('ChZVcGRhdGVFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghlbXBsb3llZRgDIAEoCzIMLnBiLkVtcGxveWVlUghlbXBsb3llZQ==');
@$core.Deprecated('Use removeEmployeeRequestDescriptor instead')
const RemoveEmployeeRequest$json = const {
  '1': 'RemoveEmployeeRequest',
  '2': const [
    const {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
  ],
};

/// Descriptor for `RemoveEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeEmployeeRequestDescriptor = $convert.base64Decode('ChVSZW1vdmVFbXBsb3llZVJlcXVlc3QSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSWQ=');
@$core.Deprecated('Use removeEmployeeResponseDescriptor instead')
const RemoveEmployeeResponse$json = const {
  '1': 'RemoveEmployeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `RemoveEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeEmployeeResponseDescriptor = $convert.base64Decode('ChZSZW1vdmVFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getEmployeeRequestDescriptor instead')
const GetEmployeeRequest$json = const {
  '1': 'GetEmployeeRequest',
  '2': const [
    const {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
  ],
};

/// Descriptor for `GetEmployeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEmployeeRequestDescriptor = $convert.base64Decode('ChJHZXRFbXBsb3llZVJlcXVlc3QSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSWQ=');
@$core.Deprecated('Use getEmployeeResponseDescriptor instead')
const GetEmployeeResponse$json = const {
  '1': 'GetEmployeeResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'employee', '3': 3, '4': 1, '5': 11, '6': '.pb.Employee', '10': 'employee'},
  ],
};

/// Descriptor for `GetEmployeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEmployeeResponseDescriptor = $convert.base64Decode('ChNHZXRFbXBsb3llZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghlbXBsb3llZRgDIAEoCzIMLnBiLkVtcGxveWVlUghlbXBsb3llZQ==');
@$core.Deprecated('Use listEmployeesRequestDescriptor instead')
const ListEmployeesRequest$json = const {
  '1': 'ListEmployeesRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.EmployeeStatus', '10': 'status'},
    const {'1': 'department', '3': 4, '4': 1, '5': 9, '10': 'department'},
    const {'1': 'search', '3': 5, '4': 1, '5': 9, '10': 'search'},
  ],
};

/// Descriptor for `ListEmployeesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEmployeesRequestDescriptor = $convert.base64Decode('ChRMaXN0RW1wbG95ZWVzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIqCgZzdGF0dXMYAyABKA4yEi5wYi5FbXBsb3llZVN0YXR1c1IGc3RhdHVzEh4KCmRlcGFydG1lbnQYBCABKAlSCmRlcGFydG1lbnQSFgoGc2VhcmNoGAUgASgJUgZzZWFyY2g=');
@$core.Deprecated('Use listEmployeesResponseDescriptor instead')
const ListEmployeesResponse$json = const {
  '1': 'ListEmployeesResponse',
  '2': const [
    const {'1': 'employees', '3': 1, '4': 3, '5': 11, '6': '.pb.Employee', '10': 'employees'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListEmployeesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEmployeesResponseDescriptor = $convert.base64Decode('ChVMaXN0RW1wbG95ZWVzUmVzcG9uc2USKgoJZW1wbG95ZWVzGAEgAygLMgwucGIuRW1wbG95ZWVSCWVtcGxveWVlcxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use createPayRunRequestDescriptor instead')
const CreatePayRunRequest$json = const {
  '1': 'CreatePayRunRequest',
  '2': const [
    const {'1': 'pay_period_start', '3': 1, '4': 1, '5': 9, '10': 'payPeriodStart'},
    const {'1': 'pay_period_end', '3': 2, '4': 1, '5': 9, '10': 'payPeriodEnd'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'employee_ids', '3': 4, '4': 3, '5': 9, '10': 'employeeIds'},
    const {'1': 'is_recurring', '3': 5, '4': 1, '5': 8, '10': 'isRecurring'},
    const {'1': 'recurrence_frequency', '3': 6, '4': 1, '5': 14, '6': '.pb.RecurrenceFrequency', '10': 'recurrenceFrequency'},
    const {'1': 'auto_approve', '3': 7, '4': 1, '5': 8, '10': 'autoApprove'},
  ],
};

/// Descriptor for `CreatePayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPayRunRequestDescriptor = $convert.base64Decode('ChNDcmVhdGVQYXlSdW5SZXF1ZXN0EigKEHBheV9wZXJpb2Rfc3RhcnQYASABKAlSDnBheVBlcmlvZFN0YXJ0EiQKDnBheV9wZXJpb2RfZW5kGAIgASgJUgxwYXlQZXJpb2RFbmQSEgoEbmFtZRgDIAEoCVIEbmFtZRIhCgxlbXBsb3llZV9pZHMYBCADKAlSC2VtcGxveWVlSWRzEiEKDGlzX3JlY3VycmluZxgFIAEoCFILaXNSZWN1cnJpbmcSSgoUcmVjdXJyZW5jZV9mcmVxdWVuY3kYBiABKA4yFy5wYi5SZWN1cnJlbmNlRnJlcXVlbmN5UhNyZWN1cnJlbmNlRnJlcXVlbmN5EiEKDGF1dG9fYXBwcm92ZRgHIAEoCFILYXV0b0FwcHJvdmU=');
@$core.Deprecated('Use createPayRunResponseDescriptor instead')
const CreatePayRunResponse$json = const {
  '1': 'CreatePayRunResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
  ],
};

/// Descriptor for `CreatePayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPayRunResponseDescriptor = $convert.base64Decode('ChRDcmVhdGVQYXlSdW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoHcGF5X3J1bhgDIAEoCzIKLnBiLlBheVJ1blIGcGF5UnVu');
@$core.Deprecated('Use calculatePayRunRequestDescriptor instead')
const CalculatePayRunRequest$json = const {
  '1': 'CalculatePayRunRequest',
  '2': const [
    const {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
  ],
};

/// Descriptor for `CalculatePayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculatePayRunRequestDescriptor = $convert.base64Decode('ChZDYWxjdWxhdGVQYXlSdW5SZXF1ZXN0EhwKCnBheV9ydW5faWQYASABKAlSCHBheVJ1bklk');
@$core.Deprecated('Use calculatePayRunResponseDescriptor instead')
const CalculatePayRunResponse$json = const {
  '1': 'CalculatePayRunResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
    const {'1': 'pay_slips', '3': 4, '4': 3, '5': 11, '6': '.pb.PaySlip', '10': 'paySlips'},
  ],
};

/// Descriptor for `CalculatePayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List calculatePayRunResponseDescriptor = $convert.base64Decode('ChdDYWxjdWxhdGVQYXlSdW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoHcGF5X3J1bhgDIAEoCzIKLnBiLlBheVJ1blIGcGF5UnVuEigKCXBheV9zbGlwcxgEIAMoCzILLnBiLlBheVNsaXBSCHBheVNsaXBz');
@$core.Deprecated('Use approvePayRunRequestDescriptor instead')
const ApprovePayRunRequest$json = const {
  '1': 'ApprovePayRunRequest',
  '2': const [
    const {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
  ],
};

/// Descriptor for `ApprovePayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approvePayRunRequestDescriptor = $convert.base64Decode('ChRBcHByb3ZlUGF5UnVuUmVxdWVzdBIcCgpwYXlfcnVuX2lkGAEgASgJUghwYXlSdW5JZA==');
@$core.Deprecated('Use approvePayRunResponseDescriptor instead')
const ApprovePayRunResponse$json = const {
  '1': 'ApprovePayRunResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
  ],
};

/// Descriptor for `ApprovePayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List approvePayRunResponseDescriptor = $convert.base64Decode('ChVBcHByb3ZlUGF5UnVuUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiMKB3BheV9ydW4YAyABKAsyCi5wYi5QYXlSdW5SBnBheVJ1bg==');
@$core.Deprecated('Use processPayRunRequestDescriptor instead')
const ProcessPayRunRequest$json = const {
  '1': 'ProcessPayRunRequest',
  '2': const [
    const {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
    const {'1': 'transaction_pin', '3': 2, '4': 1, '5': 9, '10': 'transactionPin'},
    const {'1': 'source_account_id', '3': 3, '4': 1, '5': 9, '10': 'sourceAccountId'},
  ],
};

/// Descriptor for `ProcessPayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayRunRequestDescriptor = $convert.base64Decode('ChRQcm9jZXNzUGF5UnVuUmVxdWVzdBIcCgpwYXlfcnVuX2lkGAEgASgJUghwYXlSdW5JZBInCg90cmFuc2FjdGlvbl9waW4YAiABKAlSDnRyYW5zYWN0aW9uUGluEioKEXNvdXJjZV9hY2NvdW50X2lkGAMgASgJUg9zb3VyY2VBY2NvdW50SWQ=');
@$core.Deprecated('Use processPayRunResponseDescriptor instead')
const ProcessPayRunResponse$json = const {
  '1': 'ProcessPayRunResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
    const {'1': 'successful_payments', '3': 4, '4': 1, '5': 5, '10': 'successfulPayments'},
    const {'1': 'failed_payments', '3': 5, '4': 1, '5': 5, '10': 'failedPayments'},
  ],
};

/// Descriptor for `ProcessPayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processPayRunResponseDescriptor = $convert.base64Decode('ChVQcm9jZXNzUGF5UnVuUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiMKB3BheV9ydW4YAyABKAsyCi5wYi5QYXlSdW5SBnBheVJ1bhIvChNzdWNjZXNzZnVsX3BheW1lbnRzGAQgASgFUhJzdWNjZXNzZnVsUGF5bWVudHMSJwoPZmFpbGVkX3BheW1lbnRzGAUgASgFUg5mYWlsZWRQYXltZW50cw==');
@$core.Deprecated('Use getPayRunRequestDescriptor instead')
const GetPayRunRequest$json = const {
  '1': 'GetPayRunRequest',
  '2': const [
    const {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
  ],
};

/// Descriptor for `GetPayRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayRunRequestDescriptor = $convert.base64Decode('ChBHZXRQYXlSdW5SZXF1ZXN0EhwKCnBheV9ydW5faWQYASABKAlSCHBheVJ1bklk');
@$core.Deprecated('Use getPayRunResponseDescriptor instead')
const GetPayRunResponse$json = const {
  '1': 'GetPayRunResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pay_run', '3': 3, '4': 1, '5': 11, '6': '.pb.PayRun', '10': 'payRun'},
  ],
};

/// Descriptor for `GetPayRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayRunResponseDescriptor = $convert.base64Decode('ChFHZXRQYXlSdW5SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIwoHcGF5X3J1bhgDIAEoCzIKLnBiLlBheVJ1blIGcGF5UnVu');
@$core.Deprecated('Use listPayRunsRequestDescriptor instead')
const ListPayRunsRequest$json = const {
  '1': 'ListPayRunsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.PayRunStatus', '10': 'status'},
  ],
};

/// Descriptor for `ListPayRunsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPayRunsRequestDescriptor = $convert.base64Decode('ChJMaXN0UGF5UnVuc1JlcXVlc3QSEgoEcGFnZRgBIAEoBVIEcGFnZRIUCgVsaW1pdBgCIAEoBVIFbGltaXQSKAoGc3RhdHVzGAMgASgOMhAucGIuUGF5UnVuU3RhdHVzUgZzdGF0dXM=');
@$core.Deprecated('Use listPayRunsResponseDescriptor instead')
const ListPayRunsResponse$json = const {
  '1': 'ListPayRunsResponse',
  '2': const [
    const {'1': 'pay_runs', '3': 1, '4': 3, '5': 11, '6': '.pb.PayRun', '10': 'payRuns'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPayRunsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPayRunsResponseDescriptor = $convert.base64Decode('ChNMaXN0UGF5UnVuc1Jlc3BvbnNlEiUKCHBheV9ydW5zGAEgAygLMgoucGIuUGF5UnVuUgdwYXlSdW5zEjkKCnBhZ2luYXRpb24YAiABKAsyGS5wYi5QYXlyb2xsUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
@$core.Deprecated('Use getPaySlipRequestDescriptor instead')
const GetPaySlipRequest$json = const {
  '1': 'GetPaySlipRequest',
  '2': const [
    const {'1': 'pay_slip_id', '3': 1, '4': 1, '5': 9, '10': 'paySlipId'},
  ],
};

/// Descriptor for `GetPaySlipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaySlipRequestDescriptor = $convert.base64Decode('ChFHZXRQYXlTbGlwUmVxdWVzdBIeCgtwYXlfc2xpcF9pZBgBIAEoCVIJcGF5U2xpcElk');
@$core.Deprecated('Use getPaySlipResponseDescriptor instead')
const GetPaySlipResponse$json = const {
  '1': 'GetPaySlipResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'pay_slip', '3': 3, '4': 1, '5': 11, '6': '.pb.PaySlip', '10': 'paySlip'},
  ],
};

/// Descriptor for `GetPaySlipResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaySlipResponseDescriptor = $convert.base64Decode('ChJHZXRQYXlTbGlwUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiYKCHBheV9zbGlwGAMgASgLMgsucGIuUGF5U2xpcFIHcGF5U2xpcA==');
@$core.Deprecated('Use listPaySlipsRequestDescriptor instead')
const ListPaySlipsRequest$json = const {
  '1': 'ListPaySlipsRequest',
  '2': const [
    const {'1': 'pay_run_id', '3': 1, '4': 1, '5': 9, '10': 'payRunId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListPaySlipsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaySlipsRequestDescriptor = $convert.base64Decode('ChNMaXN0UGF5U2xpcHNSZXF1ZXN0EhwKCnBheV9ydW5faWQYASABKAlSCHBheVJ1bklkEhIKBHBhZ2UYAiABKAVSBHBhZ2USFAoFbGltaXQYAyABKAVSBWxpbWl0');
@$core.Deprecated('Use listPaySlipsResponseDescriptor instead')
const ListPaySlipsResponse$json = const {
  '1': 'ListPaySlipsResponse',
  '2': const [
    const {'1': 'pay_slips', '3': 1, '4': 3, '5': 11, '6': '.pb.PaySlip', '10': 'paySlips'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPaySlipsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaySlipsResponseDescriptor = $convert.base64Decode('ChRMaXN0UGF5U2xpcHNSZXNwb25zZRIoCglwYXlfc2xpcHMYASADKAsyCy5wYi5QYXlTbGlwUghwYXlTbGlwcxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getPayrollSummaryRequestDescriptor instead')
const GetPayrollSummaryRequest$json = const {
  '1': 'GetPayrollSummaryRequest',
  '2': const [
    const {'1': 'period_start', '3': 1, '4': 1, '5': 9, '10': 'periodStart'},
    const {'1': 'period_end', '3': 2, '4': 1, '5': 9, '10': 'periodEnd'},
  ],
};

/// Descriptor for `GetPayrollSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayrollSummaryRequestDescriptor = $convert.base64Decode('ChhHZXRQYXlyb2xsU3VtbWFyeVJlcXVlc3QSIQoMcGVyaW9kX3N0YXJ0GAEgASgJUgtwZXJpb2RTdGFydBIdCgpwZXJpb2RfZW5kGAIgASgJUglwZXJpb2RFbmQ=');
@$core.Deprecated('Use getPayrollSummaryResponseDescriptor instead')
const GetPayrollSummaryResponse$json = const {
  '1': 'GetPayrollSummaryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'total_employees', '3': 3, '4': 1, '5': 5, '10': 'totalEmployees'},
    const {'1': 'total_pay_runs', '3': 4, '4': 1, '5': 5, '10': 'totalPayRuns'},
    const {'1': 'total_gross_paid', '3': 5, '4': 1, '5': 3, '10': 'totalGrossPaid'},
    const {'1': 'total_deductions', '3': 6, '4': 1, '5': 3, '10': 'totalDeductions'},
    const {'1': 'total_net_paid', '3': 7, '4': 1, '5': 3, '10': 'totalNetPaid'},
    const {'1': 'total_employer_contributions', '3': 8, '4': 1, '5': 3, '10': 'totalEmployerContributions'},
    const {'1': 'deduction_breakdown', '3': 9, '4': 3, '5': 11, '6': '.pb.DeductionSummary', '10': 'deductionBreakdown'},
  ],
};

/// Descriptor for `GetPayrollSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPayrollSummaryResponseDescriptor = $convert.base64Decode('ChlHZXRQYXlyb2xsU3VtbWFyeVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRInCg90b3RhbF9lbXBsb3llZXMYAyABKAVSDnRvdGFsRW1wbG95ZWVzEiQKDnRvdGFsX3BheV9ydW5zGAQgASgFUgx0b3RhbFBheVJ1bnMSKAoQdG90YWxfZ3Jvc3NfcGFpZBgFIAEoA1IOdG90YWxHcm9zc1BhaWQSKQoQdG90YWxfZGVkdWN0aW9ucxgGIAEoA1IPdG90YWxEZWR1Y3Rpb25zEiQKDnRvdGFsX25ldF9wYWlkGAcgASgDUgx0b3RhbE5ldFBhaWQSQAocdG90YWxfZW1wbG95ZXJfY29udHJpYnV0aW9ucxgIIAEoA1IadG90YWxFbXBsb3llckNvbnRyaWJ1dGlvbnMSRQoTZGVkdWN0aW9uX2JyZWFrZG93bhgJIAMoCzIULnBiLkRlZHVjdGlvblN1bW1hcnlSEmRlZHVjdGlvbkJyZWFrZG93bg==');
@$core.Deprecated('Use getTaxReportRequestDescriptor instead')
const GetTaxReportRequest$json = const {
  '1': 'GetTaxReportRequest',
  '2': const [
    const {'1': 'period_start', '3': 1, '4': 1, '5': 9, '10': 'periodStart'},
    const {'1': 'period_end', '3': 2, '4': 1, '5': 9, '10': 'periodEnd'},
  ],
};

/// Descriptor for `GetTaxReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxReportRequestDescriptor = $convert.base64Decode('ChNHZXRUYXhSZXBvcnRSZXF1ZXN0EiEKDHBlcmlvZF9zdGFydBgBIAEoCVILcGVyaW9kU3RhcnQSHQoKcGVyaW9kX2VuZBgCIAEoCVIJcGVyaW9kRW5k');
@$core.Deprecated('Use getTaxReportResponseDescriptor instead')
const GetTaxReportResponse$json = const {
  '1': 'GetTaxReportResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'total_paye', '3': 3, '4': 1, '5': 3, '10': 'totalPaye'},
    const {'1': 'total_nhf', '3': 4, '4': 1, '5': 3, '10': 'totalNhf'},
    const {'1': 'total_pension_employee', '3': 5, '4': 1, '5': 3, '10': 'totalPensionEmployee'},
    const {'1': 'total_pension_employer', '3': 6, '4': 1, '5': 3, '10': 'totalPensionEmployer'},
    const {'1': 'total_nsitf', '3': 7, '4': 1, '5': 3, '10': 'totalNsitf'},
    const {'1': 'total_itf', '3': 8, '4': 1, '5': 3, '10': 'totalItf'},
    const {'1': 'employee_summaries', '3': 9, '4': 3, '5': 11, '6': '.pb.EmployeeTaxSummary', '10': 'employeeSummaries'},
  ],
};

/// Descriptor for `GetTaxReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxReportResponseDescriptor = $convert.base64Decode('ChRHZXRUYXhSZXBvcnRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHQoKdG90YWxfcGF5ZRgDIAEoA1IJdG90YWxQYXllEhsKCXRvdGFsX25oZhgEIAEoA1IIdG90YWxOaGYSNAoWdG90YWxfcGVuc2lvbl9lbXBsb3llZRgFIAEoA1IUdG90YWxQZW5zaW9uRW1wbG95ZWUSNAoWdG90YWxfcGVuc2lvbl9lbXBsb3llchgGIAEoA1IUdG90YWxQZW5zaW9uRW1wbG95ZXISHwoLdG90YWxfbnNpdGYYByABKANSCnRvdGFsTnNpdGYSGwoJdG90YWxfaXRmGAggASgDUgh0b3RhbEl0ZhJFChJlbXBsb3llZV9zdW1tYXJpZXMYCSADKAsyFi5wYi5FbXBsb3llZVRheFN1bW1hcnlSEWVtcGxveWVlU3VtbWFyaWVz');
@$core.Deprecated('Use employeeTaxSummaryDescriptor instead')
const EmployeeTaxSummary$json = const {
  '1': 'EmployeeTaxSummary',
  '2': const [
    const {'1': 'employee_id', '3': 1, '4': 1, '5': 9, '10': 'employeeId'},
    const {'1': 'employee_name', '3': 2, '4': 1, '5': 9, '10': 'employeeName'},
    const {'1': 'gross_pay', '3': 3, '4': 1, '5': 3, '10': 'grossPay'},
    const {'1': 'paye', '3': 4, '4': 1, '5': 3, '10': 'paye'},
    const {'1': 'nhf', '3': 5, '4': 1, '5': 3, '10': 'nhf'},
    const {'1': 'pension', '3': 6, '4': 1, '5': 3, '10': 'pension'},
    const {'1': 'net_pay', '3': 7, '4': 1, '5': 3, '10': 'netPay'},
  ],
};

/// Descriptor for `EmployeeTaxSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List employeeTaxSummaryDescriptor = $convert.base64Decode('ChJFbXBsb3llZVRheFN1bW1hcnkSHwoLZW1wbG95ZWVfaWQYASABKAlSCmVtcGxveWVlSWQSIwoNZW1wbG95ZWVfbmFtZRgCIAEoCVIMZW1wbG95ZWVOYW1lEhsKCWdyb3NzX3BheRgDIAEoA1IIZ3Jvc3NQYXkSEgoEcGF5ZRgEIAEoA1IEcGF5ZRIQCgNuaGYYBSABKANSA25oZhIYCgdwZW5zaW9uGAYgASgDUgdwZW5zaW9uEhcKB25ldF9wYXkYByABKANSBm5ldFBheQ==');
@$core.Deprecated('Use createInventoryItemRequestDescriptor instead')
const CreateInventoryItemRequest$json = const {
  '1': 'CreateInventoryItemRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'unit_price', '3': 5, '4': 1, '5': 3, '10': 'unitPrice'},
    const {'1': 'unit', '3': 6, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'sku', '3': 7, '4': 1, '5': 9, '10': 'sku'},
    const {'1': 'location', '3': 8, '4': 1, '5': 9, '10': 'location'},
    const {'1': 'minimum_stock_level', '3': 9, '4': 1, '5': 5, '10': 'minimumStockLevel'},
    const {'1': 'notes', '3': 10, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `CreateInventoryItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInventoryItemRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVJbnZlbnRvcnlJdGVtUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGAIgASgJUgtkZXNjcmlwdGlvbhIaCghjYXRlZ29yeRgDIAEoCVIIY2F0ZWdvcnkSGgoIcXVhbnRpdHkYBCABKAVSCHF1YW50aXR5Eh0KCnVuaXRfcHJpY2UYBSABKANSCXVuaXRQcmljZRISCgR1bml0GAYgASgJUgR1bml0EhAKA3NrdRgHIAEoCVIDc2t1EhoKCGxvY2F0aW9uGAggASgJUghsb2NhdGlvbhIuChNtaW5pbXVtX3N0b2NrX2xldmVsGAkgASgFUhFtaW5pbXVtU3RvY2tMZXZlbBIUCgVub3RlcxgKIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use createInventoryItemResponseDescriptor instead')
const CreateInventoryItemResponse$json = const {
  '1': 'CreateInventoryItemResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'item', '3': 3, '4': 1, '5': 11, '6': '.pb.InventoryItem', '10': 'item'},
  ],
};

/// Descriptor for `CreateInventoryItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInventoryItemResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVJbnZlbnRvcnlJdGVtUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiUKBGl0ZW0YAyABKAsyES5wYi5JbnZlbnRvcnlJdGVtUgRpdGVt');
@$core.Deprecated('Use updateInventoryItemRequestDescriptor instead')
const UpdateInventoryItemRequest$json = const {
  '1': 'UpdateInventoryItemRequest',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'unit_price', '3': 5, '4': 1, '5': 3, '10': 'unitPrice'},
    const {'1': 'unit', '3': 6, '4': 1, '5': 9, '10': 'unit'},
    const {'1': 'sku', '3': 7, '4': 1, '5': 9, '10': 'sku'},
    const {'1': 'location', '3': 8, '4': 1, '5': 9, '10': 'location'},
    const {'1': 'minimum_stock_level', '3': 9, '4': 1, '5': 5, '10': 'minimumStockLevel'},
    const {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.pb.InventoryItemStatus', '10': 'status'},
    const {'1': 'notes', '3': 11, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateInventoryItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInventoryItemRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVJbnZlbnRvcnlJdGVtUmVxdWVzdBIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIgCgtkZXNjcmlwdGlvbhgDIAEoCVILZGVzY3JpcHRpb24SGgoIY2F0ZWdvcnkYBCABKAlSCGNhdGVnb3J5Eh0KCnVuaXRfcHJpY2UYBSABKANSCXVuaXRQcmljZRISCgR1bml0GAYgASgJUgR1bml0EhAKA3NrdRgHIAEoCVIDc2t1EhoKCGxvY2F0aW9uGAggASgJUghsb2NhdGlvbhIuChNtaW5pbXVtX3N0b2NrX2xldmVsGAkgASgFUhFtaW5pbXVtU3RvY2tMZXZlbBIvCgZzdGF0dXMYCiABKA4yFy5wYi5JbnZlbnRvcnlJdGVtU3RhdHVzUgZzdGF0dXMSFAoFbm90ZXMYCyABKAlSBW5vdGVz');
@$core.Deprecated('Use updateInventoryItemResponseDescriptor instead')
const UpdateInventoryItemResponse$json = const {
  '1': 'UpdateInventoryItemResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'item', '3': 3, '4': 1, '5': 11, '6': '.pb.InventoryItem', '10': 'item'},
  ],
};

/// Descriptor for `UpdateInventoryItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInventoryItemResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVJbnZlbnRvcnlJdGVtUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiUKBGl0ZW0YAyABKAsyES5wYi5JbnZlbnRvcnlJdGVtUgRpdGVt');
@$core.Deprecated('Use deleteInventoryItemRequestDescriptor instead')
const DeleteInventoryItemRequest$json = const {
  '1': 'DeleteInventoryItemRequest',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
  ],
};

/// Descriptor for `DeleteInventoryItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInventoryItemRequestDescriptor = $convert.base64Decode('ChpEZWxldGVJbnZlbnRvcnlJdGVtUmVxdWVzdBIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQ=');
@$core.Deprecated('Use deleteInventoryItemResponseDescriptor instead')
const DeleteInventoryItemResponse$json = const {
  '1': 'DeleteInventoryItemResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteInventoryItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteInventoryItemResponseDescriptor = $convert.base64Decode('ChtEZWxldGVJbnZlbnRvcnlJdGVtUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use getInventoryItemRequestDescriptor instead')
const GetInventoryItemRequest$json = const {
  '1': 'GetInventoryItemRequest',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
  ],
};

/// Descriptor for `GetInventoryItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventoryItemRequestDescriptor = $convert.base64Decode('ChdHZXRJbnZlbnRvcnlJdGVtUmVxdWVzdBIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQ=');
@$core.Deprecated('Use getInventoryItemResponseDescriptor instead')
const GetInventoryItemResponse$json = const {
  '1': 'GetInventoryItemResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'item', '3': 3, '4': 1, '5': 11, '6': '.pb.InventoryItem', '10': 'item'},
  ],
};

/// Descriptor for `GetInventoryItemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventoryItemResponseDescriptor = $convert.base64Decode('ChhHZXRJbnZlbnRvcnlJdGVtUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiUKBGl0ZW0YAyABKAsyES5wYi5JbnZlbnRvcnlJdGVtUgRpdGVt');
@$core.Deprecated('Use listInventoryItemsRequestDescriptor instead')
const ListInventoryItemsRequest$json = const {
  '1': 'ListInventoryItemsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'search', '3': 4, '4': 1, '5': 9, '10': 'search'},
    const {'1': 'low_stock_only', '3': 5, '4': 1, '5': 8, '10': 'lowStockOnly'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.InventoryItemStatus', '10': 'status'},
  ],
};

/// Descriptor for `ListInventoryItemsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInventoryItemsRequestDescriptor = $convert.base64Decode('ChlMaXN0SW52ZW50b3J5SXRlbXNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0EhoKCGNhdGVnb3J5GAMgASgJUghjYXRlZ29yeRIWCgZzZWFyY2gYBCABKAlSBnNlYXJjaBIkCg5sb3dfc3RvY2tfb25seRgFIAEoCFIMbG93U3RvY2tPbmx5Ei8KBnN0YXR1cxgGIAEoDjIXLnBiLkludmVudG9yeUl0ZW1TdGF0dXNSBnN0YXR1cw==');
@$core.Deprecated('Use listInventoryItemsResponseDescriptor instead')
const ListInventoryItemsResponse$json = const {
  '1': 'ListInventoryItemsResponse',
  '2': const [
    const {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.pb.InventoryItem', '10': 'items'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListInventoryItemsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInventoryItemsResponseDescriptor = $convert.base64Decode('ChpMaXN0SW52ZW50b3J5SXRlbXNSZXNwb25zZRInCgVpdGVtcxgBIAMoCzIRLnBiLkludmVudG9yeUl0ZW1SBWl0ZW1zEjkKCnBhZ2luYXRpb24YAiABKAsyGS5wYi5QYXlyb2xsUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
@$core.Deprecated('Use adjustInventoryQuantityRequestDescriptor instead')
const AdjustInventoryQuantityRequest$json = const {
  '1': 'AdjustInventoryQuantityRequest',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'adjustment_type', '3': 2, '4': 1, '5': 14, '6': '.pb.AdjustmentType', '10': 'adjustmentType'},
    const {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'reason', '3': 4, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `AdjustInventoryQuantityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adjustInventoryQuantityRequestDescriptor = $convert.base64Decode('Ch5BZGp1c3RJbnZlbnRvcnlRdWFudGl0eVJlcXVlc3QSFwoHaXRlbV9pZBgBIAEoCVIGaXRlbUlkEjsKD2FkanVzdG1lbnRfdHlwZRgCIAEoDjISLnBiLkFkanVzdG1lbnRUeXBlUg5hZGp1c3RtZW50VHlwZRIaCghxdWFudGl0eRgDIAEoBVIIcXVhbnRpdHkSFgoGcmVhc29uGAQgASgJUgZyZWFzb24=');
@$core.Deprecated('Use adjustInventoryQuantityResponseDescriptor instead')
const AdjustInventoryQuantityResponse$json = const {
  '1': 'AdjustInventoryQuantityResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'item', '3': 3, '4': 1, '5': 11, '6': '.pb.InventoryItem', '10': 'item'},
    const {'1': 'adjustment', '3': 4, '4': 1, '5': 11, '6': '.pb.InventoryAdjustment', '10': 'adjustment'},
  ],
};

/// Descriptor for `AdjustInventoryQuantityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adjustInventoryQuantityResponseDescriptor = $convert.base64Decode('Ch9BZGp1c3RJbnZlbnRvcnlRdWFudGl0eVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIlCgRpdGVtGAMgASgLMhEucGIuSW52ZW50b3J5SXRlbVIEaXRlbRI3CgphZGp1c3RtZW50GAQgASgLMhcucGIuSW52ZW50b3J5QWRqdXN0bWVudFIKYWRqdXN0bWVudA==');
@$core.Deprecated('Use getInventoryHistoryRequestDescriptor instead')
const GetInventoryHistoryRequest$json = const {
  '1': 'GetInventoryHistoryRequest',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetInventoryHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventoryHistoryRequestDescriptor = $convert.base64Decode('ChpHZXRJbnZlbnRvcnlIaXN0b3J5UmVxdWVzdBIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use getInventoryHistoryResponseDescriptor instead')
const GetInventoryHistoryResponse$json = const {
  '1': 'GetInventoryHistoryResponse',
  '2': const [
    const {'1': 'adjustments', '3': 1, '4': 3, '5': 11, '6': '.pb.InventoryAdjustment', '10': 'adjustments'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `GetInventoryHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventoryHistoryResponseDescriptor = $convert.base64Decode('ChtHZXRJbnZlbnRvcnlIaXN0b3J5UmVzcG9uc2USOQoLYWRqdXN0bWVudHMYASADKAsyFy5wYi5JbnZlbnRvcnlBZGp1c3RtZW50UgthZGp1c3RtZW50cxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getInventorySummaryRequestDescriptor instead')
const GetInventorySummaryRequest$json = const {
  '1': 'GetInventorySummaryRequest',
};

/// Descriptor for `GetInventorySummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventorySummaryRequestDescriptor = $convert.base64Decode('ChpHZXRJbnZlbnRvcnlTdW1tYXJ5UmVxdWVzdA==');
@$core.Deprecated('Use getInventorySummaryResponseDescriptor instead')
const GetInventorySummaryResponse$json = const {
  '1': 'GetInventorySummaryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'total_items', '3': 3, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'low_stock_items', '3': 4, '4': 1, '5': 5, '10': 'lowStockItems'},
    const {'1': 'total_inventory_value', '3': 5, '4': 1, '5': 3, '10': 'totalInventoryValue'},
    const {'1': 'categories', '3': 6, '4': 3, '5': 11, '6': '.pb.InventoryCategorySummary', '10': 'categories'},
  ],
};

/// Descriptor for `GetInventorySummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventorySummaryResponseDescriptor = $convert.base64Decode('ChtHZXRJbnZlbnRvcnlTdW1tYXJ5UmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEh8KC3RvdGFsX2l0ZW1zGAMgASgFUgp0b3RhbEl0ZW1zEiYKD2xvd19zdG9ja19pdGVtcxgEIAEoBVINbG93U3RvY2tJdGVtcxIyChV0b3RhbF9pbnZlbnRvcnlfdmFsdWUYBSABKANSE3RvdGFsSW52ZW50b3J5VmFsdWUSPAoKY2F0ZWdvcmllcxgGIAMoCzIcLnBiLkludmVudG9yeUNhdGVnb3J5U3VtbWFyeVIKY2F0ZWdvcmllcw==');
@$core.Deprecated('Use customerDescriptor instead')
const Customer$json = const {
  '1': 'Customer',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'business_name', '3': 4, '4': 1, '5': 9, '10': 'businessName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 7, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'city', '3': 8, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'state', '3': 9, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'country', '3': 10, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'tin', '3': 11, '4': 1, '5': 9, '10': 'tin'},
    const {'1': 'bank_account_number', '3': 12, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    const {'1': 'bank_code', '3': 13, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 14, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'segment', '3': 15, '4': 1, '5': 14, '6': '.pb.CustomerSegment', '10': 'segment'},
    const {'1': 'status', '3': 16, '4': 1, '5': 14, '6': '.pb.CustomerStatus', '10': 'status'},
    const {'1': 'tags', '3': 17, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'notes', '3': 18, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 19, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 20, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `Customer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customerDescriptor = $convert.base64Decode('CghDdXN0b21lchIOCgJpZBgBIAEoCVICaWQSHwoLYnVzaW5lc3NfaWQYAiABKAlSCmJ1c2luZXNzSWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIjCg1idXNpbmVzc19uYW1lGAQgASgJUgxidXNpbmVzc05hbWUSFAoFZW1haWwYBSABKAlSBWVtYWlsEhQKBXBob25lGAYgASgJUgVwaG9uZRIYCgdhZGRyZXNzGAcgASgJUgdhZGRyZXNzEhIKBGNpdHkYCCABKAlSBGNpdHkSFAoFc3RhdGUYCSABKAlSBXN0YXRlEhgKB2NvdW50cnkYCiABKAlSB2NvdW50cnkSEAoDdGluGAsgASgJUgN0aW4SLgoTYmFua19hY2NvdW50X251bWJlchgMIAEoCVIRYmFua0FjY291bnROdW1iZXISGwoJYmFua19jb2RlGA0gASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYDiABKAlSCGJhbmtOYW1lEi0KB3NlZ21lbnQYDyABKA4yEy5wYi5DdXN0b21lclNlZ21lbnRSB3NlZ21lbnQSKgoGc3RhdHVzGBAgASgOMhIucGIuQ3VzdG9tZXJTdGF0dXNSBnN0YXR1cxISCgR0YWdzGBEgAygJUgR0YWdzEhQKBW5vdGVzGBIgASgJUgVub3RlcxI5CgpjcmVhdGVkX2F0GBMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYFCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use customerFinancialProfileDescriptor instead')
const CustomerFinancialProfile$json = const {
  '1': 'CustomerFinancialProfile',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'total_invoiced', '3': 2, '4': 1, '5': 3, '10': 'totalInvoiced'},
    const {'1': 'total_paid', '3': 3, '4': 1, '5': 3, '10': 'totalPaid'},
    const {'1': 'outstanding', '3': 4, '4': 1, '5': 3, '10': 'outstanding'},
    const {'1': 'avg_payment_days', '3': 5, '4': 1, '5': 5, '10': 'avgPaymentDays'},
    const {'1': 'total_invoices', '3': 6, '4': 1, '5': 5, '10': 'totalInvoices'},
    const {'1': 'paid_invoices', '3': 7, '4': 1, '5': 5, '10': 'paidInvoices'},
    const {'1': 'overdue_invoices', '3': 8, '4': 1, '5': 5, '10': 'overdueInvoices'},
    const {'1': 'last_payment_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastPaymentDate'},
  ],
};

/// Descriptor for `CustomerFinancialProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customerFinancialProfileDescriptor = $convert.base64Decode('ChhDdXN0b21lckZpbmFuY2lhbFByb2ZpbGUSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQSJQoOdG90YWxfaW52b2ljZWQYAiABKANSDXRvdGFsSW52b2ljZWQSHQoKdG90YWxfcGFpZBgDIAEoA1IJdG90YWxQYWlkEiAKC291dHN0YW5kaW5nGAQgASgDUgtvdXRzdGFuZGluZxIoChBhdmdfcGF5bWVudF9kYXlzGAUgASgFUg5hdmdQYXltZW50RGF5cxIlCg50b3RhbF9pbnZvaWNlcxgGIAEoBVINdG90YWxJbnZvaWNlcxIjCg1wYWlkX2ludm9pY2VzGAcgASgFUgxwYWlkSW52b2ljZXMSKQoQb3ZlcmR1ZV9pbnZvaWNlcxgIIAEoBVIPb3ZlcmR1ZUludm9pY2VzEkYKEWxhc3RfcGF5bWVudF9kYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPbGFzdFBheW1lbnREYXRl');
@$core.Deprecated('Use customerNoteDescriptor instead')
const CustomerNote$json = const {
  '1': 'CustomerNote',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'customer_id', '3': 2, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'business_id', '3': 3, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'created_by', '3': 5, '4': 1, '5': 9, '10': 'createdBy'},
    const {'1': 'created_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `CustomerNote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customerNoteDescriptor = $convert.base64Decode('CgxDdXN0b21lck5vdGUSDgoCaWQYASABKAlSAmlkEh8KC2N1c3RvbWVyX2lkGAIgASgJUgpjdXN0b21lcklkEh8KC2J1c2luZXNzX2lkGAMgASgJUgpidXNpbmVzc0lkEhgKB2NvbnRlbnQYBCABKAlSB2NvbnRlbnQSHQoKY3JlYXRlZF9ieRgFIAEoCVIJY3JlYXRlZEJ5EjkKCmNyZWF0ZWRfYXQYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use customerStatementEntryDescriptor instead')
const CustomerStatementEntry$json = const {
  '1': 'CustomerStatementEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'reference', '3': 3, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'description', '3': 4, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'balance', '3': 6, '4': 1, '5': 3, '10': 'balance'},
    const {'1': 'date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'date'},
  ],
};

/// Descriptor for `CustomerStatementEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customerStatementEntryDescriptor = $convert.base64Decode('ChZDdXN0b21lclN0YXRlbWVudEVudHJ5Eg4KAmlkGAEgASgJUgJpZBISCgR0eXBlGAIgASgJUgR0eXBlEhwKCXJlZmVyZW5jZRgDIAEoCVIJcmVmZXJlbmNlEiAKC2Rlc2NyaXB0aW9uGAQgASgJUgtkZXNjcmlwdGlvbhIWCgZhbW91bnQYBSABKANSBmFtb3VudBIYCgdiYWxhbmNlGAYgASgDUgdiYWxhbmNlEi4KBGRhdGUYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgRkYXRl');
@$core.Deprecated('Use customerSummaryDescriptor instead')
const CustomerSummary$json = const {
  '1': 'CustomerSummary',
  '2': const [
    const {'1': 'total_customers', '3': 1, '4': 1, '5': 5, '10': 'totalCustomers'},
    const {'1': 'active_customers', '3': 2, '4': 1, '5': 5, '10': 'activeCustomers'},
    const {'1': 'vip_customers', '3': 3, '4': 1, '5': 5, '10': 'vipCustomers'},
    const {'1': 'overdue_customers', '3': 4, '4': 1, '5': 5, '10': 'overdueCustomers'},
    const {'1': 'total_outstanding', '3': 5, '4': 1, '5': 3, '10': 'totalOutstanding'},
    const {'1': 'total_revenue', '3': 6, '4': 1, '5': 3, '10': 'totalRevenue'},
  ],
};

/// Descriptor for `CustomerSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customerSummaryDescriptor = $convert.base64Decode('Cg9DdXN0b21lclN1bW1hcnkSJwoPdG90YWxfY3VzdG9tZXJzGAEgASgFUg50b3RhbEN1c3RvbWVycxIpChBhY3RpdmVfY3VzdG9tZXJzGAIgASgFUg9hY3RpdmVDdXN0b21lcnMSIwoNdmlwX2N1c3RvbWVycxgDIAEoBVIMdmlwQ3VzdG9tZXJzEisKEW92ZXJkdWVfY3VzdG9tZXJzGAQgASgFUhBvdmVyZHVlQ3VzdG9tZXJzEisKEXRvdGFsX291dHN0YW5kaW5nGAUgASgDUhB0b3RhbE91dHN0YW5kaW5nEiMKDXRvdGFsX3JldmVudWUYBiABKANSDHRvdGFsUmV2ZW51ZQ==');
@$core.Deprecated('Use createCustomerRequestDescriptor instead')
const CreateCustomerRequest$json = const {
  '1': 'CreateCustomerRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'business_name', '3': 2, '4': 1, '5': 9, '10': 'businessName'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 5, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'city', '3': 6, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'state', '3': 7, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'country', '3': 8, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'tin', '3': 9, '4': 1, '5': 9, '10': 'tin'},
    const {'1': 'bank_account_number', '3': 10, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    const {'1': 'bank_code', '3': 11, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 12, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'segment', '3': 13, '4': 1, '5': 14, '6': '.pb.CustomerSegment', '10': 'segment'},
    const {'1': 'tags', '3': 14, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'notes', '3': 15, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `CreateCustomerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCustomerRequestDescriptor = $convert.base64Decode('ChVDcmVhdGVDdXN0b21lclJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIjCg1idXNpbmVzc19uYW1lGAIgASgJUgxidXNpbmVzc05hbWUSFAoFZW1haWwYAyABKAlSBWVtYWlsEhQKBXBob25lGAQgASgJUgVwaG9uZRIYCgdhZGRyZXNzGAUgASgJUgdhZGRyZXNzEhIKBGNpdHkYBiABKAlSBGNpdHkSFAoFc3RhdGUYByABKAlSBXN0YXRlEhgKB2NvdW50cnkYCCABKAlSB2NvdW50cnkSEAoDdGluGAkgASgJUgN0aW4SLgoTYmFua19hY2NvdW50X251bWJlchgKIAEoCVIRYmFua0FjY291bnROdW1iZXISGwoJYmFua19jb2RlGAsgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYDCABKAlSCGJhbmtOYW1lEi0KB3NlZ21lbnQYDSABKA4yEy5wYi5DdXN0b21lclNlZ21lbnRSB3NlZ21lbnQSEgoEdGFncxgOIAMoCVIEdGFncxIUCgVub3RlcxgPIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use createCustomerResponseDescriptor instead')
const CreateCustomerResponse$json = const {
  '1': 'CreateCustomerResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'customer', '3': 3, '4': 1, '5': 11, '6': '.pb.Customer', '10': 'customer'},
  ],
};

/// Descriptor for `CreateCustomerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createCustomerResponseDescriptor = $convert.base64Decode('ChZDcmVhdGVDdXN0b21lclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghjdXN0b21lchgDIAEoCzIMLnBiLkN1c3RvbWVyUghjdXN0b21lcg==');
@$core.Deprecated('Use updateCustomerRequestDescriptor instead')
const UpdateCustomerRequest$json = const {
  '1': 'UpdateCustomerRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'business_name', '3': 3, '4': 1, '5': 9, '10': 'businessName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 6, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'city', '3': 7, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'state', '3': 8, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'country', '3': 9, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'tin', '3': 10, '4': 1, '5': 9, '10': 'tin'},
    const {'1': 'bank_account_number', '3': 11, '4': 1, '5': 9, '10': 'bankAccountNumber'},
    const {'1': 'bank_code', '3': 12, '4': 1, '5': 9, '10': 'bankCode'},
    const {'1': 'bank_name', '3': 13, '4': 1, '5': 9, '10': 'bankName'},
    const {'1': 'segment', '3': 14, '4': 1, '5': 14, '6': '.pb.CustomerSegment', '10': 'segment'},
    const {'1': 'status', '3': 15, '4': 1, '5': 14, '6': '.pb.CustomerStatus', '10': 'status'},
    const {'1': 'tags', '3': 16, '4': 3, '5': 9, '10': 'tags'},
    const {'1': 'notes', '3': 17, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateCustomerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCustomerRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVDdXN0b21lclJlcXVlc3QSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIjCg1idXNpbmVzc19uYW1lGAMgASgJUgxidXNpbmVzc05hbWUSFAoFZW1haWwYBCABKAlSBWVtYWlsEhQKBXBob25lGAUgASgJUgVwaG9uZRIYCgdhZGRyZXNzGAYgASgJUgdhZGRyZXNzEhIKBGNpdHkYByABKAlSBGNpdHkSFAoFc3RhdGUYCCABKAlSBXN0YXRlEhgKB2NvdW50cnkYCSABKAlSB2NvdW50cnkSEAoDdGluGAogASgJUgN0aW4SLgoTYmFua19hY2NvdW50X251bWJlchgLIAEoCVIRYmFua0FjY291bnROdW1iZXISGwoJYmFua19jb2RlGAwgASgJUghiYW5rQ29kZRIbCgliYW5rX25hbWUYDSABKAlSCGJhbmtOYW1lEi0KB3NlZ21lbnQYDiABKA4yEy5wYi5DdXN0b21lclNlZ21lbnRSB3NlZ21lbnQSKgoGc3RhdHVzGA8gASgOMhIucGIuQ3VzdG9tZXJTdGF0dXNSBnN0YXR1cxISCgR0YWdzGBAgAygJUgR0YWdzEhQKBW5vdGVzGBEgASgJUgVub3Rlcw==');
@$core.Deprecated('Use updateCustomerResponseDescriptor instead')
const UpdateCustomerResponse$json = const {
  '1': 'UpdateCustomerResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'customer', '3': 3, '4': 1, '5': 11, '6': '.pb.Customer', '10': 'customer'},
  ],
};

/// Descriptor for `UpdateCustomerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCustomerResponseDescriptor = $convert.base64Decode('ChZVcGRhdGVDdXN0b21lclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghjdXN0b21lchgDIAEoCzIMLnBiLkN1c3RvbWVyUghjdXN0b21lcg==');
@$core.Deprecated('Use deleteCustomerRequestDescriptor instead')
const DeleteCustomerRequest$json = const {
  '1': 'DeleteCustomerRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
  ],
};

/// Descriptor for `DeleteCustomerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCustomerRequestDescriptor = $convert.base64Decode('ChVEZWxldGVDdXN0b21lclJlcXVlc3QSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQ=');
@$core.Deprecated('Use deleteCustomerResponseDescriptor instead')
const DeleteCustomerResponse$json = const {
  '1': 'DeleteCustomerResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteCustomerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteCustomerResponseDescriptor = $convert.base64Decode('ChZEZWxldGVDdXN0b21lclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getCustomerRequestDescriptor instead')
const GetCustomerRequest$json = const {
  '1': 'GetCustomerRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
  ],
};

/// Descriptor for `GetCustomerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerRequestDescriptor = $convert.base64Decode('ChJHZXRDdXN0b21lclJlcXVlc3QSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQ=');
@$core.Deprecated('Use getCustomerResponseDescriptor instead')
const GetCustomerResponse$json = const {
  '1': 'GetCustomerResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'customer', '3': 3, '4': 1, '5': 11, '6': '.pb.Customer', '10': 'customer'},
  ],
};

/// Descriptor for `GetCustomerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerResponseDescriptor = $convert.base64Decode('ChNHZXRDdXN0b21lclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghjdXN0b21lchgDIAEoCzIMLnBiLkN1c3RvbWVyUghjdXN0b21lcg==');
@$core.Deprecated('Use listCustomersRequestDescriptor instead')
const ListCustomersRequest$json = const {
  '1': 'ListCustomersRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'search', '3': 3, '4': 1, '5': 9, '10': 'search'},
    const {'1': 'segment', '3': 4, '4': 1, '5': 14, '6': '.pb.CustomerSegment', '10': 'segment'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.CustomerStatus', '10': 'status'},
    const {'1': 'tag', '3': 6, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `ListCustomersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCustomersRequestDescriptor = $convert.base64Decode('ChRMaXN0Q3VzdG9tZXJzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZzZWFyY2gYAyABKAlSBnNlYXJjaBItCgdzZWdtZW50GAQgASgOMhMucGIuQ3VzdG9tZXJTZWdtZW50UgdzZWdtZW50EioKBnN0YXR1cxgFIAEoDjISLnBiLkN1c3RvbWVyU3RhdHVzUgZzdGF0dXMSEAoDdGFnGAYgASgJUgN0YWc=');
@$core.Deprecated('Use listCustomersResponseDescriptor instead')
const ListCustomersResponse$json = const {
  '1': 'ListCustomersResponse',
  '2': const [
    const {'1': 'customers', '3': 1, '4': 3, '5': 11, '6': '.pb.Customer', '10': 'customers'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListCustomersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCustomersResponseDescriptor = $convert.base64Decode('ChVMaXN0Q3VzdG9tZXJzUmVzcG9uc2USKgoJY3VzdG9tZXJzGAEgAygLMgwucGIuQ3VzdG9tZXJSCWN1c3RvbWVycxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getCustomerFinancialProfileRequestDescriptor instead')
const GetCustomerFinancialProfileRequest$json = const {
  '1': 'GetCustomerFinancialProfileRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
  ],
};

/// Descriptor for `GetCustomerFinancialProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerFinancialProfileRequestDescriptor = $convert.base64Decode('CiJHZXRDdXN0b21lckZpbmFuY2lhbFByb2ZpbGVSZXF1ZXN0Eh8KC2N1c3RvbWVyX2lkGAEgASgJUgpjdXN0b21lcklk');
@$core.Deprecated('Use getCustomerFinancialProfileResponseDescriptor instead')
const GetCustomerFinancialProfileResponse$json = const {
  '1': 'GetCustomerFinancialProfileResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'profile', '3': 3, '4': 1, '5': 11, '6': '.pb.CustomerFinancialProfile', '10': 'profile'},
  ],
};

/// Descriptor for `GetCustomerFinancialProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerFinancialProfileResponseDescriptor = $convert.base64Decode('CiNHZXRDdXN0b21lckZpbmFuY2lhbFByb2ZpbGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNgoHcHJvZmlsZRgDIAEoCzIcLnBiLkN1c3RvbWVyRmluYW5jaWFsUHJvZmlsZVIHcHJvZmlsZQ==');
@$core.Deprecated('Use getCustomerSummaryRequestDescriptor instead')
const GetCustomerSummaryRequest$json = const {
  '1': 'GetCustomerSummaryRequest',
};

/// Descriptor for `GetCustomerSummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerSummaryRequestDescriptor = $convert.base64Decode('ChlHZXRDdXN0b21lclN1bW1hcnlSZXF1ZXN0');
@$core.Deprecated('Use getCustomerSummaryResponseDescriptor instead')
const GetCustomerSummaryResponse$json = const {
  '1': 'GetCustomerSummaryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'summary', '3': 3, '4': 1, '5': 11, '6': '.pb.CustomerSummary', '10': 'summary'},
  ],
};

/// Descriptor for `GetCustomerSummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerSummaryResponseDescriptor = $convert.base64Decode('ChpHZXRDdXN0b21lclN1bW1hcnlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USLQoHc3VtbWFyeRgDIAEoCzITLnBiLkN1c3RvbWVyU3VtbWFyeVIHc3VtbWFyeQ==');
@$core.Deprecated('Use addCustomerNoteRequestDescriptor instead')
const AddCustomerNoteRequest$json = const {
  '1': 'AddCustomerNoteRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
  ],
};

/// Descriptor for `AddCustomerNoteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addCustomerNoteRequestDescriptor = $convert.base64Decode('ChZBZGRDdXN0b21lck5vdGVSZXF1ZXN0Eh8KC2N1c3RvbWVyX2lkGAEgASgJUgpjdXN0b21lcklkEhgKB2NvbnRlbnQYAiABKAlSB2NvbnRlbnQ=');
@$core.Deprecated('Use addCustomerNoteResponseDescriptor instead')
const AddCustomerNoteResponse$json = const {
  '1': 'AddCustomerNoteResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'note', '3': 3, '4': 1, '5': 11, '6': '.pb.CustomerNote', '10': 'note'},
  ],
};

/// Descriptor for `AddCustomerNoteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addCustomerNoteResponseDescriptor = $convert.base64Decode('ChdBZGRDdXN0b21lck5vdGVSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USJAoEbm90ZRgDIAEoCzIQLnBiLkN1c3RvbWVyTm90ZVIEbm90ZQ==');
@$core.Deprecated('Use listCustomerNotesRequestDescriptor instead')
const ListCustomerNotesRequest$json = const {
  '1': 'ListCustomerNotesRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'page', '3': 2, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListCustomerNotesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCustomerNotesRequestDescriptor = $convert.base64Decode('ChhMaXN0Q3VzdG9tZXJOb3Rlc1JlcXVlc3QSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQSEgoEcGFnZRgCIAEoBVIEcGFnZRIUCgVsaW1pdBgDIAEoBVIFbGltaXQ=');
@$core.Deprecated('Use listCustomerNotesResponseDescriptor instead')
const ListCustomerNotesResponse$json = const {
  '1': 'ListCustomerNotesResponse',
  '2': const [
    const {'1': 'notes', '3': 1, '4': 3, '5': 11, '6': '.pb.CustomerNote', '10': 'notes'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListCustomerNotesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listCustomerNotesResponseDescriptor = $convert.base64Decode('ChlMaXN0Q3VzdG9tZXJOb3Rlc1Jlc3BvbnNlEiYKBW5vdGVzGAEgAygLMhAucGIuQ3VzdG9tZXJOb3RlUgVub3RlcxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use getCustomerStatementRequestDescriptor instead')
const GetCustomerStatementRequest$json = const {
  '1': 'GetCustomerStatementRequest',
  '2': const [
    const {'1': 'customer_id', '3': 1, '4': 1, '5': 9, '10': 'customerId'},
    const {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'end_date', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

/// Descriptor for `GetCustomerStatementRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerStatementRequestDescriptor = $convert.base64Decode('ChtHZXRDdXN0b21lclN0YXRlbWVudFJlcXVlc3QSHwoLY3VzdG9tZXJfaWQYASABKAlSCmN1c3RvbWVySWQSHQoKc3RhcnRfZGF0ZRgCIAEoCVIJc3RhcnREYXRlEhkKCGVuZF9kYXRlGAMgASgJUgdlbmREYXRl');
@$core.Deprecated('Use getCustomerStatementResponseDescriptor instead')
const GetCustomerStatementResponse$json = const {
  '1': 'GetCustomerStatementResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'entries', '3': 3, '4': 3, '5': 11, '6': '.pb.CustomerStatementEntry', '10': 'entries'},
    const {'1': 'opening_balance', '3': 4, '4': 1, '5': 3, '10': 'openingBalance'},
    const {'1': 'closing_balance', '3': 5, '4': 1, '5': 3, '10': 'closingBalance'},
  ],
};

/// Descriptor for `GetCustomerStatementResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCustomerStatementResponseDescriptor = $convert.base64Decode('ChxHZXRDdXN0b21lclN0YXRlbWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI0CgdlbnRyaWVzGAMgAygLMhoucGIuQ3VzdG9tZXJTdGF0ZW1lbnRFbnRyeVIHZW50cmllcxInCg9vcGVuaW5nX2JhbGFuY2UYBCABKANSDm9wZW5pbmdCYWxhbmNlEicKD2Nsb3NpbmdfYmFsYW5jZRgFIAEoA1IOY2xvc2luZ0JhbGFuY2U=');
@$core.Deprecated('Use taxObligationDescriptor instead')
const TaxObligation$json = const {
  '1': 'TaxObligation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'tax_type', '3': 3, '4': 1, '5': 14, '6': '.pb.TaxType', '10': 'taxType'},
    const {'1': 'period', '3': 4, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'status', '3': 6, '4': 1, '5': 14, '6': '.pb.TaxObligationStatus', '10': 'status'},
    const {'1': 'due_date', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dueDate'},
    const {'1': 'filed_date', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'filedDate'},
    const {'1': 'paid_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'paidDate'},
    const {'1': 'reference', '3': 10, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'notes', '3': 11, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `TaxObligation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taxObligationDescriptor = $convert.base64Decode('Cg1UYXhPYmxpZ2F0aW9uEg4KAmlkGAEgASgJUgJpZBIfCgtidXNpbmVzc19pZBgCIAEoCVIKYnVzaW5lc3NJZBImCgh0YXhfdHlwZRgDIAEoDjILLnBiLlRheFR5cGVSB3RheFR5cGUSFgoGcGVyaW9kGAQgASgJUgZwZXJpb2QSFgoGYW1vdW50GAUgASgDUgZhbW91bnQSLwoGc3RhdHVzGAYgASgOMhcucGIuVGF4T2JsaWdhdGlvblN0YXR1c1IGc3RhdHVzEjUKCGR1ZV9kYXRlGAcgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZHVlRGF0ZRI5CgpmaWxlZF9kYXRlGAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJZmlsZWREYXRlEjcKCXBhaWRfZGF0ZRgJIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCHBhaWREYXRlEhwKCXJlZmVyZW5jZRgKIAEoCVIJcmVmZXJlbmNlEhQKBW5vdGVzGAsgASgJUgVub3RlcxI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use taxCalendarEventDescriptor instead')
const TaxCalendarEvent$json = const {
  '1': 'TaxCalendarEvent',
  '2': const [
    const {'1': 'tax_type', '3': 1, '4': 1, '5': 14, '6': '.pb.TaxType', '10': 'taxType'},
    const {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'due_date', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dueDate'},
    const {'1': 'is_filed', '3': 4, '4': 1, '5': 8, '10': 'isFiled'},
    const {'1': 'is_paid', '3': 5, '4': 1, '5': 8, '10': 'isPaid'},
    const {'1': 'period', '3': 6, '4': 1, '5': 9, '10': 'period'},
  ],
};

/// Descriptor for `TaxCalendarEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taxCalendarEventDescriptor = $convert.base64Decode('ChBUYXhDYWxlbmRhckV2ZW50EiYKCHRheF90eXBlGAEgASgOMgsucGIuVGF4VHlwZVIHdGF4VHlwZRIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24SNQoIZHVlX2RhdGUYAyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdkdWVEYXRlEhkKCGlzX2ZpbGVkGAQgASgIUgdpc0ZpbGVkEhcKB2lzX3BhaWQYBSABKAhSBmlzUGFpZBIWCgZwZXJpb2QYBiABKAlSBnBlcmlvZA==');
@$core.Deprecated('Use taxDocumentDescriptor instead')
const TaxDocument$json = const {
  '1': 'TaxDocument',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'document_type', '3': 3, '4': 1, '5': 14, '6': '.pb.TaxDocumentType', '10': 'documentType'},
    const {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'file_url', '3': 5, '4': 1, '5': 9, '10': 'fileUrl'},
    const {'1': 'expiry_date', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiryDate'},
    const {'1': 'notes', '3': 7, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 8, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `TaxDocument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taxDocumentDescriptor = $convert.base64Decode('CgtUYXhEb2N1bWVudBIOCgJpZBgBIAEoCVICaWQSHwoLYnVzaW5lc3NfaWQYAiABKAlSCmJ1c2luZXNzSWQSOAoNZG9jdW1lbnRfdHlwZRgDIAEoDjITLnBiLlRheERvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEhIKBG5hbWUYBCABKAlSBG5hbWUSGQoIZmlsZV91cmwYBSABKAlSB2ZpbGVVcmwSOwoLZXhwaXJ5X2RhdGUYBiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpleHBpcnlEYXRlEhQKBW5vdGVzGAcgASgJUgVub3RlcxI5CgpjcmVhdGVkX2F0GAggASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0');
@$core.Deprecated('Use vATEntryDescriptor instead')
const VATEntry$json = const {
  '1': 'VATEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'base_amount', '3': 4, '4': 1, '5': 3, '10': 'baseAmount'},
    const {'1': 'vat_amount', '3': 5, '4': 1, '5': 3, '10': 'vatAmount'},
    const {'1': 'direction', '3': 6, '4': 1, '5': 14, '6': '.pb.VATDirection', '10': 'direction'},
    const {'1': 'invoice_reference', '3': 7, '4': 1, '5': 9, '10': 'invoiceReference'},
    const {'1': 'period', '3': 8, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'transaction_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `VATEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vATEntryDescriptor = $convert.base64Decode('CghWQVRFbnRyeRIOCgJpZBgBIAEoCVICaWQSHwoLYnVzaW5lc3NfaWQYAiABKAlSCmJ1c2luZXNzSWQSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh8KC2Jhc2VfYW1vdW50GAQgASgDUgpiYXNlQW1vdW50Eh0KCnZhdF9hbW91bnQYBSABKANSCXZhdEFtb3VudBIuCglkaXJlY3Rpb24YBiABKA4yEC5wYi5WQVREaXJlY3Rpb25SCWRpcmVjdGlvbhIrChFpbnZvaWNlX3JlZmVyZW5jZRgHIAEoCVIQaW52b2ljZVJlZmVyZW5jZRIWCgZwZXJpb2QYCCABKAlSBnBlcmlvZBJFChB0cmFuc2FjdGlvbl9kYXRlGAkgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIPdHJhbnNhY3Rpb25EYXRlEjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQ=');
@$core.Deprecated('Use wHTEntryDescriptor instead')
const WHTEntry$json = const {
  '1': 'WHTEntry',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'vendor_name', '3': 3, '4': 1, '5': 9, '10': 'vendorName'},
    const {'1': 'payment_amount', '3': 4, '4': 1, '5': 3, '10': 'paymentAmount'},
    const {'1': 'wht_rate', '3': 5, '4': 1, '5': 1, '10': 'whtRate'},
    const {'1': 'wht_amount', '3': 6, '4': 1, '5': 3, '10': 'whtAmount'},
    const {'1': 'payment_reference', '3': 7, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'period', '3': 8, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'transaction_date', '3': 9, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'transactionDate'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
  ],
};

/// Descriptor for `WHTEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wHTEntryDescriptor = $convert.base64Decode('CghXSFRFbnRyeRIOCgJpZBgBIAEoCVICaWQSHwoLYnVzaW5lc3NfaWQYAiABKAlSCmJ1c2luZXNzSWQSHwoLdmVuZG9yX25hbWUYAyABKAlSCnZlbmRvck5hbWUSJQoOcGF5bWVudF9hbW91bnQYBCABKANSDXBheW1lbnRBbW91bnQSGQoId2h0X3JhdGUYBSABKAFSB3dodFJhdGUSHQoKd2h0X2Ftb3VudBgGIAEoA1IJd2h0QW1vdW50EisKEXBheW1lbnRfcmVmZXJlbmNlGAcgASgJUhBwYXltZW50UmVmZXJlbmNlEhYKBnBlcmlvZBgIIAEoCVIGcGVyaW9kEkUKEHRyYW5zYWN0aW9uX2RhdGUYCSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUg90cmFuc2FjdGlvbkRhdGUSOQoKY3JlYXRlZF9hdBgKIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');
@$core.Deprecated('Use taxDashboardSummaryDescriptor instead')
const TaxDashboardSummary$json = const {
  '1': 'TaxDashboardSummary',
  '2': const [
    const {'1': 'vat_due', '3': 1, '4': 1, '5': 3, '10': 'vatDue'},
    const {'1': 'paye_due', '3': 2, '4': 1, '5': 3, '10': 'payeDue'},
    const {'1': 'wht_due', '3': 3, '4': 1, '5': 3, '10': 'whtDue'},
    const {'1': 'cit_estimated', '3': 4, '4': 1, '5': 3, '10': 'citEstimated'},
    const {'1': 'pending_obligations', '3': 5, '4': 1, '5': 5, '10': 'pendingObligations'},
    const {'1': 'overdue_obligations', '3': 6, '4': 1, '5': 5, '10': 'overdueObligations'},
    const {'1': 'upcoming_deadlines', '3': 7, '4': 3, '5': 11, '6': '.pb.TaxCalendarEvent', '10': 'upcomingDeadlines'},
  ],
};

/// Descriptor for `TaxDashboardSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taxDashboardSummaryDescriptor = $convert.base64Decode('ChNUYXhEYXNoYm9hcmRTdW1tYXJ5EhcKB3ZhdF9kdWUYASABKANSBnZhdER1ZRIZCghwYXllX2R1ZRgCIAEoA1IHcGF5ZUR1ZRIXCgd3aHRfZHVlGAMgASgDUgZ3aHREdWUSIwoNY2l0X2VzdGltYXRlZBgEIAEoA1IMY2l0RXN0aW1hdGVkEi8KE3BlbmRpbmdfb2JsaWdhdGlvbnMYBSABKAVSEnBlbmRpbmdPYmxpZ2F0aW9ucxIvChNvdmVyZHVlX29ibGlnYXRpb25zGAYgASgFUhJvdmVyZHVlT2JsaWdhdGlvbnMSQwoSdXBjb21pbmdfZGVhZGxpbmVzGAcgAygLMhQucGIuVGF4Q2FsZW5kYXJFdmVudFIRdXBjb21pbmdEZWFkbGluZXM=');
@$core.Deprecated('Use getTaxDashboardRequestDescriptor instead')
const GetTaxDashboardRequest$json = const {
  '1': 'GetTaxDashboardRequest',
};

/// Descriptor for `GetTaxDashboardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxDashboardRequestDescriptor = $convert.base64Decode('ChZHZXRUYXhEYXNoYm9hcmRSZXF1ZXN0');
@$core.Deprecated('Use getTaxDashboardResponseDescriptor instead')
const GetTaxDashboardResponse$json = const {
  '1': 'GetTaxDashboardResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'dashboard', '3': 3, '4': 1, '5': 11, '6': '.pb.TaxDashboardSummary', '10': 'dashboard'},
  ],
};

/// Descriptor for `GetTaxDashboardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxDashboardResponseDescriptor = $convert.base64Decode('ChdHZXRUYXhEYXNoYm9hcmRSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNQoJZGFzaGJvYXJkGAMgASgLMhcucGIuVGF4RGFzaGJvYXJkU3VtbWFyeVIJZGFzaGJvYXJk');
@$core.Deprecated('Use getTaxCalendarRequestDescriptor instead')
const GetTaxCalendarRequest$json = const {
  '1': 'GetTaxCalendarRequest',
  '2': const [
    const {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    const {'1': 'month', '3': 2, '4': 1, '5': 5, '10': 'month'},
  ],
};

/// Descriptor for `GetTaxCalendarRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxCalendarRequestDescriptor = $convert.base64Decode('ChVHZXRUYXhDYWxlbmRhclJlcXVlc3QSEgoEeWVhchgBIAEoBVIEeWVhchIUCgVtb250aBgCIAEoBVIFbW9udGg=');
@$core.Deprecated('Use getTaxCalendarResponseDescriptor instead')
const GetTaxCalendarResponse$json = const {
  '1': 'GetTaxCalendarResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'events', '3': 3, '4': 3, '5': 11, '6': '.pb.TaxCalendarEvent', '10': 'events'},
  ],
};

/// Descriptor for `GetTaxCalendarResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTaxCalendarResponseDescriptor = $convert.base64Decode('ChZHZXRUYXhDYWxlbmRhclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIsCgZldmVudHMYAyADKAsyFC5wYi5UYXhDYWxlbmRhckV2ZW50UgZldmVudHM=');
@$core.Deprecated('Use createTaxObligationRequestDescriptor instead')
const CreateTaxObligationRequest$json = const {
  '1': 'CreateTaxObligationRequest',
  '2': const [
    const {'1': 'tax_type', '3': 1, '4': 1, '5': 14, '6': '.pb.TaxType', '10': 'taxType'},
    const {'1': 'period', '3': 2, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'due_date', '3': 4, '4': 1, '5': 9, '10': 'dueDate'},
    const {'1': 'notes', '3': 5, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `CreateTaxObligationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTaxObligationRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVUYXhPYmxpZ2F0aW9uUmVxdWVzdBImCgh0YXhfdHlwZRgBIAEoDjILLnBiLlRheFR5cGVSB3RheFR5cGUSFgoGcGVyaW9kGAIgASgJUgZwZXJpb2QSFgoGYW1vdW50GAMgASgDUgZhbW91bnQSGQoIZHVlX2RhdGUYBCABKAlSB2R1ZURhdGUSFAoFbm90ZXMYBSABKAlSBW5vdGVz');
@$core.Deprecated('Use createTaxObligationResponseDescriptor instead')
const CreateTaxObligationResponse$json = const {
  '1': 'CreateTaxObligationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'obligation', '3': 3, '4': 1, '5': 11, '6': '.pb.TaxObligation', '10': 'obligation'},
  ],
};

/// Descriptor for `CreateTaxObligationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTaxObligationResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVUYXhPYmxpZ2F0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjEKCm9ibGlnYXRpb24YAyABKAsyES5wYi5UYXhPYmxpZ2F0aW9uUgpvYmxpZ2F0aW9u');
@$core.Deprecated('Use updateTaxObligationRequestDescriptor instead')
const UpdateTaxObligationRequest$json = const {
  '1': 'UpdateTaxObligationRequest',
  '2': const [
    const {'1': 'obligation_id', '3': 1, '4': 1, '5': 9, '10': 'obligationId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.pb.TaxObligationStatus', '10': 'status'},
    const {'1': 'amount', '3': 3, '4': 1, '5': 3, '10': 'amount'},
    const {'1': 'reference', '3': 4, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'notes', '3': 5, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateTaxObligationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTaxObligationRequestDescriptor = $convert.base64Decode('ChpVcGRhdGVUYXhPYmxpZ2F0aW9uUmVxdWVzdBIjCg1vYmxpZ2F0aW9uX2lkGAEgASgJUgxvYmxpZ2F0aW9uSWQSLwoGc3RhdHVzGAIgASgOMhcucGIuVGF4T2JsaWdhdGlvblN0YXR1c1IGc3RhdHVzEhYKBmFtb3VudBgDIAEoA1IGYW1vdW50EhwKCXJlZmVyZW5jZRgEIAEoCVIJcmVmZXJlbmNlEhQKBW5vdGVzGAUgASgJUgVub3Rlcw==');
@$core.Deprecated('Use updateTaxObligationResponseDescriptor instead')
const UpdateTaxObligationResponse$json = const {
  '1': 'UpdateTaxObligationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'obligation', '3': 3, '4': 1, '5': 11, '6': '.pb.TaxObligation', '10': 'obligation'},
  ],
};

/// Descriptor for `UpdateTaxObligationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTaxObligationResponseDescriptor = $convert.base64Decode('ChtVcGRhdGVUYXhPYmxpZ2F0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjEKCm9ibGlnYXRpb24YAyABKAsyES5wYi5UYXhPYmxpZ2F0aW9uUgpvYmxpZ2F0aW9u');
@$core.Deprecated('Use listTaxObligationsRequestDescriptor instead')
const ListTaxObligationsRequest$json = const {
  '1': 'ListTaxObligationsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'tax_type', '3': 3, '4': 1, '5': 14, '6': '.pb.TaxType', '10': 'taxType'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.pb.TaxObligationStatus', '10': 'status'},
    const {'1': 'year', '3': 5, '4': 1, '5': 5, '10': 'year'},
  ],
};

/// Descriptor for `ListTaxObligationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTaxObligationsRequestDescriptor = $convert.base64Decode('ChlMaXN0VGF4T2JsaWdhdGlvbnNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0EiYKCHRheF90eXBlGAMgASgOMgsucGIuVGF4VHlwZVIHdGF4VHlwZRIvCgZzdGF0dXMYBCABKA4yFy5wYi5UYXhPYmxpZ2F0aW9uU3RhdHVzUgZzdGF0dXMSEgoEeWVhchgFIAEoBVIEeWVhcg==');
@$core.Deprecated('Use listTaxObligationsResponseDescriptor instead')
const ListTaxObligationsResponse$json = const {
  '1': 'ListTaxObligationsResponse',
  '2': const [
    const {'1': 'obligations', '3': 1, '4': 3, '5': 11, '6': '.pb.TaxObligation', '10': 'obligations'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListTaxObligationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTaxObligationsResponseDescriptor = $convert.base64Decode('ChpMaXN0VGF4T2JsaWdhdGlvbnNSZXNwb25zZRIzCgtvYmxpZ2F0aW9ucxgBIAMoCzIRLnBiLlRheE9ibGlnYXRpb25SC29ibGlnYXRpb25zEjkKCnBhZ2luYXRpb24YAiABKAsyGS5wYi5QYXlyb2xsUGFnaW5hdGlvbkluZm9SCnBhZ2luYXRpb24=');
@$core.Deprecated('Use uploadTaxDocumentRequestDescriptor instead')
const UploadTaxDocumentRequest$json = const {
  '1': 'UploadTaxDocumentRequest',
  '2': const [
    const {'1': 'document_type', '3': 1, '4': 1, '5': 14, '6': '.pb.TaxDocumentType', '10': 'documentType'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'file_url', '3': 3, '4': 1, '5': 9, '10': 'fileUrl'},
    const {'1': 'expiry_date', '3': 4, '4': 1, '5': 9, '10': 'expiryDate'},
    const {'1': 'notes', '3': 5, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UploadTaxDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadTaxDocumentRequestDescriptor = $convert.base64Decode('ChhVcGxvYWRUYXhEb2N1bWVudFJlcXVlc3QSOAoNZG9jdW1lbnRfdHlwZRgBIAEoDjITLnBiLlRheERvY3VtZW50VHlwZVIMZG9jdW1lbnRUeXBlEhIKBG5hbWUYAiABKAlSBG5hbWUSGQoIZmlsZV91cmwYAyABKAlSB2ZpbGVVcmwSHwoLZXhwaXJ5X2RhdGUYBCABKAlSCmV4cGlyeURhdGUSFAoFbm90ZXMYBSABKAlSBW5vdGVz');
@$core.Deprecated('Use uploadTaxDocumentResponseDescriptor instead')
const UploadTaxDocumentResponse$json = const {
  '1': 'UploadTaxDocumentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'document', '3': 3, '4': 1, '5': 11, '6': '.pb.TaxDocument', '10': 'document'},
  ],
};

/// Descriptor for `UploadTaxDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadTaxDocumentResponseDescriptor = $convert.base64Decode('ChlVcGxvYWRUYXhEb2N1bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIrCghkb2N1bWVudBgDIAEoCzIPLnBiLlRheERvY3VtZW50Ughkb2N1bWVudA==');
@$core.Deprecated('Use listTaxDocumentsRequestDescriptor instead')
const ListTaxDocumentsRequest$json = const {
  '1': 'ListTaxDocumentsRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'document_type', '3': 3, '4': 1, '5': 14, '6': '.pb.TaxDocumentType', '10': 'documentType'},
  ],
};

/// Descriptor for `ListTaxDocumentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTaxDocumentsRequestDescriptor = $convert.base64Decode('ChdMaXN0VGF4RG9jdW1lbnRzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdBI4Cg1kb2N1bWVudF90eXBlGAMgASgOMhMucGIuVGF4RG9jdW1lbnRUeXBlUgxkb2N1bWVudFR5cGU=');
@$core.Deprecated('Use listTaxDocumentsResponseDescriptor instead')
const ListTaxDocumentsResponse$json = const {
  '1': 'ListTaxDocumentsResponse',
  '2': const [
    const {'1': 'documents', '3': 1, '4': 3, '5': 11, '6': '.pb.TaxDocument', '10': 'documents'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListTaxDocumentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTaxDocumentsResponseDescriptor = $convert.base64Decode('ChhMaXN0VGF4RG9jdW1lbnRzUmVzcG9uc2USLQoJZG9jdW1lbnRzGAEgAygLMg8ucGIuVGF4RG9jdW1lbnRSCWRvY3VtZW50cxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use deleteTaxDocumentRequestDescriptor instead')
const DeleteTaxDocumentRequest$json = const {
  '1': 'DeleteTaxDocumentRequest',
  '2': const [
    const {'1': 'document_id', '3': 1, '4': 1, '5': 9, '10': 'documentId'},
  ],
};

/// Descriptor for `DeleteTaxDocumentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTaxDocumentRequestDescriptor = $convert.base64Decode('ChhEZWxldGVUYXhEb2N1bWVudFJlcXVlc3QSHwoLZG9jdW1lbnRfaWQYASABKAlSCmRvY3VtZW50SWQ=');
@$core.Deprecated('Use deleteTaxDocumentResponseDescriptor instead')
const DeleteTaxDocumentResponse$json = const {
  '1': 'DeleteTaxDocumentResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteTaxDocumentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteTaxDocumentResponseDescriptor = $convert.base64Decode('ChlEZWxldGVUYXhEb2N1bWVudFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use getVATScheduleRequestDescriptor instead')
const GetVATScheduleRequest$json = const {
  '1': 'GetVATScheduleRequest',
  '2': const [
    const {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
  ],
};

/// Descriptor for `GetVATScheduleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVATScheduleRequestDescriptor = $convert.base64Decode('ChVHZXRWQVRTY2hlZHVsZVJlcXVlc3QSFgoGcGVyaW9kGAEgASgJUgZwZXJpb2Q=');
@$core.Deprecated('Use getVATScheduleResponseDescriptor instead')
const GetVATScheduleResponse$json = const {
  '1': 'GetVATScheduleResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'entries', '3': 3, '4': 3, '5': 11, '6': '.pb.VATEntry', '10': 'entries'},
    const {'1': 'total_output_vat', '3': 4, '4': 1, '5': 3, '10': 'totalOutputVat'},
    const {'1': 'total_input_vat', '3': 5, '4': 1, '5': 3, '10': 'totalInputVat'},
    const {'1': 'net_vat_payable', '3': 6, '4': 1, '5': 3, '10': 'netVatPayable'},
  ],
};

/// Descriptor for `GetVATScheduleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVATScheduleResponseDescriptor = $convert.base64Decode('ChZHZXRWQVRTY2hlZHVsZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRImCgdlbnRyaWVzGAMgAygLMgwucGIuVkFURW50cnlSB2VudHJpZXMSKAoQdG90YWxfb3V0cHV0X3ZhdBgEIAEoA1IOdG90YWxPdXRwdXRWYXQSJgoPdG90YWxfaW5wdXRfdmF0GAUgASgDUg10b3RhbElucHV0VmF0EiYKD25ldF92YXRfcGF5YWJsZRgGIAEoA1INbmV0VmF0UGF5YWJsZQ==');
@$core.Deprecated('Use recordVATTransactionRequestDescriptor instead')
const RecordVATTransactionRequest$json = const {
  '1': 'RecordVATTransactionRequest',
  '2': const [
    const {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'base_amount', '3': 2, '4': 1, '5': 3, '10': 'baseAmount'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.pb.VATDirection', '10': 'direction'},
    const {'1': 'invoice_reference', '3': 4, '4': 1, '5': 9, '10': 'invoiceReference'},
    const {'1': 'period', '3': 5, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'transaction_date', '3': 6, '4': 1, '5': 9, '10': 'transactionDate'},
  ],
};

/// Descriptor for `RecordVATTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordVATTransactionRequestDescriptor = $convert.base64Decode('ChtSZWNvcmRWQVRUcmFuc2FjdGlvblJlcXVlc3QSIAoLZGVzY3JpcHRpb24YASABKAlSC2Rlc2NyaXB0aW9uEh8KC2Jhc2VfYW1vdW50GAIgASgDUgpiYXNlQW1vdW50Ei4KCWRpcmVjdGlvbhgDIAEoDjIQLnBiLlZBVERpcmVjdGlvblIJZGlyZWN0aW9uEisKEWludm9pY2VfcmVmZXJlbmNlGAQgASgJUhBpbnZvaWNlUmVmZXJlbmNlEhYKBnBlcmlvZBgFIAEoCVIGcGVyaW9kEikKEHRyYW5zYWN0aW9uX2RhdGUYBiABKAlSD3RyYW5zYWN0aW9uRGF0ZQ==');
@$core.Deprecated('Use recordVATTransactionResponseDescriptor instead')
const RecordVATTransactionResponse$json = const {
  '1': 'RecordVATTransactionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'entry', '3': 3, '4': 1, '5': 11, '6': '.pb.VATEntry', '10': 'entry'},
  ],
};

/// Descriptor for `RecordVATTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordVATTransactionResponseDescriptor = $convert.base64Decode('ChxSZWNvcmRWQVRUcmFuc2FjdGlvblJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIiCgVlbnRyeRgDIAEoCzIMLnBiLlZBVEVudHJ5UgVlbnRyeQ==');
@$core.Deprecated('Use getWHTScheduleRequestDescriptor instead')
const GetWHTScheduleRequest$json = const {
  '1': 'GetWHTScheduleRequest',
  '2': const [
    const {'1': 'period', '3': 1, '4': 1, '5': 9, '10': 'period'},
  ],
};

/// Descriptor for `GetWHTScheduleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWHTScheduleRequestDescriptor = $convert.base64Decode('ChVHZXRXSFRTY2hlZHVsZVJlcXVlc3QSFgoGcGVyaW9kGAEgASgJUgZwZXJpb2Q=');
@$core.Deprecated('Use getWHTScheduleResponseDescriptor instead')
const GetWHTScheduleResponse$json = const {
  '1': 'GetWHTScheduleResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'entries', '3': 3, '4': 3, '5': 11, '6': '.pb.WHTEntry', '10': 'entries'},
    const {'1': 'total_wht_deducted', '3': 4, '4': 1, '5': 3, '10': 'totalWhtDeducted'},
  ],
};

/// Descriptor for `GetWHTScheduleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getWHTScheduleResponseDescriptor = $convert.base64Decode('ChZHZXRXSFRTY2hlZHVsZVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRImCgdlbnRyaWVzGAMgAygLMgwucGIuV0hURW50cnlSB2VudHJpZXMSLAoSdG90YWxfd2h0X2RlZHVjdGVkGAQgASgDUhB0b3RhbFdodERlZHVjdGVk');
@$core.Deprecated('Use recordWHTDeductionRequestDescriptor instead')
const RecordWHTDeductionRequest$json = const {
  '1': 'RecordWHTDeductionRequest',
  '2': const [
    const {'1': 'vendor_name', '3': 1, '4': 1, '5': 9, '10': 'vendorName'},
    const {'1': 'payment_amount', '3': 2, '4': 1, '5': 3, '10': 'paymentAmount'},
    const {'1': 'wht_rate', '3': 3, '4': 1, '5': 1, '10': 'whtRate'},
    const {'1': 'payment_reference', '3': 4, '4': 1, '5': 9, '10': 'paymentReference'},
    const {'1': 'period', '3': 5, '4': 1, '5': 9, '10': 'period'},
    const {'1': 'transaction_date', '3': 6, '4': 1, '5': 9, '10': 'transactionDate'},
  ],
};

/// Descriptor for `RecordWHTDeductionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordWHTDeductionRequestDescriptor = $convert.base64Decode('ChlSZWNvcmRXSFREZWR1Y3Rpb25SZXF1ZXN0Eh8KC3ZlbmRvcl9uYW1lGAEgASgJUgp2ZW5kb3JOYW1lEiUKDnBheW1lbnRfYW1vdW50GAIgASgDUg1wYXltZW50QW1vdW50EhkKCHdodF9yYXRlGAMgASgBUgd3aHRSYXRlEisKEXBheW1lbnRfcmVmZXJlbmNlGAQgASgJUhBwYXltZW50UmVmZXJlbmNlEhYKBnBlcmlvZBgFIAEoCVIGcGVyaW9kEikKEHRyYW5zYWN0aW9uX2RhdGUYBiABKAlSD3RyYW5zYWN0aW9uRGF0ZQ==');
@$core.Deprecated('Use recordWHTDeductionResponseDescriptor instead')
const RecordWHTDeductionResponse$json = const {
  '1': 'RecordWHTDeductionResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'entry', '3': 3, '4': 1, '5': 11, '6': '.pb.WHTEntry', '10': 'entry'},
  ],
};

/// Descriptor for `RecordWHTDeductionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recordWHTDeductionResponseDescriptor = $convert.base64Decode('ChpSZWNvcmRXSFREZWR1Y3Rpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USIgoFZW50cnkYAyABKAsyDC5wYi5XSFRFbnRyeVIFZW50cnk=');
@$core.Deprecated('Use getPAYESummaryRequestDescriptor instead')
const GetPAYESummaryRequest$json = const {
  '1': 'GetPAYESummaryRequest',
  '2': const [
    const {'1': 'period_start', '3': 1, '4': 1, '5': 9, '10': 'periodStart'},
    const {'1': 'period_end', '3': 2, '4': 1, '5': 9, '10': 'periodEnd'},
  ],
};

/// Descriptor for `GetPAYESummaryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPAYESummaryRequestDescriptor = $convert.base64Decode('ChVHZXRQQVlFU3VtbWFyeVJlcXVlc3QSIQoMcGVyaW9kX3N0YXJ0GAEgASgJUgtwZXJpb2RTdGFydBIdCgpwZXJpb2RfZW5kGAIgASgJUglwZXJpb2RFbmQ=');
@$core.Deprecated('Use getPAYESummaryResponseDescriptor instead')
const GetPAYESummaryResponse$json = const {
  '1': 'GetPAYESummaryResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'total_paye', '3': 3, '4': 1, '5': 3, '10': 'totalPaye'},
    const {'1': 'employee_count', '3': 4, '4': 1, '5': 5, '10': 'employeeCount'},
    const {'1': 'employee_summaries', '3': 5, '4': 3, '5': 11, '6': '.pb.EmployeeTaxSummary', '10': 'employeeSummaries'},
  ],
};

/// Descriptor for `GetPAYESummaryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPAYESummaryResponseDescriptor = $convert.base64Decode('ChZHZXRQQVlFU3VtbWFyeVJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIdCgp0b3RhbF9wYXllGAMgASgDUgl0b3RhbFBheWUSJQoOZW1wbG95ZWVfY291bnQYBCABKAVSDWVtcGxveWVlQ291bnQSRQoSZW1wbG95ZWVfc3VtbWFyaWVzGAUgAygLMhYucGIuRW1wbG95ZWVUYXhTdW1tYXJ5UhFlbXBsb3llZVN1bW1hcmllcw==');
@$core.Deprecated('Use getCITEstimationRequestDescriptor instead')
const GetCITEstimationRequest$json = const {
  '1': 'GetCITEstimationRequest',
  '2': const [
    const {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
  ],
};

/// Descriptor for `GetCITEstimationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCITEstimationRequestDescriptor = $convert.base64Decode('ChdHZXRDSVRFc3RpbWF0aW9uUmVxdWVzdBISCgR5ZWFyGAEgASgFUgR5ZWFy');
@$core.Deprecated('Use getCITEstimationResponseDescriptor instead')
const GetCITEstimationResponse$json = const {
  '1': 'GetCITEstimationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'annual_revenue', '3': 3, '4': 1, '5': 3, '10': 'annualRevenue'},
    const {'1': 'annual_expenses', '3': 4, '4': 1, '5': 3, '10': 'annualExpenses'},
    const {'1': 'taxable_income', '3': 5, '4': 1, '5': 3, '10': 'taxableIncome'},
    const {'1': 'cit_rate', '3': 6, '4': 1, '5': 1, '10': 'citRate'},
    const {'1': 'estimated_cit', '3': 7, '4': 1, '5': 3, '10': 'estimatedCit'},
    const {'1': 'tax_band', '3': 8, '4': 1, '5': 9, '10': 'taxBand'},
  ],
};

/// Descriptor for `GetCITEstimationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCITEstimationResponseDescriptor = $convert.base64Decode('ChhHZXRDSVRFc3RpbWF0aW9uUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiUKDmFubnVhbF9yZXZlbnVlGAMgASgDUg1hbm51YWxSZXZlbnVlEicKD2FubnVhbF9leHBlbnNlcxgEIAEoA1IOYW5udWFsRXhwZW5zZXMSJQoOdGF4YWJsZV9pbmNvbWUYBSABKANSDXRheGFibGVJbmNvbWUSGQoIY2l0X3JhdGUYBiABKAFSB2NpdFJhdGUSIwoNZXN0aW1hdGVkX2NpdBgHIAEoA1IMZXN0aW1hdGVkQ2l0EhkKCHRheF9iYW5kGAggASgJUgd0YXhCYW5k');
@$core.Deprecated('Use supplierDescriptor instead')
const Supplier$json = const {
  '1': 'Supplier',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'contact_name', '3': 4, '4': 1, '5': 9, '10': 'contactName'},
    const {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 7, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'status', '3': 8, '4': 1, '5': 14, '6': '.pb.SupplierStatus', '10': 'status'},
    const {'1': 'notes', '3': 9, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `Supplier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supplierDescriptor = $convert.base64Decode('CghTdXBwbGllchIOCgJpZBgBIAEoCVICaWQSHwoLYnVzaW5lc3NfaWQYAiABKAlSCmJ1c2luZXNzSWQSEgoEbmFtZRgDIAEoCVIEbmFtZRIhCgxjb250YWN0X25hbWUYBCABKAlSC2NvbnRhY3ROYW1lEhQKBWVtYWlsGAUgASgJUgVlbWFpbBIUCgVwaG9uZRgGIAEoCVIFcGhvbmUSGAoHYWRkcmVzcxgHIAEoCVIHYWRkcmVzcxIqCgZzdGF0dXMYCCABKA4yEi5wYi5TdXBwbGllclN0YXR1c1IGc3RhdHVzEhQKBW5vdGVzGAkgASgJUgVub3RlcxI5CgpjcmVhdGVkX2F0GAogASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYCyABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use purchaseOrderDescriptor instead')
const PurchaseOrder$json = const {
  '1': 'PurchaseOrder',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'business_id', '3': 2, '4': 1, '5': 9, '10': 'businessId'},
    const {'1': 'supplier_id', '3': 3, '4': 1, '5': 9, '10': 'supplierId'},
    const {'1': 'supplier_name', '3': 4, '4': 1, '5': 9, '10': 'supplierName'},
    const {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.pb.PurchaseOrderStatus', '10': 'status'},
    const {'1': 'items', '3': 6, '4': 3, '5': 11, '6': '.pb.PurchaseOrderItem', '10': 'items'},
    const {'1': 'total_amount', '3': 7, '4': 1, '5': 3, '10': 'totalAmount'},
    const {'1': 'notes', '3': 8, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'reference', '3': 9, '4': 1, '5': 9, '10': 'reference'},
    const {'1': 'expected_date', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expectedDate'},
    const {'1': 'received_date', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'receivedDate'},
    const {'1': 'created_at', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `PurchaseOrder`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseOrderDescriptor = $convert.base64Decode('Cg1QdXJjaGFzZU9yZGVyEg4KAmlkGAEgASgJUgJpZBIfCgtidXNpbmVzc19pZBgCIAEoCVIKYnVzaW5lc3NJZBIfCgtzdXBwbGllcl9pZBgDIAEoCVIKc3VwcGxpZXJJZBIjCg1zdXBwbGllcl9uYW1lGAQgASgJUgxzdXBwbGllck5hbWUSLwoGc3RhdHVzGAUgASgOMhcucGIuUHVyY2hhc2VPcmRlclN0YXR1c1IGc3RhdHVzEisKBWl0ZW1zGAYgAygLMhUucGIuUHVyY2hhc2VPcmRlckl0ZW1SBWl0ZW1zEiEKDHRvdGFsX2Ftb3VudBgHIAEoA1ILdG90YWxBbW91bnQSFAoFbm90ZXMYCCABKAlSBW5vdGVzEhwKCXJlZmVyZW5jZRgJIAEoCVIJcmVmZXJlbmNlEj8KDWV4cGVjdGVkX2RhdGUYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgxleHBlY3RlZERhdGUSPwoNcmVjZWl2ZWRfZGF0ZRgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSDHJlY2VpdmVkRGF0ZRI5CgpjcmVhdGVkX2F0GAwgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkKCnVwZGF0ZWRfYXQYDSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQXQ=');
@$core.Deprecated('Use purchaseOrderItemDescriptor instead')
const PurchaseOrderItem$json = const {
  '1': 'PurchaseOrderItem',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'item_name', '3': 2, '4': 1, '5': 9, '10': 'itemName'},
    const {'1': 'quantity_ordered', '3': 3, '4': 1, '5': 5, '10': 'quantityOrdered'},
    const {'1': 'quantity_received', '3': 4, '4': 1, '5': 5, '10': 'quantityReceived'},
    const {'1': 'unit_price', '3': 5, '4': 1, '5': 3, '10': 'unitPrice'},
    const {'1': 'total_price', '3': 6, '4': 1, '5': 3, '10': 'totalPrice'},
  ],
};

/// Descriptor for `PurchaseOrderItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List purchaseOrderItemDescriptor = $convert.base64Decode('ChFQdXJjaGFzZU9yZGVySXRlbRIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQSGwoJaXRlbV9uYW1lGAIgASgJUghpdGVtTmFtZRIpChBxdWFudGl0eV9vcmRlcmVkGAMgASgFUg9xdWFudGl0eU9yZGVyZWQSKwoRcXVhbnRpdHlfcmVjZWl2ZWQYBCABKAVSEHF1YW50aXR5UmVjZWl2ZWQSHQoKdW5pdF9wcmljZRgFIAEoA1IJdW5pdFByaWNlEh8KC3RvdGFsX3ByaWNlGAYgASgDUgp0b3RhbFByaWNl');
@$core.Deprecated('Use inventoryValuationDescriptor instead')
const InventoryValuation$json = const {
  '1': 'InventoryValuation',
  '2': const [
    const {'1': 'total_value', '3': 1, '4': 1, '5': 3, '10': 'totalValue'},
    const {'1': 'total_items', '3': 2, '4': 1, '5': 5, '10': 'totalItems'},
    const {'1': 'categories', '3': 3, '4': 3, '5': 11, '6': '.pb.CategoryValuation', '10': 'categories'},
  ],
};

/// Descriptor for `InventoryValuation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryValuationDescriptor = $convert.base64Decode('ChJJbnZlbnRvcnlWYWx1YXRpb24SHwoLdG90YWxfdmFsdWUYASABKANSCnRvdGFsVmFsdWUSHwoLdG90YWxfaXRlbXMYAiABKAVSCnRvdGFsSXRlbXMSNQoKY2F0ZWdvcmllcxgDIAMoCzIVLnBiLkNhdGVnb3J5VmFsdWF0aW9uUgpjYXRlZ29yaWVz');
@$core.Deprecated('Use categoryValuationDescriptor instead')
const CategoryValuation$json = const {
  '1': 'CategoryValuation',
  '2': const [
    const {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'item_count', '3': 2, '4': 1, '5': 5, '10': 'itemCount'},
    const {'1': 'total_value', '3': 3, '4': 1, '5': 3, '10': 'totalValue'},
    const {'1': 'percentage', '3': 4, '4': 1, '5': 1, '10': 'percentage'},
  ],
};

/// Descriptor for `CategoryValuation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryValuationDescriptor = $convert.base64Decode('ChFDYXRlZ29yeVZhbHVhdGlvbhIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcnkSHQoKaXRlbV9jb3VudBgCIAEoBVIJaXRlbUNvdW50Eh8KC3RvdGFsX3ZhbHVlGAMgASgDUgp0b3RhbFZhbHVlEh4KCnBlcmNlbnRhZ2UYBCABKAFSCnBlcmNlbnRhZ2U=');
@$core.Deprecated('Use expiryAlertDescriptor instead')
const ExpiryAlert$json = const {
  '1': 'ExpiryAlert',
  '2': const [
    const {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    const {'1': 'item_name', '3': 2, '4': 1, '5': 9, '10': 'itemName'},
    const {'1': 'category', '3': 3, '4': 1, '5': 9, '10': 'category'},
    const {'1': 'quantity', '3': 4, '4': 1, '5': 5, '10': 'quantity'},
    const {'1': 'expiry_date', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiryDate'},
    const {'1': 'days_until_expiry', '3': 6, '4': 1, '5': 5, '10': 'daysUntilExpiry'},
  ],
};

/// Descriptor for `ExpiryAlert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expiryAlertDescriptor = $convert.base64Decode('CgtFeHBpcnlBbGVydBIXCgdpdGVtX2lkGAEgASgJUgZpdGVtSWQSGwoJaXRlbV9uYW1lGAIgASgJUghpdGVtTmFtZRIaCghjYXRlZ29yeRgDIAEoCVIIY2F0ZWdvcnkSGgoIcXVhbnRpdHkYBCABKAVSCHF1YW50aXR5EjsKC2V4cGlyeV9kYXRlGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKZXhwaXJ5RGF0ZRIqChFkYXlzX3VudGlsX2V4cGlyeRgGIAEoBVIPZGF5c1VudGlsRXhwaXJ5');
@$core.Deprecated('Use createSupplierRequestDescriptor instead')
const CreateSupplierRequest$json = const {
  '1': 'CreateSupplierRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'contact_name', '3': 2, '4': 1, '5': 9, '10': 'contactName'},
    const {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 4, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 5, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'notes', '3': 6, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `CreateSupplierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSupplierRequestDescriptor = $convert.base64Decode('ChVDcmVhdGVTdXBwbGllclJlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZRIhCgxjb250YWN0X25hbWUYAiABKAlSC2NvbnRhY3ROYW1lEhQKBWVtYWlsGAMgASgJUgVlbWFpbBIUCgVwaG9uZRgEIAEoCVIFcGhvbmUSGAoHYWRkcmVzcxgFIAEoCVIHYWRkcmVzcxIUCgVub3RlcxgGIAEoCVIFbm90ZXM=');
@$core.Deprecated('Use createSupplierResponseDescriptor instead')
const CreateSupplierResponse$json = const {
  '1': 'CreateSupplierResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'supplier', '3': 3, '4': 1, '5': 11, '6': '.pb.Supplier', '10': 'supplier'},
  ],
};

/// Descriptor for `CreateSupplierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createSupplierResponseDescriptor = $convert.base64Decode('ChZDcmVhdGVTdXBwbGllclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghzdXBwbGllchgDIAEoCzIMLnBiLlN1cHBsaWVyUghzdXBwbGllcg==');
@$core.Deprecated('Use updateSupplierRequestDescriptor instead')
const UpdateSupplierRequest$json = const {
  '1': 'UpdateSupplierRequest',
  '2': const [
    const {'1': 'supplier_id', '3': 1, '4': 1, '5': 9, '10': 'supplierId'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'contact_name', '3': 3, '4': 1, '5': 9, '10': 'contactName'},
    const {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'address', '3': 6, '4': 1, '5': 9, '10': 'address'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.pb.SupplierStatus', '10': 'status'},
    const {'1': 'notes', '3': 8, '4': 1, '5': 9, '10': 'notes'},
  ],
};

/// Descriptor for `UpdateSupplierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSupplierRequestDescriptor = $convert.base64Decode('ChVVcGRhdGVTdXBwbGllclJlcXVlc3QSHwoLc3VwcGxpZXJfaWQYASABKAlSCnN1cHBsaWVySWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIhCgxjb250YWN0X25hbWUYAyABKAlSC2NvbnRhY3ROYW1lEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIUCgVwaG9uZRgFIAEoCVIFcGhvbmUSGAoHYWRkcmVzcxgGIAEoCVIHYWRkcmVzcxIqCgZzdGF0dXMYByABKA4yEi5wYi5TdXBwbGllclN0YXR1c1IGc3RhdHVzEhQKBW5vdGVzGAggASgJUgVub3Rlcw==');
@$core.Deprecated('Use updateSupplierResponseDescriptor instead')
const UpdateSupplierResponse$json = const {
  '1': 'UpdateSupplierResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'supplier', '3': 3, '4': 1, '5': 11, '6': '.pb.Supplier', '10': 'supplier'},
  ],
};

/// Descriptor for `UpdateSupplierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSupplierResponseDescriptor = $convert.base64Decode('ChZVcGRhdGVTdXBwbGllclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRIoCghzdXBwbGllchgDIAEoCzIMLnBiLlN1cHBsaWVyUghzdXBwbGllcg==');
@$core.Deprecated('Use deleteSupplierRequestDescriptor instead')
const DeleteSupplierRequest$json = const {
  '1': 'DeleteSupplierRequest',
  '2': const [
    const {'1': 'supplier_id', '3': 1, '4': 1, '5': 9, '10': 'supplierId'},
  ],
};

/// Descriptor for `DeleteSupplierRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSupplierRequestDescriptor = $convert.base64Decode('ChVEZWxldGVTdXBwbGllclJlcXVlc3QSHwoLc3VwcGxpZXJfaWQYASABKAlSCnN1cHBsaWVySWQ=');
@$core.Deprecated('Use deleteSupplierResponseDescriptor instead')
const DeleteSupplierResponse$json = const {
  '1': 'DeleteSupplierResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteSupplierResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteSupplierResponseDescriptor = $convert.base64Decode('ChZEZWxldGVTdXBwbGllclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use listSuppliersRequestDescriptor instead')
const ListSuppliersRequest$json = const {
  '1': 'ListSuppliersRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'search', '3': 3, '4': 1, '5': 9, '10': 'search'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.pb.SupplierStatus', '10': 'status'},
  ],
};

/// Descriptor for `ListSuppliersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSuppliersRequestDescriptor = $convert.base64Decode('ChRMaXN0U3VwcGxpZXJzUmVxdWVzdBISCgRwYWdlGAEgASgFUgRwYWdlEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZzZWFyY2gYAyABKAlSBnNlYXJjaBIqCgZzdGF0dXMYBCABKA4yEi5wYi5TdXBwbGllclN0YXR1c1IGc3RhdHVz');
@$core.Deprecated('Use listSuppliersResponseDescriptor instead')
const ListSuppliersResponse$json = const {
  '1': 'ListSuppliersResponse',
  '2': const [
    const {'1': 'suppliers', '3': 1, '4': 3, '5': 11, '6': '.pb.Supplier', '10': 'suppliers'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListSuppliersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSuppliersResponseDescriptor = $convert.base64Decode('ChVMaXN0U3VwcGxpZXJzUmVzcG9uc2USKgoJc3VwcGxpZXJzGAEgAygLMgwucGIuU3VwcGxpZXJSCXN1cHBsaWVycxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use createPurchaseOrderRequestDescriptor instead')
const CreatePurchaseOrderRequest$json = const {
  '1': 'CreatePurchaseOrderRequest',
  '2': const [
    const {'1': 'supplier_id', '3': 1, '4': 1, '5': 9, '10': 'supplierId'},
    const {'1': 'items', '3': 2, '4': 3, '5': 11, '6': '.pb.PurchaseOrderItem', '10': 'items'},
    const {'1': 'notes', '3': 3, '4': 1, '5': 9, '10': 'notes'},
    const {'1': 'expected_date', '3': 4, '4': 1, '5': 9, '10': 'expectedDate'},
  ],
};

/// Descriptor for `CreatePurchaseOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPurchaseOrderRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVQdXJjaGFzZU9yZGVyUmVxdWVzdBIfCgtzdXBwbGllcl9pZBgBIAEoCVIKc3VwcGxpZXJJZBIrCgVpdGVtcxgCIAMoCzIVLnBiLlB1cmNoYXNlT3JkZXJJdGVtUgVpdGVtcxIUCgVub3RlcxgDIAEoCVIFbm90ZXMSIwoNZXhwZWN0ZWRfZGF0ZRgEIAEoCVIMZXhwZWN0ZWREYXRl');
@$core.Deprecated('Use createPurchaseOrderResponseDescriptor instead')
const CreatePurchaseOrderResponse$json = const {
  '1': 'CreatePurchaseOrderResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'purchase_order', '3': 3, '4': 1, '5': 11, '6': '.pb.PurchaseOrder', '10': 'purchaseOrder'},
  ],
};

/// Descriptor for `CreatePurchaseOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createPurchaseOrderResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVQdXJjaGFzZU9yZGVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjgKDnB1cmNoYXNlX29yZGVyGAMgASgLMhEucGIuUHVyY2hhc2VPcmRlclINcHVyY2hhc2VPcmRlcg==');
@$core.Deprecated('Use getPurchaseOrderRequestDescriptor instead')
const GetPurchaseOrderRequest$json = const {
  '1': 'GetPurchaseOrderRequest',
  '2': const [
    const {'1': 'purchase_order_id', '3': 1, '4': 1, '5': 9, '10': 'purchaseOrderId'},
  ],
};

/// Descriptor for `GetPurchaseOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPurchaseOrderRequestDescriptor = $convert.base64Decode('ChdHZXRQdXJjaGFzZU9yZGVyUmVxdWVzdBIqChFwdXJjaGFzZV9vcmRlcl9pZBgBIAEoCVIPcHVyY2hhc2VPcmRlcklk');
@$core.Deprecated('Use getPurchaseOrderResponseDescriptor instead')
const GetPurchaseOrderResponse$json = const {
  '1': 'GetPurchaseOrderResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'purchase_order', '3': 3, '4': 1, '5': 11, '6': '.pb.PurchaseOrder', '10': 'purchaseOrder'},
  ],
};

/// Descriptor for `GetPurchaseOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPurchaseOrderResponseDescriptor = $convert.base64Decode('ChhHZXRQdXJjaGFzZU9yZGVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEjgKDnB1cmNoYXNlX29yZGVyGAMgASgLMhEucGIuUHVyY2hhc2VPcmRlclINcHVyY2hhc2VPcmRlcg==');
@$core.Deprecated('Use listPurchaseOrdersRequestDescriptor instead')
const ListPurchaseOrdersRequest$json = const {
  '1': 'ListPurchaseOrdersRequest',
  '2': const [
    const {'1': 'page', '3': 1, '4': 1, '5': 5, '10': 'page'},
    const {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.pb.PurchaseOrderStatus', '10': 'status'},
    const {'1': 'supplier_id', '3': 4, '4': 1, '5': 9, '10': 'supplierId'},
  ],
};

/// Descriptor for `ListPurchaseOrdersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPurchaseOrdersRequestDescriptor = $convert.base64Decode('ChlMaXN0UHVyY2hhc2VPcmRlcnNSZXF1ZXN0EhIKBHBhZ2UYASABKAVSBHBhZ2USFAoFbGltaXQYAiABKAVSBWxpbWl0Ei8KBnN0YXR1cxgDIAEoDjIXLnBiLlB1cmNoYXNlT3JkZXJTdGF0dXNSBnN0YXR1cxIfCgtzdXBwbGllcl9pZBgEIAEoCVIKc3VwcGxpZXJJZA==');
@$core.Deprecated('Use listPurchaseOrdersResponseDescriptor instead')
const ListPurchaseOrdersResponse$json = const {
  '1': 'ListPurchaseOrdersResponse',
  '2': const [
    const {'1': 'purchase_orders', '3': 1, '4': 3, '5': 11, '6': '.pb.PurchaseOrder', '10': 'purchaseOrders'},
    const {'1': 'pagination', '3': 2, '4': 1, '5': 11, '6': '.pb.PayrollPaginationInfo', '10': 'pagination'},
  ],
};

/// Descriptor for `ListPurchaseOrdersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPurchaseOrdersResponseDescriptor = $convert.base64Decode('ChpMaXN0UHVyY2hhc2VPcmRlcnNSZXNwb25zZRI6Cg9wdXJjaGFzZV9vcmRlcnMYASADKAsyES5wYi5QdXJjaGFzZU9yZGVyUg5wdXJjaGFzZU9yZGVycxI5CgpwYWdpbmF0aW9uGAIgASgLMhkucGIuUGF5cm9sbFBhZ2luYXRpb25JbmZvUgpwYWdpbmF0aW9u');
@$core.Deprecated('Use receivePurchaseOrderRequestDescriptor instead')
const ReceivePurchaseOrderRequest$json = const {
  '1': 'ReceivePurchaseOrderRequest',
  '2': const [
    const {'1': 'purchase_order_id', '3': 1, '4': 1, '5': 9, '10': 'purchaseOrderId'},
    const {'1': 'received_items', '3': 2, '4': 3, '5': 11, '6': '.pb.PurchaseOrderItem', '10': 'receivedItems'},
  ],
};

/// Descriptor for `ReceivePurchaseOrderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receivePurchaseOrderRequestDescriptor = $convert.base64Decode('ChtSZWNlaXZlUHVyY2hhc2VPcmRlclJlcXVlc3QSKgoRcHVyY2hhc2Vfb3JkZXJfaWQYASABKAlSD3B1cmNoYXNlT3JkZXJJZBI8Cg5yZWNlaXZlZF9pdGVtcxgCIAMoCzIVLnBiLlB1cmNoYXNlT3JkZXJJdGVtUg1yZWNlaXZlZEl0ZW1z');
@$core.Deprecated('Use receivePurchaseOrderResponseDescriptor instead')
const ReceivePurchaseOrderResponse$json = const {
  '1': 'ReceivePurchaseOrderResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'purchase_order', '3': 3, '4': 1, '5': 11, '6': '.pb.PurchaseOrder', '10': 'purchaseOrder'},
  ],
};

/// Descriptor for `ReceivePurchaseOrderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receivePurchaseOrderResponseDescriptor = $convert.base64Decode('ChxSZWNlaXZlUHVyY2hhc2VPcmRlclJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3MSGAoHbWVzc2FnZRgCIAEoCVIHbWVzc2FnZRI4Cg5wdXJjaGFzZV9vcmRlchgDIAEoCzIRLnBiLlB1cmNoYXNlT3JkZXJSDXB1cmNoYXNlT3JkZXI=');
@$core.Deprecated('Use getInventoryValuationRequestDescriptor instead')
const GetInventoryValuationRequest$json = const {
  '1': 'GetInventoryValuationRequest',
};

/// Descriptor for `GetInventoryValuationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventoryValuationRequestDescriptor = $convert.base64Decode('ChxHZXRJbnZlbnRvcnlWYWx1YXRpb25SZXF1ZXN0');
@$core.Deprecated('Use getInventoryValuationResponseDescriptor instead')
const GetInventoryValuationResponse$json = const {
  '1': 'GetInventoryValuationResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'valuation', '3': 3, '4': 1, '5': 11, '6': '.pb.InventoryValuation', '10': 'valuation'},
  ],
};

/// Descriptor for `GetInventoryValuationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInventoryValuationResponseDescriptor = $convert.base64Decode('Ch1HZXRJbnZlbnRvcnlWYWx1YXRpb25SZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USNAoJdmFsdWF0aW9uGAMgASgLMhYucGIuSW52ZW50b3J5VmFsdWF0aW9uUgl2YWx1YXRpb24=');
@$core.Deprecated('Use getExpiryAlertsRequestDescriptor instead')
const GetExpiryAlertsRequest$json = const {
  '1': 'GetExpiryAlertsRequest',
  '2': const [
    const {'1': 'days_ahead', '3': 1, '4': 1, '5': 5, '10': 'daysAhead'},
  ],
};

/// Descriptor for `GetExpiryAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpiryAlertsRequestDescriptor = $convert.base64Decode('ChZHZXRFeHBpcnlBbGVydHNSZXF1ZXN0Eh0KCmRheXNfYWhlYWQYASABKAVSCWRheXNBaGVhZA==');
@$core.Deprecated('Use getExpiryAlertsResponseDescriptor instead')
const GetExpiryAlertsResponse$json = const {
  '1': 'GetExpiryAlertsResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'alerts', '3': 3, '4': 3, '5': 11, '6': '.pb.ExpiryAlert', '10': 'alerts'},
  ],
};

/// Descriptor for `GetExpiryAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getExpiryAlertsResponseDescriptor = $convert.base64Decode('ChdHZXRFeHBpcnlBbGVydHNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USJwoGYWxlcnRzGAMgAygLMg8ucGIuRXhwaXJ5QWxlcnRSBmFsZXJ0cw==');
