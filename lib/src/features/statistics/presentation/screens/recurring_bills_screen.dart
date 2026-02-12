import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:intl/intl.dart';

/// Recurring Bills Screen
/// Manage recurring bills and subscriptions with automatic reminders
class RecurringBillsScreen extends StatefulWidget {
  const RecurringBillsScreen({super.key});

  @override
  State<RecurringBillsScreen> createState() => _RecurringBillsScreenState();
}

class _RecurringBillsScreenState extends State<RecurringBillsScreen> {
  final List<RecurringBill> _bills = [];
  bool _showUpcomingOnly = false;

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  void _loadBills() {
    // TODO: Load from backend
    setState(() {
      _bills.addAll([
        RecurringBill(
          id: '1',
          name: 'Netflix Subscription',
          amount: 4500,
          currency: 'NGN',
          category: 'Subscriptions',
          recurrencePattern: 'monthly',
          nextDueDate: DateTime.now().add(const Duration(days: 5)),
          daysUntilDue: 5,
          icon: 'movie',
          autoPayEnabled: false,
        ),
        RecurringBill(
          id: '2',
          name: 'Rent',
          amount: 500000,
          currency: 'NGN',
          category: 'Rent/Mortgage',
          recurrencePattern: 'monthly',
          nextDueDate: DateTime.now().add(const Duration(days: 12)),
          daysUntilDue: 12,
          icon: 'home',
          autoPayEnabled: true,
        ),
        RecurringBill(
          id: '3',
          name: 'Electricity Bill',
          amount: 25000,
          currency: 'NGN',
          category: 'Bills/Utilities',
          recurrencePattern: 'monthly',
          nextDueDate: DateTime.now().add(const Duration(days: 8)),
          daysUntilDue: 8,
          merchant: 'EKEDC',
          icon: 'bolt',
          autoPayEnabled: false,
        ),
        RecurringBill(
          id: '4',
          name: 'Spotify Premium',
          amount: 1200,
          currency: 'NGN',
          category: 'Subscriptions',
          recurrencePattern: 'monthly',
          nextDueDate: DateTime.now().add(const Duration(days: 15)),
          daysUntilDue: 15,
          icon: 'music_note',
          autoPayEnabled: false,
        ),
        RecurringBill(
          id: '5',
          name: 'Internet Service',
          amount: 15000,
          currency: 'NGN',
          category: 'Bills/Utilities',
          recurrencePattern: 'monthly',
          nextDueDate: DateTime.now().subtract(const Duration(days: 2)),
          daysUntilDue: -2,
          merchant: 'Spectranet',
          icon: 'wifi',
          autoPayEnabled: true,
        ),
      ]);
    });
  }

