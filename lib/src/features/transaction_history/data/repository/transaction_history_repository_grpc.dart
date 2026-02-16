import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/generated/accounts.pb.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/types/transaction_service_mapping.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/transaction_history/data/datasources/transaction_history_cache_datasource.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';

/// gRPC-based Transaction History Repository
/// Uses gRPC for communication with the accounts microservice
///
/// Architecture Notes:
/// - Transaction history is now integrated into the accounts microservice
/// - Uses account_id from AccountManager (not user_id)
/// - Locale is automatically derived from the account
/// - Service name filtering allows for service-specific views
class TransactionHistoryRepositoryGrpc implements TransactionHistoryRepository {
  final AccountsGrpcClient grpcClient;
  final TransactionHistoryCacheDataSource cacheDataSource;
  final AccountManager accountManager;
  final FlutterSecureStorage storage;

  // Cache TTL - 5 minutes
  static const _cacheTTL = Duration(minutes: 5);

  TransactionHistoryRepositoryGrpc({
    required this.grpcClient,
    required this.accountManager,
    TransactionHistoryCacheDataSource? cacheDataSource,
    FlutterSecureStorage? storage,
  })  : cacheDataSource = cacheDataSource ?? TransactionHistoryCacheDataSource(),
        storage = storage ?? const FlutterSecureStorage();

  @override
  Future<TransactionListResponse> fetchAllTransactions({
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  }) async {
    try {
      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      // Try cache first
      final userId = await storage.read(key: 'user_id');
      if (page == 1 && userId != null && !_shouldBypassCache(filters)) {
        try {
          final cached = await cacheDataSource.getCachedTransactions(
            userId: userId,
            limit: limit,
          );

          if (cached.isNotEmpty) {
            return TransactionListResponse(
              transactions: cached,
              hasMore: false,
              currentPage: page,
              totalPages: 1,
              nextCursor: null,
            );
          }
        } catch (e) {
          // Cache miss or error, continue to network
        }
      }

      // Map filters to accounts-service parameters
      String? typeFilter;
      if (filters?.flows?.isNotEmpty == true) {
        typeFilter = filters!.flows!.first == TransactionFlow.incoming
            ? 'credit'
            : 'debit';
      }

      // Fetch from gRPC server
      final response = await grpcClient.getTransactionHistory(
        accountId: accountId,
        type: typeFilter,
        category: filters?.serviceTypes?.isNotEmpty == true
            ? _mapServiceTypeToCategory(filters!.serviceTypes!.first)
            : null,
        status: filters?.statuses?.isNotEmpty == true
            ? _mapStatusToString(filters!.statuses!.first)
            : null,
        serviceName: filters?.serviceTypes?.isNotEmpty == true
            ? _mapServiceTypeToServiceName(filters!.serviceTypes!.first)
            : null,
        startDate: filters?.startDate,
        endDate: filters?.endDate,
        limit: limit,
        offset: (page - 1) * limit,
      );

      // Convert proto transactions to unified transactions
      var transactions = response.transactions.map(_convertFromProto).toList();

      // Apply local search filter if set
      if (filters?.searchQuery?.isNotEmpty == true) {
        final query = filters!.searchQuery!.toLowerCase();
        transactions = transactions.where((tx) =>
          tx.title.toLowerCase().contains(query) ||
          tx.description?.toLowerCase().contains(query) == true ||
          tx.counterpartyName?.toLowerCase().contains(query) == true ||
          tx.transactionReference?.toLowerCase().contains(query) == true
        ).toList();
      }

      // Cache the results
      if (page == 1 && transactions.isNotEmpty && userId != null) {
        try {
          await cacheDataSource.cacheTransactions(
            userId,
            transactions,
            _cacheTTL,
          );
        } catch (e) {
          // Cache failure is not critical
        }
      }

      // Determine if there are more pages
      final hasMore = transactions.length == limit;
      final totalPages = (response.total / limit).ceil();

      return TransactionListResponse(
        transactions: transactions,
        hasMore: hasMore,
        currentPage: page,
        totalPages: totalPages,
        nextCursor: null,
      );
    } catch (e) {
      throw Exception('Failed to fetch transaction history: $e');
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
      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      // Try cache first for page 1
      final userId = await storage.read(key: 'user_id');
      if (page == 1 && userId != null) {
        try {
          final cached = await cacheDataSource.getCachedTransactions(
            userId: userId,
            serviceType: serviceType,
            limit: limit,
          );

          if (cached.isNotEmpty) {
            return TransactionListResponse(
              transactions: cached,
              hasMore: false,
              currentPage: page,
              totalPages: 1,
              nextCursor: null,
            );
          }
        } catch (e) {
          // Cache miss, continue to network
        }
      }

      final response = await grpcClient.getTransactionHistory(
        accountId: accountId,
        serviceName: _mapServiceTypeToServiceName(serviceType),
        status: filters?.statuses?.isNotEmpty == true
            ? _mapStatusToString(filters!.statuses!.first)
            : null,
        startDate: filters?.startDate,
        endDate: filters?.endDate,
        limit: limit,
        offset: (page - 1) * limit,
      );

      final transactions = response.transactions.map(_convertFromProto).toList();

      // Cache if first page
      if (page == 1 && transactions.isNotEmpty && userId != null) {
        try {
          await cacheDataSource.cacheTransactions(
            userId,
            transactions,
            _cacheTTL,
          );
        } catch (e) {
          // Cache failure is not critical
        }
      }

      // Determine if there are more pages
      final hasMore = transactions.length == limit;
      final totalPages = (response.total / limit).ceil();

      return TransactionListResponse(
        transactions: transactions,
        hasMore: hasMore,
        currentPage: page,
        totalPages: totalPages,
        nextCursor: null,
      );
    } catch (e) {
      throw Exception('Failed to fetch service transactions: $e');
    }
  }

