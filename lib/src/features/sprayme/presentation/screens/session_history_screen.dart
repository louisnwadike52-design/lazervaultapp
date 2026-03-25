import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';

class SessionHistoryScreen extends StatefulWidget {
  final String? sessionId; // if null, shows all user transactions

  const SessionHistoryScreen({super.key, this.sessionId});

  @override
  State<SessionHistoryScreen> createState() => _SessionHistoryScreenState();
}

class _SessionHistoryScreenState extends State<SessionHistoryScreen> {
  String _filter = 'all'; // all, sent, received

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    final cubit = context.read<SprayMeCubit>();
    if (widget.sessionId != null) {
      cubit.loadSessionTransactions(widget.sessionId!);
    } else {
      cubit.loadMyTransactions(type: _filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          widget.sessionId != null ? 'Session History' : 'My LazerSpray History',
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter chips (only for user transactions)
          if (widget.sessionId == null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: ['all', 'sent', 'received'].map((f) {
                  final isSelected = _filter == f;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _filter = f);
                        _loadTransactions();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          f[0].toUpperCase() + f.substring(1),
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Transaction list
          Expanded(
            child: BlocBuilder<SprayMeCubit, SprayMeState>(
              builder: (context, state) {
                if (state is SprayMeLoading) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
                }
                if (state is SprayMeError) {
                  return Center(
                    child: Text(state.message, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
                  );
                }
                if (state is TransactionsLoaded) {
                  if (state.transactions.isEmpty) {
                    return _buildEmpty();
                  }
                  return RefreshIndicator(
                    onRefresh: () async => _loadTransactions(),
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      itemCount: state.transactions.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        return _buildTransactionCard(state.transactions[index]);
                      },
                    ),
                  );
                }
                return _buildEmpty();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 48.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 12.h),
          Text(
            'No transactions yet',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 16.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            'Start spraying to see your history here',
            style: TextStyle(color: const Color(0xFF9CA3AF).withValues(alpha: 0.6), fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(SprayTransaction tx) {
    IconData icon;
    Color color;
    String title;
    String subtitle;

    switch (tx.type) {
      case 'gift':
        icon = Icons.card_giftcard;
        color = const Color(0xFFFFD700);
        title = '${tx.giftEmoji ?? ""} ${tx.giftName ?? "Gift"} x${tx.quantity}';
        subtitle = '${tx.senderName} \u2192 ${tx.recipientName}';
      case 'money_spray':
        icon = Icons.monetization_on;
        color = const Color(0xFF10B981);
        title = 'Money Spray';
        subtitle = '${tx.senderName} sprayed ${tx.currency} ${tx.amountMajor.toStringAsFixed(0)}';
      case 'like':
        icon = Icons.favorite;
        color = const Color(0xFFFF1744);
        title = 'Like';
        subtitle = tx.senderName;
      case 'fund_wallet':
        icon = Icons.add_circle;
        color = const Color(0xFF3B82F6);
        title = 'Wallet Funded';
        subtitle = tx.reference;
      case 'withdraw_wallet':
        icon = Icons.remove_circle;
        color = const Color(0xFFFB923C);
        title = 'Wallet Withdrawal';
        subtitle = tx.reference;
      default:
        icon = Icons.receipt;
        color = const Color(0xFF9CA3AF);
        title = tx.type;
        subtitle = tx.reference;
    }

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (tx.amount > 0)
            Text(
              '${tx.currency} ${tx.amountMajor.toStringAsFixed(0)}',
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
