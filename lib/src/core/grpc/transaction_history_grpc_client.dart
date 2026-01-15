import 'package:grpc/grpc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/generated/transaction_history.pb.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// gRPC Client for Transaction History Service
class TransactionHistoryGrpcClient {
  final String host;
  final int port;
  final String? authToken;

  late final ClientChannel _channel;
  late final TransactionHistoryServiceClient _stub;

  TransactionHistoryGrpcClient({
    this.host = 'localhost',
    this.port = 9091,
    this.authToken,
  }) {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        timeout: Duration(seconds: 30),
      ),
    );

    _stub = TransactionHistoryServiceClient(_channel);
  }

  Future<TransactionListResponse> getTransactionHistory({
    required String userId,
    int page = 1,
    int limit = 20,
    TransactionServiceType? serviceType,
    List<UnifiedTransactionStatus>? statuses,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
  }) async {
    final request = GetTransactionHistoryRequest()
      ..userId = userId
      ..page = Int32(page)
      ..limit = Int32(limit);

    if (serviceType != null) {
      request.serviceType = _mapServiceType(serviceType);
    }

    if (statuses != null && statuses.isNotEmpty) {
      request.statuses.addAll(statuses.map(_mapStatus));
    }

    if (startDate != null) {
      request.startDate = Timestamp()
        ..seconds = Int64(startDate.millisecondsSinceEpoch ~/ 1000)
        ..nanos = (startDate.millisecondsSinceEpoch % 1000 * 1000000).toInt();
    }

    if (endDate != null) {
      request.endDate = Timestamp()
        ..seconds = Int64(endDate.millisecondsSinceEpoch ~/ 1000)
        ..nanos = (endDate.millisecondsSinceEpoch % 1000 * 1000000).toInt();
    }

    if (minAmount != null) {
      request.minAmount = minAmount;
    }

    if (maxAmount != null) {
      request.maxAmount = maxAmount;
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      request.searchQuery = searchQuery;
    }

    try {
      final response = await _stub.getTransactionHistory(request);

      return TransactionListResponse(
        transactions: response.transactions.map(_convertFromProto).toList(),
        hasMore: response.hasMore,
        currentPage: response.currentPage.toInt(),
        totalPages: response.totalPages.toInt(),
        totalItems: response.totalItems.toInt(),
        nextCursor: response.nextCursor.isNotEmpty ? response.nextCursor : null,
      );
    } catch (e) {
      throw Exception('Failed to fetch transaction history: $e');
    }
  }

  Future<void> close() async {
    await _channel.shutdown();
  }

  // Conversion helpers
  TransactionServiceType_Enum _mapServiceType(TransactionServiceType type) {
    switch (type) {
      case TransactionServiceType.airtime:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_AIRTIME;
      case TransactionServiceType.giftCard:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_GIFT_CARD;
      case TransactionServiceType.electricity:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_ELECTRICITY;
      case TransactionServiceType.water:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_WATER;
      case TransactionServiceType.tvSubscription:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_TV_SUBSCRIPTION;
      case TransactionServiceType.transfer:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_TRANSFER;
      case TransactionServiceType.crypto:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_CRYPTO;
      case TransactionServiceType.stocks:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_STOCKS;
      case TransactionServiceType.insurance:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_INSURANCE;
      case TransactionServiceType.invoice:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_INVOICE;
      case TransactionServiceType.barcodePayment:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_BARCODE_PAYMENT;
      case TransactionServiceType.tagPay:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_TAG_PAY;
      case TransactionServiceType.crowdfund:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_CROWDFUND;
      case TransactionServiceType.autosave:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_AUTOSAVE;
      case TransactionServiceType.deposit:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_DEPOSIT;
      case TransactionServiceType.withdrawal:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_WITHDRAWAL;
      default:
        return TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_UNKNOWN;
    }
  }

  TransactionStatus_Enum _mapStatus(UnifiedTransactionStatus status) {
    switch (status) {
      case UnifiedTransactionStatus.pending:
        return TransactionStatus_Enum.TRANSACTION_STATUS_PENDING;
      case UnifiedTransactionStatus.processing:
        return TransactionStatus_Enum.TRANSACTION_STATUS_PROCESSING;
      case UnifiedTransactionStatus.completed:
        return TransactionStatus_Enum.TRANSACTION_STATUS_COMPLETED;
      case UnifiedTransactionStatus.failed:
        return TransactionStatus_Enum.TRANSACTION_STATUS_FAILED;
      case UnifiedTransactionStatus.cancelled:
        return TransactionStatus_Enum.TRANSACTION_STATUS_CANCELLED;
      case UnifiedTransactionStatus.refunded:
        return TransactionStatus_Enum.TRANSACTION_STATUS_REFUNDED;
      case UnifiedTransactionStatus.expired:
        return TransactionStatus_Enum.TRANSACTION_STATUS_EXPIRED;
    }
  }

  UnifiedTransactionStatus _mapStatusFromProto(TransactionStatus_Enum status) {
    switch (status) {
      case TransactionStatus_Enum.TRANSACTION_STATUS_PENDING:
        return UnifiedTransactionStatus.pending;
      case TransactionStatus_Enum.TRANSACTION_STATUS_PROCESSING:
        return UnifiedTransactionStatus.processing;
      case TransactionStatus_Enum.TRANSACTION_STATUS_COMPLETED:
        return UnifiedTransactionStatus.completed;
      case TransactionStatus_Enum.TRANSACTION_STATUS_FAILED:
        return UnifiedTransactionStatus.failed;
      case TransactionStatus_Enum.TRANSACTION_STATUS_CANCELLED:
        return UnifiedTransactionStatus.cancelled;
      case TransactionStatus_Enum.TRANSACTION_STATUS_REFUNDED:
        return UnifiedTransactionStatus.refunded;
      case TransactionStatus_Enum.TRANSACTION_STATUS_EXPIRED:
        return UnifiedTransactionStatus.expired;
      default:
        return UnifiedTransactionStatus.pending;
    }
  }

  TransactionFlow _mapFlowFromProto(TransactionFlow_Enum flow) {
    switch (flow) {
      case TransactionFlow_Enum.TRANSACTION_FLOW_INCOMING:
        return TransactionFlow.incoming;
      case TransactionFlow_Enum.TRANSACTION_FLOW_OUTGOING:
        return TransactionFlow.outgoing;
      case TransactionFlow_Enum.TRANSACTION_FLOW_NEUTRAL:
        return TransactionFlow.neutral;
      default:
        return TransactionFlow.neutral;
    }
  }

  TransactionServiceType _mapServiceTypeFromProto(TransactionServiceType_Enum type) {
    switch (type) {
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_AIRTIME:
        return TransactionServiceType.airtime;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_GIFT_CARD:
        return TransactionServiceType.giftCard;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_ELECTRICITY:
        return TransactionServiceType.electricity;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_WATER:
        return TransactionServiceType.water;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_TV_SUBSCRIPTION:
        return TransactionServiceType.tvSubscription;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_TRANSFER:
        return TransactionServiceType.transfer;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_CRYPTO:
        return TransactionServiceType.crypto;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_STOCKS:
        return TransactionServiceType.stocks;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_INSURANCE:
        return TransactionServiceType.insurance;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_INVOICE:
        return TransactionServiceType.invoice;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_BARCODE_PAYMENT:
        return TransactionServiceType.barcodePayment;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_TAG_PAY:
        return TransactionServiceType.tagPay;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_CROWDFUND:
        return TransactionServiceType.crowdfund;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_AUTOSAVE:
        return TransactionServiceType.autosave;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_DEPOSIT:
        return TransactionServiceType.deposit;
      case TransactionServiceType_Enum.TRANSACTION_SERVICE_TYPE_WITHDRAWAL:
        return TransactionServiceType.withdrawal;
      default:
        return TransactionServiceType.unknown;
    }
  }

  UnifiedTransaction _convertFromProto(TransactionHistoryItem protoTx) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
      protoTx.createdAt.seconds.toInt() * 1000 +
          (protoTx.createdAt.nanos ~/ 1000000).toInt(),
    );

    return UnifiedTransaction(
      id: protoTx.id,
      serviceType: _mapServiceTypeFromProto(protoTx.serviceType),
      title: protoTx.title,
      description: protoTx.description.isNotEmpty ? protoTx.description : null,
      amount: protoTx.amount,
      currency: protoTx.currency,
      createdAt: createdAt,
      status: _mapStatusFromProto(protoTx.status),
      flow: _mapFlowFromProto(protoTx.flow),
      transactionReference: protoTx.transactionReference.isNotEmpty ? protoTx.transactionReference : null,
      metadata: protoTx.metadata.isNotEmpty ? protoTx.metadata : null,
    );
  }
}
