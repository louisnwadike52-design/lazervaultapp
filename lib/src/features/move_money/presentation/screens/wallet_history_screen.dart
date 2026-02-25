import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';

import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';

import '../../cubit/wallet_transfer_cubit.dart';
import '../../cubit/wallet_transfer_state.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  static const int _pageSize = 20;

  String _activeFilter = 'all';
  final List<PaymentsTransferResult> _transfers = [];
  int _total = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _accountId;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _resolveAccountAndLoad();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _resolveAccountAndLoad() {
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    List<AccountSummaryEntity> accounts = [];
    if (accountState is AccountCardsSummaryLoaded) {
      accounts = accountState.accountSummaries;
    } else if (accountState is AccountBalanceUpdated) {
      accounts = accountState.accountSummaries;
    }

    if (accounts.isNotEmpty) {
      final primary = accounts.firstWhere(
        (a) => a.isPrimary,
        orElse: () => accounts.first,
      );
      _accountId = primary.id;
      _loadTransfers(reset: true);
    } else {
      // Accounts not loaded yet — fetch them first
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: authState.profile.userId,
              accessToken: authState.profile.session.accessToken,
            );
      }
    }
  }

  void _loadTransfers({bool reset = false}) {
    if (_accountId == null) return;

    if (reset) {
      _transfers.clear();
      _hasMore = true;
    }

    context.read<WalletTransferCubit>().getWalletTransferHistory(
          accountId: _accountId!,
          limit: _pageSize,
          offset: reset ? 0 : _transfers.length,
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      setState(() => _isLoadingMore = true);
      _loadTransfers();
    }
  }

  void _onFilterChanged(String filter) {
    if (filter == _activeFilter) return;
    setState(() => _activeFilter = filter);
    _loadTransfers(reset: true);
  }

  List<PaymentsTransferResult> get _filteredTransfers {
    if (_activeFilter == 'all') return _transfers;
    return _transfers.where((t) {
      final status = (t.status ?? '').toLowerCase();
      switch (_activeFilter) {
        case 'completed':
          return status == 'completed' || status == 'success';
        case 'processing':
          return status == 'processing' || status == 'pending';
        case 'failed':
          return status == 'failed' || status == 'error';
        default:
          return true;
      }
    }).toList();
  }

  String _formatNaira(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return 'NGN ${formatter.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy  HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Wallet History',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          SizedBox(height: 8.h),
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<AccountCardsSummaryCubit,
                    AccountCardsSummaryState>(
                  listener: (context, state) {
                    if (state is AccountCardsSummaryLoaded &&
                        _accountId == null) {
                      final accounts = state.accountSummaries;
                      if (accounts.isNotEmpty) {
                        final primary = accounts.firstWhere(
                          (a) => a.isPrimary,
                          orElse: () => accounts.first,
                        );
                        _accountId = primary.id;
                        _loadTransfers(reset: true);
                      }
                    }
                  },
                ),
              ],
              child: BlocConsumer<WalletTransferCubit, WalletTransferState>(
                listener: (context, state) {
                  if (state is WalletTransferHistoryLoaded) {
                    setState(() {
                      if (_transfers.isEmpty) {
                        _transfers.addAll(state.transfers);
                      } else {
                        final existingIds =
                            _transfers.map((t) => t.transferId).toSet();
                        for (final t in state.transfers) {
                          if (!existingIds.contains(t.transferId)) {
                            _transfers.add(t);
                          }
                        }
                      }
                      _total = state.total;
                      _hasMore = _transfers.length < _total;
                      _isLoadingMore = false;
                    });
                  } else if (state is WalletTransferHistoryError) {
                    setState(() => _isLoadingMore = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFFEF4444),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is WalletTransferHistoryLoading &&
                      _transfers.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF3B82F6),
                      ),
                    );
                  }

                  final filtered = _filteredTransfers;
                  if (filtered.isEmpty) {
                    return _buildEmptyState();
                  }

                  return RefreshIndicator(
                    onRefresh: () async => _loadTransfers(reset: true),
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      itemCount: filtered.length + (_hasMore ? 1 : 0),
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        if (index == filtered.length) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: const CircularProgressIndicator(
                                color: Color(0xFF3B82F6),
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                        return _buildTransferItem(filtered[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    const filters = [
      ('all', 'All'),
      ('completed', 'Completed'),
      ('processing', 'Processing'),
      ('failed', 'Failed'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: filters.map((filter) {
          final isActive = _activeFilter == filter.$1;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: FilterChip(
              label: Text(
                filter.$2,
                style: GoogleFonts.inter(
                  color: isActive
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isActive,
              onSelected: (_) => _onFilterChanged(filter.$1),
              backgroundColor: const Color(0xFF1F1F1F),
              selectedColor: const Color(0xFF3B82F6),
              side: BorderSide(
                color: isActive
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              showCheckmark: false,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransferItem(PaymentsTransferResult transfer) {
    final amountDisplay = transfer.amount != null
        ? _formatNaira(transfer.amount! / 100)
        : 'NGN 0.00';
    final description = transfer.reference ?? transfer.transferId ?? 'Transfer';
    final date = transfer.createdAt ?? DateTime.now();
    final status = (transfer.status ?? 'processing').toLowerCase();

    return GestureDetector(
      onTap: () {
        // Could navigate to a detail/receipt screen if needed
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: const Color(0xFF60A5FA),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatDate(date),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amountDisplay,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                _buildStatusBadge(status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final Color bgColor;
    final Color textColor;
    final String label;

    if (status == 'completed' || status == 'success') {
      bgColor = const Color(0xFF10B981);
      textColor = const Color(0xFF10B981);
      label = 'Completed';
    } else if (status == 'failed' || status == 'error') {
      bgColor = const Color(0xFFEF4444);
      textColor = const Color(0xFFEF4444);
      label = 'Failed';
    } else {
      bgColor = const Color(0xFF3B82F6);
      textColor = const Color(0xFF3B82F6);
      label = 'Processing';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: const Color(0xFF60A5FA),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                _activeFilter == 'all'
                    ? 'No wallet transfers yet'
                    : 'No $_activeFilter transfers',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _activeFilter == 'all'
                    ? 'Your wallet transfer history will appear here\nonce you move money between accounts.'
                    : 'No transfers match the selected filter.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              if (_activeFilter == 'all')
                SizedBox(
                  width: 220.w,
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.walletTransfer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Transfer Between Accounts',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
