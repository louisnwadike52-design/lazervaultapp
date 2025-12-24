import 'recipient_entity.dart';

class CurrencyTransaction {
  final String id;
  final String fromCurrency;
  final String toCurrency;
  final double fromAmount;
  final double toAmount;
  final double exchangeRate;
  final double fees;
  final double totalCost;
  final Recipient recipient;
  final TransactionStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? transactionHash;
  final String? referenceNumber;
  final String? notes;
  final TransactionType type;
  final String? failureReason;

  const CurrencyTransaction({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.fromAmount,
    required this.toAmount,
    required this.exchangeRate,
    required this.fees,
    required this.totalCost,
    required this.recipient,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.transactionHash,
    this.referenceNumber,
    this.notes,
    this.type = TransactionType.send,
    this.failureReason,
  });

  factory CurrencyTransaction.fromJson(Map<String, dynamic> json) {
    return CurrencyTransaction(
      id: json['id'] ?? '',
      fromCurrency: json['fromCurrency'] ?? '',
      toCurrency: json['toCurrency'] ?? '',
      fromAmount: (json['fromAmount'] ?? 0.0).toDouble(),
      toAmount: (json['toAmount'] ?? 0.0).toDouble(),
      exchangeRate: (json['exchangeRate'] ?? 0.0).toDouble(),
      fees: (json['fees'] ?? 0.0).toDouble(),
      totalCost: (json['totalCost'] ?? 0.0).toDouble(),
      recipient: Recipient.fromJson(json['recipient'] ?? {}),
      status: TransactionStatus.values.firstWhere(
        (e) => e.toString() == 'TransactionStatus.${json['status']}',
        orElse: () => TransactionStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      transactionHash: json['transactionHash'],
      referenceNumber: json['referenceNumber'],
      notes: json['notes'],
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == 'TransactionType.${json['type']}',
        orElse: () => TransactionType.send,
      ),
      failureReason: json['failureReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'fromAmount': fromAmount,
      'toAmount': toAmount,
      'exchangeRate': exchangeRate,
      'fees': fees,
      'totalCost': totalCost,
      'recipient': recipient.toJson(),
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'transactionHash': transactionHash,
      'referenceNumber': referenceNumber,
      'notes': notes,
      'type': type.toString().split('.').last,
      'failureReason': failureReason,
    };
  }

  CurrencyTransaction copyWith({
    String? id,
    String? fromCurrency,
    String? toCurrency,
    double? fromAmount,
    double? toAmount,
    double? exchangeRate,
    double? fees,
    double? totalCost,
    Recipient? recipient,
    TransactionStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? transactionHash,
    String? referenceNumber,
    String? notes,
    TransactionType? type,
    String? failureReason,
  }) {
    return CurrencyTransaction(
      id: id ?? this.id,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      fees: fees ?? this.fees,
      totalCost: totalCost ?? this.totalCost,
      recipient: recipient ?? this.recipient,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      transactionHash: transactionHash ?? this.transactionHash,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      notes: notes ?? this.notes,
      type: type ?? this.type,
      failureReason: failureReason ?? this.failureReason,
    );
  }

  String get formattedFromAmount => '${fromAmount.toStringAsFixed(2)} $fromCurrency';
  String get formattedToAmount => '${toAmount.toStringAsFixed(2)} $toCurrency';
  String get formattedFees => '${fees.toStringAsFixed(2)} $fromCurrency';
  String get formattedTotalCost => '${totalCost.toStringAsFixed(2)} $fromCurrency';

  // Convenience getters for UI
  String get transactionId => id;
  DateTime get timestamp => createdAt;
  String get recipientName => recipient.name;
  double get fee => fees;
  String get statusString => status.toString().split('.').last.toUpperCase();

  bool get isCompleted => status == TransactionStatus.completed;
  bool get isPending => status == TransactionStatus.pending;
  bool get isFailed => status == TransactionStatus.failed;
  bool get isProcessing => status == TransactionStatus.processing;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CurrencyTransaction && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CurrencyTransaction(id: $id, from: $fromCurrency, to: $toCurrency, amount: $fromAmount)';
  }
}

enum TransactionStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
}

enum TransactionType {
  send,
  receive,
  exchange,
} 