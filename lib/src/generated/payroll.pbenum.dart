///
//  Generated code. Do not modify.
//  source: payroll.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class EmploymentType extends $pb.ProtobufEnum {
  static const EmploymentType EMPLOYMENT_TYPE_FULL_TIME = EmploymentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMPLOYMENT_TYPE_FULL_TIME');
  static const EmploymentType EMPLOYMENT_TYPE_PART_TIME = EmploymentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMPLOYMENT_TYPE_PART_TIME');
  static const EmploymentType EMPLOYMENT_TYPE_CONTRACT = EmploymentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMPLOYMENT_TYPE_CONTRACT');

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
  static const PayFrequency PAY_FREQUENCY_MONTHLY = PayFrequency._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_FREQUENCY_MONTHLY');
  static const PayFrequency PAY_FREQUENCY_BIWEEKLY = PayFrequency._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_FREQUENCY_BIWEEKLY');
  static const PayFrequency PAY_FREQUENCY_WEEKLY = PayFrequency._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_FREQUENCY_WEEKLY');

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
  static const EmployeeStatus EMPLOYEE_STATUS_ACTIVE = EmployeeStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMPLOYEE_STATUS_ACTIVE');
  static const EmployeeStatus EMPLOYEE_STATUS_INACTIVE = EmployeeStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMPLOYEE_STATUS_INACTIVE');
  static const EmployeeStatus EMPLOYEE_STATUS_TERMINATED = EmployeeStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMPLOYEE_STATUS_TERMINATED');

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
  static const PayRunStatus PAY_RUN_STATUS_DRAFT = PayRunStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_DRAFT');
  static const PayRunStatus PAY_RUN_STATUS_CALCULATING = PayRunStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_CALCULATING');
  static const PayRunStatus PAY_RUN_STATUS_READY = PayRunStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_READY');
  static const PayRunStatus PAY_RUN_STATUS_APPROVED = PayRunStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_APPROVED');
  static const PayRunStatus PAY_RUN_STATUS_PROCESSING = PayRunStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_PROCESSING');
  static const PayRunStatus PAY_RUN_STATUS_COMPLETED = PayRunStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_COMPLETED');
  static const PayRunStatus PAY_RUN_STATUS_FAILED = PayRunStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAY_RUN_STATUS_FAILED');

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
  static const PaymentStatus PAYMENT_STATUS_PENDING = PaymentStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_STATUS_PENDING');
  static const PaymentStatus PAYMENT_STATUS_PAID = PaymentStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_STATUS_PAID');
  static const PaymentStatus PAYMENT_STATUS_FAILED = PaymentStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PAYMENT_STATUS_FAILED');

  static const $core.List<PaymentStatus> values = <PaymentStatus> [
    PAYMENT_STATUS_PENDING,
    PAYMENT_STATUS_PAID,
    PAYMENT_STATUS_FAILED,
  ];

  static final $core.Map<$core.int, PaymentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentStatus? valueOf($core.int value) => _byValue[value];

  const PaymentStatus._($core.int v, $core.String n) : super(v, n);
}

class RecurrenceFrequency extends $pb.ProtobufEnum {
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_NONE = RecurrenceFrequency._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRENCE_FREQUENCY_NONE');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_WEEKLY = RecurrenceFrequency._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRENCE_FREQUENCY_WEEKLY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_BIWEEKLY = RecurrenceFrequency._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRENCE_FREQUENCY_BIWEEKLY');
  static const RecurrenceFrequency RECURRENCE_FREQUENCY_MONTHLY = RecurrenceFrequency._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRENCE_FREQUENCY_MONTHLY');

  static const $core.List<RecurrenceFrequency> values = <RecurrenceFrequency> [
    RECURRENCE_FREQUENCY_NONE,
    RECURRENCE_FREQUENCY_WEEKLY,
    RECURRENCE_FREQUENCY_BIWEEKLY,
    RECURRENCE_FREQUENCY_MONTHLY,
  ];

  static final $core.Map<$core.int, RecurrenceFrequency> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RecurrenceFrequency? valueOf($core.int value) => _byValue[value];

  const RecurrenceFrequency._($core.int v, $core.String n) : super(v, n);
}

