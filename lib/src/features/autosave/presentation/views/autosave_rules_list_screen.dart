import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:lazervault/src/features/autosave/presentation/views/create_autosave_rule_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_analytics_card.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_filter_tabs.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_list_shimmer.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_search_bar.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_sort_dropdown.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_swipeable_card.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/bulk_action_bottom_bar.dart';

class AutoSaveRulesListScreen extends StatefulWidget {
  const AutoSaveRulesListScreen({super.key});

  @override
  State<AutoSaveRulesListScreen> createState() =>
      _AutoSaveRulesListScreenState();
}

class _AutoSaveRulesListScreenState extends State<AutoSaveRulesListScreen> {
  AutoSaveStatus? _selectedFilter;
  RuleSortOption _selectedSort = RuleSortOption.dateCreatedDesc;
  bool _selectionMode = false;
  Set<String> _selectedRuleIds = {};

  @override
  void initState() {
    super.initState();
    context.read<AutoSaveCubit>().getRulesWithCache();
  }

  void _toggleSelectionMode(String? ruleId) {
    setState(() {
      _selectionMode = !_selectionMode;
      if (_selectionMode && ruleId != null) {
        _selectedRuleIds.add(ruleId);
      } else {
        _selectedRuleIds.clear();
      }
    });
  }

  void _selectAll(List<AutoSaveRuleEntity> rules) {
    setState(() {
      _selectedRuleIds = rules.map((r) => r.id).toSet();
    });
  }

  Future<void> _handleRefresh() async {
    await context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
  }

  void _navigateToDetails(AutoSaveRuleEntity rule) {
    Get.toNamed(
      AppRoutes.autoSaveDetails,
      arguments: rule,
    )?.then((_) {
      context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
    });
  }

  void _navigateToEdit(AutoSaveRuleEntity rule) {
    // TODO: Navigate to edit screen when created
    Get.snackbar(
      'Edit',
      'Edit screen will be available soon',
      backgroundColor: const Color(0xFF3B82F6),
      colorText: Colors.white,
    );
  }

  void _toggleRule(AutoSaveRuleEntity rule) {
    final action = rule.isActive ? 'pause' : 'resume';
    context.read<AutoSaveCubit>().toggleRuleOptimistic(
          ruleId: rule.id,
          action: action,
        );
  }

