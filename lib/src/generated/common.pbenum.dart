//
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Invoice Payment Status Enum - comprehensive status for all invoice payment scenarios
class InvoicePaymentStatus extends $pb.ProtobufEnum {
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_PENDING = InvoicePaymentStatus._(0, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_PENDING');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_PROCESSING = InvoicePaymentStatus._(1, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_PROCESSING');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_COMPLETED = InvoicePaymentStatus._(2, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_COMPLETED');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_FAILED = InvoicePaymentStatus._(3, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_FAILED');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_CANCELLED = InvoicePaymentStatus._(4, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_CANCELLED');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_PARTIALLY_PAID = InvoicePaymentStatus._(5, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_PARTIALLY_PAID');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_REFUNDED = InvoicePaymentStatus._(6, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_REFUNDED');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_DISPUTED = InvoicePaymentStatus._(7, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_DISPUTED');
  static const InvoicePaymentStatus INVOICE_PAYMENT_STATUS_OVERDUE = InvoicePaymentStatus._(8, _omitEnumNames ? '' : 'INVOICE_PAYMENT_STATUS_OVERDUE');

  static const $core.List<InvoicePaymentStatus> values = <InvoicePaymentStatus> [
    INVOICE_PAYMENT_STATUS_PENDING,
    INVOICE_PAYMENT_STATUS_PROCESSING,
    INVOICE_PAYMENT_STATUS_COMPLETED,
    INVOICE_PAYMENT_STATUS_FAILED,
    INVOICE_PAYMENT_STATUS_CANCELLED,
    INVOICE_PAYMENT_STATUS_PARTIALLY_PAID,
    INVOICE_PAYMENT_STATUS_REFUNDED,
    INVOICE_PAYMENT_STATUS_DISPUTED,
    INVOICE_PAYMENT_STATUS_OVERDUE,
  ];

  static final $core.Map<$core.int, InvoicePaymentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvoicePaymentStatus? valueOf($core.int value) => _byValue[value];

  const InvoicePaymentStatus._($core.int v, $core.String n) : super(v, n);
}

/// Payment Method Type Enum
class PaymentMethodType extends $pb.ProtobufEnum {
  static const PaymentMethodType PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE = PaymentMethodType._(0, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_CREDIT_CARD = PaymentMethodType._(1, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_CREDIT_CARD');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_DEBIT_CARD = PaymentMethodType._(2, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_DEBIT_CARD');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_PAYPAL = PaymentMethodType._(3, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_PAYPAL');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_APPLE_PAY = PaymentMethodType._(4, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_APPLE_PAY');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_GOOGLE_PAY = PaymentMethodType._(5, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_GOOGLE_PAY');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_BITCOIN = PaymentMethodType._(6, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_BITCOIN');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_ETHEREUM = PaymentMethodType._(7, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_ETHEREUM');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_USDC = PaymentMethodType._(8, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_USDC');
  static const PaymentMethodType PAYMENT_METHOD_TYPE_BANK_TRANSFER = PaymentMethodType._(9, _omitEnumNames ? '' : 'PAYMENT_METHOD_TYPE_BANK_TRANSFER');

  static const $core.List<PaymentMethodType> values = <PaymentMethodType> [
    PAYMENT_METHOD_TYPE_ACCOUNT_BALANCE,
    PAYMENT_METHOD_TYPE_CREDIT_CARD,
    PAYMENT_METHOD_TYPE_DEBIT_CARD,
    PAYMENT_METHOD_TYPE_PAYPAL,
    PAYMENT_METHOD_TYPE_APPLE_PAY,
    PAYMENT_METHOD_TYPE_GOOGLE_PAY,
    PAYMENT_METHOD_TYPE_BITCOIN,
    PAYMENT_METHOD_TYPE_ETHEREUM,
    PAYMENT_METHOD_TYPE_USDC,
    PAYMENT_METHOD_TYPE_BANK_TRANSFER,
  ];

  static final $core.Map<$core.int, PaymentMethodType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentMethodType? valueOf($core.int value) => _byValue[value];

  const PaymentMethodType._($core.int v, $core.String n) : super(v, n);
}

/// Dispute Status Enum
class DisputeStatus extends $pb.ProtobufEnum {
  static const DisputeStatus DISPUTE_STATUS_PENDING = DisputeStatus._(0, _omitEnumNames ? '' : 'DISPUTE_STATUS_PENDING');
  static const DisputeStatus DISPUTE_STATUS_INVESTIGATING = DisputeStatus._(1, _omitEnumNames ? '' : 'DISPUTE_STATUS_INVESTIGATING');
  static const DisputeStatus DISPUTE_STATUS_RESOLVED = DisputeStatus._(2, _omitEnumNames ? '' : 'DISPUTE_STATUS_RESOLVED');
  static const DisputeStatus DISPUTE_STATUS_REJECTED = DisputeStatus._(3, _omitEnumNames ? '' : 'DISPUTE_STATUS_REJECTED');
  static const DisputeStatus DISPUTE_STATUS_ESCALATED = DisputeStatus._(4, _omitEnumNames ? '' : 'DISPUTE_STATUS_ESCALATED');

  static const $core.List<DisputeStatus> values = <DisputeStatus> [
    DISPUTE_STATUS_PENDING,
    DISPUTE_STATUS_INVESTIGATING,
    DISPUTE_STATUS_RESOLVED,
    DISPUTE_STATUS_REJECTED,
    DISPUTE_STATUS_ESCALATED,
  ];

  static final $core.Map<$core.int, DisputeStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DisputeStatus? valueOf($core.int value) => _byValue[value];

  const DisputeStatus._($core.int v, $core.String n) : super(v, n);
}

/// Invoice Priority Enum
class InvoicePriority extends $pb.ProtobufEnum {
  static const InvoicePriority INVOICE_PRIORITY_LOW = InvoicePriority._(0, _omitEnumNames ? '' : 'INVOICE_PRIORITY_LOW');
  static const InvoicePriority INVOICE_PRIORITY_MEDIUM = InvoicePriority._(1, _omitEnumNames ? '' : 'INVOICE_PRIORITY_MEDIUM');
  static const InvoicePriority INVOICE_PRIORITY_HIGH = InvoicePriority._(2, _omitEnumNames ? '' : 'INVOICE_PRIORITY_HIGH');
  static const InvoicePriority INVOICE_PRIORITY_URGENT = InvoicePriority._(3, _omitEnumNames ? '' : 'INVOICE_PRIORITY_URGENT');

  static const $core.List<InvoicePriority> values = <InvoicePriority> [
    INVOICE_PRIORITY_LOW,
    INVOICE_PRIORITY_MEDIUM,
    INVOICE_PRIORITY_HIGH,
    INVOICE_PRIORITY_URGENT,
  ];

  static final $core.Map<$core.int, InvoicePriority> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvoicePriority? valueOf($core.int value) => _byValue[value];

  const InvoicePriority._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
