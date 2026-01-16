import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

class AutoSaveSwipeableCard extends StatelessWidget {
  final AutoSaveRuleEntity rule;
  final String? accountName; // Resolved account name
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final bool isSelected;
  final bool selectionMode;
  final Function(bool?)? onSelectionChanged;

  const AutoSaveSwipeableCard({
    super.key,
    required this.rule,
    this.accountName,
    required this.onTap,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
    this.isSelected = false,
    this.selectionMode = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(rule.id),
      enabled: !selectionMode,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
          ),
          SlidableAction(
            onPressed: (_) => onToggle(),
            backgroundColor: rule.isActive
                ? const Color(0xFFF59E0B)
                : const Color(0xFF10B981),
            foregroundColor: Colors.white,
            icon: rule.isActive ? Icons.pause : Icons.play_arrow,
            label: rule.isActive ? 'Pause' : 'Resume',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: const Color(0xFFEF4444),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 78, 3, 208)
                : (rule.isActive
                    ? const Color.fromARGB(255, 78, 3, 208)
                    : const Color(0xFF2D2D2D)),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: selectionMode
                ? () => onSelectionChanged?.call(!isSelected)
                : onTap,
            onLongPress: !selectionMode
                ? () => onSelectionChanged?.call(true)
                : null,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  if (selectionMode)
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Checkbox(
                        value: isSelected,
                        onChanged: onSelectionChanged,
                        activeColor: const Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                rule.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _buildStatusBadge(),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          rule.description,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            _buildInfoChip(
                                Icons.repeat, rule.triggerDescription),
                            SizedBox(width: 8.w),
                            _buildInfoChip(
                                Icons.attach_money, rule.amountDescription),
                          ],
                        ),
                        if (accountName != null) ...[
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet,
                                  size: 12.sp, color: const Color(0xFF9CA3AF)),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  'To: $accountName',
                                  style: TextStyle(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 10.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (rule.targetAmount != null) ...[
                          SizedBox(height: 12.h),
                          _buildProgressIndicator(),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _getStatusColor(rule.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _getStatusText(rule.status),
        style: TextStyle(
          color: _getStatusColor(rule.status),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
            Text(
              '\$${rule.totalSaved.toStringAsFixed(2)} / \$${rule.targetAmount!.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: rule.progressPercentage / 100,
            backgroundColor: const Color(0xFF2D2D2D),
            valueColor: const AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 78, 3, 208)),
            minHeight: 4.h,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return Colors.green;
      case AutoSaveStatus.paused:
        return Colors.orange;
      case AutoSaveStatus.completed:
        return Colors.blue;
      case AutoSaveStatus.cancelled:
        return Colors.red;
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _getStatusText(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return 'ACTIVE';
      case AutoSaveStatus.paused:
        return 'PAUSED';
      case AutoSaveStatus.completed:
        return 'COMPLETED';
      case AutoSaveStatus.cancelled:
        return 'CANCELLED';
      default:
        return 'UNKNOWN';
    }
  }
}