  @override
  Future<UnifiedTransaction?> fetchTransactionById(String id) async {
    try {
      // Try cache first
      try {
        final cached = await cacheDataSource.getCachedTransaction(id);
        if (cached != null) {
          return cached;
        }
      } catch (e) {
        // Cache miss, continue to network
      }

      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      // Note: The accounts-service doesn't have a getTransactionById endpoint
      // We would need to fetch all transactions and filter, or add this endpoint
      // For now, return null
      return null;
    } catch (e) {
      if (e.toString().contains('not found')) {
        return null;
      }
      throw Exception('Failed to fetch transaction: $e');
    }
  }

  @override
  Future<List<UnifiedTransaction>> searchTransactions(String query) async {
    try {
      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      // Note: The accounts-service doesn't have a search endpoint
      // We fetch all transactions and filter locally
      final response = await grpcClient.getTransactionHistory(
        accountId: accountId,
        limit: 100, // Fetch a larger set for searching
      );

      return response.transactions
          .map(_convertFromProto)
          .where((tx) =>
              tx.description?.toLowerCase().contains(query.toLowerCase()) == true ||
              tx.transactionReference?.toLowerCase().contains(query.toLowerCase()) == true)
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
      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      final response = await grpcClient.getTransactionStatistics(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
      );

      // Convert proto statistics to unified statistics
      final transactionCountsByService = <TransactionServiceType, int>{};
      for (final entry in response.transactionsByService.entries) {
        final serviceType = _mapServiceNameToServiceType(entry.key);
        transactionCountsByService[serviceType] = entry.value.toInt();
      }

      return TransactionStatistics(
        totalIncoming: response.totalCredits,
        totalOutgoing: response.totalDebits,
        netBalance: response.netBalance,
        totalTransactions: response.totalTransactions,
        transactionCountsByService: transactionCountsByService,
        transactionCountsByStatus: {}, // Empty for now, not provided by backend
      );
    } catch (e) {
      throw Exception('Failed to fetch statistics: $e');
    }
  }

  @override
  Future<List<UnifiedTransaction>> fetchTransactionsForExport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      // Fetch up to 500 transactions for export
      final response = await grpcClient.getTransactionHistory(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
        limit: 500,
        offset: 0,
      );

