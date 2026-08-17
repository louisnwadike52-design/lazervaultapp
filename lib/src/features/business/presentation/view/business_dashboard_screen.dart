import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import '../../data/services/business_overview_service.dart';
import '../../domain/entities/business_overview_entity.dart';
import '../cubit/business_dashboard_cubit.dart';
part 'business_dashboard_screen_widgets.dart';


/// The Lazavote Business dashboard — the hub shown behind the Business account
/// card. Combines the business account BALANCE (passed in from the accounts
/// carousel) with the aggregated overview (payroll/expenses/inventory/tax/
/// customers/revenue) and renders KPIs, fl_chart graphs, and quick actions.
class BusinessDashboardScreen extends StatelessWidget {
  const BusinessDashboardScreen({super.key});

  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _accent = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    // The Business account card (balance, NUBAN) — passed from the carousel
    // "Details" CTA. Null-safe: the dashboard still works without it.
    final args = Get.arguments;
    final AccountSummaryEntity? account =
        args is AccountSummaryEntity ? args : null;

    return BlocProvider(
      create: (_) => BusinessDashboardCubit(
        service: BusinessOverviewService(
          endpoints: endpointRegistry,
        ),
      )..load(),
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('Business',
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
          actions: [
            // Per-service voice + chat, pinned to the business hub agent
            // (DIRECT_ROUTES['business'] → chat-business-service). Same
            // pattern as the tax/crowdfund/etc. dashboards.
            ServiceVoiceButton(
              serviceName: 'business',
              iconColor: _accent,
              backgroundColor: _accent,
            ),
            SizedBox(width: 4.w),
            MicroserviceChatIcon(
              serviceName: 'Business',
              sourceContext: 'business',
              icon: Icons.chat_bubble_outline,
              iconColor: _accent,
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart_rounded, color: Colors.white),
              tooltip: 'Analytics',
              // Scope analytics to THIS business account (falls back to the
              // active account when opened without it).
              onPressed: () => Get.toNamed(AppRoutes.businessAnalytics,
                  arguments: account),
            ),
          ],
        ),
        body: BlocBuilder<BusinessDashboardCubit, BusinessDashboardState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: _accent,
              onRefresh: () => context.read<BusinessDashboardCubit>().load(),
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
                children: [
                  _balanceCard(account),
                  SizedBox(height: 16.h),
                  if (state is BusinessDashboardLoading)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: const Center(
                          child: CircularProgressIndicator(color: _accent)),
                    )
                  else if (state is BusinessDashboardError)
                    _errorBox(context, state.message)
                  else if (state is BusinessDashboardLoaded) ...[
                    _kpiGrid(state.overview),
                    SizedBox(height: 20.h),
                    _sectionTitle('Money in vs out'),
                    SizedBox(height: 10.h),
                    _barChartCard(state.overview),
                    SizedBox(height: 20.h),
                    _sectionTitle('Where money goes'),
                    SizedBox(height: 10.h),
                    _pieCard(state.overview),
                    SizedBox(height: 20.h),
                    _taxCard(state.overview),
                  ],
                  SizedBox(height: 20.h),
                  _sectionTitle('Quick actions'),
                  SizedBox(height: 10.h),
                  _quickActions(context, account),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _money(double v, String currency) =>
      '${_symbol(currency)}${NumberFormat('#,##0.00').format(v)}';

  String _symbol(String c) {
    switch (c.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      default:
        return '$c ';
    }
  }

