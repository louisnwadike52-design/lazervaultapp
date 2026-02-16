import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;
import 'package:intl/intl.dart';

/// Recurring Bills Screen
/// Manage recurring bills and subscriptions loaded from the backend
class RecurringBillsScreen extends StatefulWidget {
  const RecurringBillsScreen({super.key});

  @override
  State<RecurringBillsScreen> createState() => _RecurringBillsScreenState();
}

class _RecurringBillsScreenState extends State<RecurringBillsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetCubit>().loadRecurringBills();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Recurring Bills',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showCreateBillDialog(),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {
          if (state is BudgetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
          if (state is BudgetCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF10B981)),
            );
          }

          if (state is RecurringBillsLoaded) {
            return Column(
              children: [
                _buildSummaryCard(
                  bills: state.bills,
                  totalUpcoming: state.totalUpcoming,
                ),
                Expanded(
                  child: state.bills.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: () => context.read<BudgetCubit>().loadRecurringBills(),
                          color: const Color(0xFF10B981),
                          backgroundColor: const Color(0xFF1F1F1F),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.all(16.w),
                            itemCount: state.bills.length,
                            itemBuilder: (context, index) {
                              return _BillCard(bill: state.bills[index]);
                            },
                          ),
                        ),
                ),
              ],
            );
          }

          if (state is BudgetError) {
            return _buildErrorState(state.message);
          }

          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF10B981)),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required List<pb.RecurringBill> bills,
    required double totalUpcoming,
  }) {
    final upcomingBills = bills.where((b) => b.daysUntilDue >= 0 && b.daysUntilDue <= 30).toList();
    final overdueBills = bills.where((b) => b.daysUntilDue < 0).toList();

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D9668), Color(0xFF10B981), Color(0xFF34D399)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(
            label: 'Upcoming',
            value: '${upcomingBills.length}',
            subtext: 'bills',
          ),
          Container(
            width: 1,
            height: 40.h,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          _SummaryItem(
            label: 'This Month',
            value: CurrencySymbols.formatAmount(totalUpcoming),
            subtext: 'total',
          ),
          Container(
            width: 1,
            height: 40.h,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          _SummaryItem(
            label: 'Overdue',
            value: '${overdueBills.length}',
            subtext: overdueBills.isEmpty ? 'bills' : '!',
            subtextColor: overdueBills.isNotEmpty ? const Color(0xFFFFA726) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.receipt_long, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 40.r),
              ),
              SizedBox(height: 16.h),
              Text(
                'No recurring bills',
                style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Track your recurring expenses and subscriptions',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () => _showCreateBillDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Add Bill'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF9CA3AF)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<BudgetCubit>().loadRecurringBills(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showCreateBillDialog() {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final merchantController = TextEditingController();
    pb.ExpenseCategory selectedCategory = pb.ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS;
    String selectedRecurrence = 'monthly';

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: StatefulBuilder(
          builder: (context, setSheetState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  const Text(
                    'Add Recurring Bill',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24.h),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Bill Name',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      prefixText: '${CurrencySymbols.currentSymbol} ',
                      prefixStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: merchantController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Merchant (optional)',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<pb.ExpenseCategory>(
                        value: selectedCategory,
                        dropdownColor: const Color(0xFF2D2D2D),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        items: [
                          pb.ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS,
                          pb.ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES,
                          pb.ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE,
                          pb.ExpenseCategory.EXPENSE_CATEGORY_INSURANCE,
                          pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER,
                        ].map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(_categoryLabel(cat)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) setSheetState(() => selectedCategory = value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedRecurrence,
                        dropdownColor: const Color(0xFF2D2D2D),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                        isExpanded: true,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        items: const [
                          DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                          DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                          DropdownMenuItem(value: 'quarterly', child: Text('Quarterly')),
                          DropdownMenuItem(value: 'yearly', child: Text('Yearly')),
                        ],
                        onChanged: (value) {
                          if (value != null) setSheetState(() => selectedRecurrence = value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        final amount = double.tryParse(amountController.text.trim()) ?? 0;
                        final merchant = merchantController.text.trim();

                        if (name.isEmpty || amount <= 0) {
                          Get.snackbar('Error', 'Please enter a name and amount',
                              backgroundColor: const Color(0xFFEF4444));
                          return;
                        }

                        Get.back();
                        context.read<BudgetCubit>().createRecurringBill(
                          name: name,
                          amount: amount,
                          currency: CurrencySymbols.currentCurrency,
                          category: selectedCategory,
                          recurrencePattern: selectedRecurrence,
                          merchant: merchant.isNotEmpty ? merchant : null,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: const Text('Add Bill', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _categoryLabel(pb.ExpenseCategory cat) {
    switch (cat) {
      case pb.ExpenseCategory.EXPENSE_CATEGORY_SUBSCRIPTIONS:
        return 'Subscriptions';
      case pb.ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES:
        return 'Bills & Utilities';
      case pb.ExpenseCategory.EXPENSE_CATEGORY_RENT_MORTGAGE:
        return 'Rent/Mortgage';
      case pb.ExpenseCategory.EXPENSE_CATEGORY_INSURANCE:
        return 'Insurance';
      case pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER:
        return 'Other';
      default:
        return 'Other';
    }
  }
}

class _BillCard extends StatelessWidget {
  final pb.RecurringBill bill;

  const _BillCard({required this.bill});

  @override
  Widget build(BuildContext context) {
    final isOverdue = bill.daysUntilDue < 0;
    final isDueSoon = bill.daysUntilDue >= 0 && bill.daysUntilDue <= 3;
    final statusColor = isOverdue
        ? const Color(0xFFEF4444)
        : isDueSoon
            ? const Color(0xFFF59E0B)
            : const Color(0xFF10B981);

    final recurrenceLabel = bill.recurrencePattern.isNotEmpty
        ? bill.recurrencePattern[0].toUpperCase() + bill.recurrencePattern.substring(1)
        : 'Monthly';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isOverdue ? const Color(0xFFEF4444).withValues(alpha: 0.3) : statusColor.withValues(alpha: 0.2),
          width: isOverdue ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    _getIconForBill(bill.icon),
                    color: statusColor,
                    size: 24.r,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    if (bill.merchant.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        bill.merchant,
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencySymbols.formatAmount(bill.amount),
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _getDueText(bill.daysUntilDue),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (bill.hasNextDueDate()) ...[
                Icon(Icons.calendar_today, size: 14.r, color: Colors.grey[500]),
                SizedBox(width: 4.w),
                Text(
                  DateFormat('MMM d, yyyy').format(bill.nextDueDate.toDateTime()),
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                SizedBox(width: 16.w),
              ],
              Icon(Icons.repeat, size: 14.r, color: Colors.grey[500]),
              SizedBox(width: 4.w),
              Text(
                recurrenceLabel,
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const Spacer(),
              if (bill.autoPayEnabled) ...[
                Icon(Icons.autorenew, size: 14.r, color: const Color(0xFF10B981)),
                SizedBox(width: 4.w),
                const Text('Auto-pay', style: TextStyle(color: Color(0xFF10B981), fontSize: 12)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForBill(String? icon) {
    switch (icon) {
      case 'movie':
        return Icons.movie;
      case 'home':
        return Icons.home;
      case 'bolt':
        return Icons.bolt;
      case 'music_note':
        return Icons.music_note;
      case 'wifi':
        return Icons.wifi;
      case 'phone':
        return Icons.phone;
      case 'tv':
        return Icons.tv;
      default:
        return Icons.receipt;
    }
  }

  String _getDueText(int daysUntilDue) {
    if (daysUntilDue < 0) {
      return 'Overdue';
    } else if (daysUntilDue == 0) {
      return 'Due today';
    } else if (daysUntilDue == 1) {
      return 'Due tomorrow';
    } else {
      return 'Due in $daysUntilDue days';
    }
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final String subtext;
  final Color? subtextColor;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.subtext,
    this.subtextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12.sp)),
        SizedBox(height: 4.h),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          subtext,
          style: TextStyle(color: subtextColor ?? Colors.white.withValues(alpha: 0.6), fontSize: 11.sp),
        ),
      ],
    );
  }
}
