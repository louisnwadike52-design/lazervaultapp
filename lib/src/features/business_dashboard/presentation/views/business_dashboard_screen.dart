import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/business_dashboard_cubit.dart';
import '../cubit/business_dashboard_state.dart';
import '../widgets/revenue_overview_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/recent_business_transactions.dart';
import '../widgets/payroll_summary_widget.dart';
import '../widgets/pending_invoices_card.dart';
import '../widgets/period_selector_chip.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({super.key});

  @override
  State<BusinessDashboardScreen> createState() =>
      _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen> {
  @override
  void initState() {
    super.initState();
    final accountManager = serviceLocator<AccountManager>();
    final cubit = context.read<BusinessDashboardCubit>();
    final accountId = accountManager.activeAccountId;
    if (accountId != null) {
      cubit.setAccountId(accountId);
      cubit.loadDashboard();
    }
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
          'Business Hub',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: MicroserviceChatIcon(
              serviceName: 'Business',
              sourceContext: 'accounts',
            ),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.businessAnalytics),
            icon: Icon(
              Icons.analytics_rounded,
              color: const Color(0xFF3B82F6),
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: BlocBuilder<BusinessDashboardCubit, BusinessDashboardState>(
        builder: (context, state) {
          return switch (state) {
            BusinessDashboardLoading() => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3B82F6),
                ),
              ),
            BusinessDashboardLoaded() => RefreshIndicator(
                onRefresh: () =>
                    context.read<BusinessDashboardCubit>().refresh(),
                color: const Color(0xFF3B82F6),
                backgroundColor: const Color(0xFF1F1F1F),
                child: _buildContent(state),
              ),
            BusinessDashboardError(message: var msg) => _buildError(msg),
            _ => _buildEmpty(),
          };
        },
      ),
    );
  }

  Widget _buildContent(BusinessDashboardLoaded state) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      children: [
        // Period Selector
        PeriodSelectorChip(
          selectedPeriod: state.selectedPeriod,
          onPeriodChanged: (period) =>
              context.read<BusinessDashboardCubit>().changePeriod(period),
        ),
        SizedBox(height: 16.h),

        // Revenue Overview Cards
        RevenueOverviewCard(
          totalRevenue: state.summary.totalRevenue,
          totalExpenses: state.summary.totalExpenses,
          netProfit: state.summary.netProfit,
          currency: state.summary.currency,
        ),
        SizedBox(height: 20.h),

        // Quick Actions
        const QuickActionsGrid(),
        SizedBox(height: 20.h),

        // Payroll Summary
        PayrollSummaryWidget(
          totalEmployees: state.summary.totalEmployees,
          lastPayRunTotal: state.summary.lastPayRunTotal,
          lastPayRunDate: state.summary.lastPayRunDate,
          currency: state.summary.currency,
        ),
        SizedBox(height: 16.h),

        // Pending Invoices
        PendingInvoicesCard(
          pendingCount: state.summary.pendingInvoices,
          overdueCount: state.summary.overdueInvoices,
        ),
        SizedBox(height: 20.h),

        // Recent Transactions
        RecentBusinessTransactions(
          transactions: state.recentTransactions,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load dashboard',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () =>
                  context.read<BusinessDashboardCubit>().refresh(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business_rounded,
            size: 48.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            'Select a business account to get started',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