  List<RecurringBill> get _filteredBills {
    if (_showUpcomingOnly) {
      return _bills.where((b) => b.daysUntilDue >= 0 && b.daysUntilDue <= 30).toList();
    }
    return _bills;
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
            onPressed: () => _showFilterDialog(),
            icon: Icon(Icons.filter_list, color: _showUpcomingOnly ? const Color(0xFF3B82F6) : Colors.white),
          ),
          IconButton(
            onPressed: () => Get.toNamed('/statistics/recurring-bills/create'),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummaryCard(),
          Expanded(
            child: _filteredBills.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: _filteredBills.length,
                    itemBuilder: (context, index) {
                      return _BillCard(
                        bill: _filteredBills[index],
                        onMarkPaid: () => _markAsPaid(_filteredBills[index].id),
                        onEdit: () => _editBill(_filteredBills[index].id),
                        onDelete: () => _deleteBill(_filteredBills[index].id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    final upcomingBills = _bills.where((b) => b.daysUntilDue >= 0 && b.daysUntilDue <= 30).toList();
    final overdueBills = _bills.where((b) => b.daysUntilDue < 0).toList();
    final totalUpcoming = upcomingBills.fold<double>(0, (sum, b) => sum + b.amount);

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
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
            subtextColor: const Color(0xFFFFA726),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, color: Colors.grey[600], size: 64.r),
          SizedBox(height: 16.h),
          Text(
            _showUpcomingOnly ? 'No upcoming bills' : 'No recurring bills',
            style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Track your recurring expenses and subscriptions',
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
          ),
          if (!_showUpcomingOnly) ...[
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed('/statistics/recurring-bills/create'),
              icon: const Icon(Icons.add),
              label: const Text('Add Bill'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showFilterDialog() {
    Get.defaultDialog(
      title: 'Filter Bills',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Show upcoming only (next 30 days)'),
            value: _showUpcomingOnly,
            onChanged: (value) {
              setState(() => _showUpcomingOnly = value ?? false);
              Get.back();
            },
            activeColor: const Color(0xFF3B82F6),
            checkColor: Colors.white,
          ),
        ],
      ),
      textConfirm: 'Close',
      onConfirm: () => Get.back(),
    );
  }

  void _markAsPaid(String id) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
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
              'Mark Bill as Paid',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.h),
            TextField(
              decoration: InputDecoration(
                labelText: 'Payment Date',
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                // TODO: Handle date selection
              },
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  setState(() {
                    _bills.removeWhere((b) => b.id == id);
                  });
                  Get.snackbar(
                    'Success',
                    'Bill marked as paid',
                    backgroundColor: const Color(0xFF10B981),
                  );
                  // TODO: Call backend to mark as paid
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: const Text('Confirm Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editBill(String id) {
    Get.toNamed('/statistics/recurring-bills/create', arguments: {'billId': id});
  }

  void _deleteBill(String id) {
    Get.defaultDialog(
      title: 'Delete Bill',
      middleText: 'Are you sure you want to delete this recurring bill? Payments will no longer be tracked.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF9CA3AF),
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        setState(() {
          _bills.removeWhere((b) => b.id == id);
        });
        Get.back();
        // TODO: Delete from backend
        Get.snackbar('Deleted', 'Bill deleted successfully', backgroundColor: const Color(0xFF10B981));
      },
    );
  }
}

class _BillCard extends StatelessWidget {
  final RecurringBill bill;
  final VoidCallback onMarkPaid;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BillCard({
    required this.bill,
    required this.onMarkPaid,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = bill.daysUntilDue < 0;
    final isDueSoon = bill.daysUntilDue >= 0 && bill.daysUntilDue <= 3;
    final statusColor = isOverdue
        ? const Color(0xFFEF4444)
        : isDueSoon
            ? const Color(0xFFF59E0B)
            : const Color(0xFF10B981);

    final dateFormat = DateFormat('MMM d, yyyy');
    final recurrenceLabel = bill.recurrencePattern[0].toUpperCase() + bill.recurrencePattern.substring(1);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isOverdue ? const Color(0xFFEF4444).withValues(alpha: 0.3) : const Color(0xFF2D2D2D),
          width: isOverdue ? 2 : 1,
        ),
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
                    if (bill.merchant != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        bill.merchant!,
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
              Icon(Icons.calendar_today, size: 14.r, color: Colors.grey[500]),
              SizedBox(width: 4.w),
              Text(
                dateFormat.format(bill.nextDueDate),
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              SizedBox(width: 16.w),
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
                Text('Auto-pay', style: TextStyle(color: const Color(0xFF10B981), fontSize: 12)),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onMarkPaid,
                  icon: const Icon(Icons.check_circle_outline, size: 16),
                  label: const Text('Mark Paid'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF10B981),
                    side: const BorderSide(color: Color(0xFF10B981)),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 18),
                color: Colors.grey[400],
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline, size: 18),
                color: Colors.grey[400],
              ),
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

/// Recurring Bill Model
class RecurringBill {
  final String id;
  final String name;
  final double amount;
  final String currency;
  final String category;
  final String recurrencePattern;
  final DateTime nextDueDate;
  final int daysUntilDue;
  final String? icon;
  final bool autoPayEnabled;
  final String? merchant;

  RecurringBill({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.category,
    required this.recurrencePattern,
    required this.nextDueDate,
    required this.daysUntilDue,
    this.icon,
    required this.autoPayEnabled,
    this.merchant,
  });
}
