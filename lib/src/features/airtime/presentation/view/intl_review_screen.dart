import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../domain/entities/intl_airtime_country.dart';
import '../../domain/entities/intl_airtime_operator.dart';
import '../cubit/intl_airtime_cubit.dart';
import '../cubit/intl_airtime_state.dart';
import '../widgets/airtime_shimmer.dart';

class IntlReviewScreen extends StatefulWidget {
  const IntlReviewScreen({super.key});

  @override
  State<IntlReviewScreen> createState() => _IntlReviewScreenState();
}

class _IntlReviewScreenState extends State<IntlReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final LocaleManager _localeManager = GetIt.I<LocaleManager>();

  late IntlAirtimeCountry _country;
  late IntlAirtimeOperator _operator;
  late String _phoneNumber;
  late double _amount;
  late String _senderCurrency;
  late double _destAmount;
  late double _fxRate;
  late bool _useLocalAmount;

  String? _selectedAccountId;
  bool _autoSelectedAccount = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _country = args['country'] as IntlAirtimeCountry;
    _operator = args['operator'] as IntlAirtimeOperator;
    _phoneNumber = args['phoneNumber'] as String? ?? '';
    _amount = (args['amount'] as num?)?.toDouble() ?? 0;
    // Active locale currency from the dashboard (e.g. NGN for en-NG). This is
    // what the wallet is debited in and what the account selector filters on.
    _senderCurrency = (args['senderCurrency'] as String?) ??
        _localeManager.currentCurrency;
    _destAmount = (args['destAmount'] as num?)?.toDouble() ?? 0;
    _fxRate = (args['fxRate'] as num?)?.toDouble() ?? 0;
    _useLocalAmount = args['useLocalAmount'] as bool? ?? false;
    _loadAccounts();
  }

  void _loadAccounts() {
    final state = context.read<AccountCardsSummaryCubit>().state;
    if (state is AccountCardsSummaryLoaded) {
      _autoSelectAccount(state);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(userId: userId);
    }
  }

  /// Pre-select the user's **personal** account in the active currency.
  /// Fallback order: personal w/ sufficient balance → any personal → primary →
  /// any account in active currency.
  void _autoSelectAccount(AccountCardsSummaryLoaded state) {
    if (_autoSelectedAccount) return;
    final matching = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == _senderCurrency.toUpperCase())
        .toList();
    if (matching.isEmpty) return;

    AccountSummaryEntity? pick;
    for (final acc in matching) {
      if (acc.isPersonalAccount && acc.availableBalance >= _amount) {
        pick = acc;
        break;
      }
    }
    pick ??= matching.firstWhere(
      (a) => a.isPersonalAccount,
      orElse: () => matching.firstWhere(
        (a) => a.isPrimary,
        orElse: () => matching.first,
      ),
    );
    _selectedAccountId = pick.id.toString();
    _autoSelectedAccount = true;
  }

  void _showAccountSheet() {
    final state = context.read<AccountCardsSummaryCubit>().state;
    if (state is! AccountCardsSummaryLoaded) return;
    final accounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == _senderCurrency.toUpperCase())
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AccountSheet(
        accounts: accounts,
        selectedId: _selectedAccountId,
        requiredAmount: _amount,
        currency: _senderCurrency,
        onSelected: (id) => setState(() => _selectedAccountId = id),
      ),
    );
  }

  void _confirmPayment() async {
    if (_isProcessing) return;
    if (_selectedAccountId == null) {
      Get.snackbar('Error', 'Please select an account',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
      return;
    }
    setState(() => _isProcessing = true);

    final transactionId =
        'intl_airtime_${DateTime.now().millisecondsSinceEpoch}';
    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'intl_airtime_purchase',
      amount: _amount,
      currency: _senderCurrency,
      title: 'Confirm International Airtime',
      message:
          'Send ${_country.currencyCode} ${_destAmount.toStringAsFixed(2)} '
          'airtime to $_phoneNumber',
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

    context.read<IntlAirtimeCubit>().buyIntlAirtime(
          accountId: _selectedAccountId!,
          operatorId: _operator.id,
          countryCode: _country.countryCode,
          phoneNumber: _phoneNumber,
          amount: _amount,
          senderCurrency: _senderCurrency,
          useLocalAmount: _useLocalAmount,
          destAmount: _destAmount,
          destCurrency: _country.currencyCode,
          fxRateSnapshot: _fxRate,
          variationCode: _operator.vtpassOperatorId,
          pin: verificationToken!,
          idempotencyKey: 'INTA-$transactionId',
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntlAirtimeCubit, IntlAirtimeState>(
      listener: (context, state) {
        if (state is IntlAirtimePurchaseSuccess) {
          setState(() => _isProcessing = false);
          Get.offNamed(AppRoutes.intlAirtimeReceipt, arguments: {
            'paymentId': state.paymentId,
            'reference': state.reference,
            'isSuccess': state.status != 'failed',
            'amountPaid': state.amountPaid,
            'senderCurrency': state.senderCurrency,
            'deliveredAmount': state.deliveredAmount,
            'deliveredCurrency': state.deliveredCurrency,
            'fxRateUsed': state.fxRateUsed,
            'operatorName': state.operatorName,
            'countryName': state.countryName,
            'phoneNumber': state.phoneNumber,
          });
        } else if (state is IntlAirtimeError) {
          setState(() => _isProcessing = false);
          Get.snackbar(
            'Payment Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 5),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 120.h),
                child: Column(
                  children: [
                    _buildSummaryCard(),
                    SizedBox(height: 16.h),
                    _buildAccountSelector(state),
                    SizedBox(height: 12.h),
                    _buildDisclaimer(),
                  ],
                ),
              ),
              // Docked confirm button — gives it breathing room and anchors
              // the primary CTA to a consistent position on the screen.
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 24.h,
                child: _buildPayButton(state),
              ),
              if (state is IntlAirtimePurchasing || _isProcessing)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(
                        color: Color(0xFF4E03D0)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Review & Pay',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      );

  Widget _buildSummaryCard() {
    // The "You Pay" line must always reflect the SELECTED ACCOUNT's currency
    // — that is the ground truth of what the wallet gets debited in. The
    // `_senderCurrency` passed from the previous screen came from the
    // provider operator's SenderCurrencyCode, which in some sandbox configs
    // (GBP) does NOT match the user's wallet currency (NGN). Showing "2 GBP"
    // for a South Africa top-up bought from an NGN account was the bug. We
    // resolve via the accounts cubit — if it hasn't loaded yet we fall back
    // to whatever came through the args, but 99% of the time `_senderCurrency`
    // is already replaced by the selected account's currency below.
    final accountsState = context.watch<AccountCardsSummaryCubit>().state;
    String displayedSenderCurrency = _senderCurrency;
    if (accountsState is AccountCardsSummaryLoaded &&
        _selectedAccountId != null) {
      final match = accountsState.accountSummaries.firstWhere(
        (a) => a.id.toString() == _selectedAccountId,
        orElse: () => accountsState.accountSummaries.first,
      );
      displayedSenderCurrency = match.currency.toUpperCase();
    }
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Recipient gets — headline in target country currency.
          _summaryRow(
            label: 'Recipient Gets',
            value: _destAmount > 0
                ? '${_country.currencyCode} ${_destAmount.toStringAsFixed(2)}'
                : 'Calculated by provider',
            valueColor: const Color(0xFF10B981),
            valueSize: 22.sp,
            valueBold: true,
          ),
          SizedBox(height: 12.h),
          // You pay — in the selected account's currency (source of truth
          // for the actual debit). Never the operator's sender currency.
          _summaryRow(
            label: 'You Pay',
            value:
                '$displayedSenderCurrency ${_amount.toStringAsFixed(2)}',
            valueColor: Colors.white,
            valueSize: 18.sp,
            valueBold: true,
          ),
          if (_fxRate > 0 &&
              _country.currencyCode.toUpperCase() !=
                  displayedSenderCurrency.toUpperCase()) ...[
            SizedBox(height: 8.h),
            _summaryRow(
              label: 'Exchange Rate',
              value:
                  '1 ${_country.currencyCode} ≈ ${_fxRate.toStringAsFixed(4)} $displayedSenderCurrency',
              valueColor: const Color(0xFF4E03D0),
              valueSize: 12.sp,
            ),
          ],
          Divider(color: const Color(0xFF2D2D2D), height: 24.h),
          // Route: explicit FROM (user's wallet + home locale) → TO (dest
          // country). The old screen only showed the recipient side; users
          // couldn't tell at a glance which of their accounts was being
          // charged or which country the airtime was heading to.
          _summaryRow(
            label: 'From',
            value: displayedSenderCurrency,
            trailing: Text(
              '🏦  Your $displayedSenderCurrency wallet',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
          ),
          SizedBox(height: 10.h),
          _summaryRow(
            label: 'To',
            value: _country.countryName,
            trailing: Text(
              '${_country.flagEmoji}  ${_country.currencyCode}',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
          ),
          SizedBox(height: 10.h),
          // Recipient info
          _summaryRow(
            label: 'Recipient',
            value: _phoneNumber,
            trailing: Text(
              '${_country.flagEmoji}  ${_country.countryName}',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
          ),
            SizedBox(height: 10.h),
            // Operator
            _summaryRow(
              label: 'Network',
              value: _operator.operatorName,
              trailing: _operator.logoUrl.isNotEmpty
                  ? Image.network(
                      _operator.logoUrl,
                      width: 28.w,
                      height: 28.w,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    )
                  : null,
            ),
          ],
        ),
    );
  }

  Widget _summaryRow({
    required String label,
    required String value,
    Color valueColor = Colors.white,
    double? valueSize,
    bool valueBold = false,
    Widget? trailing,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: valueSize ?? 14.sp,
                  fontWeight:
                      valueBold ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 8.w),
                trailing,
              ],
            ],
          ),
        ],
      );

  Widget _buildAccountSelector(IntlAirtimeState state) =>
      BlocConsumer<AccountCardsSummaryCubit, AccountCardsSummaryState>(
        listener: (_, accState) {
          if (accState is AccountCardsSummaryLoaded && !_autoSelectedAccount) {
            setState(() => _autoSelectAccount(accState));
          }
        },
        builder: (_, accState) {
          if (accState is AccountCardsSummaryLoading ||
              accState is AccountCardsSummaryInitial) {
            return Container(
              height: 64.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                    color: Color(0xFF4E03D0), strokeWidth: 2),
              ),
            );
          }
          if (accState is! AccountCardsSummaryLoaded) {
            return const SizedBox.shrink();
          }
          final selected = accState.accountSummaries
              .where((a) => a.id.toString() == _selectedAccountId)
              .firstOrNull;
          return GestureDetector(
            onTap: _showAccountSheet,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.account_balance_wallet,
                        color: const Color(0xFF4E03D0), size: 18.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: selected == null
                        ? Text('Select Account',
                            style: TextStyle(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 14.sp))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selected.accountType,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Balance: $_senderCurrency ${selected.availableBalance.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                  ),
                  const Icon(Icons.expand_more,
                      color: Color(0xFF9CA3AF), size: 20),
                ],
              ),
            ),
          );
        },
      );

  Widget _buildDisclaimer() => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline,
                color: const Color(0xFFFB923C), size: 14.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Exchange rate may vary slightly at the time of execution.',
                style:
                    TextStyle(color: const Color(0xFFFB923C), fontSize: 11.sp),
              ),
            ),
          ],
        ),
      );

  Widget _buildPayButton(IntlAirtimeState state) {
    final disabled = state is IntlAirtimePurchasing || _isProcessing;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: disabled ? 0 : 0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 58.h,
        child: ElevatedButton.icon(
          onPressed: disabled ? null : _confirmPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4E03D0),
            disabledBackgroundColor:
                const Color(0xFF4E03D0).withValues(alpha: 0.5),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
          ),
          icon: disabled
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(Icons.lock_outline_rounded,
                  color: Colors.white, size: 20.sp),
          label: Text(
            disabled
                ? 'Processing…'
                : 'Confirm Payment · $_senderCurrency ${_amount.toStringAsFixed(2)}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// ─── Account selection bottom sheet ────────────────────────────────────────

class _AccountSheet extends StatelessWidget {
  final List<dynamic> accounts;
  final String? selectedId;
  final double requiredAmount;
  final String currency;
  final ValueChanged<String> onSelected;

  const _AccountSheet({
    required this.accounts,
    required this.selectedId,
    required this.requiredAmount,
    required this.currency,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text('Select Account',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 16.h),
          ...accounts.map((acc) {
            final id = acc.id.toString();
            final isSelected = selectedId == id;
            final hasFunds = acc.availableBalance >= requiredAmount;
            return GestureDetector(
              onTap: hasFunds
                  ? () {
                      onSelected(id);
                      Navigator.pop(context);
                    }
                  : null,
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4E03D0)
                        : hasFunds
                            ? const Color(0xFF2D2D2D)
                            : const Color(0xFFEF4444).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(acc.accountType,
                              style: TextStyle(
                                  color: hasFunds
                                      ? Colors.white
                                      : const Color(0xFF9CA3AF),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '$currency ${acc.availableBalance.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: hasFunds
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFEF4444),
                                fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle,
                          color: const Color(0xFF4E03D0), size: 20.sp),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
