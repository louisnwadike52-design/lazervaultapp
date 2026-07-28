import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/generated/accounts.pb.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/types/transaction_service_mapping.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';
import 'package:lazervault/src/features/transaction_history/data/datasources/transaction_history_cache_datasource.dart';
import 'package:lazervault/src/features/transaction_history/domain/repository/transaction_history_repository.dart';

/// gRPC-based Transaction History Repository
/// Uses gRPC for communication with the accounts microservice
///
/// Architecture Notes:
/// - Transaction history is now integrated into the accounts microservice
/// - Uses account_id from AccountManager and locale from LocaleManager
/// - Both active account and active locale are sent to filter results
/// - Service name filtering allows for service-specific views
class TransactionHistoryRepositoryGrpc implements TransactionHistoryRepository {
  final AccountsGrpcClient grpcClient;
  final TransactionHistoryCacheDataSource cacheDataSource;
  final AccountManager accountManager;
  final LocaleManager localeManager;
  final FlutterSecureStorage storage;

  // Cache TTL - 5 minutes
  static const _cacheTTL = Duration(minutes: 5);

  /// Composite cache key that scopes the local transaction cache per
  /// (user, account). The cache table keys on user_id; without the account
  /// dimension, selecting the Family & Friends card would surface the
  /// personal account's cached rows (and vice-versa). The real user id never
  /// contains "::", so this stays collision-free.
  String _accountScopedKey(String userId, String accountId) =>
      '$userId::$accountId';

  final IPaymentsTransferDataSource? _paymentsDataSource;

  TransactionHistoryRepositoryGrpc({
    required this.grpcClient,
    required this.accountManager,
    required this.localeManager,
    TransactionHistoryCacheDataSource? cacheDataSource,
    FlutterSecureStorage? storage,
    IPaymentsTransferDataSource? paymentsDataSource,
  })  : cacheDataSource = cacheDataSource ?? TransactionHistoryCacheDataSource(),
        storage = storage ?? const FlutterSecureStorage(),
        _paymentsDataSource = paymentsDataSource;

  /// Core-payments data source for merging EXTERNAL transfers (pending/failed
  /// too). Resolved lazily from the service locator when not injected, so DI
  /// registrations don't have to change.
  IPaymentsTransferDataSource? get _payments {
    if (_paymentsDataSource != null) return _paymentsDataSource;
    try {
      return serviceLocator<IPaymentsTransferDataSource>();
    } catch (_) {
      return null;
    }
  }

