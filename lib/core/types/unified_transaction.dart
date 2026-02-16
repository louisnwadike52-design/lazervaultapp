import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Unified transaction type enum supporting all services
enum TransactionServiceType {
  airtime('Airtime', Icons.phone_android, Color(0xFFFFCC00)),
  giftCard('Gift Card', Icons.card_giftcard, Color(0xFF6366F1)),
  electricity('Electricity', Icons.bolt, Color(0xFF00B04F)),
  water('Water Bill', Icons.water_drop, Color(0xFF3B82F6)),
  tvSubscription('TV Subscription', Icons.tv, Color(0xFFEF4444)),
  transfer('Transfer', Icons.swap_horiz, Color(0xFF8B5CF6)),
  crypto('Crypto', Icons.currency_bitcoin, Color(0xFFF59E0B)),
  stocks('Stocks', Icons.trending_up, Color(0xFF10B981)),
  insurance('Insurance', Icons.security, Color(0xFF3B82F6)),
  invoice('Invoice', Icons.receipt_long, Color(0xFF6366F1)),
  qrPayment('QR Payment', Icons.qr_code_2, Color(0xFFEC4899)),
  tagPay('Tag Pay', Icons.local_offer, Color(0xFF14B8A6)),
  crowdfund('Crowdfund', Icons.volunteer_activism, Color(0xFFF472B6)),
  autosave('AutoSave', Icons.savings, Color(0xFF22C55E)),
  deposit('Deposit', Icons.add_circle_outline, Color(0xFF10B981)),
  withdrawal('Withdrawal', Icons.remove_circle_outline, Color(0xFFEF4444)),
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
  refunded('Refunded', Color(0xFF8B5CF6)),
  expired('Expired', Color(0xFF9CA3AF));

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

/// Unified transaction model supporting all service types
class UnifiedTransaction extends Equatable {
  final String id;
  final TransactionServiceType serviceType;
  final String title;
  final String? description;
  final double amount;
  final String currency;
  final DateTime createdAt;
  final UnifiedTransactionStatus status;
  final TransactionFlow flow;
  final String? transactionReference;
  final Map<String, dynamic>? metadata;
  final String? counterpartyName;
  final String? counterpartyAccount;

  const UnifiedTransaction({
    required this.id,
    required this.serviceType,
    required this.title,
    this.description,
    required this.amount,
    required this.currency,
    required this.createdAt,
    required this.status,
    required this.flow,
    this.transactionReference,
    this.metadata,
    this.counterpartyName,
    this.counterpartyAccount,
  });

  /// Format amount with currency symbol and flow indicator
  String get formattedAmount {
    final symbol = currency == 'NGN' ? '₦' : currency == 'USD' ? '\$' : currency;
    return '${flow.prefix}$symbol${amount.toStringAsFixed(2)}';
  }

  /// Get service-specific icon
  IconData get serviceIcon => serviceType.icon;

  /// Get service-specific color
  Color get serviceColor => serviceType.color;

  /// Get status color
  Color get statusColor => status.color;

