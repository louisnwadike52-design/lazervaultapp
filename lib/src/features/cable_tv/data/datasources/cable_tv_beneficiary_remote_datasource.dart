import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as $timestamp_pb;
import '../../domain/entities/cable_tv_auto_recharge.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/cable_tv_reminder.dart';

/// Remote datasource for cable-TV-scoped beneficiaries, auto-recharges
/// (auto-renew) and reminders. Every call goes through commerce-gateway
/// via the shared GrpcClient (`commerceGrpcClient` in DI).
abstract class CableTVBeneficiaryRemoteDataSource {
  // Beneficiary operations
  Future<List<CableTVBeneficiary>> getBeneficiaries({String? providerCode});
  Future<CableTVBeneficiary> saveBeneficiary({
    required String smartCardNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? customerName,
  });
  Future<void> deleteBeneficiary(String beneficiaryId);
  Future<CableTVBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });

  // Auto-recharge (auto-renew) operations
  Future<List<CableTVAutoRecharge>> getAutoRecharges({String? status});
  Future<CableTVAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required String variationCode,
    required String packageName,
    required double amount,
    required String currency,
    required String subscriptionType,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  });
  Future<CableTVAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    String? variationCode,
    String? packageName,
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
  Future<List<CableTVReminder>> getReminders({
    String? status,
    bool includePast = false,
  });
  Future<CableTVReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? variationCode,
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
    String? variationCode,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  });
  Future<void> deleteReminder(String reminderId);
  Future<void> markReminderComplete(String reminderId);
}

