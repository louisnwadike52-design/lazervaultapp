import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_statistics_card.dart';

class AutoSaveDashboardScreen extends StatefulWidget {
  const AutoSaveDashboardScreen({super.key});

  @override
  State<AutoSaveDashboardScreen> createState() => _AutoSaveDashboardScreenState();
}

class _AutoSaveDashboardScreenState extends State<AutoSaveDashboardScreen> {
  AutoSaveStatisticsEntity? _statistics;
  List<AutoSaveRuleEntity> _rules = [];
  bool _isLoadingStatistics = true;
  bool _isLoadingRules = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoadingStatistics = true;
      _isLoadingRules = true;
    });

    // Load statistics
    context.read<AutoSaveCubit>().getStatistics();

    // Load active rules
    context.read<AutoSaveCubit>().getRules(status: AutoSaveStatus.active);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Auto-Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Automate your savings goals',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AutoSaveCubit, AutoSaveState>(
        listener: (context, state) {
          if (state is AutoSaveStatisticsLoaded) {
            setState(() {
              _statistics = state.statistics;
              _isLoadingStatistics = false;
            });
          } else if (state is AutoSaveRulesLoaded) {
            setState(() {
              _rules = state.rules;
              _isLoadingRules = false;
            });
          } else if (state is AutoSaveError) {
            setState(() {
              _isLoadingStatistics = false;
              _isLoadingRules = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AutoSaveRuleDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Rule deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            _loadDashboardData();
          }
        },
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          color: const Color.fromARGB(255, 78, 3, 208),
          backgroundColor: const Color(0xFF1F1F1F),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Statistics Card
                if (_isLoadingStatistics)
                  _buildLoadingCard()
                else if (_statistics != null)
                  AutoSaveStatisticsCard(statistics: _statistics!),

                SizedBox(height: 20.h),

                // Quick Actions
                _buildQuickActions(),

                SizedBox(height: 24.h),

                // Active Rules Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active Rules',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (_rules.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          // Navigate to all rules screen
                          // For now, we could navigate to the existing rules list screen
                          // or create a dedicated "all rules" screen
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 78, 3, 208),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Rules List or Empty State
                if (_isLoadingRules)
                  _buildLoadingCard()
                else if (_rules.isEmpty)
                  _buildEmptyRulesState()
                else
                  ..._rules.take(5).map((rule) => _buildRuleCard(rule)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Color.fromARGB(255, 78, 3, 208)),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            label: 'Create Rule',
            icon: Icons.add_circle_outline,
            color: const Color.fromARGB(255, 78, 3, 208),
            onTap: () {
              Get.toNamed(AppRoutes.createAutoSaveRule);
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            label: 'Transactions',
            icon: Icons.receipt_long_outlined,
            color: const Color(0xFF10B981),
            onTap: () {
              Get.toNamed(AppRoutes.autoSaveTransactions);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyRulesState() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 40.h),
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 48.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(height: 12.h),
            Text(
              'No Active Rules',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Create your first rule to start\nsaving automatically',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.createAutoSaveRule);
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Rule'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(AutoSaveRuleEntity rule) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: rule.isActive ? const Color.fromARGB(255, 78, 3, 208) : const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rule.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
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
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(rule.status).withValues(alpha: 0.1),
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
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildInfoChip(Icons.repeat, rule.triggerDescription),
              SizedBox(width: 8.w),
              _buildInfoChip(Icons.attach_money, rule.amountDescription),
            ],
          ),
          if (rule.targetAmount != null) ...[
            SizedBox(height: 12.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      '\$${rule.totalSaved.toStringAsFixed(2)} / \$${rule.targetAmount!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: rule.progressPercentage / 100,
                    backgroundColor: const Color(0xFF2D2D2D),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 78, 3, 208)),
                    minHeight: 6.h,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  final action = rule.isActive ? 'pause' : 'resume';
                  context.read<AutoSaveCubit>().toggleRule(
                        ruleId: rule.id,
                        action: action,
                      );
                },
                icon: Icon(
                  rule.isActive ? Icons.pause : Icons.play_arrow,
                  size: 16.sp,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
                label: Text(
                  rule.isActive ? 'Pause' : 'Resume',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 78, 3, 208),
                    fontSize: 12.sp,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  _showDeleteDialog(rule.id);
                },
                icon: Icon(
                  Icons.delete_outline,
                  size: 16.sp,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
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

  void _showDeleteDialog(String ruleId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: const Text(
            'Delete Rule',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to delete this auto-save rule? This action cannot be undone.',
            style: TextStyle(color: Color(0xFF9CA3AF)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<AutoSaveCubit>().deleteRule(ruleId: ruleId);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
