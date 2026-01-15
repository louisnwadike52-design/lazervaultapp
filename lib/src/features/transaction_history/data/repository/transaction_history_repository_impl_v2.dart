import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';
import 'package:lazervault/src/features/transaction_history/data/datasources/transaction_history_remote_datasource.dart';

/// Production-ready implementation of transaction history repository
/// Supports both real API calls and mock data for development
class TransactionHistoryRepositoryImplV2 implements TransactionHistoryRepository {
  final TransactionHistoryRemoteDataSource remoteDataSource;
  final bool useMockData; // Set to false to use real API

  TransactionHistoryRepositoryImplV2({
    required this.remoteDataSource,
    this.useMockData = true, // Default to mock for development
  });

  // Mock data for development (can be removed in production)
  final List<UnifiedTransaction> _mockTransactions = [];

  void _initializeMockData() {
    if (_mockTransactions.isNotEmpty) return;

    final now = DateTime.now();
    _mockTransactions.addAll([
      // Airtime transactions
      UnifiedTransaction(
        id: 'txn_airtime_1',
        serviceType: TransactionServiceType.airtime,
        title: 'MTN Airtime',
        description: '080123456789',
        amount: 1000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(hours: 2)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_AIRTIME_001',
        metadata: {'networkProvider': 'MTN', 'recipientName': 'John Doe'},
      ),
      UnifiedTransaction(
        id: 'txn_airtime_2',
        serviceType: TransactionServiceType.airtime,
        title: 'Airtel Airtime',
        description: '080987654321',
        amount: 500.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 1)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_AIRTIME_002',
        metadata: {'networkProvider': 'Airtel', 'recipientName': 'Jane Smith'},
      ),
      UnifiedTransaction(
        id: 'txn_airtime_3',
        serviceType: TransactionServiceType.airtime,
        title: 'Glo Airtime',
        description: '07055555555',
        amount: 2000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 2)),
        status: UnifiedTransactionStatus.failed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_AIRTIME_003',
        metadata: {'networkProvider': 'Glo', 'recipientName': 'Bob Johnson'},
      ),

      // Gift Card transactions
      UnifiedTransaction(
        id: 'txn_gift_1',
        serviceType: TransactionServiceType.giftCard,
        title: 'Amazon Gift Card',
        description: 'Purchased \$100 Amazon gift card',
        amount: 100.0,
        currency: 'USD',
        createdAt: now.subtract(const Duration(hours: 5)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_GIFT_001',
        metadata: {'brandName': 'Amazon', 'transactionType': 'purchase'},
      ),
      UnifiedTransaction(
        id: 'txn_gift_2',
        serviceType: TransactionServiceType.giftCard,
        title: 'iTunes Gift Card',
        description: 'Redeemed iTunes gift card',
        amount: 50.0,
        currency: 'USD',
        createdAt: now.subtract(const Duration(days: 1, hours: 3)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.neutral,
        transactionReference: 'REF_GIFT_002',
        metadata: {'brandName': 'iTunes', 'transactionType': 'redeem'},
      ),
      UnifiedTransaction(
        id: 'txn_gift_3',
        serviceType: TransactionServiceType.giftCard,
        title: 'Target Gift Card',
        description: 'Sold gift card to marketplace',
        amount: 75.0,
        currency: 'USD',
        createdAt: now.subtract(const Duration(days: 3)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.incoming,
        transactionReference: 'REF_GIFT_003',
        metadata: {'brandName': 'Target', 'transactionType': 'sell'},
      ),

      // Electricity transactions
      UnifiedTransaction(
        id: 'txn_electricity_1',
        serviceType: TransactionServiceType.electricity,
        title: 'Electricity Bill',
        description: 'Meter: 12345678901',
        amount: 15000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 1, hours: 6)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_ELEC_001',
        metadata: {
          'meterNumber': '12345678901',
          'customerName': 'John Doe',
          'units': '250.5'
        },
      ),
      UnifiedTransaction(
        id: 'txn_electricity_2',
        serviceType: TransactionServiceType.electricity,
        title: 'Electricity Bill',
        description: 'Meter: 98765432109',
        amount: 20000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 5)),
        status: UnifiedTransactionStatus.pending,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_ELEC_002',
        metadata: {
          'meterNumber': '98765432109',
          'customerName': 'Jane Smith',
          'units': '350.0'
        },
      ),

