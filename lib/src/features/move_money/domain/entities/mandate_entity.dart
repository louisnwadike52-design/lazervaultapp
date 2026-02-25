import 'package:equatable/equatable.dart';

enum MandateType { emandate, gsm, signed }

enum MandateStatus {
  pending,
  awaitingAuthorization,
  authorized,
  active,
  readyToDebit,
  paused,
  cancelled,
  expired,
  rejected,
}

MandateStatus mandateStatusFromString(String status) {
  switch (status.toLowerCase().replaceAll('_', '')) {
    case 'pending':
      return MandateStatus.pending;
    case 'awaitingauthorization':
      return MandateStatus.awaitingAuthorization;
    case 'authorized':
      return MandateStatus.authorized;
    case 'active':
      return MandateStatus.active;
    case 'readytodebit':
      return MandateStatus.readyToDebit;
    case 'paused':
      return MandateStatus.paused;
    case 'cancelled':
      return MandateStatus.cancelled;
    case 'expired':
      return MandateStatus.expired;
    case 'rejected':
      return MandateStatus.rejected;
    default:
      return MandateStatus.pending;
  }
}

MandateType mandateTypeFromString(String type) {
  switch (type.toLowerCase().replaceAll('_', '').replaceAll('-', '')) {
    case 'emandate':
      return MandateType.emandate;
    case 'gsm':
      return MandateType.gsm;
    case 'signed':
      return MandateType.signed;
    default:
      return MandateType.gsm;
  }
}

class MandateEntity extends Equatable {
  final String id;
  final String monoMandateId;
  final String userId;
  final String linkedAccountId;
  final String monoCustomerId;
  final String bankName;
  final String bankCode;
  final String accountNumber;
  final String accountName;
  final MandateType mandateType;
  final MandateStatus status;
  final int amountLimit; // kobo, 0 = unlimited
  final int debitLimit;
  final int debitCount;
  final int totalDebited; // kobo
  final int remainingLimit; // kobo
  final bool canDebit;
  final bool isExpired;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime? authorizedAt;
  final DateTime? readyAt;
  final DateTime? lastDebitAt;
  final DateTime? cancelledAt;
  final String reference;
  final String? description;

  const MandateEntity({
    required this.id,
    required this.monoMandateId,
    required this.userId,
    required this.linkedAccountId,
    this.monoCustomerId = '',
    this.bankName = '',
    this.bankCode = '',
    this.accountNumber = '',
    this.accountName = '',
    this.mandateType = MandateType.gsm,
    required this.status,
    this.amountLimit = 0,
    this.debitLimit = 0,
    this.debitCount = 0,
    this.totalDebited = 0,
    this.remainingLimit = 0,
    this.canDebit = false,
    this.isExpired = false,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.authorizedAt,
    this.readyAt,
    this.lastDebitAt,
    this.cancelledAt,
    this.reference = '',
    this.description,
  });

  /// Whether this mandate is in a usable state for auto-debit
  bool get isActive =>
      status == MandateStatus.active ||
      status == MandateStatus.readyToDebit;

  /// Whether this mandate is still being set up
  bool get isActivating =>
      status == MandateStatus.awaitingAuthorization ||
      status == MandateStatus.authorized;

  @override
  List<Object?> get props => [
        id,
        monoMandateId,
        userId,
        linkedAccountId,
        status,
        amountLimit,
        totalDebited,
        remainingLimit,
        canDebit,
        isExpired,
        startDate,
        endDate,
        createdAt,
      ];
}
