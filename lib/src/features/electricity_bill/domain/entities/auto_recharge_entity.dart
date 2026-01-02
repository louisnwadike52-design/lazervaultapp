import 'package:equatable/equatable.dart';
import 'bill_payment_entity.dart';

enum AutoRechargeStatus {
  active,
  paused,
  expired,
  cancelled,
}

extension AutoRechargeStatusExtension on AutoRechargeStatus {
  String get displayName {
    switch (this) {
      case AutoRechargeStatus.active:
        return 'Active';
      case AutoRechargeStatus.paused:
        return 'Paused';
      case AutoRechargeStatus.expired:
        return 'Expired';
      case AutoRechargeStatus.cancelled:
        return 'Cancelled';
    }
  }

  static AutoRechargeStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AutoRechargeStatus.active;
      case 'paused':
        return AutoRechargeStatus.paused;
      case 'expired':
        return AutoRechargeStatus.expired;
      case 'cancelled':
        return AutoRechargeStatus.cancelled;
      default:
        return AutoRechargeStatus.active;
    }
  }
}

enum RechargeFrequency {
  daily,
  weekly,
  monthly,
}

extension RechargeFrequencyExtension on RechargeFrequency {
  String get displayName {
    switch (this) {
      case RechargeFrequency.daily:
        return 'Daily';
      case RechargeFrequency.weekly:
        return 'Weekly';
      case RechargeFrequency.monthly:
        return 'Monthly';
    }
  }

  static RechargeFrequency fromString(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'daily':
        return RechargeFrequency.daily;
      case 'weekly':
        return RechargeFrequency.weekly;
      case 'monthly':
        return RechargeFrequency.monthly;
      default:
        return RechargeFrequency.monthly;
    }
  }
}

class AutoRechargeEntity extends Equatable {
  final String id;
  final String userId;
  final String beneficiaryId;
  final String providerId;
  final String providerCode;
  final String providerName;
  final String meterNumber;
  final String customerName;
  final MeterType meterType;
  final double amount;
  final String currency;
  final RechargeFrequency frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;
  final AutoRechargeStatus status;
  final DateTime nextRunDate;
  final DateTime? lastRunDate;
  final int failureCount;
  final int maxRetries;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AutoRechargeEntity({
    required this.id,
    required this.userId,
    required this.beneficiaryId,
    required this.providerId,
    required this.providerCode,
    required this.providerName,
    required this.meterNumber,
    required this.customerName,
    required this.meterType,
    required this.amount,
    required this.currency,
    required this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    required this.status,
    required this.nextRunDate,
    this.lastRunDate,
    required this.failureCount,
    required this.maxRetries,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == AutoRechargeStatus.active;
  bool get isPaused => status == AutoRechargeStatus.paused;
  bool get isExpired => status == AutoRechargeStatus.expired;
  bool get isCancelled => status == AutoRechargeStatus.cancelled;
  bool get hasFailures => failureCount > 0;
  bool get isDue => DateTime.now().isAfter(nextRunDate);
  bool get hasRunBefore => lastRunDate != null;

  String get frequencyDescription {
    switch (frequency) {
      case RechargeFrequency.daily:
        return 'Every day';
      case RechargeFrequency.weekly:
        final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        return 'Every ${dayOfWeek != null && dayOfWeek! >= 1 && dayOfWeek! <= 7 ? days[dayOfWeek! - 1] : "week"}';
      case RechargeFrequency.monthly:
        return 'On day ${dayOfMonth ?? 1} of every month';
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        beneficiaryId,
        providerId,
        providerCode,
        providerName,
        meterNumber,
        customerName,
        meterType,
        amount,
        currency,
        frequency,
        dayOfWeek,
        dayOfMonth,
        status,
        nextRunDate,
        lastRunDate,
        failureCount,
        maxRetries,
        createdAt,
        updatedAt,
      ];
}
