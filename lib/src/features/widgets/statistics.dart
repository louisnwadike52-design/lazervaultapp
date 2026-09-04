import 'package:flutter/foundation.dart' show setEquals;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/account_reauth_helper.dart';
import 'package:lazervault/src/features/open_banking/presentation/mixins/linked_balance_refresh_mixin.dart'
    show linkedBalanceRefreshFailureMessage;
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_categories.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/linked_banks_widget.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/bank_scope_pills.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/financial_health_score_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/cash_flow_insights_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/failed_transactions_card.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/statistics_content_skeleton.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/error_state_widget.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
part 'statistics_widgets.dart';


/// Returns true for platform/internal fee categories that should be
/// included in totals but hidden from the UI breakdown.
bool _isPlatformFee(String categoryName) {
  final n = categoryName.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
  return const {
    'fee',
    'fees',
    'service_fees',
    'service_fee',
    'transfer_fee',
    'transfer_fees',
    'exchange_margin',
    'exchange_fee',
    'platform_fee',
    'platform_fees',
    'processing_fee',
    'processing_fees',
    'commission',
    'commissions',
  }.contains(n);
}

/// Maps category names from backend to display-friendly names.
/// Uses ServiceCategories for service subcategory mappings where available.
String _friendlyCategoryName(String raw, {String? serviceName}) {
  // First try to find in ServiceCategories by subcategory name
  final normalized = raw.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
  final serviceCat = ServiceCategories.getBySubCategory(normalized);
  if (serviceCat != null) {
    return serviceCat.displayName;
  }

  // Legacy mappings for backward compatibility
  return switch (raw.toLowerCase()) {
    'p2p transfers' || 'bank transfers' || 'international transfers' => raw,
    'gift cards' || 'bills & utilities' => raw,
    'service fees' || 'tagpay' || 'invoices' => raw,
    'payroll' || 'crowdfunding' || 'deposits' || 'withdrawals' => raw,
    'reversals' || 'transfers' || 'banking' || 'payments' => raw,
    'food & drinks' || 'shopping' || 'transportation' || 'entertainment' => raw,

    'piggyvault' || 'piggy vault' || 'lock funds' || 'lock_funds' => 'Piggyvault',
    'autosave' => 'AutoSave',
    'savings & products' => 'Savings & Products',

    'transfer' || 'c2c_transfer' => 'P2P Transfers',
    'domestic_transfer' => 'Bank Transfers',
    'international_transfer' => 'International Transfers',
    'deposit' => 'Deposits',
    'withdrawal' => 'Withdrawals',
    'fee' => 'Service Fees',
    'reversal' => 'Reversals',
    'payment' || 'invoice_payment' => 'Payments',
    'tag-pay' => 'TagPay',
    'invoice' => 'Invoices',
    'giftcards' || 'gift-cards' || 'gift_card' => 'Gift Cards',
    'airtime' => 'Airtime',
    'bill_payment' => 'Bill Payments',
    'investment' || 'investments' => 'Investments',

    'core-payments-service' || 'core-payments' => 'Transfers',
    'banking-service' => 'Banking',
    'invoice-service' => 'Invoices',
    'giftcards-service' => 'Gift Cards',
    'utility-payments-service' => 'Bills & Utilities',
    'tag-pay-service' => 'TagPay',
    'financial-products-service' => 'Savings & Products',
    'investments-service' => 'Investments',
    'payroll-service' => 'Payroll',
    'crowdfund-service' => 'Crowdfunding',
    'accounts-service' => 'Other',

    _ => raw.replaceAll('-', ' ').replaceAll('_', ' ').split(' ').map((w) =>
        w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '').join(' '),
  };
}

