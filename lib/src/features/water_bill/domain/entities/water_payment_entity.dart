import 'package:equatable/equatable.dart';

enum WaterPaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

class WaterPaymentEntity extends Equatable {
  final String id;
  final String providerCode;
  final String providerName;
  final String customerNumber;
  final String customerName;
  final double amount;
  final String currency;
  final String? receiptNumber;
  final WaterPaymentStatus status;

  /// Why the money came back, when it did. Empty on a purchase that was never
  /// refunded.
  ///
  /// The backend keeps a refunded purchase as `status = failed` — the PURCHASE
  /// failed, which is correct — and records the refund here. A receipt that
  /// renders only `status` tells a customer "Failed" about money they already
  /// have back. See core/utils/bill_receipt_status.dart.
  final String refundSource;

  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? transactionReference;

  const WaterPaymentEntity({
    required this.id,
    required this.providerCode,
    required this.providerName,
    required this.customerNumber,
    required this.customerName,
    required this.amount,
    required this.currency,
    this.receiptNumber,
    required this.status,
    this.refundSource = '',
    this.errorMessage,
    required this.createdAt,
    this.completedAt,
    this.transactionReference,
  });

  bool get isPending => status == WaterPaymentStatus.pending;
  bool get isProcessing => status == WaterPaymentStatus.processing;
  bool get isCompleted => status == WaterPaymentStatus.completed;
  bool get isFailed => status == WaterPaymentStatus.failed;
  /// Refunded EITHER by an explicit status or by the backend's refund_source
  /// on a failed row — the enum only sees the literal string 'refunded', and
  /// our bill rails record a refund as `failed` plus a source.
  bool get isRefunded =>
      status == WaterPaymentStatus.refunded || refundSource.isNotEmpty;

  WaterPaymentEntity copyWith({
    String? id,
    String? providerCode,
    String? providerName,
    String? customerNumber,
    String? customerName,
    double? amount,
    String? currency,
    String? receiptNumber,
    WaterPaymentStatus? status,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? completedAt,
    String? transactionReference,
  }) {
    return WaterPaymentEntity(
      id: id ?? this.id,
      providerCode: providerCode ?? this.providerCode,
      providerName: providerName ?? this.providerName,
      customerNumber: customerNumber ?? this.customerNumber,
      customerName: customerName ?? this.customerName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      transactionReference: transactionReference ?? this.transactionReference,
    );
  }

  @override
  List<Object?> get props => [
        id,
        providerCode,
        providerName,
        customerNumber,
        customerName,
        amount,
        currency,
        receiptNumber,
        status,
        errorMessage,
        createdAt,
        completedAt,
        transactionReference,
        refundSource,
      ];
}
