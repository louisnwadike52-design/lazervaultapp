import 'package:equatable/equatable.dart';

/// A betting platform the user can fund (Bet9ja, SportyBet, etc.).
class BettingPlatform extends Equatable {
  final String code;
  final String name;
  final String logoUrl;
  final bool isActive;
  final double minAmount;
  final double maxAmount;

  const BettingPlatform({
    required this.code,
    required this.name,
    required this.logoUrl,
    required this.isActive,
    required this.minAmount,
    required this.maxAmount,
  });

  @override
  List<Object?> get props =>
      [code, name, logoUrl, isActive, minAmount, maxAmount];
}

/// Result of verifying a betting account id — resolves the holder name.
class BettingAccountVerification extends Equatable {
  final bool valid;
  final String accountName;
  final String message;

  const BettingAccountVerification({
    required this.valid,
    required this.accountName,
    required this.message,
  });

  @override
  List<Object?> get props => [valid, accountName, message];
}

/// A saved betting account (select-don't-type on future fundings).
class BettingBeneficiary extends Equatable {
  final String id;
  final String platform;
  final String accountUserid;
  final String accountName;
  final String nickname;
  final bool isDefault;
  final String createdAt;

  const BettingBeneficiary({
    required this.id,
    required this.platform,
    required this.accountUserid,
    required this.accountName,
    required this.nickname,
    required this.isDefault,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, platform, accountUserid, accountName, nickname, isDefault, createdAt];
}

/// A funding transaction (backed by the shared BillPayment message).
class BettingFundingRecord extends Equatable {
  final String id;
  final String platform;
  final String customerNumber;
  final double amount;
  final String status;
  final String reference;
  final String createdAt;

  const BettingFundingRecord({
    required this.id,
    required this.platform,
    required this.customerNumber,
    required this.amount,
    required this.status,
    required this.reference,
    required this.createdAt,
  });

  bool get isCompleted {
    final s = status.toLowerCase();
    return s == 'completed' || s == 'success' || s == 'delivered';
  }

  bool get isFailed {
    final s = status.toLowerCase();
    return s == 'failed' || s == 'cancelled' || s == 'reversed';
  }

  /// Terminal REFUNDED state — the funding didn't go through and the money was
  /// returned to the wallet. Must be distinct from [isPending] so the receipt
  /// doesn't show "Funding pending" for an already-refunded transaction.
  bool get isRefunded {
    final s = status.toLowerCase().trim();
    return s == 'refunded' || s == 'refund_completed';
  }

  bool get isPending => !isCompleted && !isFailed && !isRefunded;

  @override
  List<Object?> get props =>
      [id, platform, customerNumber, amount, status, reference, createdAt];
}

/// Result of an initiate-funding call.
class BettingFundingResult extends Equatable {
  final BettingFundingRecord payment;
  final double newBalance;
  final String providerReference;
  final String message;

  const BettingFundingResult({
    required this.payment,
    required this.newBalance,
    required this.providerReference,
    required this.message,
  });

  @override
  List<Object?> get props => [payment, newBalance, providerReference, message];
}
