import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';

class SettlementHistoryScreen extends StatefulWidget {
  const SettlementHistoryScreen({super.key});

  @override
  State<SettlementHistoryScreen> createState() => _SettlementHistoryScreenState();
}

class _SettlementHistoryScreenState extends State<SettlementHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GiftCardCubit>().loadSettlementHistory();
  }

  Future<void> _onRefresh() async {
    await context.read<GiftCardCubit>().loadSettlementHistory();
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        title: Text(
          'Settlement History',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<GiftCardCubit, GiftCardState>(
        builder: (context, state) {
          if (state is GiftCardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is SettlementHistoryLoaded) {
            if (state.settlements.isEmpty) {
              return _buildEmptyState();
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: state.settlements.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final settlement = state.settlements[index];
                  return _buildSettlementCard(settlement);
                },
              ),
            );
          }

          if (state is GiftCardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _onRefresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      minimumSize: Size(120.w, 44.h),
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

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64.sp,
            color: const Color(0xFF2D2D2D),
          ),
          SizedBox(height: 16.h),
          Text(
            'No settlements yet',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettlementCard(dynamic settlement) {
    // Determine status color
    Color statusColor;
    String statusText;

    switch (settlement.status?.toLowerCase() ?? '') {
      case 'completed':
      case 'paid':
        statusColor = const Color(0xFF10B981);
        statusText = 'Completed';
        break;
      case 'pending':
        statusColor = const Color(0xFFF59E0B);
        statusText = 'Pending';
        break;
      case 'failed':
        statusColor = const Color(0xFFEF4444);
        statusText = 'Failed';
        break;
      default:
        statusColor = const Color(0xFF6B7280);
        statusText = settlement.status ?? 'Unknown';
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                settlement.brandName ?? 'Gift Card',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  statusText,
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${settlement.currency ?? 'NGN'} ${settlement.amount?.toStringAsFixed(2) ?? '0.00'}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Date',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    settlement.createdAt ?? '',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (settlement.reference != null) ...[
            SizedBox(height: 12.h),
            Divider(color: const Color(0xFF2D2D2D)),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.receipt,
                  size: 16.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Ref: ${settlement.reference}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
