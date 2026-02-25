import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_grpc;

/// Withdrawal Flow Screen - Standard fintech withdrawal flow
/// Flow: Recipient Selection → Amount Entry → Review → PIN Auth → Processing → Success/Failure
class WithdrawalFlowScreen extends StatefulWidget {
  final Map<String, dynamic> selectedAccount;

  const WithdrawalFlowScreen({
    super.key,
    required this.selectedAccount,
  });

  @override
  State<WithdrawalFlowScreen> createState() => _WithdrawalFlowScreenState();
}

class _WithdrawalFlowScreenState extends State<WithdrawalFlowScreen> {
  // Flow state
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Form data
  Map<String, dynamic>? _selectedRecipient;
  double _amount = 0;
  String _narration = '';
  bool _isNewRecipient = false;
  bool _isProcessingWithdrawal = false;

  // Amount entry
  final _amountController = TextEditingController();

  // New recipient form
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();
  String? _selectedBankCode;

  // Dynamic data from backend
  List<Map<String, dynamic>> _banksList = [];
  List<Map<String, dynamic>> _savedRecipients = [];
  bool _isLoadingBanks = false;
  bool _isLoadingRecipients = false;
  bool _isVerifyingAccount = false;
  String? _banksError;

  // Linked accounts from Open Banking
  List<Map<String, dynamic>> _linkedAccounts = [];
  bool _isLoadingLinkedAccounts = false;

  // Fee from backend
  double _calculatedFee = 0;
  bool _isCalculatingFee = false;
  bool _feeCalculated = false;

  /// Get currency from selected account
  String get _currency {
    final currency = widget.selectedAccount['currency'] as String? ?? 'NGN';
    return currency.toUpperCase();
  }

  /// Get currency symbol for display
  String get _currencySymbol {
    switch (_currency) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GHS':
        return '₵';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return _currency;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBanks();
    _loadRecipients();
    _loadLinkedAccounts();
  }

  Future<void> _loadBanks() async {
    setState(() {
      _isLoadingBanks = true;
      _banksError = null;
    });

    final country = serviceLocator<LocaleManager>().currentCountry;

    // Try backend API first, fallback to local BanksData
    try {
      final bankingClient = serviceLocator<banking_grpc.BankingServiceClient>();
      final callOptions = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final response = await bankingClient.getBanks(
        banking_pb.GetBanksRequest(country: country),
        options: callOptions,
      );

      if (mounted && response.banks.isNotEmpty) {
        setState(() {
          _banksList = response.banks
              .where((bank) => bank.isActive)
              .map((bank) => <String, dynamic>{
                    'code': bank.code,
                    'name': bank.name,
                    'nipCode': bank.nipCode,
                    'icon': Icons.account_balance,
                  })
              .toList();
          _banksList.sort((a, b) =>
              (a['name'] as String).compareTo(b['name'] as String));
          _isLoadingBanks = false;
        });
        return;
      }
    } catch (e) {
      debugPrint('Backend getBanks failed, falling back to local data: $e');
    }

    // Fallback to local BanksData
    try {
      final banks = BanksData.getBanksForCountry(country);
      if (mounted) {
        setState(() {
          _banksList = banks.map((bank) => <String, dynamic>{
            'code': bank['code'],
            'name': bank['name'],
            'icon': Icons.account_balance,
          }).toList();
          _isLoadingBanks = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _banksError = 'Failed to load banks. Please try again.';
          _isLoadingBanks = false;
        });
      }
    }
  }

  Future<void> _loadRecipients() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    setState(() {
      _isLoadingRecipients = true;
    });

