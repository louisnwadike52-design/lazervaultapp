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
import 'package:lazervault/src/features/transaction_history/data/repository/transaction_classifier.dart'
    as classifier;
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

      // Legacy invoice platform-fee rows were stamped core-payments-service,
      // so the backend returns them for the Transfers view. They are fees into
      // the revenue ledger, not transfers — never show them there. (New rows
      // are stamped invoice-service and don't hit this filter.)
      if (serviceType == TransactionServiceType.transfer) {
        transactions
            .removeWhere((tx) => tx.serviceType == TransactionServiceType.fee);
      }

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

    // Determine transaction flow from type (crypto swaps override to neutral
    // below — they move no fiat, so neither +green nor -white applies).
    var flow = protoTx.type.toLowerCase() == 'credit'
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
      serviceType = _inferServiceTypeFromCategory(protoTx.category,
          protoTx.type, protoTx.description, protoTx.reference, protoTx.serviceName);
    }

    // Correct the service type for the shared hold_capture bucket. Several
    // capturing services (exchange-service, banking-service, financial-products-
    // service) have no direct AppServiceName→backend mapping, so
    // _mapServiceNameToServiceType returns `unknown`, and rows with no
    // service_name fall to `giftCard`. Resolve the real domain from
    // service_name + description and pin the type accordingly, so the icon/
    // colour match the corrected title. Only override when we positively resolve
    // a domain AND the current type is ambiguous (unknown/giftCard) — never
    // downgrade an already-correct concrete type.
    if (serviceType == TransactionServiceType.unknown ||
        serviceType == TransactionServiceType.giftCard) {
      final domain = _domainFromText(protoTx.category, protoTx.description,
          protoTx.reference, protoTx.serviceName);
      final domainType = _serviceTypeForDomain(domain);
      if (domainType != null) {
        serviceType = domainType;
      }
    }

    // Invoice PLATFORM fees are never transfers (nor generic invoice
    // payments): force the fee type so the icon/title/receipt-routing all
    // agree, including for legacy rows still stamped core-payments-service.
    final feeDomain = _domainFromText(protoTx.category, protoTx.description,
        protoTx.reference, protoTx.serviceName);
    if (feeDomain == 'invoice_fee') {
      serviceType = TransactionServiceType.fee;
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

    // Legacy invoice-fee rows predate the metadata stamp — recover the
    // invoice id from the idempotency reference so tapping the row can still
    // open the invoice receipt.
    if (feeDomain == 'invoice_fee' && metadata['invoice_id'] == null) {
      final recoveredInvoiceId =
          classifier.invoiceIdFromReference(protoTx.reference);
      if (recoveredInvoiceId != null) {
        metadata['invoice_id'] = recoveredInvoiceId;
      }
    }

    // Zero-amount crypto rows (crypto_convert swap / crypto_send) carry their
    // real story in metadata — the fiat amount is honestly 0, so build a
    // crypto-denominated presentation from the metadata legs instead of
    // rendering "+₦0.00". Backend amounts arrive at full ledger precision
    // ("1.7000000000000000000"); trim for display everywhere.
    final catLower = protoTx.category.toLowerCase();
    final opValue = (metadata['op']?.toString() ?? '').toLowerCase();
    final isCryptoSwap =
        catLower.contains('crypto_convert') || opValue == 'convert';
    final isCryptoSend = !isCryptoSwap &&
        (catLower.contains('crypto_send') || opValue == 'send');
    String? amountDisplayOverride;
    String? assetSymbol;
    String? descriptionOverride;
    if (isCryptoSwap) {
      flow = TransactionFlow.neutral;
      final fromCcy =
          (metadata['from_currency']?.toString() ?? '').toUpperCase();
      final toCcy = (metadata['to_currency']?.toString() ?? '').toUpperCase();
      final fromAmt =
          _trimCryptoAmount(metadata['from_amount']?.toString() ?? '');
      final toAmt = _trimCryptoAmount(metadata['to_amount']?.toString() ?? '');
      if (fromCcy.isNotEmpty &&
          toCcy.isNotEmpty &&
          fromAmt.isNotEmpty &&
          toAmt.isNotEmpty) {
        amountDisplayOverride = '$fromAmt $fromCcy → $toAmt $toCcy';
        descriptionOverride = 'Converted $fromAmt $fromCcy to $toAmt $toCcy';
        metadata['from_amount'] = fromAmt;
        metadata['to_amount'] = toAmt;
      }
      if (toCcy.isNotEmpty) assetSymbol = toCcy;
    } else if (isCryptoSend) {
      final ccy = (metadata['currency']?.toString() ?? '').toUpperCase();
      final amt = _trimCryptoAmount(metadata['amount']?.toString() ?? '');
      if (ccy.isNotEmpty && amt.isNotEmpty) {
        amountDisplayOverride = '$amt $ccy';
        metadata['amount'] = amt;
        final recipient = metadata['recipient']?.toString() ?? '';
        if (recipient.isNotEmpty) {
          descriptionOverride = 'Sent $amt $ccy to $recipient';
        }
      }
      if (ccy.isNotEmpty) assetSymbol = ccy;
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

    // Crypto sends name their recipient in metadata (username or truncated
    // address) — surface it as the counterparty so the receipt shows "To".
    if (isCryptoSend && (counterpartyName == null || counterpartyName.isEmpty)) {
      final recipient = metadata['recipient']?.toString();
      if (recipient != null && recipient.isNotEmpty) {
        counterpartyName = recipient;
      }
    }

    // Fallback: try to parse account number from description. Never for
    // zero-amount crypto rows — and never digits after a decimal point: the
    // fractional part of a full-precision crypto amount
    // ("1.7000000000000000000 USDT") is 10+ digits and was being rendered as
    // an "Account 7000000000000000000" row.
    // Also never for invoice platform fees: there is no counterparty, and the
    // epoch-second in "…unlock-<uuid>-1756704000-FROM" descriptions was being
    // rendered as "Account 1756704000".
    if (counterpartyAccount == null &&
        !isCryptoSwap &&
        !isCryptoSend &&
        feeDomain != 'invoice_fee' &&
        protoTx.description.isNotEmpty) {
      final accountMatch =
          RegExp(r'(?<![.\d])(\d{10,})\b').firstMatch(protoTx.description);
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
    String title = _generateTransactionTitle(protoTx.category, protoTx.type,
        protoTx.description, protoTx.reference, protoTx.serviceName);
    if (counterpartyName != null && counterpartyName.isNotEmpty) {
      final categoryLower = protoTx.category.toLowerCase();
      final typeLower = protoTx.type.toLowerCase();
      final isInternational =
          protoTx.description.toLowerCase().contains('international') ||
              (metadata['exchange_type'] as String?) == 'international';
      if (isInternational) {
        title = 'International transfer to $counterpartyName';
      } else if (categoryLower.contains('transfer') ||
          _domainFromText(protoTx.category, protoTx.description,
                  protoTx.reference, protoTx.serviceName) ==
              'transfer') {
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
      description: descriptionOverride ??
          (protoTx.description.isNotEmpty ? protoTx.description : null),
      amount: protoTx.amount,
      currency: accountManager.activeAccountDetails?.currency ?? 'NGN',
      createdAt: createdAt,
      status: status,
      flow: flow,
      transactionReference: displayReference,
      metadata: metadata.isNotEmpty ? metadata : null,
      counterpartyName: counterpartyName,
      counterpartyAccount: counterpartyAccount,
      amountDisplayOverride: amountDisplayOverride,
      assetSymbol: assetSymbol,
    );
  }

  /// Trims a full-precision ledger amount string ("1.7000000000000000000")
  /// to its human form ("1.7") without float round-tripping, so 18-decimal
  /// crypto precision can never be corrupted by double parsing.
  String _trimCryptoAmount(String raw) {
    var s = raw.trim();
    if (s.isEmpty || !s.contains('.')) return s;
    s = s.replaceAll(RegExp(r'0+$'), '');
    if (s.endsWith('.')) s = s.substring(0, s.length - 1);
    return s.isEmpty ? '0' : s;
  }

  // Transaction classification (domain/title/type) lives in
  // `transaction_classifier.dart` as pure, unit-testable functions. These thin
  // wrappers keep the call sites in this file unchanged.
  String _domainFromText(String category, String description, String reference,
          [String serviceName = '']) =>
      classifier.classifyDomain(category, description, reference, serviceName);

  TransactionServiceType? _serviceTypeForDomain(String domain) =>
      classifier.serviceTypeForDomain(domain);

  String _generateTransactionTitle(
          String category, String type, String description, String reference,
          [String serviceName = '']) =>
      classifier.generateTransactionTitle(
          category, type, description, reference, serviceName);

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

  TransactionServiceType _inferServiceTypeFromCategory(
          String category, String type, String description, String reference,
          [String serviceName = '']) =>
      classifier.inferServiceTypeFromCategory(
          category, type, description, reference, serviceName);

  bool _looksLikeUtilityRef(String reference) =>
      classifier.looksLikeUtilityRef(reference);

  TransactionServiceType _refineUtilityServiceType(
    TransactionServiceType current,
    String reference,
    String description,
    String category,
  ) =>
      classifier.refineUtilityServiceType(
          current, reference, description, category);

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
