import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

/// Review and edit the AI's proposed budget allocation before anything is
/// created.
///
/// "Apply Recommendations" used to call Get.back() and create nothing, so the
/// AI's per-category amounts were computed, rendered, and then discarded by the
/// button that promised to apply them.
///
/// Applying is deliberately a two-step: the AI proposes, the user decides.
/// These become real budgets that the send-funds flow enforces — a STRICT one
/// will refuse a transfer — so creating them straight from a tap, at amounts
/// the user never saw as editable, would hand spending controls to a model.
class BudgetAllocationReviewScreen extends StatefulWidget {
  const BudgetAllocationReviewScreen({
    required this.recommendations,
    required this.currency,
    this.monthlyIncome = 0,
    super.key,
  });

  final List<BudgetRecommendationData> recommendations;
  final String currency;

  /// Used only to show what share of income is being allocated. Zero hides it
  /// rather than rendering a meaningless percentage.
  final double monthlyIncome;

  @override
  State<BudgetAllocationReviewScreen> createState() =>
      _BudgetAllocationReviewScreenState();
}

/// One editable row. Mirrors the fields createBudget actually takes, so what
/// the user edits here is exactly what gets created.
class _Allocation {
  _Allocation({
    required this.category,
    required this.categoryName,
    required this.amount,
    required this.reasoning,
    required this.currentAmount,
  })  : controller = TextEditingController(
          text: amount > 0 ? amount.toStringAsFixed(0) : '',
        ),
        include = amount > 0;

  final String category;
  final String categoryName;
  final String reasoning;
  final double currentAmount;
  double amount;
  bool include;
  pb.BudgetPeriod period = pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY;
  // Flexible by default. A strict budget BLOCKS a transfer, so opting into
  // that belongs to the user, never to a default.
  pb.BudgetEnforcementMode enforcement =
      pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_FLEXIBLE;
  double alertThreshold = 80;
  final TextEditingController controller;

  void dispose() => controller.dispose();
}