class CableTVBeneficiaryRemoteDataSourceImpl
    implements CableTVBeneficiaryRemoteDataSource {
  final GrpcClient grpcClient;

  CableTVBeneficiaryRemoteDataSourceImpl({required this.grpcClient});

  // ===================== Beneficiaries =====================

  @override
  Future<List<CableTVBeneficiary>> getBeneficiaries(
      {String? providerCode}) async {
    try {
      final request = pb.GetCableTVBeneficiariesRequest();
      if (providerCode != null && providerCode.isNotEmpty) {
        request.providerCode = providerCode;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getCableTVBeneficiaries(request, options: options);
      return response.beneficiaries
          .map((b) => CableTVBeneficiary.fromProto(b))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch cable TV beneficiaries: ${e.message}');
    }
  }

  @override
  Future<CableTVBeneficiary> saveBeneficiary({
    required String smartCardNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? customerName,
  }) async {
    try {
      final request = pb.SaveCableTVBeneficiaryRequest()
        ..smartCardNumber = smartCardNumber
        ..providerCode = providerCode
        ..providerName = providerName;
      if (nickname != null) request.nickname = nickname;
      if (customerName != null) request.customerName = customerName;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveCableTVBeneficiary(request, options: options);
      return CableTVBeneficiary.fromProto(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception('Failed to save cable TV beneficiary: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final request = pb.DeleteCableTVBeneficiaryRequest()
        ..id = beneficiaryId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteCableTVBeneficiary(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete cable TV beneficiary: ${e.message}');
    }
  }

  @override
  Future<CableTVBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final request = pb.UpdateCableTVBeneficiaryRequest()
        ..id = beneficiaryId;
      if (nickname != null) request.nickname = nickname;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateCableTVBeneficiary(request, options: options);
      return response.hasBeneficiary()
          ? CableTVBeneficiary.fromProto(response.beneficiary)
          : null;
    } on GrpcError catch (e) {
      throw Exception('Failed to update cable TV beneficiary: ${e.message}');
    }
  }

  // ===================== Auto-recharges =====================

  @override
  Future<List<CableTVAutoRecharge>> getAutoRecharges({String? status}) async {
    try {
      final request = pb.GetCableTVAutoRechargesRequest();
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getCableTVAutoRecharges(request, options: options);
      return response.autoRecharges
          .map((ar) => CableTVAutoRecharge.fromProto(ar))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch cable TV auto-recharges: ${e.message}');
    }
  }

  @override
  Future<CableTVAutoRecharge> createAutoRecharge({
    required String beneficiaryId,
    required String variationCode,
    required String packageName,
    required double amount,
    required String currency,
    required String subscriptionType,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final request = pb.CreateCableTVAutoRechargeRequest()
        ..beneficiaryId = beneficiaryId
        ..variationCode = variationCode
        ..packageName = packageName
        ..amount = amount
        ..currency = currency
        ..subscriptionType = subscriptionType
        ..frequency = frequency
        ..dayOfWeek = dayOfWeek
        ..dayOfMonth = dayOfMonth
        ..maxRetries = maxRetries;
      if (executionHour != null) request.executionHour = executionHour;
      if (executionMinute != null) request.executionMinute = executionMinute;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .createCableTVAutoRecharge(request, options: options);
      return CableTVAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to create cable TV auto-recharge: ${e.message}');
    }
  }

  @override
  Future<CableTVAutoRecharge> updateAutoRecharge({
    required String autoRechargeId,
    String? variationCode,
    String? packageName,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    try {
      final request = pb.UpdateCableTVAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      if (variationCode != null) request.variationCode = variationCode;
      if (packageName != null) request.packageName = packageName;
      if (amount != null) request.amount = amount;
      if (frequency != null) request.frequency = frequency;
      if (dayOfWeek != null) request.dayOfWeek = dayOfWeek;
      if (dayOfMonth != null) request.dayOfMonth = dayOfMonth;
      if (maxRetries != null) request.maxRetries = maxRetries;
      if (executionHour != null) request.executionHour = executionHour;
      if (executionMinute != null) request.executionMinute = executionMinute;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateCableTVAutoRecharge(request, options: options);
      return CableTVAutoRecharge.fromProto(response.autoRecharge);
    } on GrpcError catch (e) {
      throw Exception('Failed to update cable TV auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> pauseAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.PauseCableTVAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .pauseCableTVAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to pause cable TV auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> resumeAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.ResumeCableTVAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .resumeCableTVAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to resume cable TV auto-recharge: ${e.message}');
    }
  }

  @override
  Future<void> deleteAutoRecharge(String autoRechargeId) async {
    try {
      final request = pb.DeleteCableTVAutoRechargeRequest()
        ..autoRechargeId = autoRechargeId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteCableTVAutoRecharge(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete cable TV auto-recharge: ${e.message}');
    }
  }

  // ===================== Reminders =====================

  @override
  Future<List<CableTVReminder>> getReminders({
    String? status,
    bool includePast = false,
  }) async {
    try {
      final request = pb.GetCableTVRemindersRequest()
        ..includePast = includePast;
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getCableTVReminders(request, options: options);
      return response.reminders
          .map((r) => CableTVReminder.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch cable TV reminders: ${e.message}');
    }
  }

  @override
  Future<CableTVReminder> createReminder({
    required String beneficiaryId,
    required String title,
    String? description,
    required String reminderDate,
    double? amount,
    String? variationCode,
    String? currency,
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.CreateCableTVReminderRequest()
        ..beneficiaryId = beneficiaryId
        ..title = title
        ..reminderDate = _isoToTimestamp(reminderDate);
      if (description != null) request.description = description;
      if (amount != null) request.amount = amount;
      if (variationCode != null) request.variationCode = variationCode;
      if (currency != null) request.currency = currency;
      request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .createCableTVReminder(request, options: options);
      return CableTVReminder.fromProto(response.reminder);
    } on GrpcError catch (e) {
      throw Exception('Failed to create cable TV reminder: ${e.message}');
    }
  }

  @override
  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    String? reminderDate,
    double? amount,
    String? variationCode,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    try {
      final request = pb.UpdateCableTVReminderRequest()
        ..reminderId = reminderId;
      if (title != null) request.title = title;
      if (description != null) request.description = description;
      if (reminderDate != null) {
        request.reminderDate = _isoToTimestamp(reminderDate);
      }
      if (amount != null) request.amount = amount;
      if (variationCode != null) request.variationCode = variationCode;
      if (currency != null) request.currency = currency;
      if (isRecurring != null) request.isRecurring = isRecurring;
      if (recurrenceType != null) request.recurrenceType = recurrenceType;

      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .updateCableTVReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to update cable TV reminder: ${e.message}');
    }
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    try {
      final request = pb.DeleteCableTVReminderRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteCableTVReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception('Failed to delete cable TV reminder: ${e.message}');
    }
  }

  @override
  Future<void> markReminderComplete(String reminderId) async {
    try {
      final request = pb.MarkCableTVReminderCompleteRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .markCableTVReminderComplete(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to mark cable TV reminder complete: ${e.message}');
    }
  }

  $timestamp_pb.Timestamp _isoToTimestamp(String iso) {
    final dt = DateTime.parse(iso).toUtc();
    return $timestamp_pb.Timestamp()
      ..seconds = $fixnum.Int64(dt.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dt.millisecondsSinceEpoch % 1000) * 1000000;
  }
}
