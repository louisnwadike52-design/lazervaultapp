import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_pb;
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/pay_run_entity.dart';
import '../../domain/entities/pay_slip_entity.dart';
import '../../domain/repositories/payroll_repository.dart';

class PayrollRepositoryGrpcImpl implements PayrollRepository {
  final payroll_pb.PayrollServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  PayrollRepositoryGrpcImpl({
    required payroll_pb.PayrollServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ---------------------------------------------------------------------------
  // Employee Management
  // ---------------------------------------------------------------------------

  @override
  Future<EmployeeEntity> addEmployee({
    required String fullName,
    required String email,
    required String phone,
    String nin = '',
    String bankAccountNumber = '',
    String bankCode = '',
    String bankName = '',
    required EmploymentType employmentType,
    required int payRate,
    required PayFrequency payFrequency,
    String department = '',
    String jobTitle = '',
    String? startDate,
    String? userId,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.AddEmployeeRequest()
          ..fullName = fullName
          ..email = email
          ..phone = phone
          ..nin = nin
          ..bankAccountNumber = bankAccountNumber
          ..bankCode = bankCode
          ..bankName = bankName
          ..employmentType = _employmentTypeToProto(employmentType)
          ..payRate = $fixnum.Int64(payRate)
          ..payFrequency = _payFrequencyToProto(payFrequency)
          ..department = department
          ..jobTitle = jobTitle;

        if (startDate != null) {
          request.startDate = startDate;
        }
        if (userId != null) {
          request.userId = userId;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.addEmployee(request, options: options);

        if (!response.success) {
          throw Exception(response.message);
        }

        return _employeeFromProto(response.employee);
      },
    );
  }

  @override
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
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.UpdateEmployeeRequest()
          ..employeeId = employeeId;

        if (fullName != null) request.fullName = fullName;
        if (email != null) request.email = email;
        if (phone != null) request.phone = phone;
        if (nin != null) request.nin = nin;
        if (bankAccountNumber != null) {
          request.bankAccountNumber = bankAccountNumber;
        }
        if (bankCode != null) request.bankCode = bankCode;
        if (bankName != null) request.bankName = bankName;
        if (employmentType != null) {
          request.employmentType = _employmentTypeToProto(employmentType);
        }
        if (payRate != null) request.payRate = $fixnum.Int64(payRate);
        if (payFrequency != null) {
          request.payFrequency = _payFrequencyToProto(payFrequency);
        }
        if (department != null) request.department = department;
        if (jobTitle != null) request.jobTitle = jobTitle;
        if (status != null) {
          request.status = _employeeStatusToProto(status);
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.updateEmployee(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _employeeFromProto(response.employee);
      },
    );
  }

  @override
  Future<void> removeEmployee(String employeeId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.RemoveEmployeeRequest()
          ..employeeId = employeeId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.removeEmployee(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }
      },
    );
  }

  @override
  Future<EmployeeEntity> getEmployee(String employeeId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetEmployeeRequest()
          ..employeeId = employeeId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getEmployee(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _employeeFromProto(response.employee);
      },
    );
  }

  @override
  Future<EmployeesPageResult> listEmployees({
    int page = 1,
    int limit = 20,
    String? search,
    String? department,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListEmployeesRequest()
          ..page = page
          ..limit = limit;

        if (search != null && search.isNotEmpty) {
          request.search = search;
        }
        if (department != null && department.isNotEmpty) {
          request.department = department;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listEmployees(
          request,
          options: options,
        );

        return EmployeesPageResult(
          employees: response.employees
              .map((e) => _employeeFromProto(e))
              .toList(),
          totalItems: response.pagination.totalItems,
          currentPage: response.pagination.currentPage,
          totalPages: response.pagination.totalPages,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Pay Run Management
  // ---------------------------------------------------------------------------

  @override
  Future<PayRunEntity> createPayRun({
    required String payPeriodStart,
    required String payPeriodEnd,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CreatePayRunRequest()
          ..payPeriodStart = payPeriodStart
          ..payPeriodEnd = payPeriodEnd;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.createPayRun(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _payRunFromProto(response.payRun);
      },
    );
  }

  @override
  Future<PayRunEntity> calculatePayRun(String payRunId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CalculatePayRunRequest()
          ..payRunId = payRunId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.calculatePayRun(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _payRunFromProto(response.payRun);
      },
    );
  }

  @override
  Future<PayRunEntity> approvePayRun(String payRunId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ApprovePayRunRequest()
          ..payRunId = payRunId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.approvePayRun(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _payRunFromProto(response.payRun);
      },
    );
  }

  @override
  Future<PayRunEntity> processPayRun({
    required String payRunId,
    required String transactionPin,
    required String sourceAccountId,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ProcessPayRunRequest()
          ..payRunId = payRunId
          ..transactionPin = transactionPin
          ..sourceAccountId = sourceAccountId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.processPayRun(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _payRunFromProto(response.payRun);
      },
    );
  }

  @override
  Future<PayRunEntity> getPayRun(String payRunId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetPayRunRequest()
          ..payRunId = payRunId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getPayRun(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _payRunFromProto(response.payRun);
      },
    );
  }

  @override
  Future<PayRunsPageResult> listPayRuns({int page = 1, int limit = 20}) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListPayRunsRequest()
          ..page = page
          ..limit = limit;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listPayRuns(
          request,
          options: options,
        );

        return PayRunsPageResult(
          payRuns: response.payRuns
              .map((pr) => _payRunFromProto(pr))
              .toList(),
          totalItems: response.pagination.totalItems,
          currentPage: response.pagination.currentPage,
          totalPages: response.pagination.totalPages,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Payslips
  // ---------------------------------------------------------------------------

  @override
  Future<PaySlipEntity> getPaySlip(String paySlipId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetPaySlipRequest()
          ..paySlipId = paySlipId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getPaySlip(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _paySlipFromProto(response.paySlip);
      },
    );
  }

  @override
  Future<PaySlipsPageResult> listPaySlips({
    required String payRunId,
    int page = 1,
    int limit = 20,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListPaySlipsRequest()
          ..payRunId = payRunId
          ..page = page
          ..limit = limit;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listPaySlips(
          request,
          options: options,
        );

        return PaySlipsPageResult(
          paySlips: response.paySlips
              .map((ps) => _paySlipFromProto(ps))
              .toList(),
          totalItems: response.pagination.totalItems,
          currentPage: response.pagination.currentPage,
          totalPages: response.pagination.totalPages,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Reports
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getPayrollSummary({
    required String periodStart,
    required String periodEnd,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetPayrollSummaryRequest()
          ..periodStart = periodStart
          ..periodEnd = periodEnd;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getPayrollSummary(
          request,
          options: options,
        );

        return {
          'totalGross': response.totalGrossPaid.toInt() / 100.0,
          'totalDeductions': response.totalDeductions.toInt() / 100.0,
          'totalNet': response.totalNetPaid.toInt() / 100.0,
          'totalEmployerContributions':
              response.totalEmployerContributions.toInt() / 100.0,
          'employeeCount': response.totalEmployees,
          'payRunCount': response.totalPayRuns,
        };
      },
    );
  }

  @override
  Future<Map<String, dynamic>> getTaxReport({
    required String periodStart,
    required String periodEnd,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetTaxReportRequest()
          ..periodStart = periodStart
          ..periodEnd = periodEnd;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getTaxReport(
          request,
          options: options,
        );

        return {
          'totalPaye': response.totalPaye.toInt() / 100.0,
          'totalNhf': response.totalNhf.toInt() / 100.0,
          'totalPension': response.totalPensionEmployee.toInt() / 100.0,
          'totalNsitf': response.totalNsitf.toInt() / 100.0,
          'totalItf': response.totalItf.toInt() / 100.0,
          'employeeCount': response.employeeSummaries.length,
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Proto → Entity Mappers
  // ---------------------------------------------------------------------------

  EmployeeEntity _employeeFromProto(payroll_pb.Employee proto) {
    return EmployeeEntity(
      id: proto.id,
      userId: proto.userId.isNotEmpty ? proto.userId : null,
      businessId: proto.businessId,
      fullName: proto.fullName,
      email: proto.email,
      phone: proto.phone,
      nin: proto.nin,
      bankAccountNumber: proto.bankAccountNumber,
      bankCode: proto.bankCode,
      bankName: proto.bankName,
      employmentType: _employmentTypeFromProto(proto.employmentType),
      payRate: proto.payRate.toInt() / 100.0,
      payFrequency: _payFrequencyFromProto(proto.payFrequency),
      department: proto.department,
      jobTitle: proto.jobTitle,
      startDate: proto.startDate.isNotEmpty ? proto.startDate : null,
      status: _employeeStatusFromProto(proto.status),
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  PayRunEntity _payRunFromProto(payroll_pb.PayRun proto) {
    return PayRunEntity(
      id: proto.id,
      businessId: proto.businessId,
      payPeriodStart: proto.payPeriodStart,
      payPeriodEnd: proto.payPeriodEnd,
      status: _payRunStatusFromProto(proto.status),
      totalGross: proto.totalGross.toInt() / 100.0,
      totalDeductions: proto.totalDeductions.toInt() / 100.0,
      totalNet: proto.totalNet.toInt() / 100.0,
      totalEmployerContributions:
          proto.totalEmployerContributions.toInt() / 100.0,
      employeeCount: proto.employeeCount,
      createdBy: proto.createdBy,
      approvedBy: proto.approvedBy.isNotEmpty ? proto.approvedBy : null,
      createdAt: proto.createdAt.toDateTime(),
      processedAt:
          proto.hasProcessedAt() ? proto.processedAt.toDateTime() : null,
    );
  }

  PaySlipEntity _paySlipFromProto(payroll_pb.PaySlip proto) {
    return PaySlipEntity(
      id: proto.id,
      payRunId: proto.payRunId,
      employeeId: proto.employeeId,
      employeeName: proto.employeeName,
      grossPay: proto.grossPay.toInt() / 100.0,
      incomeTax: proto.incomeTax.toInt() / 100.0,
      nationalInsurance: proto.nationalInsurance.toInt() / 100.0,
      studentLoanRepayment: proto.studentLoanRepayment.toInt() / 100.0,
      pensionContribution: proto.pensionContribution.toInt() / 100.0,
      otherDeductions: proto.otherDeductions.toInt() / 100.0,
      totalDeductions: proto.totalDeductions.toInt() / 100.0,
      netPay: proto.netPay.toInt() / 100.0,
      employerNIC: proto.employerNic.toInt() / 100.0,
      employerPension: proto.employerPension.toInt() / 100.0,
      hoursWorked: proto.hoursWorked,
      overtimeHours: proto.overtimeHours,
      overtimePay: proto.overtimePay.toInt() / 100.0,
      bonuses: proto.bonuses.toInt() / 100.0,
      commissions: proto.commissions.toInt() / 100.0,
      paymentStatus: _paymentStatusFromProto(proto.paymentStatus),
      paymentReference: proto.paymentReference,
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  // ---------------------------------------------------------------------------
  // Entity → Proto Enum Mappers
  // ---------------------------------------------------------------------------

  payroll_pb.EmploymentType _employmentTypeToProto(EmploymentType type) {
    switch (type) {
      case EmploymentType.fullTime:
        return payroll_pb.EmploymentType.EMPLOYMENT_TYPE_FULL_TIME;
      case EmploymentType.partTime:
        return payroll_pb.EmploymentType.EMPLOYMENT_TYPE_PART_TIME;
      case EmploymentType.contract:
        return payroll_pb.EmploymentType.EMPLOYMENT_TYPE_CONTRACT;
    }
  }

  payroll_pb.PayFrequency _payFrequencyToProto(PayFrequency freq) {
    switch (freq) {
      case PayFrequency.monthly:
        return payroll_pb.PayFrequency.PAY_FREQUENCY_MONTHLY;
      case PayFrequency.biweekly:
        return payroll_pb.PayFrequency.PAY_FREQUENCY_BIWEEKLY;
      case PayFrequency.weekly:
        return payroll_pb.PayFrequency.PAY_FREQUENCY_WEEKLY;
    }
  }

  payroll_pb.EmployeeStatus _employeeStatusToProto(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return payroll_pb.EmployeeStatus.EMPLOYEE_STATUS_ACTIVE;
      case EmployeeStatus.inactive:
        return payroll_pb.EmployeeStatus.EMPLOYEE_STATUS_INACTIVE;
      case EmployeeStatus.terminated:
        return payroll_pb.EmployeeStatus.EMPLOYEE_STATUS_TERMINATED;
    }
  }

  // ---------------------------------------------------------------------------
  // Proto → Entity Enum Mappers
  // ---------------------------------------------------------------------------

  EmploymentType _employmentTypeFromProto(payroll_pb.EmploymentType type) {
    switch (type) {
      case payroll_pb.EmploymentType.EMPLOYMENT_TYPE_FULL_TIME:
        return EmploymentType.fullTime;
      case payroll_pb.EmploymentType.EMPLOYMENT_TYPE_PART_TIME:
        return EmploymentType.partTime;
      case payroll_pb.EmploymentType.EMPLOYMENT_TYPE_CONTRACT:
        return EmploymentType.contract;
      default:
        return EmploymentType.fullTime;
    }
  }

  PayFrequency _payFrequencyFromProto(payroll_pb.PayFrequency freq) {
    switch (freq) {
      case payroll_pb.PayFrequency.PAY_FREQUENCY_MONTHLY:
        return PayFrequency.monthly;
      case payroll_pb.PayFrequency.PAY_FREQUENCY_BIWEEKLY:
        return PayFrequency.biweekly;
      case payroll_pb.PayFrequency.PAY_FREQUENCY_WEEKLY:
        return PayFrequency.weekly;
      default:
        return PayFrequency.monthly;
    }
  }

  EmployeeStatus _employeeStatusFromProto(payroll_pb.EmployeeStatus status) {
    switch (status) {
      case payroll_pb.EmployeeStatus.EMPLOYEE_STATUS_ACTIVE:
        return EmployeeStatus.active;
      case payroll_pb.EmployeeStatus.EMPLOYEE_STATUS_INACTIVE:
        return EmployeeStatus.inactive;
      case payroll_pb.EmployeeStatus.EMPLOYEE_STATUS_TERMINATED:
        return EmployeeStatus.terminated;
      default:
        return EmployeeStatus.active;
    }
  }

  PayRunStatus _payRunStatusFromProto(payroll_pb.PayRunStatus status) {
    switch (status) {
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_DRAFT:
        return PayRunStatus.draft;
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_CALCULATING:
        return PayRunStatus.calculating;
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_READY:
        return PayRunStatus.ready;
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_APPROVED:
        return PayRunStatus.approved;
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_PROCESSING:
        return PayRunStatus.processing;
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_COMPLETED:
        return PayRunStatus.completed;
      case payroll_pb.PayRunStatus.PAY_RUN_STATUS_FAILED:
        return PayRunStatus.failed;
      default:
        return PayRunStatus.draft;
    }
  }

  PaymentStatus _paymentStatusFromProto(payroll_pb.PaymentStatus status) {
    switch (status) {
      case payroll_pb.PaymentStatus.PAYMENT_STATUS_PENDING:
        return PaymentStatus.pending;
      case payroll_pb.PaymentStatus.PAYMENT_STATUS_PAID:
        return PaymentStatus.paid;
      case payroll_pb.PaymentStatus.PAYMENT_STATUS_FAILED:
        return PaymentStatus.failed;
      default:
        return PaymentStatus.pending;
    }
  }
}
