import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crypto_entity.dart';

class WatchlistSection extends StatelessWidget {
  final CryptoWatchlist watchlist;
  final List<Crypto> cryptos;
  final Function(Crypto) onCryptoTap;
  final Function(String, String)? onRemoveFromWatchlist;
  final Function(String)? onDeleteWatchlist;

  const WatchlistSection({
    super.key,
    required this.watchlist,
    required this.cryptos,
    required this.onCryptoTap,
    this.onRemoveFromWatchlist,
    this.onDeleteWatchlist,
  });

  List<Crypto> get watchlistCryptos {
    return cryptos.where((crypto) => watchlist.cryptoIds.contains(crypto.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWatchlistHeader(),
          if (watchlistCryptos.isEmpty)
            _buildEmptyWatchlist()
          else
            ...watchlistCryptos.map((crypto) => _buildWatchlistItem(crypto)),
        ],
      ),
    );
  }

  Widget _buildWatchlistHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.bookmark,
              color: const Color(0xFF6C5CE7),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  watchlist.name,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (watchlist.description.isNotEmpty)
                  Text(
                    watchlist.description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${watchlistCryptos.length} asset${watchlistCryptos.length != 1 ? 's' : ''}',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
            color: const Color(0xFF2D2D2D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Delete Watchlist',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                onDeleteWatchlist?.call(watchlist.id);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWatchlist() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Icon(
            Icons.visibility_off,
            color: Colors.white.withValues(alpha: 0.4),
            size: 32.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'No cryptos in this watchlist',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Add cryptocurrencies to track their performance',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistItem(Crypto crypto) {
    final isPositive = crypto.priceChangePercentage24h >= 0;
    
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: () => onCryptoTap(crypto),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: _getCryptoColor(crypto.symbol).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              crypto.symbol.substring(0, 1).toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: _getCryptoColor(crypto.symbol),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${crypto.symbol.toUpperCase()} • ${crypto.name}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Rank #${crypto.marketCapRank}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${crypto.currentPrice.toStringAsFixed(crypto.currentPrice < 1 ? 4 : 2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
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
                      size: 12.sp,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${isPositive ? '+' : ''}${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white.withValues(alpha: 0.6),
            size: 18.sp,
          ),
          onPressed: () => onRemoveFromWatchlist?.call(watchlist.id, crypto.id),
        ),
      ),
    );
  }

  Color _getCryptoColor(String symbol) {
    final colors = {
      'BTC': Colors.orange,
      'ETH': Colors.blue,
      'ADA': Colors.blue,
      'SOL': Colors.purple,
      'DOGE': Colors.yellow,
      'DOT': Colors.pink,
      'MATIC': Colors.indigo,
      'LINK': Colors.blue,
    };
    
    return colors[symbol.toUpperCase()] ?? Colors.grey;
  }
} 