class InventoryItemStatus extends $pb.ProtobufEnum {
  static const InventoryItemStatus INVENTORY_ITEM_STATUS_ACTIVE = InventoryItemStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVENTORY_ITEM_STATUS_ACTIVE');
  static const InventoryItemStatus INVENTORY_ITEM_STATUS_INACTIVE = InventoryItemStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVENTORY_ITEM_STATUS_INACTIVE');
  static const InventoryItemStatus INVENTORY_ITEM_STATUS_DISCONTINUED = InventoryItemStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INVENTORY_ITEM_STATUS_DISCONTINUED');

  static const $core.List<InventoryItemStatus> values = <InventoryItemStatus> [
    INVENTORY_ITEM_STATUS_ACTIVE,
    INVENTORY_ITEM_STATUS_INACTIVE,
    INVENTORY_ITEM_STATUS_DISCONTINUED,
  ];

  static final $core.Map<$core.int, InventoryItemStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InventoryItemStatus? valueOf($core.int value) => _byValue[value];

  const InventoryItemStatus._($core.int v, $core.String n) : super(v, n);
}

class AdjustmentType extends $pb.ProtobufEnum {
  static const AdjustmentType ADJUSTMENT_TYPE_ADD = AdjustmentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADJUSTMENT_TYPE_ADD');
  static const AdjustmentType ADJUSTMENT_TYPE_REMOVE = AdjustmentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADJUSTMENT_TYPE_REMOVE');
  static const AdjustmentType ADJUSTMENT_TYPE_SET = AdjustmentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADJUSTMENT_TYPE_SET');

  static const $core.List<AdjustmentType> values = <AdjustmentType> [
    ADJUSTMENT_TYPE_ADD,
    ADJUSTMENT_TYPE_REMOVE,
    ADJUSTMENT_TYPE_SET,
  ];

  static final $core.Map<$core.int, AdjustmentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AdjustmentType? valueOf($core.int value) => _byValue[value];

  const AdjustmentType._($core.int v, $core.String n) : super(v, n);
}

class CustomerSegment extends $pb.ProtobufEnum {
  static const CustomerSegment CUSTOMER_SEGMENT_NONE = CustomerSegment._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_SEGMENT_NONE');
  static const CustomerSegment CUSTOMER_SEGMENT_VIP = CustomerSegment._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_SEGMENT_VIP');
  static const CustomerSegment CUSTOMER_SEGMENT_RETAIL = CustomerSegment._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_SEGMENT_RETAIL');
  static const CustomerSegment CUSTOMER_SEGMENT_WHOLESALE = CustomerSegment._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_SEGMENT_WHOLESALE');
  static const CustomerSegment CUSTOMER_SEGMENT_GOVERNMENT = CustomerSegment._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_SEGMENT_GOVERNMENT');
  static const CustomerSegment CUSTOMER_SEGMENT_OVERDUE = CustomerSegment._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_SEGMENT_OVERDUE');

  static const $core.List<CustomerSegment> values = <CustomerSegment> [
    CUSTOMER_SEGMENT_NONE,
    CUSTOMER_SEGMENT_VIP,
    CUSTOMER_SEGMENT_RETAIL,
    CUSTOMER_SEGMENT_WHOLESALE,
    CUSTOMER_SEGMENT_GOVERNMENT,
    CUSTOMER_SEGMENT_OVERDUE,
  ];

  static final $core.Map<$core.int, CustomerSegment> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CustomerSegment? valueOf($core.int value) => _byValue[value];

  const CustomerSegment._($core.int v, $core.String n) : super(v, n);
}

