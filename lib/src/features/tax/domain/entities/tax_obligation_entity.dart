import 'package:equatable/equatable.dart';
import 'dart:ui';

enum TaxType { vat, paye, wht, cit }

enum TaxObligationStatus { pending, filed, paid, overdue }

class TaxObligationEntity extends Equatable {
  final String id;
  final String businessId;
  final TaxType taxType;
  final String period;
  final double amount; // Major units (Naira)
  final TaxObligationStatus status;
  final DateTime dueDate;
  final DateTime? filedDate;
  final DateTime? paidDate;
  final String reference;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaxObligationEntity({
    required this.id,
    required this.businessId,
    required this.taxType,
    required this.period,
    required this.amount,
    required this.status,
    required this.dueDate,
    this.filedDate,
    this.paidDate,
    required this.reference,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  String get taxTypeDisplay {
    switch (taxType) {
      case TaxType.vat: return 'VAT';
      case TaxType.paye: return 'PAYE';
      case TaxType.wht: return 'WHT';
      case TaxType.cit: return 'CIT';
    }
  }

  String get statusDisplay {
    switch (status) {
      case TaxObligationStatus.pending: return 'Pending';
      case TaxObligationStatus.filed: return 'Filed';
      case TaxObligationStatus.paid: return 'Paid';
      case TaxObligationStatus.overdue: return 'Overdue';
    }
  }

  Color get statusColor {
    switch (status) {
      case TaxObligationStatus.pending: return const Color(0xFFFB923C);
      case TaxObligationStatus.filed: return const Color(0xFF3B82F6);
      case TaxObligationStatus.paid: return const Color(0xFF10B981);
      case TaxObligationStatus.overdue: return const Color(0xFFEF4444);
    }
  }

  Color get taxTypeColor {
    switch (taxType) {
      case TaxType.vat: return const Color(0xFF3B82F6);
      case TaxType.paye: return const Color(0xFF10B981);
      case TaxType.wht: return const Color(0xFFFB923C);
      case TaxType.cit: return const Color(0xFF8B5CF6);
    }
  }

  String get formattedAmount => '\u20A6${amount.toStringAsFixed(2)}';

  bool get isOverdue => status == TaxObligationStatus.overdue || (status == TaxObligationStatus.pending && dueDate.isBefore(DateTime.now()));

  int get daysUntilDue => dueDate.difference(DateTime.now()).inDays;

  @override
  List<Object?> get props => [id, taxType, period, status];
}
