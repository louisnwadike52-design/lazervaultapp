import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/grpc_exceptions.dart';
import 'package:lazervault/src/features/payroll/domain/entities/employee_entity.dart';
import 'package:lazervault/src/features/payroll/domain/entities/pay_slip_entity.dart';
import 'package:lazervault/src/features/payroll/domain/repositories/payroll_repository.dart';
import 'payroll_state.dart';

class PayrollCubit extends Cubit<PayrollState> {
  final PayrollRepository _repository;

  PayrollCubit({required PayrollRepository repository})
      : _repository = repository,
        super(PayrollInitial());

  String _friendlyGrpcError(GrpcError e) {
    switch (e.code) {
      case StatusCode.unavailable:
        return 'Unable to reach payroll service. Check your connection.';
      case StatusCode.deadlineExceeded:
        return 'Request timed out. Please try again.';
      case StatusCode.permissionDenied:
        return 'You don\'t have permission for this action.';
      case StatusCode.unauthenticated:
        return 'Session expired. Please log in again.';
      case StatusCode.alreadyExists:
        // The server's own words, deliberately. payroll-service answers a
        // duplicate employee with a message that NAMES the person already on
        // the roster and which field matched ("Chris is already on this
        // payroll (matched by email)"). Replacing that with generic copy would
        // throw away the only part an employer can act on.
        //
        // NOTE this branch is reached only when a RAW GrpcError arrives.
        // retryWithBackoff rethrows raw only for unauthenticated and
        // permissionDenied; everything else, alreadyExists included, it passes
        // through mapGrpcError first and throws the mapped type. So the
        // duplicate message really arrives as a GrpcException and is handled by
        // _friendlyError below. Kept here anyway because a caller that does not
        // go through retryWithBackoff would land here instead.
        return e.message ?? 'That employee is already on this payroll.';
      default:
        return e.message ?? 'An error occurred';
    }
  }

  /// Error copy for anything that is NOT a raw [GrpcError].
  ///
  /// This is the live path for most failures. The repository wraps every call
  /// in retryWithBackoff, which converts a GrpcError into one of the
  /// [GrpcException] subtypes via mapGrpcError before throwing — so by the time
  /// a duplicate-employee rejection reaches the cubit it is a GrpcException
  /// carrying the server's message, not a GrpcError.
  ///
  /// [GrpcException.message] is read explicitly rather than relying on its
  /// `toString()` override returning the bare message. That override is what
  /// made this work before, which meant the single most useful message in the
  /// payroll flow depended on a `toString()` three files away continuing to be
  /// written that way. A plain `e.toString()` here would start rendering
  /// "Instance of 'ServerException'" the day someone adds a type prefix to it.
  String _friendlyError(Object e) {
    if (e is GrpcError) return _friendlyGrpcError(e);
    if (e is GrpcException) {
      final m = e.message.trim();
      if (m.isNotEmpty) return m;
    }
    return e.toString();
  }

  // ---------------------------------------------------------------------------
  // Employee methods
  // ---------------------------------------------------------------------------

