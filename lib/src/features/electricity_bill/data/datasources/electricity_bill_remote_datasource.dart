import 'package:grpc/grpc.dart';
import '../../../../generated/electricity_bill.pbgrpc.dart' as pb;
import '../../../../generated/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import '../../../../core/network/grpc_client.dart';
import '../models/provider_model.dart';
import '../models/bill_payment_model.dart';
import '../models/beneficiary_model.dart';
import '../models/auto_recharge_model.dart';
import '../models/reminder_model.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';

abstract class ElectricityBillRemoteDataSource {
  // Provider Management
  Future<List<ElectricityProviderModel>> getProviders({String? country});
  Future<void> syncProviders();

  // Meter Validation
  Future<MeterValidationResult> validateMeter({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
  });

  // Payment Operations
  Future<BillPaymentModel> initiatePayment({
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

  Future<BillPaymentModel> verifyPayment({required String paymentId});
  Future<List<BillPaymentModel>> getPaymentHistory({int? limit, int? offset});
  Future<BillPaymentModel> getPaymentReceipt({required String paymentId});

  // Beneficiary Management
  Future<BillBeneficiaryModel> saveBeneficiary({
    required String providerId,
    required String meterNumber,
    required MeterType meterType,
    required String customerName,
    String? customerAddress,
    required String nickname,
    bool isDefault = false,
  });

  Future<List<BillBeneficiaryModel>> getBeneficiaries();
  Future<BillBeneficiaryModel> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
    bool? isDefault,
  });
  Future<void> deleteBeneficiary({required String beneficiaryId});

  // Auto-Recharge Management
  Future<AutoRechargeModel> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required RechargeFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int maxRetries = 3,
  });

  Future<List<AutoRechargeModel>> getAutoRecharges();
  Future<AutoRechargeModel> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    RechargeFrequency? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
  });
  Future<void> pauseAutoRecharge({required String autoRechargeId});
  Future<void> resumeAutoRecharge({required String autoRechargeId});
  Future<void> deleteAutoRecharge({required String autoRechargeId});

  // Payment Reminder Management
  Future<BillPaymentReminderModel> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    bool isRecurring = false,
    ReminderRecurrenceType? recurrenceType,
  });

  Future<List<BillPaymentReminderModel>> getReminders();
  Future<BillPaymentReminderModel> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    bool? isRecurring,
    ReminderRecurrenceType? recurrenceType,
  });
  Future<void> markReminderComplete({required String reminderId});
  Future<void> deleteReminder({required String reminderId});
}

class ElectricityBillRemoteDataSourceImpl implements ElectricityBillRemoteDataSource {
  final GrpcClient grpcClient;

  ElectricityBillRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<ElectricityProviderModel>> getProviders({String? country}) async {
    final request = pb.GetProvidersRequest();
    if (country != null) {
      request.country = country;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.getProviders(
      request,
      options: options,
    );

    return response.providers
        .map((provider) => ElectricityProviderModel.fromProto(provider))
        .toList();
  }

  @override
  Future<void> syncProviders() async {
    final request = pb.SyncProvidersRequest();
    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.syncProviders(
      request,
      options: options,
    );
  }

  @override
  Future<MeterValidationResult> validateMeter({
    required String providerCode,
    required String meterNumber,
    required MeterType meterType,
  }) async {
    final request = pb.ValidateMeterRequest()
      ..providerCode = providerCode
      ..meterNumber = meterNumber
      ..meterType = meterType.name;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.validateMeterNumber(
      request,
      options: options,
    );

    return MeterValidationResult(
      customerName: response.customerName,
      customerAddress: response.hasCustomerAddress() ? response.customerAddress : null,
      meterNumber: response.meterNumber,
      meterType: MeterTypeExtension.fromString(response.meterType),
      isValid: response.isValid,
    );
  }

  @override
  Future<BillPaymentModel> initiatePayment({
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
  }) async {
    final request = pb.InitiatePaymentRequest()
      ..providerCode = providerCode
      ..meterNumber = meterNumber
      ..meterType = meterType.name
      ..amount = amount
      ..currency = currency
      ..sourceAccountId = accountId;

    if (paymentGateway != null) {
      request.paymentGateway = paymentGateway;
    }
    if (beneficiaryId != null) {
      request.beneficiaryId = beneficiaryId;
    }
    // Note: transactionId and verificationToken are not part of InitiatePaymentRequest protobuf
    // These may be added to metadata or handled differently in the future
    // if (transactionId != null) {
    //   request.transactionId = transactionId;
    // }
    // if (verificationToken != null) {
    //   request.verificationToken = verificationToken;
    // }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.initiatePayment(
      request,
      options: options,
    );

    // InitiatePaymentResponse returns payment_id, not full payment object
    // We need to verify the payment to get the full details
    final payment = await verifyPayment(paymentId: response.paymentId);
    return payment;
  }

