import 'package:lazervault/src/features/payroll/domain/entities/employee_entity.dart';
import 'package:lazervault/src/features/payroll/domain/entities/pay_run_entity.dart';
import 'package:lazervault/src/features/payroll/domain/entities/pay_slip_entity.dart';

sealed class PayrollState {}

class PayrollInitial extends PayrollState {}

class PayrollLoading extends PayrollState {}

class PayrollError extends PayrollState {
  final String message;
  PayrollError({required this.message});
}

// Employee states
class EmployeesLoaded extends PayrollState {
  final List<EmployeeEntity> employees;
  final int totalPages;
  final bool isStale;
  EmployeesLoaded({
    required this.employees,
    this.totalPages = 1,
    this.isStale = false,
  });
}

class EmployeeLoaded extends PayrollState {
  final EmployeeEntity employee;
  EmployeeLoaded({required this.employee});
}

class EmployeeAdded extends PayrollState {
  final String message;
  EmployeeAdded({required this.message});
}

class EmployeeUpdated extends PayrollState {
  final String message;
  EmployeeUpdated({required this.message});
}

class EmployeeRemoved extends PayrollState {
  final String message;
  EmployeeRemoved({required this.message});
}

// Pay Run states
class PayRunsLoaded extends PayrollState {
  final List<PayRunEntity> payRuns;
  final int totalPages;
  PayRunsLoaded({required this.payRuns, this.totalPages = 1});
}

class PayRunLoaded extends PayrollState {
  final PayRunEntity payRun;
  PayRunLoaded({required this.payRun});
}

class PayRunCreated extends PayrollState {
  final String message;
  final PayRunEntity payRun;
  PayRunCreated({required this.message, required this.payRun});
}

class PayRunCalculated extends PayrollState {
  final PayRunEntity payRun;
  final List<PaySlipEntity> paySlips;
  PayRunCalculated({required this.payRun, required this.paySlips});
}

class PayRunApproved extends PayrollState {
  final String message;
  PayRunApproved({required this.message});
}

class PayRunProcessed extends PayrollState {
  final String message;
  final int successfulPayments;
  final int failedPayments;
  PayRunProcessed({
    required this.message,
    required this.successfulPayments,
    required this.failedPayments,
  });
}

// Pay Slip states
class PaySlipsLoaded extends PayrollState {
  final List<PaySlipEntity> paySlips;
  final int totalPages;
  PaySlipsLoaded({required this.paySlips, this.totalPages = 1});
}

class PaySlipLoaded extends PayrollState {
  final PaySlipEntity paySlip;
  PaySlipLoaded({required this.paySlip});
}

// Report states
class PayrollSummaryLoaded extends PayrollState {
  final Map<String, dynamic> summary;
  PayrollSummaryLoaded({required this.summary});
}

class TaxReportLoaded extends PayrollState {
  final Map<String, dynamic> report;
  TaxReportLoaded({required this.report});
}
