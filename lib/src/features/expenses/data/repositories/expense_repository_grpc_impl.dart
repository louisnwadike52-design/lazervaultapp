import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_pb;

import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';

/// gRPC implementation of [ExpenseRepository]. Mirrors the customer +
/// tax + inventory gRPC impls — same retryWithBackoff wrapping, same
/// withAuth() options helper, same proto↔entity conversion.
class ExpenseRepositoryGrpcImpl implements ExpenseRepository {
  final payroll_pb.ExpenseServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  ExpenseRepositoryGrpcImpl({
    required payroll_pb.ExpenseServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ---------- CRUD ----------

  @override
  Future<ExpensesPageResult> listExpenses({
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
    return retryWithBackoff(
      operation: () async {
        final req = payroll_pb.ListExpensesRequest()
          ..page = page
          ..limit = limit;
        if (search != null && search.isNotEmpty) req.search = search;
        if (category != null) {
          req.category = payroll_pb.ExpenseCategory.valueOf(category.index) ??
              payroll_pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER;
        }
        if (status != null) {
          req.status = payroll_pb.ExpenseStatus.valueOf(status.index) ??
              payroll_pb.ExpenseStatus.EXPENSE_STATUS_PENDING;
        }
        if (startDate != null && startDate.isNotEmpty) req.startDate = startDate;
        if (endDate != null && endDate.isNotEmpty) req.endDate = endDate;
        if (tag != null && tag.isNotEmpty) req.tag = tag;
        if (minAmountMinor != null && minAmountMinor > 0) {
          req.minAmount = Int64(minAmountMinor);
        }
        if (maxAmountMinor != null && maxAmountMinor > 0) {
          req.maxAmount = Int64(maxAmountMinor);
        }

        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.listExpenses(req, options: opts);
        if (!resp.success) {
          throw Exception(resp.message);
        }
        final items =
            resp.expenses.map(_fromProto).toList(growable: false);
        final total = resp.pagination.totalItems;
        final totalPages = (total / limit).ceil().clamp(1, 1 << 30);
        return ExpensesPageResult(
          items: items,
          totalItems: total,
          currentPage: page,
          totalPages: totalPages,
        );
      },
    );
  }

  @override
  Future<ExpenseEntity> getExpense(String expenseId) async {
    return retryWithBackoff(
      operation: () async {
        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.getExpense(
          payroll_pb.GetExpenseRequest()..expenseId = expenseId,
          options: opts,
        );
        if (!resp.success) {
          throw Exception(resp.message);
        }
        return _fromProto(resp.expense);
      },
    );
  }

  @override
  Future<ExpenseEntity> createExpense({
    required String description,
    required int amountMinor,
    String currency = 'NGN',
    ExpenseCategory category = ExpenseCategory.other,
    ExpensePaymentMethod paymentMethod = ExpensePaymentMethod.cash,
    String? expenseDate,
    String vendor = '',
    String reference = '',
    String receiptUrl = '',
    List<String> tags = const [],
    String notes = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final req = payroll_pb.CreateExpenseRequest()
          ..description = description
          ..amount = Int64(amountMinor)
          ..currency = currency
          ..category =
              payroll_pb.ExpenseCategory.valueOf(category.index) ??
                  payroll_pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER
          ..paymentMethod = payroll_pb.ExpensePaymentMethod.valueOf(
                  paymentMethod.index) ??
              payroll_pb.ExpensePaymentMethod.EXPENSE_PAYMENT_METHOD_CASH
          ..vendor = vendor
          ..reference = reference
          ..receiptUrl = receiptUrl
          ..tags.addAll(tags)
          ..notes = notes;
        if (expenseDate != null && expenseDate.isNotEmpty) {
          req.expenseDate = expenseDate;
        }

        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.createExpense(req, options: opts);
        if (!resp.success) {
          throw Exception(resp.message);
        }
        return _fromProto(resp.expense);
      },
    );
  }

  @override
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
  }) async {
    return retryWithBackoff(
      operation: () async {
        final req = payroll_pb.UpdateExpenseRequest()..expenseId = expenseId;
        if (description != null) req.description = description;
        if (amountMinor != null && amountMinor > 0) {
          req.amount = Int64(amountMinor);
        }
        if (currency != null) req.currency = currency;
        if (category != null) {
          req.category = payroll_pb.ExpenseCategory.valueOf(category.index) ??
              payroll_pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER;
        }
        if (status != null) {
          req.status = payroll_pb.ExpenseStatus.valueOf(status.index) ??
              payroll_pb.ExpenseStatus.EXPENSE_STATUS_PENDING;
        }
        if (paymentMethod != null) {
          req.paymentMethod = payroll_pb.ExpensePaymentMethod.valueOf(
                  paymentMethod.index) ??
              payroll_pb.ExpensePaymentMethod.EXPENSE_PAYMENT_METHOD_CASH;
        }
        if (expenseDate != null) req.expenseDate = expenseDate;
        if (vendor != null) req.vendor = vendor;
        if (reference != null) req.reference = reference;
        if (receiptUrl != null) req.receiptUrl = receiptUrl;
        if (tags != null) req.tags.addAll(tags);
        if (notes != null) req.notes = notes;

        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.updateExpense(req, options: opts);
        if (!resp.success) {
          throw Exception(resp.message);
        }
        return _fromProto(resp.expense);
      },
    );
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    return retryWithBackoff(
      operation: () async {
        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.deleteExpense(
          payroll_pb.DeleteExpenseRequest()..expenseId = expenseId,
          options: opts,
        );
        if (!resp.success) {
          throw Exception(resp.message);
        }
      },
    );
  }

