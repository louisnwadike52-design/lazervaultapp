import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as $timestamp_pb;
import '../../domain/entities/internet_auto_recharge.dart';
import '../../domain/entities/internet_beneficiary.dart';
import '../../domain/entities/internet_reminder.dart';

/// Remote datasource for internet-scoped beneficiaries + auto-recharges.
/// Mirrors `DataBeneficiaryRemoteDataSource` 1:1 — every call goes through
/// commerce-gateway via the shared GrpcClient (`utilityPaymentsClient`).
abstract class InternetBeneficiaryRemoteDataSource {
  // Beneficiary operations
  Future<List<InternetBeneficiary>> getBeneficiaries({String? providerCode});
  Future<InternetBeneficiary> saveBeneficiary({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
  });
  Future<void> deleteBeneficiary(String beneficiaryId);
  Future<InternetBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });

  // Auto-recharge ("Rollover") operations
  Future<List<InternetAutoRecharge>> getAutoRecharges({String? status});
  Future<InternetAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required String packageId,
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
  Future<InternetAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    String? packageId,
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
  Future<List<InternetReminder>> getReminders({
    String? status,
    bool includePast = false,
  });
  Future<InternetReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? packageId,
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
    String? packageId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  });
  Future<void> deleteReminder(String reminderId);
  Future<void> markReminderComplete(String reminderId);
}

class InternetBeneficiaryRemoteDataSourceImpl
    implements InternetBeneficiaryRemoteDataSource {
  final GrpcClient grpcClient;

  InternetBeneficiaryRemoteDataSourceImpl({required this.grpcClient});

  // ===================== Beneficiaries =====================

  @override
  Future<List<InternetBeneficiary>> getBeneficiaries(
      {String? providerCode}) async {
    try {
      final request = pb.GetInternetBeneficiariesRequest();
      if (providerCode != null && providerCode.isNotEmpty) {
        request.providerCode = providerCode;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getInternetBeneficiaries(request, options: options);
      return response.beneficiaries
          .map((b) => InternetBeneficiary.fromProto(b))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch internet beneficiaries: ${e.message}');
    }
  }

  @override
  Future<InternetBeneficiary> saveBeneficiary({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
  }) async {
    try {
      final request = pb.SaveInternetBeneficiaryRequest()
        ..accountNumber = accountNumber
        ..providerCode = providerCode
        ..providerName = providerName;
      if (nickname != null) request.nickname = nickname;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveInternetBeneficiary(request, options: options);
      return InternetBeneficiary.fromProto(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception('Failed to save internet beneficiary: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final request = pb.DeleteInternetBeneficiaryRequest()..id = beneficiaryId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteInternetBeneficiary(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete internet beneficiary: ${e.message}');
    }
  }

  @override
  Future<InternetBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final request = pb.UpdateInternetBeneficiaryRequest()..id = beneficiaryId;
      if (nickname != null) request.nickname = nickname;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateInternetBeneficiary(request, options: options);
      return response.hasBeneficiary()
          ? InternetBeneficiary.fromProto(response.beneficiary)
          : null;
    } on GrpcError catch (e) {
      throw Exception('Failed to update internet beneficiary: ${e.message}');
    }
  }

  // ===================== Auto-recharges =====================

  @override
  Future<List<InternetAutoRecharge>> getAutoRecharges({String? status}) async {
    try {
      final request = pb.GetInternetAutoRechargesRequest();
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getInternetAutoRecharges(request, options: options);
      return response.autoRecharges
          .map((ar) => InternetAutoRecharge.fromProto(ar))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to fetch internet auto-recharges: ${e.message}');
    }
  }

  @override
  Future<InternetAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required String packageId,
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
      final request = pb.CreateInternetAutoRechargeRequest()
        ..beneficiaryId = beneficiaryId
        ..packageId = packageId
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
          .createInternetAutoRecharge(request, options: options);
      return InternetAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to create internet auto-recharge: ${e.message}');
    }
  }

  @override
  Future<InternetAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    String? packageId,
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
      final request = pb.UpdateInternetAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      if (packageId != null) request.packageId = packageId;
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
          .updateInternetAutoRecharge(request, options: options);
      return InternetAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to update internet auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> pauseAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.PauseInternetAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .pauseInternetAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to pause internet auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> resumeAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.ResumeInternetAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .resumeInternetAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to resume internet auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> deleteAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.DeleteInternetAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteInternetAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to delete internet auto-recharge: ${e.message}');
    }
  }

  // ===================== Reminders =====================

  @override
  Future<List<InternetReminder>> getReminders({
    String? status,
    bool includePast = false,
  }) async {
    try {
      final request = pb.GetInternetRemindersRequest()
        ..includePast = includePast;
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getInternetReminders(request, options: options);
      return response.reminders
          .map((r) => InternetReminder.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch internet reminders: ${e.message}');
    }
  }

  @override
  Future<InternetReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? packageId,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.CreateInternetReminderRequest()
        ..beneficiaryId = beneficiaryId
        ..title = title
        ..reminderDate = _isoToTimestamp(reminderDate);
      if (description != null) request.description = description;
      if (amount != null) request.amount = amount;
      if (packageId != null) request.packageId = packageId;
      if (currency != null) request.currency = currency;
      request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .createInternetReminder(request, options: options);
      return InternetReminder.fromProto(response.reminder);
    } on GrpcError catch (e) {
      throw Exception('Failed to create internet reminder: ${e.message}');
    }
  }

  @override
  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? packageId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.UpdateInternetReminderRequest()
        ..reminderId = reminderId;
      if (title != null) request.title = title;
      if (description != null) request.description = description;
      if (reminderDate != null) {
        request.reminderDate = _isoToTimestamp(reminderDate);
      }
      if (amount != null) request.amount = amount;
      if (packageId != null) request.packageId = packageId;
      if (currency != null) request.currency = currency;
      if (isRecurring != null) request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .updateInternetReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to update internet reminder: ${e.message}');
    }
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    try {
      final request = pb.DeleteInternetReminderRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteInternetReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete internet reminder: ${e.message}');
    }
  }

  @override
  Future<void> markReminderComplete(String reminderId) async {
    try {
      final request = pb.MarkInternetReminderCompleteRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .markInternetReminderComplete(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to mark internet reminder complete: ${e.message}');
    }
  }

  $timestamp_pb.Timestamp _isoToTimestamp(String iso) {
    final dt = DateTime.parse(iso).toUtc();
    return $timestamp_pb.Timestamp()
      ..seconds = $fixnum.Int64(dt.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dt.millisecondsSinceEpoch % 1000) * 1000000;
  }
}