/// Get category color from service categories or fallback
Color _getCategoryColor(String categoryName, {String? serviceName}) {
  final normalized = categoryName.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
  final serviceCat = ServiceCategories.getBySubCategory(normalized);
  if (serviceCat != null) {
    return serviceCat.color;
  }

  // Legacy colors
  return switch (normalized) {
    'p2p_transfers' || 'transfer' => const Color(0xFF4A90E2),
    'bank_transfers' || 'domestic_transfer' => const Color(0xFFE2844A),
    'international_transfers' => const Color(0xFF4AE28D),
    'bills_&_utilities' || 'bill_payment' => const Color(0xFFE24A67),
    'gift_cards' => const Color(0xFF9B4AE2),
    'tagpay' => const Color(0xFFE2E24A),
    'invoices' => const Color(0xFFE2E24A),
    'investments' || 'investment' => const Color(0xFF4AE2D4),
    'payroll' => const Color(0xFFE24ABB),
    'crowdfunding' => const Color(0xFF4AE28D),
    _ => const Color(0xFF6B7280),
  };
}

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  final List<String> timePeriods = ["Day", "Week", "Month", "Quarter", "Year"];
  String selectedPeriod = "Week"; // Default to week instead of Day

  bool showIncome = true;
  bool _includeExternalBanks = true; // Track external banks filter state
  StatisticsSource _statsSource = StatisticsSource.both; // 3-way source filter
  // Selected linked-bank scope. Empty = ALL linked banks; one or more narrows
  // every external number on the page to that SUBSET of banks (multi-select).
  Set<String> _selectedBankIds = <String>{};

  /// The bank scope to send with credit-score / insight reads.
  ///
  /// A comma-separated list of EVERY selected bank, or null when none are
  /// selected. banking-service parses either form and scores across all of
  /// them; null genuinely means unscoped, which it resolves to the user's
  /// default account.
  ///
  /// This used to send an id only when exactly one bank was selected, so
  /// choosing two silently scored the default account instead of the two.
  String? _selectedBankScopeId() {
    if (_selectedBankIds.isEmpty) return null;
    return _selectedBankIds.join(',');
  }
  ExternalDataStatus _externalStatus = ExternalDataStatus.notApplicable;
  String? _externalError;
  String _userId = '';
  String _accessToken = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _ensureActiveAccount();
      context.read<BudgetCubit>().loadBudgetProgress();
      // Resolve identity BEFORE the first stats load so the external-bank
      // leg (banking-service analytics) is included from the start.
      await _initOpenBanking();
      if (!mounted) return;
      context.read<StatisticsCubit>()
        ..userId = _userId
        ..loadStatistics();
    });
  }

  /// Ensure AccountManager has an active account before loading statistics.
  /// Syncs from the dashboard carousel selection, or falls back to
  /// the first available account.
  void _ensureActiveAccount() {
    final accountManager = serviceLocator<AccountManager>();
    if (accountManager.activeAccountId != null) return;

    final accountCubit = context.read<AccountCardsSummaryCubit>();
    final accountState = accountCubit.state;

    List<AccountSummaryEntity> accounts = [];
    if (accountState is AccountCardsSummaryLoaded) {
      accounts = accountState.accountSummaries;
    } else if (accountState is AccountBalanceUpdated) {
      accounts = accountState.accountSummaries;
    }

    if (accounts.isNotEmpty) {
      // Prefer the personal account, fallback to first. Case-insensitive: the
      // model stores the capitalized display value ("Personal"), so a lowercase
      // 'personal' compare never matched and the default always fell through.
      final personal =
          accounts.where((a) => a.accountType.toLowerCase() == 'personal');
      final selected = personal.isNotEmpty ? personal.first : accounts.first;
      accountManager.setActiveAccount(selected.id);
    }
  }

  Future<void> _initOpenBanking() async {
    final secureStorage = serviceLocator<SecureStorageService>();
    final userId = await secureStorage.getUserId() ?? '';
    final accessToken = await secureStorage.getAccessToken() ?? '';
    if (userId.isNotEmpty && mounted) {
      setState(() {
        _userId = userId;
        _accessToken = accessToken;
      });
      // Await linked accounts first to avoid race condition —
      // both methods emit to the same cubit, so running them
      // concurrently causes the second to overwrite the first state.
      await context.read<OpenBankingCubit>().fetchLinkedAccounts(userId: userId, accessToken: accessToken);
      if (mounted) {
        context.read<OpenBankingCubit>().fetchCreditScore(userId: userId);
        // COST-AWARE: do NOT auto-refresh bank balances on stats load — a live
        // Mono read per account burns Connect quota. Rows show the last-known
        // (cached) balance labelled "not live"; the user refreshes explicitly
        // (cost-confirmed) to pull live figures.
      }
    }
  }

  /// User-initiated, COST-CONFIRMED live balance refresh for one bank (same path
  /// as Linked Banks / LazerBeam): quote the fee, and when it's > 0 show the cost
  /// + take a txPIN before charging the wallet and pulling the live figure. A
  /// live Mono balance read is billed, so we never fire it silently.
  Future<void> _costConfirmedRefresh(LinkedBankAccount account) async {
    if (_userId.isEmpty) return;
    final cubit = context.read<OpenBankingCubit>();
    final feeKobo = await cubit.quoteRefreshFee(
      accountId: account.id,
      userId: _userId,
      accessToken: _accessToken,
    );
    if (!mounted) return;
    if (feeKobo <= 0) {
      cubit.refreshBalance(
        accountId: account.id,
        userId: _userId,
        accessToken: _accessToken,
        isManual: true,
      );
      return;
    }
    final feeNaira = feeKobo / 100.0;
    final txnId =
        'refresh-${account.id}-${DateTime.now().millisecondsSinceEpoch}';
    await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'balance_refresh',
      // Fee-only charge: a balance refresh has NO base amount, so pass amount 0
      // and let the sheet render just the ₦fee (not "fee + fee").
      amount: 0,
      fee: feeNaira,
      totalAmount: feeNaira,
      currency: 'NGN',
      title: 'Refresh balance',
      message:
          'Refreshing ${account.bankName} pulls a live balance and costs ₦${feeNaira.toStringAsFixed(2)}. Your last-known balance is shown otherwise.',
      successMessage: 'Balance refreshed',
      // Honest failure: a failed live read shows the sheet's unsuccessful state
      // with category copy, never a false "balance refreshed".
      failureMessageBuilder: linkedBalanceRefreshFailureMessage,
      onPinValidated: (token) async {
        await cubit.refreshBalance(
          accountId: account.id,
          userId: _userId,
          accessToken: _accessToken,
          isManual: true,
          verificationToken: token,
          transactionId: txnId,
          rethrowOnError: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatisticsCubit, StatisticsState>(
      listener: (context, state) {
        if (state is StatisticsLoaded) {
          final cubitPeriod = state.currentPeriod;
          final capitalized = cubitPeriod.isNotEmpty
              ? cubitPeriod[0].toUpperCase() + cubitPeriod.substring(1)
              : selectedPeriod;
          if (capitalized != selectedPeriod) {
            setState(() => selectedPeriod = capitalized);
          }
          // Sync only the load-derived signals. The source/bank selection is
          // driven locally by the tab tap (set synchronously in onTap), so it's
          // authoritative and must NEVER be reverted from here — doing so made
          // the selected tab lag/flicker behind the tap.
          if (_includeExternalBanks != state.includeExternalBanks ||
              _externalStatus != state.externalStatus) {
            setState(() {
              _includeExternalBanks = state.includeExternalBanks;
              _externalStatus = state.externalStatus;
              _externalError = state.externalError;
            });
          }
        }

        if (state is StatisticsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  context.read<StatisticsCubit>().refresh();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        // The header + source tabs + wallet/bank scope row + linking + quick
        // actions are ALWAYS mounted (driven by local state), so a source /
        // bank / period switch never tears them down to a black screen. Only
        // the stats region below swaps to the diagonal skeleton while loading.
        return Container(
          color: const Color(0xFF0A0A0A),
          child: RefreshIndicator(
            onRefresh: () => context.read<StatisticsCubit>().refresh(),
            color: InvoiceThemeColors.primaryPurple,
            backgroundColor: const Color(0xFF1F1F1F),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 12.h),

                  // ============ ONE COMPACT FILTER BAR ============
                  // Source / Banks / Period / Wallet-account chips — each shows
                  // the current selection, opens its own picker sheet, and
                  // scopes EVERY section below. Replaces the old always-inline
                  // source segments + wallet row + Analytics period selector.
                  _buildCompactFilterBar(),
                  SizedBox(height: 12.h),

                  // Honesty signal: when bank data couldn't be fetched from
                  // Mono, say so (with Retry) instead of rendering fake zeros.
                  _buildExternalStatusNotice(),

                  // ==================== LINKED BANKS + CREDIT (TOP) ====================
                  // Linking is the gateway to every external-bank number below,
                  // so it lives at the top beside the credit score whenever
                  // external banks are in scope.
                  if (_statsSource.includesExternal) ...[
                    _buildLinkedBanksSection(),
                    SizedBox(height: 12.h),
                  ],
                  _buildCreditScoreCTA(),
                  SizedBox(height: 16.h),

                  // ==================== STATS CONTENT (skeleton-or-real) ======
                  // Collapsible sections; the Quick Actions grid is now folded
                  // into the "Budgets & Management" section, not a separate block.
                  _buildStatsContent(state),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// The metric-bearing region (Overview / Insights / Analytics / Category /
  /// Management). Shows the diagonal dark skeleton on first load AND while a
  /// source/bank/period change is reloading (isRefreshing), an inline error
  /// widget on failure, and the real sections once loaded. The header + tabs
  /// + quick actions above stay mounted throughout.
  Widget _buildStatsContent(StatisticsState state) {
    final showSkeleton = state is StatisticsInitial ||
        state is StatisticsLoading ||
        (state is StatisticsLoaded && state.isRefreshing);
    if (showSkeleton) {
      return const StatisticsContentSkeleton();
    }
    if (state is StatisticsError) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: ErrorStateWidget(
          message: state.message,
          onRetry: () => context.read<StatisticsCubit>().refresh(),
        ),
      );
    }
    if (state is! StatisticsLoaded) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Metrics below depend on real transaction data. For a BANK-ONLY scope
        // whose data couldn't be read, we already show the notice above and
        // SKIP the metric sections rather than render misleading zeros/scores.
        // Each section is a collapsible card whose heavy chart subtree is built
        // ONLY when expanded (lazy) — collapsed charts never render.
        if (!_bankScopeDataMissing) ...[
          _CollapsibleSection(
            key: const ValueKey('overview'),
            title: 'Overview',
            trailing: _buildScopeBadge(),
            initiallyExpanded: true,
            childBuilder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuickStats(state),
                SizedBox(height: 12.h),
                _buildPerformanceAlert(state),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _CollapsibleSection(
            key: const ValueKey('insights'),
            title: 'Insights',
            childBuilder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFinancialHealthScore(state),
                SizedBox(height: 12.h),
                _buildCashFlowInsights(state),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          _CollapsibleSection(
            key: const ValueKey('analytics'),
            title: 'Analytics',
            childBuilder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSpendingChart(state),
                SizedBox(height: 12.h),
                _buildMonthlyTrendChart(state),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          if (_hasCategoryData(state)) ...[
            _CollapsibleSection(
              key: const ValueKey('categories'),
              title: 'Categories',
              childBuilder: (_) => _buildCategoryAnalysisContent(state),
            ),
            SizedBox(height: 12.h),
          ],
        ],
        _CollapsibleSection(
          key: const ValueKey('budgets_management'),
          title: 'Budgets & Management',
          childBuilder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFeatureGrid(),
              _buildManagementSection(state),
            ],
          ),
        ),
      ],
    );
  }

  // ============ CONSOLIDATED FILTER BAR ============
  // One compact, horizontally-scrollable row of chips that each open a picker
  // sheet and scope EVERY section below. Replaces the old always-inline source
  // segments + wallet row + Analytics period selector; the bank list now lives
  // in a bottom sheet instead of clustering the page inline.
  /// The filter area: a dedicated Lazervault / Both / Bank source toggle on top,
  /// with the Period / Banks / Wallet pills BELOW it. The pills that show are
  /// keyed off the selected source — Banks only when a bank is in scope, Wallet
  /// only when the wallet is in scope — so e.g. selecting "Lazervault" hides the
  /// "All banks" pill entirely.
  Widget _buildCompactFilterBar() {
    final includesWallet = _statsSource != StatisticsSource.bank;
    final banksActive = _selectedBankIds.isNotEmpty;
    final banksLabel = _selectedBankIds.isEmpty
        ? 'All banks'
        : '${_selectedBankIds.length} bank${_selectedBankIds.length == 1 ? '' : 's'}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSourceToggle(),
        SizedBox(height: 10.h),
        SizedBox(
          height: 40.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              _filterChip(Icons.calendar_today_rounded, selectedPeriod,
                  () => _openFilterSheet('Period', _buildPeriodSheet())),
              if (_statsSource.includesExternal) ...[
                SizedBox(width: 8.w),
                _filterChip(Icons.account_balance_rounded, banksLabel,
                    () => _openFilterSheet('Banks', _buildBanksSheet()),
                    active: banksActive),
              ],
              if (includesWallet) ...[
                SizedBox(width: 8.w),
                _filterChip(Icons.account_balance_wallet_rounded, 'Wallet',
                    () => _openFilterSheet('Wallet account', _buildWalletSheet())),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Segmented Lazervault | Bank | Both source selector — one tap to switch
  /// scope (replaces the old chip → sheet → tile flow). "Both" (the union) sits
  /// LAST so the two single-source scopes lead. Drives [_statsSource] + the
  /// cubit scope; a switch re-fetches ONLY the newly-active scope.
  Widget _buildSourceToggle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          _sourceSegment(StatisticsSource.lazervault, 'Lazervault',
              Icons.account_balance_wallet_rounded),
          _sourceSegment(
              StatisticsSource.bank, 'Bank', Icons.account_balance_rounded),
          _sourceSegment(
              StatisticsSource.both, 'Both', Icons.dashboard_rounded),
        ],
      ),
    );
  }

  Widget _sourceSegment(StatisticsSource value, String label, IconData icon) {
    final selected = _statsSource == value;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_statsSource == value) return;
          // Mirror StatisticsCubit.changeSource(), which WIPES the per-bank
          // filter on every source switch. Without clearing the local set too,
          // the Banks pill would keep showing "N banks"/active-purple while the
          // cubit has actually reverted to All — a lie the user can't explain.
          setState(() {
            _statsSource = value;
            _selectedBankIds = <String>{};
          });
          context.read<StatisticsCubit>().changeSource(value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(vertical: 9.h),
          decoration: BoxDecoration(
            color: selected
                ? InvoiceThemeColors.primaryPurple
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 14.sp,
                  color: selected ? Colors.white : const Color(0xFF9CA3AF)),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color:
                            selected ? Colors.white : const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight:
                            selected ? FontWeight.w700 : FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterChip(IconData icon, String label, VoidCallback onTap,
      {bool active = false}) {
    final accent = InvoiceThemeColors.primaryPurple;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: active
              ? accent.withValues(alpha: 0.16)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
              color: active
                  ? accent.withValues(alpha: 0.55)
                  : const Color(0xFF2D2D2D)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 14.sp,
                color: active ? accent : const Color(0xFFB9A5E8)),
            SizedBox(width: 6.w),
            Text(label,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(width: 4.w),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 16.sp,
                color: active ? accent : const Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }

  /// Opens a dark, rounded picker sheet. The sheet is pushed on the root
  /// navigator (ABOVE the tab's MultiBlocProvider), so re-provide the cubits the
  /// sheet content reads (BankScopePills is a BlocBuilder<OpenBankingCubit>).
  Future<void> _openFilterSheet(String title, Widget child) {
    final statsCubit = context.read<StatisticsCubit>();
    final obCubit = context.read<OpenBankingCubit>();
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => MultiBlocProvider(
        providers: [
          BlocProvider<StatisticsCubit>.value(value: statsCubit),
          BlocProvider<OpenBankingCubit>.value(value: obCubit),
        ],
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Text(title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 12.h),
                Flexible(child: SingleChildScrollView(child: child)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: timePeriods.map((period) {
        final selected = period == selectedPeriod;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            if (period != selectedPeriod) {
              setState(() => selectedPeriod = period);
              context.read<StatisticsCubit>().changePeriod(period.toLowerCase());
            }
            Navigator.of(context).pop();
          },
          title: Text(period,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
          trailing: selected
              ? Icon(Icons.check_rounded,
                  color: InvoiceThemeColors.primaryPurple, size: 20.sp)
              : null,
        );
      }).toList(),
    );
  }

  Widget _buildBanksSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBankScopeChips(),
        SizedBox(height: 8.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Done',
                style: GoogleFonts.inter(
                    color: InvoiceThemeColors.primaryPurple,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _buildWalletSheet() => _buildWalletAccountRow();

  /// True when the loaded state carries any income/expense category rows — used
  /// to skip the Categories collapsible entirely when there's nothing to show.
  bool _hasCategoryData(StatisticsState state) {
    if (state is! StatisticsLoaded) return false;
    final c = state.categoryAnalytics;
    return c != null &&
        (c.incomeCategories.isNotEmpty || c.expenseCategories.isNotEmpty);
  }

  /// The category breakdown CONTENT (toggle + income/expense analysis) WITHOUT
  /// its own section header — the collapsible card supplies the title.
  Widget _buildCategoryAnalysisContent(StatisticsState state) {
    if (state is! StatisticsLoaded) return const SizedBox.shrink();
    final catAnalytics = state.categoryAnalytics;
    final hasIncome =
        catAnalytics != null && catAnalytics.incomeCategories.isNotEmpty;
    final hasExpense =
        catAnalytics != null && catAnalytics.expenseCategories.isNotEmpty;
    if (!hasIncome && !hasExpense) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildToggleSection(),
        SizedBox(height: 12.h),
        showIncome && hasIncome
            ? _buildIncomeAnalysis(state)
            : (!showIncome && hasExpense
                ? _buildExpenseAnalysis(state)
                : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              InvoiceThemeColors.primaryPurple.withValues(alpha: 0.10),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded so the title column yields space to the action icons
            // instead of overflowing — the reusable 22sp header scale used
            // across Auto-Save / Joint Funds.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights,
                        color: InvoiceThemeColors.primaryPurple,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          'Finance Analytics',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Smart financial analytics and budgeting powered by AI',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Per-service voice + chat icons — pin every session
            // opened from the Statistics tab to chat-statistics-service
            // via DIRECT_ROUTES['statistics']. Mirrors the canonical
            // pair used across all other dashboard quick services.
            ServiceVoiceButton(
              serviceName: 'statistics',
              iconColor: InvoiceThemeColors.primaryPurple,
              backgroundColor: InvoiceThemeColors.primaryPurple,
              buttonSize: 36.w,
              iconSize: 17.sp,
            ),
            SizedBox(width: 8.w),
            MicroserviceChatIcon(
              serviceName: 'Statistics',
              sourceContext: 'statistics',
              icon: Icons.chat_bubble_outline,
              iconColor: InvoiceThemeColors.primaryPurple,
              chatAccentColor: InvoiceThemeColors.primaryPurple,
              size: 36,
              iconSize: 19,
            ),
            // Account selector moved OUT of the header (it overflowed beside
            // the title + 2 icon buttons, and is useless on the Banks tab).
            // It now renders under the source tabs for wallet/all scopes —
            // see _buildWalletAccountRow().
          ],
        ),
      ),
    );
  }

  /// Wallet account selector row, shown UNDER the source tabs only for
  /// wallet/all scopes (hidden on the Banks tab, where the bank scope chips
  /// scope the numbers). Selecting an account re-scopes the wallet analytics
  /// leg via AccountManager + StatisticsCubit.refresh().
  Widget _buildWalletAccountRow() {
    if (_statsSource == StatisticsSource.bank) return const SizedBox.shrink();
    final selector = _buildAccountSelector();
    if (selector is SizedBox) return const SizedBox.shrink(); // no accounts
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_rounded,
              size: 14.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(width: 6.w),
          Text(
            'Wallet account',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          selector,
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    final accountManager = serviceLocator<AccountManager>();
    final accountCubit = context.read<AccountCardsSummaryCubit>();
    final accountState = accountCubit.state;

    List<AccountSummaryEntity> accounts = [];
    if (accountState is AccountCardsSummaryLoaded) {
      accounts = accountState.accountSummaries;
    } else if (accountState is AccountBalanceUpdated) {
      accounts = accountState.accountSummaries;
    }

    if (accounts.isEmpty) {
      return const SizedBox.shrink();
    }

    final activeId = accountManager.activeAccountId;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 160.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: activeId != null && accounts.any((a) => a.id == activeId)
                ? activeId
                : accounts.first.id,
            dropdownColor: const Color(0xFF1F1F1F),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 18.r),
            isDense: true,
            isExpanded: true,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
            items: accounts.map((account) {
              // Show the account TYPE (Personal / Investment / Savings) so the
              // accounts are DISTINGUISHABLE — accountName is the holder's name
              // (the same person on every account) and can't differentiate them.
              // Append the last-4 so two accounts of the same type are still
              // tellable apart.
              final last4 = account.accountNumberLast4;
              final label = (last4.isNotEmpty && last4 != '••••')
                  ? '${account.accountType} •••• $last4'
                  : account.accountType;
              return DropdownMenuItem<String>(
                value: account.id,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        account.currency,
                        style: TextStyle(
                          color: InvoiceThemeColors.primaryPurple,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (newAccountId) {
              if (newAccountId != null && newAccountId != activeId) {
                accountManager.setActiveAccount(newAccountId);
                context.read<StatisticsCubit>().refresh();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats(StatisticsState state) {
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    double savingsRate = 0.0;
    double incomeChange = 0.0;
    double expenseChange = 0.0;

    if (state is StatisticsLoaded && state.financialAnalytics != null) {
      final analytics = state.financialAnalytics!;
      if (analytics.hasCurrentPeriod()) {
        totalIncome = analytics.currentPeriod.totalIncome;
        totalExpenses = analytics.currentPeriod.totalExpenses;
        if (totalIncome > 0) {
          savingsRate = ((totalIncome - totalExpenses) / totalIncome * 100);
        }
      }
      incomeChange = analytics.incomeChangePercent;
      expenseChange = analytics.expenseChangePercent;
    }

    String formatTrend(double change) {
      final prefix = change >= 0 ? '+' : '';
      return '$prefix${change.toStringAsFixed(1)}%';
    }

    final savingsChange = incomeChange - expenseChange;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF39026F), Color(0xFF4E03D0), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.analytics_outlined, color: Colors.white, size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                'Financial Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _QuickStatCard(
                  label: 'Income',
                  value: CurrencySymbols.formatAmount(totalIncome),
                  icon: Icons.arrow_downward,
                  color: Colors.white,
                  trend: formatTrend(incomeChange),
                  isPositive: incomeChange >= 0,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickStatCard(
                  label: 'Expenses',
                  value: CurrencySymbols.formatAmount(totalExpenses),
                  icon: Icons.arrow_upward,
                  color: Colors.white,
                  trend: formatTrend(expenseChange),
                  isPositive: expenseChange <= 0,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _QuickStatCard(
                  label: 'Savings',
                  value: '${savingsRate.toStringAsFixed(0)}%',
                  icon: Icons.savings,
                  color: Colors.white,
                  trend: formatTrend(savingsChange),
                  isPositive: savingsChange >= 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceAlert(StatisticsState state) {
    if (state is! StatisticsLoaded || state.financialAnalytics == null) {
      return const SizedBox.shrink();
    }

    final analytics = state.financialAnalytics!;
    double totalIncome = 0;
    double totalExpenses = 0;
    double savingsRate = 0;
    double expenseChange = analytics.expenseChangePercent;

    if (analytics.hasCurrentPeriod()) {
      totalIncome = analytics.currentPeriod.totalIncome;
      totalExpenses = analytics.currentPeriod.totalExpenses;
      if (totalIncome > 0) {
        savingsRate = (totalIncome - totalExpenses) / totalIncome * 100;
      }
    }

    if (totalIncome <= 0) return const SizedBox.shrink();

    String emoji;
    String message;
    Color borderColor;

    if (expenseChange > 20) {
      emoji = '\u{1F534}';
      message = 'Spending up ${expenseChange.toStringAsFixed(0)}% vs last period';
      borderColor = const Color(0xFFEF4444).withValues(alpha: 0.3);
    } else if (savingsRate >= 20) {
      emoji = '\u{1F389}';
      message = 'Great job! You\'re saving ${savingsRate.toStringAsFixed(0)}% this month';
      borderColor = const Color(0xFF10B981).withValues(alpha: 0.3);
    } else if (savingsRate >= 10) {
      emoji = '\u{1F4AA}';
      message = 'Good progress \u2014 you saved ${savingsRate.toStringAsFixed(0)}% this month';
      borderColor = InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3);
    } else {
      emoji = '\u{26A0}\u{FE0F}';
      message = 'Heads up \u2014 only ${savingsRate.toStringAsFixed(0)}% saved this month';
      borderColor = const Color(0xFFFB923C).withValues(alpha: 0.3);
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.budgetAIInsights),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 22.sp)),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.auto_awesome, color: const Color.fromARGB(255, 78, 3, 208), size: 18.sp),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialHealthScore(StatisticsState state) {
    if (state is! StatisticsLoaded || state.financialAnalytics == null) {
      return const SizedBox.shrink();
    }

    final analytics = state.financialAnalytics!;
    if (!analytics.hasCurrentPeriod()) return const SizedBox.shrink();

    final current = analytics.currentPeriod;

    if (current.totalIncome <= 0 && current.totalExpenses <= 0) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<BudgetCubit, BudgetState>(
      buildWhen: (prev, curr) =>
          curr is BudgetProgressLoaded || curr is BudgetInitial,
      builder: (context, budgetState) {
        List<({double spent, double budget})> budgetItems = [];
        if (budgetState is BudgetProgressLoaded) {
          budgetItems = budgetState.items
              .map((item) => (spent: item.spentAmount, budget: item.budgetAmount))
              .toList();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: FinancialHealthScoreCard(
            data: FinancialHealthData(
              totalIncome: current.totalIncome,
              totalExpenses: current.totalExpenses,
              incomeChangePercent: analytics.incomeChangePercent,
              expenseChangePercent: analytics.expenseChangePercent,
              budgetItems: budgetItems,
            ),
            onTap: () => Get.toNamed(
              AppRoutes.creditScore,
              arguments: {
                'userId': _userId,
                'showAllSources': _includeExternalBanks,
                // EVERY selected bank, not just one. Passing null for a
                // multi-bank selection did not mean "all banks" as the old
                // comment claimed: banking-service reads an absent scope as
                // GetDefaultByUserID, so the screen showed the DEFAULT bank's
                // score while the UI implied it covered the selection.
                'linkedAccountId': _selectedBankScopeId(),
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCashFlowInsights(StatisticsState state) {
    if (state is! StatisticsLoaded || state.financialAnalytics == null) {
      return const SizedBox.shrink();
    }

    final analytics = state.financialAnalytics!;
    if (!analytics.hasCurrentPeriod()) return const SizedBox.shrink();

    final current = analytics.currentPeriod;
    if (current.totalIncome <= 0 && current.totalExpenses <= 0) {
      return const SizedBox.shrink();
    }

    double dailyAverage = 0;
    if (state.expenseTimeSeries != null && state.expenseTimeSeries!.dailyAverage > 0) {
      dailyAverage = state.expenseTimeSeries!.dailyAverage;
    } else if (current.totalExpenses > 0) {
      final elapsed = DateTime.now().difference(state.startDate).inDays.clamp(1, 366);
      dailyAverage = current.totalExpenses / elapsed;
    }

    List<({String name, double amount, double percentage})> topCategories = [];
    if (state.categoryAnalytics != null) {
      topCategories = state.categoryAnalytics!.expenseCategories
          .where((c) => !_isPlatformFee(c.categoryName))
          .map((c) => (
                name: _friendlyCategoryName(c.categoryName),
                amount: c.amount,
                percentage: c.percentage,
              ))
          .toList();
      if (topCategories.length > 3) {
        topCategories = topCategories.sublist(0, 3);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CashFlowInsightsCard(
        data: CashFlowData(
          totalIncome: current.totalIncome,
          totalExpenses: current.totalExpenses,
          dailyAverage: dailyAverage,
          expenseChangePercent: analytics.expenseChangePercent,
          period: state.currentPeriod,
          periodStart: state.startDate,
          periodEnd: state.endDate,
          topCategories: topCategories,
          transactionCount: current.transactionCount,
        ),
      ),
    );
  }

  Widget _buildFeatureGrid() {
    // Bills + Categories removed — not needed on this surface. The four kept
    // actions each have a verified end-to-end flow.
    final features = [
      _FeatureItem(
        title: 'Budgets',
        description: 'Manage budgets',
        icon: Icons.account_balance_wallet,
        color: InvoiceThemeColors.primaryPurple,
        route: AppRoutes.budgetList,
      ),
      _FeatureItem(
        title: 'AI Insights',
        description: 'Smart recommendations',
        icon: Icons.auto_awesome,
        color: const Color.fromARGB(255, 78, 3, 208),
        route: AppRoutes.budgetAIInsights,
      ),
      _FeatureItem(
        title: 'Goals',
        description: 'Track goals',
        icon: Icons.flag,
        color: const Color(0xFFFB923C),
        route: AppRoutes.financialGoals,
      ),
      _FeatureItem(
        title: 'Spending',
        description: 'Analyze spending',
        icon: Icons.pie_chart,
        color: const Color(0xFFEC4899),
        route: AppRoutes.statisticsSpendingDetail,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.5,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return _FeatureCard(feature: features[index]);
      },
    );
  }

  /// Bank scope selector: a compact, horizontally-scrollable row of bank pills
  /// ("All banks" + one per linked bank, overflow collapsing into a small
  /// "More ▾" dropdown), followed by a scope banner that makes it obvious when
  /// EVERY number on the page is narrowed to a single bank. Picking a pill
  /// re-scopes the whole page via [_applyBankFilter].
  Widget _buildBankScopeChips() {
    return BlocBuilder<OpenBankingCubit, OpenBankingState>(
      buildWhen: (prev, curr) =>
          curr is LinkedAccountsLoaded ||
          curr is AccountLinked ||
          curr is AccountLinkedWithMandate ||
          curr is AccountUnlinked,
      builder: (context, _) {
        final banks = context.read<OpenBankingCubit>().linkedAccounts;
        if (banks.isEmpty) {
          // All banks gone (e.g. last one unlinked): drop any stale scope so
          // the page isn't filtered to a bank that no longer exists.
          if (_selectedBankIds.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _applyBankFilter(const <String>{});
            });
          }
          // No pills to show — the single, beautified empty state lives in the
          // Linked Banks section below, so we don't duplicate the messaging here.
          return const SizedBox.shrink();
        }
        // Some selected banks were unlinked but others remain: prune the dead
        // ids so the numbers don't stay scoped to accounts that no longer exist.
        final liveIds = banks.map((b) => b.id).toSet();
        if (_selectedBankIds.isNotEmpty &&
            !_selectedBankIds.every(liveIds.contains)) {
          final pruned = _selectedBankIds.intersection(liveIds);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _applyBankFilter(pruned);
          });
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BankScopePills(
              banks: banks,
              selectedIds: _selectedBankIds,
              onChanged: _applyBankFilter,
            ),
            SizedBox(height: 8.h),
            _buildBankScopeBanner(banks),
          ],
        );
      },
    );
  }

  /// Makes the active scope unmistakable: an orange banner when the page is
  /// narrowed to ONE bank (with a "View all" escape hatch), or a muted line
  /// when every linked bank is in scope.
  Widget _buildBankScopeBanner(List<LinkedBankAccount> banks) {
    if (_selectedBankIds.isEmpty) {
      return Row(
        children: [
          Icon(Icons.all_inclusive_rounded,
              size: 12.sp, color: const Color(0xFF6B7280)),
          SizedBox(width: 6.w),
          Text(
            'Across all your linked banks',
            style: GoogleFonts.inter(
                color: const Color(0xFF6B7280), fontSize: 11.5.sp),
          ),
        ],
      );
    }

    // One selected → its name; several → "N banks".
    final selected =
        banks.where((b) => _selectedBankIds.contains(b.id)).toList();
    final bankName = selected.isEmpty
        ? 'these banks'
        : selected.length == 1
            ? selected.first.bankName
            : '${selected.length} banks';
    final hidden =
        _statsSource == StatisticsSource.both ? 'wallet & other banks' : 'other banks';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_alt_rounded,
              size: 14.sp, color: const Color(0xFFFB923C)),
          SizedBox(width: 8.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 11.5.sp, height: 1.35),
                children: [
                  const TextSpan(text: 'Analytics scoped to '),
                  TextSpan(
                    text: bankName,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(text: ' only'),
                  TextSpan(text: ' · $hidden hidden'),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => _applyBankFilter(const <String>{}),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'View all',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Apply a bank scope selection: update local state and re-scope every number
  /// on the page via the cubit. No billed live balance read is fired here —
  /// filtering analytics must never cost money. The Linked Banks rows carry
  /// their own explicit, cost-confirmed balance refresh.
  void _applyBankFilter(Set<String> ids) {
    final next = Set<String>.from(ids);
    if (setEquals(_selectedBankIds, next)) return;
    setState(() => _selectedBankIds = next);
    context.read<StatisticsCubit>().changeBanks(next.toList());
  }

  /// True when the active scope is BANK-ONLY and that bank data could not be
  /// read (failed sync/fetch) OR is genuinely empty — so the metric sections
  /// must be skipped instead of rendering misleading zeros. (Combined scope
  /// keeps showing the real wallet numbers + a banner.)
  bool get _bankScopeDataMissing =>
      _statsSource == StatisticsSource.bank &&
      (_externalStatus == ExternalDataStatus.unavailable ||
          _externalStatus == ExternalDataStatus.empty);

  /// Honest external-data notice. Renders nothing when external is ready or
  /// out of scope; an amber retry card when unavailable; a neutral empty card
  /// when the scope has no synced activity. For combined scope an unavailable
  /// external shows a slim "showing LazerVault only" banner.
  Widget _buildExternalStatusNotice() {
    if (!_statsSource.includesExternal) return const SizedBox.shrink();

    final bankLabel = () {
      if (_selectedBankIds.isEmpty) return 'your banks';
      final banks = context.read<OpenBankingCubit>().linkedAccounts;
      final selected =
          banks.where((b) => _selectedBankIds.contains(b.id)).toList();
      if (selected.isEmpty) return 'these banks';
      if (selected.length == 1) return selected.first.bankName;
      return '${selected.length} banks';
    }();

    Widget card({
      required IconData icon,
      required Color color,
      required String title,
      required String body,
      bool showRetry = false,
    }) {
      return Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 3.h),
                  Text(body,
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 11.5.sp, height: 1.4)),
                ],
              ),
            ),
            if (showRetry) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => context.read<StatisticsCubit>().refresh(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text('Retry',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ],
        ),
      );
    }

    switch (_externalStatus) {
      case ExternalDataStatus.unavailable:
        if (_statsSource == StatisticsSource.both) {
          return card(
            icon: Icons.info_outline_rounded,
            color: const Color(0xFFFB923C),
            title: 'Showing LazerVault only',
            body: _externalError ??
                'We couldn\'t load $bankLabel right now. Pull to refresh to retry.',
            showRetry: true,
          );
        }
        return card(
          icon: Icons.cloud_off_rounded,
          color: const Color(0xFFEF4444),
          title: 'Couldn\'t load $bankLabel',
          body: _externalError ??
              'We couldn\'t read transactions from $bankLabel. Your numbers aren\'t shown to avoid guessing.',
          showRetry: true,
        );
      case ExternalDataStatus.empty:
        return card(
          icon: Icons.inbox_rounded,
          color: const Color(0xFF6B7280),
          title: 'No bank activity yet',
          body: 'No synced transactions for $bankLabel in this period.',
        );
      case ExternalDataStatus.ready:
      case ExternalDataStatus.notApplicable:
        return const SizedBox.shrink();
    }
  }

  /// Small read-only badge restating the active scope next to "Overview" —
  /// the actual control is the filter bar above.
  Widget _buildScopeBadge() {
    String label = _statsSource.label;
    if (_statsSource.includesExternal && _selectedBankIds.isNotEmpty) {
      final banks = context.read<OpenBankingCubit>().linkedAccounts;
      final selected =
          banks.where((b) => _selectedBankIds.contains(b.id)).toList();
      if (selected.isNotEmpty) {
        final scope = selected.length == 1
            ? selected.first.bankName
            : '${selected.length} banks';
        label =
            _statsSource == StatisticsSource.both ? 'Wallet + $scope' : scope;
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: InvoiceThemeColors.primaryPurple,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSpendingChart(StatisticsState state) {
    List<FlSpot> spots = [];

    if (state is StatisticsLoaded && state.expenseTimeSeries != null) {
      final dataPoints = state.expenseTimeSeries!.dataPoints;
      if (dataPoints.isNotEmpty) {
        for (int i = 0; i < dataPoints.length; i++) {
          spots.add(FlSpot(i.toDouble(), dataPoints[i].amount));
        }
      }
    }

    if (spots.isEmpty) {
      return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.statisticsSpendingDetail),
        child: Container(
          height: 180.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(Icons.show_chart, color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.5), size: 32.r),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No expense data for this period',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tap to view detailed spending',
                  style: TextStyle(color: const Color(0xFF6B7280), fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.statisticsSpendingDetail),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spending Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See Details',
                  style: TextStyle(
                    color: InvoiceThemeColors.primaryPurple,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 120.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4E03D0), Color(0xFF7C3AED)],
                      ),
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
                            const Color(0xFF7C3AED).withValues(alpha: 0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTrendChart(StatisticsState state) {
    List<accounts_pb.MonthlyDataPoint> monthlyPoints = [];

    if (state is StatisticsLoaded && state.monthlyTrends != null) {
      monthlyPoints = state.monthlyTrends!.months.toList();
    }

    if (monthlyPoints.isEmpty) {
      return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.statisticsMonthlyTrends),
        child: Container(
          height: 200.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(Icons.bar_chart, color: const Color(0xFFFB923C).withValues(alpha: 0.5), size: 32.r),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No monthly trend data available',
                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tap to view monthly trends',
                  style: TextStyle(color: const Color(0xFF6B7280), fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final maxY = monthlyPoints.fold<double>(0.0, (max, point) {
      final bigger = point.income > point.expenses ? point.income : point.expenses;
      return bigger > max ? bigger : max;
    });
    final roundedMaxY = maxY > 0 ? (maxY * 1.2).ceilToDouble() : 10000.0;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.statisticsMonthlyTrends),
      child: Container(
        height: 240.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                  'Monthly Trends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See Details',
                  style: TextStyle(
                    color: InvoiceThemeColors.primaryPurple,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: roundedMaxY,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= monthlyPoints.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            monthlyPoints[index].monthLabel,
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                          );
                        },
                        reservedSize: 28,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          final compactValue = value >= 1000000
                              ? '${(value / 1000000).toStringAsFixed(1)}M'
                              : value >= 1000
                                  ? '${(value / 1000).toStringAsFixed(0)}K'
                                  : '${value.toInt()}';
                          return Text(
                            compactValue,
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 10.sp),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: roundedMaxY > 0 ? roundedMaxY / 5 : 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white.withValues(alpha: 0.1),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    monthlyPoints.length,
                    (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: monthlyPoints[index].income,
                          color: Colors.green[300],
                          width: 10.w,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        BarChartRodData(
                          toY: monthlyPoints[index].expenses,
                          color: Colors.red[300],
                          width: 10.w,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChartLegend('Income', Colors.green[300]!),
                SizedBox(width: 24.w),
                _buildChartLegend('Expenses', Colors.red[300]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // _buildCategoryAnalysisSection was split into _hasCategoryData +
  // _buildCategoryAnalysisContent (the collapsible "Categories" card supplies
  // the header), so the old header-bearing builder is gone.

  Widget _buildManagementSection(StatisticsState state) {
    // Only show failed transactions card if available
    final hasFailedTransactions = state is StatisticsLoaded &&
        state.failedTransactions != null &&
        state.failedTransactions!.transactions.isNotEmpty;

    if (!hasFailedTransactions) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Management'),
        SizedBox(height: 12.h),
        _buildFailedTransactionsSection(state),
      ],
    );
  }

  Widget _buildCreditScoreCTA() {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.creditScore,
        arguments: {
          'userId': _userId,
          'showAllSources': _includeExternalBanks,
          // Every selected bank (see _selectedBankScopeId).
          'linkedAccountId': _selectedBankScopeId(),
        },
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.speed_rounded,
                color: const Color(0xFFFB923C),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credit Score',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'View your score, insights & tips to improve',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF9CA3AF),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedBanksSection() {
    return BlocBuilder<OpenBankingCubit, OpenBankingState>(
      buildWhen: (prev, curr) =>
          curr is LinkedAccountsLoaded ||
          curr is AccountLinked ||
          curr is AccountLinkedWithMandate ||
          curr is AccountUnlinked ||
          curr is BalanceRefreshed ||
          curr is AccountTransactionsSynced ||
          curr is OpenBankingInitial ||
          curr is OpenBankingError,
      builder: (context, state) {
        final all = context.read<OpenBankingCubit>().linkedAccounts;
        // When the user has picked a specific bank in the budgeting filter,
        // narrow the Linked Banks section to JUST that bank — the content
        // above is already scoped to it, so showing the full list here is
        // misleading. Falling back to the full list when no bank is picked.
        // selectedBankAccountId only lives on StatisticsLoaded; we read it
        // straight off the cubit (which holds the canonical value across
        // every state transition) so loading + initial states also respect
        // the filter on first paint.
        return BlocBuilder<StatisticsCubit, StatisticsState>(
          buildWhen: (prev, curr) {
            List<String> extract(StatisticsState s) =>
                s is StatisticsLoaded ? s.selectedBankAccountIds : const [];
            return !setEquals(extract(prev).toSet(), extract(curr).toSet());
          },
          builder: (context, statsState) {
            // Filtering now lives in the bank pills above — the Linked Banks
            // section always lists EVERY bank so any of them can be managed,
            // regardless of which one the analytics is scoped to.
            final displayed = all;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: LinkedBanksWidget(
                linkedAccounts: displayed,
                userId: _userId,
                accessToken: _accessToken,
                // Highlight the single scoped bank when exactly one is selected.
                selectedAccountId:
                    _selectedBankIds.length == 1 ? _selectedBankIds.first : null,
                onBankTap: (account) {
                  // Tapping a bank opens its management sheet (refresh, set
                  // default, reconnect, unlink) — filtering is handled by the
                  // bank pills above, not by tapping the list.
                  _showBankManagementSheet(account);
                },
                // Per-card refresh icon → the SAME fee-gated path (quote fee →
                // cost-confirm tx-PIN → live Mono read). Never a free direct
                // read; no silent bulk balance pull here.
                onRefreshBalance: _costConfirmedRefresh,
                onRefresh: null,
              ),
            );
          },
        );
      },
    );
  }

  /// Per-bank management sheet, opened by tapping a linked-bank row. Offers the
  /// same actions as the full Linked Banks screen (refresh balance, set default,
  /// reconnect, unlink) without leaving the AI Budgeting page.
  void _showBankManagementSheet(LinkedBankAccount account) {
    final cubit = context.read<OpenBankingCubit>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.account_balance_rounded,
                          size: 20.sp, color: InvoiceThemeColors.primaryPurple),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.bankName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            account.displayAccountNumber,
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    if (account.isDefault)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text('Default',
                            style: GoogleFonts.inter(
                                color: const Color(0xFF10B981),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(color: const Color(0xFF2D2D2D), height: 1.h),
                SizedBox(height: 8.h),
                if (account.needsReauthorization)
                  _bankMgmtTile(
                    icon: Icons.link_off_rounded,
                    color: const Color(0xFFFB923C),
                    label: 'Reconnect bank',
                    subtitle: 'This connection expired — reauthorize to sync',
                    onTap: () {
                      Navigator.of(sheetCtx).pop();
                      startAccountReauthorization(context, account);
                    },
                  ),
                _bankMgmtTile(
                  icon: Icons.sync_rounded,
                  color: InvoiceThemeColors.primaryPurple,
                  label: 'Refresh balance',
                  subtitle: 'Pull the latest balance from your bank',
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _costConfirmedRefresh(account);
                  },
                ),
                if (!account.isDefault)
                  _bankMgmtTile(
                    icon: Icons.star_rounded,
                    color: const Color(0xFFF59E0B),
                    label: 'Set as default',
                    subtitle: 'Use this bank first for linked-bank actions',
                    onTap: () {
                      Navigator.of(sheetCtx).pop();
                      cubit.setDefaultAccount(
                        accountId: account.id,
                        userId: _userId,
                        accessToken: _accessToken,
                      );
                    },
                  ),
                _bankMgmtTile(
                  icon: Icons.tune_rounded,
                  color: const Color(0xFF9CA3AF),
                  label: 'Manage all banks',
                  subtitle: 'Open the full linked-banks screen',
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    Get.toNamed(
                      AppRoutes.linkedBanks,
                      arguments: {
                        'highlightAccountId': account.id,
                        'fromStatistics': true,
                      },
                    );
                  },
                ),
                _bankMgmtTile(
                  icon: Icons.link_off_rounded,
                  color: const Color(0xFFEF4444),
                  label: 'Unlink bank',
                  subtitle: 'Remove this bank from Lazervault',
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _confirmUnlinkBank(account, cubit);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bankMgmtTile({
    required IconData icon,
    required Color color,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: color),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(subtitle,
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 11.5.sp)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 18.sp, color: const Color(0xFF6B7280)),
          ],
        ),
      ),
    );
  }

  void _confirmUnlinkBank(LinkedBankAccount account, OpenBankingCubit cubit) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Unlink ${account.bankName}?',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700)),
        content: Text(
          'Its transactions will stop syncing and drop out of your bank analytics. You can link it again anytime.',
          style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              cubit.unlinkAccount(
                accountId: account.id,
                userId: _userId,
                accessToken: _accessToken,
              );
            },
            child: Text('Unlink',
                style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildFailedTransactionsSection(StatisticsState state) {
    if (state is! StatisticsLoaded || state.failedTransactions == null) {
      return const SizedBox.shrink();
    }
    final transactions = state.failedTransactions!.transactions;
    if (transactions.isEmpty) return const SizedBox.shrink();

    return FailedTransactionsCard(transactions: transactions);
  }

  Widget _buildToggleSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: showIncome
                      ? InvoiceThemeColors.primaryPurple
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Income',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: !showIncome
                      ? const Color(0xFFFB923C)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  'Expenses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: !showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeAnalysis(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return const SizedBox.shrink();
    }

    final catAnalytics = state.categoryAnalytics;
    if (catAnalytics != null && catAnalytics.incomeCategories.isNotEmpty) {
      return _buildIncomeCategoryAnalytics(catAnalytics);
    }

    return const SizedBox.shrink();
  }

  Widget _buildIncomeCategoryAnalytics(accounts_pb.GetCategoryAnalyticsResponse catAnalytics) {
    final categories = catAnalytics.incomeCategories;
    final totalIncome = catAnalytics.totalIncome;

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.statisticsCategoryAnalysis,
        arguments: {'type': 'income'},
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                  'Income Breakdown',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  CurrencySymbols.formatAmount(totalIncome),
                  style: TextStyle(
                    color: Colors.green[300],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: _generateCategoryBreakdownSections(categories, totalIncome),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Column(
              children: categories.map((cat) {
                return _CategoryItem(
                  categoryName: cat.categoryName,
                  amount: cat.amount,
                  total: totalIncome,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseAnalysis(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return const SizedBox.shrink();
    }

    final catAnalytics = state.categoryAnalytics;
    if (catAnalytics != null && catAnalytics.expenseCategories.isNotEmpty) {
      // Filter out platform fees from display but keep total (which includes them)
      final displayCategories = catAnalytics.expenseCategories
          .where((c) => !_isPlatformFee(c.categoryName))
          .toList();
      final totalExpenses = catAnalytics.totalExpenses;

      if (displayCategories.isEmpty) return const SizedBox.shrink();

      return GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.statisticsCategoryAnalysis,
          arguments: {'type': 'expense'},
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF1F1F1F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
                    'Expense Breakdown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    CurrencySymbols.formatAmount(totalExpenses),
                    style: TextStyle(
                      color: Colors.red[300],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              if (displayCategories.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1.3,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: _generateCategoryBreakdownSections(displayCategories, totalExpenses),
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
              Column(
                children: displayCategories.map((cat) {
                  return _CategoryItem(
                    categoryName: cat.categoryName,
                    amount: cat.amount,
                    total: totalExpenses,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  List<PieChartSectionData> _generateCategoryBreakdownSections(
    List<accounts_pb.CategoryBreakdownItem> categories,
    double total,
  ) {
    if (total == 0 || categories.isEmpty) return [];

    return categories.asMap().entries.map((entry) {
      final cat = entry.value;
      final percentage = cat.percentage > 0
          ? cat.percentage.roundToDouble()
          : (cat.amount / total * 100).roundToDouble();
      // Use service category color if available, otherwise fallback to default colors
      final categoryColor = _getCategoryColor(cat.categoryName);
      return PieChartSectionData(
        color: categoryColor,
        value: cat.amount,
        title: '$percentage%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 12.sp),
        ),
      ],
    );
  }

}
