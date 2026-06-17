import 'package:flutter/material.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:lazervault/src/features/widgets/service_categories.dart';

/// Helper functions for expense categories
/// Delegates color and name lookups to ServiceCategories for consistency
class ExpenseCategoryHelpers {
  /// Get display name for expense category
  static String getCategoryDisplayName(pb.ExpenseCategory category) {
    return ServiceCategories.getBudgetCategoryName(category.value);
  }

  /// Get icon for expense category
  static IconData getCategoryIcon(pb.ExpenseCategory category) {
    switch (category) {
      case pb.ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING:
        return Icons.restaurant;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION:
        return Icons.directions_car;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_SHOPPING:
        return Icons.shopping_bag;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_ENTERTAINMENT:
        return Icons.movie;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES:
        return Icons.receipt_long;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_HEALTHCARE:
        return Icons.medical_services;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_EDUCATION:
        return Icons.school;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_TRAVEL:
        return Icons.flight;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_GROCERIES:
        return Icons.shopping_cart;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE:
        return Icons.home;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_INSURANCE:
        return Icons.security;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_INVESTMENTS:
        return Icons.trending_up;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_GIFTS_DONATIONS:
        return Icons.card_giftcard;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_PERSONAL_CARE:
        return Icons.spa;
      case pb.ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS:
        return Icons.subscriptions;
      default:
        return Icons.category;
    }
  }

  /// Get color for expense category (for charts and badges)
  /// Delegates to ServiceCategories for consistency across the app
  static Color getCategoryColor(pb.ExpenseCategory category) {
    return ServiceCategories.getBudgetCategoryColor(category.value);
  }

  /// Get all expense categories
  static List<pb.ExpenseCategory> getAllCategories() {
    return pb.ExpenseCategory.values
        .where((c) => c != pb.ExpenseCategory.EXPENSE_CATEGORY_UNSPECIFIED)
        .toList();
  }

  /// Get budget period display name
  static String getPeriodDisplayName(pb.BudgetPeriod period) {
    switch (period) {
      case pb.BudgetPeriod.BUDGET_PERIOD_DAILY:
        return 'Daily';
      case pb.BudgetPeriod.BUDGET_PERIOD_WEEKLY:
        return 'Weekly';
      case pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY:
        return 'Monthly';
      case pb.BudgetPeriod.BUDGET_PERIOD_QUARTERLY:
        return 'Quarterly';
      case pb.BudgetPeriod.BUDGET_PERIOD_YEARLY:
        return 'Yearly';
      case pb.BudgetPeriod.BUDGET_PERIOD_CUSTOM:
        return 'Custom';
      default:
        return 'Select Period';
    }
  }

  /// Get budget status display name
  static String getStatusDisplayName(pb.BudgetStatus status) {
    switch (status) {
      case pb.BudgetStatus.BUDGET_STATUS_ACTIVE:
        return 'Active';
      case pb.BudgetStatus.BUDGET_STATUS_EXCEEDED:
        return 'Exceeded';
      case pb.BudgetStatus.BUDGET_STATUS_NEAR_LIMIT:
        return 'Near Limit';
      case pb.BudgetStatus.BUDGET_STATUS_INACTIVE:
        return 'Inactive';
      case pb.BudgetStatus.BUDGET_STATUS_COMPLETED:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  /// Get budget status color
  static Color getStatusColor(pb.BudgetStatus status) {
    switch (status) {
      case pb.BudgetStatus.BUDGET_STATUS_ACTIVE:
        return const Color(0xFF10B981); // Green
      case pb.BudgetStatus.BUDGET_STATUS_EXCEEDED:
        return const Color(0xFFEF4444); // Red
      case pb.BudgetStatus.BUDGET_STATUS_NEAR_LIMIT:
        return const Color(0xFFFB923C); // Orange
      case pb.BudgetStatus.BUDGET_STATUS_COMPLETED:
        return const Color(0xFF10B981); // Green
      default:
        return const Color(0xFF9CA3AF); // Gray
    }
  }
}