      // Transfer transactions
      UnifiedTransaction(
        id: 'txn_transfer_1',
        serviceType: TransactionServiceType.transfer,
        title: 'Transfer to John Doe',
        description: 'Bank: GTBank',
        amount: 50000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(hours: 8)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_TRANSFER_001',
        metadata: {'bankName': 'GTBank', 'accountNumber': '0123456789'},
      ),
      UnifiedTransaction(
        id: 'txn_transfer_2',
        serviceType: TransactionServiceType.transfer,
        title: 'Transfer from Jane Smith',
        description: 'Bank: Access Bank',
        amount: 25000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 2)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.incoming,
        transactionReference: 'REF_TRANSFER_002',
        metadata: {'bankName': 'Access Bank', 'accountNumber': '0987654321'},
      ),

      // Crypto transactions
      UnifiedTransaction(
        id: 'txn_crypto_1',
        serviceType: TransactionServiceType.crypto,
        title: 'Bitcoin Purchase',
        description: '0.005 BTC',
        amount: 500.0,
        currency: 'USD',
        createdAt: now.subtract(const Duration(days: 1, hours: 12)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_CRYPTO_001',
        metadata: {'crypto': 'BTC', 'amount': '0.005'},
      ),
      UnifiedTransaction(
        id: 'txn_crypto_2',
        serviceType: TransactionServiceType.crypto,
        title: 'Ethereum Sale',
        description: '0.1 ETH',
        amount: 200.0,
        currency: 'USD',
        createdAt: now.subtract(const Duration(days: 4)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.incoming,
        transactionReference: 'REF_CRYPTO_002',
        metadata: {'crypto': 'ETH', 'amount': '0.1'},
      ),

      // Stock transactions
      UnifiedTransaction(
        id: 'txn_stock_1',
        serviceType: TransactionServiceType.stocks,
        title: 'Apple Stock Purchase',
        description: '10 shares AAPL',
        amount: 1750.0,
        currency: 'USD',
        createdAt: now.subtract(const Duration(days: 3)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_STOCK_001',
        metadata: {'symbol': 'AAPL', 'shares': 10},
      ),

      // Deposit transaction
      UnifiedTransaction(
        id: 'txn_deposit_1',
        serviceType: TransactionServiceType.deposit,
        title: 'Card Deposit',
        description: 'Deposit via **** 1234',
        amount: 100000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 6)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.incoming,
        transactionReference: 'REF_DEPOSIT_001',
        metadata: {'cardLast4': '1234', 'bank': 'GTBank'},
      ),

      // Invoice payment
      UnifiedTransaction(
        id: 'txn_invoice_1',
        serviceType: TransactionServiceType.invoice,
        title: 'Invoice Payment',
        description: 'INV-2024-001',
        amount: 45000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 7)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_INVOICE_001',
        metadata: {'invoiceNumber': 'INV-2024-001', 'vendor': 'ABC Corp'},
      ),

      // Tag Pay transaction
      UnifiedTransaction(
        id: 'txn_tagpay_1',
        serviceType: TransactionServiceType.tagPay,
        title: 'Tag Payment Received',
        description: 'From @johndoe',
        amount: 5000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(hours: 24)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.incoming,
        transactionReference: 'REF_TAG_001',
        metadata: {'sender': '@johndoe', 'tag': '#personal'},
      ),

      // Insurance payment
      UnifiedTransaction(
        id: 'txn_insurance_1',
        serviceType: TransactionServiceType.insurance,
        title: 'Insurance Premium',
        description: 'Health Insurance - Monthly',
        amount: 15000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 10)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_INS_001',
        metadata: {'policyType': 'Health', 'duration': 'Monthly'},
      ),

      // AutoSave transaction
      UnifiedTransaction(
        id: 'txn_autosave_1',
        serviceType: TransactionServiceType.autosave,
        title: 'AutoSave Deposit',
        description: 'Weekly savings',
        amount: 10000.0,
        currency: 'NGN',
        createdAt: now.subtract(const Duration(days: 8)),
        status: UnifiedTransactionStatus.completed,
        flow: TransactionFlow.outgoing,
        transactionReference: 'REF_AUTOSAVE_001',
        metadata: {'frequency': 'Weekly', 'goal': 'Emergency Fund'},
      ),
    ]);

    _mockTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<TransactionListResponse> fetchAllTransactions({
    int page = 1,
    int limit = 20,
    String? cursor,
    TransactionFilters? filters,
  }) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 800));
      _initializeMockData();

      List<UnifiedTransaction> transactions = List.from(_mockTransactions);

      // Apply filters
      if (filters != null) {
        if (filters.serviceTypes != null && filters.serviceTypes!.isNotEmpty) {
          transactions = transactions
              .where((t) => filters.serviceTypes!.contains(t.serviceType))
              .toList();
        }
        if (filters.statuses != null && filters.statuses!.isNotEmpty) {
          transactions = transactions
              .where((t) => filters.statuses!.contains(t.status))
              .toList();
        }
        if (filters.startDate != null) {
          transactions = transactions
              .where((t) => t.createdAt.isAfter(filters.startDate!))
              .toList();
        }
        if (filters.endDate != null) {
          transactions = transactions
              .where((t) => t.createdAt.isBefore(filters.endDate!))
              .toList();
        }
        if (filters.minAmount != null) {
          transactions = transactions
              .where((t) => t.amount >= filters.minAmount!)
              .toList();
        }
        if (filters.maxAmount != null) {
          transactions = transactions
              .where((t) => t.amount <= filters.maxAmount!)
              .toList();
        }
        if (filters.searchQuery != null && filters.searchQuery!.isNotEmpty) {
          final query = filters.searchQuery!.toLowerCase();
          transactions = transactions
              .where((t) =>
                  t.title.toLowerCase().contains(query) ||
                  (t.description?.toLowerCase().contains(query) ?? false))
              .toList();
        }
      }

      // Pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      final paginatedTransactions = startIndex < transactions.length
          ? transactions.sublist(startIndex, endIndex.clamp(0, transactions.length))
          : <UnifiedTransaction>[];

      return TransactionListResponse(
        transactions: paginatedTransactions,
        hasMore: endIndex < transactions.length,
        currentPage: page,
        totalPages: (transactions.length / limit).ceil(),
        nextCursor: endIndex < transactions.length ? 'page_${page + 1}' : null,
      );
    } else {
      // Use real API
      final data = await remoteDataSource.fetchAllTransactions(
        page: page,
        limit: limit,
        cursor: cursor,
        filters: filters?.toJson(),
      );
      return remoteDataSource.parseTransactionListResponse(data);
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
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 600));
      _initializeMockData();

      final serviceTransactions = _mockTransactions
          .where((t) => t.serviceType == serviceType)
          .toList();

      // Apply additional filters
      List<UnifiedTransaction> filteredTransactions = serviceTransactions;
      if (filters != null) {
        if (filters.statuses != null && filters.statuses!.isNotEmpty) {
          filteredTransactions = filteredTransactions
              .where((t) => filters.statuses!.contains(t.status))
              .toList();
        }
        if (filters.searchQuery != null && filters.searchQuery!.isNotEmpty) {
          final query = filters.searchQuery!.toLowerCase();
          filteredTransactions = filteredTransactions
              .where((t) =>
                  t.title.toLowerCase().contains(query) ||
                  (t.description?.toLowerCase().contains(query) ?? false))
              .toList();
        }
      }

      // Pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      final paginatedTransactions = startIndex < filteredTransactions.length
          ? filteredTransactions.sublist(
              startIndex, endIndex.clamp(0, filteredTransactions.length))
          : <UnifiedTransaction>[];

      return TransactionListResponse(
        transactions: paginatedTransactions,
        hasMore: endIndex < filteredTransactions.length,
        currentPage: page,
        totalPages: (filteredTransactions.length / limit).ceil(),
        nextCursor: endIndex < filteredTransactions.length ? 'page_${page + 1}' : null,
      );
    } else {
      // Use real API
      final data = await remoteDataSource.fetchServiceTransactions(
        serviceType.name,
        page: page,
        limit: limit,
        cursor: cursor,
        filters: filters?.toJson(),
      );
      return remoteDataSource.parseTransactionListResponse(data);
    }
  }

  @override
  Future<UnifiedTransaction?> fetchTransactionById(String id) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      _initializeMockData();
      try {
        return _mockTransactions.firstWhere((t) => t.id == id);
      } catch (e) {
        return null;
      }
    } else {
      // Use real API
      final data = await remoteDataSource.fetchTransactionById(id);
      return UnifiedTransaction.fromJson(data);
    }
  }

  @override
  Future<List<UnifiedTransaction>> searchTransactions(String query) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      _initializeMockData();
      final lowerQuery = query.toLowerCase();
      return _mockTransactions
          .where((t) =>
              t.title.toLowerCase().contains(lowerQuery) ||
              (t.description?.toLowerCase().contains(lowerQuery) ?? false) ||
              t.transactionReference?.toLowerCase().contains(lowerQuery) == true)
          .toList();
    } else {
      // Use real API
      final data = await remoteDataSource.searchTransactions(query);
      return data.map((item) => UnifiedTransaction.fromJson(item)).toList();
    }
  }

  @override
  Future<TransactionStatistics> getStatistics({
    TransactionServiceType? serviceType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 400));
      _initializeMockData();

      List<UnifiedTransaction> transactions = List.from(_mockTransactions);

      if (serviceType != null) {
        transactions = transactions.where((t) => t.serviceType == serviceType).toList();
      }
      if (startDate != null) {
        transactions = transactions.where((t) => t.createdAt.isAfter(startDate)).toList();
      }
      if (endDate != null) {
        transactions = transactions.where((t) => t.createdAt.isBefore(endDate)).toList();
      }

      double totalIncoming = 0.0;
      double totalOutgoing = 0.0;
      final transactionCountsByService = <TransactionServiceType, int>{};
      final transactionCountsByStatus = <UnifiedTransactionStatus, int>{};

      for (final transaction in transactions) {
        if (transaction.flow == TransactionFlow.incoming) {
          totalIncoming += transaction.amount;
        } else if (transaction.flow == TransactionFlow.outgoing) {
          totalOutgoing += transaction.amount;
        }

        transactionCountsByService[transaction.serviceType] =
            (transactionCountsByService[transaction.serviceType] ?? 0) + 1;
        transactionCountsByStatus[transaction.status] =
            (transactionCountsByStatus[transaction.status] ?? 0) + 1;
      }

      return TransactionStatistics(
        totalIncoming: totalIncoming,
        totalOutgoing: totalOutgoing,
        netBalance: totalIncoming - totalOutgoing,
        totalTransactions: transactions.length,
        transactionCountsByService: transactionCountsByService,
        transactionCountsByStatus: transactionCountsByStatus,
      );
    } else {
      // Use real API
      final data = await remoteDataSource.getStatistics(
        serviceType: serviceType?.name,
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
      );
      return remoteDataSource.parseTransactionStatistics(data);
    }
  }

  @override
  Future<void> refreshTransactions() async {
    if (useMockData) {
      await Future.delayed(const Duration(seconds: 1));
      _mockTransactions.clear();
      _initializeMockData();
    } else {
      await remoteDataSource.refreshTransactions();
    }
  }

  @override
  Future<void> cacheTransactions(List<UnifiedTransaction> transactions) async {
    // TODO: Implement local caching with SQLite or Hive
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<List<UnifiedTransaction>> getCachedTransactions() async {
    // TODO: Implement local cache retrieval
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }
}

/// Extension to convert TransactionFilters to JSON
extension TransactionFiltersExtension on TransactionFilters {
  Map<String, dynamic>? toJson() {
    if (!hasFilters) return null;

    final json = <String, dynamic>{};

    if (serviceTypes != null && serviceTypes!.isNotEmpty) {
      json['serviceTypes'] = serviceTypes!.map((t) => t.name).toList();
    }
    if (statuses != null && statuses!.isNotEmpty) {
      json['statuses'] = statuses!.map((s) => s.name).toList();
    }
    if (startDate != null) {
      json['startDate'] = startDate!.toIso8601String();
    }
    if (endDate != null) {
      json['endDate'] = endDate!.toIso8601String();
    }
    if (minAmount != null) {
      json['minAmount'] = minAmount;
    }
    if (maxAmount != null) {
      json['maxAmount'] = maxAmount;
    }
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      json['searchQuery'] = searchQuery;
    }

    return json.isEmpty ? null : json;
  }
}
