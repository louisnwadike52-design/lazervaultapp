import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'budget_warning_widget_widgets.dart';


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
        return const Color.fromARGB(255, 78, 3, 208); // Purple
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
