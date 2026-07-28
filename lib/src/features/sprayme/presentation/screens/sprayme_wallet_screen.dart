import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';

class SprayMeWalletScreen extends StatefulWidget {
  const SprayMeWalletScreen({super.key});

  @override
  State<SprayMeWalletScreen> createState() => _SprayMeWalletScreenState();
}

class _SprayMeWalletScreenState extends State<SprayMeWalletScreen> {
  SprayWallet? _wallet;
  List<SprayTransaction> _transactions = [];
  MySprayStats? _stats;
  bool _isLoadingWallet = true;
  bool _isLoadingTransactions = true;
  bool _isLoadingStats = true;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  void _loadAll() {
    context.read<SprayMeCubit>().loadWallet();
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoadingWallet = true;
      _isLoadingTransactions = true;
      _isLoadingStats = true;
    });
    context.read<SprayMeCubit>().loadWallet();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'Wallet history',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<SprayMeCubit, SprayMeState>(
          listener: (context, state) {
            if (state is WalletLoaded) {
              setState(() {
                _wallet = state.wallet;
                _isLoadingWallet = false;
              });
              context.read<SprayMeCubit>().loadMyTransactions();
            } else if (state is TransactionsLoaded) {
              setState(() {
                _transactions = state.transactions;
                _isLoadingTransactions = false;
              });
              context.read<SprayMeCubit>().loadMySprayStats();
            } else if (state is MySprayStatsLoaded) {
              setState(() {
                _stats = state.stats;
                _isLoadingStats = false;
              });
            } else if (state is SprayMeError) {
              // Clear the loading flags so a failed wallet/transactions/stats load
              // stops shimmering forever (the chain aborts on the first error).
              setState(() {
                _isLoadingWallet = false;
                _isLoadingTransactions = false;
                _isLoadingStats = false;
              });
              _showError(state.message);
            }
            // Fund/Withdraw now settle inside the shared action sheet (which
            // returns the updated wallet); no WalletFunded/WalletWithdrawn
            // handling is needed here.
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _refresh,
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                children: [
                  _buildBalanceCard(),
                  SizedBox(height: 20.h),
                  _buildStatsRow(),
                  SizedBox(height: 24.h),
                  _buildTransactionHistory(),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Balance Card ─────────────────────────────────────────────────────────────

  Widget _buildBalanceCard() {
    if (_isLoadingWallet) {
      return Shimmer.fromColors(
        baseColor: const Color(0xFF1F1F1F),
        highlightColor: const Color(0xFF2D2D2D),
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      );
    }

    final spendable = (_wallet?.balance ?? 0) / 100;
    final earnings = (_wallet?.earningsBalance ?? 0) / 100;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF581C87), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Gifts-to-spray (spendable) — bought from your personal account.
          Text(
            'Gifts to spray',
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13.sp),
          ),
          SizedBox(height: 6.h),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: spendable),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, _) => Text(
              'NGN ${_formatAmount(value)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(height: 1, color: Colors.white.withOpacity(0.15)),
          SizedBox(height: 12.h),
          // Earnings — accumulated received gifts, withdrawable to personal.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.savings_outlined, color: const Color(0xFF10B981), size: 16.sp),
                  SizedBox(width: 6.w),
                  Text('Earnings (withdrawable)',
                      style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12.sp)),
                ],
              ),
              Text('NGN ${_formatAmount(earnings)}',
                  style: TextStyle(
                      color: const Color(0xFF10B981), fontSize: 16.sp, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Stats Row ────────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    if (_isLoadingStats) {
      return Shimmer.fromColors(
        baseColor: const Color(0xFF1F1F1F),
        highlightColor: const Color(0xFF2D2D2D),
        child: Row(
          children: List.generate(
            4,
            (_) => Expanded(
              child: Container(
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildMiniStat(
            label: 'Funded',
            // total_funded/total_withdrawn are NOT in the stats response — read
            // them from the wallet object (walletToJSON carries them), else these
            // two cards are permanently ₦0.
            value: _formatAmountShort((_wallet?.totalFunded ?? 0) / 100),
            color: const Color(0xFF3B82F6),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildMiniStat(
            label: 'Sprayed',
            value: _formatAmountShort((_stats?.totalSprayed ?? 0) / 100),
            color: const Color(0xFFEF4444),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildMiniStat(
            label: 'Received',
            value: _formatAmountShort((_stats?.totalReceived ?? 0) / 100),
            color: const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: _buildMiniStat(
            label: 'Withdrawn',
            value: _formatAmountShort((_wallet?.totalWithdrawn ?? 0) / 100),
            color: const Color(0xFFFB923C),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniStat({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  // ── Transaction History ──────────────────────────────────────────────────────

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (_isLoadingTransactions)
          Shimmer.fromColors(
            baseColor: const Color(0xFF1F1F1F),
            highlightColor: const Color(0xFF2D2D2D),
            child: Column(
              children: List.generate(
                4,
                (_) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (_transactions.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 40.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                SizedBox(height: 8.h),
                Text(
                  'No transactions yet',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          )
        else
          ..._transactions.take(20).map((tx) => _buildTransactionTile(tx)),
      ],
    );
  }

  Widget _buildTransactionTile(SprayTransaction tx) {
    final isCredit = tx.type.toLowerCase() == 'fund' ||
        tx.type.toLowerCase() == 'received' ||
        tx.type.toLowerCase() == 'credit';
    final amountMajor = tx.amount / 100;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: (isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444))
                  .withOpacity(0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _capitalizeFirst(tx.type),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (tx.description.isNotEmpty)
                  Text(
                    tx.description,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : '-'} NGN ${_formatAmount(amountMajor)}',
            style: TextStyle(
              color: isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    }
    return amount.toStringAsFixed(amount == amount.truncateToDouble() ? 0 : 2);
  }

  String _formatAmountShort(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}K';
    }
    return amount.toStringAsFixed(0);
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
