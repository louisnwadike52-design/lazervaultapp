import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Budget Status Enum
enum BudgetStatus {
  ok,
  nearLimit,
  exceeded,
  noBudgetSet,
  currencyMismatch,
  expired,
}

/// Budget Enforcement Mode
enum BudgetEnforcementMode {
  flexible,  // Allow transactions over budget with warning
  strict,    // Block transactions when budget exceeded
}

/// Budget Validation Reason
enum BudgetValidationReason {
  withinBudget,
  nearLimit,
  approachingLimit,
  budgetExceeded,
  budgetExceededStrict,     // Exceeded with strict enforcement - BLOCK
  budgetExceededFlexible,   // Exceeded with flexible enforcement - ALLOW with warning
  noBudgetSet,
  noActiveBudget,
  currencyMismatch,
  amountBelowThreshold,
  withinTolerance,
}

/// Parse budget enforcement mode from string
BudgetEnforcementMode parseEnforcementMode(String mode) {
  switch (mode.toLowerCase()) {
    case 'strict':
      return BudgetEnforcementMode.strict;
    case 'flexible':
    default:
      return BudgetEnforcementMode.flexible;
  }
}

/// Parse budget reason from string
BudgetValidationReason parseBudgetReason(String reason) {
  final normalized = reason.toLowerCase().replaceAll('_', '');
  switch (normalized) {
    case 'withinbudget':
    case 'within_budget':
      return BudgetValidationReason.withinBudget;
    case 'nearlimit':
    case 'near_limit':
      return BudgetValidationReason.nearLimit;
    case 'approachinglimit':
    case 'approaching_limit':
      return BudgetValidationReason.approachingLimit;
    case 'budgetexceeded':
    case 'budget_exceeded':
      return BudgetValidationReason.budgetExceeded;
    case 'budgetexceededstrict':
    case 'budget_exceeded_strict':
      return BudgetValidationReason.budgetExceededStrict;
    case 'budgetexceededflexible':
    case 'budget_exceeded_flexible':
      return BudgetValidationReason.budgetExceededFlexible;
    case 'nobudgetset':
    case 'no_budget_set':
      return BudgetValidationReason.noBudgetSet;
    case 'noactivebudget':
    case 'no_active_budget':
      return BudgetValidationReason.noActiveBudget;
    case 'currencymismatch':
    case 'currency_mismatch':
      return BudgetValidationReason.currencyMismatch;
    case 'amountbelowthreshold':
    case 'amount_below_threshold':
      return BudgetValidationReason.amountBelowThreshold;
    case 'withintolerance':
    case 'within_tolerance':
      return BudgetValidationReason.withinTolerance;
    default:
      return BudgetValidationReason.withinBudget;
  }
}

/// Budget Info Model
/// Contains budget validation information
class BudgetInfo {
  final String budgetId;
  final String budgetName;
  final double amount;         // Budget limit (major units)
  final double spent;          // Amount spent (major units)
  final double percentage;     // Percentage used
  final int daysRemaining;     // Days remaining in period
  final String currency;
  final BudgetEnforcementMode enforcementMode;  // strict or flexible

  const BudgetInfo({
    required this.budgetId,
    required this.budgetName,
    required this.amount,
    required this.spent,
    required this.percentage,
    required this.daysRemaining,
    required this.currency,
    this.enforcementMode = BudgetEnforcementMode.flexible,
  });

  factory BudgetInfo.fromJson(Map<String, dynamic> json) {
    return BudgetInfo(
      budgetId: json['budget_id'] as String? ?? '',
      budgetName: json['budget_name'] as String? ?? 'Budget',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      daysRemaining: json['days_remaining'] as int? ?? 0,
      currency: json['currency'] as String? ?? 'NGN',
      enforcementMode: json['enforcement_mode'] != null
          ? parseEnforcementMode(json['enforcement_mode'] as String)
          : BudgetEnforcementMode.flexible,
    );
  }

  /// Get budget status based on percentage
  BudgetStatus get status {
    if (percentage >= 100) return BudgetStatus.exceeded;
    if (percentage >= 80) return BudgetStatus.nearLimit;
    return BudgetStatus.ok;
  }

  /// Get remaining amount
  double get remaining => amount - spent;

