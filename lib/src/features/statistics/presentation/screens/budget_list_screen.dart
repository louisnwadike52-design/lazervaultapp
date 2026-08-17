import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/expense_category_helpers.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import '../../../../../core/utils/currency_formatter.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/shared_widgets/app_error_view.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
part 'budget_list_screen_widgets.dart';


class _SummaryCard extends StatelessWidget {
  final double totalBudgetAmount;
  final double totalSpentAmount;
  final double overallPercentage;

  const _SummaryCard({
    required this.totalBudgetAmount,
    required this.totalSpentAmount,
    required this.overallPercentage,
    super.key,
  });

  /// Green while there's comfortable headroom, amber as the budget fills up,
  /// red once spending is at/over the limit.
  static Color _utilizationColor(double percentage) {
    if (percentage >= 90) return const Color(0xFFEF4444);
    if (percentage >= 70) return const Color(0xFFFB923C);
    return InvoiceThemeColors.primaryPurple;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Budget',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(totalBudgetAmount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Progress Ring — a real determinate arc of budget utilization,
          // coloured green/amber/red by how much of the budget is used.
          SizedBox(
            height: 120.h,
            width: 120.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 110.h,
                  width: 110.h,
                  child: CircularProgressIndicator(
                    value: (overallPercentage / 100).clamp(0.0, 1.0),
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                    backgroundColor: const Color(0xFF2D2D2D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _utilizationColor(overallPercentage),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${overallPercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Used',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spent',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CurrencySymbols.formatAmount(totalSpentAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Remaining',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    CurrencySymbols.formatAmount(totalBudgetAmount - totalSpentAmount),
                    style: TextStyle(
                      color: (totalBudgetAmount - totalSpentAmount) >= 0
                          ? InvoiceThemeColors.primaryPurple
                          : const Color(0xFFEF4444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