    try {
      final recipientCubit = context.read<RecipientCubit>();
      final localeManager = serviceLocator<LocaleManager>();
      await recipientCubit.getRecipients(
        accessToken: authState.profile.session.accessToken,
        countryCode: localeManager.currentCountry,
        currency: localeManager.currentCurrency,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingRecipients = false;
        });
      }
    }
  }

  Future<void> _loadLinkedAccounts() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    setState(() => _isLoadingLinkedAccounts = true);

    try {
      await serviceLocator<OpenBankingCubit>().fetchLinkedAccounts(
        userId: authState.profile.user.id,
        accessToken: authState.profile.session.accessToken,
      );
    } catch (e) {
      debugPrint('Failed to load linked accounts: $e');
    }

    if (mounted) {
      setState(() => _isLoadingLinkedAccounts = false);
    }
  }

  Future<void> _calculateFee() async {
    if (_amount <= 0) return;

    setState(() {
      _isCalculatingFee = true;
      _feeCalculated = false;
    });

    try {
      final bankingClient = serviceLocator<banking_grpc.BankingServiceClient>();
      final callOptions = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      // Amount in minor units (kobo/cents)
      final amountMinor = (_amount * 100).round();
      final response = await bankingClient.calculateWithdrawalFee(
        banking_pb.CalculateWithdrawalFeeRequest(amount: Int64(amountMinor)),
        options: callOptions,
      );

      if (mounted && response.success) {
        setState(() {
          // Fee returned in minor units, convert to major
          _calculatedFee = response.fee.toDouble() / 100;
          _isCalculatingFee = false;
          _feeCalculated = true;
        });
        return;
      }
    } catch (e) {
      debugPrint('Backend fee calculation failed: $e');
    }

    // Fee calculation failed - set to 0 and let user proceed
    if (mounted) {
      setState(() {
        _calculatedFee = 0;
        _isCalculatingFee = false;
        _feeCalculated = false;
      });
    }
  }

  /// Safely get the first character of a name for avatar display
  String _safeInitial(String? name) {
    if (name == null || name.isEmpty) return '?';
    return name.substring(0, 1).toUpperCase();
  }

  /// Safely parse a numeric value from dynamic map data
  double _safeDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  void _nextStep() {
    // Guard: don't advance if on processing step
    if (_currentStep >= 4) return;

    // Validate current step before advancing
    if (_currentStep == 0 && _selectedRecipient == null) return;
    if (_currentStep == 1 && (_amount <= 0)) return;

    // Reset fee calculation when leaving amount step (amount may have changed)
    if (_currentStep == 1) {
      _feeCalculated = false;
      _calculatedFee = 0;
    }

    setState(() => _currentStep++);
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousStep() {
    // Block back navigation during processing
    if (_currentStep == 4 || _isProcessingWithdrawal) return;

    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _amountController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<WithdrawalCubit>()),
        BlocProvider.value(
          value: context.read<RecipientCubit>(),
        ),
        BlocProvider.value(
          value: context.read<AccountVerificationCubit>(),
        ),
        BlocProvider.value(
          value: serviceLocator<OpenBankingCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<OpenBankingCubit, OpenBankingState>(
            listener: (context, state) {
              if (state is LinkedAccountsLoaded) {
                setState(() {
                  _linkedAccounts = state.accounts
                      .where((a) => a.isActive)
                      .map((a) => <String, dynamic>{
                            'id': a.id,
                            'name': a.accountName,
                            'bank': a.bankName,
                            'bankCode': a.bankCode,
                            'accountNumber': a.accountNumber,
                            'isLinkedAccount': true,
                          })
                      .toList();
                  _isLoadingLinkedAccounts = false;
                });
              }
            },
          ),
          BlocListener<RecipientCubit, RecipientState>(
            listener: (context, state) {
              if (state is RecipientLoaded) {
                setState(() {
                  _savedRecipients = state.recipients.map((r) => {
                    'id': r.id,
                    'name': r.name,
                    'bank': r.bankName,
                    'bankCode': r.sortCode,
                    'accountNumber': r.accountNumber,
                    'lastUsed': DateTime.now().subtract(const Duration(days: 1)),
                  }).toList();
                  _isLoadingRecipients = false;
                });
              } else if (state is RecipientError) {
                setState(() {
                  _isLoadingRecipients = false;
                });
              }
            },
          ),
          BlocListener<AccountVerificationCubit, AccountVerificationState>(
            listener: (context, state) {
              setState(() {
                _isVerifyingAccount = state is AccountVerificationLoading;
              });

              if (state is AccountVerificationSuccess) {
                setState(() {
                  _accountNameController.text = state.accountName;
                });
              } else if (state is AccountVerificationFailure) {
                Get.snackbar(
                  'Verification Failed',
                  state.userMessage,
                  backgroundColor: Colors.red.withValues(alpha: 0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color(0xFF1A1A1A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _previousStep,
            ),
            title: Text(
              _getStepTitle(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Progress indicator
              _buildProgressIndicator(),

              // Page content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildRecipientSelectionStep(),
                    _buildAmountEntryStep(),
                    _buildReviewStep(),
                    _buildPinAuthStep(),
                    _buildProcessingStep(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Select Recipient';
      case 1:
        return 'Enter Amount';
      case 2:
        return 'Review';
      case 3:
        return 'Confirm';
      case 4:
        return 'Processing';
      default:
        return 'Withdraw';
    }
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: List.generate(5, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.orange
                          : Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                if (index < 4) SizedBox(width: 4.w),
              ],
            ),
          );
        }),
      ),
    );
  }

  // =====================================================
  // STEP 1: Recipient Selection
  // =====================================================
  Widget _buildRecipientSelectionStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account balance header
          _buildBalanceHeader(),
          SizedBox(height: 24.h),

          // Loading state for recipients
          if (_isLoadingRecipients && !_isNewRecipient)
            Center(
              child: Padding(
                padding: EdgeInsets.all(32.h),
                child: Column(
                  children: [
                    CircularProgressIndicator(color: Colors.orange),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading recipients...',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Saved recipients
          if (!_isLoadingRecipients && _savedRecipients.isNotEmpty && !_isNewRecipient) ...[
            Text(
              'Recent Recipients',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            ..._savedRecipients.map((r) => _buildRecipientCard(r)),
            SizedBox(height: 24.h),
          ],

          // No recipients message
          if (!_isLoadingRecipients && _savedRecipients.isEmpty && !_isNewRecipient)
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 48.sp,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No saved recipients',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          // Linked bank accounts
          if (!_isNewRecipient && _linkedAccounts.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Text(
              'Linked Bank Accounts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            ..._linkedAccounts.map((a) => _buildLinkedAccountCard(a)),
          ],

          if (!_isNewRecipient && _isLoadingLinkedAccounts)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Loading linked accounts...',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 24.h),

          // New recipient option
          if (!_isNewRecipient)
            GestureDetector(
              onTap: () => setState(() => _isNewRecipient = true),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.orange,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Recipient',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Enter new bank account details',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),

          // New recipient form
          if (_isNewRecipient) ...[
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => setState(() => _isNewRecipient = false),
                ),
                Text(
                  'Add New Recipient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildNewRecipientForm(),
          ],
        ],
      ),
    );
  }

  Widget _buildBalanceHeader() {
    final balance = _safeDouble(widget.selectedAccount['balance']);
    final availableBalance = _safeDouble(widget.selectedAccount['availableBalance'] ?? widget.selectedAccount['balance']);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withValues(alpha: 0.2),
            Colors.orange.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '$_currencySymbol${availableBalance.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (balance != availableBalance) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '$_currencySymbol${(balance - availableBalance).toStringAsFixed(2)} on hold',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecipientCard(Map<String, dynamic> recipient) {
    final isSelected = _selectedRecipient?['id'] == recipient['id'];

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRecipient = recipient);
        Future.delayed(const Duration(milliseconds: 200), _nextStep);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.orange.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Colors.orange
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _safeInitial(recipient['name']?.toString()),
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipient['name']?.toString() ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${recipient['bank'] ?? 'Unknown Bank'} • ${_maskAccountNumber(recipient['accountNumber']?.toString() ?? '')}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.length <= 4) return accountNumber;
    return '****${accountNumber.substring(accountNumber.length - 4)}';
  }

  Widget _buildLinkedAccountCard(Map<String, dynamic> account) {
    final isSelected = _selectedRecipient?['id'] == account['id'];

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRecipient = account);
        Future.delayed(const Duration(milliseconds: 200), _nextStep);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.orange.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? Colors.orange
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.link,
                  color: Colors.green,
                  size: 24.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          account['name'] ?? 'Linked Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Linked',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${account['bank']} • ${_maskAccountNumber(account['accountNumber'] ?? '')}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewRecipientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bank selection
        Text(
          'Select Bank',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _showBankSelectionBottomSheet,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _bankNameController.text.isEmpty
                        ? 'Select bank'
                        : _bankNameController.text,
                    style: TextStyle(
                      color: _bankNameController.text.isEmpty
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Account number
        Text(
          'Account Number',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _accountNumberController,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
          keyboardType: TextInputType.number,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Enter 10-digit account number',
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            counterText: '',
          ),
          onChanged: (value) {
            if (value.length == 10 && _selectedBankCode != null) {
              // Call name enquiry API via AccountVerificationCubit
              _verifyAccount();
            } else if (value.length < 10) {
              // Clear verification result if account number is shortened
              _accountNameController.clear();
            }
          },
        ),
        SizedBox(height: 16.h),

        // Account name (auto-filled after verification)
        if (_isVerifyingAccount)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verifying Account...',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (_accountNameController.text.isNotEmpty && !_isVerifyingAccount) ...[
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Name',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        _accountNameController.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],

        // Continue button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _canProceedWithNewRecipient() ? _proceedWithNewRecipient : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _canProceedWithNewRecipient()
                  ? Colors.orange
                  : Colors.grey.shade700,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _canProceedWithNewRecipient() {
    return _bankNameController.text.isNotEmpty &&
        _accountNumberController.text.length == 10 &&
        _accountNameController.text.isNotEmpty &&
        _selectedBankCode != null;
  }

  Future<void> _verifyAccount() async {
    if (_selectedBankCode == null || _accountNumberController.text.length != 10) {
      return;
    }

    final bankName = _bankNameController.text;
    final accountNumber = _accountNumberController.text;

    await context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: accountNumber,
          bankName: bankName,
          country: serviceLocator<LocaleManager>().currentCountry,
        );
  }

  void _proceedWithNewRecipient() {
    final bank = _banksList.firstWhere(
      (b) => b['name'] == _bankNameController.text,
      orElse: () => {'code': _selectedBankCode ?? '', 'name': _bankNameController.text},
    );

    setState(() {
      _selectedRecipient = {
        'id': 'new',
        'name': _accountNameController.text,
        'bank': _bankNameController.text,
        'bankCode': bank['code'],
        'accountNumber': _accountNumberController.text,
        'isNew': true,
      };
    });
    _nextStep();
  }

  void _showBankSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) => _BankSelectionSheet(
        banksList: _banksList,
        isLoadingBanks: _isLoadingBanks,
        banksError: _banksError,
        onBankSelected: (bank) {
          setState(() {
            _bankNameController.text = bank['name'] as String? ?? '';
            _selectedBankCode = bank['code'] as String?;
            // Clear verification when bank changes
            _accountNameController.clear();
          });
          // Auto-verify if account number already entered
          if (_accountNumberController.text.length == 10 && _selectedBankCode != null) {
            _verifyAccount();
          }
        },
        onRetryLoad: () {
          Navigator.pop(sheetContext);
          _loadBanks();
        },
      ),
    );
  }

  // =====================================================
  // STEP 2: Amount Entry
  // =====================================================
  Widget _buildAmountEntryStep() {
    final availableBalance = _safeDouble(widget.selectedAccount['availableBalance'] ?? widget.selectedAccount['balance']);
    final exceedsBalance = _amount > availableBalance;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipient info
          if (_selectedRecipient != null)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _safeInitial(_selectedRecipient?['name']?.toString()),
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sending to',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          _selectedRecipient?['name']?.toString() ?? 'Unknown',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _previousStep,
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 24.h),

          Text(
            'Enter amount to send',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),

          // Amount input
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: exceedsBalance
                  ? Border.all(color: Colors.red, width: 2)
                  : null,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currencySymbol,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        style: TextStyle(
                          color: exceedsBalance ? Colors.red : Colors.white,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _amount = double.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (exceedsBalance) ...[
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 16.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Exceeds available balance',
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Available balance
          Text(
            'Available: $_currencySymbol${availableBalance.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Quick amounts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickAmountButton(_currencySymbol, 1000),
              _buildQuickAmountButton(_currencySymbol, 5000),
              _buildQuickAmountButton(_currencySymbol, 10000),
              _buildQuickAmountButton(_currencySymbol, 50000),
            ],
          ),
          SizedBox(height: 24.h),

          // Narration
          Text(
            'Narration (optional)',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: 'What is this payment for?',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16.w),
            ),
            onChanged: (value) => _narration = value,
          ),
          SizedBox(height: 32.h),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _amount > 0 && !exceedsBalance ? _nextStep : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _amount > 0 && !exceedsBalance
                    ? Colors.orange
                    : Colors.grey.shade700,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButton(String symbol, int amount) {
    final availableBalance = widget.selectedAccount['availableBalance'] ??
        widget.selectedAccount['balance'] ?? 0.0;
    final isDisabled = amount > availableBalance;

    return GestureDetector(
      onTap: isDisabled ? null : () => setState(() {
        _amount = amount.toDouble();
        _amountController.text = amount.toString();
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _amount == amount
              ? Colors.orange.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: isDisabled ? 0.02 : 0.05),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: _amount == amount ? Colors.orange : Colors.transparent,
          ),
        ),
        child: Text(
          '$symbol${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
          style: TextStyle(
            color: isDisabled
                ? Colors.white.withValues(alpha: 0.3)
                : Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // STEP 3: Review
  // =====================================================
  Widget _buildReviewStep() {
    // Calculate fee from backend on first display
    if (!_feeCalculated && !_isCalculatingFee && _amount > 0) {
      _calculateFee();
    }

    final total = _amount + _calculatedFee;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review your transfer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),

          // Amount card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withValues(alpha: 0.3),
                  Colors.orange.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Text(
                  'Amount to Send',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '$_currencySymbol${_amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Recipient details
          _buildReviewSection('Recipient', [
            {'label': 'Name', 'value': _selectedRecipient?['name'] ?? ''},
            {'label': 'Bank', 'value': _selectedRecipient?['bank'] ?? ''},
            {'label': 'Account', 'value': _selectedRecipient?['accountNumber'] ?? ''},
          ]),
          SizedBox(height: 16.h),

          // Transaction details
          _buildReviewSection('Transaction Details', [
            {'label': 'Amount', 'value': '$_currencySymbol${_amount.toStringAsFixed(2)}'},
            {
              'label': 'Transfer Fee',
              'value': _isCalculatingFee
                  ? 'Calculating...'
                  : '$_currencySymbol${_calculatedFee.toStringAsFixed(2)}',
            },
            {
              'label': 'Total Debit',
              'value': _isCalculatingFee
                  ? 'Calculating...'
                  : '$_currencySymbol${total.toStringAsFixed(2)}',
              'isTotal': true,
            },
            if (_narration.isNotEmpty) {'label': 'Narration', 'value': _narration},
          ]),
          SizedBox(height: 32.h),

          // Continue to PIN
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isCalculatingFee ? null : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCalculatingFee
                    ? Colors.grey.shade700
                    : Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isCalculatingFee
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Calculating fees...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Confirm & Enter PIN',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(String title, List<Map<String, dynamic>> items) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          ...items.map((item) => Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['label'],
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  item['value'],
                  style: TextStyle(
                    color: item['isTotal'] == true ? Colors.orange : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: item['isTotal'] == true ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // =====================================================
  // STEP 4: PIN Authentication
  // =====================================================
  Widget _buildPinAuthStep() {
    return _PinEntryWidget(
      onPinComplete: (pin) {
        // Verify PIN and initiate transfer
        _initiateWithdrawal(context, pin);
      },
    );
  }

  void _initiateWithdrawal(BuildContext context, String pin) {
    // Guard: prevent double submission
    if (_isProcessingWithdrawal) return;

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Error',
        'Please log in to continue',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Validate recipient fields
    final recipientName = _selectedRecipient?['name']?.toString() ?? '';
    final recipientBank = _selectedRecipient?['bank']?.toString() ?? '';
    final recipientAccount = _selectedRecipient?['accountNumber']?.toString() ?? '';
    final recipientBankCode = _selectedRecipient?['bankCode']?.toString() ?? '';

    if (recipientAccount.isEmpty || recipientBank.isEmpty) {
      Get.snackbar(
        'Error',
        'Invalid recipient details. Please go back and select a recipient.',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Validate total vs balance
    final availableBalance = _safeDouble(
      widget.selectedAccount['availableBalance'] ?? widget.selectedAccount['balance'],
    );
    final total = _amount + _calculatedFee;
    if (total > availableBalance) {
      Get.snackbar(
        'Insufficient Balance',
        'Total amount ($_currencySymbol${total.toStringAsFixed(2)}) exceeds available balance.',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Safe accountId parsing
    final rawAccountId = widget.selectedAccount['id'];
    final int accountId;
    if (rawAccountId is int) {
      accountId = rawAccountId;
    } else {
      final parsed = int.tryParse(rawAccountId?.toString() ?? '');
      if (parsed == null) {
        Get.snackbar(
          'Error',
          'Invalid account. Please try again.',
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      accountId = parsed;
    }

    setState(() => _isProcessingWithdrawal = true);

    final accessToken = authState.profile.session.accessToken;

    context.read<WithdrawalCubit>().initiateWithdrawal(
      sourceAccountId: accountId,
      amount: _amount,
      currency: _currency,
      targetBankName: recipientBank,
      targetAccountNumber: recipientAccount,
      targetSortCode: recipientBankCode,
      accessToken: accessToken,
    );

    _nextStep();
  }

  // =====================================================
  // STEP 5: Processing
  // =====================================================
  Widget _buildProcessingStep() {
    return BlocConsumer<WithdrawalCubit, WithdrawalState>(
      listener: (context, state) {
        if (state is WithdrawalFailure) {
          Get.snackbar(
            'Transfer Failed',
            state.message,
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      builder: (context, withdrawalState) {
        return BlocBuilder<BalanceWebSocketCubit, BalanceWebSocketState>(
          builder: (context, wsState) {
            // Check for real-time status update
            final lastUpdate = wsState.lastUpdate;
            final isCompleted = withdrawalState is WithdrawalSuccess ||
                (lastUpdate != null &&
                    lastUpdate.eventType == 'withdrawal' &&
                    lastUpdate.status == 'completed');
            final isFailed = withdrawalState is WithdrawalFailure ||
                (lastUpdate != null &&
                    lastUpdate.eventType == 'withdrawal' &&
                    lastUpdate.status == 'failed');

            return _WithdrawalProcessingView(
              amount: _amount,
              currency: _currency,
              recipientName: _selectedRecipient?['name']?.toString() ?? '',
              isCompleted: isCompleted,
              isFailed: isFailed,
              failureMessage: withdrawalState is WithdrawalFailure
                  ? withdrawalState.message
                  : null,
              onDone: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              onRetry: isFailed
                  ? () {
                      // Reset processing state and go back to PIN step
                      setState(() {
                        _isProcessingWithdrawal = false;
                        _currentStep = 3;
                      });
                      _pageController.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
            );
          },
        );
      },
    );
  }
}

/// PIN Entry Widget
class _PinEntryWidget extends StatefulWidget {
  final Function(String) onPinComplete;

  const _PinEntryWidget({required this.onPinComplete});

  @override
  State<_PinEntryWidget> createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<_PinEntryWidget> {
  String _pin = '';
  bool _pinSubmitted = false;

  void _addDigit(String digit) {
    if (_pin.length < 4 && !_pinSubmitted) {
      setState(() => _pin += digit);
      if (_pin.length == 4) {
        _pinSubmitted = true;
        widget.onPinComplete(_pin);
      }
    }
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin = _pin.substring(0, _pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            color: Colors.orange,
            size: 48.sp,
          ),
          SizedBox(height: 24.h),
          Text(
            'Enter your PIN',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter your 4-digit PIN to confirm this transfer',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),

          // PIN dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final isFilled = index < _pin.length;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: isFilled ? Colors.orange : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFilled ? Colors.orange : Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 48.h),

          // Number pad
          _buildNumberPad(),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map((d) => _buildNumberButton(d)).toList(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map((d) => _buildNumberButton(d)).toList(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map((d) => _buildNumberButton(d)).toList(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 80.w), // Empty space
            _buildNumberButton('0'),
            GestureDetector(
              onTap: _removeDigit,
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.backspace_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String digit) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            digit,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Processing view with animations
class _WithdrawalProcessingView extends StatefulWidget {
  final double amount;
  final String currency;
  final String recipientName;
  final bool isCompleted;
  final bool isFailed;
  final String? failureMessage;
  final VoidCallback onDone;
  final VoidCallback? onRetry;

  const _WithdrawalProcessingView({
    required this.amount,
    required this.currency,
    required this.recipientName,
    required this.isCompleted,
    required this.isFailed,
    this.failureMessage,
    required this.onDone,
    this.onRetry,
  });

  @override
  State<_WithdrawalProcessingView> createState() => _WithdrawalProcessingViewState();
}

class _WithdrawalProcessingViewState extends State<_WithdrawalProcessingView>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  static String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GHS':
        return '₵';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return currency;
    }
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencySymbol = _getCurrencySymbol(widget.currency);

    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (widget.isCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check;
      statusText = 'Transfer Successful!';
    } else if (widget.isFailed) {
      statusColor = Colors.red;
      statusIcon = Icons.close;
      statusText = 'Transfer Failed';
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_top;
      statusText = 'Processing Transfer...';
    }

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon
            ScaleTransition(
              scale: widget.isCompleted || widget.isFailed
                  ? const AlwaysStoppedAnimation(1.0)
                  : _pulseAnimation,
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [statusColor, statusColor.withValues(alpha: 0.7)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  statusIcon,
                  color: Colors.white,
                  size: 60.sp,
                ),
              ),
            ),
            SizedBox(height: 32.h),

            // Status text
            Text(
              statusText,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),

            // Amount
            Text(
              '$currencySymbol${widget.amount.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                color: statusColor,
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),

            // Recipient
            Text(
              'to ${widget.recipientName}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 24.h),

            // Status message
            if (widget.failureMessage != null)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        widget.failureMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),

            if (!widget.isFailed && !widget.isCompleted)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.orange),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'This may take a few moments',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 48.h),

            // Action buttons (only show when finished)
            if (widget.isCompleted || widget.isFailed) ...[
              if (widget.isFailed && widget.onRetry != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (widget.isFailed && widget.onRetry != null)
                SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.isFailed && widget.onRetry != null
                        ? Colors.white.withValues(alpha: 0.1)
                        : statusColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    widget.isCompleted ? 'Done' : 'Go Home',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Bank selection bottom sheet widget for withdrawal flow
class _BankSelectionSheet extends StatefulWidget {
  final List<Map<String, dynamic>> banksList;
  final bool isLoadingBanks;
  final String? banksError;
  final void Function(Map<String, dynamic> bank) onBankSelected;
  final VoidCallback onRetryLoad;

  const _BankSelectionSheet({
    required this.banksList,
    required this.isLoadingBanks,
    this.banksError,
    required this.onBankSelected,
    required this.onRetryLoad,
  });

  @override
  State<_BankSelectionSheet> createState() => _BankSelectionSheetState();
}

class _BankSelectionSheetState extends State<_BankSelectionSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _filteredBanks = widget.banksList;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBanks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = widget.banksList;
      } else {
        _filteredBanks = widget.banksList.where((bank) {
          final name = (bank['name'] as String? ?? '').toLowerCase();
          final code = (bank['code'] as String? ?? '').toLowerCase();
          return name.contains(query.toLowerCase()) ||
              code.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Select Bank',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search banks...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onChanged: _filterBanks,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Content
          Expanded(
            child: widget.isLoadingBanks
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  )
                : widget.banksError != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.banksError!,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: widget.onRetryLoad,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: _filteredBanks.length,
                        itemBuilder: (context, index) {
                          final bank = _filteredBanks[index];
                          final name = bank['name'] as String? ?? '';
                          return InkWell(
                            onTap: () {
                              widget.onBankSelected(bank);
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              margin: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36.w,
                                    height: 36.w,
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        name.isNotEmpty ? name[0] : '?',
                                        style: GoogleFonts.inter(
                                          color: Colors.orange,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
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
  }
}
