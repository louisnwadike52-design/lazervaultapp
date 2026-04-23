import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../cubit/water_bill_cubit.dart';
import '../cubit/water_bill_state.dart';
import '../widgets/water_history_actions_sheet.dart';

class WaterBillHistoryScreen extends StatefulWidget {
  const WaterBillHistoryScreen({super.key});

  @override
  State<WaterBillHistoryScreen> createState() => _WaterBillHistoryScreenState();
}

class _WaterBillHistoryScreenState extends State<WaterBillHistoryScreen> {
  // Optional filter args passed from the Saved Accounts "View Payments"
  // action. When set, the list is narrowed client-side to payments whose
  // customer_number (and provider_code, if provided) match. Without
  // these the screen behaves exactly as before: full history.
  String? _filterAccountNumber;
  String? _filterProviderCode;

  @override
  void initState() {
    super.initState();
    final raw = Get.arguments;
    if (raw is Map<String, dynamic>) {
      final acc = raw['accountNumber'];
      final code = raw['providerCode'];
      _filterAccountNumber = acc is String && acc.isNotEmpty ? acc : null;
      _filterProviderCode = code is String && code.isNotEmpty ? code : null;
    }
    context.read<WaterBillCubit>().getPaymentHistory();
  }

  // Narrow the full history list to rows matching the filter args (if any).
  // Keeps the filter client-side so the same cubit/repository feeds both
  // the landing strip's "View All" and the saved-account "View Payments".
  List<WaterPaymentEntity> _applyFilter(List<WaterPaymentEntity> rows) {
    if (_filterAccountNumber == null) return rows;
    final target = _filterAccountNumber!.trim();
    return rows.where((p) {
      if (p.customerNumber.trim() != target) return false;
      if (_filterProviderCode != null && _filterProviderCode!.isNotEmpty) {
        if (p.providerCode.toUpperCase() !=
            _filterProviderCode!.toUpperCase()) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocConsumer<WaterBillCubit, WaterBillState>(
                  listener: (context, state) {
                    if (state is WaterBillError) {
                      Get.snackbar(
                        'Error',
                        state.message,
                        backgroundColor: Colors.red.withValues(alpha: 0.9),
                        colorText: Colors.white,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PaymentHistoryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF3B82F6)),
                      );
                    }

                    if (state is PaymentHistoryLoaded) {
                      final filtered = _applyFilter(state.payments);
                      if (filtered.isEmpty) {
                        return _buildEmptyState();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<WaterBillCubit>().getPaymentHistory();
                        },
                        color: const Color(0xFF3B82F6),
                        child: ListView.separated(
                          padding: EdgeInsets.all(20.w),
                          itemCount: filtered.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final payment = filtered[index];
                            return _buildPaymentCard(payment);
                          },
                        ),
                      );
                    }

                    return _buildEmptyState();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment History',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'View all your water bill payments',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.receipt_long,
                color: Colors.white.withValues(alpha: 0.3),
                size: 56.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Payments Yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your water bill payment history will\nappear here once you make a payment',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3B82F6),
                      const Color(0xFF2563EB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Make a Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(WaterPaymentEntity payment) {
    // Unified with airtime / data / electricity via the shared
    // BillHistoryItem widget so every bill type renders with the same
    // per-row card, separators, and interactive affordances. Previously
    // water had its own bespoke layout that looked like one big shared
    // container — user feedback flagged the visual drift.
    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          _getStatusIcon(payment.status),
          color: const Color(0xFF3B82F6),
          size: 22.sp,
        ),
      ),
      title: payment.providerName.isNotEmpty
          ? payment.providerName
          : 'Water Bill',
      subtitle: payment.customerNumber.isNotEmpty
          ? payment.customerNumber
          : (payment.customerName.isNotEmpty
              ? payment.customerName
              : 'Account'),
      reference: payment.transactionReference,
      date: DateFormat('MMM dd, yyyy • hh:mm a')
          .format(payment.createdAt),
      amount: payment.amount,
      // BillHistoryItem takes a String status (same chip contract
      // airtime/data pass). Use the enum's name — the widget lowercases
      // and maps to its own chip colour palette internally.
      status: payment.status.name,
      onTap: () => WaterHistoryActionsSheet.show(context, payment),
    );
  }

  // _buildInfoChip, _formatStatus, _getStatusColor all became dead once
  // the row migrated to the shared BillHistoryItem widget — the widget
  // owns status chip colour + label formatting. Deleted to keep the
  // file focused on what's still used.

  IconData _getStatusIcon(WaterPaymentStatus status) {
    switch (status) {
      case WaterPaymentStatus.completed:
        return Icons.check_circle;
      case WaterPaymentStatus.processing:
        return Icons.hourglass_empty;
      case WaterPaymentStatus.pending:
        return Icons.pending;
      case WaterPaymentStatus.failed:
        return Icons.error;
      case WaterPaymentStatus.refunded:
        return Icons.replay;
    }
  }
}