      return response.transactions.map(_convertFromProto).toList();
    } catch (e) {
      throw Exception('Failed to fetch transactions for export: $e');
    }
  }

  @override
  Future<void> refreshTransactions() async {
    try {
      final accountId = accountManager.activeAccountId;
      if (accountId == null) {
        throw Exception('No active account selected');
      }

      // Clear cache after refresh
      final userId = await storage.read(key: 'user_id');
      if (userId != null) {
        await cacheDataSource.clearUserTransactions(userId);
      }

      // Note: The accounts-service doesn't have a refresh endpoint
      // Fetching fresh transactions will happen on next call
    } catch (e) {
      throw Exception('Failed to refresh transactions: $e');
    }
  }

  @override
  Future<void> cacheTransactions(List<UnifiedTransaction> transactions) async {
    final userId = await storage.read(key: 'user_id');
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await cacheDataSource.cacheTransactions(
      userId,
      transactions,
      _cacheTTL,
    );
  }

  @override
  Future<List<UnifiedTransaction>> getCachedTransactions() async {
    final userId = await storage.read(key: 'user_id');
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return await cacheDataSource.getCachedTransactions(userId: userId);
  }

  // Helper methods
  bool _shouldBypassCache(TransactionFilters? filters) {
    // Bypass cache if there are filters that can't be handled locally
    if (filters == null || !filters.hasFilters) return false;

    // Date range filters bypass cache
    if (filters.startDate != null || filters.endDate != null) return true;

    // Amount range filters bypass cache
    if (filters.minAmount != null || filters.maxAmount != null) return true;

    return false;
  }

  /// Convert proto Transaction to UnifiedTransaction
  UnifiedTransaction _convertFromProto(Transaction protoTx) {
    // Parse createdAt from ISO8601 string
    final createdAt = DateTime.tryParse(protoTx.createdAt) ?? DateTime.now();

    // Determine transaction flow from type
    final flow = protoTx.type.toLowerCase() == 'credit'
        ? TransactionFlow.incoming
        : protoTx.type.toLowerCase() == 'debit'
            ? TransactionFlow.outgoing
            : TransactionFlow.neutral;

    // Map service name to service type
    final serviceType = protoTx.serviceName.isNotEmpty
        ? _mapServiceNameToServiceType(protoTx.serviceName)
        : TransactionServiceType.unknown;

    // Map status
    final status = _mapStatusFromProto(protoTx.status);

    // Build metadata: start with parsed JSON metadata, then merge in
    // proto-level fields that receipt screens need for display.
    final metadata = <String, dynamic>{};
    if (protoTx.metadata.isNotEmpty) {
      final parsed = _parseMetadata(protoTx.metadata);
      if (parsed != null) metadata.addAll(parsed);
    }
    if (protoTx.balanceBefore != 0 || protoTx.balanceAfter != 0) {
      metadata['balance_before'] = protoTx.balanceBefore;
      metadata['balance_after'] = protoTx.balanceAfter;
    }

    // Extract counterparty info: prefer proto fields, fallback to metadata
    String? counterpartyName = protoTx.counterpartyName.isNotEmpty
        ? protoTx.counterpartyName
        : (metadata['recipient_name'] as String?
            ?? metadata['counterparty_name'] as String?);
    String? counterpartyAccount = protoTx.counterpartyAccount.isNotEmpty
        ? protoTx.counterpartyAccount
        : (metadata['recipient_account'] as String?
            ?? metadata['counterparty_account'] as String?);

    // Fallback: try to parse account number from description
    if (counterpartyAccount == null && protoTx.description.isNotEmpty) {
      final accountMatch = RegExp(r'\b(\d{10,})\b').firstMatch(protoTx.description);
      if (accountMatch != null) {
        counterpartyAccount = accountMatch.group(1);
      }
    }

    // Generate title, enriched with counterparty name for transfers
    String title = _generateTransactionTitle(protoTx.category, protoTx.type);
    if (counterpartyName != null && counterpartyName.isNotEmpty) {
      final categoryLower = protoTx.category.toLowerCase();
      final typeLower = protoTx.type.toLowerCase();
      if (categoryLower.contains('transfer')) {
        title = typeLower == 'credit'
            ? 'Transfer from $counterpartyName'
            : 'Transfer to $counterpartyName';
      }
    }

    return UnifiedTransaction(
      id: protoTx.id,
      serviceType: serviceType,
      title: title,
      description: protoTx.description.isNotEmpty ? protoTx.description : null,
      amount: protoTx.amount,
      currency: accountManager.activeAccountDetails?.currency ?? 'NGN',
      createdAt: createdAt,
      status: status,
      flow: flow,
      transactionReference: protoTx.reference.isNotEmpty ? protoTx.reference : null,
      metadata: metadata.isNotEmpty ? metadata : null,
      counterpartyName: counterpartyName,
      counterpartyAccount: counterpartyAccount,
    );
  }

  /// Generate a user-friendly transaction title
  String _generateTransactionTitle(String category, String type) {
    final categoryLower = category.toLowerCase();
    final typeLower = type.toLowerCase();

    if (categoryLower.contains('airtime')) {
      return typeLower == 'credit' ? 'Airtime Top-up' : 'Airtime Purchase';
    } else if (categoryLower.contains('transfer')) {
      return typeLower == 'credit' ? 'Transfer Received' : 'Transfer Sent';
    } else if (categoryLower.contains('gift')) {
      return 'Gift Card Purchase';
    } else if (categoryLower.contains('electricity')) {
      return 'Electricity Bill Payment';
    } else if (categoryLower.contains('deposit')) {
      return 'Account Deposit';
    } else if (categoryLower.contains('withdrawal')) {
      return 'Account Withdrawal';
    } else if (categoryLower.contains('invoice')) {
      return typeLower == 'credit' ? 'Invoice Received' : 'Invoice Payment';
    } else if (categoryLower.contains('crypto')) {
      return typeLower == 'credit' ? 'Crypto Sale' : 'Crypto Purchase';
    } else if (categoryLower.contains('stock')) {
      return typeLower == 'credit' ? 'Stock Sale' : 'Stock Purchase';
    } else if (categoryLower.contains('insurance')) {
      return 'Insurance Payment';
    } else if (categoryLower.contains('tag')) {
      return typeLower == 'credit' ? 'Tag Payment Received' : 'Tag Payment Sent';
    } else if (categoryLower.contains('barcode')) {
      return 'Barcode Payment';
    } else if (categoryLower.contains('crowdfund') || categoryLower.contains('donation')) {
      return 'Donation';
    } else if (categoryLower.contains('autosave') || categoryLower.contains('auto_save')) {
      return 'AutoSave Deposit';
    } else if (categoryLower.contains('water')) {
      return 'Water Bill Payment';
    } else if (categoryLower.contains('tv') || categoryLower.contains('subscription')) {
      return 'TV Subscription';
    } else {
      return typeLower == 'credit' ? 'Credit' : 'Debit';
    }
  }

  /// Parse metadata JSON string to Map
  Map<String, dynamic>? _parseMetadata(String metadataJson) {
    try {
      final decoded = jsonDecode(metadataJson);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Map TransactionServiceType to service name string using centralized mapping
  String? _mapServiceTypeToServiceName(TransactionServiceType type) {
    return type.backendServiceName;
  }

  /// Map service name string to TransactionServiceType using centralized mapping
  TransactionServiceType _mapServiceNameToServiceType(String serviceName) {
    // Try to find matching AppServiceName by backend service name
    for (final appService in AppServiceName.values) {
      if (appService.backendServiceName == serviceName) {
        final txType = appService.toTransactionServiceType;
        return txType;
            }
    }

    // Fallback for services not in AppServiceName enum
    final serviceLower = serviceName.toLowerCase();
    if (serviceLower.contains('deposit')) return TransactionServiceType.deposit;
    if (serviceLower.contains('withdrawal')) return TransactionServiceType.withdrawal;

    return TransactionServiceType.unknown;
  }

  /// Map TransactionServiceType to category string
  String? _mapServiceTypeToCategory(TransactionServiceType type) {
    switch (type) {
      case TransactionServiceType.airtime:
        return 'airtime';
      case TransactionServiceType.giftCard:
        return 'gift_card';
      case TransactionServiceType.electricity:
        return 'utility';
      case TransactionServiceType.transfer:
        return 'transfer';
      case TransactionServiceType.crypto:
        return 'investment';
      case TransactionServiceType.stocks:
        return 'investment';
      case TransactionServiceType.insurance:
        return 'insurance';
      case TransactionServiceType.invoice:
        return 'invoice';
      case TransactionServiceType.deposit:
        return 'deposit';
      case TransactionServiceType.withdrawal:
        return 'withdrawal';
      default:
        return null;
    }
  }

  /// Map UnifiedTransactionStatus to proto status string
  String? _mapStatusToString(UnifiedTransactionStatus status) {
    switch (status) {
      case UnifiedTransactionStatus.pending:
        return 'pending';
      case UnifiedTransactionStatus.processing:
        return 'processing';
      case UnifiedTransactionStatus.completed:
        return 'completed';
      case UnifiedTransactionStatus.failed:
        return 'failed';
      case UnifiedTransactionStatus.cancelled:
        return 'cancelled';
      case UnifiedTransactionStatus.refunded:
        return 'refunded';
      case UnifiedTransactionStatus.expired:
        return 'expired';
    }
  }

  /// Map proto status string to UnifiedTransactionStatus
  UnifiedTransactionStatus _mapStatusFromProto(String status) {
    final statusLower = status.toLowerCase();
    if (statusLower == 'completed') return UnifiedTransactionStatus.completed;
    if (statusLower == 'pending') return UnifiedTransactionStatus.pending;
    if (statusLower == 'processing') return UnifiedTransactionStatus.processing;
    if (statusLower == 'failed') return UnifiedTransactionStatus.failed;
    if (statusLower == 'cancelled') return UnifiedTransactionStatus.cancelled;
    if (statusLower == 'refunded') return UnifiedTransactionStatus.refunded;
    if (statusLower == 'expired') return UnifiedTransactionStatus.expired;
    return UnifiedTransactionStatus.pending;
  }
}
