import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/presentation/cubit/subscription_tracker_cubit.dart';
import 'package:lazervault/src/features/subscriptions/presentation/cubit/subscription_tracker_state.dart';
import 'package:lazervault/src/features/subscriptions/presentation/widgets/subscription_list_tile.dart';
import 'package:lazervault/src/features/subscriptions/presentation/widgets/subscription_spending_chart.dart';
import 'package:lazervault/src/features/subscriptions/presentation/widgets/subscription_summary_card.dart';
import 'package:lazervault/src/features/subscriptions/presentation/widgets/subscription_type_pie_chart.dart';

/// Main subscription tracker dashboard screen.
class SubscriptionDashboardScreen extends StatelessWidget {
  const SubscriptionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SubscriptionTrackerCubit>()..loadDashboard(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  String? _selectedType;
  bool _spendingExpanded = false;
  bool _pieExpanded = false;

  static const _filterTypes = [
    null,
    'data',
    'cable_tv',
    'internet',
    'electricity',
    'airtime',
  ];

  static const _filterLabels = [
    'All',
    'Data',
    'Cable TV',
    'Internet',
    'Electricity',
    'Airtime',
  ];

  void _onFilterTap(String? type) {
    if (type == _selectedType) return;
    setState(() => _selectedType = type);
    if (type == null) {
      context.read<SubscriptionTrackerCubit>().loadDashboard();
    } else {
      context.read<SubscriptionTrackerCubit>().loadByType(type);
    }
  }

  Future<void> _onRefresh() async {
    setState(() => _selectedType = null);
    await context.read<SubscriptionTrackerCubit>().refreshAll();
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
          'My Subscriptions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<SubscriptionTrackerCubit, SubscriptionTrackerState>(
          listener: (context, state) {
            if (state is SubscriptionTrackerError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SubscriptionTrackerLoading) {
              return const _LoadingView();
            }

            if (state is SubscriptionTrackerError) {
              return _ErrorView(
                message: state.message,
                onRetry: _onRefresh,
              );
            }

            if (state is SubscriptionDashboardLoaded) {
              return _buildDashboard(context, state);
            }

            // Initial state
            return const _LoadingView();
          },
        ),
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    SubscriptionDashboardLoaded state,
  ) {
    // Subscriptions are already filtered server-side by loadByType().
    // Summary card intentionally shows global totals for context.
    final filteredSubscriptions = state.subscriptions;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        children: [
          // Summary card
          SubscriptionSummaryCard(summary: state.summary),
          SizedBox(height: 16.h),

          // Filter chips
          _buildFilterChips(),
          SizedBox(height: 16.h),

          // Spending chart (expandable)
          _buildExpandableSection(
            title: 'Spending Trend',
            icon: Icons.trending_up,
            isExpanded: _spendingExpanded,
            onToggle: () => setState(() => _spendingExpanded = !_spendingExpanded),
            child: SubscriptionSpendingChart(spending: state.spending),
          ),
          SizedBox(height: 12.h),

          // Pie chart (expandable)
          _buildExpandableSection(
            title: 'By Category',
            icon: Icons.pie_chart_outline,
            isExpanded: _pieExpanded,
            onToggle: () => setState(() => _pieExpanded = !_pieExpanded),
            child: SubscriptionTypePieChart(byType: state.spending.byType),
          ),
          SizedBox(height: 16.h),

          // Subscriptions list header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subscriptions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${filteredSubscriptions.length} item${filteredSubscriptions.length == 1 ? '' : 's'}',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Subscription list
          if (filteredSubscriptions.isEmpty)
            _buildEmptyFilterState()
          else
            ...filteredSubscriptions.map(
              (sub) => SubscriptionListTile(
                subscription: sub,
                onTap: () => _navigateToDetail(sub),
              ),
            ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterTypes.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final type = _filterTypes[index];
          final label = _filterLabels[index];
          final isSelected = _selectedType == type;

          return GestureDetector(
            onTap: () => _onFilterTap(type),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(18.r),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFF2D2D2D)),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: isExpanded
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    )
                  : BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF3B82F6), size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) child,
      ],
    );
  }

  Widget _buildEmptyFilterState() {
    return Container(
      padding: EdgeInsets.all(32.w),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              color: const Color(0xFF9CA3AF),
              size: 40.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'No subscriptions found for this category',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(ActiveSubscriptionEntity subscription) {
    Get.toNamed(
      AppRoutes.subscriptionDetail,
      arguments: subscription,
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF3B82F6)),
          SizedBox(height: 16),
          Text(
            'Loading subscriptions...',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: const Color(0xFFEF4444),
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