class CustomerStatus extends $pb.ProtobufEnum {
  static const CustomerStatus CUSTOMER_STATUS_ACTIVE = CustomerStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_STATUS_ACTIVE');
  static const CustomerStatus CUSTOMER_STATUS_INACTIVE = CustomerStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_STATUS_INACTIVE');
  static const CustomerStatus CUSTOMER_STATUS_BLOCKED = CustomerStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CUSTOMER_STATUS_BLOCKED');

  static const $core.List<CustomerStatus> values = <CustomerStatus> [
    CUSTOMER_STATUS_ACTIVE,
    CUSTOMER_STATUS_INACTIVE,
    CUSTOMER_STATUS_BLOCKED,
  ];

  static final $core.Map<$core.int, CustomerStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CustomerStatus? valueOf($core.int value) => _byValue[value];

  const CustomerStatus._($core.int v, $core.String n) : super(v, n);
}

class TaxType extends $pb.ProtobufEnum {
  static const TaxType TAX_TYPE_VAT = TaxType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_TYPE_VAT');
  static const TaxType TAX_TYPE_PAYE = TaxType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_TYPE_PAYE');
  static const TaxType TAX_TYPE_WHT = TaxType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_TYPE_WHT');
  static const TaxType TAX_TYPE_CIT = TaxType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_TYPE_CIT');

  static const $core.List<TaxType> values = <TaxType> [
    TAX_TYPE_VAT,
    TAX_TYPE_PAYE,
    TAX_TYPE_WHT,
    TAX_TYPE_CIT,
  ];

  static final $core.Map<$core.int, TaxType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TaxType? valueOf($core.int value) => _byValue[value];

  const TaxType._($core.int v, $core.String n) : super(v, n);
}

class TaxObligationStatus extends $pb.ProtobufEnum {
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_PENDING = TaxObligationStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_OBLIGATION_STATUS_PENDING');
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_FILED = TaxObligationStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_OBLIGATION_STATUS_FILED');
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_PAID = TaxObligationStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_OBLIGATION_STATUS_PAID');
  static const TaxObligationStatus TAX_OBLIGATION_STATUS_OVERDUE = TaxObligationStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_OBLIGATION_STATUS_OVERDUE');

  static const $core.List<TaxObligationStatus> values = <TaxObligationStatus> [
    TAX_OBLIGATION_STATUS_PENDING,
    TAX_OBLIGATION_STATUS_FILED,
    TAX_OBLIGATION_STATUS_PAID,
    TAX_OBLIGATION_STATUS_OVERDUE,
  ];

  static final $core.Map<$core.int, TaxObligationStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TaxObligationStatus? valueOf($core.int value) => _byValue[value];

  const TaxObligationStatus._($core.int v, $core.String n) : super(v, n);
}

class TaxDocumentType extends $pb.ProtobufEnum {
  static const TaxDocumentType TAX_DOCUMENT_TYPE_TIN_CERT = TaxDocumentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_DOCUMENT_TYPE_TIN_CERT');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_VAT_REGISTRATION = TaxDocumentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_DOCUMENT_TYPE_VAT_REGISTRATION');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_TAX_CLEARANCE = TaxDocumentType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_DOCUMENT_TYPE_TAX_CLEARANCE');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_WHT_RECEIPT = TaxDocumentType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_DOCUMENT_TYPE_WHT_RECEIPT');
  static const TaxDocumentType TAX_DOCUMENT_TYPE_FILING_RECEIPT = TaxDocumentType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TAX_DOCUMENT_TYPE_FILING_RECEIPT');

  static const $core.List<TaxDocumentType> values = <TaxDocumentType> [
    TAX_DOCUMENT_TYPE_TIN_CERT,
    TAX_DOCUMENT_TYPE_VAT_REGISTRATION,
    TAX_DOCUMENT_TYPE_TAX_CLEARANCE,
    TAX_DOCUMENT_TYPE_WHT_RECEIPT,
    TAX_DOCUMENT_TYPE_FILING_RECEIPT,
  ];

  static final $core.Map<$core.int, TaxDocumentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TaxDocumentType? valueOf($core.int value) => _byValue[value];

  const TaxDocumentType._($core.int v, $core.String n) : super(v, n);
}

