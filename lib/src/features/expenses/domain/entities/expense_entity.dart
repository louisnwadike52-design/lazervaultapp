import 'package:flutter/material.dart';

/// Pagination wrapper for expense list responses.
class ExpensesPageResult {
  final List<ExpenseEntity> items;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const ExpensesPageResult({
    required this.items,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

/// Mirror of payroll.proto ExpenseCategory enum. Int values match the
/// proto ordering — `EXPENSE_CATEGORY_OFFICE = 0`, etc.
enum ExpenseCategory {
  office,
  travel,
  meals,
  marketing,
  utilities,
  payroll,
  professional,
  software,
  inventory,
  taxes,
  other;

  static ExpenseCategory fromInt(int v) {
    if (v < 0 || v >= ExpenseCategory.values.length) {
      return ExpenseCategory.other;
    }
    return ExpenseCategory.values[v];
  }

  String get label {
    switch (this) {
      case ExpenseCategory.office:
        return 'Office';
      case ExpenseCategory.travel:
        return 'Travel';
      case ExpenseCategory.meals:
        return 'Meals & Entertainment';
      case ExpenseCategory.marketing:
        return 'Marketing';
      case ExpenseCategory.utilities:
        return 'Utilities';
      case ExpenseCategory.payroll:
        return 'Payroll';
      case ExpenseCategory.professional:
        return 'Professional Services';
      case ExpenseCategory.software:
        return 'Software & Subscriptions';
      case ExpenseCategory.inventory:
        return 'Inventory';
      case ExpenseCategory.taxes:
        return 'Taxes';
      case ExpenseCategory.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseCategory.office:
        return Icons.business_center_rounded;
      case ExpenseCategory.travel:
        return Icons.flight_takeoff_rounded;
      case ExpenseCategory.meals:
        return Icons.restaurant_rounded;
      case ExpenseCategory.marketing:
        return Icons.campaign_rounded;
      case ExpenseCategory.utilities:
        return Icons.flash_on_rounded;
      case ExpenseCategory.payroll:
        return Icons.payments_rounded;
      case ExpenseCategory.professional:
        return Icons.gavel_rounded;
      case ExpenseCategory.software:
        return Icons.cloud_rounded;
      case ExpenseCategory.inventory:
        return Icons.inventory_2_rounded;
      case ExpenseCategory.taxes:
        return Icons.account_balance_rounded;
      case ExpenseCategory.other:
        return Icons.receipt_long_rounded;
    }
  }
}

/// Mirror of payroll.proto ExpenseStatus enum.
enum ExpenseStatus {
  pending,
  approved,
  reimbursed,
  rejected;

  static ExpenseStatus fromInt(int v) {
    if (v < 0 || v >= ExpenseStatus.values.length) {
      return ExpenseStatus.pending;
    }
    return ExpenseStatus.values[v];
  }

  String get label {
    switch (this) {
      case ExpenseStatus.pending:
        return 'Pending';
      case ExpenseStatus.approved:
        return 'Approved';
      case ExpenseStatus.reimbursed:
        return 'Reimbursed';
      case ExpenseStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case ExpenseStatus.pending:
        return const Color(0xFFFB923C); // orange
      case ExpenseStatus.approved:
        return const Color(0xFF3B82F6); // blue
      case ExpenseStatus.reimbursed:
        return const Color(0xFF10B981); // green
      case ExpenseStatus.rejected:
        return const Color(0xFFEF4444); // red
    }
  }
}

/// Mirror of payroll.proto ExpensePaymentMethod enum.
enum ExpensePaymentMethod {
  cash,
  card,
  bankTransfer,
  cheque,
  other;

  static ExpensePaymentMethod fromInt(int v) {
    if (v < 0 || v >= ExpensePaymentMethod.values.length) {
      return ExpensePaymentMethod.other;
    }
    return ExpensePaymentMethod.values[v];
  }

  String get label {
    switch (this) {
      case ExpensePaymentMethod.cash:
        return 'Cash';
      case ExpensePaymentMethod.card:
        return 'Card';
      case ExpensePaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case ExpensePaymentMethod.cheque:
        return 'Cheque';
      case ExpensePaymentMethod.other:
        return 'Other';
    }
  }
}

/// A single business expense record. Money fields are MINOR units
/// (kobo for NGN); UI divides by 100 for display + multiplies on
/// submission.
class ExpenseEntity {
  final String id;
  final String businessId;
  final String description;
  final int amountMinor;
  final String currency;
  final ExpenseCategory category;
  final ExpenseStatus status;
  final ExpensePaymentMethod paymentMethod;
  final DateTime expenseDate;
  final String vendor;
  final String reference;
  final String receiptUrl;
  final List<String> tags;
  final String notes;
  final String createdBy;
  final String approvedBy;
  final DateTime? approvedAt;
  final DateTime? reimbursedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ExpenseEntity({
    required this.id,
    required this.businessId,
    required this.description,
    required this.amountMinor,
    required this.currency,
    required this.category,
    required this.status,
    required this.paymentMethod,
    required this.expenseDate,
    this.vendor = '',
    this.reference = '',
    this.receiptUrl = '',
    this.tags = const [],
    this.notes = '',
    this.createdBy = '',
    this.approvedBy = '',
    this.approvedAt,
    this.reimbursedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Decode an HTTP JSON payload from /api/v1/expenses/* — uses the
  /// snake_case field names the business-gateway emits.
  factory ExpenseEntity.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(dynamic v) {
      if (v == null) return DateTime.now();
      if (v is String && v.isNotEmpty) {
        return DateTime.tryParse(v) ?? DateTime.now();
      }
      return DateTime.now();
    }

    DateTime? parseDateOrNull(dynamic v) {
      if (v == null) return null;
      if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
      return null;
    }

    return ExpenseEntity(
      id: (json['id'] ?? '') as String,
      businessId: (json['business_id'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      amountMinor: (json['amount'] ?? 0) is int
          ? json['amount'] as int
          : int.tryParse('${json['amount']}') ?? 0,
      currency: (json['currency'] ?? 'NGN') as String,
      category: ExpenseCategory.fromInt(
        (json['category'] ?? 0) is int
            ? json['category'] as int
            : int.tryParse('${json['category']}') ?? 0,
      ),
      status: ExpenseStatus.fromInt(
        (json['status'] ?? 0) is int
            ? json['status'] as int
            : int.tryParse('${json['status']}') ?? 0,
      ),
      paymentMethod: ExpensePaymentMethod.fromInt(
        (json['payment_method'] ?? 0) is int
            ? json['payment_method'] as int
            : int.tryParse('${json['payment_method']}') ?? 0,
      ),
      expenseDate: parseDate(json['expense_date']),
      vendor: (json['vendor'] ?? '') as String,
      reference: (json['reference'] ?? '') as String,
      receiptUrl: (json['receipt_url'] ?? '') as String,
      tags: (json['tags'] as List?)?.map((e) => '$e').toList() ?? const [],
      notes: (json['notes'] ?? '') as String,
      createdBy: (json['created_by'] ?? '') as String,
      approvedBy: (json['approved_by'] ?? '') as String,
      approvedAt: parseDateOrNull(json['approved_at']),
      reimbursedAt: parseDateOrNull(json['reimbursed_at']),
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  double get amountMajor => amountMinor / 100.0;
}

/// Per-status + per-category + per-month summary for the dashboard
/// card / chat summary tool.
class ExpenseSummaryEntity {
  final int totalExpensesMinor;
  final int totalPendingMinor;
  final int totalApprovedMinor;
  final int totalReimbursedMinor;
  final int totalRejectedMinor;
  final int expenseCount;
  final int pendingCount;
  final int approvedCount;
  final int reimbursedCount;
  final int rejectedCount;
  final String currency;
  final List<ExpenseCategoryTotal> byCategory;
  final List<ExpenseMonthlyTotal> byMonth;

  const ExpenseSummaryEntity({
    required this.totalExpensesMinor,
    required this.totalPendingMinor,
    required this.totalApprovedMinor,
    required this.totalReimbursedMinor,
    required this.totalRejectedMinor,
    required this.expenseCount,
    required this.pendingCount,
    required this.approvedCount,
    required this.reimbursedCount,
    required this.rejectedCount,
    required this.currency,
    required this.byCategory,
    required this.byMonth,
  });

  factory ExpenseSummaryEntity.fromJson(Map<String, dynamic> json) {
    int asInt(dynamic v) {
      if (v is int) return v;
      return int.tryParse('${v ?? 0}') ?? 0;
    }

    return ExpenseSummaryEntity(
      totalExpensesMinor: asInt(json['total_expenses']),
      totalPendingMinor: asInt(json['total_pending']),
      totalApprovedMinor: asInt(json['total_approved']),
      totalReimbursedMinor: asInt(json['total_reimbursed']),
      totalRejectedMinor: asInt(json['total_rejected']),
      expenseCount: asInt(json['expense_count']),
      pendingCount: asInt(json['pending_count']),
      approvedCount: asInt(json['approved_count']),
      reimbursedCount: asInt(json['reimbursed_count']),
      rejectedCount: asInt(json['rejected_count']),
      currency: (json['currency'] ?? 'NGN') as String,
      byCategory: (json['by_category'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(ExpenseCategoryTotal.fromJson)
          .toList(),
      byMonth: (json['by_month'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(ExpenseMonthlyTotal.fromJson)
          .toList(),
    );
  }
}

class ExpenseCategoryTotal {
  final ExpenseCategory category;
  final int totalAmountMinor;
  final int expenseCount;

  const ExpenseCategoryTotal({
    required this.category,
    required this.totalAmountMinor,
    required this.expenseCount,
  });

  factory ExpenseCategoryTotal.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryTotal(
      category: ExpenseCategory.fromInt(json['category'] is int
          ? json['category'] as int
          : int.tryParse('${json['category']}') ?? 0),
      totalAmountMinor: json['total_amount'] is int
          ? json['total_amount'] as int
          : int.tryParse('${json['total_amount']}') ?? 0,
      expenseCount: json['expense_count'] is int
          ? json['expense_count'] as int
          : int.tryParse('${json['expense_count']}') ?? 0,
    );
  }
}

class ExpenseMonthlyTotal {
  final String period; // YYYY-MM
  final int totalAmountMinor;
  final int expenseCount;

  const ExpenseMonthlyTotal({
    required this.period,
    required this.totalAmountMinor,
    required this.expenseCount,
  });

  factory ExpenseMonthlyTotal.fromJson(Map<String, dynamic> json) {
    return ExpenseMonthlyTotal(
      period: (json['period'] ?? '') as String,
      totalAmountMinor: json['total_amount'] is int
          ? json['total_amount'] as int
          : int.tryParse('${json['total_amount']}') ?? 0,
      expenseCount: json['expense_count'] is int
          ? json['expense_count'] as int
          : int.tryParse('${json['expense_count']}') ?? 0,
    );
  }
}
