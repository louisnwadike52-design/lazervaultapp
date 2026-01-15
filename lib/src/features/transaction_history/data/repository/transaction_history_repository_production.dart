import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/core/grpc/transaction_history_grpc_client.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:lazervault/src/generated/transaction_history.pb.dart' as pb;

/// Production implementation of Transaction History Repository
/// Connects to the Transaction History microservice via gRPC (with HTTP fallback)
class TransactionHistoryRepositoryProduction implements TransactionHistoryRepository {
  final TransactionHistoryClient grpcClient;
  final Dio httpClient;
  final FlutterSecureStorage storage;
  final String baseUrl;

  TransactionHistoryRepositoryProduction({
    required this.grpcClient,
    required this.httpClient,
    required this.storage,
    this.baseUrl = 'http://localhost:7878', // Core Gateway
  });

  // Get current user ID
  Future<String> _getUserId() async {
    final userId = await storage.read(key: 'user_id');
    if (userId == null || userId.isEmpty) {
      throw Exception('User not authenticated');
    }
    return userId;
  }

  // Get auth token for HTTP requests
  Future<String> _getAuthToken() async {
    final token = await storage.read(key: 'auth_token');
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token not found');
    }
    return token;
  }

  @override
  Future<TransactionListResponse> fetchAllTransactions({
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  }) async {
    try {
      final userId = await _getUserId();

      // Convert filters to gRPC types
      List<pb.TransactionStatus>? statuses;
      if (filters?.statuses != null && filters!.statuses!.isNotEmpty) {
        statuses = filters.statuses!.map((s) => _mapStatus(s)).toList();
      }

      // Try gRPC first
      try {
        final response = await grpcClient.getTransactionHistory(
          userId: userId,
          page: page,
          limit: limit,
          cursor: cursor,
          statuses: statuses,
          startDate: filters?.startDate != null
              ? _timestampFromDateTime(filters!.startDate!)
              : null,
          endDate: filters?.endDate != null
              ? _timestampFromDateTime(filters!.endDate!)
              : null,
          minAmount: filters?.minAmount,
          maxAmount: filters?.maxAmount,
          searchQuery: filters?.searchQuery,
        );

        final transactions = response.transactions
            .map((pbTx) => _convertFromProto(pbTx))
            .toList();

        return TransactionListResponse(
          transactions: transactions,
          hasMore: response.hasMore,
          currentPage: response.currentPage.toInt(),
          totalPages: response.totalPages.toInt(),
          nextCursor: response.nextCursor,
        );
      } catch (e) {
        // Fallback to HTTP if gRPC fails
        return await _fetchViaHttp(userId, page, limit, filters);
      }
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  @override
  Future<TransactionListResponse> fetchServiceTransactions(
    TransactionServiceType serviceType, {
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  }) async {
    try {
      final userId = await _getUserId();

      // Convert service type
      final pbServiceType = _mapServiceType(serviceType);

      List<pb.TransactionStatus>? statuses;
      if (filters?.statuses != null && filters!.statuses!.isNotEmpty) {
        statuses = filters.statuses!.map((s) => _mapStatus(s)).toList();
      }

      final response = await grpcClient.getTransactionHistory(
        userId: userId,
        serviceType: pbServiceType,
        page: page,
        limit: limit,
        cursor: cursor,
        statuses: statuses,
        searchQuery: filters?.searchQuery,
      );

      final transactions = response.transactions
          .map((pbTx) => _convertFromProto(pbTx))
          .toList();

      return TransactionListResponse(
        transactions: transactions,
        hasMore: response.hasMore,
        currentPage: response.currentPage.toInt(),
        totalPages: response.totalPages.toInt(),
        nextCursor: response.nextCursor,
      );
    } catch (e) {
      throw Exception('Failed to fetch service transactions: $e');
    }
  }

  @override
  Future<UnifiedTransaction?> fetchTransactionById(String id) async {
    try {
      final userId = await _getUserId();

      final response = await grpcClient.getTransactionDetails(
        userId: userId,
        transactionId: id,
      );

      return _convertFromProto(response.transaction);
    } catch (e) {
      throw Exception('Failed to fetch transaction details: $e');
    }
  }

  @override
  Future<List<UnifiedTransaction>> searchTransactions(String query) async {
    try {
      final userId = await _getUserId();

      final response = await grpcClient.searchTransactions(
        userId: userId,
        query: query,
        limit: 20,
      );

      return response.transactions
          .map((pbTx) => _convertFromProto(pbTx))
          .toList();
    } catch (e) {
      throw Exception('Failed to search transactions: $e');
    }
  }

  @override
  Future<TransactionStatistics> getStatistics({
    TransactionServiceType? serviceType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final userId = await _getUserId();

      final response = await grpcClient.getTransactionStatistics(
        userId: userId,
        serviceType: serviceType != null ? _mapServiceType(serviceType) : null,
        startDate: startDate != null ? _timestampFromDateTime(startDate) : null,
        endDate: endDate != null ? _timestampFromDateTime(endDate) : null,
      );

      final countsByService = <TransactionServiceType, int>{};
      response.transactionCountsByService.forEach((key, value) {
        final serviceType = TransactionServiceType.values.firstWhere(
          (s) => s.index == key,
          orElse: () => TransactionServiceType.unknown,
        );
        countsByService[serviceType] = value.toInt();
      });

      final countsByStatus = <UnifiedTransactionStatus, int>{};
      response.transactionCountsByStatus.forEach((key, value) {
        final status = UnifiedTransactionStatus.values.firstWhere(
          (s) => s.index == key,
          orElse: () => UnifiedTransactionStatus.pending,
        );
        countsByStatus[status] = value.toInt();
      });

      return TransactionStatistics(
        totalIncoming: response.totalIncoming,
        totalOutgoing: response.totalOutgoing,
        netBalance: response.netBalance,
        totalTransactions: response.totalTransactions.toInt(),
        transactionCountsByService: countsByService,
        transactionCountsByStatus: countsByStatus,
      );
    } catch (e) {
      throw Exception('Failed to fetch statistics: $e');
    }
  }

  @override
  Future<void> refreshTransactions() async {
    try {
      final userId = await _getUserId();

      await grpcClient.refreshTransactions(userId: userId);
    } catch (e) {
      throw Exception('Failed to refresh transactions: $e');
    }
  }

  @override
  Future<void> cacheTransactions(List<UnifiedTransaction> transactions) async {
    // Implement with local database (SQLite or Hive)
    // For now, this is a no-op since the service handles caching
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<List<UnifiedTransaction>> getCachedTransactions() async {
    // Implement with local database
    // For now, return empty list
    return [];
  }

  // HTTP fallback method
  Future<TransactionListResponse> _fetchViaHttp(
    String userId,
    int page,
    int limit,
    TransactionFilters? filters,
  ) async {
    final token = await _getAuthToken();

    final queryParams = <String, dynamic>{
      'user_id': userId,
      'page': page.toString(),
      'limit': limit.toString(),
    };

    if (filters?.searchQuery != null) {
      queryParams['search_query'] = filters!.searchQuery;
    }
    if (filters?.minAmount != null) {
      queryParams['min_amount'] = filters!.minAmount.toString();
    }
    if (filters?.maxAmount != null) {
      queryParams['max_amount'] = filters!.maxAmount.toString();
    }

    final response = await httpClient.get(
      '/api/v1/transactions/history',
      queryParameters: queryParams,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final transactions = (data['transactions'] as List)
          .map((item) => UnifiedTransaction.fromJson(item as Map<String, dynamic>))
          .toList();

      return TransactionListResponse(
        transactions: transactions,
        hasMore: data['has_more'] as bool? ?? false,
        currentPage: data['current_page'] as int? ?? page,
        totalPages: data['total_pages'] as int? ?? 1,
        nextCursor: data['next_cursor'] as String?,
      );
    } else {
      throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
    }
  }

  // Conversion helpers
  pb.TransactionServiceType _mapServiceType(TransactionServiceType type) {
    switch (type) {
      case TransactionServiceType.airtime:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_AIRTIME;
      case TransactionServiceType.giftCard:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_GIFT_CARD;
      case TransactionServiceType.electricity:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_ELECTRICITY;
      case TransactionServiceType.water:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_WATER;
      case TransactionServiceType.tvSubscription:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_TV_SUBSCRIPTION;
      case TransactionServiceType.transfer:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_TRANSFER;
      case TransactionServiceType.crypto:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_CRYPTO;
      case TransactionServiceType.stocks:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_STOCKS;
      case TransactionServiceType.insurance:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_INSURANCE;
      case TransactionServiceType.invoice:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_INVOICE;
      case TransactionServiceType.barcodePayment:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_BARCODE_PAYMENT;
      case TransactionServiceType.tagPay:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_TAG_PAY;
      case TransactionServiceType.crowdfund:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_CROWDFUND;
      case TransactionServiceType.autosave:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_AUTOSAVE;
      case TransactionServiceType.deposit:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_DEPOSIT;
      case TransactionServiceType.withdrawal:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_WITHDRAWAL;
      default:
        return pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_UNKNOWN;
    }
  }

  pb.TransactionStatus _mapStatus(UnifiedTransactionStatus status) {
    switch (status) {
      case UnifiedTransactionStatus.pending:
        return pb.TransactionStatus.TRANSACTION_STATUS_PENDING;
      case UnifiedTransactionStatus.processing:
        return pb.TransactionStatus.TRANSACTION_STATUS_PROCESSING;
      case UnifiedTransactionStatus.completed:
        return pb.TransactionStatus.TRANSACTION_STATUS_COMPLETED;
      case UnifiedTransactionStatus.failed:
        return pb.TransactionStatus.TRANSACTION_STATUS_FAILED;
      case UnifiedTransactionStatus.cancelled:
        return pb.TransactionStatus.TRANSACTION_STATUS_CANCELLED;
      case UnifiedTransactionStatus.refunded:
        return pb.TransactionStatus.TRANSACTION_STATUS_REFUNDED;
      case UnifiedTransactionStatus.expired:
        return pb.TransactionStatus.TRANSACTION_STATUS_EXPIRED;
    }
  }

  pb.TransactionFlow _mapFlow(TransactionFlow flow) {
    switch (flow) {
      case TransactionFlow.incoming:
        return pb.TransactionFlow.TRANSACTION_FLOW_INCOMING;
      case TransactionFlow.outgoing:
        return pb.TransactionFlow.TRANSACTION_FLOW_OUTGOING;
      case TransactionFlow.neutral:
        return pb.TransactionFlow.TRANSACTION_FLOW_NEUTRAL;
    }
  }

  TransactionFlow _mapFlowFromProto(pb.TransactionFlow flow) {
    switch (flow) {
      case pb.TransactionFlow.TRANSACTION_FLOW_INCOMING:
        return TransactionFlow.incoming;
      case pb.TransactionFlow.TRANSACTION_FLOW_OUTGOING:
        return TransactionFlow.outgoing;
      case pb.TransactionFlow.TRANSACTION_FLOW_NEUTRAL:
        return TransactionFlow.neutral;
      default:
        return TransactionFlow.neutral;
    }
  }

  UnifiedTransactionStatus _mapStatusFromProto(pb.TransactionStatus status) {
    switch (status) {
      case pb.TransactionStatus.TRANSACTION_STATUS_PENDING:
        return UnifiedTransactionStatus.pending;
      case pb.TransactionStatus.TRANSACTION_STATUS_PROCESSING:
        return UnifiedTransactionStatus.processing;
      case pb.TransactionStatus.TRANSACTION_STATUS_COMPLETED:
        return UnifiedTransactionStatus.completed;
      case pb.TransactionStatus.TRANSACTION_STATUS_FAILED:
        return UnifiedTransactionStatus.failed;
      case pb.TransactionStatus.TRANSACTION_STATUS_CANCELLED:
        return UnifiedTransactionStatus.cancelled;
      case pb.TransactionStatus.TRANSACTION_STATUS_REFUNDED:
        return UnifiedTransactionStatus.refunded;
      case pb.TransactionStatus.TRANSACTION_STATUS_EXPIRED:
        return UnifiedTransactionStatus.expired;
      default:
        return UnifiedTransactionStatus.pending;
    }
  }

  TransactionServiceType _mapServiceTypeFromProto(pb.TransactionServiceType type) {
    switch (type) {
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_AIRTIME:
        return TransactionServiceType.airtime;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_GIFT_CARD:
        return TransactionServiceType.giftCard;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_ELECTRICITY:
        return TransactionServiceType.electricity;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_WATER:
        return TransactionServiceType.water;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_TV_SUBSCRIPTION:
        return TransactionServiceType.tvSubscription;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_TRANSFER:
        return TransactionServiceType.transfer;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_CRYPTO:
        return TransactionServiceType.crypto;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_STOCKS:
        return TransactionServiceType.stocks;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_INSURANCE:
        return TransactionServiceType.insurance;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_INVOICE:
        return TransactionServiceType.invoice;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_BARCODE_PAYMENT:
        return TransactionServiceType.barcodePayment;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_TAG_PAY:
        return TransactionServiceType.tagPay;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_CROWDFUND:
        return TransactionServiceType.crowdfund;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_AUTOSAVE:
        return TransactionServiceType.autosave;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_DEPOSIT:
        return TransactionServiceType.deposit;
      case pb.TransactionServiceType.TRANSACTION_SERVICE_TYPE_WITHDRAWAL:
        return TransactionServiceType.withdrawal;
      default:
        return TransactionServiceType.unknown;
    }
  }

  UnifiedTransaction _convertFromProto(pb.TransactionHistoryItem pbTx) {
    return UnifiedTransaction(
      id: pbTx.id.toString(),
      serviceType: _mapServiceTypeFromProto(pbTx.serviceType),
      title: pbTx.title,
      description: pbTx.description.isEmpty ? null : pbTx.description,
      amount: pbTx.amount,
      currency: pbTx.currency,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        pbTx.createdAt.seconds * 1000 + (pbTx.createdAt.nanos ~/ 1000000).toInt(),
      ),
      status: _mapStatusFromProto(pbTx.status),
      flow: _mapFlowFromProto(pbTx.flow),
      transactionReference: pbTx.transactionReference.isEmpty ? null : pbTx.transactionReference,
      metadata: pbTx.metadata.isEmpty ? null : pbTx.metadata,
    );
  }

  // DateTime to Proto Timestamp
  google_timestamp.Timestamp _timestampFromDateTime(DateTime dateTime) {
    final milliseconds = dateTime.millisecondsSinceEpoch;
    final seconds = milliseconds ~/ 1000;
    final nanos = ((milliseconds % 1000) * 1000000).toInt();

    return google_timestamp.Timestamp()
      ..seconds = Int64(seconds)
      ..nanos = Int32(nanos);
  }
}
