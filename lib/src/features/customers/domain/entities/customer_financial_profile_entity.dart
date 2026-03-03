import 'package:equatable/equatable.dart';

class CustomerFinancialProfileEntity extends Equatable {
  final String customerId;
  final double totalInvoiced; // Major units (Naira)
  final double totalPaid; // Major units (Naira)
  final double outstanding; // Major units (Naira)
  final int avgPaymentDays;
  final int totalInvoices;
  final int paidInvoices;
  final int overdueInvoices;
  final DateTime? lastPaymentDate;

  const CustomerFinancialProfileEntity({
    required this.customerId,
    required this.totalInvoiced,
    required this.totalPaid,
    required this.outstanding,
    required this.avgPaymentDays,
    required this.totalInvoices,
    required this.paidInvoices,
    required this.overdueInvoices,
    this.lastPaymentDate,
  });

  String get formattedTotalInvoiced =>
      '\u20A6${totalInvoiced.toStringAsFixed(2)}';

  String get formattedOutstanding => '\u20A6${outstanding.toStringAsFixed(2)}';

  double get paymentRate {
    if (totalInvoices == 0) return 0.0;
    return (paidInvoices / totalInvoices) * 100;
  }

  @override
  List<Object?> get props => [
        customerId,
        totalInvoiced,
        totalPaid,
        outstanding,
        avgPaymentDays,
        totalInvoices,
        paidInvoices,
        overdueInvoices,
        lastPaymentDate,
      ];
}
