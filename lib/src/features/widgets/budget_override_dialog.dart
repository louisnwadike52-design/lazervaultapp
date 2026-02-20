import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Result of a budget override/adjustment action
enum BudgetOverrideAction {
  cancel,
  overrideOnce,
  increaseBudget,
}

/// Result data when user chooses to increase budget
class BudgetIncreaseResult {
  final double increaseAmount;
  final bool confirmWithPin;

  const BudgetIncreaseResult({
    required this.increaseAmount,
    this.confirmWithPin = true,
  });
}

/// Dialog shown when a transaction is blocked due to budget exceeded (strict mode)
/// Allows user to:
/// 1. Cancel the transaction
/// 2. Override once (skip budget check for this transaction)
/// 3. Increase the budget limit
class BudgetOverrideDialog extends StatefulWidget {
  final String budgetName;
  final double currentSpent;
  final double budgetLimit;
  final double transactionAmount;
  final double percentageUsed;
  final String currency;
  final String budgetId;

  const BudgetOverrideDialog({
    super.key,
    required this.budgetName,
    required this.currentSpent,
    required this.budgetLimit,
    required this.transactionAmount,
    required this.percentageUsed,
    required this.currency,
    required this.budgetId,
  });

  /// Show the dialog and return user's action
  static Future<BudgetOverrideAction?> show(
    BuildContext context, {
    required String budgetName,
    required double currentSpent,
    required double budgetLimit,
    required double transactionAmount,
    required double percentageUsed,
    required String currency,
    required String budgetId,
  }) {
    return showModalBottomSheet<BudgetOverrideAction>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BudgetOverrideDialog(
        budgetName: budgetName,
        currentSpent: currentSpent,
        budgetLimit: budgetLimit,
        transactionAmount: transactionAmount,
        percentageUsed: percentageUsed,
        currency: currency,
        budgetId: budgetId,
      ),
    );
  }

  @override
  State<BudgetOverrideDialog> createState() => _BudgetOverrideDialogState();
}

class _BudgetOverrideDialogState extends State<BudgetOverrideDialog> {
  final TextEditingController _increaseController = TextEditingController();
  final FocusNode _increaseFocus = FocusNode();

  double? _suggestedIncrease;
  bool _showIncreaseInput = false;

  @override
  void initState() {
    super.initState();
    // Calculate minimum increase needed to cover this transaction
    final totalAfterTransaction = widget.currentSpent + widget.transactionAmount;
    _suggestedIncrease = totalAfterTransaction - widget.budgetLimit;
    if (_suggestedIncrease! < 0) _suggestedIncrease = null;
  }

  @override
  void dispose() {
    _increaseController.dispose();
    _increaseFocus.dispose();
    super.dispose();
  }

  void _handleIncreaseBudget() {
    final amountText = _increaseController.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount')),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    Navigator.of(context).pop(BudgetOverrideAction.increaseBudget);

    // Navigate to PIN confirmation, then proceed with the increased budget
    // The calling screen should handle the PIN confirmation and retry
  }

  void _handleOverrideOnce() {
    Navigator.of(context).pop(BudgetOverrideAction.overrideOnce);
  }

  void _handleCancel() {
    Navigator.of(context).pop(BudgetOverrideAction.cancel);
  }

  @override
  Widget build(BuildContext context) {
    final isOverBudget = widget.percentageUsed >= 100;
    final overBy = widget.percentageUsed - 100;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, MediaQuery.of(context).viewInsets.bottom + 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Warning icon
              const Icon(
                Icons.warning_rounded,
                color: Color(0xFFEF4444),
                size: 32,
              ),
              SizedBox(height: 16.h),

              // Title
              Text(
                'Budget Limit Exceeded',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),

              // Budget info
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.budgetName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${widget.percentageUsed.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: (widget.percentageUsed / 100).clamp(0.0, 1.0),
                        backgroundColor: const Color(0xFF1A1A1A),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFEF4444)),
                        minHeight: 6.h,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Spent: ${widget.currency} ${widget.currentSpent.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        Text(
                          'Limit: ${widget.currency} ${widget.budgetLimit.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                    if (isOverBudget) ...[
                      SizedBox(height: 8.h),
                      Text(
                        'Over budget by ${overBy.toStringAsFixed(0)}% (${widget.currency} ${((widget.budgetLimit * overBy / 100)).toStringAsFixed(2)})',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFFEF4444),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Transaction info
              Text(
                'This transaction requires ${widget.currency} ${widget.transactionAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),

              // Options
              Text(
                'Choose an option to proceed:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16.h),

              if (!_showIncreaseInput) ...[
                // Option 1: Override once
                _buildOptionButton(
                  icon: Icons.skip_next_rounded,
                  title: 'Override Once',
                  description: 'Skip budget check for this transaction only',
                  onTap: _handleOverrideOnce,
                  color: const Color(0xFF3B82F6),
                ),
                SizedBox(height: 12.h),

                // Option 2: Increase budget
                _buildOptionButton(
                  icon: Icons.add_circle_outline_rounded,
                  title: 'Increase Budget',
                  description: _suggestedIncrease != null
                      ? 'Add ${widget.currency} ${_suggestedIncrease!.toStringAsFixed(2)} to your budget'
                      : 'Increase your budget limit',
                  onTap: () {
                    setState(() => _showIncreaseInput = true);
                    if (_suggestedIncrease != null) {
                      _increaseController.text = _suggestedIncrease!.toStringAsFixed(2);
                    }
                  },
                  color: const Color(0xFF10B981),
                ),
              ] else ...[
                // Budget increase input
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Increase Budget',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Enter amount to add to ${widget.budgetName}:',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _increaseController,
                        focusNode: _increaseFocus,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          prefixText: '${widget.currency} ',
                          hintStyle: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Color(0xFF10B981)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      if (_suggestedIncrease != null)
                        Text(
                          'Suggested: ${widget.currency} ${_suggestedIncrease!.toStringAsFixed(2)} (minimum needed)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() => _showIncreaseInput = false);
                                _increaseController.clear();
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF9CA3AF),
                                side: const BorderSide(color: Color(0xFF3D3D3D)),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text('Cancel', style: TextStyle(fontSize: 14.sp)),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _handleIncreaseBudget,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF10B981),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                'Confirm Increase',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 24.h),

              // Cancel button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _handleCancel,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF9CA3AF),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Cancel Transaction',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF6B7280),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
