import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crypto_entity.dart';

class CryptoSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final Function(Crypto) onCryptoSelected;
  final List<Crypto> searchResults;
  final bool isLoading;

  const CryptoSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onCryptoSelected,
    this.searchResults = const [],
    this.isLoading = false,
  });

  @override
  State<CryptoSearchBar> createState() => _CryptoSearchBarState();
}

class _CryptoSearchBarState extends State<CryptoSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showResults = _focusNode.hasFocus && widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchHeader(),
        SizedBox(height: 20.h),
        _buildSearchInput(),
        SizedBox(height: 16.h),
        Expanded(
          child: _buildSearchResults(),
        ),
      ],
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.search,
              color: const Color(0xFF6C5CE7),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Cryptocurrencies',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Find and explore digital assets',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2746),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: _focusNode.hasFocus
                ? const Color(0xFF6C5CE7).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.15),
            blurRadius: _focusNode.hasFocus ? 12 : 6,
            offset: Offset(0, _focusNode.hasFocus ? 4 : 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search by name or symbol (e.g., Bitcoin, BTC)',
          hintStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.5),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.6),
              size: 20.sp,
            ),
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    widget.onSearch('');
                    setState(() {
                      _showResults = false;
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 20.sp,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
        onChanged: (value) {
          widget.onSearch(value);
          setState(() {
            _showResults = value.isNotEmpty;
          });
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    if (!_showResults || widget.controller.text.isEmpty) {
      return _buildSearchSuggestions();
    }

    if (widget.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C5CE7)),
            ),
            SizedBox(height: 16.h),
            Text(
              'Searching...',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    if (widget.searchResults.isEmpty) {
      return _buildNoResults();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: widget.searchResults.length,
      itemBuilder: (context, index) {
        final crypto = widget.searchResults[index];
        return _buildSearchResultItem(crypto);
      },
    );
  }

  Widget _buildSearchSuggestions() {
    final suggestions = [
      {'name': 'Bitcoin', 'symbol': 'BTC', 'color': Colors.orange},
      {'name': 'Ethereum', 'symbol': 'ETH', 'color': Colors.blue},
      {'name': 'Cardano', 'symbol': 'ADA', 'color': Colors.blue},
      {'name': 'Solana', 'symbol': 'SOL', 'color': Colors.purple},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Cryptocurrencies',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ...suggestions.map((suggestion) => _buildSuggestionItem(
            suggestion['name'] as String,
            suggestion['symbol'] as String,
            suggestion['color'] as Color,
          )),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: const Color(0xFF6C5CE7),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Tip: You can search by cryptocurrency name or symbol',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String name, String symbol, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        onTap: () {
          widget.controller.text = name;
          widget.onSearch(name);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        leading: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Text(
              symbol.substring(0, 1),
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          symbol,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white.withValues(alpha: 0.3),
          size: 14.sp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        tileColor: Colors.transparent,
        hoverColor: const Color(0xFF1E2746),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            color: Colors.white.withValues(alpha: 0.4),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No cryptocurrencies found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try searching with a different name or symbol',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(Crypto crypto) {
    final isPositive = crypto.priceChangePercentage24h >= 0;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          widget.onCryptoSelected(crypto);
          Navigator.of(context).pop();
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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