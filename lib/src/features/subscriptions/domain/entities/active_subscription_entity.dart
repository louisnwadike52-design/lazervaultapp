import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ActiveSubscriptionEntity extends Equatable {
  final String id;
  final String subscriptionType;
  final String providerId;
  final String providerName;
  final String planName;
  final double amount;
  final String currency;
  final String customerNumber;
  final String status;
  final DateTime purchasedAt;
  final DateTime? expiresAt;
  final int validityDays;
  final String renewalDate;
  final String token;
  final double units;
  final double progressPercentage;
  final int daysRemaining;
  final String paymentReference;

  const ActiveSubscriptionEntity({
    required this.id,
    required this.subscriptionType,
    required this.providerId,
    required this.providerName,
    required this.planName,
    required this.amount,
    required this.currency,
    required this.customerNumber,
    required this.status,
    required this.purchasedAt,
    this.expiresAt,
    required this.validityDays,
    required this.renewalDate,
    required this.token,
    required this.units,
    required this.progressPercentage,
    required this.daysRemaining,
    required this.paymentReference,
  });

  bool get isActive => status.toLowerCase() == 'active';

  bool get isExpired => status.toLowerCase() == 'expired';

  bool get isExpiringSoon => hasExpiry && daysRemaining <= 3 && daysRemaining >= 0;

  bool get hasExpiry => expiresAt != null;

  IconData get typeIcon {
    switch (subscriptionType.toLowerCase()) {
      case 'data':
        return Icons.wifi;
      case 'cable_tv':
        return Icons.tv;
      case 'internet':
        return Icons.router;
      case 'electricity':
        return Icons.bolt;
      case 'airtime':
        return Icons.phone_android;
      default:
        return Icons.subscriptions;
    }
  }

  Color get statusColor {
    if (isExpired) return const Color(0xFFEF4444);
    if (isExpiringSoon) return const Color(0xFFFB923C);
    if (isActive) return const Color(0xFF10B981);
    return const Color(0xFF9CA3AF);
  }

  @override
  List<Object?> get props => [
        id,
        subscriptionType,
        providerId,
        providerName,
        planName,
        amount,
        currency,
        customerNumber,
        status,
        purchasedAt,
        expiresAt,
        validityDays,
        renewalDate,
        token,
        units,
        progressPercentage,
        daysRemaining,
        paymentReference,
      ];
}