class _BudgetAllocationReviewScreenState
    extends State<BudgetAllocationReviewScreen> {
  late final List<_Allocation> _rows;
  bool _applying = false;
  int _created = 0;
  final List<String> _failed = [];

  @override
  void initState() {
    super.initState();
    _rows = widget.recommendations
        .map((r) => _Allocation(
              category: r.category,
              categoryName: r.categoryName.isNotEmpty
                  ? r.categoryName
                  : _prettyCategory(r.category),
              amount: r.recommendedAmount,
              reasoning: r.reasoning,
              currentAmount: r.currentAmount,
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final r in _rows) {
      r.dispose();
    }
    super.dispose();
  }

  double get _total => _rows
      .where((r) => r.include)
      .fold<double>(0, (sum, r) => sum + r.amount);

  int get _includedCount => _rows.where((r) => r.include).length;

  /// Turns EXPENSE_CATEGORY_FOOD_DINING into "Food dining" for rows where the
  /// model gave a raw enum and no display name.
  String _prettyCategory(String raw) {
    final cleaned = raw.replaceFirst('EXPENSE_CATEGORY_', '').replaceAll('_', ' ');
    if (cleaned.isEmpty) return 'Other';
    return cleaned[0].toUpperCase() + cleaned.substring(1).toLowerCase();
  }

  pb.ExpenseCategory _protoCategory(String raw) =>
      pb.ExpenseCategory.values.firstWhere(
        (c) => c.name == raw,
        orElse: () => pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER,
      );

  Future<void> _apply() async {
    final selected = _rows.where((r) => r.include && r.amount > 0).toList();
    if (selected.isEmpty) return;

    setState(() {
      _applying = true;
      _created = 0;
      _failed.clear();
    });

    final cubit = context.read<BudgetCubit>();
    for (final row in selected) {
      try {
        await cubit.createBudget(
          name: row.categoryName,
          amount: row.amount,
          currency: widget.currency,
          category: _protoCategory(row.category),
          period: row.period,
          enforcementMode: row.enforcement,
          alertThreshold: row.alertThreshold,
        );
        _created++;
      } catch (_) {
        // Keep going: one rejected category must not strand the rest, and the
        // user is told exactly which ones did not make it.
        _failed.add(row.categoryName);
      }
    }

    if (!mounted) return;
    setState(() => _applying = false);

    if (_failed.isEmpty) {
      Get.back(result: true);
      Get.snackbar(
        'Budgets created',
        '$_created budget${_created == 1 ? '' : 's'} applied.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: InvoiceThemeColors.primaryPurple,
        colorText: Colors.white,
        margin: EdgeInsets.all(12.w),
      );
    } else {
      Get.snackbar(
        _created > 0 ? 'Partly applied' : 'Could not apply',
        _created > 0
            ? '$_created created. These did not save: ${_failed.join(', ')}.'
            : 'None of the budgets could be created. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade700,
        colorText: Colors.white,
        margin: EdgeInsets.all(12.w),
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final symbol = CurrencySymbols.symbols[widget.currency] ?? widget.currency;
    final overIncome =
        widget.monthlyIncome > 0 && _total > widget.monthlyIncome;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Review allocation',
          style: GoogleFonts.inter(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              children: [
                Text(
                  'These are suggestions, not decisions. Change any amount, '
                  'switch a category off, or make one strict before applying.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 16.h),
                ..._rows.map((r) => _row(r, symbol)),
              ],
            ),
          ),
          _footer(symbol, overIncome),
        ],
      ),
    );
  }

  Widget _row(_Allocation r, String symbol) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: r.include ? const Color(0xFFFAFAFC) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  r.categoryName,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              Switch(
                value: r.include,
                activeThumbColor: InvoiceThemeColors.primaryPurple,
                onChanged: (v) => setState(() => r.include = v),
              ),
            ],
          ),
          if (r.reasoning.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                r.reasoning,
                style: GoogleFonts.inter(
                  fontSize: 11.5.sp,
                  height: 1.35,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
          if (r.include) ...[
            Row(
              children: [
                SizedBox(
                  width: 130.w,
                  child: TextField(
                    controller: r.controller,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (v) =>
                        setState(() => r.amount = double.tryParse(v) ?? 0),
                    decoration: InputDecoration(
                      prefixText: '$symbol ',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                if (r.currentAmount > 0)
                  Expanded(
                    child: Text(
                      'now ${CurrencySymbols.formatAmountWithCurrency(r.currentAmount, widget.currency)}',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<pb.BudgetPeriod>(
                    initialValue: r.period,
                    isDense: true,
                    decoration: InputDecoration(
                      labelText: 'Period',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    items: const [
                      pb.BudgetPeriod.BUDGET_PERIOD_WEEKLY,
                      pb.BudgetPeriod.BUDGET_PERIOD_MONTHLY,
                      pb.BudgetPeriod.BUDGET_PERIOD_QUARTERLY,
                      pb.BudgetPeriod.BUDGET_PERIOD_YEARLY,
                    ]
                        .map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(
                                _prettyCategory(
                                    p.name.replaceFirst('BUDGET_PERIOD_', '')),
                                style: GoogleFonts.inter(fontSize: 12.sp),
                              ),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => r.period = v ?? r.period),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: DropdownButtonFormField<pb.BudgetEnforcementMode>(
                    initialValue: r.enforcement,
                    isDense: true,
                    decoration: InputDecoration(
                      labelText: 'If exceeded',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: pb.BudgetEnforcementMode
                            .BUDGET_ENFORCEMENT_MODE_FLEXIBLE,
                        child: Text('Warn me',
                            style: GoogleFonts.inter(fontSize: 12.sp)),
                      ),
                      DropdownMenuItem(
                        value: pb.BudgetEnforcementMode
                            .BUDGET_ENFORCEMENT_MODE_STRICT,
                        child: Text('Block it',
                            style: GoogleFonts.inter(fontSize: 12.sp)),
                      ),
                    ],
                    onChanged: (v) =>
                        setState(() => r.enforcement = v ?? r.enforcement),
                  ),
                ),
              ],
            ),
            if (r.enforcement ==
                pb.BudgetEnforcementMode.BUDGET_ENFORCEMENT_MODE_STRICT)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  'Transfers in this category will be refused once the budget '
                  'is spent. You can still override at the time.',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    height: 1.35,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _footer(String symbol, bool overIncome) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE5E7EB))),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$_includedCount categor${_includedCount == 1 ? 'y' : 'ies'}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
                Text(
                  CurrencySymbols.formatAmountWithCurrency(_total, widget.currency),
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ],
            ),
            if (overIncome)
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Text(
                  'This allocates more than the income we could see. Applying '
                  'is still allowed, since we may not know every source.',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    height: 1.35,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed:
                    (_applying || _includedCount == 0 || _total <= 0)
                        ? null
                        : _apply,
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvoiceThemeColors.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  _applying
                      ? 'Creating budgets…'
                      : 'Create $_includedCount budget${_includedCount == 1 ? '' : 's'}',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
