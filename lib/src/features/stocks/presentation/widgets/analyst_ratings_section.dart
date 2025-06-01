import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/stock_entity.dart';

class AnalystRatingsSection extends StatelessWidget {
  final Stock stock;
  final VoidCallback onSeeAll;

  const AnalystRatingsSection({
    super.key,
    required this.stock,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analyst ratings & price targets',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildConsensusCard(),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildPriceTargetCard(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConsensusCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consensus • 48 analysts',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Hold',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildRatingBar('Buy', 48, Colors.green),
          SizedBox(height: 8.h),
          _buildRatingBar('Hold', 31, Colors.grey),
          SizedBox(height: 8.h),
          _buildRatingBar('Sell', 21, Colors.red),
        ],
      ),
    );
  }

  Widget _buildPriceTargetCard() {
    final targetPrice = 299.38;
    final currentPrice = stock.currentPrice;
    final changePercent = ((targetPrice - currentPrice) / currentPrice) * 100;
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1y avg price target',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '\$${targetPrice.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                changePercent >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                color: changePercent >= 0 ? Colors.green : Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${changePercent.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  color: changePercent >= 0 ? Colors.green : Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.trending_down,
              color: Colors.red,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, int percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          '$percentage% $label',
          style: GoogleFonts.inter(
            color: Colors.grey[300],
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
} 