  Future<void> listEmployees({
    int page = 1,
    String? search,
    String? department,
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final result = await _repository.listEmployees(
        page: page,
        search: search,
        department: department,
      );
      if (isClosed) return;
      emit(EmployeesLoaded(
        employees: result.employees,
        totalPages: result.totalPages,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> getEmployee(String id) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final employee = await _repository.getEmployee(id);
      if (isClosed) return;
      emit(EmployeeLoaded(employee: employee));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> addEmployee({
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
    String payoutType = 'external',
    String bankAccountName = '',
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final employee = await _repository.addEmployee(
        fullName: fullName,
        email: email,
        phone: phone,
        nin: nin,
        bankAccountNumber: bankAccountNumber,
        bankCode: bankCode,
        bankName: bankName,
        employmentType: employmentType,
        payRate: payRate,
        payFrequency: payFrequency,
        department: department,
        jobTitle: jobTitle,
        startDate: startDate,
        userId: userId,
        payoutType: payoutType,
        bankAccountName: bankAccountName,
      );
      if (isClosed) return;
      emit(EmployeeAdded(
          message: 'Employee added successfully', employee: employee));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> updateEmployee({
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
    String? userId,
    String? payoutType,
    String? bankAccountName,
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      await _repository.updateEmployee(
        employeeId: employeeId,
        fullName: fullName,
        email: email,
        phone: phone,
        nin: nin,
        bankAccountNumber: bankAccountNumber,
        bankCode: bankCode,
        bankName: bankName,
        employmentType: employmentType,
        payRate: payRate,
        payFrequency: payFrequency,
        department: department,
        jobTitle: jobTitle,
        status: status,
        userId: userId,
        payoutType: payoutType,
        bankAccountName: bankAccountName,
      );
      if (isClosed) return;
      emit(EmployeeUpdated(message: 'Employee updated successfully'));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> removeEmployee(String id) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      await _repository.removeEmployee(id);
      if (isClosed) return;
      emit(EmployeeRemoved(message: 'Employee removed successfully'));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // Pay Run methods
  // ---------------------------------------------------------------------------

  Future<void> listPayRuns({int page = 1}) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final result = await _repository.listPayRuns(page: page);
      if (isClosed) return;
      emit(PayRunsLoaded(
        payRuns: result.payRuns,
        totalPages: result.totalPages,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> getPayRun(String id) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final payRun = await _repository.getPayRun(id);
      // Also load the per-employee pay slip breakdown (empty until the run is
      // calculated). Best-effort: a slip-fetch failure must not hide the run.
      List<PaySlipEntity> paySlips = const [];
      try {
        final result = await _repository.listPaySlips(payRunId: id, limit: 100);
        paySlips = result.paySlips;
      } catch (_) {}
      if (isClosed) return;
      emit(PayRunLoaded(payRun: payRun, paySlips: paySlips));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> createPayRun({
    required String start,
    required String end,
    String name = '',
    List<String> employeeIds = const [],
    bool isRecurring = false,
    int recurrenceFrequency = 0,
    bool autoApprove = false,
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final payRun = await _repository.createPayRun(
        payPeriodStart: start,
        payPeriodEnd: end,
        name: name,
        employeeIds: employeeIds,
        isRecurring: isRecurring,
        recurrenceFrequency: recurrenceFrequency,
        autoApprove: autoApprove,
      );
      if (isClosed) return;
      emit(PayRunCreated(
        message: 'Pay run created successfully',
        payRun: payRun,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> calculatePayRun(String id) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final payRun = await _repository.calculatePayRun(id);

      // Also fetch pay slips after calculation
      final paySlipsResult = await _repository.listPaySlips(payRunId: id);
      if (isClosed) return;
      emit(PayRunCalculated(
        payRun: payRun,
        paySlips: paySlipsResult.paySlips,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> approvePayRun(String id) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      await _repository.approvePayRun(id);
      if (isClosed) return;
      emit(PayRunApproved(message: 'Pay run approved successfully'));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> processPayRun({
    required String id,
    required String pin,
    required String accountId,
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      await _repository.processPayRun(
        payRunId: id,
        transactionPin: pin,
        sourceAccountId: accountId,
      );

      // Count results from pay slips
      final slipsResult = await _repository.listPaySlips(payRunId: id);
      final successful = slipsResult.paySlips.where((s) => s.isPaid).length;
      final failed = slipsResult.paySlips
          .where((s) => s.paymentStatus == PaymentStatus.failed)
          .length;

      if (isClosed) return;
      emit(PayRunProcessed(
        message: 'Pay run processed successfully',
        successfulPayments: successful,
        failedPayments: failed,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // Pay Slip methods
  // ---------------------------------------------------------------------------

  Future<void> listPaySlips({required String payRunId, int page = 1}) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final result = await _repository.listPaySlips(
        payRunId: payRunId,
        page: page,
      );
      if (isClosed) return;
      emit(PaySlipsLoaded(
        paySlips: result.paySlips,
        totalPages: result.totalPages,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> getPaySlip(String id) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final paySlip = await _repository.getPaySlip(id);
      if (isClosed) return;
      emit(PaySlipLoaded(paySlip: paySlip));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  // ---------------------------------------------------------------------------
  // Report methods
  // ---------------------------------------------------------------------------

  Future<void> getPayrollSummary({
    required String start,
    required String end,
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final summary = await _repository.getPayrollSummary(
        periodStart: start,
        periodEnd: end,
      );
      if (isClosed) return;
      emit(PayrollSummaryLoaded(summary: summary));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }

  Future<void> getTaxReport({
    required String start,
    required String end,
  }) async {
    try {
      if (isClosed) return;
      emit(PayrollLoading());
      final report = await _repository.getTaxReport(
        periodStart: start,
        periodEnd: end,
      );
      if (isClosed) return;
      emit(TaxReportLoaded(report: report));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(PayrollError(message: _friendlyError(e)));
    }
  }
}