  /// Merge accounts-service ledger rows with core-payments external transfers,
  /// deduping by base reference + flow (a COMPLETED external transfer is in
  /// BOTH sources). Ledger rows win (richer fields); external fills in the
  /// pending/failed ones the ledger never records. Newest-first.
  List<UnifiedTransaction> _mergeExternalTransfers(
      List<UnifiedTransaction> ledger, List<UnifiedTransaction> external) {
    String keyFor(UnifiedTransaction tx) {
      // An external-transfer CAPTURE ledger row is named HOLD-CAP-<reserveId>
      // but carries the real payment reference (TRF-…) in metadata; the payments
      // source keys the same transfer as TRF-… . So ONLY for capture rows do we
      // prefer the metadata reference — that makes the two sources collide on
      // one key and stops a COMPLETED external transfer being listed twice.
      // Every other ledger row keeps its own reference, so unrelated rows that
      // happen to share a metadata.reference are never over-collapsed.
      final selfRef = tx.transactionReference ?? tx.id;
      final metaRef = (tx.metadata?['reference'] as String?)?.trim();
      final ref = (selfRef.startsWith('HOLD-CAP') &&
              metaRef != null &&
              metaRef.isNotEmpty)
          ? metaRef
          : selfRef;
      final base =
          ref.endsWith('-CR') ? ref.substring(0, ref.length - 3) : ref;
      return '${base}_${tx.flow.name}';
    }

    final byKey = <String, UnifiedTransaction>{};
    for (final tx in ledger) {
      byKey[keyFor(tx)] = tx;
    }
    for (final tx in external) {
      byKey.putIfAbsent(keyFor(tx), () => tx);
    }
    return byKey.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

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

      // Try cache first (but skip if search query is present — apply locally after).
      // Cache is scoped per (user, account) so selecting the Family & Friends
      // card doesn't surface the personal account's cached transactions, and
      // vice-versa. The cache table keys on user_id, so we pass a composite key.
      final userId = await storage.read(key: 'user_id');
      final scopedKey = userId != null ? _accountScopedKey(userId, accountId) : null;
      if (page == 1 && scopedKey != null && !_shouldBypassCache(filters)) {
        try {
          final cached = await cacheDataSource.getCachedTransactions(
            userId: scopedKey,
            limit: limit,
          );

          if (cached.isNotEmpty) {
            // Apply local search filter to cached results
            var cachedResults = cached;
            if (filters?.searchQuery?.isNotEmpty == true) {
              final query = filters!.searchQuery!.toLowerCase();
              cachedResults = cached.where((tx) =>
                tx.title.toLowerCase().contains(query) ||
                tx.description?.toLowerCase().contains(query) == true ||
                tx.counterpartyName?.toLowerCase().contains(query) == true ||
                tx.transactionReference?.toLowerCase().contains(query) == true ||
                tx.formattedAmount.toLowerCase().contains(query)
              ).toList();
            }
            return TransactionListResponse(
              transactions: cachedResults,
              hasMore: false,
              currentPage: page,
              totalPages: 1,
              nextCursor: null,
              // Stale subset (no external-transfer merge, capped hasMore) —
              // the cubit follows up with a background network refresh.
              fromCache: true,
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
        locale: localeManager.currentLocale,
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
        counterpartyAccount: filters?.counterpartyAccount,
        startDate: filters?.startDate,
        endDate: filters?.endDate,
        limit: limit,
        offset: (page - 1) * limit,
      );

      // Convert proto transactions to unified transactions
      var transactions = response.transactions.map(_convertFromProto).toList();

      // MERGE core-payments EXTERNAL transfers (pending / processing / failed /
      // reversed too). A failed or still-pending external transfer never reaches
      // the accounts-service ledger (only a hold CAPTURE writes a ledger row),
      // so without this it silently never appears in history. Merge on page 1 of
      // an UNFILTERED view (the "all recent" list the dashboard + send-funds
      // history use); dedupe by reference so a COMPLETED external transfer
      // (present in BOTH sources) isn't double-listed.
      final statusFilters =
          filters?.statuses ?? const <UnifiedTransactionStatus>[];
      final serviceFilters =
          filters?.serviceTypes ?? const <TransactionServiceType>[];
      final hasCounterparty = (filters?.counterpartyAccount?.isNotEmpty) ?? false;
      final unfiltered = statusFilters.isEmpty &&
          serviceFilters.isEmpty &&
          !hasCounterparty &&
          filters?.startDate == null &&
          filters?.endDate == null;

      // The external supplement matters not only to the unfiltered "all recent"
      // view but also when the user explicitly filters by a status the ledger
      // can NEVER hold for an external transfer (pending/processing/failed/
      // refunded/cancelled/expired — only a CAPTURE writes a ledger row) or by
      // the Transfers service. Without this, filtering "Failed" drops the exact
      // failed transfers the user is trying to see. We fetch the whole external
      // list and post-filter it locally to match the active filters. Skipped
      // when filtering by a specific counterparty account (the external source
      // isn't keyed that way).
      const externalOnlyStatuses = {
        UnifiedTransactionStatus.pending,
        UnifiedTransactionStatus.processing,
        UnifiedTransactionStatus.failed,
        UnifiedTransactionStatus.refunded, // provider 'reversed' maps here
        UnifiedTransactionStatus.cancelled,
        UnifiedTransactionStatus.expired,
      };
      final wantsExternalStatus =
          statusFilters.any(externalOnlyStatuses.contains);
      final wantsTransferService =
          serviceFilters.contains(TransactionServiceType.transfer);
      final mergeRelevant =
          unfiltered || wantsExternalStatus || wantsTransferService;

      if (page == 1 && mergeRelevant && !hasCounterparty) {
        try {
          var external = await _payments?.getExternalTransferHistory(
                accountId: accountId,
                limit: 200,
              ) ??
              const <UnifiedTransaction>[];
          // Post-filter the external rows to match the active status/service/
          // date filters (the backend filter only ran against ledger rows).
          if (statusFilters.isNotEmpty) {
            external =
                external.where((tx) => statusFilters.contains(tx.status)).toList();
          }
          if (serviceFilters.isNotEmpty) {
            external = external
                .where((tx) => serviceFilters.contains(tx.serviceType))
                .toList();
          }
          if (filters?.startDate != null) {
            external = external
                .where((tx) => !tx.createdAt.isBefore(filters!.startDate!))
                .toList();
          }
          if (filters?.endDate != null) {
            external = external
                .where((tx) => !tx.createdAt.isAfter(filters!.endDate!))
                .toList();
          }
          if (external.isNotEmpty) {
            transactions = _mergeExternalTransfers(transactions, external);
          }
        } catch (_) {
          // best-effort — never fail history because of the supplement
        }
      }

      // Apply local search filter if set
      if (filters?.searchQuery?.isNotEmpty == true) {
        final query = filters!.searchQuery!.toLowerCase();
        transactions = transactions.where((tx) =>
          tx.title.toLowerCase().contains(query) ||
          tx.description?.toLowerCase().contains(query) == true ||
          tx.counterpartyName?.toLowerCase().contains(query) == true ||
          tx.transactionReference?.toLowerCase().contains(query) == true ||
          tx.formattedAmount.toLowerCase().contains(query)
        ).toList();
      }

      // Cache the results (scoped per account — see scopedKey above)
      if (page == 1 && transactions.isNotEmpty && scopedKey != null) {
        try {
          await cacheDataSource.cacheTransactions(
            scopedKey,
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

      // Try cache first for page 1 — scoped per (user, account) so the
      // service-filtered list also respects the selected account card.
      final userId = await storage.read(key: 'user_id');
      final scopedKey = userId != null ? _accountScopedKey(userId, accountId) : null;
      if (page == 1 && scopedKey != null) {
        try {
          final cached = await cacheDataSource.getCachedTransactions(
            userId: scopedKey,
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
              // Stale subset — cubit follows up with a background refresh.
              fromCache: true,
            );
          }
        } catch (e) {
          // Cache miss, continue to network
        }
      }

      final response = await grpcClient.getTransactionHistory(
        accountId: accountId,
        locale: localeManager.currentLocale,
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

      // Cache if first page (scoped per account — see scopedKey above)
      if (page == 1 && transactions.isNotEmpty && scopedKey != null) {
        try {
          await cacheDataSource.cacheTransactions(
            scopedKey,
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
        locale: localeManager.currentLocale,
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
        locale: localeManager.currentLocale,
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
        locale: localeManager.currentLocale,
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

      // Clear cache after refresh — only the active account's scoped bucket,
      // so refreshing one account doesn't wipe another account's cache.
      final userId = await storage.read(key: 'user_id');
      if (userId != null) {
        await cacheDataSource.clearUserTransactions(
          _accountScopedKey(userId, accountId),
        );
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

    // Counterparty account filter bypasses cache (backend-filtered)
    if (filters.counterpartyAccount != null) return true;

    return false;
  }

  /// Convert proto Transaction to UnifiedTransaction
  UnifiedTransaction _convertFromProto(Transaction protoTx) {
    // Parse createdAt from ISO8601 string
    // Server sends UTC; normalize to LOCAL so history lists, detail, receipts
    // AND day-grouping (which uses timezone-dependent .day/.month/.year) all
    // render in the user's timezone and match optimistic DateTime.now() items.
    final createdAt =
        DateTime.tryParse(protoTx.createdAt)?.toLocal() ?? DateTime.now();

    // Determine transaction flow from type
    final flow = protoTx.type.toLowerCase() == 'credit'
        ? TransactionFlow.incoming
        : protoTx.type.toLowerCase() == 'debit'
            ? TransactionFlow.outgoing
            : TransactionFlow.neutral;

    // Map service name to service type — fallback to category-based inference
    TransactionServiceType serviceType;
    if (protoTx.serviceName.isNotEmpty) {
      serviceType = _mapServiceNameToServiceType(protoTx.serviceName);
    } else {
      // Infer service type from category when service_name is missing
      serviceType = _inferServiceTypeFromCategory(
          protoTx.category, protoTx.type, protoTx.description, protoTx.reference);
    }

    // The utility-payments service serves airtime/data/electricity/water/tv/
    // internet/education/epin/betting under ONE backend service name, so the
    // service-name map returns the FIRST match (electricity) for all of them —
    // which is why ePIN/betting/etc. previously showed as "Electricity".
    // Disambiguate the specific bill type from the reference prefix / text.
    if (protoTx.serviceName == 'utility-payments-service' ||
        _looksLikeUtilityRef(protoTx.reference)) {
      serviceType = _refineUtilityServiceType(
          serviceType, protoTx.reference, protoTx.description, protoTx.category);
    }

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

    // Counterparty name — DIRECTION-AWARE. For an OUTGOING (debit) transfer the
    // counterparty to display is the RECEIVER; for an INCOMING (credit) transfer
    // it's the SENDER. Prefer the backend's per-perspective `counterparty_name`,
    // then fall back to the metadata key for the RIGHT side of THIS direction.
    // (The old code always read `recipient_name` and — paired with the
    // narration fallback below — surfaced the SENDER's name on outgoing rows,
    // e.g. "Sent to <me>" instead of "Sent to <receiver>".)
    final isIncoming = flow == TransactionFlow.incoming;
    String? counterpartyName = protoTx.counterpartyName.isNotEmpty
        ? protoTx.counterpartyName
        : (isIncoming
            ? (metadata['sender_name'] as String?
                ?? metadata['payer_name'] as String?
                ?? metadata['counterparty_name'] as String?)
            : (metadata['recipient_name'] as String?
                ?? metadata['beneficiary_name'] as String?
                ?? metadata['destination_name'] as String?
                ?? metadata['counterparty_name'] as String?));
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

    // Don't use generic account names as counterparty display names
    const genericAccountNames = {'Personal', 'Savings', 'Business', 'USD Wallet', 'GBP Wallet', 'GHS Wallet', 'KES Wallet', 'ZAR Wallet'};
    if (counterpartyName != null && genericAccountNames.contains(counterpartyName)) {
      counterpartyName = null;
    }

    // Client-side fallback: if the backend didn't stamp counterparty_name on
    // this row (older rows, or providers that don't populate the field), try
    // to recover the human-readable name from the narration. The send-funds
    // flow's default narration is "Transfer from {Sender Name}" /
    // "Transfer to {Recipient Name}", so a simple prefix-strip yields the
    // name we want to show. We deliberately ignore "Lazervault" to avoid
    // the vague "Transfer from Lazervault" string surfacing as a name.
    if ((counterpartyName == null || counterpartyName.isEmpty)
        && protoTx.description.isNotEmpty) {
      final desc = protoTx.description.trim();
      final lower = desc.toLowerCase();
      String? recovered;
      // DIRECTION-AWARE: only strip the prefix that names the COUNTERPARTY for
      // this row's direction. On an OUTGOING (debit) row we want "Transfer to
      // {receiver}" — NOT "Transfer from {sender}" (that's us). On an INCOMING
      // (credit) row we want "Transfer from {sender}". Stripping the opposite
      // prefix was the bug that showed the sender's name on sent transactions.
      if (isIncoming && lower.startsWith('transfer from ')) {
        recovered = desc.substring('transfer from '.length).trim();
      } else if (!isIncoming && lower.startsWith('transfer to ')) {
        recovered = desc.substring('transfer to '.length).trim();
      }
      if (recovered != null
          && recovered.isNotEmpty
          && recovered.toLowerCase() != 'lazervault') {
        counterpartyName = recovered;
      }
    }

    // Resolve bank name from bank_code if bank_name is not already set
    if (metadata['bank_name'] == null || (metadata['bank_name'] as String).isEmpty) {
      final bankCode = metadata['bank_code'] as String?
          ?? metadata['destination_bank_code'] as String?;
      if (bankCode != null && bankCode.isNotEmpty) {
        final resolvedName = BanksData.getBankNameByCode(bankCode);
        if (resolvedName != null) {
          metadata['bank_name'] = resolvedName;
        }
      }
    }

    // Generate title, enriched with counterparty name for transfers
    String title = _generateTransactionTitle(
        protoTx.category, protoTx.type, protoTx.description, protoTx.reference);
    if (counterpartyName != null && counterpartyName.isNotEmpty) {
      final categoryLower = protoTx.category.toLowerCase();
      final typeLower = protoTx.type.toLowerCase();
      final isInternational =
          protoTx.description.toLowerCase().contains('international') ||
              (metadata['exchange_type'] as String?) == 'international';
      if (isInternational) {
        title = 'International transfer to $counterpartyName';
      } else if (categoryLower.contains('transfer') ||
          _domainFromText(protoTx.category, protoTx.description, protoTx.reference) == 'transfer') {
        title = typeLower == 'credit'
            ? 'Transfer from $counterpartyName'
            : 'Transfer to $counterpartyName';
      }
    }

    // Prefer the ORIGINATING reference stashed in metadata (TRF-…, C2C-…,
    // DEP-…) over the ledger row's internal bookkeeping reference
    // (HOLD-CAP-{holdID}, IDEM-…) — the internal one means nothing to the
    // user and doesn't match the receipt/provider trail.
    final metaReference = metadata['reference'] as String?;
    final displayReference = (metaReference != null && metaReference.isNotEmpty)
        ? metaReference
        : (protoTx.reference.isNotEmpty ? protoTx.reference : null);

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
      transactionReference: displayReference,
      metadata: metadata.isNotEmpty ? metadata : null,
      counterpartyName: counterpartyName,
      counterpartyAccount: counterpartyAccount,
    );
  }

  /// Detects the true domain of a transaction whose accounts-service `category`
  /// is the GENERIC shared bucket `hold_capture` — which giftcards, crypto,
  /// insurance, etc. all use. The domain lives in the description/reference
  /// (crypto → "crypto swap"/"CRYPTO-", giftcard → "gift"/"GC-",
  /// insurance → "INS-"/"insurance"). Returns 'crypto' | 'giftcard' |
  /// 'insurance' | ''.
  String _domainFromText(String category, String description, String reference) {
    final s = '$category $description $reference'.toLowerCase();
    if (s.contains('crypto') || s.contains('crypto-')) return 'crypto';
    if (s.contains('gift') || RegExp(r'\bgc-').hasMatch(s)) return 'giftcard';
    if (s.contains('insurance') || RegExp(r'\bins-').hasMatch(s)) return 'insurance';
    // External bank transfers capture a hold too (category 'hold_capture',
    // description "Transfer to {name}", metadata.reference "TRF-…") — without
    // this rule a completed send-funds transfer read as "Gift Card Purchase".
    if (s.contains('transfer') || s.contains('trf-') || s.contains('c2c-')) {
      return 'transfer';
    }
    return '';
  }

  /// Generate a user-friendly transaction title
  String _generateTransactionTitle(
      String category, String type, String description, String reference) {
    final categoryLower = category.toLowerCase();
    final typeLower = type.toLowerCase();

    // Crypto first — a crypto buy captures a hold (category 'hold_capture',
    // shared with giftcards/insurance) so it MUST be classified by content
    // before the generic hold_capture→giftcard rule below, or every crypto buy
    // reads as "Gift Card Purchase". Wallet history only ever shows the fiat
    // legs: a debit is a BUY, a credit is a SELL (swap/send never touch the
    // fiat wallet).
    if (categoryLower.contains('crypto') ||
        _domainFromText(category, description, reference) == 'crypto') {
      return typeLower == 'credit' ? 'Crypto sell' : 'Crypto buy';
    }
    if (categoryLower.contains('insurance') ||
        _domainFromText(category, description, reference) == 'insurance') {
      return 'Insurance Payment';
    }

    if (_looksLikeEPinRef(reference) ||
        categoryLower.contains('epin') ||
        _text(description, category).contains('recharge card')) {
      return typeLower == 'credit'
          ? 'Recharge Card Refund'
          : 'Recharge Card Purchase';
    } else if (_looksLikeBettingRef(reference) ||
        categoryLower.contains('betting') ||
        _text(description, category).contains('betting')) {
      return typeLower == 'credit' ? 'Betting Refund' : 'Betting Wallet Funding';
    } else if (categoryLower.contains('airtime')) {
      return typeLower == 'credit' ? 'Airtime Top-up' : 'Airtime Purchase';
    } else if (categoryLower.contains('transfer') ||
        _domainFromText(category, description, reference) == 'transfer') {
      return typeLower == 'credit' ? 'Transfer Received' : 'Transfer Sent';
    } else if (categoryLower.contains('gift_card_sell') || categoryLower.contains('sell_payout')) {
      return 'Gift Card Sale';
    } else if (categoryLower.contains('hold_capture') && typeLower == 'debit') {
      return 'Gift Card Purchase';
    } else if (categoryLower.contains('gift')) {
      return typeLower == 'credit' ? 'Gift Card Refund' : 'Gift Card Purchase';
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

  /// Infer service type from category when service_name is empty
  TransactionServiceType _inferServiceTypeFromCategory(
      String category, String type, String description, String reference) {
    final cat = category.toLowerCase();
    // Disambiguate the shared 'hold_capture' bucket by content FIRST, so a
    // crypto buy / insurance premium hold isn't misclassified as a giftcard.
    final domain = _domainFromText(category, description, reference);
    if (cat.contains('crypto') || domain == 'crypto') {
      return TransactionServiceType.crypto;
    }
    if (cat.contains('insurance') || domain == 'insurance') {
      return TransactionServiceType.insurance;
    }
    // Transfers before the generic hold_capture→giftCard fallback — an
    // external bank transfer's capture row is category 'hold_capture' with
    // "Transfer to {name}" in the description.
    if (cat.contains('transfer') || domain == 'transfer') {
      return TransactionServiceType.transfer;
    }
    if (cat.contains('gift_card') || cat.contains('hold_capture') || cat.contains('giftcard')) {
      return TransactionServiceType.giftCard;
    } else if (_looksLikeEPinRef(reference) ||
        cat.contains('epin') ||
        _text(description, category).contains('recharge card')) {
      return TransactionServiceType.epin;
    } else if (_looksLikeBettingRef(reference) ||
        cat.contains('betting') ||
        _text(description, category).contains('betting')) {
      return TransactionServiceType.betting;
    } else if (cat.contains('airtime')) {
      return TransactionServiceType.airtime;
    } else if (cat.contains('electricity')) {
      return TransactionServiceType.electricity;
    } else if (cat.contains('deposit') || (type == 'credit' && cat.contains('fund'))) {
      return TransactionServiceType.deposit;
    } else if (cat.contains('withdrawal')) {
      return TransactionServiceType.withdrawal;
    } else if (cat.contains('tag')) {
      return TransactionServiceType.tagPay;
    } else if (cat.contains('invoice')) {
      return TransactionServiceType.invoice;
    } else if (cat.contains('crypto')) {
      return TransactionServiceType.crypto;
    } else if (cat.contains('insurance')) {
      return TransactionServiceType.insurance;
    }
    return TransactionServiceType.unknown;
  }

  String _text(String description, String category) =>
      '${description.toLowerCase()} ${category.toLowerCase()}';

  /// ePIN references are minted as `EPIN-...` (holds as `HOLD-EPIN-...`,
  /// reversals as `REV-EPIN-...`), so the prefix is authoritative.
  bool _looksLikeEPinRef(String reference) {
    final r = reference.toLowerCase();
    return r.startsWith('epin') ||
        r.startsWith('hold-epin') ||
        r.contains('-epin-') ||
        r.contains('epin');
  }

  /// Betting-wallet funding references are minted as `BET-...`.
  bool _looksLikeBettingRef(String reference) {
    final r = reference.toLowerCase();
    return r.startsWith('bet-') ||
        r.startsWith('hold-bet-') ||
        r.contains('-bet-');
  }

  /// True when a reference looks like it belongs to any utility-payments bill —
  /// used to trigger disambiguation even if service_name wasn't stamped.
  bool _looksLikeUtilityRef(String reference) {
    return _looksLikeEPinRef(reference) || _looksLikeBettingRef(reference);
  }

  /// The utility-payments family (airtime/data/electricity/water/tv/internet/
  /// education/epin/betting) shares ONE backend service name, so mapping by
  /// service name alone collapses them all onto the first match (electricity).
  /// Refine to the specific bill type using the reference prefix (authoritative)
  /// then the description/category text. Only acts on utility/unknown inputs and
  /// only when it finds a positive signal, so it never mislabels other services.
  TransactionServiceType _refineUtilityServiceType(
    TransactionServiceType current,
    String reference,
    String description,
    String category,
  ) {
    const utility = {
      TransactionServiceType.electricity,
      TransactionServiceType.airtime,
      TransactionServiceType.data,
      TransactionServiceType.water,
      TransactionServiceType.tvSubscription,
      TransactionServiceType.internet,
      TransactionServiceType.education,
      TransactionServiceType.betting,
      TransactionServiceType.epin,
      TransactionServiceType.unknown,
    };
    if (!utility.contains(current)) return current;

    final text = _text(description, category);
    bool has(String kw) => text.contains(kw);

    // Reference prefixes are authoritative.
    if (_looksLikeEPinRef(reference) || has('recharge card') || has('epin')) {
      return TransactionServiceType.epin;
    }
    if (_looksLikeBettingRef(reference) || has('betting')) {
      return TransactionServiceType.betting;
    }
    if (has('airtime')) return TransactionServiceType.airtime;
    if (has('data bundle') || has('data plan') || has('mobile data')) {
      return TransactionServiceType.data;
    }
    if (has('electricity') || has('meter') || has('prepaid') || has('postpaid')) {
      return TransactionServiceType.electricity;
    }
    if (has('water')) return TransactionServiceType.water;
    if (has('cable') ||
        has('dstv') ||
        has('gotv') ||
        has('startimes') ||
        has('tv subscription')) {
      return TransactionServiceType.tvSubscription;
    }
    if (has('internet') || has('broadband')) {
      return TransactionServiceType.internet;
    }
    if (has('education') || has('waec') || has('jamb')) {
      return TransactionServiceType.education;
    }
    return current;
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
      case UnifiedTransactionStatus.scheduled:
        return 'scheduled';
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
    // A future-dated transfer not yet fired — keep it distinct so it renders
    // "Scheduled" instead of collapsing to Pending below.
    if (statusLower == 'scheduled') return UnifiedTransactionStatus.scheduled;
    // A provider reversal of a completed transfer stamps 'reversed'; surface it
    // as Refunded (money-returned) rather than falling through to Pending —
    // otherwise a reversed transfer reads as still in-flight. Also accept the
    // provider's success synonyms so a 'success'/'successful' ledger row isn't
    // mislabelled Pending.
    if (statusLower == 'reversed') return UnifiedTransactionStatus.refunded;
    if (statusLower == 'success' || statusLower == 'successful') {
      return UnifiedTransactionStatus.completed;
    }
    return UnifiedTransactionStatus.pending;
  }
}
