import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/pay_run_entity.dart';
import '../../domain/entities/pay_slip_entity.dart';
import 'employee_list_screen.dart';
import 'employee_details_screen.dart';
import 'add_employee_screen.dart';
import 'create_pay_run_screen.dart';
import 'pay_run_details_screen.dart';
import '../../services/payroll_pdf_service.dart';
import '../../domain/repositories/payroll_repository.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

class PayrollHomeScreen extends StatefulWidget {
  const PayrollHomeScreen({super.key});

  @override
  State<PayrollHomeScreen> createState() => _PayrollHomeScreenState();
}

class _PayrollHomeScreenState extends State<PayrollHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  // Pay Runs status filter (null = All)
  PayRunStatus? _payRunFilter;

  // Report period
  String _reportPeriodStart = '';
  String _reportPeriodEnd = '';
  bool _exportingReport = false;

  // Per-employee payroll report (name + gross/deductions/net for the period).
  // Loaded via the repo directly (NOT the cubit) so it doesn't collide with the
  // Reports tab's PayrollSummaryLoaded state or trigger the tax-report sheet.
  List<Map<String, dynamic>> _employeePayments = const [];
  bool _loadingEmployeePayments = false;

  /// Loads the per-employee payment rows for the Reports "Employees & payments"
  /// section. Unlike the aggregate cards (which count only COMPLETED payroll),
  /// this shows EVERY slip from ALL pay runs whose period falls in the report
  /// window — paid, pending AND failed — each tagged with its payment status,
  /// so a failed run (e.g. an employee with no payout destination) is visible
  /// here instead of silently vanishing while the Pay Runs tab still lists it.
  Future<void> _loadEmployeePayments() async {
    if (_reportPeriodStart.isEmpty || _reportPeriodEnd.isEmpty) return;
    setState(() => _loadingEmployeePayments = true);
    try {
      final repo = serviceLocator<PayrollRepository>();
      // All pay runs (recent-first), then keep those whose pay period is within
      // the report window ('YYYY-MM-DD' strings compare lexicographically,
      // matching the backend GetTaxReport `pay_period_start >= ? AND
      // pay_period_end <= ?`). Limit 250 comfortably covers years of runs at any
      // cadence for a single window.
      final runsPage = await repo.listPayRuns(page: 1, limit: 250);
      final inWindow = runsPage.payRuns
          .where((r) =>
              r.payPeriodStart.compareTo(_reportPeriodStart) >= 0 &&
              r.payPeriodEnd.compareTo(_reportPeriodEnd) <= 0)
          .toList();
      final rows = <Map<String, dynamic>>[];
      for (final run in inWindow) {
        // Limit 500 covers large teams in a single run. One run's slips failing
        // to load must NOT zero the whole section — skip it and keep the rest.
        try {
          final slipsPage =
              await repo.listPaySlips(payRunId: run.id, limit: 500);
          for (final s in slipsPage.paySlips) {
            rows.add({
              'employeeName': s.employeeName,
              'grossPay': s.grossPay,
              'netPay': s.netPay,
              'totalDeductions': s.totalDeductions,
              'paymentStatus': s.paymentStatus,
            });
          }
        } catch (_) {
          // Skip this run's slips; the section still shows every other run.
        }
      }
      // Failed/pending first so unresolved payments surface at the top.
      int rank(Map<String, dynamic> m) {
        switch (m['paymentStatus'] as PaymentStatus) {
          case PaymentStatus.failed:
            return 0;
          case PaymentStatus.pending:
            return 1;
          case PaymentStatus.paid:
            return 2;
        }
      }

      rows.sort((a, b) => rank(a).compareTo(rank(b)));
      if (mounted) setState(() => _employeePayments = rows);
    } catch (_) {
      if (mounted) setState(() => _employeePayments = const []);
    } finally {
      if (mounted) setState(() => _loadingEmployeePayments = false);
    }
  }

  /// Export the payroll report as a PDF — download to storage or open the
  /// share sheet. Uses the SAME real summary the Reports tab is showing.
  Future<void> _exportReport(Map<String, dynamic> summary,
      {required bool share}) async {
    if (_exportingReport) return;
    setState(() => _exportingReport = true);
    try {
      if (share) {
        await PayrollPdfService.sharePayrollReport(
          summary: summary,
          periodStart: _reportPeriodStart,
          periodEnd: _reportPeriodEnd,
        );
      } else {
        final path = await PayrollPdfService.downloadPayrollReport(
          summary: summary,
          periodStart: _reportPeriodStart,
          periodEnd: _reportPeriodEnd,
        );
        Get.snackbar(
          'Report Saved',
          'PDF saved to $path',
          backgroundColor: InvoiceThemeColors.successGreen,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16.w),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Export Failed',
        'Could not export the report. Please try again.',
        backgroundColor: InvoiceThemeColors.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _exportingReport = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);

    // Default report period: current month
    final now = DateTime.now();
    _reportPeriodStart =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-01';
    final lastDay = DateTime(now.year, now.month + 1, 0).day;
    _reportPeriodEnd =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-$lastDay';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentTabData();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() => _currentTabIndex = _tabController.index);
    _loadCurrentTabData();
  }

  void _loadCurrentTabData() {
    final cubit = context.read<PayrollCubit>();
    switch (_currentTabIndex) {
      case 0:
        cubit.listEmployees();
        break;
      case 1:
        cubit.listPayRuns();
        break;
      case 2:
        cubit.getPayrollSummary(
          start: _reportPeriodStart,
          end: _reportPeriodEnd,
        );
        _loadEmployeePayments();
        break;
    }
  }

  void _onFabPressed() {
    switch (_currentTabIndex) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<PayrollCubit>(),
                child: const AddEmployeeScreen(),
              ),
            ))
            .then((_) => context.read<PayrollCubit>().listEmployees());
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<PayrollCubit>(),
                child: const CreatePayRunScreen(),
              ),
            ))
            .then((_) => context.read<PayrollCubit>().listPayRuns());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      floatingActionButton: _currentTabIndex < 2
          ? FloatingActionButton.extended(
              onPressed: _onFabPressed,
              backgroundColor: InvoiceThemeColors.primaryPurple,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                _currentTabIndex == 0 ? 'Add Employee' : 'New Pay Run',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 8.h),
            _buildTabBar(),
            SizedBox(height: 16.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEmployeesTab(),
                  _buildPayRunsTab(),
                  _buildReportsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Payroll',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ServiceVoiceButton(serviceName: 'payroll'),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Payroll',
            sourceContext: 'payroll',
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: InvoiceThemeColors.primaryPurple,
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: InvoiceThemeColors.textGray400,
        labelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Employees'),
          Tab(text: 'Pay Runs'),
          Tab(text: 'Reports'),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Employees Tab
  // ---------------------------------------------------------------------------

  Widget _buildEmployeesTab() {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is EmployeeAdded || state is EmployeeRemoved) {
          context.read<PayrollCubit>().listEmployees();
        }
      },
      builder: (context, state) {
        if (state is PayrollLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is EmployeesLoaded) {
          final employees = state.employees;
          return Column(
            children: [
              _buildEmployeeSummaryCard(employees),
              SizedBox(height: 12.h),
              Expanded(
                child: employees.isEmpty
                    ? _buildEmptyEmployees()
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<PayrollCubit>().listEmployees();
                        },
                        color: InvoiceThemeColors.primaryPurpleLight,
                        backgroundColor: InvoiceThemeColors.secondaryBackground,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 4.h,
                          ),
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            return _buildEmployeeCard(employees[index]);
                          },
                        ),
                      ),
              ),
            ],
          );
        }

        if (state is PayrollError) {
          return _buildErrorState(state.message, onRetry: () {
            context.read<PayrollCubit>().listEmployees();
          });
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmployeeSummaryCard(List<EmployeeEntity> employees) {
    final activeCount = employees.where((e) => e.isActive).length;
    final totalPayroll = employees
        .where((e) => e.isActive)
        .fold<double>(0, (sum, e) => sum + e.payRate);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [InvoiceThemeColors.primaryPurple, InvoiceThemeColors.primaryPurpleLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$activeCount Active Employees',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Est. Monthly: \u20A6${totalPayroll.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.people_outline,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(EmployeeEntity employee) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<PayrollCubit>(),
                  child: EmployeeDetailsScreen(employee: employee),
                ),
              ),
            )
            .then((_) => context.read<PayrollCubit>().listEmployees());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
              child: Text(
                employee.fullName.isNotEmpty
                    ? employee.fullName[0].toUpperCase()
                    : '?',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurpleLight,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.fullName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${employee.department}${employee.department.isNotEmpty && employee.jobTitle.isNotEmpty ? ' - ' : ''}${employee.jobTitle}',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  employee.formattedPayRate,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildStatusBadge(
                  employee.statusDisplay,
                  employee.isActive
                      ? InvoiceThemeColors.successGreen
                      : InvoiceThemeColors.textGray400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyEmployees() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(
                  Icons.people_outline,
                  size: 32.sp,
                  color: InvoiceThemeColors.textGray500,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Employees Yet',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Add your first employee to get started\nwith payroll management',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Pay Runs Tab
  // ---------------------------------------------------------------------------

  Widget _buildPayRunsTab() {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is PayRunCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: InvoiceThemeColors.successGreen,
            ),
          );
          context.read<PayrollCubit>().listPayRuns();
        }
      },
      builder: (context, state) {
        if (state is PayrollLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is PayRunsLoaded) {
          final payRuns = state.payRuns;
          if (payRuns.isEmpty) {
            return _buildEmptyPayRuns();
          }
          final filtered = _payRunFilter == null
              ? payRuns
              : payRuns.where((p) => p.status == _payRunFilter).toList();
          return Column(
            children: [
              _buildPayRunFilterChips(),
              SizedBox(height: 8.h),
              Expanded(
                child: filtered.isEmpty
                    ? _buildFilteredEmptyPayRuns()
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<PayrollCubit>().listPayRuns();
                        },
                        color: InvoiceThemeColors.primaryPurpleLight,
                        backgroundColor: InvoiceThemeColors.secondaryBackground,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 4.h,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return _buildPayRunCard(filtered[index]);
                          },
                        ),
                      ),
              ),
            ],
          );
        }

        if (state is PayrollError) {
          return _buildErrorState(state.message, onRetry: () {
            context.read<PayrollCubit>().listPayRuns();
          });
        }

        return const SizedBox.shrink();
      },
    );
  }

  String _payRunStatusLabel(PayRunStatus status) {
    return status.name[0].toUpperCase() + status.name.substring(1);
  }

  Widget _buildPayRunFilterChips() {
    // All + one chip per filterable status (calculating is a transient state).
    const statuses = [
      PayRunStatus.draft,
      PayRunStatus.ready,
      PayRunStatus.approved,
      PayRunStatus.processing,
      PayRunStatus.completed,
      PayRunStatus.failed,
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _buildPayRunFilterChip('All', null),
          ...statuses.map(
            (s) => Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: _buildPayRunFilterChip(_payRunStatusLabel(s), s),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayRunFilterChip(String label, PayRunStatus? status) {
    final selected = _payRunFilter == status;
    return GestureDetector(
      onTap: () => setState(() => _payRunFilter = status),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected
              ? InvoiceThemeColors.primaryPurple
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected
                ? InvoiceThemeColors.primaryPurple
                : InvoiceThemeColors.borderColor,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: selected ? Colors.white : InvoiceThemeColors.textGray400,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredEmptyPayRuns() {
    final label =
        _payRunFilter == null ? '' : '${_payRunStatusLabel(_payRunFilter!)} ';
    return Center(
      child: Text(
        'No ${label}pay runs',
        style: GoogleFonts.inter(
          color: InvoiceThemeColors.textGray400,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildPayRunCard(PayRunEntity payRun) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<PayrollCubit>(),
                  child: PayRunDetailsScreen(payRunId: payRun.id),
                ),
              ),
            )
            .then((_) => context.read<PayrollCubit>().listPayRuns());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${payRun.payPeriodStart} - ${payRun.payPeriodEnd}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _buildPayRunStatusBadge(payRun.status),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _buildPayRunStat(
                  'Employees',
                  payRun.employeeCount.toString(),
                ),
                SizedBox(width: 20.w),
                _buildPayRunStat('Gross', payRun.formattedTotalGross),
                SizedBox(width: 20.w),
                _buildPayRunStat('Net', payRun.formattedTotalNet),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayRunStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPayRunStatusBadge(PayRunStatus status) {
    Color badgeColor;
    switch (status) {
      case PayRunStatus.draft:
        badgeColor = InvoiceThemeColors.textGray400;
        break;
      case PayRunStatus.calculating:
        badgeColor = InvoiceThemeColors.warningOrange;
        break;
      case PayRunStatus.ready:
        badgeColor = InvoiceThemeColors.primaryPurpleLight;
        break;
      case PayRunStatus.approved:
        badgeColor = InvoiceThemeColors.warningOrange;
        break;
      case PayRunStatus.processing:
        badgeColor = InvoiceThemeColors.warningOrange;
        break;
      case PayRunStatus.completed:
        badgeColor = InvoiceThemeColors.successGreen;
        break;
      case PayRunStatus.failed:
        badgeColor = InvoiceThemeColors.errorRed;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.name[0].toUpperCase() + status.name.substring(1),
        style: GoogleFonts.inter(
          color: badgeColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyPayRuns() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 32.sp,
                  color: InvoiceThemeColors.textGray500,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Pay Runs',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Create a pay run to process\npayroll for your employees',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Reports Tab
  // ---------------------------------------------------------------------------

  Widget _buildReportsTab() {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is TaxReportLoaded) {
          _showTaxReportSheet(state.report);
        }
      },
      builder: (context, state) {
        if (state is PayrollLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is PayrollSummaryLoaded) {
          return _buildReportContent(state.summary);
        }

        if (state is PayrollError) {
          return _buildErrorState(state.message, onRetry: () {
            context.read<PayrollCubit>().getPayrollSummary(
                  start: _reportPeriodStart,
                  end: _reportPeriodEnd,
                );
          });
        }

        // Default: show prompt to load report
        return _buildReportContent({});
      },
    );
  }

  Widget _buildReportContent(Map<String, dynamic> summary) {
    final totalGross = summary['totalGross'] as double? ?? 0.0;
    final totalDeductions = summary['totalDeductions'] as double? ?? 0.0;
    final totalNet = summary['totalNet'] as double? ?? 0.0;
    final totalEmployerContributions =
        summary['totalEmployerContributions'] as double? ?? 0.0;
    final employeeCount = summary['employeeCount'] as int? ?? 0;
    final payRunCount = summary['payRunCount'] as int? ?? 0;

    return RefreshIndicator(
      color: InvoiceThemeColors.primaryPurple,
      backgroundColor: InvoiceThemeColors.secondaryBackground,
      onRefresh: () async {
        context.read<PayrollCubit>().getPayrollSummary(
              start: _reportPeriodStart,
              end: _reportPeriodEnd,
            );
        _loadEmployeePayments();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period picker
          GestureDetector(
            onTap: _showPeriodPicker,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: InvoiceThemeColors.primaryPurpleLight,
                    size: 20.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '$_reportPeriodStart to $_reportPeriodEnd',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: InvoiceThemeColors.textGray400,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Summary cards
          _buildReportSummaryCard(
            'Total Gross Pay',
            '\u20A6${totalGross.toStringAsFixed(2)}',
            Icons.trending_up,
            InvoiceThemeColors.primaryPurpleLight,
          ),
          SizedBox(height: 10.h),
          _buildReportSummaryCard(
            'Total Deductions',
            '\u20A6${totalDeductions.toStringAsFixed(2)}',
            Icons.trending_down,
            InvoiceThemeColors.errorRed,
          ),
          SizedBox(height: 10.h),
          _buildReportSummaryCard(
            'Total Net Pay',
            '\u20A6${totalNet.toStringAsFixed(2)}',
            Icons.account_balance_wallet,
            InvoiceThemeColors.successGreen,
          ),
          SizedBox(height: 10.h),
          _buildReportSummaryCard(
            'Employer Contributions',
            '\u20A6${totalEmployerContributions.toStringAsFixed(2)}',
            Icons.business,
            InvoiceThemeColors.warningOrange,
          ),
          SizedBox(height: 16.h),

          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Employees',
                  employeeCount.toString(),
                  Icons.people,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildStatCard(
                  'Pay Runs',
                  payRunCount.toString(),
                  Icons.receipt_long,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Employees & payments — the actual per-employee payroll report for the
          // period (name + gross / deductions / net), not just the tax totals.
          _buildEmployeePaymentsSection(),
          SizedBox(height: 16.h),

          // Export report (PDF) — Download + Share. Only enabled once a real
          // summary is loaded (empty map = nothing to export).
          if (summary.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton.icon(
                      onPressed: _exportingReport
                          ? null
                          : () => _exportReport(summary, share: false),
                      icon: _exportingReport
                          ? LazerVaultLoader.tiny()
                          : Icon(Icons.download_outlined,
                              color: InvoiceThemeColors.successGreen, size: 20.sp),
                      label: Text(
                        'Download PDF',
                        style: GoogleFonts.inter(
                          color: InvoiceThemeColors.successGreen,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: InvoiceThemeColors.successGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton.icon(
                      onPressed: _exportingReport
                          ? null
                          : () => _exportReport(summary, share: true),
                      icon: Icon(Icons.share_outlined,
                          color: InvoiceThemeColors.primaryPurpleLight, size: 20.sp),
                      label: Text(
                        'Share',
                        style: GoogleFonts.inter(
                          color: InvoiceThemeColors.primaryPurpleLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: InvoiceThemeColors.primaryPurpleLight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],

          // Tax report button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<PayrollCubit>().getTaxReport(
                      start: _reportPeriodStart,
                      end: _reportPeriodEnd,
                    );
              },
              icon: Icon(Icons.description_outlined,
                  color: InvoiceThemeColors.primaryPurpleLight, size: 20.sp),
              label: Text(
                'View Tax Report',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurpleLight,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: InvoiceThemeColors.primaryPurpleLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
        ),
      ),
    );
  }

  /// The per-employee payroll report for the selected period: each employee with
  /// what they grossed, was deducted, and netted. This is the actual "payroll
  /// report" (vs the aggregate cards + the separate tax report).
  Widget _buildEmployeePaymentsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups_outlined,
                  color: InvoiceThemeColors.primaryPurpleLight, size: 20.sp),
              SizedBox(width: 8.w),
              Text('Employees & payments',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              if (_employeePayments.isNotEmpty)
                Text('${_employeePayments.length}',
                    style: GoogleFonts.inter(
                        color: InvoiceThemeColors.textGray400, fontSize: 13.sp)),
            ],
          ),
          SizedBox(height: 12.h),
          if (_loadingEmployeePayments)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              child: const Center(child: LazerVaultLoader.small()),
            )
          else if (_employeePayments.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text('No employee payments in this period.',
                  style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400, fontSize: 13.sp)),
            )
          else
            ..._employeePayments.map(_buildEmployeePaymentRow),
        ],
      ),
    );
  }

  Widget _buildEmployeePaymentRow(Map<String, dynamic> e) {
    final name = (e['employeeName'] as String?)?.trim();
    final gross = (e['grossPay'] as num?)?.toDouble() ?? 0.0;
    final net = (e['netPay'] as num?)?.toDouble() ?? 0.0;
    final deductionsRaw = (e['totalDeductions'] as num?)?.toDouble();
    final deductions =
        deductionsRaw ?? (gross - net).clamp(0, double.infinity).toDouble();
    final status =
        (e['paymentStatus'] as PaymentStatus?) ?? PaymentStatus.paid;
    final label = (name == null || name.isEmpty) ? 'Employee' : name;

    final (Color statusColor, String statusLabel) = switch (status) {
      PaymentStatus.paid => (InvoiceThemeColors.successGreen, 'Paid'),
      PaymentStatus.pending => (InvoiceThemeColors.warningOrange, 'Pending'),
      PaymentStatus.failed => (InvoiceThemeColors.errorRed, 'Failed'),
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor:
                InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
            child: Text(
              label.substring(0, 1).toUpperCase(),
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurpleLight,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(statusLabel,
                          style: GoogleFonts.inter(
                              color: statusColor,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                    'Gross ${_formatAmount(gross)} · Deductions ${_formatAmount(deductions)}',
                    style: GoogleFonts.inter(
                        color: InvoiceThemeColors.textGray400, fontSize: 11.5.sp)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(_formatAmount(net),
              style: GoogleFonts.inter(
                  color: status == PaymentStatus.paid
                      ? InvoiceThemeColors.successGreen
                      : InvoiceThemeColors.textGray400,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildReportSummaryCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray400,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: InvoiceThemeColors.primaryPurpleLight, size: 28.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(dynamic amount) {
    final value = (amount is int)
        ? amount.toDouble()
        : (amount as double? ?? 0.0);
    return '\u20A6${value.toStringAsFixed(2)}';
  }

  void _showTaxReportSheet(Map<String, dynamic> report) {
    final totalPaye = report['totalPaye'] ?? 0.0;
    final totalNhf = report['totalNhf'] ?? 0.0;
    final totalPensionEmployee = report['totalPensionEmployee'] ?? 0.0;
    final totalPensionEmployer = report['totalPensionEmployer'] ?? 0.0;
    final totalNsitf = report['totalNsitf'] ?? 0.0;
    final totalItf = report['totalItf'] ?? 0.0;
    final employeeSummaries =
        report['employeeSummaries'] as List<dynamic>? ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        constraints: BoxConstraints(maxHeight: 0.85.sh),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.tertiaryBackground,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(Icons.description_outlined,
                      color: InvoiceThemeColors.primaryPurpleLight, size: 24.sp),
                  SizedBox(width: 10.w),
                  Text(
                    'Tax Report',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                '$_reportPeriodStart to $_reportPeriodEnd',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400,
                  fontSize: 13.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Divider(color: InvoiceThemeColors.borderColor, height: 1.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tax totals
                    _buildTaxRow('Total PAYE', totalPaye),
                    _buildTaxRow('Total Pension (Employee)', totalPensionEmployee),
                    _buildTaxRow('Total Pension (Employer)', totalPensionEmployer),
                    _buildTaxRow('Total NHF', totalNhf),
                    _buildTaxRow('Total NSITF', totalNsitf),
                    _buildTaxRow('Total ITF', totalItf),
                    SizedBox(height: 20.h),

                    // Per-employee breakdown
                    if (employeeSummaries.isNotEmpty) ...[
                      Text(
                        'Per-Employee Breakdown',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ...employeeSummaries.map((emp) {
                        final e = emp as Map<String, dynamic>;
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: InvoiceThemeColors.primaryBackground,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['employeeName'] as String? ?? 'Unknown',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildMiniStat(
                                      'Gross', _formatAmount(e['grossPay'])),
                                  _buildMiniStat(
                                      'PAYE', _formatAmount(e['paye'])),
                                  _buildMiniStat(
                                      'Pension', _formatAmount(e['pension'])),
                                  _buildMiniStat(
                                      'Net', _formatAmount(e['netPay'])),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Reload summary so the reports tab goes back to summary view
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        context.read<PayrollCubit>().getPayrollSummary(
              start: _reportPeriodStart,
              end: _reportPeriodEnd,
            );
        _loadEmployeePayments();
      }
    });
  }

  Widget _buildTaxRow(String label, dynamic amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _formatAmount(amount),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray500,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Future<void> _showPeriodPicker() async {
    final start = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_reportPeriodStart) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: InvoiceThemeColors.primaryPurple,
              surface: InvoiceThemeColors.secondaryBackground,
            ),
          ),
          child: child!,
        );
      },
    );
    if (start == null || !mounted) return;

    final end = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_reportPeriodEnd) ?? DateTime.now(),
      firstDate: start,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: InvoiceThemeColors.primaryPurple,
              surface: InvoiceThemeColors.secondaryBackground,
            ),
          ),
          child: child!,
        );
      },
    );
    if (end == null || !mounted) return;

    setState(() {
      _reportPeriodStart =
          '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}';
      _reportPeriodEnd =
          '${end.year}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}';
    });

    context.read<PayrollCubit>().getPayrollSummary(
          start: _reportPeriodStart,
          end: _reportPeriodEnd,
        );
  }

  // ---------------------------------------------------------------------------
  // Shared Widgets
  // ---------------------------------------------------------------------------

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, {VoidCallback? onRetry}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: InvoiceThemeColors.errorRed,
            ),
            SizedBox(height: 16.h),
            Text(
              'Something Went Wrong',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvoiceThemeColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Retry',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
