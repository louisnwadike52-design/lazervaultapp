import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

import '../../domain/entities/expense_entity.dart';
import '../cubit/expense_cubit.dart';
import '../cubit/expense_state.dart';

/// Landing screen for the Expense Tracking feature. Mirrors the
/// customer / inventory / tax landings — same status-filter pill row,
/// same canonical chat+voice icons (per-service `serviceName:
/// 'expenses'`) so BOTH the per-service routing (`DIRECT_ROUTES`) and
/// the general voice/chat (intent-classifier) reach the same chat
/// tools on chat-business-service.
class ExpensesListScreen extends StatefulWidget {
  const ExpensesListScreen({super.key});

  @override
  State<ExpensesListScreen> createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  final _searchController = TextEditingController();
  ExpenseStatus? _statusFilter;
  ExpenseCategory? _categoryFilter;

  static final _moneyFmt = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _load() {
    context.read<ExpenseCubit>().listExpenses(
          search: _searchController.text.trim().isEmpty
              ? null
              : _searchController.text.trim(),
          status: _statusFilter,
          category: _categoryFilter,
        );
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
          'Expenses',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // Per-service voice + chat icons — pin every session to the
          // expense tracking flow on chat-business-service via
          // DIRECT_ROUTES['expenses'] → primary 'expenses'. Same
          // pattern as customers / tax / inventory.
          ServiceVoiceButton(
            serviceName: 'expenses',
            iconColor: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Expenses',
            sourceContext: 'expenses',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildStatusFilters(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.toNamed(AppRoutes.addExpense);
          if (result == true && mounted) _load();
        },
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'Search description, vendor, or reference...',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (_) => _load(),
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
      height: 44.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: filters.entries
            .map((e) => _pill(e.key, _statusFilter == e.value, () {
                  setState(() => _statusFilter = e.value);
                  _load();
                }))
            .toList(),
      ),
    );
  }

  Widget _pill(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ExpenseCubit, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        } else if (state is ExpenseDeleted) {
          _load();
        }
      },
      buildWhen: (_, state) =>
          state is ExpenseLoading ||
          state is ExpensesLoaded ||
          state is ExpenseError,
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
          );
        }
        if (state is! ExpensesLoaded) {
          return Center(
            child: Text(
              'Pull to refresh',
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          );
        }
        if (state.expenses.isEmpty) {
          return _empty();
        }
        return RefreshIndicator(
          color: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFF1F1F1F),
          onRefresh: () async => _load(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20.w),
            itemCount: state.expenses.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (_, i) => _expenseTile(state.expenses[i]),
          ),
        );
      },
    );
  }

  Widget _empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_rounded,
              size: 64.sp, color: Colors.white24),
          SizedBox(height: 12.h),
          Text(
            'No expenses yet',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 16.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap + to record your first expense.',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 13.sp),
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
        if (result == true && mounted) _load();
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: e.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(e.category.icon, color: e.status.color, size: 22.sp),
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${e.category.label}'
                    '${e.vendor.isNotEmpty ? ' · ${e.vendor}' : ''}'
                    ' · ${DateFormat('yMMMd').format(e.expenseDate)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _moneyFmt.format(e.amountMajor),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: e.status.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    e.status.label,
                    style: GoogleFonts.inter(
                      color: e.status.color,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
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
