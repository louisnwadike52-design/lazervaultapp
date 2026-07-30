import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/app_surfaces.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/utils/kyc_error_handler.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/move_money/presentation/receipts/beam_receipt_payload.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/beam_style.dart';
import 'package:lazervault/src/features/move_money/data/datasources/move_money_grpc_datasource.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_prediction_cubit.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_prediction_alert.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:uuid/uuid.dart';

import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';
import '../../cubit/move_money_cubit.dart';
import '../../cubit/move_money_state.dart';
import '../../domain/entities/mandate_entity.dart';
import '../../domain/entities/move_transfer.dart';
import '../../domain/entities/move_fee_calculation.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_authorization_sheet.dart'
    as shared_auth;
import '../widgets/mandate_activating_banner.dart';
import '../widgets/mandate_management_bottomsheet.dart';
import '../widgets/mandate_mode_info.dart';
import '../widgets/mandate_status_badge.dart';
import '../widgets/move_fee_breakdown.dart';
import '../widgets/reauth_required_overlay.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/account_reauth_helper.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_link_fee_mixin.dart';

/// Single-screen Move Money transfer flow (modelled after the Exchange Convert flow).
///
/// Layout:
///   From account card (draggable / tappable)
///   Swap button
///   To account card (draggable / tappable)
///   Amount input
///   Fee breakdown
///   Narration (optional)
///   ── pinned CTA ──
///   "Move Money" button → PIN bottom sheet → initiate transfer → receipt
class MoveTransferFlowScreen extends StatefulWidget {
  const MoveTransferFlowScreen({super.key});

  @override
  State<MoveTransferFlowScreen> createState() =>
      _MoveTransferFlowScreenState();
}

