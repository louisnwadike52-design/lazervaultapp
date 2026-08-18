import 'dart:async';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// Pulls in TransactionTypeModeMatch so recentTransactions.where can call
// `tx.type.matchesMode(...)` to filter the Recent list to the active tab.
import '../../domain/entities/transaction_entity.dart';

import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/app_surfaces.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../theme/exchange_theme.dart';
import '../utils/exchange_error_classifier.dart';
import '../widgets/currency_pair_selector.dart';
import '../widgets/exchange_mode_toggle.dart';
import '../widgets/exchange_history_actions_sheet.dart';
import '../widgets/exchange_transaction_tile.dart';
import '../widgets/fee_breakdown_widget.dart';
import '../widgets/quick_amount_buttons.dart';
import '../widgets/source_currency_picker.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'exchange_home_screen_widgets.dart';


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
  // _isRefreshingRate tracks ONLY the in-flight GET /rates call so we can
  // debounce the "refresh" icon; it never gates the primary action anymore.
  // Rate staleness was removed — the backend fetches a fresh Flutterwave rate
  // at capture time, so the UI no longer expires rates on the client.
  bool _isRefreshingRate = false;
  bool _isPrimaryActionInProgress = false;
  Timer? _amountDebounce;

  // SharedPreferences keys for per-flow source-currency stickiness. The user's
  // last "Send from" choice is restored on next entry to the exchange flow so
  // multi-currency users don't reselect NGN every time. Defaults to NGN when
  // no prior selection (matches pre-#112 behaviour).
  static const _prefsKeySourceConvert =
      'last_exchange_source_currency_conversion';
  static const _prefsKeySourceInternational =
      'last_exchange_source_currency_international';

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ExchangeCubit>();
    final args = Get.arguments;
    // Was this screen opened by "Repeat Exchange" (Convert) from history? If so
    // we prefill the pair AND amount + mode so the form is ready to convert —
    // previously initState read only from/to and dropped amount/mode/
    // repeatPrefill, leaving the user on an empty form with a disabled button.
    bool isRepeatPrefill = false;
    if (args is Map) {
      final from = args['fromCurrency'] as String?;
      final to = args['toCurrency'] as String?;
      if (from != null &&
          to != null &&
          from.isNotEmpty &&
          to.isNotEmpty) {
        cubit.setCurrencyPair(from, to);
      }
      // Mode (Convert vs Send Abroad); the history sheet routes Send Abroad to
      // the recipient screen, so here we only expect 'convert'.
      final modeArg = (args['mode'] as String?)?.toLowerCase();
      if (modeArg == 'convert') {
        _mode = ExchangeMode.convert;
        cubit.setMode(ExchangeMode.convert);
      }
      final repeatPrefill = args['repeatPrefill'] == true;
      final amt = (args['amount'] as num?)?.toDouble();
      if ((repeatPrefill || modeArg == 'convert') &&
          amt != null &&
          amt > 0) {
        isRepeatPrefill = true;
        // Set the field BEFORE the listener is attached, and push the amount to
        // the cubit directly, so the "Convert Now" button enables once the rate
        // for this amount comes back.
        _amountController.text = amt.toStringAsFixed(0);
        cubit.setAmount(amt);
      }
    }
    cubit.loadHome();
    _amountController.addListener(_onAmountChanged);
    if (isRepeatPrefill) {
      // Fetch a rate for the prefilled amount so the form is immediately
      // actionable. Do NOT restore the last-used source currency here — it
      // would clobber the fromCurrency the repeat just set.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _fetchRate();
      });
    } else {
      // Restore the last-used source currency for the active mode (best
      // effort; ignored if SharedPreferences fails or no prior choice exists).
      _restoreLastSourceCurrency();
    }
  }

  Future<void> _restoreLastSourceCurrency() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _mode == ExchangeMode.convert
          ? _prefsKeySourceConvert
          : _prefsKeySourceInternational;
      final stored = prefs.getString(key);
      if (stored == null || stored.isEmpty) return;
      if (!mounted) return;
      final cubit = context.read<ExchangeCubit>();
      if (stored.toUpperCase() == cubit.fromCurrency.toUpperCase()) return;
      // Avoid bouncing into an invalid pair (source == destination).
      if (stored.toUpperCase() == cubit.toCurrency.toUpperCase()) return;
      cubit.setCurrencyPair(stored.toUpperCase(), cubit.toCurrency);
      // Refresh rate against the restored source.
      await _fetchRate();
    } catch (_) {
      // Ignore — defaulting to NGN is fine when prefs are unavailable.
    }
  }

  Future<void> _persistSourceCurrency(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _mode == ExchangeMode.convert
          ? _prefsKeySourceConvert
          : _prefsKeySourceInternational;
      await prefs.setString(key, code.toUpperCase());
    } catch (_) {
      // Persistence failure is benign — just doesn't stick across launches.
    }
  }

  @override
  void dispose() {
    _amountDebounce?.cancel();
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<ExchangeCubit>().loadHome();
  }

  void _onAmountChanged() {
    _amountDebounce?.cancel();
    _amountDebounce = Timer(const Duration(milliseconds: 300), () {
      final amount = double.tryParse(_amountController.text) ?? 0;
      context.read<ExchangeCubit>().setAmount(amount);
    });
  }

  void _onQuickAmount(double amount) {
    _amountController.text = amount.toStringAsFixed(0);
  }

  void _onModeChanged(ExchangeMode mode) {
    setState(() => _mode = mode);
    context.read<ExchangeCubit>().setMode(mode);
    // Each flow type owns its own source-currency stickiness, so reapply
    // the stored choice for the newly active mode (best effort).
    _restoreLastSourceCurrency();
  }

  Future<void> _fetchRate() async {
    if (_isRefreshingRate) return;
    setState(() => _isRefreshingRate = true);
    try {
      final amount = double.tryParse(_amountController.text) ?? 0;
      await context
          .read<ExchangeCubit>()
          .fetchRateForHome(forAmount: amount > 0 ? amount : null);
    } finally {
      if (mounted) setState(() => _isRefreshingRate = false);
    }
  }

  void _onSwapCurrencies() {
    final cubit = context.read<ExchangeCubit>();
    cubit.swapCurrencies();
    // Persist the new source so it sticks across sessions per the active
    // flow type. Fire-and-forget — failure is benign (just doesn't survive
    // restart).
    _persistSourceCurrency(cubit.fromCurrency);
    _fetchRate();
  }

  void _showCurrencyPicker(bool isFrom) {
    final cubit = context.read<ExchangeCubit>();
    final currencies = cubit.supportedCurrencies;
    if (currencies.isEmpty) return;

    // Source picker uses the dedicated wallet-aware sheet (#112): only shows
    // currencies the user actually has a balance > 0 in, with an empty-state
    // CTA when they only have NGN. Destination picker stays on the legacy
    // supports-conversion / supports-international filter.
    if (isFrom) {
      _showSourceCurrencyPicker(cubit, currencies);
      return;
    }

    // TODO(#114): swap to corridor-aware filtering once the corridor-matrix
    // RPC is exposed on ExchangeServiceClient. Today we filter by the
    // capability flags from GetSupportedCurrencies (supportsConversion /
    // supportsInternational) and exclude the source via `excludeCode`. The
    // corridor matrix will give us a per-(source,destination) pairs list so
    // we can drop pairs that the backend would 400 (e.g. USD -> KES bridges
    // that aren't live).
    // Convert mode: show conversion-capable currencies, PLUS the
    // international-only ones (e.g. PHP/CAD — Klasha VAs cover only NGN+GHS, so
    // they can't be held/converted) rendered DISABLED so users see they exist
    // but can only be sent abroad. Send-abroad mode shows all international ones.
    final List<SupportedCurrencyInfo> filtered;
    bool Function(SupportedCurrencyInfo)? disabledFor;
    if (_mode == ExchangeMode.convert) {
      filtered = currencies
          .where((c) => c.supportsConversion || c.supportsInternational)
          .toList();
      disabledFor = (c) => !c.supportsConversion;
    } else {
      filtered = currencies.where((c) => c.supportsInternational).toList();
      disabledFor = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _CurrencyPickerSheet(
        currencies: filtered,
        selectedCode: cubit.toCurrency,
        excludeCode: cubit.fromCurrency,
        disabledFor: disabledFor,
        disabledHint: 'Send abroad only',
        title: 'Select Destination Currency',
        onSelected: (code) {
          cubit.setCurrencyPair(cubit.fromCurrency, code);
          Navigator.of(ctx).pop();
          _fetchRate();
        },
      ),
    );
  }

  Future<void> _showSourceCurrencyPicker(
    ExchangeCubit cubit,
    List<SupportedCurrencyInfo> currencies,
  ) async {
    final picked = await SourceCurrencyPicker.show(
      context,
      currentCode: cubit.fromCurrency,
      supportedCurrencies: currencies,
    );
    if (picked == null || picked.isEmpty || !mounted) return;
    if (picked.toUpperCase() == cubit.toCurrency.toUpperCase()) {
      // User picked a source that matches the destination — flip the
      // destination to the prior source so we never end up source == dest.
      cubit.setCurrencyPair(picked, cubit.fromCurrency);
    } else {
      cubit.setCurrencyPair(picked, cubit.toCurrency);
    }
    await _persistSourceCurrency(picked);
    await _fetchRate();
  }

  Future<void> _onPrimaryAction() async {
    // Prevent double-tap (gRPC call + dialog is async) and show a loading
    // spinner on the CTA while the async balance / limit checks run so the tap
    // doesn't feel stuck (parity with Send Abroad). Covers both Convert and
    // Send Abroad — this is the shared primary path.
    if (_isPrimaryActionInProgress) return;
    setState(() => _isPrimaryActionInProgress = true);

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

      // We no longer gate on a client-side rate TTL. If the cubit has no
      // rate yet, fetch one synchronously (best effort) before continuing.
      if (cubit.currentRate == null) {
        await _fetchRate();
        if (cubit.currentRate == null) {
          Get.snackbar(
            'Rate unavailable',
            'Could not fetch an exchange rate. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ExchangeTheme.cardBackground,
            colorText: Colors.white,
          );
          return;
        }
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

      // Daily FX limit pre-flight — warn BEFORE the recipient screen / PIN so
      // a limit breach doesn't first appear after the user has entered
      // recipient details and their PIN. Fails open on lookup error.
      final limitError = await cubit.checkDailyLimit(amount);
      if (limitError != null) {
        if (mounted) {
          Get.snackbar(
            'Daily limit reached',
            limitError,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
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
      if (mounted) {
        setState(() => _isPrimaryActionInProgress = false);
      } else {
        _isPrimaryActionInProgress = false;
      }
    }
  }

  /// Check if the user has sufficient balance in the source currency wallet.
  /// Returns an error message if insufficient, null if OK.
  Future<String?> _validateBalance({
    required String currency,
    required double totalCost,
  }) async {
    try {
      final accountsClient =
          serviceLocator<accounts_grpc.AccountsServiceClient>();
      final callOptions =
          await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      // Cross-currency check: the validator MUST see USD/GBP/etc wallets
      // even when the user's locale is en-NG. Default GetUserAccounts
      // returns only the locale-currency accounts, which made the check
      // report `bestBalance=0` for any non-locale source currency and
      // refuse perfectly funded international transfers.
      final response = await accountsClient.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(includeAllCurrencies: true),
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
      // Cross-locale dialog needs to see the foreign-currency wallet
      // to render its real balance. Without includeAllCurrencies the
      // user saw "USD Balance $0.00" even with a funded USD account.
      final response = await accountsClient.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(includeAllCurrencies: true),
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
      'USD': 'US',
      'GBP': 'GB',
      'EUR': 'EU',
      'NGN': 'NG',
      'ZAR': 'ZA',
      'GHS': 'GH',
      'KES': 'KE',
      // PHP/CAD removed — Klasha (their provider) is reserved for RMB.
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
        'bankName': 'Lazervault',
        'accountName': 'Lazervault Account',
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
                  color: Color(0xFF4E03D0),
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
                    backgroundColor: const Color(0xFF4E03D0),
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

    // The cubit always fetches a fresh rate inside convertCurrency(),
    // so we don't block on expired cached rate here.

    // Fire the RPC INSIDE the onPinValidated callback so the PIN
    // bottom sheet stays open in its processing state while we await
    // the backend. The callback is EXHAUSTIVE — every cubit outcome
    // resolves to a definite next screen or a thrown error, so the sheet
    // can never close into nothing. `handledNavigation` tells the outer
    // block the callback already navigated.
    bool handledNavigation = false;
    final success = await validateTransactionPin(
      context: context,
      transactionId: 'exchange-${DateTime.now().millisecondsSinceEpoch}',
      transactionType: 'exchange_conversion',
      amount: cubit.amount,
      currency: cubit.fromCurrency,
      title: 'Confirm Exchange',
      message:
          'Confirm currency exchange of ${cubit.fromCurrency} ${cubit.amount.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        await cubit.convertCurrency(verificationToken: token);
        final state = cubit.state;
        if (state is ExchangeError) {
          // Classify so the sheet shows a friendly headline+detail rather
          // than a raw backend log line.
          final view = classifyExchangeError(state.message);
          throw Exception('${view.headline} — ${view.detail}');
        }
        if (state is ExchangeProcessing) {
          // Backend returned a processing-state tx (async mode).
          // Pop the PIN sheet ourselves and route to the processing
          // screen, which subscribes to the WS + auto-polls for terminal.
          handledNavigation = true;
          if (mounted) {
            try {
              Navigator.of(context).pop();
            } catch (_) {}
          }
          Get.toNamed(
            AppRoutes.exchangeProcessing,
            arguments: {
              'mode': 'convert',
              'fromCurrency': cubit.fromCurrency,
              'toCurrency': cubit.toCurrency,
              'amount': cubit.amount,
              'rate': cubit.currentRate,
              'transactionId': state.transactionId,
            },
          );
          return;
        }
        if (state is ExchangeSuccess) {
          // Terminal RPC response — navigate to the receipt from inside
          // the callback rather than relying on a fragile post-await read.
          handledNavigation = true;
          if (mounted) {
            try {
              Navigator.of(context).pop();
            } catch (_) {}
          }
          Get.offNamed(
            AppRoutes.exchangeReceipt,
            arguments: state.transaction,
          );
          return;
        }
        // No definite outcome — never fall through to a fake success.
        throw Exception(
          "We couldn't confirm your exchange — check your Transactions "
          'to see if it went through before retrying.',
        );
      },
    );

    // The callback owns navigation; this only guards cancel / failed-PIN.
    if (!success || handledNavigation || !mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.dashboard);
      },
      child: Scaffold(
        backgroundColor: AppSurfaces.pageTop,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            'Currency Exchange',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            ServiceVoiceButton(serviceName: 'exchange'),
            const SizedBox(width: 8),
            const MicroserviceChatIcon(
              serviceName: 'Currency Exchange',
              sourceContext: 'exchange',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: AppGradientBackground(
          child: BlocConsumer<ExchangeCubit, ExchangeState>(
          listener: (context, state) {
            // Rate staleness is enforced server-side now. ExchangeRateExpired
            // events (if any older code paths still emit them) are ignored.
          },
          builder: (context, state) {
            if (state is ExchangeLoading) {
              return const Center(
                  child: LazerVaultLoader.small());
            }

            if (state is ExchangeError) {
              return _buildErrorState(state.message);
            }

            if (state is ExchangeHomeWithRate) {
              return _buildContent(state);
            }

            return const SizedBox.shrink();
          },
        ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    // Classify the raw backend error into a kind + headline + detail so
    // the user sees an actionable message ("Send at least 6.00 USD")
    // instead of a leaky log line. See
    // currency_exchange/presentation/utils/exchange_error_classifier.dart.
    final view = classifyExchangeError(message);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
            const SizedBox(height: 16),
            Text(
              view.headline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              view.detail,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _refresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(view.cta ?? 'Retry',
                  style: const TextStyle(color: Colors.white)),
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
    final canProceed = amount > 0 && rate != null;

    return RefreshIndicator(
      onRefresh: _refresh,
      color: const Color(0xFF4E03D0),
      backgroundColor: const Color(0xFF1F1F1F),
      child: Column(
        children: [
          Expanded(
            // Horizontal swipe anywhere on the form flips between the two
            // tabs (Convert ↔ Send abroad), mirroring the toggle above.
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: (details) {
                final velocity = details.primaryVelocity ?? 0;
                if (velocity.abs() < 200) return;
                final next = velocity < 0
                    ? ExchangeMode.sendAbroad // swipe left → next tab
                    : ExchangeMode.convert; // swipe right → previous tab
                if (next != _mode) _onModeChanged(next);
              },
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

                  // Indicative rate chip — no countdown, no expiry. The final
                  // rate is captured server-side at transaction time.
                  if (rate != null)
                    _buildIndicativeRateChip(rate),
                  if (rate == null && amount > 0)
                    Center(
                      child: TextButton.icon(
                        onPressed: _fetchRate,
                        icon: const Icon(Icons.refresh,
                            color: ExchangeTheme.primary, size: 16),
                        label: const Text(
                          'Get exchange rate',
                          style: TextStyle(
                              color: ExchangeTheme.primary, fontSize: 13),
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

                  // Fee-paid history preview — last 3 completed exchanges
                  // of the active tab. Conversion tab shows only same-
                  // user wallet conversions; Send Abroad tab shows only
                  // cross-border Flutterwave transfers. Legacy
                  // TransactionType.exchange rows (pre-dating the split)
                  // surface on both tabs so nothing disappears.
                  () {
                    final isConversion = _mode == ExchangeMode.convert;
                    final visibleRecent = state.recentTransactions
                        .where((tx) => tx.type.matchesMode(isConversion: isConversion))
                        .take(3)
                        .toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          'Recent ${isConversion ? 'Conversions' : 'International Transfers'}',
                          visibleRecent.isNotEmpty
                              ? () => Get.toNamed(AppRoutes.exchangeHistory)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        if (visibleRecent.isEmpty)
                          _buildEmptyTransactions()
                        else
                          ...visibleRecent.map((tx) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ExchangeTransactionTile(
                                  transaction: tx,
                                  // Open the actions bottom sheet (View /
                                  // Repeat / Share / Report) just like the
                                  // history screen. Going straight to the
                                  // detail page skipped those actions for
                                  // no good reason.
                                  onTap: () => ExchangeHistoryActionsSheet
                                      .show(context, tx),
                                ),
                              )),
                      ],
                    );
                  }(),
                  // Bottom padding for scroll
                  const SizedBox(height: 80),
                ],
              ),
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
                  onPressed: (canProceed && !_isPrimaryActionInProgress)
                      ? _onPrimaryAction
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ExchangeTheme.primary,
                    disabledBackgroundColor: ExchangeTheme.surfaceElevated,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isPrimaryActionInProgress
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: LazerVaultLoader.small())
                      : Text(
                          _mode == ExchangeMode.convert
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

  Widget _buildIndicativeRateChip(ExchangeRate rate) {
    // Replaces the old countdown. Shows "1 NGN ≈ 0.00064 USD · Final rate
    // confirmed at transfer" and a manual refresh icon. No TTL.
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: ExchangeTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ExchangeTheme.divider),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline,
                color: ExchangeTheme.primary, size: 14),
            const SizedBox(width: 6),
            Text(
              '1 ${rate.fromCurrency} ≈ ${rate.rate.toStringAsFixed(rate.rate < 1 ? 6 : 4)} ${rate.toCurrency}',
              style: const TextStyle(
                color: ExchangeTheme.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Final rate locked at transfer',
              style: TextStyle(
                  color: ExchangeTheme.textSecondary, fontSize: 11),
            ),
            const SizedBox(width: 6),
            InkWell(
              onTap: _isRefreshingRate ? null : _fetchRate,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: _isRefreshingRate
                    ? LazerVaultLoader(size: 14)
                    : const Icon(Icons.refresh,
                        size: 14, color: ExchangeTheme.primary),
              ),
            ),
          ],
        ),
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
              ? const Color(0xFF4E03D0).withValues(alpha: 0.5)
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
                color: Color(0xFF4E03D0),
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
