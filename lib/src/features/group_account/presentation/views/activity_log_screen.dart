import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class ActivityLogScreen extends StatefulWidget {
  final String groupId;
  final String? contributionId;
  final String title;

  const ActivityLogScreen({
    super.key,
    required this.groupId,
    this.contributionId,
    this.title = 'Activity Log',
  });

  @override
  State<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  String? _selectedFilter;
  final List<String> _filterOptions = [
    'All',
    'Members',
    'Payments',
    'Contributions',
    'Payouts',
    'Settings',
  ];

  List<ActivityLogEntry> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadActivityLogs();
  }

  void _loadActivityLogs() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<GroupAccountCubit>();
      if (widget.contributionId != null) {
        cubit.loadContributionActivityLogs(widget.contributionId!);
      } else {
        cubit.loadGroupActivityLogs(widget.groupId);
      }
    });
  }

  List<ActivityLogEntry> get _filteredLogs {
    if (_selectedFilter == null || _selectedFilter == 'All') {
      return _logs;
    }

    return _logs.where((log) {
      switch (_selectedFilter) {
        case 'Members':
          return ActivityActionType.memberActions.contains(log.actionType);
        case 'Payments':
          return ActivityActionType.paymentActions.contains(log.actionType);
        case 'Contributions':
          return ActivityActionType.contributionActions.contains(log.actionType);
        case 'Payouts':
          return ActivityActionType.payoutActions.contains(log.actionType);
        case 'Settings':
          return ActivityActionType.settingsActions.contains(log.actionType);
        default:
          return true;
      }
    }).toList();
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
        title: Text(
          widget.title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _loadActivityLogs,
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
          listener: (context, state) {
            if (state is GroupActivityLogsLoaded) {
              setState(() {
                _logs = state.logs;
              });
            } else if (state is ContributionActivityLogsLoaded) {
              setState(() {
                _logs = state.logs;
              });
            } else if (state is GroupAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildFilterChips(),
                Expanded(
                  child: state is ActivityLogsLoading
                      ? _buildLoadingState()
                      : _buildActivityList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading activity logs...',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final filter = _filterOptions[index];
          final isSelected = (_selectedFilter ?? 'All') == filter;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(
                filter,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = selected ? filter : 'All';
                });
              },
              backgroundColor: const Color(0xFF1F1F1F),
              selectedColor: const Color.fromARGB(255, 78, 3, 208),
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              side: BorderSide.none,
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityList() {
    final logs = _filteredLogs;

    if (logs.isEmpty) {
      return _buildEmptyState();
    }

    // Group logs by date
    final groupedLogs = <String, List<ActivityLogEntry>>{};
    for (final log in logs) {
      final dateKey = _getDateKey(log.createdAt);
      groupedLogs.putIfAbsent(dateKey, () => []);
      groupedLogs[dateKey]!.add(log);
    }

    return RefreshIndicator(
      onRefresh: () async => _loadActivityLogs(),
      color: const Color.fromARGB(255, 78, 3, 208),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: groupedLogs.length,
        itemBuilder: (context, index) {
          final dateKey = groupedLogs.keys.elementAt(index);
          final dayLogs = groupedLogs[dateKey]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  dateKey,
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...dayLogs.map((log) => _buildActivityItem(log)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActivityItem(ActivityLogEntry log) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionIcon(log.actionType),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getActionTitle(log),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _getActionDescription(log),
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: Colors.grey[500],
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      log.actorName,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.access_time,
                      color: Colors.grey[500],
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatTime(log.createdAt),
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(String actionType) {
    final iconData = _getActionIconData(actionType);
    final color = _getActionColor(actionType);

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 20.sp,
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 64.sp,
                color: Colors.grey[600],
              ),
              SizedBox(height: 16.h),
              Text(
                'No Activity Yet',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Activity will appear here as actions\nare taken in this group',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final logDate = DateTime(date.year, date.month, date.day);

    if (logDate == today) {
      return 'Today';
    } else if (logDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, yyyy').format(date);
    }
  }

  IconData _getActionIconData(String actionType) {
    switch (actionType) {
      case ActivityActionType.memberAdded:
      case ActivityActionType.memberInvited:
        return Icons.person_add;
      case ActivityActionType.memberRemoved:
        return Icons.person_remove;
      case ActivityActionType.memberRoleChanged:
        return Icons.admin_panel_settings;
      case ActivityActionType.paymentMade:
        return Icons.payment;
      case ActivityActionType.paymentFailed:
        return Icons.payment;
      case ActivityActionType.paymentRefunded:
        return Icons.replay;
      case ActivityActionType.contributionCreated:
        return Icons.add_circle;
      case ActivityActionType.contributionUpdated:
        return Icons.edit;
      case ActivityActionType.contributionDeleted:
        return Icons.delete;
      case ActivityActionType.contributionPaused:
        return Icons.pause_circle;
      case ActivityActionType.payoutProcessed:
        return Icons.account_balance_wallet;
      case ActivityActionType.payoutRotationAdvanced:
        return Icons.autorenew;
      case ActivityActionType.settingsChanged:
      case ActivityActionType.groupUpdated:
        return Icons.settings;
      case ActivityActionType.groupCreated:
        return Icons.group_add;
      default:
        return Icons.info;
    }
  }

  Color _getActionColor(String actionType) {
    switch (actionType) {
      case ActivityActionType.memberAdded:
      case ActivityActionType.memberInvited:
      case ActivityActionType.contributionCreated:
      case ActivityActionType.groupCreated:
        return const Color(0xFF10B981); // Green
      case ActivityActionType.memberRemoved:
      case ActivityActionType.contributionDeleted:
      case ActivityActionType.paymentFailed:
        return const Color(0xFFEF4444); // Red
      case ActivityActionType.paymentMade:
      case ActivityActionType.payoutProcessed:
        return const Color(0xFF3B82F6); // Blue
      case ActivityActionType.memberRoleChanged:
      case ActivityActionType.contributionUpdated:
      case ActivityActionType.settingsChanged:
      case ActivityActionType.groupUpdated:
        return const Color(0xFFFB923C); // Orange
      case ActivityActionType.paymentRefunded:
      case ActivityActionType.payoutRotationAdvanced:
        return const Color(0xFF8B5CF6); // Purple
      case ActivityActionType.contributionPaused:
        return const Color(0xFFF59E0B); // Amber
      default:
        return Colors.grey;
    }
  }

  String _getActionTitle(ActivityLogEntry log) {
    switch (log.actionType) {
      case ActivityActionType.memberAdded:
        return 'Member Added';
      case ActivityActionType.memberRemoved:
        return 'Member Removed';
      case ActivityActionType.memberRoleChanged:
        return 'Role Changed';
      case ActivityActionType.memberInvited:
        return 'Member Invited';
      case ActivityActionType.paymentMade:
        return 'Payment Made';
      case ActivityActionType.paymentFailed:
        return 'Payment Failed';
      case ActivityActionType.paymentRefunded:
        return 'Payment Refunded';
      case ActivityActionType.contributionCreated:
        return 'Contribution Created';
      case ActivityActionType.contributionUpdated:
        return 'Contribution Updated';
      case ActivityActionType.contributionDeleted:
        return 'Contribution Deleted';
      case ActivityActionType.contributionPaused:
        return 'Contribution Paused';
      case ActivityActionType.payoutProcessed:
        return 'Payout Processed';
      case ActivityActionType.payoutRotationAdvanced:
        return 'Rotation Advanced';
      case ActivityActionType.settingsChanged:
        return 'Settings Changed';
      case ActivityActionType.groupCreated:
        return 'Group Created';
      case ActivityActionType.groupUpdated:
        return 'Group Updated';
      default:
        return 'Activity';
    }
  }

  String _getActionDescription(ActivityLogEntry log) {
    final details = log.details ?? {};

    switch (log.actionType) {
      case ActivityActionType.memberAdded:
        return '${details['member_name'] ?? 'A member'} was added to the group';
      case ActivityActionType.memberRemoved:
        return '${details['member_name'] ?? 'A member'} was removed from the group';
      case ActivityActionType.memberRoleChanged:
        return '${details['member_name'] ?? 'Member'}\'s role changed to ${details['new_role'] ?? 'member'}';
      case ActivityActionType.memberInvited:
        return '${details['email'] ?? 'Someone'} was invited to join';
      case ActivityActionType.paymentMade:
        final amount = details['amount'] != null ? '\u20A6${NumberFormat('#,###').format(details['amount'])}' : '';
        return 'Paid $amount to ${details['contribution_title'] ?? 'contribution'}';
      case ActivityActionType.paymentFailed:
        return 'Payment attempt failed for ${details['contribution_title'] ?? 'contribution'}';
      case ActivityActionType.paymentRefunded:
        return 'Payment was refunded';
      case ActivityActionType.contributionCreated:
        return '"${details['title'] ?? 'Contribution'}" was created';
      case ActivityActionType.contributionUpdated:
        return '"${details['title'] ?? 'Contribution'}" was updated';
      case ActivityActionType.contributionDeleted:
        return '"${details['title'] ?? 'Contribution'}" was deleted';
      case ActivityActionType.contributionPaused:
        return '"${details['title'] ?? 'Contribution'}" was paused';
      case ActivityActionType.payoutProcessed:
        final amount = details['amount'] != null ? '\u20A6${NumberFormat('#,###').format(details['amount'])}' : '';
        return '$amount paid out to ${details['recipient'] ?? 'recipient'}';
      case ActivityActionType.payoutRotationAdvanced:
        return 'Payout rotation moved to next member';
      case ActivityActionType.settingsChanged:
        return '${details['setting'] ?? 'Setting'} was changed';
      case ActivityActionType.groupCreated:
        return 'Group was created';
      case ActivityActionType.groupUpdated:
        return 'Group details were updated';
      default:
        return 'Action performed';
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}
