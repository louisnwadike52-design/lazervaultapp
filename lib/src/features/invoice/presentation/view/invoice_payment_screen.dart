import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/entities/invoice_fee_quote.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart' show AuthenticationSuccess;
import '../notifiers/invoice_refresh_notifier.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class InvoicePaymentScreen extends StatefulWidget {
  final Invoice? invoice;
  final double serviceFee;
  final bool isPrePayment;

  const InvoicePaymentScreen({
    super.key,
    this.invoice,
    this.serviceFee = 0.0,
    this.isPrePayment = false,
  });

  @override
  State<InvoicePaymentScreen> createState() => _InvoicePaymentScreenState();
}

class _InvoicePaymentScreenState extends State<InvoicePaymentScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String _selectedAccountId = '';
  String _selectedPaymentMethod = '';
  bool _isProcessingPayment = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Service fee resolved by the backend (admin base fee, FX-converted into the
  // active account's currency). Falls back to the constructor value until loaded.
  InvoiceFeeQuote? _feeQuote;
  double get _fee => _feeQuote?.amount ?? widget.serviceFee;

  // The fee (and the active wallet balance) are denominated in the account
  // currency, which the fee quote reports.
  String get _feeCurrencySymbol =>
      _getCurrencySymbol(_feeQuote?.currency ?? widget.invoice?.currency ?? 'NGN');
  String get _feeCurrencyCode => _feeQuote?.currency ?? widget.invoice?.currency ?? 'NGN';

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN': return '\u20a6';
      case 'GBP': return '\u00a3';
      case 'EUR': return '\u20ac';
      case 'ZAR': return 'R';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      case 'INR': return '\u20b9';
      case 'JPY': return '\u00a5';
      case 'USD': return '\$';
      default: return '₦';
    }
  }

  IconData _getAccountIcon(String accountType) {
    final type = accountType.toLowerCase();
    if (type.contains('savings')) return Icons.savings;
    if (type.contains('investment')) return Icons.trending_up;
    if (type.contains('family')) return Icons.family_restroom;
    return Icons.account_balance_wallet;
  }

  Color _getAccountColor(String accountType) {
    final type = accountType.toLowerCase();
    if (type.contains('savings')) return Colors.green;
    if (type.contains('investment')) return Colors.purple;
    if (type.contains('family')) return Colors.orange;
    return Colors.blue;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _fetchAccounts();
    _loadFeeQuote();
  }

  /// True when the quote could not be fetched after retries. Drives the
  /// "tap to retry" affordance — WITHOUT this, a null quote left the button
  /// saying "Loading fee…" forever with no way out (observed live on prod:
  /// a hung fee call stranded the unlock screen until auto-logout fired).
  bool _feeQuoteFailed = false;

  Future<void> _loadFeeQuote() async {
    if (mounted && _feeQuoteFailed) setState(() => _feeQuoteFailed = false);
    // Retry with a hard timeout per attempt. The fee is the price the user is
    // consenting to — a screen that can neither show it nor recover is a dead
    // end on a money path.
    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        final quote = await context
            .read<InvoiceCubit>()
            .getServiceFeeQuote()
            .timeout(const Duration(seconds: 10));
        if (!mounted) return;
        if (quote != null) {
          setState(() => _feeQuote = quote);
          return;
        }
      } catch (_) {/* timeout or transport — retry below */}
      if (!mounted) return;
      await Future.delayed(Duration(seconds: 1 + attempt));
      if (!mounted) return;
    }
    if (mounted) setState(() => _feeQuoteFailed = true);
  }

  void _fetchAccounts() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: authState.profile.userId,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceCubit, InvoiceState>(
      listener: (context, state) {
        if (state is InvoiceServiceFeePaid) {
          setState(() => _isProcessingPayment = false);
          Get.offNamed(AppRoutes.createInvoice, arguments: {'serviceFeeRef': state.serviceFeeRef});
        } else if (state is InvoiceUnlockSuccess) {
          setState(() => _isProcessingPayment = false);
          // Notify the shared notifier so the home screen reloads on return
          GetIt.I<InvoiceRefreshNotifier>().notifyRefresh();
          Get.offNamed(AppRoutes.invoiceProcessing, arguments: state.invoice ?? widget.invoice);
        } else if (state is InvoiceError) {
          setState(() => _isProcessingPayment = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: InvoiceThemeColors.primaryBackground,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildServiceDetails(),
                        SizedBox(height: 24.h),
                        _buildPaymentMethods(),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                _buildPaymentButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isPrePayment ? 'Service Fee' : 'Pay Invoice',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.isPrePayment ? 'Pay service fee to create an invoice' : 'Complete your payment securely',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Color(0xFF10B981).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Secure',
              style: GoogleFonts.inter(
                color: Color(0xFF10B981),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3B82F6).withValues(alpha: 0.1),
            Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lazervault Invoice Service',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Professional invoice generation & management',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _feeQuote == null ? '$_feeCurrencySymbol…' : '$_feeCurrencySymbol${_fee.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Color(0xFF3B82F6),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Premium Features Included:',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _buildFeatureItem('PDF Download & Export'),
          _buildFeatureItem('QR Code Generation & Sharing'),
          _buildFeatureItem('Email & SMS Distribution'),
          _buildFeatureItem('Payment Tracking & Reminders'),
          _buildFeatureItem('Professional Templates'),
          _buildFeatureItem('Analytics & Reporting'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF10B981),
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            feature,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Payment Method',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        // Invoice service fee is always paid from the active LazerVault wallet.
        // Crypto and other payment methods are intentionally not offered here.
        _buildWalletPaymentCard(),
      ],
    );
  }

  // --- LazerVault Wallet ---

  Widget _buildWalletPaymentCard() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        List<AccountSummaryEntity> accounts = [];
        if (state is AccountCardsSummaryLoaded) {
          accounts = state.accountSummaries;
        } else if (state is AccountBalanceUpdated) {
          accounts = state.accountSummaries;
        }

        if (state is AccountCardsSummaryLoading) {
          return _buildPaymentCategoryCard(
            isSelected: false,
            icon: Icons.account_balance_wallet,
            iconColor: Colors.blue,
            title: 'Pay with Lazervault Wallet',
            subtitle: 'Loading wallets...',
            trailing: LazerVaultLoader.tiny(),
            onTap: null,
            onChangeTap: null,
          );
        }

        if (accounts.isEmpty) {
          return _buildPaymentCategoryCard(
            isSelected: false,
            icon: Icons.account_balance_wallet,
            iconColor: Colors.blue,
            title: 'Pay with Lazervault Wallet',
            subtitle: 'No wallets available',
            trailing: null,
            onTap: null,
            onChangeTap: null,
          );
        }

        // Always pay from the ACTIVE dashboard wallet — auto-filled and
        // non-changeable (no account picker / no "Change" action).
        final activeId =
            GetIt.I<AccountManager>().activeAccountId ?? _selectedAccountId;
        AccountSummaryEntity displayAccount = accounts.first;
        final match = accounts.where((a) => a.id == activeId);
        if (match.isNotEmpty) displayAccount = match.first;

        // Auto-select this wallet as the payment method. Safe to assign during
        // build — no rebuild is needed; these feed the same build pass and the
        // confirm/pay handler reads them.
        _selectedAccountId = displayAccount.id;
        _selectedPaymentMethod = 'account_${displayAccount.id}';

        final hasEnough = displayAccount.availableBalance >= _fee;

        return _buildPaymentCategoryCard(
          isSelected: true,
          icon: _getAccountIcon(displayAccount.accountType),
          iconColor: _getAccountColor(displayAccount.accountType),
          title: 'Pay with Lazervault Wallet',
          subtitle: '${displayAccount.accountType} Account  •  ${_getCurrencySymbol(displayAccount.currency)}${displayAccount.availableBalance.toStringAsFixed(2)}',
          insufficientFunds: !hasEnough,
          trailing: Icon(Icons.check_circle, color: const Color(0xFF3B82F6), size: 22.sp),
          onTap: null,
          onChangeTap: null,
        );
      },
    );
  }

  // --- Shared card & bottom sheet builders ---

  Widget _buildPaymentCategoryCard({
    required bool isSelected,
    IconData? icon,
    Color? iconColor,
    Widget? iconWidget,
    required String title,
    required String subtitle,
    bool insufficientFunds = false,
    Widget? trailing,
    VoidCallback? onTap,
    VoidCallback? onChangeTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFF3B82F6).withValues(alpha: 0.1)
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
              ? Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.4))
              : null,
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Color(0xFF3B82F6).withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                iconWidget ??
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: (iconColor ?? Colors.blue).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(icon, color: iconColor, size: 22.sp),
                    ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          color: insufficientFunds ? Colors.red[400] : const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: 8.w),
                  trailing,
                ],
              ],
            ),
            if (insufficientFunds) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 14.sp),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      'Insufficient balance. Tap "Change" to select another wallet.',
                      style: GoogleFonts.inter(color: Colors.red[400], fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ],
            if (onChangeTap != null) ...[
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: onChangeTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.swap_horiz, color: Color(0xFF3B82F6), size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Change',
                      style: GoogleFonts.inter(
                        color: Color(0xFF3B82F6),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: Color(0xFF3B82F6),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Your payment is secured with end-to-end encryption',
                    style: GoogleFonts.inter(
                      color: Color(0xFF3B82F6),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              // Paying is gated on the QUOTE, not just on processing state.
              // While the fee is unknown the tap must not reach the PIN sheet:
              // the prompt would show the fallback amount (possibly 0.00)
              // while the backend charges the real fee — consent to the wrong
              // number. A failed quote turns the tap into a retry instead.
              onPressed: _isProcessingPayment
                  ? null
                  : _feeQuoteFailed
                      ? _loadFeeQuote
                      : (_feeQuote == null ? null : _handlePaymentTap),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3B82F6),
                disabledBackgroundColor: Color(0xFF3B82F6).withValues(alpha: 0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: _isProcessingPayment
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LazerVaultLoader.small(),
                        SizedBox(width: 12.w),
                        Text(
                          'Processing Payment...',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _feeQuoteFailed
                              ? 'Fee unavailable — tap to retry'
                              : _feeQuote == null
                                  ? 'Loading fee…'
                                  : 'Unlock for $_feeCurrencySymbol${_fee.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentTap() {
    // Validate payment method selected
    if (_selectedPaymentMethod.isEmpty) {
      _showErrorSnackbar('Please select a payment method before proceeding.');
      return;
    }

    // Validate balance for wallet payments
    if (_selectedPaymentMethod.startsWith('account_') && _selectedAccountId.isNotEmpty) {
      final accountState = context.read<AccountCardsSummaryCubit>().state;
      List<AccountSummaryEntity> accounts = [];
      if (accountState is AccountCardsSummaryLoaded) {
        accounts = accountState.accountSummaries;
      } else if (accountState is AccountBalanceUpdated) {
        accounts = accountState.accountSummaries;
      }
      final match = accounts.where((a) => a.id == _selectedAccountId);
      if (match.isNotEmpty && match.first.availableBalance < _fee) {
        _showErrorSnackbar(
          'Insufficient balance in this wallet. Please select a different wallet or payment method.',
        );
        return;
      }
    }

    _processPayment();
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }

  void _processPayment() async {
    if (_selectedPaymentMethod.isEmpty) return;

    HapticFeedback.mediumImpact();

    // Use TransactionPinMixin for proper PIN verification
    final transactionId = widget.isPrePayment
        ? 'INV-SVC-FEE-${DateTime.now().millisecondsSinceEpoch}'
        : 'INV-PAY-${(widget.invoice!.id.length >= 8 ? widget.invoice!.id.substring(0, 8) : widget.invoice!.id)}';
    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: widget.isPrePayment ? 'invoice_service_fee' : 'invoice_payment',
      amount: _fee,
      currency: _feeCurrencyCode,
      title: widget.isPrePayment ? 'Confirm Service Fee' : 'Confirm Payment',
      message: widget.isPrePayment
          ? 'Confirm service fee payment of $_feeCurrencyCode ${_fee.toStringAsFixed(2)}'
          : 'Confirm invoice unlock fee of $_feeCurrencyCode ${_fee.toStringAsFixed(2)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;

    // Set the selected account on AccountManager so x-account-id metadata is sent
    if (_selectedAccountId.isNotEmpty) {
      GetIt.I<AccountManager>().setActiveAccount(_selectedAccountId);
    }

    if (mounted) {
      setState(() {
        _isProcessingPayment = true;
      });
    }

    // BlocListener handles navigation on success and error display on failure.
    //
    // The PIN has been consumed by this point. If this State was disposed
    // while the PIN sheet was up, context.read on the dead context would
    // THROW mid-money-path — so we bail instead. That abandons the validated
    // token, which is the acceptable cost: the unlock is idempotent by
    // transactionId, nothing has been debited yet, and the user simply
    // retries. A crash here would leave them unsure whether they paid.
    if (!mounted) return;
    final cubit = context.read<InvoiceCubit>();

    // Always use unlockInvoice to pay service fee and activate the invoice
    if (widget.invoice != null) {
      await cubit.unlockInvoice(
        widget.invoice!.id,
        accountId: _selectedAccountId.isNotEmpty ? _selectedAccountId : null,
        verificationToken: verificationToken,
        transactionId: transactionId,
      );
    } else {
      // Should not happen - invoice should always be provided
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invoice information missing. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
