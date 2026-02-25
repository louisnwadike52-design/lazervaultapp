import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';

import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';
import '../../cubit/move_money_cubit.dart';
import '../../cubit/wallet_transfer_cubit.dart';
import '../../cubit/wallet_transfer_state.dart';
import '../../domain/entities/mandate_entity.dart';
import '../../cubit/move_money_state.dart';
import '../../domain/entities/move_transfer.dart';
import '../widgets/mandate_management_bottomsheet.dart';
import '../widgets/mandate_setup_bottomsheet.dart';
import '../widgets/move_account_card.dart';
import '../widgets/move_status_badge.dart';
import '../../services/move_transfer_pdf_service.dart';
import '../../services/wallet_transfer_pdf_service.dart';

/// Dashboard screen for the Move Money feature.
///
/// Two tabs: "External Banks" (linked accounts + Mono DirectPay) and
/// "LazerVault Wallet" (move between own LazerVault virtual accounts).
class MoveMoneyDashboardScreen extends StatefulWidget {
  const MoveMoneyDashboardScreen({super.key});

  @override
  State<MoveMoneyDashboardScreen> createState() =>
      _MoveMoneyDashboardScreenState();
}

class _MoveMoneyDashboardScreenState extends State<MoveMoneyDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Wallet tab: From/To account selectors
  AccountSummaryEntity? _walletSourceAccount;
  AccountSummaryEntity? _walletDestinationAccount;

  // Drag-to-swap visual state (wallet tab)
  bool _isWalletHoveringFrom = false;
  bool _isWalletHoveringTo = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadData() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<OpenBankingCubit>().fetchLinkedAccounts(
            userId: authState.profile.userId,
            accessToken: authState.profile.session.accessToken,
          );
      context.read<MoveMoneyCubit>().getTransfers(
            userId: authState.profile.userId,
            limit: 5,
          );
      context.read<MandateCubit>().fetchUserMandates(
            userId: authState.profile.userId,
          );
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: authState.profile.userId,
            accessToken: authState.profile.session.accessToken,
          );

      // Delayed refresh for wallet transfers (backend indexing latency)
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          final state = context.read<AccountCardsSummaryCubit>().state;
          final accounts = switch (state) {
            AccountCardsSummaryLoaded(:final accountSummaries) =>
              accountSummaries,
            AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
            _ => <AccountSummaryEntity>[],
          };
          if (accounts.isNotEmpty) _loadWalletHistory(accounts);
        }
      });
    }
  }

  void _loadWalletHistory(List<AccountSummaryEntity> accounts) {
    if (accounts.isEmpty) return;
    final primary = accounts.firstWhere(
      (a) => a.isPrimary,
      orElse: () => accounts.first,
    );
    context.read<WalletTransferCubit>().getRecentWalletTransfers(
          accountId: primary.id,
        );
  }

  void _navigateToLinkBank() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    final user = authState.profile.user;
    final customerName = '${user.firstName} ${user.lastName}'.trim();

    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: user.email.isNotEmpty ? user.email : null,
      reference: 'lzv_move_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (result != null && mounted) {
      context.read<OpenBankingCubit>().linkAccount(
            userId: user.id,
            code: result.code,
            accessToken: authState.profile.session.accessToken,
          );
      _loadData();
    }
  }

  Future<void> _showMandateManagement(
    LinkedBankAccount account,
    MandateEntity? mandate,
  ) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    await showMandateManagementBottomSheet(
      context: context,
      linkedAccountId: account.id,
      userId: authState.profile.userId,
      bankName: account.bankName,
      accountName: account.accountName,
      mandate: mandate,
    );
    if (mounted) {
      context.read<MandateCubit>().fetchUserMandates(
            userId: authState.profile.userId,
          );
    }
  }

  String _formatNaira(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return 'NGN ${formatter.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy HH:mm').format(date);
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
          'Move Money',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OpenBankingCubit, OpenBankingState>(
            listenWhen: (prev, curr) =>
                curr is AccountLinked || curr is AccountUnlinked,
            listener: (context, state) async {
              if (state is AccountLinked) {
                final authState = context.read<AuthenticationCubit>().state;
                if (authState is AuthenticationSuccess) {
                  final mandateCubit = context.read<MandateCubit>();
                  final user = authState.profile.user;
                  await showMandateSetupBottomSheet(
                    context: context,
                    linkedAccountId: state.account.id,
                    userId: authState.profile.userId,
                    bankName: state.account.bankName,
                    accountName: state.account.accountName,
                    userEmail: user.email,
                    userName: '${user.firstName} ${user.lastName}'.trim(),
                    userPhone: user.phoneNumber,
                  );
                  mandateCubit.fetchUserMandates(
                    userId: authState.profile.userId,
                  );
                }
              } else if (state is AccountUnlinked) {
                Get.snackbar(
                  'Account Unlinked',
                  'Bank account has been removed.',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
                _loadData();
              }
            },
          ),
          BlocListener<MandateCubit, MandateState>(
            listener: (context, state) {
              if (state is UserMandatesLoaded ||
                  state is MandateCreated ||
                  state is MandatePaused ||
                  state is MandateReinstated ||
                  state is MandateCancelled) {
                setState(() {});
              }
            },
          ),
          BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
            listener: (context, state) {
              if (state is AccountCardsSummaryLoaded) {
                _loadWalletHistory(state.accountSummaries);
              } else if (state is AccountBalanceUpdated) {
                _loadWalletHistory(state.accountSummaries);
              }
            },
          ),
        ],
        child: Column(
          children: [
            // Shared hero banner
            _buildHeroBanner(),
            SizedBox(height: 16.h),

            // Tab bar
            _buildTabBar(),
            SizedBox(height: 8.h),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildExternalBanksTab(),
                  _buildWalletTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tab bar
  // ---------------------------------------------------------------------------

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'External Banks'),
          Tab(text: 'LazerVault Wallet'),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // External Banks tab (existing functionality)
  // ---------------------------------------------------------------------------

  Widget _buildExternalBanksTab() {
    return RefreshIndicator(
      onRefresh: () async => _loadData(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: BlocBuilder<OpenBankingCubit, OpenBankingState>(
        builder: (context, obState) {
          if (obState is OpenBankingLoading) {
            return _buildLoadingState();
          }
          if (obState is OpenBankingError) {
            return _buildErrorState(obState.message);
          }
          if (obState is OpenBankingOffline) {
            return _buildErrorState(
                'No internet connection. Pull down to retry.');
          }
          if (obState is ServiceUnavailable) {
            return _buildErrorState(
                'Service temporarily unavailable. Please try again later.');
          }

          final accounts = context.read<OpenBankingCubit>().linkedAccounts;

          if (accounts.length < 2) {
            return _buildEmptyState(accounts);
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            children: [
              _buildLinkedAccountsHeader(),
              SizedBox(height: 10.h),
              _buildAccountsList(accounts),
              SizedBox(height: 24.h),
              // Move Money Now CTA
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed('/move-money/transfer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.swap_horiz_rounded,
                            color: Colors.white, size: 22.sp),
                        SizedBox(width: 10.w),
                        Text(
                          'Move Money Now',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              _buildRecentTransfers(),
              SizedBox(height: 40.h),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LazerVault Wallet tab — move between own virtual accounts
  // ---------------------------------------------------------------------------

  String _formatCurrency(double value, String currency) {
    return '$currency ${NumberFormat('#,##0.00', 'en_NG').format(value)}';
  }

  bool get _walletCanContinue =>
      _walletSourceAccount != null &&
      _walletDestinationAccount != null &&
      _walletSourceAccount!.id != _walletDestinationAccount!.id &&
      _walletSourceAccount!.currency == _walletDestinationAccount!.currency;

  void _swapWalletAccounts() {
    if (_walletSourceAccount != null && _walletDestinationAccount != null) {
      setState(() {
        final temp = _walletSourceAccount;
        _walletSourceAccount = _walletDestinationAccount;
        _walletDestinationAccount = temp;
      });
    }
  }

  void _continueWalletTransfer() {
    if (!_walletCanContinue) return;
    Get.toNamed(
      AppRoutes.walletTransfer,
      arguments: {
        'sourceAccount': _walletSourceAccount,
        'destinationAccount': _walletDestinationAccount,
      },
    );
  }

  Widget _buildWalletTab() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, accountState) {
        final accounts = switch (accountState) {
          AccountCardsSummaryLoaded(:final accountSummaries) =>
            accountSummaries,
          AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
          _ => <AccountSummaryEntity>[],
        };

        if (accountState is AccountCardsSummaryLoading) {
          return _buildLoadingState();
        }

        if (accountState is AccountCardsSummaryError) {
          return _buildErrorState(accountState.message);
        }

        if (accounts.length < 2) {
          return _buildNotEnoughWalletAccounts(accounts);
        }

        return RefreshIndicator(
          onRefresh: () async => _loadData(),
          color: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFF1F1F1F),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            children: [
              // Free transfer banner
              _buildFreeTransferBanner(),
              SizedBox(height: 24.h),

              // Draggable From / To wallet account pair
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _buildWalletDraggableAccountPair(accounts),
              ),

              // Currency mismatch warning
              if (_walletSourceAccount != null &&
                  _walletDestinationAccount != null &&
                  _walletSourceAccount!.currency !=
                      _walletDestinationAccount!.currency) ...[
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color:
                              const Color(0xFFFB923C).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: const Color(0xFFFB923C), size: 20.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Cross-currency transfers are not yet supported.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFB923C),
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              SizedBox(height: 20.h),

              // Continue button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _walletCanContinue ? _continueWalletTransfer : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      disabledBackgroundColor:
                          const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Recent wallet transfers
              _buildRecentWalletTransfers(),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Wallet tab draggable From / To pair
  // ---------------------------------------------------------------------------

  Widget _buildWalletDraggableAccountPair(List<AccountSummaryEntity> accounts) {
    return Column(
      children: [
        // FROM card
        _buildWalletDraggableSlot(
          dragData: 'from',
          acceptData: 'to',
          isHovering: _isWalletHoveringFrom,
          onHoverChanged: (h) => setState(() => _isWalletHoveringFrom = h),
          child: _buildWalletDraggableCard(
            label: 'From',
            account: _walletSourceAccount,
            onTap: () => _showWalletAccountPicker(
              accounts: accounts,
              excludeId: _walletDestinationAccount?.id,
              onSelected: (a) => setState(() => _walletSourceAccount = a),
            ),
            highlight: _isWalletHoveringFrom,
          ),
          feedbackChild: _buildWalletDraggableCard(
            label: 'From',
            account: _walletSourceAccount,
            highlight: true,
          ),
          ghostChild: _buildWalletDraggableCard(
            label: 'From',
            account: _walletSourceAccount,
          ),
        ),
        // Swap button — equal spacing above and below
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: GestureDetector(
            onTap:
                (_walletSourceAccount != null || _walletDestinationAccount != null)
                    ? _swapWalletAccounts
                    : null,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2D2D2D), width: 2),
              ),
              child: Icon(
                Icons.swap_vert_rounded,
                color:
                    (_walletSourceAccount != null || _walletDestinationAccount != null)
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF6B7280),
                size: 22.sp,
              ),
            ),
          ),
        ),
        // TO card
        _buildWalletDraggableSlot(
          dragData: 'to',
          acceptData: 'from',
          isHovering: _isWalletHoveringTo,
          onHoverChanged: (h) => setState(() => _isWalletHoveringTo = h),
          child: _buildWalletDraggableCard(
            label: 'To',
            account: _walletDestinationAccount,
            onTap: () => _showWalletAccountPicker(
              accounts: accounts,
              excludeId: _walletSourceAccount?.id,
              onSelected: (a) => setState(() => _walletDestinationAccount = a),
            ),
            highlight: _isWalletHoveringTo,
          ),
          feedbackChild: _buildWalletDraggableCard(
            label: 'To',
            account: _walletDestinationAccount,
            highlight: true,
          ),
          ghostChild: _buildWalletDraggableCard(
            label: 'To',
            account: _walletDestinationAccount,
          ),
        ),
      ],
    );
  }

  Widget _buildWalletDraggableSlot({
    required String dragData,
    required String acceptData,
    required bool isHovering,
    required ValueChanged<bool> onHoverChanged,
    required Widget child,
    required Widget feedbackChild,
    required Widget ghostChild,
  }) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) {
        if (details.data == acceptData) {
          onHoverChanged(true);
          return true;
        }
        return false;
      },
      onLeave: (_) => onHoverChanged(false),
      onAcceptWithDetails: (_) {
        onHoverChanged(false);
        _swapWalletAccounts();
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<String>(
          data: dragData,
          axis: Axis.vertical,
          feedback: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 32.w,
              child: Opacity(opacity: 0.9, child: feedbackChild),
            ),
          ),
          childWhenDragging: Opacity(opacity: 0.3, child: ghostChild),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: isHovering
                ? Matrix4.diagonal3Values(1.03, 1.03, 1.0)
                : Matrix4.identity(),
            transformAlignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildWalletDraggableCard({
    required String label,
    required AccountSummaryEntity? account,
    VoidCallback? onTap,
    bool highlight = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: highlight
                ? const Color(0xFF3B82F6)
                : account != null
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.5)
                    : const Color(0xFF2D2D2D),
            width: highlight ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Drag handle
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Icon(
                Icons.drag_indicator,
                color: const Color(0xFF4B5563),
                size: 20.sp,
              ),
            ),
            if (account != null)
              _buildWalletAccountIcon(account)
            else
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.add,
                    color: const Color(0xFF3B82F6), size: 20.sp),
              ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (account != null) ...[
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            account.displayName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (account.isPrimary) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Primary',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '•••• ${account.accountNumberLast4}  ·  ${_formatCurrency(account.balance, account.currency)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ] else
                    Text(
                      'Tap to select account',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showWalletAccountPicker({
    required List<AccountSummaryEntity> accounts,
    required String? excludeId,
    required ValueChanged<AccountSummaryEntity> onSelected,
  }) {
    final filtered = accounts.where((a) => a.id != excludeId).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Select Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              ...filtered.map((account) => ListTile(
                    leading: _buildWalletAccountIcon(account),
                    title: Row(
                      children: [
                        Text(
                          account.displayName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (account.isPrimary) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Primary',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Text(
                      '•••• ${account.accountNumberLast4}  ·  ${_formatCurrency(account.balance, account.currency)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      onSelected(account);
                    },
                  )),
              if (filtered.isEmpty)
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'No other accounts available',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWalletAccountIcon(AccountSummaryEntity account) {
    final type = account.accountTypeEnum;
    final IconData icon;
    final Color color;
    switch (type) {
      case VirtualAccountType.savings:
        icon = Icons.savings_outlined;
        color = const Color(0xFF10B981);
      case VirtualAccountType.investment:
        icon = Icons.trending_up_rounded;
        color = const Color(0xFFFB923C);
      case VirtualAccountType.family:
        icon = Icons.family_restroom_rounded;
        color = const Color(0xFFA78BFA);
      case VirtualAccountType.usd:
      case VirtualAccountType.gbp:
      case VirtualAccountType.eur:
        icon = Icons.currency_exchange_rounded;
        color = const Color(0xFF60A5FA);
      case VirtualAccountType.business:
        icon = Icons.business_rounded;
        color = const Color(0xFFFBBF24);
      default:
        icon = Icons.account_balance_wallet_outlined;
        color = const Color(0xFF3B82F6);
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }

  Widget _buildNotEnoughWalletAccounts(List<AccountSummaryEntity> accounts) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      children: [
        SizedBox(height: 40.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.account_balance_wallet_outlined,
                    color: const Color(0xFF60A5FA), size: 36.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                'Need at least 2 accounts',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  'To transfer between your wallets, you need at least two LazerVault accounts.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${accounts.length} of 2 accounts',
                style: GoogleFonts.inter(
                  color: const Color(0xFF60A5FA),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentWalletTransfers() {
    return BlocBuilder<WalletTransferCubit, WalletTransferState>(
      builder: (context, state) {
        List<PaymentsTransferResult> transfers = [];
        if (state is WalletTransferHistoryLoaded) {
          transfers = state.transfers;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transfers',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (transfers.isNotEmpty)
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.walletTransferHistory),
                      child: Text(
                        'See All',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF60A5FA),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            if (state is WalletTransferHistoryLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: const CircularProgressIndicator(
                      color: Color(0xFF3B82F6)),
                ),
              )
            else if (transfers.isEmpty)
              _buildNoWalletTransfersState()
            else
              ...transfers.map((t) => _buildWalletTransferItem(t)),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }

  Widget _buildNoWalletTransfersState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            Icon(Icons.swap_horiz_rounded,
                color: const Color(0xFF6B7280), size: 36.sp),
            SizedBox(height: 12.h),
            Text(
              'No transfers yet',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Your wallet transfer history will appear here.',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletTransferItem(PaymentsTransferResult transfer) {
    final amountDisplay = transfer.amount != null
        ? _formatNaira(transfer.amount! / 100)
        : 'NGN 0.00';
    final description = transfer.reference ?? transfer.transferId ?? 'Transfer';
    final date = transfer.createdAt ?? DateTime.now();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: GestureDetector(
        onTap: () => _showWalletTransferDetailSheet(transfer),
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
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.account_balance_wallet_outlined,
                  color: const Color(0xFF60A5FA), size: 20.sp),
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
                _buildWalletStatusBadge(transfer.status ?? 'processing'),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildWalletStatusBadge(String status) {
    final lowerStatus = status.toLowerCase();
    final Color bgColor;
    final Color textColor;
    final String label;

    if (lowerStatus == 'completed' || lowerStatus == 'success') {
      bgColor = const Color(0xFF10B981);
      textColor = const Color(0xFF10B981);
      label = 'Completed';
    } else if (lowerStatus == 'failed' || lowerStatus == 'error') {
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

  Widget _buildFreeTransferBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14.r),
          border:
              Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.bolt_rounded,
                color: const Color(0xFF10B981), size: 28.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instant & Free',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Move money between your LazerVault accounts with zero fees.',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
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

  // ---------------------------------------------------------------------------
  // Loading state
  // ---------------------------------------------------------------------------

  Widget _buildLoadingState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              const CircularProgressIndicator(color: Color(0xFF3B82F6)),
              SizedBox(height: 16.h),
              Text(
                'Loading your accounts...',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Error state with retry
  // ---------------------------------------------------------------------------

  Widget _buildErrorState(String message) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      children: [
        SizedBox(height: 40.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.cloud_off_rounded,
                    color: const Color(0xFFEF4444), size: 36.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                'Something went wrong',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 180.w,
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: _loadData,
                  icon: Icon(Icons.refresh, size: 20.sp),
                  label: Text(
                    'Try Again',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Hero banner
  // ---------------------------------------------------------------------------

  Widget _buildHeroBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.swap_horiz_rounded,
              color: Colors.white.withValues(alpha: 0.85),
              size: 32.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              'Move money between\nyour accounts',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Transfer funds across banks or to LazerVault users.',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Linked accounts header
  // ---------------------------------------------------------------------------

  void _navigateToLinkedAccountsList() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    Get.toNamed(
      AppRoutes.openBankingConnect,
      arguments: {
        'userId': authState.profile.userId,
        'accessToken': authState.profile.session.accessToken,
      },
    );
  }

  Widget _buildLinkedAccountsHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Text(
            'Your Linked Accounts',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _navigateToLinkedAccountsList,
            child: Text(
              'View All',
              style: GoogleFonts.inter(
                color: const Color(0xFF60A5FA),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: _navigateToLinkBank,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle_outline_rounded,
                    color: const Color(0xFF60A5FA), size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  'Link New',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF60A5FA),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Horizontal accounts list
  // ---------------------------------------------------------------------------

  Widget _buildAccountsList(List<LinkedBankAccount> accounts) {
    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: accounts.length + 1,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          if (index == accounts.length) {
            return _buildAddAccountCard();
          }
          final account = accounts[index];
          final mandate =
              context.read<MandateCubit>().getMandateForAccount(account.id);
          return MoveAccountCard(
            account: account,
            isSelected: false,
            mandate: mandate,
            onTap: () => _showAccountDetailSheet(account),
            onLongPress: () => _showMandateManagement(account, mandate),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Account detail bottom sheet
  // ---------------------------------------------------------------------------

  Color _getBankColor(String bankName) {
    final name = bankName.toLowerCase();
    if (name.contains('access')) return const Color(0xFFED7D31);
    if (name.contains('gtb') || name.contains('guaranty')) {
      return const Color(0xFFE94C16);
    }
    if (name.contains('zenith')) return const Color(0xFFED1C24);
    if (name.contains('uba')) return const Color(0xFFE4002B);
    if (name.contains('first')) return const Color(0xFF003366);
    if (name.contains('sterling')) return const Color(0xFF003399);
    if (name.contains('fidelity')) return const Color(0xFF009933);
    if (name.contains('fcmb')) return const Color(0xFF800080);
    if (name.contains('ecobank')) return const Color(0xFF003366);
    if (name.contains('union')) return const Color(0xFF009DDC);
    if (name.contains('polaris')) return const Color(0xFF8B0000);
    if (name.contains('stanbic')) return const Color(0xFF0033A0);
    if (name.contains('wema')) return const Color(0xFF800080);
    if (name.contains('keystone')) return const Color(0xFF006400);
    if (name.contains('kuda')) return const Color(0xFF40196D);
    if (name.contains('opay')) return const Color(0xFF1BB066);
    if (name.contains('palmpay')) return const Color(0xFF6F42C1);
    if (name.contains('moniepoint')) return const Color(0xFF2F3292);
    return const Color(0xFF3B82F6);
  }

  void _showAccountDetailSheet(LinkedBankAccount account) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    final bankColor = _getBankColor(account.bankName);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B7280),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 20.h),

                // Bank icon + name header
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: bankColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.account_balance,
                          color: bankColor, size: 24.sp),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.bankName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            account.accountName,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Detail card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Account Number', account.accountNumber),
                      _buildSheetDivider(),
                      _buildDetailRow('Account Type', account.accountType),
                      _buildSheetDivider(),
                      _buildDetailRow('Currency', account.currency),
                      _buildSheetDivider(),
                      _buildDetailRow('Balance', account.formattedBalance),
                      _buildSheetDivider(),
                      _buildDetailRow(
                        'Status',
                        account.isActive ? 'Active' : 'Inactive',
                        valueColor: account.isActive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                      if (account.isDefault) ...[
                        _buildSheetDivider(),
                        _buildDetailRow('Default', 'Yes',
                            valueColor: const Color(0xFF3B82F6)),
                      ],
                      _buildSheetDivider(),
                      _buildDetailRow(
                        'Linked Since',
                        _formatDate(account.linkedAt),
                      ),
                      if (account.lastUsedAt != null) ...[
                        _buildSheetDivider(),
                        _buildDetailRow(
                          'Last Used',
                          _formatDate(account.lastUsedAt!),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Action buttons row
                Row(
                  children: [
                    if (!account.isDefault)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            context.read<OpenBankingCubit>().setDefaultAccount(
                                  accountId: account.id,
                                  userId: authState.profile.userId,
                                  accessToken:
                                      authState.profile.session.accessToken,
                                );
                          },
                          icon: Icon(Icons.star_outline_rounded, size: 18.sp),
                          label: Text(
                            'Set Default',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF3B82F6),
                            side: const BorderSide(color: Color(0xFF3B82F6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                        ),
                      ),
                    if (!account.isDefault) SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          context.read<OpenBankingCubit>().refreshBalance(
                                accountId: account.id,
                                userId: authState.profile.userId,
                                accessToken:
                                    authState.profile.session.accessToken,
                              );
                        },
                        icon: Icon(Icons.refresh_rounded, size: 18.sp),
                        label: Text(
                          'Refresh Balance',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF10B981),
                          side: const BorderSide(color: Color(0xFF10B981)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Unlink button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (dlgCtx) => AlertDialog(
                          backgroundColor: const Color(0xFF1F1F1F),
                          title: const Text('Unlink Account',
                              style: TextStyle(color: Colors.white)),
                          content: Text(
                            'Are you sure you want to unlink ${account.bankName} (${account.displayAccountNumber})?',
                            style:
                                const TextStyle(color: Color(0xFF9CA3AF)),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dlgCtx, false),
                              child: const Text('Cancel',
                                  style:
                                      TextStyle(color: Color(0xFF9CA3AF))),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dlgCtx, true),
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red),
                              child: const Text('Unlink'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true && mounted) {
                        context.read<OpenBankingCubit>().unlinkAccount(
                              accountId: account.id,
                              userId: authState.profile.userId,
                              accessToken:
                                  authState.profile.session.accessToken,
                            );
                      }
                    },
                    icon: Icon(Icons.link_off_rounded, size: 18.sp),
                    label: Text(
                      'Unlink Account',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFEF4444).withValues(alpha: 0.15),
                      foregroundColor: const Color(0xFFEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 13.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetDivider() {
    return Divider(
      color: const Color(0xFF2D2D2D),
      height: 1.h,
      thickness: 0.5,
    );
  }

  Widget _buildAddAccountCard() {
    return GestureDetector(
      onTap: _navigateToLinkBank,
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add,
                  color: const Color(0xFF3B82F6), size: 24.sp),
            ),
            SizedBox(height: 12.h),
            Text(
              'Link Account',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recent transfers
  // ---------------------------------------------------------------------------

  Widget _buildRecentTransfers() {
    return BlocBuilder<MoveMoneyCubit, MoveMoneyState>(
      builder: (context, state) {
        List<MoveTransfer> transfers = [];
        if (state is MoveTransfersLoaded) {
          transfers = state.transfers;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transfers',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (transfers.isNotEmpty)
                    GestureDetector(
                      onTap: () => Get.toNamed('/move-money/history'),
                      child: Text(
                        'See All',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF60A5FA),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            if (state is MoveMoneyLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: const CircularProgressIndicator(
                      color: Color(0xFF3B82F6)),
                ),
              )
            else if (transfers.isEmpty)
              _buildNoTransfersState()
            else
              ...transfers.map((t) => _buildTransferItem(t)),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }

  Widget _buildNoTransfersState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            Icon(Icons.swap_horiz_rounded,
                color: const Color(0xFF6B7280), size: 36.sp),
            SizedBox(height: 12.h),
            Text(
              'No transfers yet',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Your transfer history will appear here.',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferItem(MoveTransfer transfer) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: GestureDetector(
        onTap: () => _showMoveTransferDetailSheet(transfer),
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
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.swap_horiz_rounded,
                    color: const Color(0xFF60A5FA), size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${transfer.sourceBankName} → ${transfer.destinationBankName}',
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
                      _formatDate(transfer.createdAt),
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
                    _formatNaira(transfer.amountNaira),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  MoveStatusBadge(status: transfer.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty state (fewer than 2 linked accounts)
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState(List<LinkedBankAccount> accounts) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      children: [
        SizedBox(height: 20.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.account_balance_outlined,
                    color: const Color(0xFF60A5FA), size: 36.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                'Link at least 2 bank accounts',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  'To move money between accounts, you need at least two linked bank accounts.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${accounts.length} of 2 accounts linked',
                style: GoogleFonts.inter(
                  color: const Color(0xFF60A5FA),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: 220.w,
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: _navigateToLinkBank,
                  icon: Icon(Icons.add, size: 20.sp),
                  label: Text(
                    'Link Bank Account',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              if (accounts.isNotEmpty) ...[
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Linked Accounts',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                ...accounts.map((account) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(12.r),
                          border:
                              Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(Icons.account_balance,
                                  color: const Color(0xFF60A5FA),
                                  size: 20.sp),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.bankName,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    '${account.accountName}  ${account.displayAccountNumber}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.check_circle,
                                color: const Color(0xFF10B981),
                                size: 20.sp),
                          ],
                        ),
                      ),
                    )),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Transfer Detail Bottom Sheets
  // ---------------------------------------------------------------------------

  /// Shows detail sheet for external bank transfer (MoveTransfer)
  void _showMoveTransferDetailSheet(MoveTransfer transfer) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              _buildDragHandle(),
              // Status icon + title
              _buildTransferStatusHeader(transfer),
              SizedBox(height: 20.h),
              // Detail card with all fields
              _buildTransferDetailCard(transfer),
              SizedBox(height: 16.h),
              // Download/Share PDF buttons
              _buildMoveTransferPdfActions(transfer, ctx),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows detail sheet for wallet transfer (PaymentsTransferResult)
  void _showWalletTransferDetailSheet(PaymentsTransferResult transfer) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              _buildDragHandle(),
              // Status icon + title
              _buildWalletTransferStatusHeader(transfer),
              SizedBox(height: 20.h),
              // Detail card with all fields
              _buildWalletTransferDetailCard(transfer),
              SizedBox(height: 16.h),
              // Download/Share PDF buttons
              _buildWalletTransferPdfActions(transfer, ctx),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF6B7280),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildTransferStatusHeader(MoveTransfer transfer) {
    final color = _statusColorForMoveTransfer(transfer.status);
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _statusIconForMoveTransfer(transfer.status),
            color: color,
            size: 30.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          _statusTitleForMoveTransfer(transfer.status),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          _formatNaira(transfer.amountNaira),
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWalletTransferStatusHeader(PaymentsTransferResult transfer) {
    final color = _statusColorForWalletTransfer(transfer.status);
    final amount = transfer.amount != null
        ? _formatNaira(transfer.amount! / 100.0)
        : 'NGN 0.00';
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _statusIconForWalletTransfer(transfer.status),
            color: color,
            size: 30.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          _statusTitleForWalletTransfer(transfer.status),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          amount,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTransferDetailCard(MoveTransfer transfer) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          _buildSheetDetailRow('Reference', transfer.reference),
          _buildSheetDivider(),
          _buildSheetDetailRow(
            'From',
            '${transfer.sourceBankName}\n${transfer.sourceAccountName}\n${transfer.sourceAccountNumber}',
          ),
          _buildSheetDivider(),
          _buildSheetDetailRow(
            'To',
            '${transfer.destinationBankName}\n${transfer.destinationAccountName}\n${transfer.destinationAccountNumber}',
          ),
          _buildSheetDivider(),
          _buildSheetDetailRow('Amount', _formatNaira(transfer.amountNaira)),
          if (transfer.totalFee > 0) ...[
            _buildSheetDivider(),
            _buildSheetDetailRow(
              'Debit Fee',
              _formatNaira(transfer.debitFee / 100.0),
            ),
            _buildSheetDetailRow(
              'Transfer Fee',
              _formatNaira(transfer.transferFee / 100.0),
            ),
            if (transfer.stampDuty > 0)
              _buildSheetDetailRow(
                'Stamp Duty',
                _formatNaira(transfer.stampDuty / 100.0),
              ),
            if (transfer.serviceFee > 0)
              _buildSheetDetailRow(
                'Service Fee',
                _formatNaira(transfer.serviceFee / 100.0),
              ),
            _buildSheetDivider(),
            _buildSheetDetailRow(
              'Total Fees',
              _formatNaira(transfer.totalFeeNaira),
              isBold: true,
            ),
            _buildSheetDetailRow(
              'Total Debit',
              _formatNaira(transfer.totalDebitNaira),
              isBold: true,
              valueColor: const Color(0xFF60A5FA),
            ),
          ],
          if (transfer.narration != null && transfer.narration!.isNotEmpty) ...[
            _buildSheetDivider(),
            _buildSheetDetailRow('Narration', transfer.narration!),
          ],
          _buildSheetDivider(),
          _buildSheetDetailRow('Date', _formatDate(transfer.createdAt)),
          if (transfer.completedAt != null)
            _buildSheetDetailRow(
              'Completed',
              _formatDate(transfer.completedAt!),
            ),
        ],
      ),
    );
  }

  Widget _buildWalletTransferDetailCard(PaymentsTransferResult transfer) {
    final amount = transfer.amount != null
        ? _formatNaira(transfer.amount! / 100.0)
        : 'NGN 0.00';
    final description = transfer.reference ?? transfer.transferId ?? 'Wallet Transfer';
    final date = transfer.createdAt ?? DateTime.now();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          _buildSheetDetailRow('Reference', description),
          _buildSheetDivider(),
          _buildSheetDetailRow('Amount', amount),
          _buildSheetDivider(),
          _buildSheetDetailRow('Fee', 'NGN 0.00',
              valueColor: const Color(0xFF10B981)),
          _buildSheetDivider(),
          _buildSheetDetailRow('Total', amount, isBold: true),
          if (transfer.newBalance != null) ...[
            _buildSheetDivider(),
            _buildSheetDetailRow(
              'New Balance',
              _formatNaira(transfer.newBalance!),
              valueColor: const Color(0xFF60A5FA),
            ),
          ],
          _buildSheetDivider(),
          _buildSheetDetailRow('Date', _formatDate(date)),
          if (transfer.recipientName != null && transfer.recipientName!.isNotEmpty) ...[
            _buildSheetDivider(),
            _buildSheetDetailRow('Recipient', transfer.recipientName!),
          ],
        ],
      ),
    );
  }

  Widget _buildSheetDetailRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: 12.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoveTransferPdfActions(MoveTransfer transfer, BuildContext ctx) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is! AuthenticationSuccess) return;
              final userName = '${authState.profile.user.firstName} ${authState.profile.user.lastName}'.trim();

              try {
                await MoveTransferPdfService.downloadReceipt(
                  transfer: transfer,
                  userName: userName,
                );
                Navigator.of(ctx).pop();
                Get.snackbar(
                  'Downloaded',
                  'Receipt saved to Downloads',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to download receipt',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                );
              }
            },
            icon: Icon(Icons.download_rounded, size: 16.sp),
            label: Text(
              'Download',
              style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF2D2D2D)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is! AuthenticationSuccess) return;
              final userName = '${authState.profile.user.firstName} ${authState.profile.user.lastName}'.trim();

              try {
                await MoveTransferPdfService.shareReceipt(
                  transfer: transfer,
                  userName: userName,
                );
                Navigator.of(ctx).pop();
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to share receipt',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                );
              }
            },
            icon: Icon(Icons.share_rounded, size: 16.sp),
            label: Text(
              'Share Receipt',
              style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWalletTransferPdfActions(PaymentsTransferResult transfer, BuildContext ctx) {
    // Get account names from current state or use defaults
    final sourceName = _walletSourceAccount?.displayName ?? 'Source Account';
    final destName = _walletDestinationAccount?.displayName ?? 'Destination Account';

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is! AuthenticationSuccess) return;
              final userName = '${authState.profile.user.firstName} ${authState.profile.user.lastName}'.trim();

              try {
                await WalletTransferPdfService.downloadReceipt(
                  transfer: transfer,
                  userName: userName,
                  sourceAccountName: sourceName,
                  destinationAccountName: destName,
                );
                Navigator.of(ctx).pop();
                Get.snackbar(
                  'Downloaded',
                  'Receipt saved to Downloads',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to download receipt',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                );
              }
            },
            icon: Icon(Icons.download_rounded, size: 16.sp),
            label: Text(
              'Download',
              style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF2D2D2D)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is! AuthenticationSuccess) return;
              final userName = '${authState.profile.user.firstName} ${authState.profile.user.lastName}'.trim();

              try {
                await WalletTransferPdfService.shareReceipt(
                  transfer: transfer,
                  userName: userName,
                  sourceAccountName: sourceName,
                  destinationAccountName: destName,
                );
                Navigator.of(ctx).pop();
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to share receipt',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                );
              }
            },
            icon: Icon(Icons.share_rounded, size: 16.sp),
            label: Text(
              'Share Receipt',
              style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Status helpers for MoveTransfer
  // ---------------------------------------------------------------------------

  Color _statusColorForMoveTransfer(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return const Color(0xFF10B981);
      case MoveTransferStatus.failed:
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _statusIconForMoveTransfer(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return Icons.check_circle_rounded;
      case MoveTransferStatus.failed:
        return Icons.cancel_rounded;
      default:
        return Icons.schedule_rounded;
    }
  }

  String _statusTitleForMoveTransfer(MoveTransferStatus status) {
    switch (status) {
      case MoveTransferStatus.completed:
        return 'Transfer Completed';
      case MoveTransferStatus.failed:
        return 'Transfer Failed';
      case MoveTransferStatus.debitInitiated:
      case MoveTransferStatus.debitAuthorizing:
      case MoveTransferStatus.debitProcessing:
        return 'Debiting Account';
      case MoveTransferStatus.payoutInitiated:
      case MoveTransferStatus.payoutProcessing:
        return 'Sending Funds';
      case MoveTransferStatus.refunding:
        return 'Refunding';
      case MoveTransferStatus.refunded:
        return 'Refunded';
      default:
        return 'Processing';
    }
  }

  // ---------------------------------------------------------------------------
  // Status helpers for WalletTransfer
  // ---------------------------------------------------------------------------

  Color _statusColorForWalletTransfer(String? status) {
    if (status == null) return const Color(0xFF3B82F6);
    final lower = status.toLowerCase();
    if (lower == 'completed' || lower == 'success') {
      return const Color(0xFF10B981);
    } else if (lower == 'failed' || lower == 'error') {
      return const Color(0xFFEF4444);
    }
    return const Color(0xFF3B82F6);
  }

  IconData _statusIconForWalletTransfer(String? status) {
    if (status == null) return Icons.schedule_rounded;
    final lower = status.toLowerCase();
    if (lower == 'completed' || lower == 'success') {
      return Icons.check_circle_rounded;
    } else if (lower == 'failed' || lower == 'error') {
      return Icons.cancel_rounded;
    }
    return Icons.schedule_rounded;
  }

  String _statusTitleForWalletTransfer(String? status) {
    if (status == null) return 'Processing';
    final lower = status.toLowerCase();
    if (lower == 'completed' || lower == 'success') {
      return 'Transfer Completed';
    } else if (lower == 'failed' || lower == 'error') {
      return 'Transfer Failed';
    } else if (lower == 'pending') {
      return 'Pending';
    } else if (lower == 'scheduled') {
      return 'Scheduled';
    }
    return 'Processing';
  }
}
