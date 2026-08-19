import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/app_surfaces.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/account_reauth_helper.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_link_fee_mixin.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/link_account_gate.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/linked_account_state_chip.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:fixnum/fixnum.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdrawal_receipt_screen.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/open_banking/presentation/mixins/linked_balance_refresh_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Withdraw funds to one of the user's linked bank accounts.
///
/// Money OUT of the user's Lazervault balance. Mirrors the deposit screen's theme.
/// The destination is restricted to a **Mono-linked** bank account (verified during
/// deposit linking); the payout itself runs server-side via the NIP transfer provider
/// (Mono is collection-only and has no payout API). The backend resolves the bank +
/// account number from `linked_account_id`, holds funds, pays out, then captures on
/// success / releases on failure — the user is never debited for a failed payout.
class WithdrawFundsScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCard;
  const WithdrawFundsScreen({super.key, required this.selectedCard});

  @override
  State<WithdrawFundsScreen> createState() => _WithdrawFundsScreenState();
}

class _WithdrawFundsScreenState extends State<WithdrawFundsScreen>
    with TransactionPinMixin, BankLinkFeeMixin, LinkedBalanceRefreshMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  // Joint-fund / group-accounts theme palette (signature purple #4E03D0).
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _primaryPurple = Color(0xFF4E03D0); // signature hero / CTA / selection
  static const _accent = Color(0xFF7C5CFF); // lighter purple for text + icon accents
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFFB923C);
  static const _error = Color(0xFFEF4444);

  // Signature purple gradient (#4E03D0 → 80%) used on the hero + primary CTAs,
  // matching the joint-fund / contribution screens.
  static final LinearGradient _heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [_primaryPurple, _primaryPurple.withValues(alpha: 0.80)],
  );

  // Inter text styling helper (the group-account theme's typeface).
  static TextStyle _inter(
          {double? size, FontWeight? weight, Color? color, double? spacing, double? height}) =>
      GoogleFonts.inter(
          fontSize: size, fontWeight: weight, color: color, letterSpacing: spacing, height: height);

  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  List<LinkedBankAccount> _linkedAccounts = [];
  LinkedBankAccount? _selected;
  // Drives the linked-bank carousel so selecting a bank can snap it to the start.
  final ScrollController _bankCarouselController = ScrollController();
  bool _loadingAccounts = true;
  bool _linking = false;

  // Backend-authoritative fee quote (aggregated platform margin + Flutterwave payout
  // cost). Falls back to the local NIP-tier estimate until the quote lands, so the
  // fee is never blank and the user is never surprised by a different charge.
  int? _quotedFeeKobo;
  int? _quotedPlatformFeeKobo;
  int? _quotedProviderCostKobo;
  Timer? _feeQuoteDebounce;

  String get _sourceAccountId =>
      (widget.selectedCard['id'] ?? widget.selectedCard['accountId'] ?? '')
          .toString();
  String get _currency =>
      (widget.selectedCard['currency'] ?? widget.selectedCard['currencyCode'] ?? 'NGN')
          .toString();
  String get _currencySymbol => _currency == 'NGN' ? '₦' : '';

  /// Available balance in major units (naira). Read defensively from the card; the
  /// backend is the source of truth and re-validates before any money moves.
  double get _availableBalance {
    final v = widget.selectedCard['availableBalance'] ??
        widget.selectedCard['available_balance'] ??
        widget.selectedCard['balance'] ??
        0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  /// Identity of the ACTIVE Lazervault account being debited (the "Available to
  /// withdraw" figure is THIS account's wallet balance, not a linked-bank balance).
  String get _activeAccountLabel {
    final c = widget.selectedCard;
    final name = (c['name'] ??
            c['accountName'] ??
            c['account_name'] ??
            c['title'] ??
            '')
        .toString()
        .trim();
    final type =
        (c['accountType'] ?? c['account_type'] ?? c['type'] ?? '').toString().trim();
    if (name.isNotEmpty && type.isNotEmpty) return '$name · $type';
    if (name.isNotEmpty) return name;
    if (type.isNotEmpty) return type;
    return 'Your Lazervault account';
  }

  @override
  void initState() {
    super.initState();
    // Telemetry: withdrawal screen view.
    AnalyticsService.instance.trackWithdrawalScreen(_currency);
    // Repaint the amount field's border when it gains/loses focus (purple focus ring).
    _amountFocus.addListener(() {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadLinkedAccounts());
  }

  @override
  void dispose() {
    _feeQuoteDebounce?.cancel();
    _amountController.dispose();
    _amountFocus.dispose();
    _bankCarouselController.dispose();
    super.dispose();
  }

  void _loadLinkedAccounts() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      setState(() => _loadingAccounts = false);
      return;
    }
    serviceLocator<OpenBankingCubit>().fetchLinkedAccounts(
      userId: authState.profile.user.id,
      accessToken: authState.profile.session.accessToken,
    );
  }

  /// Swipe-down-to-refresh: re-pull the linked payout accounts so the
  /// destination carousel reflects the latest linked banks. Awaits a short
  /// settle so the spinner stays visible until the cubit emits.
  Future<void> _pullToRefresh() async {
    if (mounted) setState(() => _loadingAccounts = true);
    _loadLinkedAccounts();
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  /// Link a new bank via Mono Connect, then pick it as the destination.
  /// autoCreateMandate is false — a payout destination needs no debit mandate.
  Future<void> _linkNewBank() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    if (!MonoConfig.isEnabled) {
      _snack('Bank linking is not available right now.', _error);
      return;
    }
    final user = authState.profile.user;
    final name = '${user.firstName} ${user.lastName}'.trim();

    // VIRTUAL-ACCOUNT GATE + CONNECTION-FEE CONSENT — the VA check now lives
    // inside showBankConnectionFeeNotice (the universal chokepoint every link
    // flow shares), so it runs FIRST: the "Setting up your account" modal mints
    // the NUBAN / routes to BVN KYC before the fee notice, exactly like deposit,
    // analytics, LazerBeam & autosave. No separate KYC pre-gate.
    final proceed = await showBankConnectionFeeNotice(context);
    if (!proceed || !mounted) return;
    // One idempotency id for this whole link attempt.
    final txnId = 'link-${DateTime.now().millisecondsSinceEpoch}';

    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: name.isNotEmpty ? name : null,
      customerEmail: user.email.isNotEmpty ? user.email : null,
      reference: 'lzv_withdraw_link_${DateTime.now().millisecondsSinceEpoch}',
    );
    if (result == null || !mounted) return;

    setState(() => _linking = true);
    // Fee already consented above — link straight through (no second notice).
    // autoCreateMandate is false — a payout destination needs no debit mandate.
    final obc = serviceLocator<OpenBankingCubit>();
    await obc.linkAccount(
      userId: user.id,
      code: result.code,
      accessToken: authState.profile.session.accessToken,
      autoCreateMandate: false,
      transactionId: txnId,
    );
  }

  void _onAccountLinked(LinkedBankAccount account) {
    setState(() {
      _linking = false;
      final i = _linkedAccounts.indexWhere((a) => a.id == account.id);
      if (i >= 0) {
        _linkedAccounts[i] = account;
      } else {
        // New bank becomes the first card in the carousel + the selection.
        _linkedAccounts.insert(0, account);
      }
      _selected = account;
    });
    _snack('${account.bankName} linked.', _success);

    // Flow straight into completing the withdrawal: if an amount is already
    // entered, open the confirm/PIN txbottomsheet now; otherwise prompt for the
    // amount by focusing the field so the user can finish in one continuous flow.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_enteredAmount > 0) {
        _onWithdraw();
      } else {
        FocusScope.of(context).requestFocus(_amountFocus);
        _snack('Bank linked. Enter an amount to withdraw.', _accent);
      }
    });
  }

  /// Select a destination bank, move it to the FRONT of the carousel, and snap
  /// the carousel back to the start so the chosen (now-first) account is the
  /// first card shown.
  void _selectAccount(LinkedBankAccount account) {
    setState(() {
      _selected = account;
      final i = _linkedAccounts.indexWhere((a) => a.id == account.id);
      if (i > 0) {
        _linkedAccounts.insert(0, _linkedAccounts.removeAt(i));
      }
    });
    // Auto-scroll to the start after the reorder so the selected card is visible.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_bankCarouselController.hasClients) {
        _bankCarouselController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ===== Fee =====
  // Local AGGREGATED estimate — placeholder shown until the backend quote lands.
  // Mirrors the backend default (platform NIP tier + Flutterwave payout cost
  // ₦10.75/21.50/26.88) so it NEVER under-shows the real charge: worst case the
  // user sees a hair more, never a surprise higher charge. Never the final amount.
  double _localFeeEstimate(double amount) {
    final kobo = (amount * 100).round();
    if (kobo <= 500000) return 20.75; // ₦10 platform + ₦10.75 payout
    if (kobo <= 5000000) return 46.50; // ₦25 + ₦21.50
    return 76.88; // ₦50 + ₦26.88
  }

  double get _enteredAmount => double.tryParse(_amountController.text.trim()) ?? 0;

  /// The fee shown + charged: the backend's AGGREGATED quote (platform margin +
  /// Flutterwave payout cost) when available, else the local estimate.
  double get _fee {
    if (_quotedFeeKobo != null) return _quotedFeeKobo! / 100.0;
    return _enteredAmount > 0 ? _localFeeEstimate(_enteredAmount) : 0;
  }

  double get _totalDebit => _enteredAmount + _fee;

  /// Debounced backend fee quote on every amount change (money-visibility: the fee
  /// shown must be the fee charged, admin-tunable, incl. the FW payout cost).
  void _scheduleFeeQuote() {
    _feeQuoteDebounce?.cancel();
    // Drop any prior quote IMMEDIATELY on every amount change so a stale quote for a
    // DIFFERENT amount can never be shown/charged — the getter falls back to the
    // local estimate until the fresh quote lands (and _runWithdrawFlow force-fetches
    // when it's still null at submit time).
    if (_quotedFeeKobo != null ||
        _quotedPlatformFeeKobo != null ||
        _quotedProviderCostKobo != null) {
      setState(() {
        _quotedFeeKobo = null;
        _quotedPlatformFeeKobo = null;
        _quotedProviderCostKobo = null;
      });
    }
    if (_enteredAmount <= 0) return;
    _feeQuoteDebounce =
        Timer(const Duration(milliseconds: 400), _fetchWithdrawalFeeQuote);
  }

  Future<void> _fetchWithdrawalFeeQuote() async {
    final amount = _enteredAmount;
    if (amount <= 0) return;
    final amountKobo = (amount * 100).round();
    try {
      final req = banking_pb.CalculateWithdrawalFeeRequest()
        ..amount = Int64(amountKobo);
      final callOptions =
          await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final client = serviceLocator<banking_grpc.BankingServiceClient>();
      final resp = await client.calculateWithdrawalFee(req, options: callOptions);
      if (!mounted || !resp.success) return;
      // Drop a stale response if the amount changed while it was in flight.
      if ((_enteredAmount * 100).round() != resp.amount.toInt()) return;
      setState(() {
        _quotedFeeKobo = resp.fee.toInt();
        _quotedPlatformFeeKobo = resp.platformFee.toInt();
        _quotedProviderCostKobo = resp.providerCost.toInt();
      });
    } catch (_) {
      // Keep the local estimate on any error — never block the withdrawal flow.
    }
  }

  String _money(double v) =>
      '$_currencySymbol${v.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}';

  // ===== Validation =====
  String? _validate() {
    if (_enteredAmount <= 0) return 'Enter an amount to withdraw';
    if (_selected == null) return 'Select a bank to withdraw to';
    if (_availableBalance > 0 && _totalDebit > _availableBalance) {
      return 'Amount plus fee exceeds your available balance';
    }
    return null;
  }

  /// Map raw backend/provider withdrawal errors to user-facing copy. The raw
  /// text (e.g. "transfer failed: flutterwave transfer request failed:
  /// flutterwave HTTP 400: Transfer creation failed") must never reach the UI.
  String _friendlyWithdrawError(String? raw) {
    final lower = (raw ?? '').toLowerCase();
    if (lower.contains('account resolve') || lower.contains('resolve failed')) {
      return 'We could not verify this bank account with our payout provider. '
          'Please confirm the account details or try a different bank.';
    }
    if (lower.contains('insufficient')) {
      return 'Insufficient balance for this withdrawal.';
    }
    if (lower.contains('limit')) {
      return 'This withdrawal exceeds your current limit.';
    }
    if (lower.contains('timeout') ||
        lower.contains('deadline') ||
        lower.contains('unavailable') ||
        lower.contains('network')) {
      return 'The payout service is taking too long. Your money has not been '
          'deducted. Please try again shortly.';
    }
    return 'We could not complete this withdrawal. Your money has not been '
        'deducted. Please try again shortly.';
  }

  // ===== Submit =====
  // The destination (a Mono-linked account) is already bank-verified, so the
  // confirm sheet shows the verified holder name, then the PIN sheet processes
  // the payout IN-SHEET (verify -> process -> success/failed) like the transfer
  // txbottomsheet: the real gRPC call runs inside onPinValidated so the sheet's
  // result reflects the actual outcome. On success we land on the receipt; on
  // failure the error is shown inside the sheet (no navigation).
  bool _submitting = false;

  Future<void> _onWithdraw() async {
    // Guard against a double-tap firing two withdrawals with different idem keys.
    if (_submitting) return;
    final err = _validate();
    if (err != null) {
      _snack(err, _error);
      return;
    }
    // Guard: a payout destination whose Mono session expired must be reconnected
    // before we can resolve its NUBAN/bank for the NIP transfer. Route to the
    // real reauthorization flow instead of attempting a payout that would fail.
    if (_selected != null && _selected!.needsReauthorization) {
      _snack('Reconnect ${_selected!.bankName} from its card to withdraw to it.', _error);
      return;
    }
    _submitting = true;
    try {
      await _runWithdrawFlow();
    } finally {
      if (mounted) _submitting = false;
    }
  }

  Future<void> _runWithdrawFlow() async {
    FocusScope.of(context).unfocus();
    final account = _selected!;
    final amount = _enteredAmount;
    // Ensure the tx-PIN sheet + the balance check use the AUTHORITATIVE aggregated
    // fee (platform + Flutterwave payout cost), not the local estimate — force the
    // quote if the debounced fetch hasn't landed yet, so the shown fee = the charge.
    if (_quotedFeeKobo == null) {
      await _fetchWithdrawalFeeQuote();
      if (!mounted) return;
      // If the quote service is down, do NOT proceed on the local estimate — the
      // admin-tunable fees may have drifted, so it could under-show the real charge.
      // Ask the user to retry so the shown fee is always the authoritative one.
      if (_quotedFeeKobo == null) {
        _snack("We couldn't confirm the withdrawal fee. Please try again.", _error);
        return;
      }
      // Re-check affordability now that the real (higher) fee is known.
      final err2 = _validate();
      if (err2 != null) {
        _snack(err2, _error);
        return;
      }
    }
    final transactionId = const Uuid().v4();
    final destName =
        account.accountName.isNotEmpty ? account.accountName : account.bankName;

    banking_pb.WithdrawalResponse? resp;

    final ok = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'withdrawal',
      amount: amount,
      currency: _currency,
      fee: _fee,
      totalAmount: _totalDebit,
      currencySymbol: _currencySymbol,
      title: 'Confirm withdrawal',
      message:
          'Send ${_money(amount)} to $destName · ${account.bankName} (${account.displayAccountNumber}). ${_money(_fee)} fee.',
      // Run the payout inside the sheet's processing phase (transfer pattern).
      // A thrown error here makes the sheet show the failure inline.
      showProcessingPhase: true,
      onPinValidated: (token) async {
        resp = await _runWithdrawal(account, amount, transactionId, token);
        if (resp == null || !resp!.success) {
          // Never surface raw provider plumbing ("flutterwave HTTP 400…") to
          // the user — classify into actionable copy. Money safety: a failed
          // payout releases its hold, so the balance is untouched.
          throw Exception(_friendlyWithdrawError(resp?.errorMessage));
        }
      },
    );

    // Telemetry: linked-bank withdrawal initiation outcome.
    AnalyticsService.instance.trackWithdrawalOutcome(
      destination: 'linked_bank',
      outcome: (ok && resp != null && resp!.success) ? 'success' : 'failure',
    );

    // Failure path already surfaced inside the sheet.
    if (!ok || resp == null || !resp!.success) return;
    if (!mounted) return;

    // Use the backend's AUTHORITATIVE fee/total from the withdrawal record (never a
    // client recompute) so the receipt matches exactly what was charged.
    final feeKobo = resp!.withdrawal.fee.toInt();
    final totalKobo = resp!.withdrawal.totalAmount.toInt();
    final fee = feeKobo > 0 ? feeKobo / 100.0 : _fee;
    final totalDebited = totalKobo > 0 ? totalKobo / 100.0 : amount + fee;
    Get.off(() => WithdrawalReceiptScreen(
          amount: amount,
          fee: fee,
          totalDebited: totalDebited,
          bankName: account.bankName.isNotEmpty ? account.bankName : 'Bank',
          accountNumber: account.displayAccountNumber,
          reference: resp!.withdrawal.reference,
          currencySymbol: _currencySymbol,
          status: resp!.withdrawal.status,
        ));
  }

  /// Fires the withdrawal gRPC. Returns the response (success or business
  /// failure); throws on transport error so the sheet shows a failure state.
  Future<banking_pb.WithdrawalResponse> _runWithdrawal(
      LinkedBankAccount account, double amount, String transactionId, String verificationToken) async {
    final req = banking_pb.InitiateWithdrawalRequest()
      ..sourceAccountId = _sourceAccountId
      ..linkedAccountId = account.id
      ..amount = Int64((amount * 100).round())
      ..narration = 'Withdrawal to ${account.bankName}'
      ..idempotencyKey = transactionId
      // PIN verification is ENFORCED server-side: pass the token + txn id in the
      // request body (matching InitiateMoveTransfer). Metadata is also set below
      // for older gateway paths, but the body fields are now the primary source.
      ..verificationToken = verificationToken
      ..transactionId = transactionId;

    var callOptions = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
    callOptions = callOptions.mergedWith(CallOptions(metadata: {
      'x-verification-token': verificationToken,
      'x-transaction-id': transactionId,
    }));

    final client = serviceLocator<banking_grpc.BankingServiceClient>();
    return client.initiateWithdrawal(req, options: callOptions);
  }

  void _snack(String msg, Color color) {
    Get.snackbar('', msg,
        titleText: const SizedBox.shrink(),
        messageText: Text(msg, style: const TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color.withValues(alpha: 0.95),
        margin: EdgeInsets.all(12.w));
  }

  // ===== Bank logo (bundled asset, gradient-initials fallback) =====
  Widget _bankLogoAvatar(String bankName, {String? bankCode, double size = 42}) {
    return BankLogo(
      bankName: bankName,
      bankCode: bankCode,
      size: size,
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<OpenBankingCubit>(),
      child: BlocListener<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
          if (state is LinkedAccountsLoaded) {
            setState(() {
              _linkedAccounts = state.accounts
                  .where((a) => a.status == LinkedAccountStatus.active)
                  .toList();
              _loadingAccounts = false;
              if (_selected == null && _linkedAccounts.isNotEmpty) {
                _selected = _linkedAccounts.firstWhere((a) => a.isDefault,
                    orElse: () => _linkedAccounts.first);
              }
            });
          } else if (state is AccountLinked) {
            _onAccountLinked(state.account);
          } else if (state is AccountLinkedWithMandate) {
            _onAccountLinked(state.account);
          } else if (state is BalanceRefreshed) {
            // A per-account refresh landed (possibly triggered from the DEPOSIT
            // screen — same singleton cubit) → update THIS card's balance in place
            // so the "last updated" + figure reflect it everywhere.
            if (mounted) {
              setState(() {
                _linkedAccounts = _linkedAccounts
                    .map((a) => a.id == state.accountId
                        ? a.copyWith(
                            lastKnownBalance: state.newBalance,
                            balanceUpdatedAt: DateTime.now())
                        : a)
                    .toList();
                if (_selected?.id == state.accountId) {
                  _selected = _linkedAccounts.firstWhere(
                      (a) => a.id == state.accountId,
                      orElse: () => _selected!);
                }
              });
            }
          } else if (state is OpenBankingError) {
            if (state.operation == 'fetchLinkedAccounts') {
              setState(() => _loadingAccounts = false);
            } else if (state.operation == 'linkAccount') {
              setState(() => _linking = false);
              // Linked-bank cap (admin-tunable default 3) / provider capacity
              // exhausted — surface as a styled modal with a "Manage banks" CTA,
              // never a toast. Nothing was charged (checked before any fee).
              if (state.errorCode == kLinkLimitReachedCode) {
                showLinkLimitReachedDialog(context, state.message);
              } else if (state.errorCode == kLinkingCapacityCode) {
                showLinkingCapacityDialog(context);
              } else {
                _snack('Could not link the bank. Please try again.', _error);
              }
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppSurfaces.pageTop,
          appBar: AppBar(
            backgroundColor: AppSurfaces.pageTop,
            elevation: 0,
            title: Text('Withdraw',
                style: _inter(size: 18.sp, weight: FontWeight.w700, color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: AppGradientBackground(
            child: Stack(
            children: [
              SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _pullToRefresh,
                    color: const Color(0xFF8B5CF6),
                    backgroundColor: const Color(0xFF1A1A1A),
                    child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBalance(),
                        SizedBox(height: 20.h),
                        _buildAmountField(),
                        SizedBox(height: 24.h),
                        _buildDestinationCarousel(),
                      ],
                    ),
                  ),
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
          ),
              if (_linking)
                Positioned.fill(
                  child: ColoredBox(
                    color: const Color(0xCC000000),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 26.h),
                        decoration: BoxDecoration(
                          color: _card,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(color: _divider),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LazerVaultLoader(size: 38),
                            SizedBox(height: 16.h),
                            Text('Linking your bank…',
                                style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                            SizedBox(height: 4.h),
                            Text('Securely connecting via Mono',
                                style: TextStyle(color: _textSecondary, fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  /// Signature purple-gradient hero (joint-fund theme): the wallet balance the
  /// user can withdraw, with a short caption explaining the NIP payout path.
  Widget _buildBalance() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: _heroGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: _primaryPurple.withValues(alpha: 0.28),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text('Available to withdraw',
                    style: _inter(size: 12.5.sp, weight: FontWeight.w500, color: Colors.white.withValues(alpha: 0.85))),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(_currency,
                    style: _inter(size: 11.sp, weight: FontWeight.w700, color: Colors.white, spacing: 0.4)),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(_money(_availableBalance),
              style: _inter(size: 30.sp, weight: FontWeight.w800, color: Colors.white)),
          SizedBox(height: 4.h),
          Text('From $_activeAccountLabel',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _inter(size: 11.5.sp, weight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.92))),
          SizedBox(height: 4.h),
          Text('Debited from this account · sent to your linked bank over NIP',
              style: _inter(size: 11.5.sp, weight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.78))),
        ],
      ),
    );
  }

  Widget _buildAmountField() {
    final focused = _amountFocus.hasFocus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amount', style: _inter(size: 14.sp, weight: FontWeight.w600, color: Colors.white)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: focused ? _primaryPurple : _divider,
              width: focused ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(_currencySymbol,
                  style: _inter(size: 20.sp, weight: FontWeight.w700, color: Colors.white)),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  focusNode: _amountFocus,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                  onChanged: (_) {
                    setState(() {});
                    _scheduleFeeQuote();
                  },
                  style: _inter(size: 22.sp, weight: FontWeight.w700, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: _inter(size: 22.sp, color: _textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_enteredAmount > 0) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Text('Fee ${_money(_fee)}', style: _inter(size: 12.sp, color: _textSecondary)),
              const Spacer(),
              Text('Total ${_money(_totalDebit)}',
                  style: _inter(size: 12.sp, weight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.8))),
            ],
          ),
          // Transparency: the aggregated fee = our platform margin + the bank payout
          // cost we pay Flutterwave. Shown once the backend quote lands.
          if ((_quotedProviderCostKobo ?? 0) > 0) ...[
            SizedBox(height: 3.h),
            Text(
                'incl. ${_money((_quotedProviderCostKobo ?? 0) / 100.0)} bank payout · '
                '${_money((_quotedPlatformFeeKobo ?? 0) / 100.0)} service fee',
                style: _inter(size: 10.5.sp, color: _textSecondary)),
          ],
          SizedBox(height: 3.h),
          Text('You receive ${_money(_enteredAmount)} at your bank',
              style: _inter(size: 11.sp, weight: FontWeight.w500, color: _accent)),
        ],
      ],
    );
  }

  /// "Withdraw to" section: header + horizontal carousel of linked banks (tap to
  /// select, swipe to browse) ending with an "add bank" card, plus a "View all"
  /// link opening the full picker bottomsheet. Mirrors the deposit screen carousel.
  Widget _buildDestinationCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Withdraw to',
                      style: _inter(size: 16.sp, weight: FontWeight.w600, color: Colors.white)),
                  SizedBox(height: 3.h),
                  Text(
                    _linkedAccounts.isEmpty
                        ? 'Link a bank to withdraw to'
                        : 'Tap a bank to select, swipe to browse',
                    style: _inter(size: 12.sp, color: _textSecondary),
                  ),
                ],
              ),
            ),
            // Link a new bank — always available right here on the page.
            GestureDetector(
              onTap: _linking ? null : _linkNewBank,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline, color: _accent, size: 16.sp),
                    SizedBox(width: 3.w),
                    Text('Link new',
                        style: _inter(size: 13.sp, weight: FontWeight.w700, color: _accent)),
                  ],
                ),
              ),
            ),
            if (_linkedAccounts.length > 1) ...[
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: _openAccountSheet,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Row(
                    children: [
                      Text('View all',
                          style: _inter(size: 13.sp, weight: FontWeight.w700, color: _accent)),
                      Icon(Icons.chevron_right, color: _accent, size: 18.sp),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 14.h),
        if (_loadingAccounts)
          _buildCarouselLoading()
        else if (_linkedAccounts.isEmpty)
          _buildLinkBankCta()
        else
          SizedBox(
            height: 150.h,
            child: ListView.separated(
              controller: _bankCarouselController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: _linkedAccounts.length + 1,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (ctx, i) {
                if (i == _linkedAccounts.length) return _buildAddBankCard();
                // Pass the itemBuilder ctx (below the OpenBankingCubit provider)
                // so the Reconnect flow can read the cubit from context.
                return _buildCarouselCard(ctx, _linkedAccounts[i]);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildCarouselLoading() {
    return LazerVaultLoader(size: 12);
  }

  /// A single linked-bank card in the carousel. Tap to select; the selected card
  /// gets an accent border + check. Shows the Mono-verified holder name + account.
  Widget _buildCarouselCard(BuildContext cardCtx, LinkedBankAccount a) {
    final selected = _selected?.id == a.id;
    final needsReauth = a.needsReauthorization;
    // A bank whose Mono session expired can't be paid out to until reconnected —
    // tapping the card (or the Reconnect chip) runs the real reauthorization flow
    // instead of selecting it. cardCtx is below the OpenBankingCubit provider.
    return GestureDetector(
      onTap: () => needsReauth
          ? startAccountReauthorization(cardCtx, a)
          : _selectAccount(a),
      child: Container(
        width: 230.w,
        padding: EdgeInsets.all(16.w),
        decoration: AppSurfaces.card(
          accent: needsReauth
              ? _warning
              : (selected ? _primaryPurple : AppSurfaces.accentPurple),
          accentAlpha: needsReauth ? 0.50 : (selected ? 1.0 : 0.22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _bankLogoAvatar(a.bankName, bankCode: a.bankCode, size: 38),
                const Spacer(),
                if (needsReauth)
                  _reconnectChip(cardCtx, a)
                else if (selected)
                  Icon(Icons.check_circle, color: _accent, size: 22.sp)
                else
                  _payoutStatusChip(a),
              ],
            ),
            const Spacer(),
            Text(a.bankName.isNotEmpty ? a.bankName : 'Linked bank',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _inter(size: 14.sp, weight: FontWeight.w700, color: Colors.white)),
            if (a.accountName.isNotEmpty) ...[
              SizedBox(height: 3.h),
              Text(a.accountName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp)),
            ],
            SizedBox(height: 2.h),
            Text(a.displayAccountNumber,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11.5.sp, letterSpacing: 0.3)),
            SizedBox(height: 3.h),
            // Cached balance from our DB record + when it was last refreshed. A live
            // Mono balance read is BILLED PER ACCOUNT, so we NEVER auto-fetch — the
            // user taps refresh (fee-gated) to pull a live figure for THIS bank only.
            // A refresh here or on the deposit screen reflects on both (shared cubit).
            Builder(builder: (_) {
              final isRefreshing = cardCtx.select<OpenBankingCubit, bool>((c) {
                final s = c.state;
                return s is BalanceRefreshing && s.accountId == a.id;
              });
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('₦${a.lastKnownBalance.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 1.h),
                        Text(
                            needsReauth
                                ? 'Reconnect to refresh'
                                : linkedBalanceLastUpdatedLabel(a.balanceUpdatedAt),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.45),
                                fontSize: 9.5.sp)),
                      ],
                    ),
                  ),
                  if (!needsReauth) _cardRefreshButton(a, isRefreshing),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Per-account refresh button on a payout card — pulls a LIVE balance for THIS
  /// bank only (fee-gated tx-PIN sheet), via the shared LinkedBalanceRefreshMixin.
  Widget _cardRefreshButton(LinkedBankAccount a, bool isRefreshing) {
    const accent = Color(0xFF3B82F6);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isRefreshing ? null : () => _refreshCardBalance(a),
      child: Tooltip(
        message: 'Refresh balance',
        child: Container(
          width: 30.w,
          height: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(9.r),
            border: Border.all(color: accent.withValues(alpha: 0.42)),
          ),
          child: isRefreshing
              ? SizedBox(
                  width: 13.w,
                  height: 13.w,
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: accent),
                )
              : Icon(Icons.sync_rounded, size: 15.sp, color: accent),
        ),
      ),
    );
  }

  void _refreshCardBalance(LinkedBankAccount a) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    // Same shared, per-account, fee-gated refresh the deposit screen uses.
    refreshLinkedBalance(
      context,
      a,
      userId: authState.profile.user.id,
      accessToken: authState.profile.session.accessToken,
    );
  }

  /// Shared "Reconnect" chip for a payout account whose Mono session expired.
  /// [cardCtx] is below the OpenBankingCubit provider so the reauth flow works.
  Widget _reconnectChip(BuildContext cardCtx, LinkedBankAccount a) {
    return LinkedAccountStateChip(
      state: LinkedAccountState.reconnect,
      onTap: () => startAccountReauthorization(cardCtx, a),
    );
  }

  /// Verified/connected chip — tappable to explain the payout (NIP) model.
  Widget _payoutStatusChip(LinkedBankAccount a) {
    return LinkedAccountStateChip(
      state: a.isVerified ? LinkedAccountState.verified : LinkedAccountState.connected,
      onTap: () => _showPayoutInfo(a),
      showInfoAffordance: true,
    );
  }

  /// Explains a withdrawal destination uses NIP (no Direct Debit mandate).
  void _showPayoutInfo(LinkedBankAccount a) {
    final bank = a.bankName.isNotEmpty ? a.bankName : 'this bank';
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.14), shape: BoxShape.circle),
                  child: Icon(Icons.account_balance_outlined, color: _accent, size: 19.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text('Payout to $bank',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                ),
              ]),
              SizedBox(height: 16.h),
              Text(
                'Withdrawals send money TO this bank over NIP (instant bank transfer). '
                'No Direct Debit authorization is needed. That is only for pulling money IN (deposits).',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13.sp, height: 1.45),
              ),
              SizedBox(height: 12.h),
              _payoutInfoRow(
                a.isVerified ? Icons.verified_rounded : Icons.info_outline,
                a.isVerified ? _success : const Color(0xFFFB923C),
                a.isVerified
                    ? 'Account name verified with your bank.'
                    : 'Account ownership not yet verified.',
              ),
              if (a.needsReauthorization) ...[
                SizedBox(height: 8.h),
                _payoutInfoRow(Icons.refresh, const Color(0xFFFB923C),
                    'The connection expired. Reconnect to refresh live balances.'),
              ],
              SizedBox(height: 18.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: TextButton.styleFrom(foregroundColor: _accent),
                  child: Text('Got it', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _payoutInfoRow(IconData icon, Color color, String text) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 16.sp),
      SizedBox(width: 10.w),
      Expanded(
        child: Text(text,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 12.5.sp, height: 1.4)),
      ),
    ]);
  }

  /// Trailing carousel card to link another bank.
  Widget _buildAddBankCard() {
    return GestureDetector(
      onTap: _linkNewBank,
      child: Container(
        width: 150.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_primaryPurple, Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w, height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.add_rounded, color: Colors.white, size: 24.sp),
            ),
            const Spacer(),
            Text('Link a new bank',
                style: _inter(size: 13.sp, weight: FontWeight.w800, color: Colors.white)),
            SizedBox(height: 3.h),
            Text('Withdraw to another account',
                maxLines: 2,
                style: _inter(size: 10.5.sp, color: Colors.white.withValues(alpha: 0.85))),
          ],
        ),
      ),
    );
  }

  /// Full-width CTA shown when the user has no linked banks yet.
  Widget _buildLinkBankCta() {
    return GestureDetector(
      onTap: _linkNewBank,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_primaryPurple, Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: _primaryPurple.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46.w, height: 46.w,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(13.r)),
              child: Icon(Icons.add_rounded, color: Colors.white, size: 26.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Link a bank to withdraw',
                      style: _inter(size: 16.sp, weight: FontWeight.w800, color: Colors.white)),
                  SizedBox(height: 3.h),
                  Text('Securely connect a bank via Mono',
                      style: _inter(size: 12.sp, color: Colors.white.withValues(alpha: 0.85))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 22.sp),
          ],
        ),
      ),
    );
  }

  /// Bank picker bottomsheet: linked banks (tap to select) + "Link a new bank".
  void _openAccountSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(sheetCtx).size.height * 0.82),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2E38),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  width: 44.w, height: 4.h,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 14.h),
                child: Text('Withdraw to',
                    style: _inter(size: 20.sp, weight: FontWeight.w800, color: Colors.white)),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 8.h),
                  children: [
                    _buildLinkNewBankTile(sheetCtx),
                    if (_linkedAccounts.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 16.h, 4.w, 10.h),
                        child: Text('YOUR LINKED BANKS',
                            style: _inter(
                                size: 11.sp,
                                weight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.45),
                                spacing: 1.0)),
                      ),
                      ..._linkedAccounts.map((a) => _buildSheetAccountTile(sheetCtx, a)),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetAccountTile(BuildContext sheetCtx, LinkedBankAccount account) {
    final selected = _selected?.id == account.id;
    return GestureDetector(
      onTap: () {
        _selectAccount(account);
        Navigator.of(sheetCtx).pop();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected ? _primaryPurple.withValues(alpha: 0.18) : Colors.white.withValues(alpha: 0.045),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? _primaryPurple : Colors.white.withValues(alpha: 0.06),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            _bankLogoAvatar(account.bankName, bankCode: account.bankCode, size: 46),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.bankName.isNotEmpty ? account.bankName : 'Linked bank',
                      overflow: TextOverflow.ellipsis,
                      style: _inter(size: 15.sp, weight: FontWeight.w700, color: Colors.white)),
                  SizedBox(height: 4.h),
                  Text(account.displayAccountNumber,
                      style: _inter(size: 12.sp, color: Colors.white.withValues(alpha: 0.5), spacing: 0.3)),
                ],
              ),
            ),
            Container(
              width: 24.w, height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? _primaryPurple : Colors.transparent,
                border: Border.all(color: selected ? _primaryPurple : Colors.white.withValues(alpha: 0.25), width: 1.5),
              ),
              child: selected ? Icon(Icons.check, color: Colors.white, size: 15.sp) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkNewBankTile(BuildContext sheetCtx) {
    return GestureDetector(
      onTap: () {
        Navigator.of(sheetCtx).pop();
        _linkNewBank();
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_primaryPurple, Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: _primaryPurple.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46.w, height: 46.w,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(13.r)),
              child: Icon(Icons.add_rounded, color: Colors.white, size: 26.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Link a new bank',
                      style: _inter(size: 16.sp, weight: FontWeight.w800, color: Colors.white)),
                  SizedBox(height: 3.h),
                  Text('Securely connect a bank to withdraw to',
                      style: _inter(size: 12.sp, color: Colors.white.withValues(alpha: 0.85))),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 22.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final ready = _enteredAmount > 0 && _selected != null;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: AppSurfaces.pageBottom,
        border: Border(top: BorderSide(color: _divider)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: ready
                ? [
                    BoxShadow(
                      color: _primaryPurple.withValues(alpha: 0.40),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const [],
          ),
          child: ElevatedButton(
            onPressed: ready ? _onWithdraw : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryPurple,
              disabledBackgroundColor: _primaryPurple.withValues(alpha: 0.3),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            ),
            child: Text(
                _enteredAmount > 0 ? 'Withdraw ${_money(_totalDebit)}' : 'Withdraw',
                style: _inter(size: 16.sp, weight: FontWeight.w800, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
