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
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import '../../domain/entities/auto_recharge_entity.dart';
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
import '../widgets/electricity_rollover_preference_sheet.dart';
import 'package:lazervault/core/services/locale_manager.dart';

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
  /// Whether the logged-in user's profile carries a phone number. Drives
  /// the "Set it in Settings" CTA under the token-SMS phone field — same
  /// pattern as the airtime recipient screen.
  bool _hasProfilePhone = false;
  CountryLocale _selectedCountry = CountryLocales.all.first; // Nigeria default

  // Beneficiary-aware fields
  BillBeneficiaryEntity? _beneficiary;
  bool _isFromBeneficiary = false;
  // True when this screen was opened by the "Repeat Payment" action on
  // the electricity history bottom sheet. Back-nav behaviour differs:
  // repeat flows pop back to the history list, normal flows fall through
  // to the meter-input step that produced the validation result.
  bool _isRepeatPayment = false;
  String? _originalNickname;

  // Probe state — fetched once on mount so we can hide toggles the user
  // has already configured (saved beneficiary / active auto-recharge).
  // Mirrors the internet bill confirmation UX.
  bool _probeLoading = true;
  BillBeneficiaryEntity? _existingBeneficiary;
  AutoRechargeEntity? _existingAutoRecharge;

  // Auto-recharge toggle state for this confirm flow.
  bool _autoRechargeEnabled = false;
  ElectricityRolloverPreference? _autoRechargePref;

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

      // Repeat-payment path: remember the flag so the back-nav flips
      // to the history screen (instead of the meter-input step) when
      // the user taps the AppBar back arrow. Also pre-fill the amount
      // + match any quick-amount chip so the user can one-tap re-send.
      _isRepeatPayment = args['isRepeat'] == true;
      final repeatAmount = args['amount'];
      if (repeatAmount is num && repeatAmount > 0) {
        _amountController.text = repeatAmount.toStringAsFixed(0);
      }
      // Repeat flows have phone + meter already validated — jump to
      // the Payment Details step so the user doesn't have to click
      // through Contact Details just to re-confirm a known-good row.
      if (_isRepeatPayment) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _pageController.jumpToPage(1);
          setState(() => _currentStep = 1);
        });
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

    // Pre-fill phone number: from beneficiary args if present, else from
    // user profile. Track `_hasProfilePhone` separately so the CTA under
    // the field correctly reflects the profile state even when the
    // current value came from a saved beneficiary.
    final argsPhone = args is Map<String, dynamic> ? args['phoneNumber'] as String? : null;
    String rawPhone = '';
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final profilePhone = authState.profile.user.phoneNumber ?? '';
      _hasProfilePhone = profilePhone.isNotEmpty;
      if (argsPhone == null || argsPhone.isEmpty) {
        rawPhone = profilePhone;
      }
    }
    if (argsPhone != null && argsPhone.isNotEmpty) {
      rawPhone = argsPhone;
    }
    if (rawPhone.isNotEmpty) {
      // Detect country code from phone and strip it for the local number field
      final stripped = _stripDialCode(rawPhone);
      _phoneController.text = stripped;
    }

    // Probe existing beneficiary / auto-recharge after first frame so the
    // InheritedWidgets are wired. Non-blocking — toggles render as
    // placeholders while the probe is in flight.
    WidgetsBinding.instance.addPostFrameCallback((_) => _probeExistingState());
  }

  /// Look up whether this meter already has a saved beneficiary and an
  /// active auto-recharge. Uses the repository directly rather than the
  /// cubits so state for other screens isn't perturbed. Failures are
  /// swallowed — worst case we show the toggles and trust server-side
  /// duplicate protection.
  Future<void> _probeExistingState() async {
    if (!_argsValid || _meterNumber == null || _provider == null) {
      if (mounted) setState(() => _probeLoading = false);
      return;
    }

    final meter = _meterNumber!;
    final providerCode = _provider!.providerCode;

    try {
      final repo = GetIt.I<ElectricityBillRepository>();

      // If we navigated here from an existing beneficiary, reuse it
      // instead of re-fetching — also lets us skip showing the
      // "save as beneficiary" toggle entirely.
      BillBeneficiaryEntity? matchBen = _beneficiary;

      if (matchBen == null) {
        final bensRes = await repo.getBeneficiaries();
        matchBen = bensRes.fold<BillBeneficiaryEntity?>(
          (_) => null,
          (list) {
            for (final b in list) {
              if (b.meterNumber == meter &&
                  (b.providerCode == providerCode ||
                      b.providerId == _provider!.id)) {
                return b;
              }
            }
            return null;
          },
        );
      }

      AutoRechargeEntity? matchAuto;
      if (matchBen != null) {
        final autoRes = await repo.getAutoRecharges();
        matchAuto = autoRes.fold<AutoRechargeEntity?>(
          (_) => null,
          (list) {
            for (final ar in list) {
              if (ar.beneficiaryId == matchBen!.id && ar.isActive) {
                return ar;
              }
            }
            return null;
          },
        );
      }

      if (!mounted) return;
      setState(() {
        _existingBeneficiary = matchBen;
        _existingAutoRecharge = matchAuto;
        _probeLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _probeLoading = false);
    }
  }

  Future<void> _onToggleAutoRecharge(bool newValue) async {
    if (!newValue) {
      setState(() {
        _autoRechargeEnabled = false;
        _autoRechargePref = null;
      });
      return;
    }
    final pref = await ElectricityRolloverPreferenceSheet.show(context);
    if (pref == null) return;
    setState(() {
      _autoRechargeEnabled = true;
      _autoRechargePref = pref;
    });
  }

  /// Save-as-beneficiary toggle handler. When turning ON, prompt for a
  /// nickname via a dialog; if the user cancels we leave the toggle off
  /// so a blank nickname never gets submitted. When turning OFF, clear
  /// the nickname controller so re-toggling prompts fresh.
  Future<void> _onToggleSaveBeneficiary(bool newValue) async {
    if (!newValue) {
      setState(() {
        _saveBeneficiary = false;
        _nicknameController.text = '';
      });
      return;
    }
    final nickname = await _promptForNickname();
    if (nickname == null || nickname.trim().isEmpty) return;
    setState(() {
      _saveBeneficiary = true;
      _nicknameController.text = nickname.trim();
    });
  }

  /// Dialog collecting a nickname for the meter. Delegates the body to
  /// [_NicknameDialog] — a private `StatefulWidget` so the controller's
  /// lifecycle is tied to the dialog's own element tree. Disposing the
  /// controller inline here used to race the dialog's close animation
  /// and trip `dependents.isEmpty is not true` on Cancel.
  Future<String?> _promptForNickname() {
    return showDialog<String>(
      context: context,
      builder: (_) =>
          _NicknameDialog(initial: _nicknameController.text.trim()),
    );
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
      return;
    }
    // Step-0 back from a repeat-payment entry: the caller (history
    // actions sheet) pushed this screen directly, so there's no
    // meter-input screen underneath. Pop straight back to history for
    // a clean UX — a plain Get.back() would also work but we make the
    // intent explicit and skip any transient screens in between.
    if (_isRepeatPayment) {
      Get.offAllNamed(
        AppRoutes.electricityBillHistory,
      );
      return;
    }
    // Normal purchase flow: just pop one level (back to meter input).
    Get.back();
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
        'Enter a valid phone number (e.g. 8012345678)',
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
    if (_selectedAccount != null && _selectedAccount!.availableBalance < _totalAmount) {
      Get.snackbar(
        'Insufficient Balance',
        'Your account balance (\u20A6${_selectedAccount!.availableBalance.toStringAsFixed(2)}) is less than the total amount (\u20A6${_totalAmount.toStringAsFixed(2)})',
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
    String? verificationToken;

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
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) {
      setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    _executePaymentWithToken(
      provider: provider,
      validationResult: validationResult,
      meterNumber: meterNumber,
      meterType: meterType,
      amount: amount,
      transactionId: transactionId,
      verificationToken: verificationToken!,
    );
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
    final phoneNumber = _buildFullPhone();

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

    // Navigate to processing screen — remove confirmation from stack.
    // Post-pay side-effects (auto-recharge creation, beneficiary id
    // lookup) are threaded through so the receipt screen can fire them
    // once the payment itself is confirmed as completed.
    Get.offNamed(
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
        // Keep-alive flags — receipt screen consumes these on success.
        'autoRechargeEnabled': _autoRechargeEnabled,
        'autoRechargePref': _autoRechargePref,
        'existingBeneficiaryId': _existingBeneficiary?.id ?? _beneficiary?.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_argsValid) {
      return const Scaffold(
        backgroundColor: InvoiceThemeColors.primaryBackground,
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
        backgroundColor: InvoiceThemeColors.primaryBackground,
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
                : const Color(0xFF4E03D0),
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
                ? const Color(0xFF4E03D0)
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
              color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              meterType == MeterType.prepaid ? 'Prepaid' : 'Postpaid',
              style: GoogleFonts.inter(
                color: const Color(0xFF4E03D0),
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
          SizedBox(height: 12.h),
          _buildAmountInput(provider),
          SizedBox(height: 12.h),
          _buildFeeBreakdown(),
          SizedBox(height: 12.h),
          _buildAccountCard(),
          SizedBox(height: 12.h),
          _buildKeepAliveTiles(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ===== Keep-alive tiles (save beneficiary + auto-recharge) =====

  /// Renders a pair of tiles:
  ///  - Save-as-beneficiary: toggle when no existing match, info tile
  ///    ("Already saved") otherwise.
  ///  - Auto-recharge: toggle (opens the rollover preference sheet) when
  ///    no active schedule exists, info tile ("Auto-recharge active")
  ///    otherwise.
  ///
  /// Step-1 already has the legacy "save beneficiary + nickname" UI; we
  /// keep that for users coming directly from manual meter entry, but
  /// hide it when an existing beneficiary is detected so they don't save
  /// twice. The step-2 tiles are the always-visible summary.
  Widget _buildKeepAliveTiles() {
    if (_probeLoading) {
      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: InvoiceThemeColors.borderColor, width: 1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18.sp,
              height: 18.sp,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  InvoiceThemeColors.primaryPurple,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Checking saved beneficiaries...',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      );
    }

    final saveRow = (_existingBeneficiary == null && !_isFromBeneficiary)
        ? _buildToggleRow(
            icon: Icons.bookmark_outline,
            title: 'Save as beneficiary',
            subtitle: _saveBeneficiary &&
                    _nicknameController.text.trim().isNotEmpty
                ? 'Nickname: ${_nicknameController.text.trim()}'
                : 'Quick-buy this meter next time',
            value: _saveBeneficiary,
            onChanged: _onToggleSaveBeneficiary,
          )
        : (_existingBeneficiary != null
            ? _buildInfoRow(
                icon: Icons.bookmark,
                title: 'Meter already saved',
                subtitle:
                    'Saved as "${_existingBeneficiary!.displayName}"',
              )
            : null);

    final autoRow = (_existingAutoRecharge == null)
        ? _buildToggleRow(
            icon: Icons.autorenew,
            title: 'Enable auto-recharge',
            subtitle: _autoRechargeEnabled && _autoRechargePref != null
                ? _formatAutoRechargeSummary(_autoRechargePref!)
                : 'Keep this meter topped up on a schedule',
            value: _autoRechargeEnabled,
            onChanged: _onToggleAutoRecharge,
          )
        : _buildInfoRow(
            icon: Icons.autorenew,
            title: 'Auto-recharge active',
            subtitle:
                '${_existingAutoRecharge!.frequency.displayName} \u00B7 \u20A6${_existingAutoRecharge!.amount.toStringAsFixed(0)}',
          );

    final rows = <Widget>[
      if (saveRow != null) saveRow,
      if (saveRow != null) Divider(height: 1, color: InvoiceThemeColors.borderColor),
      autoRow,
    ];

    return Container(
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: InvoiceThemeColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rows,
      ),
    );
  }

  String _formatAutoRechargeSummary(ElectricityRolloverPreference pref) {
    final freq = pref.frequency[0].toUpperCase() + pref.frequency.substring(1);
    final time =
        '${pref.executionHour.toString().padLeft(2, '0')}:${pref.executionMinute.toString().padLeft(2, '0')}';
    switch (pref.frequency) {
      case 'weekly':
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        final idx = (pref.dayOfWeek - 1).clamp(0, 6);
        return '$freq \u00B7 ${days[idx]} at $time';
      case 'monthly':
        return '$freq \u00B7 Day ${pref.dayOfMonth} at $time';
      default:
        return '$freq \u00B7 $time';
    }
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, color: InvoiceThemeColors.primaryPurple, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray400,
                    fontSize: 11.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: InvoiceThemeColors.primaryPurple,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, color: InvoiceThemeColors.successGreen, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.successGreen,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray400,
                    fontSize: 11.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
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
                    AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
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
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                      border: Border.all(
                        color: const Color(0xFF4E03D0),
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
                            color: const Color(0xFF4E03D0)
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            color: const Color(0xFF4E03D0),
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
                                'Balance: \u20A6${_selectedAccount!.availableBalance.toStringAsFixed(2)}',
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
                              color: const Color(0xFF4E03D0),
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
                        ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                        : const Color(0xFF2D2D2D),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4E03D0)
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
                          color: const Color(0xFF4E03D0)
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: const Color(0xFF4E03D0),
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
                              '\u20A6${account.availableBalance.toStringAsFixed(2)}',
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
                          color: const Color(0xFF4E03D0),
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
                  side: const BorderSide(color: Color(0xFF4E03D0)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Back',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4E03D0),
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
                backgroundColor: const Color(0xFF4E03D0),
                disabledBackgroundColor:
                    const Color(0xFF4E03D0).withValues(alpha: 0.5),
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
                          ? const Color(0xFF4E03D0).withValues(alpha: 0.15)
                          : const Color(0xFF1F1F1F),
                  border: Border.all(
                    color: !isInRange
                        ? const Color(0xFF2D2D2D).withValues(alpha: 0.5)
                        : isSelected
                            ? const Color(0xFF4E03D0)
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
                            ? const Color(0xFF4E03D0)
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
                  color: const Color(0xFF4E03D0),
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
    return phone.replaceAll(RegExp(r'[\s\-()]'), '');
  }

  /// Strip dial code prefix from a phone number to get the local part.
  String _stripDialCode(String phone) {
    final cleaned = _normalizePhone(phone);
    // Try to match against known dial codes (longest first)
    final sortedCountries = List<CountryLocale>.from(CountryLocales.all)
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
    for (final country in sortedCountries) {
      final code = country.dialCode; // e.g. "+234"
      if (cleaned.startsWith(code)) {
        _selectedCountry = country;
        return cleaned.substring(code.length);
      }
    }
    // Strip leading 0 for Nigerian numbers without country code
    if (cleaned.startsWith('0') && cleaned.length >= 10) {
      return cleaned.substring(1);
    }
    return cleaned;
  }

  /// Build the full E.164 phone number with country code.
  String _buildFullPhone() {
    final local = _normalizePhone(_phoneController.text.trim());
    // Strip leading zero if present (common in local format)
    final stripped = local.startsWith('0') ? local.substring(1) : local;
    return '${_selectedCountry.dialCode}$stripped';
  }

  /// Validates the local phone number. Accepts both the 11-digit
  /// leading-zero form (`0XXXXXXXXXX`) and the 10-digit bare form
  /// (`XXXXXXXXXX`) for Nigeria; for other countries, 7–14 digits.
  bool _isValidPhone(String phone) {
    final local = _normalizePhone(phone);
    final stripped = local.startsWith('0') ? local.substring(1) : local;
    // NG: exactly 10 digits after stripping leading 0.
    if (_selectedCountry.dialCode == '+234') {
      return RegExp(r'^\d{10}$').hasMatch(stripped);
    }
    return RegExp(r'^\d{7,14}$').hasMatch(stripped);
  }

  void _showCountryCodePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final filtered = searchQuery.isEmpty
                ? CountryLocales.all
                : CountryLocales.search(searchQuery);
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Drag handle
                      Container(
                        margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      // Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select Country Code',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp),
                            ),
                          ],
                        ),
                      ),
                      // Search
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        child: TextField(
                          onChanged: (v) => setSheetState(() => searchQuery = v),
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Search country...',
                            hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                            prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                            filled: true,
                            fillColor: const Color(0xFF0A0A0A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          ),
                        ),
                      ),
                      // List
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final country = filtered[index];
                            final isSelected = country.countryCode == _selectedCountry.countryCode;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _selectedCountry = country);
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                                      : const Color(0xFF0A0A0A),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: isSelected
                                      ? Border.all(color: const Color(0xFF4E03D0), width: 1.5)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Text(country.flag, style: TextStyle(fontSize: 24.sp)),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        country.countryName,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      country.dialCode,
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF9CA3AF),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (isSelected) ...[
                                      SizedBox(width: 8.w),
                                      Icon(Icons.check_circle, color: const Color(0xFF4E03D0), size: 20.sp),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
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
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Country code selector
              GestureDetector(
                onTap: _showCountryCodePicker,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: const Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountry.flag,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _selectedCountry.dialCode,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF6B7280),
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
              // Phone number input
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d]')),
                    // Cap the local-part at 11 digits — matches
                    // `0XXXXXXXXXX` (NG w/leading 0). The country-code
                    // prefix lives in a separate widget, so 11 is
                    // strictly the local number here.
                    LengthLimitingTextInputFormatter(11),
                  ],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: '8012345678',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF4B5563),
                      fontSize: 16.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!_hasProfilePhone) ...[
          SizedBox(height: 10.h),
          _buildProfilePhoneCta(),
        ],
      ],
    );
  }

  /// Warning pill shown under the phone field when the logged-in user
  /// has no phone on their profile. Matches the airtime recipient
  /// screen's CTA so next time the field auto-prefills.
  Widget _buildProfilePhoneCta() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline,
              color: const Color(0xFFFB923C), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "You haven't set a phone number on your profile.",
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.myAccount),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Set it',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFB923C),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

/// Nickname dialog body — owns its own `TextEditingController` so the
/// controller is disposed through the widget tree's normal teardown
/// rather than synchronously after `Navigator.pop()`. The old inline
/// implementation disposed the controller while the dialog's fade-out
/// animation was still in flight, triggering
/// `dependents.isEmpty is not true` in debug builds.
class _NicknameDialog extends StatefulWidget {
  final String initial;
  const _NicknameDialog({required this.initial});

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final v = _controller.text.trim();
    if (v.isEmpty) {
      setState(() => _error = 'Nickname is required');
      return;
    }
    Navigator.of(context).pop(v);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: InvoiceThemeColors.secondaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text('Save this meter',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Give this meter a nickname so you can find it fast next time.',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: 'e.g. Home, Office',
              hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF4B5563), fontSize: 14.sp),
              errorText: _error,
              filled: true,
              fillColor: InvoiceThemeColors.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                    const BorderSide(color: InvoiceThemeColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                    const BorderSide(color: InvoiceThemeColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                    color: InvoiceThemeColors.primaryPurple),
              ),
            ),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
        ],
      ),
      actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text('Cancel',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400, fontSize: 14.sp)),
        ),
        TextButton(
          onPressed: _submit,
          child: Text('Save',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurple,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
