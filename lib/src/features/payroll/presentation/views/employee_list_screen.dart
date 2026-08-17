import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/repositories/payroll_repository.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';
part 'employee_list_screen_widgets.dart';


class EmployeeListScreen extends StatefulWidget {
  final String? initialSearch;

  const EmployeeListScreen({super.key, this.initialSearch});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen>
    with InfiniteScrollMixin<EmployeeListScreen> {
  static const int _limit = 20;

  final TextEditingController _searchController = TextEditingController();
  String? _searchQuery;

  List<EmployeeEntity> _items = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initialSearch != null) {
      _searchController.text = widget.initialSearch!;
      _searchQuery = widget.initialSearch;
    }
    attachInfiniteScroll();
    _loadFirst();
  }

  @override
  void dispose() {
    detachInfiniteScroll();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await serviceLocator<PayrollRepository>().listEmployees(
        page: 1,
        limit: _limit,
        search: _searchQuery,
      );
      if (!mounted) return;
      setState(() {
        _items = res.employees;
        _loading = false;
        hasMore = res.currentPage < res.totalPages;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final res = await serviceLocator<PayrollRepository>().listEmployees(
          page: page + 1,
          limit: _limit,
          search: _searchQuery,
        );
        if (!mounted) return;
        setState(() {
          _items.addAll(res.employees);
          page += 1;
          hasMore = page < res.totalPages;
        });
      });

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query.isEmpty ? null : query);
    _loadFirst();
  }

  Future<void> _onRefresh() async {
    await _loadFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Employees',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 8.h),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (_loading) {
                    return const Center(
                      child: LazerVaultLoader.small(),
                    );
                  }

                  if (_error != null) {
                    return _buildError(_error!);
                  }

                  if (_items.isEmpty) {
                    return _buildEmpty();
                  }

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: InvoiceThemeColors.primaryPurpleLight,
                    backgroundColor: InvoiceThemeColors.secondaryBackground,
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 4.h,
                      ),
                      itemCount: _items.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= _items.length) {
                          return Padding(
                            padding: EdgeInsets.all(16.w),
                            child: const Center(
                              child: LazerVaultLoader.small(),
                            ),
                          );
                        }
                        return _buildEmployeeItem(_items[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 15.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search employees...',
          hintStyle: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray500,
            fontSize: 15.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: InvoiceThemeColors.textGray400,
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: InvoiceThemeColors.textGray400,
                    size: 18.sp,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: InvoiceThemeColors.secondaryBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildEmployeeItem(EmployeeEntity employee) {
    return GestureDetector(
      onTap: () => _showEmployeeDetails(employee),
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
              radius: 24.r,
              backgroundColor:
                  InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
              child: Text(
                employee.fullName.isNotEmpty
                    ? employee.fullName[0].toUpperCase()
                    : '?',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurpleLight,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 14.w),
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
                  SizedBox(height: 3.h),
                  if (employee.department.isNotEmpty ||
                      employee.jobTitle.isNotEmpty)
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
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        employee.formattedPayRate,
                        style: GoogleFonts.inter(
                          color: InvoiceThemeColors.successGreen,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '/ ${employee.payFrequencyDisplay}',
                        style: GoogleFonts.inter(
                          color: InvoiceThemeColors.textGray500,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  _buildPayoutChip(employee),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusChip(employee),
                SizedBox(height: 6.h),
                Text(
                  employee.employmentTypeDisplay,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray500,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayoutChip(EmployeeEntity employee) {
    final isInternal = employee.isInternalPayout;
    final color = isInternal
        ? InvoiceThemeColors.primaryPurpleLight
        : InvoiceThemeColors.textGray300;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isInternal
                ? Icons.account_balance_wallet_outlined
                : Icons.account_balance_outlined,
            color: color,
            size: 12.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            employee.payoutDisplay,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(EmployeeEntity employee) {
    Color color;
    switch (employee.status) {
      case EmployeeStatus.active:
        color = InvoiceThemeColors.successGreen;
        break;
      case EmployeeStatus.inactive:
        color = InvoiceThemeColors.warningOrange;
        break;
      case EmployeeStatus.terminated:
        color = InvoiceThemeColors.errorRed;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        employee.statusDisplay,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showEmployeeDetails(EmployeeEntity employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EmployeeDetailsSheet(employee: employee),
    );
  }

  Widget _buildEmpty() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 48.sp,
                color: InvoiceThemeColors.textGray500,
              ),
              SizedBox(height: 16.h),
              Text(
                _searchQuery != null ? 'No Results' : 'No Employees',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _searchQuery != null
                    ? 'No employees match your search'
                    : 'Add employees to get started',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: InvoiceThemeColors.errorRed),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _onRefresh,
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
      ),
    );
  }
}
