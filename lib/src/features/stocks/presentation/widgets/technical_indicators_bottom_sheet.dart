import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalIndicatorsBottomSheet extends StatefulWidget {
  final List<String> availableIndicators;
  final List<String> selectedIndicators;
  final Function(List<String>) onIndicatorsChanged;

  const TechnicalIndicatorsBottomSheet({
    super.key,
    required this.availableIndicators,
    required this.selectedIndicators,
    required this.onIndicatorsChanged,
  });

  @override
  State<TechnicalIndicatorsBottomSheet> createState() => _TechnicalIndicatorsBottomSheetState();
}

class _TechnicalIndicatorsBottomSheetState extends State<TechnicalIndicatorsBottomSheet> {
  late List<String> _tempSelectedIndicators;

  @override
  void initState() {
    super.initState();
    _tempSelectedIndicators = List.from(widget.selectedIndicators);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Technical Indicators',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Select indicators to overlay on your chart',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Scrollable indicators list
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: widget.availableIndicators.map((indicator) => 
                  _buildIndicatorTile(indicator)
                ).toList(),
              ),
            ),
          ),
          
          // Action buttons
          Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[600]!),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _tempSelectedIndicators.clear();
                            });
                          },
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: TextButton(
                          onPressed: () {
                            widget.onIndicatorsChanged(_tempSelectedIndicators);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Apply',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorTile(String indicator) {
    final isSelected = _tempSelectedIndicators.contains(indicator);
    
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                _tempSelectedIndicators.remove(indicator);
              } else {
                _tempSelectedIndicators.add(indicator);
              }
            });
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: isSelected ? Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ) : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, color: Colors.black, size: 16.sp)
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        indicator,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        _getIndicatorDescription(indicator),
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Active',
                      style: GoogleFonts.inter(
                        color: Colors.green,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getIndicatorDescription(String indicator) {
    switch (indicator) {
      case 'SMA':
        return 'Simple Moving Average - Smoothed price trend';
      case 'EMA':
        return 'Exponential Moving Average - Weighted recent prices';
      case 'MACD':
        return 'Moving Average Convergence Divergence - Momentum';
      case 'RSI':
        return 'Relative Strength Index - Overbought/oversold';
      case 'Bollinger Bands':
        return 'Volatility bands around moving average';
      case 'Volume':
        return 'Trading volume overlay';
      case 'Stochastic':
        return 'Momentum oscillator comparing closing price';
      default:
        return 'Technical analysis indicator';
    }
  }
} 