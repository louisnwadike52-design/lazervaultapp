import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/airtime_to_cash_conversion.dart';

class AirtimeToCashConversionModel extends AirtimeToCashConversion {
  const AirtimeToCashConversionModel({
    required super.id,
    required super.phoneNumber,
    required super.network,
    required super.airtimeAmount,
    required super.cashAmount,
    required super.conversionRate,
    required super.fee,
    required super.providerName,
    required super.providerTxId,
    required super.status,
    super.failureReason,
    required super.reference,
    required super.createdAt,
    super.completedAt,
  });

  /// Build from the ConvertAirtimeToCash RPC response.
  factory AirtimeToCashConversionModel.fromConvertResponse(
    pb.ConvertAirtimeToCashResponse response,
  ) {
    final payment = response.payment;
    final effectiveStatus =
        payment.status.isEmpty ? 'processing' : payment.status;

    return AirtimeToCashConversionModel(
      id: payment.id,
      phoneNumber: payment.customerNumber,
      network: payment.providerId,
      airtimeAmount: payment.amount,
      cashAmount: response.cashAmount,
      conversionRate: response.conversionRate,
      fee: response.fee,
      providerName: payment.providerId,
      providerTxId: payment.reference,
      status: _statusFromString(effectiveStatus),
      reference: payment.reference,
      createdAt: DateTime.tryParse(payment.createdAt) ?? DateTime.now(),
    );
  }

  /// Build from the AirtimeToCashConversion proto message (history list item).
  factory AirtimeToCashConversionModel.fromProto(
    pb.AirtimeToCashConversion conversion,
  ) {
    return AirtimeToCashConversionModel(
      id: conversion.id,
      phoneNumber: conversion.phoneNumber,
      network: conversion.network,
      airtimeAmount: conversion.airtimeAmount,
      cashAmount: conversion.cashAmount,
      conversionRate: conversion.conversionRate,
      fee: conversion.fee,
      providerName: conversion.providerName,
      providerTxId: conversion.providerTxId,
      status: _statusFromString(conversion.status),
      failureReason: conversion.failureReason.isEmpty
          ? null
          : conversion.failureReason,
      reference: conversion.reference,
      createdAt: DateTime.tryParse(conversion.createdAt) ?? DateTime.now(),
      completedAt: conversion.completedAt.isEmpty
          ? null
          : DateTime.tryParse(conversion.completedAt),
    );
  }

  factory AirtimeToCashConversionModel.fromJson(Map<String, dynamic> json) {
    return AirtimeToCashConversionModel(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      network: json['network'] as String,
      airtimeAmount: (json['airtimeAmount'] as num).toDouble(),
      cashAmount: (json['cashAmount'] as num).toDouble(),
      conversionRate: (json['conversionRate'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      providerName: json['providerName'] as String? ?? '',
      providerTxId: json['providerTxId'] as String? ?? '',
      status: A2CConversionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => A2CConversionStatus.pending,
      ),
      failureReason: json['failureReason'] as String?,
      reference: json['reference'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'network': network,
      'airtimeAmount': airtimeAmount,
      'cashAmount': cashAmount,
      'conversionRate': conversionRate,
      'fee': fee,
      'providerName': providerName,
      'providerTxId': providerTxId,
      'status': status.name,
      'failureReason': failureReason,
      'reference': reference,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  static A2CConversionStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return A2CConversionStatus.completed;
      case 'failed':
        return A2CConversionStatus.failed;
      case 'processing':
        return A2CConversionStatus.processing;
      case 'awaiting_settlement':
        return A2CConversionStatus.awaitingSettlement;
      default:
        return A2CConversionStatus.pending;
    }
  }

  @override
  AirtimeToCashConversionModel copyWith({
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
    return AirtimeToCashConversionModel(
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
}
