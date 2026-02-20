import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/invoice_entity.dart';
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

class InvoicePaymentScreen extends StatefulWidget {
  final Invoice? invoice;
  final double serviceFee;
  final bool isPrePayment;

  const InvoicePaymentScreen({
    super.key,
    this.invoice,
    this.serviceFee = 99.99,
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

  // Track selected index per category
  int _selectedCryptoIndex = 0;
  int _selectedOtherIndex = 0;

  final List<Map<String, dynamic>> _cryptoOptions = [
    {
      "name": "Bitcoin",
      "symbol": "BTC",
      "icon": "\u20bf",
      "color": Colors.orange,
      "rate": "0.00005",
    },
    {
      "name": "Ethereum",
      "symbol": "ETH",
      "icon": "\u039e",
      "color": Colors.indigo,
      "rate": "0.0018",
    },
    {
      "name": "USDC",
      "symbol": "USDC",
      "icon": "\$",
      "color": Colors.blue,
      "rate": "99.99",
    },
  ];

  final List<Map<String, dynamic>> _otherOptions = [
    {
      "name": "Credit/Debit Card",
      "description": "Visa, Mastercard, American Express",
      "icon": Icons.credit_card,
      "color": Colors.teal,
      "id": "card",
    },
    {
      "name": "PayPal",
      "description": "Pay with your PayPal account",
      "icon": Icons.payment,
      "color": Colors.blue[700],
      "id": "paypal",
    },
    {
      "name": "Apple Pay",
      "description": "Touch ID or Face ID",
      "icon": Icons.phone_iphone,
      "color": Colors.black,
      "id": "apple_pay",
    },
    {
      "name": "Google Pay",
      "description": "Pay with Google",
      "icon": Icons.account_circle,
      "color": Colors.red,
      "id": "google_pay",
    },
  ];

  String get _currencySymbol => _getCurrencySymbol(widget.invoice?.currency ?? 'NGN');

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
            Color(0xFF8B5CF6).withValues(alpha: 0.1),
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
                      'LazerVault Invoice Service',
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
                '$_currencySymbol${widget.serviceFee.toStringAsFixed(2)}',
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
        _buildWalletPaymentCard(),
        SizedBox(height: 12.h),
        _buildCryptoPaymentCard(),
        SizedBox(height: 12.h),
        _buildOtherPaymentCard(),
      ],
    );
  }

  // --- LazerVault Wallet ---

  Widget _buildWalletPaymentCard() {
    final isSelected = _selectedPaymentMethod.startsWith('account_');
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
            title: 'Pay with LazerVault Wallet',
            subtitle: 'Loading wallets...',
            trailing: SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
                strokeWidth: 2,
              ),
            ),
            onTap: null,
            onChangeTap: null,
          );
        }

        if (accounts.isEmpty) {
          return _buildPaymentCategoryCard(
            isSelected: false,
            icon: Icons.account_balance_wallet,
            iconColor: Colors.blue,
            title: 'Pay with LazerVault Wallet',
            subtitle: 'No wallets available',
            trailing: null,
            onTap: null,
            onChangeTap: null,
          );
        }

        // Find the currently selected account, or default to first
        AccountSummaryEntity displayAccount = accounts.first;
        if (_selectedAccountId.isNotEmpty) {
          final match = accounts.where((a) => a.id == _selectedAccountId);
          if (match.isNotEmpty) displayAccount = match.first;
        }

        final hasEnough = displayAccount.balance >= widget.serviceFee;

        return _buildPaymentCategoryCard(
          isSelected: isSelected,
          icon: _getAccountIcon(displayAccount.accountType),
          iconColor: _getAccountColor(displayAccount.accountType),
          title: 'Pay with LazerVault Wallet',
          subtitle: '${displayAccount.accountType} Account  •  $_currencySymbol${displayAccount.balance.toStringAsFixed(2)}',
          insufficientFunds: isSelected && !hasEnough,
          trailing: isSelected
              ? Icon(Icons.check_circle, color: Color(0xFF3B82F6), size: 22.sp)
              : null,
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 'account_${displayAccount.id}';
              _selectedAccountId = displayAccount.id;
            });
          },
          onChangeTap: accounts.length > 1 ? () => _showWalletBottomSheet(accounts) : null,
        );
      },
    );
  }

  void _showWalletBottomSheet(List<AccountSummaryEntity> accounts) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _buildBottomSheetContainer(
        title: 'Select LazerVault Wallet',
        children: accounts.map((account) {
          final isCurrent = _selectedAccountId == account.id;
          final hasEnough = account.balance >= widget.serviceFee;
          final color = _getAccountColor(account.accountType);
          return _buildBottomSheetOption(
            icon: _getAccountIcon(account.accountType),
            iconColor: color,
            title: '${account.accountType} Account',
            subtitle: '\u2022\u2022\u2022\u2022 ${account.accountNumberLast4}',
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_currencySymbol${account.balance.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: hasEnough ? Colors.white : Colors.red[400],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!hasEnough)
                  Text(
                    'Insufficient',
                    style: GoogleFonts.inter(color: Colors.red[400], fontSize: 11.sp),
                  ),
              ],
            ),
            isSelected: isCurrent,
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 'account_${account.id}';
                _selectedAccountId = account.id;
              });
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      ),
    );
  }

  // --- Cryptocurrency ---

  Widget _buildCryptoPaymentCard() {
    final crypto = _cryptoOptions[_selectedCryptoIndex];
    final isSelected = _selectedPaymentMethod.startsWith('crypto_');

    return _buildPaymentCategoryCard(
      isSelected: isSelected,
      iconWidget: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: (crypto["color"] as Color).withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            crypto["icon"],
            style: GoogleFonts.inter(
              color: crypto["color"],
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: 'Pay with Cryptocurrency',
      subtitle: '${crypto["name"]} (${crypto["symbol"]})  •  ${crypto["rate"]} ${crypto["symbol"]}',
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Color(0xFF3B82F6), size: 22.sp)
          : null,
      onTap: () {
        setState(() {
          _selectedPaymentMethod = 'crypto_${crypto["symbol"]}';
          _selectedAccountId = '';
        });
      },
      onChangeTap: () => _showCryptoBottomSheet(),
    );
  }

  void _showCryptoBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _buildBottomSheetContainer(
        title: 'Select Cryptocurrency',
        children: _cryptoOptions.asMap().entries.map((entry) {
          final idx = entry.key;
          final crypto = entry.value;
          final isCurrent = _selectedCryptoIndex == idx &&
              _selectedPaymentMethod == 'crypto_${crypto["symbol"]}';
          return _buildBottomSheetOption(
            iconWidget: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: (crypto["color"] as Color).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  crypto["icon"],
                  style: GoogleFonts.inter(
                    color: crypto["color"],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: crypto["name"],
            subtitle: '${crypto["rate"]} ${crypto["symbol"]}  \u2248  $_currencySymbol${widget.serviceFee.toStringAsFixed(2)}',
            isSelected: isCurrent,
            onTap: () {
              setState(() {
                _selectedCryptoIndex = idx;
                _selectedPaymentMethod = 'crypto_${crypto["symbol"]}';
                _selectedAccountId = '';
              });
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      ),
    );
  }

  // --- Other Payment Methods ---

  Widget _buildOtherPaymentCard() {
    final option = _otherOptions[_selectedOtherIndex];
    final isSelected = _selectedPaymentMethod == option["id"];

    return _buildPaymentCategoryCard(
      isSelected: isSelected,
      icon: option["icon"],
      iconColor: option["color"],
      title: 'Other Payment Methods',
      subtitle: '${option["name"]}  •  ${option["description"]}',
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Color(0xFF3B82F6), size: 22.sp)
          : null,
      onTap: () {
        setState(() {
          _selectedPaymentMethod = option["id"];
          _selectedAccountId = '';
        });
      },
      onChangeTap: () => _showOtherMethodsBottomSheet(),
    );
  }

  void _showOtherMethodsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _buildBottomSheetContainer(
        title: 'Select Payment Method',
        children: _otherOptions.asMap().entries.map((entry) {
          final idx = entry.key;
          final option = entry.value;
          final isCurrent = _selectedOtherIndex == idx &&
              _selectedPaymentMethod == option["id"];
          return _buildBottomSheetOption(
            icon: option["icon"],
            iconColor: option["color"],
            title: option["name"],
            subtitle: option["description"],
            isSelected: isCurrent,
            onTap: () {
              setState(() {
                _selectedOtherIndex = idx;
                _selectedPaymentMethod = option["id"];
                _selectedAccountId = '';
              });
              Navigator.pop(ctx);
            },
          );
        }).toList(),
      ),
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

  Widget _buildBottomSheetContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ...children,
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ),
    );
  }

  Widget _buildBottomSheetOption({
    IconData? icon,
    Color? iconColor,
    Widget? iconWidget,
    required String title,
    required String subtitle,
    Widget? trailing,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFF3B82F6).withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
              ? Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.4))
              : null,
        ),
        child: Row(
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
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(Icons.check_circle, color: Color(0xFF3B82F6), size: 22.sp),
              ),
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
              onPressed: _isProcessingPayment ? null : _handlePaymentTap,
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
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
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
                          'Unlock for $_currencySymbol${widget.serviceFee.toStringAsFixed(2)}',
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
      if (match.isNotEmpty && match.first.balance < widget.serviceFee) {
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
    final pinResult = await validatePinOnly(
      context: context,
      transactionId: transactionId,
      transactionType: widget.isPrePayment ? 'invoice_service_fee' : 'invoice_payment',
      amount: widget.serviceFee,
      currency: widget.invoice?.currency ?? 'NGN',
    );

    if (pinResult == null || !pinResult.success) return;

    // Set the selected account on AccountManager so x-account-id metadata is sent
    if (_selectedAccountId.isNotEmpty) {
      GetIt.I<AccountManager>().setActiveAccount(_selectedAccountId);
    }

    setState(() {
      _isProcessingPayment = true;
    });

    // BlocListener handles navigation on success and error display on failure
    final cubit = context.read<InvoiceCubit>();

    if (widget.isPrePayment) {
      await cubit.payServiceFee(
        accountId: _selectedAccountId.isNotEmpty ? _selectedAccountId : null,
        verificationToken: pinResult.verificationToken,
        transactionId: transactionId,
      );
    } else {
      await cubit.unlockInvoice(
        widget.invoice!.id,
        accountId: _selectedAccountId.isNotEmpty ? _selectedAccountId : null,
        verificationToken: pinResult.verificationToken,
        transactionId: transactionId,
      );
    }
  }
}
