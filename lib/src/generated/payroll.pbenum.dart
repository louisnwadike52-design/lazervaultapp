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

import 'package:protobuf/protobuf.dart' as $pb;

class EmploymentType extends $pb.ProtobufEnum {
  static const EmploymentType EMPLOYMENT_TYPE_FULL_TIME =
      EmploymentType._(0, _omitEnumNames ? '' : 'EMPLOYMENT_TYPE_FULL_TIME');
  static const EmploymentType EMPLOYMENT_TYPE_PART_TIME =
      EmploymentType._(1, _omitEnumNames ? '' : 'EMPLOYMENT_TYPE_PART_TIME');
  static const EmploymentType EMPLOYMENT_TYPE_CONTRACT =
      EmploymentType._(2, _omitEnumNames ? '' : 'EMPLOYMENT_TYPE_CONTRACT');

  static const $core.List<EmploymentType> values = <EmploymentType>[
    EMPLOYMENT_TYPE_FULL_TIME,
    EMPLOYMENT_TYPE_PART_TIME,
    EMPLOYMENT_TYPE_CONTRACT,
  ];

  static final $core.List<EmploymentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static EmploymentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EmploymentType._(super.value, super.name);
}

class PayFrequency extends $pb.ProtobufEnum {
  static const PayFrequency PAY_FREQUENCY_MONTHLY =
      PayFrequency._(0, _omitEnumNames ? '' : 'PAY_FREQUENCY_MONTHLY');
  static const PayFrequency PAY_FREQUENCY_BIWEEKLY =
      PayFrequency._(1, _omitEnumNames ? '' : 'PAY_FREQUENCY_BIWEEKLY');
  static const PayFrequency PAY_FREQUENCY_WEEKLY =
      PayFrequency._(2, _omitEnumNames ? '' : 'PAY_FREQUENCY_WEEKLY');

  static const $core.List<PayFrequency> values = <PayFrequency>[
    PAY_FREQUENCY_MONTHLY,
    PAY_FREQUENCY_BIWEEKLY,
    PAY_FREQUENCY_WEEKLY,
  ];

  static final $core.List<PayFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static PayFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PayFrequency._(super.value, super.name);
}

class EmployeeStatus extends $pb.ProtobufEnum {
  static const EmployeeStatus EMPLOYEE_STATUS_ACTIVE =
      EmployeeStatus._(0, _omitEnumNames ? '' : 'EMPLOYEE_STATUS_ACTIVE');
  static const EmployeeStatus EMPLOYEE_STATUS_INACTIVE =
      EmployeeStatus._(1, _omitEnumNames ? '' : 'EMPLOYEE_STATUS_INACTIVE');
  static const EmployeeStatus EMPLOYEE_STATUS_TERMINATED =
      EmployeeStatus._(2, _omitEnumNames ? '' : 'EMPLOYEE_STATUS_TERMINATED');

  static const $core.List<EmployeeStatus> values = <EmployeeStatus>[
    EMPLOYEE_STATUS_ACTIVE,
    EMPLOYEE_STATUS_INACTIVE,
    EMPLOYEE_STATUS_TERMINATED,
  ];

  static final $core.List<EmployeeStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static EmployeeStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EmployeeStatus._(super.value, super.name);
}

class PayRunStatus extends $pb.ProtobufEnum {
  static const PayRunStatus PAY_RUN_STATUS_DRAFT =
      PayRunStatus._(0, _omitEnumNames ? '' : 'PAY_RUN_STATUS_DRAFT');
  static const PayRunStatus PAY_RUN_STATUS_CALCULATING =
      PayRunStatus._(1, _omitEnumNames ? '' : 'PAY_RUN_STATUS_CALCULATING');
  static const PayRunStatus PAY_RUN_STATUS_READY =
      PayRunStatus._(2, _omitEnumNames ? '' : 'PAY_RUN_STATUS_READY');
  static const PayRunStatus PAY_RUN_STATUS_APPROVED =
      PayRunStatus._(3, _omitEnumNames ? '' : 'PAY_RUN_STATUS_APPROVED');
  static const PayRunStatus PAY_RUN_STATUS_PROCESSING =
      PayRunStatus._(4, _omitEnumNames ? '' : 'PAY_RUN_STATUS_PROCESSING');
  static const PayRunStatus PAY_RUN_STATUS_COMPLETED =
      PayRunStatus._(5, _omitEnumNames ? '' : 'PAY_RUN_STATUS_COMPLETED');
  static const PayRunStatus PAY_RUN_STATUS_FAILED =
      PayRunStatus._(6, _omitEnumNames ? '' : 'PAY_RUN_STATUS_FAILED');