class VATDirection extends $pb.ProtobufEnum {
  static const VATDirection VAT_DIRECTION_OUTPUT = VATDirection._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VAT_DIRECTION_OUTPUT');
  static const VATDirection VAT_DIRECTION_INPUT = VATDirection._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VAT_DIRECTION_INPUT');

  static const $core.List<VATDirection> values = <VATDirection> [
    VAT_DIRECTION_OUTPUT,
    VAT_DIRECTION_INPUT,
  ];

  static final $core.Map<$core.int, VATDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VATDirection? valueOf($core.int value) => _byValue[value];

  const VATDirection._($core.int v, $core.String n) : super(v, n);
}

class PurchaseOrderStatus extends $pb.ProtobufEnum {
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_DRAFT = PurchaseOrderStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PURCHASE_ORDER_STATUS_DRAFT');
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_SUBMITTED = PurchaseOrderStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PURCHASE_ORDER_STATUS_SUBMITTED');
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_RECEIVED = PurchaseOrderStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PURCHASE_ORDER_STATUS_RECEIVED');
  static const PurchaseOrderStatus PURCHASE_ORDER_STATUS_CANCELLED = PurchaseOrderStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PURCHASE_ORDER_STATUS_CANCELLED');

  static const $core.List<PurchaseOrderStatus> values = <PurchaseOrderStatus> [
    PURCHASE_ORDER_STATUS_DRAFT,
    PURCHASE_ORDER_STATUS_SUBMITTED,
    PURCHASE_ORDER_STATUS_RECEIVED,
    PURCHASE_ORDER_STATUS_CANCELLED,
  ];

  static final $core.Map<$core.int, PurchaseOrderStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PurchaseOrderStatus? valueOf($core.int value) => _byValue[value];

  const PurchaseOrderStatus._($core.int v, $core.String n) : super(v, n);
}

class SupplierStatus extends $pb.ProtobufEnum {
  static const SupplierStatus SUPPLIER_STATUS_ACTIVE = SupplierStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUPPLIER_STATUS_ACTIVE');
  static const SupplierStatus SUPPLIER_STATUS_INACTIVE = SupplierStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUPPLIER_STATUS_INACTIVE');

  static const $core.List<SupplierStatus> values = <SupplierStatus> [
    SUPPLIER_STATUS_ACTIVE,
    SUPPLIER_STATUS_INACTIVE,
  ];

  static final $core.Map<$core.int, SupplierStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SupplierStatus? valueOf($core.int value) => _byValue[value];

  const SupplierStatus._($core.int v, $core.String n) : super(v, n);
}

class ExpenseCategory extends $pb.ProtobufEnum {
  static const ExpenseCategory EXPENSE_CATEGORY_OFFICE = ExpenseCategory._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_OFFICE');
  static const ExpenseCategory EXPENSE_CATEGORY_TRAVEL = ExpenseCategory._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_TRAVEL');
  static const ExpenseCategory EXPENSE_CATEGORY_MEALS = ExpenseCategory._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_MEALS');
  static const ExpenseCategory EXPENSE_CATEGORY_MARKETING = ExpenseCategory._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_MARKETING');
  static const ExpenseCategory EXPENSE_CATEGORY_UTILITIES = ExpenseCategory._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_UTILITIES');
  static const ExpenseCategory EXPENSE_CATEGORY_PAYROLL = ExpenseCategory._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_PAYROLL');
  static const ExpenseCategory EXPENSE_CATEGORY_PROFESSIONAL = ExpenseCategory._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_PROFESSIONAL');
  static const ExpenseCategory EXPENSE_CATEGORY_SOFTWARE = ExpenseCategory._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_SOFTWARE');
  static const ExpenseCategory EXPENSE_CATEGORY_INVENTORY = ExpenseCategory._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_INVENTORY');
  static const ExpenseCategory EXPENSE_CATEGORY_TAXES = ExpenseCategory._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_TAXES');
  static const ExpenseCategory EXPENSE_CATEGORY_OTHER = ExpenseCategory._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_CATEGORY_OTHER');

