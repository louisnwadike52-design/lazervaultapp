import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/inventory_enhanced_cubit.dart';
import '../cubit/inventory_enhanced_state.dart';

class InventoryValuationScreen extends StatefulWidget {
  const InventoryValuationScreen({super.key});

  @override
  State<InventoryValuationScreen> createState() =>
      _InventoryValuationScreenState();
}

class _InventoryValuationScreenState extends State<InventoryValuationScreen> {
  @override
  void initState() {
    super.initState();
    _loadValuation();
  }

  void _loadValuation() {
    context.read<InventoryEnhancedCubit>().getInventoryValuation();
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
          'Inventory Valuation',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<InventoryEnhancedCubit, InventoryEnhancedState>(
      listener: (context, state) {
        if (state is InventoryEnhancedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is InventoryEnhancedLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is ValuationLoaded) {
          return _buildValuationContent(state.data);
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Valuation Content
  // ---------------------------------------------------------------------------

  Widget _buildValuationContent(Map<String, dynamic> data) {
    final totalValue = (data['totalValue'] as num?)?.toDouble() ?? 0.0;
    final totalItems = (data['totalItems'] as num?)?.toInt() ?? 0;
    final categories =
        (data['categories'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];

    return RefreshIndicator(
      onRefresh: () async => _loadValuation(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        children: [
          _buildSummaryCard(totalValue, totalItems),
          SizedBox(height: 20.h),
          Text(
            'Category Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          if (categories.isEmpty)
            _buildNoCategoriesMessage()
          else
            ...categories.map((cat) => _buildCategoryRow(cat, totalValue)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Summary Card
  // ---------------------------------------------------------------------------

  Widget _buildSummaryCard(double totalValue, int totalItems) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            color: const Color(0xFF3B82F6),
            size: 36.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'Total Inventory Value',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '\u20A6${_formatCurrency(totalValue)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '$totalItems item${totalItems != 1 ? 's' : ''} in inventory',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Category Row
  // ---------------------------------------------------------------------------

  Widget _buildCategoryRow(Map<String, dynamic> category, double totalValue) {
    final catName = category['category'] as String? ?? 'Unknown';
    final itemCount = (category['itemCount'] as num?)?.toInt() ?? 0;
    final catValue = (category['totalValue'] as num?)?.toDouble() ?? 0.0;
    final percentage = (category['percentage'] as num?)?.toDouble() ?? 0.0;
    final barFraction = (percentage / 100.0).clamp(0.0, 1.0);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  catName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '\u20A6${_formatCurrency(catValue)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Text(
                '$itemCount item${itemCount != 1 ? 's' : ''}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
              const Spacer(),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Percentage bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: barFraction,
              minHeight: 6.h,
              backgroundColor: const Color(0xFF2D2D2D),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // No Categories
  // ---------------------------------------------------------------------------

  Widget _buildNoCategoriesMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          Icon(
            Icons.category_outlined,
            color: const Color(0xFF2D2D2D),
            size: 48.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'No category data available',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadValuation(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.analytics_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No valuation data',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add inventory items to see valuation',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _formatCurrency(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)}K';
    }
    return value.toStringAsFixed(2);
  }
}