  static const $core.List<PayRunStatus> values = <PayRunStatus>[
    PAY_RUN_STATUS_DRAFT,
    PAY_RUN_STATUS_CALCULATING,
    PAY_RUN_STATUS_READY,
    PAY_RUN_STATUS_APPROVED,
    PAY_RUN_STATUS_PROCESSING,
    PAY_RUN_STATUS_COMPLETED,
    PAY_RUN_STATUS_FAILED,
  ];

  static final $core.List<PayRunStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static PayRunStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PayRunStatus._(super.value, super.name);
}

class PaymentStatus extends $pb.ProtobufEnum {
  static const PaymentStatus PAYMENT_STATUS_PENDING =
      PaymentStatus._(0, _omitEnumNames ? '' : 'PAYMENT_STATUS_PENDING');
  static const PaymentStatus PAYMENT_STATUS_PAID =
      PaymentStatus._(1, _omitEnumNames ? '' : 'PAYMENT_STATUS_PAID');
  static const PaymentStatus PAYMENT_STATUS_FAILED =
      PaymentStatus._(2, _omitEnumNames ? '' : 'PAYMENT_STATUS_FAILED');

  static const $core.List<PaymentStatus> values = <PaymentStatus>[
    PAYMENT_STATUS_PENDING,
    PAYMENT_STATUS_PAID,
    PAYMENT_STATUS_FAILED,
  ];

  static final $core.List<PaymentStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static PaymentStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PaymentStatus._(super.value, super.name);
}

