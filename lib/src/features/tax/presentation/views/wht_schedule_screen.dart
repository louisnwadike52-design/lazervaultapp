import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';
import 'record_wht_screen.dart';

/// WHT schedule: the withholding-tax deductions recorded for a period, with the
/// total withheld. A "+" opens Record WHT and refreshes on return. Self-contained
/// cubit so it doesn't collide with the tax dashboard's state.
class WHTScheduleScreen extends StatefulWidget {
  const WHTScheduleScreen({super.key});

  @override
  State<WHTScheduleScreen> createState() => _WHTScheduleScreenState();
}

class _WHTScheduleScreenState extends State<WHTScheduleScreen> {
  late final TaxCubit _cubit;
  late String _period;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _period = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    _cubit = serviceLocator<TaxCubit>()..getWHTSchedule(_period);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _openRecord() async {
    final result = await Get.to(() => BlocProvider.value(
          value: _cubit,
          child: const RecordWHTScreen(),
        ));
    if (result == true) _cubit.getWHTSchedule(_period);
  }

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2);
    final dateFmt = DateFormat('dd MMM yyyy');

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('WHT Schedule',
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _openRecord,
              icon: const Icon(Icons.add, color: Color(0xFF3B82F6)),
              tooltip: 'Record WHT',
            ),
          ],
        ),
        body: BlocBuilder<TaxCubit, TaxState>(
          builder: (context, state) {
            if (state is TaxLoading || state is TaxInitial) {
              return const Center(child: LazerVaultLoader());
            }
            if (state is TaxError) {
              return _error(state.message);
            }
            if (state is WHTScheduleLoaded) {
              final entries = (state.data['entries'] as List?) ?? const [];
              final total = (state.data['totalWhtAmount'] as num?)?.toDouble() ?? 0;
              return RefreshIndicator(
                onRefresh: () async => _cubit.getWHTSchedule(_period),
                color: const Color(0xFF3B82F6),
                backgroundColor: const Color(0xFF1F1F1F),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20.w),
                  children: [
                    _totalCard(_period, total, money),
                    SizedBox(height: 16.h),
                    if (entries.isEmpty)
                      _empty()
                    else
                      ...entries.map((e) => _row(
                          (e as Map).cast<String, dynamic>(), money, dateFmt)),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _totalCard(String period, double total, NumberFormat money) => Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(14.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total withheld',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
                SizedBox(height: 4.h),
                Text(period,
                    style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280), fontSize: 11.sp)),
              ],
            ),
            Text(money.format(total),
                style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      );

  Widget _row(Map<String, dynamic> e, NumberFormat money, DateFormat dateFmt) {
    DateTime? date;
    final ds = e['transactionDate'] as String?;
    if (ds != null && ds.isNotEmpty) date = DateTime.tryParse(ds);
    final rate = (e['whtRate'] as num?)?.toDouble() ?? 0;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((e['vendorName'] as String?) ?? 'Vendor',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 13.5.sp),
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 2.h),
                Text(
                  '${rate % 1 == 0 ? rate.toStringAsFixed(0) : rate.toStringAsFixed(1)}% on ${money.format((e['paymentAmount'] as num?)?.toDouble() ?? 0)}${date != null ? ' • ${dateFmt.format(date)}' : ''}',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(money.format((e['whtAmount'] as num?)?.toDouble() ?? 0),
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _empty() => Padding(
        padding: EdgeInsets.only(top: 80.h),
        child: Column(
          children: [
            Icon(Icons.account_balance_outlined,
                color: const Color(0xFF2D2D2D), size: 56.sp),
            SizedBox(height: 12.h),
            Text('No WHT recorded for this period',
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
            SizedBox(height: 12.h),
            TextButton.icon(
              onPressed: _openRecord,
              icon: const Icon(Icons.add, size: 18, color: Color(0xFF3B82F6)),
              label: Text('Record WHT',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );

  Widget _error(String message) => Center(
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
                onPressed: () => _cubit.getWHTSchedule(_period),
                icon: const Icon(Icons.refresh_rounded, size: 18, color: Color(0xFF3B82F6)),
                label: Text('Retry',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      );
}
