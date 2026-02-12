import 'package:equatable/equatable.dart';

enum BillPaymentStatus {
  pending,
  processing,
  completed,
  failed,
}

extension BillPaymentStatusExtension on BillPaymentStatus {
  String get displayName {
    switch (this) {
      case BillPaymentStatus.pending:
        return 'Pending';
      case BillPaymentStatus.processing:
        return 'Processing';
      case BillPaymentStatus.completed:
        return 'Completed';
      case BillPaymentStatus.failed:
        return 'Failed';
    }
  }

  static BillPaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BillPaymentStatus.pending;
      case 'processing':
        return BillPaymentStatus.processing;
      case 'completed':
        return BillPaymentStatus.completed;
      case 'failed':
        return BillPaymentStatus.failed;
      default:
        return BillPaymentStatus.pending;
    }
  }
}

enum MeterType {
  prepaid,
  postpaid,
}

extension MeterTypeExtension on MeterType {
  String get displayName {
    switch (this) {
      case MeterType.prepaid:
        return 'Prepaid';
      case MeterType.postpaid:
        return 'Postpaid';
    }
  }

  static MeterType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'prepaid':
        return MeterType.prepaid;
      case 'postpaid':
        return MeterType.postpaid;
      default:
        return MeterType.prepaid;
    }
  }
}

class BillPaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String providerId;
  final String providerCode;
  final String providerName;
  final String meterNumber;
  final String customerName;
  final String? customerAddress;
  final MeterType meterType;
  final double amount;
  final String currency;
  final double serviceFee;
  final double totalAmount;
  final BillPaymentStatus status;
  final String? token;
  final double? units;
  final String paymentGateway;
  final String referenceNumber;
  final String? gatewayReference;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final DateTime? failedAt;

  const BillPaymentEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.providerCode,
    required this.providerName,
    required this.meterNumber,
    required this.customerName,
    this.customerAddress,
    required this.meterType,
    required this.amount,
    required this.currency,
    required this.serviceFee,
    required this.totalAmount,
    required this.status,
    this.token,
    this.units,
    required this.paymentGateway,
    required this.referenceNumber,
    this.gatewayReference,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.failedAt,
  });

  /// Creates an empty entity for use as a placeholder (e.g., null safety fallback).
  factory BillPaymentEntity.empty() {
    final now = DateTime.now();
    return BillPaymentEntity(
      id: '',
      userId: '',
      providerId: '',
      providerCode: '',
      providerName: '',
      meterNumber: '',
      customerName: '',
      meterType: MeterType.prepaid,
      amount: 0,
      currency: 'NGN',
      serviceFee: 0,
      totalAmount: 0,
      status: BillPaymentStatus.pending,
      paymentGateway: '',
      referenceNumber: '',
      createdAt: now,
      updatedAt: now,
    );
  }

  bool get isPending => status == BillPaymentStatus.pending;
  bool get isProcessing => status == BillPaymentStatus.processing;
  bool get isCompleted => status == BillPaymentStatus.completed;
  bool get isFailed => status == BillPaymentStatus.failed;
  bool get isPrepaid => meterType == MeterType.prepaid;
  bool get isPostpaid => meterType == MeterType.postpaid;
  bool get hasToken => token != null && token!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        userId,
        providerId,
        providerCode,
        providerName,
        meterNumber,
        customerName,
        customerAddress,
        meterType,
        amount,
        currency,
        serviceFee,
        totalAmount,
        status,
        token,
        units,
        paymentGateway,
        referenceNumber,
        gatewayReference,
        errorMessage,
        createdAt,
        updatedAt,
        completedAt,
        failedAt,
      ];
}