  /// Check if budget is in strict mode
  bool get isStrict => enforcementMode == BudgetEnforcementMode.strict;
}

/// Budget Validation Result
/// Result of validating a transaction against a budget
class BudgetValidationResult {
  final bool allowed;
  final String reason;            // "budget_exceeded", "near_limit", "within_budget", "no_budget_set", etc.
  final double currentSpent;
  final double budgetLimit;
  final double percentageUsed;
  final double remaining;
  final List<BudgetInfo> matchingBudgets;
  final List<String> warnings;
  final List<String> infoMessages;

  const BudgetValidationResult({
    required this.allowed,
    required this.reason,
    required this.currentSpent,
    required this.budgetLimit,
    required this.percentageUsed,
    required this.remaining,
    this.matchingBudgets = const [],
    this.warnings = const [],
    this.infoMessages = const [],
  });

  factory BudgetValidationResult.fromJson(Map<String, dynamic> json) {
    final budgets = json['matching_budgets'] as List<dynamic>?;
    final warningsList = json['warnings'] as List<dynamic>?;
    final infoList = json['info_messages'] as List<dynamic>?;

    // Parse reason which may contain multiple parts separated by |
    String rawReason = json['reason'] as String? ?? 'within_budget';
    String mainReason = rawReason;
    if (rawReason.contains('|')) {
      mainReason = rawReason.split('|').first.trim();
    }

    return BudgetValidationResult(
      allowed: json['allowed'] as bool? ?? true,
      reason: mainReason,
      currentSpent: (json['current_spent'] as num?)?.toDouble() ?? 0.0,
      budgetLimit: (json['budget_limit'] as num?)?.toDouble() ?? 0.0,
      percentageUsed: (json['percentage_used'] as num?)?.toDouble() ?? 0.0,
      remaining: (json['remaining'] as num?)?.toDouble() ?? 0.0,
      matchingBudgets: budgets?.map((b) => BudgetInfo.fromJson(b as Map<String, dynamic>)).toList() ?? [],
      warnings: warningsList?.map((w) => w.toString()).toList() ?? [],
      infoMessages: infoList?.map((i) => i.toString()).toList() ?? [],
    );
  }

  /// Create from a JSON response with additional transaction context
  factory BudgetValidationResult.fromJsonWithTransaction(
    Map<String, dynamic> json,
    double transactionAmount,
  ) {
    final result = BudgetValidationResult.fromJson(json);
    return result.copyWith(transactionAmount: transactionAmount);
  }

  /// Create a copy with some fields replaced
  BudgetValidationResult copyWith({
    String? reason,
    double? currentSpent,
    double? budgetLimit,
    double? percentageUsed,
    double? remaining,
    double? transactionAmount,
    List<BudgetInfo>? matchingBudgets,
  }) {
    return BudgetValidationResult(
      allowed: allowed,
      reason: reason ?? this.reason,
      currentSpent: currentSpent ?? this.currentSpent,
      budgetLimit: budgetLimit ?? this.budgetLimit,
      percentageUsed: percentageUsed ?? this.percentageUsed,
      remaining: remaining ?? this.remaining,
      matchingBudgets: matchingBudgets ?? this.matchingBudgets,
      warnings: warnings,
      infoMessages: infoMessages,
    );
  }

  BudgetValidationReason get parsedReason => parseBudgetReason(reason);

  BudgetStatus get status {
    final parsed = parsedReason;
    switch (parsed) {
      case BudgetValidationReason.budgetExceeded:
      case BudgetValidationReason.budgetExceededStrict:
        return BudgetStatus.exceeded;
      case BudgetValidationReason.budgetExceededFlexible:
        return BudgetStatus.exceeded; // Still show exceeded, but transaction is allowed
      case BudgetValidationReason.nearLimit:
      case BudgetValidationReason.approachingLimit:
        return BudgetStatus.nearLimit;
      case BudgetValidationReason.noBudgetSet:
      case BudgetValidationReason.noActiveBudget:
        return BudgetStatus.noBudgetSet;
      case BudgetValidationReason.currencyMismatch:
        return BudgetStatus.currencyMismatch;
      case BudgetValidationReason.withinTolerance:
        return BudgetStatus.ok; // Over budget but within tolerance
      case BudgetValidationReason.amountBelowThreshold:
        return BudgetStatus.ok; // Small amount, don't show warning
      case BudgetValidationReason.withinBudget:
        if (percentageUsed >= 100) return BudgetStatus.exceeded;
        if (percentageUsed >= 80) return BudgetStatus.nearLimit;
        return BudgetStatus.ok;
    }
  }

