import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../cubit/betting_state.dart';
import 'betting_theme.dart';

/// Review + PIN confirm step for funding a betting account.
class BettingReviewScreen extends StatefulWidget {
  const BettingReviewScreen({super.key});

  @override
  State<BettingReviewScreen> createState() => _BettingReviewScreenState();
}

class _BettingReviewScreenState extends State<BettingReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  static const _bg = BettingTheme.bg;
  static const _card = BettingTheme.card;
  static const _divider = BettingTheme.divider;
  static const _primary = BettingTheme.primary;
  static const _error = BettingTheme.error;
  static const _textSecondary = BettingTheme.textSecondary;

  BettingPlatform? _platform;
  String _accountUserid = '';
  String _accountName = '';
  double _amount = 0;
  bool _saveAccount = false;

  String? _selectedAccountId;
  bool _autoSelected = false;
  bool _isProcessing = false;

  final String _idempotencyKey = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _platform = args['platform'] as BettingPlatform?;
      _accountUserid = (args['accountUserid'] as String?) ?? '';
      _accountName = (args['accountName'] as String?) ?? '';
      _amount = (args['amount'] as double?) ?? 0;
      _saveAccount = (args['saveAccount'] as bool?) ?? false;
    }
    _loadAccounts();
  }

  void _loadAccounts() {
    final state = context.read<AccountCardsSummaryCubit>().state;
    if (state is AccountCardsSummaryLoaded) {
      _autoSelectAccount(state);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context
          .read<AccountCardsSummaryCubit>()
          .fetchAccountSummaries(userId: userId);
    }
  }

  void _autoSelectAccount(AccountCardsSummaryLoaded state) {
    if (_autoSelected) return;
    final ngn = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == 'NGN')
        .toList();
    // Prefer the dashboard's ACTIVE account (matched by id or spending id) so
    // funding stays on the account/locale the user launched the service from.
    final activeId = serviceLocator<AccountManager>().activeAccountId;
    if (activeId != null && activeId.isNotEmpty) {
      for (final a in ngn) {
        if (a.id.toString() == activeId || a.spendingAccountId == activeId) {
          _selectedAccountId = a.id.toString();
          _autoSelected = true;
          return;
        }
      }
    }
    for (final a in ngn) {
      if (a.availableBalance >= _amount) {
        _selectedAccountId = a.id.toString();
        _autoSelected = true;
        return;
      }
    }
    if (_selectedAccountId == null && ngn.isNotEmpty) {
      _selectedAccountId = ngn.first.id.toString();
      _autoSelected = true;
    }
  }

  bool _hasSufficientBalance(dynamic account) {
    if (account.currency.toUpperCase() != 'NGN') return false;
    return account.availableBalance >= _amount;
  }

  Future<void> _processPayment() async {
    if (_isProcessing) return;
    if (_selectedAccountId == null) {
      _snack('Please select an account to pay from', _error);
      return;
    }
    final state = context.read<AccountCardsSummaryCubit>().state;
    if (state is AccountCardsSummaryLoaded) {
      final acct = state.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .firstOrNull;
      if (acct != null && !_hasSufficientBalance(acct)) {
        _snack(
          'This account has NGN ${acct.availableBalance.toStringAsFixed(2)} but you need NGN ${_amount.toStringAsFixed(2)}',
          _error,
        );
        return;
      }
    }

    if (_platform == null) return;

    setState(() => _isProcessing = true);
    final transactionId =
        'betting_${DateTime.now().millisecondsSinceEpoch}_${_platform!.code}';
    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'betting_funding',
      amount: _amount,
      currency: 'NGN',
      title: 'Confirm funding',
      message:
          'Confirm funding $_accountName on ${_platform!.name} with NGN ${_amount.toStringAsFixed(0)}',
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) {
      if (mounted) setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    // Resolve the SPENDABLE account id to debit — equals the summary id for a
    // normal account, but the family virtual-pool id for a family account
    // (debiting the family group id instead would hit the wrong balance).
    String sourceAccountId = _selectedAccountId!;
    final selState = context.read<AccountCardsSummaryCubit>().state;
    if (selState is AccountCardsSummaryLoaded) {
      final sel = selState.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .firstOrNull;
      if (sel != null) sourceAccountId = sel.spendingAccountId;
    }

    Get.offNamed(AppRoutes.bettingProcessing, arguments: {
      'platform': _platform!.code,
      'platformName': _platform!.name,
      'accountUserid': _accountUserid,
      'accountName': _accountName,
      'amount': _amount,
      'transactionId': transactionId,
      'verificationToken': verificationToken!,
      'sourceAccountId': sourceAccountId,
      'idempotencyKey': _idempotencyKey,
      'saveAccount': _saveAccount,
    });
  }

  void _snack(String message, Color color) {
    Get.snackbar(
      '',
      message,
      titleText: const SizedBox.shrink(),
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_platform == null) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(
          child:
              Text('Invalid data', style: TextStyle(color: Colors.white)),
        ),
      );
    }
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    _buildDetailsCard(),
                    SizedBox(height: 12.h),
                    _buildTotalHero(),
                    SizedBox(height: 12.h),
                    _buildAccountSelector(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review funding',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Confirm your betting wallet top-up',
                  style: TextStyle(fontSize: 13.sp, color: _textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Funding',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _row('Platform', _platform!.name),
          SizedBox(height: 10.h),
          _row('Account', _accountUserid),
          SizedBox(height: 10.h),
          _row('Account name', _accountName),
          if (_saveAccount) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.bookmark, color: _primary, size: 14.sp),
                SizedBox(width: 6.w),
                Text(
                  'This account will be saved',
                  style: TextStyle(color: _textSecondary, fontSize: 11.sp),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTotalHero() {
    return BettingGradientCard(
      padding: EdgeInsets.all(18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Amount to fund',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14.sp,
            ),
          ),
          Text(
            '₦${_amount.toStringAsFixed(0)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 14.sp,
            color: isTotal ? Colors.white : Colors.white.withValues(alpha: 0.6),
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              color: Colors.white,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: _primary),
            ),
          );
        }
        if (state is! AccountCardsSummaryLoaded) {
          return const SizedBox.shrink();
        }
        if (!_autoSelected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _autoSelectAccount(state));
          });
        }
        final allNgn = state.accountSummaries
            .where((a) => a.currency.toUpperCase() == 'NGN')
            .toList();
        // Only the ACTIVE dashboard account is offered as the pay-from source —
        // betting is funded from the wallet the user is currently operating in,
        // so we don't surface the other accounts here. Falls back to all NGN if
        // the active account can't be resolved in the summaries.
        final activeId = serviceLocator<AccountManager>().activeAccountId;
        final activeOnly = allNgn
            .where((a) =>
                a.id.toString() == activeId || a.spendingAccountId == activeId)
            .toList();
        final ngn = activeOnly.isNotEmpty ? activeOnly : allNgn;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pay from',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            ...ngn.map((a) {
              final isSel = a.id.toString() == _selectedAccountId;
              final ok = _hasSufficientBalance(a);
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedAccountId = a.id.toString()),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: isSel ? _primary.withValues(alpha: 0.1) : _card,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSel
                          ? _primary
                          : (ok ? _divider : _error.withValues(alpha: 0.3)),
                      width: isSel ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: ok ? _primary : _error, size: 20.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a.accountType,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${a.currency} ${a.availableBalance.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: _textSecondary,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!ok)
                        Text(
                          'Insufficient',
                          style: TextStyle(
                            color: _error,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (isSel && ok)
                        Icon(Icons.check_circle, color: _primary, size: 22.sp),
                    ],
                  ),
                ),
              );
            }),
            if (ngn.isEmpty)
              Text(
                'No NGN account available',
                style: TextStyle(color: _textSecondary, fontSize: 12.sp),
              ),
          ],
        );
      },
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: _isProcessing
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  'Confirm payment',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
