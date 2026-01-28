import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class AutoSaveRuleDetailsScreen extends StatefulWidget {
  const AutoSaveRuleDetailsScreen({super.key});

  @override
  State<AutoSaveRuleDetailsScreen> createState() => _AutoSaveRuleDetailsScreenState();
}

class _AutoSaveRuleDetailsScreenState extends State<AutoSaveRuleDetailsScreen> {
  late AutoSaveRuleEntity rule;
  bool _isTogglingRule = false;
  bool _isDeletingRule = false;
  bool _isTriggeringRule = false;
  String? _sourceAccountName;
  String? _destinationAccountName;

  @override
  void initState() {
    super.initState();
    rule = Get.arguments as AutoSaveRuleEntity;
    _fetchAccountNames();
  }

  Future<void> _fetchAccountNames() async {
    // For now, use account type as name (can be enhanced later to fetch actual names)
    setState(() {
      _sourceAccountName = 'Account ${rule.sourceAccountId.substring(0, 8)}...';
      _destinationAccountName = 'Account ${rule.destinationAccountId.substring(0, 8)}...';
    });
  }

  void _showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    required Color confirmColor,
    required String confirmText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: TextButton.styleFrom(
                backgroundColor: confirmColor.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  confirmText,
                  style: GoogleFonts.inter(
                    color: confirmColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleRule() {
    final action = rule.isActive ? 'pause' : 'resume';
    final actionText = rule.isActive ? 'Pause' : 'Resume';

    _showConfirmationDialog(
      title: '$actionText Rule',
      message: rule.isActive
          ? 'Are you sure you want to pause this auto-save rule? No automatic savings will occur while paused.'
          : 'Are you sure you want to resume this auto-save rule? Automatic savings will restart immediately.',
      confirmColor: rule.isActive ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
      confirmText: actionText,
      onConfirm: () {
        setState(() => _isTogglingRule = true);
        context.read<AutoSaveCubit>().toggleRuleOptimistic(
          ruleId: rule.id,
          action: action,
        );
      },
    );
  }

  void _deleteRule() {
    _showConfirmationDialog(
      title: 'Delete Rule',
      message: 'Are you sure you want to delete this auto-save rule? This action cannot be undone. All transaction history will be preserved.',
      confirmColor: const Color(0xFFEF4444),
      confirmText: 'Delete',
      onConfirm: () {
        setState(() => _isDeletingRule = true);
        context.read<AutoSaveCubit>().deleteRule(ruleId: rule.id);
      },
    );
  }

  void _triggerManualSave() {
    _showConfirmationDialog(
      title: 'Trigger Manual Save',
      message: 'This will immediately execute a save based on this rule\'s settings. The amount will be transferred from your source account to your destination account.',
      confirmColor: const Color.fromARGB(255, 78, 3, 208),
      confirmText: 'Trigger Save',
      onConfirm: () {
        setState(() => _isTriggeringRule = true);
        context.read<AutoSaveCubit>().triggerSave(ruleId: rule.id);
      },
    );
  }

  void _duplicateRule() {
    // Navigate to create screen with pre-filled data
    Get.toNamed(
      AppRoutes.createAutoSaveRule,
      arguments: {'duplicateFrom': rule},
    )?.then((_) {
      if (!mounted) return;
      Navigator.pop(context);
    });
  }

  void _exportRule() {
    final details = '''
Auto-Save Rule Details

Name: ${rule.name}
Description: ${rule.description}
Status: ${_getStatusText(rule.status)}

Trigger: ${_getTriggerDescription()}
Amount: ${_getAmountDescription()}

Source Account: ${_sourceAccountName ?? rule.sourceAccountId}
Destination Account: ${_destinationAccountName ?? rule.destinationAccountId}

Total Saved: \$${rule.totalSaved.toStringAsFixed(2)}
Times Triggered: ${rule.triggerCount}
${rule.targetAmount != null ? 'Target: \$${rule.targetAmount!.toStringAsFixed(2)}' : ''}
${rule.minimumBalance != null ? 'Min Balance: \$${rule.minimumBalance!.toStringAsFixed(2)}' : ''}
${rule.maximumPerSave != null ? 'Max Per Save: \$${rule.maximumPerSave!.toStringAsFixed(2)}' : ''}

Created: ${DateFormat('MMM dd, yyyy').format(rule.createdAt)}
${rule.lastTriggeredAt != null ? 'Last Triggered: ${DateFormat('MMM dd, yyyy').format(rule.lastTriggeredAt!)}' : ''}
''';

    SharePlus.instance.share(ShareParams(text: details, subject: 'Auto-Save Rule: ${rule.name}'));
  }

  void _navigateToEdit() {
    Get.toNamed(
      AppRoutes.editAutoSaveRule,
      arguments: rule,
    )?.then((_) {
      if (!mounted) return;
      // Refresh data when returning from edit screen
      context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
    });
  }

  String _getStatusText(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return 'Active';
      case AutoSaveStatus.paused:
        return 'Paused';
      case AutoSaveStatus.completed:
        return 'Completed';
      case AutoSaveStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  void _viewTransactions() {
    Get.toNamed(
      AppRoutes.autoSaveTransactions,
      arguments: {'ruleId': rule.id, 'ruleName': rule.name},
    );
  }

  void _navigateBack() {
    Get.back();
  }

  String _getTriggerDescription() {
    switch (rule.triggerType) {
      case TriggerType.onDeposit:
        return 'On Deposit';
      case TriggerType.scheduled:
        final frequency = rule.frequency;
        switch (frequency) {
          case ScheduleFrequency.daily:
            return 'Daily at ${rule.scheduleTime ?? "N/A"}';
          case ScheduleFrequency.weekly:
            return 'Weekly on ${_getDayName(rule.scheduleDay)} at ${rule.scheduleTime ?? "N/A"}';
          case ScheduleFrequency.biweekly:
            return 'Bi-Weekly at ${rule.scheduleTime ?? "N/A"}';
          case ScheduleFrequency.monthly:
            return 'Monthly on day ${rule.scheduleDay ?? "N/A"} at ${rule.scheduleTime ?? "N/A"}';
          default:
            return 'Scheduled';
        }
      case TriggerType.roundUp:
        return 'Round Up to \$${rule.roundUpTo ?? 0}';
      default:
        return 'Unknown';
    }
  }

  String _getDayName(int? day) {
    if (day == null) return 'N/A';
    const days = ['', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return day >= 1 && day <= 7 ? days[day] : 'N/A';
  }

  String _getAmountDescription() {
    if (rule.amountType == AmountType.fixed) {
      return '\$${rule.amountValue.toStringAsFixed(2)}';
    } else {
      return '${rule.amountValue.toStringAsFixed(0)}% of deposit';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AutoSaveCubit, AutoSaveState>(
      listener: (context, state) {
        if (state is AutoSaveRuleToggleSuccess) {
          setState(() {
            _isTogglingRule = false;
            rule = state.rule;
          });

          Get.snackbar(
            'Success',
            rule.isActive ? 'Rule resumed successfully' : 'Rule paused successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        } else if (state is AutoSaveRuleUpdated) {
          setState(() {
            _isTogglingRule = false;
            rule = state.rule;
          });

          Get.snackbar(
            'Success',
            'Rule updated successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        } else if (state is AutoSaveRuleDeleted || state is AutoSaveRuleDeleteSuccess) {
          setState(() => _isDeletingRule = false);

          Get.snackbar(
            'Success',
            'Rule deleted successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );

          // Fixed: Just pop instead of clearing entire stack
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        } else if (state is AutoSaveTransactionTriggered) {
          setState(() => _isTriggeringRule = false);

          Get.snackbar(
            'Success',
            'Manual save triggered successfully for \$${state.transaction.amount.toStringAsFixed(2)}',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );

          // Refresh rule data to show updated totalSaved
          context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
        } else if (state is AutoSaveError) {
          setState(() {
            _isTogglingRule = false;
            _isDeletingRule = false;
            _isTriggeringRule = false;
          });

          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 4),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1F1F1F),
                const Color(0xFF0A0A0A),
                const Color(0xFF000000),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildStatusCard(),
                        SizedBox(height: 20.h),
                        _buildRuleInfoCard(),
                        SizedBox(height: 20.h),
                        _buildAccountsCard(),
                        SizedBox(height: 20.h),
                        _buildLimitsCard(),
                        SizedBox(height: 20.h),
                        _buildStatisticsCard(),
                        SizedBox(height: 20.h),
                        _buildActionsCard(),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          IconButton(
            onPressed: _navigateBack,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (rule.description.isNotEmpty)
                  Text(
                    rule.description,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          // Edit button
          IconButton(
            onPressed: _navigateToEdit,
            icon: Icon(
              Icons.edit,
              color: const Color.fromARGB(255, 78, 3, 208),
              size: 20.sp,
            ),
            tooltip: 'Edit Rule',
          ),
          // More options menu
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 20.sp),
            color: const Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            onSelected: (value) {
              if (value == 'duplicate') {
                _duplicateRule();
              } else if (value == 'export') {
                _exportRule();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 18.sp, color: Colors.white),
                    SizedBox(width: 12.w),
                    Text(
                      'Duplicate Rule',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 18.sp, color: Colors.white),
                    SizedBox(width: 12.w),
                    Text(
                      'Export Details',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    final statusColor = rule.isActive
        ? const Color(0xFF10B981)
        : rule.isPaused
            ? const Color(0xFFF59E0B)
            : const Color(0xFF6B7280);

    final statusText = rule.isActive
        ? 'Active'
        : rule.isPaused
            ? 'Paused'
            : rule.status.toString().split('.').last.toUpperCase();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
              boxShadow: [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Status: $statusText',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (rule.hasReachedGoal)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFF10B981),
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Goal Reached',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRuleInfoCard() {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Rule Information',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDetailRow('Rule ID', rule.id),
          SizedBox(height: 12.h),
          _buildDetailRow('Trigger Type', _getTriggerDescription()),
          SizedBox(height: 12.h),
          _buildDetailRow('Save Amount', _getAmountDescription()),
          SizedBox(height: 12.h),
          _buildDetailRow('Created', dateFormat.format(rule.createdAt)),
          if (rule.lastTriggeredAt != null) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Last Triggered', dateFormat.format(rule.lastTriggeredAt!)),
          ],
        ],
      ),
    );
  }

  Widget _buildAccountsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Accounts',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDetailRow('Source Account', _sourceAccountName ?? rule.sourceAccountId),
          SizedBox(height: 12.h),
          _buildDetailRow('Destination Account', _destinationAccountName ?? rule.destinationAccountId),
        ],
      ),
    );
  }

  Widget _buildLimitsCard() {
    final hasLimits = rule.targetAmount != null ||
        rule.minimumBalance != null ||
        rule.maximumPerSave != null;

    if (!hasLimits) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Goals & Limits',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          if (rule.targetAmount != null) ...[
            _buildDetailRow(
              'Target Amount',
              '\$${rule.targetAmount!.toStringAsFixed(2)}',
            ),
            SizedBox(height: 8.h),
            _buildProgressBar(),
            SizedBox(height: 12.h),
          ],
          if (rule.minimumBalance != null) ...[
            _buildDetailRow(
              'Minimum Balance',
              '\$${rule.minimumBalance!.toStringAsFixed(2)}',
            ),
            SizedBox(height: 12.h),
          ],
          if (rule.maximumPerSave != null)
            _buildDetailRow(
              'Maximum Per Save',
              '\$${rule.maximumPerSave!.toStringAsFixed(2)}',
            ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    if (rule.targetAmount == null || rule.targetAmount == 0) {
      return const SizedBox.shrink();
    }

    final progress = (rule.totalSaved / rule.targetAmount!).clamp(0.0, 1.0);
    final percentage = (progress * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${rule.totalSaved.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 78, 3, 208),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$percentage%',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 78, 3, 208),
                    Color.fromARGB(255, 98, 33, 224),
                  ],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Statistics',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Total Saved',
                  '\$${rule.totalSaved.toStringAsFixed(2)}',
                  Icons.savings_outlined,
                  const Color(0xFF10B981),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatItem(
                  'Times Triggered',
                  '${rule.triggerCount}',
                  Icons.replay,
                  const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    return Column(
      children: [
        // View Transactions Button
        _buildActionButton(
          label: 'View Transaction History',
          icon: Icons.history,
          color: const Color(0xFF3B82F6),
          onPressed: _viewTransactions,
        ),
        SizedBox(height: 12.h),

        // Trigger Manual Save Button
        if (rule.isActive)
          _buildActionButton(
            label: 'Trigger Manual Save',
            icon: Icons.play_circle_outline,
            color: const Color.fromARGB(255, 78, 3, 208),
            onPressed: (_isTogglingRule || _isDeletingRule || _isTriggeringRule) ? null : _triggerManualSave,
            isLoading: _isTriggeringRule,
          ),
        if (rule.isActive) SizedBox(height: 12.h),

        // Pause/Resume Button
        _buildActionButton(
          label: rule.isActive ? 'Pause Rule' : 'Resume Rule',
          icon: rule.isActive ? Icons.pause_circle_outline : Icons.play_circle_filled,
          color: rule.isActive ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
          onPressed: (_isTogglingRule || _isDeletingRule || _isTriggeringRule) ? null : _toggleRule,
          isLoading: _isTogglingRule,
        ),
        SizedBox(height: 12.h),

        // Delete Button
        _buildActionButton(
          label: 'Delete Rule',
          icon: Icons.delete_outline,
          color: const Color(0xFFEF4444),
          onPressed: (_isTogglingRule || _isDeletingRule || _isTriggeringRule) ? null : _deleteRule,
          isLoading: _isDeletingRule,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: onPressed == null
            ? const Color(0xFF2D2D2D)
            : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: onPressed == null
              ? const Color(0xFF2D2D2D)
              : color.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onPressed,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: onPressed == null ? Colors.grey[600] : color,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: onPressed == null ? Colors.grey[600] : color,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