  static const $core.List<ExpenseCategory> values = <ExpenseCategory> [
    EXPENSE_CATEGORY_OFFICE,
    EXPENSE_CATEGORY_TRAVEL,
    EXPENSE_CATEGORY_MEALS,
    EXPENSE_CATEGORY_MARKETING,
    EXPENSE_CATEGORY_UTILITIES,
    EXPENSE_CATEGORY_PAYROLL,
    EXPENSE_CATEGORY_PROFESSIONAL,
    EXPENSE_CATEGORY_SOFTWARE,
    EXPENSE_CATEGORY_INVENTORY,
    EXPENSE_CATEGORY_TAXES,
    EXPENSE_CATEGORY_OTHER,
  ];

  static final $core.Map<$core.int, ExpenseCategory> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExpenseCategory? valueOf($core.int value) => _byValue[value];

  const ExpenseCategory._($core.int v, $core.String n) : super(v, n);
}

class ExpenseStatus extends $pb.ProtobufEnum {
  static const ExpenseStatus EXPENSE_STATUS_PENDING = ExpenseStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_STATUS_PENDING');
  static const ExpenseStatus EXPENSE_STATUS_APPROVED = ExpenseStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_STATUS_APPROVED');
  static const ExpenseStatus EXPENSE_STATUS_REIMBURSED = ExpenseStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_STATUS_REIMBURSED');
  static const ExpenseStatus EXPENSE_STATUS_REJECTED = ExpenseStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_STATUS_REJECTED');

  static const $core.List<ExpenseStatus> values = <ExpenseStatus> [
    EXPENSE_STATUS_PENDING,
    EXPENSE_STATUS_APPROVED,
    EXPENSE_STATUS_REIMBURSED,
    EXPENSE_STATUS_REJECTED,
  ];

  static final $core.Map<$core.int, ExpenseStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExpenseStatus? valueOf($core.int value) => _byValue[value];

  const ExpenseStatus._($core.int v, $core.String n) : super(v, n);
}

class ExpensePaymentMethod extends $pb.ProtobufEnum {
  static const ExpensePaymentMethod EXPENSE_PAYMENT_METHOD_CASH = ExpensePaymentMethod._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_PAYMENT_METHOD_CASH');
  static const ExpensePaymentMethod EXPENSE_PAYMENT_METHOD_CARD = ExpensePaymentMethod._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_PAYMENT_METHOD_CARD');
  static const ExpensePaymentMethod EXPENSE_PAYMENT_METHOD_BANK_TRANSFER = ExpensePaymentMethod._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_PAYMENT_METHOD_BANK_TRANSFER');
  static const ExpensePaymentMethod EXPENSE_PAYMENT_METHOD_CHEQUE = ExpensePaymentMethod._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_PAYMENT_METHOD_CHEQUE');
  static const ExpensePaymentMethod EXPENSE_PAYMENT_METHOD_OTHER = ExpensePaymentMethod._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EXPENSE_PAYMENT_METHOD_OTHER');

  static const $core.List<ExpensePaymentMethod> values = <ExpensePaymentMethod> [
    EXPENSE_PAYMENT_METHOD_CASH,
    EXPENSE_PAYMENT_METHOD_CARD,
    EXPENSE_PAYMENT_METHOD_BANK_TRANSFER,
    EXPENSE_PAYMENT_METHOD_CHEQUE,
    EXPENSE_PAYMENT_METHOD_OTHER,
  ];

  static final $core.Map<$core.int, ExpensePaymentMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExpensePaymentMethod? valueOf($core.int value) => _byValue[value];

  const ExpensePaymentMethod._($core.int v, $core.String n) : super(v, n);
}

