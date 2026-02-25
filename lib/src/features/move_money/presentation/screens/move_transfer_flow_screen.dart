import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_authorization_sheet.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:uuid/uuid.dart';

import '../../cubit/mandate_cubit.dart';
import '../../cubit/mandate_state.dart';
import '../../cubit/move_money_cubit.dart';
import '../../cubit/move_money_state.dart';
import '../../domain/entities/mandate_entity.dart';
import '../../domain/entities/move_fee_calculation.dart';
import '../widgets/mandate_management_bottomsheet.dart';
import '../widgets/mandate_setup_bottomsheet.dart';
import '../widgets/mandate_status_badge.dart';
import '../widgets/move_fee_breakdown.dart';

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
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  // Backend constants (kobo)
  static const int _minAmountKobo = 150000; // NGN 1,500
  static const int _maxAmountKobo = 500000000; // NGN 5,000,000

  LinkedBankAccount? _sourceAccount;
  LinkedBankAccount? _destinationAccount;
  final _amountController = TextEditingController();
  final _narrationController = TextEditingController();
  MoveFeeCalculation? _feeCalculation;
  bool _isCalculatingFee = false;
  bool _isTransferInProgress = false;
  String? _amountError;

  // Drag-to-swap visual state
  bool _isHoveringFrom = false;
  bool _isHoveringTo = false;

  // Track which side triggered "Link New Account" so we can auto-select it
  bool? _pendingLinkIsSource;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
    _amountController.addListener(_onAmountChanged);
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
  }

  @override
  void dispose() {
    _amountController.dispose();
    _narrationController.dispose();
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
    });
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
      // BlocListener<OpenBankingCubit> in build() detects AccountLinked
      // and offers mandate setup
      context.read<OpenBankingCubit>().linkAccount(
            userId: user.id,
            code: result.code,
            accessToken: authState.profile.session.accessToken,
          );
      context.read<OpenBankingCubit>().fetchLinkedAccounts(
            userId: authState.profile.userId,
            accessToken: authState.profile.session.accessToken,
          );
    }
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
  Future<bool> _handleDirectPayAuthorization(
    String paymentUrl,
    String paymentId,
  ) async {
    final result = await showDirectPayAuthorizationSheet(
      context: context,
      paymentUrl: paymentUrl,
      paymentId: paymentId,
      redirectScheme: 'lazervault',
      redirectPath: '/move-money/callback',
    );
    return result.success;
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

    await validateTransactionPin(
      context: context,
      transactionId: moveTransactionId,
      transactionType: 'move_money_transfer',
      amount: amountNaira,
      currency: 'NGN',
      fee: _feeCalculation?.totalFeeNaira,
      totalAmount: _feeCalculation?.totalDebitNaira ?? amountNaira,
      onPinValidated: (verificationToken) async {
        pinModalKey.currentState?.setProcessing();

        final authState = context.read<AuthenticationCubit>().state;
        if (authState is! AuthenticationSuccess) {
          throw Exception('Authentication required');
        }

        final cubit = context.read<MoveMoneyCubit>();
        await cubit.initiateMoveTransfer(
          userId: authState.profile.userId,
          sourceLinkedAccountId: _sourceAccount!.id,
          destinationLinkedAccountId: _destinationAccount!.id,
          amount: amountKobo,
          narration: _narrationController.text.isNotEmpty
              ? _narrationController.text
              : null,
          verificationToken: verificationToken,
          transactionId: moveTransactionId,
          idempotencyKey: const Uuid().v4(),
        );

        final currentState = cubit.state;
        if (currentState is MoveTransferInitiated) {
          if (currentState.requiresAuthorization &&
              currentState.paymentUrl != null &&
              currentState.paymentUrl!.isNotEmpty) {
            // No mandate — DirectPay fallback: open bank authorization WebView
            pinModalKey.currentState?.setProcessing();
            if (mounted) Navigator.of(context).pop(); // Close PIN modal

            final authSuccess = await _handleDirectPayAuthorization(
              currentState.paymentUrl!,
              currentState.transfer.paymentId ?? currentState.transfer.id,
            );

            if (authSuccess) {
              Get.snackbar(
                'Authorization Successful',
                'Your transfer is being processed.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: const Color(0xFF10B981),
              );
              Get.offNamed('/move-money/receipt',
                  arguments: currentState.transfer);
            } else {
              Get.snackbar(
                'Authorization Required',
                'Bank authorization was cancelled. Please try again.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: const Color(0xFFFB923C),
              );
            }
          } else {
            // Mandate active — transfer went through without WebView
            pinModalKey.currentState?.setSuccess();
            await Future.delayed(const Duration(milliseconds: 800));
            if (mounted) Navigator.of(context).pop();
            Get.offNamed('/move-money/receipt',
                arguments: currentState.transfer);
          }
        } else if (currentState is MoveMoneyError) {
          throw Exception(currentState.message);
        }
      },
    );
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
          BlocListener<MoveMoneyCubit, MoveMoneyState>(
            listener: (context, state) {
              if (state is MoveMoneyFeeCalculated) {
                setState(() {
                  _feeCalculation = state.feeCalculation;
                  _isCalculatingFee = false;
                });
              }
            },
          ),
          BlocListener<OpenBankingCubit, OpenBankingState>(
            listener: (context, state) async {
              // Auto-select newly linked account on the side that triggered linking
              if (state is AccountLinked && _pendingLinkIsSource != null) {
                final account = state.account;
                setState(() {
                  if (_pendingLinkIsSource!) {
                    _sourceAccount = account;
                  } else {
                    _destinationAccount = account;
                  }
                  _pendingLinkIsSource = null;
                });
                // Refresh accounts list
                _loadAccounts();

                // Offer mandate setup for newly linked account
                final authState = context.read<AuthenticationCubit>().state;
                if (authState is AuthenticationSuccess) {
                  final mandateCubit = context.read<MandateCubit>();
                  final user = authState.profile.user;
                  await showMandateSetupBottomSheet(
                    context: context,
                    linkedAccountId: account.id,
                    userId: authState.profile.userId,
                    bankName: account.bankName,
                    accountName: account.accountName,
                    userEmail: user.email,
                    userName: '${user.firstName} ${user.lastName}'.trim(),
                    userPhone: user.phoneNumber,
                  );
                  mandateCubit.fetchUserMandates(
                    userId: authState.profile.userId,
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
              }
            },
          ),
        ],
        child: BlocBuilder<OpenBankingCubit, OpenBankingState>(
          builder: (context, obState) {
            if (obState is OpenBankingLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
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
                        // From / swap / To – with drag-to-swap
                        _buildDraggableAccountPair(),
                        SizedBox(height: 20.h),

                        // Amount input
                        _buildAmountInput(),
                        SizedBox(height: 16.h),

                        // Fee breakdown
                        if (_isCalculatingFee)
                          _buildCalculatingFees()
                        else if (_feeCalculation != null)
                          MoveFeeBreakdown(feeCalculation: _feeCalculation!),
                        SizedBox(height: 16.h),

                        // Narration
                        _buildNarrationInput(),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),

                // CTA button pinned at bottom
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: canProceed ? _onMoveMoneyTap : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          disabledBackgroundColor:
                              const Color(0xFF10B981).withValues(alpha: 0.3),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Move Money',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Draggable From / To pair with swap
  // ---------------------------------------------------------------------------

  Widget _buildDraggableAccountPair() {
    return Column(
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
        // Swap button — equal spacing above and below
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: GestureDetector(
            onTap: (_sourceAccount != null || _destinationAccount != null)
                ? _swapAccounts
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
                    (_sourceAccount != null || _destinationAccount != null)
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF6B7280),
                size: 22.sp,
              ),
            ),
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
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: highlight
                ? const Color(0xFF3B82F6)
                : account != null
                    ? const Color(0xFF10B981).withValues(alpha: 0.4)
                    : const Color(0xFF2D2D2D),
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
            SizedBox(
              width: 16.w,
              height: 16.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF3B82F6),
              ),
            ),
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
                  // "Link New Account" at end
                  if (index == _filtered.length) {
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

                  final account = _filtered[index];
                  final isSelected = account.id == widget.selectedId;
                  final isExcluded = account.id == widget.excludeId;

                  return ListTile(
                    enabled: !isExcluded && account.isActive,
                    onTap: (isExcluded || !account.isActive)
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