  @override
  Future<BillPaymentModel> verifyPayment({required String paymentId}) async {
    final request = pb.VerifyPaymentRequest()
      ..paymentId = paymentId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.verifyPayment(
      request,
      options: options,
    );

    return BillPaymentModel.fromProto(response.payment);
  }

  @override
  Future<List<BillPaymentModel>> getPaymentHistory({int? limit, int? offset}) async {
    final request = pb.GetPaymentHistoryRequest()
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.getPaymentHistory(
      request,
      options: options,
    );

    return response.payments
        .map((payment) => BillPaymentModel.fromProto(payment))
        .toList();
  }

  @override
  Future<BillPaymentModel> getPaymentReceipt({required String paymentId}) async {
    final request = pb.GetPaymentReceiptRequest()
      ..paymentId = paymentId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.getPaymentReceipt(
      request,
      options: options,
    );

    return BillPaymentModel.fromProto(response.payment);
  }

  @override
  Future<BillBeneficiaryModel> saveBeneficiary({
    required String providerId,
    required String meterNumber,
    required MeterType meterType,
    required String customerName,
    String? customerAddress,
    required String nickname,
    bool isDefault = false,
  }) async {
    final request = pb.SaveBeneficiaryRequest()
      ..providerId = providerId
      ..meterNumber = meterNumber
      ..meterType = meterType.name
      ..customerName = customerName
      ..nickname = nickname
      ..isDefault = isDefault;

    if (customerAddress != null) {
      request.customerAddress = customerAddress;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.saveBeneficiary(
      request,
      options: options,
    );

    return BillBeneficiaryModel.fromProto(response.beneficiary);
  }

  @override
  Future<List<BillBeneficiaryModel>> getBeneficiaries() async {
    final request = pb.GetBeneficiariesRequest();
    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.getBeneficiaries(
      request,
      options: options,
    );

    return response.beneficiaries
        .map((beneficiary) => BillBeneficiaryModel.fromProto(beneficiary))
        .toList();
  }

  @override
  Future<BillBeneficiaryModel> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
    bool? isDefault,
  }) async {
    final request = pb.UpdateBeneficiaryRequest()
      ..beneficiaryId = beneficiaryId;

    if (nickname != null) {
      request.nickname = nickname;
    }
    if (isDefault != null) {
      request.isDefault = isDefault;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.updateBeneficiary(
      request,
      options: options,
    );

    return BillBeneficiaryModel.fromProto(response.beneficiary);
  }

  @override
  Future<void> deleteBeneficiary({required String beneficiaryId}) async {
    final request = pb.DeleteBeneficiaryRequest()
      ..beneficiaryId = beneficiaryId;

    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.deleteBeneficiary(
      request,
      options: options,
    );
  }

  @override
  Future<AutoRechargeModel> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required RechargeFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int maxRetries = 3,
  }) async {
    final request = pb.CreateAutoRechargeRequest()
      ..beneficiaryId = beneficiaryId
      ..amount = amount
      ..currency = currency
      ..frequency = frequency.name
      ..maxRetries = maxRetries;

    if (dayOfWeek != null) {
      request.dayOfWeek = dayOfWeek;
    }
    if (dayOfMonth != null) {
      request.dayOfMonth = dayOfMonth;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.createAutoRecharge(
      request,
      options: options,
    );

    return AutoRechargeModel.fromProto(response.autoRecharge);
  }

  @override
  Future<List<AutoRechargeModel>> getAutoRecharges() async {
    final request = pb.GetAutoRechargesRequest();
    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.getAutoRecharges(
      request,
      options: options,
    );

    return response.autoRecharges
        .map((autoRecharge) => AutoRechargeModel.fromProto(autoRecharge))
        .toList();
  }

  @override
  Future<AutoRechargeModel> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    RechargeFrequency? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
  }) async {
    final request = pb.UpdateAutoRechargeRequest()
      ..autoRechargeId = autoRechargeId;

    if (amount != null) {
      request.amount = amount;
    }
    if (frequency != null) {
      request.frequency = frequency.name;
    }
    if (dayOfWeek != null) {
      request.dayOfWeek = dayOfWeek;
    }
    if (dayOfMonth != null) {
      request.dayOfMonth = dayOfMonth;
    }
    if (maxRetries != null) {
      request.maxRetries = maxRetries;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.updateAutoRecharge(
      request,
      options: options,
    );

    return AutoRechargeModel.fromProto(response.autoRecharge);
  }

  @override
  Future<void> pauseAutoRecharge({required String autoRechargeId}) async {
    final request = pb.PauseAutoRechargeRequest()
      ..autoRechargeId = autoRechargeId;

    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.pauseAutoRecharge(
      request,
      options: options,
    );
  }

  @override
  Future<void> resumeAutoRecharge({required String autoRechargeId}) async {
    final request = pb.ResumeAutoRechargeRequest()
      ..autoRechargeId = autoRechargeId;

    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.resumeAutoRecharge(
      request,
      options: options,
    );
  }

  @override
  Future<void> deleteAutoRecharge({required String autoRechargeId}) async {
    final request = pb.DeleteAutoRechargeRequest()
      ..autoRechargeId = autoRechargeId;

    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.deleteAutoRecharge(
      request,
      options: options,
    );
  }

  @override
  Future<BillPaymentReminderModel> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    bool isRecurring = false,
    ReminderRecurrenceType? recurrenceType,
  }) async {
    final request = pb.CreateReminderRequest()
      ..title = title
      ..description = description
      ..reminderDate = pb_timestamp.Timestamp.fromDateTime(reminderDate)
      ..isRecurring = isRecurring;

    if (beneficiaryId != null) {
      request.beneficiaryId = beneficiaryId;
    }
    if (amount != null) {
      request.amount = amount;
      request.currency = 'NGN'; // Default currency
    }
    if (recurrenceType != null) {
      request.recurrenceType = recurrenceType.name;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.createReminder(
      request,
      options: options,
    );

    return BillPaymentReminderModel.fromProto(response.reminder);
  }

  @override
  Future<List<BillPaymentReminderModel>> getReminders() async {
    final request = pb.GetRemindersRequest();
    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.getReminders(
      request,
      options: options,
    );

    return response.reminders
        .map((reminder) => BillPaymentReminderModel.fromProto(reminder))
        .toList();
  }

  @override
  Future<BillPaymentReminderModel> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    bool? isRecurring,
    ReminderRecurrenceType? recurrenceType,
  }) async {
    final request = pb.UpdateReminderRequest()
      ..reminderId = reminderId;

    if (title != null) {
      request.title = title;
    }
    if (description != null) {
      request.description = description;
    }
    if (reminderDate != null) {
      request.reminderDate = pb_timestamp.Timestamp.fromDateTime(reminderDate);
    }
    if (amount != null) {
      request.amount = amount;
      request.currency = 'NGN'; // Default currency
    }
    if (isRecurring != null) {
      request.isRecurring = isRecurring;
    }
    if (recurrenceType != null) {
      request.recurrenceType = recurrenceType.name;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.electricityBillClient.updateReminder(
      request,
      options: options,
    );

    return BillPaymentReminderModel.fromProto(response.reminder);
  }

  @override
  Future<void> markReminderComplete({required String reminderId}) async {
    final request = pb.MarkReminderCompleteRequest()
      ..reminderId = reminderId;

    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.markReminderComplete(
      request,
      options: options,
    );
  }

  @override
  Future<void> deleteReminder({required String reminderId}) async {
    final request = pb.DeleteReminderRequest()
      ..reminderId = reminderId;

    final options = await grpcClient.callOptions;
    await grpcClient.electricityBillClient.deleteReminder(
      request,
      options: options,
    );
  }
}
