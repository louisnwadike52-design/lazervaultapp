import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/provider_entity.dart';
import '../entities/bill_payment_entity.dart';
import '../entities/beneficiary_entity.dart';
import '../entities/auto_recharge_entity.dart';
import '../entities/reminder_entity.dart';

abstract class ElectricityBillRepository {
  // Provider Management
  Future<Either<Failure, List<ElectricityProviderEntity>>> getProviders({
    String? country,
  });

  Future<Either<Failure, void>> syncProviders();

  // Meter Validation
  Future<Either<Failure, MeterValidationResult>> validateMeter({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
  });

  Future<Either<Failure, SmartMeterValidationResult>> smartValidateMeter({
    required String meterNumber,
  });

  // Payment Operations
  Future<Either<Failure, BillPaymentEntity>> initiatePayment({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
    required double amount,
    required String currency,
    required String accountId,
    String? paymentGateway,
    String? beneficiaryId,
    String? transactionId,
    String? verificationToken,
  });

  Future<Either<Failure, BillPaymentEntity>> verifyPayment({
    required String paymentId,
  });

  Future<Either<Failure, List<BillPaymentEntity>>> getPaymentHistory({
    int? limit,
    int? offset,
  });

  Future<Either<Failure, BillPaymentEntity>> getPaymentReceipt({
    required String paymentId,
  });

  // Beneficiary Management
  Future<Either<Failure, BillBeneficiaryEntity>> saveBeneficiary({
    required String providerId,
    required String meterNumber,
    required MeterType meterType,
    required String customerName,
    String? customerAddress,
    required String nickname,
    bool isDefault = false,
  });

  Future<Either<Failure, List<BillBeneficiaryEntity>>> getBeneficiaries();

  Future<Either<Failure, BillBeneficiaryEntity>> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
    bool? isDefault,
  });

  Future<Either<Failure, void>> deleteBeneficiary({
    required String beneficiaryId,
  });

  // Auto-Recharge Management
  Future<Either<Failure, AutoRechargeEntity>> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required RechargeFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int maxRetries = 3,
  });

  Future<Either<Failure, List<AutoRechargeEntity>>> getAutoRecharges();

  Future<Either<Failure, AutoRechargeEntity>> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    RechargeFrequency? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
  });

  Future<Either<Failure, void>> pauseAutoRecharge({
    required String autoRechargeId,
  });

  Future<Either<Failure, void>> resumeAutoRecharge({
    required String autoRechargeId,
  });

  Future<Either<Failure, void>> deleteAutoRecharge({
    required String autoRechargeId,
  });

  // Payment Reminder Management
  Future<Either<Failure, PaymentReminderEntity>> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    bool isRecurring = false,
    ReminderRecurrenceType? recurrenceType,
  });

  Future<Either<Failure, List<PaymentReminderEntity>>> getReminders();

  Future<Either<Failure, PaymentReminderEntity>> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    bool? isRecurring,
    ReminderRecurrenceType? recurrenceType,
  });

  Future<Either<Failure, void>> markReminderComplete({
    required String reminderId,
  });

  Future<Either<Failure, void>> deleteReminder({
    required String reminderId,
  });
}

class MeterValidationResult {
  final String customerName;
  final String? customerAddress;
  final String meterNumber;
  final MeterType meterType;
  final bool isValid;

  const MeterValidationResult({
    required this.customerName,
    this.customerAddress,
    required this.meterNumber,
    required this.meterType,
    required this.isValid,
  });
}

class SmartMeterValidationResult {
  final bool isValid;
  final String customerName;
  final String? customerAddress;
  final String meterType;
  final String meterNumber;
  final String providerCode;
  final String providerName;
  final String? message;
  final double minAmount;
  final double maxAmount;
  final double serviceFee;
  final bool fromCache;

  const SmartMeterValidationResult({
    required this.isValid,
    required this.customerName,
    this.customerAddress,
    required this.meterType,
    required this.meterNumber,
    required this.providerCode,
    required this.providerName,
    this.message,
    required this.minAmount,
    required this.maxAmount,
    required this.serviceFee,
    this.fromCache = false,
  });
}
