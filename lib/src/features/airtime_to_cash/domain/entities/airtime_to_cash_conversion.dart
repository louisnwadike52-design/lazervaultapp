import 'dart:ui';
import 'package:equatable/equatable.dart';

enum A2CConversionStatus {
  pending,
  processing,
  awaitingSettlement,
  completed,
  failed,
}

extension A2CConversionStatusExtension on A2CConversionStatus {
  String get displayName {
    switch (this) {
      case A2CConversionStatus.pending:
        return 'Pending';
      case A2CConversionStatus.processing:
        return 'Processing';
      case A2CConversionStatus.awaitingSettlement:
        return 'Awaiting Settlement';
      case A2CConversionStatus.completed:
        return 'Completed';
      case A2CConversionStatus.failed:
        return 'Failed';
    }
  }

  String get statusColor {
    switch (this) {
      case A2CConversionStatus.pending:
        return '#FFA500';
      case A2CConversionStatus.processing:
        return '#0066CC';
      case A2CConversionStatus.awaitingSettlement:
        return '#FFA500';
      case A2CConversionStatus.completed:
        return '#00AA4F';
      case A2CConversionStatus.failed:
        return '#FF0000';
    }
  }

  Color get color {
    switch (this) {
      case A2CConversionStatus.pending:
        return const Color(0xFFFFA500);
      case A2CConversionStatus.processing:
        return const Color(0xFF0066CC);
      case A2CConversionStatus.awaitingSettlement:
        return const Color(0xFFFFA500);
      case A2CConversionStatus.completed:
        return const Color(0xFF00AA4F);
      case A2CConversionStatus.failed:
        return const Color(0xFFFF0000);
    }
  }
}

class AirtimeToCashConversion extends Equatable {
  final String id;
  final String phoneNumber;
  final String network;
  final double airtimeAmount;
  final double cashAmount;
  final double conversionRate;
  final double fee;
  final String providerName;
  final String providerTxId;
  final A2CConversionStatus status;
  final String? failureReason;
  final String reference;
  final DateTime createdAt;
  final DateTime? completedAt;

  const AirtimeToCashConversion({
    required this.id,
    required this.phoneNumber,
    required this.network,
    required this.airtimeAmount,
    required this.cashAmount,
    required this.conversionRate,
    required this.fee,
    required this.providerName,
    required this.providerTxId,
    required this.status,
    this.failureReason,
    required this.reference,
    required this.createdAt,
    this.completedAt,
  });

  bool get isCompleted => status == A2CConversionStatus.completed;
  bool get isFailed => status == A2CConversionStatus.failed;
  bool get isPending =>
      status == A2CConversionStatus.pending ||
      status == A2CConversionStatus.processing ||
      status == A2CConversionStatus.awaitingSettlement;

  /// Net amount credited to wallet after fee deduction
  double get netCashAmount => cashAmount;

  /// Effective rate as percentage string (e.g., "80%")
  String get ratePercentage => '${(conversionRate * 100).toStringAsFixed(0)}%';

  /// Formatted airtime amount with Naira symbol
  String get formattedAirtimeAmount =>
      '\u20A6${airtimeAmount.toStringAsFixed(2)}';

  /// Formatted cash amount with Naira symbol
  String get formattedCashAmount => '\u20A6${cashAmount.toStringAsFixed(2)}';

  /// Formatted fee with Naira symbol
  String get formattedFee => '\u20A6${fee.toStringAsFixed(2)}';

  AirtimeToCashConversion copyWith({
    String? id,
    String? phoneNumber,
    String? network,
    double? airtimeAmount,
    double? cashAmount,
    double? conversionRate,
    double? fee,
    String? providerName,
    String? providerTxId,
    A2CConversionStatus? status,
    String? failureReason,
    String? reference,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return AirtimeToCashConversion(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      network: network ?? this.network,
      airtimeAmount: airtimeAmount ?? this.airtimeAmount,
      cashAmount: cashAmount ?? this.cashAmount,
      conversionRate: conversionRate ?? this.conversionRate,
      fee: fee ?? this.fee,
      providerName: providerName ?? this.providerName,
      providerTxId: providerTxId ?? this.providerTxId,
      status: status ?? this.status,
      failureReason: failureReason ?? this.failureReason,
      reference: reference ?? this.reference,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
        network,
        airtimeAmount,
        cashAmount,
        conversionRate,
        fee,
        providerName,
        providerTxId,
        status,
        failureReason,
        reference,
        createdAt,
        completedAt,
      ];
}
