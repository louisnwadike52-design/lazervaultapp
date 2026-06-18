import 'package:equatable/equatable.dart';

enum SplitBillStatus { active, completed, cancelled, expired }

enum SplitBillParticipantStatus { pending, paid, declined }

enum SplitMethodType { equal, custom, percentage }

class SplitBillEntity extends Equatable {
  final String id;
  final String creatorId;
  final String creatorUsername;
  final String creatorName;
  final double totalAmount;
  final double creatorShare;
  final String currency;
  final String description;
  final SplitMethodType splitMethod;
  final SplitBillStatus status;
  final String reference;
  final int totalParticipants;
  final int paidCount;
  final double paidAmount;
  final List<SplitBillParticipantEntity> participants;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Receiver (the third-party payee co-payers pay TO). receiverType: '' (legacy →
  // creator), 'internal_user', or 'external_bank'.
  final String receiverType;
  final String receiverName;
  final String receiverAccountMasked;
  final String settlementStatus;
  final double withdrawalFee;

  const SplitBillEntity({
    required this.id,
    required this.creatorId,
    required this.creatorUsername,
    required this.creatorName,
    required this.totalAmount,
    required this.creatorShare,
    required this.currency,
    required this.description,
    required this.splitMethod,
    required this.status,
    required this.reference,
    required this.totalParticipants,
    required this.paidCount,
    required this.paidAmount,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
    this.receiverType = '',
    this.receiverName = '',
    this.receiverAccountMasked = '',
    this.settlementStatus = 'not_applicable',
    this.withdrawalFee = 0.0,
  });

  bool get isCompleted => status == SplitBillStatus.completed;
  bool get isActive => status == SplitBillStatus.active;

  /// True when the bill pays an explicit third-party receiver (not the creator).
  bool get hasExternalReceiver => receiverType == 'external_bank';
  bool get hasReceiver => receiverType.isNotEmpty;

  /// Human label for who collects the money ("the receiver").
  String get receiverDisplay {
    if (receiverName.isNotEmpty) return receiverName;
    if (!hasReceiver) return creatorName.isNotEmpty ? creatorName : '@$creatorUsername';
    return receiverAccountMasked;
  }

  /// Co-payers who have paid (for the "who's paid" sheet).
  List<SplitBillParticipantEntity> get paidParticipants =>
      participants.where((p) => p.isPaid).toList();

  /// Co-payers still owing.
  List<SplitBillParticipantEntity> get pendingParticipants =>
      participants.where((p) => p.isPending).toList();

  double get progressPercent =>
      totalParticipants > 0
          ? (paidCount / totalParticipants).clamp(0.0, 1.0)
          : 0.0;

  String get progressLabel => '$paidCount/$totalParticipants paid';

  String get formattedTotal =>
      '${_currencySymbol(currency)}${totalAmount.toStringAsFixed(2)}';

  String get formattedPaidAmount =>
      '${_currencySymbol(currency)}${paidAmount.toStringAsFixed(2)}';

  /// Find the participant record for a given user ID
  SplitBillParticipantEntity? participantForUser(String userId) {
    try {
      return participants.firstWhere((p) => p.userId == userId);
    } catch (_) {
      return null;
    }
  }

  static String _currencySymbol(String code) {
    switch (code) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'GHS':
        return 'GH\u20B5';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '$code ';
    }
  }

  @override
  List<Object?> get props => [
        id,
        creatorId,
        totalAmount,
        status,
        paidCount,
        paidAmount,
        participants,
        createdAt,
      ];
}

class SplitBillParticipantEntity extends Equatable {
  final String id;
  final String splitBillId;
  final String userId;
  final String username;
  final String displayName;
  final double amount;
  final double percentage;
  final SplitBillParticipantStatus status;
  final String? transactionReference;
  final DateTime? paidAt;
  final bool isCreator;

  const SplitBillParticipantEntity({
    required this.id,
    required this.splitBillId,
    required this.userId,
    required this.username,
    required this.displayName,
    required this.amount,
    required this.percentage,
    required this.status,
    this.transactionReference,
    this.paidAt,
    this.isCreator = false,
  });

  bool get isPending => status == SplitBillParticipantStatus.pending;
  bool get isPaid => status == SplitBillParticipantStatus.paid;
  bool get isDeclined => status == SplitBillParticipantStatus.declined;

  String formattedAmount(String currency) =>
      '${SplitBillEntity._currencySymbol(currency)}${amount.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [id, splitBillId, userId, status, amount, paidAt];
}

class SplitBillsPageResult {
  final List<SplitBillEntity> bills;
  final int total;
  final int page;
  final int totalPages;

  const SplitBillsPageResult({
    required this.bills,
    required this.total,
    required this.page,
    required this.totalPages,
  });
}