  @override
  Future<ExpenseSummaryEntity> getSummary({
    String? startDate,
    String? endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final req = payroll_pb.GetExpenseSummaryRequest();
        if (startDate != null && startDate.isNotEmpty) req.startDate = startDate;
        if (endDate != null && endDate.isNotEmpty) req.endDate = endDate;
        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.getExpenseSummary(req, options: opts);
        if (!resp.success) {
          throw Exception(resp.message);
        }
        final s = resp.summary;
        return ExpenseSummaryEntity(
          totalExpensesMinor: s.totalExpenses.toInt(),
          totalPendingMinor: s.totalPending.toInt(),
          totalApprovedMinor: s.totalApproved.toInt(),
          totalReimbursedMinor: s.totalReimbursed.toInt(),
          totalRejectedMinor: s.totalRejected.toInt(),
          expenseCount: s.expenseCount,
          pendingCount: s.pendingCount,
          approvedCount: s.approvedCount,
          reimbursedCount: s.reimbursedCount,
          rejectedCount: s.rejectedCount,
          currency: s.currency.isEmpty ? 'NGN' : s.currency,
          byCategory: s.byCategory
              .map((c) => ExpenseCategoryTotal(
                    category: ExpenseCategory.fromInt(c.category.value),
                    totalAmountMinor: c.totalAmount.toInt(),
                    expenseCount: c.expenseCount,
                  ))
              .toList(growable: false),
          byMonth: s.byMonth
              .map((m) => ExpenseMonthlyTotal(
                    period: m.period,
                    totalAmountMinor: m.totalAmount.toInt(),
                    expenseCount: m.expenseCount,
                  ))
              .toList(growable: false),
        );
      },
    );
  }

  @override
  Future<ExpenseEntity> approveExpense(
    String expenseId, {
    String approvalNotes = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final req = payroll_pb.ApproveExpenseRequest()
          ..expenseId = expenseId
          ..approvalNotes = approvalNotes;
        final opts = await _callOptionsHelper.withAuth();
        final resp = await _client.approveExpense(req, options: opts);
        if (!resp.success) {
          throw Exception(resp.message);
        }
        return _fromProto(resp.expense);
      },
    );
  }

  @override
  Future<ExpenseEntity> markReimbursed(
    String expenseId, {
    String reimbursementReference = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final req = payroll_pb.MarkExpenseReimbursedRequest()
          ..expenseId = expenseId
          ..reimbursementReference = reimbursementReference;
        final opts = await _callOptionsHelper.withAuth();
        final resp =
            await _client.markExpenseReimbursed(req, options: opts);
        if (!resp.success) {
          throw Exception(resp.message);
        }
        return _fromProto(resp.expense);
      },
    );
  }

  // ---------- Proto → Entity ----------

  ExpenseEntity _fromProto(payroll_pb.Expense e) {
    return ExpenseEntity(
      id: e.id,
      businessId: e.businessId,
      description: e.description,
      amountMinor: e.amount.toInt(),
      currency: e.currency.isEmpty ? 'NGN' : e.currency,
      category: ExpenseCategory.fromInt(e.category.value),
      status: ExpenseStatus.fromInt(e.status.value),
      paymentMethod: ExpensePaymentMethod.fromInt(e.paymentMethod.value),
      expenseDate: e.hasExpenseDate()
          ? e.expenseDate.toDateTime()
          : DateTime.now(),
      vendor: e.vendor,
      reference: e.reference,
      receiptUrl: e.receiptUrl,
      tags: List<String>.from(e.tags),
      notes: e.notes,
      createdBy: e.createdBy,
      approvedBy: e.approvedBy,
      approvedAt: e.hasApprovedAt() ? e.approvedAt.toDateTime() : null,
      reimbursedAt:
          e.hasReimbursedAt() ? e.reimbursedAt.toDateTime() : null,
      createdAt:
          e.hasCreatedAt() ? e.createdAt.toDateTime() : DateTime.now(),
      updatedAt:
          e.hasUpdatedAt() ? e.updatedAt.toDateTime() : DateTime.now(),
    );
  }
}
