import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../datasources/electricity_bill_remote_datasource.dart';

class ElectricityBillRepositoryImpl implements ElectricityBillRepository {
  final ElectricityBillRemoteDataSource remoteDataSource;

  ElectricityBillRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ElectricityProviderEntity>>> getProviders({String? country}) async {
    try {
      final result = await remoteDataSource.getProviders(country: country);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get providers', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> syncProviders() async {
    try {
      await remoteDataSource.syncProviders();
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to sync providers', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, MeterValidationResult>> validateMeter({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
  }) async {
    try {
      final result = await remoteDataSource.validateMeter(
        providerCode: providerCode,
        meterNumber: meterNumber,
        meterType: meterType,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to validate meter', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, SmartMeterValidationResult>> smartValidateMeter({
    required String meterNumber,
  }) async {
    try {
      final result = await remoteDataSource.smartValidateMeter(
        meterNumber: meterNumber,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Smart meter validation failed', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BillPaymentEntity>> initiatePayment({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
    required double amount,
    required String currency,
    required String accountId,
    required String phoneNumber,
    String? paymentGateway,
    String? beneficiaryId,
    String? transactionId,
    String? verificationToken,
  }) async {
    try {
      final result = await remoteDataSource.initiatePayment(
        providerCode: providerCode,
        meterNumber: meterNumber,
        meterType: meterType,
        amount: amount,
        currency: currency,
        accountId: accountId,
        phoneNumber: phoneNumber,
        paymentGateway: paymentGateway,
        beneficiaryId: beneficiaryId,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to initiate payment', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BillPaymentEntity>> verifyPayment({required String paymentId}) async {
    try {
      final result = await remoteDataSource.verifyPayment(paymentId: paymentId);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to verify payment', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<BillPaymentEntity>>> getPaymentHistory({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await remoteDataSource.getPaymentHistory(limit: limit, offset: offset);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get payment history', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BillPaymentEntity>> getPaymentReceipt({required String paymentId}) async {
    try {
      final result = await remoteDataSource.getPaymentReceipt(paymentId: paymentId);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get payment receipt', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BillBeneficiaryEntity>> saveBeneficiary({
    required String providerId,
    required String meterNumber,
    required MeterType meterType,
    required String customerName,
    String? customerAddress,
    String? phoneNumber,
    required String nickname,
    bool isDefault = false,
    String? providerCode,
    String? providerName,
  }) async {
    try {
      final result = await remoteDataSource.saveBeneficiary(
        providerId: providerId,
        meterNumber: meterNumber,
        meterType: meterType,
        customerName: customerName,
        customerAddress: customerAddress,
        phoneNumber: phoneNumber,
        nickname: nickname,
        isDefault: isDefault,
        providerCode: providerCode,
        providerName: providerName,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to save beneficiary', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<BillBeneficiaryEntity>>> getBeneficiaries() async {
    try {
      final result = await remoteDataSource.getBeneficiaries();
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get beneficiaries', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, BillBeneficiaryEntity>> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
    bool? isDefault,
  }) async {
    try {
      final result = await remoteDataSource.updateBeneficiary(
        beneficiaryId: beneficiaryId,
        nickname: nickname,
        isDefault: isDefault,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to update beneficiary', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBeneficiary({required String beneficiaryId}) async {
    try {
      await remoteDataSource.deleteBeneficiary(beneficiaryId: beneficiaryId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete beneficiary', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, AutoRechargeEntity>> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required RechargeFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int maxRetries = 3,
  }) async {
    try {
      final result = await remoteDataSource.createAutoRecharge(
        beneficiaryId: beneficiaryId,
        amount: amount,
        currency: currency,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to create auto-recharge', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<AutoRechargeEntity>>> getAutoRecharges() async {
    try {
      final result = await remoteDataSource.getAutoRecharges();
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get auto-recharges', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, AutoRechargeEntity>> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    RechargeFrequency? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
  }) async {
    try {
      final result = await remoteDataSource.updateAutoRecharge(
        autoRechargeId: autoRechargeId,
        amount: amount,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to update auto-recharge', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> pauseAutoRecharge({required String autoRechargeId}) async {
    try {
      await remoteDataSource.pauseAutoRecharge(autoRechargeId: autoRechargeId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to pause auto-recharge', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> resumeAutoRecharge({required String autoRechargeId}) async {
    try {
      await remoteDataSource.resumeAutoRecharge(autoRechargeId: autoRechargeId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to resume auto-recharge', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAutoRecharge({required String autoRechargeId}) async {
    try {
      await remoteDataSource.deleteAutoRecharge(autoRechargeId: autoRechargeId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete auto-recharge', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, PaymentReminderEntity>> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    bool isRecurring = false,
    ReminderRecurrenceType? recurrenceType,
  }) async {
    try {
      final result = await remoteDataSource.createReminder(
        title: title,
        description: description,
        reminderDate: reminderDate,
        beneficiaryId: beneficiaryId,
        amount: amount,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to create reminder', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentReminderEntity>>> getReminders() async {
    try {
      final result = await remoteDataSource.getReminders();
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get reminders', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, PaymentReminderEntity>> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    bool? isRecurring,
    ReminderRecurrenceType? recurrenceType,
  }) async {
    try {
      final result = await remoteDataSource.updateReminder(
        reminderId: reminderId,
        title: title,
        description: description,
        reminderDate: reminderDate,
        amount: amount,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to update reminder', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> markReminderComplete({required String reminderId}) async {
    try {
      await remoteDataSource.markReminderComplete(reminderId: reminderId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to mark reminder complete', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReminder({required String reminderId}) async {
    try {
      await remoteDataSource.deleteReminder(reminderId: reminderId);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete reminder', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
