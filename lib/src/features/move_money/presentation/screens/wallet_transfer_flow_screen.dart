import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:uuid/uuid.dart';

import '../../cubit/wallet_transfer_cubit.dart';
import '../../cubit/wallet_transfer_state.dart';

class WalletTransferFlowScreen extends StatefulWidget {
  const WalletTransferFlowScreen({super.key});

  @override
  State<WalletTransferFlowScreen> createState() =>
      _WalletTransferFlowScreenState();
}

class _WalletTransferFlowScreenState extends State<WalletTransferFlowScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Flow: 0=select accounts, 1=enter amount, 2=review
  int _currentStep = 0;
  AccountSummaryEntity? _sourceAccount;
  AccountSummaryEntity? _destinationAccount;

  // Amount validation
  static const double _minAmount = 100.0;
  static const double _maxAmount = 5000000.0;

  // Drag-to-swap visual state
  bool _isHoveringFrom = false;
  bool _isHoveringTo = false;

  @override
  void initState() {
    super.initState();
    // Ensure accounts are loaded (may be a fresh cubit from route)
    final cubit = context.read<AccountCardsSummaryCubit>();
    if (cubit.currentSummaries.isEmpty) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        cubit.fetchAccountSummaries(
          userId: authState.profile.userId,
          accessToken: authState.profile.session.accessToken,
        );
      }
    }

    // Accept pre-selected accounts from route arguments
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final source = args['sourceAccount'];
      final dest = args['destinationAccount'];
      if (source is AccountSummaryEntity && dest is AccountSummaryEntity) {
        _sourceAccount = source;
        _destinationAccount = dest;
        _currentStep = 1; // Skip to amount entry
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<AccountSummaryEntity> get _accounts {
    final state = context.read<AccountCardsSummaryCubit>().state;
    return switch (state) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => <AccountSummaryEntity>[],
    };
  }

  double? get _parsedAmount {
    final text = _amountController.text.replaceAll(',', '');
    return double.tryParse(text);
  }

  String? get _amountError {
    final amount = _parsedAmount;
    if (amount == null || amount == 0) return null;
    if (amount < _minAmount) {
      return 'Minimum amount is ${_formatCurrency(
        _minAmount, _sourceAccount?.currency ?? 'NGN')}';
    }
    if (amount > _maxAmount) {
      return 'Maximum amount is ${_formatCurrency(
        _maxAmount, _sourceAccount?.currency ?? 'NGN')}';
    }
    if (_sourceAccount != null && amount > _sourceAccount!.balance) {
      return 'Insufficient balance (${_formatCurrency(
        _sourceAccount!.balance, _sourceAccount!.currency)})';
    }
    return null;
  }

  bool get _isAmountValid {
    final amount = _parsedAmount;
    if (amount == null || amount < _minAmount || amount > _maxAmount) {
      return false;
    }
    if (_sourceAccount != null && amount > _sourceAccount!.balance) {
      return false;
    }
    return true;
  }

  bool get _isSameCurrency {
    if (_sourceAccount == null || _destinationAccount == null) return true;
    return _sourceAccount!.currency == _destinationAccount!.currency;
  }

  String _formatNumber(double value) {
    return NumberFormat('#,##0', 'en_NG').format(value);
  }

  String _formatCurrency(double value, String currency) {
    return '$currency ${NumberFormat('#,##0.00', 'en_NG').format(value)}';
  }

  String _accountDisplayLabel(AccountSummaryEntity account) {
    final label = account.displayName;
    final last4 = account.accountNumberLast4;
    return '$label •••• $last4';
  }

  void _goToAmount() {
    if (_sourceAccount != null && _destinationAccount != null) {
      if (_sourceAccount!.id == _destinationAccount!.id) {
        Get.snackbar(
          'Same Account',
          'Source and destination cannot be the same account.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
        return;
      }
      if (!_isSameCurrency) {
        Get.snackbar(
          'Different Currencies',
          'Cross-currency transfers are not yet supported. '
              'Both accounts must use the same currency.',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }
      setState(() => _currentStep = 1);
    }
  }

  void _goToReview() {
    if (_isAmountValid) {
      setState(() => _currentStep = 2);
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Get.back();
    }
  }

  Future<void> _confirmTransfer() async {
    final source = _sourceAccount;
    final destination = _destinationAccount;
    final amount = _parsedAmount;
    if (source == null || destination == null || amount == null) return;

    final transactionId = const Uuid().v4();
    final description = _descriptionController.text.trim().isNotEmpty
        ? _descriptionController.text.trim()
        : 'Transfer from ${source.displayName} to ${destination.displayName}';

    // Use accountNumber if available, otherwise use account id
    final toAccountNumber = destination.accountNumber ?? destination.id;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'transfer',
      amount: amount,
      currency: source.currency.isNotEmpty ? source.currency : 'NGN',
      title: 'Confirm Transfer',
      message:
          'Move ${_formatCurrency(amount, source.currency)} from '
          '${source.displayName} to ${destination.displayName}?',
      onPinValidated: (verificationToken) async {
        context.read<WalletTransferCubit>().transferBetweenAccounts(
              fromAccountId: source.id,
              toAccountNumber: toAccountNumber,
              amount: amount,
              description: description,
              transactionId: transactionId,
              verificationToken: verificationToken,
              sourceAccountName: _accountDisplayLabel(source),
              destinationAccountName: _accountDisplayLabel(destination),
              currency: source.currency,
            );

        // Wait for cubit result
        await for (final state
            in context.read<WalletTransferCubit>().stream) {
          if (state is WalletTransferSuccess) {
            pinModalKey.currentState?.setSuccess();
            await Future.delayed(const Duration(milliseconds: 1200));
            if (mounted) {
              try {
                Navigator.of(context).pop();
              } catch (_) {}
            }
            Get.offNamed(
              AppRoutes.walletTransferReceipt,
              arguments: {
                'sourceAccount': state.sourceAccountName,
                'destinationAccount': state.destinationAccountName,
                'amount': state.amount,
                'currency': state.currency,
                'reference': state.reference ?? '',
                'transferId': state.transferId ?? '',
                'newBalance': state.newBalance,
              },
            );
            break;
          } else if (state is WalletTransferError) {
            throw Exception(state.message);
          }
        }
      },
    );

    if (!success && mounted) {
      context.read<WalletTransferCubit>().reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _goBack,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          _currentStep == 0
              ? 'Select Accounts'
              : _currentStep == 1
                  ? 'Enter Amount'
                  : 'Review Transfer',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<WalletTransferCubit, WalletTransferState>(
          listener: (context, state) {
            if (state is WalletTransferError && _currentStep < 2) {
              Get.snackbar('Error', state.message,
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white);
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _currentStep == 0
                ? _buildAccountSelectionStep()
                : _currentStep == 1
                    ? _buildAmountStep()
                    : _buildReviewStep(),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 0: Select source and destination accounts
  // ---------------------------------------------------------------------------

  Widget _buildAccountSelectionStep() {
    final accounts = _accounts;

    if (accounts.length < 2) {
      return _buildNotEnoughAccounts();
    }

    return Column(
      key: const ValueKey('accounts'),
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Free transfer badge
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: const Color(0xFF10B981), size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Instant & free — no fees',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Draggable From / To account pair
                _buildDraggableAccountPair(accounts),

                // Currency mismatch warning
                if (!_isSameCurrency) ...[
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color:
                              const Color(0xFFFB923C).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: const Color(0xFFFB923C), size: 20.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Cross-currency transfers are not yet supported.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFB923C),
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // Continue button
        Padding(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _sourceAccount != null &&
                      _destinationAccount != null &&
                      _isSameCurrency &&
                      _sourceAccount!.id != _destinationAccount!.id
                  ? _goToAmount
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Draggable From / To pair with swap
  // ---------------------------------------------------------------------------

  void _swapAccounts() {
    if (_sourceAccount == null && _destinationAccount == null) return;
    setState(() {
      final temp = _sourceAccount;
      _sourceAccount = _destinationAccount;
      _destinationAccount = temp;
      _amountController.clear();
    });
  }

  Widget _buildDraggableAccountPair(List<AccountSummaryEntity> accounts) {
    return Column(
      children: [
        // FROM card — drag source + drop target
        _buildDraggableSlot(
          dragData: 'from',
          acceptData: 'to',
          isHovering: _isHoveringFrom,
          onHoverChanged: (h) => setState(() => _isHoveringFrom = h),
          child: _buildDraggableAccountCard(
            label: 'From',
            account: _sourceAccount,
            onTap: () => _showAccountPicker(
              accounts: accounts,
              excludeId: _destinationAccount?.id,
              onSelected: (account) {
                setState(() {
                  _sourceAccount = account;
                  _amountController.clear();
                });
              },
            ),
            highlight: _isHoveringFrom,
          ),
          feedbackChild: _buildDraggableAccountCard(
            label: 'From',
            account: _sourceAccount,
            highlight: true,
          ),
          ghostChild: _buildDraggableAccountCard(
            label: 'From',
            account: _sourceAccount,
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
        // TO card — drag source + drop target
        _buildDraggableSlot(
          dragData: 'to',
          acceptData: 'from',
          isHovering: _isHoveringTo,
          onHoverChanged: (h) => setState(() => _isHoveringTo = h),
          child: _buildDraggableAccountCard(
            label: 'To',
            account: _destinationAccount,
            onTap: () => _showAccountPicker(
              accounts: accounts,
              excludeId: _sourceAccount?.id,
              onSelected: (account) {
                setState(() => _destinationAccount = account);
              },
            ),
            highlight: _isHoveringTo,
          ),
          feedbackChild: _buildDraggableAccountCard(
            label: 'To',
            account: _destinationAccount,
            highlight: true,
          ),
          ghostChild: _buildDraggableAccountCard(
            label: 'To',
            account: _destinationAccount,
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
              width: MediaQuery.of(context).size.width - 40.w,
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

  Widget _buildDraggableAccountCard({
    required String label,
    required AccountSummaryEntity? account,
    VoidCallback? onTap,
    bool highlight = false,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.5)
                    : const Color(0xFF2D2D2D),
            width: highlight ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Drag handle
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Icon(
                Icons.drag_indicator,
                color: const Color(0xFF4B5563),
                size: 20.sp,
              ),
            ),
            if (account != null)
              _buildAccountIcon(account)
            else
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.add,
                    color: const Color(0xFF3B82F6), size: 20.sp),
              ),
            SizedBox(width: 12.w),
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
                      _accountDisplayLabel(account),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _formatCurrency(account.balance, account.currency),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
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

  Widget _buildAccountIcon(AccountSummaryEntity account) {
    final type = account.accountTypeEnum;
    final IconData icon;
    final Color color;
    switch (type) {
      case VirtualAccountType.savings:
        icon = Icons.savings_outlined;
        color = const Color(0xFF10B981);
      case VirtualAccountType.investment:
        icon = Icons.trending_up_rounded;
        color = const Color(0xFFFB923C);
      case VirtualAccountType.family:
        icon = Icons.family_restroom_rounded;
        color = const Color(0xFFA78BFA);
      case VirtualAccountType.usd:
      case VirtualAccountType.gbp:
      case VirtualAccountType.eur:
        icon = Icons.currency_exchange_rounded;
        color = const Color(0xFF60A5FA);
      case VirtualAccountType.business:
        icon = Icons.business_rounded;
        color = const Color(0xFFFBBF24);
      default:
        icon = Icons.account_balance_wallet_outlined;
        color = const Color(0xFF3B82F6);
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }

  void _showAccountPicker({
    required List<AccountSummaryEntity> accounts,
    required String? excludeId,
    required ValueChanged<AccountSummaryEntity> onSelected,
  }) {
    final filtered =
        accounts.where((a) => a.id != excludeId).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Select Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              ...filtered.map((account) => ListTile(
                    leading: _buildAccountIcon(account),
                    title: Text(
                      _accountDisplayLabel(account),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      _formatCurrency(account.balance, account.currency),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                    trailing: account.isPrimary
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'Primary',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF3B82F6),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      onSelected(account);
                    },
                  )),
              if (filtered.isEmpty)
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'No other accounts available',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotEnoughAccounts() {
    return Center(
      key: const ValueKey('not-enough'),
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined,
                size: 64.sp, color: const Color(0xFF374151)),
            SizedBox(height: 20.h),
            Text(
              'Need At Least 2 Accounts',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'You need at least two LazerVault accounts to '
              'transfer between them. Create another account first.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 28.h),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Go Back',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step 1: Enter amount
  // ---------------------------------------------------------------------------

  Widget _buildAmountStep() {
    final source = _sourceAccount!;
    final destination = _destinationAccount!;
    final error = _amountError;

    return Column(
      key: const ValueKey('amount'),
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Transfer summary
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Row(
                    children: [
                      _buildAccountIcon(source),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              source.displayName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _formatCurrency(
                                  source.balance, source.currency),
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_rounded,
                          color: const Color(0xFF3B82F6), size: 20.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              destination.displayName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              _formatCurrency(destination.balance,
                                  destination.currency),
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _buildAccountIcon(destination),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Free transfer badge
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline,
                          color: const Color(0xFF10B981), size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Free transfer — no fees',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Amount label
                Text(
                  'Amount (${source.currency})',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),

                // Amount input
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    prefixText: '${source.currency} ',
                    prefixStyle: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: '0',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF374151),
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 20.h),
                    errorText: error,
                    errorStyle: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 12.sp,
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 8.h),

                // Available balance hint
                Text(
                  'Available: ${_formatCurrency(source.balance, source.currency)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 12.h),

                // Quick amount chips
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: [5000, 10000, 20000, 50000].map((amount) {
                    final enabled = amount <= source.balance;
                    return GestureDetector(
                      onTap: enabled
                          ? () {
                              _amountController.text = amount.toString();
                              setState(() {});
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: enabled
                              ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                              : const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: enabled
                                ? const Color(0xFF3B82F6).withValues(alpha: 0.4)
                                : const Color(0xFF2D2D2D),
                          ),
                        ),
                        child: Text(
                          '${source.currency} ${_formatNumber(amount.toDouble())}',
                          style: GoogleFonts.inter(
                            color: enabled
                                ? const Color(0xFF60A5FA)
                                : const Color(0xFF374151),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24.h),

                // Description (optional)
                Text(
                  'Description (optional)',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: _descriptionController,
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: 'What is this for?',
                    hintStyle:
                        GoogleFonts.inter(color: const Color(0xFF6B7280)),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    counterStyle: GoogleFonts.inter(
                        color: const Color(0xFF6B7280), fontSize: 11.sp),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Continue button
        Padding(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _isAmountValid ? _goToReview : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor:
                    const Color(0xFF3B82F6).withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2: Review & confirm
  // ---------------------------------------------------------------------------

  Widget _buildReviewStep() {
    final source = _sourceAccount!;
    final destination = _destinationAccount!;
    final amount = _parsedAmount!;
    final description = _descriptionController.text.trim().isNotEmpty
        ? _descriptionController.text.trim()
        : 'Transfer from ${source.displayName} to ${destination.displayName}';

    return Column(
      key: const ValueKey('review'),
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // Amount display
                SizedBox(height: 16.h),
                Text(
                  _formatCurrency(amount, source.currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),

                // Free transfer badge
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Free transfer',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 28.h),

                // Details card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Column(
                    children: [
                      _buildReviewRow(
                          'From', _accountDisplayLabel(source)),
                      _buildReviewDivider(),
                      _buildReviewRow(
                          'To', _accountDisplayLabel(destination)),
                      _buildReviewDivider(),
                      _buildReviewRow('Amount',
                          _formatCurrency(amount, source.currency)),
                      _buildReviewDivider(),
                      _buildReviewRow(
                        'Fee',
                        _formatCurrency(0, source.currency),
                        valueColor: const Color(0xFF10B981),
                      ),
                      _buildReviewDivider(),
                      _buildReviewRow(
                        'Total',
                        _formatCurrency(amount, source.currency),
                        isBold: true,
                      ),
                      if (description.isNotEmpty) ...[
                        _buildReviewDivider(),
                        _buildReviewRow('Description', description),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Confirm button
        Padding(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _confirmTransfer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Confirm Transfer',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: 13.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewDivider() {
    return Divider(color: const Color(0xFF2D2D2D), height: 1.h);
  }
}
