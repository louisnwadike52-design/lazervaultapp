import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceStatisticsCard extends StatelessWidget {
  final Map<String, dynamic> statistics;

  const InvoiceStatisticsCard({
    super.key,
    required this.statistics,
  });

  String _currencySymbolFrom(BuildContext context) {
    try {
      final state = context.read<AccountCardsSummaryCubit>().state;
      if (state is AccountCardsSummaryLoaded && state.accountSummaries.isNotEmpty) {
        return _getCurrencySymbol(state.accountSummaries.first.currency);
      }
    } catch (_) {}
    return '\$';
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN': return '₦';
      case 'GBP': return '£';
      case 'EUR': return '€';
      case 'ZAR': return 'R';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      case 'INR': return '₹';
      case 'JPY': return '¥';
      case 'USD': return '\$';
      default: return '₦';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: InvoiceThemeColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sent Invoice Statistics',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildStatsGrid(context),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                'Total',
                statistics['total_invoices']?.toString() ?? '0',
                Icons.receipt_long,
                Colors.blue,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatItem(
                'Paid',
                statistics['paid_invoices']?.toString() ?? '0',
                Icons.check_circle,
                Colors.green,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatItem(
                'Pending',
                statistics['pending_invoices']?.toString() ?? '0',
                Icons.pending,
                Colors.orange,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatItem(
                'Overdue',
                statistics['overdue_invoices']?.toString() ?? '0',
                Icons.warning,
                Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.trending_up,
                color: InvoiceThemeColors.primaryPurple,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Collection Rate',
                      style: GoogleFonts.inter(
                        color: Colors.grey[300],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${(statistics['collection_rate'] ?? 0.0).toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        color: InvoiceThemeColors.primaryPurple,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Amount',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    '${_currencySymbolFrom(context)}${(statistics['total_amount'] ?? 0.0).toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 16.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 