  void _deleteRule(AutoSaveRuleEntity rule) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        title: Text(
          'Delete Rule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${rule.name}"? This action cannot be undone.',
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
              context.read<AutoSaveCubit>().deleteRule(ruleId: rule.id);
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

  void _bulkPause() {
    context.read<AutoSaveCubit>().bulkPause(_selectedRuleIds.toList());
  }

  void _bulkResume() {
    context.read<AutoSaveCubit>().bulkResume(_selectedRuleIds.toList());
  }

  void _bulkDelete() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        title: Text(
          'Delete ${_selectedRuleIds.length} Rules',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${_selectedRuleIds.length} selected rules? This action cannot be undone.',
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
              context.read<AutoSaveCubit>().bulkDelete(_selectedRuleIds.toList());
              Navigator.pop(dialogContext);
            },
            child: Text(
              'Delete All',
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

  Map<AutoSaveStatus, int> _calculateStatusCounts(
      List<AutoSaveRuleEntity> rules) {
    final counts = <AutoSaveStatus, int>{};
    for (final rule in rules) {
      counts[rule.status] = (counts[rule.status] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: BlocConsumer<AutoSaveCubit, AutoSaveState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          if (state is AutoSaveRulesLoadingState &&
              state.cachedRules.isEmpty) {
            return const AutoSaveListShimmer();
          }

          if (state is AutoSaveRulesLoadedState) {
            return _buildContent(state);
          }

          if (state is AutoSaveError) {
            return _buildErrorState(state.message);
          }

          return _buildEmptyState();
        },
      ),
      floatingActionButton: !_selectionMode ? _buildFAB() : null,
      bottomNavigationBar: _selectionMode ? _buildBulkActionsBar() : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0A0A0A),
      elevation: 0,
      title: Text(
        _selectionMode
            ? '${_selectedRuleIds.length} Selected'
            : 'Auto-Save Rules',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          _selectionMode ? Icons.close : Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: _selectionMode
            ? () => _toggleSelectionMode(null)
            : () => Navigator.pop(context),
      ),
      actions: _selectionMode
          ? [
              TextButton(
                onPressed: () {
                  final state = context.read<AutoSaveCubit>().state;
                  if (state is AutoSaveRulesLoadedState) {
                    _selectAll(state.rules);
                  }
                },
                child: Text(
                  'Select All',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 78, 3, 208),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  Widget _buildContent(AutoSaveRulesLoadedState state) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: AutoSaveSearchBar(
            initialQuery: state.appliedSearch,
            onSearchChanged: (query) {
              context.read<AutoSaveCubit>().searchRules(query);
            },
          ),
        ),

        // Filter tabs
        AutoSaveFilterTabs(
          selectedStatus: state.appliedFilter,
          onStatusChanged: (status) {
            setState(() => _selectedFilter = status);
            context.read<AutoSaveCubit>().filterRules(status);
          },
          counts: _calculateStatusCounts(state.rules),
        ),

        SizedBox(height: 8.h),

        // Sort dropdown and count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.rules.length} rules',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              AutoSaveSortDropdown(
                selectedOption: state.appliedSort ?? _selectedSort,
                onChanged: (option) {
                  setState(() => _selectedSort = option);
                  context.read<AutoSaveCubit>().sortRules(option);
                },
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        // Analytics card (only show when not in selection mode and has rules)
        if (!_selectionMode && state.rules.isNotEmpty)
          AutoSaveAnalyticsCard(rules: state.rules),

        // Rules list
        Expanded(
          child: state.rules.isEmpty
              ? _buildEmptyStateForFilter(state.appliedFilter)
              : RefreshIndicator(
                  onRefresh: _handleRefresh,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: state.rules.length,
                    itemBuilder: (context, index) {
                      final rule = state.rules[index];
                      final accountName =
                          state.accountNames[rule.destinationAccountId];

                      return AutoSaveSwipeableCard(
                        rule: rule,
                        accountName: accountName,
                        isSelected: _selectedRuleIds.contains(rule.id),
                        selectionMode: _selectionMode,
                        onTap: () => _navigateToDetails(rule),
                        onEdit: () => _navigateToEdit(rule),
                        onToggle: () => _toggleRule(rule),
                        onDelete: () => _deleteRule(rule),
                        onSelectionChanged: (selected) {
                          setState(() {
                            if (selected == true) {
                              if (!_selectionMode) {
                                _toggleSelectionMode(rule.id);
                              } else {
                                _selectedRuleIds.add(rule.id);
                              }
                            } else {
                              _selectedRuleIds.remove(rule.id);
                              if (_selectedRuleIds.isEmpty) {
                                _selectionMode = false;
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildBulkActionsBar() {
    return BulkActionBottomBar(
      selectedCount: _selectedRuleIds.length,
      onPause: _bulkPause,
      onResume: _bulkResume,
      onDelete: _bulkDelete,
      onCancel: () => _toggleSelectionMode(null),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<AutoSaveCubit>(),
              child: const CreateAutoSaveRuleScreen(),
            ),
          ),
        ).then((_) => context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true));
      },
      backgroundColor: const Color.fromARGB(255, 78, 3, 208),
      child: const Icon(Icons.add, color: Colors.white),
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
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AutoSaveCubit>(),
                    child: const CreateAutoSaveRuleScreen(),
                  ),
                ),
              ).then((_) => context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true));
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Rule'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateForFilter(AutoSaveStatus? filter) {
    final filterName = filter == null
        ? 'matching your search'
        : filter.toString().split('.').last;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 16.h),
          Text(
            'No $filterName rules found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            filter != null
                ? 'Try selecting a different filter'
                : 'Try adjusting your search',
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

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(height: 16.h),
          Text(
            'Error',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  void _handleStateChanges(BuildContext context, AutoSaveState state) {
    if (state is AutoSaveRuleToggleSuccess) {
      Get.snackbar(
        'Success',
        state.rule.isActive ? 'Rule resumed successfully' : 'Rule paused successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else if (state is AutoSaveRuleDeleted) {
      Get.snackbar(
        'Success',
        'Rule deleted successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
    } else if (state is AutoSaveBulkOperationSuccess) {
      _toggleSelectionMode(null);
      final operation = state.operation.toString().split('.').last;
      Get.snackbar(
        'Success',
        '${state.affectedCount} rules ${operation}d successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else if (state is AutoSaveError) {
      Get.snackbar(
        'Error',
        state.message,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    }
  }
}
