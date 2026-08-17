import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
part 'unified_transaction_widgets.dart';


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

  /// Optional pre-formatted hero string that overrides the default fiat
  /// formatting (`₦#,##0.00`). Used for crypto-denominated receipts (e.g. a
  /// crypto send is "5.000000 USDT", not a 2-decimal fiat amount). When null,
  /// the receipt formats [amount] with [currency] as before.
  final String? amountDisplayOverride;

  /// For crypto receipts: the asset's real logo URL (CoinGecko/Quidax image).
  /// When set (with [assetSymbol]), the receipt hero renders the actual asset
  /// logo (with an initials fallback) instead of the generic service icon, so
  /// a USDT receipt shows the Tether logo — never a shared Bitcoin icon.
  final String? assetImageUrl;

  /// For crypto receipts: the asset ticker (e.g. "USDT"). Presence of this
  /// value switches the hero to the per-asset avatar; drives the initials
  /// fallback when [assetImageUrl] is absent or fails to load.
  final String? assetSymbol;

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
    this.amountDisplayOverride,
    this.assetImageUrl,
    this.assetSymbol,
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
        amountDisplayOverride,
        assetImageUrl,
        assetSymbol,
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
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
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
      createdAt: DateTime.parse(airtimeTxn['createdAt'] as String? ?? DateTime.now().toIso8601String()).toLocal(),
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
      createdAt: DateTime.parse(giftCardTxn['transactionDate'] as String? ?? DateTime.now().toIso8601String()).toLocal(),
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
      createdAt: DateTime.parse(billTxn['paymentDate'] as String? ?? DateTime.now().toIso8601String()).toLocal(),
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
    String? amountDisplayOverride,
    String? assetImageUrl,
    String? assetSymbol,
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
      amountDisplayOverride:
          amountDisplayOverride ?? this.amountDisplayOverride,
      assetImageUrl: assetImageUrl ?? this.assetImageUrl,
      assetSymbol: assetSymbol ?? this.assetSymbol,
    );
  }
}
