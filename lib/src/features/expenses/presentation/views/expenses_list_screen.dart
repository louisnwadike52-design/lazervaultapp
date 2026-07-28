import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

import '../../domain/entities/expense_entity.dart';
import '../../domain/repositories/expense_repository.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Landing screen for the Expense Tracking feature, styled to the invoice
/// (purple) theme. A summary hero + search + status/category filters sit above
/// an infinite list of expense tiles. Chat + voice icons pin every session to
/// the expenses flow on chat-business-service (per-service `serviceName:
/// 'expenses'`).
class ExpensesListScreen extends StatefulWidget {
  const ExpensesListScreen({super.key});

  @override
  State<ExpensesListScreen> createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen>
    with InfiniteScrollMixin<ExpensesListScreen> {
  final _searchController = TextEditingController();
  ExpenseStatus? _statusFilter;
  ExpenseCategory? _categoryFilter;

  static const int _limit = 20;

  List<ExpenseEntity> _expenses = [];
  bool _loading = true;

  ExpenseSummaryEntity? _summary;

  static final _moneyFmt = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  );
  static final _compactFmt = NumberFormat.compactCurrency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 0,
  );

  /// The hero overview only makes sense on the unfiltered landing state — once
  /// the user searches or filters they're drilling down, so it steps aside.
  bool get _showHero =>
      _searchController.text.trim().isEmpty &&
      _statusFilter == null &&
      _categoryFilter == null;

  @override
  void initState() {
    super.initState();
    attachInfiniteScroll();
    _loadFirst();
    _loadSummary();
  }

  @override
  void dispose() {
    detachInfiniteScroll();
    _searchController.dispose();
    super.dispose();
  }

  String? get _searchTerm {
    final t = _searchController.text.trim();
    return t.isEmpty ? null : t;
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() => _loading = true);
    try {
      final res = await serviceLocator<ExpenseRepository>().listExpenses(
        page: 1,
        limit: _limit,
        search: _searchTerm,
        status: _statusFilter,
        category: _categoryFilter,
      );
      if (!mounted) return;
      setState(() {
        _expenses = res.items;
        _loading = false;
        hasMore = res.currentPage < res.totalPages;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: InvoiceThemeColors.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16.w),
      );
    }
  }

  /// All-time summary powering the hero. Best-effort — a failure just hides the
  /// hero, never blocks the list.
  Future<void> _loadSummary() async {
    try {
      final s = await serviceLocator<ExpenseRepository>().getSummary();
      if (mounted) setState(() => _summary = s);
    } catch (_) {
      /* hero stays hidden */
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final res = await serviceLocator<ExpenseRepository>().listExpenses(
          page: page + 1,
          limit: _limit,
          search: _searchTerm,
          status: _statusFilter,
          category: _categoryFilter,
        );
        if (!mounted) return;
        setState(() {
          _expenses.addAll(res.items);
          page += 1;
          hasMore = page < res.totalPages;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Expenses',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          ServiceVoiceButton(
            serviceName: 'expenses',
            iconColor: InvoiceThemeColors.primaryPurpleLight,
            backgroundColor: InvoiceThemeColors.primaryPurple,
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Expenses',
            sourceContext: 'expenses',
            icon: Icons.chat_bubble_outline,
            iconColor: InvoiceThemeColors.primaryPurpleLight,
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildStatusFilters(),
            _buildCategoryFilters(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.addExpense);
          if (result == true && mounted) {
            _loadFirst();
            _loadSummary();
          }
        },
        backgroundColor: InvoiceThemeColors.primaryPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'New expense',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Summary hero
  // ---------------------------------------------------------------------------
  Widget _buildHero(ExpenseSummaryEntity s) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            const Color(0xFF2A0B5E),
          ],
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.28),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_rounded,
                  color: Colors.white.withValues(alpha: 0.85), size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'Total expenses',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${s.expenseCount} record${s.expenseCount == 1 ? '' : 's'}',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 11.5.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _moneyFmt.format(s.totalExpensesMinor / 100.0),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _heroStat('Pending', s.totalPendingMinor, s.pendingCount,
                  ExpenseStatus.pending.color),
              _heroDivider(),
              _heroStat('Approved', s.totalApprovedMinor, s.approvedCount,
                  ExpenseStatus.approved.color),
              _heroDivider(),
              _heroStat('Reimbursed', s.totalReimbursedMinor,
                  s.reimbursedCount, ExpenseStatus.reimbursed.color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroDivider() => Container(
        width: 1,
        height: 34.h,
        color: Colors.white.withValues(alpha: 0.15),
      );

  Widget _heroStat(String label, int amountMinor, int count, Color dot) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 7.w,
                height: 7.w,
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
              ),
              SizedBox(width: 5.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            _compactFmt.format(amountMinor / 100.0),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search + filters
  // ---------------------------------------------------------------------------
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        textInputAction: TextInputAction.search,
        onChanged: (_) => setState(() {}), // toggle clear button + hero
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search description, vendor or reference',
          hintStyle: GoogleFonts.inter(
              color: InvoiceThemeColors.hintText, fontSize: 14.sp),
          prefixIcon: Icon(Icons.search_rounded,
              color: InvoiceThemeColors.textGray500, size: 20.sp),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close_rounded,
                      color: InvoiceThemeColors.textGray500, size: 18.sp),
                  onPressed: () {
                    _searchController.clear();
                    _loadFirst();
                  },
                ),
          filled: true,
          fillColor: InvoiceThemeColors.secondaryBackground,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide:
                BorderSide(color: InvoiceThemeColors.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
                color: InvoiceThemeColors.primaryPurpleLight, width: 1.4),
          ),
        ),
        onSubmitted: (_) => _loadFirst(),
      ),
    );
  }

  Widget _buildStatusFilters() {
    final filters = <String, ExpenseStatus?>{
      'All': null,
      'Pending': ExpenseStatus.pending,
      'Approved': ExpenseStatus.approved,
      'Reimbursed': ExpenseStatus.reimbursed,
      'Rejected': ExpenseStatus.rejected,
    };
    return SizedBox(
      height: 42.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: filters.entries.map((e) {
          final selected = _statusFilter == e.value;
          final accent = e.value?.color ?? InvoiceThemeColors.primaryPurple;
          return _pill(
            e.key,
            selected,
            accent,
            () {
              setState(() => _statusFilter = e.value);
              _loadFirst();
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final filters = <String, ExpenseCategory?>{
      'All categories': null,
      'Office': ExpenseCategory.office,
      'Travel': ExpenseCategory.travel,
      'Meals': ExpenseCategory.meals,
      'Marketing': ExpenseCategory.marketing,
      'Utilities': ExpenseCategory.utilities,
      'Software': ExpenseCategory.software,
      'Professional': ExpenseCategory.professional,
      'Inventory': ExpenseCategory.inventory,
      'Taxes': ExpenseCategory.taxes,
      'Other': ExpenseCategory.other,
    };
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 6.h),
      child: SizedBox(
        height: 34.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: filters.entries.map((e) {
            return _categoryPill(
              e.key,
              e.value,
              _categoryFilter == e.value,
              () {
                setState(() => _categoryFilter = e.value);
                _loadFirst();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _categoryPill(
    String label,
    ExpenseCategory? value,
    bool selected,
    VoidCallback onTap,
  ) {
    final accent = value?.color ?? InvoiceThemeColors.primaryPurpleLight;
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.18)
                : InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected ? accent : InvoiceThemeColors.borderColor,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (value != null) ...[
                Icon(value.icon,
                    color: selected ? accent : InvoiceThemeColors.textGray500,
                    size: 13.sp),
                SizedBox(width: 6.w),
              ],
              Text(
                label,
                style: GoogleFonts.inter(
                  color: selected ? Colors.white : InvoiceThemeColors.textGray400,
                  fontSize: 12.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pill(String label, bool selected, Color accent, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: selected ? accent : InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: selected ? accent : InvoiceThemeColors.borderColor,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: selected ? Colors.white : InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body / list
  // ---------------------------------------------------------------------------
  Widget _buildBody() {
    if (_loading) {
      return const Center(child: LazerVaultLoader.small());
    }

    final hero = _showHero && _summary != null;
    final heroOffset = hero ? 1 : 0;
    final isEmpty = _expenses.isEmpty;

    // No hero to anchor an empty list → full-screen centred empty state.
    if (isEmpty && !hero) {
      return _empty();
    }

    return RefreshIndicator(
      color: InvoiceThemeColors.primaryPurpleLight,
      backgroundColor: InvoiceThemeColors.secondaryBackground,
      onRefresh: () async {
        await _loadFirst();
        await _loadSummary();
      },
      child: ListView.separated(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 96.h),
        // hero (0/1) + either a single empty slot or the tiles + optional loader
        itemCount: heroOffset +
            (isEmpty ? 1 : _expenses.length) +
            (isLoadingMore ? 1 : 0),
        separatorBuilder: (_, i) =>
            SizedBox(height: (hero && i == 0) ? 16.h : 10.h),
        itemBuilder: (_, i) {
          if (hero && i == 0) return _buildHero(_summary!);
          final idx = i - heroOffset;
          if (isEmpty) {
            // Hero is shown above (all-time overview) but there are no rows yet.
            return Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: _empty(),
            );
          }
          if (idx >= _expenses.length) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: const Center(child: LazerVaultLoader.small()),
            );
          }
          return _expenseTile(_expenses[idx]);
        },
      ),
    );
  }

  Widget _empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.receipt_long_rounded,
                size: 44.sp, color: InvoiceThemeColors.primaryPurpleLight),
          ),
          SizedBox(height: 16.h),
          Text(
            _showHero ? 'No expenses yet' : 'No matching expenses',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          Text(
            _showHero
                ? 'Tap “New expense” to record your first one.'
                : 'Try a different search or filter.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray500, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _expenseTile(ExpenseEntity e) {
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(
          AppRoutes.expenseDetails,
          arguments: e,
        );
        if (result == true && mounted) {
          _loadFirst();
          _loadSummary();
        }
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: InvoiceThemeColors.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                color: e.category.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(e.category.icon, color: e.category.color, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${e.category.label}'
                    '${e.vendor.isNotEmpty ? ' · ${e.vendor}' : ''}'
                    ' · ${DateFormat('d MMM y').format(e.expenseDate)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _moneyFmt.format(e.amountMajor),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: e.status.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    e.status.label,
                    style: GoogleFonts.inter(
                      color: e.status.color,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
