import '../../domain/entities/expense_entity.dart';

sealed class ExpenseState {
  const ExpenseState();
}

class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

class ExpenseLoading extends ExpenseState {
  const ExpenseLoading();
}

class ExpenseError extends ExpenseState {
  final String message;
  const ExpenseError(this.message);
}

class ExpensesLoaded extends ExpenseState {
  final List<ExpenseEntity> expenses;
  final int totalItems;
  final int totalPages;
  final int currentPage;
  const ExpensesLoaded({
    required this.expenses,
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
  });
}

class ExpenseLoaded extends ExpenseState {
  final ExpenseEntity expense;
  const ExpenseLoaded(this.expense);
}

class ExpenseCreated extends ExpenseState {
  final ExpenseEntity expense;
  const ExpenseCreated(this.expense);
}

class ExpenseUpdated extends ExpenseState {
  final ExpenseEntity expense;
  const ExpenseUpdated(this.expense);
}

class ExpenseDeleted extends ExpenseState {
  const ExpenseDeleted();
}

class ExpenseApproved extends ExpenseState {
  final ExpenseEntity expense;
  const ExpenseApproved(this.expense);
}

class ExpenseReimbursed extends ExpenseState {
  final ExpenseEntity expense;
  const ExpenseReimbursed(this.expense);
}

class ExpenseSummaryLoaded extends ExpenseState {
  final ExpenseSummaryEntity summary;
  const ExpenseSummaryLoaded(this.summary);
}
