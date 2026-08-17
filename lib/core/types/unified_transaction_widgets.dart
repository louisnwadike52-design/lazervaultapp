part of 'unified_transaction.dart';

/// Unified transaction type enum supporting all services
enum TransactionServiceType {
  // Utility bill family — keep all five bill types in one cluster so the
  // user reads "those are all bills" at a glance.
  airtime('Airtime', Icons.phone_android, Color(0xFFFFCC00)),
  data('Mobile Data', Icons.signal_cellular_alt, Color(0xFF06B6D4)),
  electricity('Electricity', Icons.bolt, Color(0xFF00B04F)),
  water('Water Bill', Icons.water_drop, Color(0xFF3B82F6)),
  tvSubscription('TV Subscription', Icons.tv, Color(0xFFEF4444)),
  internet('Internet Bill', Icons.wifi, Color(0xFF0EA5E9)),
  education('Education', Icons.school, Color(0xFFA855F7)),
  betting('Betting', Icons.sports_soccer, Color(0xFF8B5CF6)),
  epin('Recharge Card', Icons.confirmation_number, Color(0xFFF97316)),

  // Send / receive money family — outgoing flows.
  transfer('Transfer', Icons.swap_horiz, Color.fromARGB(255, 78, 3, 208)),
  batchTransfer('Batch Transfer', Icons.group_outlined, Color(0xFF8B5CF6)),
  splitBill('Split Bill', Icons.receipt_outlined, Color(0xFFFB923C)),
  tagPay('Tag Pay', Icons.local_offer, Color(0xFF14B8A6)),
  qrPayment('QR Payment', Icons.qr_code_2, Color(0xFFEC4899)),
  idPay('PayID', Icons.badge_outlined, Color(0xFF6366F1)),
  contactlessPay('Tap to Pay', Icons.contactless_outlined, Color(0xFF6F42C1)),
  rmb('RMB Transfer', Icons.currency_yuan, Color(0xFFE60012)),

  // Stored value / commerce.
  invoice('Invoice', Icons.receipt_long, Color(0xFF6366F1)),
  giftCard('Gift Card', Icons.card_giftcard, Color(0xFF6366F1)),

  // Business (payroll, sales, expenses, tax, inventory) — receipts the business
  // dashboard generates.
  payroll('Payroll', Icons.groups_outlined, Color(0xFF6366F1)),
  sale('Sale', Icons.point_of_sale_outlined, Color(0xFF10B981)),
  expense('Expense', Icons.account_balance_wallet_outlined, Color(0xFFFB923C)),
  tax('Tax', Icons.receipt_long_outlined, Color(0xFF8B5CF6)),
  purchaseOrder('Purchase Order', Icons.inventory_2_outlined, Color(0xFF0EA5E9)),

  // Investments / savings.
  crypto('Crypto', Icons.currency_bitcoin, Color(0xFFF59E0B)),
  stocks('Stocks', Icons.trending_up, Color(0xFF10B981)),
  insurance('Insurance', Icons.security, Color(0xFF3B82F6)),
  crowdfund('Crowdfund', Icons.volunteer_activism, Color(0xFFF472B6)),
  autosave('AutoSave', Icons.savings, Color(0xFF22C55E)),
  lockFunds('Piggyvault', Icons.lock_clock_outlined, Color(0xFF6366F1)),
  groupFunds('Group Funds', Icons.groups_2_outlined, Color(0xFFA855F7)),
  exchange('Exchange', Icons.currency_exchange, Color(0xFFFB923C)),

  // Account-level money flow.
  deposit('Deposit', Icons.add_circle_outline, Color(0xFF10B981)),
  withdrawal('Withdrawal', Icons.remove_circle_outline, Color(0xFFEF4444)),
  refund('Refund', Icons.undo_outlined, Color(0xFF6B7280)),
  reversal('Reversal', Icons.replay_outlined, Color(0xFF6B7280)),
  fee('Fee', Icons.receipt, Color(0xFF9CA3AF)),

  unknown('Unknown', Icons.help_outline, Color(0xFF9CA3AF));

  final String displayName;
  final IconData icon;
  final Color color;

  const TransactionServiceType(
    this.displayName,
    this.icon,
    this.color,
  );

  static TransactionServiceType fromString(String value) {
    return TransactionServiceType.values.firstWhere(
      (type) => type.name.toLowerCase() == value.toLowerCase(),
      orElse: () => TransactionServiceType.unknown,
    );
  }
}

