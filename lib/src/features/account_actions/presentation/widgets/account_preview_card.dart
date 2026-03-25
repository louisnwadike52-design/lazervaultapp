import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Compact account preview card shown at the top of the bottom sheet
class AccountPreviewCard extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final String currencySymbol;

  const AccountPreviewCard({
    super.key,
    required this.accountArgs,
    required this.currencySymbol,
  });

  @override
  Widget build(BuildContext context) {
    final balance = (accountArgs['balance'] as double?) ?? 0.0;
    final availableBalance = (accountArgs['availableBalance'] as double?) ?? balance;
    final reservedBalance = (accountArgs['reservedBalance'] as double?) ?? 0.0;
    final currency = (accountArgs['currency'] as String?) ?? 'NGN';
    final status = (accountArgs['status'] as String?) ?? 'active';
    final accountType = (accountArgs['accountType'] as String?) ?? 'Personal';
    final pendingBalance = balance - availableBalance;
    final hasPendingFunds = pendingBalance > 0.01;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1),
            Color(0xFF4F46E5),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getIconForAccountType(accountType),
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatAccountType(accountType),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Show available balance as primary (what user can spend)
                    Text(
                      '$currencySymbol${availableBalance.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Available Balance',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _formatStatus(status),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Always show account breakdown
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                _buildBalanceRow(
                  'Total Balance',
                  '$currencySymbol${balance.toStringAsFixed(2)}',
                  Colors.white,
                ),
                SizedBox(height: 6.h),
                _buildBalanceRow(
                  'Available',
                  '$currencySymbol${availableBalance.toStringAsFixed(2)}',
                  const Color(0xFF10B981),
                ),
                if (hasPendingFunds) ...[
                  SizedBox(height: 6.h),
                  _buildBalanceRow(
                    'Pending / In Transit',
                    '$currencySymbol${pendingBalance.toStringAsFixed(2)}',
                    const Color(0xFFFB923C),
                  ),
                ],
                if (reservedBalance > 0.01) ...[
                  SizedBox(height: 6.h),
                  _buildBalanceRow(
                    'Held (Reserved)',
                    '$currencySymbol${reservedBalance.toStringAsFixed(2)}',
                    const Color(0xFFF59E0B),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceRow(String label, String value, Color dotColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData _getIconForAccountType(String type) {
    switch (type.toLowerCase()) {
      case 'savings':
        return Icons.savings_outlined;
      case 'investment':
        return Icons.trending_up_outlined;
      case 'family':
        return Icons.family_restroom_outlined;
      case 'business':
        return Icons.business_outlined;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }

  String _formatAccountType(String type) {
    switch (type.toLowerCase()) {
      case 'personal':
        return 'Personal Account';
      case 'savings':
        return 'Savings Account';
      case 'investment':
        return 'Investment Account';
      case 'family':
        return 'Family & Friends';
      case 'business':
        return 'Business Account';
      default:
        return 'Account';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF10B981);
      case 'frozen':
      case 'blocked_temporary':
      case 'blocked_permanent':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFFF59E0B);
    }
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Active';
      case 'frozen':
        return 'Frozen';
      case 'blocked_temporary':
        return 'Blocked';
      case 'blocked_permanent':
        return 'Blocked';
      default:
        return status;
    }
  }
}