class RecurrenceFrequency extends $pb.ProtobufEnum {
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_NONE =
      RecurrenceFrequency._(
          0, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_NONE');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_WEEKLY =
      RecurrenceFrequency._(
          1, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_WEEKLY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_BIWEEKLY =
      RecurrenceFrequency._(
          2, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_BIWEEKLY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_MONTHLY =
      RecurrenceFrequency._(
          3, _omitEnumNames ? '' : 'RECURRENCE_FREQUENCY_MONTHLY');

  static const $core.List<RecurrenceFrequency> values = <RecurrenceFrequency>[
    RECURRENCE_FREQUENCY_NONE,
    RECURRENCE_FREQUENCY_WEEKLY,
    RECURRENCE_FREQUENCY_BIWEEKLY,
    RECURRENCE_FREQUENCY_MONTHLY,
  ];

  static final $core.List<RecurrenceFrequency?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RecurrenceFrequency? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RecurrenceFrequency._(super.value, super.name);
}

class InventoryItemStatus extends $pb.ProtobufEnum {
  static const InventoryItemStatus INVENTORY_ITEM_STATUS_ACTIVE =
      InventoryItemStatus._(
          0, _omitEnumNames ? '' : 'INVENTORY_ITEM_STATUS_ACTIVE');
  static const InventoryItemStatus INVENTORY_ITEM_STATUS_INACTIVE =
      InventoryItemStatus._(
          1, _omitEnumNames ? '' : 'INVENTORY_ITEM_STATUS_INACTIVE');
  static const InventoryItemStatus INVENTORY_ITEM_STATUS_DISCONTINUED =
      InventoryItemStatus._(
          2, _omitEnumNames ? '' : 'INVENTORY_ITEM_STATUS_DISCONTINUED');

  static const $core.List<InventoryItemStatus> values = <InventoryItemStatus>[
    INVENTORY_ITEM_STATUS_ACTIVE,
    INVENTORY_ITEM_STATUS_INACTIVE,
    INVENTORY_ITEM_STATUS_DISCONTINUED,
  ];

  static final $core.List<InventoryItemStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static InventoryItemStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const InventoryItemStatus._(super.value, super.name);
}

class AdjustmentType extends $pb.ProtobufEnum {
  static const AdjustmentType ADJUSTMENT_TYPE_ADD =
      AdjustmentType._(0, _omitEnumNames ? '' : 'ADJUSTMENT_TYPE_ADD');
  static const AdjustmentType ADJUSTMENT_TYPE_REMOVE =
      AdjustmentType._(1, _omitEnumNames ? '' : 'ADJUSTMENT_TYPE_REMOVE');
  static const AdjustmentType ADJUSTMENT_TYPE_SET =
      AdjustmentType._(2, _omitEnumNames ? '' : 'ADJUSTMENT_TYPE_SET');

  static const $core.List<AdjustmentType> values = <AdjustmentType>[
    ADJUSTMENT_TYPE_ADD,
    ADJUSTMENT_TYPE_REMOVE,
    ADJUSTMENT_TYPE_SET,
  ];

  static final $core.List<AdjustmentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AdjustmentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AdjustmentType._(super.value, super.name);
}

/// Customer enums
class CustomerSegment extends $pb.ProtobufEnum {
  static const CustomerSegment CUSTOMER_SEGMENT_NONE =
      CustomerSegment._(0, _omitEnumNames ? '' : 'CUSTOMER_SEGMENT_NONE');
  static const CustomerSegment CUSTOMER_SEGMENT_VIP =
      CustomerSegment._(1, _omitEnumNames ? '' : 'CUSTOMER_SEGMENT_VIP');
  static const CustomerSegment CUSTOMER_SEGMENT_RETAIL =
      CustomerSegment._(2, _omitEnumNames ? '' : 'CUSTOMER_SEGMENT_RETAIL');
  static const CustomerSegment CUSTOMER_SEGMENT_WHOLESALE =
      CustomerSegment._(3, _omitEnumNames ? '' : 'CUSTOMER_SEGMENT_WHOLESALE');
  static const CustomerSegment CUSTOMER_SEGMENT_GOVERNMENT =
      CustomerSegment._(4, _omitEnumNames ? '' : 'CUSTOMER_SEGMENT_GOVERNMENT');
  static const CustomerSegment CUSTOMER_SEGMENT_OVERDUE =
      CustomerSegment._(5, _omitEnumNames ? '' : 'CUSTOMER_SEGMENT_OVERDUE');

  static const $core.List<CustomerSegment> values = <CustomerSegment>[
    CUSTOMER_SEGMENT_NONE,
    CUSTOMER_SEGMENT_VIP,
    CUSTOMER_SEGMENT_RETAIL,
    CUSTOMER_SEGMENT_WHOLESALE,
    CUSTOMER_SEGMENT_GOVERNMENT,
    CUSTOMER_SEGMENT_OVERDUE,
  ];

  static final $core.List<CustomerSegment?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static CustomerSegment? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CustomerSegment._(super.value, super.name);
}

class CustomerStatus extends $pb.ProtobufEnum {
  static const CustomerStatus CUSTOMER_STATUS_ACTIVE =
      CustomerStatus._(0, _omitEnumNames ? '' : 'CUSTOMER_STATUS_ACTIVE');
  static const CustomerStatus CUSTOMER_STATUS_INACTIVE =
      CustomerStatus._(1, _omitEnumNames ? '' : 'CUSTOMER_STATUS_INACTIVE');
  static const CustomerStatus CUSTOMER_STATUS_BLOCKED =
      CustomerStatus._(2, _omitEnumNames ? '' : 'CUSTOMER_STATUS_BLOCKED');

  static const $core.List<CustomerStatus> values = <CustomerStatus>[
    CUSTOMER_STATUS_ACTIVE,
    CUSTOMER_STATUS_INACTIVE,
    CUSTOMER_STATUS_BLOCKED,
  ];

  static final $core.List<CustomerStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CustomerStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CustomerStatus._(super.value, super.name);
}

/// Tax enums
class TaxType extends $pb.ProtobufEnum {
  static const TaxType TAX_TYPE_VAT =
      TaxType._(0, _omitEnumNames ? '' : 'TAX_TYPE_VAT');
  static const TaxType TAX_TYPE_PAYE =
      TaxType._(1, _omitEnumNames ? '' : 'TAX_TYPE_PAYE');
  static const TaxType TAX_TYPE_WHT =
      TaxType._(2, _omitEnumNames ? '' : 'TAX_TYPE_WHT');
  static const TaxType TAX_TYPE_CIT =
      TaxType._(3, _omitEnumNames ? '' : 'TAX_TYPE_CIT');

  static const $core.List<TaxType> values = <TaxType>[
    TAX_TYPE_VAT,
    TAX_TYPE_PAYE,
    TAX_TYPE_WHT,
    TAX_TYPE_CIT,
  ];

  static final $core.List<TaxType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TaxType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TaxType._(super.value, super.name);
}

class TaxObligationStatus extends $pb.ProtobufEnum {
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_PENDING =
      TaxObligationStatus._(
          0, _omitEnumNames ? '' : 'TAX_OBLIGATION_STATUS_PENDING');
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_FILED =
      TaxObligationStatus._(
          1, _omitEnumNames ? '' : 'TAX_OBLIGATION_STATUS_FILED');
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_PAID =
      TaxObligationStatus._(
          2, _omitEnumNames ? '' : 'TAX_OBLIGATION_STATUS_PAID');
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_OVERDUE =
      TaxObligationStatus._(
          3, _omitEnumNames ? '' : 'TAX_OBLIGATION_STATUS_OVERDUE');

  static const $core.List<TaxObligationStatus> values = <TaxObligationStatus>[
    TAX_OBLIGATION_STATUS_PENDING,
    TAX_OBLIGATION_STATUS_FILED,
    TAX_OBLIGATION_STATUS_PAID,
    TAX_OBLIGATION_STATUS_OVERDUE,
  ];

  static final $core.List<TaxObligationStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TaxObligationStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TaxObligationStatus._(super.value, super.name);
}

class TaxDocumentType extends $pb.ProtobufEnum {
  static const TaxDocumentType TAX_DOCUMENT_TYPE_TIN_CERT =
      TaxDocumentType._(0, _omitEnumNames ? '' : 'TAX_DOCUMENT_TYPE_TIN_CERT');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_VAT_REGISTRATION =
      TaxDocumentType._(
          1, _omitEnumNames ? '' : 'TAX_DOCUMENT_TYPE_VAT_REGISTRATION');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_TAX_CLEARANCE =
      TaxDocumentType._(
          2, _omitEnumNames ? '' : 'TAX_DOCUMENT_TYPE_TAX_CLEARANCE');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_WHT_RECEIPT =
      TaxDocumentType._(
          3, _omitEnumNames ? '' : 'TAX_DOCUMENT_TYPE_WHT_RECEIPT');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_FILING_RECEIPT =
      TaxDocumentType._(
          4, _omitEnumNames ? '' : 'TAX_DOCUMENT_TYPE_FILING_RECEIPT');

  static const $core.List<TaxDocumentType> values = <TaxDocumentType>[
    TAX_DOCUMENT_TYPE_TIN_CERT,
    TAX_DOCUMENT_TYPE_VAT_REGISTRATION,
    TAX_DOCUMENT_TYPE_TAX_CLEARANCE,
    TAX_DOCUMENT_TYPE_WHT_RECEIPT,
    TAX_DOCUMENT_TYPE_FILING_RECEIPT,
  ];

  static final $core.List<TaxDocumentType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static TaxDocumentType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TaxDocumentType._(super.value, super.name);
}

class VATDirection extends $pb.ProtobufEnum {
  static const VATDirection VAT_DIRECTION_OUTPUT =
      VATDirection._(0, _omitEnumNames ? '' : 'VAT_DIRECTION_OUTPUT');
  static const VATDirection VAT_DIRECTION_INPUT =
      VATDirection._(1, _omitEnumNames ? '' : 'VAT_DIRECTION_INPUT');

  static const $core.List<VATDirection> values = <VATDirection>[
    VAT_DIRECTION_OUTPUT,
    VAT_DIRECTION_INPUT,
  ];

  static final $core.List<VATDirection?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static VATDirection? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VATDirection._(super.value, super.name);
}

/// Inventory enhancement enums
class PurchaseOrderStatus extends $pb.ProtobufEnum {
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_DRAFT =
      PurchaseOrderStatus._(
          0, _omitEnumNames ? '' : 'PURCHASE_ORDER_STATUS_DRAFT');
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_SUBMITTED =
      PurchaseOrderStatus._(
          1, _omitEnumNames ? '' : 'PURCHASE_ORDER_STATUS_SUBMITTED');
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_RECEIVED =
      PurchaseOrderStatus._(
          2, _omitEnumNames ? '' : 'PURCHASE_ORDER_STATUS_RECEIVED');
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_CANCELLED =
      PurchaseOrderStatus._(
          3, _omitEnumNames ? '' : 'PURCHASE_ORDER_STATUS_CANCELLED');

  static const $core.List<PurchaseOrderStatus> values = <PurchaseOrderStatus>[
    PURCHASE_ORDER_STATUS_DRAFT,
    PURCHASE_ORDER_STATUS_SUBMITTED,
    PURCHASE_ORDER_STATUS_RECEIVED,
    PURCHASE_ORDER_STATUS_CANCELLED,
  ];

  static final $core.List<PurchaseOrderStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static PurchaseOrderStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PurchaseOrderStatus._(super.value, super.name);
}

class SupplierStatus extends $pb.ProtobufEnum {
  static const SupplierStatus SUPPLIER_STATUS_ACTIVE =
      SupplierStatus._(0, _omitEnumNames ? '' : 'SUPPLIER_STATUS_ACTIVE');
  static const SupplierStatus SUPPLIER_STATUS_INACTIVE =
      SupplierStatus._(1, _omitEnumNames ? '' : 'SUPPLIER_STATUS_INACTIVE');

  static const $core.List<SupplierStatus> values = <SupplierStatus>[
    SUPPLIER_STATUS_ACTIVE,
    SUPPLIER_STATUS_INACTIVE,
  ];

  static final $core.List<SupplierStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static SupplierStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SupplierStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
