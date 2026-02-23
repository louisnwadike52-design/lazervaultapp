import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../widgets/rate_countdown_widget.dart';
import '../../domain/repositories/i_exchange_repository.dart';

// ---------------------------------------------------------------------------
// Currency → Country config (derived, no picker)
// ---------------------------------------------------------------------------

enum _FieldType { african, uk, us, eu, generic }

class _CurrencyCountryConfig {
  final String countryCode;
  final String countryName;
  final String flag;
  final _FieldType fieldType;
  final bool supportsAutoVerify;

  const _CurrencyCountryConfig({
    required this.countryCode,
    required this.countryName,
    required this.flag,
    required this.fieldType,
    this.supportsAutoVerify = false,
  });

  static _CurrencyCountryConfig fromCurrency(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return const _CurrencyCountryConfig(
          countryCode: 'NG',
          countryName: 'Nigeria',
          flag: '\u{1F1F3}\u{1F1EC}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'GHS':
        return const _CurrencyCountryConfig(
          countryCode: 'GH',
          countryName: 'Ghana',
          flag: '\u{1F1EC}\u{1F1ED}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'KES':
        return const _CurrencyCountryConfig(
          countryCode: 'KE',
          countryName: 'Kenya',
          flag: '\u{1F1F0}\u{1F1EA}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'ZAR':
        return const _CurrencyCountryConfig(
          countryCode: 'ZA',
          countryName: 'South Africa',
          flag: '\u{1F1FF}\u{1F1E6}',
          fieldType: _FieldType.african,
          supportsAutoVerify: true,
        );
      case 'GBP':
        return const _CurrencyCountryConfig(
          countryCode: 'GB',
          countryName: 'United Kingdom',
          flag: '\u{1F1EC}\u{1F1E7}',
          fieldType: _FieldType.uk,
        );
      case 'USD':
        return const _CurrencyCountryConfig(
          countryCode: 'US',
          countryName: 'United States',
          flag: '\u{1F1FA}\u{1F1F8}',
          fieldType: _FieldType.us,
        );
      case 'EUR':
        return const _CurrencyCountryConfig(
          countryCode: 'EU',
          countryName: 'Europe',
          flag: '\u{1F1EA}\u{1F1FA}',
          fieldType: _FieldType.eu,
        );
      default:
        // Safe substring: use full currency if shorter than 2 chars
        final code = currency.length >= 2
            ? currency.substring(0, 2).toUpperCase()
            : currency.toUpperCase();
        return _CurrencyCountryConfig(
          countryCode: code,
          countryName: currency,
          flag: '\u{1F3F3}\u{FE0F}',
          fieldType: _FieldType.generic,
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Sort code formatter: XX-XX-XX
// ---------------------------------------------------------------------------

class _SortCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 6) {
      return oldValue;
    }
    // Count how many raw digits are before the cursor in the new input
    final cursorPos = newValue.selection.baseOffset.clamp(0, newValue.text.length);
    int digitsBefore = newValue.text.substring(0, cursorPos).replaceAll(RegExp(r'[^0-9]'), '').length;

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) buffer.write('-');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();

    // Map digitsBefore back to a position in the formatted string
    int newCursorPos = 0;
    int digitCount = 0;
    for (int i = 0; i < formatted.length && digitCount < digitsBefore; i++) {
      newCursorPos = i + 1;
      if (formatted[i] != '-') digitCount++;
    }
    newCursorPos = newCursorPos.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
}

// ---------------------------------------------------------------------------
// IBAN formatter: groups of 4 separated by spaces
// ---------------------------------------------------------------------------

class _IbanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleaned =
        newValue.text.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();
    if (cleaned.length > 34) {
      return oldValue;
    }
    // Count how many alphanumeric chars are before the cursor
    final cursorPos = newValue.selection.baseOffset.clamp(0, newValue.text.length);
    int charsBefore = newValue.text.substring(0, cursorPos).replaceAll(RegExp(r'[^A-Za-z0-9]'), '').length;

    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    final formatted = buffer.toString();

    // Map charsBefore back to a position in the formatted string
    int newCursorPos = 0;
    int charCount = 0;
    for (int i = 0; i < formatted.length && charCount < charsBefore; i++) {
      newCursorPos = i + 1;
      if (formatted[i] != ' ') charCount++;
    }
    newCursorPos = newCursorPos.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class ExchangeRecipientScreen extends StatefulWidget {
  const ExchangeRecipientScreen({super.key});

  @override
  State<ExchangeRecipientScreen> createState() =>
      _ExchangeRecipientScreenState();
}

class _ExchangeRecipientScreenState extends State<ExchangeRecipientScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  // Navigation
  final _pageController = PageController();
  int _currentPage = 0;

  // Form keys
  final _step1FormKey = GlobalKey<FormState>();
  final _step2FormKey = GlobalKey<FormState>();

  // Step 1 controllers
  final _accountController = TextEditingController();
  final _sortCodeController = TextEditingController();
  final _routingController = TextEditingController();
  final _ibanController = TextEditingController();

  // Step 2 controllers
  final _nameController = TextEditingController();
  final _swiftController = TextEditingController();
  final _emailController = TextEditingController();

  // Generic fallback controllers
  final _genericBankNameController = TextEditingController();
  final _genericCountryController = TextEditingController();

  // Bank picker state
  String? _selectedBankName;
  String? _selectedBankCode;

  // Verification state
  String? _verifiedAccountName;
  bool _isManualNameEntry = false;
  String? _lastVerifiedAccountNumber; // Track what was verified to avoid spurious resets
  String? _lastVerifiedBankCode;

  // Validation error state (replaces hidden validators)
  String? _bankPickerError;
  String? _purposeError;

  // Rate / submission
  bool _isRateExpired = false;
  bool _isSubmitting = false;
  String? _purposeOfPayment;

  // Data from home screen
  late String _fromCurrency;
  late String _toCurrency;
  late double _amount;
  ExchangeRate? _rate;
  late _CurrencyCountryConfig _countryConfig;

  static const _purposes = [
    'Personal payment',
    'Family support',
    'Education fees',
    'Medical expenses',
    'Property purchase',
    'Investment',
    'Business payment',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments is Map<String, dynamic>
        ? Get.arguments as Map<String, dynamic>
        : null;
    if (args != null) {
      _fromCurrency = args['fromCurrency'] as String? ?? 'NGN';
      _toCurrency = args['toCurrency'] as String? ?? 'USD';
      _amount = args['amount'] as double? ?? 0;
      _rate = args['rate'] as ExchangeRate?;
      final mode = args['mode'] as ExchangeMode? ?? ExchangeMode.sendAbroad;

      if (_rate != null) {
        context.read<ExchangeCubit>().initFromArguments(
              from: _fromCurrency,
              to: _toCurrency,
              amount: _amount,
              rate: _rate!,
              mode: mode,
            );
      }
    } else {
      final cubit = context.read<ExchangeCubit>();
      _fromCurrency = cubit.fromCurrency;
      _toCurrency = cubit.toCurrency;
      _amount = cubit.amount;
      _rate = cubit.currentRate;
    }
    _countryConfig = _CurrencyCountryConfig.fromCurrency(_toCurrency);

    // Pre-fill generic country code from derived config
    if (_countryConfig.fieldType == _FieldType.generic) {
      _genericCountryController.text = _countryConfig.countryCode;
    }

    // Listen for account/bank changes to reset verification state
    _accountController.addListener(_onBankDetailsChanged);
  }

  @override
  void dispose() {
    _accountController.removeListener(_onBankDetailsChanged);
    _pageController.dispose();
    _accountController.dispose();
    _sortCodeController.dispose();
    _routingController.dispose();
    _ibanController.dispose();
    _nameController.dispose();
    _swiftController.dispose();
    _emailController.dispose();
    _genericBankNameController.dispose();
    _genericCountryController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Input change listener — reset stale verification
  // ---------------------------------------------------------------------------

  void _onBankDetailsChanged() {
    if (_verifiedAccountName == null) return;
    // Only reset if the account number actually changed from what was verified
    final currentAccount = _accountController.text.trim();
    if (currentAccount == _lastVerifiedAccountNumber &&
        _selectedBankCode == _lastVerifiedBankCode) {
      return;
    }
    setState(() {
      _verifiedAccountName = null;
      _isManualNameEntry = false;
      _lastVerifiedAccountNumber = null;
      _lastVerifiedBankCode = null;
    });
    context.read<AccountVerificationCubit>().reset();
  }

  void _onBankSelected(String name, String code) {
    final bankChanged = _selectedBankCode != code;
    setState(() {
      _selectedBankName = name;
      _selectedBankCode = code;
      _bankPickerError = null;
    });
    if (bankChanged) {
      // Trigger the same change-detection as account number edits
      _onBankDetailsChanged();
    }
  }

  // ---------------------------------------------------------------------------
  // Navigation helpers
  // ---------------------------------------------------------------------------

  void _goToStep2() {
    if (_step1FormKey.currentState?.validate() != true) return;

    // Validate bank picker for field types that require it
    if (_countryConfig.fieldType != _FieldType.eu &&
        _countryConfig.fieldType != _FieldType.generic &&
        _selectedBankCode == null) {
      setState(() => _bankPickerError = 'Please select a bank');
      return;
    }

    FocusScope.of(context).unfocus();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = 1);
  }

  void _goBackToStep1() {
    FocusScope.of(context).unfocus();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = 0);
  }

  // ---------------------------------------------------------------------------
  // Account verification (African countries)
  // ---------------------------------------------------------------------------

  void _verifyAccount() {
    if (_step1FormKey.currentState?.validate() != true) return;
    if (_selectedBankCode == null) {
      setState(() => _bankPickerError = 'Please select a bank');
      return;
    }

    FocusScope.of(context).unfocus();
    context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: _accountController.text.trim(),
          bankName: _selectedBankName ?? '',
          country: _countryConfig.countryCode,
        );
  }

