import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
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

class _SprayMeWalletScreenState extends State<SprayMeWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();

  SprayWallet? _wallet;
  List<SprayTransaction> _transactions = [];
  MySprayStats? _stats;
  bool _isLoadingWallet = true;
  bool _isLoadingTransactions = true;
  bool _isLoadingStats = true;
  bool _obscurePin = true;

  // Account pulled from AccountManager
  late final AccountManager _accountManager;
  String? _accountId;
  String _accountDisplay = '';
  String _accountCurrency = 'NGN';
  double _accountBalance = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _accountManager = serviceLocator<AccountManager>();
    _loadAccountDetails();
    _loadAll();
  }

  void _loadAccountDetails() {
    final details = _accountManager.activeAccountDetails;
    if (details != null) {
      _accountId = details.id;
      final accNum = details.accountNumber;
      _accountDisplay = '${details.accountType} •••• ${accNum.length >= 4 ? accNum.substring(accNum.length - 4) : accNum}';
      _accountCurrency = details.currency.isNotEmpty ? details.currency : 'NGN';
      _accountBalance = details.balance;
    } else {
      // Fallback to just the account ID
      _accountId = _accountManager.activeAccountId;
      _accountDisplay = _accountId != null ? 'Personal Account' : '';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
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

  void _clearForm() {
    _amountController.clear();
    _pinController.clear();
  }

  bool _isFundingOrWithdrawing = false;

  void _onFund() {
    if (_isFundingOrWithdrawing) return;
    final amount = int.tryParse(_amountController.text.trim());
    final pin = _pinController.text.trim();

    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }
    if (amount > 10000000) {
      _showError('Maximum fund amount is $_accountCurrency 10,000,000');
      return;
    }
    if (_accountId == null || _accountId!.isEmpty) {
      _showError('No account found. Please select an account on the home screen first.');
      return;
    }
    if (_accountBalance > 0 && amount * 100 > _accountBalance) {
      final available = (_accountBalance / 100).toStringAsFixed(0);
      _showError('Amount exceeds account balance ($_accountCurrency $available)');
      return;
    }
    if (pin.length < 4 || pin.length > 6) {
      _showError('PIN must be 4-6 digits');
      return;
    }

    _isFundingOrWithdrawing = true;
    HapticFeedback.lightImpact();
    context.read<SprayMeCubit>().fundWallet(
          amount: amount * 100, // Convert to kobo
          sourceAccountId: _accountId!,
          pin: pin,
        );
  }

  void _onWithdraw() {
    if (_isFundingOrWithdrawing) return;
    final amount = int.tryParse(_amountController.text.trim());
    final pin = _pinController.text.trim();

    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }
    if (amount > 10000000) {
      _showError('Maximum withdrawal amount is $_accountCurrency 10,000,000');
      return;
    }
    if (_wallet == null) {
      _showError('Wallet not loaded yet. Please wait and try again.');
      return;
    }
    if (amount * 100 > _wallet!.balance) {
      final available = (_wallet!.balance / 100).toStringAsFixed(0);
      _showError('Insufficient balance. Available: $_accountCurrency $available');
      return;
    }
    if (_accountId == null || _accountId!.isEmpty) {
      _showError('No account found. Please select an account on the home screen first.');
      return;
    }
    if (pin.length < 4 || pin.length > 6) {
      _showError('PIN must be 4-6 digits');
      return;
    }

    _isFundingOrWithdrawing = true;
    HapticFeedback.lightImpact();
    context.read<SprayMeCubit>().withdrawFromWallet(
          amount: amount * 100, // Convert to kobo
          destinationAccountId: _accountId!,
          pin: pin,
        );
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
          'LazerSpray Wallet',
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
            } else if (state is WalletFunded) {
              _isFundingOrWithdrawing = false;
              HapticFeedback.mediumImpact();
              setState(() {
                _wallet = state.wallet;
              });
              _clearForm();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
              // Reload transactions
              context.read<SprayMeCubit>().loadMyTransactions();
            } else if (state is WalletWithdrawn) {
              _isFundingOrWithdrawing = false;
              HapticFeedback.mediumImpact();
              setState(() {
                _wallet = state.wallet;
              });
              _clearForm();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
              context.read<SprayMeCubit>().loadMyTransactions();
            } else if (state is SprayMeError) {
              _isFundingOrWithdrawing = false;
              _showError(state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is SprayMeLoading;

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
                  SizedBox(height: 20.h),
                  _buildFundWithdrawTabs(isLoading),
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

    final balance = (_wallet?.balance ?? 0) / 100;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.w),
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
          Text(
            'Available Balance',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: balance),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, _) {
              return Text(
                'NGN ${_formatAmount(value)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              );
            },
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
            value: _formatAmountShort((_stats?.totalFunded ?? 0) / 100),
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
            value: _formatAmountShort((_stats?.totalWithdrawn ?? 0) / 100),
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

  // ── Fund / Withdraw Tabs ─────────────────────────────────────────────────────

  Widget _buildFundWithdrawTabs(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TabBar(
              controller: _tabController,
              onTap: (_) {
                HapticFeedback.lightImpact();
                _clearForm();
              },
              indicator: BoxDecoration(
                color: const Color(0xFF7C3AED),
                borderRadius: BorderRadius.circular(10.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF9CA3AF),
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: 'Fund Wallet'),
                Tab(text: 'Withdraw'),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Tab content
          SizedBox(
            height: 340.h,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFundForm(isLoading),
                _buildWithdrawForm(isLoading),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundForm(bool isLoading) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Source account card (TagPay-style, locked to personal)
          _buildAccountCard(
            label: 'Funding from',
            isSource: true,
          ),
          SizedBox(height: 16.h),
          _buildFormLabel('Amount ($_accountCurrency)'),
          SizedBox(height: 6.h),
          _buildFormField(
            controller: _amountController,
            hint: 'Enter amount',
            keyboardType: TextInputType.number,
            prefixText: '$_accountCurrency ',
          ),
          SizedBox(height: 14.h),
          _buildFormLabel('Transaction PIN'),
          SizedBox(height: 6.h),
          _buildPinField(),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: isLoading ? null : _onFund,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                disabledBackgroundColor: const Color(0xFF10B981).withValues(alpha: 0.4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Fund Wallet',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawForm(bool isLoading) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Destination account card (TagPay-style, locked to personal)
          _buildAccountCard(
            label: 'Withdrawing to',
            isSource: false,
          ),
          SizedBox(height: 16.h),
          _buildFormLabel('Amount ($_accountCurrency)'),
          SizedBox(height: 6.h),
          _buildFormField(
            controller: _amountController,
            hint: 'Enter amount',
            keyboardType: TextInputType.number,
            prefixText: '$_accountCurrency ',
          ),
          SizedBox(height: 14.h),
          _buildFormLabel('Transaction PIN'),
          SizedBox(height: 6.h),
          _buildPinField(),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: isLoading ? null : _onWithdraw,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFB923C),
                disabledBackgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Withdraw',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  /// TagPay-style account card showing the user's personal LazerVault account.
  /// Pre-selected, no ability to change — only personal account is allowed.
  Widget _buildAccountCard({
    required String label,
    required bool isSource,
  }) {
    if (_accountId == null || _accountId!.isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.5), width: 1.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.warning_amber_rounded, color: const Color(0xFFEF4444), size: 22.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Account Found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Please select an account on the home screen first.',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final balanceMajor = _accountBalance / 100;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF3B82F6), width: 2),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Account icon
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: const Color(0xFF3B82F6),
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 14.w),

                // Account info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _accountDisplay.isNotEmpty ? _accountDisplay : 'LazerVault Wallet',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Balance + checkmark
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: const Color(0xFF3B82F6),
                      size: 24.sp,
                    ),
                    if (_accountBalance > 0) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '$_accountCurrency ${_formatAmount(balanceMajor)}',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Flow label
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: (isSource ? const Color(0xFF10B981) : const Color(0xFFFB923C)).withValues(alpha: 0.08),
              border: Border(
                top: BorderSide(
                  color: (isSource ? const Color(0xFF10B981) : const Color(0xFFFB923C)).withValues(alpha: 0.2),
                ),
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(14.r)),
            ),
            child: Row(
              children: [
                Icon(
                  isSource ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isSource ? const Color(0xFF10B981) : const Color(0xFFFB923C),
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  isSource
                      ? 'Funding from this account'
                      : 'Withdrawing to this account',
                  style: TextStyle(
                    color: isSource ? const Color(0xFF10B981) : const Color(0xFFFB923C),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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

  // ── Form Helpers ─────────────────────────────────────────────────────────────

  Widget _buildFormLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF9CA3AF),
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? prefixText,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      inputFormatters: keyboardType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]
          : null,
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        prefixText: prefixText,
        prefixStyle: TextStyle(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildPinField() {
    return TextFormField(
      controller: _pinController,
      keyboardType: TextInputType.number,
      obscureText: _obscurePin,
      maxLength: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: 'Enter PIN',
        hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        counterText: '',
        filled: true,
        fillColor: const Color(0xFF0A0A0A),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscurePin = !_obscurePin),
          icon: Icon(
            _obscurePin ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
        ),
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
