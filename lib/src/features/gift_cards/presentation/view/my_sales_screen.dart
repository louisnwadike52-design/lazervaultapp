import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';

class MySalesScreen extends StatefulWidget {
  const MySalesScreen({super.key});

  @override
  State<MySalesScreen> createState() => _MySalesScreenState();
}

class _MySalesScreenState extends State<MySalesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = ['All', 'Pending', 'Approved', 'Paid', 'Rejected'];
  static const _statusFilters = [null, 'pending', 'approved', 'paid', 'rejected'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<GiftCardCubit>().loadMySales();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      context.read<GiftCardCubit>().loadMySales(
        status: _statusFilters[_tabController.index],
      );
    }
  }

  Future<void> _onRefresh() async {
    await context.read<GiftCardCubit>().loadMySales(
      status: _statusFilters[_tabController.index],
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        title: Text(
          'My Sales',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF3B82F6),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: const Color(0xFF3B82F6),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocBuilder<GiftCardCubit, GiftCardState>(
        builder: (context, state) {
          if (state is GiftCardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is MySalesLoaded) {
            return _buildSalesList(state.sales);
          }

          if (state is MySalesEmpty) {
            return _buildEmptyState();
          }

          if (state is GiftCardNetworkError) {
            return _buildErrorState(state.message);
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildSalesList(List<GiftCardSale> sales) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: sales.length,
        itemBuilder: (context, index) => _buildSaleCard(sales[index]),
      ),
    );
  }

  Widget _buildSaleCard(GiftCardSale sale) {
    return GestureDetector(
      onTap: () => _showSaleDetails(sale),
      child: Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sale.cardType.replaceAll('_', ' ').toUpperCase(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildStatusBadge(sale.status),
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
                    'Denomination',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '\$${sale.denomination.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${sale.ratePercentage.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Payout',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _formatCurrency(sale.expectedPayout),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (sale.submittedAt.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              _formatDate(sale.submittedAt),
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
    ),
    );
  }

  void _showSaleDetails(GiftCardSale sale) {
    // Refresh status from backend
    context.read<GiftCardCubit>().getSellStatus(sale.id);

    Get.bottomSheet(
      BlocBuilder<GiftCardCubit, GiftCardState>(
        builder: (context, state) {
          final displaySale = (state is SellStatusLoaded) ? state.sale : sale;
          return Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sale Details',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    _buildStatusBadge(displaySale.status),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildSaleDetailRow('Card Type', displaySale.cardType.replaceAll('_', ' ').toUpperCase()),
                SizedBox(height: 10.h),
                _buildSaleDetailRow('Card Number', displaySale.cardNumber.isNotEmpty ? '****${displaySale.cardNumber.substring(displaySale.cardNumber.length > 4 ? displaySale.cardNumber.length - 4 : 0)}' : 'N/A'),
                SizedBox(height: 10.h),
                _buildSaleDetailRow('Denomination', '\$${displaySale.denomination.toStringAsFixed(0)}'),
                SizedBox(height: 10.h),
                _buildSaleDetailRow('Rate', '${displaySale.ratePercentage.toStringAsFixed(0)}%'),
                SizedBox(height: 10.h),
                _buildSaleDetailRow('Expected Payout', _formatCurrency(displaySale.expectedPayout)),
                if (displaySale.actualPayout > 0) ...[
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Actual Payout', _formatCurrency(displaySale.actualPayout)),
                ],
                if (displaySale.reference.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Reference', displaySale.reference),
                ],
                if (displaySale.providerName.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Provider', displaySale.providerName),
                ],
                SizedBox(height: 10.h),
                _buildSaleDetailRow('Submitted', _formatDate(displaySale.submittedAt)),
                if (displaySale.paidAt.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Paid', _formatDate(displaySale.paidAt)),
                ],
                if (state is GiftCardLoading) ...[
                  SizedBox(height: 16.h),
                  const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Color(0xFF3B82F6),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Close',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildSaleDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case 'pending':
        bgColor = const Color(0xFFFB923C).withValues(alpha: 0.15);
        textColor = const Color(0xFFFB923C);
        label = 'Pending';
        break;
      case 'reviewing':
        bgColor = const Color(0xFF3B82F6).withValues(alpha: 0.15);
        textColor = const Color(0xFF3B82F6);
        label = 'Reviewing';
        break;
      case 'approved':
        bgColor = const Color(0xFF10B981).withValues(alpha: 0.15);
        textColor = const Color(0xFF10B981);
        label = 'Approved';
        break;
      case 'rejected':
        bgColor = const Color(0xFFEF4444).withValues(alpha: 0.15);
        textColor = const Color(0xFFEF4444);
        label = 'Rejected';
        break;
      case 'paid':
        bgColor = const Color(0xFF10B981).withValues(alpha: 0.15);
        textColor = const Color(0xFF10B981);
        label = 'Paid';
        break;
      case 'cancelled':
        bgColor = const Color(0xFF6B7280).withValues(alpha: 0.15);
        textColor = const Color(0xFF6B7280);
        label = 'Cancelled';
        break;
      default:
        bgColor = const Color(0xFF6B7280).withValues(alpha: 0.15);
        textColor = const Color(0xFF6B7280);
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(
                  Icons.sell_outlined,
                  size: 32.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Sales Yet',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your sold gift cards will appear here',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFFEF4444)),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
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

  String _formatCurrency(double amount) {
    if (amount >= 1000) {
      return 'NGN ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      )}';
    }
    return 'NGN ${amount.toStringAsFixed(2)}';
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }
}