  BudgetInfo? get primaryBudget => matchingBudgets.isNotEmpty ? matchingBudgets.first : null;

  /// Check if this result should show a warning to the user
  bool get shouldShowWarning {
    final status = this.status;
    return status == BudgetStatus.exceeded ||
           status == BudgetStatus.nearLimit ||
           status == BudgetStatus.currencyMismatch;
  }

  /// Check if this result indicates no budget is set
  bool get hasNoBudget => status == BudgetStatus.noBudgetSet;

  /// Check if currency mismatch occurred
  bool get hasCurrencyMismatch => status == BudgetStatus.currencyMismatch;

  /// Check if this result should block the transaction (strict mode exceeded)
  bool get shouldBlockTransaction {
    final parsed = parsedReason;
    return parsed == BudgetValidationReason.budgetExceededStrict;
  }

  /// Check if transaction is allowed despite being over budget (flexible mode)
  bool get allowedDespiteExceeded {
    final parsed = parsedReason;
    return parsed == BudgetValidationReason.budgetExceededFlexible;
  }

  /// Get the display message for the user
  String get displayMessage {
    switch (parsedReason) {
      case BudgetValidationReason.budgetExceeded:
        final overBy = percentageUsed - 100;
        return 'This transaction will exceed your ${primaryBudget?.budgetName ?? "budget"} by ${overBy.toStringAsFixed(0)}%.';
      case BudgetValidationReason.budgetExceededStrict:
        final overBy = percentageUsed - 100;
        return 'Transaction blocked: This would exceed your ${primaryBudget?.budgetName ?? "budget"} by ${overBy.toStringAsFixed(0)}%. (Strict enforcement)';
      case BudgetValidationReason.budgetExceededFlexible:
        final overBy = percentageUsed - 100;
        final mode = primaryBudget?.enforcementMode == BudgetEnforcementMode.strict ? 'strict' : 'flexible';
        return 'Warning: This exceeds your ${primaryBudget?.budgetName ?? "budget"} by ${overBy.toStringAsFixed(0)}%. ($mode mode - transaction allowed)';
      case BudgetValidationReason.nearLimit:
        return 'You\'ve used ${percentageUsed.toStringAsFixed(0)}% of your ${primaryBudget?.budgetName ?? "budget"}.';
      case BudgetValidationReason.approachingLimit:
        return 'You\'re approaching your budget limit (${percentageUsed.toStringAsFixed(0)}% used).';
      case BudgetValidationReason.noBudgetSet:
        return 'No budget set for this category. Transaction will proceed.';
      case BudgetValidationReason.noActiveBudget:
        return 'No active budget found for this period. Consider creating a new budget.';
      case BudgetValidationReason.currencyMismatch:
        final budgetCurrency = primaryBudget?.currency ?? 'NGN';
        return 'Currency mismatch: Your budget is in $budgetCurrency.';
      case BudgetValidationReason.amountBelowThreshold:
        return 'Amount is below budget tracking threshold.';
      case BudgetValidationReason.withinTolerance:
        return 'Over budget by a small amount, but within acceptable tolerance.';
      case BudgetValidationReason.withinBudget:
        final budgetName = primaryBudget?.budgetName ?? "budget";
        if (remaining > 0) {
          return 'You have ${remaining.toStringAsFixed(2)} remaining in your $budgetName.';
        }
        return 'Within your $budgetName limit.';
    }
  }
}

/// Budget Warning Widget
/// Displays budget status with color-coded warnings
class BudgetWarningWidget extends StatelessWidget {
  final double currentSpent;
  final double budgetLimit;
  final double percentageUsed;
  final double remaining;
  final int daysRemaining;
  final BudgetInfo? budgetInfo;
  final BudgetValidationResult? validationResult;

  const BudgetWarningWidget({
    super.key,
    required this.currentSpent,
    required this.budgetLimit,
    required this.percentageUsed,
    required this.remaining,
    required this.daysRemaining,
    this.budgetInfo,
    this.validationResult,
  });

