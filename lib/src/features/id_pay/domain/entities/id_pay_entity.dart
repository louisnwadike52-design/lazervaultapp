import 'package:equatable/equatable.dart';

enum IDPayStatus {
  active,
  paid,
  expired,
  cancelled,
}

extension IDPayStatusExtension on IDPayStatus {
  String get displayName {
    switch (this) {
      case IDPayStatus.active:
        return 'Active';
      case IDPayStatus.paid:
        return 'Paid';
      case IDPayStatus.expired:
        return 'Expired';
      case IDPayStatus.cancelled:
        return 'Cancelled';
    }
  }

  static IDPayStatus fromInt(int value) {
    switch (value) {
      case 1:
        return IDPayStatus.active;
      case 2:
        return IDPayStatus.paid;
      case 3:
        return IDPayStatus.expired;
      case 4:
        return IDPayStatus.cancelled;
      default:
        return IDPayStatus.active;
    }
  }
}

enum IDPayType {
  oneTime,
  recurring,
}

extension IDPayTypeExtension on IDPayType {
  String get displayName {
    switch (this) {
      case IDPayType.oneTime:
        return 'One-Time';
      case IDPayType.recurring:
        return 'Recurring';
    }
  }
}

enum IDPayAmountMode {
  fixed,
  flexible,
}

extension IDPayAmountModeExtension on IDPayAmountMode {
  String get displayName {
    switch (this) {
      case IDPayAmountMode.fixed:
        return 'Fixed';
      case IDPayAmountMode.flexible:
        return 'Flexible';
    }
  }
}

class IDPayEntity extends Equatable {
  final String id;
  final String payId;
  final String creatorId;
  final String creatorName;
  final String creatorUsername;
  final IDPayType type;
  final IDPayAmountMode amountMode;
  final double amount;
  final double minAmount;
  final double maxAmount;
  final String currency;
  final String description;
  final IDPayStatus status;
  final DateTime expiresAt;
  final DateTime createdAt;
  final double totalReceived;
  final int paymentCount;

  const IDPayEntity({
    required this.id,
    required this.payId,
    required this.creatorId,
    required this.creatorName,
    required this.creatorUsername,
    required this.type,
    required this.amountMode,
    required this.amount,
    required this.minAmount,
    required this.maxAmount,
    required this.currency,
    required this.description,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
    required this.totalReceived,
    required this.paymentCount,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isActive => status == IDPayStatus.active && !isExpired;
  bool get isPaid => status == IDPayStatus.paid;
  bool get isOneTime => type == IDPayType.oneTime;
  bool get isRecurring => type == IDPayType.recurring;
  bool get isFixed => amountMode == IDPayAmountMode.fixed;
  bool get isFlexible => amountMode == IDPayAmountMode.flexible;

  String get displayPayId => 'PAY-$payId';

  @override
  List<Object?> get props => [
        id,
        payId,
        creatorId,
        creatorName,
        creatorUsername,
        type,
        amountMode,
        amount,
        minAmount,
        maxAmount,
        currency,
        description,
        status,
        expiresAt,
        createdAt,
        totalReceived,
        paymentCount,
      ];
}
