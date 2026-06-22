import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/app_surfaces.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/account_reauth_helper.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/linked_account_state_chip.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Withdraw funds to one of the user's linked bank accounts.
///
/// Money OUT of the user's LazerVault balance. Mirrors the deposit screen's theme.
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
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  // Deposit dark theme palette.
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF3B82F6);
  static const _orange = Color(0xFFF97316); // Withdraw CTA
  static const _onOrange = Color(0xFF1A1206); // high-contrast text on orange
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);

  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  List<LinkedBankAccount> _linkedAccounts = [];
  LinkedBankAccount? _selected;
  bool _loadingAccounts = true;
  bool _linking = false;

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadLinkedAccounts());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocus.dispose();
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

    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: name.isNotEmpty ? name : null,
      customerEmail: user.email.isNotEmpty ? user.email : null,
      reference: 'lzv_withdraw_link_${DateTime.now().millisecondsSinceEpoch}',
    );
    if (result == null || !mounted) return;

    setState(() => _linking = true);
    serviceLocator<OpenBankingCubit>().linkAccount(
      userId: user.id,
      code: result.code,
      accessToken: authState.profile.session.accessToken,
      autoCreateMandate: false,
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

  /// Select a destination bank and move it to the FRONT of the carousel so the
  /// chosen account is always the first card shown.
  void _selectAccount(LinkedBankAccount account) {
    setState(() {
      _selected = account;
      final i = _linkedAccounts.indexWhere((a) => a.id == account.id);
      if (i > 0) {
        _linkedAccounts.insert(0, _linkedAccounts.removeAt(i));
      }
    });
  }

  // ===== Fee (mirrors banking-service CalculateWithdrawalFee NIP tiers) =====
  double _feeFor(double amount) {
    final kobo = (amount * 100).round();
    if (kobo <= 500000) return 10; // <= NGN 5,000
    if (kobo <= 5000000) return 25; // <= NGN 50,000
    return 50;
  }

  double get _enteredAmount => double.tryParse(_amountController.text.trim()) ?? 0;
  double get _fee => _enteredAmount > 0 ? _feeFor(_enteredAmount) : 0;
  double get _totalDebit => _enteredAmount + _fee;

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
  Future<void> _onWithdraw() async {
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
    FocusScope.of(context).unfocus();
    final account = _selected!;
    final amount = _enteredAmount;
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

    // Failure path already surfaced inside the sheet.
    if (!ok || resp == null || !resp!.success) return;
    if (!mounted) return;

    final fee = _feeFor(amount);
    Get.off(() => WithdrawalReceiptScreen(
          amount: amount,
          fee: fee,
          totalDebited: amount + fee,
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
      ..idempotencyKey = transactionId;

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
          } else if (state is OpenBankingError) {
            if (state.operation == 'fetchLinkedAccounts') {
              setState(() => _loadingAccounts = false);
            } else if (state.operation == 'linkAccount') {
              setState(() => _linking = false);
              _snack('Could not link the bank. Please try again.', _error);
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppSurfaces.pageTop,
          appBar: AppBar(
            backgroundColor: AppSurfaces.pageTop,
            elevation: 0,
            title: Text('Withdraw',
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: AppGradientBackground(
            child: Stack(
            children: [
              SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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

  Widget _buildBalance() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: AppSurfaces.card(accent: _orange, accentAlpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Available balance', style: TextStyle(color: _textSecondary, fontSize: 12.sp)),
          SizedBox(height: 6.h),
          Text(_money(_availableBalance),
              style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amount', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _divider),
          ),
          child: Row(
            children: [
              Text(_currencySymbol,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  focusNode: _amountFocus,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                  onChanged: (_) => setState(() {}),
                  style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(color: _textSecondary, fontSize: 22.sp),
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
              Text('Fee ${_money(_fee)}', style: TextStyle(color: _textSecondary, fontSize: 12.sp)),
              const Spacer(),
              Text('You send ${_money(_totalDebit)}',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ],
          ),
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
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 3.h),
                  Text(
                    _linkedAccounts.isEmpty
                        ? 'Link a bank to withdraw to'
                        : 'Tap a bank to select, swipe to browse',
                    style: TextStyle(color: _textSecondary, fontSize: 12.sp),
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
                        style: TextStyle(color: _accent, fontSize: 13.sp, fontWeight: FontWeight.w700)),
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
                          style: TextStyle(color: _accent, fontSize: 13.sp, fontWeight: FontWeight.w700)),
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
              ? const Color(0xFFFB923C)
              : (selected ? _accent : AppSurfaces.accentPurple),
          accentAlpha: needsReauth ? 0.50 : (selected ? 0.90 : 0.22),
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
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
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
            // LIVE-ONLY: figure only when this session's Mono read landed.
            Builder(builder: (_) {
              final fresh = a.balanceUpdatedAt != null &&
                  DateTime.now().difference(a.balanceUpdatedAt!).inMinutes < 3;
              if (fresh) {
                return Text('₦${a.lastKnownBalance.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700));
              }
              return Row(mainAxisSize: MainAxisSize.min, children: [
                LazerVaultLoader(size: 9),
                SizedBox(width: 5.w),
                Text('Fetching balance…',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.sp)),
              ]);
            }),
          ],
        ),
      ),
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
            colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
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
                style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w800)),
            SizedBox(height: 3.h),
            Text('Withdraw to another account',
                maxLines: 2,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 10.5.sp)),
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
            colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.35),
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
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
                  SizedBox(height: 3.h),
                  Text('Securely connect a bank via Mono',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12.sp)),
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
                    style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800)),
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
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.45),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0)),
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
          color: selected ? const Color(0xFF3B82F6).withValues(alpha: 0.16) : Colors.white.withValues(alpha: 0.045),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? const Color(0xFF3B82F6) : Colors.white.withValues(alpha: 0.06),
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
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4.h),
                  Text(account.displayAccountNumber,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp, letterSpacing: 0.3)),
                ],
              ),
            ),
            Container(
              width: 24.w, height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? const Color(0xFF3B82F6) : Colors.transparent,
                border: Border.all(color: selected ? const Color(0xFF3B82F6) : Colors.white.withValues(alpha: 0.25), width: 1.5),
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
            colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.35),
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
                      style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
                  SizedBox(height: 3.h),
                  Text('Securely connect a bank to withdraw to',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12.sp)),
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
        child: ElevatedButton(
          onPressed: ready ? _onWithdraw : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _orange,
            disabledBackgroundColor: _orange.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          ),
          child: Text(
              _enteredAmount > 0 ? 'Withdraw ${_money(_totalDebit)}' : 'Withdraw',
              style: TextStyle(color: _onOrange, fontSize: 16.sp, fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}