  /// Create from validation result
  factory BudgetWarningWidget.fromValidation(BudgetValidationResult result) {
    return BudgetWarningWidget(
      currentSpent: result.currentSpent,
      budgetLimit: result.budgetLimit,
      percentageUsed: result.percentageUsed,
      remaining: result.remaining,
      daysRemaining: result.primaryBudget?.daysRemaining ?? 0,
      budgetInfo: result.primaryBudget,
      validationResult: result,
    );
  }

  /// Get budget status
  BudgetStatus get status {
    if (validationResult != null) {
      return validationResult!.status;
    }
    if (percentageUsed >= 100) return BudgetStatus.exceeded;
    if (percentageUsed >= 80) return BudgetStatus.nearLimit;
    return BudgetStatus.ok;
  }

  /// Get status color
  Color get statusColor {
    switch (status) {
      case BudgetStatus.exceeded:
        return const Color(0xFFEF4444); // Red
      case BudgetStatus.nearLimit:
        return const Color(0xFFF59E0B); // Orange
      case BudgetStatus.ok:
        return const Color(0xFF10B981); // Green
      case BudgetStatus.noBudgetSet:
        return const Color(0xFF6B7280); // Gray
      case BudgetStatus.currencyMismatch:
        return const Color(0xFF8B5CF6); // Purple
      case BudgetStatus.expired:
        return const Color(0xFFEC4899); // Pink
    }
  }

  /// Get status label
  String get statusLabel {
    if (validationResult != null) {
      return validationResult!.parsedReason.toLabel();
    }
    switch (status) {
      case BudgetStatus.exceeded:
        return 'Budget Exceeded';
      case BudgetStatus.nearLimit:
        return 'Near Budget Limit';
      case BudgetStatus.ok:
        return 'Within Budget';
      case BudgetStatus.noBudgetSet:
        return 'No Budget Set';
      case BudgetStatus.currencyMismatch:
        return 'Currency Mismatch';
      case BudgetStatus.expired:
        return 'Budget Expired';
    }
  }

  /// Get status message
  String get statusMessage {
    if (validationResult != null) {
      return validationResult!.displayMessage;
    }
    switch (status) {
      case BudgetStatus.exceeded:
        return 'This transaction will exceed your ${budgetInfo?.budgetName ?? "budget"} by ${(remaining * -1).toStringAsFixed(2)}.';
      case BudgetStatus.nearLimit:
        return 'You\'ve used ${percentageUsed.toStringAsFixed(0)}% of your ${budgetInfo?.budgetName ?? "budget"}.';
      case BudgetStatus.ok:
        return 'You have ${remaining.toStringAsFixed(2)} remaining in your ${budgetInfo?.budgetName ?? "budget"}.';
      case BudgetStatus.noBudgetSet:
        return 'No budget is set for this category.';
      case BudgetStatus.currencyMismatch:
        return 'Transaction currency differs from budget currency.';
      case BudgetStatus.expired:
        return 'The budget period has expired.';
    }
  }

  /// Check if widget should be shown
  bool get shouldShow {
    if (validationResult != null) {
      return validationResult!.shouldShowWarning || validationResult!.hasNoBudget;
    }
    return status != BudgetStatus.ok;
  }

  @override
  Widget build(BuildContext context) {
    // Don't show if everything is OK and no info to display
    if (!shouldShow && status == BudgetStatus.ok) {
      return const SizedBox.shrink();
    }

    final effectiveBudgetInfo = budgetInfo ?? validationResult?.primaryBudget;
    final hasInfoMessages = validationResult?.infoMessages.isNotEmpty ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(
                _getIconForStatus(),
                color: statusColor,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                statusLabel,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const Spacer(),
              if (percentageUsed > 0 && status != BudgetStatus.noBudgetSet && status != BudgetStatus.currencyMismatch)
                Text(
                  '${percentageUsed.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // Progress bar (only show for percentage-based statuses)
          if (status == BudgetStatus.ok || status == BudgetStatus.nearLimit || status == BudgetStatus.exceeded) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: (percentageUsed / 100).clamp(0.0, 1.0),
                backgroundColor: const Color(0xFF2D2D2D),
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                minHeight: 6.h,
              ),
            ),
            SizedBox(height: 12.h),
          ],

