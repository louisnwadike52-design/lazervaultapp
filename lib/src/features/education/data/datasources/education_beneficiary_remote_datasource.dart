import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as $timestamp_pb;
import '../../domain/entities/education_beneficiary.dart';
import '../../domain/entities/education_reminder.dart';

/// Remote datasource for education-scoped beneficiaries (saved candidates)
/// and reminders. Every call goes through commerce-gateway
/// via the shared GrpcClient (`commerceGrpcClient` in DI).
/// NO auto-recharge — education PINs are one-time purchases.
abstract class EducationBeneficiaryRemoteDataSource {
  // Beneficiary operations
  Future<List<EducationBeneficiary>> getBeneficiaries(
      {String? providerCode});
  Future<EducationBeneficiary> saveBeneficiary({
    required String candidateNumber,
    required String examType,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? candidateName,
  });
  Future<void> deleteBeneficiary(String beneficiaryId);
  Future<EducationBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  });

  // Reminder operations
  Future<List<EducationReminder>> getReminders({
    String? status,
    bool includePast = false,
  });
  Future<EducationReminder> createReminder({
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

class EducationBeneficiaryRemoteDataSourceImpl
    implements EducationBeneficiaryRemoteDataSource {
  final GrpcClient grpcClient;

  EducationBeneficiaryRemoteDataSourceImpl({required this.grpcClient});

  // ===================== Beneficiaries =====================

  @override
  Future<List<EducationBeneficiary>> getBeneficiaries(
      {String? providerCode}) async {
    try {
      final request = pb.GetEducationBeneficiariesRequest();
      if (providerCode != null && providerCode.isNotEmpty) {
        request.providerCode = providerCode;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getEducationBeneficiaries(request, options: options);
      return response.beneficiaries
          .map((b) => EducationBeneficiary.fromProto(b))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to fetch education beneficiaries: ${e.message}');
    }
  }

  @override
  Future<EducationBeneficiary> saveBeneficiary({
    required String candidateNumber,
    required String examType,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? candidateName,
  }) async {
    try {
      final request = pb.SaveEducationBeneficiaryRequest()
        ..candidateNumber = candidateNumber
        ..examType = examType
        ..providerCode = providerCode
        ..providerName = providerName;
      if (nickname != null) request.nickname = nickname;
      if (candidateName != null) request.candidateName = candidateName;

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveEducationBeneficiary(request, options: options);
      return EducationBeneficiary.fromProto(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to save education beneficiary: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final request = pb.DeleteEducationBeneficiaryRequest()
        ..id = beneficiaryId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteEducationBeneficiary(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to delete education beneficiary: ${e.message}');
    }
  }

  @override
  Future<EducationBeneficiary?> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final request = pb.UpdateEducationBeneficiaryRequest()
        ..id = beneficiaryId;
      if (nickname != null) request.nickname = nickname;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .updateEducationBeneficiary(request, options: options);
      return response.hasBeneficiary()
          ? EducationBeneficiary.fromProto(response.beneficiary)
          : null;
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to update education beneficiary: ${e.message}');
    }
  }

  // ===================== Reminders =====================

  @override
  Future<List<EducationReminder>> getReminders({
    String? status,
    bool includePast = false,
  }) async {
    try {
      final request = pb.GetEducationRemindersRequest()
        ..includePast = includePast;
      if (status != null && status.isNotEmpty) request.status = status;
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getEducationReminders(request, options: options);
      return response.reminders
          .map((r) => EducationReminder.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to fetch education reminders: ${e.message}');
    }
  }

  @override
  Future<EducationReminder> createReminder({
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
      final request = pb.CreateEducationReminderRequest()
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
          .createEducationReminder(request, options: options);
      return EducationReminder.fromProto(response.reminder);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to create education reminder: ${e.message}');
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
      final request = pb.UpdateEducationReminderRequest()
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
          .updateEducationReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to update education reminder: ${e.message}');
    }
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    try {
      final request = pb.DeleteEducationReminderRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .deleteEducationReminder(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to delete education reminder: ${e.message}');
    }
  }

  @override
  Future<void> markReminderComplete(String reminderId) async {
    try {
      final request = pb.MarkEducationReminderCompleteRequest()
        ..reminderId = reminderId;
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient
          .markEducationReminderComplete(request, options: options);
    } on GrpcError catch (e) {
      throw Exception(
          'Failed to mark education reminder complete: ${e.message}');
    }
  }

  $timestamp_pb.Timestamp _isoToTimestamp(String iso) {
    final dt = DateTime.parse(iso).toUtc();
    return $timestamp_pb.Timestamp()
      ..seconds = $fixnum.Int64(dt.millisecondsSinceEpoch ~/ 1000)
      ..nanos = (dt.millisecondsSinceEpoch % 1000) * 1000000;
  }
}