  Widget _balanceCard(AccountSummaryEntity? account) {
    final currency = account?.currency ?? 'NGN';
    final balance = account?.availableBalance ?? account?.balance ?? 0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC2410C), Color(0xFF431407)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.business_center, color: Colors.white, size: 18.sp),
              SizedBox(width: 8.w),
              Text('Business Balance',
                  style: GoogleFonts.inter(
                      color: Colors.white70, fontSize: 13.sp, fontWeight: FontWeight.w600)),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                    color: Colors.white24, borderRadius: BorderRadius.circular(20.r)),
                child: Text('PRO',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(_money(balance, currency),
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.w800)),
          SizedBox(height: 8.h),
          if (account?.accountNumber != null && account!.accountNumber!.isNotEmpty)
            Text(
              '${account.bankName ?? ''} · ${account.accountNumber}'.trim(),
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 12.sp),
            )
          else
            Text('Virtual account pending — complete business KYC to activate',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 11.5.sp)),
        ],
      ),
    );
  }

  Widget _kpiGrid(BusinessOverviewEntity o) {
    final c = o.currency;
    final items = [
      _Kpi('Revenue', _money(o.revenueMajor, c), Icons.trending_up_rounded, const Color(0xFF10B981)),
      _Kpi('Expenses', _money(o.expensesMajor, c), Icons.receipt_long_rounded, const Color(0xFFFB923C)),
      _Kpi('Payroll', _money(o.payrollMajor, c), Icons.groups_rounded, _accent),
      _Kpi('Tax due', _money(o.taxMajor, c), Icons.account_balance_rounded, const Color(0xFFEF4444)),
      _Kpi('Inventory', _money(o.inventoryMajor, c), Icons.inventory_2_rounded, const Color(0xFF8B5CF6)),
      _Kpi('Customers', '${o.customerCount}', Icons.people_rounded, const Color(0xFF06B6D4)),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.3,
      children: items.map(_kpiTile).toList(),
    );
  }

  Widget _kpiTile(_Kpi k) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(14.r), border: Border.all(color: _border)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(9.w),
            decoration: BoxDecoration(
                color: k.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10.r)),
            child: Icon(k.icon, color: k.color, size: 18.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(k.label,
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                SizedBox(height: 2.h),
                Text(k.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Real Money-In vs Money-Out: inflow (revenue) against total outflow
  /// (payroll + expenses + tax). The "Where money goes" pie below breaks the
  /// outflow down by category. (Was a mislabeled 4-value card that mixed one
  /// inflow with three outflows.)
  Widget _barChartCard(BusinessOverviewEntity o) {
    final c = o.currency;
    final moneyIn = o.revenueMajor;
    final moneyOut = o.payrollMajor + o.expensesMajor + o.taxMajor;
    final bars = <_Bar>[
      _Bar('Money in', moneyIn, const Color(0xFF10B981)),
      _Bar('Money out', moneyOut, const Color(0xFFEF4444)),
    ];
    final maxV = bars.map((b) => b.value).fold<double>(0, (a, b) => b > a ? b : a);
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 18.h, 12.w, 8.h),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(16.r), border: Border.all(color: _border)),
      height: 200.h,
      child: BarChart(
        BarChartData(
          maxY: maxV <= 0 ? 1 : maxV * 1.25,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => _border,
              getTooltipItem: (group, gi, rod, ri) => BarTooltipItem(
                '${bars[group.x.toInt()].label}\n${_money(bars[group.x.toInt()].value, c)}',
                GoogleFonts.inter(color: Colors.white, fontSize: 11.sp),
              ),
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40.h,
                getTitlesWidget: (v, meta) {
                  final i = v.toInt();
                  if (i < 0 || i >= bars.length) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(bars[i].label,
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF), fontSize: 10.sp)),
                        SizedBox(height: 2.h),
                        Text(_compactMoney(bars[i].value, c),
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (int i = 0; i < bars.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: bars[i].value,
                  color: bars[i].color,
                  width: 40.w,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
                ),
              ]),
          ],
        ),
      ),
    );
  }

  /// Compact money (e.g. ₦1.2M) for chart labels that can't fit a full amount.
  String _compactMoney(double v, String currency) =>
      '${_symbol(currency)}${NumberFormat.compact().format(v)}';

  Widget _pieCard(BusinessOverviewEntity o) {
    final segments = <_Bar>[
      _Bar('Payroll', o.payrollMajor, _accent),
      _Bar('Expenses', o.expensesMajor, const Color(0xFFFB923C)),
      _Bar('Inventory', o.inventoryMajor, const Color(0xFF8B5CF6)),
      _Bar('Tax', o.taxMajor, const Color(0xFFEF4444)),
    ].where((s) => s.value > 0).toList();
    final total = segments.fold<double>(0, (a, b) => a + b.value);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(16.r), border: Border.all(color: _border)),
      child: total <= 0
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text('No spending recorded yet',
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.5.sp)),
              ),
            )
          : Row(
              children: [
                SizedBox(
                  height: 120.h,
                  width: 120.h,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 34.r,
                      sections: [
                        for (final s in segments)
                          PieChartSectionData(
                            value: s.value,
                            color: s.color,
                            radius: 22.r,
                            showTitle: false,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final s in segments)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Container(width: 10.w, height: 10.w,
                                  decoration: BoxDecoration(color: s.color, shape: BoxShape.circle)),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(s.label,
                                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp)),
                              ),
                              Text('${(s.value / total * 100).toStringAsFixed(0)}%',
                                  style: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _taxCard(BusinessOverviewEntity o) {
    if (o.pendingObligations == 0 && o.overdueObligations == 0 && o.taxTotalDue == 0) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_rounded, color: const Color(0xFFEF4444), size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              '${o.pendingObligations} pending, ${o.overdueObligations} overdue tax obligation(s)',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5.sp),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.taxDashboard),
            child: Text('View',
                style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _quickActions(BuildContext context, AccountSummaryEntity? account) {
    final actions = <_Action>[
      _Action('Record sale', Icons.point_of_sale_rounded, AppRoutes.recordSale),
      _Action('Sales', Icons.sell_rounded, AppRoutes.sales),
      _Action('Payroll', Icons.payments_rounded, AppRoutes.payroll),
      _Action('Employees', Icons.badge_rounded, AppRoutes.payrollEmployees),
      _Action('Expenses', Icons.account_balance_wallet_rounded, AppRoutes.expenses),
      _Action('Invoices', Icons.receipt_long_rounded, AppRoutes.invoice),
      _Action('Customers', Icons.people_rounded, AppRoutes.customers),
      _Action('Inventory', Icons.inventory_2_rounded, AppRoutes.inventory),
      _Action('Taxes', Icons.account_balance_rounded, AppRoutes.taxDashboard),
      _Action('Analytics', Icons.bar_chart_rounded, AppRoutes.businessAnalytics),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.0,
      children: actions.map((a) {
        return GestureDetector(
          onTap: () async {
            // Analytics needs THIS business account to scope its ledger charts;
            // other actions take no argument.
            await Get.toNamed(
              a.route,
              arguments:
                  a.route == AppRoutes.businessAnalytics ? account : null,
            );
            // Returning from ANY business service may have changed KPIs
            // (a sale, expense, pay run, new customer/item…), so refresh the
            // overview on return rather than only when a screen signals `true`.
            if (context.mounted) {
              context.read<BusinessDashboardCubit>().load();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: _card, borderRadius: BorderRadius.circular(14.r), border: Border.all(color: _border)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(a.icon, color: _accent, size: 24.sp),
                SizedBox(height: 8.h),
                Text(a.label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 11.5.sp)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700));

  Widget _errorBox(BuildContext context, String message) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(14.r), border: Border.all(color: _border)),
      child: Column(
        children: [
          Icon(Icons.cloud_off_rounded, color: const Color(0xFF9CA3AF), size: 32.sp),
          SizedBox(height: 10.h),
          Text(message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.5.sp)),
          SizedBox(height: 12.h),
          TextButton.icon(
            onPressed: () => context.read<BusinessDashboardCubit>().load(),
            icon: Icon(Icons.refresh_rounded, size: 18.sp, color: _accent),
            label: Text('Retry',
                style: GoogleFonts.inter(color: _accent, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
