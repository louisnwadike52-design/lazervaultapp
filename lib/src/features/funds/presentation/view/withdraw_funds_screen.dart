import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixnum/fixnum.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;

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
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF3B82F6);
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);

  final TextEditingController _amountController = TextEditingController();
  List<LinkedBankAccount> _linkedAccounts = [];
  LinkedBankAccount? _selected;
  bool _loadingAccounts = true;
  bool _submitting = false;
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
        _linkedAccounts.insert(0, account);
      }
      _selected = account;
    });
    _snack('${account.bankName} linked.', _success);
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

  // ===== Submit =====
  Future<void> _onWithdraw() async {
    final err = _validate();
    if (err != null) {
      _snack(err, _error);
      return;
    }
    FocusScope.of(context).unfocus();
    final account = _selected!;
    final amount = _enteredAmount;
    final transactionId = const Uuid().v4();

    String? token;
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
          'Send ${_money(amount)} to ${account.bankName}. ${_money(_fee)} fee. ${_money(_totalDebit)} will leave your balance.',
      onPinValidated: (t) async {
        token = t;
      },
    );
    if (!ok || token == null) return;
    if (!mounted) return;
    await _submit(account, amount, transactionId, token!);
  }

  Future<void> _submit(LinkedBankAccount account, double amount,
      String transactionId, String verificationToken) async {
    setState(() => _submitting = true);
    _showProcessing(account.bankName);
    try {
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
      final resp = await client.initiateWithdrawal(req, options: callOptions);

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // close processing

      if (resp.success) {
        Get.offAllNamed(AppRoutes.dashboard);
        Get.snackbar(
          'Withdrawal started',
          'Sending ${_money(amount)} to ${account.bankName}.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: _success.withValues(alpha: 0.95),
          colorText: Colors.white,
          margin: EdgeInsets.all(12.w),
        );
      } else {
        _snack(resp.errorMessage.isNotEmpty ? resp.errorMessage : 'Withdrawal failed', _error);
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        _snack('Withdrawal failed. Please try again.', _error);
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showProcessing(String bankName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => Center(
        child: Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.symmetric(horizontal: 48.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 44.w,
                height: 44.w,
                child: const CircularProgressIndicator(color: _accent, strokeWidth: 3),
              ),
              SizedBox(height: 18.h),
              Text('Sending to $bankName',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 6.h),
              Text('Securely processing your withdrawal',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textSecondary, fontSize: 12.sp)),
            ],
          ),
        ),
      ),
    );
  }

  void _snack(String msg, Color color) {
    Get.snackbar('', msg,
        titleText: const SizedBox.shrink(),
        messageText: Text(msg, style: const TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color.withValues(alpha: 0.95),
        margin: EdgeInsets.all(12.w));
  }

  // ===== Bank logo avatar (gradient initials; matches deposit) =====
  Widget _bankLogoAvatar(String bankName, {double size = 42}) {
    final name = bankName.trim().isEmpty ? 'Bank' : bankName.trim();
    final initials = name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.substring(0, 1).toUpperCase();
    final palettes = <List<Color>>[
      [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      [const Color(0xFF0EA5E9), const Color(0xFF2563EB)],
      [const Color(0xFF10B981), const Color(0xFF059669)],
      [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
      [const Color(0xFFEC4899), const Color(0xFF8B5CF6)],
      [const Color(0xFF14B8A6), const Color(0xFF0EA5E9)],
    ];
    final pair = palettes[name.codeUnits.fold<int>(0, (a, b) => a + b) % palettes.length];
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: pair, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12.r),
      ),
      alignment: Alignment.center,
      child: Text(initials,
          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
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
          backgroundColor: _bg,
          appBar: AppBar(
            backgroundColor: _bg,
            elevation: 0,
            title: Text('Withdraw',
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Stack(
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
                        Text('Withdraw to',
                            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                        SizedBox(height: 12.h),
                        _buildDestinationSelector(),
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
          ),
              if (_linking)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0x99000000),
                    child: Center(child: CircularProgressIndicator(color: _accent)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalance() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _divider),
      ),
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

  /// Tappable destination row — opens the bank picker bottomsheet.
  Widget _buildDestinationSelector() {
    final acct = _selected;
    return GestureDetector(
      onTap: _loadingAccounts ? null : _openAccountSheet,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: acct != null ? _accent.withValues(alpha: 0.4) : _divider),
        ),
        child: Row(
          children: [
            if (_loadingAccounts)
              SizedBox(width: 42.w, height: 42.w, child: const Center(child: CircularProgressIndicator(color: _accent, strokeWidth: 2)))
            else if (acct != null)
              _bankLogoAvatar(acct.bankName)
            else
              Container(
                width: 42.w, height: 42.w,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(12.r)),
                child: Icon(Icons.account_balance_outlined, color: _textSecondary, size: 20.sp),
              ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(acct != null ? acct.bankName : 'Select a bank',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 3.h),
                  Text(
                    acct != null ? acct.displayAccountNumber : 'Choose or link a bank to withdraw to',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: _textSecondary, size: 22.sp),
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
        constraints: BoxConstraints(maxHeight: MediaQuery.of(sheetCtx).size.height * 0.8),
        decoration: BoxDecoration(
          color: const Color(0xFF26262E),
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
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 10.h),
                child: Text('Withdraw to',
                    style: TextStyle(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w700)),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 8.h),
                  children: [
                    ..._linkedAccounts.map((a) => _buildSheetAccountTile(sheetCtx, a)),
                    _buildLinkNewBankTile(sheetCtx),
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
        setState(() => _selected = account);
        Navigator.of(sheetCtx).pop();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(13.w),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.14) : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: selected ? _accent : Colors.white.withValues(alpha: 0.08), width: selected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            _bankLogoAvatar(account.bankName),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.bankName.isNotEmpty ? account.bankName : 'Linked bank',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 3.h),
                  Text(account.displayAccountNumber,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12.sp)),
                ],
              ),
            ),
            Icon(selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: selected ? _accent : _textSecondary, size: 20.sp),
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
        margin: EdgeInsets.only(top: 2.h, bottom: 6.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _accent.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: _accent.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w, height: 42.w,
              decoration: BoxDecoration(color: _accent.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(12.r)),
              child: Icon(Icons.add, color: _accent, size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Link a new bank',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 3.h),
                  Text('Securely connect a bank to withdraw to',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12.sp)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: _accent, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final ready = _enteredAmount > 0 && _selected != null && !_submitting;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _divider)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: ElevatedButton(
          onPressed: ready ? _onWithdraw : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _accent,
            disabledBackgroundColor: _accent.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          ),
          child: _submitting
              ? SizedBox(
                  width: 22.w, height: 22.w,
                  child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text(
                  _enteredAmount > 0 ? 'Withdraw ${_money(_totalDebit)}' : 'Withdraw',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
