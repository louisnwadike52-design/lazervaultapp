import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crypto_entity.dart';

class CryptoCard extends StatelessWidget {
  final Crypto crypto;
  final VoidCallback onTap;

  const CryptoCard({
    super.key,
    required this.crypto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = crypto.priceChangePercentage24h >= 0;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2746),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
        ),
        child: Row(
          children: [
            // Crypto Icon/Image placeholder
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _getCryptoColor(crypto.symbol).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                _getCryptoIcon(crypto.symbol),
                color: _getCryptoColor(crypto.symbol),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            
            // Crypto Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        crypto.symbol,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      if (crypto.marketCapRank <= 10)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'TOP ${crypto.marketCapRank}',
                            style: GoogleFonts.inter(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    crypto.name,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Price Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${_formatPrice(crypto.currentPrice)}',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 14.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      return price.toStringAsFixed(0);
    } else if (price >= 1) {
      return price.toStringAsFixed(2);
    } else if (price >= 0.01) {
      return price.toStringAsFixed(4);
    } else {
      return price.toStringAsFixed(6);
    }
  }

  Color _getCryptoColor(String symbol) {
    switch (symbol.toLowerCase()) {
      case 'btc':
        return Colors.orange;
      case 'eth':
        return Colors.blue;
      case 'bnb':
        return Colors.yellow;
      case 'ada':
        return Colors.cyan;
      case 'sol':
        return Colors.purple;
      case 'doge':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  IconData _getCryptoIcon(String symbol) {
    switch (symbol.toLowerCase()) {
      case 'btc':
        return Icons.currency_bitcoin;
      case 'eth':
        return Icons.diamond;
      case 'bnb':
        return Icons.token;
      case 'ada':
        return Icons.account_balance;
      case 'sol':
        return Icons.wb_sunny;
      case 'doge':
        return Icons.pets;
      default:
        return Icons.currency_exchange;
    }
  }
} 