import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/business/presentation/receipts/business_receipt.dart';

import '../../domain/entities/expense_entity.dart';
import '../cubit/expense_cubit.dart';
import '../cubit/expense_state.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final ExpenseEntity expense;
  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late ExpenseEntity _expense;
  // Set when an in-place mutation (approve/reimburse/delete) changes the record,
  // so backing out returns `true` and the list re-renders the new status.
  bool _didMutate = false;

  static final _moneyFmt = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    _expense = widget.expense;
  }

  UnifiedTransaction _expenseReceipt(ExpenseEntity e,
      {required String title, required bool moneyOut}) {
    return buildBusinessReceipt(
      type: TransactionServiceType.expense,
      title: title,
      amountMajor: e.amountMinor / 100.0,
      currency: e.currency,
      flow: moneyOut ? TransactionFlow.outgoing : TransactionFlow.neutral,
      status: UnifiedTransactionStatus.completed,
      reference: e.reference.isNotEmpty ? e.reference : null,
      counterpartyName: e.vendor.isNotEmpty ? e.vendor : null,
      description: e.description,
      metadata: {
        'Category': e.category.label,
        if (e.vendor.isNotEmpty) 'Vendor': e.vendor,
        if (e.reference.isNotEmpty) 'Reference': e.reference,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseCubit, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseLoaded) {
          setState(() => _expense = state.expense);
        } else if (state is ExpenseApproved) {
          setState(() {
            _expense = state.expense;
            _didMutate = true;
          });
          showBusinessReceipt(
            context,
            _expenseReceipt(state.expense,
                title: 'Expense approved', moneyOut: false),
          );
        } else if (state is ExpenseReimbursed) {
          setState(() {
            _expense = state.expense;
            _didMutate = true;
          });
          showBusinessReceipt(
            context,
            _expenseReceipt(state.expense,
                title: 'Expense reimbursed', moneyOut: true),
          );
        } else if (state is ExpenseDeleted) {
          Get.back(result: true);
          Get.snackbar('Deleted', 'Expense removed',
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white);
        } else if (state is ExpenseError) {
          Get.snackbar('Error', state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          // Return whether an in-place mutation happened so the list refreshes.
          if (!didPop) Get.back(result: _didMutate);
        },
        child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(result: _didMutate),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Expense',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () async {
                final cubit = context.read<ExpenseCubit>();
                final r = await Get.toNamed(
                  AppRoutes.editExpense,
                  arguments: _expense,
                );
                if (r == true) {
                  cubit.getExpense(_expense.id);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFFEF4444)),
              onPressed: _confirmDelete,
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20.w),
            children: [
              _headerCard(),
              SizedBox(height: 16.h),
              _detailsCard(),
              SizedBox(height: 16.h),
              _actionsCard(),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _headerCard() {
    final e = _expense;
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            e.status.color.withValues(alpha: 0.25),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46.w,
                height: 46.w,
                decoration: BoxDecoration(
                  color: e.category.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(e.category.icon,
                    color: e.category.color, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  e.description,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: e.status.color,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  e.status.label,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _moneyFmt.format(e.amountMajor),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            DateFormat('EEEE, MMMM d, y').format(e.expenseDate),
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsCard() {
    final e = _expense;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _row('Category', e.category.label, e.category.icon),
          _divider(),
          _row('Payment', e.paymentMethod.label, Icons.payment_rounded),
          if (e.vendor.isNotEmpty) ...[
            _divider(),
            _row('Vendor', e.vendor, Icons.store_rounded),
          ],
          if (e.reference.isNotEmpty) ...[
            _divider(),
            _row('Reference', e.reference, Icons.receipt_rounded),
          ],
          if (e.notes.isNotEmpty) ...[
            _divider(),
            _row('Notes', e.notes, Icons.notes_rounded),
          ],
          if (e.approvedAt != null) ...[
            _divider(),
            _row(
              'Approved',
              DateFormat('yMMMd jm').format(e.approvedAt!),
              Icons.check_circle_rounded,
            ),
          ],
          if (e.reimbursedAt != null) ...[
            _divider(),
            _row(
              'Reimbursed',
              DateFormat('yMMMd jm').format(e.reimbursedAt!),
              Icons.payments_rounded,
            ),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(color: Color(0xFF2D2D2D), height: 1);

  Widget _actionsCard() {
    final e = _expense;
    final canApprove = e.status == ExpenseStatus.pending;
    final canReimburse = e.status == ExpenseStatus.approved;
    if (!canApprove && !canReimburse) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        if (canApprove)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () =>
                  context.read<ExpenseCubit>().approveExpense(e.id),
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: Text('Approve',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        if (canReimburse)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () =>
                  context.read<ExpenseCubit>().markReimbursed(e.id),
              icon: const Icon(Icons.payments, color: Colors.white),
              label: Text('Mark reimbursed',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.successGreen,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _confirmDelete() {
    // Capture the cubit BEFORE the async gap so the post-dialog
    // callback doesn't lean on `context` if the widget unmounts.
    final cubit = context.read<ExpenseCubit>();
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Delete expense?',
            style: GoogleFonts.inter(color: Colors.white)),
        content: Text(
          'This permanently removes the expense record.',
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        cubit.deleteExpense(_expense.id);
      }
    });
  }
}