          // Details
          Text(
            statusMessage,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),

          // Additional info messages
          if (hasInfoMessages) ...[
            SizedBox(height: 8.h),
            for (final message in validationResult!.infoMessages) ...[
              Text(
                '• $message',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ],

          // Days remaining
          if (daysRemaining > 0 && effectiveBudgetInfo != null && status != BudgetStatus.noBudgetSet) ...[
            SizedBox(height: 8.h),
            Text(
              '$daysRemaining ${daysRemaining == 1 ? "day" : "days"} remaining in this budget period',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],

          // Warnings
          if (validationResult?.warnings.isNotEmpty ?? false) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, size: 14.sp, color: const Color(0xFFF59E0B)),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      validationResult!.warnings.first,
                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFFF59E0B)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getIconForStatus() {
    switch (status) {
      case BudgetStatus.exceeded:
        return Icons.warning_rounded;
      case BudgetStatus.nearLimit:
        return Icons.info_rounded;
      case BudgetStatus.ok:
        return Icons.check_circle_rounded;
      case BudgetStatus.noBudgetSet:
        return Icons.help_outline_rounded;
      case BudgetStatus.currencyMismatch:
        return Icons.currency_exchange_rounded;
      case BudgetStatus.expired:
        return Icons.event_busy_rounded;
    }
  }
}

/// Extension to convert BudgetValidationReason to label
extension BudgetValidationReasonExtension on BudgetValidationReason {
  String toLabel() {
    switch (this) {
      case BudgetValidationReason.withinBudget:
        return 'Within Budget';
      case BudgetValidationReason.nearLimit:
        return 'Near Budget Limit';
      case BudgetValidationReason.approachingLimit:
        return 'Approaching Limit';
      case BudgetValidationReason.budgetExceeded:
        return 'Budget Exceeded';
      case BudgetValidationReason.budgetExceededStrict:
        return 'Budget Exceeded (Strict)';
      case BudgetValidationReason.budgetExceededFlexible:
        return 'Budget Exceeded (Flexible)';
      case BudgetValidationReason.noBudgetSet:
        return 'No Budget Set';
      case BudgetValidationReason.noActiveBudget:
        return 'No Active Budget';
      case BudgetValidationReason.currencyMismatch:
        return 'Currency Mismatch';
      case BudgetValidationReason.amountBelowThreshold:
        return 'Small Amount';
      case BudgetValidationReason.withinTolerance:
        return 'Within Tolerance';
    }
  }
}

/// Compact Budget Warning Widget
/// A smaller version for use in tight spaces
class CompactBudgetWarning extends StatelessWidget {
  final double percentageUsed;
  final BudgetStatus status;
  final String? message;
  final BudgetValidationResult? validationResult;

  const CompactBudgetWarning({
    super.key,
    required this.percentageUsed,
    required this.status,
    this.message,
    this.validationResult,
  });

  Color get statusColor {
    switch (status) {
      case BudgetStatus.exceeded:
        return const Color(0xFFEF4444);
      case BudgetStatus.nearLimit:
        return const Color(0xFFF59E0B);
      case BudgetStatus.ok:
        return const Color(0xFF10B981);
      case BudgetStatus.noBudgetSet:
        return const Color(0xFF6B7280);
      case BudgetStatus.currencyMismatch:
        return const Color(0xFF8B5CF6);
      case BudgetStatus.expired:
        return const Color(0xFFEC4899);
    }
  }

  IconData get statusIcon {
    switch (status) {
      case BudgetStatus.exceeded:
        return Icons.warning;
      case BudgetStatus.nearLimit:
        return Icons.info;
      case BudgetStatus.ok:
        return Icons.check_circle;
      case BudgetStatus.noBudgetSet:
        return Icons.help_outline;
      case BudgetStatus.currencyMismatch:
        return Icons.currency_exchange;
      case BudgetStatus.expired:
        return Icons.event_busy;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Don't show if OK
    if (status == BudgetStatus.ok) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 16.sp,
          ),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              message ??
                validationResult?.displayMessage ??
                '${percentageUsed.toStringAsFixed(0)}% of budget used',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
