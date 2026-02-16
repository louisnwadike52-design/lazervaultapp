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
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen>
    with TransactionPinMixin {
  final PageController _pageController = PageController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  int _currentStep = 0;
  static const int _totalSteps = 2;

  AccountSummaryEntity? _selectedAccount;
  bool _isProcessing = false;
  int? _selectedQuickAmount;
  bool _saveBeneficiary = false;

  // Beneficiary-aware fields
  BillBeneficiaryEntity? _beneficiary;
  bool _isFromBeneficiary = false;
  bool _isNicknameEditable = false;
  String? _originalNickname;

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

  // Service fee from provider (controlled by backend feature flag)
  double get _serviceFee {
    return _provider?.serviceFee ?? 0.0;
  }

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

      // Parse beneficiary if navigating from beneficiaries screen
      if (args['beneficiary'] is BillBeneficiaryEntity) {
        _beneficiary = args['beneficiary'] as BillBeneficiaryEntity;
        _isFromBeneficiary = true;
        _originalNickname = _beneficiary!.nickname;
        _nicknameController.text = _beneficiary!.nickname;
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }

    // C1: Ensure accounts are loaded with real user ID
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      _preSelectAccount(accountState);
    } else {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: authState.profile.user.id,
            );
      }
    }

    _amountController.addListener(_onAmountChanged);

    // Pre-load beneficiaries for duplicate check when saving
    context.read<BeneficiaryCubit>().getBeneficiaries();

    // Pre-fill phone number: from beneficiary args if present, else from user profile
    final argsPhone = args is Map<String, dynamic> ? args['phoneNumber'] as String? : null;
    if (argsPhone != null && argsPhone.isNotEmpty) {
      _phoneController.text = _normalizePhone(argsPhone);
    } else {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        final profilePhone = authState.profile.user.phoneNumber ?? '';
        _phoneController.text = profilePhone.isNotEmpty
            ? _normalizePhone(profilePhone)
            : '';
      }
    }
  }

  void _preSelectAccount(AccountCardsSummaryLoaded state) {
    final ngnAccounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == 'NGN')
        .toList();
    if (ngnAccounts.isNotEmpty) {
      // Prefer primary account, else first NGN account
      final primary = ngnAccounts.where((a) => a.isPrimary).firstOrNull;
      setState(() {
        _selectedAccount = primary ?? ngnAccounts.first;
      });
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _phoneController.dispose();
    _nicknameController.dispose();
    _pageController.dispose();
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

  String get _selectedAccountCurrency => _selectedAccount?.currency ?? 'NGN';

  // ===== Navigation =====

  void _goNext() {
    if (_currentStep == 0 && !_validateStep1()) return;
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _goBack() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    } else {
      Get.back();
    }
  }

  bool _validateStep1() {
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isNotEmpty && !_isValidPhone(phoneNumber)) {
      Get.snackbar(
        'Invalid Phone Number',
        'Enter a valid phone number (e.g. +2348012345678)',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Only validate nickname for new beneficiary saves, not existing ones
    if (!_isFromBeneficiary && _saveBeneficiary && _nicknameController.text.trim().isEmpty) {
      Get.snackbar(
        'Nickname Required',
        'Please enter a nickname for this beneficiary',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    return true;
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

    // Validate phone number
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        'Phone Number Required',
        'Please enter a phone number for token delivery',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (!_isValidPhone(phoneNumber)) {
      Get.snackbar(
        'Invalid Phone Number',
        'Enter a valid phone number (e.g. +2348012345678)',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_selectedAccount == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select a payment account',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Skip beneficiary saving/validation when coming from saved beneficiary
    if (!_isFromBeneficiary) {
      // Validate nickname if saving as beneficiary
      if (_saveBeneficiary && _nicknameController.text.trim().isEmpty) {
        Get.snackbar(
          'Nickname Required',
          'Please enter a nickname for this beneficiary',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Check for duplicate beneficiary meter number
      if (_saveBeneficiary) {
        final beneficiaryState = context.read<BeneficiaryCubit>().state;
        if (beneficiaryState is BeneficiariesLoaded) {
          final isDuplicate = beneficiaryState.beneficiaries.any(
            (b) => b.meterNumber == meterNumber,
          );
          if (isDuplicate) {
            Get.snackbar(
              'Already Saved',
              'A beneficiary with this meter number already exists',
              backgroundColor: const Color(0xFFFB923C),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            setState(() => _saveBeneficiary = false);
            return;
          }
        }
      }
    }

    // C5: Check balance before proceeding
    if (_selectedAccount != null && _selectedAccount!.balance < _totalAmount) {
      Get.snackbar(
        'Insufficient Balance',
        'Your account balance (\u20A6${_selectedAccount!.balance.toStringAsFixed(2)}) is less than the total amount (\u20A6${_totalAmount.toStringAsFixed(2)})',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
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
      showProcessingPhase: false,
      onPinValidated: (verificationToken) async {
        // Pop the PIN bottom sheet before navigating to processing screen
        if (mounted) {
          try { Navigator.of(context).pop(); } catch (_) {}
        }
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
    final phoneNumber = _normalizePhone(_phoneController.text.trim());

    // Save beneficiary if toggle is on (new beneficiary flow only)
    if (_saveBeneficiary && !_isFromBeneficiary) {
      context.read<BeneficiaryCubit>().saveBeneficiary(
            providerId: provider.id,
            meterNumber: meterNumber,
            meterType: meterType,
            customerName: validationResult.customerName,
            customerAddress: validationResult.customerAddress,
            phoneNumber: phoneNumber,
            nickname: _nicknameController.text.trim(),
            providerCode: provider.providerCode,
            providerName: provider.providerName,
          );
    }

    // Update beneficiary nickname if changed
    if (_isFromBeneficiary && _beneficiary != null) {
      final newNickname = _nicknameController.text.trim();
      if (newNickname.isNotEmpty && newNickname != _originalNickname) {
        context.read<BeneficiaryCubit>().updateBeneficiary(
              beneficiaryId: _beneficiary!.id,
              nickname: newNickname,
            );
      }
    }

    // Navigate to processing screen with all payment params
    Get.toNamed(
      AppRoutes.electricityBillProcessing,
      arguments: {
        'provider': provider,
        'validationResult': validationResult,
        'amount': amount,
        'meterNumber': meterNumber,
        'meterType': meterType,
        'providerCode': provider.providerCode,
        'currency': _selectedAccountCurrency,
        'accountId': _selectedAccount!.id,
        'phoneNumber': phoneNumber,
        'transactionId': transactionId,
        'verificationToken': verificationToken,
      },
    );
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

    return BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      listener: (context, state) {
        if (state is AccountCardsSummaryLoaded && _selectedAccount == null) {
          _preSelectAccount(state);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressBar(),
              SizedBox(height: 8.h),
              _buildStepIndicators(),
              SizedBox(height: 8.h),
              // Customer summary always visible
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _buildCustomerSummary(
                    provider, validationResult, meterType),
              ),
              SizedBox(height: 16.h),
              // PageView carousel
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) {
                    setState(() => _currentStep = page);
                  },
                  children: [
                    _buildStep1ContactDetails(),
                    _buildStep2PaymentDetails(provider),
                  ],
                ),
              ),
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Header =====

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _goBack,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              _currentStep == 0 ? 'Contact Details' : 'Payment Details',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            '${_currentStep + 1}/$_totalSteps',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ===== Progress Bar =====

  Widget _buildProgressBar() {
    return Container(
      height: 4,
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: (_currentStep + 1) / _totalSteps,
          backgroundColor: const Color(0xFF2D2D2D),
          valueColor: AlwaysStoppedAnimation<Color>(
            _currentStep == _totalSteps - 1
                ? const Color(0xFF10B981)
                : const Color(0xFF3B82F6),
          ),
        ),
      ),
    );
  }

  // ===== Step Indicators =====

  Widget _buildStepIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalSteps, (index) {
        final isActive = index == _currentStep;
        final isCompleted = index < _currentStep;
        return Container(
          width: isActive ? 24.w : 8.w,
          height: 8.w,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF3B82F6)
                : isCompleted
                    ? const Color(0xFF10B981)
                    : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }

  // ===== Customer Summary (Always Visible) =====

  Widget _buildCustomerSummary(
    ElectricityProviderEntity provider,
    MeterValidationResult validationResult,
    MeterType meterType,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          // Verified icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.verified,
              color: const Color(0xFF10B981),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  validationResult.customerName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  '${provider.providerName} \u2022 ${validationResult.meterNumber}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              meterType == MeterType.prepaid ? 'Prepaid' : 'Postpaid',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Step 1: Contact Details =====

  Widget _buildStep1ContactDetails() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          _buildPhoneInput(),
          SizedBox(height: 20.h),
          _buildSaveBeneficiaryToggle(),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  // ===== Step 2: Payment Details =====

  Widget _buildStep2PaymentDetails(ElectricityProviderEntity provider) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          _buildQuickAmounts(provider),
          SizedBox(height: 20.h),
          _buildAmountInput(provider),
          SizedBox(height: 20.h),
          _buildFeeBreakdown(),
          SizedBox(height: 20.h),
          _buildAccountCard(),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  // ===== Account Card (Pre-selected with Change) =====

  Widget _buildAccountCard() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
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
          if (_selectedAccount == null && state.accountSummaries.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _preSelectAccount(state);
            });
          }

          if (_selectedAccount != null) {
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
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => _showAccountSelector(state.accountSummaries),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                      border: Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 1.5,
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
                                '${_selectedAccount!.currency} Account  \u00B7\u00B7\u00B7${_selectedAccount!.accountNumberLast4}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Balance: \u20A6${_selectedAccount!.balance.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Change',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showAccountSelector(List<AccountSummaryEntity> allAccounts) {
    final ngnAccounts = allAccounts
        .where((a) => a.currency.toUpperCase() == 'NGN')
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Select Account',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            ...ngnAccounts.map((account) {
              final isSelected = _selectedAccount?.id == account.id;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedAccount = account);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                        : const Color(0xFF2D2D2D),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF374151),
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6)
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: const Color(0xFF3B82F6),
                          size: 18.sp,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: const Color(0xFF3B82F6),
                          size: 22.sp,
                        ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  // ===== Bottom Navigation =====

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: const Border(
            top: BorderSide(color: Color(0xFF2D2D2D))),
      ),
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: _goBack,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF3B82F6)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Back',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _isProcessing
                  ? null
                  : (_currentStep == _totalSteps - 1
                      ? _processPayment
                      : _goNext),
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentStep == _totalSteps - 1
                    ? const Color(0xFF10B981)
                    : const Color(0xFF3B82F6),
                disabledBackgroundColor: (_currentStep == _totalSteps - 1
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6))
                    .withValues(alpha: 0.5),
                padding: EdgeInsets.symmetric(vertical: 14.h),
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
                        if (_currentStep == _totalSteps - 1)
                          Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        if (_currentStep == _totalSteps - 1)
                          SizedBox(width: 8.w),
                        Text(
                          _currentStep == _totalSteps - 1
                              ? (_enteredAmount > 0
                                  ? 'Pay \u20A6${_totalAmount.toStringAsFixed(2)}'
                                  : 'Pay Now')
                              : 'Continue',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (_currentStep < _totalSteps - 1)
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14.sp,
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Shared Widgets =====

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

  /// Strips whitespace, dashes from phone number.
  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-]'), '');
  }

  /// Validates phone numbers - accepts any valid phone format.
  /// Must be at least 7 digits (shortest valid international numbers)
  /// and at most 15 digits (ITU-T E.164 max). May start with +.
  bool _isValidPhone(String phone) {
    final normalized = _normalizePhone(phone);
    return RegExp(r'^\+?\d{7,15}$').hasMatch(normalized);
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'For token delivery via SMS',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.h),
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
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: '+2348012345678',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF4B5563),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.phone_outlined,
                color: const Color(0xFF6B7280),
                size: 22.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveBeneficiaryToggle() {
    if (_isFromBeneficiary) {
      return _buildBeneficiaryNicknameField();
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.bookmark_border,
                color: _saveBeneficiary
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF6B7280),
                size: 22.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Save as Beneficiary',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Switch.adaptive(
                value: _saveBeneficiary,
                onChanged: (v) => setState(() => _saveBeneficiary = v),
                activeTrackColor: const Color(0xFF3B82F6),
              ),
            ],
          ),
        ),
        if (_saveBeneficiary) ...[
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: TextField(
              controller: _nicknameController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Nickname (required)',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF4B5563),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.label_outline,
                  color: const Color(0xFF6B7280),
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBeneficiaryNicknameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _isNicknameEditable
            ? const Color(0xFF1F1F1F)
            : const Color(0xFF1F1F1F).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _isNicknameEditable
              ? const Color(0xFF3B82F6)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: TextField(
        controller: _nicknameController,
        enabled: _isNicknameEditable,
        style: GoogleFonts.inter(
          color: _isNicknameEditable ? Colors.white : const Color(0xFF9CA3AF),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: 'Beneficiary Nickname',
          labelStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 12.sp,
          ),
          border: InputBorder.none,
          icon: Icon(
            Icons.label_outline,
            color: const Color(0xFF6B7280),
            size: 20.sp,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _isNicknameEditable = !_isNicknameEditable);
            },
            icon: Icon(
              _isNicknameEditable ? Icons.check : Icons.edit,
              color: _isNicknameEditable
                  ? const Color(0xFF10B981)
                  : const Color(0xFF6B7280),
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
