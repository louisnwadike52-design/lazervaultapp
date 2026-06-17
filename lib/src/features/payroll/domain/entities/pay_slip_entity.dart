import 'package:equatable/equatable.dart';

class PaySlipsPageResult {
  final List<PaySlipEntity> paySlips;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const PaySlipsPageResult({
    required this.paySlips,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

enum PaymentStatus { pending, paid, failed }

class PaySlipEntity extends Equatable {
  final String id;
  final String payRunId;
  final String employeeId;
  final String employeeName;
  final double grossPay;
  final double incomeTax;
  final double nationalInsurance;
  final double studentLoanRepayment;
  final double pensionContribution;
  final double otherDeductions;
  final double totalDeductions;
  final double netPay;
  final double employerNIC;
  final double employerPension;
  final double hoursWorked;
  final double overtimeHours;
  final double overtimePay;
  final double bonuses;
  final double commissions;
  final PaymentStatus paymentStatus;
  final String paymentReference;
  final DateTime createdAt;

  const PaySlipEntity({
    required this.id,
    required this.payRunId,
    required this.employeeId,
    required this.employeeName,
    required this.grossPay,
    required this.incomeTax,
    required this.nationalInsurance,
    required this.studentLoanRepayment,
    required this.pensionContribution,
    required this.otherDeductions,
    required this.totalDeductions,
    required this.netPay,
    required this.employerNIC,
    required this.employerPension,
    required this.hoursWorked,
    required this.overtimeHours,
    required this.overtimePay,
    required this.bonuses,
    required this.commissions,
    required this.paymentStatus,
    required this.paymentReference,
    required this.createdAt,
  });

  String get formattedGross => '\u20A6${grossPay.toStringAsFixed(2)}';
  String get formattedNet => '\u20A6${netPay.toStringAsFixed(2)}';
  String get formattedDeductions => '\u20A6${totalDeductions.toStringAsFixed(2)}';

  bool get isPaid => paymentStatus == PaymentStatus.paid;

  @override
  List<Object?> get props => [id, employeeId, grossPay, netPay, paymentStatus];
}
