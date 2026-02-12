import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../cubit/electricity_bill_cubit.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen>
    with TransactionPinMixin {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedAccountId;
  bool _isProcessing = false;
  int? _selectedQuickAmount;

  // Parsed from Get.arguments in initState
  ElectricityProviderEntity? _provider;
  MeterValidationResult? _validationResult;
  String? _meterNumber;
  MeterType? _meterType;
  bool _argsValid = false;

  static const _quickAmounts = [1000, 2000, 5000, 10000, 20000];

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  // C4: Get service fee from provider
  double get _serviceFee => _provider?.serviceFee ?? 0.0;

  @override
  void initState() {
    super.initState();

    // Parse args safely
    final args = Get.arguments;
    if (args is Map<String, dynamic> &&
        args['provider'] is ElectricityProviderEntity &&
        args['validationResult'] is MeterValidationResult &&
        args['meterNumber'] is String &&
        args['meterType'] is MeterType) {
      _provider = args['provider'] as ElectricityProviderEntity;
      _validationResult = args['validationResult'] as MeterValidationResult;
      _meterNumber = args['meterNumber'] as String;
      _meterType = args['meterType'] as MeterType;
      _argsValid = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }

    // C1: Ensure accounts are loaded with real user ID
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: authState.profile.user.id,
            );
      }
    }

    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount != null) {
      final matchingQuick = _quickAmounts.cast<int?>().firstWhere(
            (q) => q!.toDouble() == amount,
            orElse: () => null,
          );
      setState(() => _selectedQuickAmount = matchingQuick);
    } else {
      setState(() => _selectedQuickAmount = null);
    }
  }

  void _onQuickAmountSelected(int amount) {
    setState(() => _selectedQuickAmount = amount);
    _amountController.text = amount.toString();
    _amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: _amountController.text.length),
    );
  }

  double get _enteredAmount =>
      double.tryParse(_amountController.text.trim()) ?? 0;

  double get _totalAmount => _enteredAmount + _serviceFee;

  String get _selectedAccountCurrency {
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded && _selectedAccountId != null) {
      final account = accountState.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .firstOrNull;
      if (account != null) return account.currency;
    }
    return 'NGN';
  }

  void _processPayment() async {
    // C2: Prevent double-tap
    if (_isProcessing) return;
    if (!_argsValid) return;

    final provider = _provider!;
    final validationResult = _validationResult!;
    final meterNumber = _meterNumber!;
    final meterType = _meterType!;

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      Get.snackbar(
        'Enter Amount',
        'Please enter an amount to continue',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Check amount limits
    if (provider.hasAmountLimits) {
      if (amount < (provider.minAmount ?? 0)) {
        Get.snackbar(
          'Below Minimum',
          'Minimum amount is \u20A6${provider.minAmount?.toStringAsFixed(0)}',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      if (amount > (provider.maxAmount ?? double.infinity)) {
        Get.snackbar(
          'Above Maximum',
          'Maximum amount is \u20A6${provider.maxAmount?.toStringAsFixed(0)}',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    if (_selectedAccountId == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select a payment account',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // C5: Check balance before proceeding
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .firstOrNull;
      if (selectedAccount != null && selectedAccount.balance < _totalAmount) {
        Get.snackbar(
          'Insufficient Balance',
          'Your account balance (\u20A6${selectedAccount.balance.toStringAsFixed(2)}) is less than the total amount (\u20A6${_totalAmount.toStringAsFixed(2)})',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    // C2: Set processing flag
    setState(() => _isProcessing = true);

    HapticFeedback.mediumImpact();

    // C3: Generate unique transaction ID with UUID
    final transactionId = const Uuid().v4();

    // Validate PIN before processing payment
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'bill_payment',
      amount: amount,
      currency: _selectedAccountCurrency,
      title: 'Confirm Bill Payment',
      message:
          'Confirm payment of \u20A6${amount.toStringAsFixed(2)} for ${provider.providerName}?',
      onPinValidated: (verificationToken) async {
        _executePaymentWithToken(
          provider: provider,
          validationResult: validationResult,
          meterNumber: meterNumber,
          meterType: meterType,
          amount: amount,
          transactionId: transactionId,
          verificationToken: verificationToken,
        );
      },
    );

    if (!success) {
      // C2: Reset processing flag on PIN failure/cancellation
      setState(() => _isProcessing = false);
    }
  }

  void _executePaymentWithToken({
    required ElectricityProviderEntity provider,
    required MeterValidationResult validationResult,
    required String meterNumber,
    required MeterType meterType,
    required double amount,
    required String transactionId,
    required String verificationToken,
  }) {
    // Navigate to processing screen first
    Get.toNamed(
      AppRoutes.electricityBillProcessing,
      arguments: {
        'provider': provider,
        'validationResult': validationResult,
        'amount': amount,
        'meterNumber': meterNumber,
        'meterType': meterType,
      },
    );

    // Then trigger the payment with verification token
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      context.read<ElectricityBillCubit>().initiatePaymentWithToken(
            providerCode: provider.providerCode,
            meterNumber: meterNumber,
            meterType: meterType,
            amount: amount,
            currency: _selectedAccountCurrency,
            accountId: _selectedAccountId!,
            transactionId: transactionId,
            verificationToken: verificationToken,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_argsValid) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: SizedBox.shrink(),
      );
    }

    final provider = _provider!;
    final validationResult = _validationResult!;
    final meterType = _meterType!;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    _buildCustomerSummary(
                        provider, validationResult, meterType),
                    SizedBox(height: 24.h),
                    _buildQuickAmounts(provider),
                    SizedBox(height: 20.h),
                    _buildAmountInput(provider),
                    SizedBox(height: 20.h),
                    _buildFeeBreakdown(),
                    SizedBox(height: 24.h),
                    _buildAccountSelector(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
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
                  'Confirm Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Review details before paying',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerSummary(
    ElectricityProviderEntity provider,
    MeterValidationResult validationResult,
    MeterType meterType,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          // Verified badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  color: const Color(0xFF10B981),
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Meter Verified',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Customer info
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      validationResult.customerName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      validationResult.meterNumber,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Customer address (from VTPass validation)
          if (validationResult.customerAddress != null &&
              validationResult.customerAddress!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: const Color(0xFF8B5CF6),
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    validationResult.customerAddress!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: 16.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),

          // Provider + meter type row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.bolt,
                      color: const Color(0xFFFB923C),
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    provider.providerName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  meterType == MeterType.prepaid ? 'Prepaid' : 'Postpaid',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmounts(ElectricityProviderEntity provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Amount',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: _quickAmounts.map((amount) {
            final isSelected = _selectedQuickAmount == amount;
            // Check if amount is within provider limits
            final isInRange = !provider.hasAmountLimits ||
                (amount >= (provider.minAmount ?? 0) &&
                    amount <= (provider.maxAmount ?? double.infinity));

            return GestureDetector(
              onTap: isInRange ? () => _onQuickAmountSelected(amount) : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: !isInRange
                      ? const Color(0xFF1F1F1F).withValues(alpha: 0.5)
                      : isSelected
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                          : const Color(0xFF1F1F1F),
                  border: Border.all(
                    color: !isInRange
                        ? const Color(0xFF2D2D2D).withValues(alpha: 0.5)
                        : isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '\u20A6${_formatQuickAmount(amount)}',
                  style: GoogleFonts.inter(
                    color: !isInRange
                        ? const Color(0xFF6B7280)
                        : isSelected
                            ? const Color(0xFF3B82F6)
                            : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _formatQuickAmount(int amount) {
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}k';
    }
    return amount.toString();
  }

  Widget _buildAmountInput(ElectricityProviderEntity provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Custom Amount',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (provider.hasAmountLimits)
              Text(
                '\u20A6${provider.minAmount?.toStringAsFixed(0)} - \u20A6${provider.maxAmount?.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF4B5563),
                fontSize: 24.sp,
              ),
              border: InputBorder.none,
              prefix: Text(
                '\u20A6 ',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeeBreakdown() {
    return AnimatedOpacity(
      opacity: _enteredAmount > 0 ? 1.0 : 0.4,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            _buildFeeRow(
              'Amount',
              '\u20A6${_enteredAmount.toStringAsFixed(2)}',
            ),
            SizedBox(height: 8.h),
            _buildFeeRow(
              'Service Fee',
              '\u20A6${_serviceFee.toStringAsFixed(2)}',
            ),
            SizedBox(height: 8.h),
            Divider(color: const Color(0xFF2D2D2D)),
            SizedBox(height: 8.h),
            _buildFeeRow(
              'Total',
              '\u20A6${_totalAmount.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: isTotal ? Colors.white : const Color(0xFFD1D5DB),
            fontSize: isTotal ? 16.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                strokeWidth: 2,
              ),
            ),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          final ngnAccounts = state.accountSummaries
              .where((a) => a.currency.toUpperCase() == 'NGN')
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Account',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              ...ngnAccounts.map((account) {
                final isSelected =
                    _selectedAccountId == account.id.toString();

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAccountId = account.id.toString();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                          : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: const Color(0xFF3B82F6),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                account.accountType,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '\u20A6${account.balance.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF3B82F6),
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            disabledBackgroundColor:
                const Color(0xFF10B981).withValues(alpha: 0.5),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: _isProcessing
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      _enteredAmount > 0
                          ? 'Pay \u20A6${_totalAmount.toStringAsFixed(2)}'
                          : 'Confirm Payment',
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
    );
  }
}
