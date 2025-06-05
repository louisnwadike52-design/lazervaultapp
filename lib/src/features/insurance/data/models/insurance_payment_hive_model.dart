import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/insurance_payment_entity.dart';

part 'insurance_payment_hive_model.g.dart';

@HiveType(typeId: 21)
class InsurancePaymentHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String insuranceId;

  @HiveField(2)
  String policyNumber;

  @HiveField(3)
  double amount;

  @HiveField(4)
  String currency;

  @HiveField(5)
  String paymentMethod; // Store as string and convert to enum

  @HiveField(6)
  String status; // Store as string and convert to enum

  @HiveField(7)
  String? transactionId;

  @HiveField(8)
  String? referenceNumber;

  @HiveField(9)
  DateTime paymentDate;

  @HiveField(10)
  DateTime dueDate;

  @HiveField(11)
  DateTime? processedAt;

  @HiveField(12)
  Map<String, dynamic>? paymentDetails;

  @HiveField(13)
  String? failureReason;

  @HiveField(14)
  String? receiptUrl;

  @HiveField(15)
  DateTime createdAt;

  @HiveField(16)
  DateTime updatedAt;

  @HiveField(17)
  String userId;

  InsurancePaymentHiveModel({
    required this.id,
    required this.insuranceId,
    required this.policyNumber,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.status,
    this.transactionId,
    this.referenceNumber,
    required this.paymentDate,
    required this.dueDate,
    this.processedAt,
    this.paymentDetails,
    this.failureReason,
    this.receiptUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  // Convert from domain entity
  factory InsurancePaymentHiveModel.fromEntity(InsurancePayment payment) {
    return InsurancePaymentHiveModel(
      id: payment.id,
      insuranceId: payment.insuranceId,
      policyNumber: payment.policyNumber,
      amount: payment.amount,
      currency: payment.currency,
      paymentMethod: payment.paymentMethod.name,
      status: payment.status.name,
      transactionId: payment.transactionId,
      referenceNumber: payment.referenceNumber,
      paymentDate: payment.paymentDate,
      dueDate: payment.dueDate,
      processedAt: payment.processedAt,
      paymentDetails: payment.paymentDetails != null 
          ? Map<String, dynamic>.from(payment.paymentDetails!) 
          : null,
      failureReason: payment.failureReason,
      receiptUrl: payment.receiptUrl,
      createdAt: payment.createdAt,
      updatedAt: payment.updatedAt,
      userId: payment.userId,
    );
  }

  // Convert to domain entity
  InsurancePayment toEntity() {
    return InsurancePayment(
      id: id,
      insuranceId: insuranceId,
      policyNumber: policyNumber,
      amount: amount,
      currency: currency,
      paymentMethod: PaymentMethod.values.firstWhere((e) => e.name == paymentMethod),
      status: PaymentStatus.values.firstWhere((e) => e.name == status),
      transactionId: transactionId,
      referenceNumber: referenceNumber,
      paymentDate: paymentDate,
      dueDate: dueDate,
      processedAt: processedAt,
      paymentDetails: paymentDetails,
      failureReason: failureReason,
      receiptUrl: receiptUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
} 