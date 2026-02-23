import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../widgets/currency_pair_selector.dart';
import '../widgets/exchange_mode_toggle.dart';
import '../widgets/exchange_transaction_tile.dart';
import '../widgets/fee_breakdown_widget.dart';
import '../widgets/quick_amount_buttons.dart';
import '../widgets/rate_countdown_widget.dart';
import '../../domain/repositories/i_exchange_repository.dart';

class ExchangeHomeScreen extends StatefulWidget {
  const ExchangeHomeScreen({super.key});

  @override
  State<ExchangeHomeScreen> createState() => _ExchangeHomeScreenState();
}

class _ExchangeHomeScreenState extends State<ExchangeHomeScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  final _amountController = TextEditingController();
  final _amountFocusNode = FocusNode();
  ExchangeMode _mode = ExchangeMode.convert;
  bool _isRateExpired = false;
  bool _isPrimaryActionInProgress = false;

  @override
  void initState() {
    super.initState();
    context.read<ExchangeCubit>().loadHome();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<ExchangeCubit>().loadHome();
  }

  void _onAmountChanged() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    context.read<ExchangeCubit>().setAmount(amount);
  }

  void _onQuickAmount(double amount) {
    _amountController.text = amount.toStringAsFixed(0);
  }

  void _onModeChanged(ExchangeMode mode) {
    setState(() => _mode = mode);
    context.read<ExchangeCubit>().setMode(mode);
  }

  void _fetchRate() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    context
        .read<ExchangeCubit>()
        .fetchRateForHome(forAmount: amount > 0 ? amount : null);
    setState(() => _isRateExpired = false);
  }

  void _onSwapCurrencies() {
    final cubit = context.read<ExchangeCubit>();
    cubit.swapCurrencies();
    _fetchRate();
  }

  void _showCurrencyPicker(bool isFrom) {
    final cubit = context.read<ExchangeCubit>();
    final currencies = cubit.supportedCurrencies;
    if (currencies.isEmpty) return;

    final filtered = _mode == ExchangeMode.convert
        ? currencies.where((c) => c.supportsConversion).toList()
        : currencies.where((c) => c.supportsInternational).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _CurrencyPickerSheet(
        currencies: filtered,
        selectedCode: isFrom ? cubit.fromCurrency : cubit.toCurrency,
        excludeCode: isFrom ? cubit.toCurrency : cubit.fromCurrency,
        title: isFrom ? 'Select Source Currency' : 'Select Destination Currency',
        onSelected: (code) {
          if (isFrom) {
            cubit.setCurrencyPair(code, cubit.toCurrency);
          } else {
            cubit.setCurrencyPair(cubit.fromCurrency, code);
          }
          Navigator.of(ctx).pop();
          _fetchRate();
        },
      ),
    );
  }

  Future<void> _onPrimaryAction() async {
    // Prevent double-tap (gRPC call + dialog is async)
    if (_isPrimaryActionInProgress) return;
    _isPrimaryActionInProgress = true;

    try {
      final cubit = context.read<ExchangeCubit>();
      final amount = double.tryParse(_amountController.text) ?? 0;

      if (amount <= 0) {
        Get.snackbar(
          'Amount Required',
          'Please enter an amount to continue',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1F1F1F),
          colorText: Colors.white,
        );
        return;
      }

      if (cubit.currentRate == null || cubit.currentRate!.isExpired) {
        setState(() => _isRateExpired = true);
        return;
      }

      cubit.setAmount(amount);

      // Check if source currency differs from user's locale currency
      final localeManager = serviceLocator<LocaleManager>();
      final localeCurrency = localeManager.currentCurrency;
      if (localeCurrency.isNotEmpty &&
          cubit.fromCurrency.toUpperCase() != localeCurrency.toUpperCase()) {
        final shouldProceed = await _showCrossLocaleDialog(
          sourceCurrency: cubit.fromCurrency,
          localeCurrency: localeCurrency,
        );
        if (!shouldProceed || !mounted) return;
      }

      // Validate balance before proceeding to PIN or recipient
      final balanceError = await _validateBalance(
        currency: cubit.fromCurrency,
        totalCost: cubit.currentRate!.calculateTotalCost(amount),
      );
      if (balanceError != null) {
        if (mounted) {
          Get.snackbar(
            'Insufficient Balance',
            balanceError,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
        }
        return;
      }

      if (!mounted) return;

      if (_mode == ExchangeMode.sendAbroad) {
        // Navigate to recipient screen with all data
        Get.toNamed(AppRoutes.exchangeRecipient, arguments: {
          'fromCurrency': cubit.fromCurrency,
          'toCurrency': cubit.toCurrency,
          'amount': cubit.amount,
          'rate': cubit.currentRate,
          'mode': _mode,
        });
      } else {
        // Convert flow: PIN inline then execute
        _executeConversion();
      }
    } finally {
      _isPrimaryActionInProgress = false;
    }
  }

  /// Check if the user has sufficient balance in the source currency wallet.
  /// Returns an error message if insufficient, null if OK.
  Future<String?> _validateBalance({
    required String currency,
    required double totalCost,
  }) async {
    try {
      final accountsClient = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final callOptions = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await accountsClient.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(),
        options: callOptions,
      );

      // Find the account with the highest balance for the source currency
      double bestBalance = 0;
      for (final account in response.accounts) {
        if (account.currency == currency && account.status == 'active') {
          // balance is in minor units (kobo/cents)
          final balanceMajor = account.balance.toDouble() / 100;
          if (balanceMajor > bestBalance) {
            bestBalance = balanceMajor;
          }
        }
      }

      if (bestBalance < totalCost) {
        final formatted = bestBalance.toStringAsFixed(2);
        return 'Your $currency balance ($formatted) is not enough for this exchange (${totalCost.toStringAsFixed(2)} required).';
      }

      return null; // Balance is sufficient
    } catch (_) {
      // If balance check fails, let the backend handle validation
      return null;
    }
  }

  /// Show a dialog when the user is exchanging from a currency that differs
  /// from their locale currency. Returns true if the user wants to proceed
  /// with the exchange, false if they dismissed or chose to withdraw instead.
  Future<bool> _showCrossLocaleDialog({
    required String sourceCurrency,
    required String localeCurrency,
  }) async {
    // Fetch accounts to show the source currency balance
    double sourceBalance = 0;
    accounts_pb.AccountSummary? sourceAccount;
    try {
      final accountsClient =
          serviceLocator<accounts_grpc.AccountsServiceClient>();
      final callOptions =
          await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await accountsClient.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(),
        options: callOptions,
      );
      for (final account in response.accounts) {
        if (account.currency.toUpperCase() == sourceCurrency.toUpperCase() &&
            account.status == 'active') {
          final balanceMajor = account.balance.toDouble() / 100;
          if (balanceMajor > sourceBalance) {
            sourceBalance = balanceMajor;
            sourceAccount = account;
          }
        }
      }
    } catch (_) {
      // If fetch fails, show dialog with 0 balance and no withdraw option
    }

    if (!mounted) return false;

    final symbol = CurrencySymbols.getSymbol(sourceCurrency);
    final formattedBalance = '$symbol${sourceBalance.toStringAsFixed(2)}';

    // Generate flag emoji from currency → country code mapping
    const currencyToCountry = {
      'USD': 'US', 'GBP': 'GB', 'EUR': 'EU', 'NGN': 'NG',
      'ZAR': 'ZA', 'GHS': 'GH', 'KES': 'KE',
    };
    final countryCode = currencyToCountry[sourceCurrency.toUpperCase()] ?? '';
    final flag = countryCode.isNotEmpty
        ? countryCode
            .toUpperCase()
            .codeUnits
            .map((c) => String.fromCharCode(c + 127397))
            .join()
        : '';

    // Build withdrawal card arguments safely (only if account exists)
    Map<String, dynamic>? withdrawalCard;
    if (sourceAccount != null) {
      final acctNum = sourceAccount.accountNumber;
      final maskedNum = acctNum.length >= 4
          ? '•••• ${acctNum.substring(acctNum.length - 4)}'
          : '•••• $acctNum';

      withdrawalCard = {
        'id': sourceAccount.id,
        'accountType': sourceAccount.accountType.isNotEmpty
            ? sourceAccount.accountType
            : 'savings',
        'currency': sourceCurrency,
        'balance': sourceBalance,
        'accountNumber': acctNum.isNotEmpty ? acctNum : maskedNum,
        'accountNumberMasked': maskedNum,
        'bankName': 'LazerVault',
        'accountName': 'LazerVault Account',
        'trend': '+0.0%',
        'isUp': true,
      };
    }

    final result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Flag + header
              if (flag.isNotEmpty)
                Text(
                  flag,
                  style: const TextStyle(fontSize: 40),
                )
              else
                const Icon(
                  Icons.currency_exchange,
                  color: Color(0xFF3B82F6),
                  size: 40,
                ),
              const SizedBox(height: 12),
              const Text(
                'Foreign Currency Exchange',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),

              // Info text
              Text(
                'You\'re about to exchange from your $sourceCurrency wallet. '
                'Your active currency is $localeCurrency.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // Balance card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Column(
                  children: [
                    Text(
                      '$sourceCurrency Balance',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formattedBalance,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Continue Exchange button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue Exchange',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Withdraw Instead button (only if account exists with valid data)
              if (withdrawalCard != null) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                      Get.toNamed(AppRoutes.withdrawFunds, arguments: {
                        'selectedCard': withdrawalCard,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D2D2D),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Withdraw $sourceCurrency Instead',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    // Widget may have been disposed while dialog was open
    if (!mounted) return false;

    return result == true;
  }

  Future<void> _executeConversion() async {
    final cubit = context.read<ExchangeCubit>();

    if (!cubit.checkRateValidity()) {
      setState(() => _isRateExpired = true);
      return;
    }

    await validateTransactionPin(
      context: context,
      transactionId: 'exchange-${DateTime.now().millisecondsSinceEpoch}',
      transactionType: 'exchange_conversion',
      amount: cubit.amount,
      currency: cubit.fromCurrency,
      onPinValidated: (verificationToken) async {
        pinModalKey.currentState?.setProcessing();

        await cubit.convertCurrency(verificationToken: verificationToken);

        final currentState = cubit.state;
        if (currentState is ExchangeSuccess) {
          pinModalKey.currentState?.setSuccess();
          await Future.delayed(const Duration(milliseconds: 800));
          if (mounted) Navigator.of(context).pop();
          Get.offNamed(
            AppRoutes.exchangeReceipt,
            arguments: currentState.transaction,
          );
        } else if (currentState is ExchangeProcessing) {
          pinModalKey.currentState?.setSuccess();
          await Future.delayed(const Duration(milliseconds: 800));
          if (mounted) Navigator.of(context).pop();
          Get.offNamed(
            AppRoutes.exchangeProcessing,
            arguments: {
              'transactionId': currentState.transactionId,
              'isConversion': currentState.isConversion,
            },
          );
        } else if (currentState is ExchangeError) {
          final errorMsg = currentState.message;
          // Restore home state to prevent BlocConsumer from rebuilding
          // with error state while PIN modal is still active
          cubit.restoreHomeState();
          throw Exception(errorMsg);
        }
      },
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
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Currency Exchange',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ExchangeCubit, ExchangeState>(
        listener: (context, state) {
          if (state is ExchangeRateExpired) {
            setState(() => _isRateExpired = true);
          }
        },
        builder: (context, state) {
          if (state is ExchangeLoading) {
            return const Center(
                child:
                    CircularProgressIndicator(color: Color(0xFF3B82F6)));
          }

          if (state is ExchangeError) {
            return _buildErrorState(state.message);
          }

          if (state is ExchangeHomeWithRate) {
            return _buildContent(state);
          }

          // Fallback for legacy ExchangeHomeLoaded
          if (state is ExchangeHomeLoaded) {
            return _buildContent(ExchangeHomeWithRate(
              supportedCurrencies: state.supportedCurrencies,
              recentTransactions: state.recentTransactions,
            ));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                color: Color(0xFFEF4444), size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _refresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Retry',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ExchangeHomeWithRate state) {
    final cubit = context.read<ExchangeCubit>();
    final amount = double.tryParse(_amountController.text) ?? 0;
    final rate = state.rate;
    final convertedAmount = rate != null ? rate.calculateToAmount(amount) : 0.0;
    final canProceed = amount > 0 && rate != null && !_isRateExpired;

    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mode toggle
                  ExchangeModeToggle(
                    selectedMode: _mode,
                    onModeChanged: _onModeChanged,
                  ),
                  const SizedBox(height: 20),

                  // Currency pair selector
                  CurrencyPairSelector(
                    fromCurrency: cubit.fromCurrency,
                    toCurrency: cubit.toCurrency,
                    onFromTap: () => _showCurrencyPicker(true),
                    onToTap: () => _showCurrencyPicker(false),
                    onSwap: _onSwapCurrencies,
                  ),
                  const SizedBox(height: 20),

                  // You send — amount input
                  _buildAmountCard(
                    label: 'You send',
                    currencyCode: cubit.fromCurrency,
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    isEditable: true,
                  ),
                  const SizedBox(height: 12),

                  // Quick amount buttons
                  QuickAmountButtons(
                    currencyCode: cubit.fromCurrency,
                    onAmountSelected: _onQuickAmount,
                    selectedAmount: amount,
                  ),
                  const SizedBox(height: 16),

                  // They receive — read-only
                  if (rate != null)
                    _buildAmountCard(
                      label: _mode == ExchangeMode.convert
                          ? 'You receive'
                          : 'They receive',
                      currencyCode: cubit.toCurrency,
                      displayAmount: convertedAmount,
                      isEditable: false,
                    ),
                  const SizedBox(height: 16),

                  // Rate countdown
                  if (rate != null)
                    Center(
                      child: RateCountdownWidget(
                        rate: rate,
                        onExpired: () =>
                            setState(() => _isRateExpired = true),
                        onRefresh: _fetchRate,
                      ),
                    ),
                  if (rate == null && amount > 0)
                    Center(
                      child: TextButton.icon(
                        onPressed: _fetchRate,
                        icon: const Icon(Icons.refresh,
                            color: Color(0xFF3B82F6), size: 16),
                        label: const Text(
                          'Get exchange rate',
                          style: TextStyle(
                              color: Color(0xFF3B82F6), fontSize: 13),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Fee breakdown
                  if (rate != null && amount > 0)
                    FeeBreakdownWidget(
                      rate: rate,
                      amount: amount,
                      convertedAmount: convertedAmount,
                    ),
                  const SizedBox(height: 24),

                  // Recent exchanges section
                  _buildSectionHeader(
                    'Recent Exchanges',
                    state.recentTransactions.isNotEmpty ? () {
                      Get.toNamed(AppRoutes.exchangeHistory);
                    } : null,
                  ),
                  const SizedBox(height: 12),
                  if (state.recentTransactions.isEmpty)
                    _buildEmptyTransactions()
                  else
                    ...state.recentTransactions.map((tx) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ExchangeTransactionTile(
                            transaction: tx,
                            onTap: () => Get.toNamed(
                              AppRoutes.exchangeDetail,
                              arguments: tx,
                            ),
                          ),
                        )),
                  // Bottom padding for scroll
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Primary action button — pinned at bottom
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isRateExpired
                      ? _fetchRate
                      : canProceed
                          ? _onPrimaryAction
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    disabledBackgroundColor: const Color(0xFF2D2D2D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _isRateExpired
                        ? 'Refresh Rate to Continue'
                        : _mode == ExchangeMode.convert
                            ? 'Convert Now'
                            : 'Continue',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard({
    required String label,
    required String currencyCode,
    TextEditingController? controller,
    FocusNode? focusNode,
    double? displayAmount,
    required bool isEditable,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEditable
              ? const Color(0xFF3B82F6).withValues(alpha: 0.5)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                currencyCode,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: isEditable
                    ? TextField(
                        controller: controller,
                        focusNode: focusNode,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(color: Color(0xFF4B5563)),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : Text(
                        displayAmount?.toStringAsFixed(2) ?? '0.00',
                        style: TextStyle(
                          color: (displayAmount ?? 0) > 0
                              ? const Color(0xFF10B981)
                              : const Color(0xFF4B5563),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback? onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: const Text(
              'View All',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyTransactions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Icon(Icons.swap_horiz, color: Color(0xFF2D2D2D), size: 40),
          SizedBox(height: 12),
          Text(
            'No exchanges yet',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            'Your exchange history will appear here',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Currency picker bottom sheet extracted from CurrencyPairScreen.
class _CurrencyPickerSheet extends StatefulWidget {
  final List<SupportedCurrencyInfo> currencies;
  final String selectedCode;
  final String? excludeCode;
  final String title;
  final ValueChanged<String> onSelected;

  const _CurrencyPickerSheet({
    required this.currencies,
    required this.selectedCode,
    this.excludeCode,
    required this.title,
    required this.onSelected,
  });

  @override
  State<_CurrencyPickerSheet> createState() => _CurrencyPickerSheetState();
}

class _CurrencyPickerSheetState extends State<_CurrencyPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SupportedCurrencyInfo> get _filtered {
    var list = widget.currencies;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list
          .where((c) =>
              c.code.toLowerCase().contains(q) ||
              c.name.toLowerCase().contains(q) ||
              c.country.toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search currency...',
                      hintStyle:
                          const TextStyle(color: Color(0xFF6B7280)),
                      prefixIcon: const Icon(Icons.search,
                          color: Color(0xFF6B7280)),
                      filled: true,
                      fillColor: const Color(0xFF0A0A0A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  final curr = _filtered[index];
                  final isSelected = curr.code == widget.selectedCode;
                  final isExcluded = curr.code == widget.excludeCode;
                  final countryCode = curr.country.toLowerCase();
                  final flag = countryCode.isNotEmpty
                      ? countryCode
                          .toUpperCase()
                          .codeUnits
                          .map((c) =>
                              String.fromCharCode(c + 127397))
                          .join()
                      : '';

                  return ListTile(
                    enabled: !isExcluded,
                    onTap: isExcluded
                        ? null
                        : () => widget.onSelected(curr.code),
                    leading: flag.isNotEmpty
                        ? Text(flag,
                            style: const TextStyle(fontSize: 24))
                        : const Icon(Icons.currency_exchange,
                            color: Color(0xFF9CA3AF)),
                    title: Text(
                      curr.code,
                      style: TextStyle(
                        color: isExcluded
                            ? const Color(0xFF6B7280)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      curr.name,
                      style: TextStyle(
                        color: isExcluded
                            ? const Color(0xFF4B5563)
                            : const Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: Color(0xFF3B82F6), size: 20)
                        : isExcluded
                            ? const Text('Selected',
                                style: TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 12))
                            : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
