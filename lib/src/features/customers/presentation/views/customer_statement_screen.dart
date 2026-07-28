import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import '../cubit/customer_cubit.dart';
import '../cubit/customer_state.dart';

/// Account statement for a single customer, derived from the sales ledger by the
/// backend (INVOICE = unpaid receivable, PAYMENT = settled sale) with a running
/// balance. Self-contained: owns its own [CustomerCubit] so it never clashes with
/// the details screen's financial-profile state.
class CustomerStatementScreen extends StatelessWidget {
  final CustomerEntity customer;
  const CustomerStatementScreen({super.key, required this.customer});

  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _accent = Color(0xFFA78BFA);

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2);
    final dateFmt = DateFormat('dd MMM yyyy');

    return BlocProvider(
      create: (_) =>
          serviceLocator<CustomerCubit>()..getStatement(customerId: customer.id),
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Statement',
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            if (state is CustomerLoading || state is CustomerInitial) {
              return const Center(child: LazerVaultLoader());
            }
            if (state is CustomerError) {
              return _error(context, state.message, customer.id);
            }
            if (state is StatementLoaded) {
              final entries = (state.data['entries'] as List?) ?? const [];
              final opening = (state.data['openingBalance'] as num?)?.toDouble() ?? 0;
              final closing = (state.data['closingBalance'] as num?)?.toDouble() ?? 0;
              return ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  _summaryCard(customer.name, opening, closing, money),
                  SizedBox(height: 16.h),
                  if (entries.isEmpty)
                    _empty()
                  else
                    ...entries.map((e) => _entryRow(
                        (e as Map).cast<String, dynamic>(), money, dateFmt)),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _summaryCard(String name, double opening, double closing, NumberFormat money) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(14.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 12.h),
          _kv('Opening balance', money.format(opening), Colors.white),
          SizedBox(height: 6.h),
          _kv('Outstanding (closing)', money.format(closing),
              closing > 0 ? const Color(0xFFFB923C) : const Color(0xFF10B981)),
        ],
      ),
    );
  }

  Widget _kv(String k, String v, Color valueColor) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k,
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          Text(v,
              style: GoogleFonts.inter(
                  color: valueColor, fontSize: 14.sp, fontWeight: FontWeight.w600)),
        ],
      );

  Widget _entryRow(Map<String, dynamic> e, NumberFormat money, DateFormat dateFmt) {
    final isInvoice = (e['type'] as String?) == 'INVOICE';
    DateTime? date;
    final ds = e['date'] as String?;
    if (ds != null && ds.isNotEmpty) date = DateTime.tryParse(ds);
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: (isInvoice ? const Color(0xFFFB923C) : const Color(0xFF10B981))
                  .withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isInvoice ? Icons.receipt_long_rounded : Icons.check_circle_rounded,
              color: isInvoice ? const Color(0xFFFB923C) : const Color(0xFF10B981),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (e['description'] as String?)?.isNotEmpty == true
                      ? e['description'] as String
                      : (isInvoice ? 'Sale (unpaid)' : 'Sale (paid)'),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13.5.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  '${e['reference'] ?? ''}${date != null ? ' • ${dateFmt.format(date)}' : ''}',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(money.format((e['amount'] as num?)?.toDouble() ?? 0),
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 2.h),
              Text('Bal ${money.format((e['balance'] as num?)?.toDouble() ?? 0)}',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280), fontSize: 10.5.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _empty() => Padding(
        padding: EdgeInsets.only(top: 80.h),
        child: Column(
          children: [
            Icon(Icons.description_outlined,
                color: const Color(0xFF2D2D2D), size: 56.sp),
            SizedBox(height: 12.h),
            Text('No transactions yet',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          ],
        ),
      );

  Widget _error(BuildContext context, String message, String customerId) => Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_rounded,
                  color: const Color(0xFF9CA3AF), size: 40.sp),
              SizedBox(height: 12.h),
              Text(message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
              SizedBox(height: 12.h),
              TextButton.icon(
                onPressed: () =>
                    context.read<CustomerCubit>().getStatement(customerId: customerId),
                icon: Icon(Icons.refresh_rounded, size: 18.sp, color: _accent),
                label: Text('Retry',
                    style: GoogleFonts.inter(
                        color: _accent, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      );
}
