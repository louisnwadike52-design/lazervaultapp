import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as $timestamp_pb;
import '../../domain/entities/data_auto_recharge.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../../domain/entities/data_reminder.dart';

/// Remote datasource for data-scoped beneficiaries, auto-recharges (rollover)
/// and reminders. Mirrors `AirtimeRemoteDataSource`'s contract — every call
/// goes through commerce-gateway via the shared GrpcClient
/// (`commerceGrpcClient` in DI).
abstract class DataBeneficiaryRemoteDataSource {
  // Beneficiary operations
  Future<List<DataBeneficiary>> getBeneficiaries({String? networkCode});
  Future<DataBeneficiary> saveBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  });
  Future<void> deleteBeneficiary(String beneficiaryId);
  Future<DataBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });

  // Auto-recharge ("Rollover") operations
  Future<List<DataAutoRecharge>> getAutoRecharges({String? status});
  Future<DataAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required String variationId,
    required String planName,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  });
  Future<DataAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    String? variationId,
    String? planName,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  });
  Future<void> pauseAutoRecharge(String autoRechargeId);
  Future<void> resumeAutoRecharge(String autoRechargeId);
  Future<void> deleteAutoRecharge(String autoRechargeId);

  // Reminder operations
  Future<List<DataReminder>> getReminders({
    String? status,
    bool includePast = false,
  });
  Future<DataReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? variationId,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  });
  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? variationId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  });
  Future<void> deleteReminder(String reminderId);
  Future<void> markReminderComplete(String reminderId);
}

class DataBeneficiaryRemoteDataSourceImpl
    implements DataBeneficiaryRemoteDataSource {
  final GrpcClient grpcClient;

  DataBeneficiaryRemoteDataSourceImpl({required this.grpcClient});

  // ===================== Beneficiaries =====================

  @override
  Future<List<DataBeneficiary>> getBeneficiaries({String? networkCode}) async {
    try {
      final request = pb.GetDataBeneficiariesRequest();
      if (networkCode != null && networkCode.isNotEmpty) {
        request.networkCode = networkCode;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getDataBeneficiaries(request, options: options);
      return response.beneficiaries
          .map((b) => DataBeneficiary.fromProto(b))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch data beneficiaries: ${e.message}');
    }
  }

  @override
  Future<DataBeneficiary> saveBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  }) async {
    try {
      final request = pb.SaveDataBeneficiaryRequest()
        ..phoneNumber = phoneNumber
        ..networkCode = networkCode
        ..networkName = networkName
        ..countryCode = countryCode;
      if (nickname != null) request.nickname = nickname;
      if (operatorId != null) request.operatorId = operatorId;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveDataBeneficiary(request, options: options);
      return DataBeneficiary.fromProto(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception('Failed to save data beneficiary: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final request = pb.DeleteDataBeneficiaryRequest()..id = beneficiaryId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteDataBeneficiary(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete data beneficiary: ${e.message}');
    }
  }

  @override
  Future<DataBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final request = pb.UpdateDataBeneficiaryRequest()..id = beneficiaryId;
      if (nickname != null) request.nickname = nickname;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateDataBeneficiary(request, options: options);
      return response.hasBeneficiary()
          ? DataBeneficiary.fromProto(response.beneficiary)
          : null;
    } on GrpcError catch (e) {
      throw Exception('Failed to update data beneficiary: ${e.message}');
    }
  }

  // ===================== Auto-recharges =====================

  @override
  Future<List<DataAutoRecharge>> getAutoRecharges({String? status}) async {
    try {
      final request = pb.GetDataAutoRechargesRequest();
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getDataAutoRecharges(request, options: options);
      return response.autoRecharges
          .map((ar) => DataAutoRecharge.fromProto(ar))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch data auto-recharges: ${e.message}');
    }
  }

  @override
  Future<DataAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required String variationId,
    required String planName,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final request = pb.CreateDataAutoRechargeRequest()
        ..beneficiaryId = beneficiaryId
        ..variationId = variationId
        ..planName = planName
        ..amount = amount
        ..currency = currency
        ..frequency = frequency
        ..dayOfWeek = dayOfWeek
        ..dayOfMonth = dayOfMonth
        ..maxRetries = maxRetries;
      if (executionHour != null) request.executionHour = executionHour;
      if (executionMinute != null) request.executionMinute = executionMinute;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .createDataAutoRecharge(request, options: options);
      return DataAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to create data auto-recharge: ${e.message}');
    }
  }

  @override
  Future<DataAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    String? variationId,
    String? planName,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final request = pb.UpdateDataAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      if (variationId != null) request.variationId = variationId;
      if (planName != null) request.planName = planName;
      if (amount != null) request.amount = amount;
      if (frequency != null) request.frequency = frequency;
      if (dayOfWeek != null) request.dayOfWeek = dayOfWeek;
      if (dayOfMonth != null) request.dayOfMonth = dayOfMonth;
      if (maxRetries != null) request.maxRetries = maxRetries;
      if (executionHour != null) request.executionHour = executionHour;
      if (executionMinute != null) request.executionMinute = executionMinute;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateDataAutoRecharge(request, options: options);
      return DataAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to update data auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> pauseAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.PauseDataAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .pauseDataAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to pause data auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> resumeAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.ResumeDataAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .resumeDataAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to resume data auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> deleteAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.DeleteDataAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteDataAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete data auto-recharge: ${e.message}');
    }
  }

  // ===================== Reminders =====================

  @override
  Future<List<DataReminder>> getReminders({
    String? status,
    bool includePast = false,
  }) async {
    try {
      final request = pb.GetDataRemindersRequest()..includePast = includePast;
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getDataReminders(request, options: options);
      return response.reminders.map((r) => DataReminder.fromProto(r)).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch data reminders: ${e.message}');
    }
  }

  @override
  Future<DataReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? variationId,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.CreateDataReminderRequest()
        ..beneficiaryId = beneficiaryId
        ..title = title
        ..reminderDate = _isoToTimestamp(reminderDate);
      if (description != null) request.description = description;
      if (amount != null) request.amount = amount;
      if (variationId != null) request.variationId = variationId;
      if (currency != null) request.currency = currency;
      request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .createDataReminder(request, options: options);
      return DataReminder.fromProto(response.reminder);
    } on GrpcError catch (e) {
      throw Exception('Failed to create data reminder: ${e.message}');
    }
  }

  @override
  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? variationId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.UpdateDataReminderRequest()..reminderId = reminderId;
      if (title != null) request.title = title;
      if (description != null) request.description = description;
      if (reminderDate != null) {
        request.reminderDate = _isoToTimestamp(reminderDate);
      }
      if (amount != null) request.amount = amount;
      if (variationId != null) request.variationId = variationId;
      if (currency != null) request.currency = currency;
      if (isRecurring != null) request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .updateDataReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to update data reminder: ${e.message}');
    }
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    try {
      final request = pb.DeleteDataReminderRequest()..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteDataReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete data reminder: ${e.message}');
    }
  }

  @override
  Future<void> markReminderComplete(String reminderId) async {
    try {
      final request = pb.MarkDataReminderCompleteRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .markDataReminderComplete(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to mark data reminder complete: ${e.message}');
    }
  }

  $timestamp_pb.Timestamp _isoToTimestamp(String iso) {
    final dt = DateTime.parse(iso).toUtc();
    return $timestamp_pb.Timestamp()
      ..seconds = $fixnum.Int64(dt.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dt.millisecondsSinceEpoch % 1000) * 1000000;
  }
}