class _MoveTransferFlowScreenState extends State<MoveTransferFlowScreen>
    with TransactionPinMixin, BankLinkFeeMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  // Beam bounds (kobo). These are admin-tunable server-side; the values below are
  // only a PRE-RESPONSE fallback and are overwritten with the authoritative
  // min/max returned by CalculateMoveFee (see the fee-calculated listener). The
  // backend re-enforces the real cap regardless of the client.
  int _minAmountKobo = 150000; // fallback until the server responds
  int _maxAmountKobo = 500000000; // fallback until the server responds

  LinkedBankAccount? _sourceAccount;
  LinkedBankAccount? _destinationAccount;
  final _amountController = TextEditingController();
  final _narrationController = TextEditingController();
  MoveFeeCalculation? _feeCalculation;
  bool _isCalculatingFee = false;
  bool _isTransferInProgress = false;
  String? _amountError;
  // Per-transfer debit choice: false = DirectPay (default), true = Direct Debit mandate.

  // Drag-to-swap visual state
  bool _isHoveringFrom = false;
  bool _isHoveringTo = false;

  // Track which side triggered "Link New Account" so we can auto-select it
  bool? _pendingLinkIsSource;

  // Informational, READ-ONLY transfer success prediction (non-blocking).
  // Owned by this screen so we can drive it as the destination changes.
  final TransferPredictionCubit _predictionCubit =
      serviceLocator<TransferPredictionCubit>();
  String? _lastPredictedDestKey;

  // Redo prefill (best-effort): a Beam receipt's "Redo" passes the previous
  // destination linked-account id + amount + narration. Amount/narration apply
  // immediately; the destination is re-selected once linked accounts load.
  String? _pendingRedoDestId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      final destId = args['destinationLinkedAccountId'];
      if (destId is String && destId.isNotEmpty) _pendingRedoDestId = destId;
      final amount = args['amount'];
      if (amount is num && amount > 0) {
        _amountController.text = amount.toStringAsFixed(2);
      }
      final narration = args['narration'];
      if (narration is String && narration.isNotEmpty) {
        _narrationController.text = narration;
      }
    }
    _loadAccounts();
    _amountController.addListener(_onAmountChanged);
  }

  /// Re-select the redo destination once linked accounts are available.
  void _applyRedoIfReady() {
    final destId = _pendingRedoDestId;
    if (destId == null) return;
    final accounts = context.read<OpenBankingCubit>().linkedAccounts;
    for (final a in accounts) {
      if (a.id == destId) {
        _pendingRedoDestId = null;
        setState(() => _destinationAccount = a);
        // No billed auto-refresh — the last-known balance is shown; the user
        // taps the tile to pull a live (cost-confirmed) figure if they want one.
        _maybeFetchPrediction();
        return;
      }
    }
  }

  /// Fetch the success prediction once the destination bank code + account
  /// number are known. Best-effort and non-blocking; safe to call repeatedly.
  void _maybeFetchPrediction() {
    final dest = _destinationAccount;
    if (dest == null || dest.bankCode.isEmpty || dest.accountNumber.isEmpty) {
      _lastPredictedDestKey = null;
      _predictionCubit.reset();
      return;
    }
    final key = '${dest.bankCode}|${dest.accountNumber}';
    if (key == _lastPredictedDestKey) return;
    _lastPredictedDestKey = key;
    _predictionCubit.fetch(
      bankCode: dest.bankCode,
      accountNumber: dest.accountNumber,
    );
  }

  void _loadAccounts() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<OpenBankingCubit>().fetchLinkedAccounts(
            userId: authState.profile.userId,
            accessToken: authState.profile.session.accessToken,
          );
      context.read<MandateCubit>().fetchUserMandates(
            userId: authState.profile.userId,
          );
    }
    _listenForBalanceRefreshes();
  }

  /// Balances are refreshed only on an explicit, cost-confirmed user tap (never
  /// auto-pulled). This listener keeps the screen's picked accounts in sync with
  /// a completed manual refresh and records FAILURES so the tile can offer a
  /// retry.
  StreamSubscription<OpenBankingState>? _balanceRefreshSub;
  final Set<String> _balanceRefreshFailedIds = <String>{};
  final Set<String> _refreshingBalanceIds = <String>{};

  void _listenForBalanceRefreshes() {
    _balanceRefreshSub ??=
        context.read<OpenBankingCubit>().stream.listen((s) {
      if (!mounted) return;
      if (s is LinkedAccountsLoaded) {
        _applyRedoIfReady();
      }
      if (s is BalanceRefreshing) {
        setState(() => _refreshingBalanceIds.add(s.accountId));
      } else if (s is BalanceRefreshed) {
        setState(() {
          _refreshingBalanceIds.remove(s.accountId);
          _balanceRefreshFailedIds.remove(s.accountId);
          final fresh = context.read<OpenBankingCubit>().linkedAccounts;
          LinkedBankAccount? pick(String? id) {
            for (final a in fresh) {
              if (a.id == id) return a;
            }
            return null;
          }

          _sourceAccount = pick(_sourceAccount?.id) ?? _sourceAccount;
          _destinationAccount =
              pick(_destinationAccount?.id) ?? _destinationAccount;
        });
      } else if (s is OpenBankingError && s.operation == 'refreshBalance') {
        setState(() {
          final inFlight = Set<String>.from(_refreshingBalanceIds);
          _refreshingBalanceIds.clear();
          _balanceRefreshFailedIds.addAll(inFlight);
        });
      }
    });
  }

  @override
  void dispose() {
    _balanceRefreshSub?.cancel();
    _amountController.dispose();
    _narrationController.dispose();
    _predictionCubit.close();
    // Stop any active polling when leaving the screen
    context.read<MoveMoneyCubit>().stopPolling();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Amount / fee handling
  // ---------------------------------------------------------------------------

  void _onAmountChanged() {
    final amountKobo = _parseAmountKobo();
    if (amountKobo > 0) {
      String? error;
      if (amountKobo < _minAmountKobo) {
        error = 'Minimum amount is NGN ${(_minAmountKobo / 100).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
      } else if (amountKobo > _maxAmountKobo) {
        error = 'Maximum amount is NGN ${(_maxAmountKobo / 100).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
      }
      setState(() {
        _amountError = error;
        _isCalculatingFee = error == null;
      });
      if (error == null) {
        context.read<MoveMoneyCubit>().calculateFeeDebounced(amountKobo);
      } else {
        setState(() => _feeCalculation = null);
      }
    } else {
      setState(() {
        _amountError = null;
        _feeCalculation = null;
        _isCalculatingFee = false;
      });
    }
  }

  int _parseAmountKobo() {
    final text = _amountController.text.replaceAll(',', '');
    final naira = double.tryParse(text) ?? 0;
    return (naira * 100).toInt();
  }

  // ---------------------------------------------------------------------------
  // Account picker bottom sheet
  // ---------------------------------------------------------------------------

  void _showAccountPicker({required bool isSource}) {
    final accounts = context.read<OpenBankingCubit>().linkedAccounts;
    final excludeId = isSource ? _destinationAccount?.id : _sourceAccount?.id;
    final selectedId = isSource ? _sourceAccount?.id : _destinationAccount?.id;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _AccountPickerSheet(
        accounts: accounts,
        selectedId: selectedId,
        excludeId: excludeId,
        title: isSource
            ? 'Select Source Account'
            : 'Select Destination Account',
        onSelected: (account) {
          setState(() {
            if (isSource) {
              _sourceAccount = account;
              if (_destinationAccount?.id == account.id) {
                _destinationAccount = null;
              }
            } else {
              _destinationAccount = account;
              if (_sourceAccount?.id == account.id) {
                _sourceAccount = null;
              }
            }
          });
          Navigator.of(ctx).pop();
        },
        onAddAccount: () {
          Navigator.of(ctx).pop();
          _pendingLinkIsSource = isSource;
          _showLinkAccountBottomSheet();
        },
      ),
    );
  }

  void _swapAccounts() {
    if (_sourceAccount == null && _destinationAccount == null) return;
    setState(() {
      final temp = _sourceAccount;
      _sourceAccount = _destinationAccount;
      _destinationAccount = temp;
      // Fee depends on source account — recalculate
      _feeCalculation = null;
    });
    // Recalculate fee if there's an amount entered
    final amountKobo = _parseAmountKobo();
    if (amountKobo >= _minAmountKobo && amountKobo <= _maxAmountKobo) {
      setState(() => _isCalculatingFee = true);
      context.read<MoveMoneyCubit>().calculateFeeDebounced(amountKobo);
    }
  }

  // ---------------------------------------------------------------------------
  // Mono account linking
  // ---------------------------------------------------------------------------

  void _showLinkAccountBottomSheet() async {
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
      final obc = context.read<OpenBankingCubit>();
      // Cost-confirmed link (fee + txPIN when an operator has enabled it; free
      // otherwise). Auto-mandate: passes user info so mandate is created too.
      await linkBankWithFee(
        context: context,
        cubit: obc,
        doLink: (token, txnId) async => obc.linkAccount(
          userId: user.id,
          code: result.code,
          accessToken: authState.profile.session.accessToken,
          userEmail: user.email.isNotEmpty ? user.email : null,
          userName: customerName.isNotEmpty ? customerName : null,
          userPhone:
              (user.phoneNumber?.isNotEmpty ?? false) ? user.phoneNumber : null,
          verificationToken: token,
          transactionId: txnId,
        ),
      );
      if (!mounted) return;
      obc.fetchLinkedAccounts(
        userId: authState.profile.userId,
        accessToken: authState.profile.session.accessToken,
      );
    }
  }

  /// Shown when the backend gates a money move on identity verification
  /// (KYC_REQUIRED). Routes the user into the progressive KYC flow so they can
  /// verify their BVN, after which DirectPay / Direct Debit can move money.
  void _showKYCRequiredSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24.w, 20.h, 24.w, 24.h + MediaQuery.of(sheetCtx).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF6B7280),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.verified_user_outlined,
                  color: const Color(0xFF3B82F6), size: 28.sp),
            ),
            SizedBox(height: 16.h),
            Text('Verify your identity',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text(
              'To move money from your bank we need to confirm your identity with your BVN. It only takes a moment.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(sheetCtx).pop();
                  Get.toNamed('/kyc/progressive');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                child: Text('Verify identity',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => Navigator.of(sheetCtx).pop(),
              child: Text('Not now',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }

  /// Compact debit-method control on the transfer screen. DirectPay is the
  /// DEFAULT (the user approves each transfer at their bank); toggling Direct
  /// Debit on opens the mandate setup so future transfers debit instantly
  /// (authorize once). Reflects the source account's current mandate state, so
  /// it lights up automatically once Mono enables Direct Debit and a mandate
  /// becomes ready.
  Widget _buildDebitModeToggle() {
    // Rebuild when the MandateCubit updates (the background Mono refresh) so this
    // row reflects the live Direct-Debit state.
    return BlocBuilder<MandateCubit, MandateState>(
      builder: (context, _) => _buildDebitModeToggleBody(),
    );
  }

  Widget _buildDebitModeToggleBody() {
    if (_sourceAccount == null) return const SizedBox.shrink();
    final mandate =
        context.read<MandateCubit>().getMandateForAccount(_sourceAccount!.id);
    final mandateReady = mandate != null && mandate.isActive;
    // "Activating" = user authorized, only NIBSS left. A cancelled / not-yet-
    // authorized mandate (awaiting_authorization/pending) is NOT activating — it
    // falls through to the "one-time / set up Direct Debit" path so the user can
    // resume their authorization.
    final mandateActivating = mandate != null && mandate.isActivating;

    // STATE-DRIVEN row — no switch. The system always uses the best rail for
    // the source automatically (mandate when ready, one-time DirectPay
    // otherwise, with server-side fallback if a mandate debit fails), so the
    // user is INFORMED, and only offered an action when one exists:
    //  - ready mandate     → info only ("debits instantly")
    //  - activating        → [Finish setup] resumes the SAME mandate's
    //                        authorization (backend reuses it — no duplicate)
    //  - none / terminal   → [Set up Direct Debit] upgrade path
    final String title;
    final String subtitle;
    final IconData icon;
    final Color accent;
    String? actionLabel;

    if (mandateReady) {
      title = 'Direct Debit';
      subtitle = 'Authorized once. This transfer debits instantly.';
      icon = Icons.flash_on_rounded;
      accent = const Color(0xFF10B981);
    } else if (mandateActivating) {
      title = 'Direct Debit activating';
      subtitle = 'One-time approval is used until activation completes.';
      icon = Icons.hourglass_top_rounded;
      accent = const Color(0xFFFB923C);
      actionLabel = 'Finish setup';
    } else {
      title = 'One-time approval';
      subtitle = 'You approve this transfer at your bank.';
      icon = Icons.verified_user_outlined;
      accent = const Color(0xFF9CA3AF);
      actionLabel = 'Set up Direct Debit';
    }

    // Tapping the row (anywhere but the action button) opens the shared
    // DirectPay-vs-Direct-Debit info modal — same modal Deposit uses.
    final modeView = mandateReady
        ? MandateModeView.directDebit
        : mandateActivating
            ? MandateModeView.settingUp
            : MandateModeView.oneTime;

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () => showMandateModeInfoModal(
        context,
        current: modeView,
        bankName: _sourceAccount!.bankName,
        actionNoun: 'transfer',
        switchHint: 'Use the Direct Debit action on this row to switch.',
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: mandateReady
                ? const Color(0xFF10B981).withValues(alpha: 0.35)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(Icons.info_outline,
                          color: Colors.white.withValues(alpha: 0.4), size: 13.sp),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: mandateActivating
                          ? const Color(0xFFFB923C)
                          : const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          if (actionLabel != null)
            TextButton(
              onPressed: () async {
                await _showMandateManagement(_sourceAccount!, mandate);
                // The sheet may have created/authorized a mandate — reload so
                // this row (and the submit rail) reflect the new state.
                if (!mounted) return;
                final authState = context.read<AuthenticationCubit>().state;
                if (authState is AuthenticationSuccess) {
                  context.read<MandateCubit>().fetchUserMandates(
                        userId: authState.profile.userId,
                      );
                }
                setState(() {});
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              child: Text(
                actionLabel,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      ),
    );
  }

  Future<void> _showMandateManagement(
    LinkedBankAccount account,
    MandateEntity? mandate,
  ) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    final mandateCubit = context.read<MandateCubit>();
    await showMandateManagementBottomSheet(
      context: context,
      linkedAccountId: account.id,
      userId: authState.profile.userId,
      bankName: account.bankName,
      accountName: account.accountName,
      mandate: mandate,
    );
    if (mounted) {
      mandateCubit.fetchUserMandates(
        userId: authState.profile.userId,
      );
    }
  }

  /// Handle DirectPay authorization when transfer requires it (no mandate).
  /// Opens in-app WebView for bank authorization.
  Future<bool> _handleDirectPayAuthorization(String paymentUrl) async {
    // ONE PIPELINE: Beam uses the same hardened authorization sheet as
    // deposits (once-guarded redirect handling, provider-crash detection,
    // flow-specific chrome) instead of a separate webview variant.
    final result = await shared_auth.showDirectPayAuthorizationSheet(
      context: context,
      paymentUrl: paymentUrl,
      paymentId: '',
      flow: shared_auth.DirectPayFlow.deposit,
    );
    return result.success;
  }

  /// Handle mandate required error — auto-create mandate for the account.
  void _handleMandateRequired(String accountId) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    final mandateCubit = context.read<MandateCubit>();
    final user = authState.profile.user;

    Get.snackbar(
      'Setting Up Direct Debit',
      'Creating Direct Debit authorization for this account...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F1F1F),
      colorText: const Color(0xFFFB923C),
    );

    mandateCubit.recreateMandateForAccount(
      userId: authState.profile.userId,
      linkedAccountId: accountId,
      userEmail: user.email.isNotEmpty ? user.email : null,
      userName: '${user.firstName} ${user.lastName}'.trim(),
      userPhone: (user.phoneNumber?.isNotEmpty ?? false) ? user.phoneNumber : null,
    );
  }

  /// Handle reauthorization for an expired account.
  void _handleReauthorization(LinkedBankAccount account) async {
    // Full reconnect: reauth token → Mono Connect (reauth mode) → re-exchange
    // (backend dedups to the same row) → live balance refresh.
    await startAccountReauthorization(context, account);
    if (!mounted) return;
    // Sync local selections with the refreshed cubit cache.
    final cubit = context.read<OpenBankingCubit>();
    setState(() {
      for (final a in cubit.linkedAccounts) {
        if (_sourceAccount?.id == a.id) _sourceAccount = a;
        if (_destinationAccount?.id == a.id) _destinationAccount = a;
      }
    });
  }

  /// Check source account readiness before proceeding to PIN.
  /// Returns null if ready, or an error message string.
  String? _checkSourceAccountReady() {
    if (_sourceAccount == null) return 'Please select a source account';
    if (_destinationAccount == null) return 'Please select a destination account';

    if (_sourceAccount!.needsReauthorization) {
      return 'Source account requires re-authorization. Please re-link the account.';
    }

    if (_destinationAccount!.needsReauthorization) {
      return 'Destination account requires re-authorization. Please re-link the account.';
    }

    if (!_sourceAccount!.isActive) {
      return 'Source account is not active.';
    }

    if (!_destinationAccount!.isActive) {
      return 'Destination account is not active.';
    }

    // Same-account check (belt + suspenders — picker already prevents this)
    if (_sourceAccount!.id == _destinationAccount!.id) {
      return 'Source and destination cannot be the same account.';
    }

    // Cross-currency check
    if (_sourceAccount!.currency != _destinationAccount!.currency) {
      return 'Source and destination accounts must use the same currency.';
    }

    // Check balance
    final amountKobo = _parseAmountKobo();
    final totalDebit = _feeCalculation?.totalDebit ?? amountKobo;
    final balanceKobo = (_sourceAccount!.lastKnownBalance * 100).toInt();

    if (!_sourceAccount!.isBalanceStale) {
      // Fresh balance — strict check
      if (balanceKobo > 0 && balanceKobo < totalDebit) {
        final available = _sourceAccount!.lastKnownBalance.toStringAsFixed(2);
        final required = (totalDebit / 100.0).toStringAsFixed(2);
        return 'Insufficient balance. Available: NGN $available, required: NGN $required.';
      }
    }

    return null;
  }



  /// Beam → SendFunds receipt payload. One receipt experience platform-wide
  /// (LazerVault logo top-right, QR with the reference, no extra CTAs); only
  /// the payload varies per money product.
  /// Builds a GetIt-backed status fetcher that outlives this screen.
  Future<MoveTransfer> Function() _liveStatusFetcher(MoveTransfer t) {
    final authState = context.read<AuthenticationCubit>().state;
    final userId =
        authState is AuthenticationSuccess ? authState.profile.userId : '';
    final ds = serviceLocator<MoveMoneyGrpcDataSource>();
    return () => ds.getMoveTransferStatus(transferId: t.id, userId: userId);
  }

  Map<String, dynamic> _beamReceiptPayload(MoveTransfer t) =>
      beamReceiptPayloadFromMoveTransfer(
        t,
        // LIVE status on the receipt: fetch-on-load + WS push + pull-to-refresh.
        // The closure captures GetIt singletons only, so it stays valid after
        // this screen is disposed by Get.offNamed.
        statusFetch: _liveStatusFetcher(t),
      );

  /// User-initiated, COST-CONFIRMED balance refresh. A live Mono read is billed
  /// (Mono Connect is a paid connection), so we NEVER auto-pull one on load or
  /// account-pick — the last-known figure is shown until the user asks. When
  /// they do, quote the fee and, if it's > 0, show the cost + take a txPIN
  /// before charging the wallet and reading the live balance.
  Future<void> _manualRefreshBalance(LinkedBankAccount account) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final userId = authState.profile.userId;
    final accessToken = authState.profile.session.accessToken;
    final cubit = context.read<OpenBankingCubit>();

    final feeKobo = await cubit.quoteRefreshFee(
      accountId: account.id,
      userId: userId,
      accessToken: accessToken,
    );
    if (!mounted) return;
    if (feeKobo <= 0) {
      cubit.refreshBalance(
        accountId: account.id,
        userId: userId,
        accessToken: accessToken,
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
      amount: feeNaira,
      fee: feeNaira,
      totalAmount: feeNaira,
      currency: 'NGN',
      title: 'Refresh balance',
      message:
          'Refreshing ${account.bankName} pulls a live balance and costs ₦${feeNaira.toStringAsFixed(2)}. Your last-known balance is shown otherwise.',
      successMessage: 'Balance refreshed',
      onPinValidated: (token) async {
        await cubit.refreshBalance(
          accountId: account.id,
          userId: userId,
          accessToken: accessToken,
          isManual: true,
          verificationToken: token,
          transactionId: txnId,
        );
      },
    );
  }

  /// Balance line for the From/To tiles. We never auto-pull a billed live read,
  /// so the tile shows the LAST-KNOWN figure with a tap-to-refresh (cost-
  /// confirmed) affordance; states: refreshing → spinner, failed → "Refresh",
  /// otherwise the cached figure (green tick when it just went live, else a
  /// grey "not live" hint).
  Widget _buildTileBalance(LinkedBankAccount account) {
    if (_refreshingBalanceIds.contains(account.id)) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        LazerVaultLoader(size: 10),
        SizedBox(width: 6.w),
        Text('Refreshing…',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
      ]);
    }
    if (_balanceRefreshFailedIds.contains(account.id)) {
      return GestureDetector(
        onTap: () => _manualRefreshBalance(account),
        child: Text('Balance unavailable · Refresh',
            style: GoogleFonts.inter(
                color: const Color(0xFFFB923C),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600)),
      );
    }
    final everFetched = account.balanceUpdatedAt != null;
    final isLive = everFetched &&
        DateTime.now().difference(account.balanceUpdatedAt!).inMinutes < 3;
    return GestureDetector(
      onTap: () => _manualRefreshBalance(account),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          everFetched
              ? '₦${account.lastKnownBalance.toStringAsFixed(2)}'
              : 'Tap to fetch balance',
          style: GoogleFonts.inter(
              color: everFetched ? Colors.white : const Color(0xFF3B82F6),
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 5.w),
        Icon(Icons.refresh,
            size: 12.sp,
            color: isLive
                ? const Color(0xFF10B981)
                : const Color(0xFF9CA3AF)),
        if (everFetched && !isLive) ...[
          SizedBox(width: 3.w),
          Text('not live',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 9.5.sp)),
        ],
      ]),
    );
  }

  /// Returns a non-blocking warning ONLY when a user-initiated balance refresh
  /// FAILED. We show the last-known figure otherwise (no live auto-pull), so
  /// plain staleness is expected and never nagged about.
  String? _getBalanceWarning() {
    if (_sourceAccount == null) return null;
    if (_balanceRefreshFailedIds.contains(_sourceAccount!.id)) {
      return 'Could not refresh this balance (last updated '
          '${_formatLastRefresh(_sourceAccount!)}). Tap the balance to retry.';
    }
    if (_sourceAccount!.lastKnownBalance <= 0 && !_sourceAccount!.isBalanceStale) {
      return 'Balance information unavailable for this account.';
    }
    return null;
  }

  String _formatLastRefresh(LinkedBankAccount account) {
    final refreshTime = account.lastBalanceRefreshAt ?? account.balanceUpdatedAt;
    if (refreshTime == null) return 'never';
    final diff = DateTime.now().difference(refreshTime);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  /// Page-contained error SnackBar — bound to THIS screen's Scaffold via the
  /// nearest ScaffoldMessenger, so a server failure surfaced here disappears
  /// when the Beam flow pops instead of floating over the dashboard. Always
  /// shows friendly text, never the raw gRPC/HTTP error.
  void _showPageError(Object? error, {String? context}) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(this.context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          friendlyError(error, context: context),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
        ),
        backgroundColor: const Color(0xFF1F1F1F),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Transfer execution (PIN → debit → payout)
  // ---------------------------------------------------------------------------

  Future<void> _onMoveMoneyTap() async {
    if (_isTransferInProgress) return;

    if (_sourceAccount == null) {
      Get.snackbar('Source Required', 'Please select a source account',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1F1F1F),
          colorText: Colors.white);
      return;
    }
    if (_destinationAccount == null) {
      Get.snackbar(
          'Destination Required', 'Please select a destination account',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1F1F1F),
          colorText: Colors.white);
      return;
    }
    if (_parseAmountKobo() <= 0) {
      Get.snackbar('Amount Required', 'Please enter an amount',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1F1F1F),
          colorText: Colors.white);
      return;
    }

    // Pre-check source account readiness
    final readinessError = _checkSourceAccountReady();
    if (readinessError != null) {
      Get.snackbar('Cannot Proceed', readinessError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1F1F1F),
          colorText: const Color(0xFFEF4444),
          duration: const Duration(seconds: 4));
      return;
    }

    _isTransferInProgress = true;
    try {
      await _executeMoveTransfer();
    } finally {
      _isTransferInProgress = false;
    }
  }

  Future<void> _executeMoveTransfer() async {
    final amountKobo = _parseAmountKobo();
    final amountNaira = amountKobo / 100.0;

    final moveTransactionId = const Uuid().v4();

    // Fail fast BEFORE the PIN sheet if the session is gone.
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar('Error', 'Authentication required',
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
      return;
    }

    // The ENTIRE initiate (gateway -> banking-service -> Mono debit) runs
    // INSIDE the PIN sheet's processing phase, so the user watches one
    // continuous sheet (PIN -> Processing -> Success) and lands straight on
    // the receipt. A failure renders in the same sheet; the user never
    // bounces back to the form mid-flight.
    MoveMoneyState? postPinState;

    final success = await validateTransactionPin(
      context: context,
      transactionId: moveTransactionId,
      transactionType: 'move_money_transfer',
      amount: amountNaira,
      fee: _feeCalculation != null ? _feeCalculation!.totalFee / 100.0 : null,
      totalAmount:
          _feeCalculation != null ? _feeCalculation!.totalDebit / 100.0 : null,
      currency: 'NGN',
      title: 'Beam Money',
      message: 'Confirm Lazerbeam transfer of NGN ${amountNaira.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        final cubit = context.read<MoveMoneyCubit>();
        // The debit rail is derived LIVE from the source's mandate state —
        // never from a user toggle. Ready/active mandate → instant Direct
        // Debit; anything else → one-time DirectPay (the backend also
        // self-falls-back if a mandate debit errors mid-flight).
        final srcMandate = context
            .read<MandateCubit>()
            .getMandateForAccount(_sourceAccount!.id);
        final useDirectDebit = srcMandate != null &&
            (srcMandate.status == MandateStatus.readyToDebit ||
                srcMandate.status == MandateStatus.active);
        await cubit.initiateMoveTransfer(
          userId: authState.profile.userId,
          sourceLinkedAccountId: _sourceAccount!.id,
          destinationLinkedAccountId: _destinationAccount!.id,
          amount: amountKobo,
          narration: _narrationController.text.isNotEmpty
              ? _narrationController.text
              : null,
          verificationToken: token,
          transactionId: moveTransactionId,
          idempotencyKey: const Uuid().v4(),
          useDirectDebit: useDirectDebit,
        );
        postPinState = cubit.state;
        // Throwing here keeps the failure INSIDE the sheet (setFailed) —
        // the mixin renders the message and closes gracefully.
        if (postPinState is MoveMoneyError) {
          throw Exception((postPinState as MoveMoneyError).message);
        }
        if (postPinState is MoveMoneyNeedsReauth) {
          throw Exception((postPinState as MoveMoneyNeedsReauth).message);
        }
      },
    );

    if (!success) return;
    if (!mounted) return;

    final currentState = postPinState;
    if (currentState is MoveTransferInitiated) {
      if (currentState.requiresAuthorization &&
          currentState.paymentUrl != null &&
          currentState.paymentUrl!.isNotEmpty) {
        // No mandate — DirectPay fallback: open in-app WebView
        final authSuccess = await _handleDirectPayAuthorization(
          currentState.paymentUrl!,
        );

        if (authSuccess) {
          // Start polling transfer status
          context.read<MoveMoneyCubit>().startPollingTransferStatus(
            transferId: currentState.transfer.id,
            userId: authState.profile.userId,
          );
          Get.offNamed(AppRoutes.transferProof,
              arguments: _beamReceiptPayload(currentState.transfer));
        } else {
          Get.snackbar(
            'Authorization Cancelled',
            'Transfer may still be processing. Check transfer history for updates.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF1F1F1F),
            colorText: const Color(0xFFFB923C),
            duration: const Duration(seconds: 5),
            mainButton: TextButton(
              onPressed: () => Get.toNamed('/move-money/history'),
              child: Text(
                'View History',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
      } else {
        // Mandate active — transfer went through without WebView
        Get.offNamed(AppRoutes.transferProof,
            arguments: _beamReceiptPayload(currentState.transfer));
      }
    }
    // Error / reauth outcomes are rendered INSIDE the PIN sheet (the
    // onPinValidated callback throws) — nothing further to do here.
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final amountKobo = _parseAmountKobo();
    final canProceed = _sourceAccount != null &&
        _destinationAccount != null &&
        amountKobo >= _minAmountKobo &&
        amountKobo <= _maxAmountKobo &&
        _amountError == null &&
        !_isCalculatingFee;

    // Kick off the (non-blocking) success prediction after this frame so we
    // never emit a new cubit state mid-build. Guarded by destination key.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _maybeFetchPrediction();
    });

    return AppGradientBackground(
      child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Lazerbeam',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider<TransferPredictionCubit>.value(
        value: _predictionCubit,
        child: MultiBlocListener(
        listeners: [
          BlocListener<MoveMoneyCubit, MoveMoneyState>(
            listener: (context, state) {
              if (state is MoveMoneyFeeCalculated) {
                setState(() {
                  _feeCalculation = state.feeCalculation;
                  // Adopt the authoritative, admin-tunable bounds from the server
                  // so the client enforces/displays the SAME cap as the backend.
                  if (state.feeCalculation.minAmount > 0) {
                    _minAmountKobo = state.feeCalculation.minAmount;
                  }
                  if (state.feeCalculation.maxAmount > 0) {
                    _maxAmountKobo = state.feeCalculation.maxAmount;
                  }
                  _isCalculatingFee = false;
                });
              } else if (state is MoveMoneyFeeError) {
                setState(() {
                  _isCalculatingFee = false;
                  _feeCalculation = null;
                });
              } else if (state is MoveMoneyInsufficientFunds) {
                Get.snackbar(
                  'Insufficient Funds',
                  state.message,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF1F1F1F),
                  colorText: const Color(0xFFEF4444),
                  duration: const Duration(seconds: 5),
                  mainButton: TextButton(
                    onPressed: () {
                      if (_sourceAccount != null) {
                        final authState =
                            context.read<AuthenticationCubit>().state;
                        if (authState is AuthenticationSuccess) {
                          context.read<OpenBankingCubit>().refreshBalance(
                                accountId: _sourceAccount!.id,
                                userId: authState.profile.userId,
                                accessToken:
                                    authState.profile.session.accessToken,
                              );
                        }
                      }
                    },
                    child: Text(
                      'Refresh',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else if (state is MoveMoneyNeedsReauth) {
                // Mark source account as needing reauth in local state
                if (_sourceAccount != null &&
                    _sourceAccount!.id == state.accountId) {
                  setState(() {
                    _sourceAccount = _sourceAccount!.copyWith(
                      status: LinkedAccountStatus.reauthorize,
                    );
                  });
                }
                Get.snackbar(
                  'Re-link Required',
                  state.message,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF1F1F1F),
                  colorText: const Color(0xFFFB923C),
                  duration: const Duration(seconds: 5),
                  mainButton: TextButton(
                    onPressed: () {
                      if (_sourceAccount != null) {
                        _handleReauthorization(_sourceAccount!);
                      }
                    },
                    child: Text(
                      'Re-link',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else if (state is MoveMoneyMandateRequired) {
                _handleMandateRequired(state.accountId);
              } else if (state is MoveMoneyRateLimited) {
                // Temporarily disable the transfer button during rate limit
                setState(() => _isTransferInProgress = true);
                Future.delayed(state.retryAfter, () {
                  if (mounted) setState(() => _isTransferInProgress = false);
                });
                Get.snackbar(
                  'Please Wait',
                  'Too many requests. Try again in ${state.retryAfter.inSeconds} seconds.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF1F1F1F),
                  colorText: const Color(0xFFFB923C),
                  duration: state.retryAfter + const Duration(seconds: 1),
                );
              } else if (state is MoveMoneyTransferTimeout) {
                Get.snackbar(
                  'Transfer Processing',
                  state.message,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF1F1F1F),
                  colorText: const Color(0xFF3B82F6),
                  duration: const Duration(seconds: 6),
                  mainButton: TextButton(
                    onPressed: () => Get.toNamed('/move-money/history'),
                    child: Text(
                      'View History',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else if (state is MoveMoneyError) {
                if (isKYCRequiredError(state.errorCode) ||
                    isKYCRequiredError(state.message)) {
                  _showKYCRequiredSheet(context);
                } else {
                  // Page-contained + friendly: stays on the Beam flow's
                  // Scaffold (not over the dashboard once the flow pops) and
                  // never shows the raw server message.
                  _showPageError(state.message,
                      context: 'complete your transfer');
                }
              }
            },
          ),
          BlocListener<OpenBankingCubit, OpenBankingState>(
            listener: (context, state) async {
              // Auto-select newly linked account on the side that triggered linking
              if ((state is AccountLinked || state is AccountLinkedWithMandate) &&
                  _pendingLinkIsSource != null) {
                final account = state is AccountLinkedWithMandate
                    ? state.account
                    : (state as AccountLinked).account;
                setState(() {
                  if (_pendingLinkIsSource!) {
                    _sourceAccount = account;
                  } else {
                    _destinationAccount = account;
                  }
                  _pendingLinkIsSource = null;
                });
                // Refresh accounts list and mandates
                _loadAccounts();
                final authState = context.read<AuthenticationCubit>().state;
                if (authState is AuthenticationSuccess) {
                  context.read<MandateCubit>().fetchUserMandates(
                        userId: authState.profile.userId,
                      );
                }

                if (state is AccountLinkedWithMandate && state.mandateFailed) {
                  Get.snackbar(
                    'Direct Debit Pending',
                    'Account linked. Direct Debit setup will retry automatically.',
                    backgroundColor: const Color(0xFFFB923C),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              }
            },
          ),
          // Rebuild From/To cards when mandate data loads (for badge updates)
          BlocListener<MandateCubit, MandateState>(
            listener: (context, state) {
              if (state is UserMandatesLoaded ||
                  state is MandateCreated ||
                  state is MandatePaused ||
                  state is MandateReinstated ||
                  state is MandateCancelled) {
                setState(() {}); // Trigger rebuild so badges reflect new state
              } else if (state is MandateError) {
                // Page-contained + friendly: Direct Debit setup failures stay
                // on this flow, never the raw server message on the dashboard.
                _showPageError(state.message,
                    context: 'set up Direct Debit');
              }
            },
          ),
        ],
        child: BlocBuilder<OpenBankingCubit, OpenBankingState>(
          builder: (context, obState) {
            if (obState is OpenBankingLoading) {
              return const Center(
                child: LazerVaultLoader.small(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Reauth overlay for source account
                        if (_sourceAccount != null &&
                            _sourceAccount!.needsReauthorization)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: ReauthRequiredOverlay(
                              bankName: _sourceAccount!.bankName,
                              accountName: _sourceAccount!.accountName,
                              onReauthorize: () =>
                                  _handleReauthorization(_sourceAccount!),
                            ),
                          ),

                        // Mandate activating banner for source account
                        if (_sourceAccount != null &&
                            !_sourceAccount!.needsReauthorization) ...[
                          Builder(builder: (context) {
                            final mandate = context
                                .read<MandateCubit>()
                                .getMandateForAccount(_sourceAccount!.id);
                            if (mandate != null && mandate.isActivating) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: MandateActivatingBanner(
                                  mandate: mandate,
                                  bankName: _sourceAccount!.bankName,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                        ],

                        // From / swap / To – with drag-to-swap
                        _buildDraggableAccountPair(),
                        SizedBox(height: 16.h),

                        // Debit method — DirectPay (default) vs Direct Debit
                        _buildDebitModeToggle(),

                        // Amount input
                        _buildAmountInput(),
                        SizedBox(height: 16.h),

                        // Fee breakdown
                        if (_isCalculatingFee)
                          _buildCalculatingFees()
                        else if (_feeCalculation != null)
                          MoveFeeBreakdown(feeCalculation: _feeCalculation!)
                        else
                          BlocBuilder<MoveMoneyCubit, MoveMoneyState>(
                            buildWhen: (prev, curr) =>
                                curr is MoveMoneyFeeError,
                            builder: (context, state) {
                              if (state is MoveMoneyFeeError) {
                                return _buildFeeRetry(state);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        SizedBox(height: 16.h),

                        // Stale balance warning
                        Builder(builder: (context) {
                          final warning = _getBalanceWarning();
                          if (warning == null) return const SizedBox.shrink();
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: const Color(0xFFFB923C),
                                  size: 14.sp,
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    warning,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFFFB923C),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ),
                                // Inline refresh CTA — re-pulls the live balance
                                // from the linked bank (Mono) for this account.
                                GestureDetector(
                                  onTap: () {
                                    if (_sourceAccount == null) return;
                                    final authState = context
                                        .read<AuthenticationCubit>()
                                        .state;
                                    if (authState is AuthenticationSuccess) {
                                      context
                                          .read<OpenBankingCubit>()
                                          .refreshBalance(
                                            accountId: _sourceAccount!.id,
                                            userId: authState.profile.userId,
                                            accessToken: authState
                                                .profile.session.accessToken,
                                          );
                                      Get.snackbar(
                                        'Refreshing',
                                        'Updating balance from your bank...',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: const Color(0xFF1F1F1F),
                                        colorText: const Color(0xFFFB923C),
                                        duration: const Duration(seconds: 2),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.refresh_rounded,
                                        color: const Color(0xFFFB923C),
                                        size: 14.sp,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        'Refresh',
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFFFB923C),
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        // Narration
                        _buildNarrationInput(),

                        // Informational, READ-ONLY transfer success prediction
                        // (bank network + recipient trust). Shown BEFORE the
                        // PIN/Transfer action; never blocks or moves money.
                        if (_destinationAccount != null)
                          const TransferPredictionAlert(),

                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),

                // CTA button pinned at bottom
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                    child: BeamGradientButton(
                      label: 'Transfer',
                      icon: Icons.bolt_rounded,
                      enabled: canProceed,
                      isLoading: _isTransferInProgress,
                      onTap: _onMoveMoneyTap,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Draggable From / To pair with swap
  // ---------------------------------------------------------------------------

  Widget _buildDraggableAccountPair() {
    // Big rounded outer card holding the From / swap / To slots — the swap
    // screen's signature "exchange" card.
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BeamStyle.card(radius: 20),
      child: Column(
      children: [
        // FROM card – drag source + drop target
        _buildDraggableSlot(
          dragData: 'from',
          acceptData: 'to',
          isHovering: _isHoveringFrom,
          onHoverChanged: (h) => setState(() => _isHoveringFrom = h),
          child: _buildAccountCard(
            label: 'From',
            account: _sourceAccount,
            onTap: () => _showAccountPicker(isSource: true),
            highlight: _isHoveringFrom,
            showDragHandle: true,
          ),
          feedbackChild: _buildAccountCard(
            label: 'From',
            account: _sourceAccount,
            highlight: true,
            showDragHandle: true,
          ),
          ghostChild: _buildAccountCard(
            label: 'From',
            account: _sourceAccount,
            showDragHandle: true,
          ),
        ),
        // Swap button — purple gradient square, equal spacing above and below
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: BeamSwapButton(
            onTap: (_sourceAccount != null || _destinationAccount != null)
                ? _swapAccounts
                : null,
          ),
        ),
        // TO card – drag source + drop target
        _buildDraggableSlot(
          dragData: 'to',
          acceptData: 'from',
          isHovering: _isHoveringTo,
          onHoverChanged: (h) => setState(() => _isHoveringTo = h),
          child: _buildAccountCard(
            label: 'To',
            account: _destinationAccount,
            onTap: () => _showAccountPicker(isSource: false),
            highlight: _isHoveringTo,
            showDragHandle: true,
          ),
          feedbackChild: _buildAccountCard(
            label: 'To',
            account: _destinationAccount,
            highlight: true,
            showDragHandle: true,
          ),
          ghostChild: _buildAccountCard(
            label: 'To',
            account: _destinationAccount,
            showDragHandle: true,
          ),
        ),
      ],
    ),
    );
  }

  /// Builds a single draggable + drop-target slot for an account card.
  Widget _buildDraggableSlot({
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
        _swapAccounts();
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

  // ---------------------------------------------------------------------------
  // Account card
  // ---------------------------------------------------------------------------

  Widget _buildAccountCard({
    required String label,
    required LinkedBankAccount? account,
    VoidCallback? onTap,
    bool highlight = false,
    bool showDragHandle = false,
  }) {
    final mandate = account != null
        ? context.read<MandateCubit>().getMandateForAccount(account.id)
        : null;

    return GestureDetector(
      onTap: onTap,
      onLongPress: account != null
          ? () => _showMandateManagement(account, mandate)
          : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: BeamStyle.innerSurface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: highlight
                ? BeamStyle.purple
                : account != null
                    ? BeamStyle.purple.withValues(alpha: 0.35)
                    : Colors.white.withValues(alpha: 0.06),
            width: highlight ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Drag handle (visible grip lines)
            if (showDragHandle)
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Icon(
                  Icons.drag_indicator,
                  color: const Color(0xFF4B5563),
                  size: 20.sp,
                ),
              ),
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: account != null
                    ? const Color(0xFF10B981).withValues(alpha: 0.15)
                    : const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                account != null ? Icons.account_balance : Icons.add,
                color: account != null
                    ? const Color(0xFF10B981)
                    : const Color(0xFF3B82F6),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
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
                    Text(
                      account.bankName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${account.accountName}  ${account.displayAccountNumber}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    // REAL-TIME balance with explicit states: fetching →
                    // spinner copy; available → figure; failed → retry CTA.
                    // Selecting an account always triggers a fresh Mono read,
                    // so a figure shown here is never stale.
                    _buildTileBalance(account),
                    SizedBox(height: 2.h),
                    if (account.needsReauthorization)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Re-link required',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFEF4444),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    else
                      MandateStatusBadge(mandate: mandate),
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

  // ---------------------------------------------------------------------------
  // Amount input
  // ---------------------------------------------------------------------------

  Widget _buildAmountInput() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: _amountError != null
              ? const Color(0xFFEF4444).withValues(alpha: 0.6)
              : const Color(0xFF3B82F6).withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                'NGN',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                  ],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF4B5563),
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          if (_amountError != null) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: const Color(0xFFEF4444),
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    _amountError!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Fee loading indicator
  // ---------------------------------------------------------------------------

  Widget _buildCalculatingFees() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LazerVaultLoader.tiny(),
            SizedBox(width: 10.w),
            Text(
              'Calculating fees...',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Fee retry widget
  // ---------------------------------------------------------------------------

  Widget _buildFeeRetry(MoveMoneyFeeError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: GestureDetector(
          onTap: _isCalculatingFee
              ? null
              : () {
                  final amountKobo = _parseAmountKobo();
                  if (amountKobo > 0) {
                    setState(() => _isCalculatingFee = true);
                    context
                        .read<MoveMoneyCubit>()
                        .retryFeeCalculation(amountKobo);
                  }
                },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isCalculatingFee)
                LazerVaultLoader(size: 14)
              else
                Icon(
                  Icons.refresh_rounded,
                  color: const Color(0xFFFB923C),
                  size: 16.sp,
                ),
              SizedBox(width: 8.w),
              Text(
                _isCalculatingFee
                    ? 'Retrying...'
                    : state.retryCount >= 3
                        ? 'Fee unavailable. Tap to retry.'
                        : 'Failed to calculate fees. Tap to retry.',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFB923C),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Narration input
  // ---------------------------------------------------------------------------

  Widget _buildNarrationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Narration (optional)',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _narrationController,
          maxLines: 2,
          maxLength: 100,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: 'Add a note for this transfer',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide:
                  const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
            ),
            counterStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Account picker bottom sheet (search + list + "Link New Account")
// =============================================================================

class _AccountPickerSheet extends StatefulWidget {
  final List<LinkedBankAccount> accounts;
  final String? selectedId;
  final String? excludeId;
  final String title;
  final ValueChanged<LinkedBankAccount> onSelected;
  final VoidCallback onAddAccount;

  const _AccountPickerSheet({
    required this.accounts,
    this.selectedId,
    this.excludeId,
    required this.title,
    required this.onSelected,
    required this.onAddAccount,
  });

  @override
  State<_AccountPickerSheet> createState() => _AccountPickerSheetState();
}

class _AccountPickerSheetState extends State<_AccountPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LinkedBankAccount> get _filtered {
    var list = widget.accounts;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list
          .where((a) =>
              a.bankName.toLowerCase().contains(q) ||
              a.accountName.toLowerCase().contains(q) ||
              a.accountNumber.contains(q))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header + search
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search bank or account...',
                      hintStyle: GoogleFonts.inter(
                          color: const Color(0xFF6B7280)),
                      prefixIcon: const Icon(Icons.search,
                          color: Color(0xFF6B7280)),
                      filled: true,
                      fillColor: const Color(0xFF0A0A0A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ],
              ),
            ),

            // Account list + "Link New Account"
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _filtered.length + 1,
                itemBuilder: (context, index) {
                  // "Link New Account" pinned at the top
                  if (index == 0) {
                    return ListTile(
                      onTap: widget.onAddAccount,
                      leading: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(Icons.add,
                            color: const Color(0xFF3B82F6),
                            size: 22.sp),
                      ),
                      title: Text(
                        'Link New Account',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Connect a bank account via Mono',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }

                  final account = _filtered[index - 1];
                  final isSelected = account.id == widget.selectedId;
                  final isExcluded = account.id == widget.excludeId;

                  final needsReauth = account.needsReauthorization;

                  return ListTile(
                    enabled: !isExcluded && account.isActive && !needsReauth,
                    onTap: (isExcluded || !account.isActive || needsReauth)
                        ? null
                        : () => widget.onSelected(account),
                    leading: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF10B981)
                                .withValues(alpha: 0.15)
                            : const Color(0xFF3B82F6)
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.account_balance,
                        color: isSelected
                            ? const Color(0xFF10B981)
                            : const Color(0xFF60A5FA),
                        size: 20.sp,
                      ),
                    ),
                    title: Text(
                      account.bankName,
                      style: GoogleFonts.inter(
                        color: isExcluded
                            ? const Color(0xFF6B7280)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${account.accountName}  ${account.displayAccountNumber}',
                      style: GoogleFonts.inter(
                        color: isExcluded
                            ? const Color(0xFF4B5563)
                            : const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle,
                            color: const Color(0xFF10B981), size: 20.sp)
                        : needsReauth
                            ? Text('Re-link',
                                style: GoogleFonts.inter(
                                    color: const Color(0xFFFB923C),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600))
                            : isExcluded
                                ? Text('In use',
                                    style: GoogleFonts.inter(
                                        color: const Color(0xFF6B7280),
                                        fontSize: 12.sp))
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
