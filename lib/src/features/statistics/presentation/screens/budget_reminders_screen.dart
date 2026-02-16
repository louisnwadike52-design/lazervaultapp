import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

/// Budget Reminders Screen
/// Displays budget alerts from the backend (threshold reached, budget exceeded, etc.)
class BudgetRemindersScreen extends StatefulWidget {
  const BudgetRemindersScreen({super.key});

  @override
  State<BudgetRemindersScreen> createState() => _BudgetRemindersScreenState();
}

class _BudgetRemindersScreenState extends State<BudgetRemindersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetCubit>().loadBudgetAlerts();
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
          'Budget Alerts',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<BudgetCubit, BudgetState>(
            builder: (context, state) {
              if (state is BudgetAlertsLoaded && state.unreadCount > 0) {
                return TextButton(
                  onPressed: () => context.read<BudgetCubit>().loadBudgetAlerts(unreadOnly: true),
                  child: Text(
                    'Unread (${state.unreadCount})',
                    style: const TextStyle(color: Color(0xFF10B981), fontSize: 14),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
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
          if (state is AlertMarkedRead) {
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

          if (state is BudgetAlertsLoaded) {
            if (state.alerts.isEmpty) {
              return _buildEmptyState();
            }
            return RefreshIndicator(
              onRefresh: () => context.read<BudgetCubit>().loadBudgetAlerts(),
              color: const Color(0xFF10B981),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(16.w),
                itemCount: state.alerts.length,
                itemBuilder: (context, index) {
                  return _AlertCard(
                    alert: state.alerts[index],
                    onMarkRead: () {
                      context.read<BudgetCubit>().markAlertAsRead(state.alerts[index].id);
                    },
                  );
                },
              ),
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

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 200.h),
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
                child: Icon(Icons.notifications_none, color: const Color(0xFF10B981).withValues(alpha: 0.5), size: 40.r),
              ),
              SizedBox(height: 16.h),
              Text(
                'No alerts',
                style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Budget alerts will appear here when\nyou approach or exceed your limits',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                textAlign: TextAlign.center,
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
            onPressed: () => context.read<BudgetCubit>().loadBudgetAlerts(),
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
}

class _AlertCard extends StatelessWidget {
  final pb.BudgetAlertMessage alert;
  final VoidCallback onMarkRead;

  const _AlertCard({
    required this.alert,
    required this.onMarkRead,
  });

  @override
  Widget build(BuildContext context) {
    final alertColor = _getAlertColor(alert.alertType);
    final alertIcon = _getAlertIcon(alert.alertType);
    final alertLabel = _getAlertLabel(alert.alertType);

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
          color: alert.isRead ? const Color(0xFF2D2D2D) : alertColor.withValues(alpha: 0.3),
          width: alert.isRead ? 1 : 2,
        ),
        boxShadow: alert.isRead ? null : [
          BoxShadow(
            color: alertColor.withValues(alpha: 0.1),
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
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: alertColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(alertIcon, color: alertColor, size: 20.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.budgetName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: alertColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        alertLabel,
                        style: TextStyle(color: alertColor, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              if (!alert.isRead)
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: alertColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            alert.message,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _MiniStat(
                      label: 'Spent',
                      value: CurrencySymbols.formatAmount(alert.currentSpent),
                    ),
                    SizedBox(width: 16.w),
                    _MiniStat(
                      label: 'Budget',
                      value: CurrencySymbols.formatAmount(alert.budgetLimit),
                    ),
                    SizedBox(width: 16.w),
                    _MiniStat(
                      label: 'Used',
                      value: '${alert.percentageUsed.toStringAsFixed(0)}%',
                      valueColor: alertColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!alert.isRead) ...[
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onMarkRead,
                icon: const Icon(Icons.check, size: 16),
                label: const Text('Mark as read'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF10B981),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getAlertColor(pb.AlertType type) {
    switch (type) {
      case pb.AlertType.ALERT_TYPE_BUDGET_EXCEEDED:
        return const Color(0xFFEF4444);
      case pb.AlertType.ALERT_TYPE_THRESHOLD_REACHED:
        return const Color(0xFFF59E0B);
      case pb.AlertType.ALERT_TYPE_APPROACHING_LIMIT:
        return const Color(0xFFFB923C);
      case pb.AlertType.ALERT_TYPE_RECURRING_EXPENSE_DUE:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  IconData _getAlertIcon(pb.AlertType type) {
    switch (type) {
      case pb.AlertType.ALERT_TYPE_BUDGET_EXCEEDED:
        return Icons.error;
      case pb.AlertType.ALERT_TYPE_THRESHOLD_REACHED:
        return Icons.warning;
      case pb.AlertType.ALERT_TYPE_APPROACHING_LIMIT:
        return Icons.trending_up;
      case pb.AlertType.ALERT_TYPE_RECURRING_EXPENSE_DUE:
        return Icons.schedule;
      default:
        return Icons.notifications;
    }
  }

  String _getAlertLabel(pb.AlertType type) {
    switch (type) {
      case pb.AlertType.ALERT_TYPE_BUDGET_EXCEEDED:
        return 'Budget Exceeded';
      case pb.AlertType.ALERT_TYPE_THRESHOLD_REACHED:
        return 'Threshold Reached';
      case pb.AlertType.ALERT_TYPE_APPROACHING_LIMIT:
        return 'Approaching Limit';
      case pb.AlertType.ALERT_TYPE_RECURRING_EXPENSE_DUE:
        return 'Expense Due';
      default:
        return 'Alert';
    }
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _MiniStat({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 11.sp)),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
