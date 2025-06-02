import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crypto_entity.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final List<CryptoHolding> holdings;

  const PortfolioSummaryCard({
    super.key,
    required this.holdings,
  });

  double get totalValue {
    return holdings.fold(0.0, (sum, holding) => sum + holding.totalValue);
  }

  double get totalProfitLoss {
    return holdings.fold(0.0, (sum, holding) => sum + holding.totalGainLoss);
  }

  double get profitLossPercentage {
    final totalCost = totalValue - totalProfitLoss;
    return totalCost > 0 ? (totalProfitLoss / totalCost) * 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    if (holdings.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2746),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white.withOpacity(0.6),
              size: 48.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Start Your Portfolio',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Buy your first cryptocurrency to begin building your digital asset portfolio',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7),
            const Color(0xFF74B9FF),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio Value',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${holdings.length} Asset${holdings.length != 1 ? 's' : ''}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '\$${totalValue.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                totalProfitLoss >= 0 ? Icons.trending_up : Icons.trending_down,
                color: totalProfitLoss >= 0 ? Colors.green : Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${totalProfitLoss >= 0 ? '+' : ''}\$${totalProfitLoss.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: totalProfitLoss >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '(${profitLossPercentage >= 0 ? '+' : ''}${profitLossPercentage.toStringAsFixed(2)}%)',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'Top Holdings',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          ...holdings.take(3).map((holding) => _buildHoldingItem(holding)),
          if (holdings.length > 3)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                '+${holdings.length - 3} more assets',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHoldingItem(CryptoHolding holding) {
    final percentage = totalValue > 0 ? (holding.totalValue / totalValue) * 100 : 0.0;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                holding.cryptoSymbol.substring(0, 1).toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holding.cryptoSymbol.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${holding.quantity.toStringAsFixed(4)} coins',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${holding.totalValue.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 