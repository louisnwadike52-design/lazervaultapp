import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 1: Set target allocation percentages
class RebalanceAllocationScreen extends StatefulWidget {
  final String strategy;
  final Map<String, double> targetAllocations;
  final Map<String, double> currentAllocations;
  final List<StockHolding> holdings;
  final Function(String) onStrategyChanged;
  final Function(Map<String, double>) onAllocationChanged;

  const RebalanceAllocationScreen({
    super.key,
    required this.strategy,
    required this.targetAllocations,
    required this.currentAllocations,
    required this.holdings,
    required this.onStrategyChanged,
    required this.onAllocationChanged,
  });

  @override
  State<RebalanceAllocationScreen> createState() => _RebalanceAllocationScreenState();
}

class _RebalanceAllocationScreenState extends State<RebalanceAllocationScreen> {
  late Map<String, double> _localAllocations;

  final List<Map<String, dynamic>> _strategies = [
    {
      'name': 'Conservative',
      'icon': Icons.shield,
      'description': 'Equal weight distribution for stability',
    },
    {
      'name': 'Balanced',
      'icon': Icons.balance,
      'description': 'Balanced approach with equal allocations',
    },
    {
      'name': 'Aggressive',
      'icon': Icons.trending_up,
      'description': 'Growth-focused allocation strategy',
    },
    {
      'name': 'Custom',
      'icon': Icons.tune,
      'description': 'Customize your own target allocations',
    },
  ];

  @override
  void initState() {
    super.initState();
    _localAllocations = Map.from(widget.targetAllocations);
  }

  double get _totalAllocation {
    return _localAllocations.values.fold(0.0, (sum, val) => sum + val);
  }

  void _updateAllocation(String symbol, double value) {
    setState(() {
      _localAllocations[symbol] = value;
    });
    widget.onAllocationChanged(_localAllocations);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Rebalancing Strategy',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose a preset strategy or customize your own',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 24.h),

          // Strategy cards
          ..._strategies.map((strategy) {
            final isSelected = widget.strategy == strategy['name'];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isSelected
                      ? [
                          const Color(0xFF6366F1).withValues(alpha: 0.3),
                          const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                        ]
                      : [
                          const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                          const Color(0xFF1F1F35).withValues(alpha: 0.9),
                        ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.white.withValues(alpha: 0.1),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () => widget.onStrategyChanged(strategy['name']),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            strategy['icon'],
                            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[400],
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                strategy['name'],
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                strategy['description'],
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF6366F1),
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),

          SizedBox(height: 32.h),

          // Current vs Target Allocation
          Text(
            'Portfolio Allocation',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          // Allocation cards for each holding
          ...widget.holdings.map((holding) {
            final currentAllocation = widget.currentAllocations[holding.symbol] ?? 0.0;
            final targetAllocation = _localAllocations[holding.symbol] ?? 0.0;
            final isCustom = widget.strategy == 'Custom';

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2A2A3E).withValues(alpha: 0.6),
                    const Color(0xFF1F1F35).withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        holding.symbol,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (!isCustom)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${targetAllocation.toStringAsFixed(1)}%',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Current allocation bar
                  Row(
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          'Current',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: currentAllocation / 100,
                              child: Container(
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: 50.w,
                        child: Text(
                          '${currentAllocation.toStringAsFixed(1)}%',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.grey[400],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Target allocation bar (with slider if custom)
                  if (isCustom)
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: Text(
                                'Target',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: targetAllocation,
                                min: 0,
                                max: 100,
                                divisions: 100,
                                activeColor: const Color(0xFF6366F1),
                                inactiveColor: Colors.white.withValues(alpha: 0.1),
                                onChanged: (value) {
                                  _updateAllocation(holding.symbol, value);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
                              child: Text(
                                '${targetAllocation.toStringAsFixed(1)}%',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6366F1),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        SizedBox(
                          width: 80.w,
                          child: Text(
                            'Target',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: targetAllocation / 100,
                                child: Container(
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            '${targetAllocation.toStringAsFixed(1)}%',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6366F1),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }).toList(),

          SizedBox(height: 16.h),

          // Total allocation indicator
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: (_totalAllocation - 100.0).abs() < 0.1
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: (_totalAllocation - 100.0).abs() < 0.1
                    ? Colors.green.withValues(alpha: 0.3)
                    : Colors.orange.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      (_totalAllocation - 100.0).abs() < 0.1
                          ? Icons.check_circle
                          : Icons.warning_amber,
                      color: (_totalAllocation - 100.0).abs() < 0.1
                          ? Colors.green
                          : Colors.orange,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Total Allocation',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: (_totalAllocation - 100.0).abs() < 0.1
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_totalAllocation.toStringAsFixed(1)}%',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: (_totalAllocation - 100.0).abs() < 0.1
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
