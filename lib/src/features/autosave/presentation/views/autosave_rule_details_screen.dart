import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/src/features/autosave/services/autosave_pdf_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class AutoSaveRuleDetailsScreen extends StatefulWidget {
  const AutoSaveRuleDetailsScreen({super.key});

  @override
  State<AutoSaveRuleDetailsScreen> createState() => _AutoSaveRuleDetailsScreenState();
}

class _AutoSaveRuleDetailsScreenState extends State<AutoSaveRuleDetailsScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

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
    // Look up real account names from AccountCardsSummaryCubit
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final source = accountState.accountSummaries.where(
        (a) => a.id.toString() == rule.sourceAccountId,
      );
      final dest = accountState.accountSummaries.where(
        (a) => a.id.toString() == rule.destinationAccountId,
      );
      setState(() {
        _sourceAccountName = source.isNotEmpty
            ? '${source.first.accountType} (****${source.first.accountNumberLast4})'
            : _truncateId(rule.sourceAccountId);
        _destinationAccountName = dest.isNotEmpty
            ? '${dest.first.accountType} (****${dest.first.accountNumberLast4})'
            : _truncateId(rule.destinationAccountId);
      });
    } else {
      setState(() {
        _sourceAccountName = _truncateId(rule.sourceAccountId);
        _destinationAccountName = _truncateId(rule.destinationAccountId);
      });
    }
  }

  String _truncateId(String id) {
    if (id.length >= 8) {
      return 'Account ${id.substring(0, 8)}...';
    }
    return 'Account $id';
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

  void _triggerManualSave() async {
    HapticFeedback.mediumImpact();

    final idPrefix = rule.id.length >= 8 ? rule.id.substring(0, 8) : rule.id;
    final transactionId = 'AUTOSAVE-$idPrefix';

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'autosave_trigger',
      amount: rule.amountValue,
      currency: rule.currency,
      title: 'Confirm Manual Save',
      message: 'Confirm manual auto-save trigger',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;

    setState(() => _isTriggeringRule = true);

    if (!mounted) return;
    context.read<AutoSaveCubit>().triggerSave(
      ruleId: rule.id,
      transactionPinToken: verificationToken!,
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

  Future<void> _exportRule() async {
    // Build a proper PDF (the previous text-only share leaked details
    // verbatim into the share intent and was hard to archive). The
    // service captures every rule field + the recent transactions
    // already loaded in state — same data the screen renders.
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(
      content: Row(
        children: [
          SizedBox(
            width: 16.w,
            height: 16.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(width: 12.w),
          const Text('Building PDF...'),
        ],
      ),
      duration: const Duration(seconds: 2),
    ));
    try {
      final file = await AutoSavePdfService.generateRuleDetails(
        rule: rule,
        sourceAccountLabel:
            _sourceAccountName ?? rule.sourceAccountId,
        destinationAccountLabel:
            _destinationAccountName ?? rule.destinationAccountId,
        triggerDescription: _getTriggerDescription(),
        amountDescription: _getAmountDescription(),
        // The detail screen doesn't currently page in transactions —
        // the All Rules screen owns that history. Skip the table when
        // we don't have the data; the PDF still surfaces every rule
        // field + lifetime aggregates.
        recentTransactions: const [],
      );
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: 'Auto-Save Rule: ${rule.name}',
          text: 'Auto-save rule report: ${rule.name}',
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(
        content: Text('Could not export PDF: $e'),
        backgroundColor: const Color(0xFFEF4444),
      ));
    }
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
    // Single canonical history surface — All Rules. Completed /
    // cancelled rules are filterable from the same screen, so a
    // dedicated transactions page would duplicate functionality.
    Get.toNamed(AppRoutes.autoSaveRulesList);
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
        return 'Round Up to ${currency_formatter.CurrencySymbols.formatAmountWithCurrency((rule.roundUpTo ?? 0).toDouble(), rule.currency)}';
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
      return currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.amountValue, rule.currency);
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
            'Manual save triggered successfully for ${state.transaction.formattedAmount}',
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

          // Map backend executor strings to user-friendly copy.
          // The autosave executor returns reasons verbatim ("debit
          // rejected: insufficient funds", "savings goal already
          // reached", etc.); these are clear to engineers but
          // unfriendly in a snackbar. Falls back to the raw message
          // for unmatched cases so we never swallow useful detail.
          final friendly = _humaniseAutosaveError(state.message);
          Get.snackbar(
            friendly.title,
            friendly.body,
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
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.targetAmount!, rule.currency),
            ),
            SizedBox(height: 8.h),
            _buildProgressBar(),
            SizedBox(height: 12.h),
          ],
          if (rule.minimumBalance != null) ...[
            _buildDetailRow(
              'Minimum Balance',
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.minimumBalance!, rule.currency),
            ),
            SizedBox(height: 12.h),
          ],
          if (rule.maximumPerSave != null)
            _buildDetailRow(
              'Maximum Per Save',
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.maximumPerSave!, rule.currency),
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
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.totalSaved, rule.currency),
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
                  currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.totalSaved, rule.currency),
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
    final busy = _isTogglingRule || _isDeletingRule || _isTriggeringRule;

    // Group the CTAs into rows of two so destructive / state-changing
    // actions sit side-by-side instead of stacking down the screen.
    // Manual Trigger only shows for active rules — when present we
    // pair it with Pause; otherwise Resume gets the lead slot.
    final pauseResume = _buildActionButton(
      label: rule.isActive ? 'Pause' : 'Resume',
      icon: rule.isActive
          ? Icons.pause_circle_outline
          : Icons.play_circle_filled,
      color: rule.isActive
          ? const Color(0xFFF59E0B)
          : const Color(0xFF10B981),
      onPressed: busy ? null : _toggleRule,
      isLoading: _isTogglingRule,
    );

    final triggerOrAllRules = rule.isActive
        ? _buildActionButton(
            label: 'Manual Save',
            icon: Icons.play_circle_outline,
            color: const Color.fromARGB(255, 78, 3, 208),
            onPressed: busy ? null : _triggerManualSave,
            isLoading: _isTriggeringRule,
          )
        : _buildActionButton(
            label: 'All Rules',
            icon: Icons.list_alt_outlined,
            color: const Color(0xFF3B82F6),
            onPressed: _viewTransactions,
          );

    final deleteButton = _buildActionButton(
      label: 'Delete',
      icon: Icons.delete_outline,
      color: const Color(0xFFEF4444),
      onPressed: busy ? null : _deleteRule,
      isLoading: _isDeletingRule,
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: triggerOrAllRules),
            SizedBox(width: 12.w),
            Expanded(child: pauseResume),
          ],
        ),
        SizedBox(height: 12.h),
        // For active rules row 1 already has Manual Save, so pair
        // All Rules + Delete on row 2. For inactive rules row 1
        // already had All Rules + Resume, so row 2 is full-width
        // Delete — keeping it stretched looks less awkward than a
        // half-empty pair.
        rule.isActive
            ? Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      label: 'All Rules',
                      icon: Icons.list_alt_outlined,
                      color: const Color(0xFF3B82F6),
                      onPressed: _viewTransactions,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(child: deleteButton),
                ],
              )
            : SizedBox(width: double.infinity, child: deleteButton),
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

