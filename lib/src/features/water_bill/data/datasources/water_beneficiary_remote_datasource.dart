import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as $timestamp_pb;
import '../../domain/entities/water_auto_recharge.dart';
import '../../domain/entities/water_beneficiary.dart';
import '../../domain/entities/water_reminder.dart';

/// Remote datasource for water-bill-scoped beneficiaries, auto-recharges
/// and reminders. Every call goes through commerce-gateway
/// via the shared GrpcClient (`commerceGrpcClient` in DI).
abstract class WaterBeneficiaryRemoteDataSource {
  // Beneficiary operations
  Future<List<WaterBeneficiary>> getBeneficiaries({String? providerCode});
  Future<WaterBeneficiary> saveBeneficiary({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? customerName,
  });
  Future<void> deleteBeneficiary(String beneficiaryId);
  Future<WaterBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });

  // Auto-recharge operations
  Future<List<WaterAutoRecharge>> getAutoRecharges({String? status});
  Future<WaterAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  });
  Future<WaterAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
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
  Future<List<WaterReminder>> getReminders({
    String? status,
    bool includePast = false,
  });
  Future<WaterReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
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
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  });
  Future<void> deleteReminder(String reminderId);
  Future<void> markReminderComplete(String reminderId);
}

class WaterBeneficiaryRemoteDataSourceImpl
    implements WaterBeneficiaryRemoteDataSource {
  final GrpcClient grpcClient;

  WaterBeneficiaryRemoteDataSourceImpl({required this.grpcClient});

  // ===================== Beneficiaries =====================

  @override
  Future<List<WaterBeneficiary>> getBeneficiaries(
      {String? providerCode}) async {
    try {
      final request = pb.GetWaterBeneficiariesRequest();
      if (providerCode != null && providerCode.isNotEmpty) {
        request.providerCode = providerCode;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getWaterBeneficiaries(request, options: options);
      return response.beneficiaries
          .map((b) => WaterBeneficiary.fromProto(b))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch water beneficiaries: ${e.message}');
    }
  }

  @override
  Future<WaterBeneficiary> saveBeneficiary({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? customerName,
  }) async {
    try {
      final request = pb.SaveWaterBeneficiaryRequest()
        ..accountNumber = accountNumber
        ..providerCode = providerCode
        ..providerName = providerName;
      if (nickname != null) request.nickname = nickname;
      if (customerName != null) request.customerName = customerName;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveWaterBeneficiary(request, options: options);
      return WaterBeneficiary.fromProto(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception('Failed to save water beneficiary: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final request = pb.DeleteWaterBeneficiaryRequest()
        ..id = beneficiaryId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteWaterBeneficiary(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete water beneficiary: ${e.message}');
    }
  }

  @override
  Future<WaterBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final request = pb.UpdateWaterBeneficiaryRequest()
        ..id = beneficiaryId;
      if (nickname != null) request.nickname = nickname;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateWaterBeneficiary(request, options: options);
      return response.hasBeneficiary()
          ? WaterBeneficiary.fromProto(response.beneficiary)
          : null;
    } on GrpcError catch (e) {
      throw Exception('Failed to update water beneficiary: ${e.message}');
    }
  }

  // ===================== Auto-recharges =====================

  @override
  Future<List<WaterAutoRecharge>> getAutoRecharges({String? status}) async {
    try {
      final request = pb.GetWaterAutoRechargesRequest();
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getWaterAutoRecharges(request, options: options);
      return response.autoRecharges
          .map((ar) => WaterAutoRecharge.fromProto(ar))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch water auto-recharges: ${e.message}');
    }
  }

  @override
  Future<WaterAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
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
      final request = pb.CreateWaterAutoRechargeRequest()
        ..beneficiaryId = beneficiaryId
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
          .createWaterAutoRecharge(request, options: options);
      return WaterAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to create water auto-recharge: ${e.message}');
    }
  }

  @override
  Future<WaterAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final request = pb.UpdateWaterAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      if (amount != null) request.amount = amount;
      if (frequency != null) request.frequency = frequency;
      if (dayOfWeek != null) request.dayOfWeek = dayOfWeek;
      if (dayOfMonth != null) request.dayOfMonth = dayOfMonth;
      if (maxRetries != null) request.maxRetries = maxRetries;
      if (executionHour != null) request.executionHour = executionHour;
      if (executionMinute != null) request.executionMinute = executionMinute;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateWaterAutoRecharge(request, options: options);
      return WaterAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to update water auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> pauseAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.PauseWaterAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .pauseWaterAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to pause water auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> resumeAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.ResumeWaterAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .resumeWaterAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to resume water auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> deleteAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.DeleteWaterAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteWaterAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete water auto-recharge: ${e.message}');
    }
  }

  // ===================== Reminders =====================

  @override
  Future<List<WaterReminder>> getReminders({
    String? status,
    bool includePast = false,
  }) async {
    try {
      final request = pb.GetWaterRemindersRequest()
        ..includePast = includePast;
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getWaterReminders(request, options: options);
      return response.reminders
          .map((r) => WaterReminder.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch water reminders: ${e.message}');
    }
  }

  @override
  Future<WaterReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.CreateWaterReminderRequest()
        ..beneficiaryId = beneficiaryId
        ..title = title
        ..reminderDate = _isoToTimestamp(reminderDate);
      if (description != null) request.description = description;
      if (amount != null) request.amount = amount;
      if (currency != null) request.currency = currency;
      request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .createWaterReminder(request, options: options);
      return WaterReminder.fromProto(response.reminder);
    } on GrpcError catch (e) {
      throw Exception('Failed to create water reminder: ${e.message}');
    }
  }

  @override
  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.UpdateWaterReminderRequest()
        ..reminderId = reminderId;
      if (title != null) request.title = title;
      if (description != null) request.description = description;
      if (reminderDate != null) {
        request.reminderDate = _isoToTimestamp(reminderDate);
      }
      if (amount != null) request.amount = amount;
      if (currency != null) request.currency = currency;
      if (isRecurring != null) request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .updateWaterReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to update water reminder: ${e.message}');
    }
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    try {
      final request = pb.DeleteWaterReminderRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteWaterReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete water reminder: ${e.message}');
    }
  }

  @override
  Future<void> markReminderComplete(String reminderId) async {
    try {
      final request = pb.MarkWaterReminderCompleteRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .markWaterReminderComplete(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to mark water reminder complete: ${e.message}');
    }
  }

  $timestamp_pb.Timestamp _isoToTimestamp(String iso) {
    final dt = DateTime.parse(iso).toUtc();
    return $timestamp_pb.Timestamp()
      ..seconds = $fixnum.Int64(dt.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dt.millisecondsSinceEpoch % 1000) * 1000000;
  }
}