  // ---------------------------------------------------------------------------
  // Confirm & Send
  // ---------------------------------------------------------------------------

  void _onConfirmAndSend() async {
    if (_isSubmitting) return;
    if (_step2FormKey.currentState?.validate() != true) return;

    // Validate purpose (not in form, uses dropdown state)
    if (_purposeOfPayment == null) {
      setState(() => _purposeError = 'Please select a purpose');
      return;
    }

    // Guard: rate must exist before attempting transfer
    if (_rate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exchange rate unavailable. Please go back and refresh.'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();
    final cubit = context.read<ExchangeCubit>();

    if (!cubit.checkRateValidity()) {
      setState(() => _isRateExpired = true);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Determine recipient bank code based on country type
      String? recipientBankCode;
      switch (_countryConfig.fieldType) {
        case _FieldType.uk:
          recipientBankCode =
              _sortCodeController.text.replaceAll('-', '').trim();
        case _FieldType.us:
          recipientBankCode = _routingController.text.trim();
        case _FieldType.african:
          recipientBankCode = _selectedBankCode;
        case _FieldType.generic:
          recipientBankCode = _selectedBankCode;
        case _FieldType.eu:
          recipientBankCode = null;
      }

      // Determine account number
      String accountNumber;
      if (_countryConfig.fieldType == _FieldType.eu) {
        accountNumber = _ibanController.text.replaceAll(' ', '').trim();
      } else {
        accountNumber = _accountController.text.trim();
      }

      // Determine recipient name
      String recipientName;
      if (_verifiedAccountName != null && !_isManualNameEntry) {
        recipientName = _verifiedAccountName!;
      } else {
        recipientName = _nameController.text.trim();
      }

      // Determine bank name (generic fallback uses manual field)
      String recipientBankName;
      if (_countryConfig.fieldType == _FieldType.generic) {
        recipientBankName = _genericBankNameController.text.trim();
      } else if (_countryConfig.fieldType == _FieldType.eu) {
        // Derive bank name from IBAN country code to avoid empty backend value
        final iban = _ibanController.text.replaceAll(' ', '').trim();
        final ibanCountry = iban.length >= 2 ? iban.substring(0, 2) : 'EU';
        recipientBankName = 'SEPA Bank ($ibanCountry)';
      } else {
        recipientBankName = _selectedBankName ?? '';
      }

      // Determine country (generic fallback uses manual field)
      String recipientCountry;
      if (_countryConfig.fieldType == _FieldType.generic) {
        recipientCountry = _genericCountryController.text.trim().isNotEmpty
            ? _genericCountryController.text.trim().toUpperCase()
            : _countryConfig.countryCode;
      } else {
        recipientCountry = _countryConfig.countryCode;
      }

      await validateTransactionPin(
        context: context,
        transactionId: 'exchange-${DateTime.now().millisecondsSinceEpoch}',
        transactionType: 'international_transfer',
        amount: cubit.amount,
        currency: cubit.fromCurrency,
        onPinValidated: (verificationToken) async {
          pinModalKey.currentState?.setProcessing();

          await cubit.initiateTransfer(
            verificationToken: verificationToken,
            recipientName: recipientName,
            recipientAccountNumber: accountNumber,
            recipientBankName: recipientBankName,
            recipientBankCode: recipientBankCode,
            recipientSwiftCode: _swiftController.text.trim().isNotEmpty
                ? _swiftController.text.trim()
                : null,
            recipientCountry: recipientCountry,
            recipientEmail: _emailController.text.trim().isNotEmpty
                ? _emailController.text.trim()
                : null,
            purposeOfPayment: _purposeOfPayment,
          );

          final currentState = cubit.state;
          if (currentState is ExchangeSuccess) {
            pinModalKey.currentState?.setSuccess();
            await Future.delayed(const Duration(milliseconds: 800));
            if (mounted) Navigator.of(context).pop();
            Get.offNamed(
              AppRoutes.exchangeReceipt,
              arguments: currentState.transaction,
            );
          } else if (currentState is ExchangeProcessing) {
            pinModalKey.currentState?.setSuccess();
            await Future.delayed(const Duration(milliseconds: 800));
            if (mounted) Navigator.of(context).pop();
            Get.offNamed(
              AppRoutes.exchangeProcessing,
              arguments: {
                'transactionId': currentState.transactionId,
                'isConversion': currentState.isConversion,
              },
            );
          } else if (currentState is ExchangeError) {
            final errorMsg = currentState.message;
            cubit.restoreHomeState();
            throw Exception(errorMsg);
          }
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _refreshRate() {
    context.read<ExchangeCubit>().fetchRate();
    setState(() => _isRateExpired = false);
  }

  // ---------------------------------------------------------------------------
  // Bank picker bottom sheet
  // ---------------------------------------------------------------------------

  void _showBankPicker() {
    FocusScope.of(context).unfocus();
    final banks = BanksData.getBanksForCountry(_countryConfig.countryCode);
    final popular =
        BanksData.getPopularBanksForCountry(_countryConfig.countryCode);
    String searchQuery = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (_, setSheetState) {
            final filtered = searchQuery.isEmpty
                ? banks
                : BanksData.searchBanks(
                    _countryConfig.countryCode, searchQuery);

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4B4B4B),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Title
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Select Bank',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Search
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search banks...',
                        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                        prefixIcon: const Icon(Icons.search,
                            color: Color(0xFF6B7280)),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                      ),
                      onChanged: (v) =>
                          setSheetState(() => searchQuery = v),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Popular banks section
                  if (searchQuery.isEmpty && popular.isNotEmpty) ...[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Popular',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: popular.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          final bank = popular[i];
                          final isSelected =
                              bank['code'] == _selectedBankCode;
                          return GestureDetector(
                            onTap: () {
                              _onBankSelected(bank['name']!, bank['code']!);
                              Navigator.pop(sheetContext);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF3B82F6)
                                        .withValues(alpha: 0.2)
                                    : const Color(0xFF2D2D2D),
                                borderRadius: BorderRadius.circular(20),
                                border: isSelected
                                    ? Border.all(
                                        color: const Color(0xFF3B82F6))
                                    : null,
                              ),
                              child: Text(
                                _bankChipLabel(bank['name']!),
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF3B82F6)
                                      : Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(color: Color(0xFF2D2D2D), height: 1),
                    ),
                  ],
                  // Full list
                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(
                            child: Text(
                              'No banks found',
                              style: TextStyle(color: Color(0xFF6B7280)),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (_, i) {
                              final bank = filtered[i];
                              final isSelected =
                                  bank['code'] == _selectedBankCode;
                              return ListTile(
                                leading: _buildBankAvatar(bank['name']!),
                                title: Text(
                                  bank['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  bank['code']!,
                                  style: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: isSelected
                                    ? const Icon(Icons.check_circle,
                                        color: Color(0xFF3B82F6), size: 20)
                                    : null,
                                onTap: () {
                                  _onBankSelected(
                                      bank['name']!, bank['code']!);
                                  Navigator.pop(sheetContext);
                                },
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
  }

  /// Short label for popular bank chip. Safe against empty names.
  String _bankChipLabel(String name) {
    final words = name.split(' ').where((w) => w.isNotEmpty).toList();
    return words.isNotEmpty ? words.first : name;
  }

  Widget _buildBankAvatar(String name) {
    final words = name.split(' ').where((w) => w.isNotEmpty).toList();
    final initials = words.take(2).map((w) => w[0]).join().toUpperCase();
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          initials.isNotEmpty ? initials : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for account verification state changes
        BlocListener<AccountVerificationCubit, AccountVerificationState>(
          listener: (context, state) {
            if (state is AccountVerificationSuccess) {
              // Store verified values and advance to step 2 in one setState
              setState(() {
                _verifiedAccountName = state.accountName;
                _isManualNameEntry = false;
                _lastVerifiedAccountNumber = _accountController.text.trim();
                _lastVerifiedBankCode = _selectedBankCode;
                _currentPage = 1;
              });
              FocusScope.of(context).unfocus();
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else if (state is AccountVerificationFailure) {
              if (state.isAccountNotFound) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.userMessage),
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                );
              }
            }
          },
        ),
        // Listen for exchange rate refresh — keep local _rate in sync
        BlocListener<ExchangeCubit, ExchangeState>(
          listener: (context, state) {
            if (state is ExchangeRateLoaded) {
              setState(() {
                _rate = state.rate;
                _isRateExpired = false;
              });
            } else if (state is ExchangeRateExpired) {
              setState(() => _isRateExpired = true);
            }
          },
        ),
      ],
      child: PopScope(
        canPop: _currentPage == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop && _currentPage > 0) {
            _goBackToStep1();
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                if (_currentPage > 0) {
                  _goBackToStep1();
                } else {
                  Get.back();
                }
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text(
              'Recipient Details',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Step indicator dots
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(0),
                    const SizedBox(width: 8),
                    _buildDot(1),
                  ],
                ),
              ),
              // Country header
              _buildCountryHeader(),
              const SizedBox(height: 8),
              // PageView
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildStep1(),
                    _buildStep2(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int step) {
    final isActive = _currentPage == step;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildCountryHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            _countryConfig.flag,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
          Text(
            'Sending to ${_countryConfig.countryName}',
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // STEP 1: Bank Details
  // ===========================================================================

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _step1FormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter bank details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _countryConfig.supportsAutoVerify
                          ? 'We\'ll verify the account holder name automatically'
                          : 'Enter the recipient\'s bank details below',
                      style: const TextStyle(
                          color: Color(0xFF9CA3AF), fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    switch (_countryConfig.fieldType) {
                      _FieldType.african => _buildAfricanBankFields(),
                      _FieldType.uk => _buildUKBankFields(),
                      _FieldType.us => _buildUSBankFields(),
                      _FieldType.eu => _buildEUBankFields(),
                      _FieldType.generic => _buildGenericBankFields(),
                    },
                  ],
                ),
              ),
            ),
          ),
          // Step 1 action button
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: _buildStep1Button(),
            ),
          ),
        ],
      ),
    );
  }

  // ----- African fields -----

  Widget _buildAfricanBankFields() {
    return Column(
      children: [
        _buildBankPickerField(),
        const SizedBox(height: 16),
        _buildField(
          controller: _accountController,
          label: 'Account Number',
          hint: _accountHint,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(_accountMaxLength),
          ],
          validator: _accountNumberValidator,
        ),
        // Verification result inline
        BlocBuilder<AccountVerificationCubit, AccountVerificationState>(
          builder: (context, state) {
            if (state is AccountVerificationLoading) {
              return _buildVerificationLoading();
            }
            if (state is AccountVerificationFailure &&
                !state.isAccountNotFound) {
              return _buildVerificationError(state);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildVerificationLoading() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF3B82F6),
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Verifying account...',
            style: TextStyle(color: Color(0xFF3B82F6), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationError(AccountVerificationFailure state) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.userMessage,
            style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (state.canRetry)
                GestureDetector(
                  onTap: () => context
                      .read<AccountVerificationCubit>()
                      .retryVerification(bankName: _selectedBankName ?? ''),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (state.canRetry && state.allowManualEntry)
                const SizedBox(width: 16),
              if (state.allowManualEntry)
                GestureDetector(
                  onTap: () {
                    // Re-validate in case user changed inputs during verification
                    if (_step1FormKey.currentState?.validate() != true) return;
                    if (_selectedBankCode == null) {
                      setState(() => _bankPickerError = 'Please select a bank');
                      return;
                    }
                    setState(() {
                      _isManualNameEntry = true;
                      _currentPage = 1;
                    });
                    FocusScope.of(context).unfocus();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text(
                    'Enter Name Manually',
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ----- UK fields -----

  Widget _buildUKBankFields() {
    return Column(
      children: [
        _buildBankPickerField(),
        const SizedBox(height: 16),
        _buildField(
          controller: _sortCodeController,
          label: 'Sort Code',
          hint: 'XX-XX-XX',
          keyboardType: TextInputType.number,
          inputFormatters: [_SortCodeFormatter()],
          validator: (v) {
            final digits = (v ?? '').replaceAll('-', '');
            if (digits.length != 6) return 'Sort code must be 6 digits';
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildField(
          controller: _accountController,
          label: 'Account Number',
          hint: 'Enter 8-digit account number',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(8),
          ],
          validator: (v) {
            if ((v ?? '').trim().length != 8) {
              return 'Account number must be 8 digits';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ----- US fields -----

  Widget _buildUSBankFields() {
    return Column(
      children: [
        _buildBankPickerField(),
        const SizedBox(height: 16),
        _buildField(
          controller: _routingController,
          label: 'Routing Number (ABA)',
          hint: 'Enter 9-digit routing number',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(9),
          ],
          validator: (v) {
            if ((v ?? '').trim().length != 9) {
              return 'Routing number must be 9 digits';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildField(
          controller: _accountController,
          label: 'Account Number',
          hint: 'Enter account number',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(17),
          ],
          validator: (v) {
            final len = (v ?? '').trim().length;
            if (len < 4 || len > 17) {
              return 'Account number must be 4-17 digits';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ----- EU fields -----

  Widget _buildEUBankFields() {
    return Column(
      children: [
        _buildField(
          controller: _ibanController,
          label: 'IBAN',
          hint: 'e.g. DE89 3704 0044 0532 0130 00',
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [_IbanFormatter()],
          validator: (v) {
            final cleaned = (v ?? '').replaceAll(' ', '');
            if (cleaned.isEmpty) return 'IBAN is required';
            if (cleaned.length < 15 || cleaned.length > 34) {
              return 'IBAN must be 15-34 characters';
            }
            if (!RegExp(r'^[A-Z]{2}').hasMatch(cleaned)) {
              return 'IBAN must start with a 2-letter country code';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ----- Generic fields (unsupported currencies) -----

  Widget _buildGenericBankFields() {
    return Column(
      children: [
        _buildField(
          controller: _genericBankNameController,
          label: 'Bank Name',
          hint: 'Enter bank name',
          validator: (v) =>
              (v ?? '').trim().isEmpty ? 'Bank name is required' : null,
        ),
        const SizedBox(height: 16),
        _buildField(
          controller: _accountController,
          label: 'Account Number / IBAN',
          hint: 'Enter account number or IBAN',
          validator: (v) =>
              (v ?? '').trim().isEmpty ? 'Account number is required' : null,
        ),
        const SizedBox(height: 16),
        _buildField(
          controller: _genericCountryController,
          label: 'Country Code',
          hint: 'e.g. GB, US, GH',
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
            LengthLimitingTextInputFormatter(2),
          ],
          validator: (v) => (v ?? '').trim().length != 2
              ? 'Enter a 2-letter country code'
              : null,
        ),
      ],
    );
  }

  // ----- Shared: Bank picker field -----

  Widget _buildBankPickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bank',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _showBankPicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _bankPickerError != null
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF2D2D2D),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedBankName ?? 'Select bank',
                    style: TextStyle(
                      color: _selectedBankName != null
                          ? Colors.white
                          : const Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF6B7280), size: 20),
              ],
            ),
          ),
        ),
        // Visible error message for bank picker
        if (_bankPickerError != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _bankPickerError!,
              style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
            ),
          ),
      ],
    );
  }

  // ----- Account number hint, max length & validator -----

  String get _accountHint {
    switch (_countryConfig.countryCode) {
      case 'NG':
        return 'Enter 10-digit account number';
      case 'GH':
      case 'KE':
        return 'Enter 13-digit account number';
      case 'ZA':
        return 'Enter 9-11 digit account number';
      default:
        return 'Enter account number';
    }
  }

  int get _accountMaxLength {
    switch (_countryConfig.countryCode) {
      case 'NG':
        return 10;
      case 'GH':
      case 'KE':
        return 13;
      case 'ZA':
        return 11;
      default:
        return 20;
    }
  }

  String? Function(String?) get _accountNumberValidator {
    return (String? v) {
      final val = (v ?? '').trim();
      if (val.isEmpty) return 'Account number is required';
      switch (_countryConfig.countryCode) {
        case 'NG':
          if (val.length != 10) return 'Must be 10 digits';
        case 'GH':
          if (val.length != 13) return 'Must be 13 digits';
        case 'KE':
          if (val.length != 13) return 'Must be 13 digits';
        case 'ZA':
          if (val.length < 9 || val.length > 11) return 'Must be 9-11 digits';
      }
      return null;
    };
  }

  // ----- Step 1 button -----

  Widget _buildStep1Button() {
    if (_countryConfig.supportsAutoVerify) {
      return BlocBuilder<AccountVerificationCubit, AccountVerificationState>(
        builder: (context, state) {
          final isLoading = state is AccountVerificationLoading;
          return ElevatedButton(
            onPressed: isLoading ? null : _verifyAccount,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              disabledBackgroundColor: const Color(0xFF2D2D2D),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isLoading ? 'Verifying...' : 'Verify Account',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      );
    }

    return ElevatedButton(
      onPressed: () {
        setState(() => _isManualNameEntry = true);
        _goToStep2();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Next',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ===========================================================================
  // STEP 2: Confirm & Send
  // ===========================================================================

  Widget _buildStep2() {
    final convertedAmount = _rate?.calculateToAmount(_amount) ?? 0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _step2FormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Verified account card OR name field
                    if (_verifiedAccountName != null && !_isManualNameEntry)
                      _buildVerifiedCard()
                    else
                      _buildField(
                        controller: _nameController,
                        label: 'Recipient Full Name',
                        hint: 'Enter recipient\'s full name',
                        validator: (v) => (v ?? '').trim().isEmpty
                            ? 'Name is required'
                            : null,
                      ),
                    const SizedBox(height: 16),

                    // SWIFT/BIC for non-African countries
                    if (_countryConfig.fieldType != _FieldType.african) ...[
                      _buildField(
                        controller: _swiftController,
                        label: 'SWIFT/BIC Code (optional)',
                        hint: 'e.g. BARCGB22',
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z0-9]')),
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (v) {
                          final val = (v ?? '').trim();
                          if (val.isEmpty) return null; // optional
                          if (val.length != 8 && val.length != 11) {
                            return 'SWIFT code must be 8 or 11 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Email
                    _buildField(
                      controller: _emailController,
                      label: 'Recipient Email (optional)',
                      hint: 'Enter email for notification',
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        final val = (v ?? '').trim();
                        if (val.isEmpty) return null; // optional
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(val)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Purpose of payment
                    _buildPurposeDropdown(),
                    const SizedBox(height: 20),

                    // Exchange summary card
                    _buildSummaryCard(convertedAmount),
                    const SizedBox(height: 12),

                    // Rate countdown or unavailable notice
                    if (_rate != null)
                      Center(
                        child: RateCountdownWidget(
                          rate: _rate!,
                          onExpired: () =>
                              setState(() => _isRateExpired = true),
                          onRefresh: _refreshRate,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: _refreshRate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh,
                                  size: 14, color: Color(0xFFEF4444)),
                              SizedBox(width: 4),
                              Text(
                                'Rate unavailable - Tap to refresh',
                                style: TextStyle(
                                  color: Color(0xFFEF4444),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),

                    // Estimated arrival
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF10B981).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.schedule,
                              color: Color(0xFF10B981), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: const Text(
                              'Estimated arrival: 1-3 business days',
                              style: TextStyle(
                                  color: Color(0xFF10B981), fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Confirm button
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting || (_rate == null && !_isRateExpired)
                    ? null
                    : _isRateExpired || _rate == null
                        ? _refreshRate
                        : _onConfirmAndSend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  disabledBackgroundColor: const Color(0xFF2D2D2D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  _rate == null
                      ? 'Rate Unavailable'
                      : _isRateExpired
                          ? 'Refresh Rate to Continue'
                          : _isSubmitting
                              ? 'Processing...'
                              : 'Confirm & Send',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, color: Color(0xFF10B981), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verified Account Holder',
                  style: TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _verifiedAccountName ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_selectedBankName ?? ''} - ${_accountController.text}',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurposeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Purpose of Payment',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _purposeError != null
                  ? const Color(0xFFEF4444)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _purposeOfPayment,
              hint: const Text(
                'Select purpose',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
              dropdownColor: const Color(0xFF1F1F1F),
              style: const TextStyle(color: Colors.white),
              items: _purposes
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() {
                _purposeOfPayment = v;
                _purposeError = null;
              }),
            ),
          ),
        ),
        // Visible error for purpose
        if (_purposeError != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              _purposeError!,
              style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
            ),
          ),
      ],
    );
  }

  // ===========================================================================
  // Shared widgets
  // ===========================================================================

  Widget _buildSummaryCard(double convertedAmount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildAmountDisplay(
                    _amount, _fromCurrency, 'You send'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward,
                    color: Color(0xFF3B82F6), size: 24),
              ),
              Flexible(
                child: _buildAmountDisplay(
                    convertedAmount, _toCurrency, 'They receive'),
              ),
            ],
          ),
          if (_rate != null) ...[
            const SizedBox(height: 12),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exchange rate',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                ),
                Flexible(
                  child: Text(
                    _rate!.formatForDisplay(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (_rate!.fees > 0) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Service fee',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                  Text(
                    '${_rate!.fees.toStringAsFixed(2)} $_fromCurrency',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildAmountDisplay(double amount, String currency, String label) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            amount.toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          currency,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
