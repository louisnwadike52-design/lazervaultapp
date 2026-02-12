import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';

class GiftCardTransactionsScreen extends StatefulWidget {
  const GiftCardTransactionsScreen({super.key});

  @override
  State<GiftCardTransactionsScreen> createState() =>
      _GiftCardTransactionsScreenState();
}

class _GiftCardTransactionsScreenState
    extends State<GiftCardTransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;

  @override
  void initState() {
    super.initState();
    context.read<GiftCardCubit>().loadGiftCardHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<GiftCardCubit>().loadGiftCardHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildFilterChips(),
            Expanded(
              child: BlocBuilder<GiftCardCubit, GiftCardState>(
                builder: (context, state) {
                  if (state is GiftCardLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF3B82F6),
                        strokeWidth: 2.5,
                      ),
                    );
                  } else if (state is GiftCardTransactionsLoaded) {
                    return _buildTransactionsList(state.transactions);
                  } else if (state is GiftCardError) {
                    return _buildErrorView(state.message);
                  }
                  return _buildEmptyState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              'Transaction History',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: _showExportDialog,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.download_rounded,
                  color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search transactions...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Purchase', 'Redeem', 'Transfer', 'Sell'];

    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 12.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final filterValue = filter == 'All' ? null : filter.toLowerCase();
          final isSelected = _selectedFilter == filterValue;

          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filterValue;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionsList(List<GiftCardTransaction> transactions) {
    var filtered = transactions;

    if (_selectedFilter != null) {
      filtered = filtered
          .where((t) =>
              t.transactionType.toLowerCase() ==
              _selectedFilter!.toLowerCase())
          .toList();
    }

    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered.where((t) {
        return t.description.toLowerCase().contains(query) ||
            t.reference.toLowerCase().contains(query);
      }).toList();
    }

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          return _buildTransactionCard(filtered[index]);
        },
      ),
    );
  }

  Widget _buildTransactionCard(GiftCardTransaction transaction) {
    return GestureDetector(
      onTap: () => _showTransactionDetails(transaction),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            _buildTransactionIcon(transaction.transactionType),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description.isNotEmpty
                        ? transaction.description
                        : _getTransactionTypeLabel(
                            transaction.transactionType),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatCreatedAt(transaction.createdAt),
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _formatTransactionAmount(transaction),
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: _isCredit(transaction.transactionType)
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionIcon(String type) {
    final IconData icon;
    final Color color;

    switch (type.toLowerCase()) {
      case 'purchase':
        icon = Icons.shopping_cart_rounded;
        color = const Color(0xFF3B82F6);
        break;
      case 'redeem':
        icon = Icons.redeem_rounded;
        color = const Color(0xFF10B981);
        break;
      case 'transfer':
        icon = Icons.send_rounded;
        color = const Color(0xFFFB923C);
        break;
      case 'sell':
        icon = Icons.sell_rounded;
        color = const Color(0xFF8B5CF6);
        break;
      default:
        icon = Icons.receipt_long_rounded;
        color = const Color(0xFF9CA3AF);
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }

  Widget _buildErrorView(String message) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 40.sp,
                  color: const Color(0xFFEF4444),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Failed to load transactions',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _onRefresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Try Again',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  size: 40.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Transactions',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _selectedFilter != null
                    ? 'No $_selectedFilter transactions found'
                    : 'Your transaction history will appear here',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatCreatedAt(String createdAt) {
    if (createdAt.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(createdAt);
      final day = dateTime.day.toString().padLeft(2, '0');
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final month = months[dateTime.month - 1];
      final year = dateTime.year;
      final hour = dateTime.hour > 12
          ? dateTime.hour - 12
          : (dateTime.hour == 0 ? 12 : dateTime.hour);
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';
      return '$month $day, $year \u2022 ${hour.toString().padLeft(2, '0')}:$minute $period';
    } catch (_) {
      return createdAt;
    }
  }

  String _getTransactionTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'purchase':
        return 'Gift card purchased';
      case 'redeem':
        return 'Gift card redeemed';
      case 'transfer':
        return 'Gift card transferred';
      case 'sell':
        return 'Gift card sold';
      default:
        return 'Transaction';
    }
  }

  bool _isCredit(String type) {
    final t = type.toLowerCase();
    return t == 'sell' || t == 'redeem';
  }

  String _formatTransactionAmount(GiftCardTransaction transaction) {
    final prefix = _isCredit(transaction.transactionType) ? '+' : '-';
    return '$prefix\$${transaction.amount.toStringAsFixed(2)}';
  }

  void _showTransactionDetails(GiftCardTransaction transaction) {
    Get.bottomSheet(
      Container(
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
            Text(
              'Transaction Details',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            _buildDetailRow('Transaction ID', transaction.id),
            SizedBox(height: 10.h),
            _buildDetailRow(
                'Reference',
                transaction.reference.isNotEmpty
                    ? transaction.reference
                    : 'N/A'),
            SizedBox(height: 10.h),
            _buildDetailRow(
                'Type', _getTransactionTypeLabel(transaction.transactionType)),
            SizedBox(height: 10.h),
            _buildDetailRow(
                'Amount', '\$${transaction.amount.toStringAsFixed(2)}'),
            SizedBox(height: 10.h),
            _buildDetailRow('Date', _formatCreatedAt(transaction.createdAt)),
            if (transaction.description.isNotEmpty) ...[
              SizedBox(height: 10.h),
              _buildDetailRow('Description', transaction.description),
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
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailRow(String label, String value) {
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

  void _showExportDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Text(
              'Export Transactions',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            _buildExportOption(
              'Export as PDF',
              Icons.picture_as_pdf_rounded,
              const Color(0xFFEF4444),
              () {
                Get.back();
                Get.snackbar(
                  'Exporting',
                  'Generating PDF report...',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor:
                      const Color(0xFFEF4444).withValues(alpha: 0.9),
                  colorText: Colors.white,
                  borderRadius: 12.r,
                  margin: EdgeInsets.all(16.w),
                );
              },
            ),
            SizedBox(height: 10.h),
            _buildExportOption(
              'Export as CSV',
              Icons.table_chart_rounded,
              const Color(0xFF10B981),
              () {
                Get.back();
                Get.snackbar(
                  'Exporting',
                  'Generating CSV file...',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor:
                      const Color(0xFF10B981).withValues(alpha: 0.9),
                  colorText: Colors.white,
                  borderRadius: 12.r,
                  margin: EdgeInsets.all(16.w),
                );
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildExportOption(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF9CA3AF),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
