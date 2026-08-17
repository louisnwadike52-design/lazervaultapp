part of 'recurring_bills_screen.dart';

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
