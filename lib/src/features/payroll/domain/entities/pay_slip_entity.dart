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

  /// Whether the employer owed ANYTHING on top of gross for this slip.
  ///
  /// None of the employer contributions applies to every Nigerian employer —
  /// pension is mandatory at 15+ employees (PRA 2014 s.2), NSITF and ITF at
  /// 5+ (ECA 2010 s.33, ITF Act s.6(1)) — and an operator switches off what a
  /// business does not owe. The engine then charges 0 and stores 0.
  ///
  /// So a zero is an EXEMPTION, not a missing figure, and the surfaces hide
  /// the section rather than printing "₦0.00" — which reads as a calculation
  /// that failed.
  ///
  /// Reads the STORED values rather than today's configuration on purpose: a
  /// payslip from a month when the pension was charged must keep showing it
  /// after the switch is turned off.
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

  /// True when at least one employer contribution was actually charged.
  bool get hasEmployerContributions => employerNIC > 0 || employerPension > 0;

  String get formattedGross => '\u20A6${grossPay.toStringAsFixed(2)}';
  String get formattedNet => '\u20A6${netPay.toStringAsFixed(2)}';
  String get formattedDeductions =>
      '\u20A6${totalDeductions.toStringAsFixed(2)}';

  bool get isPaid => paymentStatus == PaymentStatus.paid;

  @override
  List<Object?> get props => [id, employeeId, grossPay, netPay, paymentStatus];
}
