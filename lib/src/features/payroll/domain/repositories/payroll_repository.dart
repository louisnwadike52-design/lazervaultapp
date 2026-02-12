import 'package:lazervault/src/features/payroll/domain/entities/employee_entity.dart';
import 'package:lazervault/src/features/payroll/domain/entities/pay_run_entity.dart';
import 'package:lazervault/src/features/payroll/domain/entities/pay_slip_entity.dart';

abstract class PayrollRepository {
  // Employee Management
  Future<EmployeeEntity> addEmployee({
    required String fullName,
    required String email,
    required String phone,
    String nin = '',
    String bankAccountNumber = '',
    String bankCode = '',
    String bankName = '',
    required EmploymentType employmentType,
    required int payRate, // in kobo
    required PayFrequency payFrequency,
    String department = '',
    String jobTitle = '',
    String? startDate,
    String? userId,
  });
  Future<EmployeeEntity> updateEmployee({
    required String employeeId,
    String? fullName,
    String? email,
    String? phone,
    String? nin,
    String? bankAccountNumber,
    String? bankCode,
    String? bankName,
    EmploymentType? employmentType,
    int? payRate,
    PayFrequency? payFrequency,
    String? department,
    String? jobTitle,
    EmployeeStatus? status,
  });
  Future<void> removeEmployee(String employeeId);
  Future<EmployeeEntity> getEmployee(String employeeId);
  Future<EmployeesPageResult> listEmployees({
    int page = 1,
    int limit = 20,
    String? search,
    String? department,
  });

  // Pay Run Management
  Future<PayRunEntity> createPayRun({
    required String payPeriodStart,
    required String payPeriodEnd,
  });
  Future<PayRunEntity> calculatePayRun(String payRunId);
  Future<PayRunEntity> approvePayRun(String payRunId);
  Future<PayRunEntity> processPayRun({
    required String payRunId,
    required String transactionPin,
    required String sourceAccountId,
  });
  Future<PayRunEntity> getPayRun(String payRunId);
  Future<PayRunsPageResult> listPayRuns({int page = 1, int limit = 20});

  // Payslips
  Future<PaySlipEntity> getPaySlip(String paySlipId);
  Future<PaySlipsPageResult> listPaySlips({
    required String payRunId,
    int page = 1,
    int limit = 20,
  });

  // Reports
  Future<Map<String, dynamic>> getPayrollSummary({
    required String periodStart,
    required String periodEnd,
  });
  Future<Map<String, dynamic>> getTaxReport({
    required String periodStart,
    required String periodEnd,
  });
}
