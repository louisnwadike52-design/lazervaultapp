import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as $timestamp_pb;
import '../../domain/entities/airtime_auto_recharge.dart';
import '../../domain/entities/airtime_beneficiary.dart';
import '../../domain/entities/airtime_reminder.dart';

/// Remote datasource for airtime-scoped beneficiaries, auto-recharges and
/// reminders. Mirrors `InternetBeneficiaryRemoteDataSource` — every call goes
/// through commerce-gateway via the shared GrpcClient.
abstract class AirtimeBeneficiaryRemoteDataSource {
  // Beneficiary
  Future<List<AirtimeBeneficiary>> getBeneficiaries({String? networkCode});
  Future<AirtimeBeneficiary> saveBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  });
  Future<void> deleteBeneficiary(String beneficiaryId);
  Future<AirtimeBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });

  // Auto-recharge
  Future<List<AirtimeAutoRecharge>> getAutoRecharges({String? status});
  Future<AirtimeAutoRecharge> createAutoRecharge({
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
  Future<AirtimeAutoRecharge> updateAutoRecharge({
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

  // Reminder
  Future<List<AirtimeReminder>> getReminders({
    String? status,
    bool includePast = false,
  });
  Future<AirtimeReminder> createReminder({
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

class AirtimeBeneficiaryRemoteDataSourceImpl
    implements AirtimeBeneficiaryRemoteDataSource {
  final GrpcClient grpcClient;

  AirtimeBeneficiaryRemoteDataSourceImpl({required this.grpcClient});

  // ================== Beneficiaries ==================
  @override
  Future<List<AirtimeBeneficiary>> getBeneficiaries(
      {String? networkCode}) async {
    try {
      final request = pb.GetAirtimeBeneficiariesRequest();
      if (networkCode != null && networkCode.isNotEmpty) {
        request.networkCode = networkCode;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeBeneficiaries(request, options: options);
      return response.beneficiaries
          .map((b) => AirtimeBeneficiary.fromProto(b))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime beneficiaries: ${e.message}');
    }
  }

  @override
  Future<AirtimeBeneficiary> saveBeneficiary({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  }) async {
    try {
      final request = pb.SaveAirtimeBeneficiaryRequest()
        ..phoneNumber = phoneNumber
        ..networkCode = networkCode
        ..networkName = networkName
        ..countryCode = countryCode;
      if (nickname != null) request.nickname = nickname;
      if (operatorId != null) request.operatorId = operatorId;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveAirtimeBeneficiary(request, options: options);
      return AirtimeBeneficiary.fromProto(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception('Failed to save airtime beneficiary: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final request = pb.DeleteAirtimeBeneficiaryRequest()..id = beneficiaryId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteAirtimeBeneficiary(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete airtime beneficiary: ${e.message}');
    }
  }

  @override
  Future<AirtimeBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final request = pb.UpdateAirtimeBeneficiaryRequest()..id = beneficiaryId;
      if (nickname != null) request.nickname = nickname;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateAirtimeBeneficiary(request, options: options);
      return response.hasBeneficiary()
          ? AirtimeBeneficiary.fromProto(response.beneficiary)
          : null;
    } on GrpcError catch (e) {
      throw Exception('Failed to update airtime beneficiary: ${e.message}');
    }
  }

  // ================== Auto-recharges ==================
  @override
  Future<List<AirtimeAutoRecharge>> getAutoRecharges({String? status}) async {
    try {
      final request = pb.GetAirtimeAutoRechargesRequest();
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeAutoRecharges(request, options: options);
      return response.autoRecharges
          .map((ar) => AirtimeAutoRecharge.fromProto(ar))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime auto-recharges: ${e.message}');
    }
  }

  @override
  Future<AirtimeAutoRecharge> createAutoRecharge({
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
      final request = pb.CreateAirtimeAutoRechargeRequest()
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
          .createAirtimeAutoRecharge(request, options: options);
      return AirtimeAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to create airtime auto-recharge: ${e.message}');
    }
  }

  @override
  Future<AirtimeAutoRecharge> updateAutoRecharge({
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
      final request = pb.UpdateAirtimeAutoRechargeRequest()
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
          .updateAirtimeAutoRecharge(request, options: options);
      return AirtimeAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to update airtime auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> pauseAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.PauseAirtimeAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .pauseAirtimeAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to pause airtime auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> resumeAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.ResumeAirtimeAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .resumeAirtimeAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to resume airtime auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> deleteAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.DeleteAirtimeAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteAirtimeAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete airtime auto-recharge: ${e.message}');
    }
  }

  // ================== Reminders ==================
  @override
  Future<List<AirtimeReminder>> getReminders({
    String? status,
    bool includePast = false,
  }) async {
    try {
      final request = pb.GetAirtimeRemindersRequest()
        ..includePast = includePast;
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getAirtimeReminders(request, options: options);
      return response.reminders
          .map((r) => AirtimeReminder.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch airtime reminders: ${e.message}');
    }
  }

  @override
  Future<AirtimeReminder> createReminder({
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
      final request = pb.CreateAirtimeReminderRequest()
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
          .createAirtimeReminder(request, options: options);
      return AirtimeReminder.fromProto(response.reminder);
    } on GrpcError catch (e) {
      throw Exception('Failed to create airtime reminder: ${e.message}');
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
      final request = pb.UpdateAirtimeReminderRequest()
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
          .updateAirtimeReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to update airtime reminder: ${e.message}');
    }
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    try {
      final request = pb.DeleteAirtimeReminderRequest()..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteAirtimeReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete airtime reminder: ${e.message}');
    }
  }

  @override
  Future<void> markReminderComplete(String reminderId) async {
    try {
      final request = pb.MarkAirtimeReminderCompleteRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .markAirtimeReminderComplete(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to mark airtime reminder complete: ${e.message}');
    }
  }

  $timestamp_pb.Timestamp _isoToTimestamp(String iso) {
    final dt = DateTime.parse(iso).toUtc();
    return $timestamp_pb.Timestamp()
      ..seconds = $fixnum.Int64(dt.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dt.millisecondsSinceEpoch % 1000) * 1000000;
  }
}
