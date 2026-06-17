import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/split_bill.pb.dart' as pb;
import 'package:lazervault/src/generated/split_bill.pbenum.dart' as pb_enum;
import '../../domain/entities/split_bill_entity.dart';
import '../../domain/exceptions/split_bill_exceptions.dart';
import '../../domain/repositories/split_bill_repository.dart';

class SplitBillRepositoryGrpcImpl implements SplitBillRepository {
  final GrpcClient grpcClient;

  SplitBillRepositoryGrpcImpl({required this.grpcClient});

  @override
  Future<SplitBillEntity> createSplitBill({
    required double totalAmount,
    required String currency,
    required String description,
    required SplitMethodType splitMethod,
    required double creatorShare,
    required List<SplitBillParticipantInput> participants,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreateSplitBillRequest()
          ..totalAmount = totalAmount
          ..currency = currency
          ..description = description
          ..splitMethod = _splitMethodToProto(splitMethod)
          ..creatorShare = creatorShare;

        for (final p in participants) {
          request.participants.add(pb.SplitBillParticipantInput()
            ..username = p.username
            ..amount = p.amount
            ..percentage = p.percentage);
        }

        final options = await grpcClient.callOptions;
        try {
          final response = await grpcClient.splitBillClient.createSplitBill(
            request,
            options: options,
          );

          if (!response.success) {
            throw Exception(
                response.message.isNotEmpty ? response.message : 'Failed to create split bill');
          }

          return _splitBillFromProto(response.splitBill);
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<SplitBillEntity> getSplitBill({required String splitBillId}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetSplitBillRequest()..splitBillId = splitBillId;

        final options = await grpcClient.callOptions;
        try {
          final response = await grpcClient.splitBillClient.getSplitBill(
            request,
            options: options,
          );

          if (!response.success) {
            throw Exception(
                response.message.isNotEmpty ? response.message : 'Split bill not found');
          }

          return _splitBillFromProto(response.splitBill);
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<SplitBillsPageResult> getMyCreatedSplitBills({
    int page = 1,
    int limit = 20,
    SplitBillStatus? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetMySplitBillsRequest()
          ..page = page
          ..limit = limit;

        if (status != null) {
          request.status = _statusToProto(status);
        }

        final options = await grpcClient.callOptions;
        try {
          final response =
              await grpcClient.splitBillClient.getMyCreatedSplitBills(
            request,
            options: options,
          );

          return SplitBillsPageResult(
            bills: response.splitBills.map(_splitBillFromProto).toList(),
            total: response.total,
            page: response.page,
            totalPages: response.totalPages,
          );
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<SplitBillsPageResult> getMyIncomingSplitBills({
    int page = 1,
    int limit = 20,
    SplitBillStatus? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetMySplitBillsRequest()
          ..page = page
          ..limit = limit;

        if (status != null) {
          request.status = _statusToProto(status);
        }

        final options = await grpcClient.callOptions;
        try {
          final response =
              await grpcClient.splitBillClient.getMyIncomingSplitBills(
            request,
            options: options,
          );

          return SplitBillsPageResult(
            bills: response.splitBills.map(_splitBillFromProto).toList(),
            total: response.total,
            page: response.page,
            totalPages: response.totalPages,
          );
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<PaySplitBillResult> paySplitBillShare({
    required String splitBillId,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.PaySplitBillShareRequest()
          ..splitBillId = splitBillId
          ..sourceAccountId = sourceAccountId
          ..transactionPin = transactionPin;

        final options = await grpcClient.callOptions;
        try {
          final response = await grpcClient.splitBillClient.paySplitBillShare(
            request,
            options: options,
          );

          if (!response.success) {
            throw Exception(
                response.message.isNotEmpty ? response.message : 'Payment failed');
          }

          return PaySplitBillResult(
            transactionReference: response.transaction.reference,
            message: response.message,
            updatedBill: _splitBillFromProto(response.splitBill),
          );
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<void> cancelSplitBill({required String splitBillId}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CancelSplitBillRequest()
          ..splitBillId = splitBillId;

        final options = await grpcClient.callOptions;
        try {
          final response = await grpcClient.splitBillClient.cancelSplitBill(
            request,
            options: options,
          );

          if (!response.success) {
            throw Exception(
                response.message.isNotEmpty ? response.message : 'Failed to cancel');
          }
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<void> declineSplitBillShare({
    required String splitBillId,
    String? reason,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.DeclineSplitBillShareRequest()
          ..splitBillId = splitBillId;

        if (reason != null) {
          request.reason = reason;
        }

        final options = await grpcClient.callOptions;
        try {
          final response =
              await grpcClient.splitBillClient.declineSplitBillShare(
            request,
            options: options,
          );

          if (!response.success) {
            throw Exception(
                response.message.isNotEmpty ? response.message : 'Failed to decline');
          }
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  @override
  Future<int> sendSplitBillReminder({required String splitBillId}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SendSplitBillReminderRequest()
          ..splitBillId = splitBillId;

        final options = await grpcClient.callOptions;
        try {
          final response =
              await grpcClient.splitBillClient.sendSplitBillReminder(
            request,
            options: options,
          );

          if (!response.success) {
            throw Exception(
                response.message.isNotEmpty ? response.message : 'Failed to send reminders');
          }

          return response.remindersSent;
        } on GrpcError catch (e) {
          _handleGrpcError(e);
        }
      },
    );
  }

  Never _handleGrpcError(GrpcError e) {
    switch (e.code) {
      case StatusCode.notFound:
        throw SplitBillNotFoundException(e.message ?? 'Split bill not found');
      case StatusCode.permissionDenied:
        throw SplitBillPermissionDeniedException(
            e.message ?? 'Permission denied');
      case StatusCode.failedPrecondition:
        throw SplitBillStateException(e.message ?? 'Invalid state');
      case StatusCode.unavailable:
        throw SplitBillServiceUnavailableException(
            e.message ?? 'Service unavailable');
      case StatusCode.aborted:
        throw Exception(e.message ?? 'Transfer failed');
      default:
        throw Exception(e.message ?? 'Unknown error');
    }
  }

  // --- Proto converters ---

  SplitBillEntity _splitBillFromProto(pb.SplitBill proto) {
    if (proto.id.isEmpty) {
      throw Exception('Invalid response: missing split bill data');
    }
    return SplitBillEntity(
      id: proto.id,
      creatorId: proto.creatorId,
      creatorUsername: proto.creatorUsername,
      creatorName: proto.creatorName,
      totalAmount: proto.totalAmount,
      creatorShare: proto.creatorShare,
      currency: proto.currency,
      description: proto.description,
      splitMethod: _splitMethodFromProto(proto.splitMethod),
      status: _statusFromProto(proto.status),
      reference: proto.reference,
      totalParticipants: proto.totalParticipants,
      paidCount: proto.paidCount,
      paidAmount: proto.paidAmount,
      participants:
          proto.participants.map(_participantFromProto).toList(),
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  SplitBillParticipantEntity _participantFromProto(
      pb.SplitBillParticipant proto) {
    return SplitBillParticipantEntity(
      id: proto.id,
      splitBillId: proto.splitBillId,
      userId: proto.userId,
      username: proto.username,
      displayName: proto.displayName,
      amount: proto.amount,
      percentage: proto.percentage,
      status: _participantStatusFromProto(proto.status),
      transactionReference: proto.transactionReference.isEmpty
          ? null
          : proto.transactionReference,
      paidAt: proto.hasPaidAt() ? proto.paidAt.toDateTime() : null,
    );
  }

  SplitBillStatus _statusFromProto(pb_enum.SplitBillStatus status) {
    switch (status) {
      case pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_ACTIVE:
        return SplitBillStatus.active;
      case pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_COMPLETED:
        return SplitBillStatus.completed;
      case pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_CANCELLED:
        return SplitBillStatus.cancelled;
      case pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_EXPIRED:
        return SplitBillStatus.expired;
      default:
        return SplitBillStatus.active;
    }
  }

  pb_enum.SplitBillStatus _statusToProto(SplitBillStatus status) {
    switch (status) {
      case SplitBillStatus.active:
        return pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_ACTIVE;
      case SplitBillStatus.completed:
        return pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_COMPLETED;
      case SplitBillStatus.cancelled:
        return pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_CANCELLED;
      case SplitBillStatus.expired:
        return pb_enum.SplitBillStatus.SPLIT_BILL_STATUS_EXPIRED;
    }
  }

  SplitBillParticipantStatus _participantStatusFromProto(
      pb_enum.SplitBillParticipantStatus status) {
    switch (status) {
      case pb_enum.SplitBillParticipantStatus
            .SPLIT_BILL_PARTICIPANT_STATUS_PENDING:
        return SplitBillParticipantStatus.pending;
      case pb_enum
            .SplitBillParticipantStatus.SPLIT_BILL_PARTICIPANT_STATUS_PAID:
        return SplitBillParticipantStatus.paid;
      case pb_enum.SplitBillParticipantStatus
            .SPLIT_BILL_PARTICIPANT_STATUS_DECLINED:
        return SplitBillParticipantStatus.declined;
      default:
        return SplitBillParticipantStatus.pending;
    }
  }

  SplitMethodType _splitMethodFromProto(pb_enum.SplitMethod method) {
    switch (method) {
      case pb_enum.SplitMethod.SPLIT_METHOD_EQUAL:
        return SplitMethodType.equal;
      case pb_enum.SplitMethod.SPLIT_METHOD_CUSTOM:
        return SplitMethodType.custom;
      case pb_enum.SplitMethod.SPLIT_METHOD_PERCENTAGE:
        return SplitMethodType.percentage;
      default:
        return SplitMethodType.equal;
    }
  }

  pb_enum.SplitMethod _splitMethodToProto(SplitMethodType method) {
    switch (method) {
      case SplitMethodType.equal:
        return pb_enum.SplitMethod.SPLIT_METHOD_EQUAL;
      case SplitMethodType.custom:
        return pb_enum.SplitMethod.SPLIT_METHOD_CUSTOM;
      case SplitMethodType.percentage:
        return pb_enum.SplitMethod.SPLIT_METHOD_PERCENTAGE;
    }
  }
}