  @override
  List<Object?> get props => [
        id,
        serviceType,
        title,
        description,
        amount,
        currency,
        createdAt,
        status,
        flow,
        transactionReference,
        metadata,
        counterpartyName,
        counterpartyAccount,
      ];

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceType': serviceType.name,
      'title': title,
      'description': description,
      'amount': amount,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
      'flow': flow.name,
      'transactionReference': transactionReference,
      'metadata': metadata,
      'counterpartyName': counterpartyName,
      'counterpartyAccount': counterpartyAccount,
    };
  }

  /// Create from JSON
  factory UnifiedTransaction.fromJson(Map<String, dynamic> json) {
    return UnifiedTransaction(
      id: json['id'] as String,
      serviceType: TransactionServiceType.fromString(
        json['serviceType'] as String? ?? 'unknown',
      ),
      title: json['title'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: UnifiedTransactionStatus.fromString(
        json['status'] as String? ?? 'pending',
      ),
      flow: TransactionFlow.values.firstWhere(
        (f) => f.name == json['flow'],
        orElse: () => TransactionFlow.neutral,
      ),
      transactionReference: json['transactionReference'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      counterpartyName: json['counterpartyName'] as String?,
      counterpartyAccount: json['counterpartyAccount'] as String?,
    );
  }

  /// Create from airtime transaction
  factory UnifiedTransaction.fromAirtime(Map<String, dynamic> airtimeTxn) {
    return UnifiedTransaction(
      id: airtimeTxn['id'] as String,
      serviceType: TransactionServiceType.airtime,
      title: '${airtimeTxn['networkProvider'] ?? 'Network'} Airtime',
      description: airtimeTxn['recipientPhoneNumber'] as String?,
      amount: (airtimeTxn['amount'] as num).toDouble(),
      currency: airtimeTxn['currency'] as String? ?? 'NGN',
      createdAt: DateTime.parse(airtimeTxn['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      status: UnifiedTransactionStatus.fromString(
        airtimeTxn['status'] as String? ?? 'pending',
      ),
      flow: TransactionFlow.outgoing,
      transactionReference: airtimeTxn['transactionReference'] as String?,
      metadata: {
        'networkProvider': airtimeTxn['networkProvider'],
        'recipientName': airtimeTxn['recipientName'],
      },
    );
  }

  /// Create from gift card transaction
  factory UnifiedTransaction.fromGiftCard(Map<String, dynamic> giftCardTxn) {
    final type = giftCardTxn['transactionType'] as String? ?? 'purchase';
    return UnifiedTransaction(
      id: giftCardTxn['id'] as String,
      serviceType: TransactionServiceType.giftCard,
      title: '${giftCardTxn['brandName'] ?? 'Gift Card'}',
      description: giftCardTxn['description'] as String?,
      amount: (giftCardTxn['amount'] as num).toDouble(),
      currency: giftCardTxn['currency'] as String? ?? 'USD',
      createdAt: DateTime.parse(giftCardTxn['transactionDate'] as String? ?? DateTime.now().toIso8601String()),
      status: UnifiedTransactionStatus.fromString(
        giftCardTxn['status'] as String? ?? 'pending',
      ),
      flow: type == 'sell' ? TransactionFlow.incoming : TransactionFlow.outgoing,
      transactionReference: giftCardTxn['id'] as String?,
      metadata: {
        'brandName': giftCardTxn['brandName'],
        'transactionType': type,
      },
    );
  }

  /// Create from electricity bill transaction
  factory UnifiedTransaction.fromElectricityBill(Map<String, dynamic> billTxn) {
    return UnifiedTransaction(
      id: billTxn['id'] as String,
      serviceType: TransactionServiceType.electricity,
      title: 'Electricity Bill',
      description: billTxn['meterNumber'] as String?,
      amount: (billTxn['amount'] as num).toDouble(),
      currency: billTxn['currency'] as String? ?? 'NGN',
      createdAt: DateTime.parse(billTxn['paymentDate'] as String? ?? DateTime.now().toIso8601String()),
      status: UnifiedTransactionStatus.fromString(
        billTxn['status'] as String? ?? 'pending',
      ),
      flow: TransactionFlow.outgoing,
      transactionReference: billTxn['transactionReference'] as String?,
      metadata: {
        'meterNumber': billTxn['meterNumber'],
        'customerName': billTxn['customerName'],
        'units': billTxn['units'],
      },
    );
  }

  /// Create a copy with modified fields
  UnifiedTransaction copyWith({
    String? id,
    TransactionServiceType? serviceType,
    String? title,
    String? description,
    double? amount,
    String? currency,
    DateTime? createdAt,
    UnifiedTransactionStatus? status,
    TransactionFlow? flow,
    String? transactionReference,
    Map<String, dynamic>? metadata,
    String? counterpartyName,
    String? counterpartyAccount,
  }) {
    return UnifiedTransaction(
      id: id ?? this.id,
      serviceType: serviceType ?? this.serviceType,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      flow: flow ?? this.flow,
      transactionReference: transactionReference ?? this.transactionReference,
      metadata: metadata ?? this.metadata,
      counterpartyName: counterpartyName ?? this.counterpartyName,
      counterpartyAccount: counterpartyAccount ?? this.counterpartyAccount,
    );
  }
}

/// Transaction list response with pagination support
class TransactionListResponse extends Equatable {
  final List<UnifiedTransaction> transactions;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final String? nextCursor;

  const TransactionListResponse({
    required this.transactions,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [transactions, hasMore, currentPage, totalPages, nextCursor];
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

  const TransactionFilters({
    this.serviceTypes,
    this.statuses,
    this.flows,
    this.startDate,
    this.endDate,
    this.minAmount,
    this.maxAmount,
    this.searchQuery,
  });

  bool get hasFilters =>
      serviceTypes != null ||
      statuses != null ||
      flows != null ||
      startDate != null ||
      endDate != null ||
      minAmount != null ||
      maxAmount != null ||
      searchQuery != null;

  TransactionFilters copyWith({
    List<TransactionServiceType>? serviceTypes,
    List<UnifiedTransactionStatus>? statuses,
    List<TransactionFlow>? flows,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
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
      ];
}
