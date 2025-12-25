import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:lazervault/src/features/autosave/presentation/views/create_autosave_rule_screen.dart';

class AutoSaveRulesListScreen extends StatefulWidget {
  const AutoSaveRulesListScreen({Key? key}) : super(key: key);

  @override
  State<AutoSaveRulesListScreen> createState() => _AutoSaveRulesListScreenState();
}

class _AutoSaveRulesListScreenState extends State<AutoSaveRulesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AutoSaveCubit>().getRules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Text(
          'Auto-Save Rules',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AutoSaveCubit, AutoSaveState>(
        listener: (context, state) {
          if (state is AutoSaveError) {
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
            context.read<AutoSaveCubit>().getRules();
          }
        },
        builder: (context, state) {
          if (state is AutoSaveLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color.fromARGB(255, 78, 3, 208)),
            );
          }

          if (state is AutoSaveRulesLoaded) {
            if (state.rules.isEmpty) {
              return _buildEmptyState();
            }
            return _buildRulesList(state.rules);
          }

          return _buildEmptyState();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<AutoSaveCubit>(),
                child: const CreateAutoSaveRuleScreen(),
              ),
            ),
          ).then((_) => context.read<AutoSaveCubit>().getRules());
        },
        backgroundColor: const Color.fromARGB(255, 78, 3, 208),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.savings_outlined,
            size: 64.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Auto-Save Rules',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create your first rule to start saving automatically',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRulesList(List<AutoSaveRuleEntity> rules) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final rule = rules[index];
        return _buildRuleCard(rule);
      },
    );
  }

  Widget _buildRuleCard(AutoSaveRuleEntity rule) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: rule.isActive ? const Color.fromARGB(255, 78, 3, 208) : const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            Get.toNamed(
              AppRoutes.autoSaveDetails,
              arguments: rule,
            )?.then((_) {
              // Refresh rules list when coming back from details
              context.read<AutoSaveCubit>().getRules();
            });
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
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
                    ),
                  ],
                ),
              ),
              Container(
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
          ),
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
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Delete Rule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this auto-save rule?',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AutoSaveCubit>().deleteRule(ruleId: ruleId);
              Navigator.pop(dialogContext);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