/// Transaction status enum
enum UnifiedTransactionStatus {
  pending('Pending', Color(0xFFF59E0B)),
  processing('Processing', Color(0xFF3B82F6)),
  completed('Completed', Color(0xFF10B981)),
  failed('Failed', Color(0xFFEF4444)),
  cancelled('Cancelled', Color(0xFF6B7280)),
  refunded('Refunded', Color.fromARGB(255, 78, 3, 208)),
  expired('Expired', Color(0xFF9CA3AF)),
  // A future-dated transfer that hasn't fired yet — distinct violet so it never
  // reads as Completed/Pending. The scheduler flips it to completed on execution.
  scheduled('Scheduled', Color(0xFF8B5CF6));

  final String displayName;
  final Color color;

  const UnifiedTransactionStatus(
    this.displayName,
    this.color,
  );

  static UnifiedTransactionStatus fromString(String value) {
    return UnifiedTransactionStatus.values.firstWhere(
      (status) => status.name.toLowerCase() == value.toLowerCase(),
      orElse: () => UnifiedTransactionStatus.pending,
    );
  }
}

/// Transaction flow direction
enum TransactionFlow {
  incoming('incoming', 'credit', '+', Color(0xFF10B981)),
  outgoing('outgoing', 'debit', '-', Color(0xFFEF4444)),
  neutral('neutral', 'neutral', '', Color(0xFF6B7280));

  final String name;
  final String type;
  final String prefix;
  final Color color;

  const TransactionFlow(
    this.name,
    this.type,
    this.prefix,
    this.color,
  );
}

/// Transaction list response with pagination support
class TransactionListResponse extends Equatable {
  final List<UnifiedTransaction> transactions;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final String? nextCursor;

  /// True when this page was served from the local cache (a possibly stale
  /// subset with no external-transfer merge). Consumers use it to trigger a
  /// background network refresh so the visible list converges to complete
  /// data without a loading flash.
  final bool fromCache;

  const TransactionListResponse({
    required this.transactions,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    this.nextCursor,
    this.fromCache = false,
  });

  @override
  List<Object?> get props =>
      [transactions, hasMore, currentPage, totalPages, nextCursor, fromCache];
}

/// Transaction statistics model
class TransactionStatistics extends Equatable {
  final double totalIncoming;
  final double totalOutgoing;
  final double netBalance;
  final int totalTransactions;
  final Map<TransactionServiceType, int> transactionCountsByService;
  final Map<UnifiedTransactionStatus, int> transactionCountsByStatus;

  const TransactionStatistics({
    required this.totalIncoming,
    required this.totalOutgoing,
    required this.netBalance,
    required this.totalTransactions,
    required this.transactionCountsByService,
    required this.transactionCountsByStatus,
  });

  @override
  List<Object?> get props => [
        totalIncoming,
        totalOutgoing,
        netBalance,
        totalTransactions,
        transactionCountsByService,
        transactionCountsByStatus,
      ];

  @override
  String toString() {
    return 'TransactionStatistics(totalIncoming: $totalIncoming, totalOutgoing: $totalOutgoing, netBalance: $netBalance, totalTransactions: $totalTransactions)';
  }
}

/// Transaction filter options
class TransactionFilters extends Equatable {
  final List<TransactionServiceType>? serviceTypes;
  final List<UnifiedTransactionStatus>? statuses;
  final List<TransactionFlow>? flows;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minAmount;
  final double? maxAmount;
  final String? searchQuery;
  final String? counterpartyAccount;

  const TransactionFilters({
    this.serviceTypes,
    this.statuses,
    this.flows,
    this.startDate,
    this.endDate,
    this.minAmount,
    this.maxAmount,
    this.searchQuery,
    this.counterpartyAccount,
  });

  bool get hasFilters =>
      serviceTypes != null ||
      statuses != null ||
      flows != null ||
      startDate != null ||
      endDate != null ||
      minAmount != null ||
      maxAmount != null ||
      searchQuery != null ||
      counterpartyAccount != null;

  TransactionFilters copyWith({
    List<TransactionServiceType>? serviceTypes,
    List<UnifiedTransactionStatus>? statuses,
    List<TransactionFlow>? flows,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
    String? counterpartyAccount,
  }) {
    return TransactionFilters(
      serviceTypes: serviceTypes ?? this.serviceTypes,
      statuses: statuses ?? this.statuses,
      flows: flows ?? this.flows,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      searchQuery: searchQuery ?? this.searchQuery,
      counterpartyAccount: counterpartyAccount ?? this.counterpartyAccount,
    );
  }

  TransactionFilters clear() {
    return const TransactionFilters();
  }

  @override
  List<Object?> get props => [
        serviceTypes,
        statuses,
        flows,
        startDate,
        endDate,
        minAmount,
        maxAmount,
        searchQuery,
        counterpartyAccount,
      ];
}