/// Tiny pair returned by [_humaniseAutosaveError] — split-out so the
/// snackbar can show a strong title + softer detail line.
class _FriendlyError {
  final String title;
  final String body;
  const _FriendlyError(this.title, this.body);
}

/// Map verbatim backend executor messages onto user-friendly copy.
/// The executor itself returns short technical reasons ("debit
/// rejected: insufficient funds", "savings goal already reached",
/// "rule not active (status=paused)", etc.) — fine for engineers but
/// noisy in a snackbar. Unmatched messages fall through with a
/// neutral title + the raw text so we never swallow useful detail.
_FriendlyError _humaniseAutosaveError(String raw) {
  final m = raw.toLowerCase();
  if (m.contains('savings goal already reached') ||
      m.contains('target reached')) {
    return const _FriendlyError(
      'Goal already met',
      'This rule has already saved its full target amount.',
    );
  }
  if (m.contains('rule not active') || m.contains('status=paused') ||
      m.contains('status=cancelled') || m.contains('status=completed')) {
    return const _FriendlyError(
      'Rule not active',
      'Resume the rule first, then try again.',
    );
  }
  if (m.contains('insufficient') || m.contains('balance') &&
      m.contains('low')) {
    return const _FriendlyError(
      'Not enough balance',
      'Your source account doesn\'t have the funds for this save right now.',
    );
  }
  if (m.contains('debit rejected')) {
    return _FriendlyError(
      'Source account couldn\'t be debited',
      raw.replaceFirst(RegExp(r'^debit rejected:?\s*', caseSensitive: false), ''),
    );
  }
  if (m.contains('credit rejected')) {
    return _FriendlyError(
      'Destination account refused the credit',
      raw.replaceFirst(RegExp(r'^credit rejected:?\s*', caseSensitive: false), ''),
    );
  }
  if (m.contains('duplicate trigger in progress')) {
    return const _FriendlyError(
      'Already saving',
      'A save for this rule is already in flight. Hold on a moment.',
    );
  }
  if (m.contains('minimum') && m.contains('balance')) {
    return const _FriendlyError(
      'Below minimum balance',
      'Saving would take your account below its configured minimum balance.',
    );
  }
  if (m.contains('amount') && (m.contains('exceeds') || m.contains('cap'))) {
    return const _FriendlyError(
      'Above per-save cap',
      'The computed amount is over your configured maximum per save.',
    );
  }
  // Network / accounts-service unreachable — produced by the gRPC
  // client wrapper before the executor records anything.
  if (m.contains('unavailable') ||
      m.contains('deadline exceeded') ||
      m.contains('connection')) {
    return const _FriendlyError(
      'Network hiccup',
      'We couldn\'t reach the savings service. The reconciler will retry shortly.',
    );
  }
  return _FriendlyError('Couldn\'t save', raw);
}
