import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/contactless_payment.pb.dart' as pb;
import '../../domain/entities/contactless_payment_entity.dart';
import '../../domain/repositories/contactless_payment_repository.dart';

class ContactlessPaymentRepositoryImpl implements ContactlessPaymentRepository {
  final GrpcClient grpcClient;

  ContactlessPaymentRepositoryImpl({required this.grpcClient});

  @override
  Future<({PaymentSessionEntity session, String nfcPayload, String message})>
      createPaymentSession({
    required double amount,
    required String currency,
    String? category,
    String? description,
    int validitySeconds = 120,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreatePaymentSessionRequest()
          ..amount = amount
          ..currency = currency
          ..validitySeconds = validitySeconds;

        if (category != null) {
          request.category = category;
        }
        if (description != null) {
          request.description = description;
        }

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.createPaymentSession(
          request,
          options: options,
        );

        return (
          session: _paymentSessionFromProto(response.session),
          nfcPayload: response.nfcPayload,
          message: response.message,
        );
      },
    );
  }

  @override
  Future<PaymentSessionEntity> getPaymentSession(String sessionId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetPaymentSessionRequest()..sessionId = sessionId;

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.getPaymentSession(
          request,
          options: options,
        );

        return _paymentSessionFromProto(response.session);
      },
    );
  }

  @override
  Future<
      ({
        ContactlessTransactionEntity transaction,
        double newBalance,
        String message
      })> processContactlessPayment({
    required String sessionId,
    required String sourceAccountId,
    required String transactionId,
    required String verificationToken,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.ProcessContactlessPaymentRequest()
          ..sessionId = sessionId
          ..sourceAccountId = sourceAccountId
          ..transactionId = transactionId
          ..verificationToken = verificationToken;

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.processContactlessPayment(
          request,
          options: options,
        );

        return (
          transaction: _contactlessTransactionFromProto(response.transaction),
          newBalance: response.newBalance,
          message: response.message,
        );
      },
    );
  }

  @override
  Future<String> cancelPaymentSession(String sessionId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CancelPaymentSessionRequest()
          ..sessionId = sessionId;

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.cancelPaymentSession(
          request,
          options: options,
        );

        return response.message;
      },
    );
  }

  @override
  Future<({List<PaymentSessionEntity> sessions, int total})>
      getMyPaymentSessions({
    int limit = 20,
    int offset = 0,
    String? statusFilter,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetMyPaymentSessionsRequest()
          ..limit = limit
          ..offset = offset;

        if (statusFilter != null) {
          request.statusFilter = statusFilter;
        }

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.getMyPaymentSessions(
          request,
          options: options,
        );

        return (
          sessions: response.sessions
              .map((s) => _paymentSessionFromProto(s))
              .toList(),
          total: response.total,
        );
      },
    );
  }

  @override
  Future<({List<ContactlessTransactionEntity> transactions, int total})>
      getMyContactlessPayments({
    int limit = 20,
    int offset = 0,
    String? roleFilter,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetMyContactlessPaymentsRequest()
          ..limit = limit
          ..offset = offset;

        if (roleFilter != null) {
          request.roleFilter = roleFilter;
        }

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.getMyContactlessPayments(
          request,
          options: options,
        );

        return (
          transactions: response.transactions
              .map((t) => _contactlessTransactionFromProto(t))
              .toList(),
          total: response.total,
        );
      },
    );
  }

  @override
  Future<({String status, String? payerName, DateTime updatedAt})>
      checkSessionStatus(String sessionId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CheckSessionStatusRequest()..sessionId = sessionId;

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.checkSessionStatus(
          request,
          options: options,
        );

        return (
          status: response.status,
          payerName:
              response.payerName.isNotEmpty ? response.payerName : null,
          updatedAt: response.updatedAt.toDateTime(),
        );
      },
    );
  }

  @override
  Future<({PaymentSessionEntity session, String message})>
      acknowledgeSessionRead(String sessionId) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.AcknowledgeSessionReadRequest()
          ..sessionId = sessionId;

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.contactlessPaymentClient.acknowledgeSessionRead(
          request,
          options: options,
        );

        return (
          session: _paymentSessionFromProto(response.session),
          message: response.message,
        );
      },
    );
  }

  // Helper methods to convert proto messages to entities

  PaymentSessionEntity _paymentSessionFromProto(pb.PaymentSession proto) {
    return PaymentSessionEntity(
      id: proto.id,
      receiverId: proto.receiverId,
      receiverUsername: proto.receiverUsername,
      receiverName: proto.receiverName,
      receiverAccountId: proto.receiverAccountId,
      amount: proto.amount,
      currency: proto.currency,
      category: proto.category.isNotEmpty ? proto.category : null,
      description: proto.description.isNotEmpty ? proto.description : null,
      status: _paymentSessionStatusFromString(proto.status),
      payerId: proto.payerId.isNotEmpty ? proto.payerId : null,
      payerName: proto.payerName.isNotEmpty ? proto.payerName : null,
      createdAt: proto.createdAt.toDateTime(),
      expiresAt: proto.expiresAt.toDateTime(),
      readAt: proto.hasReadAt() ? proto.readAt.toDateTime() : null,
      completedAt:
          proto.hasCompletedAt() ? proto.completedAt.toDateTime() : null,
    );
  }

  ContactlessTransactionEntity _contactlessTransactionFromProto(
      pb.ContactlessTransaction proto) {
    return ContactlessTransactionEntity(
      id: proto.id,
      sessionId: proto.sessionId,
      payerId: proto.payerId,
      payerUsername: proto.payerUsername,
      payerName: proto.payerName,
      payerAccountId: proto.payerAccountId,
      receiverId: proto.receiverId,
      receiverUsername: proto.receiverUsername,
      receiverName: proto.receiverName,
      receiverAccountId: proto.receiverAccountId,
      amount: proto.amount,
      currency: proto.currency,
      category: proto.category.isNotEmpty ? proto.category : null,
      description: proto.description.isNotEmpty ? proto.description : null,
      referenceNumber: proto.referenceNumber,
      status: _transactionStatusFromString(proto.status),
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  PaymentSessionStatus _paymentSessionStatusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentSessionStatus.pending;
      case 'read':
        return PaymentSessionStatus.read;
      case 'processing':
        return PaymentSessionStatus.processing;
      case 'completed':
        return PaymentSessionStatus.completed;
      case 'cancelled':
        return PaymentSessionStatus.cancelled;
      case 'expired':
        return PaymentSessionStatus.expired;
      default:
        return PaymentSessionStatus.pending;
    }
  }

  TransactionStatus _transactionStatusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return TransactionStatus.completed;
      case 'failed':
        return TransactionStatus.failed;
      case 'reversed':
        return TransactionStatus.reversed;
      default:
        return TransactionStatus.completed;
    }
  }
}
