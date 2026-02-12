import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../../../../../core/types/app_routes.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
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
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.airtimeHistory),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          BlocBuilder<AirtimeCubit, AirtimeState>(
            builder: (context, state) {
              if (state is AirtimeTransactionHistoryLoaded) {
                if (state.transactions.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildTransactionsList(state.transactions.take(3).toList());
              }
              return _buildLoadingState();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<AirtimeTransaction> transactions) {
    return Column(
      children: transactions.map((transaction) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _buildTransactionItem(transaction),
        );
      }).toList(),
    );
  }

  Widget _buildTransactionItem(AirtimeTransaction transaction) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.airtimeDetails,
        arguments: {'transaction': transaction},
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.r),
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
            // Network provider icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: transaction.networkProvider.color,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  transaction.networkProvider.displayName.substring(0, 1),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Transaction details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.networkProvider.displayName} Airtime',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  Text(
                    transaction.displayRecipientNumber,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  Text(
                    DateFormat('MMM dd, yyyy • hh:mm a').format(transaction.createdAt),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            
            // Amount and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.currencySymbol}${transaction.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                
                SizedBox(height: 4.h),
                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: transaction.status.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    transaction.status.displayName,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: transaction.status.color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Icon(
            Icons.history,
            size: 48.sp,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          SizedBox(height: 12.h),
          Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your airtime purchases will appear here',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.4),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: List.generate(3, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            height: 72.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

} 