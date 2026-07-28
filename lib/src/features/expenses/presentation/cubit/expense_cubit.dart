import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository _repository;

  ExpenseCubit({required ExpenseRepository repository})
      : _repository = repository,
        super(const ExpenseInitial());

  String _friendlyError(Object e) {
    if (e is GrpcError) {
      switch (e.code) {
        case StatusCode.unauthenticated:
          return 'Session expired. Please sign in again.';
        case StatusCode.permissionDenied:
          return "You don't have permission for that.";
        case StatusCode.notFound:
          return 'Expense not found.';
        case StatusCode.invalidArgument:
          return e.message ?? 'Invalid input.';
        case StatusCode.failedPrecondition:
          return e.message ?? 'Action not allowed in current state.';
        case StatusCode.unavailable:
          return 'Network issue. Try again shortly.';
        default:
          return e.message ?? 'Something went wrong.';
      }
    }
    return e.toString();
  }

  Future<void> listExpenses({
    int page = 1,
    int limit = 20,
    String? search,
    ExpenseCategory? category,
    ExpenseStatus? status,
    String? startDate,
    String? endDate,
    String? tag,
    int? minAmountMinor,
    int? maxAmountMinor,
  }) async {
    emit(const ExpenseLoading());
    try {
      final result = await _repository.listExpenses(
        page: page,
        limit: limit,
        search: search,
        category: category,
        status: status,
        startDate: startDate,
        endDate: endDate,
        tag: tag,
        minAmountMinor: minAmountMinor,
        maxAmountMinor: maxAmountMinor,
      );
      emit(ExpensesLoaded(
        expenses: result.items,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        currentPage: result.currentPage,
      ));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> getExpense(String expenseId) async {
    emit(const ExpenseLoading());
    try {
      final e = await _repository.getExpense(expenseId);
      emit(ExpenseLoaded(e));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> createExpense({
    required String description,
    required int amountMinor,
    String currency = 'NGN',
    ExpenseCategory category = ExpenseCategory.other,
    ExpensePaymentMethod paymentMethod = ExpensePaymentMethod.cash,
    String? expenseDate,
    String vendor = '',
    String supplierId = '',
    String reference = '',
    String receiptUrl = '',
    List<String> tags = const [],
    String notes = '',
  }) async {
    emit(const ExpenseLoading());
    try {
      final created = await _repository.createExpense(
        description: description,
        amountMinor: amountMinor,
        currency: currency,
        category: category,
        paymentMethod: paymentMethod,
        expenseDate: expenseDate,
        vendor: vendor,
        supplierId: supplierId,
        reference: reference,
        receiptUrl: receiptUrl,
        tags: tags,
        notes: notes,
      );
      emit(ExpenseCreated(created));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> updateExpense({
    required String expenseId,
    String? description,
    int? amountMinor,
    String? currency,
    ExpenseCategory? category,
    ExpenseStatus? status,
    ExpensePaymentMethod? paymentMethod,
    String? expenseDate,
    String? vendor,
    String? supplierId,
    String? reference,
    String? receiptUrl,
    List<String>? tags,
    String? notes,
  }) async {
    emit(const ExpenseLoading());
    try {
      final updated = await _repository.updateExpense(
        expenseId: expenseId,
        description: description,
        amountMinor: amountMinor,
        currency: currency,
        category: category,
        status: status,
        paymentMethod: paymentMethod,
        expenseDate: expenseDate,
        vendor: vendor,
        supplierId: supplierId,
        reference: reference,
        receiptUrl: receiptUrl,
        tags: tags,
        notes: notes,
      );
      emit(ExpenseUpdated(updated));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    emit(const ExpenseLoading());
    try {
      await _repository.deleteExpense(expenseId);
      emit(const ExpenseDeleted());
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> approveExpense(String expenseId,
      {String approvalNotes = ''}) async {
    emit(const ExpenseLoading());
    try {
      final e = await _repository.approveExpense(expenseId,
          approvalNotes: approvalNotes);
      emit(ExpenseApproved(e));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> markReimbursed(String expenseId,
      {String reimbursementReference = ''}) async {
    emit(const ExpenseLoading());
    try {
      final e = await _repository.markReimbursed(expenseId,
          reimbursementReference: reimbursementReference);
      emit(ExpenseReimbursed(e));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }

  Future<void> getSummary({String? startDate, String? endDate}) async {
    emit(const ExpenseLoading());
    try {
      final s = await _repository.getSummary(
        startDate: startDate,
        endDate: endDate,
      );
      emit(ExpenseSummaryLoaded(s));
    } catch (e) {
      emit(ExpenseError(_friendlyError(e)));
    }
  }
}
