import '../entities/expense_entity.dart';

/// Abstract data-access surface for business expenses. The default
/// impl (`ExpenseRepositoryHttpImpl`) talks to business-gateway via
/// HTTP at /api/v1/expenses/*. Bizz-level filters (category, status,
/// date range, amount range) all pass through to the gateway query.
abstract class ExpenseRepository {
  Future<ExpensesPageResult> listExpenses({
    int page = 1,
    int limit = 20,
    String? search,
    ExpenseCategory? category,
    ExpenseStatus? status,
    String? startDate, // YYYY-MM-DD
    String? endDate,
    String? tag,
    int? minAmountMinor,
    int? maxAmountMinor,
  });

  Future<ExpenseEntity> getExpense(String expenseId);

  Future<ExpenseEntity> createExpense({
    required String description,
    required int amountMinor,
    String currency = 'NGN',
    ExpenseCategory category = ExpenseCategory.other,
    ExpensePaymentMethod paymentMethod = ExpensePaymentMethod.cash,
    String? expenseDate, // YYYY-MM-DD; defaults to today on server
    String vendor = '',
    String reference = '',
    String receiptUrl = '',
    List<String> tags = const [],
    String notes = '',
  });

  Future<ExpenseEntity> updateExpense({
    required String expenseId,
    String? description,
    int? amountMinor,
    String? currency,
    ExpenseCategory? category,
    ExpenseStatus? status,
    ExpensePaymentMethod? paymentMethod,
    String? expenseDate,
    String? vendor,
    String? reference,
    String? receiptUrl,
    List<String>? tags,
    String? notes,
  });

  Future<void> deleteExpense(String expenseId);

  Future<ExpenseSummaryEntity> getSummary({
    String? startDate,
    String? endDate,
  });

  Future<ExpenseEntity> approveExpense(
    String expenseId, {
    String approvalNotes = '',
  });

  Future<ExpenseEntity> markReimbursed(
    String expenseId, {
    String reimbursementReference = '',
  });
}
